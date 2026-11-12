import std/[unittest, math]
import ngis/coordinates

suite "coordinate values":
  test "bounds include touching edges":
    let b = initBounds(0, 1, 4, 5)
    check b.contains(Coordinate(x: 0, y: 5))
    check not b.contains(Coordinate(x: -1, y: 5))
    check b.intersects(initBounds(4, 5, 6, 7))
    expect ValueError:
      discard initBounds(2, 0, 1, 1)

  test "affine round trip and singular transform":
    let values = [10.0, 2.0, 0.5, 20.0, -0.25, -3.0]
    let t = toAffineTransform(values)
    check t.toArray == values
    let pixel = Coordinate(x: 4, y: 7)
    let roundTrip = t.worldToPixel(t.pixelToWorld(pixel))
    check abs(roundTrip.x - pixel.x) < 1e-10
    check abs(roundTrip.y - pixel.y) < 1e-10
    expect ValueError:
      discard toAffineTransform([0.0, 1, 2, 0, 2, 4]).worldToPixel(pixel)
    expect ValueError:
      discard toAffineTransform([Inf, 1.0, 0, 0, 0, 1]).worldToPixel(pixel)

  test "batch transformation retains its own CRS resources":
    let source = newSpatialReference(4326)
    let target = newSpatialReference(3857)
    source.axisOrder = AxisOrder.traditionalGis
    target.axisOrder = AxisOrder.traditionalGis
    let t = newCoordinateTransform(source, target)
    source.close()
    target.close()
    let points = [Coordinate(x: 0, y: 0), Coordinate(x: 1, y: 1)]
    let transformed = t.transform(points)
    check transformed.len == 2
    check abs(transformed[1].x - 111319.490793) < 0.1
    check points[1].x == 1
    check t.transform([]).len == 0
    t.close()
    expect ValueError:
      discard t.transform(points)
