# GDAL bindings and verification

The generated raw bindings target GDAL **3.13.3** public C headers. `src/ngis/gdal/bindings.json` records the header hashes, functions, and coverage; `header_inventory.json` records the disposition of installed headers, including C++ and internal/plugin headers outside the raw C API. `macro_inventory.json` records macro coverage. The C++ API is outside this binding. Some declared C entry points, including optional drivers and features, are not exported by every GDAL build.

The independent function audit compares the generated declarations against Clang's C and C++ header ASTs. It checks C linkage, legacy symbol mappings, parameter and return shapes, scalar width and signedness, array-to-pointer parameter decay, callback shapes and convention markers, and varargs. The current manifest has 2,257 C functions, 5,118 parameters and 56 callback types. The four C++-linkage functions found in C-readable headers are excluded from raw C imports. This audit uses the host ABI and does not establish availability of every optional symbol in a particular GDAL binary. Generated ABI tests separately check structure layout; runtime tests exercise representative calls, callbacks and pointer arrays.

Install Python `clang==18.1.8` and a recent libclang (16 or later), then use the pinned GDAL headers. Older Clang releases may not parse GDAL's C++ float16 helpers used by the linkage audit. Pass `--include` when they are not under the `gdal-config` prefix. The Clang-based scripts accept `--libclang` when libclang cannot be discovered. In a shared conda include directory, header inventory uses package file ownership to exclude dependencies' headers; unavailable C++-only headers are optional.

Regenerate and check with:

```sh
python3 -m pip install clang==18.1.8
python3 scripts/generate_bindings.py --include "$(gdal-config --prefix)/include"
python3 scripts/generate_abi_test.py --include "$(gdal-config --prefix)/include"
python3 scripts/gdal_macros.py --include "$(gdal-config --prefix)/include"
python3 scripts/audit_headers.py --include "$(gdal-config --prefix)/include"
python3 scripts/check_function_abi.py --include "$(gdal-config --prefix)/include"
nph src/ngis/gdal/bindings.nim tests/tgdal_generated_abi.nim
atlas-run tests
atlas-run tests --compile-only examples/all_compile.nim
```

The function checker's `--bindings` option can compare an alternate generated Nim file without changing the manifest. Regenerate and review the inventories and ABI tests together when deliberately updating the pinned GDAL version.
