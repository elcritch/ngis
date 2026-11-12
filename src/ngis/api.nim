## High-level GDAL workflows using Nim values, iterators and automatic cleanup.
##
## Use `ngis/gdal` alongside this module for direct C API access.
##
## .. code-block:: nim
##   import ngis/api
##   let image = createRaster(float32, 2, 2)
##   var pixels = initRasterGrid[float32](2, 2)
##   pixels[1, 0] = 12.5
##   image.band().write(pixels)
##   echo readGrid[float32](image.band())[1, 0]
import
  ./[
    runtime, datasets, datasetops, drivers, raster, rasterio, rasterextras, vector,
    features, geometryops, vectorextras, spatialrefs, coordinates, schemadomains,
    multidim, arrayops, operations, processing, rendering, utilities, algorithms,
    asyncio, advanced, cpl, vsi, memory, plugins, progress, processes, networks,
  ]
export
  datasets, datasetops, drivers, raster, rasterio, rasterextras, vector, features,
  geometryops, vectorextras, spatialrefs, coordinates, schemadomains, multidim,
  arrayops, operations, processing, rendering, utilities, algorithms, asyncio, advanced,
  cpl, vsi, memory, plugins, progress, processes, networks
export runtime except registerGdalImports
