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
annotations = re.compile(r'^(?:CPL_(?:PRINT_FUNC_FORMAT|SCAN_FUNC_FORMAT|FORMAT_STRING|SCANF_FORMAT_STRING|STATIC_ASSERT.*|WARN_DEPRECATED|DISALLOW_COPY_ASSIGN|REINTERPRET_CAST|STATIC_CAST|UNLIKELY)|UNREFERENCED_PARAM|__has_attribute)$')
idioms = re.compile(r'^(?:OGR_FOR_EACH_FEATURE_(?:BEGIN|END)|CPL_ARRAYSIZE|CPLAssert(?:AlwaysEval)?|VALIDATE_POINTER[01]|CPLDebug.*|CPLErrorOnce|VSIDebug[1-4])$')
cpp = re.compile(r'^(?:GDAL_DEFINE_.*|SRCVAL|DB2_V72_.*|CPL(?:Lock|Mutex)Holder.*)$')
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
                'compiler_annotation_or_cast' if annotations.match(name) else
                'nim_idiom_or_control_flow' if idioms.match(name) else
                'cpp_or_internal' if cpp.match(name) else 'unimplemented')
    items[name] = {'category': category, 'headers': sorted(headers)}
result = {'scope': 'Function-like definitions in listed headers, including inactive preprocessor branches; object-like macros are in bindings.json.', 'macros': items}
args.output.write_text(json.dumps(result, indent=2) + '\n')
from collections import Counter
print(dict(Counter(item['category'] for item in items.values())))
print('Unimplemented:', ', '.join(name for name, item in items.items() if item['category'] == 'unimplemented'))
