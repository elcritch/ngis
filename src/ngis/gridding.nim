## Shared interpolation policy and deterministic location means.
import std/[algorithm, math]
import ./metricgrid
export metricgrid

type IdwGridOptions* = object ## Interpolation and output coverage policy.
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

proc locationMeans*(
    samples: openArray[MetricSample], maxSamples: Positive = 10_000
): seq[MetricSample] =
  ## Average finite samples at exact positions; each returned location contributes once.
  ## Sort positions and values for input-order-independent results. Invalid observations
  ## are ignored; exceeding the raw input budget raises ValueError.
  if samples.len > maxSamples:
    raise newException(ValueError, "Too many location observations")
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
