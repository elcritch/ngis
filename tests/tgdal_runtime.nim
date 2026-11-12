## Exercise explicit runtime loading without letting failures poison a retry.
import std/[os, osproc, tempfiles, unittest]
import ngis/gdal

const expectMissing {.booldefine.} = false

when defined(gdalRuntime) or defined(feature.ngis.runtime) or
    defined(features.ngis.runtime):
  import std/dynlib

  suite "runtime GDAL library":
    test "import leaves the library and procedure pointers unloaded":
      check gdalRuntimeEnabled
      check not isGdalLoaded()
      check gdalLibraryPath() == ""
      check GDALVersionInfo == nil
      check GDALAllRegister == nil

    test "failed paths leave state unchanged and can be retried":
      let missing = currentSourcePath().parentDir / "missing-gdal-library"
      for attempt in 0 .. 1:
        expect GdalLoadError:
          loadGdal(missing)
        check not isGdalLoaded()
        check gdalLibraryPath() == ""
        check GDALVersionInfo == nil
        check GDALAllRegister == nil

    test "a non-GDAL library is rejected":
      let path =
        when defined(windows):
          "kernel32.dll"
        elif defined(macosx):
          "/usr/lib/libSystem.B.dylib"
        else:
          "libc.so.6"
      expect GdalLoadError:
        loadGdal(path)
      check not isGdalLoaded()
      check GDALVersionInfo == nil
      check GDALAllRegister == nil

    test "an embedded NUL cannot truncate a library path":
      expect ValueError:
        loadGdal("missing-gdal\0library")
      check not isGdalLoaded()
      check GDALVersionInfo == nil
      check GDALAllRegister == nil

    when expectMissing:
      test "default discovery failure is recoverable":
        for attempt in 0 .. 1:
          expect GdalLoadError:
            loadGdal()
          check not isGdalLoaded()
          check GDALVersionInfo == nil

      test "an explicit path can recover after failed discovery":
        let path = getEnv("GDAL_TEST_LIBRARY_PATH")
        if path.len > 0:
          loadGdal(path)
          check isGdalLoaded()
          check ($GDALVersionInfo("RELEASE_NAME")).len > 0
    else:
      when compileOption("threads"):
        test "concurrent loads publish pointers before returning":
          proc probe(ok: ptr bool) {.thread.} =
            loadGdal()
            ok[] =
              isGdalLoaded() and GDALVersionInfo != nil and GDALAllRegister != nil and
              ($GDALVersionInfo("RELEASE_NAME")).len > 0

          var results: array[2, bool]
          var threads: array[2, Thread[ptr bool]]
          for i in 0 ..< threads.len:
            createThread(threads[i], probe, addr results[i])
          joinThreads(threads)
          check results[0] and results[1]

      test "successful loads are idempotent and native symbols are preserved":
        loadGdal()
        require isGdalLoaded()
        let path = gdalLibraryPath()
        require path.len > 0
        let version = GDALVersionInfo
        check version != nil
        check ($version("RELEASE_NAME")).len > 0
        loadGdal()
        check GDALVersionInfo == version
        check gdalLibraryPath() == path

        let handle = loadLib(path)
        require handle != nil
        defer:
          unloadLib(handle)
        check cast[pointer](GDALVersionInfo) == symAddr(handle, "GDALVersionInfo")
        check cast[pointer](GDALAllRegister) == symAddr(handle, "GDALAllRegister")
        check cast[pointer](RPCInfoV1ToMD) == symAddr(handle, "RPCInfoToMD")

        var buffer: array[64, char]
        check CPLsprintfBuffer(cast[cstring](addr buffer[0]), "%s %d", "test", 42) == 7
        check $cast[cstring](addr buffer[0]) == "test 42"
        check $CPLSPrintfText("%s %d", "test", 42) == "test 42"

      test "a loaded library cannot be replaced":
        expect ValueError:
          loadGdal("another-gdal-library")
        check isGdalLoaded()
        check GDALVersionInfo != nil
else:
  suite "automatic GDAL library loading":
    when not expectMissing:
      test "import loads the installed library":
        check isGdalLoaded()
        check GDALVersionInfo != nil
        check ($GDALVersionInfo("RELEASE_NAME")).len > 0

suite "isolated GDAL loading":
  test "optional symbols remain nil in a minimal library":
    let tempDir = createTempDir("ngis-gdal-runtime-", "")
    defer:
      removeDir(tempDir)
    let fixtures = currentSourcePath().parentDir / "fixtures"
    let stubName =
      when defined(windows):
        "gdalstub.dll"
      elif defined(macosx):
        "gdalstub.dylib"
      else:
        "gdalstub.so"
    let stub = tempDir / stubName
    let child = tempDir / changeFileExt("gdalchild", ExeExt)
    let src = currentSourcePath().parentDir.parentDir / "src"
    let buildStub =
      "nim c --hints:off --app:lib --out:" & quoteShell(stub) & " " &
      quoteShell(fixtures / "gdal_runtime_stub.nim")
    let (stubOutput, stubCode) = execCmdEx(buildStub)
    checkpoint stubOutput
    require stubCode == 0
    let buildChild =
      "nim c --hints:off -d:gdalRuntime --path:" & quoteShell(src) & " --out:" &
      quoteShell(child) & " " & quoteShell(fixtures / "gdal_runtime_child.nim")
    let (childOutput, childCode) = execCmdEx(buildChild)
    checkpoint childOutput
    require childCode == 0
    let (output, code) = execCmdEx(quoteShell(child) & " stub " & quoteShell(stub))
    checkpoint output
    check code == 0

  test "missing automatic library permits safe cleanup and explicit recovery":
    let path =
      if gdalLibraryPath().len > 0:
        gdalLibraryPath()
      else:
        getEnv("GDAL_TEST_LIBRARY_PATH")
    if path.len > 0:
      let tempDir = createTempDir("ngis-gdal-recovery-", "")
      defer:
        removeDir(tempDir)
      let fixtures = currentSourcePath().parentDir / "fixtures"
      let child = tempDir / changeFileExt("gdalchild", ExeExt)
      let src = currentSourcePath().parentDir.parentDir / "src"
      let build =
        "nim c --hints:off -d:gdalLib=missing-ngis-gdal-library --path:" &
        quoteShell(src) & " --out:" & quoteShell(child) & " " &
        quoteShell(fixtures / "gdal_runtime_child.nim")
      let (buildOutput, buildCode) = execCmdEx(build)
      checkpoint buildOutput
      require buildCode == 0
      let (output, code) =
        execCmdEx(quoteShell(child) & " recovery " & quoteShell(path))
      checkpoint output
      check code == 0
