import ngis/mapprojection

import std/[math, unittest]

suite "Shared field projections, native and JS":
  test "field local metres round trip and preserve zero":
    let projection = initLocalProjection(GeoPoint(lat: 42, lon: -93))
    let point = GeoPoint(lat: 42.001, lon: -92.999)
    let restored = projection.unproject(projection.project(point))
    check abs(restored.lat - point.lat) < 1e-10
    check abs(restored.lon - point.lon) < 1e-10
    check projection.project(GeoPoint(lat: 42, lon: -93)) == Coordinate(x: 0, y: 0)
  test "Mercator round trip retains field precision":
    let point = GeoPoint(lat: 42.000001, lon: -93.000001)
    let restored = fromWebMercator(webMercator(point))
    check abs(restored.lat - point.lat) < 1e-10
    check abs(restored.lon - point.lon) < 1e-10
  test "antimeridian coordinates stay adjacent":
    let p = initLocalProjection(GeoPoint(lat: 42, lon: 179.999))
    check abs(p.project(GeoPoint(lat: 42, lon: -179.999)).x) < 200
    let world = webMercator(GeoPoint(lat: 42, lon: -179.999), 179.999)
    check world.x > 1
    check abs(fromWebMercator(world).lon - 180.001) < 1e-9

  test "wrapped Mercator origins preserve their chosen world":
    let point = GeoPoint(lat: 42, lon: -1)
    for (origin, longitude) in [
      (-540.0, -361.0), (-180.0, -1.0), (180.0, 359.0), (540.0, 719.0)
    ]:
      let world = webMercator(point, origin)
      let restored = fromWebMercator(world)
      check abs(restored.lon - longitude) < 1e-10
      check abs(restored.lat - point.lat) < 1e-10
    check fromWebMercator(Coordinate(x: 2.5, y: 0.5)).lon == 720
    check fromWebMercator(Coordinate(y: 0)).lat > 85
    check fromWebMercator(Coordinate(y: 1)).lat < -85

  test "longitude deltas have a consistent half-open interval":
    check longitudeDelta(-179, 179) == 2
    check longitudeDelta(179, -179) == -2
    check longitudeDelta(180, 0) == -180
    check longitudeDelta(-180, 0) == -180
    check longitudeDelta(540, -540) == 0

  test "invalid geography and uninitialized projections reject":
    expect ValueError:
      discard initLocalProjection(GeoPoint(lat: 90))
    expect ValueError:
      discard webMercator(GeoPoint(lat: NaN))
    expect ValueError:
      discard LocalProjection().unproject(Coordinate())
    expect ValueError:
      discard LocalProjection().project(GeoPoint(lon: 1))
    expect ValueError:
      discard fromWebMercator(Coordinate(y: Inf))
    for point in [
      GeoPoint(lat: 85),
      GeoPoint(lat: -85),
      GeoPoint(lon: 181),
      GeoPoint(lat: Inf),
      GeoPoint(lon: NaN),
    ]:
      expect ValueError:
        discard initLocalProjection(point)
      expect ValueError:
        discard webMercator(point)
    for origin in [NaN, Inf, -541.0, 541.0]:
      expect ValueError:
        discard webMercator(GeoPoint(), origin)
      expect ValueError:
        discard longitudeDelta(0, origin)
    for point in [
      Coordinate(x: NaN),
      Coordinate(x: 1e308),
      Coordinate(y: -0.01),
      Coordinate(y: 1.01),
    ]:
      expect ValueError:
        discard fromWebMercator(point)
