## Owning vector schema, style and SQL resources.
import ./[gdal, datasets, vector, spatialrefs]
import ./private/resources

type
  FieldDefinition* = object
    resource: NativeResource[OGRFieldDefnH]

  GeometryFieldDefinition* = object
    resource: NativeResource[OGRGeomFieldDefnH]

  FeatureDefinition* = object
    resource: NativeResource[OGRFeatureDefnH]

  StyleTable* = object
    resource: NativeResource[OGRStyleTableH]

  StyleManager* = object
    resource: NativeResource[OGRStyleMgrH]
    table: StyleTable

  StyleTool* = object
    resource: NativeResource[OGRStyleToolH]

  PreparedGeometry* = object
    resource: NativeResource[OGRPreparedGeometryH]

  GeometryTransformer* = object
    resource: NativeResource[OGRGeomTransformerH]

template owner(T, H, releaseFn: untyped) =
  proc rawHandle*(x: T): H =
    when compiles(x.table):
      discard rawHandle(x.table.resource)
    rawHandle(x.resource)

  proc close*(x: T) =
    close(x.resource)

  proc own(_: typedesc[T], h: H): T =
    result.resource = newNativeResource(
      h,
      proc(p: H) {.nimcall, raises: [].} =
        releaseFn(p),
    )

owner(FieldDefinition, OGRFieldDefnH, OGR_Fld_Destroy)
owner(GeometryFieldDefinition, OGRGeomFieldDefnH, OGR_GFld_Destroy)
owner(FeatureDefinition, OGRFeatureDefnH, OGR_FD_Release)
owner(StyleTable, OGRStyleTableH, OGR_STBL_Destroy)
owner(StyleManager, OGRStyleMgrH, OGR_SM_Destroy)
owner(StyleTool, OGRStyleToolH, OGR_ST_Destroy)
owner(PreparedGeometry, OGRPreparedGeometryH, OGRDestroyPreparedGeometry)
owner(GeometryTransformer, OGRGeomTransformerH, OGR_GeomTransformer_Destroy)

proc newFieldDefinition*(name: string, kind: OGRFieldType): FieldDefinition =
  validateCString(name, "field name")
  own(FieldDefinition, OGR_Fld_Create(name.cstring, kind))

proc name*(field: FieldDefinition): string =
  $OGR_Fld_GetNameRef(field.rawHandle)

proc kind*(field: FieldDefinition): OGRFieldType =
  OGR_Fld_GetType(field.rawHandle)

proc width*(field: FieldDefinition): int =
  int(OGR_Fld_GetWidth(field.rawHandle))

proc setWidth*(field: FieldDefinition, width: int) =
  if width < 0 or width > high(cint).int:
    raise newException(ValueError, "invalid width")
  OGR_Fld_SetWidth(field.rawHandle, cint(width))

proc newGeometryFieldDefinition*(
    name: string, kind: OGRwkbGeometryType
): GeometryFieldDefinition =
  validateCString(name, "geometry field name")
  own(GeometryFieldDefinition, OGR_GFld_Create(name.cstring, kind))

proc name*(field: GeometryFieldDefinition): string =
  $OGR_GFld_GetNameRef(field.rawHandle)

proc kind*(field: GeometryFieldDefinition): OGRwkbGeometryType =
  OGR_GFld_GetType(field.rawHandle)

proc newFeatureDefinition*(name: string): FeatureDefinition =
  validateCString(name, "feature definition name")
  let h = OGR_FD_Create(name.cstring)
  if h != nil:
    discard OGR_FD_Reference(h)
  own(FeatureDefinition, h)

proc name*(definition: FeatureDefinition): string =
  $OGR_FD_GetName(definition.rawHandle)

proc fieldCount*(definition: FeatureDefinition): int =
  int(OGR_FD_GetFieldCount(definition.rawHandle))

proc geometryFieldCount*(definition: FeatureDefinition): int =
  int(OGR_FD_GetGeomFieldCount(definition.rawHandle))

proc add*(definition: FeatureDefinition, field: FieldDefinition) =
  OGR_FD_AddFieldDefn(definition.rawHandle, field.rawHandle)

proc add*(definition: FeatureDefinition, field: GeometryFieldDefinition) =
  OGR_FD_AddGeomFieldDefn(definition.rawHandle, field.rawHandle)

proc field*(definition: FeatureDefinition, index: int): FieldDefinition =
  if index < 0 or index >= definition.fieldCount:
    raise newException(IndexDefect, "field index out of range")
  let h = OGR_FD_GetFieldDefn(definition.rawHandle, cint(index))
  result = newFieldDefinition($OGR_Fld_GetNameRef(h), OGR_Fld_GetType(h))
  OGR_Fld_SetSubType(result.rawHandle, OGR_Fld_GetSubType(h))
  OGR_Fld_SetWidth(result.rawHandle, OGR_Fld_GetWidth(h))
  OGR_Fld_SetPrecision(result.rawHandle, OGR_Fld_GetPrecision(h))
  OGR_Fld_SetNullable(result.rawHandle, OGR_Fld_IsNullable(h))
  OGR_Fld_SetUnique(result.rawHandle, OGR_Fld_IsUnique(h))
  OGR_Fld_SetDefault(result.rawHandle, OGR_Fld_GetDefault(h))
  OGR_Fld_SetAlternativeName(result.rawHandle, OGR_Fld_GetAlternativeNameRef(h))
  OGR_Fld_SetDomainName(result.rawHandle, OGR_Fld_GetDomainName(h))
  OGR_Fld_SetComment(result.rawHandle, OGR_Fld_GetComment(h))
  OGR_Fld_SetJustify(result.rawHandle, OGR_Fld_GetJustify(h))
  OGR_Fld_SetTZFlag(result.rawHandle, OGR_Fld_GetTZFlag(h))
  OGR_Fld_SetIgnored(result.rawHandle, OGR_Fld_IsIgnored(h))
  OGR_Fld_SetGenerated(result.rawHandle, OGR_Fld_IsGenerated(h))

proc geometryField*(
    definition: FeatureDefinition, index: int
): GeometryFieldDefinition =
  if index < 0 or index >= definition.geometryFieldCount:
    raise newException(IndexDefect, "geometry field index out of range")
  let h = OGR_FD_GetGeomFieldDefn(definition.rawHandle, cint(index))
  result = newGeometryFieldDefinition($OGR_GFld_GetNameRef(h), OGR_GFld_GetType(h))
  OGR_GFld_SetNullable(result.rawHandle, OGR_GFld_IsNullable(h))
  OGR_GFld_SetIgnored(result.rawHandle, OGR_GFld_IsIgnored(h))
  OGR_GFld_SetSpatialRef(result.rawHandle, OGR_GFld_GetSpatialRef(h))

proc clone*(definition: FeatureDefinition): FeatureDefinition =
  result = newFeatureDefinition(definition.name)
  for i in 0 ..< definition.fieldCount:
    result.add definition.field(i)
  # Newly created definitions contain a default geometry field.
  while result.geometryFieldCount > 0:
    discard OGR_FD_DeleteGeomFieldDefn(result.rawHandle, 0)
  for i in 0 ..< definition.geometryFieldCount:
    result.add definition.geometryField(i)

proc newStyleTable*(): StyleTable =
  own(StyleTable, OGR_STBL_Create())

proc add*(table: StyleTable, name, style: string) =
  validateCString(name, "style name")
  validateCString(style, "style")
  if OGR_STBL_AddStyle(table.rawHandle, name.cstring, style.cstring) == 0:
    raise gdalError("could not add style")

proc find*(table: StyleTable, name: string): string =
  validateCString(name, "style name")
  let h = OGR_STBL_Find(table.rawHandle, name.cstring)
  if h == nil:
    raise newException(KeyError, "style not found: " & name)
  $h

proc newStyleManager*(table: StyleTable): StyleManager =
  result = own(StyleManager, OGR_SM_Create(table.rawHandle))
  result.table = table

proc init*(manager: StyleManager, style: string) =
  validateCString(style, "style")
  if OGR_SM_InitStyleString(manager.rawHandle, style.cstring) == 0:
    raise gdalError("invalid style")

proc partCount*(manager: StyleManager): int =
  int(OGR_SM_GetPartCount(manager.rawHandle, nil))

proc part*(manager: StyleManager, index: int): StyleTool =
  if index < 0 or index >= manager.partCount:
    raise newException(IndexDefect, "style part index out of range")
  own(StyleTool, OGR_SM_GetPart(manager.rawHandle, cint(index), nil))

proc newStyleTool*(kind: OGRSTClassId): StyleTool =
  own(StyleTool, OGR_ST_Create(kind))

proc kind*(tool: StyleTool): OGRSTClassId =
  OGR_ST_GetType(tool.rawHandle)

proc styleString*(tool: StyleTool): string =
  $OGR_ST_GetStyleString(tool.rawHandle)

proc add*(manager: StyleManager, tool: StyleTool) =
  if OGR_SM_AddPart(manager.rawHandle, tool.rawHandle) == 0:
    raise gdalError("could not add style part")

proc prepare*(geometry: Geometry): PreparedGeometry =
  result = own(PreparedGeometry, OGRCreatePreparedGeometry(geometry.rawHandle))

proc intersects*(prepared: PreparedGeometry, other: Geometry): bool =
  OGRPreparedGeometryIntersects(prepared.rawHandle, other.rawHandle) != 0

proc contains*(prepared: PreparedGeometry, other: Geometry): bool =
  OGRPreparedGeometryContains(prepared.rawHandle, other.rawHandle) != 0

proc newGeometryTransformer*(transform: CoordinateTransform): GeometryTransformer =
  result =
    own(GeometryTransformer, OGR_GeomTransformer_Create(transform.rawHandle, nil))

type
  SqlPayload = object
    handle: OGRLayerH
    dataset: GDALDatasetH

  SqlResult* = ref object
    payload: SqlPayload

proc `=destroy`(payload: SqlPayload) =
  if payload.handle != nil:
    GDALDatasetReleaseResultSet(payload.dataset, payload.handle)
  if payload.dataset != nil:
    discard GDALReleaseDataset(payload.dataset)

proc `=copy`(dest: var SqlPayload, src: SqlPayload) {.error.}
proc `=dup`(src: SqlPayload): SqlPayload {.error.}
proc rawHandle*(resultSet: SqlResult): OGRLayerH =
  if resultSet == nil or resultSet.payload.handle == nil:
    raise newException(ValueError, "SQL result is closed")
  resultSet.payload.handle

proc close*(resultSet: SqlResult) =
  if resultSet != nil and resultSet.payload.handle != nil:
    let h = resultSet.payload.handle
    resultSet.payload.handle = nil
    GDALDatasetReleaseResultSet(resultSet.payload.dataset, h)

proc adoptResultSet*(dataset: Dataset, handle: OGRLayerH): SqlResult =
  ## Takes ownership of a result layer belonging to the dataset.
  if handle == nil:
    raise gdalError("could not obtain result set")
  let ds = dataset.rawHandle
  discard GDALReferenceDataset(ds)
  SqlResult(payload: SqlPayload(handle: handle, dataset: ds))

proc executeSql*(dataset: Dataset, sql: string, dialect = ""): SqlResult =
  validateCString(sql, "SQL")
  validateCString(dialect, "dialect")
  let ds = dataset.rawHandle
  let h = GDALDatasetExecuteSQL(
    ds, sql.cstring, nil, if dialect.len == 0: nil else: dialect.cstring
  )
  if h == nil:
    raise gdalError("SQL did not return a result set")
  adoptResultSet(dataset, h)

proc featureCount*(resultSet: SqlResult): int64 =
  OGR_L_GetFeatureCount(resultSet.rawHandle, 1)

proc startTransaction*(dataset: Dataset, force = false) =
  if GDALDatasetStartTransaction(dataset.rawHandle, cint(force)) != OGRERR_NONE:
    raise gdalError("could not start dataset transaction")

proc commitTransaction*(dataset: Dataset) =
  if GDALDatasetCommitTransaction(dataset.rawHandle) != OGRERR_NONE:
    raise gdalError("could not commit dataset transaction")

proc rollbackTransaction*(dataset: Dataset) =
  if GDALDatasetRollbackTransaction(dataset.rawHandle) != OGRERR_NONE:
    raise gdalError("could not roll back dataset transaction")

proc startTransaction*(layer: Layer) =
  if OGR_L_StartTransaction(layer.rawHandle) != OGRERR_NONE:
    raise gdalError("could not start layer transaction")

proc commitTransaction*(layer: Layer) =
  if OGR_L_CommitTransaction(layer.rawHandle) != OGRERR_NONE:
    raise gdalError("could not commit layer transaction")

proc rollbackTransaction*(layer: Layer) =
  if OGR_L_RollbackTransaction(layer.rawHandle) != OGRERR_NONE:
    raise gdalError("could not roll back layer transaction")

proc transform*(transformer: GeometryTransformer, geometry: Geometry): Geometry =
  adoptGeometry(
    OGR_GeomTransformer_Transform(transformer.rawHandle, geometry.rawHandle)
  )

iterator items*(resultSet: SqlResult): Feature =
  OGR_L_ResetReading(resultSet.rawHandle)
  while true:
    let feature = OGR_L_GetNextFeature(resultSet.rawHandle)
    if feature == nil:
      break
    yield adoptFeature(feature)

template withTransaction*(owner: Dataset | Layer, body: untyped) =
  ## Commits on success and attempts rollback if the body or commit raises.
  block:
    let transactionOwner = owner
    startTransaction(transactionOwner)
    var committed = false
    try:
      body
      commitTransaction(transactionOwner)
      committed = true
    finally:
      if not committed:
        try:
          rollbackTransaction(transactionOwner)
        except CatchableError:
          discard

type WkbExportOptions* = object
  resource: NativeResource[ptr OGRwkbExportOptions]

proc rawHandle*(options: WkbExportOptions): ptr OGRwkbExportOptions =
  options.resource.rawHandle

proc close*(options: WkbExportOptions) =
  options.resource.close()

proc newWkbExportOptions*(): WkbExportOptions =
  WkbExportOptions(
    resource: newNativeResource(
      OGRwkbExportOptionsCreate(),
      proc(h: ptr OGRwkbExportOptions) {.nimcall, raises: [].} =
        OGRwkbExportOptionsDestroy(h),
    )
  )

proc setByteOrder*(options: WkbExportOptions, order: OGRwkbByteOrder) =
  OGRwkbExportOptionsSetByteOrder(options.rawHandle, order)

proc setVariant*(options: WkbExportOptions, variant: OGRwkbVariant) =
  OGRwkbExportOptionsSetVariant(options.rawHandle, variant)

proc toWkb*(geometry: Geometry, options: WkbExportOptions): seq[byte] =
  let count = OGR_G_WkbSizeEx(geometry.rawHandle)
  if count > csize_t(high(int)):
    raise newException(ValueError, "geometry is too large")
  result = newSeq[byte](int(count))
  if count == 0 or
      OGR_G_ExportToWkbEx(geometry.rawHandle, addr result[0], options.rawHandle) !=
      OGRERR_NONE:
    raise gdalError("could not export WKB")

proc toWkb*(geometry: Geometry): seq[byte] =
  toWkb(geometry, newWkbExportOptions())
