## Convenience geometry construction and operations.
import ./[gdal, vector, coordinates, datasets]
export vector, coordinates

type GeometryKind* {.pure.} = enum
  unknown
  point
  lineString
  polygon
  multiPoint
  multiLineString
  multiPolygon
  collection
  none

proc nativeKind(kind: GeometryKind): OGRwkbGeometryType =
  case kind
  of GeometryKind.unknown: wkbUnknown
  of GeometryKind.point: wkbPoint
  of GeometryKind.lineString: wkbLineString
  of GeometryKind.polygon: wkbPolygon
  of GeometryKind.multiPoint: wkbMultiPoint
  of GeometryKind.multiLineString: wkbMultiLineString
  of GeometryKind.multiPolygon: wkbMultiPolygon
  of GeometryKind.collection: wkbGeometryCollection
  of GeometryKind.none: wkbNone

proc newGeometry*(kind: GeometryKind): Geometry =
  vector.newGeometry(nativeKind(kind))

proc createLayer*(
    dataset: Dataset, name: string, kind: GeometryKind, srs: SpatialReference = nil
): Layer =
  vector.createLayer(dataset, name, nativeKind(kind), srs)

proc geometryKind*(geometry: Geometry): GeometryKind =
  ## Ignores Z and M dimensions. Unsupported geometry types raise ValueError.
  case cuint(OGR_GT_Flatten(OGR_G_GetGeometryType(geometry.rawHandle)))
  of cuint(wkbUnknown):
    GeometryKind.unknown
  of cuint(wkbPoint):
    GeometryKind.point
  of cuint(wkbLineString):
    GeometryKind.lineString
  of cuint(wkbPolygon):
    GeometryKind.polygon
  of cuint(wkbMultiPoint):
    GeometryKind.multiPoint
  of cuint(wkbMultiLineString):
    GeometryKind.multiLineString
  of cuint(wkbMultiPolygon):
    GeometryKind.multiPolygon
  of cuint(wkbGeometryCollection):
    GeometryKind.collection
  of cuint(wkbNone):
    GeometryKind.none
  else:
    raise newException(ValueError, "unsupported geometry type")

proc newLineString*(points: openArray[Coordinate]): Geometry =
  if points.len < 2:
    raise newException(ValueError, "a line string needs at least two points")
  result = newGeometry(wkbLineString)
  for p in points:
    if OGR_G_AddPoint_2D(result.rawHandle, p.x, p.y) != OGRERR_NONE:
      raise newException(IOError, "could not add line string point")

proc addRing(polygon: Geometry, points: openArray[Coordinate]) =
  if points.len < 3:
    raise newException(ValueError, "a polygon ring needs at least three points")
  let ring = newGeometry(wkbLinearRing)
  for p in points:
    if OGR_G_AddPoint_2D(ring.rawHandle, p.x, p.y) != OGRERR_NONE:
      raise newException(IOError, "could not add ring point")
  if points[0] != points[^1]:
    if OGR_G_AddPoint_2D(ring.rawHandle, points[0].x, points[0].y) != OGRERR_NONE:
      raise newException(IOError, "could not close ring")
  elif points.len < 4:
    raise newException(ValueError, "a closed ring needs at least four points")
  if OGR_G_AddGeometry(polygon.rawHandle, ring.rawHandle) != OGRERR_NONE:
    raise newException(IOError, "could not add polygon ring")

proc newPolygon*(
    exterior: openArray[Coordinate], holes: openArray[seq[Coordinate]]
): Geometry =
  ## Constructs a polygon, closing each ring when necessary.
  result = newGeometry(wkbPolygon)
  result.addRing(exterior)
  for hole in holes:
    result.addRing(hole)

proc newPolygon*(exterior: openArray[Coordinate]): Geometry =
  newPolygon(exterior, [])

proc newMultiPoint*(points: openArray[Coordinate]): Geometry =
  result = newGeometry(wkbMultiPoint)
  for point in points:
    let geometry = newPoint(point.x, point.y)
    if OGR_G_AddGeometry(result.rawHandle, geometry.rawHandle) != OGRERR_NONE:
      raise newException(IOError, "could not add point")

proc newMultiLineString*(lines: openArray[seq[Coordinate]]): Geometry =
  result = newGeometry(wkbMultiLineString)
  for points in lines:
    let line = newLineString(points)
    if OGR_G_AddGeometry(result.rawHandle, line.rawHandle) != OGRERR_NONE:
      raise newException(IOError, "could not add line string")

proc newMultiPolygon*(polygons: openArray[Geometry]): Geometry =
  ## Copies polygon geometries into an independent collection.
  result = newGeometry(wkbMultiPolygon)
  for polygon in polygons:
    if OGR_G_AddGeometry(result.rawHandle, polygon.rawHandle) != OGRERR_NONE:
      raise newException(ValueError, "could not add polygon to collection")

iterator points*(g: Geometry): Coordinate =
  ## Yields coordinate values from a point, line string or ring.
  let handle = g.rawHandle
  for i in 0 ..< int(OGR_G_GetPointCount(handle)):
    yield Coordinate(x: OGR_G_GetX(handle, cint(i)), y: OGR_G_GetY(handle, cint(i)))

proc len*(g: Geometry): int =
  ## Number of component geometries (rings for polygons).
  int(OGR_G_GetGeometryCount(g.rawHandle))

proc `[]`*(g: Geometry, index: int): Geometry =
  ## Returns an independent clone of a component.
  let handle = g.rawHandle
  if index < 0 or index >= int(OGR_G_GetGeometryCount(handle)):
    raise newException(IndexDefect, "geometry component index out of bounds")
  let component = OGR_G_GetGeometryRef(handle, cint(index))
  if component == nil:
    raise newException(IOError, "could not read geometry component")
  let copy = OGR_G_Clone(component)
  if copy == nil:
    raise newException(IOError, "could not clone geometry component")
  adoptGeometry(copy)

iterator items*(g: Geometry): Geometry =
  for i in 0 ..< g.len:
    yield g[i]

proc isEmpty*(g: Geometry): bool =
  OGR_G_IsEmpty(g.rawHandle) != 0

proc bounds*(g: Geometry): Bounds =
  if g.isEmpty:
    raise newException(ValueError, "empty geometry has no bounds")
  var envelope: OGREnvelope
  OGR_G_GetEnvelope(g.rawHandle, addr envelope)
  initBounds(envelope.MinX, envelope.MinY, envelope.MaxX, envelope.MaxY)

proc area*(g: Geometry): float64 =
  OGR_G_Area(g.rawHandle)

proc length*(g: Geometry): float64 =
  OGR_G_Length(g.rawHandle)

proc intersects*(a, b: Geometry): bool =
  let first = a.rawHandle
  let second = b.rawHandle
  CPLErrorReset()
  result = OGR_G_Intersects(first, second) != 0
  if cuint(CPLGetLastErrorType()) >= cuint(CE_Failure):
    raise gdalError("geometry intersects failed")

proc contains*(a, b: Geometry): bool =
  let first = a.rawHandle
  let second = b.rawHandle
  CPLErrorReset()
  result = OGR_G_Contains(first, second) != 0
  if cuint(CPLGetLastErrorType()) >= cuint(CE_Failure):
    raise gdalError("geometry contains failed")

proc ownedResult(handle: OGRGeometryH, operation: string): Geometry =
  if handle == nil:
    raise newException(IOError, "geometry " & operation & " failed")
  adoptGeometry(handle)

proc buffer*(g: Geometry, distance: float64, quadrantSegments = 30): Geometry =
  if quadrantSegments <= 0 or quadrantSegments > int(high(cint)):
    raise newException(ValueError, "quadrant segments must be positive")
  ownedResult(OGR_G_Buffer(g.rawHandle, distance, cint(quadrantSegments)), "buffer")

proc intersection*(a, b: Geometry): Geometry =
  ownedResult(OGR_G_Intersection(a.rawHandle, b.rawHandle), "intersection")

proc union*(a, b: Geometry): Geometry =
  ownedResult(OGR_G_Union(a.rawHandle, b.rawHandle), "union")

proc difference*(a, b: Geometry): Geometry =
  ownedResult(OGR_G_Difference(a.rawHandle, b.rawHandle), "difference")
