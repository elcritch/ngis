## Coordinate values, bounding boxes, affine mappings and CRS transformations.
import ./[api, spatialrefs]
import ../coordinatevalues
export spatialrefs, coordinatevalues

type AxisOrder* {.pure.} = enum
  authority
  traditionalGis

proc `axisOrder=`*(reference: SpatialReference, order: AxisOrder) =
  ## Set explicitly; without this setter GDAL's default axis order applies.
  reference.axisMappingStrategy = (
    if order == AxisOrder.authority:
      OAMS_AUTHORITY_COMPLIANT
    else: OAMS_TRADITIONAL_GIS_ORDER
  )

proc newSpatialReference*(definition: string, axisOrder: AxisOrder): SpatialReference =
  result = newSpatialReference(definition)
  result.axisOrder = axisOrder

proc newSpatialReference*(epsg: int, axisOrder: AxisOrder): SpatialReference =
  result = newSpatialReference(epsg)
  result.axisOrder = axisOrder

proc transform*(
    t: CoordinateTransform, coordinates: openArray[Coordinate]
): seq[Coordinate] =
  ## Returns transformed coordinates; failure raises ValueError without changing the input.
  let handle = t.rawHandle
  if coordinates.len > int(high(cint)):
    raise newException(ValueError, "too many coordinates")
  if coordinates.len == 0:
    return @[]
  var xs = newSeq[float64](coordinates.len)
  var ys = newSeq[float64](coordinates.len)
  var zs = newSeq[float64](coordinates.len)
  var success = newSeq[cint](coordinates.len)
  for i, point in coordinates:
    xs[i] = point.x
    ys[i] = point.y
  if OCTTransformEx(
    handle, cint(coordinates.len), addr xs[0], addr ys[0], addr zs[0], addr success[0]
  ) == 0:
    raise newException(ValueError, "coordinate transformation failed")
  result = newSeq[Coordinate](coordinates.len)
  for i in 0 ..< coordinates.len:
    if success[i] == 0:
      raise newException(ValueError, "coordinate transformation failed at index " & $i)
    result[i] = Coordinate(x: xs[i], y: ys[i])
