## Shared georeferenced layouts, pixel lookups, RGBA buffers and colorization.
import std/[math, options]
import ./coordinatevalues
export coordinatevalues

type
  RasterLayout* = object ## A north-up raster extent in traditional GIS x/y order.
    layoutWidth, layoutHeight: int
    layoutBounds: Bounds
    crsDefinition: string

  RasterRowOrder* {.pure.} = enum
    ## Row order of the source cell colors, not output pixels.
    topDown
    bottomUp

  RasterLookup* = object ## Owned output-to-source cell mapping, reusable across layers.
    lookupWidth, lookupHeight, cellCount: int
    ids: seq[uint32] # Zero means outside; other values are source indices + 1.

  Rgba8* = object ## Four consecutive bytes of straight (unpremultiplied) RGBA.
    r*, g*, b*, a*: uint8

  HatchStyle* = object ## Diagonal stripes aligned to output pixels.
    stripePeriod, stripeThickness: int
    stripeBrightness: float64

when not defined(js):
  static:
    doAssert sizeof(Rgba8) == 4
    doAssert offsetOf(Rgba8, r) == 0 and offsetOf(Rgba8, a) == 3

proc checkedPixelCount(width, height: int): int =
  if width <= 0 or height <= 0 or width > high(cint).int or height > high(cint).int or
      width > (high(int) div 4) div height:
    raise newException(ValueError, "invalid raster layout dimensions")
  width * height

proc validate(layout: RasterLayout) =
  discard checkedPixelCount(layout.layoutWidth, layout.layoutHeight)
  if layout.crsDefinition.len == 0:
    raise newException(ValueError, "raster layout has no CRS")

proc initRasterLayout*(
    width, height: Positive, bounds: Bounds, crs: string
): RasterLayout =
  ## Define pixel outer edges in crs, with row zero at the northern edge.
  ## Bounds must be finite with positive area. CRS parsing belongs to the selected backend.
  discard checkedPixelCount(width, height)
  for value in [bounds.minX, bounds.minY, bounds.maxX, bounds.maxY]:
    if classify(value) in {fcNan, fcInf, fcNegInf}:
      raise newException(ValueError, "raster layout bounds must be finite")
  let dx = (bounds.maxX - bounds.minX) / float64(width)
  let dy = (bounds.maxY - bounds.minY) / float64(height)
  if dx <= 0 or dy <= 0 or classify(dx) in {fcNan, fcInf, fcNegInf} or
      classify(dy) in {fcNan, fcInf, fcNegInf}:
    raise
      newException(ValueError, "raster layout bounds must have positive finite area")
  if crs.len == 0 or '\0' in crs:
    raise newException(ValueError, "raster layout requires a CRS")
  RasterLayout(
    layoutWidth: width, layoutHeight: height, layoutBounds: bounds, crsDefinition: crs
  )

func width*(layout: RasterLayout): int =
  layout.layoutWidth
func height*(layout: RasterLayout): int =
  layout.layoutHeight
func bounds*(layout: RasterLayout): Bounds =
  layout.layoutBounds
proc crs*(layout: RasterLayout): lent string =
  layout.crsDefinition

proc affineTransform*(layout: RasterLayout): AffineTransform =
  ## Return the north-up pixel-corner transform.
  layout.validate()
  AffineTransform(
    originX: layout.layoutBounds.minX,
    originY: layout.layoutBounds.maxY,
    pixelWidth:
      (layout.layoutBounds.maxX - layout.layoutBounds.minX) / float64(layout.width),
    pixelHeight:
      -(layout.layoutBounds.maxY - layout.layoutBounds.minY) / float64(layout.height),
  )

proc initRasterLookup*(
    width, height, sourceCellCount: Positive, sourceIds: sink seq[uint32]
): RasterLookup =
  ## Construct a reusable pixel mapping. Zero marks an absent source cell; positive
  ## IDs are one-based source indices. Dimensions and every ID are validated.
  if checkedPixelCount(width, height) != sourceIds.len or
      uint64(sourceCellCount) > uint64(high(uint32)):
    raise newException(ValueError, "invalid raster lookup dimensions")
  for id in sourceIds:
    if uint64(id) > uint64(sourceCellCount):
      raise newException(ValueError, "raster lookup source index is out of range")
  RasterLookup(
    lookupWidth: width, lookupHeight: height, cellCount: sourceCellCount, ids: sourceIds
  )

func width*(lookup: RasterLookup): int =
  lookup.lookupWidth
func height*(lookup: RasterLookup): int =
  lookup.lookupHeight
func len*(lookup: RasterLookup): int =
  lookup.ids.len
func sourceCellCount*(lookup: RasterLookup): int =
  lookup.cellCount

proc `[]`*(lookup: RasterLookup, x, y: int): Option[int] =
  ## Return a zero-based source color index, or none outside the source or clip.
  if x < 0 or y < 0 or x >= lookup.width or y >= lookup.height:
    raise newException(ValueError, "raster lookup pixel is out of range")
  let id = lookup.ids[y * lookup.width + x]
  if id == 0:
    none(int)
  else:
    some(int(id) - 1)

iterator items*(lookup: RasterLookup): Option[int] =
  ## Visit source indices in output row-major order.
  for id in lookup.ids:
    yield (if id == 0: none(int) else: some(int(id) - 1))

proc initHatchStyle*(
    period: Positive = 6, thickness: Positive = 1, brightness = 0.7
): HatchStyle =
  ## Darken stripes where (x + y) mod period < thickness.
  ## Brightness is a channel multiplier in 0..1, truncated to bytes. Alpha is kept.
  if thickness > period or classify(brightness) in {fcNan, fcInf, fcNegInf} or
      brightness < 0 or brightness > 1:
    raise newException(ValueError, "invalid hatch style")
  HatchStyle(
    stripePeriod: period, stripeThickness: thickness, stripeBrightness: brightness
  )

proc colorize*(
    lookup: RasterLookup,
    colors: openArray[Rgba8],
    output: var openArray[Rgba8],
    hatch: openArray[bool] = [],
    style = initHatchStyle(),
) =
  ## Fill a caller-owned RGBA buffer, which can be reused for every layer.
  ## colors and optional hatch each contain one entry per source cell. output
  ## contains lookup.len pixels. Masked pixels become transparent black; selected
  ## colors preserve straight RGB and alpha. Input and output must not overlap.
  ## A source cell can be made invisible by setting its color alpha to zero.
  if lookup.len == 0 or colors.len != lookup.cellCount or output.len != lookup.len or
      (hatch.len != 0 and hatch.len != lookup.cellCount):
    raise newException(
      ValueError, "color, hatch or output length does not match raster lookup"
    )
  if hatch.len != 0 and (style.stripePeriod <= 0 or style.stripeThickness <= 0):
    raise newException(ValueError, "uninitialized hatch style")
  for i, id in lookup.ids:
    var color: Rgba8
    if id != 0:
      let cell = int(id) - 1
      color = colors[cell]
      if hatch.len != 0 and color.a != 0 and hatch[cell] and
          (i mod lookup.width + i div lookup.width) mod style.stripePeriod <
          style.stripeThickness:
        color.r = uint8(float64(color.r) * style.stripeBrightness)
        color.g = uint8(float64(color.g) * style.stripeBrightness)
        color.b = uint8(float64(color.b) * style.stripeBrightness)
    output[i] = color

proc colorize*(
    lookup: RasterLookup,
    colors: openArray[Rgba8],
    hatch: openArray[bool] = [],
    style = initHatchStyle(),
): seq[Rgba8] =
  ## Allocate and fill a straight RGBA buffer. Use the output overload to reuse storage.
  result = newSeq[Rgba8](lookup.len)
  lookup.colorize(colors, result, hatch, style)
