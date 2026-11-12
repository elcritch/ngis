## Driver discovery and ownership before transfer to GDAL's global registry.
import ./[gdal, datasets]
import ./private/resources

type
  Driver* = object
    resource: NativeResource[GDALDriverH]

  DriverInfo* = object
    handle: GDALDriverH

proc rawHandle*(driver: Driver): GDALDriverH =
  driver.resource.rawHandle

proc rawHandle*(driver: DriverInfo): GDALDriverH =
  if driver.handle == nil:
    raise newException(ValueError, "driver is not initialized")
  driver.handle

proc close*(driver: Driver) =
  close(driver.resource)

proc newDriver*(name: string): Driver =
  ## Creates an unregistered driver for advanced raw callback configuration.
  validateCString(name, "driver name")
  result.resource = newNativeResource(
    GDALCreateDriver(),
    proc(h: GDALDriverH) {.raises: [].} =
      GDALDestroyDriver(h),
  )
  GDALSetDescription(result.rawHandle, name.cstring)

proc register*(driver: Driver): DriverInfo =
  ## Transfers ownership to GDAL's registry and invalidates the owning aliases.
  let handle = driver.rawHandle
  GDALAllRegister()
  if GDALGetDriverByName(GDALGetDescription(handle)) != nil:
    raise newException(ValueError, "driver name is already registered")
  let index = GDALRegisterDriver(handle)
  if index < 0 or GDALGetDriver(index) != handle:
    raise gdalError("could not register driver")
  discard takeHandle(driver.resource)
  DriverInfo(handle: handle)

proc driverInfo*(name: string): DriverInfo =
  ## Borrows a registered driver, valid until GDAL's registry is shut down.
  validateCString(name, "driver name")
  GDALAllRegister()
  let handle = GDALGetDriverByName(name.cstring)
  if handle == nil:
    raise newException(KeyError, "unknown GDAL driver: " & name)
  DriverInfo(handle: handle)

proc name*(driver: DriverInfo): string =
  $GDALGetDriverShortName(driver.rawHandle)

proc longName*(driver: DriverInfo): string =
  $GDALGetDriverLongName(driver.rawHandle)

proc name*(driver: Driver): string =
  $GDALGetDescription(driver.rawHandle)

iterator drivers*(): DriverInfo =
  GDALAllRegister()
  for i in 0 ..< int(GDALGetDriverCount()):
    yield DriverInfo(handle: GDALGetDriver(cint(i)))
