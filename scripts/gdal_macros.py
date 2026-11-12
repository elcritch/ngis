#!/usr/bin/env python3
"""Inventory function-like macro definitions, including inactive branches.

Reads the generated header list; defaults to gdal-config's include directory.
The unimplemented category is intentionally explicit and requires review.
"""
import argparse
import json
import re
import subprocess
from collections import defaultdict
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument('--include', type=Path)
parser.add_argument('--output', type=Path, default=Path('src/ngis/gdal/macro_inventory.json'))
args = parser.parse_args()
include = args.include
if include is None:
    flags = subprocess.check_output(['gdal-config', '--cflags'], text=True).split()
    include = Path(next(flag[2:] for flag in flags if flag.startswith('-I')))
manifest = json.loads(Path('src/ngis/gdal/bindings.json').read_text())
source = Path('src/ngis/gdal/macros.nim').read_text()
implemented = set(re.findall(r'(?m)^\s*(?:proc|func|template)\s+(\w+)\*', source))
# Each exclusion is reviewed individually; new names must fail the inventory gate.
annotations = {
    'CPL_PRINT_FUNC_FORMAT', 'CPL_SCAN_FUNC_FORMAT', 'CPL_FORMAT_STRING',
    'CPL_SCANF_FORMAT_STRING', 'CPL_STATIC_ASSERT', 'CPL_STATIC_ASSERT_IF_AVAILABLE',
    'CPL_WARN_DEPRECATED', 'CPL_DISALLOW_COPY_ASSIGN', 'CPL_REINTERPRET_CAST',
    'CPL_STATIC_CAST', 'CPL_UNLIKELY', 'UNREFERENCED_PARAM', '__has_attribute',
}
control_flow = {'OGR_FOR_EACH_FEATURE_BEGIN', 'OGR_FOR_EACH_FEATURE_END',
                'VALIDATE_POINTER0', 'VALIDATE_POINTER1'}
internal = {
    'CPLDebugOnce', 'CPLErrorOnce', 'VSIDebug1', 'VSIDebug2', 'VSIDebug3', 'VSIDebug4',
    'CPLLockHolderD', 'CPLLockHolderOptionalLockD', 'CPLMutexHolderD',
    'CPLMutexHolderExD', 'CPLMutexHolderOptionalLockD', 'GDAL_DEFINE_ARITHOP',
    'GDAL_DEFINE_COMPARISON', 'GDAL_DEFINE_CONVERSION', 'SRCVAL',
    'DB2_V72_FIX_BYTE_ORDER', 'DB2_V72_UNFIX_BYTE_ORDER',
}
# These are exported functions when the special WITHOUT_CPLDEBUG switch is absent.
native_functions = {'CPLDebug', 'CPLDebugProgress'}
macros = defaultdict(set)
for header in manifest['headers']:
    path = include / header
    if not path.exists():
        continue
    for name in re.findall(r'(?m)^\s*#\s*define\s+([A-Za-z_]\w*)\(', path.read_text(errors='replace')):
        macros[name].add(header)
items = {}
for name, headers in sorted(macros.items()):
    category = ('implemented' if name in implemented else
                'native_function' if name in native_functions else
                'compiler_annotation_or_cast' if name in annotations else
                'control_flow' if name in control_flow else
                'cpp_or_internal' if name in internal else 'unimplemented')
    items[name] = {'category': category, 'headers': sorted(headers)}
result = {'scope': 'Function-like definitions in listed headers, including inactive preprocessor branches; object-like macros are in bindings.json.', 'macros': items}
args.output.write_text(json.dumps(result, indent=2) + '\n')
from collections import Counter
print(dict(Counter(item['category'] for item in items.values())))
print('Unimplemented:', ', '.join(name for name, item in items.items() if item['category'] == 'unimplemented'))

if any(item['category'] == 'unimplemented' for item in items.values()):
    raise SystemExit(1)
