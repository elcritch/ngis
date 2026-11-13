## Shared-library loading and selection for the GDAL C API.
import ../runtime
export runtime except registerGdalImports

when defined(windows) and defined(i386):
  {.pragma: gdalCall, stdcall.}
else:
  {.pragma: gdalCall, cdecl.}
