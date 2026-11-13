## Compare generated layouts with the locally installed GDAL C headers.
import std/[strutils, unittest]
import ngis/gdal/api

when not defined(windows):
  const gdalCflags = staticExec("gdal-config --cflags").strip
  {.passC: gdalCflags.}

{.
  emit: """
#include <stddef.h>
#include <gdal.h>
#include <gdalwarper.h>
#include <ogr_api.h>
size_t ngis_size_gcp(void) { return sizeof(GDAL_GCP); }
size_t ngis_offset_gcp_z(void) { return offsetof(GDAL_GCP, dfGCPZ); }
size_t ngis_size_raster_extra(void) { return sizeof(GDALRasterIOExtraArg); }
size_t ngis_offset_raster_extra_y(void) { return offsetof(GDALRasterIOExtraArg, dfYSize); }
size_t ngis_size_envelope(void) { return sizeof(OGREnvelope); }
size_t ngis_offset_envelope_maxy(void) { return offsetof(OGREnvelope, MaxY); }
size_t ngis_size_field(void) { return sizeof(OGRField); }
size_t ngis_size_warp(void) { return sizeof(GDALWarpOptions); }
size_t ngis_offset_warp_cutline(void) { return offsetof(GDALWarpOptions, hCutline); }
"""
.}

proc cSizeGcp(): csize_t {.importc: "ngis_size_gcp", nodecl.}
proc cOffsetGcpZ(): csize_t {.importc: "ngis_offset_gcp_z", nodecl.}
proc cSizeRasterExtra(): csize_t {.importc: "ngis_size_raster_extra", nodecl.}
proc cOffsetRasterExtraY(): csize_t {.importc: "ngis_offset_raster_extra_y", nodecl.}
proc cSizeEnvelope(): csize_t {.importc: "ngis_size_envelope", nodecl.}
proc cOffsetEnvelopeMaxY(): csize_t {.importc: "ngis_offset_envelope_maxy", nodecl.}
proc cSizeField(): csize_t {.importc: "ngis_size_field", nodecl.}
proc cSizeWarp(): csize_t {.importc: "ngis_size_warp", nodecl.}
proc cOffsetWarpCutline(): csize_t {.importc: "ngis_offset_warp_cutline", nodecl.}

suite "GDAL C ABI":
  test "public structure and union sizes and offsets match C":
    check sizeof(GDAL_GCP) == int(cSizeGcp())
    check offsetOf(GDAL_GCP, dfGCPZ) == int(cOffsetGcpZ())
    check sizeof(GDALRasterIOExtraArg) == int(cSizeRasterExtra())
    check offsetOf(GDALRasterIOExtraArg, dfYSize) == int(cOffsetRasterExtraY())
    check sizeof(OGREnvelope) == int(cSizeEnvelope())
    check offsetOf(OGREnvelope, MaxY) == int(cOffsetEnvelopeMaxY())
    check sizeof(OGRField) == int(cSizeField())
    check sizeof(GDALWarpOptions) == int(cSizeWarp())
    check offsetOf(GDALWarpOptions, hCutline) == int(cOffsetWarpCutline())

  test "64-bit nodata, block and mask operations":
    GDALAllRegister()
    let ds = GDALCreate(GDALGetDriverByName("MEM"), "", 2, 2, 1, GDT_UInt64, nil)
    require ds != nil
    defer:
      discard GDALClose(ds)
    let band = GDALGetRasterBand(ds, 1)
    require band != nil
    let nodata = 18446744073709551610'u64
    check GDALSetRasterNoDataValueAsUInt64(band, nodata) == CE_None
    var success: cint
    check GDALGetRasterNoDataValueAsUInt64(band, addr success) == nodata
    check success != 0
    var blockX, blockY: cint
    GDALGetBlockSize(band, addr blockX, addr blockY)
    require blockX > 0 and blockY > 0
    var values = newSeq[uint64](int(blockX * blockY))
    for i in 0 ..< values.len:
      values[i] = uint64(i + 10)
    check GDALWriteBlock(band, 0, 0, addr values[0]) == CE_None
    var readback = newSeq[uint64](values.len)
    check GDALReadBlock(band, 0, 0, addr readback[0]) == CE_None
    check readback == values
    check GDALCreateMaskBand(band, 0) == CE_None
    check GDALGetMaskBand(band) != nil
    check (GDALGetMaskFlags(band) and GMF_ALL_VALID) == 0
