## Owning color and attribute tables, plus raster statistics and histograms.
import ./[gdal, datasets, raster]
import ./private/resources

type
  ColorTable* = object
    resource: NativeResource[GDALColorTableH]

  RasterAttributeTable* = object
    resource: NativeResource[GDALRasterAttributeTableH]

  RasterStatistics* = tuple[minimum, maximum, mean, standardDeviation: float64]
  RasterColumn* = object
    name*: string
    fieldType*: GDALRATFieldType
    usage*: GDALRATFieldUsage

proc releaseColor(handle: GDALColorTableH) {.nimcall, raises: [].} =
  GDALDestroyColorTable(handle)

proc releaseRat(handle: GDALRasterAttributeTableH) {.nimcall, raises: [].} =
  GDALDestroyRasterAttributeTable(handle)

proc wrapColor(handle: GDALColorTableH): ColorTable =
  if handle == nil:
    raise gdalError("could not create color table")
  ColorTable(resource: newNativeResource(handle, releaseColor))

proc wrapRat(handle: GDALRasterAttributeTableH): RasterAttributeTable =
  if handle == nil:
    raise gdalError("could not create raster attribute table")
  RasterAttributeTable(resource: newNativeResource(handle, releaseRat))

proc rawHandle*(table: ColorTable): GDALColorTableH =
  rawHandle(table.resource)

proc rawHandle*(table: RasterAttributeTable): GDALRasterAttributeTableH =
  rawHandle(table.resource)

proc close*(table: ColorTable) =
  close(table.resource)

proc close*(table: RasterAttributeTable) =
  close(table.resource)

proc newColorTable*(palette = GPI_RGB): ColorTable =
  wrapColor(GDALCreateColorTable(palette))

proc newRasterAttributeTable*(): RasterAttributeTable =
  wrapRat(GDALCreateRasterAttributeTable())

proc colorTable*(band: RasterBand): ColorTable =
  ## Clone the borrowed table so it remains valid after the dataset closes.
  let borrowed = GDALGetRasterColorTable(band.rawHandle)
  if borrowed == nil:
    raise newException(ValueError, "band has no color table")
  wrapColor(GDALCloneColorTable(borrowed))

proc attributeTable*(band: RasterBand): RasterAttributeTable =
  ## Clone the borrowed table so it remains valid after the dataset closes.
  let borrowed = GDALGetDefaultRAT(band.rawHandle)
  if borrowed == nil:
    raise newException(ValueError, "band has no attribute table")
  wrapRat(GDALRATClone(borrowed))

proc setColorTable*(band: RasterBand, table: ColorTable) =
  if GDALSetRasterColorTable(band.rawHandle, table.rawHandle) != CE_None:
    raise gdalError("could not set raster color table")

proc setAttributeTable*(band: RasterBand, table: RasterAttributeTable) =
  if GDALSetDefaultRAT(band.rawHandle, table.rawHandle) != CE_None:
    raise gdalError("could not set raster attribute table")

proc len*(table: ColorTable): int =
  int(GDALGetColorEntryCount(table.rawHandle))

proc palette*(table: ColorTable): GDALPaletteInterp =
  GDALGetPaletteInterpretation(table.rawHandle)

proc `[]`*(table: ColorTable, index: int): GDALColorEntry =
  if index < 0 or index >= table.len:
    raise newException(IndexDefect, "color index out of range")
  GDALGetColorEntry(table.rawHandle, cint(index))[]

proc `[]=`*(table: ColorTable, index: int, entry: GDALColorEntry) =
  if index < 0 or index > int(high(cint)):
    raise newException(ValueError, "color index out of range")
  var value = entry
  GDALSetColorEntry(table.rawHandle, cint(index), addr value)

proc rowCount*(table: RasterAttributeTable): int =
  int(GDALRATGetRowCount(table.rawHandle))

proc columnCount*(table: RasterAttributeTable): int =
  int(GDALRATGetColumnCount(table.rawHandle))

proc setRowCount*(table: RasterAttributeTable, count: int) =
  if count < 0 or count > int(high(cint)):
    raise newException(ValueError, "row count out of range")
  GDALRATSetRowCount(table.rawHandle, cint(count))

proc addColumn*(
    table: RasterAttributeTable,
    name: string,
    fieldType: GDALRATFieldType,
    usage = GFU_Generic,
) =
  if '\0' in name:
    raise newException(ValueError, "column name contains a NUL byte")
  if GDALRATCreateColumn(table.rawHandle, name.cstring, fieldType, usage) != CE_None:
    raise gdalError("could not create raster attribute column")

proc column*(table: RasterAttributeTable, index: int): RasterColumn =
  if index < 0 or index >= table.columnCount:
    raise newException(IndexDefect, "column index out of range")
  let handle = table.rawHandle
  result = RasterColumn(
    name: $GDALRATGetNameOfCol(handle, cint(index)),
    fieldType: GDALRATGetTypeOfCol(handle, cint(index)),
    usage: GDALRATGetUsageOfCol(handle, cint(index)),
  )

proc checkCell(table: RasterAttributeTable, row, column: int) =
  if row < 0 or row >= table.rowCount or column < 0 or column >= table.columnCount:
    raise newException(IndexDefect, "raster attribute cell out of range")

proc stringValue*(table: RasterAttributeTable, row, column: int): string =
  table.checkCell(row, column)
  let value = GDALRATGetValueAsString(table.rawHandle, cint(row), cint(column))
  if value != nil:
    $value
  else:
    ""

proc intValue*(table: RasterAttributeTable, row, column: int): int =
  table.checkCell(row, column)
  int(GDALRATGetValueAsInt(table.rawHandle, cint(row), cint(column)))

proc floatValue*(table: RasterAttributeTable, row, column: int): float64 =
  table.checkCell(row, column)
  GDALRATGetValueAsDouble(table.rawHandle, cint(row), cint(column))

proc setValue*(table: RasterAttributeTable, row, column: int, value: string) =
  table.checkCell(row, column)
  if '\0' in value:
    raise newException(ValueError, "value contains a NUL byte")
  GDALRATSetValueAsString(table.rawHandle, cint(row), cint(column), value.cstring)

proc setValue*(table: RasterAttributeTable, row, column: int, value: int) =
  table.checkCell(row, column)
  if value < int(low(cint)) or value > int(high(cint)):
    raise newException(ValueError, "value out of range")
  GDALRATSetValueAsInt(table.rawHandle, cint(row), cint(column), cint(value))

proc setValue*(table: RasterAttributeTable, row, column: int, value: float64) =
  table.checkCell(row, column)
  GDALRATSetValueAsDouble(table.rawHandle, cint(row), cint(column), value)

proc statistics*(band: RasterBand, approximate = false): RasterStatistics =
  if GDALComputeRasterStatistics(
    band.rawHandle,
    cint(approximate),
    addr result.minimum,
    addr result.maximum,
    addr result.mean,
    addr result.standardDeviation,
    nil,
    nil,
  ) != CE_None:
    raise gdalError("could not compute raster statistics")

proc histogram*(
    band: RasterBand,
    minimum, maximum: float64,
    buckets: int,
    includeOutOfRange = false,
    approximate = false,
): seq[uint64] =
  if buckets <= 0 or buckets > int(high(cint)) or not (minimum < maximum):
    raise newException(ValueError, "invalid histogram bounds or bucket count")
  result = newSeq[uint64](buckets)
  if GDALGetRasterHistogramEx(
    band.rawHandle,
    minimum,
    maximum,
    cint(buckets),
    addr result[0],
    cint(includeOutOfRange),
    cint(approximate),
    nil,
    nil,
  ) != CE_None:
    raise gdalError("could not compute raster histogram")

proc overviewCount*(band: RasterBand): int =
  int(GDALGetOverviewCount(band.rawHandle))

type GroundControlPoint* = object
  id*, info*: string
  pixel*, line*, x*, y*, z*: float64

proc groundControlPoints*(dataset: Dataset): seq[GroundControlPoint] =
  ## Copy native ground control points and their strings into Nim storage.
  let handle = dataset.rawHandle
  let count = int(GDALGetGCPCount(handle))
  let points = cast[ptr UncheckedArray[GDAL_GCP]](GDALGetGCPs(handle))
  if count > 0 and points == nil:
    raise gdalError("could not get ground control points")
  result = newSeq[GroundControlPoint](count)
  for i in 0 ..< count:
    let p = points[i]
    result[i] = GroundControlPoint(
      id: (if p.pszId == nil: "" else: $p.pszId),
      info: (if p.pszInfo == nil: "" else: $p.pszInfo),
      pixel: p.dfGCPPixel,
      line: p.dfGCPLine,
      x: p.dfGCPX,
      y: p.dfGCPY,
      z: p.dfGCPZ,
    )

proc setGroundControlPoints*(
    dataset: Dataset, points: openArray[GroundControlPoint], projection = ""
) =
  ## GDAL copies the points and projection; inputs may be released after return.
  if points.len > int(high(cint)):
    raise newException(ValueError, "too many ground control points")
  if '\0' in projection:
    raise newException(ValueError, "projection contains a NUL byte")
  var native = newSeq[GDAL_GCP](points.len)
  for i, p in points:
    if '\0' in p.id or '\0' in p.info:
      raise newException(ValueError, "ground control point contains a NUL byte")
    native[i] = GDAL_GCP(
      pszId: p.id.cstring,
      pszInfo: p.info.cstring,
      dfGCPPixel: p.pixel,
      dfGCPLine: p.line,
      dfGCPX: p.x,
      dfGCPY: p.y,
      dfGCPZ: p.z,
    )
  let data =
    if native.len == 0:
      nil
    else:
      addr native[0]
  if GDALSetGCPs(dataset.rawHandle, cint(native.len), data, projection.cstring) !=
      CE_None:
    raise gdalError("could not set ground control points")

proc buildOverviews*(
    dataset: Dataset, factors: openArray[int], resampling = "NEAREST"
) =
  if '\0' in resampling:
    raise newException(ValueError, "resampling contains a NUL byte")
  if factors.len > int(high(cint)):
    raise newException(ValueError, "too many overview factors")
  var values = newSeq[cint](factors.len)
  for i, factor in factors:
    if factor <= 1 or factor > int(high(cint)):
      raise newException(ValueError, "invalid overview factor")
    values[i] = cint(factor)
  let data =
    if values.len == 0:
      nil
    else:
      addr values[0]
  if GDALBuildOverviews(
    dataset.rawHandle, resampling.cstring, cint(values.len), data, 0, nil, nil, nil
  ) != CE_None:
    raise gdalError("could not build overviews")
