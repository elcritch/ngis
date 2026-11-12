import std/[unittest, os]
import ngis/processes

if paramCount() > 0 and paramStr(1) == "child":
  stdout.write("hello")
  stdout.flushFile()
  stderr.write("err")
  stderr.flushFile()
  quit(7)

if paramCount() > 0 and paramStr(1) == "echo":
  var data: array[4, byte]
  discard stdin.readBuffer(addr data[0], data.len)
  discard stdout.writeBuffer(addr data[0], data.len)
  stdout.flushFile()
  quit(0)

if paramCount() > 1 and paramStr(1) == "marker":
  writeFile(paramStr(2), "done")
  quit(0)

suite "managed spawned processes":
  test "capture stdout and stderr and cache exit status for aliases":
    let child =
      startProcess([getAppFilename(), "child"], pipeOutput = true, pipeError = true)
    let alias = child
    check child.readOutput(5) == @[
      byte('h'), byte('e'), byte('l'), byte('l'), byte('o')
    ]
    check child.readError(3) == @[byte('e'), byte('r'), byte('r')]
    check child.wait() == 7
    check alias.wait() == 7
    expect ValueError:
      discard alias.rawHandle
    child.close()

  test "reject invalid arguments before spawning":
    expect ValueError:
      discard startProcess([])
    expect ValueError:
      discard startProcess(["bad\0name"])

  test "write stdin and read exact stdout":
    let child =
      startProcess([getAppFilename(), "echo"], pipeInput = true, pipeOutput = true)
    child.writeInput(@[1'u8, 2, 3, 4])
    child.closeInput()
    check child.readOutput(4) == @[1'u8, 2, 3, 4]
    check child.wait() == 0

  test "last owner waits for child to finish":
    let marker = getTempDir() / ("ngis-process-" & $getCurrentProcessId())
    if fileExists(marker):
      removeFile(marker)
    block:
      let child = startProcess([getAppFilename(), "marker", marker])
      discard child.rawHandle
    check fileExists(marker)
    check readFile(marker) == "done"
    removeFile(marker)
