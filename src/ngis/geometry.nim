## Geometry categories shared by GIS implementations.
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
