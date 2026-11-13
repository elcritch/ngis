## Owned options and higher-level operations for GDAL command-line utilities.
import ./[api, datasets, raster, vector]
import ./private/resources

template utilityOptions(T, Native, constructor, destructor, factory: untyped) =
  type T* = object
    resource: NativeResource[ptr Native]

  proc rawHandle*(options: T): ptr Native =
    rawHandle(options.resource)

  proc close*(options: T) =
    close(options.resource)

  proc factory*(args: openArray[string] = []): T =
    for arg in args:
      validateCString(arg, "utility option")
    let argv = allocCStringArray(args)
    defer:
      deallocCStringArray(argv)
    CPLErrorReset()
    let h = constructor(argv, nil)
    if h == nil:
      raise newException(
        ValueError, "invalid GDAL utility options: " & $CPLGetLastErrorMsg()
      )
    T(
      resource: newNativeResource(
        h,
        proc(p: ptr Native) {.nimcall, raises: [].} =
          destructor(p),
      )
    )

utilityOptions(
  InfoOptions, GDALInfoOptions, GDALInfoOptionsNew, GDALInfoOptionsFree, newInfoOptions
)
utilityOptions(
  TranslateOptions, GDALTranslateOptions, GDALTranslateOptionsNew,
  GDALTranslateOptionsFree, newTranslateOptions,
)
utilityOptions(
  WarpAppOptions, GDALWarpAppOptions, GDALWarpAppOptionsNew, GDALWarpAppOptionsFree,
  newWarpAppOptions,
)
utilityOptions(
  VectorTranslateOptions, GDALVectorTranslateOptions, GDALVectorTranslateOptionsNew,
  GDALVectorTranslateOptionsFree, newVectorTranslateOptions,
)
utilityOptions(
  DEMProcessingOptions, GDALDEMProcessingOptions, GDALDEMProcessingOptionsNew,
  GDALDEMProcessingOptionsFree, newDEMProcessingOptions,
)
utilityOptions(
  NearblackOptions, GDALNearblackOptions, GDALNearblackOptionsNew,
  GDALNearblackOptionsFree, newNearblackOptions,
)
utilityOptions(
  GridOptions, GDALGridOptions, GDALGridOptionsNew, GDALGridOptionsFree, newGridOptions
)
utilityOptions(
  ContourOptions, GDALContourOptions, GDALContourOptionsNew, GDALContourOptionsFree,
  newContourOptions,
)
utilityOptions(
  RasterizeOptions, GDALRasterizeOptions, GDALRasterizeOptionsNew,
  GDALRasterizeOptionsFree, newRasterizeOptions,
)
utilityOptions(
  FootprintOptions, GDALFootprintOptions, GDALFootprintOptionsNew,
  GDALFootprintOptionsFree, newFootprintOptions,
)
utilityOptions(
  BuildVRTOptions, GDALBuildVRTOptions, GDALBuildVRTOptionsNew, GDALBuildVRTOptionsFree,
  newBuildVRTOptions,
)
utilityOptions(
  MultiDimInfoOptions, GDALMultiDimInfoOptions, GDALMultiDimInfoOptionsNew,
  GDALMultiDimInfoOptionsFree, newMultiDimInfoOptions,
)
utilityOptions(
  MultiDimTranslateOptions, GDALMultiDimTranslateOptions,
  GDALMultiDimTranslateOptionsNew, GDALMultiDimTranslateOptionsFree,
  newMultiDimTranslateOptions,
)
utilityOptions(
  VectorInfoOptions, GDALVectorInfoOptions, GDALVectorInfoOptionsNew,
  GDALVectorInfoOptionsFree, newVectorInfoOptions,
)
utilityOptions(
  TileIndexOptions, GDALTileIndexOptions, GDALTileIndexOptionsNew,
  GDALTileIndexOptionsFree, newTileIndexOptions,
)

template progress(T, setter: untyped) =
  proc setProgress*(options: T, callback: GDALProgressFunc, data: pointer = nil) =
    ## The callback and its data must remain valid through the utility call.
    setter(options.rawHandle, callback, data)

progress(TranslateOptions, GDALTranslateOptionsSetProgress)
progress(WarpAppOptions, GDALWarpAppOptionsSetProgress)
progress(VectorTranslateOptions, GDALVectorTranslateOptionsSetProgress)
progress(DEMProcessingOptions, GDALDEMProcessingOptionsSetProgress)
progress(NearblackOptions, GDALNearblackOptionsSetProgress)
progress(GridOptions, GDALGridOptionsSetProgress)
progress(ContourOptions, GDALContourOptionsSetProgress)
progress(RasterizeOptions, GDALRasterizeOptionsSetProgress)
progress(FootprintOptions, GDALFootprintOptionsSetProgress)
progress(BuildVRTOptions, GDALBuildVRTOptionsSetProgress)
progress(MultiDimTranslateOptions, GDALMultiDimTranslateOptionsSetProgress)
progress(TileIndexOptions, GDALTileIndexOptionsSetProgress)

proc takeText(value: cstring, operation: string): string =
  if value == nil:
    raise gdalError(operation & " failed")
  defer:
    CPLFree(value)
  $value

proc info*(dataset: Dataset, options: InfoOptions): string =
  takeText(GDALInfo(dataset.rawHandle, options.rawHandle), "raster info")

proc info*(dataset: Dataset): string =
  info(dataset, newInfoOptions())

proc multiDimInfo*(dataset: Dataset, options: MultiDimInfoOptions): string =
  takeText(
    GDALMultiDimInfo(dataset.rawHandle, options.rawHandle), "multidimensional info"
  )

proc multiDimInfo*(dataset: Dataset): string =
  multiDimInfo(dataset, newMultiDimInfoOptions())

proc vectorInfo*(dataset: Dataset, options: VectorInfoOptions): string =
  takeText(GDALVectorInfo(dataset.rawHandle, options.rawHandle), "vector info")

proc vectorInfo*(dataset: Dataset): string =
  vectorInfo(dataset, newVectorInfoOptions())

proc checkedResult(
    handle: GDALDatasetH, usage: cint, operation: string, deps: seq[Dataset]
): Dataset =
  if usage != 0:
    if handle != nil:
      discard GDALReleaseDataset(handle)
    raise newException(ValueError, operation & " usage error: " & $CPLGetLastErrorMsg())
  if handle == nil:
    raise gdalError(operation & " failed")
  wrapDataset(handle, deps)

proc demProcessing*(
    source: Dataset,
    destination, mode: string,
    options: DEMProcessingOptions,
    colorFile = "",
): Dataset =
  validateCString(destination, "destination")
  validateCString(mode, "mode")
  validateCString(colorFile, "color file")
  var usage: cint
  let h = GDALDEMProcessing(
    destination.cstring,
    source.rawHandle,
    mode.cstring,
    (if colorFile.len == 0: nil else: colorFile.cstring),
    options.rawHandle,
    addr usage,
  )
  checkedResult(h, usage, "DEM processing", @[source])

proc demProcessing*(
    source: Dataset, destination, mode: string, colorFile = ""
): Dataset =
  demProcessing(source, destination, mode, newDEMProcessingOptions(), colorFile)

proc nearblack*(
    source: Dataset, destination: string, options: NearblackOptions
): Dataset =
  validateCString(destination, "destination")
  var usage: cint
  let h = GDALNearblack(
    destination.cstring, nil, source.rawHandle, options.rawHandle, addr usage
  )
  checkedResult(h, usage, "nearblack", @[source])

proc nearblack*(source: Dataset, destination: string): Dataset =
  nearblack(source, destination, newNearblackOptions())

proc footprint*(
    source: Dataset, destination: string, options: FootprintOptions
): Dataset =
  validateCString(destination, "destination")
  var usage: cint
  let h = GDALFootprint(
    destination.cstring, nil, source.rawHandle, options.rawHandle, addr usage
  )
  checkedResult(h, usage, "footprint", @[source])

proc footprint*(source: Dataset, destination: string): Dataset =
  footprint(source, destination, newFootprintOptions())

proc multiDimTranslate*(
    sources: openArray[Dataset], destination: string, options: MultiDimTranslateOptions
): Dataset =
  validateCString(destination, "destination")
  if sources.len == 0 or sources.len > high(cint).int:
    raise newException(ValueError, "invalid source count")
  var handles: seq[GDALDatasetH]
  for source in sources:
    handles.add source.rawHandle
  var usage: cint
  let h = GDALMultiDimTranslate(
    destination.cstring,
    nil,
    cint(handles.len),
    addr handles[0],
    options.rawHandle,
    addr usage,
  )
  checkedResult(h, usage, "multidimensional translate", @sources)

proc multiDimTranslate*(sources: openArray[Dataset], destination: string): Dataset =
  multiDimTranslate(sources, destination, newMultiDimTranslateOptions())

proc tileIndex*(
    sources: openArray[string], destination: string, options: TileIndexOptions
): Dataset =
  validateCString(destination, "destination")
  if sources.len == 0 or sources.len > high(cint).int:
    raise newException(ValueError, "invalid source count")
  for source in sources:
    validateCString(source, "source")
  let names = allocCStringArray(sources)
  defer:
    deallocCStringArray(names)
  var usage: cint
  let h = GDALTileIndex(
    destination.cstring, cint(sources.len), names, options.rawHandle, addr usage
  )
  checkedResult(h, usage, "tile index", @[])

proc tileIndex*(sources: openArray[string], destination: string): Dataset =
  tileIndex(sources, destination, newTileIndexOptions())

proc contour*(source: RasterBand, destination: Layer, interval: float64) =
  if interval <= 0:
    raise newException(ValueError, "contour interval must be positive")
  let args = allocCStringArray(["LEVEL_INTERVAL=" & $interval])
  defer:
    deallocCStringArray(args)
  if GDALContourGenerateEx(source.rawHandle, destination.rawHandle, args, nil, nil) !=
      CE_None:
    raise gdalError("contour generation failed")
