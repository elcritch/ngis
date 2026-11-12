## Differential checks against the original full-edge scan, on native and JavaScript.
import ngis/polygonqueries

import std/[algorithm, math, random, unittest]

proc point(x, y: float): Coordinate =
  Coordinate(x: x, y: y)

proc scanRing(
    ring: openArray[Coordinate], p: Coordinate, tolerance: float
): PointLocation =
  ## Retain the pre-index algorithm as an independent regression oracle.
  var inside = false
  for index, a in ring:
    let b = ring[(index + 1) mod ring.len]
    let dx = b.x - a.x
    let dy = b.y - a.y
    let length = hypot(dx, dy)
    if p.x >= min(a.x, b.x) - tolerance and p.x <= max(a.x, b.x) + tolerance and
        p.y >= min(a.y, b.y) - tolerance and p.y <= max(a.y, b.y) + tolerance:
      if length == 0:
        if hypot(p.x - a.x, p.y - a.y) <= tolerance:
          return PointOnBoundary
      elif abs((p.x - a.x) * (dy / length) - (p.y - a.y) * (dx / length)) <= tolerance:
        return PointOnBoundary
    if (a.y > p.y) != (b.y > p.y):
      let crossing = a.x + (p.y - a.y) * dx / dy
      if p.x < crossing:
        inside = not inside
  if inside: PointInside else: PointOutside

proc scanPolygon(
    shell: seq[Coordinate], holes: seq[seq[Coordinate]], p: Coordinate, tolerance: float
): PointLocation =
  let location = scanRing(shell, p, tolerance)
  if location != PointInside:
    return location
  for hole in holes:
    let location = scanRing(hole, p, tolerance)
    if location == PointOnBoundary:
      return PointOnBoundary
    if location == PointInside:
      return PointOutside
  PointInside

proc wavyRing(vertices: int, radius: float): seq[Coordinate] =
  for index in 0 ..< vertices:
    let angle = 2 * PI * index.float / vertices.float
    let distance = radius * (1 + 0.12 * cos(7 * angle))
    result.add(point(-93 + distance * cos(angle), 41 + distance * sin(angle)))

suite "Indexed polygon queries (native and JS)":
  test "indexed rings match an independent full edge scan":
    var rng = initRand(20261021)
    for vertices in [31, 32, 33, 64, 255, 1999]:
      let shell = wavyRing(vertices, 0.04)
      let holes = @[wavyRing(65, 0.01).reversed()]
      for ring in [shell, shell & @[shell[0]], shell.reversed()]:
        let polygon = initPolygon2D(ring, holes)
        var probes: seq[Coordinate]
        for index in 0 ..< 300:
          probes.add(point(-93 + rng.rand(-0.06 .. 0.06), 41 + rng.rand(-0.06 .. 0.06)))
        for edge in 0 ..< ring.len:
          let a = ring[edge]
          let b = ring[(edge + 1) mod ring.len]
          probes.add(a)
          probes.add(point((a.x + b.x) / 2, (a.y + b.y) / 2))
        for hole in holes:
          probes.add(hole[0])
        for tolerance in [0.0, 0.000001, 0.002]:
          for probe in probes:
            check polygon.locate(probe, tolerance) ==
              scanPolygon(ring, holes, probe, tolerance)

  test "horizontal, vertical and zero length edges match the scan":
    # Subdivide an exact square beyond the index threshold; repeated vertices are legal.
    var shell: seq[Coordinate]
    for index in 0 ..< 12:
      shell.add(point(index.float, 0))
    for index in 0 ..< 12:
      shell.add(point(12, index.float))
    for index in countdown(12, 1):
      shell.add(point(index.float, 12))
    for index in countdown(12, 1):
      shell.add(point(0, index.float))
    shell.add(shell[^1])
    shell.add(shell[0])
    for ring in [shell, shell.reversed()]:
      let polygon = initPolygon2D(ring)
      for x in [-0.01, 0.0, 0.01, 6.0, 11.99, 12.0, 12.01]:
        for y in [-0.01, 0.0, 0.01, 6.0, 11.99, 12.0, 12.01]:
          for tolerance in [0.0, 0.02, 100.0]:
            check polygon.locate(point(x, y), tolerance) ==
              scanPolygon(ring, @[], point(x, y), tolerance)

  test "prepared data owns its inputs and rejects invalid tolerance":
    var shell = wavyRing(64, 0.04)
    var hole = wavyRing(64, 0.01)
    let polygon = initPolygon2D(shell, [hole])
    shell[0] = point(0, 0)
    hole[0] = point(0, 0)
    check polygon.locate(point(-93, 41)) == PointOutside
    check polygon.locate(point(-92.98, 41)) == PointInside
    for tolerance in [NaN, Inf, NegInf, -1.0]:
      expect ValueError:
        discard polygon.locate(point(-93, 41), tolerance)
