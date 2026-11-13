## GDAL raster I/O using the shared ngis raster values.
import ./[datasets, api, raster]
import ../raster as rastervalues
export rastervalues

proc rasterDataType(T: typedesc): GDALDataType =
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

proc rasterIoFailed(status: CPLErr): bool =
  status != CE_None

proc readGrid*[T](
    band: RasterBand,
    window: RasterWindow,
    outputWidth, outputHeight: Positive,
    resampling = RasterResampling.nearest,
): RasterGrid[T] =
  ## Read and resample a window into the specified output dimensions.
  let dimensions = band.size
  if window.x < 0 or window.y < 0 or window.width <= 0 or window.height <= 0 or
      window.x > dimensions.width or window.y > dimensions.height or
      window.width > dimensions.width - window.x or
      window.height > dimensions.height - window.y or outputWidth > high(cint).int or
      outputHeight > high(cint).int:
    raise newException(ValueError, "raster window or output dimensions are invalid")
  discard initRasterWindow(0, 0, outputWidth, outputHeight)
  let count = outputWidth * outputHeight
  if count > high(int) div sizeof(T):
    raise newException(ValueError, "raster buffer is too large")
  var pixels = newSeq[T](count)
  var extra: GDALRasterIOExtraArg
  INIT_RASTERIO_EXTRA_ARG(extra)
  extra.eResampleAlg =
    case resampling
    of RasterResampling.nearest: GRIORA_NearestNeighbour
    of RasterResampling.bilinear: GRIORA_Bilinear
    of RasterResampling.cubic: GRIORA_Cubic
    of RasterResampling.cubicSpline: GRIORA_CubicSpline
    of RasterResampling.lanczos: GRIORA_Lanczos
    of RasterResampling.average: GRIORA_Average
    of RasterResampling.mode: GRIORA_Mode
    of RasterResampling.rms: GRIORA_RMS
  CPLErrorReset()
  if rasterIoFailed(
    GDALRasterIOEx(
      band.rawHandle,
      GF_Read,
      cint(window.x),
      cint(window.y),
      cint(window.width),
      cint(window.height),
      addr pixels[0],
      cint(outputWidth),
      cint(outputHeight),
      rasterDataType(T),
      0,
      0,
      addr extra,
    )
  ):
    raise gdalError("could not read raster window")
  result = initRasterGrid[T](outputWidth, outputHeight, move(pixels))

proc readGrid*[T](band: RasterBand, window: RasterWindow): RasterGrid[T] =
  ## Read a window, converting native pixels to T.
  let values = read[T](band, window.x, window.y, window.width, window.height)
  initRasterGrid[T](window.width, window.height, values)

proc readGrid*[T](band: RasterBand): RasterGrid[T] =
  let dimensions = band.size
  readGrid[T](band, initRasterWindow(0, 0, dimensions.width, dimensions.height))

proc write*[T](band: RasterBand, grid: RasterGrid[T], window: RasterWindow) =
  ## Write a grid to an equally sized raster window.
  if grid.width != window.width or grid.height != window.height or
      grid.len != window.width * window.height:
    raise newException(ValueError, "raster grid dimensions do not match window")
  band.write(grid.data, window.x, window.y, window.width, window.height)

proc write*[T](band: RasterBand, grid: RasterGrid[T]) =
  let dimensions = band.size
  band.write(grid, initRasterWindow(0, 0, dimensions.width, dimensions.height))

iterator tiles*(band: RasterBand, tileWidth, tileHeight: Positive): RasterWindow =
  let dimensions = band.size
  for tile in tiles(
    initRasterWindow(0, 0, dimensions.width, dimensions.height), tileWidth, tileHeight
  ):
    yield tile

proc createRaster*[T](
    pixelType: typedesc[T],
    width, height: Positive,
    bands: Positive = 1,
    driver = "MEM",
    path = "",
    options: openArray[string] = [],
): Dataset =
  ## Create a typed raster; defaults to an in-memory dataset.
  discard initRasterWindow(0, 0, width, height)
  createDataset(driver, path, width, height, bands, rasterDataType(T), options)
