## Shared vector field schemas and copied attribute values.
type
  FieldKind* = enum
    fkInteger
    fkInteger64
    fkReal
    fkString
    fkIntegerList
    fkInteger64List
    fkRealList
    fkStringList
    fkBinary
    fkDate
    fkTime
    fkDateTime

  FieldSubtype* = enum
    fsNone
    fsBoolean
    fsInt16
    fsFloat32
    fsJson
    fsUuid

  TimeZoneKind* = enum
    tzUnknown
    tzLocal
    tzOffset

  FieldDateTime* = object ## Timezone offsets are in minutes east of UTC.
    year*, month*, day*, hour*, minute*: int
    second*: float32
    zone*: TimeZoneKind
    offsetMinutes*: int

  FieldSpec* = object
    name*: string
    kind*: FieldKind
    subtype*: FieldSubtype
    width*: int
    precision*: int

  FieldValueKind* = enum
    fvUnset
    fvNull
    fvInteger
    fvInteger64
    fvReal
    fvString
    fvIntegerList
    fvInteger64List
    fvRealList
    fvStringList
    fvBinary
    fvDate
    fvTime
    fvDateTime

  FieldValue* = object
    case kind*: FieldValueKind
    of fvUnset, fvNull: discard
    of fvInteger: integer*: int32
    of fvInteger64: integer64*: int64
    of fvReal: real*: float64
    of fvString: text*: string
    of fvIntegerList: integers*: seq[int32]
    of fvInteger64List: integers64*: seq[int64]
    of fvRealList: reals*: seq[float64]
    of fvStringList: strings*: seq[string]
    of fvBinary: binary*: seq[byte]
    of fvDate, fvTime, fvDateTime: dateTime*: FieldDateTime
