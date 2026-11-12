import std/[unittest, strutils, os]
import ngis/[gdal, cpl]

proc hashPointer(p: pointer): culong {.cdecl, raises: [].} =
  CPLHashSetHashPointer(p)

proc equalPointer(a, b: pointer): cint {.cdecl, raises: [].} =
  CPLHashSetEqualPointer(a, b)

proc getBounds(feature: pointer, bounds: ptr CPLRectObj) {.cdecl, raises: [].} =
  bounds[] = cast[ptr CPLRectObj](feature)[]

proc threadMain(arg: pointer) {.cdecl, raises: [].} =
  cast[ptr cint](arg)[] = 42

proc configChanged(
    key, value: cstring, local: bool, data: pointer
) {.cdecl, raises: [].} =
  if key != nil and $key == "NGIS_TEST_SUBSCRIBER":
    inc cast[ptr cint](data)[]

suite "managed CPL resources":
  test "string list updates shared aliases and clone remains independent":
    let list = newStringList()
    let alias = list
    check list.len == 0
    list.add("first")
    alias.set("key", "value")
    check list.values == @["first", "key=value"]
    let copy = list.clone()
    list.close()
    expect ValueError:
      discard alias.len
    check copy.values == @["first", "key=value"]
    copy.close()
    list.close()

  test "XML nodes retain their tree and fail after explicit close":
    let tree = parseXml("<root><item>before</item></root>")
    let root = tree.root
    let item = root.find("=root.item")
    check item.value() == "before"
    root.find("=root").setValue("item", "after")
    expect ValueError:
      discard item.value()
    check tree.root.find("=root.item").value() == "after"
    check "after" in tree.serialize
    let copy = tree.clone()
    tree.close()
    expect ValueError:
      discard item.value()
    check "after" in copy.serialize
    copy.close()

  test "containers own nodes but not payloads":
    var one = 1
    var two = 2
    let list = newPointerList()
    list.add(addr one)
    list.add(addr two)
    list.remove(0)
    check list.len == 1
    check list[0] == addr two
    list.close()
    let set = newHashSet(hashPointer, equalPointer)
    check set.insert(addr one)
    check set.find(addr one) == addr one
    check set.remove(addr one)
    check set.len == 0
    set.close()
    var box = CPLRectObj(minx: 1, miny: 1, maxx: 2, maxy: 2)
    let tree = newQuadTree(CPLRectObj(minx: 0, miny: 0, maxx: 10, maxy: 10), getBounds)
    tree.insert(addr box, box)
    check tree.search(box) == @[cast[pointer](addr box)]
    tree.close()
    check one == 1 and two == 2

  test "mutex, lock, condition and joinable thread release once":
    let mutex = newMutex()
    var value = 0
    mutex.withLock:
      value = 3
    check value == 3
    let cond = newCondition()
    mutex.withLock:
      check cond.timedWait(mutex, 0.001) == COND_TIMED_WAIT_TIME_OUT
    cond.close()
    mutex.close()
    let lock = newLock(LOCK_RECURSIVE_MUTEX)
    lock.withLock:
      value = 4
    lock.close()
    var threadValue: cint
    let thread = newJoinableThread(threadMain, addr threadValue)
    thread.join()
    thread.join()
    check threadValue == 42

  test "HTTP result ownership and byte copy":
    let h = cast[ptr CPLHTTPResult](CPLCalloc(1, sizeof(CPLHTTPResult).csize_t))
    h.nStatus = 7
    let response = adoptHttpResult(h)
    let alias = response
    check response.status == 7
    check response.body.len == 0
    response.close()
    expect ValueError:
      discard alias.status

  test "file locks release and can be acquired again":
    let path = getTempDir() / ("ngis-lock-" & $getCurrentProcessId())
    let first = lockFile(path, 0.1)
    let alias = first
    first.close()
    expect ValueError:
      discard alias.rawHandle
    let second = lockFile(path, 0.1)
    second.close()
    let extended = lockFileEx(path & ".extended")
    extended.close()

  test "configuration subscriptions unsubscribe once":
    var calls: cint
    let subscription = subscribeConfig(configChanged, addr calls)
    let alias = subscription
    CPLSetConfigOption("NGIS_TEST_SUBSCRIBER", "yes")
    check calls == 1
    subscription.close()
    alias.close()
    CPLSetConfigOption("NGIS_TEST_SUBSCRIBER", nil)
    check calls == 1

  test "compressor registry and allocated buffers round trip":
    let names = compressorNames()
    let decoders = decompressorNames()
    check "gzip" in names
    check "gzip" in decoders
    let bytes = @[byte('h'), byte('e'), byte('l'), byte('l'), byte('o')]
    let packed = compress("gzip", bytes)
    check packed.len > 0
    check decompress("gzip", packed) == bytes
    expect ValueError:
      discard compress("ngis-nonexistent", bytes)

  test "empty HTTP batch and validation avoid network access":
    check fetchAll([]).len == 0
    expect ValueError:
      discard fetchAll(["bad\0url"])

  test "HTTP batch copies local file response":
    if CPLHTTPEnabled() != 0 and not defined(windows):
      let path = getTempDir() / ("ngis-http-" & $getCurrentProcessId())
      writeFile(path, "local response")
      try:
        let responses = fetchAll(["file://" & path])
        check responses.len == 1
        check responses[0].status == 0
        check responses[0].body ==
          @[
            byte('l'),
            byte('o'),
            byte('c'),
            byte('a'),
            byte('l'),
            byte(' '),
            byte('r'),
            byte('e'),
            byte('s'),
            byte('p'),
            byte('o'),
            byte('n'),
            byte('s'),
            byte('e'),
          ]
      finally:
        removeFile(path)
