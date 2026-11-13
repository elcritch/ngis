## Recoverable GDAL loading. Successful libraries remain loaded for the process lifetime.
## Define `gdalRuntime` to disable automatic loading and call `loadGdal` explicitly.
import std/[dynlib, locks, strutils]

type
  GdalLoadError* = object of CatchableError
    ## A GDAL library could not be opened or lacks its identifying C symbols.

  ImportBinder = proc(handle: LibHandle) {.gcsafe, raises: [].}

const
  gdalRuntimeEnabled* =
    defined(gdalRuntime) or defined(feature.ngis.runtime) or
    defined(features.ngis.runtime)
  gdalLib* {.strdefine.} = ""
    ## Overrides default library discovery. An explicit loadGdal(path) takes precedence.
  gdalDynlib* {.strdefine.} = ""
    ## Alternate spelling of gdalLib, matching other runtime-loaded Nim libraries.

var
  loaderLock: Lock
  libraryHandle: LibHandle
  loadedPath: cstring
  importBinders: seq[ImportBinder]

initLock(loaderLock)

proc libraryNames(): seq[string] =
  if gdalDynlib.len > 0:
    return @[gdalDynlib]
  if gdalLib.len > 0:
    # Older versions accepted Nim dynlib patterns in this define.
    libCandidates(gdalLib, result)
    return
  when defined(windows):
    result = @["gdal.dll", "gdal313.dll", "gdal312.dll", "gdal311.dll", "gdal310.dll"]
  elif defined(macosx):
    result = @["libgdal.dylib", "libgdal.39.dylib", "libgdal.38.dylib"]
    for prefix in ["/opt/homebrew/opt/gdal/lib/", "/usr/local/opt/gdal/lib/"]:
      result.add prefix & "libgdal.dylib"
  else:
    result = @[
      "libgdal.so", "libgdal.so.39", "libgdal.so.38", "libgdal.so.37", "libgdal.so.36",
      "libgdal.so.35", "libgdal.so.34", "libgdal.so.33", "libgdal.so.32",
    ]

proc registerGdalImports*(binder: ImportBinder) =
  ## Internal registration used by generated raw API blocks.
  {.cast(gcsafe).}:
    withLock loaderLock:
      importBinders.add binder
      if libraryHandle != nil:
        binder(libraryHandle)

proc isGdalLoaded*(): bool {.gcsafe.} =
  ## Reports whether loadGdal has successfully published the C procedure pointers.
  withLock loaderLock:
    result = libraryHandle != nil

proc gdalLibraryPath*(): string {.gcsafe.} =
  ## Returns the selected loader name or path, or an empty string before loading.
  withLock loaderLock:
    if loadedPath != nil:
      result = $loadedPath

proc loadGdal*(path = "") {.gcsafe.} =
  ## Loads GDAL and binds its C procedure pointers exactly once.
  ##
  ## An explicit path takes precedence over gdalLib/gdalDynlib and platform discovery.
  ## Failure raises GdalLoadError and can be retried. Missing optional symbols remain
  ## nil. Call before using raw procedures, including before starting worker threads.
  ## A successful library cannot be replaced or unloaded while native resources exist.
  if '\0' in path:
    raise newException(ValueError, "GDAL library path contains a NUL byte")
  {.cast(gcsafe).}:
    withLock loaderLock:
      if libraryHandle != nil:
        if path.len > 0 and path != $loadedPath:
          raise newException(ValueError, "GDAL is already loaded from " & $loadedPath)
        return
      let candidates =
        if path.len > 0:
          @[path]
        else:
          libraryNames()
      var invalid: seq[string]
      for name in candidates:
        if '\0' in name:
          raise newException(ValueError, "GDAL library name contains a NUL byte")
        let handle = loadLib(name)
        if handle == nil:
          continue
        var missing = ""
        for symbol in ["GDALVersionInfo", "GDALAllRegister"]:
          if symAddr(handle, symbol.cstring) == nil:
            missing = symbol
            break
        if missing.len > 0:
          unloadLib(handle)
          invalid.add name & " (missing " & missing & ")"
          continue
        let saved = cast[cstring](allocShared0(name.len + 1))
        copyMem(saved, name.cstring, name.len)
        for binder in importBinders:
          binder(handle)
        loadedPath = saved
        libraryHandle = handle
        return
      let detail =
        if invalid.len > 0:
          "; rejected: " & invalid.join(", ")
        else:
          ""
      raise newException(
        GdalLoadError, "could not load GDAL; tried: " & candidates.join(", ") & detail
      )
