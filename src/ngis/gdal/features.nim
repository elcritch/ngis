## Typed, copied attribute values and field schemas for vector features.
## Deprecated GDAL wide-string field types are read as string or string-list
## kinds; newly created fields use the corresponding UTF-8 GDAL types.
import ./[api, vector]
import ../features as fieldvalues
export fieldvalues

proc checkText(s: string) =
  if '\0' in s:
    raise newException(ValueError, "text contains a NUL byte")

proc native(k: FieldKind): OGRFieldType =
  case k
  of fkInteger: OFTInteger
  of fkInteger64: OFTInteger64
  of fkReal: OFTReal
  of fkString: OFTString
  of fkIntegerList: OFTIntegerList
  of fkInteger64List: OFTInteger64List
  of fkRealList: OFTRealList
  of fkStringList: OFTStringList
  of fkBinary: OFTBinary
  of fkDate: OFTDate
  of fkTime: OFTTime
  of fkDateTime: OFTDateTime

proc fieldKind(t: OGRFieldType): FieldKind =
  if t == OFTInteger:
    fkInteger
  elif t == OFTInteger64:
    fkInteger64
  elif t == OFTReal:
    fkReal
  elif t == OFTString or t == OFTWideString:
    fkString
  elif t == OFTIntegerList:
    fkIntegerList
  elif t == OFTInteger64List:
    fkInteger64List
  elif t == OFTRealList:
    fkRealList
  elif t == OFTStringList or t == OFTWideStringList:
    fkStringList
  elif t == OFTBinary:
    fkBinary
  elif t == OFTDate:
    fkDate
  elif t == OFTTime:
    fkTime
  elif t == OFTDateTime:
    fkDateTime
  else:
    raise newException(ValueError, "unsupported field type")

proc subtype(t: OGRFieldSubType): FieldSubtype =
  if t == OFSTNone:
    fsNone
  elif t == OFSTBoolean:
    fsBoolean
  elif t == OFSTInt16:
    fsInt16
  elif t == OFSTFloat32:
    fsFloat32
  elif t == OFSTJSON:
    fsJson
  elif t == OFSTUUID:
    fsUuid
  else:
    raise newException(ValueError, "unsupported field subtype")

proc native(s: FieldSubtype): OGRFieldSubType =
  case s
  of fsNone: OFSTNone
  of fsBoolean: OFSTBoolean
  of fsInt16: OFSTInt16
  of fsFloat32: OFSTFloat32
  of fsJson: OFSTJSON
  of fsUuid: OFSTUUID

proc matches(k: FieldKind, v: FieldValueKind): bool =
  case v
  of fvUnset, fvNull:
    true
  of fvInteger:
    k == fkInteger
  of fvInteger64:
    k == fkInteger64
  of fvReal:
    k == fkReal
  of fvString:
    k == fkString
  of fvIntegerList:
    k == fkIntegerList
  of fvInteger64List:
    k == fkInteger64List
  of fvRealList:
    k == fkRealList
  of fvStringList:
    k == fkStringList
  of fvBinary:
    k == fkBinary
  of fvDate:
    k == fkDate
  of fvTime:
    k == fkTime
  of fvDateTime:
    k == fkDateTime

proc definition(h: OGRFieldDefnH): FieldSpec =
  if h == nil:
    raise newException(IOError, "invalid field definition")
  FieldSpec(
    name: $OGR_Fld_GetNameRef(h),
    kind: fieldKind(OGR_Fld_GetType(h)),
    subtype: subtype(OGR_Fld_GetSubType(h)),
    width: int(OGR_Fld_GetWidth(h)),
    precision: int(OGR_Fld_GetPrecision(h)),
  )

proc addField*(layer: Layer, field: FieldSpec) =
  checkText(field.name)
  if field.name.len == 0 or field.width < 0 or field.precision < 0 or
      field.width > high(cint).int or field.precision > high(cint).int:
    raise newException(ValueError, "invalid field definition")
  if not (
    field.subtype == fsNone or
    (field.subtype in {fsBoolean, fsInt16} and field.kind in {fkInteger, fkIntegerList}) or
    (field.subtype == fsFloat32 and field.kind in {fkReal, fkRealList}) or
    (field.subtype in {fsJson, fsUuid} and field.kind == fkString)
  ):
    raise newException(ValueError, "field subtype does not match type")
  let h = OGR_Fld_Create(field.name.cstring, native(field.kind))
  if h == nil:
    raise newException(IOError, "could not create field definition")
  defer:
    OGR_Fld_Destroy(h)
  OGR_Fld_SetSubType(h, native(field.subtype))
  OGR_Fld_SetWidth(h, cint(field.width))
  OGR_Fld_SetPrecision(h, cint(field.precision))
  if OGR_L_CreateField(layer.rawHandle, h, 0) != OGRERR_NONE:
    raise newException(IOError, "could not add field: " & field.name)

iterator fields*(layer: Layer): FieldSpec =
  let d = OGR_L_GetLayerDefn(layer.rawHandle)
  for i in 0 ..< OGR_FD_GetFieldCount(d):
    yield definition(OGR_FD_GetFieldDefn(d, i))

proc index(f: Feature, name: string): cint =
  checkText(name)
  result = OGR_F_GetFieldIndex(f.rawHandle, name.cstring)
  if result < 0:
    raise newException(KeyError, "field not found: " & name)

proc hasKey*(f: Feature, name: string): bool =
  checkText(name)
  OGR_F_GetFieldIndex(f.rawHandle, name.cstring) >= 0

proc fieldSpec*(f: Feature, name: string): FieldSpec =
  definition(OGR_FD_GetFieldDefn(OGR_F_GetDefnRef(f.rawHandle), f.index(name)))

proc readDateTime(h: OGRFeatureH, i: cint): FieldDateTime =
  var year, month, day, hour, minute, zone: cint
  var second: cfloat
  if OGR_F_GetFieldAsDateTimeEx(
    h,
    i,
    addr year,
    addr month,
    addr day,
    addr hour,
    addr minute,
    addr second,
    addr zone,
  ) == 0:
    raise newException(ValueError, "invalid date/time field")
  result = FieldDateTime(
    year: year, month: month, day: day, hour: hour, minute: minute, second: second
  )
  case zone
  of 0:
    result.zone = tzUnknown
  of 1:
    result.zone = tzLocal
  else:
    result.zone = tzOffset
    result.offsetMinutes = (zone.int - 100) * 15

proc fieldValue*(f: Feature, name: string): FieldValue =
  let h = f.rawHandle
  let i = f.index(name)
  if OGR_F_IsFieldSet(h, i) == 0:
    return FieldValue(kind: fvUnset)
  if OGR_F_IsFieldNull(h, i) != 0:
    return FieldValue(kind: fvNull)
  let k = f.fieldSpec(name).kind
  var n: cint
  case k
  of fkInteger:
    result = FieldValue(kind: fvInteger, integer: OGR_F_GetFieldAsInteger(h, i))
  of fkInteger64:
    result = FieldValue(kind: fvInteger64, integer64: OGR_F_GetFieldAsInteger64(h, i))
  of fkReal:
    result = FieldValue(kind: fvReal, real: OGR_F_GetFieldAsDouble(h, i))
  of fkString:
    result = FieldValue(kind: fvString, text: $OGR_F_GetFieldAsString(h, i))
  of fkIntegerList:
    result = FieldValue(kind: fvIntegerList)
    let p = cast[ptr UncheckedArray[cint]](OGR_F_GetFieldAsIntegerList(h, i, addr n))
    for j in 0 ..< n:
      result.integers.add p[j]
  of fkInteger64List:
    result = FieldValue(kind: fvInteger64List)
    let p = cast[ptr UncheckedArray[int64]](OGR_F_GetFieldAsInteger64List(h, i, addr n))
    for j in 0 ..< n:
      result.integers64.add p[j]
  of fkRealList:
    result = FieldValue(kind: fvRealList)
    let p = cast[ptr UncheckedArray[cdouble]](OGR_F_GetFieldAsDoubleList(h, i, addr n))
    for j in 0 ..< n:
      result.reals.add p[j]
  of fkStringList:
    result = FieldValue(kind: fvStringList)
    let p = OGR_F_GetFieldAsStringList(h, i)
    if p != nil:
      var j = 0
      while p[j] != nil:
        result.strings.add $p[j]
        inc j
  of fkBinary:
    result = FieldValue(kind: fvBinary)
    let p = cast[ptr UncheckedArray[byte]](OGR_F_GetFieldAsBinary(h, i, addr n))
    for j in 0 ..< n:
      result.binary.add p[j]
  of fkDate:
    result = FieldValue(kind: fvDate, dateTime: readDateTime(h, i))
  of fkTime:
    result = FieldValue(kind: fvTime, dateTime: readDateTime(h, i))
  of fkDateTime:
    result = FieldValue(kind: fvDateTime, dateTime: readDateTime(h, i))

proc setField*(f: Feature, name: string, value: FieldValue) =
  let h = f.rawHandle
  let i = f.index(name)
  if not matches(f.fieldSpec(name).kind, value.kind):
    raise newException(ValueError, "field value type does not match schema")
  case value.kind
  of fvUnset:
    OGR_F_UnsetField(h, i)
  of fvNull:
    OGR_F_SetFieldNull(h, i)
  of fvInteger:
    OGR_F_SetFieldInteger(h, i, value.integer)
  of fvInteger64:
    OGR_F_SetFieldInteger64(h, i, value.integer64)
  of fvReal:
    OGR_F_SetFieldDouble(h, i, value.real)
  of fvString:
    checkText(value.text)
    OGR_F_SetFieldString(h, i, value.text.cstring)
  of fvIntegerList:
    if value.integers.len > high(cint).int:
      raise newException(ValueError, "list too long")
    OGR_F_SetFieldIntegerList(
      h,
      i,
      cint(value.integers.len),
      if value.integers.len == 0:
        nil
      else:
        unsafeAddr value.integers[0]
      ,
    )
  of fvInteger64List:
    if value.integers64.len > high(cint).int:
      raise newException(ValueError, "list too long")
    OGR_F_SetFieldInteger64List(
      h,
      i,
      cint(value.integers64.len),
      if value.integers64.len == 0:
        nil
      else:
        cast[ptr GIntBig](unsafeAddr value.integers64[0]),
    )
  of fvRealList:
    if value.reals.len > high(cint).int:
      raise newException(ValueError, "list too long")
    OGR_F_SetFieldDoubleList(
      h,
      i,
      cint(value.reals.len),
      if value.reals.len == 0:
        nil
      else:
        unsafeAddr value.reals[0]
      ,
    )
  of fvStringList:
    var strings = newSeq[cstring](value.strings.len + 1)
    for j, s in value.strings:
      checkText(s)
      strings[j] = s.cstring
    OGR_F_SetFieldStringList(h, i, cast[CSLConstList](addr strings[0]))
  of fvBinary:
    if value.binary.len > high(cint).int:
      raise newException(ValueError, "binary too long")
    OGR_F_SetFieldBinary(
      h,
      i,
      cint(value.binary.len),
      if value.binary.len == 0:
        nil
      else:
        unsafeAddr value.binary[0]
      ,
    )
  of fvDate, fvTime, fvDateTime:
    let dt = value.dateTime
    if dt.year < -32768 or dt.year > 32767 or dt.month notin 0 .. 12 or
        dt.day notin 0 .. 31 or dt.hour notin 0 .. 23 or dt.minute notin 0 .. 59 or
        not (dt.second >= 0 and dt.second < 61):
      raise newException(ValueError, "invalid date/time components")
    var zone: cint
    case dt.zone
    of tzUnknown:
      zone = 0
    of tzLocal:
      zone = 1
    of tzOffset:
      if dt.offsetMinutes mod 15 != 0 or dt.offsetMinutes < -1470 or
          dt.offsetMinutes > 2325:
        raise newException(ValueError, "invalid time zone offset")
      zone = cint(dt.offsetMinutes div 15 + 100)
    OGR_F_SetFieldDateTimeEx(
      h,
      i,
      cint(dt.year),
      cint(dt.month),
      cint(dt.day),
      cint(dt.hour),
      cint(dt.minute),
      dt.second,
      zone,
    )

proc setField*(f: Feature, name: string, value: bool) =
  let d = f.fieldSpec(name)
  if d.kind != fkInteger or d.subtype != fsBoolean:
    raise newException(ValueError, "field is not boolean")
  f.setField(name, FieldValue(kind: fvInteger, integer: int32(value)))

proc setField*(f: Feature, name: string, value: int32) =
  f.setField(name, FieldValue(kind: fvInteger, integer: value))

proc setField*(f: Feature, name, value: string) =
  f.setField(name, FieldValue(kind: fvString, text: value))

proc setField*(f: Feature, name: string, value: seq[int32]) =
  f.setField(name, FieldValue(kind: fvIntegerList, integers: value))

proc setField*(f: Feature, name: string, value: seq[int64]) =
  f.setField(name, FieldValue(kind: fvInteger64List, integers64: value))

proc setField*(f: Feature, name: string, value: seq[float64]) =
  f.setField(name, FieldValue(kind: fvRealList, reals: value))

proc setField*(f: Feature, name: string, value: seq[string]) =
  f.setField(name, FieldValue(kind: fvStringList, strings: value))

proc setField*(f: Feature, name: string, value: seq[byte]) =
  f.setField(name, FieldValue(kind: fvBinary, binary: value))

iterator pairs*(f: Feature): (string, FieldValue) =
  let d = OGR_F_GetDefnRef(f.rawHandle)
  for i in 0 ..< OGR_FD_GetFieldCount(d):
    let name = $OGR_Fld_GetNameRef(OGR_FD_GetFieldDefn(d, i))
    yield (name, f.fieldValue(name))

proc id*(f: Feature): int64 =
  OGR_F_GetFID(f.rawHandle)

proc feature*(layer: Layer, id: int64): Feature =
  let h = OGR_L_GetFeature(layer.rawHandle, id)
  if h == nil:
    raise newException(KeyError, "feature not found: " & $id)
  adoptFeature(h)

proc update*(layer: Layer, f: Feature) =
  if OGR_L_SetFeature(layer.rawHandle, f.rawHandle) != OGRERR_NONE:
    raise newException(IOError, "could not update feature")

proc delete*(layer: Layer, id: int64) =
  if OGR_L_DeleteFeature(layer.rawHandle, id) != OGRERR_NONE:
    raise newException(IOError, "could not delete feature")
