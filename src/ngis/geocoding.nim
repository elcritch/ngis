## Owning geocoding resources.
import ./[gdal, vector]
import ./private/resources

type
  GeocodingSession* = object
    resource: NativeResource[OGRGeocodingSessionH]

  GeocodingResult* = object
    resource: NativeResource[OGRLayerH]

template access(T, H: typedesc) =
  proc rawHandle*(value: T): H =
    value.resource.rawHandle

  proc close*(value: T) =
    value.resource.close()

access(GeocodingSession, OGRGeocodingSessionH)
access(GeocodingResult, OGRLayerH)

proc newGeocodingSession*(options: openArray[string] = []): GeocodingSession =
  for option in options:
    validateCString(option, "geocoding option")
  let args = allocCStringArray(options)
  defer:
    deallocCStringArray(args)
  GeocodingSession(
    resource: newNativeResource(
      OGRGeocodeCreateSession(args),
      proc(h: OGRGeocodingSessionH) {.nimcall, raises: [].} =
        OGRGeocodeDestroySession(h),
    )
  )

proc geocode*(session: GeocodingSession, query: string): GeocodingResult =
  ## Sends a query to the configured geocoding service.
  validateCString(query, "geocoding query")
  GeocodingResult(
    resource: newNativeResource(
      OGRGeocode(session.rawHandle, query.cstring, nil, nil),
      proc(h: OGRLayerH) {.nimcall, raises: [].} =
        OGRGeocodeFreeResult(h),
    )
  )

proc reverseGeocode*(
    session: GeocodingSession, longitude, latitude: float64
): GeocodingResult =
  GeocodingResult(
    resource: newNativeResource(
      OGRGeocodeReverse(session.rawHandle, longitude, latitude, nil),
      proc(h: OGRLayerH) {.nimcall, raises: [].} =
        OGRGeocodeFreeResult(h),
    )
  )

proc featureCount*(value: GeocodingResult): int64 =
  OGR_L_GetFeatureCount(value.rawHandle, 1)

iterator items*(value: GeocodingResult): Feature =
  OGR_L_ResetReading(value.rawHandle)
  while true:
    let f = OGR_L_GetNextFeature(value.rawHandle)
    if f == nil:
      break
    yield adoptFeature(f)
