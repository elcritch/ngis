import std/unittest
import ngis/gdal/[datasets, vector, features]
import ngis/gdal/api

suite "typed feature attributes":
  test "schema, values, states, and feature lifecycle":
    let ds = createDataset("MEM", "", 0, 0, bands = 0)
    let layer = ds.createLayer("items", wkbNone)
    let definitions = [
      FieldSpec(name: "i", kind: fkInteger),
      FieldSpec(name: "big", kind: fkInteger64),
      FieldSpec(name: "r", kind: fkReal),
      FieldSpec(name: "s", kind: fkString, width: 40),
      FieldSpec(name: "il", kind: fkIntegerList),
      FieldSpec(name: "bl", kind: fkInteger64List),
      FieldSpec(name: "rl", kind: fkRealList),
      FieldSpec(name: "sl", kind: fkStringList),
      FieldSpec(name: "bin", kind: fkBinary),
    ]
    for d in definitions:
      layer.addField(d)
    var schema: seq[FieldSpec]
    for d in layer.fields:
      schema.add d
    check schema == @definitions
    let f = layer.newFeature()
    check f.hasKey("i")
    check not f.hasKey("missing")
    expect KeyError:
      discard f.fieldValue("missing")
    check f.fieldValue("i").kind == fvUnset
    f.setField("i", FieldValue(kind: fvNull))
    check f.fieldValue("i").kind == fvNull
    f.setField("i", FieldValue(kind: fvInteger, integer: -12))
    f.setField("big", FieldValue(kind: fvInteger64, integer64: 5000000000'i64))
    f.setField("r", FieldValue(kind: fvReal, real: 1.5))
    f.setField("s", FieldValue(kind: fvString, text: "hello"))
    f.setField("il", FieldValue(kind: fvIntegerList, integers: @[1'i32, -2]))
    f.setField("bl", FieldValue(kind: fvInteger64List, integers64: @[5000000000'i64]))
    f.setField("rl", FieldValue(kind: fvRealList, reals: @[1.25, 2.5]))
    f.setField("sl", FieldValue(kind: fvStringList, strings: @["one", "two"]))
    f.setField("bin", FieldValue(kind: fvBinary, binary: @[0'u8, 255]))
    check f.fieldValue("i").integer == -12
    check f.fieldValue("big").integer64 == 5000000000'i64
    check f.fieldValue("r").real == 1.5
    check f.fieldValue("s").text == "hello"
    check f.fieldValue("il").integers == @[1'i32, -2]
    check f.fieldValue("bl").integers64 == @[5000000000'i64]
    check f.fieldValue("rl").reals == @[1.25, 2.5]
    let copied = f.fieldValue("sl")
    check f.fieldValue("bin").binary == @[0'u8, 255]
    f.setField("sl", FieldValue(kind: fvStringList, strings: @["changed"]))
    check copied.strings == @["one", "two"]
    expect ValueError:
      f.setField("i", FieldValue(kind: fvString, text: "wrong"))
    expect ValueError:
      f.setField("sl", FieldValue(kind: fvStringList, strings: @["a\0b"]))
    var count = 0
    for name, value in f.pairs:
      check name.len > 0
      discard value
      inc count
    check count == definitions.len
    f.setField("i", FieldValue(kind: fvUnset))
    check f.fieldValue("i").kind == fvUnset
    layer.add(f)
    let id = f.id
    let loaded = layer.feature(id)
    check loaded.fieldValue("s").text == "hello"
    loaded.setField("s", FieldValue(kind: fvString, text: "updated"))
    layer.update(loaded)
    check layer.feature(id).fieldValue("s").text == "updated"
    layer.delete(id)
    expect KeyError:
      discard layer.feature(id)
    check copied.strings == @["one", "two"]

  test "reject invalid schemas":
    let ds = createDataset("MEM", "", 0, 0, bands = 0)
    let layer = ds.createLayer("items", wkbNone)
    expect ValueError:
      layer.addField(FieldSpec(name: "bad\0name", kind: fkString))
    expect ValueError:
      layer.addField(FieldSpec(name: "x", kind: fkString, width: -1))

  test "date, time, subtypes and convenient setters":
    let ds = createDataset("MEM", "", 0, 0, bands = 0)
    let layer = ds.createLayer("dates", wkbNone)
    layer.addField(FieldSpec(name: "date", kind: fkDate))
    layer.addField(FieldSpec(name: "time", kind: fkTime))
    layer.addField(FieldSpec(name: "datetime", kind: fkDateTime))
    layer.addField(FieldSpec(name: "bool", kind: fkInteger, subtype: fsBoolean))
    layer.addField(FieldSpec(name: "list", kind: fkStringList))
    let f = layer.newFeature()
    let dt = FieldDateTime(
      year: 2025,
      month: 6,
      day: 12,
      hour: 10,
      minute: 20,
      second: 31.25,
      zone: tzOffset,
      offsetMinutes: 330,
    )
    f.setField("date", FieldValue(kind: fvDate, dateTime: dt))
    f.setField("time", FieldValue(kind: fvTime, dateTime: dt))
    f.setField("datetime", FieldValue(kind: fvDateTime, dateTime: dt))
    check f.fieldValue("date").kind == fvDate
    check f.fieldValue("time").kind == fvTime
    check f.fieldValue("datetime").dateTime == dt
    f.setField("bool", true)
    check f.fieldValue("bool").integer == 1
    check f.fieldSpec("bool").subtype == fsBoolean
    f.setField("list", @["a", "b"])
    let copy = f.fieldValue("list")
    expect ValueError:
      f.setField("datetime", true)
    expect ValueError:
      f.setField("datetime", FieldValue(kind: fvTime, dateTime: dt))
    var invalid = dt
    invalid.offsetMinutes = 7
    expect ValueError:
      f.setField("datetime", FieldValue(kind: fvDateTime, dateTime: invalid))
    f.close()
    check copy.strings == @["a", "b"]
