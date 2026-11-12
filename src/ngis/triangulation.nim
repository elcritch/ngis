## Owning triangulation resources.
import ./[gdal, datasets]
import ./private/resources

type Triangulation* = object
  resource: NativeResource[ptr GDALTriangulation]

template access(T, H: typedesc) =
  proc rawHandle*(value: T): H =
    value.resource.rawHandle

  proc close*(value: T) =
    value.resource.close()

access(Triangulation, ptr GDALTriangulation)

proc triangulationAvailable*(): bool =
  GDALHasTriangulation() != 0

proc newTriangulation*(x, y: openArray[float64]): Triangulation =
  if x.len != y.len or x.len < 3 or x.len > high(cint).int:
    raise newException(ValueError, "invalid triangulation coordinates")
  let h = GDALTriangulationCreateDelaunay(cint(x.len), unsafeAddr x[0], unsafeAddr y[0])
  if h == nil:
    raise gdalError("could not triangulate points")
  result.resource = newNativeResource(
    h,
    proc(p: ptr GDALTriangulation) {.nimcall, raises: [].} =
      GDALTriangulationFree(p),
  )
  if GDALTriangulationComputeBarycentricCoefficients(
    h, unsafeAddr x[0], unsafeAddr y[0]
  ) == 0:
    result.close()
    raise gdalError("could not compute barycentric coefficients")

proc findFacet*(tri: Triangulation, x, y: float64): int =
  var facet: cint
  if GDALTriangulationFindFacetBruteForce(tri.rawHandle, x, y, addr facet) == 0:
    return -1
  int(facet)

proc barycentric*(tri: Triangulation, facet: int, x, y: float64): array[3, float64] =
  if facet < 0 or facet >= int(tri.rawHandle.nFacets):
    raise newException(ValueError, "facet index out of range")
  if GDALTriangulationComputeBarycentricCoordinates(
    tri.rawHandle, cint(facet), x, y, addr result[0], addr result[1], addr result[2]
  ) == 0:
    raise gdalError("could not calculate barycentric coordinates")
