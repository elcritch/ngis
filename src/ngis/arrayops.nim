## Shared owned multidimensional arrays and slice values.
type
  ArraySlice* = object
    starts, counts: seq[uint64]

  ArrayData*[T] = object
    dimensions: seq[uint64]
    values: seq[T]

proc arrayElementCount*(shape: openArray[uint64]): int =
  result = 1
  for size in shape:
    if size == 0 or size > uint64(high(int)) or result > high(int) div int(size):
      raise newException(ValueError, "invalid array shape")
    result *= int(size)

proc initArraySlice*(starts, counts: openArray[uint64]): ArraySlice =
  ## Construct a slice; array bounds are checked when it is used.
  if starts.len != counts.len:
    raise newException(ValueError, "slice start and count ranks differ")
  discard arrayElementCount(counts)
  ArraySlice(starts: @starts, counts: @counts)

proc start*(slice: ArraySlice): seq[uint64] =
  slice.starts

proc count*(slice: ArraySlice): seq[uint64] =
  slice.counts

proc initArrayData*[T](shape: openArray[uint64]): ArrayData[T] =
  let count = arrayElementCount(shape)
  if count > high(int) div sizeof(T):
    raise newException(ValueError, "array buffer is too large")
  ArrayData[T](dimensions: @shape, values: newSeq[T](count))

proc initArrayData*[T](shape: openArray[uint64], values: sink seq[T]): ArrayData[T] =
  if arrayElementCount(shape) != values.len:
    raise newException(ValueError, "array buffer length does not match shape")
  ArrayData[T](dimensions: @shape, values: values)

proc shape*[T](data: ArrayData[T]): seq[uint64] =
  data.dimensions

proc len*[T](data: ArrayData[T]): int =
  data.values.len

proc offset[T](data: ArrayData[T], indices: openArray[int]): int =
  if arrayElementCount(data.dimensions) != data.values.len:
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

proc data*[T](values: ArrayData[T]): lent seq[T] =
  ## Borrow the contiguous row-major values without changing their shape.
  values.values
