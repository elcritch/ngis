## Typed multidimensional arrays, slices, and owned row-major values.
import ./[gdal, multidim]

type
  ArraySlice* = object
    starts, counts: seq[uint64]

  ArrayData*[T] = object
    dimensions: seq[uint64]
    values: seq[T]

proc elementCount(shape: openArray[uint64]): int =
  result = 1
  for size in shape:
    if size == 0 or size > uint64(high(int)) or result > high(int) div int(size):
      raise newException(ValueError, "invalid array shape")
    result *= int(size)

proc initArraySlice*(starts, counts: openArray[uint64]): ArraySlice =
  ## Construct a slice; array bounds are checked when it is used.
  if starts.len != counts.len:
    raise newException(ValueError, "slice start and count ranks differ")
  discard elementCount(counts)
  ArraySlice(starts: @starts, counts: @counts)

proc start*(slice: ArraySlice): seq[uint64] =
  slice.starts

proc count*(slice: ArraySlice): seq[uint64] =
  slice.counts

proc initArrayData*[T](shape: openArray[uint64]): ArrayData[T] =
  let count = elementCount(shape)
  if count > high(int) div sizeof(T):
    raise newException(ValueError, "array buffer is too large")
  ArrayData[T](dimensions: @shape, values: newSeq[T](count))

proc initArrayData*[T](shape: openArray[uint64], values: sink seq[T]): ArrayData[T] =
  if elementCount(shape) != values.len:
    raise newException(ValueError, "array buffer length does not match shape")
  ArrayData[T](dimensions: @shape, values: values)

proc shape*[T](data: ArrayData[T]): seq[uint64] =
  data.dimensions

proc len*[T](data: ArrayData[T]): int =
  data.values.len

proc offset[T](data: ArrayData[T], indices: openArray[int]): int =
  if elementCount(data.dimensions) != data.values.len:
    raise newException(ValueError, "invalid array data")
  if indices.len != data.dimensions.len:
    raise newException(ValueError, "array index rank does not match shape")
  for i, index in indices:
    if index < 0 or uint64(index) >= data.dimensions[i]:
      raise newException(ValueError, "array index is out of bounds")
    result = result * int(data.dimensions[i]) + index

proc `[]`*[T](data: ArrayData[T], indices: varargs[int]): T =
  data.values[data.offset(indices)]

proc `[]=`*[T](data: var ArrayData[T], indices: varargs[int], value: T) =
  data.values[data.offset(indices)] = value

proc `[]=`*[T](data: var ArrayData[T], value: T) =
  data.values[data.offset([])] = value

iterator items*[T](data: ArrayData[T]): T =
  for value in data.values:
    yield value

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
  array.readSlab(slice.starts, slice.counts, T)

proc write*[T](array: MDArray, slice: ArraySlice, values: openArray[T]) =
  array.writeSlab(slice.starts, slice.counts, values)

proc readArrayData*[T](array: MDArray, elementType: typedesc[T]): ArrayData[T] =
  initArrayData(array.shape, array.read(T))

proc readArrayData*[T](
    array: MDArray, slice: ArraySlice, elementType: typedesc[T]
): ArrayData[T] =
  initArrayData(slice.counts, array.read(slice, T))

proc write*[T](array: MDArray, data: ArrayData[T]) =
  if array.shape != data.dimensions or elementCount(data.dimensions) != data.values.len:
    raise newException(ValueError, "array data shape does not match array")
  array.write(data.values)

proc write*[T](array: MDArray, slice: ArraySlice, data: ArrayData[T]) =
  if slice.counts != data.dimensions or elementCount(data.dimensions) != data.values.len:
    raise newException(ValueError, "array data shape does not match slice")
  array.write(slice, data.values)
