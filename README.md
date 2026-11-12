# ngis

Work with GDAL rasters, vector data, multidimensional arrays, and coordinate systems from Nim. Use typed grids, feature values, geometry operations, iterators, and processing options with automatic resource cleanup. The complete GDAL C API is available alongside the high-level API. Standalone mapping tools also support GPS projection, sparse observations, interpolation, and polygon queries without GDAL.

## Install

Install Nim 2.2 or later. For the GDAL modules, also install the GDAL 3.13.3 development headers and shared library. Add ngis to your project's `.nimble` file:

```nim
requires "https://github.com/elcritch/ngis"
```

Run `atlas install` in your project. By default ngis tries to load GDAL at import time using platform library names and, on macOS, Homebrew locations. Use `-d:gdalLib=/path/to/libgdal` when compiling to select a library (`gdalDynlib` is also accepted and takes precedence). The currently tested platforms are macOS arm64 and 64-bit Linux; Windows needs native ABI validation.

For applications that can operate without GDAL, compile with `-d:gdalRuntime` (or request ngis's Atlas `runtime` feature) and load it explicitly before using GDAL or starting workers that use it:

```nim
import ngis/api

try:
  loadGdal() # Or loadGdal(path = "/path/to/libgdal")
  echo gdalLibraryPath()
except GdalLoadError as error:
  echo "GDAL unavailable: ", error.msg
```

`isGdalLoaded()` reports whether loading succeeded. Failed loads can be retried; a successful load remains in use for the process lifetime. Optional symbols missing from the library remain nil, so check them before calling. Explicit loading controls runtime availability; building still requires GDAL development headers. See [binding generation and checks](docs/bindings.md) for details.

## Raster quick start

```nim
import ngis/api

let image = createRaster(float32, 2, 2)
var pixels = initRasterGrid(2, 2, @[1'f32, 2, 3, 4])
pixels[1, 0] = 12.5
image.band().write(pixels)
echo readGrid[float32](image.band())[1, 0]
for window in image.band().tiles(256, 256):
  echo readGrid[float32](image.band(), window).len
```

## Map images

Compute reprojection and clipping once, then reuse the pixel lookup for each layer:

```nim
import ngis/api

let source = initRasterLayout(2, 2, initBounds(10, 40, 12, 42), "EPSG:4326")
let target = initRasterLayout(512, 512, initBounds(9.9, 39.9, 12.1, 42.1), "EPSG:4326")
let lookup = initRasterLookup(source, target)
let colors = [
  Rgba8(r: 220, g: 60, b: 50, a: 255), Rgba8(r: 240, g: 180, b: 40, a: 255),
  Rgba8(r: 80, g: 170, b: 80, a: 255), Rgba8(r: 60, g: 110, b: 210, a: 255),
]
var pixels = lookup.colorize(colors)
lookup.colorize(colors, pixels) # Reuse storage for another layer's colors.
```

`initRasterLookup` uses exact nearest-neighbor reprojection. Pass `clip = boundary` with geometry already in the target CRS to retain holes and disconnected parts at output resolution. Set `sourceRows = RasterRowOrder.bottomUp` for analytical grids whose row zero is at the southern edge. `colorize` accepts per-cell hatch flags and an `initHatchStyle` value.

The output is contiguous straight RGBA, ready for Pixie's `encodePng` or another encoder. Pixie is an optional application dependency; see the complete [PNG example](examples/render_pixie.nim) and [rendering API guide](docs/api.md#map-rendering).

## GPS and local mapping

Use `ngis/mapping` for standard-library-only tools on native Nim or JavaScript:

```nim
import std/options
import ngis/mapping

let projection = initLocalProjection(GeoPoint(lat: 42, lon: -93))
let position = projection.project(GeoPoint(lat: 42.0001, lon: -92.9999))
let samples = [MetricSample(x: position.x, y: position.y, value: 12.5)]
let spec = gridSpecForSamples(samples, cellSize = 10).get()
let observed = aggregateObserved(samples, spec)
echo observed.cells[0].value
```

`initLocalProjection` supplies approximate local metres around a fixed GPS origin.
`webMercator` supplies normalized world coordinates for web maps, including longitude
wrapping across the antimeridian. `aggregateObserved` retains only occupied cells;
`estimateIdw` and `estimateGridIdw` return estimates separately from observations.
`initPolygon2D` prepares repeated point queries with holes and explicit boundary results.
All use the same double-precision `Coordinate` as the GDAL API.

These tools are also exported by `ngis/api`. See the [local mapping guide](docs/local_mapping.md)
for coordinate limits, missing values, and computation budgets. Importing `ngis/mapping`
directly requires neither GDAL headers nor its shared library.

## Vector data

```nim
import ngis/api

let data = createVector()
let crs = newSpatialReference(4326, AxisOrder.traditionalGis)
let places = data.createLayer("places", GeometryKind.point, crs)
places.addField(FieldSpec(name: "name", kind: fkString))
let feature = places.newFeature()
feature.setField("name", "Harbour")
feature.setGeometry(newPoint(33.0, 35.0))
places.add(feature)
for place in places:
  echo place.fieldValue("name").text, ": ", place.geometry.toWkt()
```

Use `AxisOrder.traditionalGis` for longitude/latitude or easting/northing coordinate order. Without an explicit axis order, GDAL follows the selected CRS's authority order.

## Multidimensional arrays

```nim
import ngis/api

let data = createMultiDimDataset()
let root = data.rootGroup()
let time = root.createDimension("time", 3)
let temperature = root.createArray("temperature", [time], float32)
temperature.write([18'f32, 19, 20])
echo root["temperature"].readArrayData(float32)[1]
```

## Algorithms and utilities

Copy, crop, resize, and reproject using Nim configuration values:

```nim
import std/options
import ngis/api

let source = createRaster(uint8, 2, 2)
source.band().write(initRasterGrid(2, 2, @[1'u8, 2, 3, 4]))
let copy = source.copyRaster(config = TranslateConfig(
  outputSize: some(initRasterOutputSize(4, 4)),
  resampling: RasterResampling.bilinear,
))
echo readGrid[uint8](copy.band())[3, 3]

let algorithm = globalAlgorithmRegistry().instantiate(["raster", "info"])
algorithm.argument("input").set([source])
algorithm.argument("format").set("json")
algorithm.run()
algorithm.finalize()
```

CPL and virtual filesystem helpers are available too: `parseXml`, `newStringList`, `openVirtualFile`, `createZip`, and `newNativeBuffer` manage their native resources.

## API guide

| Area | Modules and resources |
| --- | --- |
| Datasets and drivers | `datasets`, `datasetops`, `drivers`: opening options, metadata, CRS properties, datasets and drivers |
| Raster | `raster`, `rasterio`, `rasterextras`, `asyncio`: typed grids, tiles, resampling, bands, tables and async readers |
| Map rendering | `rendering`: georeferenced layouts, reusable pixel lookups, output-resolution masks, RGBA colors and hatching |
| Local mapping | `mapping`: `mapprojection`, `metricgrid`, `localidw`, `polygonqueries`, and `coordinatevalues`; GPS and numeric mapping tools for native Nim and JavaScript |
| Vector and schema | `vector`, `features`, `geometryops`, `vectorextras`, `schemadomains`: typed fields, geometry construction and operations, prepared geometries, styles, domains and relationships |
| Coordinates and arrays | `coordinates`, `spatialrefs`, `multidim`, `arrayops`: bounds, affine mapping, CRS transformations, typed arrays, slices and attributes |
| Processing | `processing`, `operations`, `utilities`, `algorithms`, `advanced`: typed conversion and reprojection, progress closures, utilities, transformers, gridding and pansharpening |
| Specialised resources | `coordinateprecision`, `geocoding`, `triangulation`, `contours`, `subdatasets`, `computedbands`: precision models, geocoding results, meshes, streaming contours, subdataset descriptions and computed bands |
| CPL and I/O | `cpl`, `vsi`, `memory`, `progress`, `plugins`, `processes`: XML, HTTP, compression, containers, synchronization, virtual files, ZIP archives, buffers, callbacks and processes |
| Networks | `networks`: GNM networks, when the installed GDAL build includes GNM |
| Raw C API | `gdal`: generated GDAL, OGR, OSR, CPL and VSI declarations and macro equivalents |

`import ngis/api` exports the high-level modules. `import ngis` also exports the raw bindings for compatibility; `import ngis/gdal` imports only the raw bindings. See the [Nim API guide](docs/api.md) for field values, array slices, metadata, geometry operations, and progress callbacks.

The owning Nim API covers common resource families and workflows, but does not provide a one-to-one wrapper for every C function. For other calls, use the C API directly; `rawHandle` borrows from an owner, and `adopt` factories take ownership of compatible independently owned handles. Keep owners alive for any borrowed handles. See [ownership and lifetimes](docs/ownership.md) for details.

The raw bindings target GDAL 3.13.3's public C headers. They do not wrap the GDAL C++ API; symbols for optional drivers and features depend on the installed build. See [binding generation and checks](docs/bindings.md) for the API boundary and development workflow.

## Development

```sh
atlas install
atlas-run tests
atlas-run tests --backend:js mapping mapprojection metricgrid localidw polygonqueries polygonindex
atlas-run tests --compile-only examples/all_compile.nim
```
