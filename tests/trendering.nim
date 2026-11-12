import std/[math, options, unittest]
import ngis/api

proc layout(width = 2, height = 2, bounds = initBounds(0, 0, 2, 2)): RasterLayout =
  initRasterLayout(width, height, bounds, "EPSG:3857")

suite "reusable map rendering":
  test "layout creates a north-up georeferenced raster":
    let frame = layout(4, 2, initBounds(10, 20, 18, 26))
    check frame.width == 4
    check frame.height == 2
    check frame.bounds == initBounds(10, 20, 18, 26)
    check newSpatialReference(frame.crs).toWkt.len > 0
    let source = createRaster(uint8, frame, bands = 2)
    check source.size == (width: 4, height: 2)
    check source.bandCount == 2
    check source.affineTransform ==
      AffineTransform(originX: 10, originY: 26, pixelWidth: 2, pixelHeight: -3)

  test "source row orders, nearest cells and output padding":
    let source = layout()
    let target = layout(4, 4)
    let topDown = initRasterLookup(source, target)
    let bottomUp =
      initRasterLookup(source, target, sourceRows = RasterRowOrder.bottomUp)
    check topDown.width == 4
    check topDown.height == 4
    check topDown.len == 16
    check topDown.sourceCellCount == 4
    check topDown[0, 0] == some(0)
    check topDown[1, 1] == some(0)
    check topDown[3, 0] == some(1)
    check topDown[0, 3] == some(2)
    check topDown[3, 3] == some(3)
    check bottomUp[0, 0] == some(2)
    check bottomUp[3, 3] == some(1)
    let padded = initRasterLookup(source, layout(4, 4, initBounds(-1, -1, 3, 3)))
    check padded[0, 0].isNone
    check padded[3, 3].isNone
    check padded[1, 1] == some(0)
    check padded[2, 2] == some(3)
    var selected = 0
    for cell in padded:
      if cell.isSome:
        inc selected
    check selected == 4
    expect ValueError:
      discard padded[-1, 0]
    expect ValueError:
      discard padded[0, 4]

  test "mask and clipping preserve holes and disconnected parts at output resolution":
    let source = layout(1, 1, initBounds(0, 0, 6, 4))
    let target = layout(6, 4, initBounds(0, 0, 6, 4))
    let boundary = geometryFromWkt(
      "MULTIPOLYGON (((0 0,4 0,4 4,0 4,0 0),(1 1,3 1,3 3,1 3,1 1))," &
        "((5 0,6 0,6 1,5 1,5 0)))"
    )
    let mask = rasterizeMask(boundary, target)
    check mask ==
      @[1'u8, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 1]
    let lookup = initRasterLookup(source, target, clip = boundary)
    boundary.close()
    check lookup[0, 0] == some(0)
    check lookup[1, 1].isNone
    check lookup[4, 3].isNone
    check lookup[5, 3] == some(0)
    let narrow = geometryFromWkt("POLYGON ((0.1 0.1,0.2 0.1,0.2 0.2,0.1 0.2,0.1 0.1))")
    let onePixel = layout(1, 1, initBounds(0, 0, 1, 1))
    check rasterizeMask(narrow, onePixel) == @[0'u8]
    check rasterizeMask(narrow, onePixel, allTouched = true) == @[1'u8]

  test "reprojection matches inverse-transformed pixel centers":
    let source = initRasterLayout(3, 4, initBounds(10, 40, 13, 44), "EPSG:4326")
    let geographic = newSpatialReference(4326, AxisOrder.traditionalGis)
    let mercator = newSpatialReference(3857, AxisOrder.traditionalGis)
    let forward = newCoordinateTransform(geographic, mercator)
    let corners =
      forward.transform([Coordinate(x: 10, y: 40), Coordinate(x: 13, y: 44)])
    let target = initRasterLayout(
      13,
      17,
      initBounds(corners[0].x, corners[0].y, corners[1].x, corners[1].y),
      "EPSG:3857",
    )
    let lookup = initRasterLookup(source, target)
    let inverse = newCoordinateTransform(mercator, geographic)
    for y in 0 ..< target.height:
      for x in 0 ..< target.width:
        let world = target.affineTransform.pixelToWorld(
          Coordinate(x: float64(x) + 0.5, y: float64(y) + 0.5)
        )
        let projected = inverse.transform([world])[0]
        let pixel = source.affineTransform.worldToPixel(projected)
        check lookup[x, y] ==
          some(int(floor(pixel.y)) * source.width + int(floor(pixel.x)))
    let identity = initRasterLookup(source, source, coordinateOperation = "+proj=noop")
    check identity[0, 0] == some(0)
    check identity[2, 3] == some(11)

  test "straight RGBA, transparency and reusable output storage":
    let lookup = initRasterLookup(layout(), layout(4, 4, initBounds(-1, -1, 3, 3)))
    let colors = [
      Rgba8(r: 255, g: 127, b: 33, a: 128),
      Rgba8(r: 10, g: 20, b: 30, a: 0),
      Rgba8(r: 40, g: 50, b: 60, a: 255),
      Rgba8(r: 70, g: 80, b: 90, a: 255),
    ]
    var pixels = lookup.colorize(colors)
    check pixels[0] == Rgba8()
    check pixels[5] == colors[0] # Straight RGB is not multiplied by alpha.
    check pixels[6] == colors[1]
    let bytes = cast[ptr UncheckedArray[uint8]](addr pixels[5])
    check sizeof(Rgba8) == 4
    check bytes[0] == 255 and bytes[1] == 127 and bytes[2] == 33 and bytes[3] == 128
    let storage = addr pixels[0]
    let replacement = [Rgba8(a: 255), Rgba8(a: 255), Rgba8(a: 255), Rgba8(a: 255)]
    lookup.colorize(replacement, pixels)
    check addr(pixels[0]) == storage
    check pixels[5] == replacement[0]
    check pixels[0] == Rgba8()

  test "vertical CRS units never scale source cell identifiers":
    let bounds = initBounds(1500000, 1000000, 1500020, 1000020)
    let feet = initRasterLayout(2, 2, bounds, "EPSG:26975+6360")
    let meters = initRasterLayout(2, 2, bounds, "EPSG:26975+5703")
    let lookup = initRasterLookup(feet, meters)
    check lookup[0, 0] == some(0)
    check lookup[1, 0] == some(1)
    check lookup[0, 1] == some(2)
    check lookup[1, 1] == some(3)

  test "per-cell hatching follows output pixel coordinates and keeps alpha":
    let lookup = initRasterLookup(layout(2, 1), layout(6, 2))
    let colors =
      [Rgba8(r: 101, g: 51, b: 21, a: 128), Rgba8(r: 90, g: 60, b: 30, a: 255)]
    let pixels =
      lookup.colorize(colors, hatch = [true, false], style = initHatchStyle(3, 1, 0.7))
    check pixels[0] == Rgba8(r: 70, g: 35, b: 14, a: 128)
    check pixels[1] == colors[0]
    check pixels[6] == colors[0]
    check pixels[8] == Rgba8(r: 70, g: 35, b: 14, a: 128)
    check pixels[3] == colors[1]

  test "invalid layouts, buffers, configurations and styles are rejected":
    for bounds in [
      initBounds(0, 0, 0, 1),
      Bounds(minX: NaN, minY: 0, maxX: 1, maxY: 1),
      Bounds(minX: 0, minY: 0, maxX: Inf, maxY: 1),
    ]:
      expect ValueError:
        discard layout(bounds = bounds)
    expect ValueError:
      discard initRasterLayout(1, 1, initBounds(0, 0, 1, 1), "")
    expect ValueError:
      discard initRasterLayout(1, 1, initBounds(0, 0, 1, 1), "EPSG:3857\0bad")
    expect ValueError:
      discard createRaster(uint8, RasterLayout())
    expect ValueError:
      discard initRasterLookup(RasterLayout(), layout())
    expect ValueError:
      discard rasterizeMask(nil, layout())
    expect ValueError:
      discard initRasterLookup(layout(), layout(), memoryLimitMiB = 0)
    let lookup = initRasterLookup(layout(), layout())
    expect ValueError:
      discard lookup.colorize([Rgba8()])
    var output = newSeq[Rgba8](3)
    let colors = [Rgba8(), Rgba8(), Rgba8(), Rgba8()]
    expect ValueError:
      lookup.colorize(colors, output)
    expect ValueError:
      discard lookup.colorize(colors, hatch = [true])
    expect ValueError:
      discard
        lookup.colorize(colors, hatch = [true, true, true, true], style = HatchStyle())
    expect ValueError:
      discard RasterLookup().colorize(colors)
    expect ValueError:
      discard initHatchStyle(2, 3)
    for brightness in [-1.0, 1.01, NaN, Inf]:
      expect ValueError:
        discard initHatchStyle(brightness = brightness)
