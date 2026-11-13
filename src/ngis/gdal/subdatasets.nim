## Owning subdatasets resources.
import ./[api, datasets]
import ./private/resources

type SubdatasetInfo* = object
  resource: NativeResource[GDALSubdatasetInfoH]

template access(T, H: typedesc) =
  proc rawHandle*(value: T): H =
    value.resource.rawHandle

  proc close*(value: T) =
    value.resource.close()

access(SubdatasetInfo, GDALSubdatasetInfoH)

proc subdatasetInfo*(name: string): SubdatasetInfo =
  validateCString(name, "subdataset")
  GDALAllRegister()
  let h = GDALGetSubdatasetInfo(name.cstring)
  if h == nil:
    raise newException(ValueError, "unrecognized subdataset descriptor")
  SubdatasetInfo(
    resource: newNativeResource(
      h,
      proc(p: GDALSubdatasetInfoH) {.nimcall, raises: [].} =
        GDALDestroySubdatasetInfo(p),
    )
  )

proc takeString(p: cstring): string =
  if p == nil:
    raise gdalError("could not obtain subdataset component")
  defer:
    CPLFree(p)
  $p

proc path*(value: SubdatasetInfo): string =
  takeString(GDALSubdatasetInfoGetPathComponent(value.rawHandle))

proc component*(value: SubdatasetInfo): string =
  takeString(GDALSubdatasetInfoGetSubdatasetComponent(value.rawHandle))

proc withPath*(value: SubdatasetInfo, path: string): string =
  validateCString(path, "path")
  takeString(GDALSubdatasetInfoModifyPathComponent(value.rawHandle, path.cstring))
