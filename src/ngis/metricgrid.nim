## Sparse observed-cell aggregation in caller-supplied metric coordinates.
## This module has no geographic projection, reading identity or rendering policy.
## Callers must deduplicate observations before aggregation. Absent cells are missing,
## never implicit zeroes. Works with both the native and JavaScript Nim backends.
import std/[math, options, tables]

type
  MetricSample* = object ## One finite measurement in a common metric projection.
    x*, y*, value*: float

  GridSpec* = object ## Half-open rectangular extent with a fixed cell size.
    originX*, originY*, cellSize*: float
    columns*, rows*: int

  ObservedCell* = object ## Arithmetic mean and count of valid observations in one cell.
    column*, row*, count*: int
    value*: float

  ObservedGrid* = object ## Only occupied cells, ordered by first observation.
    spec*: GridSpec
    cells*: seq[ObservedCell]
    acceptedCount*, rejectedCount*: int

func finite(value: float): bool =
  classify(value) notin {fcNan, fcInf, fcNegInf}

proc validateGridSpec*(spec: GridSpec, maxCells: Positive = 2_000_000) =
  ## Reject invalid geometry or a logical cell count above the caller's budget.
  if not finite(spec.originX) or not finite(spec.originY) or not finite(spec.cellSize) or
      spec.cellSize <= 0 or spec.columns <= 0 or spec.rows <= 0 or
      spec.columns > maxCells div spec.rows:
    raise newException(ValueError, "Invalid or oversized metric grid")
  let endX = spec.originX + spec.columns.float * spec.cellSize
  let endY = spec.originY + spec.rows.float * spec.cellSize
  if not finite(endX) or not finite(endY) or endX <= spec.originX or endY <= spec.originY:
    raise newException(ValueError, "Metric grid extent is not finite")

proc gridSpecForSamples*(
    samples: openArray[MetricSample],
    cellSize: float,
    anchorX = 0.0,
    anchorY = 0.0,
    maxSamples: Positive = 10_000,
    maxCells: Positive = 2_000_000,
): Option[GridSpec] =
  ## Find the smallest cell-aligned bounding box containing finite measurements.
  ## Keep anchors fixed between calls to preserve cell alignment as datasets change.
  ## A point on a grid edge belongs to the cell starting at that edge. Missing values
  ## do not expand the bounds. Empty/all-invalid input returns none. Invalid geometry
  ## or budgets raise ValueError, including extents too large for safe indexing.
  if not finite(cellSize) or cellSize <= 0 or not finite(anchorX) or not finite(anchorY) or
      samples.len > maxSamples:
    raise newException(ValueError, "Invalid or oversized metric grid input")
  var minColumn = Inf
  var minRow = Inf
  var maxColumn = NegInf
  var maxRow = NegInf
  for sample in samples:
    if finite(sample.x) and finite(sample.y) and finite(sample.value):
      let column = floor((sample.x - anchorX) / cellSize)
      let row = floor((sample.y - anchorY) / cellSize)
      if not finite(column) or not finite(row):
        raise newException(ValueError, "Metric grid coordinates exceed numeric limits")
      minColumn = min(minColumn, column)
      minRow = min(minRow, row)
      maxColumn = max(maxColumn, column)
      maxRow = max(maxRow, row)
  if minColumn == Inf:
    return none(GridSpec)
  let columnSpan = maxColumn - minColumn
  let rowSpan = maxRow - minRow
  if not finite(columnSpan) or not finite(rowSpan) or columnSpan >= maxCells.float or
      rowSpan >= maxCells.float:
    raise newException(ValueError, "Metric grid bounding box exceeds the cell budget")
  let spec = GridSpec(
    originX: anchorX + minColumn * cellSize,
    originY: anchorY + minRow * cellSize,
    cellSize: cellSize,
    columns: int(columnSpan) + 1,
    rows: int(rowSpan) + 1,
  )
  spec.validateGridSpec(maxCells)
  some(spec)

proc aggregateObserved*(
    samples: openArray[MetricSample],
    spec: GridSpec,
    maxSamples: Positive = 10_000,
    maxCells: Positive = 2_000_000,
): ObservedGrid =
  ## Aggregate in O(samples) time and O(occupied cells) memory, without a dense raster.
  ## Invalid/out-of-extent samples are rejected and counted. Oversized input or invalid
  ## configuration raises ValueError before allocating the cell index. Bounds are
  ## inclusive at the origin and exclusive at the outer edge, including negative origins.
  spec.validateGridSpec(maxCells)
  if samples.len > maxSamples:
    raise newException(ValueError, "Too many metric samples")
  result.spec = spec
  var indices = initTable[(int, int), int]()
  for sample in samples:
    var accepted = false
    if finite(sample.x) and finite(sample.y) and finite(sample.value):
      let col = (sample.x - spec.originX) / spec.cellSize
      let row = (sample.y - spec.originY) / spec.cellSize
      if col >= 0 and col < spec.columns.float and row >= 0 and row < spec.rows.float:
        let key = (int(floor(col)), int(floor(row)))
        if indices.hasKey(key):
          let idx = indices[key]
          let count = result.cells[idx].count + 1
          let previous = result.cells[idx].value
          # Divide before adding to avoid overflowing a finite arithmetic mean.
          result.cells[idx].value =
            previous * ((count - 1).float / count.float) + sample.value / count.float
          result.cells[idx].count = count
        else:
          indices[key] = result.cells.len
          result.cells.add(
            ObservedCell(column: key[0], row: key[1], count: 1, value: sample.value)
          )
        accepted = true
        result.acceptedCount.inc()
    if not accepted:
      result.rejectedCount.inc()
