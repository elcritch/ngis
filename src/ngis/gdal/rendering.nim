## GDAL construction of raster lookups, masks and georeferenced datasets.
import std/options
import ./[api, datasets, raster, rasterio, datasetops, coordinates, vector, processing]
import ../rendering as renderingvalues
export renderingvalues

proc createRaster*[T](
    pixelType: typedesc[T], layout: RasterLayout, bands: Positive = 1
): Dataset =
  ## Create a georeferenced in-memory raster with this layout.
  discard layout.affineTransform
  result = createRaster(pixelType, layout.width, layout.height, bands)
  result.affineTransform = layout.affineTransform
  result.spatialReference = newSpatialReference(layout.crs, AxisOrder.traditionalGis)

proc rasterizeMask*(
    geometry: Geometry, layout: RasterLayout, allTouched = false
): seq[uint8] =
  ## Burn 1 inside geometry and 0 outside, at the output pixel resolution.
  ## Coordinates must already be in layout's CRS and GIS x/y order; the geometry's
  ## attached CRS is not used to reproject it. Holes and multipart shapes are kept.
  ## By default polygons cover pixels whose centers are inside; allTouched also
  ## includes intersected edge pixels. Geometry is borrowed only during this call.
  var handle = geometry.rawHandle
  let mask = createRaster(uint8, layout)
  var bandNumber = 1.cint
  var burn = 1.0.cdouble
  var options = ["ALL_TOUCHED=TRUE".cstring, nil]
  CPLErrorReset()
  if GDALRasterizeGeometries(
    mask.rawHandle,
    1,
    addr bandNumber,
    1,
    addr handle,
    nil,
    nil,
    addr burn,
    (if allTouched: cast[cstringArray](addr options[0]) else: nil),
    nil,
    nil,
  ) != CE_None:
    raise gdalError("could not rasterize geometry mask")
  read[uint8](mask.band())

proc initRasterLookup*(
    source, target: RasterLayout,
    clip: Geometry = nil,
    sourceRows = RasterRowOrder.topDown,
    coordinateOperation = "",
    memoryLimitMiB = 32.0,
    threadCount: Positive = 1,
): RasterLookup =
  ## Map output pixels to source cells with exact nearest-neighbor reprojection.
  ## clip coordinates must already be in the target CRS, in GIS x/y order.
  ## Clipping happens at output resolution, independently of the source grid.
  ## sourceRows controls indexing into the later color/hatch arrays. Output rows
  ## always run top to bottom. No GDAL handles or geometry references are retained.
  ## An optional PROJ coordinateOperation must include any required axis swaps.
  discard source.affineTransform
  discard target.affineTransform
  let count = source.width * source.height
  if uint64(count) > uint64(high(uint32)):
    raise newException(ValueError, "raster lookup has too many source cells")
  let indices = createRaster(uint32, source)
  var cells = newSeq[uint32](count)
  for y in 0 ..< source.height:
    let row = (if sourceRows == RasterRowOrder.topDown: y
    else: source.height - y - 1)
    for x in 0 ..< source.width:
      cells[y * source.width + x] = uint32(row * source.width + x + 1)
  indices.band().write(cells)
  indices.band().noData = some(0.0)
  let projected = indices.warp(
    config = WarpConfig(
      targetCrs: target.crs,
      bounds: some(target.bounds),
      outputSize: some(initRasterOutputSize(target.width, target.height)),
      resampling: RasterResampling.nearest,
      targetNoData: some(0.0),
      coordinateOperation: coordinateOperation,
      errorThreshold: some(0.0),
      memoryLimitMiB: some(memoryLimitMiB),
      threadCount: some(int(threadCount)),
      verticalShift: some(false), # Cell identifiers are not elevation samples.
    )
  )
  var ids = read[uint32](projected.band())
  if clip != nil:
    let mask = rasterizeMask(clip, target)
    for i in 0 ..< ids.len:
      if mask[i] == 0:
        ids[i] = 0
  for id in ids:
    if uint64(id) > uint64(count):
      raise newException(IOError, "reprojection returned an invalid source cell index")

  result = initRasterLookup(target.width, target.height, count, move(ids))
