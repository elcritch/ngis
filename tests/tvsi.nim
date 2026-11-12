import std/[options, unittest]
import ngis/[gdal, vsi]

suite "owning VSI resources":
  test "memory files support seek, stat, truncate and shared close":
    let path = "/vsimem/ngis-owning-vsi.dat"
    defer:
      discard VSIUnlink(path.cstring)
    let file = openVirtualFile(path, "w+b")
    let alias = file
    file.write([1'u8, 2, 3, 4])
    check file.position == 4
    check file.size == 4
    check file.position == 4
    file.flush()
    check vsi.stat(path).size == 4
    var rawInfo: VSIStatBufL
    check VSIStatL(path.cstring, addr rawInfo) == 0
    check rawInfo.st_size == 4
    check VSI_ISREG(rawInfo.st_mode)
    file.position = 1
    check file.read(8) == @[2'u8, 3, 4]
    check file.eof
    file.truncate(2)
    file.close()
    alias.close()
    expect ValueError:
      discard alias.position
    let reopened = openVirtualFile(path)
    check reopened.read(10) == @[1'u8, 2]
    expect ValueError:
      discard reopened.read(-1)

  test "automatic file release and copied directory entries":
    let path = "/vsimem/ngis-vsi-directory"
    createVirtualDirectory(path)
    defer:
      removeVirtualDirectory(path, recursive = true)
    block:
      let file = openVirtualFile(path & "/data", "wb")
      file.write([9'u8])
    let directory = openDirectory(path)
    let entry = directory.next
    require entry.isSome
    check entry.get.name == "data"
    directory.close()
    check entry.get.name == "data"
    expect ValueError:
      discard directory.next

  test "invalid file names raise catchable errors":
    expect ValueError:
      discard openVirtualFile("bad\0name")
    expect IOError:
      discard openVirtualFile("/vsimem/ngis-absent-vsi-file")

  test "ZIP archive entries can be read through VSI":
    let path = "/vsimem/ngis-owning-archive.zip"
    defer:
      discard VSIUnlink(path.cstring)
    let archive = createZip(path)
    archive.addFile("values.bin", [10'u8, 20, 30])
    archive.addFile("empty", [])
    archive.close()
    archive.close()
    let file = openVirtualFile("/vsizip/" & path & "/values.bin")
    check file.read(4) == @[10'u8, 20, 30]
