## Optional example: add Pixie to the application's Atlas dependencies.
## Run with `nim r -d:release render_pixie.nim [output.png]`.
import std/os
import ngis/api
import pixie/fileformats/png

let source = initRasterLayout(2, 2, initBounds(10, 40, 12, 42), "EPSG:4326")
let target = initRasterLayout(512, 512, initBounds(9.9, 39.9, 12.1, 42.1), "EPSG:4326")
let boundary = geometryFromWkt("POLYGON ((10 40,12 40,11.8 42,10.2 42,10 40))")
let lookup = initRasterLookup(source, target, clip = boundary)
let colors = [
  Rgba8(r: 220, g: 60, b: 50, a: 255),
  Rgba8(r: 240, g: 180, b: 40, a: 255),
  Rgba8(r: 80, g: 170, b: 80, a: 255),
  Rgba8(r: 60, g: 110, b: 210, a: 255),
]
var pixels = lookup.colorize(colors)
let output = (if paramCount() > 0: paramStr(1) else: "map.png")
writeFile(
  output,
  encodePng(lookup.width, lookup.height, 4, addr pixels[0], pixels.len * sizeof(Rgba8)),
)

# For further layers, reuse both lookup and storage:
lookup.colorize(
  colors,
  pixels,
  hatch = [true, false, false, true],
  style = initHatchStyle(period = 8, thickness = 1),
)
