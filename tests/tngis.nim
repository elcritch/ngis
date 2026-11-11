import std/unittest

import ngis

suite "ngis":
  test "root module exports owning raster and vector workflows":
    let image = createDataset("MEM", "", 2, 1, dataType = GDT_Float32)
    image.band().write([1.5'f32, 2.5'f32])
    check read[float32](image.band()) == @[1.5'f32, 2.5'f32]
    let data = createDataset("MEM", "", 0, 0, bands = 0)
    let places = data.createLayer("places", wkbPoint)
    let feature = places.newFeature()
    feature.setGeometry(newPoint(2.0, 3.0))
    places.add(feature)
    var count = 0
    for place in places:
      check place.geometry.x == 2.0
      inc count
    check count == 1
