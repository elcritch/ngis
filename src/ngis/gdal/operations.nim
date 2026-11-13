## Owning wrappers around GDAL's utility operations.
import ./api
import ./datasets

proc validateDestination(destination: string) =
  if '\0' in destination:
    raise newException(ValueError, "GDAL destinations cannot contain NUL bytes")

proc optionArgs(options: openArray[string]): seq[cstring] =
  ## The strings remain owned by the caller throughout each GDAL call.
  result = newSeqOfCap[cstring](options.len + 1)
  for option in options:
    if '\0' in option:
      raise newException(ValueError, "GDAL options cannot contain NUL bytes")
    result.add option.cstring
  result.add nil

proc invalidOptions(operation: string): ref ValueError =
  let message = CPLGetLastErrorMsg()
  let detail =
    if message == nil:
      ""
    else:
      $message
  newException(
    ValueError,
    "invalid " & operation & " options" & (if detail.len > 0: ": " & detail
    else: ""),
  )

proc checkedResult(
    handle: GDALDatasetH,
    usageError: cint,
    operation: string,
    dependencies: seq[Dataset],
): Dataset =
  if usageError != 0:
    let error = invalidOptions(operation)
    if handle != nil:
      discard GDALClose(handle)
    raise error
  if handle == nil:
    let message = CPLGetLastErrorMsg()
    let detail =
      if message == nil:
        ""
      else:
        $message
    raise newException(
      IOError, operation & " failed" & (if detail.len > 0: ": " & detail
      else: "")
    )
  result = wrapDataset(handle, dependencies)

proc translate*(
    source: Dataset, destination: string, options: openArray[string] = []
): Dataset =
  ## Translate a raster dataset. The returned dataset owns its GDAL handle.
  let src = rawHandle(source)
  validateDestination(destination)
  var args = optionArgs(options)
  CPLErrorReset()
  let opts = GDALTranslateOptionsNew(cast[cstringArray](addr args[0]), nil)
  if opts == nil:
    raise invalidOptions("translate")
  defer:
    GDALTranslateOptionsFree(opts)
  var usageError: cint
  CPLErrorReset()
  let handle = GDALTranslate(destination.cstring, src, opts, addr usageError)
  checkedResult(handle, usageError, "translate", @[source])

proc warp*(
    sources: openArray[Dataset], destination: string, options: openArray[string] = []
): Dataset =
  ## Warp one or more raster datasets into a new dataset.
  if sources.len == 0:
    raise newException(ValueError, "warp requires at least one source")
  if sources.len > int(high(cint)):
    raise newException(ValueError, "too many warp sources")
  var handles = newSeqOfCap[GDALDatasetH](sources.len)
  for source in sources:
    handles.add rawHandle(source)
  validateDestination(destination)
  var args = optionArgs(options)
  CPLErrorReset()
  let opts = GDALWarpAppOptionsNew(cast[cstringArray](addr args[0]), nil)
  if opts == nil:
    raise invalidOptions("warp")
  defer:
    GDALWarpAppOptionsFree(opts)
  var usageError: cint
  CPLErrorReset()
  let handle = GDALWarp(
    destination.cstring, nil, cint(handles.len), addr handles[0], opts, addr usageError
  )
  checkedResult(handle, usageError, "warp", @sources)

proc vectorTranslate*(
    source: Dataset, destination: string, options: openArray[string] = []
): Dataset =
  ## Translate a vector dataset into a new dataset.
  var src = rawHandle(source)
  validateDestination(destination)
  var args = optionArgs(options)
  CPLErrorReset()
  let opts = GDALVectorTranslateOptionsNew(cast[cstringArray](addr args[0]), nil)
  if opts == nil:
    raise invalidOptions("vector translate")
  defer:
    GDALVectorTranslateOptionsFree(opts)
  var usageError: cint
  CPLErrorReset()
  let handle =
    GDALVectorTranslate(destination.cstring, nil, 1, addr src, opts, addr usageError)
  checkedResult(handle, usageError, "vector translate", @[source])

proc rasterize*(
    source: Dataset, destination: string, options: openArray[string] = []
): Dataset =
  ## Rasterize a vector dataset into a new raster dataset.
  let src = rawHandle(source)
  validateDestination(destination)
  var args = optionArgs(options)
  CPLErrorReset()
  let opts = GDALRasterizeOptionsNew(cast[cstringArray](addr args[0]), nil)
  if opts == nil:
    raise invalidOptions("rasterize")
  defer:
    GDALRasterizeOptionsFree(opts)
  var usageError: cint
  CPLErrorReset()
  let handle = GDALRasterize(destination.cstring, nil, src, opts, addr usageError)
  checkedResult(handle, usageError, "rasterize", @[source])

proc grid*(
    source: Dataset, destination: string, options: openArray[string] = []
): Dataset =
  ## Grid a vector dataset into a new raster dataset.
  let src = rawHandle(source)
  validateDestination(destination)
  var args = optionArgs(options)
  CPLErrorReset()
  let opts = GDALGridOptionsNew(cast[cstringArray](addr args[0]), nil)
  if opts == nil:
    raise invalidOptions("grid")
  defer:
    GDALGridOptionsFree(opts)
  var usageError: cint
  CPLErrorReset()
  let handle = GDALGrid(destination.cstring, src, opts, addr usageError)
  checkedResult(handle, usageError, "grid", @[source])

proc buildVrt*(
    sources: openArray[Dataset], destination: string, options: openArray[string] = []
): Dataset =
  ## Build a VRT and retain the source datasets while it remains open.
  ## The VRT keeps a native reference even if a source wrapper is closed.
  if sources.len == 0:
    raise newException(ValueError, "buildVrt requires at least one source")
  if sources.len > int(high(cint)):
    raise newException(ValueError, "too many VRT sources")
  var handles = newSeqOfCap[GDALDatasetH](sources.len)
  for source in sources:
    handles.add rawHandle(source)
  validateDestination(destination)
  var args = optionArgs(options)
  CPLErrorReset()
  let opts = GDALBuildVRTOptionsNew(cast[cstringArray](addr args[0]), nil)
  if opts == nil:
    raise invalidOptions("VRT")
  defer:
    GDALBuildVRTOptionsFree(opts)
  var usageError: cint
  CPLErrorReset()
  let handle = GDALBuildVRT(
    destination.cstring, cint(handles.len), addr handles[0], nil, opts, addr usageError
  )
  checkedResult(handle, usageError, "build VRT", @sources)
