## Radius-limited inverse-distance-squared estimates, independent of rendering or identity.
## Aggregate repeated positions/cells before calling to avoid weighting pauses as coverage.
import std/[math, options, sets, tables]
import ./metricgrid

type IdwEstimate* = object ## An estimate, kept separate from an observed grid cell.
  value*: float
  neighborCount*: int

type
  EstimatedCell* = object ## An unobserved cell estimated from distinct observed cells.
    column*, row*, neighborCount*: int
    value*: float

  EstimatedGrid* = object ## Bounded estimates, separate from observations.
    cells*: seq[EstimatedCell]
    limitReached*: bool ## A work/output budget was exceeded; cells is empty.
    workCount*: int ## Candidate/index lookups, for bounded computation and diagnostics.

func finite(value: float): bool =
  classify(value) notin {fcNan, fcInf, fcNegInf}

proc estimateIdw*(
    samples: openArray[MetricSample],
    x, y, radius: float,
    minNeighbors: Positive = 3,
    maxSamples: Positive = 10_000,
): Option[IdwEstimate] =
  ## Estimate one location in O(samples), with constant auxiliary memory.
  ## Radius is inclusive and uses the samples' coordinate units. Missing/invalid samples
  ## are ignored; insufficient support returns none, never zero. Exact hits return the
  ## mean of coincident observations, even below minNeighbors. Invalid query/radius or
  ## exceeding maxSamples raises ValueError. Callers must bound the number of queries.
  if not finite(x) or not finite(y) or not finite(radius) or radius <= 0 or
      samples.len > maxSamples:
    raise newException(ValueError, "Invalid or oversized local IDW query")
  var nearest = Inf
  var count, exactCount: int
  var exactMean = 0.0
  for sample in samples:
    if finite(sample.x) and finite(sample.y) and finite(sample.value):
      let distance = hypot(sample.x - x, sample.y - y)
      if distance <= radius:
        count.inc()
        nearest = min(nearest, distance)
        if distance == 0:
          exactCount.inc()
          exactMean =
            exactMean * ((exactCount - 1).float / exactCount.float) +
            sample.value / exactCount.float
  if exactCount > 0:
    return some(IdwEstimate(value: exactMean, neighborCount: exactCount))
  if count < minNeighbors:
    return none(IdwEstimate)
  var totalWeight, mean: float
  for sample in samples:
    if finite(sample.x) and finite(sample.y) and finite(sample.value):
      let distance = hypot(sample.x - x, sample.y - y)
      if distance <= radius:
        # Scale by the nearest distance so weights remain in [0, 1], including
        # queries extremely close to a sample where 1 / distance^2 would overflow.
        let weight = (nearest / distance) * (nearest / distance)
        if weight > 0:
          let updatedWeight = totalWeight + weight
          mean =
            mean * (totalWeight / updatedWeight) +
            sample.value * (weight / updatedWeight)
          totalWeight = updatedWeight
  some(IdwEstimate(value: mean, neighborCount: count))

proc estimateGridIdw*(
    grid: ObservedGrid,
    radius: float,
    minNeighbors: Positive = 3,
    maxObserved: Positive = 10_000,
    maxCandidates: Positive = 100_000,
    maxWork: Positive = 2_000_000,
    maxCells: Positive = 2_000_000,
): EstimatedGrid =
  ## Estimate only unobserved cell centers inside grid.spec using nearby observed means.
  ## Counts do not weight the means: three readings in one cell provide one neighbor.
  ## A sparse index and radius stencil avoid scanning all observations at every query.
  ## Radius must be finite, positive and at most 32 cell widths. Invalid geometry/cells
  ## raise ValueError. Exceeding candidate/work budgets returns no cells and limitReached,
  ## rather than a misleading partially computed surface. Works on native Nim and JS.
  grid.spec.validateGridSpec(maxCells)
  let radiusCells = radius / grid.spec.cellSize
  if not finite(radius) or radius <= 0 or not finite(radiusCells) or radiusCells > 32 or
      grid.cells.len > maxObserved:
    raise newException(ValueError, "Invalid or oversized IDW grid input")
  var observed = initTable[(int, int), float]()
  for cell in grid.cells:
    let key = (cell.column, cell.row)
    if cell.column < 0 or cell.column >= grid.spec.columns or cell.row < 0 or
        cell.row >= grid.spec.rows or cell.count <= 0 or not finite(cell.value) or
        observed.hasKey(key):
      raise newException(ValueError, "Invalid or duplicate observed cell")
    observed[key] = cell.value
  if observed.len < minNeighbors:
    return
  var offsets: seq[(int, int)]
  let reach = int(ceil(radiusCells))
  for row in -reach .. reach:
    for column in -reach .. reach:
      if hypot(column.float, row.float) <= radiusCells:
        offsets.add((column, row))
  var candidates: seq[(int, int)]
  var seen = initHashSet[(int, int)]()
  for cell in grid.cells:
    for offset in offsets:
      if result.workCount >= maxWork:
        result.limitReached = true
        return
      result.workCount.inc()
      let key = (cell.column + offset[0], cell.row + offset[1])
      if key[0] >= 0 and key[0] < grid.spec.columns and key[1] >= 0 and
          key[1] < grid.spec.rows and not observed.hasKey(key) and key notin seen:
        if candidates.len >= maxCandidates:
          result.limitReached = true
          return
        seen.incl(key)
        candidates.add(key)
  var neighbors: seq[MetricSample]
  for candidate in candidates:
    neighbors.setLen(0)
    for offset in offsets:
      if result.workCount >= maxWork:
        result.cells.setLen(0)
        result.limitReached = true
        return
      result.workCount.inc()
      let key = (candidate[0] + offset[0], candidate[1] + offset[1])
      if observed.hasKey(key):
        neighbors.add(
          MetricSample(
            x: offset[0].float * grid.spec.cellSize,
            y: offset[1].float * grid.spec.cellSize,
            value: observed[key],
          )
        )
    let estimate = estimateIdw(
      neighbors, 0, 0, radius, minNeighbors = minNeighbors, maxSamples = offsets.len
    )
    if estimate.isSome:
      result.cells.add(
        EstimatedCell(
          column: candidate[0],
          row: candidate[1],
          value: estimate.get().value,
          neighborCount: estimate.get().neighborCount,
        )
      )
