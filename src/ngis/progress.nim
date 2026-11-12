## Owning scaled-progress contexts. Callback userdata remains caller-owned.
import ./gdal
import ./private/resources

type ScaledProgress* = object
  resource: NativeResource[pointer]

proc newScaledProgress*(
    minimum, maximum: float64, callback: GDALProgressFunc, userdata: pointer = nil
): ScaledProgress =
  if not CPLIsFinite(minimum) or not CPLIsFinite(maximum) or minimum < 0 or maximum > 1 or
      maximum < minimum or callback == nil:
    raise newException(ValueError, "invalid progress range or callback")
  let handle = GDALCreateScaledProgress(minimum, maximum, callback, userdata)
  ScaledProgress(
    resource: newNativeResource(
      handle,
      proc(p: pointer) {.raises: [].} =
        GDALDestroyScaledProgress(p),
    )
  )

proc rawHandle*(progress: ScaledProgress): pointer =
  progress.resource.rawHandle

proc close*(progress: ScaledProgress) =
  close(progress.resource)

proc update*(progress: ScaledProgress, complete: float64, message = ""): bool =
  validateCString(message, "progress message")
  if not CPLIsFinite(complete) or complete < 0 or complete > 1:
    raise newException(ValueError, "progress must be between zero and one")
  GDALScaledProgress(complete, message.cstring, progress.rawHandle) != 0
