import ngis/polygonqueries

import std/[algorithm, unittest]

proc point(x, y: float): Coordinate =
  Coordinate(x: x, y: y)

suite "Prepared polygon queries (native and JS)":
  let shell = @[point(0, 0), point(10, 0), point(10, 10), point(0, 10)]
  let hole = @[point(3, 3), point(7, 3), point(7, 7), point(3, 7)]

  test "field shell, holes and boundary policy":
    let polygon = initPolygon2D(shell, [hole])
    check polygon.locate(point(1, 1)) == PointInside
    check polygon.locate(point(5, 5)) == PointOutside
    check polygon.locate(point(-1, 5)) == PointOutside
    for edge in [point(0, 0), point(5, 0), point(10, 5), point(3, 5), point(3, 3)]:
      check polygon.locate(edge) == PointOnBoundary
      check polygon.covers(edge)
      check not polygon.contains(edge)
    check polygon.contains(point(1, 1))
    check not polygon.covers(point(5, 5))

  test "open closed and reversed rings give the same membership":
    for ring in [shell, shell & @[shell[0]], shell.reversed()]:
      let polygon = initPolygon2D(ring, [hole.reversed()])
      check polygon.contains(point(1, 1))
      check not polygon.covers(point(5, 5))

  test "concave rings preserve unsampled cutouts and horizontal edge crossings":
    let polygon = initPolygon2D(
      [point(0, 0), point(4, 0), point(4, 1), point(1, 1), point(1, 4), point(0, 4)]
    )
    check polygon.contains(point(0.5, 3))
    check polygon.contains(point(3, 0.5))
    check not polygon.covers(point(3, 3))
    check polygon.locate(point(2, 1)) == PointOnBoundary

  test "coordinate tolerance is explicit and invalid points are outside":
    let polygon = initPolygon2D(shell)
    check polygon.locate(point(-0.001, 5)) == PointOutside
    check polygon.locate(point(-0.001, 5), 0.002) == PointOnBoundary
    check polygon.locate(point(NaN, 5)) == PointOutside
    check polygon.locate(point(5, Inf)) == PointOutside
    check Polygon2D().locate(point(0, 0)) == PointOutside
    expect ValueError:
      discard polygon.locate(point(1, 1), -1)

  test "invalid geometry and total vertex budget fail early":
    expect ValueError:
      discard initPolygon2D([point(0, 0), point(1, 1)])
    expect ValueError:
      discard initPolygon2D([point(0, 0), point(1, 1), point(2, 2)])
    expect ValueError:
      discard initPolygon2D([point(0, 0), point(1, 1), point(NaN, 2)])
    expect ValueError:
      discard initPolygon2D(shell, [hole], maxVertices = 7)
