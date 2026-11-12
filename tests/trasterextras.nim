import std/unittest
import ngis/[gdal, datasets, raster, rasterextras]

suite "owning raster extras":
  test "color and attribute tables survive dataset closure":
    let ds = createDataset("MEM", "", 2, 2)
    let band = ds.band()
    let colors = newColorTable()
    colors[1] = GDALColorEntry(c1: 10, c2: 20, c3: 30, c4: 255)
    band.setColorTable(colors)
    let borrowedColors = band.colorTable()
    colors.close()
    check borrowedColors[1].c2 == 20

    let rat = newRasterAttributeTable()
    rat.addColumn("name", GFT_String)
    rat.addColumn("count", GFT_Integer)
    rat.addColumn("score", GFT_Real)
    rat.setRowCount(1)
    rat.setValue(0, 0, "sample")
    rat.setValue(0, 1, 4)
    rat.setValue(0, 2, 2.5)
    band.setAttributeTable(rat)
    let borrowedRat = band.attributeTable()
    rat.close()
    ds.close()
    check borrowedColors[1].c1 == 10
    check borrowedRat.column(0).name == "name"
    check borrowedRat.stringValue(0, 0) == "sample"
    check borrowedRat.intValue(0, 1) == 4
    check borrowedRat.floatValue(0, 2) == 2.5
    let alias = borrowedRat
    borrowedRat.close()
    alias.close()
    expect ValueError:
      discard alias.rowCount
    borrowedColors.close()

  test "statistics and histogram use real raster values":
    let ds = createDataset("MEM", "", 2, 2)
    let band = ds.band()
    band.write(@[1'u8, 2, 3, 4])
    let stats = band.statistics()
    check stats.minimum == 1
    check stats.maximum == 4
    check stats.mean == 2.5
    check band.histogram(0.5, 4.5, 4) == @[1'u64, 1, 1, 1]
    check band.overviewCount == 0
    ds.close()

  test "ground control points and overviews":
    let ds = createDataset("MEM", "", 4, 4)
    ds.setGroundControlPoints(
      [
        GroundControlPoint(
          id: "point", info: "info", pixel: 1, line: 2, x: 3, y: 4, z: 5
        )
      ]
    )
    let points = ds.groundControlPoints
    check points.len == 1
    check points[0].id == "point"
    check points[0].x == 3
    ds.buildOverviews([2])
    check ds.band.overviewCount == 1
    ds.close()
    check points[0].info == "info"
