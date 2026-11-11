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
    OSRDestroySpatialReference(x.handle)

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
