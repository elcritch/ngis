## Owning contours resources.
import ./[gdal, datasets]
import ./private/resources

type ContourGenerator* = object
  resource: NativeResource[GDALContourGeneratorH]
  width, height: int
  state: ref tuple[lines: int]

template access(T, H: typedesc) =
  proc rawHandle*(value: T): H =
    value.resource.rawHandle

  proc close*(value: T) =
    value.resource.close()

access(ContourGenerator, GDALContourGeneratorH)

proc newContourGenerator*(
    width, height: int,
    interval, base: float64,
    writer: GDALContourWriter,
    data: pointer = nil,
): ContourGenerator =
  ## Callback and data must remain valid through close, which flushes contours.
  if width <= 0 or height <= 0 or width > high(cint).int or height > high(cint).int or
      interval <= 0 or writer == nil:
    raise newException(ValueError, "invalid contour generator configuration")
  let h = GDAL_CG_Create(cint(width), cint(height), 0, 0, interval, base, writer, data)
  ContourGenerator(
    resource: newNativeResource(
      h,
      proc(p: GDALContourGeneratorH) {.nimcall, raises: [].} =
        GDAL_CG_Destroy(p),
    ),
    width: width,
    height: height,
    state: new(tuple[lines: int]),
  )

proc feed*(generator: ContourGenerator, line: openArray[float64]) =
  if line.len != generator.width or generator.state == nil or
      generator.state.lines >= generator.height:
    raise newException(ValueError, "invalid contour scanline")
  var copy = @line
  if GDAL_CG_FeedLine(generator.rawHandle, addr copy[0]) != CE_None:
    raise gdalError("could not feed contour line")
  inc generator.state.lines
