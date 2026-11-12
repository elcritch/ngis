import ngis/[localidw, metricgrid]

import std/[math, options, unittest]

suite "Bounded local IDW (native and JS)":
  test "known inverse-square weights and inclusive radius":
    let estimate = estimateIdw(
      [
        MetricSample(x: 1, value: 0),
        MetricSample(x: 2, value: 100),
        MetricSample(x: 20, value: -1000),
      ],
      0,
      0,
      radius = 2,
      minNeighbors = 2,
    )
    check estimate.isSome
    check abs(estimate.get().value - 20) < 1e-10
    check estimate.get().neighborCount == 2

  test "insufficient support is missing and zero remains a valid estimate":
    check estimateIdw([], 0, 0, 10).isNone
    check estimateIdw([MetricSample(x: 1, value: 0)], 0, 0, 10).isNone
    let estimate = estimateIdw(
      [MetricSample(x: -1, value: -10), MetricSample(x: 1, value: 10)],
      0,
      0,
      10,
      minNeighbors = 2,
    )
    check estimate.isSome
    check estimate.get().value == 0

  test "coincident hits average only exact values and ignore missing observations":
    let estimate = estimateIdw(
      [
        MetricSample(value: 0),
        MetricSample(value: 20),
        MetricSample(value: NaN),
        MetricSample(x: NaN, value: 1),
        MetricSample(x: 1, value: 500),
      ],
      0,
      0,
      10,
    )
    check estimate.get().value == 10
    check estimate.get().neighborCount == 2

  test "tiny distances and large values retain finite estimates":
    let estimate = estimateIdw(
      [MetricSample(x: 1e-150, value: 1e308), MetricSample(x: -1e-150, value: 1e308)],
      0,
      0,
      1,
      minNeighbors = 2,
    )
    check estimate.get().value == 1e308

  test "bad queries and budgets raise rather than extrapolate":
    for radius in [0.0, -1.0, NaN, Inf]:
      expect ValueError:
        discard estimateIdw([], 0, 0, radius)
    expect ValueError:
      discard estimateIdw([], NaN, 0, 10)
    expect ValueError:
      discard estimateIdw([MetricSample(), MetricSample()], 0, 0, 10, maxSamples = 1)

  test "underflowed far weights cannot poison a later nearest sample":
    let estimate = estimateIdw(
      [MetricSample(x: 1e150, value: 500), MetricSample(x: 1e-150, value: 10)],
      0,
      0,
      1e151,
      minNeighbors = 2,
    )
    check estimate.get().value == 10

suite "Sparse IDW grid (native and JS)":
  let spec = GridSpec(cellSize: 4, columns: 9, rows: 9)
  let samples = [
    MetricSample(x: 2, y: 6, value: 0),
    MetricSample(x: 10, y: 6, value: 100),
    MetricSample(x: 6, y: 2, value: 50),
  ]

  test "grid estimates match the numeric reference and never replace observations":
    let grid = aggregateObserved(samples, spec)
    let surface = estimateGridIdw(grid, radius = 8)
    check not surface.limitReached
    var found = false
    for cell in surface.cells:
      for observed in grid.cells:
        check (cell.column, cell.row) != (observed.column, observed.row)
      let reference = estimateIdw(
        samples, (cell.column.float + 0.5) * 4, (cell.row.float + 0.5) * 4, radius = 8
      )
      check reference.isSome
      check abs(cell.value - reference.get().value) < 1e-10
      if cell.column == 1 and cell.row == 1:
        found = true
        check abs(cell.value - 50) < 1e-10
        check cell.neighborCount == 3
    check found

  test "support requires distinct observed cells and distant gaps remain absent":
    let repeated = aggregateObserved(
      [
        MetricSample(x: 2, y: 2, value: 0),
        MetricSample(x: 2, y: 2, value: 10),
        MetricSample(x: 2, y: 2, value: 20),
      ],
      spec,
    )
    check estimateGridIdw(repeated, 8).cells.len == 0
    let surface = estimateGridIdw(aggregateObserved(samples, spec), 8)
    for cell in surface.cells:
      check cell.column < 5
      check cell.row < 4
      check cell.column >= 0 and cell.row >= 0

  test "work and candidate limits return no partially estimated surface":
    let grid = aggregateObserved(samples, spec)
    for surface in [
      estimateGridIdw(grid, 8, maxWork = 100),
      estimateGridIdw(grid, 8, maxCandidates = 1),
    ]:
      check surface.limitReached
      check surface.cells.len == 0
    check estimateGridIdw(grid, 8, maxWork = 1).workCount == 1

  test "invalid observed grids and excessive search radii fail explicitly":
    let grid = aggregateObserved(samples, spec)
    for radius in [0.0, NaN, Inf, 4.0 * 33]:
      expect ValueError:
        discard estimateGridIdw(grid, radius)
    var duplicate = grid
    duplicate.cells.add(grid.cells[0])
    expect ValueError:
      discard estimateGridIdw(duplicate, 8)
    expect ValueError:
      discard estimateGridIdw(grid, 8, maxObserved = 1)
