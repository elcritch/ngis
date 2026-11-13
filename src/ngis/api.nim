## Backend-independent GIS values and utilities. No GDAL headers or library required.
## Import ngis/gdal explicitly for the GDAL backend.
import ./[mapping, raster, arrayops, features, geometry, rendering, gridding]
export mapping, raster, arrayops, features, geometry, rendering, gridding
