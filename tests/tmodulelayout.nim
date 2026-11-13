import std/unittest
import ngis/gdal/[datasets, raster, rasterio, gridding]
import ngis/gdal/api as raw
import ngis/gdal as legacyRaw
import ngis/datasets as legacyDatasets
import ngis/rasterio as legacyRasterio

static:
  doAssert datasets.Dataset is legacyDatasets.Dataset
  doAssert rasterio.RasterGrid[float32] is legacyRasterio.RasterGrid[float32]
  doAssert raw.GDALDatasetH is legacyRaw.GDALDatasetH

suite "GDAL module layout":
  test "canonical owning modules and raw API share handles":
    let image = createDataset("MEM", "", 2, 1, dataType = raw.GDT_Float32)
    image.band(1).write(initRasterGrid(2, 1, @[4'f32, 5]))
    check readGrid[float32](image.band(1))[1, 0] == 5
    check raw.GDALGetRasterXSize(image.rawHandle) == 2
    image.close()

  test "canonical GDAL gridding keeps the common metric input types":
    let samples = [MetricSample(x: 0.5, y: 0.5, value: 7)]
    let spec = GridSpec(cellSize: 1, columns: 1, rows: 1)
    check gridIdw(samples, spec) == @[7.0]
