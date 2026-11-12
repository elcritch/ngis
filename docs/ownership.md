# Ownership and lifetimes

The Nim wrappers manage native handles automatically. Most owners share their native resource when copied; `close` releases it once and invalidates all aliases of that owner. Repeated closes are harmless. Use `close` for deterministic release, or let the last owner release the resource. Check each module's API for the few wrappers with different contracts.

A `rawHandle` is borrowed: keep the corresponding owner alive and open while using it, and do not free or retain it beyond that lifetime. An `adopt` factory takes ownership of an independently owned handle and will call its matching GDAL release function. Do not adopt borrowed handles or adopt the same handle twice. The raw C API retains GDAL's original ownership contracts.

Bands and layers borrow their dataset: closing the dataset invalidates those views. XML nodes retain their tree but become invalid when it closes or a tree mutation invalidates nodes; reacquire them after mutation. Algorithm arguments retain their algorithm, and dataset-value views retain their argument; closing a parent invalidates the dependent views. Approximate transformers retain their base and stop working if it is closed.

Some results own independent native references or clones. SQL result layers retain a native dataset reference until the result is released. Multidimensional groups, arrays, dimensions and attributes retain the native dataset independently, so they can remain usable after the original dataset wrapper closes. Returned CRS matches and database records are copied; prepared geometries clone their source geometry. Color tables and raster attribute tables returned by their accessors are independent clones. See the individual API docs for other copy and borrowing behavior.

The convenience warp and pansharpen constructors retain independent references to their input datasets. When configuring `WarpOptions` or `PansharpenOptions` through `rawHandle`, the caller must keep any externally installed datasets, transformers, callbacks, and other pointed-to data alive for the operation. `newImageTransformer` retains the input datasets. Native callback functions and userdata supplied to progress, filesystem, thread, or other raw interfaces must stay valid for as long as GDAL can call them; thread callbacks must follow the native calling convention and threading rules.

`Process` waits for its child when the last owner is released. Close the input pipe and drain output and error pipes before waiting or releasing the final owner, so a child blocked on a full pipe can finish. A newly created `Driver` is owned until `register` transfers it to GDAL's global registry; registered `DriverInfo` is borrowed until registry shutdown.

Owners and native resources do not add automatic synchronization. Coordinate access and mutation across threads in the caller. GNM network operations require a GDAL build with GNM enabled.
