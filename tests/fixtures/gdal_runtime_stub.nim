## Minimal loadable library: the loader's two required symbols only.
when defined(windows) and defined(i386):
  {.pragma: gdalCall, stdcall.}
else:
  {.pragma: gdalCall, cdecl.}

proc GDALVersionInfo(request: cstring): cstring {.exportc, dynlib, gdalCall.} =
  "fixture"

proc GDALAllRegister() {.exportc, dynlib, gdalCall.} =
  discard
