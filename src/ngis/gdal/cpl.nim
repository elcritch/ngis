## Managed CPL resources. Native callbacks and pointer payloads remain the
## caller's responsibility and must outlive any native use.
import ./[api, datasets]
import ./private/resources

type
  StringListPayload = object
    handle: cstringArray
    closed: bool

  StringListState = ref object
    payload: StringListPayload

  StringList* = object
    state: StringListState

  ListPayload = object
    handle: ptr CPLList
    closed: bool

  ListState = ref object
    payload: ListPayload

  PointerList* = object
    state: ListState

  XmlState = ref object
    resource: NativeResource[ptr CPLXMLNode]
    generation: uint64

  XmlTree* = object
    state: XmlState

  XmlNode* = object
    owner: XmlState
    generation: uint64
    handle: ptr CPLXMLNode

  HttpResult* = object
    resource: NativeResource[ptr CPLHTTPResult]

  HashSet* = object
    resource: NativeResource[ptr CPLHashSet]

  QuadTree* = object
    resource: NativeResource[ptr CPLQuadTree]

  Mutex* = object
    resource: NativeResource[ptr CPLMutex]

  Condition* = object
    resource: NativeResource[ptr CPLCond]

  Lock* = object
    resource: NativeResource[ptr CPLLock]

  JoinableThread* = object
    resource: NativeResource[ptr CPLJoinableThread]

  VirtualMemory* = object
    resource: NativeResource[ptr CPLVirtualMem]

proc `=destroy`(payload: StringListPayload) =
  if payload.handle != nil:
    CSLDestroy(payload.handle)

proc `=copy`(dest: var StringListPayload, src: StringListPayload) {.error.}
proc `=dup`(src: StringListPayload): StringListPayload {.error.}
proc `=destroy`(payload: ListPayload) =
  if payload.handle != nil:
    CPLListDestroy(payload.handle)

proc `=copy`(dest: var ListPayload, src: ListPayload) {.error.}
proc `=dup`(src: ListPayload): ListPayload {.error.}

proc newStringList*(): StringList =
  StringList(state: StringListState())

proc rawHandle*(list: StringList): cstringArray =
  ## A nil handle is the valid representation of an empty list.
  if list.state == nil or list.state.payload.closed:
    raise newException(ValueError, "string list is closed")
  list.state.payload.handle

proc close*(list: StringList) =
  if list.state != nil and not list.state.payload.closed:
    let handle = list.state.payload.handle
    list.state.payload.handle = nil
    list.state.payload.closed = true
    if handle != nil:
      CSLDestroy(handle)

proc add*(list: StringList, value: string) =
  validateCString(value, "string list item")
  let updated = CSLAddString(list.rawHandle, value.cstring)
  list.state.payload.handle = updated

proc set*(list: StringList, key, value: string) =
  validateCString(key, "string list key")
  validateCString(value, "string list value")
  let updated = CSLSetNameValue(list.rawHandle, key.cstring, value.cstring)
  list.state.payload.handle = updated

proc len*(list: StringList): int =
  int(CSLCount(list.rawHandle))

proc values*(list: StringList): seq[string] =
  copyStrings(list.rawHandle)

proc clone*(list: StringList): StringList =
  result = newStringList()
  result.state.payload.handle = CSLDuplicate(list.rawHandle)

proc newPointerList*(): PointerList =
  PointerList(state: ListState())

proc rawHandle*(list: PointerList): ptr CPLList =
  if list.state == nil or list.state.payload.closed:
    raise newException(ValueError, "pointer list is closed")
  list.state.payload.handle

proc close*(list: PointerList) =
  if list.state != nil and not list.state.payload.closed:
    let handle = list.state.payload.handle
    list.state.payload.handle = nil
    list.state.payload.closed = true
    if handle != nil:
      CPLListDestroy(handle)

proc add*(list: PointerList, value: pointer) =
  ## The list owns nodes, not the pointed-to values.
  let handle = list.rawHandle
  list.state.payload.handle = CPLListAppend(handle, value)

proc len*(list: PointerList): int =
  int(CPLListCount(list.rawHandle))

proc `[]`*(list: PointerList, index: int): pointer =
  if index < 0 or index >= list.len:
    raise newException(IndexDefect, "list index out of range")
  CPLListGetData(CPLListGet(list.rawHandle, cint(index)))

proc remove*(list: PointerList, index: int) =
  if index < 0 or index >= list.len:
    raise newException(IndexDefect, "list index out of range")
  list.state.payload.handle = CPLListRemove(list.rawHandle, cint(index))

proc releaseXml(h: ptr CPLXMLNode) {.nimcall, raises: [].} =
  CPLDestroyXMLNode(h)

proc releaseHttp(h: ptr CPLHTTPResult) {.nimcall, raises: [].} =
  CPLHTTPDestroyResult(h)

proc releaseHash(h: ptr CPLHashSet) {.nimcall, raises: [].} =
  CPLHashSetDestroy(h)

proc releaseQuad(h: ptr CPLQuadTree) {.nimcall, raises: [].} =
  CPLQuadTreeDestroy(h)

proc releaseMutex(h: ptr CPLMutex) {.nimcall, raises: [].} =
  CPLDestroyMutex(h)

proc releaseCond(h: ptr CPLCond) {.nimcall, raises: [].} =
  CPLDestroyCond(h)

proc releaseLock(h: ptr CPLLock) {.nimcall, raises: [].} =
  CPLDestroyLock(h)

proc releaseThread(h: ptr CPLJoinableThread) {.nimcall, raises: [].} =
  CPLJoinThread(h)

proc releaseVirtual(h: ptr CPLVirtualMem) {.nimcall, raises: [].} =
  CPLVirtualMemFree(h)

template accessors(T, H: typedesc) =
  proc rawHandle*(value: T): H =
    rawHandle(value.resource)

  proc close*(value: T) =
    close(value.resource)

accessors(HttpResult, ptr CPLHTTPResult)
accessors(HashSet, ptr CPLHashSet)
accessors(QuadTree, ptr CPLQuadTree)
accessors(Mutex, ptr CPLMutex)
accessors(Condition, ptr CPLCond)
accessors(Lock, ptr CPLLock)
accessors(JoinableThread, ptr CPLJoinableThread)
accessors(VirtualMemory, ptr CPLVirtualMem)

proc parseXml*(text: string): XmlTree =
  validateCString(text, "XML")
  let handle = CPLParseXMLString(text.cstring)
  if handle == nil:
    raise gdalError("could not parse XML")
  XmlTree(state: XmlState(resource: newNativeResource(handle, releaseXml)))

proc rawHandle*(tree: XmlTree): ptr CPLXMLNode =
  if tree.state == nil:
    raise newException(ValueError, "XML tree is closed")
  tree.state.resource.rawHandle

proc close*(tree: XmlTree) =
  if tree.state != nil:
    tree.state.resource.close()

proc root*(tree: XmlTree): XmlNode =
  let handle = tree.rawHandle
  XmlNode(owner: tree.state, generation: tree.state.generation, handle: handle)

proc rawHandle*(node: XmlNode): ptr CPLXMLNode =
  if node.owner == nil:
    raise newException(ValueError, "XML node is missing")
  discard node.owner.resource.rawHandle
  if node.generation != node.owner.generation:
    raise newException(ValueError, "XML node was invalidated by mutation")
  if node.handle == nil:
    raise newException(ValueError, "XML node is missing")
  node.handle

proc find*(node: XmlNode, path: string): XmlNode =
  validateCString(path, "XML path")
  let found = CPLGetXMLNode(node.rawHandle, path.cstring)
  if found == nil:
    raise newException(ValueError, "XML node not found")
  XmlNode(owner: node.owner, generation: node.generation, handle: found)

proc search*(node: XmlNode, name: string): XmlNode =
  validateCString(name, "XML node name")
  let found = CPLSearchXMLNode(node.rawHandle, name.cstring)
  if found == nil:
    raise newException(ValueError, "XML node not found")
  XmlNode(owner: node.owner, generation: node.generation, handle: found)

proc value*(node: XmlNode, path = "", defaultValue = ""): string =
  validateCString(path, "XML path")
  validateCString(defaultValue, "XML default")
  let p = CPLGetXMLValue(node.rawHandle, path.cstring, defaultValue.cstring)
  if p == nil:
    ""
  else:
    $p

proc setValue*(node: XmlNode, path, value: string) =
  ## All borrowed node handles are invalidated; reacquire them from the tree.
  validateCString(path, "XML path")
  validateCString(value, "XML value")
  let handle = node.rawHandle
  inc node.owner.generation
  if CPLSetXMLValue(handle, path.cstring, value.cstring) == 0:
    raise gdalError("could not set XML value")

proc serialize*(tree: XmlTree): string =
  let p = CPLSerializeXMLTree(tree.rawHandle)
  if p == nil:
    raise gdalError("could not serialize XML")
  try:
    result = $p
  finally:
    VSIFree(cast[pointer](p))

proc clone*(tree: XmlTree): XmlTree =
  let h = CPLCloneXMLTree(tree.rawHandle)
  if h == nil:
    raise gdalError("could not clone XML")
  XmlTree(state: XmlState(resource: newNativeResource(h, releaseXml)))

proc fetch*(url: string, options: StringList): HttpResult =
  validateCString(url, "URL")
  let h = CPLHTTPFetch(url.cstring, options.rawHandle)
  if h == nil:
    raise gdalError("HTTP fetch failed")
  HttpResult(resource: newNativeResource(h, releaseHttp))

proc fetch*(url: string): HttpResult =
  let options = newStringList()
  fetch(url, options)

proc status*(response: HttpResult): int =
  int(response.rawHandle.nStatus)

proc errorMessage*(response: HttpResult): string =
  let p = response.rawHandle.pszErrBuf
  if p == nil:
    ""
  else:
    $p

proc body*(response: HttpResult): seq[byte] =
  let h = response.rawHandle
  if h.nDataLen > 0 and h.pabyData != nil:
    result = newSeq[byte](int(h.nDataLen))
    copyMem(addr result[0], h.pabyData, result.len)

proc newHashSet*(
    hash: CPLHashSetHashFunc,
    equal: CPLHashSetEqualFunc,
    freeItem: CPLHashSetFreeEltFunc = nil,
): HashSet =
  ## With freeItem=nil the caller owns each payload and keeps it alive.
  if hash == nil or equal == nil:
    raise newException(ValueError, "hash and equality callbacks are required")
  HashSet(
    resource: newNativeResource(CPLHashSetNew(hash, equal, freeItem), releaseHash)
  )

proc len*(set: HashSet): int =
  int(CPLHashSetSize(set.rawHandle))

proc insert*(set: HashSet, item: pointer): bool =
  CPLHashSetInsert(set.rawHandle, item) != 0

proc find*(set: HashSet, item: pointer): pointer =
  CPLHashSetLookup(set.rawHandle, item)

proc remove*(set: HashSet, item: pointer): bool =
  CPLHashSetRemove(set.rawHandle, item) != 0

proc newQuadTree*(bounds: CPLRectObj, getBounds: CPLQuadTreeGetBoundsFunc): QuadTree =
  if getBounds == nil:
    raise newException(ValueError, "bounds callback is required")
  var b = bounds
  QuadTree(
    resource: newNativeResource(CPLQuadTreeCreate(addr b, getBounds), releaseQuad)
  )

proc insert*(tree: QuadTree, item: pointer, bounds: CPLRectObj) =
  ## The caller owns the feature pointer and keeps it alive until removal.
  var b = bounds
  CPLQuadTreeInsertWithBounds(tree.rawHandle, item, addr b)

proc search*(tree: QuadTree, bounds: CPLRectObj): seq[pointer] =
  var b = bounds
  var count: cint
  let found = CPLQuadTreeSearch(tree.rawHandle, addr b, addr count)
  try:
    let items = cast[ptr UncheckedArray[pointer]](found)
    for i in 0 ..< int(count):
      result.add items[i]
  finally:
    if found != nil:
      VSIFree(found)

proc newMutex*(): Mutex =
  let h = CPLCreateMutex()
  if h == nil:
    raise gdalError("could not create mutex")
  CPLReleaseMutex(h) # CPL creates an acquired mutex.
  Mutex(resource: newNativeResource(h, releaseMutex))

proc acquire*(mutex: Mutex, timeout = 1000.0): bool =
  CPLAcquireMutex(mutex.rawHandle, timeout) != 0

proc release*(mutex: Mutex) =
  CPLReleaseMutex(mutex.rawHandle)

proc newCondition*(): Condition =
  Condition(resource: newNativeResource(CPLCreateCond(), releaseCond))

proc signal*(condition: Condition) =
  CPLCondSignal(condition.rawHandle)

proc broadcast*(condition: Condition) =
  CPLCondBroadcast(condition.rawHandle)

proc wait*(condition: Condition, mutex: Mutex) =
  CPLCondWait(condition.rawHandle, mutex.rawHandle)

proc timedWait*(
    condition: Condition, mutex: Mutex, timeout: float64
): CPLCondTimedWaitReason =
  CPLCondTimedWait(condition.rawHandle, mutex.rawHandle, timeout)

proc newLock*(kind: CPLLockType): Lock =
  Lock(resource: newNativeResource(CPLCreateLock(kind), releaseLock))

proc acquire*(lock: Lock): bool =
  CPLAcquireLock(lock.rawHandle) != 0

proc release*(lock: Lock) =
  CPLReleaseLock(lock.rawHandle)

proc newJoinableThread*(
    callback: CPLThreadFunc, argument: pointer = nil
): JoinableThread =
  ## Closing or releasing the last owner joins the thread. Callback and argument
  ## must remain valid until that happens.
  if callback == nil:
    raise newException(ValueError, "thread callback is required")
  JoinableThread(
    resource:
      newNativeResource(CPLCreateJoinableThread(callback, argument), releaseThread)
  )

proc join*(thread: JoinableThread) =
  thread.close()

proc adoptVirtualMemory*(handle: ptr CPLVirtualMem): VirtualMemory =
  ## Takes ownership of an independently releasable CPL virtual-memory handle.
  VirtualMemory(resource: newNativeResource(handle, releaseVirtual))

proc address*(memory: VirtualMemory): pointer =
  CPLVirtualMemGetAddr(memory.rawHandle)

proc len*(memory: VirtualMemory): int =
  int(CPLVirtualMemGetSize(memory.rawHandle))

proc adoptHttpResult*(handle: ptr CPLHTTPResult): HttpResult =
  ## Takes ownership of a result allocated for CPLHTTPDestroyResult.
  HttpResult(resource: newNativeResource(handle, releaseHttp))

template withLock*(mutex: Mutex, body: untyped) =
  ## Acquire and release on the calling thread, including when body raises.
  if not mutex.acquire():
    raise newException(IOError, "could not acquire mutex")
  try:
    body
  finally:
    mutex.release()

template withLock*(lock: Lock, body: untyped) =
  if not lock.acquire():
    raise newException(IOError, "could not acquire lock")
  try:
    body
  finally:
    lock.release()

type
  FileLock* = object
    resource: NativeResource[pointer]

  ExtendedFileLock* = object
    resource: NativeResource[CPLLockFileHandle]

  SubscriptionPayload = object
    id: cint
    active: bool

  SubscriptionState = ref object
    payload: SubscriptionPayload

  ConfigSubscription* = object
    state: SubscriptionState

proc unlockFile(h: pointer) {.nimcall, raises: [].} =
  CPLUnlockFile(h)

proc unlockFileEx(h: CPLLockFileHandle) {.nimcall, raises: [].} =
  CPLUnlockFileEx(h)

accessors(FileLock, pointer)
accessors(ExtendedFileLock, CPLLockFileHandle)

proc lockFile*(path: string, timeout = 0.0): FileLock =
  validateCString(path, "lock path")
  let h = CPLLockFile(path.cstring, timeout)
  if h == nil:
    raise gdalError("could not acquire file lock")
  FileLock(resource: newNativeResource(h, unlockFile))

proc lockFileEx*(path: string, options: StringList): ExtendedFileLock =
  validateCString(path, "lock path")
  var handle: CPLLockFileHandle
  let status = CPLLockFileEx(path.cstring, addr handle, options.rawHandle)
  if status != CLFS_OK:
    raise newException(IOError, "could not acquire extended file lock: " & $status)
  ExtendedFileLock(resource: newNativeResource(handle, unlockFileEx))

proc lockFileEx*(path: string): ExtendedFileLock =
  lockFileEx(path, newStringList())

proc `=destroy`(payload: SubscriptionPayload) =
  if payload.active:
    CPLUnsubscribeToSetConfigOption(payload.id)

proc `=copy`(dest: var SubscriptionPayload, source: SubscriptionPayload) {.error.}
proc `=dup`(source: SubscriptionPayload): SubscriptionPayload {.error.}

proc subscribeConfig*(
    callback: CPLSetConfigOptionSubscriber, userData: pointer = nil
): ConfigSubscription =
  ## Callback and userData must remain valid until the subscription closes.
  if callback == nil:
    raise newException(ValueError, "callback is required")
  let id = CPLSubscribeToSetConfigOption(callback, userData)
  result.state = SubscriptionState()
  result.state.payload.id = id
  result.state.payload.active = true

proc close*(subscription: ConfigSubscription) =
  if subscription.state != nil and subscription.state.payload.active:
    subscription.state.payload.active = false
    CPLUnsubscribeToSetConfigOption(subscription.state.payload.id)

type HttpResponse* = object
  status*: int
  contentType*, errorMessage*: string
  headers*: seq[string]
  body*: seq[byte]

proc fetchAll*(
    urls: openArray[string], maxSimultaneous = 0, options: StringList = newStringList()
): seq[HttpResponse] =
  ## Copy all responses into Nim values, then release the native result array.
  if urls.len > int(high(cint)) or maxSimultaneous < int(low(cint)) or
      maxSimultaneous > int(high(cint)):
    raise newException(ValueError, "HTTP batch exceeds native integer range")
  for url in urls:
    validateCString(url, "URL")
  let opts = options.rawHandle
  if urls.len == 0:
    return @[]
  let addresses = allocCStringArray(urls)
  try:
    let native =
      CPLHTTPMultiFetch(addresses, cint(urls.len), cint(maxSimultaneous), opts)
    if native == nil:
      raise gdalError("could not fetch HTTP batch")
    try:
      let items = cast[ptr UncheckedArray[ptr CPLHTTPResult]](native)
      result = newSeq[HttpResponse](urls.len)
      for i in 0 ..< urls.len:
        let item = items[i]
        if item == nil:
          raise gdalError("HTTP batch returned a missing response")
        if item.nDataLen < 0 or (item.nDataLen > 0 and item.pabyData == nil):
          raise newException(IOError, "HTTP batch returned an invalid buffer")
        result[i].status = int(item.nStatus)
        if item.pszContentType != nil:
          result[i].contentType = $item.pszContentType
        if item.pszErrBuf != nil:
          result[i].errorMessage = $item.pszErrBuf
        result[i].headers = copyStrings(item.papszHeaders)
        result[i].body = newSeq[byte](int(item.nDataLen))
        if item.nDataLen > 0:
          copyMem(addr result[i].body[0], item.pabyData, int(item.nDataLen))
    finally:
      CPLHTTPDestroyMultiResult(native, cint(urls.len))
  finally:
    deallocCStringArray(addresses)

proc compressorNames*(): seq[string] =
  let names = CPLGetCompressors()
  try:
    result = copyStrings(names)
  finally:
    CSLDestroy(names)

proc decompressorNames*(): seq[string] =
  let names = CPLGetDecompressors()
  try:
    result = copyStrings(names)
  finally:
    CSLDestroy(names)

proc transformBytes(
    id: string, data: openArray[byte], options: StringList, decompress: bool
): seq[byte] =
  validateCString(id, "compressor name")
  let codec =
    if decompress:
      CPLGetDecompressor(id.cstring)
    else:
      CPLGetCompressor(id.cstring)
  if codec == nil or codec.pfnFunc == nil:
    raise newException(ValueError, "unknown compressor or decompressor: " & id)
  let opts = options.rawHandle
  var empty: byte
  let input =
    if data.len == 0:
      addr empty
    else:
      unsafeAddr data[0]
  var output: pointer
  var outputSize: csize_t
  try:
    if not codec.pfnFunc(
      input, csize_t(data.len), addr output, addr outputSize, opts, codec.user_data
    ):
      raise gdalError("compression operation failed")
    if outputSize > csize_t(high(int)) or (outputSize > 0 and output == nil):
      raise newException(IOError, "compressor returned an invalid buffer")
    result = newSeq[byte](int(outputSize))
    if outputSize > 0:
      copyMem(addr result[0], output, int(outputSize))
  finally:
    if output != nil:
      VSIFree(output)

proc compress*(
    id: string, data: openArray[byte], options: StringList = newStringList()
): seq[byte] =
  transformBytes(id, data, options, false)

proc decompress*(
    id: string, data: openArray[byte], options: StringList = newStringList()
): seq[byte] =
  transformBytes(id, data, options, true)
