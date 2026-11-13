## Opt-in GDAL backend: datasets, native resources, I/O, reprojection and gridding.
##
## Use `ngis/gdal/api` alongside this module for direct C API access.
##
## .. code-block:: nim
##   import ngis/gdal
##   let image = createRaster(float32, 2, 2)
##   var pixels = initRasterGrid[float32](2, 2)
##   pixels[1, 0] = 12.5
##   image.band().write(pixels)
##   echo readGrid[float32](image.band())[1, 0]
import
  ./gdal/[
    runtime, datasets, datasetops, drivers, raster, rasterio, rasterextras, vector,
    features, geometryops, vectorextras, spatialrefs, coordinates, schemadomains,
    multidim, arrayops, gridding, operations, processing, rendering, utilities,
    algorithms, asyncio, advanced, cpl, vsi, memory, plugins, progress, processes,
    networks,
  ]
import ./api
export
  datasets, datasetops, drivers, raster, rasterio, rasterextras, vector, features,
  geometryops, vectorextras, spatialrefs, coordinates, schemadomains, multidim,
  arrayops, gridding, operations, processing, rendering, utilities, algorithms, asyncio,
  advanced, cpl, vsi, memory, plugins, progress, processes, networks
export runtime except registerGdalImports

export api
