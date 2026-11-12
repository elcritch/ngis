## Selected C preprocessor aliases and helpers from GDAL 3.13.3.
## See the generated bindings manifest for macros not represented here.
import ./bindings

type
  GDALRPCInfo* = GDALRPCInfoV2
  GNMGFID* = GIntBig

const
  RASTERIO_EXTRA_ARG_CURRENT_VERSION* = 3
  GDAL_VERSION_NUM* =
    GDAL_VERSION_MAJOR * 1_000_000 + GDAL_VERSION_MINOR * 10_000 + GDAL_VERSION_REV * 100 +
    GDAL_VERSION_BUILD
  CPLE_WrongFormat* = CPLErrorNum(200)
  GINTBIG_MIN* = low(int64)
  GINTBIG_MAX* = high(int64)
  GUINTBIG_MAX* = high(uint64)
  GINT64_MIN* = GINTBIG_MIN
  GINT64_MAX* = GINTBIG_MAX
  GUINT64_MAX* = GUINTBIG_MAX
  VSI_L_OFFSET_MAX* = GUINTBIG_MAX
  CPL_FRMT_GIB* = "%" & CPL_FRMT_GB_WITHOUT_PREFIX & "d"
  CPL_FRMT_GUIB* = "%" & CPL_FRMT_GB_WITHOUT_PREFIX & "u"

template GDAL_COMPUTE_VERSION*(major, minor, revision: untyped): untyped =
  ((major) * 1_000_000 + (minor) * 10_000 + (revision) * 100)

template GDAL_CHECK_VERSION*(component: untyped): untyped =
  GDALCheckVersion(GDAL_VERSION_MAJOR, GDAL_VERSION_MINOR, component)

template INIT_RASTERIO_EXTRA_ARG*(arg: untyped) =
  arg.nVersion = RASTERIO_EXTRA_ARG_CURRENT_VERSION
  arg.eResampleAlg = GRIORA_NearestNeighbour
  arg.pfnProgress = nil
  arg.pProgressData = nil
  arg.bFloatingPointWindowValidity = 0
  arg.bUseOnlyThisScale = 0
  arg.bOperateInBufType = 1

template GDAL_GET_OPERATE_IN_BUF_TYPE*(arg: untyped): untyped =
  (arg.nVersion < 3 or arg.bOperateInBufType != 0)

template CPLFree*(p: untyped): untyped =
  VSIFree(p)

template CPLReadDir*(p: untyped): untyped =
  VSIReadDir(p)

template GDALExtractRPCInfo*(metadata, info: untyped): untyped =
  GDALExtractRPCInfoV2(metadata, info)

template GDALCreateRPCTransformer*(
    info, reversed, threshold, options: untyped
): untyped =
  GDALCreateRPCTransformerV2(info, reversed, threshold, options)

template RPCInfoToMD*(info: untyped): untyped =
  RPCInfoV2ToMD(info)

template ParseAlgorithmAndOptions*(name, algorithm, options: untyped): untyped =
  GDALGridParseAlgorithmAndOptions(name, algorithm, options)

template CPLAtomicInc*(p: untyped): untyped =
  CPLAtomicAdd(p, 1)

template CPLAtomicDec*(p: untyped): untyped =
  CPLAtomicAdd(p, -1)

template wkbFlatten*(x: untyped): untyped =
  OGR_GT_Flatten(OGRwkbGeometryType(x))

template wkbHasZ*(x: untyped): untyped =
  (OGR_GT_HasZ(x) != 0)

template wkbSetZ*(x: untyped): untyped =
  OGR_GT_SetZ(x)

template wkbHasM*(x: untyped): untyped =
  (OGR_GT_HasM(x) != 0)

template wkbSetM*(x: untyped): untyped =
  OGR_GT_SetM(x)

# Byte-oriented pointer helpers support the unaligned addresses accepted by C.
template CPL_SWAP16*(x: untyped): untyped =
  cast[uint16]((uint32(cast[uint16](x)) shl 8) or (uint32(cast[uint16](x)) shr 8))

func swap32(x: uint32): uint32 =
  ((x and 0xff'u32) shl 24) or ((x and 0xff00'u32) shl 8) or ((x shr 8) and 0xff00'u32) or
    (x shr 24)

func swap64(x: uint64): uint64 =
  (uint64(swap32(uint32(x and 0xffff_ffff'u64))) shl 32) or
    uint64(swap32(uint32(x shr 32)))

template CPL_SWAP32*(x: untyped): untyped =
  swap32(cast[uint32](x))

template CPL_SWAP64*(x: untyped): untyped =
  swap64(cast[uint64](x))

template CPL_ARRAYSIZE*(a: untyped): untyped =
  (sizeof(a) div sizeof(a[0]))

template CPLAssert*(expr: untyped) =
  when defined(debug):
    if not (expr):
      c_CPLAssert(
        astToStr(expr),
        instantiationInfo().filename.cstring,
        cint(instantiationInfo().line),
      )

template CPLAssertAlwaysEval*(expr: untyped) =
  when defined(debug):
    CPLAssert(expr)
  else:
    discard expr

template CPLDebugOnly*(args: varargs[untyped]) =
  when defined(debug) or defined(gdalDebug):
    CPLDebug(args)

proc swapBytes(p: pointer, n: int) =
  let bytes = cast[ptr UncheckedArray[byte]](p)
  for i in 0 ..< n div 2:
    swap(bytes[i], bytes[n - 1 - i])

template CPL_SWAP16PTR*(p: untyped) =
  swapBytes(cast[pointer](p), 2)

template CPL_SWAP32PTR*(p: untyped) =
  swapBytes(cast[pointer](p), 4)

template CPL_SWAP64PTR*(p: untyped) =
  swapBytes(cast[pointer](p), 8)

template CPL_SWAPDOUBLE*(p: untyped) =
  CPL_SWAP64PTR(p)

when cpuEndian == littleEndian:
  template CPL_LSBWORD16*(x: untyped): untyped =
    x

  template CPL_LSBWORD32*(x: untyped): untyped =
    x

  template CPL_MSBWORD16*(x: untyped): untyped =
    CPL_SWAP16(x)

  template CPL_MSBWORD32*(x: untyped): untyped =
    CPL_SWAP32(x)

  template CPL_LSBPTR16*(p: untyped) =
    discard

  template CPL_LSBPTR32*(p: untyped) =
    discard

  template CPL_LSBPTR64*(p: untyped) =
    discard

  template CPL_MSBPTR16*(p: untyped) =
    CPL_SWAP16PTR(p)

  template CPL_MSBPTR32*(p: untyped) =
    CPL_SWAP32PTR(p)

  template CPL_MSBPTR64*(p: untyped) =
    CPL_SWAP64PTR(p)

else:
  template CPL_MSBWORD16*(x: untyped): untyped =
    x

  template CPL_MSBWORD32*(x: untyped): untyped =
    x

  template CPL_LSBWORD16*(x: untyped): untyped =
    CPL_SWAP16(x)

  template CPL_LSBWORD32*(x: untyped): untyped =
    CPL_SWAP32(x)

  template CPL_MSBPTR16*(p: untyped) =
    discard

  template CPL_MSBPTR32*(p: untyped) =
    discard

  template CPL_MSBPTR64*(p: untyped) =
    discard

  template CPL_LSBPTR16*(p: untyped) =
    CPL_SWAP16PTR(p)

  template CPL_LSBPTR32*(p: untyped) =
    CPL_SWAP32PTR(p)

  template CPL_LSBPTR64*(p: untyped) =
    CPL_SWAP64PTR(p)

template CPL_LSBUINT16PTR*(p: untyped): untyped =
  (
    uint16(cast[ptr UncheckedArray[byte]](p)[0]) or
    (uint16(cast[ptr UncheckedArray[byte]](p)[1]) shl 8)
  )

template CPL_LSBUINT32PTR*(p: untyped): untyped =
  (
    uint32(cast[ptr UncheckedArray[byte]](p)[0]) or
    (uint32(cast[ptr UncheckedArray[byte]](p)[1]) shl 8) or
    (uint32(cast[ptr UncheckedArray[byte]](p)[2]) shl 16) or
    (uint32(cast[ptr UncheckedArray[byte]](p)[3]) shl 24)
  )

template CPL_LSBSINT16PTR*(p: untyped): untyped =
  cast[int16](CPL_LSBUINT16PTR(p))

template CPL_LSBSINT32PTR*(p: untyped): untyped =
  cast[int32](CPL_LSBUINT32PTR(p))

template CPL_LSBINT16PTR*(p: untyped): untyped =
  cint(CPL_LSBUINT16PTR(p))

template CPL_LSBINT32PTR*(p: untyped): untyped =
  cast[cint](CPL_LSBUINT32PTR(p))

template CPL_MIN*(a, b: untyped): untyped =
  (if a < b: a else: b)

template CPL_MAX*(a, b: untyped): untyped =
  (if a > b: a else: b)

template CPL_ABS*(x: untyped): untyped =
  (if x < 0: -1 * x else: x)

when defined(windows):
  proc cStrCaseCmp(a, b: cstring): cint {.importc: "_stricmp", header: "<string.h>".}
  proc cStrNCaseCmp(
    a, b: cstring, n: csize_t
  ): cint {.importc: "_strnicmp", header: "<string.h>".}

else:
  proc cStrCaseCmp(a, b: cstring): cint {.importc: "strcasecmp", header: "<strings.h>".}
  proc cStrNCaseCmp(
    a, b: cstring, n: csize_t
  ): cint {.importc: "strncasecmp", header: "<strings.h>".}

proc cStrNCmp(
  a, b: cstring, n: csize_t
): cint {.importc: "strncmp", header: "<string.h>".}

proc cStrLen(a: cstring): csize_t {.importc: "strlen", header: "<string.h>".}
template STRCASECMP*(a, b: untyped): untyped =
  cStrCaseCmp(a, b)

template STRNCASECMP*(a, b, n: untyped): untyped =
  cStrNCaseCmp(a, b, csize_t(n))

template EQUAL*(a, b: untyped): untyped =
  (STRCASECMP(a, b) == 0)

template EQUALN*(a, b, n: untyped): untyped =
  (STRNCASECMP(a, b, n) == 0)

template STARTS_WITH*(a, b: untyped): untyped =
  (cStrNCmp(a, b, cStrLen(b)) == 0)

template STARTS_WITH_CI*(a, b: untyped): untyped =
  EQUALN(a, b, cStrLen(b))

import std/math
template CPLIsNan*(x: untyped): untyped =
  (classify(float64(x)) == fcNan)

template CPLIsInf*(x: untyped): untyped =
  (classify(float64(x)) in {fcInf, fcNegInf})

template CPLIsFinite*(x: untyped): untyped =
  (classify(float64(x)) notin {fcNan, fcInf, fcNegInf})

template CPLIsEqual*(x, y: untyped): untyped =
  (abs(x - y) < 0.0000000000001)

template VSI_MALLOC_VERBOSE*(size: untyped): untyped =
  VSIMallocVerbose(
    size, instantiationInfo().filename.cstring, cint(instantiationInfo().line)
  )

template VSI_MALLOC_ALIGNED_AUTO_VERBOSE*(size: untyped): untyped =
  VSIMallocAlignedAutoVerbose(
    size, instantiationInfo().filename.cstring, cint(instantiationInfo().line)
  )

template VSI_MALLOC2_VERBOSE*(a, b: untyped): untyped =
  VSIMalloc2Verbose(
    a, b, instantiationInfo().filename.cstring, cint(instantiationInfo().line)
  )

template VSI_MALLOC3_VERBOSE*(a, b, c: untyped): untyped =
  VSIMalloc3Verbose(
    a, b, c, instantiationInfo().filename.cstring, cint(instantiationInfo().line)
  )

template VSI_CALLOC_VERBOSE*(a, b: untyped): untyped =
  VSICallocVerbose(
    a, b, instantiationInfo().filename.cstring, cint(instantiationInfo().line)
  )

template VSI_REALLOC_VERBOSE*(p, size: untyped): untyped =
  VSIReallocVerbose(
    p, size, instantiationInfo().filename.cstring, cint(instantiationInfo().line)
  )

template VSI_STRDUP_VERBOSE*(s: untyped): untyped =
  VSIStrdupVerbose(
    s, instantiationInfo().filename.cstring, cint(instantiationInfo().line)
  )

template CPL_INT64_FITS_ON_INT32*(x: untyped): untyped =
  (x >= low(int32) and x <= high(int32))

template CPL_IS_ALIGNED*(p, quantum: untyped): untyped =
  (cast[uint](p) mod uint(quantum) == 0)

when defined(windows):
  # The Windows header tests these bits directly, and has no link/block types.
  template VSI_ISLNK*(mode: untyped): untyped =
    false

  template VSI_ISBLK*(mode: untyped): untyped =
    false

  template VSI_ISREG*(mode: untyped): untyped =
    ((mode and 0x8000) != 0)

  template VSI_ISDIR*(mode: untyped): untyped =
    ((mode and 0x4000) != 0)

  template VSI_ISCHR*(mode: untyped): untyped =
    ((mode and 0x2000) != 0)

else:
  import std/posix
  template VSI_ISLNK*(mode: untyped): untyped =
    S_ISLNK(Mode(mode))

  template VSI_ISBLK*(mode: untyped): untyped =
    S_ISBLK(Mode(mode))

  template VSI_ISREG*(mode: untyped): untyped =
    S_ISREG(Mode(mode))

  template VSI_ISDIR*(mode: untyped): untyped =
    S_ISDIR(Mode(mode))

  template VSI_ISCHR*(mode: untyped): untyped =
    S_ISCHR(Mode(mode))
