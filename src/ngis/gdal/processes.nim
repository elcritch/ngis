## Owning CPL child processes. Releasing the last owner waits for the child;
## drain output pipes and close input before waiting to avoid blocking it.
import ./[api, datasets]
import ./private/resources

type
  ProcessPayload = object
    handle: ptr CPLSpawnedProcess
    finished: bool
    exitCode: cint
    inputOpen, outputOpen, errorOpen: bool

  ProcessState = ref object
    payload: ProcessPayload

  Process* = object
    state: ProcessState

proc `=destroy`(payload: ProcessPayload) =
  if payload.handle != nil:
    discard CPLSpawnAsyncFinish(payload.handle, 1, 0)

proc `=copy`(dest: var ProcessPayload, source: ProcessPayload) {.error.}
proc `=dup`(source: ProcessPayload): ProcessPayload {.error.}

proc rawHandle*(process: Process): ptr CPLSpawnedProcess =
  ## Borrowed; becomes invalid when any alias waits or closes.
  if process.state == nil or process.state.payload.handle == nil:
    raise newException(ValueError, "process has finished")
  process.state.payload.handle

proc startProcess*(
    arguments: openArray[string],
    pipeInput = false,
    pipeOutput = false,
    pipeError = false,
): Process =
  ## Start a program; the first argument is the executable name.
  if arguments.len == 0 or arguments[0].len == 0:
    raise newException(ValueError, "an executable is required")
  for argument in arguments:
    validateCString(argument, "process argument")
  let argv = allocCStringArray(arguments)
  var handle: ptr CPLSpawnedProcess
  try:
    handle =
      CPLSpawnAsync(nil, argv, cint(pipeInput), cint(pipeOutput), cint(pipeError), nil)
  finally:
    deallocCStringArray(argv)
  if handle == nil:
    raise gdalError("could not start process")
  result.state = ProcessState()
  result.state.payload.handle = handle
  result.state.payload.inputOpen = pipeInput
  result.state.payload.outputOpen = pipeOutput
  result.state.payload.errorOpen = pipeError

proc wait*(process: Process): int =
  ## Wait and release native handles. Aliases share the cached exit status.
  if process.state == nil:
    raise newException(ValueError, "process is not initialized")
  if not process.state.payload.finished:
    let handle = process.rawHandle
    process.state.payload.handle = nil
    process.state.payload.exitCode = CPLSpawnAsyncFinish(handle, 1, 0)
    process.state.payload.finished = true
    process.state.payload.inputOpen = false
    process.state.payload.outputOpen = false
    process.state.payload.errorOpen = false
  int(process.state.payload.exitCode)

proc close*(process: Process) =
  discard process.wait()

proc closeInput*(process: Process) =
  let handle = process.rawHandle
  if process.state.payload.inputOpen:
    CPLSpawnAsyncCloseOutputFileHandle(handle)
    process.state.payload.inputOpen = false

proc closeOutput*(process: Process) =
  let handle = process.rawHandle
  if process.state.payload.outputOpen:
    CPLSpawnAsyncCloseInputFileHandle(handle)
    process.state.payload.outputOpen = false

proc closeError*(process: Process) =
  let handle = process.rawHandle
  if process.state.payload.errorOpen:
    CPLSpawnAsyncCloseErrorFileHandle(handle)
    process.state.payload.errorOpen = false

proc writeInput*(process: Process, data: openArray[byte]) =
  ## Write all bytes. CPL reports success only when the full buffer is written.
  let handle = process.rawHandle
  if not process.state.payload.inputOpen:
    raise newException(ValueError, "process input is not open")
  if data.len > int(high(cint)):
    raise newException(ValueError, "pipe buffer is too large")
  if data.len > 0 and
      CPLPipeWrite(
        CPLSpawnAsyncGetOutputFileHandle(handle), unsafeAddr data[0], cint(data.len)
      ) == 0:
    raise gdalError("could not write process input")

proc readPipe(process: Process, size: int, errorPipe: bool): seq[byte] =
  let handle = process.rawHandle
  if size < 0 or size > int(high(cint)):
    raise newException(ValueError, "invalid pipe read size")
  if (
    if errorPipe: not process.state.payload.errorOpen
    else: not process.state.payload.outputOpen
  ):
    raise newException(ValueError, "process output is not open")
  result = newSeq[byte](size)
  let pipe =
    if errorPipe:
      CPLSpawnAsyncGetErrorFileHandle(handle)
    else:
      CPLSpawnAsyncGetInputFileHandle(handle)
  if size > 0 and CPLPipeRead(pipe, addr result[0], cint(size)) == 0:
    raise gdalError("could not read requested process output")

proc readOutput*(process: Process, size: int): seq[byte] =
  ## Read exactly size bytes; EOF before size is reported as an error.
  process.readPipe(size, false)

proc readError*(process: Process, size: int): seq[byte] =
  process.readPipe(size, true)
