## Owning computedbands resources.
import ./[api, datasets, raster]
import ./private/resources

type ComputedBand* = object
  resource: NativeResource[GDALComputedRasterBandH]

template access(T, H: typedesc) =
  proc rawHandle*(value: T): H =
    value.resource.rawHandle

  proc close*(value: T) =
    value.resource.close()

access(ComputedBand, GDALComputedRasterBandH)

proc unary*(band: RasterBand, op: GDALRasterAlgebraUnaryOperation): ComputedBand =
  let h = GDALRasterBandUnaryOp(band.rawHandle, op)
  ComputedBand(
    resource: newNativeResource(
      h,
      proc(p: GDALComputedRasterBandH) {.nimcall, raises: [].} =
        GDALComputedRasterBandRelease(p),
    )
  )

proc size*(band: ComputedBand): tuple[width, height: int] =
  let h = cast[GDALRasterBandH](band.rawHandle)
  (int(GDALGetRasterBandXSize(h)), int(GDALGetRasterBandYSize(h)))

proc read*(band: ComputedBand): seq[float64] =
  let (width, height) = band.size
  if width <= 0 or height <= 0 or width > high(int) div height:
    raise newException(ValueError, "invalid band dimensions")
  result = newSeq[float64](width * height)
  if GDALRasterIO(
    cast[GDALRasterBandH](band.rawHandle),
    GF_Read,
    0,
    0,
    cint(width),
    cint(height),
    addr result[0],
    cint(width),
    cint(height),
    GDT_Float64,
    0,
    0,
  ) != CE_None:
    raise gdalError("could not read computed band")
