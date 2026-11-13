import std/[options, unittest, math, strutils]
import
  ngis/gdal/
    [datasets, raster, rasterio, datasetops, coordinates, spatialrefs, processing]

proc image(width = 4, height = 4, bands = 1): Dataset =
  result = createRaster(uint8, width, height, bands)
  result.affineTransform = AffineTransform(
    originX: 0, pixelWidth: 1, originY: float64(height), pixelHeight: -1
  )
  # The affine x/y coordinates are longitude/latitude, not EPSG authority order.
  result.spatialReference = newSpatialReference(4326, AxisOrder.traditionalGis)

suite "typed raster processing":
  test "copy, crop, resize, band selection and nodata":
    let src = image(bands = 2)
    src.band(1).write(
      initRasterGrid[uint8](
        4, 4, @[1'u8, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
      )
    )
    src.band(2).write(
      initRasterGrid[uint8](
        4, 4, @[21'u8, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]
      )
    )
    let copy = src.copyRaster()
    check copy.bandCount == 2
    check readGrid[uint8](copy.band(1))[3, 3] == 16
    let outp = src.crop(
      initRasterWindow(1, 1, 2, 2),
      config = TranslateConfig(
        bands: @[2], outputSize: some(initRasterOutputSize(4, 4)), noData: some(99.0)
      ),
    )
    check outp.size == (width: 4, height: 4)
    check outp.bandCount == 1
    check readGrid[uint8](outp.band(1))[0, 0] == 26
    check readGrid[uint8](outp.band(1))[3, 3] == 31
    check outp.band(1).noData == some(99.0)
    check outp.affineTransform.originX == 1
    check outp.affineTransform.pixelWidth == 0.5
    src.band(1).write(initRasterGrid[uint8](4, 4))
    check readGrid[uint8](copy.band(1))[3, 3] == 16

  test "warp and reproject preserve expected coordinates":
    let src = image(2, 2)
    src.band(1).write(initRasterGrid[uint8](2, 2, @[1'u8, 2, 3, 4]))
    let same = src.warp(
      config = WarpConfig(
        sourceCrs: "EPSG:4326",
        targetCrs: "EPSG:4326",
        bounds: some(initBounds(0, 0, 2, 2)),
        outputSize: some(initRasterOutputSize(2, 2)),
        coordinateOperation: "+proj=noop",
        errorThreshold: some(0.0),
        memoryLimitMiB: some(32.0),
        threadCount: some(1),
        verticalShift: some(false),
      )
    )
    check readGrid[uint8](same.band(1))[1, 1] == 4
    check same.affineTransform == src.affineTransform
    let projected = src.reproject(
      newSpatialReference(3857),
      config = WarpConfig(outputSize: some(initRasterOutputSize(2, 2))),
    )
    check projected.size == (width: 2, height: 2)
    check projected.affineTransform.pixelWidth > 100000
    check projected.spatialReference.toWkt.contains("3857")

  test "mosaic later input takes precedence":
    let a = image(2, 2)
    let b = image(2, 2)
    b.affineTransform =
      AffineTransform(originX: 1, originY: 2, pixelWidth: 1, pixelHeight: -1)
    a.band(1).write(initRasterGrid[uint8](2, 2, @[1'u8, 1, 1, 1]))
    b.band(1).write(initRasterGrid[uint8](2, 2, @[2'u8, 2, 2, 2]))
    let merged = mosaic(
      [a, b],
      config = WarpConfig(
        bounds: some(initBounds(0, 0, 3, 2)),
        outputSize: some(initRasterOutputSize(3, 2)),
      ),
    )
    let grid = readGrid[uint8](merged.band(1))
    check grid[0, 0] == 1
    check grid[1, 0] == 2
    check grid[2, 1] == 2
    check merged.affineTransform.originX == 0
    check merged.affineTransform.pixelWidth == 1

  test "progress closures, cancellation and callback exceptions":
    let src = image(512, 512)
    let cfg = TranslateConfig(outputSize: some(initRasterOutputSize(1024, 1024)))
    var calls = 0
    let cb: ProgressCallback = proc(complete: float64, message: string): bool =
      inc calls
      check complete >= 0 and complete <= 1
      true
    discard src.copyRaster(config = cfg, progress = cb)
    check calls > 0
    var cancelled = false
    expect IOError:
      discard src.copyRaster(
        config = cfg,
        progress = proc(complete: float64, message: string): bool =
          cancelled = true
          false,
      )
    check cancelled
    var raised = false
    try:
      discard src.copyRaster(
        config = cfg,
        progress = proc(complete: float64, message: string): bool =
          raise newException(ValueError, "callback error"),
      )
    except ValueError as e:
      raised = e.msg == "callback error"
    check raised

  test "invalid processing configuration":
    let src = image()
    expect ValueError:
      discard src.crop(RasterWindow(x: 3, y: 0, width: 2, height: 1))
    expect ValueError:
      discard src.crop(RasterWindow(x: -1, y: 0, width: 1, height: 1))
    expect ValueError:
      discard src.copyRaster(
        config =
          TranslateConfig(outputSize: some(RasterOutputSize(width: 0, height: 1)))
      )
    expect ValueError:
      discard src.copyRaster(config = TranslateConfig(bands: @[0]))
    expect ValueError:
      discard src.copyRaster(config = TranslateConfig(bands: @[2]))
    expect ValueError:
      discard
        src.copyRaster(config = TranslateConfig(creationOptions: @["bad\0option"]))
    expect ValueError:
      discard mosaic(newSeq[Dataset]())
    expect ValueError:
      discard src.warp(
        config = WarpConfig(bounds: some(Bounds(minX: 2, minY: 0, maxX: 1, maxY: 1)))
      )
    expect ValueError:
      discard src.warp(
        config = WarpConfig(bounds: some(Bounds(minX: NaN, minY: 0, maxX: 1, maxY: 1)))
      )
    expect ValueError:
      discard src.warp(
        config = WarpConfig(outputSize: some(RasterOutputSize(width: 1, height: -1)))
      )
    expect ValueError:
      discard src.warp(config = WarpConfig(targetCrs: "EPSG:4326\0bad"))
    expect ValueError:
      discard src.warp(config = WarpConfig(creationOptions: @["bad\0option"]))
    expect ValueError:
      discard src.warp(config = WarpConfig(coordinateOperation: "bad\0operation"))
    for value in [-1.0, NaN, Inf]:
      expect ValueError:
        discard src.warp(config = WarpConfig(errorThreshold: some(value)))
    for value in [0.0, -1.0, NaN, Inf]:
      expect ValueError:
        discard src.warp(config = WarpConfig(memoryLimitMiB: some(value)))
    expect ValueError:
      discard src.warp(config = WarpConfig(threadCount: some(0)))
