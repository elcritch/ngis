## Owning coordinateprecision resources.
import ./gdal
import ./private/resources

type CoordinatePrecision* = object
  resource: NativeResource[OGRGeomCoordinatePrecisionH]

template access(T, H: typedesc) =
  proc rawHandle*(value: T): H =
    value.resource.rawHandle

  proc close*(value: T) =
    value.resource.close()

access(CoordinatePrecision, OGRGeomCoordinatePrecisionH)

proc newCoordinatePrecision*(): CoordinatePrecision =
  CoordinatePrecision(
    resource: newNativeResource(
      OGRGeomCoordinatePrecisionCreate(),
      proc(h: OGRGeomCoordinatePrecisionH) {.nimcall, raises: [].} =
        OGRGeomCoordinatePrecisionDestroy(h),
    )
  )

proc set*(precision: CoordinatePrecision, xy, z, m: float64) =
  OGRGeomCoordinatePrecisionSet(precision.rawHandle, xy, z, m)

proc resolutions*(precision: CoordinatePrecision): tuple[xy, z, m: float64] =
  let h = precision.rawHandle
  (
    OGRGeomCoordinatePrecisionGetXYResolution(h),
    OGRGeomCoordinatePrecisionGetZResolution(h),
    OGRGeomCoordinatePrecisionGetMResolution(h),
  )
