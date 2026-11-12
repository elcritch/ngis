## Shared ownership for native handles used by the public subsystem wrappers.
type
  ReleaseProc*[T] = proc(handle: T) {.nimcall, raises: [].}
  NativePayload[T] = object
    handle: T
    release: ReleaseProc[T]

proc `=destroy`[T](payload: NativePayload[T]) =
  if payload.handle != default(T) and payload.release != nil:
    payload.release(payload.handle)

proc `=copy`[T](target: var NativePayload[T], source: NativePayload[T]) {.error.}
proc `=dup`[T](source: NativePayload[T]): NativePayload[T] {.error.}

type NativeResource*[T] = ref object
  payload: NativePayload[T]

proc newNativeResource*[T](handle: T, release: ReleaseProc[T]): NativeResource[T] =
  ## Takes ownership. The native release function must accept this handle.
  if handle == default(T):
    raise newException(IOError, "could not create native resource")
  if release == nil:
    raise newException(ValueError, "native resource needs a release function")
  NativeResource[T](payload: NativePayload[T](handle: handle, release: release))

proc isClosed*[T](resource: NativeResource[T]): bool =
  resource == nil or resource.payload.handle == default(T)

proc rawHandle*[T](resource: NativeResource[T]): T =
  ## Borrows a handle while its shared owner remains open.
  if resource.isClosed:
    raise newException(ValueError, "native resource is closed")
  resource.payload.handle

proc close*[T](resource: NativeResource[T]) =
  ## Releases once and invalidates all aliases of this resource.
  if not resource.isClosed:
    let handle = resource.payload.handle
    resource.payload.handle = default(T)
    resource.payload.release(handle)

proc takeHandle*[T](resource: NativeResource[T]): T =
  ## Transfers ownership out, invalidating aliases without releasing the handle.
  result = resource.rawHandle
  resource.payload.handle = default(T)

proc validateCString*(value, description: string) =
  if '\0' in value:
    raise newException(ValueError, description & " contains a NUL byte")

proc copyStrings*(values: cstringArray): seq[string] =
  ## Copies a borrowed null-terminated C string list without taking ownership.
  if values != nil:
    var i = 0
    while values[i] != nil:
      result.add $values[i]
      inc i
