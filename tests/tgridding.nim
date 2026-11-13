import std/[algorithm, math, random, unittest]
import ngis/[algorithms, gridding]

proc scanIdw(
    samples: openArray[MetricSample], x, y, power: float, neighbors: int
): float =
  # Independent reference for finite, distinct samples, using direct inverse powers.
  var distances: seq[tuple[distance, value: float]]
  for sample in samples:
    let distance = hypot(sample.x - x, sample.y - y)
    if distance < 1e-12:
      return sample.value
    distances.add((distance, sample.value))
  distances.sort(
    proc(a, b: tuple[distance, value: float]): int =
      cmp(a.distance, b.distance)
  )
  let count =
    if neighbors == 0:
      distances.len
    else:
      min(neighbors, distances.len)
  var numerator, denominator: float
  for index in 0 ..< count:
    let weight = 1 / pow(distances[index].distance, power)
    numerator += weight * distances[index].value
    denominator += weight
  numerator / denominator

suite "GDAL inverse-distance gridding":
  let originCell =
    GridSpec(originX: -0.5, originY: -0.5, cellSize: 1, columns: 1, rows: 1)

  test "coverage masks output without excluding distant contributors":
    let samples = [MetricSample(x: 1, value: 0), MetricSample(x: 10, value: 100)]
    let grid = gridIdw(samples, originCell, IdwGridOptions(coverageRadius: 5))
    check abs(grid[0] - 100.0 / 101) < 1e-6
    let nearest =
      gridIdw(samples, originCell, IdwGridOptions(neighbors: 1, coverageRadius: 5))
    check nearest == @[0.0]
    let distant =
      GridSpec(originX: 99.5, originY: -0.5, cellSize: 1, columns: 1, rows: 1)
    check classify(gridIdw(samples, distant, IdwGridOptions(coverageRadius: 30))[0]) ==
      fcNan

  test "the thirteenth location affects all-location IDW but not nearest twelve":
    var samples: seq[MetricSample]
    for index in 1 .. 13:
      samples.add(MetricSample(x: index.float, value: (if index == 13: 100 else: 5)))
    let allLocations = gridIdw(samples, originCell, IdwGridOptions(coverageRadius: 5))
    check abs(allLocations[0] - scanIdw(samples, 0, 0, 2, 0)) < 1e-6
    check allLocations[0] > 5
    check gridIdw(samples, originCell, IdwGridOptions(neighbors: 12)) == @[5.0]

  test "replicate means, exact hits and configurable powers match report rules":
    let samples = [
      MetricSample(value: 0),
      MetricSample(value: 20),
      MetricSample(x: 3, value: 30),
      MetricSample(x: 4, value: NaN),
    ]
    check gridIdw(samples, originCell) == @[10.0]
    let query = GridSpec(originX: 0.5, originY: -0.5, cellSize: 1, columns: 1, rows: 1)
    for power in [1.0, 1.5, 2.0, 3.0]:
      let expected = (10 + 30 / pow(2.0, power)) / (1 + 1 / pow(2.0, power))
      check abs(gridIdw(samples, query, IdwGridOptions(power: power))[0] - expected) <
        1e-6
      check abs(
        gridIdw(samples.reversed(), query, IdwGridOptions(power: power, neighbors: 12))[
          0
        ] - expected
      ) < 1e-6

  test "coverage is inclusive and one valid location is sufficient":
    let samples = [MetricSample(value: 7)]
    let query = GridSpec(originX: 29.5, originY: -0.5, cellSize: 1, columns: 1, rows: 1)
    for neighbors in [0, 8, 12, 24, 48]:
      check gridIdw(
        samples, query, IdwGridOptions(neighbors: neighbors, coverageRadius: 30)
      ) == @[7.0]
    check classify(gridIdw(samples, query, IdwGridOptions(coverageRadius: 29.99))[0]) ==
      fcNan

  test "all cells are interpolated at original positions and rows increase with y":
    let spec = GridSpec(cellSize: 1, columns: 2, rows: 2)
    let samples =
      [MetricSample(x: 0.2, y: 0.1, value: 0), MetricSample(x: 0.8, y: 0.9, value: 100)]
    let grid = gridIdw(samples, spec)
    check grid.len == 4
    for row in 0 ..< spec.rows:
      for column in 0 ..< spec.columns:
        let expected = scanIdw(samples, column.float + 0.5, row.float + 0.5, 2, 0)
        check abs(grid[row * spec.columns + column] - expected) < 1e-4

  test "GDAL nearest searches match independent scans over projected positions":
    var rng = initRand(20261113)
    var samples: seq[MetricSample]
    for index in 0 ..< 65:
      samples.add(
        MetricSample(
          x: 1_596_080 + rng.rand(-50.0 .. 80.0),
          y: 1_105_830 + rng.rand(-30.0 .. 90.0),
          value: rng.rand(-10.0 .. 200.0),
        )
      )
    let spec =
      GridSpec(originX: 1_596_080, originY: 1_105_830, cellSize: 5, columns: 7, rows: 6)
    for power in [1.0, 2.0, 3.0]:
      for neighbors in [0, 8, 12, 24, 48]:
        let grid =
          gridIdw(samples, spec, IdwGridOptions(power: power, neighbors: neighbors))
        for row in 0 ..< spec.rows:
          for column in 0 ..< spec.columns:
            let expected = scanIdw(
              samples,
              spec.originX + (column.float + 0.5) * spec.cellSize,
              spec.originY + (row.float + 0.5) * spec.cellSize,
              power,
              neighbors,
            )
            check abs(grid[row * spec.columns + column] - expected) < 1e-4

  test "missing measurements never become zero or create coverage":
    for samples in [
      newSeq[MetricSample](),
      @[
        MetricSample(value: NaN),
        MetricSample(x: Inf, value: 1),
        MetricSample(value: NegInf),
      ],
    ]:
      check classify(gridIdw(samples, originCell)[0]) == fcNan
      check gridIdw(samples, originCell, IdwGridOptions(noData: -9999)) == @[-9999.0]
    let samples = [MetricSample(x: NaN, value: 10), MetricSample(value: 0)]
    check gridIdw(samples, originCell) == @[0.0]

  test "input budgets and invalid settings fail explicitly":
    for options in [
      IdwGridOptions(power: 0),
      IdwGridOptions(power: NaN),
      IdwGridOptions(power: Inf),
      IdwGridOptions(neighbors: -1),
      IdwGridOptions(coverageRadius: 0),
      IdwGridOptions(coverageRadius: NaN),
      IdwGridOptions(coverageRadius: NegInf),
      IdwGridOptions(noData: Inf),
    ]:
      expect ValueError:
        discard gridIdw([], originCell, options)
    expect ValueError:
      discard gridIdw([], GridSpec())
    expect ValueError:
      discard gridIdw([MetricSample(), MetricSample()], originCell, maxSamples = 1)
    expect ValueError:
      discard gridIdw([], GridSpec(cellSize: 1, columns: 2, rows: 2), maxCells = 3)

  test "typed native contexts retain points and distinguish search from coverage":
    var x = @[1.0, 10.0]
    let context = newIdwGrid(x, [0.0, 0.0], [0.0, 100.0])
    x[0] = 1000
    check abs(context.grid(-0.5, 0.5, -0.5, 0.5, 1, 1)[0] - 100.0 / 101) < 1e-6
    context.close()
    context.close()
    expect ValueError:
      discard context.grid(-0.5, 0.5, -0.5, 0.5, 1, 1)
    let limited = newIdwGrid([1.0, 10.0], [0.0, 0.0], [0.0, 100.0], radius = 5)
    check limited.grid(-0.5, 0.5, -0.5, 0.5, 1, 1) == @[0.0]
    for power in [0.0, NaN, Inf]:
      expect ValueError:
        discard newIdwGrid([1.0], [0.0], [1.0], power = power)
    expect ValueError:
      discard newIdwGrid([1.0], [0.0], [1.0], maxPoints = 12)
    expect ValueError:
      discard newIdwGrid([1.0], [0.0], [NaN])
    expect ValueError:
      discard newIdwGrid([1.0], [], [1.0])
