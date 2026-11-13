## Owning schema domains, relationships, and coordinate-operation options.
import ./api
import ./datasets
import ./spatialrefs
import ./private/resources

type
  FieldDomain* = ref object
    resource: NativeResource[OGRFieldDomainH]

  Relationship* = ref object
    resource: NativeResource[GDALRelationshipH]

  CoordinateOptions* = ref object
    resource: NativeResource[OGRCoordinateTransformationOptionsH]

  CodedValue* = object
    code*, value*: string

proc releaseDomain(h: OGRFieldDomainH) {.nimcall, raises: [].} =
  OGR_FldDomain_Destroy(h)

proc releaseRelationship(h: GDALRelationshipH) {.nimcall, raises: [].} =
  GDALDestroyRelationship(h)

proc releaseCoordinateOptions(
    h: OGRCoordinateTransformationOptionsH
) {.nimcall, raises: [].} =
  OCTDestroyCoordinateTransformationOptions(h)

template ownerMethods(T, H: typedesc) =
  proc rawHandle*(owner: T): H =
    if owner == nil:
      raise newException(ValueError, "GDAL resource is closed")
    rawHandle(owner.resource)

  proc close*(owner: T) =
    if owner != nil:
      close(owner.resource)

ownerMethods(FieldDomain, OGRFieldDomainH)
ownerMethods(Relationship, GDALRelationshipH)
ownerMethods(CoordinateOptions, OGRCoordinateTransformationOptionsH)

proc adoptFieldDomain*(handle: OGRFieldDomainH): FieldDomain =
  ## Takes ownership of an independently owned native field-domain handle.
  FieldDomain(resource: newNativeResource(handle, releaseDomain))

proc adoptRelationship*(handle: GDALRelationshipH): Relationship =
  ## Takes ownership of an independently owned native relationship handle.
  Relationship(resource: newNativeResource(handle, releaseRelationship))

proc adoptCoordinateOptions*(
    handle: OGRCoordinateTransformationOptionsH
): CoordinateOptions =
  ## Takes ownership of native coordinate transformation options.
  CoordinateOptions(resource: newNativeResource(handle, releaseCoordinateOptions))

proc newCodedDomain*(
    name: string,
    values: openArray[CodedValue],
    description = "",
    fieldType = OFTString,
    fieldSubtype = OFSTNone,
): FieldDomain =
  validateCString(name, "domain name")
  validateCString(description, "domain description")
  var entries = newSeq[OGRCodedValue](values.len + 1)
  for i, value in values:
    validateCString(value.code, "domain code")
    validateCString(value.value, "domain value")
    for j in 0 ..< i:
      if values[j].code == value.code:
        raise newException(ValueError, "duplicate domain code")
    entries[i] =
      OGRCodedValue(pszCode: value.code.cstring, pszValue: value.value.cstring)
  let h = OGR_CodedFldDomain_Create(
    name.cstring, description.cstring, fieldType, fieldSubtype, addr entries[0]
  )
  if h == nil:
    raise gdalError("could not create coded domain")
  adoptFieldDomain(h)

proc newGlobDomain*(name, expression: string, description = ""): FieldDomain =
  validateCString(name, "domain name")
  validateCString(expression, "glob expression")
  validateCString(description, "domain description")
  let h = OGR_GlobFldDomain_Create(
    name.cstring, description.cstring, OFTString, OFSTNone, expression.cstring
  )
  if h == nil:
    raise gdalError("could not create glob domain")
  adoptFieldDomain(h)

proc newRangeDomain*(
    name: string,
    minimum, maximum: float64,
    minimumInclusive = true,
    maximumInclusive = true,
    description = "",
): FieldDomain =
  validateCString(name, "domain name")
  validateCString(description, "domain description")
  if minimum > maximum:
    raise newException(ValueError, "domain minimum exceeds maximum")
  var lo = OGRField(Real: minimum)
  var hi = OGRField(Real: maximum)
  let h = OGR_RangeFldDomain_Create(
    name.cstring,
    description.cstring,
    OFTReal,
    OFSTNone,
    addr lo,
    minimumInclusive,
    addr hi,
    maximumInclusive,
  )
  if h == nil:
    raise gdalError("could not create range domain")
  adoptFieldDomain(h)

proc name*(domain: FieldDomain): string =
  $OGR_FldDomain_GetName(rawHandle(domain))

proc description*(domain: FieldDomain): string =
  $OGR_FldDomain_GetDescription(rawHandle(domain))

proc kind*(domain: FieldDomain): OGRFieldDomainType =
  OGR_FldDomain_GetDomainType(rawHandle(domain))

proc glob*(domain: FieldDomain): string =
  let s = OGR_GlobFldDomain_GetGlob(rawHandle(domain))
  if s == nil:
    raise newException(ValueError, "domain is not a glob domain")
  $s

proc codedValues*(domain: FieldDomain): seq[CodedValue] =
  let p = OGR_CodedFldDomain_GetEnumeration(rawHandle(domain))
  if p == nil:
    raise newException(ValueError, "domain is not a coded domain")
  let entries = cast[ptr UncheckedArray[OGRCodedValue]](p)
  var i = 0
  while entries[i].pszCode != nil:
    result.add CodedValue(
      code: $entries[i].pszCode,
      value:
        if entries[i].pszValue == nil:
          ""
        else:
          $entries[i].pszValue,
    )
    inc i

proc newRelationship*(
    name, leftTable, rightTable: string, cardinality = GRC_ONE_TO_MANY
): Relationship =
  validateCString(name, "relationship name")
  validateCString(leftTable, "left table")
  validateCString(rightTable, "right table")
  let h = GDALRelationshipCreate(
    name.cstring, leftTable.cstring, rightTable.cstring, cardinality
  )
  if h == nil:
    raise gdalError("could not create relationship")
  adoptRelationship(h)

proc name*(relationship: Relationship): string =
  $GDALRelationshipGetName(rawHandle(relationship))

proc leftTable*(relationship: Relationship): string =
  $GDALRelationshipGetLeftTableName(rawHandle(relationship))

proc rightTable*(relationship: Relationship): string =
  $GDALRelationshipGetRightTableName(rawHandle(relationship))

proc cardinality*(relationship: Relationship): GDALRelationshipCardinality =
  GDALRelationshipGetCardinality(rawHandle(relationship))

proc setLeftFields*(relationship: Relationship, names: openArray[string]) =
  for name in names:
    validateCString(name, "field name")
  let args = allocCStringArray(names)
  defer:
    deallocCStringArray(args)
  GDALRelationshipSetLeftTableFields(rawHandle(relationship), args)

proc setRightFields*(relationship: Relationship, names: openArray[string]) =
  for name in names:
    validateCString(name, "field name")
  let args = allocCStringArray(names)
  defer:
    deallocCStringArray(args)
  GDALRelationshipSetRightTableFields(rawHandle(relationship), args)

proc leftFields*(relationship: Relationship): seq[string] =
  let list = GDALRelationshipGetLeftTableFields(rawHandle(relationship))
  defer:
    CSLDestroy(list)
  copyStrings(list)

proc rightFields*(relationship: Relationship): seq[string] =
  let list = GDALRelationshipGetRightTableFields(rawHandle(relationship))
  defer:
    CSLDestroy(list)
  copyStrings(list)

proc newCoordinateOptions*(): CoordinateOptions =
  adoptCoordinateOptions(OCTNewCoordinateTransformationOptions())

proc setAreaOfInterest*(options: CoordinateOptions, west, south, east, north: float64) =
  if OCTCoordinateTransformationOptionsSetAreaOfInterest(
    rawHandle(options), west, south, east, north
  ) == 0:
    raise gdalError("invalid coordinate area of interest")

proc setDesiredAccuracy*(options: CoordinateOptions, accuracy: float64) =
  if OCTCoordinateTransformationOptionsSetDesiredAccuracy(rawHandle(options), accuracy) ==
      0:
    raise gdalError("invalid coordinate accuracy")

proc setBallparkAllowed*(options: CoordinateOptions, allowed: bool) =
  if OCTCoordinateTransformationOptionsSetBallparkAllowed(
    rawHandle(options), cint(allowed)
  ) == 0:
    raise gdalError("could not set ballpark policy")

proc setOnlyBest*(options: CoordinateOptions, onlyBest: bool) =
  if OCTCoordinateTransformationOptionsSetOnlyBest(rawHandle(options), onlyBest) == 0:
    raise gdalError("could not set best operation policy")

proc setOperation*(options: CoordinateOptions, operation: string, inverse = false) =
  validateCString(operation, "coordinate operation")
  if OCTCoordinateTransformationOptionsSetOperation(
    rawHandle(options), operation.cstring, cint(inverse)
  ) == 0:
    raise gdalError("invalid coordinate operation")

type
  CrsInfo* = object
    authority*, code*, name*, areaName*, projectionMethod*, celestialBody*: string
    kind*: OSRCRSType
    deprecated*, hasBounds*: bool
    west*, south*, east*, north*: float64

  CrsMatch* = object
    wkt*: string
    confidence*: int

  CoordinateOperation* = ref object
    resource: NativeResource[OGRCoordinateTransformationH]

proc releaseCoordinateOperation(
    h: OGRCoordinateTransformationH
) {.nimcall, raises: [].} =
  OCTDestroyCoordinateTransformation(h)

ownerMethods(CoordinateOperation, OGRCoordinateTransformationH)

proc newCoordinateOperation*(
    source, target: SpatialReference, options: CoordinateOptions
): CoordinateOperation =
  let h = OCTNewCoordinateTransformationEx(
    source.rawHandle, target.rawHandle, options.rawHandle
  )
  if h == nil:
    raise gdalError("could not create coordinate operation")
  CoordinateOperation(resource: newNativeResource(h, releaseCoordinateOperation))

proc transform*(operation: CoordinateOperation, x, y, z: var float64) =
  if OCTTransform(rawHandle(operation), 1, addr x, addr y, addr z) == 0:
    raise gdalError("coordinate operation failed")

proc copiedString(s: cstring): string =
  if s == nil:
    ""
  else:
    $s

proc crsAuthorities*(): seq[string] =
  let list = OSRGetAuthorityListFromDatabase()
  defer:
    CSLDestroy(list)
  copyStrings(list)

proc crsInfo*(authority = "EPSG"): seq[CrsInfo] =
  ## Copies CRS records out of PROJ's local database and frees the native list.
  validateCString(authority, "CRS authority")
  var count: cint
  let list = OSRGetCRSInfoListFromDatabase(authority.cstring, nil, addr count)
  if list == nil:
    raise gdalError("could not read CRS database")
  defer:
    OSRDestroyCRSInfoList(list)
  let records = cast[ptr UncheckedArray[ptr OSRCRSInfo]](list)
  for i in 0 ..< int(count):
    let p = records[i]
    result.add CrsInfo(
      authority: copiedString(p.pszAuthName),
      code: copiedString(p.pszCode),
      name: copiedString(p.pszName),
      areaName: copiedString(p.pszAreaName),
      projectionMethod: copiedString(p.pszProjectionMethod),
      celestialBody: copiedString(p.pszCelestialBodyName),
      kind: p.eType,
      deprecated: p.bDeprecated != 0,
      hasBounds: p.bBboxValid != 0,
      west: p.dfWestLongitudeDeg,
      south: p.dfSouthLatitudeDeg,
      east: p.dfEastLongitudeDeg,
      north: p.dfNorthLatitudeDeg,
    )

proc crsMatches*(reference: SpatialReference): seq[CrsMatch] =
  ## Copies candidate definitions and confidence values before freeing native arrays.
  var count: cint
  var confidence: ptr cint
  let list = OSRFindMatches(reference.rawHandle, nil, addr count, addr confidence)
  defer:
    if list != nil:
      OSRFreeSRSArray(list)
    if confidence != nil:
      CPLFree(confidence)
  if list == nil:
    return @[]
  let references = cast[ptr UncheckedArray[OGRSpatialReferenceH]](list)
  let scores = cast[ptr UncheckedArray[cint]](confidence)
  for i in 0 ..< int(count):
    var wkt: cstring
    defer:
      CPLFree(wkt)
    if OSRExportToWkt(references[i], cast[cstringArray](addr wkt)) != OGRERR_NONE:
      raise gdalError("could not export CRS match")
    result.add CrsMatch(wkt: copiedString(wkt), confidence: int(scores[i]))

proc failure(reason: cstring, context: string): ref IOError =
  newException(IOError, context & (if reason == nil: "" else: ": " & $reason))

proc fieldDomainNames*(dataset: Dataset): seq[string] =
  let names = GDALDatasetGetFieldDomainNames(dataset.rawHandle, nil)
  defer:
    CSLDestroy(names)
  copyStrings(names)

proc relationshipNames*(dataset: Dataset): seq[string] =
  let names = GDALDatasetGetRelationshipNames(dataset.rawHandle, nil)
  defer:
    CSLDestroy(names)
  copyStrings(names)

proc add*(dataset: Dataset, domain: FieldDomain) =
  var reason: cstring
  defer:
    CPLFree(reason)
  if not GDALDatasetAddFieldDomain(
    dataset.rawHandle, domain.rawHandle, cast[cstringArray](addr reason)
  ):
    raise failure(reason, "could not add field domain")

proc update*(dataset: Dataset, domain: FieldDomain) =
  var reason: cstring
  defer:
    CPLFree(reason)
  if not GDALDatasetUpdateFieldDomain(
    dataset.rawHandle, domain.rawHandle, cast[cstringArray](addr reason)
  ):
    raise failure(reason, "could not update field domain")

proc deleteFieldDomain*(dataset: Dataset, name: string) =
  validateCString(name, "domain name")
  var reason: cstring
  defer:
    CPLFree(reason)
  if not GDALDatasetDeleteFieldDomain(
    dataset.rawHandle, name.cstring, cast[cstringArray](addr reason)
  ):
    raise failure(reason, "could not delete field domain")

proc add*(dataset: Dataset, relationship: Relationship) =
  var reason: cstring
  defer:
    CPLFree(reason)
  if not GDALDatasetAddRelationship(
    dataset.rawHandle, relationship.rawHandle, cast[cstringArray](addr reason)
  ):
    raise failure(reason, "could not add relationship")

proc update*(dataset: Dataset, relationship: Relationship) =
  var reason: cstring
  defer:
    CPLFree(reason)
  if not GDALDatasetUpdateRelationship(
    dataset.rawHandle, relationship.rawHandle, cast[cstringArray](addr reason)
  ):
    raise failure(reason, "could not update relationship")

proc deleteRelationship*(dataset: Dataset, name: string) =
  validateCString(name, "relationship name")
  var reason: cstring
  defer:
    CPLFree(reason)
  if not GDALDatasetDeleteRelationship(
    dataset.rawHandle, name.cstring, cast[cstringArray](addr reason)
  ):
    raise failure(reason, "could not delete relationship")
