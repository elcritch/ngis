## Coordinate values, bounding boxes, affine mappings and CRS transformations.
import std/math
import ./[gdal, spatialrefs]
export spatialrefs

type
  AxisOrder* {.pure.} = enum
    authority
    traditionalGis

  Coordinate* = object
    x*, y*: float64

  Bounds* = object
    minX*, minY*, maxX*, maxY*: float64

  AffineTransform* = object
    originX*, pixelWidth*, rowRotation*: float64
    originY*, columnRotation*, pixelHeight*: float64

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

proc initBounds*(minX, minY, maxX, maxY: float64): Bounds =
  ## Bounds include their edges. Invalid or NaN limits raise ValueError.
  if not (minX <= maxX and minY <= maxY):
    raise newException(ValueError, "invalid bounds")
  Bounds(minX: minX, minY: minY, maxX: maxX, maxY: maxY)

func contains*(b: Bounds, p: Coordinate): bool =
  p.x >= b.minX and p.x <= b.maxX and p.y >= b.minY and p.y <= b.maxY

func intersects*(a, b: Bounds): bool =
  a.minX <= b.maxX and b.minX <= a.maxX and a.minY <= b.maxY and b.minY <= a.maxY

func toAffineTransform*(values: array[6, float64]): AffineTransform =
  AffineTransform(
    originX: values[0],
    pixelWidth: values[1],
    rowRotation: values[2],
    originY: values[3],
    columnRotation: values[4],
    pixelHeight: values[5],
  )

func toArray*(t: AffineTransform): array[6, float64] =
  [t.originX, t.pixelWidth, t.rowRotation, t.originY, t.columnRotation, t.pixelHeight]

func pixelToWorld*(t: AffineTransform, pixel: Coordinate): Coordinate =
  Coordinate(
    x: t.originX + pixel.x * t.pixelWidth + pixel.y * t.rowRotation,
    y: t.originY + pixel.x * t.columnRotation + pixel.y * t.pixelHeight,
  )

proc worldToPixel*(t: AffineTransform, world: Coordinate): Coordinate =
  ## Raises ValueError when the linear part is singular.
  for value in t.toArray:
    if classify(value) in {fcNan, fcInf, fcNegInf}:
      raise newException(ValueError, "non-finite affine transform")
  let determinant = t.pixelWidth * t.pixelHeight - t.rowRotation * t.columnRotation
  if determinant == 0.0 or classify(determinant) in {fcNan, fcInf, fcNegInf}:
    raise newException(ValueError, "singular affine transform")
  let dx = world.x - t.originX
  let dy = world.y - t.originY
  Coordinate(
    x: (dx * t.pixelHeight - dy * t.rowRotation) / determinant,
    y: (dy * t.pixelWidth - dx * t.columnRotation) / determinant,
  )

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
