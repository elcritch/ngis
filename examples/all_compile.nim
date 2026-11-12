## Compile this bundle to check the public examples; it is not a test runner.
import ngis

proc rasterExample() =
  let image = createDataset("MEM", "", 2, 2, dataType = GDT_Float32)
  let pixels = image.band()
  pixels.write([1'f32, 2, 3, 4])
  echo read[float32](pixels)
  echo read[float32](pixels, 1, 0, 1, 2)
  let copy = translate(image, "", ["-of", "MEM"])
  echo copy.size

proc vectorExample() =
  let data = createDataset("MEM", "", 0, 0, bands = 0)
  let crs = newSpatialReference(4326)
  let places = data.createLayer("places", wkbPoint, crs)
  places.addField("name", OFTString)
  let feature = places.newFeature()
  feature["name"] = "Harbour"
  feature.setGeometry(newPoint(33.0, 35.0))
  places.add(feature)
  for place in places:
    echo place["name"], ": ", place.geometry.toWkt()

proc multidimensionalExample() =
  let data = createMultiDimDataset("MEM", "")
  let root = data.rootGroup()
  let group = root.createGroup("observations")
  let time = group.createDimension("time", 3)
  let temperature = group.createArray("temperature", [time], numericType(GDT_Float32))
  temperature.write([18'f32, 19, 20])
  echo temperature.read(float32)
  echo group.arrayNames

proc algorithmsExample() =
  let source = createDataset("MEM", "", 2, 2)
  let algorithm = globalAlgorithmRegistry().instantiate(["raster", "info"])
  algorithm.argument("input").set([source])
  algorithm.argument("format").set("json")
  algorithm.run()
  algorithm.finalize()
  let options = newInfoOptions(["-json"])
  echo source.info(options)

proc resourcesExample() =
  let xml = parseXml("<station><name>Harbour</name></station>")
  echo xml.root.value("name")
  let file = openVirtualFile("/vsimem/example.bin", "w+b")
  file.write([1'u8, 2, 3])
  file.close()
  let table = newRasterAttributeTable()
  table.addColumn("value", GFT_Integer)
  table.setRowCount(1)
  table.setValue(0, 0, 42)
  echo table.intValue(0, 0)
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
  resourcesExample()
