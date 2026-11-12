## Typed raster conversion and reprojection with synchronous Nim progress callbacks.
import std/[math, options]
import ./[gdal, datasets, rasterio, spatialrefs, coordinates, utilities]
import ./private/resources

type
  RasterOutputSize* = object
    width*, height*: int

  TranslateConfig* = object
    ## Unspecified sizes, windows and nodata preserve the source values.
    ## An empty driver selects MEM for an empty destination, or filename inference.
    driver*: string
    bands*: seq[int]
    window*: Option[RasterWindow]
    outputSize*: Option[RasterOutputSize]
    resampling*: RasterResampling
    noData*: Option[float64]
    creationOptions*: seq[string]

  WarpConfig* = object
    ## Bounds are expressed in the target CRS. Empty CRS definitions preserve the source CRS.
    driver*: string
    sourceCrs*, targetCrs*: string
    bounds*: Option[Bounds]
    outputSize*: Option[RasterOutputSize]
    resampling*: RasterResampling
    sourceNoData*, targetNoData*: Option[float64]
    creationOptions*: seq[string]
    coordinateOperation*: string
      ## Optional PROJ pipeline, including any required axis swaps.
    errorThreshold*: Option[float64]
      ## Approximation tolerance in source pixels; 0 is exact.
    memoryLimitMiB*: Option[float64]
      ## Warp working memory, separate from GDAL's block cache.
    threadCount*: Option[int]
      ## Positive computation thread count; none keeps GDAL's default.
    verticalShift*: Option[bool] ## none selects GDAL's automatic elevation adjustment.

  ProgressCallback* = proc(complete: float64, message: string): bool {.closure.}
    ## Return false to cancel. Exceptions are re-raised after control returns from GDAL.

  ProgressState = ref object
    callback: ProgressCallback
    failure: ref Exception
    cancelled: bool

when defined(windows):
  {.pragma: progressCall, stdcall.}
else:
  {.pragma: progressCall, cdecl.}

proc progressCallback(
    complete: cdouble, message: cstring, userdata: pointer
): cint {.progressCall, raises: [].} =
  let state = cast[ProgressState](userdata)
  if state.failure != nil or state.cancelled:
    return 0
  try:
    if state.callback(complete, (if message == nil: "" else: $message)):
      result = 1
    else:
      state.cancelled = true
  except Exception as error:
    state.failure = error

proc initRasterOutputSize*(width, height: Positive): RasterOutputSize =
  if width > int(high(cint)) or height > int(high(cint)):
    raise newException(ValueError, "output dimensions exceed the GDAL integer range")
  RasterOutputSize(width: width, height: height)

proc addOutputSize(
    args: var seq[string], size: Option[RasterOutputSize], flag: string
) =
  if size.isSome:
    let value = size.get
    if value.width <= 0 or value.height <= 0:
      raise newException(ValueError, "output dimensions must be positive")
    discard initRasterOutputSize(value.width, value.height)
    args.add [flag, $value.width, $value.height]

proc addFormat(args: var seq[string], driver, destination: string) =
  validateCString(destination, "destination path")
  validateCString(driver, "output driver")
  if driver.len > 0:
    args.add ["-of", driver]
  elif destination.len == 0:
    args.add ["-of", "MEM"]

proc addCreationOptions(args: var seq[string], values: openArray[string]) =
  for option in values:
    validateCString(option, "creation option")
    args.add ["-co", option]

proc resamplingName(value: RasterResampling, warp: bool): string =
  case value
  of RasterResampling.nearest:
    (if warp: "near" else: "nearest")
  of RasterResampling.bilinear:
    "bilinear"
  of RasterResampling.cubic:
    "cubic"
  of RasterResampling.cubicSpline:
    "cubicspline"
  of RasterResampling.lanczos:
    "lanczos"
  of RasterResampling.average:
    "average"
  of RasterResampling.mode:
    "mode"
  of RasterResampling.rms:
    "rms"

proc checkedResult(
    handle: GDALDatasetH,
    usageError: cint,
    state: ProgressState,
    context: string,
    dependencies: seq[Dataset],
): Dataset =
  if state.failure != nil or state.cancelled or usageError != 0:
    if handle != nil:
      discard GDALClose(handle)
    if state.failure != nil:
      raise state.failure
    if state.cancelled:
      raise newException(IOError, context & " cancelled")
    raise newException(ValueError, "invalid " & context & " configuration")
  if handle == nil:
    raise gdalError(context & " failed")
  wrapDataset(handle, dependencies)

proc translate*(
    source: Dataset,
    destination: string,
    config: TranslateConfig,
    progress: ProgressCallback = nil,
): Dataset =
  ## Converts, crops or resizes a raster using typed configuration.
  ## The callback runs during this call and is never retained by GDAL.
  let handle = source.rawHandle
  var args: seq[string]
  args.addFormat(config.driver, destination)
  for band in config.bands:
    if band <= 0 or band > source.bandCount:
      raise newException(ValueError, "output band index is out of range")
    args.add ["-b", $band]
  if config.window.isSome:
    let window = config.window.get
    let size = source.size
    if window.x < 0 or window.y < 0 or window.width <= 0 or window.height <= 0 or
        window.x > size.width or window.y > size.height or
        window.width > size.width - window.x or window.height > size.height - window.y:
      raise newException(ValueError, "source window is outside the raster")
    args.add ["-srcwin", $window.x, $window.y, $window.width, $window.height]
  args.addOutputSize(config.outputSize, "-outsize")
  args.add ["-r", resamplingName(config.resampling, false)]
  if config.noData.isSome:
    args.add ["-a_nodata", $config.noData.get]
  args.addCreationOptions(config.creationOptions)
  let options = newTranslateOptions(args)
  let state = ProgressState(callback: progress)
  if progress != nil:
    options.setProgress(progressCallback, cast[pointer](state))
  var usageError: cint
  CPLErrorReset()
  let output =
    GDALTranslate(destination.cstring, handle, options.rawHandle, addr usageError)
  checkedResult(output, usageError, state, "raster translation", @[source])

proc copyRaster*(
    source: Dataset,
    destination = "",
    config = TranslateConfig(),
    progress: ProgressCallback = nil,
): Dataset =
  ## Makes an independent raster dataset, in memory by default.
  translate(source, destination, config, progress)

proc crop*(
    source: Dataset,
    window: RasterWindow,
    destination = "",
    config = TranslateConfig(),
    progress: ProgressCallback = nil,
): Dataset =
  ## Copies a pixel window. config.outputSize can also resample the crop.
  var options = config
  options.window = some(window)
  translate(source, destination, options, progress)

proc warp*(
    sources: openArray[Dataset],
    destination: string,
    config: WarpConfig,
    progress: ProgressCallback = nil,
): Dataset =
  ## Reprojects or mosaics rasters into an owning result dataset.
  if sources.len == 0 or sources.len > int(high(cint)):
    raise newException(
      ValueError, "warp needs at least one source within the GDAL count range"
    )
  var handles = newSeq[GDALDatasetH](sources.len)
  for index, source in sources:
    handles[index] = source.rawHandle
  var args: seq[string]
  args.addFormat(config.driver, destination)
  for definition in [config.sourceCrs, config.targetCrs]:
    validateCString(definition, "CRS definition")
  if config.sourceCrs.len > 0:
    args.add ["-s_srs", config.sourceCrs]
  if config.targetCrs.len > 0:
    args.add ["-t_srs", config.targetCrs]
  validateCString(config.coordinateOperation, "coordinate operation")
  if config.coordinateOperation.len > 0:
    args.add ["-ct", config.coordinateOperation]
  if config.errorThreshold.isSome:
    let value = config.errorThreshold.get
    if classify(value) in {fcNan, fcInf, fcNegInf} or value < 0:
      raise
        newException(ValueError, "warp error threshold must be finite and nonnegative")
    args.add ["-et", $value]
  if config.memoryLimitMiB.isSome:
    let value = config.memoryLimitMiB.get
    if classify(value) in {fcNan, fcInf, fcNegInf} or value <= 0:
      raise newException(ValueError, "warp memory limit must be finite and positive")
    args.add ["-wm", $value & "MB"]
  if config.threadCount.isSome:
    let value = config.threadCount.get
    if value <= 0 or value > high(cint).int:
      raise
        newException(ValueError, "warp thread count is outside the GDAL integer range")
    args.add ["-wo", "NUM_THREADS=" & $value]
  if config.verticalShift.isSome:
    args.add (if config.verticalShift.get: "-vshift" else: "-novshift")
  if config.bounds.isSome:
    let bounds = config.bounds.get
    for value in [bounds.minX, bounds.minY, bounds.maxX, bounds.maxY]:
      if classify(value) in {fcNan, fcInf, fcNegInf}:
        raise newException(ValueError, "warp bounds must be finite")
    if bounds.minX >= bounds.maxX or bounds.minY >= bounds.maxY:
      raise newException(ValueError, "warp bounds must have positive area")
    args.add ["-te", $bounds.minX, $bounds.minY, $bounds.maxX, $bounds.maxY]
  args.addOutputSize(config.outputSize, "-ts")
  args.add ["-r", resamplingName(config.resampling, true)]
  if config.sourceNoData.isSome:
    args.add ["-srcnodata", $config.sourceNoData.get]
  if config.targetNoData.isSome:
    args.add ["-dstnodata", $config.targetNoData.get]
  args.addCreationOptions(config.creationOptions)
  let options = newWarpAppOptions(args)
  let state = ProgressState(callback: progress)
  if progress != nil:
    options.setProgress(progressCallback, cast[pointer](state))
  var usageError: cint
  CPLErrorReset()
  let output = GDALWarp(
    destination.cstring,
    nil,
    cint(handles.len),
    addr handles[0],
    options.rawHandle,
    addr usageError,
  )
  checkedResult(output, usageError, state, "raster warp", @sources)

proc warp*(
    source: Dataset,
    destination = "",
    config = WarpConfig(),
    progress: ProgressCallback = nil,
): Dataset =
  warp([source], destination, config, progress)

proc mosaic*(
    sources: openArray[Dataset],
    destination = "",
    config = WarpConfig(),
    progress: ProgressCallback = nil,
): Dataset =
  ## Combines sources in their given order; later sources take precedence.
  warp(sources, destination, config, progress)

proc reproject*(
    source: Dataset,
    target: SpatialReference,
    destination = "",
    config = WarpConfig(),
    progress: ProgressCallback = nil,
): Dataset =
  ## Reprojects to target's CRS; output is in memory unless a path is supplied.
  var options = config
  options.targetCrs = target.toWkt
  warp([source], destination, options, progress)
