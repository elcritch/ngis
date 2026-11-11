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

when isMainModule:
  rasterExample()
  vectorExample()
