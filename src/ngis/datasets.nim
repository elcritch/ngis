## Owning GDAL datasets. Borrowed bands and layers retain their dataset.
import ./gdal

type DatasetResource = object
  handle: GDALDatasetH

proc `=destroy`(resource: DatasetResource) =
  if resource.handle != nil:
    discard GDALReleaseDataset(resource.handle)

proc `=copy`(dest: var DatasetResource, source: DatasetResource) {.error.}
proc `=dup`(source: DatasetResource): DatasetResource {.error.}

type Dataset* = ref object
  resource: DatasetResource
  dependencies: seq[DatasetResource]

proc gdalError*(context: string): ref IOError =
  ## Adds the last native GDAL error to an operation's context.
  let detail = CPLGetLastErrorMsg()
  newException(
    IOError, context & (if detail == nil or detail[0] == '\0': ""
    else: ": " & $detail)
  )

proc rawHandle*(dataset: Dataset): GDALDatasetH =
  ## Borrows the native handle; do not close it or retain it beyond this owner.
  if dataset == nil or dataset.resource.handle == nil:
    raise newException(ValueError, "dataset is closed")
  dataset.resource.handle

proc wrapDataset*(handle: GDALDatasetH, dependencies: seq[Dataset] = @[]): Dataset =
  ## Takes ownership of a native handle and keeps any source datasets alive.
  if handle == nil:
    raise gdalError("could not create dataset")
  result = Dataset(resource: DatasetResource(handle: handle))
  for dependency in dependencies:
    let source = dependency.rawHandle
    discard GDALReferenceDataset(source)
    result.dependencies.add DatasetResource(handle: source)

proc isClosed*(dataset: Dataset): bool =
  ## Reports whether the shared owner has been explicitly closed.
  dataset == nil or dataset.resource.handle == nil

proc close*(dataset: Dataset) =
  ## Closes this dataset for every alias; repeated closes are harmless.
  if not dataset.isClosed:
    let handle = dataset.resource.handle
    dataset.resource.handle = nil
    CPLErrorReset()
    let code = GDALFlushCache(handle)
    let failure =
      if code != CE_None:
        gdalError("could not close dataset")
      else:
        nil
    discard GDALReleaseDataset(handle)
    dataset.dependencies.setLen(0)
    if failure != nil:
      raise failure

proc openDataset*(path: string, update = false, raster = true, vector = true): Dataset =
  ## Opens raster or vector data. The returned owner closes automatically.
  if '\0' in path:
    raise newException(ValueError, "dataset path contains a NUL byte")
  if not raster and not vector:
    raise newException(ValueError, "enable raster or vector access")
  GDALAllRegister()
  CPLErrorReset()
  var flags = cuint(GDAL_OF_READONLY)
  if update:
    flags = flags or GDAL_OF_UPDATE
  if raster:
    flags = flags or GDAL_OF_RASTER
  if vector:
    flags = flags or GDAL_OF_VECTOR
  wrapDataset(GDALOpenEx(path.cstring, flags, nil, nil, nil))

proc createDataset*(
    driverName, path: string,
    width, height: int,
    bands = 1,
    dataType: GDALDataType = GDT_Byte,
    options: openArray[string] = [],
): Dataset =
  ## Creates a dataset; zero dimensions and bands permit vector-only drivers.
  if width < 0 or height < 0 or bands < 0 or width > int(high(cint)) or
      height > int(high(cint)) or bands > int(high(cint)):
    raise newException(ValueError, "dataset dimensions exceed the GDAL integer range")
  if '\0' in driverName or '\0' in path:
    raise newException(ValueError, "driver or path contains a NUL byte")
  for option in options:
    if '\0' in option:
      raise newException(ValueError, "creation option contains a NUL byte")
  GDALAllRegister()
  CPLErrorReset()
  let driver = GDALGetDriverByName(driverName.cstring)
  if driver == nil:
    raise newException(ValueError, "unknown GDAL driver: " & driverName)
  let args = allocCStringArray(options)
  defer:
    deallocCStringArray(args)
  wrapDataset(
    GDALCreate(
      driver, path.cstring, cint(width), cint(height), cint(bands), dataType, args
    )
  )

proc size*(dataset: Dataset): tuple[width, height: int] =
  ## Returns the raster dimensions (zero for a vector-only dataset).
  let handle = dataset.rawHandle
  (int(GDALGetRasterXSize(handle)), int(GDALGetRasterYSize(handle)))

proc bandCount*(dataset: Dataset): int =
  ## Returns the number of raster bands.
  int(GDALGetRasterCount(dataset.rawHandle))

proc flush*(dataset: Dataset) =
  ## Flushes native caches and reports write failures.
  if GDALFlushCache(dataset.rawHandle) != CE_None:
    raise gdalError("could not flush dataset")
