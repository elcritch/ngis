import std/[unittest, options, tables]
import ngis/api

static:
  doAssert not declared(GDALOpenEx)
  doAssert declared(loadGdal)
  doAssert not declared(registerGdalImports)
  doAssert declared(initLocalProjection)
  doAssert declared(estimateGridIdw)
  doAssert declared(initPolygon2D)
  doAssert declared(gridIdw)
  doAssert declared(newIdwGrid)

suite "high-level API":
  test "local mapping uses the same coordinates as native geometry":
    let projection = initLocalProjection(GeoPoint(lat: 42, lon: -93))
    let origin = projection.project(GeoPoint(lat: 42, lon: -93))
    let position = projection.project(GeoPoint(lat: 42.001, lon: -92.999))
    let line = newLineString([origin, position])
    var points: seq[Coordinate]
    for point in line.points:
      points.add(point)
    check points == @[origin, position]

  test "typed raster, resampling and copy":
    let image = createRaster(float32, 2, 2)
    var grid = initRasterGrid[float32](2, 2)
    grid[0, 0] = 1
    grid[1, 0] = 2
    grid[0, 1] = 3
    grid[1, 1] = 4
    image.band().write(grid)
    check readGrid[float32](image.band())[1, 1] == 4
    let resized = readGrid[float32](image.band(), initRasterWindow(0, 0, 2, 2), 1, 1)
    check resized.len == 1
    let copied = copyRaster(
      image, config = TranslateConfig(outputSize: some(initRasterOutputSize(2, 2)))
    )
    check readGrid[float32](copied.band())[1, 1] == 4
    image.setMetadata("name", "sample")
    check image.metadataItems()["name"] == "sample"
    image.deleteMetadata("name")
    check image.metadata("name").isNone
    image.description = "sample raster"
    check image.description == "sample raster"
    image.band().description = "sample band"
    check image.band().description == "sample band"
    image.band().deleteMetadata("absent")

  test "vector schema, coordinates and CRS":
    let ds = createVector()
    let layer = ds.createLayer("places", GeometryKind.point)
    layer.addField(FieldSpec(name: "label", kind: fkString))
    let feature = layer.newFeature()
    feature.setField("label", "home")
    layer.add(feature)
    check layer.feature(feature.id).fieldValue("label").text == "home"
    check newPoint(1, 2).geometryKind == GeometryKind.point
    let bounds = initBounds(0, 0, 4, 4)
    check bounds.contains(Coordinate(x: 1, y: 2))
    let transform = toAffineTransform([0.0, 2, 0, 0, 0, -2])
    check transform.pixelToWorld(Coordinate(x: 1, y: 2)) == Coordinate(x: 2, y: -4)
    let crs = newSpatialReference(4326, AxisOrder.traditionalGis)
    check crs.toWkt.len > 0

  test "typed multidimensional array":
    let ds = createMultiDimDataset("MEM", "")
    let root = ds.rootGroup
    let dim = root.createDimension("x", 2)
    let values = root.createArray("values", [dim], int32)
    values.write(initArrayData([2'u64], @[4'i32, 5]))
    check root["values"].readArrayData(int32)[1] == 5
