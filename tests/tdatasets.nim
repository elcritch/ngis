import std/[os, unittest]
import ngis/gdal
import ngis/gdal/api

suite "owning datasets":
  test "automatic cleanup flushes a file that can be reopened":
    let path = "/vsimem/ngis-owner-" & $getCurrentProcessId() & ".tif"
    defer:
      discard VSIUnlink(path.cstring)
    proc writeImage(path: string) =
      let image = createDataset("GTiff", path, 2, 1, dataType = GDT_UInt16)
      image.band().write([123'u16, 456'u16])

    writeImage(path)
    let reopened = openDataset(path)
    check reopened.size == (2, 1)
    check reopened.bandCount == 1
    check read[uint16](reopened.band()) == @[123'u16, 456'u16]
    reopened.close()

  test "aliases share explicit close state":
    let image = createDataset("MEM", "", 1, 1)
    let alias = image
    image.close()
    image.close()
    check alias.isClosed
    expect ValueError:
      discard alias.rawHandle
    var absent: Dataset
    check absent.isClosed
    absent.close()

  test "invalid inputs and missing data raise catchable errors":
    expect ValueError:
      discard createDataset("MEM", "", -1, 1)
    expect ValueError:
      discard createDataset("unknown-ngis-driver", "", 1, 1)
    expect ValueError:
      discard createDataset("MEM", "", 1, 1, options = ["bad\0option"])
    expect ValueError:
      discard openDataset("bad\0path")
    expect ValueError:
      discard openDataset("", raster = false, vector = false)
    expect IOError:
      discard openDataset("/vsimem/ngis-absent-file.tif")
