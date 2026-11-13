import std/[options, tables, unittest]
import ngis/gdal/[coordinates, datasetops, datasets, drivers, raster, vector]
import ngis/gdal/api

suite "dataset conveniences":
  test "open and update a GTiff with explicit options":
    let path = "/vsimem/ngis_datasetops_test.tif"
    defer:
      discard VSIUnlink(path.cstring)
    let created = createDataset("GTiff", path, 3, 2)
    created.close()
    let ds = openRaster(
      path, update = true, allowedDrivers = ["GTiff"], options = ["NUM_THREADS=1"]
    )
    check ds.size == (width: 3, height: 2)
    check ds.driver.name == "GTiff"
    ds.description = "memory raster"
    check ds.description == "memory raster"
    let band = ds.band(1)
    band.description = "first band"
    check band.description == "first band"
    ds.setMetadata("key", "first")
    let copied = ds.metadataItems()
    ds.setMetadata("key", "second")
    check copied["key"] == "first"
    check ds.metadata("key") == some("second")
    check ds.metadata("missing").isNone
    ds.deleteMetadata("key")
    check ds.metadata("key").isNone
    band.setMetadata("sample", "value")
    check band.metadata("sample") == some("value")
    band.deleteMetadata("sample")
    check band.metadata("sample").isNone
    let affine = toAffineTransform([10.0, 2, 0.5, 20, -0.25, -3])
    ds.affineTransform = affine
    check ds.affineTransform.toArray == affine.toArray
    check ds.affineTransform.pixelToWorld(Coordinate(x: 2, y: 3)) ==
      Coordinate(x: 15.5, y: 10.5)
    let source = newSpatialReference(4326, AxisOrder.traditionalGis)
    ds.spatialReference = source
    source.close()
    let first = ds.spatialReference
    let second = ds.spatialReference
    first.close()
    check second.toWkt.len > 0
    second.close()
    check ds.spatialReference.toWkt.len > 0
    ds.close()
    expect ValueError:
      discard ds.description
    expect ValueError:
      discard band.description
    let reopened = openRaster(path, allowedDrivers = ["GTiff"])
    check reopened.size.width == 3
    reopened.close()
    expect IOError:
      discard openRaster(path, allowedDrivers = ["PNG"])

  test "vector layer lookup and iteration":
    let ds = createVector()
    discard ds.createLayer("roads", wkbLineString)
    discard ds.createLayer("places", wkbPoint)
    check ds.layerCount == 2
    check ds.hasLayer("roads")
    check not ds.hasLayer("missing")
    discard ds.layer(0)
    discard ds.layer("places")
    expect KeyError:
      discard ds.layer(2)
    expect KeyError:
      discard ds.layer("missing")
    var count = 0
    for layer in ds.layers:
      discard layer.rawHandle
      inc count
    check count == 2
    let view = ds.layer(0)
    ds.close()
    expect ValueError:
      discard ds.layerCount
    expect ValueError:
      discard view.rawHandle

  test "invalid values and closed datasets":
    expect ValueError:
      discard initDatasetOpenOptions(kinds = {})
    expect ValueError:
      discard openDataset("unused", DatasetOpenOptions())
    expect ValueError:
      discard openRaster("unused", options = ["bad\0option"])
    expect ValueError:
      discard openRaster("unused", allowedDrivers = ["bad\0driver"])
    let ds = createVector()
    expect ValueError:
      ds.setMetadata("bad\0key", "value")
    expect ValueError:
      ds.setMetadata("key", "bad\0value")
    expect ValueError:
      discard ds.metadata("key", "bad\0domain")
    expect ValueError:
      ds.description = "bad\0description"
    expect ValueError:
      discard ds.hasLayer("bad\0name")
    ds.close()
    expect ValueError:
      discard ds.metadata("key")
