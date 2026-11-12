## Owned spatial references and coordinate transformations.
import ./gdal

type
  SpatialReferenceObj = object
    handle: OGRSpatialReferenceH

  SpatialReference* = ref SpatialReferenceObj
  CoordinateTransformObj = object
    handle: OGRCoordinateTransformationH

  CoordinateTransform* = ref CoordinateTransformObj

proc `=destroy`(x: SpatialReferenceObj) =
  if x.handle != nil:
    OSRRelease(x.handle)

proc `=destroy`(x: CoordinateTransformObj) =
  if x.handle != nil:
    OCTDestroyCoordinateTransformation(x.handle)

proc `=copy`(dest: var SpatialReferenceObj, source: SpatialReferenceObj) {.error.}
proc `=dup`(source: SpatialReferenceObj): SpatialReferenceObj {.error.}
proc `=copy`(dest: var CoordinateTransformObj, source: CoordinateTransformObj) {.error.}
proc `=dup`(source: CoordinateTransformObj): CoordinateTransformObj {.error.}

proc rawHandle*(s: SpatialReference): OGRSpatialReferenceH =
  if s == nil or s.handle == nil:
    raise newException(ValueError, "invalid spatial reference")
  s.handle

proc rawHandle*(t: CoordinateTransform): OGRCoordinateTransformationH =
  if t == nil or t.handle == nil:
    raise newException(ValueError, "invalid coordinate transformation")
  t.handle

proc close*(s: SpatialReference) =
  ## Drops this shared owner's reference; native geometries may retain the CRS.
  if s != nil and s.handle != nil:
    let handle = s.handle
    s.handle = nil
    OSRRelease(handle)

proc close*(t: CoordinateTransform) =
  if t != nil and t.handle != nil:
    let handle = t.handle
    t.handle = nil
    OCTDestroyCoordinateTransformation(handle)

proc adoptSpatialReference*(handle: OGRSpatialReferenceH): SpatialReference =
  ## Takes ownership of one native CRS reference. Borrowed handles need OSRReference first.
  if handle == nil:
    raise newException(ValueError, "invalid spatial reference")
  SpatialReference(handle: handle)

proc newSpatialReference*(definition: string): SpatialReference =
  ## Parses an EPSG name, WKT, PROJ string, or another GDAL-supported CRS definition.
  if '\0' in definition:
    raise newException(ValueError, "CRS definition contains a NUL byte")
  result = adoptSpatialReference(OSRNewSpatialReference(nil))
  if OSRSetFromUserInput(result.handle, definition.cstring) != OGRERR_NONE:
    raise newException(ValueError, "invalid CRS definition")

proc toWkt*(s: SpatialReference): string =
  var value: cstring
  if OSRExportToWkt(s.rawHandle, cast[cstringArray](addr value)) != OGRERR_NONE:
    raise newException(IOError, "could not export CRS as WKT")
  defer:
    VSIFree(value)
  $value

proc axisMappingStrategy*(s: SpatialReference): OSRAxisMappingStrategy =
  OSRGetAxisMappingStrategy(s.rawHandle)

proc `axisMappingStrategy=`*(s: SpatialReference, strategy: OSRAxisMappingStrategy) =
  OSRSetAxisMappingStrategy(s.rawHandle, strategy)

proc newSpatialReference*(epsg: int): SpatialReference =
  ## Creates an owned spatial reference from an EPSG code.
  if epsg < 0 or epsg > int(high(cint)):
    raise newException(ValueError, "EPSG code is out of range")
  new(result)
  result.handle = OSRNewSpatialReference(nil)
  if result.handle == nil:
    raise newException(IOError, "could not create spatial reference")
  if OSRImportFromEPSG(result.handle, cint(epsg)) != OGRERR_NONE:
    raise newException(ValueError, "could not import EPSG:" & $epsg)

proc clone*(s: SpatialReference): SpatialReference =
  new(result)
  result.handle = OSRClone(s.rawHandle)
  if result.handle == nil:
    raise newException(IOError, "could not clone spatial reference")

proc newCoordinateTransform*(source, target: SpatialReference): CoordinateTransform =
  ## GDAL owns the transformation independently of the input references.
  new(result)
  result.handle = OCTNewCoordinateTransformation(source.rawHandle, target.rawHandle)
  if result.handle == nil:
    raise newException(ValueError, "could not create coordinate transformation")

proc transform*(t: CoordinateTransform, x, y: var float64, z: var float64) =
  if OCTTransform(t.rawHandle, 1, addr x, addr y, addr z) == 0:
    raise newException(ValueError, "coordinate transformation failed")
