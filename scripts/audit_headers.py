#!/usr/bin/env python3
"""Audit installed GDAL headers against the reviewed header and function inventory.

Requires the same libclang Python package and GDAL development headers as
scripts/generate_bindings.py. This checks active platform declarations, not APIs
hidden by platform-dependent preprocessor branches.
"""
import argparse
import hashlib
import json
import pathlib
import re
import subprocess
import sys
import tempfile

from clang import cindex as ci
from clang_support import configure_clang, installed_headers

ROOT = pathlib.Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--include', type=pathlib.Path)
    parser.add_argument('--libclang')
    args = parser.parse_args()
    include = (args.include or pathlib.Path(subprocess.check_output(
        ['gdal-config', '--prefix'], text=True).strip()) / 'include').resolve()
    inventory = json.loads((ROOT / 'src/ngis/gdal/header_inventory.json').read_text())
    bindings = json.loads((ROOT / 'src/ngis/gdal/bindings.json').read_text())
    headers = inventory['headers']
    actual = installed_headers(include)
    problems = []
    for name in sorted(actual - headers.keys()):
        problems.append(f'unreviewed header: {name}')
    for name in sorted(headers.keys() - actual):
        if headers[name]['category'] == 'public_c':
            problems.append(f'public C header missing: {name}')
    public = {name for name, info in headers.items() if info['category'] == 'public_c'}
    if public != set(bindings['headers']):
        problems.append('public C header inventory differs from generated header list')
    for name, expected in bindings['header_sha256'].items():
        if name in actual and hashlib.sha256((include / name).read_bytes()).hexdigest() != expected:
            problems.append(f'public header changed since generation: {name}')
    if inventory['gdal_version'] != bindings['gdal_version']:
        problems.append('header inventory and generated GDAL versions differ')
    for name, info in headers.items():
        if not info.get('reason') or info['category'] not in {'public_c', 'cpp', 'cpp_internal', 'configuration', 'private'}:
            problems.append(f'header needs classification and rationale: {name}')
    if problems:
        print('\n'.join(problems), file=sys.stderr)
        return 1
    configure_clang(args.libclang)
    flags = ['-I' + str(include)]
    if sys.platform == 'darwin':
        flags += ['-isysroot', subprocess.check_output(['xcrun', '--show-sdk-path'], text=True).strip()]
    source = ''.join(f'#include "{h}"\n' for h in sorted(public))
    index = ci.Index.create()
    with tempfile.TemporaryDirectory(prefix='ngis-header-audit-') as tmp:
        path = pathlib.Path(tmp) / 'audit.h'
        path.write_text(source)
        units = []
        for language, standard in [('c', 'c11'), ('c++', 'c++17')]:
            unit = index.parse(str(path), args=['-x', language, '-std=' + standard] + flags)
            errors = [str(d) for d in unit.diagnostics if d.severity >= ci.Diagnostic.Error]
            if errors:
                problems.extend(f'{language}: {error}' for error in errors)
            units.append(unit)
        if problems:
            print('\n'.join(problems), file=sys.stderr)
            return 1
        def walk(node):
            for child in node.get_children():
                yield child
                if child.kind in (ci.CursorKind.LINKAGE_SPEC, ci.CursorKind.UNEXPOSED_DECL):
                    yield from walk(child)
        def funcs(unit):
            return {n.spelling: n for n in walk(unit.cursor)
                    if n.kind == ci.CursorKind.FUNCTION_DECL and n.location.file
                    and pathlib.Path(n.location.file.name).name in public
                    and n.storage_class != ci.StorageClass.STATIC}
        cfuncs = funcs(units[0])
        cppfuncs = {n.spelling: n for n in walk(units[1].cursor)
                    if n.kind == ci.CursorKind.FUNCTION_DECL
                    and n.mangled_name in (n.spelling, '_' + n.spelling)}
        # C++ linkage discriminates declarations exposed only by GDAL's C-mode
        # opaque aliases from its actual extern-C API.
        eligible = {name: n for name, n in cfuncs.items() if name in cppfuncs
                    and cppfuncs[name].mangled_name in (name, '_' + name)}
        # Check exported type aliases and enum members as well as functions. Nim
        # identifiers normalize underscores and case after the initial letter.
        def key(name):
            return name[:1] + name[1:].replace('_', '').lower()
        nim = (ROOT / 'src/ngis/gdal/bindings.nim').read_text() + (ROOT / 'src/ngis/gdal/macros.nim').read_text() + (ROOT / 'src/ngis/gdal/systemtypes.nim').read_text()
        exports = {key(name) for name in re.findall(r'\b([A-Za-z][A-Za-z0-9_]*)\*', nim)}
        for node in walk(units[0].cursor):
            if not node.location.file or pathlib.Path(node.location.file.name).name not in public:
                continue
            candidates = []
            if node.kind == ci.CursorKind.TYPEDEF_DECL:
                candidates.append(('type', node.spelling))
            if node.kind == ci.CursorKind.ENUM_DECL:
                candidates.extend(('constant', child.spelling) for child in node.get_children()
                                  if child.kind == ci.CursorKind.ENUM_CONSTANT_DECL)
            for kind, name in candidates:
                normalized = ('c' + name) if name.startswith('_') else name
                if normalized and key(normalized) not in exports:
                    problems.append(f'missing {kind} {name}: {node.location.file.name}')
        cpp_only = {'CPLGreatestCommonDivisor', 'CPLParseRFC822DateTime',
                    'CPLUnixTimeToYMDHMS', 'CPLYMDHMSToUnixTime'}
        for name in sorted(cfuncs.keys() - eligible.keys() - cpp_only):
            problems.append(f'C declaration lacks C linkage in C++: {name}')
        missing = eligible.keys() - bindings['functions'].keys()
        for name in sorted(missing):
            problems.append(f'missing function {name}: {eligible[name].location.file.name}')
    if problems:
        print('\n'.join(problems), file=sys.stderr)
        return 1
    print(f'Checked {len(headers)} reviewed headers and {len(eligible)} active C functions')
    return 0


if __name__ == '__main__':
    sys.exit(main())
