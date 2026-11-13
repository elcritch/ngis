import std/unittest
import ngis/gdal/[memory, plugins, progress, drivers]
import ngis/gdal/api

proc onProgress(complete: cdouble, message: cstring, data: pointer): cint {.cdecl.} =
  cast[ptr float64](data)[] = complete
  1

suite "auxiliary native owners":
  test "aligned native buffers preserve aliases and validate bounds":
    let buffer = newNativeBuffer(64, alignment = 64)
    let alias = buffer
    check cast[uint](buffer.rawHandle) mod 64 == 0
    buffer.write([3'u8, 4], 2)
    check alias.read(2, 2) == @[3'u8, 4]
    expect ValueError:
      discard buffer.read(63, 2)
    buffer.close()
    expect ValueError:
      discard alias.len
    let empty = newNativeBuffer(0)
    check empty.read().len == 0
    expect ValueError:
      discard newNativeBuffer(4, alignment = 3)

  test "callback-table and progress contexts release once":
    let callbacks = newFilesystemCallbacks()
    require callbacks.rawHandle != nil
    let alias = callbacks
    callbacks.close()
    expect ValueError:
      discard alias.rawHandle
    var complete = 0.0
    let step = newScaledProgress(0.25, 0.75, onProgress, addr complete)
    check step.update(0.5)
    check complete == 0.5
    step.close()
    expect ValueError:
      discard step.update(0.5)

  test "drivers are owned until registry transfer":
    let temporary = newDriver("ngis-unregistered-test")
    check temporary.name == "ngis-unregistered-test"
    temporary.close()
    expect ValueError:
      discard temporary.rawHandle
    check driverInfo("MEM").name == "MEM"
    let duplicate = newDriver("MEM")
    expect ValueError:
      discard duplicate.register()
    check duplicate.name == "MEM"
    let owned = newDriver("ngis-registry-transfer-test")
    let registered = owned.register()
    defer:
      GDALDeregisterDriver(registered.rawHandle)
      GDALDestroyDriver(registered.rawHandle)
    check registered.name == "ngis-registry-transfer-test"
    expect ValueError:
      discard owned.rawHandle
    var count = 0
    for driver in drivers():
      check driver.name.len > 0
      inc count
    check count > 0
