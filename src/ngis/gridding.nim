## GDAL IDW over metric grids, with a separate nearest-reading coverage mask.
import std/[algorithm, math]
import ./[algorithms, metricgrid]
export MetricSample, GridSpec

type IdwGridOptions* = object ## GDAL interpolation and output coverage policy.
  power*: float = 2.0 ## Finite positive exponent; no smoothing is applied.
  neighbors*: int = 0 ## Zero uses all locations; positive values select the nearest k.
  coverageRadius*: float = Inf ## Positive nearest-location cutoff; Inf disables it.
  noData*: float = NaN ## Value for uncovered cells or an empty set of observations.

func finite(value: float): bool =
  classify(value) notin {fcNan, fcInf, fcNegInf}

func compareSamples(a, b: MetricSample): int =
  result = cmp(a.x, b.x)
  if result == 0:
    result = cmp(a.y, b.y)
  if result == 0:
    result = cmp(a.value, b.value)

proc locationMeans(samples: openArray[MetricSample]): seq[MetricSample] =
  var ordered: seq[MetricSample]
  for sample in samples:
    if finite(sample.x) and finite(sample.y) and finite(sample.value):
      ordered.add(sample)
  ordered.sort(compareSamples)
  var count = 0
  for sample in ordered:
    if result.len > 0 and sample.x == result[^1].x and sample.y == result[^1].y:
      count.inc()
      result[^1].value =
        result[^1].value * ((count - 1).float / count.float) + sample.value / count.float
    else:
      count = 1
      result.add(sample)

proc gridIdw*(
    samples: openArray[MetricSample],
    spec: GridSpec,
    options = IdwGridOptions(),
    maxSamples: Positive = 10_000,
    maxCells: Positive = 2_000_000,
): seq[float64] =
  ## Interpolate every cell center with GDAL at the original observation positions.
  ## Finite exact-position replicates are averaged and contribute as one location;
  ## invalid samples are ignored. Empty input returns a grid filled with noData.
  ## Coverage uses the nearest valid location, independently of contributing neighbors.
  ## Locations outside the grid extent can contribute. Zero neighbors uses all locations;
  ## positive neighbors uses GDAL's invdistnn. Both paths use a search radius spanning
  ## the full grid and all locations, the requested power and zero smoothing. A finite
  ## search radius also avoids GDAL's float-coordinate no-search optimization.
  ## Rows increase with y, starting at the southern edge in projected metric coordinates.
  ## Invalid options/geometry or exceeded input/cell budgets raise ValueError.
  ## Projection, nearby-location grouping, polygon clipping and clipped acreage are the
  ## caller's responsibility. Separate per-nutrient calls preserve independent coverage.
  spec.validateGridSpec(maxCells)
  if samples.len > maxSamples or not finite(options.power) or options.power <= 0 or
      options.neighbors < 0 or uint64(options.neighbors) > uint64(high(uint32)) or
      classify(options.coverageRadius) in {fcNan, fcNegInf} or
      options.coverageRadius <= 0 or classify(options.noData) in {fcInf, fcNegInf}:
    raise newException(ValueError, "invalid or oversized IDW grid input")
  let locations = locationMeans(samples)
  if locations.len == 0:
    result = newSeq[float64](spec.columns * spec.rows)
    for value in result.mitems:
      value = options.noData
    return
  let endX = spec.originX + spec.columns.float * spec.cellSize
  let endY = spec.originY + spec.rows.float * spec.cellSize
  var x, y, z: seq[float64]
  var radius = 0.0
  for location in locations:
    x.add(location.x)
    y.add(location.y)
    z.add(location.value)
    let dx = max(abs(location.x - spec.originX), abs(location.x - endX))
    let dy = max(abs(location.y - spec.originY), abs(location.y - endY))
    radius = max(radius, hypot(dx, dy))
  if not finite(radius):
    raise newException(ValueError, "IDW search extent exceeds numeric limits")
  let context = newIdwGrid(
    x,
    y,
    z,
    power = options.power,
    radius = radius,
    maxPoints = options.neighbors,
    noData = options.noData,
  )
  defer:
    context.close()
  result = context.grid(spec.originX, endX, spec.originY, endY, spec.columns, spec.rows)
  if options.coverageRadius != Inf:
    var present = newSeq[float64](locations.len)
    for value in present.mitems:
      value = 1
    let coverage = newNearestGrid(x, y, present, radius = options.coverageRadius)
    defer:
      coverage.close()
    let mask =
      coverage.grid(spec.originX, endX, spec.originY, endY, spec.columns, spec.rows)
    for index, covered in mask:
      if covered == 0:
        result[index] = options.noData
