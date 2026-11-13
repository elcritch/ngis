## Managed asynchronous raster reads. The buffer remains allocated until the
## native reader is ended, and the reader retains a native dataset reference.
import ./[api, datasets]

type
  AsyncPayload = object
    dataset: GDALDatasetH
    reader: GDALAsyncReaderH

  AsyncState[T] = ref object
    payload: AsyncPayload
    buffer: seq[T]

  AsyncReader*[T] = object
    state: AsyncState[T]

  AsyncRegion* = object
    status*: GDALAsyncStatusType
    x*, y*, width*, height*: int

proc endReader(payload: var AsyncPayload) {.raises: [].} =
  if payload.reader != nil:
    GDALEndAsyncReader(payload.dataset, payload.reader)
    payload.reader = nil
  if payload.dataset != nil:
    discard GDALReleaseDataset(payload.dataset)
    payload.dataset = nil

proc `=destroy`(payload: AsyncPayload) =
  if payload.reader != nil:
    GDALEndAsyncReader(payload.dataset, payload.reader)
  if payload.dataset != nil:
    discard GDALReleaseDataset(payload.dataset)

proc `=copy`(dest: var AsyncPayload, source: AsyncPayload) {.error.}
proc `=dup`(source: AsyncPayload): AsyncPayload {.error.}

proc rasterType(T: typedesc): GDALDataType =
  when T is uint8:
    GDT_Byte
  elif T is int8:
    GDT_Int8
  elif T is uint16:
    GDT_UInt16
  elif T is int16:
    GDT_Int16
  elif T is uint32:
    GDT_UInt32
  elif T is int32:
    GDT_Int32
  elif T is uint64:
    GDT_UInt64
  elif T is int64:
    GDT_Int64
  elif T is float32:
    GDT_Float32
  elif T is float64:
    GDT_Float64
  else:
    {.error: "unsupported asynchronous raster element type".}

proc rawHandle*[T](reader: AsyncReader[T]): GDALAsyncReaderH =
  if reader.state == nil or reader.state.payload.reader == nil:
    raise newException(ValueError, "asynchronous reader is closed")
  reader.state.payload.reader

proc beginAsyncRead*[T](
    dataset: Dataset, x, y, width, height: int, band = 1
): AsyncReader[T] =
  ## The buffer has width*height elements in row-major order, for one band.
  let handle = dataset.rawHandle
  let dsWidth = int(GDALGetRasterXSize(handle))
  let dsHeight = int(GDALGetRasterYSize(handle))
  if x < 0 or y < 0 or width <= 0 or height <= 0 or x > dsWidth or y > dsHeight or
      width > dsWidth - x or height > dsHeight - y or band < 1 or
      band > int(GDALGetRasterCount(handle)) or width > high(int) div height or
      width * height > high(int) div sizeof(T):
    raise newException(ValueError, "invalid asynchronous raster window or band")
  let state = AsyncState[T]()
  state.buffer = newSeq[T](width * height)
  discard GDALReferenceDataset(handle)
  state.payload.dataset = handle
  var bandNumber = cint(band)
  state.payload.reader = GDALBeginAsyncReader(
    handle,
    cint(x),
    cint(y),
    cint(width),
    cint(height),
    addr state.buffer[0],
    cint(width),
    cint(height),
    rasterType(T),
    1,
    addr bandNumber,
    0,
    0,
    0,
    nil,
  )
  if state.payload.reader == nil:
    state.payload.endReader()
    raise gdalError("could not start asynchronous raster read")
  result.state = state

proc close*[T](reader: AsyncReader[T]) =
  if reader.state != nil:
    reader.state.payload.endReader()

proc nextRegion*[T](reader: AsyncReader[T], timeout = -1.0): AsyncRegion =
  var x, y, width, height: cint
  result.status = GDALARGetNextUpdatedRegion(
    reader.rawHandle, timeout, addr x, addr y, addr width, addr height
  )
  result.x = int(x)
  result.y = int(y)
  result.width = int(width)
  result.height = int(height)

proc copyBuffer*[T](reader: AsyncReader[T], timeout = -1.0): seq[T] =
  ## Return a snapshot while holding GDAL's buffer lock.
  let handle = reader.rawHandle
  if GDALARLockBuffer(handle, timeout) == 0:
    raise newException(IOError, "could not lock asynchronous raster buffer")
  try:
    result = newSeq[T](reader.state.buffer.len)
    for i, value in reader.state.buffer:
      result[i] = value
  finally:
    GDALARUnlockBuffer(handle)
