import std/unittest
import ngis/[datasets, raster, rasterio]

suite "raster grids and windows":
  test "typed grids round trip and tile edges":
    let image = createRaster(uint16, 5, 3)
    let band = image.band()
    var grid = initRasterGrid[uint16](5, 3)
    for y in 0 ..< grid.height:
      for x in 0 ..< grid.width:
        grid[x, y] = uint16(y * grid.width + x)
    band.write(grid)
    let result = readGrid[uint16](band)
    check result[4, 2] == 14
    var windows: seq[RasterWindow]
    for window in band.tiles(3, 2):
      windows.add window
    check windows ==
      @[
        initRasterWindow(0, 0, 3, 2),
        initRasterWindow(3, 0, 2, 2),
        initRasterWindow(0, 2, 3, 1),
        initRasterWindow(3, 2, 2, 1),
      ]
    let small = readGrid[uint16](band, initRasterWindow(0, 0, 5, 3), 2, 1)
    check small.width == 2
    check small.height == 1
    let edge = readGrid[uint16](band, windows[^1])
    check edge.width == 2
    check edge.height == 1
    check edge[1, 0] == 14
    band.write(initRasterGrid(2, 1, @[99'u16, 100]), windows[^1])
    check readGrid[uint16](band)[4, 2] == 100

  test "invalid buffers, indices, windows and shapes":
    let image = createRaster(uint8, 2, 2)
    let band = image.band()
    expect ValueError:
      discard initRasterGrid(2, 2, @[1'u8])
    var grid = initRasterGrid[uint8](2, 2)
    expect ValueError:
      discard grid[-1, 0]
    expect ValueError:
      grid[2, 0] = 1
    expect ValueError:
      band.write(grid, initRasterWindow(0, 0, 1, 1))
    expect ValueError:
      discard readGrid[uint8](band, initRasterWindow(1, 1, 2, 2))
    expect ValueError:
      band.write(grid, RasterWindow(x: 0, y: 0, width: 0, height: 1))
