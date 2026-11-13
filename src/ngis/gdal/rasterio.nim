## Typed, row-major raster grids and window operations.
import ./[datasets, api, raster]

type
  RasterWindow* = object ## A rectangular region in raster pixel coordinates.
    x*, y*, width*, height*: int

  RasterGrid*[T] = object
    ## Owned row-major pixels. Dimensions cannot be changed independently.
    gridWidth, gridHeight: int
    pixels: seq[T]

proc checkedArea(width, height: int): int =
  if width <= 0 or height <= 0 or width > high(int) div height:
    raise newException(ValueError, "invalid raster dimensions")
  width * height

proc initRasterWindow*(x, y: Natural, width, height: Positive): RasterWindow =
  ## Construct a nonempty window. Bounds against a band are checked on use.
  discard checkedArea(width, height)
  RasterWindow(x: x, y: y, width: width, height: height)

proc initRasterGrid*[T](width, height: Positive): RasterGrid[T] =
  ## Allocate a zero-initialized grid.
  let count = checkedArea(width, height)
  if count > high(int) div sizeof(T):
    raise newException(ValueError, "raster buffer is too large")
  RasterGrid[T](gridWidth: width, gridHeight: height, pixels: newSeq[T](count))

proc initRasterGrid*[T](width, height: Positive, values: sink seq[T]): RasterGrid[T] =
  ## Construct a grid from exactly width * height row-major values.
  if checkedArea(width, height) != values.len:
    raise newException(ValueError, "raster buffer length does not match dimensions")
  RasterGrid[T](gridWidth: width, gridHeight: height, pixels: values)

func width*[T](grid: RasterGrid[T]): int =
  grid.gridWidth
func height*[T](grid: RasterGrid[T]): int =
  grid.gridHeight
func len*[T](grid: RasterGrid[T]): int =
  grid.pixels.len

proc pixelIndex[T](grid: RasterGrid[T], x, y: int): int =
  if x < 0 or y < 0 or x >= grid.gridWidth or y >= grid.gridHeight:
    raise newException(ValueError, "raster grid index is out of range")
  y * grid.gridWidth + x

proc `[]`*[T](grid: RasterGrid[T], x, y: int): T =
  grid.pixels[pixelIndex(grid, x, y)]

proc `[]=`*[T](grid: var RasterGrid[T], x, y: int, value: T) =
  grid.pixels[pixelIndex(grid, x, y)] = value

iterator items*[T](grid: RasterGrid[T]): T =
  for value in grid.pixels:
    yield value

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

type RasterResampling* {.pure.} = enum
  ## Resampling algorithm used when reading into a different output size.
  nearest
  bilinear
  cubic
  cubicSpline
  lanczos
  average
  mode
  rms

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
  result = initRasterGrid[T](outputWidth, outputHeight)
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
      addr result.pixels[0],
      cint(outputWidth),
      cint(outputHeight),
      rasterDataType(T),
      0,
      0,
      addr extra,
    )
  ):
    raise gdalError("could not read raster window")

proc readGrid*[T](band: RasterBand, window: RasterWindow): RasterGrid[T] =
  ## Read a window, converting native pixels to T.
  let values = read[T](band, window.x, window.y, window.width, window.height)
  initRasterGrid[T](window.width, window.height, values)

proc readGrid*[T](band: RasterBand): RasterGrid[T] =
  let dimensions = band.size
  readGrid[T](band, initRasterWindow(0, 0, dimensions.width, dimensions.height))

proc write*[T](band: RasterBand, grid: RasterGrid[T], window: RasterWindow) =
  ## Write a grid to an equally sized raster window.
  if grid.gridWidth != window.width or grid.gridHeight != window.height or
      grid.pixels.len != checkedArea(window.width, window.height):
    raise newException(ValueError, "raster grid dimensions do not match window")
  band.write(grid.pixels, window.x, window.y, window.width, window.height)

proc write*[T](band: RasterBand, grid: RasterGrid[T]) =
  let dimensions = band.size
  band.write(grid, initRasterWindow(0, 0, dimensions.width, dimensions.height))

iterator tiles*(window: RasterWindow, tileWidth, tileHeight: Positive): RasterWindow =
  ## Visit row-major tiles, clipping the right and bottom edges.
  discard checkedArea(window.width, window.height)
  if window.x < 0 or window.y < 0 or window.x > high(int) - window.width or
      window.y > high(int) - window.height:
    raise newException(ValueError, "invalid raster window")
  var y = 0
  while y < window.height:
    let h = min(tileHeight, window.height - y)
    var x = 0
    while x < window.width:
      let w = min(tileWidth, window.width - x)
      yield initRasterWindow(window.x + x, window.y + y, w, h)
      x += w
    y += h

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
  discard checkedArea(width, height)
  createDataset(driver, path, width, height, bands, rasterDataType(T), options)
