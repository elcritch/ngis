import std/unittest
import ngis/gdal/[datasets, vector, vectorextras]
import ngis/gdal/api

suite "vector resources":
  test "schema definitions copy their fields":
    let schema = newFeatureDefinition("test")
    let field = newFieldDefinition("name", OFTString)
    field.setWidth(20)
    schema.add(field)
    let copy = schema.clone()
    field.close()
    check copy.fieldCount == 1
    check copy.field(0).name == "name"
    check copy.field(0).width == 20
    let geom = newGeometryFieldDefinition("other", wkbPoint)
    schema.add(geom)
    check schema.geometryField(schema.geometryFieldCount - 1).name == "other"
  test "styles and prepared geometry":
    let table = newStyleTable()
    table.add("road", "PEN(c:#ff0000,w:2px)")
    check table.find("road").len > 0
    let manager = newStyleManager(table)
    manager.init(table.find("road"))
    check manager.partCount == 1
    let tool = manager.part(0)
    check tool.styleString.len > 0
    if OGRHasPreparedGeometrySupport() != 0:
      let polygon = geometryFromWkt("POLYGON ((0 0, 5 0, 5 5, 0 5, 0 0))")
      let prep = polygon.prepare()
      polygon.close()
      check prep.contains(newPoint(1, 1))
      check not prep.intersects(newPoint(10, 10))
  test "SQL result retains dataset and closes aliases":
    let ds = createDataset("MEM", "", 0, 0, 0)
    let layer = ds.createLayer("places", wkbPoint)
    let f = layer.newFeature()
    f.setGeometry(newPoint(1, 2))
    layer.add(f)
    let resultSet = ds.executeSql("SELECT * FROM places")
    let alias = resultSet
    ds.close()
    check resultSet.featureCount == 1
    resultSet.close()
    expect ValueError:
      discard alias.rawHandle
    resultSet.close()

  test "dataset transaction commits and rolls back on failure":
    const path = "/vsimem/ngis-vector-transaction.gpkg"
    defer:
      discard VSIUnlink(path)
    let ds = createDataset("GPKG", path, 0, 0, 0)
    let layer = ds.createLayer("items", wkbPoint)
    withTransaction(ds):
      let f = layer.newFeature()
      f.setGeometry(newPoint(1, 2))
      layer.add(f)
    expect ValueError:
      withTransaction(ds):
        let f = layer.newFeature()
        f.setGeometry(newPoint(3, 4))
        layer.add(f)
        raise newException(ValueError, "abort")
    proc earlyReturn() =
      withTransaction(ds):
        let f = layer.newFeature()
        f.setGeometry(newPoint(5, 6))
        layer.add(f)
        return

    earlyReturn()
    let rows = ds.executeSql("SELECT * FROM items")
    check rows.featureCount == 1
    rows.close()
    ds.close()

  test "geometry transformer clones its coordinate transformation":
    let source = newSpatialReference(4326)
    let target = newSpatialReference(3857)
    let ct = newCoordinateTransform(source, target)
    let transformer = newGeometryTransformer(ct)
    ct.close()
    source.close()
    target.close()
    let point = newPoint(1, 1)
    let transformed = transformer.transform(point)
    check abs(transformed.x) > 1000
    transformer.close()
