import std/unittest
import ngis/gdal/api/vector

suite "GDAL vector C API":
  test "geometry envelope and WKB round trip":
    let line = OGR_G_CreateGeometry(wkbLineString)
    require line != nil
    defer:
      OGR_G_DestroyGeometry(line)
    check OGR_G_AddPoint_2D(line, -3.0, 4.0) == OGRERR_NONE
    check OGR_G_AddPoint_2D(line, 7.0, -2.0) == OGRERR_NONE
    var envelope: OGREnvelope
    OGR_G_GetEnvelope(line, addr envelope)
    check envelope.MinX == -3.0
    check envelope.MaxX == 7.0
    check envelope.MinY == -2.0
    check envelope.MaxY == 4.0
    let size = OGR_G_WkbSize(line)
    var bytes = newSeq[byte](size)
    check OGR_G_ExportToWkb(line, wkbNDR, addr bytes[0]) == OGRERR_NONE
    var restored: OGRGeometryH
    check OGR_G_CreateFromWkb(addr bytes[0], nil, addr restored, size) == OGRERR_NONE
    require restored != nil
    defer:
      OGR_G_DestroyGeometry(restored)
    check OGR_G_GetPointCount(restored) == 2
    check OGR_G_GetX(restored, 1) == 7.0

  test "spatial reference clone and axis mapping":
    let srs = OSRNewSpatialReference(nil)
    require srs != nil
    defer:
      OSRDestroySpatialReference(srs)
    check OSRImportFromEPSG(srs, 4326) == OGRERR_NONE
    OSRSetAxisMappingStrategy(srs, OAMS_TRADITIONAL_GIS_ORDER)
    let clone = OSRClone(srs)
    require clone != nil
    defer:
      OSRDestroySpatialReference(clone)
    check OSRIsSame(srs, clone) != 0
    check OSRGetAxisMappingStrategy(clone) == OAMS_TRADITIONAL_GIS_ORDER

import ngis/gdal/[datasets, vector]

suite "Owned vector objects":
  test "create and read features from an in-memory layer":
    let ds = createDataset("MEM", "", 0, 0, 0)
    let lyr = createLayer(ds, "places", wkbPoint)
    lyr.addField("name", OFTString)
    lyr.addField("population", OFTInteger64)
    lyr.addField("height", OFTReal)
    let feature = lyr.newFeature()
    feature["name"] = "home"
    feature.setField("population", 1234567890123'i64)
    feature.setField("height", 2.5)
    feature.setGeometry(newPoint(2.0, 3.0))
    lyr.add(feature)
    var count = 0
    for found in lyr:
      inc count
      check found["name"] == "home"
      check found.intField("population") == 1234567890123'i64
      check found.floatField("height") == 2.5
      let point = found.geometry
      check point.x == 2.0
      check point.y == 3.0
      check point.toWkt == "POINT (2 3)"
      check geometryFromGeoJson(point.toGeoJson).x == 2.0
    check count == 1
    var stored: Geometry
    for found in lyr:
      stored = found.geometry
    check stored.x == 2.0
    ds.close()
    check stored.y == 3.0
    expect ValueError:
      discard lyr.rawHandle

  test "owned geometry clone survives its original":
    var original = geometryFromWkt("POINT (1 2)")
    let copied = original.clone()
    original = nil
    check copied.x == 1.0
    check copied.y == 2.0

  test "coordinate transformations own their inputs":
    var source = newSpatialReference(4326)
    var target = source.clone()
    let conversion = newCoordinateTransform(source, target)
    source = nil
    target = nil
    var x = 1.0
    var y = 2.0
    var z = 0.0
    conversion.transform(x, y, z)
    check abs(x - 1.0) < 1e-10
    check abs(y - 2.0) < 1e-10
    let point = newPoint(1.0, 2.0)
    point.transform(conversion)
    check abs(point.x - 1.0) < 1e-10

  test "geometry retains a CRS after its original owner closes":
    let reference = newSpatialReference("EPSG:4326")
    let point = newPoint(1, 2)
    point.setSpatialReference(reference)
    reference.close()
    reference.close()
    expect ValueError:
      discard reference.rawHandle
    let retained = point.spatialReference
    check OSRIsGeographic(retained.rawHandle) != 0
    check retained.toWkt.len > 0
    point.close()
    check OSRIsGeographic(retained.rawHandle) != 0
