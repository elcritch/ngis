# High-level Nim API

Import `ngis/api` for Nim values and automatically managed resources. Import `ngis/gdal` separately when a workflow needs a raw C call. `import ngis` continues to expose both layers.

## Raster pixels and windows

`createRaster(float32, width, height)` creates an in-memory raster. Set `driver` and `path` to write another format. Pixel types map to GDAL types automatically.

`RasterGrid[T]` owns a flat row-major buffer with a fixed width and height. Construct one with `initRasterGrid[T](width, height)` or pass an existing sequence. Access pixels as `grid[x, y]`, iterate values with `for value in grid`, and write it with `band.write(grid)`. Grid copies have Nim value semantics; dimensions cannot be changed independently of storage.

`readGrid[T](band)` reads the full band. Pass a `RasterWindow` for a subset, and output dimensions plus `RasterResampling` to resample. `band.tiles(tileWidth, tileHeight)` yields pixel windows, clipping the final row and column to the band edges. Raster band indices are one-based; grid coordinates are zero-based.

## Vector fields and geometries

`createVector()` creates an in-memory vector dataset. Create layers with `GeometryKind` and fields with `FieldSpec`:

```nim
import ngis/api

let data = createVector()
let layer = data.createLayer("stations", GeometryKind.point)
layer.addField(FieldSpec(name: "name", kind: fkString))
layer.addField(FieldSpec(name: "samples", kind: fkInteger64List))
let feature = layer.newFeature()
feature.setField("name", "Harbour")
feature.setField("samples", @[10'i64, 20, 30])
feature.setGeometry(newPoint(33, 35))
layer.add(feature)
```

`fieldValue(name)` returns a `FieldValue` case object. Its `kind` distinguishes unset (`fvUnset`), explicit null (`fvNull`), and typed data. Integer, integer64, real, string, list, binary, date, time, and datetime fields are supported. Access the matching variant field, such as `.text`, `.integer64`, `.reals`, or `.dateTime`, after checking its kind. Set null or unset with `setField(name, FieldValue(kind: fvNull))` or `fvUnset`. `hasKey` tests schema membership; required missing fields raise `KeyError`.

`FieldDateTime` preserves fractional seconds and distinguishes unknown, local, and explicit-offset time zones. Explicit offsets are minutes east of UTC in GDAL's 15-minute increments. `FieldSpec.subtype` supports boolean, int16, float32, JSON, and UUID subtypes where the field kind permits them. A boolean field uses `fkInteger` with `fsBoolean`.

`layer.fields` and `feature.pairs` copy schema and value data. Returned values remain usable after the feature closes. `layer.feature(id)` performs required lookup, `layer.update(feature)` saves changes, and `layer.delete(id)` removes a feature. Dataset `layers` iteration and indexed `layer(index)` lookup use zero-based indices.

Construct geometry using `newPoint`, `newLineString`, `newPolygon` with optional holes, or the multi-geometry constructors. `geometry.points` yields copied coordinates. `geometry[index]` and component iteration return independent clones. Geometry operations include `bounds`, `area`, `length`, `contains`, `intersects`, `buffer`, `intersection`, `union`, and `difference`. GEOS-backed operations require GEOS in the GDAL build. Geometry coordinates and distances use the geometry's CRS units.

## Coordinates and dataset properties

`Coordinate`, `Bounds`, and `AffineTransform` are value objects. `pixelToWorld` and `worldToPixel` map pixel corners; add 0.5 to both pixel coordinates to address a pixel center. `worldToPixel` rejects singular or nonfinite transforms. `CoordinateTransform.transform(points)` returns a sequence without changing its input, and fails if any point cannot be transformed.

GDAL follows the CRS's authority axis order by default. For longitude/latitude or easting/northing coordinate order, construct a CRS with `newSpatialReference(4326, AxisOrder.traditionalGis)`. This matters both for coordinate transformations and for CRS definitions assigned to datasets whose affine coordinates follow GIS x/y order.

`dataset.spatialReference` returns an independent clone. Assigning `dataset.spatialReference = reference` changes its CRS definition without reprojecting pixels. Assigning `dataset.affineTransform` changes georeferencing without moving pixel values.

`openRaster` and `openVector` accept driver filters and driver-specific options. Use `openDataset(path, initDatasetOpenOptions(...))` for explicit dataset kinds and access mode. `initDatasetOpenOptions()` defaults to raster and vector access; an object with an empty `kinds` set is invalid.

Read a metadata key with `dataset.metadata(name)`, which returns `Option[string]`. Use `setMetadata` and `deleteMetadata` to mutate it. `metadataItems` copies a key/value domain into an `OrderedTable`; `metadataValues` copies entries verbatim, including XML domains. Dataset and raster band descriptions, metadata domains, and values are available as ordinary Nim strings and sequences.

## Multidimensional arrays

`createMultiDimDataset()` creates an in-memory dataset. Create dimensions through its root group and create arrays with an element type, such as `group.createArray("temperature", [time], float32)`.

`ArrayData[T]` owns values and their shape. Index it in dimension order, with the last dimension varying fastest. `initArrayData(shape, values)` checks element counts. `readArrayData(array, float32)` reads values and shape together, and `array.write(data)` checks the full shape before writing.

`ArraySlice` holds starting indices and counts in dimension order. Construct it with `initArraySlice(starts, counts)` and pass it to `array.read(slice, float32)`, `readArrayData`, or `array.write(slice, values)`. Rank and bounds are checked before native I/O. A rank-zero scalar has an empty shape and exactly one value.

`group[name]` performs required array lookup and raises `KeyError` when missing. `hasKey` and `contains` test array names; `group.arrays` and `group.groups` iterate independently owned handles. These handles retain native dataset references, so closing the original dataset does not invalidate them.

## Raster processing and progress

`copyRaster`, `crop`, `warp`, `mosaic`, and `reproject` return owning datasets. `TranslateConfig` controls band selection, pixel windows, output size, resampling, nodata, driver, and creation options. `WarpConfig` controls source/target CRS, target bounds and size, resampling, nodata, driver, and creation options. An empty destination defaults to an in-memory result. Bounds are expressed in the target CRS; later mosaic sources take precedence in overlapping areas.

Pass a closure as `progress` to observe a synchronous operation:

```nim
import ngis/api

let source = createRaster(uint8, 2, 2)
var calls = 0
let copy = source.copyRaster(progress =
  proc(complete: float64, message: string): bool =
    inc calls
    true
)
```

Returning `false` cancels and raises `IOError`. A callback exception is captured inside the C callback and re-raised after GDAL returns. GDAL does not retain the closure after the operation. Write operations can leave a partial destination on failure or cancellation; these helpers do not provide filesystem transactions.

Resource cleanup and explicit `close` behavior follow the [ownership guide](ownership.md). Required missing names raise `KeyError`; invalid configurations generally raise `ValueError`, and native failures raise `IOError`. Parameters declared `Positive` or `Natural` also carry Nim's normal range contracts.
