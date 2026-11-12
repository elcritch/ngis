## Owning virtual files and directory streams for GDAL's VSI filesystems.
import std/options
import ./[gdal, datasets]
import ./private/resources

type
  VirtualFile* = object
    resource: NativeResource[ptr VSILFILE]

  Directory* = object
    resource: NativeResource[ptr VSIDIR]

  ZipArchive* = object
    resource: NativeResource[pointer]

  FileInfo* = object
    size*: uint64
    mode*: uint32
    modified*: int64

  DirectoryEntry* = object
    name*: string
    info*: FileInfo
    sizeKnown*, modeKnown*, modifiedKnown*: bool

proc rawHandle*(file: VirtualFile): ptr VSILFILE =
  rawHandle(file.resource)

proc rawHandle*(directory: Directory): ptr VSIDIR =
  rawHandle(directory.resource)

proc isClosed*(file: VirtualFile): bool =
  isClosed(file.resource)

proc isClosed*(directory: Directory): bool =
  isClosed(directory.resource)

proc adoptVirtualFile*(handle: ptr VSILFILE): VirtualFile =
  ## Takes ownership of a VSI large-file handle.
  VirtualFile(
    resource: newNativeResource(
      handle,
      proc(h: ptr VSILFILE) {.raises: [].} =
        discard VSIFCloseL(h),
    )
  )

proc openVirtualFile*(path: string, mode = "rb"): VirtualFile =
  ## Opens any installed VSI filesystem, including `/vsimem/`.
  validateCString(path, "file path")
  validateCString(mode, "file mode")
  CPLErrorReset()
  let handle = VSIFOpenExL(path.cstring, mode.cstring, 1)
  if handle == nil:
    raise gdalError("could not open virtual file")
  adoptVirtualFile(handle)

proc flush*(file: VirtualFile) =
  if VSIFFlushL(file.rawHandle) != 0:
    raise gdalError("could not flush virtual file")

proc close*(file: VirtualFile) =
  ## Flushes pending writes before releasing the shared file owner.
  if not file.isClosed:
    var failure: ref IOError
    if VSIFFlushL(file.rawHandle) != 0:
      failure = gdalError("could not flush virtual file")
    let handle = takeHandle(file.resource)
    if VSIFCloseL(handle) != 0 and failure == nil:
      failure = gdalError("could not close virtual file")
    if failure != nil:
      raise failure

proc position*(file: VirtualFile): uint64 =
  result = uint64(VSIFTellL(file.rawHandle))
  if result == high(uint64):
    raise gdalError("could not obtain virtual file position")

proc `position=`*(file: VirtualFile, offset: uint64) =
  if VSIFSeekL(file.rawHandle, vsi_l_offset(offset), 0) != 0:
    raise gdalError("could not seek virtual file")

proc size*(file: VirtualFile): uint64 =
  let saved = file.position
  if VSIFSeekL(file.rawHandle, 0, 2) != 0:
    raise gdalError("could not seek virtual file")
  try:
    result = file.position
  finally:
    file.position = saved

proc read*(file: VirtualFile, count: int): seq[byte] =
  ## Reads at most count bytes. A shorter result signals end of file.
  if count < 0:
    raise newException(ValueError, "read count must be nonnegative")
  let handle = file.rawHandle
  result = newSeq[byte](count)
  if count > 0:
    let amount = VSIFReadL(addr result[0], 1, csize_t(count), handle)
    if amount < csize_t(count) and VSIFErrorL(handle) != 0:
      raise gdalError("could not read virtual file")
    result.setLen(int(amount))

proc write*(file: VirtualFile, bytes: openArray[byte]) =
  let handle = file.rawHandle
  if bytes.len > 0 and
      VSIFWriteL(unsafeAddr bytes[0], 1, csize_t(bytes.len), handle) !=
      csize_t(bytes.len):
    raise gdalError("could not write virtual file")

proc truncate*(file: VirtualFile, size: uint64) =
  if VSIFTruncateL(file.rawHandle, vsi_l_offset(size)) != 0:
    raise gdalError("could not truncate virtual file")

proc eof*(file: VirtualFile): bool =
  VSIFEofL(file.rawHandle) != 0

proc stat*(path: string): FileInfo =
  validateCString(path, "file path")
  var info: VSIStatBufL
  if VSIStatL(path.cstring, addr info) != 0:
    raise gdalError("could not stat virtual file")
  FileInfo(
    size: uint64(info.st_size),
    mode: uint32(info.st_mode),
    modified: int64(info.st_mtime),
  )

proc removeVirtualFile*(path: string) =
  validateCString(path, "file path")
  if VSIUnlink(path.cstring) != 0:
    raise gdalError("could not remove virtual file")

proc renameVirtualFile*(source, destination: string) =
  validateCString(source, "source path")
  validateCString(destination, "destination path")
  if VSIRename(source.cstring, destination.cstring) != 0:
    raise gdalError("could not rename virtual file")

proc createVirtualDirectory*(path: string, recursive = false) =
  validateCString(path, "directory path")
  let code =
    if recursive:
      VSIMkdirRecursive(path.cstring, 0o755)
    else:
      VSIMkdir(path.cstring, 0o755)
  if code != 0:
    raise gdalError("could not create virtual directory")

proc removeVirtualDirectory*(path: string, recursive = false) =
  validateCString(path, "directory path")
  let code =
    if recursive:
      VSIRmdirRecursive(path.cstring)
    else:
      VSIRmdir(path.cstring)
  if code != 0:
    raise gdalError("could not remove virtual directory")

proc openDirectory*(path: string, depth = 0): Directory =
  validateCString(path, "directory path")
  if depth < -1 or depth > int(high(cint)):
    raise newException(ValueError, "directory depth is out of range")
  let handle = VSIOpenDir(path.cstring, cint(depth), nil)
  if handle == nil:
    raise gdalError("could not open directory")
  Directory(
    resource: newNativeResource(
      handle,
      proc(h: ptr VSIDIR) {.raises: [].} =
        VSICloseDir(h),
    )
  )

proc close*(directory: Directory) =
  close(directory.resource)

proc next*(directory: Directory): Option[DirectoryEntry] =
  ## Copies the next native entry; previous entries remain usable.
  let entry = VSIGetNextDirEntry(directory.rawHandle)
  if entry != nil:
    result = some(
      DirectoryEntry(
        name: $entry.pszName,
        sizeKnown: entry.bSizeKnown != '\0',
        modeKnown: entry.bModeKnown != '\0',
        modifiedKnown: entry.bMTimeKnown != '\0',
        info: FileInfo(
          size: uint64(entry.nSize),
          mode: uint32(entry.nMode),
          modified: int64(entry.nMTime),
        ),
      )
    )

iterator items*(directory: Directory): DirectoryEntry =
  ## Consumes the directory's shared cursor.
  var entry = directory.next
  while entry.isSome:
    yield entry.get
    entry = directory.next

proc rawHandle*(archive: ZipArchive): pointer =
  rawHandle(archive.resource)

proc createZip*(path: string): ZipArchive =
  ## Creates a ZIP archive. Close it explicitly to report finalization failures.
  validateCString(path, "archive path")
  let handle = CPLCreateZip(path.cstring, nil)
  if handle == nil:
    raise gdalError("could not create ZIP archive")
  ZipArchive(
    resource: newNativeResource(
      handle,
      proc(h: pointer) {.raises: [].} =
        discard CPLCloseZip(h),
    )
  )

proc addFile*(archive: ZipArchive, path: string, bytes: openArray[byte]) =
  ## Adds one entry, closing the entry even if writing fails.
  validateCString(path, "archive entry name")
  let handle = archive.rawHandle
  if CPLCreateFileInZip(handle, path.cstring, nil) != CE_None:
    raise gdalError("could not create ZIP entry")
  var entryOpen = true
  try:
    var offset = 0
    while offset < bytes.len:
      let count = min(bytes.len - offset, int(high(cint)))
      if CPLWriteFileInZip(handle, unsafeAddr bytes[offset], cint(count)) != CE_None:
        raise gdalError("could not write ZIP entry")
      offset += count
    let code = CPLCloseFileInZip(handle)
    entryOpen = false
    if code != CE_None:
      raise gdalError("could not close ZIP entry")
  finally:
    if entryOpen:
      discard CPLCloseFileInZip(handle)

proc close*(archive: ZipArchive) =
  if not archive.resource.isClosed:
    let handle = takeHandle(archive.resource)
    if CPLCloseZip(handle) != CE_None:
      raise gdalError("could not close ZIP archive")
