# ngis

Work with GDAL rasters, vector data, multidimensional arrays, and coordinate systems from Nim. Use typed grids, feature values, geometry operations, iterators, and processing options with automatic resource cleanup. The complete GDAL C API is available alongside the high-level API.

## Install

Install Nim 2.2 or later and the GDAL 3.13.3 development headers and shared library. Add ngis to your project's `.nimble` file:

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
atlas-run tests --compile-only examples/all_compile.nim
```
