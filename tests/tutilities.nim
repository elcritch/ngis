import std/[unittest, strutils]
import ngis/gdal/[datasets, raster, vector, multidim, utilities, vectorextras]
import ngis/gdal/api

suite "utility options and operations":
  test "every option owner releases and invalidates aliases":
    template checkOwner(value: untyped) =
      block:
        let o = value
        let alias = o
        check o.rawHandle != nil
        o.close()
        expect ValueError:
          discard alias.rawHandle
        o.close()

    checkOwner(newInfoOptions())
    checkOwner(newTranslateOptions())
    checkOwner(newWarpAppOptions())
    checkOwner(newVectorTranslateOptions())
    checkOwner(newDEMProcessingOptions())
    checkOwner(newNearblackOptions())
    checkOwner(newGridOptions())
    checkOwner(newContourOptions(["-i", "1"]))
    checkOwner(newRasterizeOptions())
    checkOwner(newFootprintOptions())
    checkOwner(newBuildVRTOptions())
    checkOwner(newMultiDimInfoOptions())
    checkOwner(newMultiDimTranslateOptions())
    checkOwner(newVectorInfoOptions())
    checkOwner(newTileIndexOptions())
    checkOwner(newWkbExportOptions())
    expect ValueError:
      discard newInfoOptions(["bad\0argument"])

  test "raster, vector and multidimensional descriptions":
    let ds = createDataset("MEM", "", 3, 3)
    check "Size is 3, 3" in ds.info()
    let v = createDataset("MEM", "", 0, 0, 0)
    discard v.createLayer("places", wkbPoint)
    check "places" in v.vectorInfo()
    let md = createMultiDimDataset("MEM", "")
    discard md.rootGroup.createDimension("x", 2)
    check "x" in md.multiDimInfo()
    check newPoint(1, 2).toWkb().len == 21

  test "DEM processing and contours use in-memory data":
    let ds = createDataset("MEM", "", 3, 3, 1, GDT_Float64)
    let output =
      ds.demProcessing("", "hillshade", newDEMProcessingOptions(["-of", "MEM"]))
    check output.size == (width: 3, height: 3)
    let vectors = createDataset("MEM", "", 0, 0, 0)
    let layer = vectors.createLayer("contours", wkbLineString)
    contour(ds.band(1), layer, 1.0)

  test "nearblack, footprint and multidimensional translation":
    let source = createDataset("MEM", "", 3, 3, 1, GDT_Byte)
    let cleaned = nearblack(source, "", newNearblackOptions(["-of", "MEM"]))
    check cleaned.size == (width: 3, height: 3)
    let outlines = footprint(source, "", newFootprintOptions(["-of", "MEM"]))
    check outlines.vectorInfo().len > 0
    let md = createMultiDimDataset("MEM", "")
    let root = md.rootGroup
    let dim = root.createDimension("x", 2)
    let a = root.createArray("values", [dim], numericType(GDT_Int32))
    a.write([1'i32, 2'i32])
    let copied =
      multiDimTranslate([md], "", newMultiDimTranslateOptions(["-of", "MEM"]))
    check copied.rootGroup.openArray("values").read(int32) == @[1'i32, 2'i32]
