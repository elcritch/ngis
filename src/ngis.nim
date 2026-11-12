## GDAL raster, vector, spatial-reference, and utility APIs with automatic cleanup.
## Import `ngis/gdal` directly when only the raw C ABI is needed.
import
  ngis/[
    gdal, datasets, drivers, raster, rasterextras, vector, vectorextras, spatialrefs,
    schemadomains, multidim, operations, utilities, algorithms, asyncio, advanced, cpl,
    vsi, memory, plugins, progress, processes, networks,
  ]
export
  gdal, datasets, drivers, raster, rasterextras, vector, vectorextras, spatialrefs,
  schemadomains, multidim, operations, utilities, algorithms, asyncio, advanced, cpl,
  vsi, memory, plugins, progress, processes, networks
