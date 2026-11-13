## Convenient raster access. Bands retain their owning dataset and become invalid
## when that dataset is explicitly closed.
import std/options
import ./[api, datasets]
import ../raster as rastervalues
export RasterSize

type RasterBand* = object
  owner: Dataset
  index: int

proc band*(dataset: Dataset, index = 1): RasterBand =
  ## Return the one-based band at `index`.
  let handle = rawHandle(dataset)
  if index < 1 or index > int(GDALGetRasterCount(handle)):
    raise newException(ValueError, "raster band index is out of range")
  result = RasterBand(owner: dataset, index: index)

proc rawHandle*(band: RasterBand): GDALRasterBandH =
  ## Borrow the band handle while its dataset remains open.
  let dataset = rawHandle(band.owner)
  if band.index < 1 or band.index > int(GDALGetRasterCount(dataset)):
    raise newException(ValueError, "invalid raster band")
  result = GDALGetRasterBand(dataset, cint(band.index))
  if result == nil:
    raise gdalError("could not access raster band")

proc size*(band: RasterBand): RasterSize =
  let handle = rawHandle(band)
  (int(GDALGetRasterBandXSize(handle)), int(GDALGetRasterBandYSize(handle)))

proc dataType(T: typedesc): GDALDataType =
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
    {.error: "unsupported raster element type".}

proc validateWindow(band: RasterBand, x, y, width, height: int): int =
  let dimensions = band.size
  if x < 0 or y < 0 or width <= 0 or height <= 0 or x > dimensions.width or
      y > dimensions.height or width > dimensions.width - x or
      height > dimensions.height - y:
    raise newException(ValueError, "raster window is outside the band")
  if width > high(cint).int or height > high(cint).int or x > high(cint).int or
      y > high(cint).int or width > high(int) div height:
    raise newException(ValueError, "raster window is too large")
  width * height

proc checkRasterStatus(status: CPLErr, context: string) =
  # Keep native enum comparison outside generics: callers need not import raw operators.
  if status != CE_None:
    raise gdalError(context)

proc read*[T](band: RasterBand, x, y, width, height: int): seq[T] =
  ## Read a window in row-major order, converting to T when needed.
  let count = validateWindow(band, x, y, width, height)
  if count > high(int) div sizeof(T):
    raise newException(ValueError, "raster buffer is too large")
  result = newSeq[T](count)
  let status = GDALRasterIO(
    rawHandle(band),
    GF_Read,
    cint(x),
    cint(y),
    cint(width),
    cint(height),
    addr result[0],
    cint(width),
    cint(height),
    dataType(T),
    0,
    0,
  )
  checkRasterStatus(status, "could not read raster window")

proc read*[T](band: RasterBand): seq[T] =
  let dimensions = band.size
  read[T](band, 0, 0, dimensions.width, dimensions.height)

proc write*[T](band: RasterBand, values: openArray[T], x, y, width, height: int) =
  ## Write a row-major window; the number of values must match its area.
  let count = validateWindow(band, x, y, width, height)
  if values.len != count:
    raise newException(ValueError, "raster buffer length does not match window")
  let status = GDALRasterIO(
    rawHandle(band),
    GF_Write,
    cint(x),
    cint(y),
    cint(width),
    cint(height),
    unsafeAddr values[0],
    cint(width),
    cint(height),
    dataType(T),
    0,
    0,
  )
  checkRasterStatus(status, "could not write raster window")

proc write*[T](band: RasterBand, values: openArray[T]) =
  let dimensions = band.size
  band.write(values, 0, 0, dimensions.width, dimensions.height)

proc geoTransform*(dataset: Dataset): array[6, float64] =
  if GDALGetGeoTransform(rawHandle(dataset), addr result[0]) != CE_None:
    raise gdalError("dataset has no geotransform")

proc `geoTransform=`*(dataset: Dataset, transform: array[6, float64]) =
  var value = transform
  if GDALSetGeoTransform(rawHandle(dataset), addr value[0]) != CE_None:
    raise gdalError("could not set geotransform")

proc noData*(band: RasterBand): Option[float64] =
  var success: cint
  let value = GDALGetRasterNoDataValue(rawHandle(band), addr success)
  if success != 0:
    some(value)
  else:
    none(float64)

proc `noData=`*(band: RasterBand, value: Option[float64]) =
  let handle = rawHandle(band)
  let status =
    if value.isSome:
      GDALSetRasterNoDataValue(handle, value.get)
    else:
      GDALDeleteRasterNoDataValue(handle)
  if status != CE_None:
    raise gdalError("could not change raster nodata value")

proc metadata*(band: RasterBand, name: string, domain = ""): Option[string] =
  let value = GDALGetMetadataItem(rawHandle(band), name.cstring, domain.cstring)
  if value == nil:
    none(string)
  else:
    some($value)

proc setMetadata*(band: RasterBand, name, value: string, domain = "") =
  if GDALSetMetadataItem(rawHandle(band), name.cstring, value.cstring, domain.cstring) !=
      CE_None:
    raise gdalError("could not set raster metadata")
