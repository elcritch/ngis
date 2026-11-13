## GDAL multidimensional I/O using shared array and slice values.
import ./[api, multidim]
import ../arrayops as arrayvalues
export arrayvalues

proc hasKey*(group: Group, name: string): bool =
  ## Report whether an array with this name is present.
  name in group.arrayNames

proc contains*(group: Group, name: string): bool =
  group.hasKey(name)

proc `[]`*(group: Group, name: string): MDArray =
  if not group.hasKey(name):
    raise newException(KeyError, "array not found: " & name)
  group.openArray(name)

iterator arrays*(group: Group): MDArray =
  ## Each yielded array owns its handle independently of other results.
  for name in group.arrayNames:
    yield group.openArray(name)

iterator groups*(group: Group): Group =
  ## Each yielded group owns its handle independently of other results.
  for name in group.groupNames:
    yield group.openGroup(name)

proc primitiveType(T: typedesc): GDALDataType =
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
    {.error: "unsupported multidimensional element type".}

proc createArray*[T](
    group: Group, name: string, dims: openArray[Dimension], elementType: typedesc[T]
): MDArray =
  group.createArray(name, dims, numericType(primitiveType(T)))

proc read*[T](array: MDArray, slice: ArraySlice, elementType: typedesc[T]): seq[T] =
  array.readSlab(slice.start, slice.count, T)

proc write*[T](array: MDArray, slice: ArraySlice, values: openArray[T]) =
  array.writeSlab(slice.start, slice.count, values)

proc readArrayData*[T](array: MDArray, elementType: typedesc[T]): ArrayData[T] =
  initArrayData(array.shape, array.read(T))

proc readArrayData*[T](
    array: MDArray, slice: ArraySlice, elementType: typedesc[T]
): ArrayData[T] =
  initArrayData(slice.count, array.read(slice, T))

proc write*[T](array: MDArray, data: ArrayData[T]) =
  if array.shape != data.shape or arrayElementCount(data.shape) != data.len:
    raise newException(ValueError, "array data shape does not match array")
  array.write(data.data)

proc write*[T](array: MDArray, slice: ArraySlice, data: ArrayData[T]) =
  if slice.count != data.shape or arrayElementCount(data.shape) != data.len:
    raise newException(ValueError, "array data shape does not match slice")
  array.write(slice, data.data)
