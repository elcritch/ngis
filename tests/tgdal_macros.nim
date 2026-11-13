import std/[strutils, unittest]
import ngis/gdal/api/[bindings, macros]

when not defined(windows):
  const cflags = staticExec("gdal-config --cflags").strip
  {.passC: cflags.}

{.
  emit: """
#include <cpl_port.h>
#include <cpl_vsi.h>
static unsigned int ngis_macro_swap32(unsigned int x) { return CPL_SWAP32(x); }
static unsigned int ngis_macro_le32(const unsigned char *p) { return CPL_LSBUINT32PTR(p); }
static int ngis_macro_equal(const char *a, const char *b) { return EQUAL(a, b); }
static int ngis_macro_isdir(int mode) { return VSI_ISDIR(mode) != 0; }
"""
.}
proc cSwap32(x: uint32): uint32 {.importc: "ngis_macro_swap32", nodecl.}
proc cLe32(p: pointer): uint32 {.importc: "ngis_macro_le32", nodecl.}
proc cEqual(a, b: cstring): cint {.importc: "ngis_macro_equal", nodecl.}
proc cIsDir(mode: cint): cint {.importc: "ngis_macro_isdir", nodecl.}

suite "GDAL C macro equivalents":
  test "RasterIO defaults and versioned behavior":
    var arg: GDALRasterIOExtraArg
    arg.dfXOff = 12
    INIT_RASTERIO_EXTRA_ARG(arg)
    check arg.nVersion == RASTERIO_EXTRA_ARG_CURRENT_VERSION
    check arg.eResampleAlg == GRIORA_NearestNeighbour
    check arg.pfnProgress == nil
    check arg.pProgressData == nil
    check arg.bFloatingPointWindowValidity == 0
    check arg.bUseOnlyThisScale == 0
    check arg.bOperateInBufType == 1
    check arg.dfXOff == 12
    arg.bOperateInBufType = 0
    check not GDAL_GET_OPERATE_IN_BUF_TYPE(arg)
    arg.nVersion = 2
    check GDAL_GET_OPERATE_IN_BUF_TYPE(arg)

  test "version, limits and geometry macros":
    check GDAL_COMPUTE_VERSION(3, 13, 3) == 3_130_300
    check GDAL_CHECK_VERSION("ngis macro test") != 0
    check GINTBIG_MIN == low(int64)
    check GUINTBIG_MAX == high(uint64)
    check VSI_L_OFFSET_MAX == GUINTBIG_MAX
    let geom = wkbSetM(wkbSetZ(wkbPoint))
    check wkbHasZ(geom)
    check wkbHasM(geom)
    check wkbFlatten(geom) == wkbPoint

  test "RPC aliases call V2 functions":
    var info: GDALRPCInfo
    check GDALExtractRPCInfo(nil, addr info) == 0
    let metadata = RPCInfoToMD(addr info)
    check metadata != nil
    CSLDestroy(metadata)

  test "atomic macros return the updated value":
    var value: cint = 0
    check CPLAtomicInc(addr value) == 1
    check CPLAtomicDec(addr value) == 0

  test "byte swaps and unaligned endian reads":
    check CPL_SWAP16(-1) == 0xffff'u16
    check CPL_SWAP16(0x123456) == 0x5634'u16
    check CPL_SWAP32(-2) == 0xfeffffff'u32
    check CPL_SWAP64(-2) == 0xfeffffffffffffff'u64
    check CPL_SWAP16(0x1234'u16) == 0x3412'u16
    check CPL_SWAP32(0x12345678'u32) == cSwap32(0x12345678'u32)
    check CPL_SWAP64(0x0123456789abcdef'u64) == 0xefcdab8967452301'u64
    var bytes = [0'u8, 0x78, 0x56, 0x34, 0x12, 0]
    check CPL_LSBUINT32PTR(addr bytes[1]) == cLe32(addr bytes[1])
    CPL_SWAP32PTR(addr bytes[1])
    check bytes == [0'u8, 0x12, 0x34, 0x56, 0x78, 0]
    CPL_MSBPTR32(addr bytes[1])
    when cpuEndian == littleEndian:
      check bytes[1] == 0x78
    else:
      check bytes[1] == 0x12

  test "string numeric and allocation helpers":
    check EQUAL("abc", "ABC") == (cEqual("abc", "ABC") != 0)
    check VSI_ISDIR(0x4000) == (cIsDir(0x4000) != 0)
    check EQUALN("Abcd", "aBxx", 2)
    check STARTS_WITH("Abcd", "Ab")
    check not STARTS_WITH("Abcd", "ab")
    check STARTS_WITH_CI("Abcd", "ab")
    check CPL_MIN(2, 3) == 2
    check CPL_MAX(2, 3) == 3
    check CPL_ABS(-3) == 3
    check CPLIsNan(NaN)
    check CPLIsInf(Inf)
    check CPLIsFinite(1.5)
    var p = VSI_MALLOC2_VERBOSE(2, 8)
    check p != nil
    p = VSI_REALLOC_VERBOSE(p, 32)
    check p != nil
    CPLFree(p)
    let copy = VSI_STRDUP_VERBOSE("hello")
    check $copy == "hello"
    CPLFree(copy)

  test "macro evaluation, array size, and float overloads":
    var calls = 0
    proc nextValue(): int =
      inc calls
      0x1234

    check CPL_SWAP16(nextValue()) == 0x3412'u16
    check calls == 2
    calls = 0
    check CPL_SWAP32(nextValue()) == 0x34120000'u32
    check calls == 1
    var bytes = [0xff'u8, 0x80, 0x00, 0x80]
    proc nextPointer(): pointer =
      inc calls
      addr bytes[0]

    calls = 0
    check CPL_LSBUINT32PTR(nextPointer()) == 0x800080ff'u32
    check calls == 4
    check CPL_LSBSINT16PTR(addr bytes[0]) == cast[int16](0x80ff'u16)
    check CPL_LSBSINT32PTR(addr bytes[0]) == cast[int32](0x800080ff'u32)
    check CPL_ARRAYSIZE(bytes) == 4
    check CPLIsNan(NaN.float32)
    check CPLIsInf(Inf.float32)
    check CPLIsFinite(1.0'f32)
    calls = 0
    CPL_LSBPTR16(nextPointer())
    when cpuEndian == littleEndian:
      check calls == 0
    else:
      check calls == 1
    calls = 0
    CPLAssertAlwaysEval(nextValue() != 0)
    check calls == 1
    calls = 0
    CPLAssert(nextValue() != 0)
    when defined(debug):
      check calls == 1
    else:
      check calls == 0
    CPLDebugOnly("ngis", "%d", 1.cint)
