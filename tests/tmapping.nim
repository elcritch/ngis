import std/[math, options, unittest]
import ngis/mapping

suite "Standalone local mapping":
  test "GPS observations become sparse cells and a separate estimated surface":
    let projection = initLocalProjection(GeoPoint(lat: 42, lon: -93))
    let boundary = initPolygon2D(
      [
        Coordinate(x: 0, y: 0),
        Coordinate(x: 12, y: 0),
        Coordinate(x: 12, y: 8),
        Coordinate(x: 0, y: 8),
      ]
    )
    var samples: seq[MetricSample]
    for sample in [
      MetricSample(x: 2, y: 6, value: 0),
      MetricSample(x: 10, y: 6, value: 100),
      MetricSample(x: 6, y: 2, value: 50),
    ]:
      let gps = projection.unproject(Coordinate(x: sample.x, y: sample.y))
      let position = projection.project(gps)
      if boundary.covers(position):
        samples.add(MetricSample(x: position.x, y: position.y, value: sample.value))
    let spec = gridSpecForSamples(samples, cellSize = 4).get()
    let observed = aggregateObserved(samples, spec)
    let estimated = estimateGridIdw(observed, radius = 8)
    check observed.acceptedCount == 3
    check observed.rejectedCount == 0
    check observed.cells.len == 3
    check spec.columns == 3
    check spec.rows == 2
    check not estimated.limitReached
    check estimated.cells.len == 1
    check estimated.cells[0].column == 1
    check estimated.cells[0].row == 1
    check abs(estimated.cells[0].value - 50) < 1e-10
    check estimated.cells[0].neighborCount == 3

  test "coordinate values and affine maps also work without GDAL":
    let bounds = initBounds(10, 20, 14, 24)
    let transform = toAffineTransform([10.0, 2, 0, 24, 0, -2])
    let point = transform.pixelToWorld(Coordinate(x: 0.5, y: 0.5))
    check point == Coordinate(x: 11, y: 23)
    check bounds.contains(point)
    check bounds.intersects(initBounds(14, 24, 15, 25))
    check transform.worldToPixel(point) == Coordinate(x: 0.5, y: 0.5)
    expect ValueError:
      discard toAffineTransform([0.0, 1, 2, 0, 2, 4]).worldToPixel(point)
    expect ValueError:
      discard toAffineTransform([Inf, 1.0, 0, 0, 0, 1]).worldToPixel(point)
