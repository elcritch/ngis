import std/[strutils, unittest]
import ngis/[algorithms, datasets, spatialrefs, raster, gdal]

suite "owning GDAL algorithm API":
  test "registry, arguments and usage":
    let registry = globalAlgorithmRegistry()
    check "raster" in registry.names
    let algorithm = registry.instantiate(["raster", "info"])
    check algorithm.name == "info"
    check "input" in algorithm.argumentNames
    check algorithm.usageJson.contains("input")
    let convert = registry.instantiate(["raster", "reproject"])
    let input = convert.argument("output")
    let dataset = createDataset("MEM", "", 2, 3)
    input.set(dataset)
    let value = input.datasetValue
    let retained = value.dataset
    dataset.close()
    check retained.size == (2, 3)
    value.close()
    input.close()
    convert.close()
    algorithm.close()
    registry.close()
    retained.close()

  test "argument values and errors":
    let registry = globalAlgorithmRegistry()
    let algorithm = registry.instantiate(["raster", "info"])
    let format = algorithm.argument("format")
    format.set("json")
    check format.stringValue == "json"
    expect ValueError:
      discard format.boolValue
    expect ValueError:
      discard algorithm.argument("does-not-exist")
    format.close()
    expect ValueError:
      discard format.name
    algorithm.close()

  test "run an algorithm with a dataset list":
    let registry = globalAlgorithmRegistry()
    let algorithm = registry.instantiate(["raster", "info"])
    let source = createDataset("MEM", "", 2, 3)
    algorithm.argument("input").set([source])
    algorithm.argument("format").set("json")
    algorithm.run()
    algorithm.finalize()
    expect ValueError:
      algorithm.run()

  test "transform points and release options":
    let transformer =
      newReprojectionTransformer(newSpatialReference(4326), newSpatialReference(3857))
    var points = [Point3D(x: 0, y: 0, z: 0), Point3D(x: 1, y: 1, z: 0)]
    check transformer.transform(points) == @[true, true]
    check abs(points[1].x) > 100000
    check transformer.transform(points, inverse = true) == @[true, true]
    check abs(points[1].x - 1) < 0.000001
    transformer.close()
    expect ValueError:
      discard transformer.transform(points)
    let warp = newWarpOptions()
    warp.close()
    warp.close()
    let pan = newPansharpenOptions()
    pan.close()

  test "nearest-neighbour grid copies its source points":
    let context = newNearestGrid([0.5, 1.5], [0.5, 0.5], [7.0, 9.0])
    check context.grid(0, 2, 0, 1, 2, 1) == @[7.0, 9.0]
    context.close()
    expect ValueError:
      discard context.grid(0, 1, 0, 1, 1, 1)

  test "warp operation retains datasets and copies pixels":
    let source = createDataset("MEM", "", 2, 2)
    let dest = createDataset("MEM", "", 2, 2)
    var gt = [0.0, 1.0, 0.0, 2.0, 0.0, -1.0]
    check GDALSetGeoTransform(source.rawHandle, addr gt[0]) == CE_None
    check GDALSetGeoTransform(dest.rawHandle, addr gt[0]) == CE_None
    source.band(1).write([1'u8, 2, 3, 4])
    let operation = newWarpOperation(source, dest)
    source.close()
    operation.warpRegion(0, 0, 2, 2)
    check read[uint8](dest.band(1)) == @[1'u8, 2, 3, 4]
    operation.close()

  test "pansharpening retains source datasets":
    let pan = createDataset("MEM", "", 2, 2)
    let spectral = createDataset("MEM", "", 2, 2)
    var gt = [0.0, 1.0, 0.0, 2.0, 0.0, -1.0]
    check GDALSetGeoTransform(pan.rawHandle, addr gt[0]) == CE_None
    check GDALSetGeoTransform(spectral.rawHandle, addr gt[0]) == CE_None
    pan.band(1).write([6'u8, 6, 6, 6])
    spectral.band(1).write([3'u8, 3, 3, 3])
    let operation = newPansharpenOperation(pan, spectral)
    pan.close()
    spectral.close()
    check operation.pansharpen(0, 0, 2, 2) == @[6.0, 6, 6, 6]
    operation.close()

  test "list arguments and borrowed handle invalidation":
    let registry = globalAlgorithmRegistry()
    let algorithm = registry.instantiate(["raster", "reproject"])
    let resolution = algorithm.argument("resolution")
    resolution.set([60.0, 30.0])
    check resolution.floatValues == @[60.0, 30.0]
    let output = algorithm.argument("output")
    let value = output.datasetValue
    algorithm.close()
    expect ValueError:
      discard resolution.floatValues
    expect ValueError:
      discard value.name
    value.close()
    output.close()
    resolution.close()

  test "homography transformer owns its native state":
    let transformer = newHomographyTransformer([1.0, 0, 3, 0, 1, 5, 0, 0, 1])
    var p = [Point3D(x: 1, y: 2)]
    check transformer.transform(p) == @[true]
    check transformer.transform(p, inverse = true) == @[true]
    check abs(p[0].x - 1) < 0.000001
    check abs(p[0].y - 2) < 0.000001
    transformer.close()

  test "control point transformers copy their inputs":
    let points = [
      GDAL_GCP(
        pszId: "a", pszInfo: "", dfGCPPixel: 0, dfGCPLine: 0, dfGCPX: 10, dfGCPY: 20
      ),
      GDAL_GCP(
        pszId: "b", pszInfo: "", dfGCPPixel: 1, dfGCPLine: 0, dfGCPX: 11, dfGCPY: 20
      ),
      GDAL_GCP(
        pszId: "c", pszInfo: "", dfGCPPixel: 0, dfGCPLine: 1, dfGCPX: 10, dfGCPY: 21
      ),
      GDAL_GCP(
        pszId: "d", pszInfo: "", dfGCPPixel: 1, dfGCPLine: 1, dfGCPX: 11, dfGCPY: 21
      ),
    ]
    for transformer in [
      newGcpTransformer(points, 1), newThinPlateSplineTransformer(points)
    ]:
      var p = [Point3D(x: 0.5, y: 0.5)]
      check transformer.transform(p) == @[true]
      check abs(p[0].x - 10.5) < 0.000001
      check abs(p[0].y - 20.5) < 0.000001
      transformer.close()

  test "approximate transformer tracks the base lifetime":
    let base = newHomographyTransformer([1.0, 0, 3, 0, 1, 5, 0, 0, 1])
    let approximation = newApproxTransformer(base, 0.01)
    var p = [Point3D(x: 1, y: 2)]
    check approximation.transform(p) == @[true]
    base.close()
    expect ValueError:
      discard approximation.transform(p)
    approximation.close()

  test "RPC transformer owns its coefficient state":
    var rpc: GDALRPCInfoV2
    rpc.dfLINE_SCALE = 1
    rpc.dfSAMP_SCALE = 1
    rpc.dfLAT_SCALE = 1
    rpc.dfLONG_SCALE = 1
    rpc.dfHEIGHT_SCALE = 1
    rpc.adfLINE_NUM_COEFF[2] = 1
    rpc.adfSAMP_NUM_COEFF[1] = 1
    rpc.adfLINE_DEN_COEFF[0] = 1
    rpc.adfSAMP_DEN_COEFF[0] = 1
    let transformer = newRpcTransformer(rpc)
    var p = [Point3D(x: 0, y: 0, z: 0)]
    check transformer.transform(p) == @[true]
    transformer.close()
