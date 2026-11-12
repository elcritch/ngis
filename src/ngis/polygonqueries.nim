## Planar point queries for simple polygons with holes, on native Nim and nim js.
## All coordinates must use the same continuous coordinate system. Geographic callers
## must handle projection/longitude wrapping before querying. No reading or field IDs
## are stored here. Rings must be simple; this module does not repair invalid topology.
import std/[algorithm, math]
import ./coordinatevalues
export coordinatevalues

type
  PointLocation* = enum ## Point membership, with boundaries classified separately.
    PointOutside
    PointInside
    PointOnBoundary

  PreparedEdge = object
    origin: Coordinate
    minX, minY, maxX, maxY: float
    dx, dy, unitX, unitY: float

  PreparedRing = object
    edges: seq[PreparedEdge]
    subtreeMaxY: seq[float]
    minX, minY, maxX, maxY: float

  Polygon2D* = object ## Immutable rings with cached edges and y interval indexes.
    shell: PreparedRing
    holes: seq[PreparedRing]

const indexedRingThreshold = 32

func valid(point: Coordinate): bool =
  classify(point.x) notin {fcNan, fcInf, fcNegInf} and
    classify(point.y) notin {fcNan, fcInf, fcNegInf} and abs(point.x) <= 1e12 and
    abs(point.y) <= 1e12

proc validate(ring: openArray[Coordinate]) =
  if ring.len < 3:
    raise newException(ValueError, "A polygon ring needs at least three vertices")
  var area = 0.0
  let origin = ring[0]
  for idx, point in ring:
    if not point.valid():
      raise
        newException(ValueError, "Polygon coordinates must be finite and within ±1e12")
    let next = ring[(idx + 1) mod ring.len]
    area +=
      (point.x - origin.x) * (next.y - origin.y) -
      (next.x - origin.x) * (point.y - origin.y)
  if area == 0:
    raise newException(ValueError, "A polygon ring must have nonzero area")

proc buildIndex(ring: var PreparedRing, first, last: int): float =
  ## Store each balanced subtree's upper y bound at its middle edge.
  let middle = first + (last - first) div 2
  var maxY = ring.edges[middle].maxY
  if first < middle:
    maxY = max(maxY, ring.buildIndex(first, middle - 1))
  if middle < last:
    maxY = max(maxY, ring.buildIndex(middle + 1, last))
  ring.subtreeMaxY[middle] = maxY
  maxY

proc prepareRing(points: openArray[Coordinate]): PreparedRing =
  ## Keep small rings linear; large rings sort edges once for interval pruning.
  result.edges = newSeqOfCap[PreparedEdge](points.len)
  result.minX = points[0].x
  result.maxX = points[0].x
  result.minY = points[0].y
  result.maxY = points[0].y
  for index, a in points:
    let b = points[(index + 1) mod points.len]
    let dx = b.x - a.x
    let dy = b.y - a.y
    let length = hypot(dx, dy)
    result.edges.add(
      PreparedEdge(
        origin: a,
        minX: min(a.x, b.x),
        maxX: max(a.x, b.x),
        minY: min(a.y, b.y),
        maxY: max(a.y, b.y),
        dx: dx,
        dy: dy,
        unitX: (if length == 0: 0.0 else: dx / length),
        unitY: (if length == 0: 0.0 else: dy / length),
      )
    )
    result.minX = min(result.minX, a.x)
    result.maxX = max(result.maxX, a.x)
    result.minY = min(result.minY, a.y)
    result.maxY = max(result.maxY, a.y)
  if points.len > indexedRingThreshold:
    result.edges.sort(
      proc(a, b: PreparedEdge): int =
        cmp(a.minY, b.minY)
    )
    result.subtreeMaxY = newSeq[float](points.len)
    discard result.buildIndex(0, points.high)

proc initPolygon2D*(
    shell: openArray[Coordinate],
    holes: openArray[seq[Coordinate]] = [],
    maxVertices: Positive = 10_000,
): Polygon2D =
  ## Prepare a simple shell and optional simple holes; large rings cost O(n log n).
  ## Open/closed rings and either winding direction are accepted. Invalid coordinates,
  ## zero-area rings or exceeding the total vertex budget raise ValueError.
  ## Callers must supply nonintersecting rings with holes inside the shell.
  if shell.len > maxVertices or holes.len > maxVertices div 3:
    raise newException(ValueError, "Polygon vertex budget exceeded")
  var remaining = maxVertices - shell.len
  shell.validate()
  for hole in holes:
    if hole.len > remaining:
      raise newException(ValueError, "Polygon vertex budget exceeded")
    remaining -= hole.len
    hole.validate()
  result.shell = prepareRing(shell)
  result.holes = newSeqOfCap[PreparedRing](holes.len)
  for hole in holes:
    result.holes.add(prepareRing(hole))

func visitEdge(
    edge: PreparedEdge, point: Coordinate, tolerance: float, inside: var bool
): bool {.inline.} =
  ## Preserve inclusive boundaries and the original half-open ray-crossing rule.
  if point.x >= edge.minX - tolerance and point.x <= edge.maxX + tolerance and
      point.y >= edge.minY - tolerance and point.y <= edge.maxY + tolerance:
    if edge.dx == 0 and edge.dy == 0:
      if hypot(point.x - edge.origin.x, point.y - edge.origin.y) <= tolerance:
        return true
    elif abs(
      (point.x - edge.origin.x) * edge.unitY - (point.y - edge.origin.y) * edge.unitX
    ) <= tolerance:
      return true
  if edge.minY <= point.y and point.y < edge.maxY:
    let crossing = edge.origin.x + (point.y - edge.origin.y) * edge.dx / edge.dy
    if point.x < crossing:
      inside = not inside

func visitIndex(
    ring: PreparedRing,
    point: Coordinate,
    tolerance: float,
    first, last: int,
    inside: var bool,
): bool =
  ## Visit only subtrees whose vertical intervals overlap the point plus tolerance.
  let middle = first + (last - first) div 2
  if point.y < ring.edges[first].minY - tolerance or
      point.y > ring.subtreeMaxY[middle] + tolerance:
    return false
  if ring.edges[middle].visitEdge(point, tolerance, inside):
    return true
  if first < middle and ring.visitIndex(point, tolerance, first, middle - 1, inside):
    return true
  if middle < last and ring.visitIndex(point, tolerance, middle + 1, last, inside):
    return true

func locateRing(
    ring: PreparedRing, point: Coordinate, tolerance: float
): PointLocation =
  if point.x < ring.minX - tolerance or point.x > ring.maxX + tolerance or
      point.y < ring.minY - tolerance or point.y > ring.maxY + tolerance:
    return PointOutside
  var inside = false
  if ring.subtreeMaxY.len > 0:
    if ring.visitIndex(point, tolerance, 0, ring.edges.high, inside):
      return PointOnBoundary
  else:
    for edge in ring.edges:
      if edge.visitEdge(point, tolerance, inside):
        return PointOnBoundary
  if inside: PointInside else: PointOutside

proc locate*(polygon: Polygon2D, point: Coordinate, tolerance = 0.0): PointLocation =
  ## Classify a point, distinguishing shell/hole boundaries from the interior.
  ## Tolerance is in caller coordinate units (default exact boundary comparison).
  ## Invalid points and an uninitialized polygon return PointOutside. Invalid tolerance
  ## raises ValueError. Large rings use cached y interval indexes to prune edges;
  ## worst-case queries remain O(vertices). The prepared polygon is safe to share read-only.
  if classify(tolerance) in {fcNan, fcInf, fcNegInf} or tolerance < 0:
    raise newException(ValueError, "Boundary tolerance must be finite and nonnegative")
  if polygon.shell.edges.len == 0 or not point.valid():
    return PointOutside
  let shell = locateRing(polygon.shell, point, tolerance)
  if shell != PointInside:
    return shell
  for hole in polygon.holes:
    let location = locateRing(hole, point, tolerance)
    if location == PointOnBoundary:
      return PointOnBoundary
    if location == PointInside:
      return PointOutside
  PointInside

proc contains*(polygon: Polygon2D, point: Coordinate): bool =
  ## Strict interior membership: excludes all shell and hole boundaries.
  polygon.locate(point) == PointInside

proc covers*(polygon: Polygon2D, point: Coordinate): bool =
  ## Inclusive membership: accepts shell/hole boundaries, excludes hole interiors.
  polygon.locate(point) != PointOutside
