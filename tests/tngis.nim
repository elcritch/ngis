import std/[math, options, unittest]
import ngis

static:
  doAssert not declared(GDALOpenEx)
  doAssert not declared(loadGdal)
  doAssert not declared(Dataset)
  doAssert not declared(gridIdw)
  doAssert declared(initLocalProjection)
  doAssert declared(IdwGridOptions)

suite "Backend-independent ngis core":
  test "shared raster buffers and tiling work without a backend":
    var pixels = initRasterGrid(2, 1, @[3'f32, 4])
    pixels[1, 0] = 7
    check pixels[0, 0] == 3
    check pixels[1, 0] == 7
    check pixels.data == @[3'f32, 7]
    var count = 0
    for tile in initRasterWindow(0, 0, 5, 3).tiles(2, 2):
      check tile.width <= 2 and tile.height <= 2
      count.inc()
    check count == 6

  test "shared array buffers retain independent shape and values":
    var data = initArrayData([2'u64, 2], @[1, 2, 3, 4])
    data[1, 0] = 8
    check data.shape == @[2'u64, 2]
    check data[1, 0] == 8
    check data.data == @[1, 2, 8, 4]
    check initArraySlice([0'u64, 1], [2'u64, 1]).count == @[2'u64, 1]
    expect ValueError:
      discard initArrayData([2'u64], @[1])

  test "layouts, lookup construction and colorization are generic":
    let layout = initRasterLayout(2, 1, initBounds(10, 20, 14, 22), "EPSG:4326")
    check layout.crs == "EPSG:4326"
    check layout.affineTransform.pixelToWorld(Coordinate(x: 0.5, y: 0.5)) ==
      Coordinate(x: 11, y: 21)
    let lookup = initRasterLookup(3, 1, 2, @[1'u32, 0, 2])
    let colors = [Rgba8(r: 100, a: 255), Rgba8(g: 200, a: 128)]
    check lookup.colorize(colors) == @[colors[0], Rgba8(), colors[1]]
    check lookup[1, 0].isNone
    expect ValueError:
      discard initRasterLookup(1, 1, 2, @[3'u32])
    expect ValueError:
      discard initRasterLookup(2, 1, 2, @[1'u32])

  test "field, geometry and coordinate types have no native handles":
    let field = FieldSpec(name: "value", kind: fkReal)
    let value = FieldValue(kind: fvReal, real: 12.5)
    check field.kind == fkReal
    check value.real == 12.5
    check GeometryKind.polygon != GeometryKind.point
    check Point3D(x: 1, y: 2, z: 3).z == 3
    check AxisOrder.traditionalGis != AxisOrder.authority

  test "location means and interpolation policy are shared utilities":
    let locations = locationMeans(
      [
        MetricSample(value: 0),
        MetricSample(value: 20),
        MetricSample(x: 3, value: 30),
        MetricSample(x: 4, value: NaN),
      ]
    )
    check locations == @[MetricSample(value: 10), MetricSample(x: 3, value: 30)]
    check IdwGridOptions().power == 2
    check IdwGridOptions().coverageRadius == Inf
    expect ValueError:
      discard locationMeans([MetricSample(), MetricSample()], maxSamples = 1)
