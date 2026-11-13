import std/unittest
import ngis as core
import
  ngis/gdal/
    [datasets, raster, rasterio, gridding, arrayops, features, geometryops, algorithms]
import ngis/gdal/api as raw

static:
  doAssert core.RasterGrid[float32] is rasterio.RasterGrid[float32]
  doAssert core.ArrayData[float32] is arrayops.ArrayData[float32]
  doAssert core.FieldValue is features.FieldValue
  doAssert core.GeometryKind is geometryops.GeometryKind
  doAssert core.IdwGridOptions is gridding.IdwGridOptions
  doAssert core.Point3D is algorithms.Point3D

suite "Explicit GDAL backend":
  test "backend modules consume shared core values":
    let image = createDataset("MEM", "", 2, 1, dataType = raw.GDT_Float32)
    image.band(1).write(core.initRasterGrid(2, 1, @[4'f32, 5]))
    check readGrid[float32](image.band(1))[1, 0] == 5
    check raw.GDALGetRasterXSize(image.rawHandle) == 2
    image.close()

  test "GDAL gridding consumes the shared interpolation inputs":
    let samples = [core.MetricSample(x: 0.5, y: 0.5, value: 7)]
    let spec = core.GridSpec(cellSize: 1, columns: 1, rows: 1)
    check gridIdw(samples, spec, core.IdwGridOptions()) == @[7.0]
