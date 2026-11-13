## Exercise ABI-sensitive calls against the installed GDAL library and headers.
import std/[strutils, unittest]
import ngis/gdal/api

when not defined(windows):
  const gdalCflags = staticExec("gdal-config --cflags").strip
  {.passC: gdalCflags.}

{.
  emit: """
#include <stdarg.h>
#include <stddef.h>
typedef int (*ngis_va_callback)(char *, size_t, char *, va_list);
int ngis_call_va(ngis_va_callback callback, char *buffer, size_t size,
                 char *format, ...) {
    va_list args;
    va_start(args, format);
    int result = callback(buffer, size, format, args);
    va_end(args);
    return result;
}
"""
.}

type VaCallback = proc(
  buffer: cstring, size: csize_t, format: cstring, args: GdalVaList
): cint {.cdecl, raises: [].}

proc callVa(
  callback: VaCallback, buffer: cstring, size: csize_t, format: cstring
): cint {.importc: "ngis_call_va", nodecl, varargs.}

proc formatVa(
    buffer: cstring, size: csize_t, format: cstring, args: GdalVaList
): cint {.cdecl, raises: [].} =
  CPLvsnprintf(buffer, size, format, args)

when defined(windows) and defined(i386):
  {.pragma: progressCall, stdcall.}
else:
  {.pragma: progressCall, cdecl.}

proc progress(
    value: cdouble, message: cstring, data: pointer
): cint {.progressCall, raises: [].} =
  cast[ptr cdouble](data)[] = value
  return 1

suite "GDAL function ABI":
  test "va_list crosses C to Nim and back to GDAL":
    var buffer: array[100, char]
    let n = callVa(
      formatVa,
      cast[cstring](addr buffer[0]),
      csize_t(buffer.len),
      "%s %d %.1f",
      "value".cstring,
      42.cint,
      2.5.cdouble,
    )
    check n == 12
    check $cast[cstring](addr buffer[0]) == "value 42 2.5"

  test "progress callback uses the declared calling convention":
    var value: cdouble
    let state = GDALCreateScaledProgress(0.25, 0.75, progress, addr value)
    require state != nil
    defer:
      GDALDestroyScaledProgress(state)
    check GDALScaledProgress(0.5, "working", state) == 1
    check abs(value - 0.5) < 0.000001

  test "multidimensional group names return a null terminated string array":
    GDALAllRegister()
    let ds = GDALCreateMultiDimensional(GDALGetDriverByName("MEM"), "", nil, nil)
    require ds != nil
    defer:
      discard GDALClose(ds)
    let root = GDALDatasetGetRootGroup(ds)
    require root != nil
    defer:
      GDALGroupRelease(root)
    let child = GDALGroupCreateGroup(root, "child", nil)
    require child != nil
    GDALGroupRelease(child)
    let names = GDALGroupGetGroupNames(root, nil)
    require names != nil
    defer:
      CSLDestroy(names)
    check $names[0] == "child"
    check names[1] == nil

  test "dimension handles are returned as an array of pointers":
    GDALAllRegister()
    let ds = GDALCreateMultiDimensional(GDALGetDriverByName("MEM"), "", nil, nil)
    require ds != nil
    defer:
      discard GDALClose(ds)
    let root = GDALDatasetGetRootGroup(ds)
    require root != nil
    defer:
      GDALGroupRelease(root)
    let dimension = GDALGroupCreateDimension(root, "axis", "", "", 17, nil)
    require dimension != nil
    GDALDimensionRelease(dimension)
    var count: csize_t
    let dimensions = GDALGroupGetDimensions(root, addr count, nil)
    require dimensions != nil
    defer:
      GDALReleaseDimensions(dimensions, count)
    require count == 1
    let first = cast[ptr UncheckedArray[GDALDimensionH]](dimensions)[0]
    check $GDALDimensionGetName(first) == "axis"
    check GDALDimensionGetSize(first) == 17

  test "C array parameters decay to pointers":
    GDALAllRegister()
    let ds = GDALCreate(GDALGetDriverByName("MEM"), "", 2, 1, 1, GDT_Byte, nil)
    require ds != nil
    defer:
      discard GDALClose(ds)
    let band = GDALGetRasterBand(ds, 1)
    var pixels = [4'u8, 9'u8]
    check GDALRasterIO(band, GF_Write, 0, 0, 2, 1, addr pixels[0], 2, 1, GDT_Byte, 0, 0) ==
      CE_None
    var extrema: array[2, cdouble]
    check GDALComputeRasterMinMax(band, 0, addr extrema[0]) == CE_None
    check extrema == [4.0, 9.0]
    var matrix = [1.0, 0.0, 3.0, 0.0, 1.0, 5.0, 0.0, 0.0, 1.0]
    let transformer = GDALCreateHomographyTransformer(addr matrix[0])
    require transformer != nil
    defer:
      GDALDestroyHomographyTransformer(transformer)
    var x = 1.0
    var y = 2.0
    var z = 0.0
    var success: cint
    check GDALHomographyTransform(
      transformer, 0, 1, addr x, addr y, addr z, addr success
    ) != 0
    check success != 0
    check abs(x - 1.0) > 0.1
    check abs(y - 2.0) > 0.1
    check GDALHomographyTransform(
      transformer, 1, 1, addr x, addr y, addr z, addr success
    ) != 0
    check success != 0
    check abs(x - 1.0) < 0.000001
    check abs(y - 2.0) < 0.000001
