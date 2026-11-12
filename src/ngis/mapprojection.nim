## Double-precision local GPS projections and normalized Web Mercator coordinates.
## Standard-library-only helpers for native Nim and JavaScript.
import std/math
import ./coordinatevalues
export coordinatevalues

type
  GeoPoint* = object ## WGS84 latitude and longitude in degrees.
    lat*, lon*: float

  LocalProjection* = object ## Approximate metres around a fixed GPS origin.
    origin: GeoPoint
    longitudeScale: float

func finite(value: float): bool =
  classify(value) notin {fcNan, fcInf, fcNegInf}

func validate(point: GeoPoint) =
  if not finite(point.lat) or not finite(point.lon) or abs(point.lat) >= 85 or
      abs(point.lon) > 180:
    raise newException(
      ValueError, "Expected WGS84 longitude in [-180, 180] and latitude in (-85, 85)"
    )

func longitudeDelta*(longitude, origin: float): float =
  ## Signed displacement in ``[-180, 180)``, including across the antimeridian.
  ## Inputs must be finite degrees within ``[-540, 540]``; otherwise raises ValueError.
  if not finite(longitude) or not finite(origin) or abs(longitude) > 540 or
      abs(origin) > 540:
    raise newException(ValueError, "Invalid longitude")
  result = longitude - origin
  while result < -180:
    result += 360
  while result >= 180:
    result -= 360

func initLocalProjection*(origin: GeoPoint): LocalProjection =
  ## Field-local equirectangular metres, anchored for stable sampled-cell grids.
  ## Requires finite longitude in ``[-180, 180]`` and latitude strictly between -85 and 85.
  origin.validate()
  LocalProjection(origin: origin, longitudeScale: 111320 * cos(origin.lat * PI / 180))

func project*(projection: LocalProjection, point: GeoPoint): Coordinate =
  ## Accurate enough for local field grids; not a continental or area projection.
  ## Rejects invalid geography and uninitialized projections with ValueError.
  if projection.longitudeScale <= 0:
    raise newException(ValueError, "Uninitialized local projection")
  point.validate()
  Coordinate(
    x: longitudeDelta(point.lon, projection.origin.lon) * projection.longitudeScale,
    y: (point.lat - projection.origin.lat) * 111320,
  )

func unproject*(projection: LocalProjection, point: Coordinate): GeoPoint =
  ## Invert local metre coordinates. Reject an uninitialized projection.
  if projection.longitudeScale <= 0 or not finite(point.x) or not finite(point.y):
    raise newException(ValueError, "Invalid local projection or coordinate")
  let lon = projection.origin.lon + point.x / projection.longitudeScale
  if not finite(lon) or abs(lon) > 540:
    raise newException(ValueError, "Coordinate exceeds the local projection")
  result =
    GeoPoint(lat: projection.origin.lat + point.y / 111320, lon: longitudeDelta(lon, 0))
  result.validate()

func webMercator*(point: GeoPoint, originLongitude = 0.0): Coordinate =
  ## Normalized world coordinates; x may exceed ``[0, 1]`` across the antimeridian.
  ## Retain float64 precision until the final pixel conversion in renderers.
  ## Uses the same geographic limits as initLocalProjection. The origin selects
  ## a world wrap and must be finite degrees within ``[-540, 540]``.
  point.validate()
  Coordinate(
    x: (originLongitude + 180 + longitudeDelta(point.lon, originLongitude)) / 360,
    y: (1 - arcsinh(tan(point.lat * PI / 180)) / PI) / 2,
  )

func fromWebMercator*(point: Coordinate): GeoPoint =
  ## Inverse normalized Mercator. Unwrapped output longitude preserves image bounds.
  ## Accepts y in ``[0, 1]``, including image edges beyond the forward latitude limit.
  ## Invalid/nonfinite input or overflowing longitude raises ValueError.
  if not finite(point.x) or not finite(point.y) or point.y < 0 or point.y > 1:
    raise newException(ValueError, "Invalid Web Mercator coordinate")
  let longitude = point.x * 360 - 180
  if not finite(longitude):
    raise newException(ValueError, "Web Mercator longitude exceeds numeric limits")
  GeoPoint(lon: longitude, lat: arctan(sinh(PI * (1 - 2 * point.y))) * 180 / PI)
