## Owning access to GDAL's algorithm registry and command-line algorithms.
import ./gdal
import ./datasets
import ./spatialrefs
import ./private/resources

type
  AlgorithmRegistry* = ref object
    resource: NativeResource[GDALAlgorithmRegistryH]

  Algorithm* = ref object
    resource: NativeResource[GDALAlgorithmH]
    ran: bool
    finalized: bool

  AlgorithmArgument* = ref object
    resource: NativeResource[GDALAlgorithmArgH]
    algorithm: Algorithm

  AlgorithmDatasetValue* = ref object
    resource: NativeResource[GDALArgDatasetValueH]
    argument: AlgorithmArgument

proc releaseRegistry(h: GDALAlgorithmRegistryH) {.nimcall, raises: [].} =
  GDALAlgorithmRegistryRelease(h)

proc releaseAlgorithm(h: GDALAlgorithmH) {.nimcall, raises: [].} =
  GDALAlgorithmRelease(h)

proc releaseArgument(h: GDALAlgorithmArgH) {.nimcall, raises: [].} =
  GDALAlgorithmArgRelease(h)

proc releaseDatasetValue(h: GDALArgDatasetValueH) {.nimcall, raises: [].} =
  GDALArgDatasetValueRelease(h)

proc checkString(value, what: string) =
  if '\0' in value:
    raise newException(ValueError, what & " contains a NUL byte")

proc strings(values: cstringArray): seq[string] =
  if values != nil:
    var i = 0
    while values[i] != nil:
      result.add $values[i]
      inc i

proc takeStrings(values: cstringArray): seq[string] =
  defer:
    CSLDestroy(values)
  strings(values)

proc rawHandle*(registry: AlgorithmRegistry): GDALAlgorithmRegistryH =
  if registry == nil:
    raise newException(ValueError, "algorithm registry is closed")
  rawHandle(registry.resource)

proc rawHandle*(algorithm: Algorithm): GDALAlgorithmH =
  if algorithm == nil:
    raise newException(ValueError, "algorithm is closed")
  rawHandle(algorithm.resource)

proc rawHandle*(argument: AlgorithmArgument): GDALAlgorithmArgH =
  if argument == nil:
    raise newException(ValueError, "algorithm argument is closed")
  discard rawHandle(argument.algorithm)
  rawHandle(argument.resource)

proc rawHandle*(value: AlgorithmDatasetValue): GDALArgDatasetValueH =
  if value == nil:
    raise newException(ValueError, "dataset value is closed")
  if value.argument != nil:
    discard rawHandle(value.argument)
  rawHandle(value.resource)

proc close*(registry: AlgorithmRegistry) =
  if registry != nil:
    close(registry.resource)

proc close*(algorithm: Algorithm) =
  if algorithm != nil:
    close(algorithm.resource)

proc close*(argument: AlgorithmArgument) =
  if argument != nil:
    close(argument.resource)

proc close*(value: AlgorithmDatasetValue) =
  if value != nil:
    close(value.resource)

proc globalAlgorithmRegistry*(): AlgorithmRegistry =
  ## Gets an owned handle to the global registry.
  GDALAllRegister()
  let handle = GDALGetGlobalAlgorithmRegistry()
  if handle == nil:
    raise gdalError("could not get algorithm registry")
  AlgorithmRegistry(resource: newNativeResource(handle, releaseRegistry))

proc names*(registry: AlgorithmRegistry): seq[string] =
  takeStrings(GDALAlgorithmRegistryGetAlgNames(rawHandle(registry)))

proc instantiate*(registry: AlgorithmRegistry, path: openArray[string]): Algorithm =
  ## Instantiates an algorithm by path, such as ["raster", "info"].
  if path.len == 0:
    raise newException(ValueError, "algorithm path is empty")
  for component in path:
    checkString(component, "algorithm path")
  let args = allocCStringArray(path)
  defer:
    deallocCStringArray(args)
  CPLErrorReset()
  let handle = GDALAlgorithmRegistryInstantiateAlgFromPath(rawHandle(registry), args)
  if handle == nil:
    raise gdalError("could not instantiate algorithm")
  Algorithm(resource: newNativeResource(handle, releaseAlgorithm))

proc instantiate*(registry: AlgorithmRegistry, name: string): Algorithm =
  instantiate(registry, [name])

proc name*(algorithm: Algorithm): string =
  $GDALAlgorithmGetName(rawHandle(algorithm))

proc description*(algorithm: Algorithm): string =
  let s = GDALAlgorithmGetDescription(rawHandle(algorithm))
  if s == nil:
    ""
  else:
    $s

proc argumentNames*(algorithm: Algorithm): seq[string] =
  takeStrings(GDALAlgorithmGetArgNames(rawHandle(algorithm)))

proc subAlgorithmNames*(algorithm: Algorithm): seq[string] =
  takeStrings(GDALAlgorithmGetSubAlgorithmNames(rawHandle(algorithm)))

proc usageJson*(algorithm: Algorithm): string =
  let s = GDALAlgorithmGetUsageAsJSON(rawHandle(algorithm))
  if s == nil:
    raise gdalError("could not get algorithm usage")
  defer:
    CPLFree(s)
  $s

proc argument*(algorithm: Algorithm, name: string): AlgorithmArgument =
  checkString(name, "argument name")
  let handle = GDALAlgorithmGetArg(rawHandle(algorithm), name.cstring)
  if handle == nil:
    raise newException(ValueError, "unknown algorithm argument: " & name)
  AlgorithmArgument(
    resource: newNativeResource(handle, releaseArgument), algorithm: algorithm
  )

proc name*(argument: AlgorithmArgument): string =
  $GDALAlgorithmArgGetName(rawHandle(argument))

proc kind*(argument: AlgorithmArgument): GDALAlgorithmArgType =
  GDALAlgorithmArgGetType(rawHandle(argument))

proc requireKind(argument: AlgorithmArgument, expected: GDALAlgorithmArgType) =
  if argument.kind != expected:
    raise newException(ValueError, "algorithm argument has a different type")

proc ensureSet(ok: bool) =
  if not ok:
    raise gdalError("could not set algorithm argument")

proc set*(argument: AlgorithmArgument, value: string) =
  checkString(value, "argument value")
  ensureSet(GDALAlgorithmArgSetAsString(rawHandle(argument), value.cstring))

proc set*(argument: AlgorithmArgument, value: bool) =
  ensureSet(GDALAlgorithmArgSetAsBoolean(rawHandle(argument), value))

proc set*(argument: AlgorithmArgument, value: int) =
  if value < int(low(cint)) or value > int(high(cint)):
    raise newException(ValueError, "argument value exceeds GDAL integer range")
  ensureSet(GDALAlgorithmArgSetAsInteger(rawHandle(argument), cint(value)))

proc set*(argument: AlgorithmArgument, value: float64) =
  ensureSet(GDALAlgorithmArgSetAsDouble(rawHandle(argument), value))

proc set*(argument: AlgorithmArgument, value: Dataset) =
  ensureSet(GDALAlgorithmArgSetDataset(rawHandle(argument), rawHandle(value)))

proc set*(argument: AlgorithmArgument, values: openArray[string]) =
  for value in values:
    checkString(value, "argument value")
  let args = allocCStringArray(values)
  defer:
    deallocCStringArray(args)
  ensureSet(GDALAlgorithmArgSetAsStringList(rawHandle(argument), args))

proc set*(argument: AlgorithmArgument, values: openArray[float64]) =
  var copy = @values
  ensureSet(
    GDALAlgorithmArgSetAsDoubleList(
      rawHandle(argument),
      csize_t(copy.len),
      if copy.len == 0:
        nil
      else:
        addr copy[0]
      ,
    )
  )

proc set*(argument: AlgorithmArgument, values: openArray[int]) =
  var copy: seq[cint]
  for value in values:
    if value < int(low(cint)) or value > int(high(cint)):
      raise newException(ValueError, "argument value exceeds GDAL integer range")
    copy.add cint(value)
  ensureSet(
    GDALAlgorithmArgSetAsIntegerList(
      rawHandle(argument),
      csize_t(copy.len),
      if copy.len == 0:
        nil
      else:
        addr copy[0]
      ,
    )
  )

proc stringValue*(argument: AlgorithmArgument): string =
  requireKind(argument, GAAT_STRING)
  let s = GDALAlgorithmArgGetAsString(rawHandle(argument))
  if s == nil:
    ""
  else:
    $s

proc boolValue*(argument: AlgorithmArgument): bool =
  requireKind(argument, GAAT_BOOLEAN)
  GDALAlgorithmArgGetAsBoolean(rawHandle(argument))

proc intValue*(argument: AlgorithmArgument): int =
  requireKind(argument, GAAT_INTEGER)
  int(GDALAlgorithmArgGetAsInteger(rawHandle(argument)))

proc floatValue*(argument: AlgorithmArgument): float64 =
  requireKind(argument, GAAT_REAL)
  GDALAlgorithmArgGetAsDouble(rawHandle(argument))

proc newAlgorithmDatasetValue*(): AlgorithmDatasetValue =
  let h = GDALArgDatasetValueCreate()
  if h == nil:
    raise gdalError("could not create dataset value")
  AlgorithmDatasetValue(resource: newNativeResource(h, releaseDatasetValue))

proc datasetValue*(argument: AlgorithmArgument): AlgorithmDatasetValue =
  requireKind(argument, GAAT_DATASET)
  let h = GDALAlgorithmArgGetAsDatasetValue(rawHandle(argument))
  if h == nil:
    raise gdalError("could not get dataset value")
  AlgorithmDatasetValue(
    resource: newNativeResource(h, releaseDatasetValue), argument: argument
  )

proc set*(value: AlgorithmDatasetValue, dataset: Dataset) =
  GDALArgDatasetValueSetDataset(rawHandle(value), rawHandle(dataset))

proc setName*(value: AlgorithmDatasetValue, name: string) =
  checkString(name, "dataset name")
  GDALArgDatasetValueSetName(rawHandle(value), name.cstring)

proc name*(value: AlgorithmDatasetValue): string =
  let s = GDALArgDatasetValueGetName(rawHandle(value))
  if s == nil:
    ""
  else:
    $s

proc dataset*(value: AlgorithmDatasetValue): Dataset =
  let h = GDALArgDatasetValueGetDatasetIncreaseRefCount(rawHandle(value))
  if h == nil:
    raise newException(ValueError, "dataset value has no open dataset")
  wrapDataset(h)

proc set*(argument: AlgorithmArgument, value: AlgorithmDatasetValue) =
  ensureSet(GDALAlgorithmArgSetAsDatasetValue(rawHandle(argument), rawHandle(value)))

proc parse*(algorithm: Algorithm, arguments: openArray[string]) =
  for argument in arguments:
    checkString(argument, "algorithm argument")
  let args = allocCStringArray(arguments)
  defer:
    deallocCStringArray(args)
  if not GDALAlgorithmParseCommandLineArguments(rawHandle(algorithm), args):
    raise gdalError("could not parse algorithm arguments")

proc run*(algorithm: Algorithm) =
  let handle = rawHandle(algorithm)
  if algorithm.ran:
    raise newException(ValueError, "algorithm has already run")
  algorithm.ran = true
  if not GDALAlgorithmRun(handle, nil, nil):
    raise gdalError("algorithm failed")

proc finalize*(algorithm: Algorithm) =
  let handle = rawHandle(algorithm)
  if algorithm.finalized:
    return
  algorithm.finalized = true
  if not GDALAlgorithmFinalize(handle):
    raise gdalError("algorithm finalization failed")

proc set*(argument: AlgorithmArgument, values: openArray[Dataset]) =
  var handles: seq[GDALDatasetH]
  for value in values:
    handles.add rawHandle(value)
  ensureSet(
    GDALAlgorithmArgSetDatasets(
      rawHandle(argument),
      csize_t(handles.len),
      if handles.len == 0:
        nil
      else:
        addr handles[0]
      ,
    )
  )

type
  Transformer* = ref object
    resource: NativeResource[pointer]
    dependencies: seq[Dataset]
    base: Transformer

  WarpOptions* = ref object
    resource: NativeResource[ptr GDALWarpOptions]
    dependencies: seq[Dataset]
    transformer: Transformer

  WarpOperation* = ref object
    resource: NativeResource[GDALWarpOperationH]
    options: WarpOptions

  PansharpenOptions* = ref object
    resource: NativeResource[ptr GDALPansharpenOptions]
    dependencies: seq[Dataset]

  PansharpenOperation* = ref object
    resource: NativeResource[GDALPansharpenOperationH]
    options: PansharpenOptions
    bands: int

  GridContext* = ref object
    resource: NativeResource[ptr GDALGridContext]

  Point3D* = object
    x*, y*, z*: float64

proc releaseTransformer(h: pointer) {.nimcall, raises: [].} =
  GDALDestroyTransformer(h)

proc releaseWarpOptions(h: ptr GDALWarpOptions) {.nimcall, raises: [].} =
  GDALDestroyWarpOptions(h)

proc releaseWarpOperation(h: GDALWarpOperationH) {.nimcall, raises: [].} =
  GDALDestroyWarpOperation(h)

proc releasePansharpenOptions(h: ptr GDALPansharpenOptions) {.nimcall, raises: [].} =
  GDALDestroyPansharpenOptions(h)

proc releasePansharpenOperation(h: GDALPansharpenOperationH) {.nimcall, raises: [].} =
  GDALDestroyPansharpenOperation(h)

proc releaseGrid(h: ptr GDALGridContext) {.nimcall, raises: [].} =
  GDALGridContextFree(h)

template ownerMethods(T, H: typedesc) =
  proc rawHandle*(owner: T): H =
    if owner == nil:
      raise newException(ValueError, "GDAL resource is closed")
    rawHandle(owner.resource)

  proc close*(owner: T) =
    if owner != nil:
      close(owner.resource)

proc rawHandle*(owner: Transformer): pointer =
  if owner == nil:
    raise newException(ValueError, "transformer is closed")
  if owner.base != nil:
    discard rawHandle(owner.base)
  rawHandle(owner.resource)

proc close*(owner: Transformer) =
  if owner != nil:
    close(owner.resource)

ownerMethods(WarpOptions, ptr GDALWarpOptions)
ownerMethods(WarpOperation, GDALWarpOperationH)
ownerMethods(PansharpenOptions, ptr GDALPansharpenOptions)
ownerMethods(PansharpenOperation, GDALPansharpenOperationH)
ownerMethods(GridContext, ptr GDALGridContext)

proc newReprojectionTransformer*(sourceWkt, destinationWkt: string): Transformer =
  ## Creates a transformer between two WKT coordinate reference systems.
  checkString(sourceWkt, "source CRS")
  checkString(destinationWkt, "destination CRS")
  let h = GDALCreateReprojectionTransformer(sourceWkt.cstring, destinationWkt.cstring)
  if h == nil:
    raise gdalError("could not create reprojection transformer")
  Transformer(resource: newNativeResource(h, releaseTransformer))

proc newReprojectionTransformer*(source, destination: SpatialReference): Transformer =
  ## Creates a transformer from owned spatial reference systems.
  let h =
    GDALCreateReprojectionTransformerEx(rawHandle(source), rawHandle(destination), nil)
  if h == nil:
    raise gdalError("could not create reprojection transformer")
  Transformer(resource: newNativeResource(h, releaseTransformer))

proc transform*(
    transformer: Transformer, points: var openArray[Point3D], inverse = false
): seq[bool] =
  ## Transforms coordinates in place and returns one success flag per point.
  let h = rawHandle(transformer)
  if points.len > int(high(cint)):
    raise newException(ValueError, "too many points")
  if points.len == 0:
    return @[]
  var x, y, z = newSeq[cdouble](points.len)
  var success = newSeq[cint](points.len)
  for i, point in points:
    x[i] = point.x
    y[i] = point.y
    z[i] = point.z
  if GDALUseTransformer(
    h, cint(inverse), cint(points.len), addr x[0], addr y[0], addr z[0], addr success[0]
  ) == 0:
    raise gdalError("coordinate transformation failed")
  result = newSeq[bool](points.len)
  for i in 0 ..< points.len:
    points[i] = Point3D(x: x[i], y: y[i], z: z[i])
    result[i] = success[i] != 0

proc newWarpOptions*(): WarpOptions =
  WarpOptions(resource: newNativeResource(GDALCreateWarpOptions(), releaseWarpOptions))

proc newWarpOperation*(options: WarpOptions): WarpOperation =
  let h = GDALCreateWarpOperation(rawHandle(options))
  if h == nil:
    raise gdalError("could not create warp operation")
  WarpOperation(resource: newNativeResource(h, releaseWarpOperation), options: options)

proc newPansharpenOptions*(): PansharpenOptions =
  PansharpenOptions(
    resource: newNativeResource(GDALCreatePansharpenOptions(), releasePansharpenOptions)
  )

proc newPansharpenOperation*(options: PansharpenOptions): PansharpenOperation =
  let h = GDALCreatePansharpenOperation(rawHandle(options))
  if h == nil:
    raise gdalError("could not create pansharpen operation")
  PansharpenOperation(
    resource: newNativeResource(h, releasePansharpenOperation),
    options: options,
    bands: int(rawHandle(options).nOutPansharpenedBands),
  )

proc newGridContext*(
    algorithm: GDALGridAlgorithm, options: pointer, x, y, z: openArray[float64]
): GridContext =
  ## GDAL copies the point arrays; `options` must match the selected algorithm.
  if x.len != y.len or x.len != z.len or x.len == 0 or
      uint64(x.len) > uint64(high(uint32)):
    raise
      newException(ValueError, "grid coordinates must be nonempty and equally sized")
  let h = GDALGridContextCreate(
    algorithm,
    options,
    GUInt32(x.len),
    unsafeAddr x[0],
    unsafeAddr y[0],
    unsafeAddr z[0],
    0,
  )
  if h == nil:
    raise gdalError("could not create grid context")
  GridContext(resource: newNativeResource(h, releaseGrid))

proc stringValues*(argument: AlgorithmArgument): seq[string] =
  requireKind(argument, GAAT_STRING_LIST)
  takeStrings(GDALAlgorithmArgGetAsStringList(rawHandle(argument)))

proc intValues*(argument: AlgorithmArgument): seq[int] =
  requireKind(argument, GAAT_INTEGER_LIST)
  var count: csize_t
  let p = GDALAlgorithmArgGetAsIntegerList(rawHandle(argument), addr count)
  let values = cast[ptr UncheckedArray[cint]](p)
  for i in 0 ..< int(count):
    result.add int(values[i])

proc floatValues*(argument: AlgorithmArgument): seq[float64] =
  requireKind(argument, GAAT_REAL_LIST)
  var count: csize_t
  let p = GDALAlgorithmArgGetAsDoubleList(rawHandle(argument), addr count)
  let values = cast[ptr UncheckedArray[cdouble]](p)
  for i in 0 ..< int(count):
    result.add values[i]

proc setDatasetNames*(argument: AlgorithmArgument, values: openArray[string]) =
  for value in values:
    checkString(value, "dataset name")
  let args = allocCStringArray(values)
  defer:
    deallocCStringArray(args)
  ensureSet(GDALAlgorithmArgSetDatasetNames(rawHandle(argument), args))

proc newNearestGrid*(
    x, y, z: openArray[float64], radius = 0.0, noData = 0.0
): GridContext =
  ## Grids point values by their nearest neighbour; zero radius means unbounded.
  if radius < 0:
    raise newException(ValueError, "grid radius must be nonnegative")
  var options = GDALGridNearestNeighborOptions(
    nSizeOfStructure: csize_t(sizeof(GDALGridNearestNeighborOptions)),
    dfRadius1: radius,
    dfRadius2: radius,
    dfNoDataValue: noData,
  )
  newGridContext(GGA_NearestNeighbor, addr options, x, y, z)

proc grid*(
    context: GridContext, xMin, xMax, yMin, yMax: float64, width, height: Positive
): seq[float64] =
  ## Computes a row-major Float64 raster over the requested extent.
  let h = rawHandle(context)
  if uint64(width) > uint64(high(uint32)) or uint64(height) > uint64(high(uint32)) or
      width > high(int) div height:
    raise newException(ValueError, "grid dimensions are too large")
  if xMax <= xMin or yMax <= yMin:
    raise newException(ValueError, "grid extent must have positive area")
  result = newSeq[float64](width * height)
  let err = GDALGridContextProcess(
    h,
    xMin,
    xMax,
    yMin,
    yMax,
    GUInt32(width),
    GUInt32(height),
    GDT_Float64,
    addr result[0],
    nil,
    nil,
  )
  if err != CE_None:
    raise gdalError("could not grid points")

proc retainedDataset(dataset: Dataset): Dataset =
  let h = rawHandle(dataset)
  discard GDALReferenceDataset(h)
  wrapDataset(h)

proc newImageTransformer*(source, destination: Dataset): Transformer =
  ## Creates a pixel/line transformer between two georeferenced datasets.
  let h =
    GDALCreateGenImgProjTransformer2(rawHandle(source), rawHandle(destination), nil)
  if h == nil:
    raise gdalError("could not create image transformer")
  Transformer(
    resource: newNativeResource(h, releaseTransformer),
    dependencies: @[retainedDataset(source), retainedDataset(destination)],
  )

proc newWarpOperation*(source, destination: Dataset): WarpOperation =
  ## Creates a nearest-neighbour operation over matching raster bands.
  let src = rawHandle(source)
  let dst = rawHandle(destination)
  let count = GDALGetRasterCount(src)
  if count <= 0 or count != GDALGetRasterCount(dst):
    raise
      newException(ValueError, "warp datasets must have matching nonzero band counts")
  let options = newWarpOptions()
  options.dependencies = @[retainedDataset(source), retainedDataset(destination)]
  options.transformer = newImageTransformer(source, destination)
  let native = rawHandle(options)
  native.hSrcDS = src
  native.hDstDS = dst
  native.pfnTransformer = GDALGenImgProjTransform
  native.pTransformerArg = rawHandle(options.transformer)
  GDALWarpInitDefaultBandMapping(native, count)
  newWarpOperation(options)

proc warpRegion*(operation: WarpOperation, x, y, width, height: int) =
  ## Warps a destination pixel window using the operation's configuration.
  let h = rawHandle(operation)
  if x < 0 or y < 0 or width <= 0 or height <= 0 or x > int(high(cint)) or
      y > int(high(cint)) or width > int(high(cint)) or height > int(high(cint)):
    raise newException(ValueError, "invalid warp window")
  if GDALChunkAndWarpImage(h, cint(x), cint(y), cint(width), cint(height)) != CE_None:
    raise gdalError("could not warp region")

proc newPansharpenOperation*(panchromatic, spectral: Dataset): PansharpenOperation =
  ## Creates a weighted Brovey operation over all spectral bands.
  let pan = rawHandle(panchromatic)
  let multi = rawHandle(spectral)
  let count = GDALGetRasterCount(multi)
  if GDALGetRasterCount(pan) < 1 or count <= 0:
    raise
      newException(ValueError, "pansharpening requires panchromatic and spectral bands")
  let options = newPansharpenOptions()
  options.dependencies = @[retainedDataset(panchromatic), retainedDataset(spectral)]
  let p = rawHandle(options)
  p.hPanchroBand = GDALGetRasterBand(pan, 1)
  p.nInputSpectralBands = count
  p.nOutPansharpenedBands = count
  p.nWeightCount = count
  p.padfWeights = cast[ptr cdouble](CPLCalloc(csize_t(count), csize_t(sizeof(cdouble))))
  p.pahInputSpectralBands = cast[ptr GDALRasterBandH](CPLCalloc(
    csize_t(count), csize_t(sizeof(GDALRasterBandH))
  ))
  p.panOutPansharpenedBands =
    cast[ptr cint](CPLCalloc(csize_t(count), csize_t(sizeof(cint))))
  let weights = cast[ptr UncheckedArray[cdouble]](p.padfWeights)
  let bands = cast[ptr UncheckedArray[GDALRasterBandH]](p.pahInputSpectralBands)
  let mapping = cast[ptr UncheckedArray[cint]](p.panOutPansharpenedBands)
  for i in 0 ..< int(count):
    weights[i] = 1.0 / float64(count)
    bands[i] = GDALGetRasterBand(multi, cint(i + 1))
    mapping[i] = cint(i)
  newPansharpenOperation(options)

proc pansharpen*(
    operation: PansharpenOperation, x, y, width, height: int
): seq[float64] =
  ## Returns band-sequential Float64 pixels for the panchromatic pixel window.
  let h = rawHandle(operation)
  if x < 0 or y < 0 or width <= 0 or height <= 0 or operation.bands <= 0 or
      x > int(high(cint)) or y > int(high(cint)) or width > int(high(cint)) or
      height > int(high(cint)) or width > high(int) div height or
      width * height > high(int) div operation.bands:
    raise newException(ValueError, "invalid pansharpen window")
  result = newSeq[float64](width * height * operation.bands)
  if GDALPansharpenProcessRegion(
    h, cint(x), cint(y), cint(width), cint(height), addr result[0], GDT_Float64
  ) != CE_None:
    raise gdalError("could not pansharpen region")

proc adoptTransformer*(handle: pointer): Transformer =
  ## Takes ownership of a GDAL transformer compatible with GDALDestroyTransformer.
  Transformer(resource: newNativeResource(handle, releaseTransformer))

proc newHomographyTransformer*(matrix: array[9, float64]): Transformer =
  ## Creates a transformer from a forward homography matrix.
  var coefficients = matrix
  let h = GDALCreateHomographyTransformer(addr coefficients[0])
  if h == nil:
    raise gdalError("could not create homography transformer")
  adoptTransformer(h)

proc newGcpTransformer*(
    points: openArray[GDAL_GCP], order = 0, reversed = false
): Transformer =
  ## Fits a polynomial transformer to control points; order 0 selects automatically.
  if points.len == 0 or points.len > int(high(cint)) or order < 0 or order > 3:
    raise newException(ValueError, "invalid control point count or polynomial order")
  let h = GDALCreateGCPTransformer(
    cint(points.len), unsafeAddr points[0], cint(order), cint(reversed)
  )
  if h == nil:
    raise gdalError("could not create GCP transformer")
  adoptTransformer(h)

proc newThinPlateSplineTransformer*(
    points: openArray[GDAL_GCP], reversed = false
): Transformer =
  if points.len == 0 or points.len > int(high(cint)):
    raise newException(ValueError, "invalid control point count")
  let h =
    GDALCreateTPSTransformer(cint(points.len), unsafeAddr points[0], cint(reversed))
  if h == nil:
    raise gdalError("could not create thin plate spline transformer")
  adoptTransformer(h)

proc newRpcTransformer*(
    info: GDALRPCInfoV2,
    reversed = false,
    pixelErrorThreshold = 0.1,
    options: openArray[string] = [],
): Transformer =
  ## Creates an RPC transformer from the native RPC coefficients.
  for option in options:
    checkString(option, "RPC option")
  let args = allocCStringArray(options)
  defer:
    deallocCStringArray(args)
  var coefficients = info
  let h = GDALCreateRPCTransformerV2(
    addr coefficients, cint(reversed), pixelErrorThreshold, args
  )
  if h == nil:
    raise gdalError("could not create RPC transformer")
  adoptTransformer(h)

proc newApproxTransformer*(base: Transformer, maximumError: float64): Transformer =
  ## Approximates a transformer; closing the base invalidates this wrapper.
  if maximumError < 0:
    raise newException(ValueError, "maximum error must be nonnegative")
  let h = GDALCreateApproxTransformer(GDALUseTransformer, rawHandle(base), maximumError)
  if h == nil:
    raise gdalError("could not create approximate transformer")
  Transformer(resource: newNativeResource(h, releaseTransformer), base: base)
