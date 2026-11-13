import std/unittest
import ngis/gdal/[schemadomains, spatialrefs, datasets]
import ngis/gdal/api

suite "schema resources":
  test "coded, glob and range domains own their native data":
    let coded = newCodedDomain(
      "status",
      [CodedValue(code: "1", value: "ready"), CodedValue(code: "2", value: "done")],
    )
    check coded.name == "status"
    check coded.codedValues ==
      @[CodedValue(code: "1", value: "ready"), CodedValue(code: "2", value: "done")]
    let glob = newGlobDomain("station", "ST-*")
    check glob.glob == "ST-*"
    let range = newRangeDomain("height", 1.5, 8.0)
    check OGR_FldDomain_GetFieldType(range.rawHandle) == OFTReal
    var inclusive: bool
    check OGR_RangeFldDomain_GetMin(range.rawHandle, addr inclusive)[].Real == 1.5
    check inclusive
    coded.close()
    expect ValueError:
      discard coded.name
    expect ValueError:
      discard newCodedDomain("bad", [CodedValue(code: "x"), CodedValue(code: "x")])

  test "relationship fields are copied":
    let relationship = newRelationship("roads", "road", "bridge")
    relationship.setLeftFields(["road_id"])
    relationship.setRightFields(["bridge_id"])
    check relationship.name == "roads"
    check relationship.leftTable == "road"
    check relationship.rightTable == "bridge"
    check relationship.leftFields == @["road_id"]
    check relationship.rightFields == @["bridge_id"]
    relationship.close()
    relationship.close()
    expect ValueError:
      discard relationship.leftFields

  test "coordinate options are owned":
    let options = newCoordinateOptions()
    options.setAreaOfInterest(-10, 30, 10, 50)
    options.setDesiredAccuracy(10)
    options.setBallparkAllowed(true)
    options.close()
    expect ValueError:
      options.setBallparkAllowed(false)

  test "CRS database lists and matches are copied":
    check "EPSG" in crsAuthorities()
    let info = crsInfo("EPSG")
    check info.len > 100
    var found = false
    for item in info:
      if item.code == "4326" and item.authority == "EPSG":
        found = true
    check found
    let source = newSpatialReference(4326)
    check crsMatches(source).len > 0
    let options = newCoordinateOptions()
    let operation = newCoordinateOperation(source, newSpatialReference(3857), options)
    var x = 0.0
    var y = 0.0
    var z = 0.0
    operation.transform(x, y, z)
    check abs(x) < 0.000001
    check abs(y) < 0.000001
    operation.close()

  test "dataset field domain mutations copy their input":
    let dataset = createDataset("MEM", "", 0, 0, 0)
    let domain = newGlobDomain("station", "ST-*")
    dataset.add(domain)
    domain.close()
    check dataset.fieldDomainNames == @["station"]
    dataset.deleteFieldDomain("station")
    check dataset.fieldDomainNames.len == 0
    expect IOError:
      dataset.deleteFieldDomain("station")
