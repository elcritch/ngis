## Standalone local mapping tools for native Nim and JavaScript, without GDAL.
## Import ngis/api to combine these tools with datasets and CRS transformations.
import ./[coordinatevalues, mapprojection, metricgrid, localidw, polygonqueries]
export coordinatevalues, mapprojection, metricgrid, localidw, polygonqueries
