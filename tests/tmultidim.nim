import std/unittest
import ngis/gdal/[datasets, multidim]
import ngis/gdal/api

suite "owning multidimensional API":
  test "groups, dimensions, slabs and attributes survive original dataset close":
    let ds = createMultiDimDataset("MEM", "")
    let root = ds.rootGroup
    let group = root.createGroup("measurements")
    check root.groupNames == @["measurements"]
    let y = group.createDimension("y", 2)
    let x = group.createDimension("x", 3)
    let typ = numericType(GDT_Float64)
    let values = group.createArray("temperature", [y, x], typ)
    check group.arrayNames == @["temperature"]
    check values.shape == @[2'u64, 3'u64]
    values.write([1.0, 2, 3, 4, 5, 6])
    check values.readSlab([1'u64, 1], [1'u64, 2], float64) == @[5.0, 6.0]
    values.writeSlab([0'u64, 1], [1'u64, 2], [20.0, 30.0])
    check values.read(float64) == @[1.0, 20, 30, 4, 5, 6]
    expect ValueError:
      values.write([1.0])
    expect ValueError:
      discard values.readSlab([2'u64, 0], [1'u64, 1], float64)
    let attr = values.createAttribute("unit", stringType())
    attr.write("kelvin")
    check values.attribute("unit").readString == "kelvin"
    ds.close()
    check group.openArray("temperature").read(float64)[1] == 20.0
    let alias = values
    values.close()
    expect ValueError:
      discard alias.rawHandle
    values.close()

  test "compound type owns its components":
    let number = numericType(GDT_Int32)
    let component = createComponent("value", 0, number)
    let typ = compoundType("record", 4, [component])
    check component.name == "value"
    check component.offset == 0
    check component.dataType.numericDataType == GDT_Int32
    check typ.size == 4
    let parts = typ.components
    check parts.len == 1
    check parts[0].name == "value"
    check parts[0].dataType.numericDataType == GDT_Int32

  test "adopted native array view retains dataset and closes aliases":
    let ds = createMultiDimDataset("MEM", "")
    let root = ds.rootGroup
    let dim = root.createDimension("x", 3)
    let array = root.createArray("values", [dim], numericType(GDT_Int32))
    array.write([4'i32, 5, 6])
    let view = adoptMDArray(GDALMDArrayGetView(array.rawHandle, "[:]"), ds)
    let alias = view
    array.close()
    root.close()
    ds.close()
    check view.read(int32) == @[4'i32, 5, 6]
    view.close()
    expect ValueError:
      discard alias.rawHandle
    expect ValueError:
      discard adoptMDArray(nil)
