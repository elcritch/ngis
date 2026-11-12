## Compile this bundle to check the public examples; it is not a test runner.
import std/options
import ngis/api

proc rasterExample() =
  let image = createRaster(float32, 2, 2)
  var pixels = initRasterGrid(2, 2, @[1'f32, 2, 3, 4])
  pixels[1, 0] = 12.5
  image.band().write(pixels)
  echo readGrid[float32](image.band())[1, 0]
  for window in image.band().tiles(256, 256):
    echo readGrid[float32](image.band(), window).len
  let copy = image.copyRaster(
    config = TranslateConfig(
      outputSize: some(initRasterOutputSize(4, 4)),
      resampling: RasterResampling.bilinear,
    )
  )
  echo copy.size

proc vectorExample() =
  let data = createVector()
  let crs = newSpatialReference(4326, AxisOrder.traditionalGis)
  let places = data.createLayer("places", GeometryKind.point, crs)
  places.addField(FieldSpec(name: "name", kind: fkString))
  places.addField(FieldSpec(name: "samples", kind: fkInteger64List))
  let feature = places.newFeature()
  feature.setField("name", "Harbour")
  feature.setField("samples", @[10'i64, 20, 30])
  feature.setGeometry(newPoint(33.0, 35.0))
  places.add(feature)
  for place in places:
    echo place.fieldValue("name").text, ": ", place.geometry.toWkt()
  for field in places.fields:
    echo field.name, " ", field.kind

proc multidimensionalExample() =
  let data = createMultiDimDataset()
  let root = data.rootGroup()
  let group = root.createGroup("observations")
  let time = group.createDimension("time", 3)
  let temperature = group.createArray("temperature", [time], float32)
  temperature.write([18'f32, 19, 20])
  echo temperature.readArrayData(float32)[1]
  let slice = initArraySlice([1'u64], [2'u64])
  echo temperature.read(slice, float32)
  echo group["temperature"].shape
  echo group.arrayNames

proc algorithmsExample() =
  let source = createRaster(uint8, 2, 2)
  let algorithm = globalAlgorithmRegistry().instantiate(["raster", "info"])
  algorithm.argument("input").set([source])
  algorithm.argument("format").set("json")
  algorithm.run()
  algorithm.finalize()
  let options = newInfoOptions(["-json"])
  echo source.info(options)

proc coordinateExample() =
  let polygon = newPolygon(
    [
      Coordinate(x: 0, y: 0),
      Coordinate(x: 4, y: 0),
      Coordinate(x: 4, y: 4),
      Coordinate(x: 0, y: 4),
    ]
  )
  echo polygon.area, " ", polygon.bounds
  echo polygon.buffer(1).area
  let source = createRaster(uint8, 2, 2)
  source.affineTransform =
    AffineTransform(originX: 0, originY: 2, pixelWidth: 1, pixelHeight: -1)
  source.spatialReference = newSpatialReference(4326, AxisOrder.traditionalGis)
  let projected = source.reproject(newSpatialReference(3857))
  echo projected.size
  var calls = 0
  let copy = source.copyRaster(
    progress = proc(complete: float64, message: string): bool =
      inc calls
      true
  )
  echo copy.size, " ", calls

proc resourcesExample() =
  let xml = parseXml("<station><name>Harbour</name></station>")
  echo xml.root.value("name")
  let file = openVirtualFile("/vsimem/example.bin", "w+b")
  file.write([1'u8, 2, 3])
  file.close()
  let list = newStringList()
  list.set("station", "Harbour")
  echo list.values
  let domain = newGlobDomain("station", "ST-*")
  echo domain.glob
  let relation = newRelationship("places", "stations", "observations")
  relation.setLeftFields(["station_id"])
  echo relation.leftFields
  let coordinateOptions = newCoordinateOptions()
  coordinateOptions.setBallparkAllowed(true)

when isMainModule:
  rasterExample()
  vectorExample()
  multidimensionalExample()
  algorithmsExample()
  coordinateExample()
  resourcesExample()
