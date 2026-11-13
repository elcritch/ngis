# Local mapping

`import ngis/mapping` exports standard-library-only tools for native Nim and
JavaScript. It works without GDAL headers or a shared library. These tools are
also exported by `ngis/api`, alongside the GDAL workflows.

The numeric core comes from the mapping utilities in `sam1_utils`. Module names
follow ngis conventions: `mapprojection`, `metricgrid`, `localidw`, and
`polygonqueries`. `initLocalProjection` constructs a value; projected positions
and polygon vertices use ngis's existing `Coordinate` type. `coordinatevalues`
holds that type, `Bounds`, and `AffineTransform` without native dependencies;
`coordinates` continues to export them with the GDAL CRS API.

## GPS projections

`GeoPoint(lat, lon)` contains WGS84 degrees. `initLocalProjection(origin)` creates
an approximate equirectangular projection in metres, with x east and y north.
Keep the origin fixed to preserve grid alignment as observations change.
`project` and `unproject` reject uninitialized projections. Forward geographic
inputs require finite latitude strictly between -85 and 85 degrees and longitude
in [-180, 180]. These local approximations are suitable for small field grids;
use GDAL CRS transformations when accurate reprojection or area measurement matters.

`longitudeDelta(longitude, origin)` returns the shortest signed displacement in
[-180, 180), accepting finite inputs in [-540, 540]. Longitude wrapping keeps
positions on opposite sides of the antimeridian adjacent.

`webMercator(point, originLongitude = 0)` returns normalized world coordinates,
with y increasing southward. It uses the same forward geographic limits as the
local projection. The origin longitude selects a world wrap; it must be finite
and in [-540, 540]. The x coordinate may extend outside [0, 1].
`fromWebMercator` preserves unwrapped longitudes and accepts y in [0, 1], including
image edges beyond the forward latitude limit. It rejects nonfinite input and
longitude overflow. Keep double precision until conversion to final image pixels.

## Observed grids

`MetricSample(x, y, value)` describes one observation in a common metric
projection. `gridSpecForSamples(samples, cellSize)` returns the smallest
cell-aligned bounding box containing finite measurements, or `none(GridSpec)`
when none are valid. Fixed `anchorX` and `anchorY` keep cells aligned across calls.
Missing values do not expand the bounds.

`aggregateObserved(samples, spec)` returns a sparse `ObservedGrid`. Each occupied
cell contains an arithmetic mean and observation count. Invalid/out-of-extent
observations are counted as rejected. Zero is a measurement; empty cells are
absent. Bounds include the origin and exclude the far edge. Rows increase with y,
so a projected metric grid starts at its southern edge. Deduplicate observations
by identity in the application before aggregation.

Both operations default to 10,000 input observations and 2,000,000 logical cells.
Invalid geometry or exceeded input/cell budgets raise `ValueError` before an index
is allocated. Aggregation takes O(samples) time and O(occupied cells) storage.

## Interpolation

`estimateIdw(samples, x, y, radius)` uses inverse distance squared within an
inclusive radius, requiring three neighbors by default. Insufficient support
returns `none(IdwEstimate)`. Exact coincident observations return their mean,
even below the neighbor threshold. Invalid observations are ignored. Queries
take O(samples), with a default input limit of 10,000; callers bound query counts.
Aggregate repeated positions before interpolation so pauses do not inflate support.

`estimateGridIdw(observed, radius)` estimates unobserved cell centers within the
grid extent. Each observed cell supplies one mean regardless of its observation
count. Results use `EstimatedCell`, with a separate `neighborCount`; observed cells
are never replaced. A sparse index and circular stencil restrict neighbor searches.

The default budgets are 10,000 observed cells, 100,000 candidate cells, 2,000,000
index/candidate lookups, and 2,000,000 logical grid cells. Radius must be finite,
positive, and at most 32 cell widths. Invalid input raises `ValueError`. Exceeding
the work or candidate budget sets `limitReached` and returns no estimated cells.
`workCount` reports the number of lookups performed.

## GDAL IDW grids

`ngis/gdal/gridding` supplies `gridIdw(samples, spec, options)` for native GDAL callers.
It is also exported by `ngis/api`; it is separate from the standalone JavaScript
modules. GDAL performs the interpolation using `invdist` for all locations or
`invdistnn` for the nearest locations. No new interpolation engine is involved.

```nim
import ngis/gdal/gridding

let samples = [MetricSample(x: 1, value: 0), MetricSample(x: 10, value: 100)]
let spec = GridSpec(originX: -0.5, originY: -0.5, cellSize: 1, columns: 1, rows: 1)
let surface = gridIdw(samples, spec,
  IdwGridOptions(power: 2, neighbors: 0, coverageRadius: 5))
# About 0.990099: the 10 m observation still contributes inside the coverage area.
```

`IdwGridOptions` defaults to power 2, all locations (`neighbors = 0`), no coverage
cutoff (`coverageRadius = Inf`), and `NaN` for missing output. A positive neighbor
count selects up to that many nearest distinct locations. The coverage cutoff is
an inclusive distance to the nearest valid location, applied as a separate GDAL
nearest-neighbor mask. It does not exclude distant contributors. A single valid
location is sufficient. Both interpolation paths use zero smoothing.

Each finite sample retains its actual x/y coordinates, including positions outside
the output extent. Exact-position replicates are averaged separately for each
call, then contribute once per location. Every cell center is interpolated,
including cells containing observations. Invalid samples are ignored; empty or
all-invalid input produces a full grid of `noData`. Output is flat row-major
Float64, with rows increasing with y. For map rendering, use
`RasterRowOrder.bottomUp` for projected metric grids.

Both GDAL interpolation paths use a finite search radius that includes all input
locations from every output cell. This also avoids the reduced coordinate
precision of GDAL's optimized unbounded power-2 path, without changing process-wide
GDAL settings. Results follow GDAL's handling of very near hits and equidistant
neighbors, so bit-for-bit agreement with another interpolation library is not
guaranteed. See [GDAL's gridding API](https://gdal.org/en/stable/api/gdal_alg.html).

Default budgets are 10,000 raw samples and 2,000,000 output cells. Oversized or
invalid configuration raises `ValueError`; GDAL failures raise `IOError`.
Projection, grouping nearby repeat fixes, per-nutrient validity rules, polygon
clipping, and clipped acreage remain application concerns. Keep NAD83/UTM or other
appropriate projected coordinates for analytical distances and areas.

For direct reusable native contexts, `newIdwGrid(x, y, z, ...)` wraps the GDAL
options without location aggregation or coverage masking. Its `radius` limits
contributors, and positive `maxPoints` selects nearest-neighbor IDW and requires
a positive search radius. `context.grid(...)` uses the existing grid API and
resource ownership rules.

## Prepared polygon queries

`initPolygon2D(shell, holes = [])` prepares immutable rings for repeated point
queries. Open or closed rings and either winding direction are accepted. `locate`
returns `PointInside`, `PointOutside`, or `PointOnBoundary`. `contains` accepts
strict interior points; `covers` also accepts shell/hole edges, excluding hole interiors.

```nim
import ngis/mapping

let boundary = initPolygon2D([
  Coordinate(x: 0, y: 0), Coordinate(x: 100, y: 0),
  Coordinate(x: 100, y: 100), Coordinate(x: 0, y: 100),
])
doAssert boundary.covers(Coordinate(x: 50, y: 100))
doAssert not boundary.contains(Coordinate(x: 50, y: 100))
```

Coordinates must share a continuous coordinate system; project or unwrap
geographic rings first. Vertices must be finite and within ±1e12, and the default
total vertex budget is 10,000. Rings must be simple and nonintersecting, with holes
inside their shell. Preparation checks coordinate limits, nonzero area, and budgets;
it does not fully validate or repair topology. Query each component of a multipolygon
separately and combine the results in the application.

`locate(point, tolerance = 0)` accepts a finite nonnegative edge tolerance in
coordinate units. Invalid points and uninitialized polygons are outside. Rings
with more than 32 vertices use an edge y interval index; smaller rings scan cached
edges. Preparation costs O(n log n) for indexed rings, storage is O(n), and queries
can still visit every edge in the worst case. Prepare once per polygon and reuse
across queries. Read-only queries do not mutate the polygon or retain caller inputs.

## Tests

```sh
atlas-run tests
atlas-run tests --backend:js mapping mapprojection metricgrid localidw polygonqueries polygonindex
```

The test configuration defines `nodejs` for JavaScript so failed `unittest`
assertions produce a failing process exit code. The JavaScript selection exercises
the standalone modules; GDAL wrappers require the native backend.
