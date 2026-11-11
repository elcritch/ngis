## Shared-library selection for the raw GDAL C API.
when defined(macosx):
  import std/strutils

when defined(windows):
  const defaultGdalLib = "gdal.dll"
elif defined(macosx):
  const brewPrefix = staticExec("brew --prefix gdal 2>/dev/null || true").strip
  const defaultGdalLib =
    if brewPrefix.len > 0:
      brewPrefix & "/lib/libgdal.dylib"
    else:
      "libgdal.dylib"
else:
  const defaultGdalLib = "libgdal.so(|.39|.38|.37|.36|.35|.34|.33|.32)"

const gdalLib* {.strdefine.} = defaultGdalLib

when defined(windows) and defined(i386):
  {.pragma: gdalCall, stdcall.}
else:
  {.pragma: gdalCall, cdecl.}
