import ngis/metricgrid

import std/[options, unittest]

suite "Sparse metric observed grid (native and JS)":
  let spec = GridSpec(originX: -10, originY: -10, cellSize: 10, columns: 3, rows: 3)

  test "fit the displayed measurements to a snapped bounding box, excluding missing data":
    let samples = @[
      MetricSample(x: -1, y: -10, value: 0),
      MetricSample(x: 10, y: 0, value: 20),
      MetricSample(x: 10_000, y: 10_000, value: NaN),
    ]
    let bounds = gridSpecForSamples(samples, 10).get()
    check bounds.originX == -10
    check bounds.originY == -10
    check bounds.columns == 3
    check bounds.rows == 2
    let grid = aggregateObserved(samples, bounds)
    check grid.acceptedCount == 2
    check grid.cells.len == 2

  test "single-cell bounds and fixed-anchor alignment survive rolling datasets":
    let first = gridSpecForSamples(
        [MetricSample(x: 1, y: 1), MetricSample(x: 11, y: 1)], 10
      )
      .get()
    let rolled = gridSpecForSamples([MetricSample(x: 11, y: 1)], 10).get()
    check first.originX + first.cellSize == rolled.originX
    check rolled.columns == 1
    check rolled.rows == 1
    check gridSpecForSamples([], 10).isNone
    check gridSpecForSamples([MetricSample(value: NaN)], 10).isNone

  test "bounding-box fitting enforces numeric and logical-cell budgets":
    expect ValueError:
      discard
        gridSpecForSamples([MetricSample(), MetricSample(x: 100)], 10, maxCells = 10)
    expect ValueError:
      discard gridSpecForSamples([MetricSample(x: 1e308)], 1e-308)
    expect ValueError:
      discard gridSpecForSamples([], 0)
    expect ValueError:
      discard gridSpecForSamples([MetricSample(), MetricSample()], 10, maxSamples = 1)

  test "mean and count retain zero and leave unsampled cells absent":
    let grid = aggregateObserved(
      [
        MetricSample(x: -9, y: -1, value: 0),
        MetricSample(x: -1, y: -9, value: 20),
        MetricSample(x: 10, y: 10, value: -4),
      ],
      spec,
    )
    check grid.cells.len == 2
    check grid.cells[0] == ObservedCell(column: 0, row: 0, count: 2, value: 10)
    check grid.cells[1] == ObservedCell(column: 2, row: 2, count: 1, value: -4)
    check grid.acceptedCount == 3
    check grid.rejectedCount == 0

  test "negative coordinates and half-open cell and extent boundaries":
    let grid = aggregateObserved(
      [
        MetricSample(x: -10, y: -10, value: 1),
        MetricSample(x: -0.00001, y: -0.00001, value: 2),
        MetricSample(x: 0, y: 0, value: 3),
        MetricSample(x: 20, y: 0, value: 4),
        MetricSample(x: 0, y: 20, value: 5),
        MetricSample(x: -10.00001, y: 0, value: 6),
      ],
      spec,
    )
    check grid.cells.len == 2
    check grid.cells[0].count == 2
    check grid.cells[1].column == 1
    check grid.cells[1].row == 1
    check grid.rejectedCount == 3

  test "missing values and invalid positions never become observations":
    let grid = aggregateObserved(
      [
        MetricSample(x: 0, y: 0, value: NaN),
        MetricSample(x: 0, y: 0, value: Inf),
        MetricSample(x: 0, y: 0, value: NegInf),
        MetricSample(x: NaN, y: 0, value: 1),
        MetricSample(x: 0, y: Inf, value: 1),
        MetricSample(x: 1e300, y: 0, value: 1),
        MetricSample(x: 0, y: 0, value: 0),
      ],
      spec,
    )
    check grid.cells.len == 1
    check grid.cells[0].value == 0
    check grid.cells[0].count == 1
    check grid.rejectedCount == 6

  test "empty input creates no coverage":
    check aggregateObserved([], spec).cells.len == 0

  test "finite means do not overflow for large same or opposite signs":
    for value in [1e308, -1e308]:
      let grid = aggregateObserved(
        [MetricSample(value: value), MetricSample(value: value)], spec
      )
      check grid.cells[0].value == value
    let grid =
      aggregateObserved([MetricSample(value: 1e308), MetricSample(value: -1e308)], spec)
    check grid.cells[0].value == 0

  test "invalid configurations and explicit resource limits fail before allocation":
    for cellSize in [0.0, -1.0, NaN, Inf]:
      expect ValueError:
        discard aggregateObserved([], GridSpec(cellSize: cellSize, columns: 1, rows: 1))
    expect ValueError:
      discard aggregateObserved([], GridSpec())
    expect ValueError:
      discard aggregateObserved([], spec, maxCells = 8)
    expect ValueError:
      discard aggregateObserved([MetricSample(), MetricSample()], spec, maxSamples = 1)
    expect ValueError:
      discard aggregateObserved(
        [], GridSpec(originX: 1e308, cellSize: 1e308, columns: 2, rows: 1)
      )
