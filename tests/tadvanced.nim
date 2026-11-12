import std/[unittest, strutils]
import ngis/[gdal, datasets, raster, advanced, multidim]

proc writer(
    level: cdouble, count: cint, x, y: ptr cdouble, data: pointer
): CPLErr {.cdecl, raises: [].} =
  inc cast[ptr int](data)[]
  CE_None

suite "specialized resource owners":
  test "coordinate precision and geocoding session close safely":
    let p = newCoordinatePrecision()
    p.set(0.1, 0.2, 0.3)
    check abs(p.resolutions.xy - 0.1) < 1e-10
    let alias = p
    p.close()
    expect ValueError:
      discard alias.rawHandle
    let session = newGeocodingSession(["CACHE=NO"])
    session.close()
  test "triangulation owns data and locates a facet":
    if triangulationAvailable():
      let tri = newTriangulation([0.0, 1.0, 0.0], [0.0, 0.0, 1.0])
      let facet = tri.findFacet(0.2, 0.3)
      check facet >= 0
      let coords = tri.barycentric(facet, 0.2, 0.3)
      check abs(coords[0] + coords[1] + coords[2] - 1) < 1e-10
      tri.close()
    else:
      skip()
  test "streaming contours and subdataset descriptors":
    var count = 0
    let generator = newContourGenerator(2, 2, 1.0, 0.0, writer, addr count)
    generator.feed([0.0, 2.0])
    generator.feed([0.0, 2.0])
    generator.close()
    check count > 0
    let info = subdatasetInfo("GTIFF_DIR:1:/tmp/data.tif")
    check info.path == "/tmp/data.tif"
    check info.component == "1"
    check "/other.tif" in info.withPath("/other.tif")
    info.close()
  test "computed band retains its source dataset":
    let ds = createDataset("MEM", "", 2, 1, 1, GDT_Float64)
    ds.band().write([-2.0, 3.0])
    let calc = ds.band().unary(GRAUO_ABS)
    ds.close()
    check calc.read() == @[2.0, 3.0]
    calc.close()
  test "multidimensional raw and string attributes":
    let ds = createMultiDimDataset("MEM", "")
    let root = ds.rootGroup
    let attr = root.createAttribute("values", stringType(), [2'u64])
    attr.write(["alpha", "beta"])
    check attr.readStrings == @["alpha", "beta"]
    let number = root.createAttribute("number", numericType(GDT_Int32))
    number.write(42'i64)
    check number.readRawNumeric.len == 4
    let dim = root.createDimension("labels_dim", 2)
    let labels = root.createArray("labels", [dim], stringType())
    labels.write(["first", "second"])
    check labels.readStrings() == @["first", "second"]
    let blockInfo = newRawBlockInfo()
    blockInfo.close()
    expect ValueError:
      discard blockInfo.rawHandle
