import std/unittest
import ngis/gdal/[datasets, multidim, arrayops]

suite "multidimensional array workflows":
  test "typed arrays, slices, lookup, iteration and retained handles":
    let ds = createMultiDimDataset("MEM", "")
    let root = ds.rootGroup
    let subgroup = root.createGroup("child")
    let y = subgroup.createDimension("y", 2)
    let x = subgroup.createDimension("x", 3)
    let arr = subgroup.createArray("values", [y, x], int32)
    var data = initArrayData([2'u64, 3], @[1'i32, 2, 3, 4, 5, 6])
    data[1, 2] = 9
    arr.write(data)
    check subgroup.hasKey("values")
    check "values" in subgroup
    check not subgroup.hasKey("missing")
    expect KeyError:
      discard subgroup["missing"]
    var retained: MDArray
    for item in subgroup.arrays:
      retained = item
    var child: Group
    for item in root.groups:
      child = item
    let slice = initArraySlice([1'u64, 1], [1'u64, 2])
    check arr.read(slice, int32) == @[5'i32, 9]
    let part = arr.readArrayData(slice, int32)
    check part.shape == @[1'u64, 2]
    check part[0, 1] == 9
    arr.write(slice, initArrayData([1'u64, 2], @[7'i32, 8]))
    ds.close()
    check retained.readArrayData(int32)[1, 2] == 8
    check child["values"].read(int32)[4] == 7
    var empty: ArrayData[int32]
    expect ValueError:
      discard empty[]
    expect ValueError:
      discard data[2, 0]
    expect ValueError:
      discard data[0]
    expect ValueError:
      discard initArrayData([2'u64, 2], @[1'i32])
    expect ValueError:
      arr.write(initArrayData([3'u64, 2], @[1'i32, 2, 3, 4, 5, 6]))
    expect ValueError:
      discard arr.read(initArraySlice([1'u64, 2], [1'u64, 2]), int32)

  test "scalar data has one value and rank zero":
    let ds = createMultiDimDataset("MEM", "")
    let root = ds.rootGroup
    let arr = root.createArray("scalar", [], float64)
    var data = initArrayData[float64]([])
    data[] = 3.5
    arr.write(data)
    check arr.readArrayData(float64)[] == 3.5
    check arr.read(initArraySlice([], []), float64) == @[3.5]
