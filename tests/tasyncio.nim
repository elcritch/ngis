import std/unittest
import ngis/gdal/[datasets, raster, asyncio]
import ngis/gdal/api

suite "asynchronous raster reader":
  test "owns buffer and keeps dataset alive after source close":
    let dataset = createDataset("MEM", "", 2, 2)
    dataset.band.write(@[1'u8, 2, 3, 4])
    let reader = beginAsyncRead[uint8](dataset, 0, 0, 2, 2)
    let alias = reader
    dataset.close()
    let region = reader.nextRegion()
    check region.status == GARIO_COMPLETE
    check (region.x, region.y, region.width, region.height) == (0, 0, 2, 2)
    check reader.copyBuffer() == @[1'u8, 2, 3, 4]
    reader.close()
    reader.close()
    expect ValueError:
      discard alias.copyBuffer()

  test "reject invalid windows and closed datasets":
    let dataset = createDataset("MEM", "", 2, 2)
    expect ValueError:
      discard beginAsyncRead[float32](dataset, 1, 1, 2, 2)
    dataset.close()
    expect ValueError:
      discard beginAsyncRead[float32](dataset, 0, 0, 1, 1)

  test "reader is ended when its last owner leaves scope":
    let dataset = createDataset("MEM", "", 1, 1)
    dataset.band.write(@[9'u8])
    block:
      let reader = beginAsyncRead[uint8](dataset, 0, 0, 1, 1)
      check reader.nextRegion().status == GARIO_COMPLETE
      check reader.copyBuffer() == @[9'u8]
    check read[uint8](dataset.band) == @[9'u8]
    dataset.close()
