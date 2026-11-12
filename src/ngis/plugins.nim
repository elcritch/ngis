## Owns the callback table used to configure a VSI filesystem plugin.
## Callback functions and userdata must remain valid while a handler uses them.
import ./gdal
import ./private/resources

type FilesystemCallbacks* = object
  resource: NativeResource[ptr VSIFilesystemPluginCallbacksStruct]

proc newFilesystemCallbacks*(): FilesystemCallbacks =
  FilesystemCallbacks(
    resource: newNativeResource(
      VSIAllocFilesystemPluginCallbacksStruct(),
      proc(p: ptr VSIFilesystemPluginCallbacksStruct) {.raises: [].} =
        VSIFreeFilesystemPluginCallbacksStruct(p),
    )
  )

proc rawHandle*(
    callbacks: FilesystemCallbacks
): ptr VSIFilesystemPluginCallbacksStruct =
  callbacks.resource.rawHandle

proc close*(callbacks: FilesystemCallbacks) =
  close(callbacks.resource)
