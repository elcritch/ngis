## Shared typed raster buffers, pixel windows and resampling choices.
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

proc data*[T](grid: RasterGrid[T]): lent seq[T] =
  ## Borrow the contiguous row-major values without changing dimensions.
  grid.pixels

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

type RasterSize* = tuple[width, height: int]
