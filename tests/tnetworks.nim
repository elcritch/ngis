import std/[unittest, tempfiles, os]
import ngis/gdal/networks

suite "geographic networks":
  test "create and open a network when GNM is available":
    if not driverAvailable():
      skip()
    else:
      let dir = createTempDir("ngis-gnm-", "")
      defer:
        removeDir(dir)
      let network = createNetwork(
        dir, ["net_name=test", "net_srs=EPSG:4326", "FORMAT=ESRI Shapefile"]
      )
      check network.name == "test"
      check network.version > 0
      network.disconnectAll()
      network.close()
      let reopened = openNetwork(dir / "test")
      check reopened.name == "test"
      reopened.close()
