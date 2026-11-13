## Geographic Network Model datasets and result layers.
import ./[api, datasets, vectorextras]
import ./private/resources

type Network* = ref object
  dataset: Dataset

proc driverAvailable*(): bool =
  GDALAllRegister()
  GDALGetDriverByName("GNMFile") != nil

proc createNetwork*(path: string, options: openArray[string]): Network =
  if not driverAvailable():
    raise newException(IOError, "GDAL GNMFile driver is unavailable")
  Network(dataset: createDataset("GNMFile", path, 0, 0, 0, GDT_Unknown, options))

proc openNetwork*(path: string, update = false): Network =
  validateCString(path, "network path")
  if not driverAvailable():
    raise newException(IOError, "GDAL GNMFile driver is unavailable")
  let flags =
    cuint(GDAL_OF_GNM) or
    (if update: cuint(GDAL_OF_UPDATE) else: cuint(GDAL_OF_READONLY))
  Network(dataset: wrapDataset(GDALOpenEx(path.cstring, flags, nil, nil, nil)))

proc dataset*(network: Network): Dataset =
  if network == nil:
    raise newException(ValueError, "network is closed")
  discard network.dataset.rawHandle
  network.dataset

proc rawHandle*(network: Network): GNMNetworkH =
  cast[GNMNetworkH](network.dataset.rawHandle)

proc close*(network: Network) =
  if network != nil:
    network.dataset.close()

proc name*(network: Network): string =
  $GNMGetName(network.rawHandle)

proc version*(network: Network): int =
  int(GNMGetVersion(network.rawHandle))

proc connect*(
    network: Network,
    source, target, connector: int64,
    cost, reverseCost: float64,
    direction: GNMDirection,
) =
  if GNMConnectFeatures(
    cast[GNMGenericNetworkH](network.rawHandle),
    source,
    target,
    connector,
    cost,
    reverseCost,
    direction,
  ) != CE_None:
    raise gdalError("could not connect network features")

proc disconnect*(network: Network, source, target, connector: int64) =
  if GNMDisconnectFeatures(
    cast[GNMGenericNetworkH](network.rawHandle), source, target, connector
  ) != CE_None:
    raise gdalError("could not disconnect network features")

proc disconnectAll*(network: Network) =
  if GNMDisconnectAll(network.rawHandle) != CE_None:
    raise gdalError("could not disconnect network")

proc path*(
    network: Network,
    source, target: int64,
    algorithm: GNMGraphAlgorithmType = GATDijkstraShortestPath,
): SqlResult =
  let h = GNMGetPath(network.rawHandle, source, target, algorithm, nil)
  adoptResultSet(network.dataset, h)
