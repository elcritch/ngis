## Dataset opening, metadata and coordinate properties using Nim values.
import std/[options, strutils, tables]
import ./[gdal, datasets, drivers, raster, vector, spatialrefs, coordinates]
import ./private/resources

type
  DatasetAccess* {.pure.} = enum
    readOnly
    readWrite

  DatasetKind* {.pure.} = enum
    raster
    vector
    multidimensional

  DatasetOpenOptions* = object
    ## Driver names and options are copied and only borrowed by GDAL during open.
    access*: DatasetAccess
    kinds*: set[DatasetKind]
    allowedDrivers*: seq[string]
    driverOptions*: seq[string]
    siblingFiles*: seq[string]

proc initDatasetOpenOptions*(
    access = DatasetAccess.readOnly,
    kinds = {DatasetKind.raster, DatasetKind.vector},
    allowedDrivers: openArray[string] = [],
    driverOptions: openArray[string] = [],
    siblingFiles: openArray[string] = [],
): DatasetOpenOptions =
  ## Constructs options for raster/vector access by default.
  if kinds == {}:
    raise newException(ValueError, "enable at least one dataset kind")
  DatasetOpenOptions(
    access: access,
    kinds: kinds,
    allowedDrivers: @allowedDrivers,
    driverOptions: @driverOptions,
    siblingFiles: @siblingFiles,
  )

proc stringArgs(values: openArray[string]): cstringArray =
  for value in values:
    validateCString(value, "dataset open option")
  allocCStringArray(values)

proc openDataset*(path: string, options: DatasetOpenOptions): Dataset =
  ## Opens a dataset with an explicit access mode, driver filter and driver options.
  validateCString(path, "dataset path")
  if options.kinds == {}:
    raise newException(ValueError, "enable at least one dataset kind")
  var flags = cuint(GDAL_OF_READONLY)
  if options.access == DatasetAccess.readWrite:
    flags = flags or GDAL_OF_UPDATE
  if DatasetKind.raster in options.kinds:
    flags = flags or GDAL_OF_RASTER
  if DatasetKind.vector in options.kinds:
    flags = flags or GDAL_OF_VECTOR
  if DatasetKind.multidimensional in options.kinds:
    flags = flags or GDAL_OF_MULTIDIM_RASTER
  let allowed = stringArgs(options.allowedDrivers)
  defer:
    deallocCStringArray(allowed)
  let arguments = stringArgs(options.driverOptions)
  defer:
    deallocCStringArray(arguments)
  let siblings = stringArgs(options.siblingFiles)
  defer:
    deallocCStringArray(siblings)
  GDALAllRegister()
  CPLErrorReset()
  wrapDataset(GDALOpenEx(path.cstring, flags, allowed, arguments, siblings))

proc openRaster*(
    path: string,
    update = false,
    allowedDrivers: openArray[string] = [],
    options: openArray[string] = [],
): Dataset =
  ## Opens raster data without considering vector-only drivers.
  openDataset(
    path,
    initDatasetOpenOptions(
      access = (if update: DatasetAccess.readWrite else: DatasetAccess.readOnly),
      kinds = {DatasetKind.raster},
      allowedDrivers = allowedDrivers,
      driverOptions = options,
    ),
  )

proc openVector*(
    path: string,
    update = false,
    allowedDrivers: openArray[string] = [],
    options: openArray[string] = [],
): Dataset =
  ## Opens vector data without considering raster-only drivers.
  openDataset(
    path,
    initDatasetOpenOptions(
      access = (if update: DatasetAccess.readWrite else: DatasetAccess.readOnly),
      kinds = {DatasetKind.vector},
      allowedDrivers = allowedDrivers,
      driverOptions = options,
    ),
  )

proc createVector*(
    driver = "MEM", path = "", options: openArray[string] = []
): Dataset =
  ## Creates vector data, using the in-memory driver by default.
  createDataset(driver, path, 0, 0, bands = 0, options = options)

proc driver*(dataset: Dataset): DriverInfo =
  ## Returns the registered driver used by this dataset.
  let handle = GDALGetDatasetDriver(dataset.rawHandle)
  if handle == nil:
    raise gdalError("dataset has no driver")
  driverInfo($GDALGetDriverShortName(handle))

proc files*(dataset: Dataset): seq[string] =
  ## Copies the driver's list of associated files.
  let values = GDALGetFileList(dataset.rawHandle)
  defer:
    CSLDestroy(values)
  copyStrings(values)

proc description*(target: Dataset | RasterBand): string =
  $GDALGetDescription(target.rawHandle)

proc `description=`*(target: Dataset | RasterBand, value: string) =
  validateCString(value, "description")
  GDALSetDescription(target.rawHandle, value.cstring)

proc metadataDomains*(target: Dataset | RasterBand): seq[string] =
  ## Returns independent copies of the available metadata domain names.
  let values = GDALGetMetadataDomainList(target.rawHandle)
  defer:
    CSLDestroy(values)
  copyStrings(values)

proc metadataValues*(target: Dataset | RasterBand, domain = ""): seq[string] =
  ## Copies native metadata verbatim, including XML domains without key/value pairs.
  validateCString(domain, "metadata domain")
  copyStrings(GDALGetMetadata(target.rawHandle, domain.cstring))

proc metadataItems*(
    target: Dataset | RasterBand, domain = ""
): OrderedTable[string, string] =
  ## Copies a key/value domain into a table. Use metadataValues for XML domains.
  result = initOrderedTable[string, string]()
  for value in target.metadataValues(domain):
    let separator = value.find('=')
    if separator < 0:
      raise newException(ValueError, "metadata domain contains non-key/value entries")
    result[value[0 ..< separator]] = value[separator + 1 .. ^1]

proc checkedKey(name: string) =
  validateCString(name, "metadata name")
  if name.len == 0 or '=' in name:
    raise newException(ValueError, "metadata names must be nonempty and exclude '='")

proc metadata*(dataset: Dataset, name: string, domain = ""): Option[string] =
  checkedKey(name)
  validateCString(domain, "metadata domain")
  let value = GDALGetMetadataItem(dataset.rawHandle, name.cstring, domain.cstring)
  if value != nil:
    some($value)
  else:
    none(string)

proc setMetadata*(dataset: Dataset, name, value: string, domain = "") =
  checkedKey(name)
  validateCString(value, "metadata value")
  validateCString(domain, "metadata domain")
  if GDALSetMetadataItem(dataset.rawHandle, name.cstring, value.cstring, domain.cstring) !=
      CE_None:
    raise gdalError("could not set dataset metadata")

proc checkMetadataStatus(status: CPLErr) =
  if status != CE_None:
    raise gdalError("could not delete metadata")

proc deleteMetadata*(target: Dataset | RasterBand, name: string, domain = "") =
  checkedKey(name)
  validateCString(domain, "metadata domain")
  checkMetadataStatus(
    GDALSetMetadataItem(target.rawHandle, name.cstring, nil, domain.cstring)
  )

proc spatialReference*(dataset: Dataset): SpatialReference =
  ## Returns an independent CRS clone. Missing CRS raises ValueError.
  let handle = GDALGetSpatialRef(dataset.rawHandle)
  if handle == nil:
    raise newException(ValueError, "dataset has no spatial reference")
  let cloned = OSRClone(handle)
  if cloned == nil:
    raise gdalError("could not clone dataset spatial reference")
  adoptSpatialReference(cloned)

proc `spatialReference=`*(dataset: Dataset, reference: SpatialReference) =
  ## Assigns a CRS without reprojecting pixels; GDAL copies its definition.
  let handle = if reference == nil: nil else: reference.rawHandle
  if GDALSetSpatialRef(dataset.rawHandle, handle) != CE_None:
    raise gdalError("could not set dataset spatial reference")

proc affineTransform*(dataset: Dataset): AffineTransform =
  ## Describes pixel-corner coordinates. Add 0.5 to address pixel centers.
  toAffineTransform(dataset.geoTransform)

proc `affineTransform=`*(dataset: Dataset, transform: AffineTransform) =
  dataset.geoTransform = transform.toArray

iterator bands*(dataset: Dataset): RasterBand =
  ## Visits one-based raster bands. Each view retains the dataset owner.
  for index in 1 .. dataset.bandCount:
    yield dataset.band(index)
