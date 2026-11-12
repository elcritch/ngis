## Shared owners for GDAL-allocated buffers, including aligned allocations.
import ./[gdal, datasets]
import ./private/resources

type
  BufferState = ref object
    resource: NativeResource[pointer]
    size: int
    closed: bool

  NativeBuffer* = object
    state: BufferState

proc adoptNativeBuffer*(data: pointer, size: int, aligned = false): NativeBuffer =
  ## Takes ownership of a VSI-allocated buffer; aligned buffers use VSIFreeAligned.
  if size < 0 or (size > 0 and data == nil):
    raise newException(ValueError, "invalid native buffer")
  result.state = BufferState(size: size)
  if data != nil:
    if aligned:
      result.state.resource = newNativeResource(
        data,
        proc(p: pointer) {.raises: [].} =
          VSIFreeAligned(p),
      )
    else:
      result.state.resource = newNativeResource(
        data,
        proc(p: pointer) {.raises: [].} =
          VSIFree(p),
      )

proc newNativeBuffer*(size: int, alignment = 0): NativeBuffer =
  ## Allocates uninitialized fixed-size memory. Copies share its close state.
  if size < 0 or alignment < 0 or (
    alignment != 0 and
    (alignment < sizeof(pointer) or (alignment and (alignment - 1)) != 0)
  ):
    raise newException(ValueError, "invalid buffer size or alignment")
  result.state = BufferState(size: size)
  if size != 0:
    let data =
      if alignment == 0:
        VSIMalloc(csize_t(size))
      else:
        VSIMallocAligned(csize_t(alignment), csize_t(size))
    if data == nil:
      raise gdalError("could not allocate native buffer")
    if alignment == 0:
      result.state.resource = newNativeResource(
        data,
        proc(p: pointer) {.raises: [].} =
          VSIFree(p),
      )
    else:
      result.state.resource = newNativeResource(
        data,
        proc(p: pointer) {.raises: [].} =
          VSIFreeAligned(p),
      )

proc rawHandle*(buffer: NativeBuffer): pointer =
  if buffer.state == nil or buffer.state.closed:
    raise newException(ValueError, "native buffer is closed")
  if buffer.state.resource == nil: nil else: buffer.state.resource.rawHandle

proc len*(buffer: NativeBuffer): int =
  discard buffer.rawHandle
  buffer.state.size

proc close*(buffer: NativeBuffer) =
  if buffer.state != nil and not buffer.state.closed:
    close(buffer.state.resource)
    buffer.state.closed = true

proc write*(buffer: NativeBuffer, bytes: openArray[byte], offset = 0) =
  let data = buffer.rawHandle
  if offset < 0 or offset > buffer.len or bytes.len > buffer.len - offset:
    raise newException(ValueError, "write exceeds native buffer")
  if bytes.len > 0:
    let target = cast[ptr UncheckedArray[byte]](data)
    copyMem(addr target[offset], unsafeAddr bytes[0], bytes.len)

proc read*(buffer: NativeBuffer, offset, count: int): seq[byte] =
  let data = buffer.rawHandle
  if offset < 0 or count < 0 or offset > buffer.len or count > buffer.len - offset:
    raise newException(ValueError, "read exceeds native buffer")
  result = newSeq[byte](count)
  if count > 0:
    let source = cast[ptr UncheckedArray[byte]](data)
    copyMem(addr result[0], addr source[offset], count)

proc read*(buffer: NativeBuffer): seq[byte] =
  buffer.read(0, buffer.len)
