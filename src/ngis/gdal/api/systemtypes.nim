## Native system buffers used by VSI. Imported types use the platform headers'
## layout; their fields can be read after VSIStat and VSIStatL.
when not defined(windows):
  import std/strutils
  const nativeGdalCflags = staticExec("gdal-config --cflags 2>/dev/null || true").strip
  when nativeGdalCflags.len > 0:
    {.passC: nativeGdalCflags.}

when defined(posix):
  import std/posix as nativePosix
  type
    GdalSystemstat* = nativePosix.Stat
    GdalSystemtm* = nativePosix.Tm
    VSIStatBufL* {.importc: "VSIStatBufL", header: "<cpl_vsi.h>", bycopy.} = object
      st_dev*: nativePosix.Dev
      st_ino*: nativePosix.Ino
      st_mode*: nativePosix.Mode
      st_nlink*: nativePosix.Nlink
      st_uid*: nativePosix.Uid
      st_gid*: nativePosix.Gid
      st_rdev*: nativePosix.Dev
      st_size*: nativePosix.Off
      st_atime*: nativePosix.Time
      st_mtime*: nativePosix.Time
      st_ctime*: nativePosix.Time
      st_blksize*: nativePosix.Blksize
      st_blocks*: nativePosix.Blkcnt

else:
  type
    GdalSystemstat* {.importc: "struct stat", header: "<sys/stat.h>", bycopy.} = object
      st_mode*: cushort
      st_size*: clong
      st_mtime*: int64

    GdalSystemtm* {.importc: "struct tm", header: "<time.h>", bycopy.} = object
      tm_sec*, tm_min*, tm_hour*, tm_mday*, tm_mon*, tm_year*: cint
      tm_wday*, tm_yday*, tm_isdst*: cint

    VSIStatBufL* {.importc: "VSIStatBufL", header: "<cpl_vsi.h>", bycopy.} = object
      st_mode*: cushort
      st_size*: int64
      st_atime*, st_mtime*, st_ctime*: int64
