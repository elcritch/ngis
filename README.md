# ngis

Nim bindings for GDAL: work with rasters, vector data, coordinate systems, and GDAL utilities through owning Nim wrappers or the public C API.

## Installation

Install Nim 2.2 or later and the GDAL 3.13.3 headers and shared library. The bindings are generated against GDAL 3.13.3; use that version for matching ABI and functionality. Add ngis to your project's `.nimble` file:

```nim
requires "https://github.com/elcritch/ngis"
```

Run `atlas install` in your project. The GDAL library must be available at runtime. On macOS the loader uses the Homebrew GDAL prefix when available; Linux uses `libgdal.so`. Set `-d:gdalLib=/path/to/libgdal` at compile time to select another shared library. The current tested platforms are macOS arm64 and 64-bit Linux; Windows requires native ABI validation before it can be considered supported.

## Raster quick start

```nim
import ngis

let image = createDataset("MEM", "", 2, 2, dataType = GDT_Float32)
let pixels = image.band()
pixels.write([1'f32, 2, 3, 4])
echo read[float32](pixels)
```

## Vector and coordinate systems

```nim
import ngis

let data = createDataset("MEM", "", 0, 0, bands = 0)
let crs = newSpatialReference(4326)
let places = data.createLayer("places", wkbPoint, crs)
places.addField("name", OFTString)
let feature = places.newFeature()
feature["name"] = "Harbour"
feature.setGeometry(newPoint(33.0, 35.0))
places.add(feature)
for place in places:
  echo place["name"], ": ", place.geometry.toWkt()
```

Use `newCoordinateTransform(source, target)` and `transform` to transform coordinates or geometries. GDAL's axis-order rules for the selected CRS apply.

## GDAL utilities

Utility options use the same arguments as the corresponding GDAL command-line tool:

```nim
import ngis

let source = createDataset("MEM", "", 2, 2)
source.band().write([1'u8, 2, 3, 4])
let copy = translate(source, "", ["-of", "MEM"])
echo read[uint8](copy.band())
```

`warp`, `vectorTranslate`, `rasterize`, `grid`, and `buildVrt` are also available. Utility results retain native references to their backing source datasets where needed.

Datasets close automatically when their last owner is released. Bands and layers retain their dataset. Calling `close` explicitly invalidates aliases and borrowed bands or layers from that dataset; use it when deterministic release is needed. Geometry, feature, spatial reference, and coordinate transform wrappers own their native resources.

## Raw bindings

`import ngis/gdal` exposes generated declarations for the GDAL 3.13.3 public C API, including GDAL, OGR, OSR, and CPL. The header inventory, signatures, and hashes are recorded in `src/ngis/gdal/bindings.json`. C macro equivalents and their coverage inventory live in `macros.nim` and `macro_inventory.json`; compiler annotations, C++ constructs, and C control-flow macros use Nim's native equivalents. GDAL's C++ API is not wrapped. Some C symbols depend on the features enabled in the installed GDAL build; a declaration does not guarantee that its symbol exists in every build. Raw handles follow GDAL's C ownership rules. Some platform-specific stat helpers use native system headers.

## Development

```sh
atlas install
atlas-run tests
atlas-run tests --compile-only examples/all_compile.nim
```

The ABI tests compile against the installed GDAL headers using `gdal-config`. To regenerate the bindings and ABI checks, install the Python package `clang==18.1.8` and a compatible libclang, then run against the GDAL 3.13.3 headers:

```sh
python3 -m pip install clang==18.1.8
python3 scripts/generate_bindings.py --include "$(gdal-config --prefix)/include"
python3 scripts/generate_abi_test.py --include "$(gdal-config --prefix)/include"
python3 scripts/gdal_macros.py --include "$(gdal-config --prefix)/include"
nph src/ngis/gdal/bindings.nim tests/tgdal_generated_abi.nim
```

Pass `--libclang /path/to/libclang` to either script if libclang is not found automatically.
