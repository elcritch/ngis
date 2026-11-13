import std/unittest
import ngis/gdal/[datasets, operations, raster]
import ngis/gdal/api

suite "GDAL utility operations":
  test "translate copies raster pixels into an owned dataset":
    let source = createDataset("MEM", "", width = 2, height = 2)
    source.band.write([1'u8, 2, 3, 4])
    let translated = translate(source, "", ["-of", "MEM"])
    check read[uint8](translated.band) == @[1'u8, 2, 3, 4]
    close(source)
    check read[uint8](translated.band) == @[1'u8, 2, 3, 4]
    close(translated)

  test "invalid inputs raise without creating a dataset":
    let source = createDataset("MEM", "", width = 1, height = 1)
    expect ValueError:
      discard translate(source, "", ["-unknown-option"])
    expect ValueError:
      discard translate(source, "", ["bad\0option"])
    expect ValueError:
      discard warp([], "", ["-of", "MEM"])
    close(source)
    expect ValueError:
      discard translate(source, "", ["-of", "MEM"])

  test "VRT retains its source after the local owner goes out of scope":
    proc makeVrt(): Dataset =
      let source = createDataset("MEM", "", width = 2, height = 2)
      source.geoTransform = [0.0, 1.0, 0.0, 2.0, 0.0, -1.0]
      source.band.write([5'u8, 6, 7, 8])
      buildVrt([source], "")

    let vrt = makeVrt()
    check read[uint8](vrt.band) == @[5'u8, 6, 7, 8]
    close(vrt)
    let source = createDataset("MEM", "", width = 1, height = 1)
    source.geoTransform = [0.0, 1.0, 0.0, 1.0, 0.0, -1.0]
    source.band.write([42'u8])
    let retained = buildVrt([source], "")
    close(source)
    check source.isClosed
    check read[uint8](retained.band) == @[42'u8]
    close(retained)

  test "warp produces an in-memory raster":
    let source = createDataset("MEM", "", width = 2, height = 2)
    source.geoTransform = [0.0, 1.0, 0.0, 2.0, 0.0, -1.0]
    source.band.write([1'u8, 2, 3, 4])
    let warped = warp([source], "", ["-of", "MEM"])
    check read[uint8](warped.band) == @[1'u8, 2, 3, 4]
    close(warped)
    close(source)

  test "vector translation and rasterization use in-memory data":
    let source = createDataset("MEM", "", width = 0, height = 0, bands = 0)
    let layer = GDALDatasetCreateLayer(source.rawHandle, "points", nil, wkbPoint, nil)
    require layer != nil
    let feature = OGR_F_Create(OGR_L_GetLayerDefn(layer))
    let point = OGR_G_CreateGeometry(wkbPoint)
    check OGR_G_AddPoint_2D(point, 0.5, 0.5) == OGRERR_NONE
    check OGR_F_SetGeometry(feature, point) == OGRERR_NONE
    check OGR_L_CreateFeature(layer, feature) == OGRERR_NONE
    OGR_G_DestroyGeometry(point)
    OGR_F_Destroy(feature)
    let copied = vectorTranslate(source, "", ["-f", "MEM"])
    check GDALDatasetGetLayerCount(copied.rawHandle) == 1
    let image = rasterize(
      source,
      "",
      ["-of", "MEM", "-burn", "9", "-te", "0", "0", "1", "1", "-ts", "1", "1"],
    )
    check read[uint8](image.band) == @[9'u8]
    let surface = grid(
      source,
      "",
      [
        "-of", "MEM", "-l", "points", "-a", "nearest", "-txe", "0", "1", "-tye", "0",
        "1", "-outsize", "1", "1",
      ],
    )
    check read[float64](surface.band) == @[0.0]
    close(surface)
    close(image)
    close(copied)
    close(source)

  test "nested VRT survives closure of both source wrappers":
    let source = createDataset("MEM", "", width = 1, height = 1)
    source.geoTransform = [0.0, 1.0, 0.0, 1.0, 0.0, -1.0]
    source.band.write([17'u8])
    let first = buildVrt([source], "")
    let second = buildVrt([first], "")
    close(source)
    close(first)
    check read[uint8](second.band) == @[17'u8]
    close(second)
    close(second)
