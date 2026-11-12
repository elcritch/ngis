## Owned geometries and features, and layers that retain their datasets.
import ./[gdal, datasets, spatialrefs]
export spatialrefs

type
  GeometryObj = object
    handle: OGRGeometryH

  Geometry* = ref GeometryObj
  FeatureObj = object
    handle: OGRFeatureH

  Feature* = ref FeatureObj
  Layer* = ref object
    dataset: Dataset
    handle: OGRLayerH

proc `=destroy`(x: GeometryObj) =
  if x.handle != nil:
    OGR_G_DestroyGeometry(x.handle)

proc `=destroy`(x: FeatureObj) =
  if x.handle != nil:
    OGR_F_Destroy(x.handle)

proc `=copy`(dest: var GeometryObj, source: GeometryObj) {.error.}
proc `=dup`(source: GeometryObj): GeometryObj {.error.}
proc `=copy`(dest: var FeatureObj, source: FeatureObj) {.error.}
proc `=dup`(source: FeatureObj): FeatureObj {.error.}

proc validateText(value, description: string) =
  if '\0' in value:
    raise newException(ValueError, description & " contains a NUL byte")

proc rawHandle*(g: Geometry): OGRGeometryH =
  if g == nil or g.handle == nil:
    raise newException(ValueError, "invalid geometry")
  g.handle

proc rawHandle*(f: Feature): OGRFeatureH =
  if f == nil or f.handle == nil:
    raise newException(ValueError, "invalid feature")
  f.handle

proc rawHandle*(l: Layer): OGRLayerH =
  if l == nil or l.handle == nil:
    raise newException(ValueError, "invalid layer")
  discard l.dataset.rawHandle
  l.handle

proc close*(g: Geometry) =
  if g != nil and g.handle != nil:
    let handle = g.handle
    g.handle = nil
    OGR_G_DestroyGeometry(handle)

proc close*(f: Feature) =
  if f != nil and f.handle != nil:
    let handle = f.handle
    f.handle = nil
    OGR_F_Destroy(handle)

proc setSpatialReference*(g: Geometry, reference: SpatialReference) =
  ## Assigns a CRS without changing coordinates. GDAL retains its own reference.
  OGR_G_AssignSpatialReference(g.rawHandle, reference.rawHandle)

proc spatialReference*(g: Geometry): SpatialReference =
  let handle = OGR_G_GetSpatialReference(g.rawHandle)
  if handle == nil:
    raise newException(ValueError, "geometry has no spatial reference")
  adoptSpatialReference(OSRClone(handle))

proc spatialReference*(layer: Layer): SpatialReference =
  let handle = OGR_L_GetSpatialRef(layer.rawHandle)
  if handle == nil:
    raise newException(ValueError, "layer has no spatial reference")
  adoptSpatialReference(OSRClone(handle))

proc wrapGeometry(h: OGRGeometryH): Geometry =
  if h == nil:
    raise newException(ValueError, "could not create geometry")
  new(result)
  result.handle = h

proc wrapFeature(h: OGRFeatureH): Feature =
  if h == nil:
    raise newException(IOError, "could not create feature")
  new(result)
  result.handle = h

proc adoptGeometry*(handle: OGRGeometryH): Geometry =
  ## Takes ownership of a native geometry. Do not destroy the handle separately.
  wrapGeometry(handle)

proc adoptFeature*(handle: OGRFeatureH): Feature =
  ## Takes ownership of a native feature. Do not destroy the handle separately.
  wrapFeature(handle)

proc newGeometry*(kind: OGRwkbGeometryType): Geometry =
  wrapGeometry(OGR_G_CreateGeometry(kind))

proc newPoint*(x, y: float64): Geometry =
  result = newGeometry(wkbPoint)
  if OGR_G_AddPoint_2D(result.handle, x, y) != OGRERR_NONE:
    raise newException(IOError, "could not set point coordinates")

proc geometryFromWkt*(wkt: string): Geometry =
  if '\0' in wkt:
    raise newException(ValueError, "WKT contains a NUL byte")
  var text = wkt.cstring
  var h: OGRGeometryH
  if OGR_G_CreateFromWkt(cast[cstringArray](addr text), nil, addr h) != OGRERR_NONE:
    raise newException(ValueError, "invalid WKT geometry")
  wrapGeometry(h)

proc geometryFromGeoJson*(json: string): Geometry =
  if '\0' in json:
    raise newException(ValueError, "GeoJSON contains a NUL byte")
  wrapGeometry(OGR_G_CreateGeometryFromJson(json.cstring))

proc toWkt*(g: Geometry): string =
  var text: cstring
  if OGR_G_ExportToWkt(g.rawHandle, cast[cstringArray](addr text)) != OGRERR_NONE:
    raise newException(IOError, "could not export geometry as WKT")
  defer:
    VSIFree(text)
  result = $text

proc toGeoJson*(g: Geometry): string =
  let text = OGR_G_ExportToJson(g.rawHandle)
  if text == nil:
    raise newException(IOError, "could not export geometry as GeoJSON")
  defer:
    VSIFree(text)
  result = $text

proc clone*(g: Geometry): Geometry =
  wrapGeometry(OGR_G_Clone(g.rawHandle))

proc transform*(g: Geometry, t: CoordinateTransform) =
  if OGR_G_Transform(g.rawHandle, t.rawHandle) != OGRERR_NONE:
    raise newException(ValueError, "geometry transformation failed")

proc x*(g: Geometry, index = 0): float64 =
  if index < 0 or index >= int(OGR_G_GetPointCount(g.rawHandle)):
    raise newException(ValueError, "geometry point index is out of range")
  OGR_G_GetX(g.rawHandle, cint(index))

proc y*(g: Geometry, index = 0): float64 =
  if index < 0 or index >= int(OGR_G_GetPointCount(g.rawHandle)):
    raise newException(ValueError, "geometry point index is out of range")
  OGR_G_GetY(g.rawHandle, cint(index))

proc layer*(ds: Dataset, name: string): Layer =
  validateText(name, "layer name")
  let h = GDALDatasetGetLayerByName(ds.rawHandle, name.cstring)
  if h == nil:
    raise newException(KeyError, "layer not found: " & name)
  Layer(dataset: ds, handle: h)

proc layerCount*(dataset: Dataset): int =
  ## Number of vector layers in this dataset.
  int(GDALDatasetGetLayerCount(dataset.rawHandle))

proc layer*(dataset: Dataset, index: Natural): Layer =
  ## Required zero-based layer lookup. Invalid indices raise KeyError.
  let handle = dataset.rawHandle
  if index >= int(GDALDatasetGetLayerCount(handle)):
    raise newException(KeyError, "layer index is out of range: " & $index)
  let layer = GDALDatasetGetLayer(handle, cint(index))
  if layer == nil:
    raise gdalError("could not access dataset layer")
  Layer(dataset: dataset, handle: layer)

proc hasLayer*(dataset: Dataset, name: string): bool =
  validateText(name, "layer name")
  GDALDatasetGetLayerByName(dataset.rawHandle, name.cstring) != nil

iterator layers*(dataset: Dataset): Layer =
  ## Visits layers in driver order. Each view retains the dataset owner.
  for index in 0 ..< dataset.layerCount:
    yield dataset.layer(index)

proc createLayer*(
    ds: Dataset, name: string, kind: OGRwkbGeometryType, srs: SpatialReference = nil
): Layer =
  validateText(name, "layer name")
  let s = if srs == nil: nil else: srs.rawHandle
  let h = GDALDatasetCreateLayer(ds.rawHandle, name.cstring, s, kind, nil)
  if h == nil:
    raise newException(IOError, "could not create layer: " & name)
  Layer(dataset: ds, handle: h)

proc addField*(l: Layer, name: string, kind: OGRFieldType) =
  validateText(name, "field name")
  let field = OGR_Fld_Create(name.cstring, kind)
  if field == nil:
    raise newException(IOError, "could not create field definition")
  defer:
    OGR_Fld_Destroy(field)
  if OGR_L_CreateField(l.rawHandle, field, 1) != OGRERR_NONE:
    raise newException(IOError, "could not add field: " & name)

proc newFeature*(l: Layer): Feature =
  wrapFeature(OGR_F_Create(OGR_L_GetLayerDefn(l.rawHandle)))

proc setGeometry*(f: Feature, g: Geometry) =
  ## GDAL clones the geometry; both objects retain their own handles.
  if OGR_F_SetGeometry(f.rawHandle, g.rawHandle) != OGRERR_NONE:
    raise newException(IOError, "could not set feature geometry")

proc geometry*(f: Feature): Geometry =
  let h = OGR_F_GetGeometryRef(f.rawHandle)
  if h == nil:
    raise newException(ValueError, "feature has no geometry")
  wrapGeometry(OGR_G_Clone(h))

proc fieldIndex(f: Feature, name: string): cint =
  validateText(name, "field name")
  result = OGR_F_GetFieldIndex(f.rawHandle, name.cstring)
  if result < 0:
    raise newException(KeyError, "field not found: " & name)

proc `[]=`*(f: Feature, name, value: string) =
  validateText(value, "field value")
  OGR_F_SetFieldString(f.rawHandle, f.fieldIndex(name), value.cstring)

proc `[]`*(f: Feature, name: string): string =
  $OGR_F_GetFieldAsString(f.rawHandle, f.fieldIndex(name))

proc setField*(f: Feature, name: string, value: int64) =
  OGR_F_SetFieldInteger64(f.rawHandle, f.fieldIndex(name), value)

proc setField*(f: Feature, name: string, value: float64) =
  OGR_F_SetFieldDouble(f.rawHandle, f.fieldIndex(name), value)

proc intField*(f: Feature, name: string): int64 =
  OGR_F_GetFieldAsInteger64(f.rawHandle, f.fieldIndex(name))

proc floatField*(f: Feature, name: string): float64 =
  OGR_F_GetFieldAsDouble(f.rawHandle, f.fieldIndex(name))

proc add*(l: Layer, f: Feature) =
  if OGR_L_CreateFeature(l.rawHandle, f.rawHandle) != OGRERR_NONE:
    raise newException(IOError, "could not create layer feature")

iterator items*(l: Layer): Feature =
  ## Resets and consumes the layer's shared reading cursor.
  OGR_L_ResetReading(l.rawHandle)
  while true:
    let h = OGR_L_GetNextFeature(l.rawHandle)
    if h == nil:
      break
    yield wrapFeature(h)
