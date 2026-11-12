# ngis

Work with GDAL rasters, vector data, multidimensional arrays, and coordinate systems from Nim. ngis provides automatic resource cleanup for common workflows and direct access to the GDAL C API when you need finer control.

## Install

Install Nim 2.2 or later and the GDAL 3.13.3 development headers and shared library. Add ngis to your project's `.nimble` file:

```nim
requires "https://github.com/elcritch/ngis"
```

Run `atlas install` in your project. GDAL must be available at runtime. On macOS ngis uses the Homebrew GDAL prefix when available; Linux uses `libgdal.so`. Use `-d:gdalLib=/path/to/libgdal` when compiling to select another shared library. The currently tested platforms are macOS arm64 and 64-bit Linux; Windows needs native ABI validation.

## Raster quick start

```nim
import ngis

let image = createDataset("MEM", "", 2, 2, dataType = GDT_Float32)
let pixels = image.band()
pixels.write([1'f32, 2, 3, 4])
echo read[float32](pixels)
```

## Vector data

```nim
import ngis

let data = createDataset("MEM", "", 0, 0, bands = 0)
let places = data.createLayer("places", wkbPoint, newSpatialReference(4326))
places.addField("name", OFTString)
let feature = places.newFeature()
feature["name"] = "Harbour"
feature.setGeometry(newPoint(33.0, 35.0))
places.add(feature)
for place in places:
  echo place["name"], ": ", place.geometry.toWkt()
```

Coordinate transformations use GDAL's axis-order rules for the selected CRS.

## Multidimensional arrays

```nim
import ngis

let data = createMultiDimDataset("MEM", "")
let root = data.rootGroup()
let time = root.createDimension("time", 3)
let temperature = root.createArray("temperature", [time], numericType(GDT_Float32))
temperature.write([18'f32, 19, 20])
echo temperature.read(float32)
```

## Algorithms and utilities

Use command-line-style GDAL utility options or inspect and run registered algorithms:

```nim
import ngis

let source = createDataset("MEM", "", 2, 2)
source.band().write([1'u8, 2, 3, 4])
let copy = translate(source, "", ["-of", "MEM"])
echo read[uint8](copy.band())

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
| Datasets and drivers | `datasets`, `drivers`: datasets, registered drivers and owned unregistered drivers |
| Raster | `raster`, `rasterextras`, `asyncio`: bands, color and attribute tables, async readers |
| Vector and schema | `vector`, `vectorextras`, `schemadomains`: features, geometries, prepared geometries, styles, field domains and relationships |
| Coordinates and arrays | `spatialrefs`, `schemadomains`, `multidim`: CRS, coordinate operations, groups, arrays, dimensions and attributes |
| Processing | `operations`, `utilities`, `algorithms`, `advanced`: utilities, algorithm registry and arguments, transformers, warping, gridding and pansharpening |
| Specialised resources | `coordinateprecision`, `geocoding`, `triangulation`, `contours`, `subdatasets`, `computedbands`: precision models, geocoding results, meshes, streaming contours, subdataset descriptions and computed bands |
| CPL and I/O | `cpl`, `vsi`, `memory`, `progress`, `plugins`, `processes`: XML, HTTP, compression, containers, synchronization, virtual files, ZIP archives, buffers, callbacks and processes |
| Networks | `networks`: GNM networks, when the installed GDAL build includes GNM |
| Raw C API | `gdal`: generated GDAL, OGR, OSR, CPL and VSI declarations and macro equivalents |

`import ngis` exports these modules; `import ngis/gdal` imports only the raw bindings. The owning Nim API covers common resource families and workflows, but does not provide a one-to-one wrapper for every C function. For other calls, use the C API directly; `rawHandle` borrows from an owner, and `adopt` factories take ownership of compatible independently owned handles. Keep owners alive for any borrowed handles. See [ownership and lifetimes](docs/ownership.md) for details.

The raw bindings target GDAL 3.13.3's public C headers. They do not wrap the GDAL C++ API; symbols for optional drivers and features depend on the installed build. See [binding generation and checks](docs/bindings.md) for the API boundary and development workflow.

## Development

```sh
atlas install
atlas-run tests
atlas-run tests --compile-only examples/all_compile.nim
```
