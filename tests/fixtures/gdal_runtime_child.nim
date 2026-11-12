import std/[os, assertions]
import ngis/[api, gdal]

let mode = paramStr(1)
let path = paramStr(2)
if mode == "stub":
  doAssert not isGdalLoaded()
  loadGdal(path)
  doAssert isGdalLoaded()
  doAssert ($GDALVersionInfo("RELEASE_NAME")) == "fixture"
  doAssert GDALAllRegister != nil
  doAssert GDALOpen == nil
else:
  doAssert not isGdalLoaded()
  block emptyOwners:
    var buffer: NativeBuffer
    var list: StringList
    var file: VirtualFile
    discard addr buffer
    discard addr list
    discard addr file
  doAssert not isGdalLoaded()
  loadGdal(path)
  doAssert isGdalLoaded()
  doAssert ($GDALVersionInfo("RELEASE_NAME")).len > 0
