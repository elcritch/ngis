import std/[os, unittest]
import ngis/gdal

suite "GDAL raster C API":
  test "float raster and geotransform round trip":
    GDALAllRegister()
    let driver = GDALGetDriverByName("MEM")
    require driver != nil
    let ds = GDALCreate(driver, "", 2, 2, 1, GDT_Float32, nil)
    require ds != nil
    defer:
      discard GDALClose(ds)
    check GDALGetRasterCount(ds) == 1
    let band = GDALGetRasterBand(ds, 1)
    require band != nil
    var values = [1.25'f32, 2.5'f32, 3.75'f32, 4.0'f32]
    check GDALRasterIO(
      band, GF_Write, 0, 0, 2, 2, addr values[0], 2, 2, GDT_Float32, 0, 0
    ) == CE_None
    var readback: array[4, float32]
    check GDALRasterIO(
      band, GF_Read, 0, 0, 2, 2, addr readback[0], 2, 2, GDT_Float32, 0, 0
    ) == CE_None
    check readback == values
    var transform = [10.0, 2.0, 0.0, 20.0, 0.0, -2.0]
    check GDALSetGeoTransform(ds, addr transform[0]) == CE_None
    var readTransform: array[6, float64]
    check GDALGetGeoTransform(ds, addr readTransform[0]) == CE_None
    check readTransform == transform
    check GDALSetRasterNoDataValue(band, -9999) == CE_None
    var valid: cint
    check GDALGetRasterNoDataValue(band, addr valid) == -9999
    check valid == 1

  test "translate a raster with GDAL utilities":
    GDALAllRegister()
    let driver = GDALGetDriverByName("MEM")
    require driver != nil
    let source = GDALCreate(driver, "", 2, 2, 1, GDT_Float32, nil)
    require source != nil
    defer:
      discard GDALClose(source)
    var values = [1.25'f32, 2.5'f32, 3.75'f32, 4.0'f32]
    let band = GDALGetRasterBand(source, 1)
    require band != nil
    require GDALRasterIO(
      band, GF_Write, 0, 0, 2, 2, addr values[0], 2, 2, GDT_Float32, 0, 0
    ) == CE_None
    let args = allocCStringArray(["-of", "MEM"])
    defer:
      deallocCStringArray(args)
    let options = GDALTranslateOptionsNew(args, nil)
    require options != nil
    defer:
      GDALTranslateOptionsFree(options)
    var usageError: cint
    let output = GDALTranslate("", source, options, addr usageError)
    require output != nil
    defer:
      discard GDALClose(output)
    check usageError == 0
    var result: array[4, float32]
    let outputBand = GDALGetRasterBand(output, 1)
    require outputBand != nil
    check GDALRasterIO(
      outputBand, GF_Read, 0, 0, 2, 2, addr result[0], 2, 2, GDT_Float32, 0, 0
    ) == CE_None
    check result == values

  test "vector geometry and spatial reference":
    let geometry = OGR_G_CreateGeometry(wkbPoint)
    require geometry != nil
    defer:
      OGR_G_DestroyGeometry(geometry)
    check OGR_G_AddPoint_2D(geometry, 12.5, 34.5) == OGRERR_NONE
    check OGR_G_GetX(geometry, 0) == 12.5
    check OGR_G_GetY(geometry, 0) == 34.5
    let srs = OSRNewSpatialReference(nil)
    require srs != nil
    defer:
      OSRDestroySpatialReference(srs)
    check OSRImportFromEPSG(srs, 4326) == OGRERR_NONE

  test "rasterize a vector feature":
    let path = getTempDir() / ("ngis-gdal-" & $getCurrentProcessId() & ".geojson")
    writeFile(
      path,
      """{"type":"FeatureCollection","features":[{"type":"Feature","properties":{"value":7},"geometry":{"type":"Point","coordinates":[0.5,0.5]}}]}""",
    )
    defer:
      removeFile(path)
    GDALAllRegister()
    let source = GDALOpenEx(path.cstring, 4, nil, nil, nil)
    require source != nil
    defer:
      discard GDALClose(source)
    let args = allocCStringArray(
      ["-of", "MEM", "-a", "value", "-ts", "1", "1", "-te", "0", "0", "1", "1"]
    )
    defer:
      deallocCStringArray(args)
    let options = GDALRasterizeOptionsNew(args, nil)
    require options != nil
    defer:
      GDALRasterizeOptionsFree(options)
    var usageError: cint
    let raster = GDALRasterize("", nil, source, options, addr usageError)
    require raster != nil
    defer:
      discard GDALClose(raster)
    check usageError == 0
    let band = GDALGetRasterBand(raster, 1)
    require band != nil
    var value: float32
    check GDALRasterIO(band, GF_Read, 0, 0, 1, 1, addr value, 1, 1, GDT_Float32, 0, 0) ==
      CE_None
    check value == 7
