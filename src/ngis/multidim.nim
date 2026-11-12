## Owning wrappers for GDAL multidimensional datasets and their objects.
import ./gdal
import ./datasets
import ./private/resources

type
  Group* = object
    resource: NativeResource[GDALGroupH]
    dataset: Dataset

  MDArray* = object
    resource: NativeResource[GDALMDArrayH]
    dataset: Dataset

  Dimension* = object
    resource: NativeResource[GDALDimensionH]
    dataset: Dataset

  Attribute* = object
    resource: NativeResource[GDALAttributeH]
    dataset: Dataset

  ExtendedDataType* = object
    resource: NativeResource[GDALExtendedDataTypeH]

  EDTComponent* = object
    resource: NativeResource[GDALEDTComponentH]

template defineOwner(T, H, releaseFn: untyped) =
  proc rawHandle*(x: T): H =
    rawHandle(x.resource)

  proc close*(x: T) =
    close(x.resource)

  proc own(handle: H, owner: Dataset = nil): T =
    if handle == nil:
      raise gdalError("could not obtain multidimensional object")
    result.resource = newNativeResource(
      handle,
      proc(h: H) {.nimcall, raises: [].} =
        releaseFn(h),
    )
    when compiles(result.dataset):
      result.dataset = owner

defineOwner(Group, GDALGroupH, GDALGroupRelease)
defineOwner(MDArray, GDALMDArrayH, GDALMDArrayRelease)
defineOwner(Dimension, GDALDimensionH, GDALDimensionRelease)
defineOwner(Attribute, GDALAttributeH, GDALAttributeRelease)
defineOwner(ExtendedDataType, GDALExtendedDataTypeH, GDALExtendedDataTypeRelease)
defineOwner(EDTComponent, GDALEDTComponentH, GDALEDTComponentRelease)

proc checked(s: string): cstring =
  if '\0' in s:
    raise newException(ValueError, "text contains a NUL byte")
  s.cstring

proc createMultiDimDataset*(driverName, path: string): Dataset =
  GDALAllRegister()
  let driver = GDALGetDriverByName(checked(driverName))
  if driver == nil:
    raise newException(ValueError, "unknown GDAL driver: " & driverName)
  wrapDataset(GDALCreateMultiDimensional(driver, checked(path), nil, nil))

proc rootGroup*(dataset: Dataset): Group =
  let h = dataset.rawHandle
  discard GDALReferenceDataset(h)
  let owner = wrapDataset(h)
  own(GDALDatasetGetRootGroup(h), owner)

proc createGroup*(group: Group, name: string): Group =
  own(GDALGroupCreateGroup(group.rawHandle, checked(name), nil), group.dataset)

proc openGroup*(group: Group, name: string): Group =
  own(GDALGroupOpenGroup(group.rawHandle, checked(name), nil), group.dataset)

proc openArray*(group: Group, name: string): MDArray =
  own(GDALGroupOpenMDArray(group.rawHandle, checked(name), nil), group.dataset)

proc names(list: cstringArray): seq[string] =
  if list != nil:
    defer:
      CSLDestroy(list)
    var i = 0
    while list[i] != nil:
      result.add $list[i]
      inc i

proc groupNames*(group: Group): seq[string] =
  names(GDALGroupGetGroupNames(group.rawHandle, nil))

proc arrayNames*(group: Group): seq[string] =
  names(GDALGroupGetMDArrayNames(group.rawHandle, nil))

proc name*(group: Group): string =
  $GDALGroupGetName(group.rawHandle)

proc name*(array: MDArray): string =
  $GDALMDArrayGetName(array.rawHandle)

proc name*(dim: Dimension): string =
  $GDALDimensionGetName(dim.rawHandle)

proc name*(attr: Attribute): string =
  $GDALAttributeGetName(attr.rawHandle)

proc size*(dim: Dimension): uint64 =
  GDALDimensionGetSize(dim.rawHandle)

proc createDimension*(
    group: Group, name: string, size: uint64, kind = "", direction = ""
): Dimension =
  if size == 0:
    raise newException(ValueError, "dimension size must be positive")
  own(
    GDALGroupCreateDimension(
      group.rawHandle, checked(name), checked(kind), checked(direction), size, nil
    ),
    group.dataset,
  )

proc numericType*(kind: GDALDataType): ExtendedDataType =
  own(GDALExtendedDataTypeCreate(kind))

proc stringType*(maxLength: int = 0): ExtendedDataType =
  if maxLength < 0:
    raise newException(ValueError, "negative string length")
  own(GDALExtendedDataTypeCreateString(csize_t(maxLength)))

proc size*(typ: ExtendedDataType): int =
  int(GDALExtendedDataTypeGetSize(typ.rawHandle))

proc numericDataType*(typ: ExtendedDataType): GDALDataType =
  GDALExtendedDataTypeGetNumericDataType(typ.rawHandle)

proc createComponent*(name: string, offset: int, typ: ExtendedDataType): EDTComponent =
  if offset < 0:
    raise newException(ValueError, "negative component offset")
  own(GDALEDTComponentCreate(checked(name), csize_t(offset), typ.rawHandle))

proc name*(component: EDTComponent): string =
  $GDALEDTComponentGetName(component.rawHandle)

proc offset*(component: EDTComponent): int =
  int(GDALEDTComponentGetOffset(component.rawHandle))

proc dataType*(component: EDTComponent): ExtendedDataType =
  own(GDALEDTComponentGetType(component.rawHandle))

proc compoundType*(
    name: string, size: int, components: openArray[EDTComponent]
): ExtendedDataType =
  if size <= 0:
    raise newException(ValueError, "compound size must be positive")
  var handles: seq[GDALEDTComponentH]
  for component in components:
    handles.add component.rawHandle
  own(
    GDALExtendedDataTypeCreateCompound(
      checked(name),
      csize_t(size),
      csize_t(handles.len),
      if handles.len == 0:
        nil
      else:
        addr handles[0]
      ,
    )
  )

proc createArray*(
    group: Group, name: string, dims: openArray[Dimension], typ: ExtendedDataType
): MDArray =
  var handles: seq[GDALDimensionH]
  for dim in dims:
    handles.add dim.rawHandle
  let data =
    if handles.len == 0:
      nil
    else:
      addr handles[0]
  own(
    GDALGroupCreateMDArray(
      group.rawHandle, checked(name), csize_t(handles.len), data, typ.rawHandle, nil
    ),
    group.dataset,
  )

proc dimensions*(group: Group): seq[Dimension] =
  var n: csize_t
  let raw = GDALGroupGetDimensions(group.rawHandle, addr n, nil)
  if raw != nil:
    defer:
      VSIFree(raw)
    let a = cast[ptr UncheckedArray[GDALDimensionH]](raw)
    for i in 0 ..< int(n):
      result.add own(a[i], group.dataset)

proc dimensions*(array: MDArray): seq[Dimension] =
  var n: csize_t
  let raw = GDALMDArrayGetDimensions(array.rawHandle, addr n)
  if raw != nil:
    defer:
      VSIFree(raw)
    let a = cast[ptr UncheckedArray[GDALDimensionH]](raw)
    for i in 0 ..< int(n):
      result.add own(a[i], array.dataset)

proc shape*(array: MDArray): seq[uint64] =
  for d in array.dimensions:
    result.add d.size

proc dataType*(array: MDArray): ExtendedDataType =
  own(GDALMDArrayGetDataType(array.rawHandle))

template bufferKind(T: typedesc): GDALDataType =
  when T is uint8:
    GDT_Byte
  elif T is int8:
    GDT_Int8
  elif T is uint16:
    GDT_UInt16
  elif T is int16:
    GDT_Int16
  elif T is uint32:
    GDT_UInt32
  elif T is int32:
    GDT_Int32
  elif T is uint64:
    GDT_UInt64
  elif T is int64:
    GDT_Int64
  elif T is float32:
    GDT_Float32
  elif T is float64:
    GDT_Float64
  else:
    {.error: "unsupported multidimensional buffer type".}

# GUInt64 is unsigned long long in GDAL, whereas Nim's uint64 can be
# unsigned long on LP64 platforms. Keep the pointer conversion explicit.
static:
  doAssert sizeof(uint64) == sizeof(GUInt64)

proc nativeIndexPointer(values: openArray[uint64]): ptr GUInt64 =
  if values.len > 0:
    result = cast[ptr GUInt64](unsafeAddr values[0])

proc blockIndexPointer(values: openArray[uint64]): ptr uint64 =
  if values.len > 0:
    result = unsafeAddr values[0]

proc slab(
    array: MDArray, start, count: openArray[uint64]
): tuple[starts: seq[uint64], counts: seq[csize_t], length: int] =
  let shape = array.shape
  if start.len != shape.len or count.len != shape.len:
    raise newException(ValueError, "slab rank does not match array")
  result.length = 1
  for i in 0 ..< shape.len:
    if count[i] == 0 or start[i] >= shape[i] or count[i] > shape[i] - start[i]:
      raise newException(ValueError, "slab is outside array dimensions")
    if count[i] > uint64(high(int)) or result.length > high(int) div int(count[i]):
      raise newException(ValueError, "slab is too large")
    result.length *= int(count[i])
    result.starts.add start[i]
    result.counts.add csize_t(count[i])

proc readSlab*[T](
    array: MDArray, start, count: openArray[uint64], _: typedesc[T]
): seq[T] =
  var s = slab(array, start, count)
  if s.length > high(int) div sizeof(T):
    raise newException(ValueError, "buffer is too large")
  result = newSeq[T](s.length)
  let typ = numericType(bufferKind(T))
  if GDALMDArrayRead(
    array.rawHandle,
    nativeIndexPointer(s.starts),
    (if s.counts.len == 0: nil else: addr s.counts[0]),
    nil,
    nil,
    typ.rawHandle,
    addr result[0],
    addr result[0],
    csize_t(s.length * sizeof(T)),
  ) == 0:
    raise gdalError("could not read multidimensional array")

proc writeSlab*[T](
    array: MDArray, start, count: openArray[uint64], values: openArray[T]
) =
  var s = slab(array, start, count)
  if s.length != values.len:
    raise newException(ValueError, "buffer length does not match slab")
  if s.length > high(int) div sizeof(T):
    raise newException(ValueError, "buffer is too large")
  let typ = numericType(bufferKind(T))
  let data = cast[pointer](unsafeAddr values[0])
  if GDALMDArrayWrite(
    array.rawHandle,
    nativeIndexPointer(s.starts),
    (if s.counts.len == 0: nil else: addr s.counts[0]),
    nil,
    nil,
    typ.rawHandle,
    data,
    data,
    csize_t(s.length * sizeof(T)),
  ) == 0:
    raise gdalError("could not write multidimensional array")

proc read*[T](array: MDArray, _: typedesc[T]): seq[T] =
  let shape = array.shape
  readSlab(array, newSeq[uint64](shape.len), shape, T)

proc write*[T](array: MDArray, values: openArray[T]) =
  let shape = array.shape
  writeSlab(array, newSeq[uint64](shape.len), shape, values)

proc createAttribute*(
    group: Group, name: string, typ: ExtendedDataType, shape: openArray[uint64] = []
): Attribute =
  for n in shape:
    if n == 0:
      raise newException(ValueError, "attribute dimensions must be positive")
  own(
    GDALGroupCreateAttribute(
      group.rawHandle,
      checked(name),
      csize_t(shape.len),
      nativeIndexPointer(shape),
      typ.rawHandle,
      nil,
    ),
    group.dataset,
  )

proc createAttribute*(
    array: MDArray, name: string, typ: ExtendedDataType, shape: openArray[uint64] = []
): Attribute =
  for n in shape:
    if n == 0:
      raise newException(ValueError, "attribute dimensions must be positive")
  own(
    GDALMDArrayCreateAttribute(
      array.rawHandle,
      checked(name),
      csize_t(shape.len),
      nativeIndexPointer(shape),
      typ.rawHandle,
      nil,
    ),
    array.dataset,
  )

proc attribute*(group: Group, name: string): Attribute =
  own(GDALGroupGetAttribute(group.rawHandle, checked(name)), group.dataset)

proc attribute*(array: MDArray, name: string): Attribute =
  own(GDALMDArrayGetAttribute(array.rawHandle, checked(name)), array.dataset)

proc write*(attribute: Attribute, value: string) =
  if GDALAttributeWriteString(attribute.rawHandle, checked(value)) == 0:
    raise gdalError("could not write attribute")

proc write*(attribute: Attribute, value: float64) =
  if GDALAttributeWriteDouble(attribute.rawHandle, value) == 0:
    raise gdalError("could not write attribute")

proc readString*(attribute: Attribute): string =
  let value = GDALAttributeReadAsString(attribute.rawHandle)
  if value == nil:
    raise gdalError("could not read attribute")
  $value

proc readFloat*(attribute: Attribute): float64 =
  GDALAttributeReadAsDouble(attribute.rawHandle)

proc components*(typ: ExtendedDataType): seq[EDTComponent] =
  ## Copies component descriptors so they remain valid after the list is freed.
  var count: csize_t
  let raw = GDALExtendedDataTypeGetComponents(typ.rawHandle, addr count)
  if raw != nil:
    defer:
      GDALExtendedDataTypeFreeComponents(raw, count)
    let entries = cast[ptr UncheckedArray[GDALEDTComponentH]](raw)
    for i in 0 ..< int(count):
      let item = entries[i]
      let itemType = own(GDALEDTComponentGetType(item))
      result.add createComponent(
        $GDALEDTComponentGetName(item), int(GDALEDTComponentGetOffset(item)), itemType
      )

proc dataType*(attribute: Attribute): ExtendedDataType =
  own(GDALAttributeGetDataType(attribute.rawHandle))

proc write*(attribute: Attribute, value: int64) =
  if GDALAttributeWriteInt64(attribute.rawHandle, value) == 0:
    raise gdalError("could not write attribute")

proc readInt*(attribute: Attribute): int64 =
  GDALAttributeReadAsInt64(attribute.rawHandle)

proc openMultiDimDataset*(path: string, update = false): Dataset =
  ## Opens an existing multidimensional dataset.
  GDALAllRegister()
  let flags =
    cuint(GDAL_OF_MULTIDIM_RASTER) or
    (if update: cuint(GDAL_OF_UPDATE) else: cuint(GDAL_OF_READONLY))
  wrapDataset(GDALOpenEx(checked(path), flags, nil, nil, nil))

type RawBlockInfo* = object
  resource: NativeResource[ptr GDALMDArrayRawBlockInfo]

proc rawHandle*(info: RawBlockInfo): ptr GDALMDArrayRawBlockInfo =
  info.resource.rawHandle

proc close*(info: RawBlockInfo) =
  info.resource.close()

proc newRawBlockInfo*(): RawBlockInfo =
  RawBlockInfo(
    resource: newNativeResource(
      GDALMDArrayRawBlockInfoCreate(),
      proc(p: ptr GDALMDArrayRawBlockInfo) {.nimcall, raises: [].} =
        GDALMDArrayRawBlockInfoRelease(p),
    )
  )

proc rawBlockInfo*(array: MDArray, coordinates: openArray[uint64]): RawBlockInfo =
  if coordinates.len != array.shape.len:
    raise newException(ValueError, "block coordinate rank does not match array")
  result = newRawBlockInfo()
  if not GDALMDArrayGetRawBlockInfo(
    array.rawHandle, blockIndexPointer(coordinates), result.rawHandle
  ):
    raise gdalError("could not get raw block information")

proc filename*(info: RawBlockInfo): string =
  let p = info.rawHandle.pszFilename
  if p == nil:
    ""
  else:
    $p

proc offset*(info: RawBlockInfo): uint64 =
  info.rawHandle.nOffset

proc size*(info: RawBlockInfo): uint64 =
  info.rawHandle.nSize

proc readStrings*(attribute: Attribute): seq[string] =
  let values = GDALAttributeReadAsStringArray(attribute.rawHandle)
  if values == nil:
    raise gdalError("could not read string attribute")
  defer:
    CSLDestroy(values)
  var i = 0
  while values[i] != nil:
    result.add $values[i]
    inc i

proc write*(attribute: Attribute, values: openArray[string]) =
  for value in values:
    if '\0' in value:
      raise newException(ValueError, "attribute contains a NUL byte")
  let strings = allocCStringArray(values)
  defer:
    deallocCStringArray(strings)
  if GDALAttributeWriteStringArray(attribute.rawHandle, strings) == 0:
    raise gdalError("could not write string attribute")

proc readRawNumeric*(attribute: Attribute): seq[byte] =
  ## Copies numeric raw bytes while freeing the native result with its attribute.
  let typ = attribute.dataType
  if GDALExtendedDataTypeGetClass(typ.rawHandle) != GEDTC_NUMERIC:
    raise newException(ValueError, "raw byte copies require a numeric attribute")
  let h = attribute.rawHandle
  var size: csize_t
  let raw = GDALAttributeReadAsRaw(h, addr size)
  if raw == nil:
    raise gdalError("could not read raw attribute")
  defer:
    GDALAttributeFreeRawResult(h, raw, size)
  if size > csize_t(high(int)):
    raise newException(ValueError, "attribute is too large")
  result = newSeq[byte](int(size))
  if size != 0:
    copyMem(addr result[0], raw, int(size))

proc readStrings*(array: MDArray): seq[string] =
  ## Reads string values, copying and freeing each native string.
  let shape = array.shape
  var s = slab(array, newSeq[uint64](shape.len), shape)
  if s.length > high(int) div sizeof(cstring):
    raise newException(ValueError, "string array is too large")
  var values = newSeq[cstring](s.length)
  defer:
    for value in values:
      if value != nil:
        CPLFree(value)
  let typ = stringType()
  if GDALMDArrayRead(
    array.rawHandle,
    nativeIndexPointer(s.starts),
    (if s.counts.len == 0: nil else: addr s.counts[0]),
    nil,
    nil,
    typ.rawHandle,
    addr values[0],
    addr values[0],
    csize_t(values.len * sizeof(cstring)),
  ) == 0:
    raise gdalError("could not read string array")
  for value in values:
    result.add(
      if value == nil:
        ""
      else:
        $value
    )

proc write*(array: MDArray, values: openArray[string]) =
  let shape = array.shape
  var s = slab(array, newSeq[uint64](shape.len), shape)
  if values.len != s.length:
    raise newException(ValueError, "buffer length does not match array")
  if values.len > high(int) div sizeof(cstring):
    raise newException(ValueError, "string array is too large")
  var pointers = newSeq[cstring](values.len)
  for i, value in values:
    if '\0' in value:
      raise newException(ValueError, "array value contains a NUL byte")
    pointers[i] = value.cstring
  let typ = stringType()
  if GDALMDArrayWrite(
    array.rawHandle,
    nativeIndexPointer(s.starts),
    (if s.counts.len == 0: nil else: addr s.counts[0]),
    nil,
    nil,
    typ.rawHandle,
    addr pointers[0],
    addr pointers[0],
    csize_t(pointers.len * sizeof(cstring)),
  ) == 0:
    raise gdalError("could not write string array")

proc retainedDataset(dataset: Dataset): Dataset =
  if dataset != nil:
    let h = dataset.rawHandle
    discard GDALReferenceDataset(h)
    result = wrapDataset(h)

proc adoptGroup*(handle: GDALGroupH, dataset: Dataset = nil): Group =
  ## Takes an independently owned handle. Borrowed handles must first be
  ## independently referenced. An optional dataset is retained separately.
  if handle == nil:
    raise newException(ValueError, "cannot adopt a nil group")
  own(handle, retainedDataset(dataset))

proc adoptMDArray*(handle: GDALMDArrayH, dataset: Dataset = nil): MDArray =
  ## Takes an independently owned handle, retaining the optional dataset.
  ## Borrowed handles must first be independently referenced.
  if handle == nil:
    raise newException(ValueError, "cannot adopt a nil array")
  own(handle, retainedDataset(dataset))

proc adoptDimension*(handle: GDALDimensionH, dataset: Dataset = nil): Dimension =
  ## Takes an independently owned handle, retaining the optional dataset.
  ## Borrowed handles must first be independently referenced.
  if handle == nil:
    raise newException(ValueError, "cannot adopt a nil dimension")
  own(handle, retainedDataset(dataset))

proc adoptAttribute*(handle: GDALAttributeH, dataset: Dataset = nil): Attribute =
  ## Takes an independently owned handle, retaining the optional dataset.
  ## Borrowed handles must first be independently referenced.
  if handle == nil:
    raise newException(ValueError, "cannot adopt a nil attribute")
  own(handle, retainedDataset(dataset))

proc adoptExtendedDataType*(handle: GDALExtendedDataTypeH): ExtendedDataType =
  ## Takes an independently owned handle; do not pass a borrowed handle.
  if handle == nil:
    raise newException(ValueError, "cannot adopt a nil data type")
  own(handle)

proc adoptEDTComponent*(handle: GDALEDTComponentH): EDTComponent =
  ## Takes an independently owned handle; do not pass a borrowed handle.
  if handle == nil:
    raise newException(ValueError, "cannot adopt a nil component")
  own(handle)
