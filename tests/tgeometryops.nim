import std/unittest
import ngis/[geometryops, datasetops, datasets]

suite "geometry conveniences":
  test "construct and clone rings":
    let polygon = newPolygon(
      [
        Coordinate(x: 0, y: 0),
        Coordinate(x: 4, y: 0),
        Coordinate(x: 4, y: 3),
        Coordinate(x: 0, y: 3),
      ]
    )
    check polygon.area == 12
    check polygon.bounds == initBounds(0, 0, 4, 3)
    check polygon.len == 1
    let ring = polygon[0]
    var count = 0
    for component in polygon:
      inc count
      check component.x == 0
    check count == 1
    polygon.close()
    check ring.x(2) == 4
    expect ValueError:
      discard polygon.bounds
    expect IndexDefect:
      discard ring[0]

  test "invalid input and lines":
    expect ValueError:
      discard newLineString([Coordinate(x: 1, y: 1)])
    expect ValueError:
      discard newPolygon([Coordinate(x: 1, y: 1)])
    let line = newLineString([Coordinate(x: 0, y: 0), Coordinate(x: 3, y: 4)])
    check line.length == 5

  test "spatial operations":
    let a = newPolygon(
      [
        Coordinate(x: 0, y: 0),
        Coordinate(x: 4, y: 0),
        Coordinate(x: 4, y: 4),
        Coordinate(x: 0, y: 4),
      ]
    )
    let b = newPolygon(
      [
        Coordinate(x: 2, y: 2),
        Coordinate(x: 6, y: 2),
        Coordinate(x: 6, y: 6),
        Coordinate(x: 2, y: 6),
      ]
    )
    check a.intersects(b)
    check a.contains(newPoint(1, 1))
    check a.intersection(b).area == 4
    check a.union(b).area == 28
    check a.difference(b).area == 12
    check newPoint(0, 0).buffer(1).area > 3

  test "holes, points, collections and empty bounds":
    let exterior = @[
      Coordinate(x: 0, y: 0),
      Coordinate(x: 10, y: 0),
      Coordinate(x: 10, y: 10),
      Coordinate(x: 0, y: 10),
    ]
    let hole = @[
      Coordinate(x: 2, y: 2),
      Coordinate(x: 2, y: 4),
      Coordinate(x: 4, y: 4),
      Coordinate(x: 4, y: 2),
    ]
    let polygon = newPolygon(exterior, [hole])
    check polygon.area == 96
    let ring = polygon[1]
    polygon.close()
    var ringPoints: seq[Coordinate]
    for point in ring.points:
      ringPoints.add(point)
    check ringPoints.len == 5
    check ringPoints[0] == hole[0]
    let multi = newMultiPoint(exterior)
    check multi.len == 4
    let lines = newMultiLineString([exterior])
    check lines.len == 1
    let polygons = newMultiPolygon([newPolygon(exterior)])
    check polygons.len == 1
    let empty = newMultiPoint([])
    check empty.isEmpty
    expect ValueError:
      discard empty.bounds

  test "typed geometry and layer kinds":
    let point = newGeometry(GeometryKind.point)
    check point.geometryKind == GeometryKind.point
    let polygon = newPolygon(
      [Coordinate(x: 0, y: 0), Coordinate(x: 1, y: 0), Coordinate(x: 0, y: 1)]
    )
    check polygon.geometryKind == GeometryKind.polygon
    let threeDimensional = geometryFromWkt("POINT Z (1 2 3)")
    check threeDimensional.geometryKind == GeometryKind.point
    let ds = createVector()
    discard ds.createLayer("points", GeometryKind.point)
    check ds.hasLayer("points")
    ds.close()

  test "disjoint predicates return false":
    let a = newPoint(0, 0)
    let b = newPoint(10, 10)
    check not a.intersects(b)
    check not a.contains(b)
    a.close()
    expect ValueError:
      discard a.intersects(b)
