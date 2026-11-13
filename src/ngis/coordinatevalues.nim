## Coordinate values, bounds and affine mappings without native dependencies.
import std/math

type
  Coordinate* = object
    x*, y*: float64

  Bounds* = object
    minX*, minY*, maxX*, maxY*: float64

  AffineTransform* = object
    originX*, pixelWidth*, rowRotation*: float64
    originY*, columnRotation*, pixelHeight*: float64

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

type AxisOrder* {.pure.} = enum
  authority
  traditionalGis

type Point3D* = object
  x*, y*, z*: float64
