import std/[options, unittest]
import ngis/gdal/[datasets, raster]
import ngis/gdal/api

suite "raster convenience API":
  test "window IO, geotransform, nodata and metadata":
    let ds = createDataset("MEM", "", 3, 2, dataType = GDT_Float32)
    defer:
      ds.close()
    let b = ds.band()
    check b.size == (3, 2)
    b.write([1'f32, 2, 3, 4, 5, 6])
    check read[float32](b) == @[1'f32, 2, 3, 4, 5, 6]
    b.write([8'f32, 9], 1, 0, 2, 1)
    check read[float32](b, 1, 0, 2, 2) == @[8'f32, 9, 5, 6]
    let transform = [10.0, 2.0, 0.0, 20.0, 0.0, -2.0]
    ds.geoTransform = transform
    check ds.geoTransform == transform
    check b.noData.isNone
    b.noData = some(-9999.0)
    check b.noData == some(-9999.0)
    b.noData = none(float64)
    check b.noData.isNone
    b.setMetadata("unit", "example")
    check b.metadata("unit") == some("example")
    check b.metadata("missing").isNone

  test "reject invalid bands, windows and buffers, including after close":
    let ds = createDataset("MEM", "", 2, 2)
    let b = ds.band()
    expect ValueError:
      discard ds.band(0)
    expect ValueError:
      discard read[uint8](b, 1, 1, 2, 2)
    expect ValueError:
      b.write([1'u8], 0, 0, 2, 2)
    ds.close()
    expect ValueError:
      discard b.size

  test "band retains its dataset":
    proc createBand(): RasterBand =
      let ds = createDataset("MEM", "", 1, 1)
      ds.band()

    let b = createBand()
    b.write([42'u8])
    check read[uint8](b) == @[42'u8]
