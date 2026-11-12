#!/usr/bin/env python3
"""Generate native C-versus-Nim public type layout checks for installed GDAL.

Use the same clang Python environment and GDAL headers as generate_bindings.py.
"""
import argparse
import pathlib
import re
import subprocess
import sys
import tempfile

from clang import cindex as ci
from clang_support import configure_clang
import generate_bindings as bindings


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--include', type=pathlib.Path)
    parser.add_argument('--libclang')
    args = parser.parse_args()
    include = args.include or pathlib.Path(subprocess.check_output(
        ['gdal-config', '--prefix'], text=True).strip()) / 'include'
    configure_clang(args.libclang)
    flags = ['-x', 'c', '-std=c11', '-I' + str(include)]
    if sys.platform == 'darwin':
        flags += ['-isysroot', subprocess.check_output(['xcrun', '--show-sdk-path'], text=True).strip()]
    with tempfile.TemporaryDirectory(prefix='ngis-abi-') as tmp:
        source = pathlib.Path(tmp) / 'public.h'
        source.write_text(''.join('#include "' + h + '"\n' for h in bindings.HEADERS))
        tu = ci.Index.create().parse(str(source), args=flags)
        errors = [str(d) for d in tu.diagnostics if d.severity >= ci.Diagnostic.Error]
        if errors:
            raise RuntimeError('\n'.join(errors))
        def public(node):
            return node.location.file and pathlib.Path(node.location.file.name).parent.resolve() == include.resolve() and pathlib.Path(node.location.file.name).name in bindings.HEADERS
        nodes = [n for n in tu.cursor.get_children() if public(n)]
        binding_text = (bindings.ROOT / 'src/ngis/gdal/bindings.nim').read_text()
        binding_text += '\n' + (bindings.ROOT / 'src/ngis/gdal/systemtypes.nim').read_text()
        nim_types = set(re.findall(r'^(?:\s{2,}|type )(\w+)\*(?:\s|\{|=)', binding_text, re.M))
        incomplete = set(re.findall(r'^(?:  |type )(\w+)\* \{\.[^\n]*incompleteStruct', binding_text, re.M))
        aliases = dict(re.findall(r'^(?:  |type )(\w+)\* = (\w+)\s*$', binding_text, re.M))
        while True:
            new = {name for name, target in aliases.items() if target in incomplete}
            if new <= incomplete:
                break
            incomplete.update(new)
        checks = []
        seen = set()
        skipped_concrete = set()
        def add(label, c_expr, nim_expr):
            if label not in seen:
                seen.add(label)
                checks.append((label, c_expr, nim_expr))
        def fields(node, c_type, nim_type, path='', nim_path=''):
            # System structs are imported by name without exposing their fields.
            if not public(node):
                return
            for field in node.get_children():
                if field.kind != ci.CursorKind.FIELD_DECL or not field.spelling or field.is_bitfield():
                    continue
                field_name = field.spelling
                path2 = path + '.' + field_name if path else field_name
                # Obtain nested Nim type from the actual field, including anonymous unions.
                nim_expr = nim_path + '.' + bindings.identifier(field_name)
                add(c_type + '.' + path2,
                    'offsetof(' + c_type + ', ' + path2 + ')',
                    'cast[int](unsafeAddr ' + nim_expr + ') - cast[int](addr value)')
                canonical = field.type.get_canonical()
                if canonical.kind == ci.TypeKind.RECORD:
                    declaration = canonical.get_declaration()
                    if declaration.is_definition():
                        fields(declaration, c_type, nim_type, path2, nim_expr)
        for n in nodes:
            if (n.kind == ci.CursorKind.TYPEDEF_DECL and n.spelling in incomplete
                    and n.type.get_size() >= 0):
                skipped_concrete.add(n.spelling)
            if n.kind != ci.CursorKind.TYPEDEF_DECL or n.spelling not in nim_types or n.spelling in incomplete:
                continue
            if n.type.get_size() < 0:
                continue
            name = n.spelling
            add(name, 'sizeof(' + name + ')', 'sizeof(' + bindings.identifier(name) + ')')
            canonical = n.underlying_typedef_type.get_canonical()
            if canonical.kind == ci.TypeKind.RECORD:
                declaration = canonical.get_declaration()
                if declaration.is_definition():
                    fields(declaration, name, bindings.identifier(name), nim_path='value')
        # Tagged public records need not have a typedef.
        typedef_names = {n.spelling for n in nodes if n.kind == ci.CursorKind.TYPEDEF_DECL}
        for n in nodes:
            if n.kind not in (ci.CursorKind.STRUCT_DECL, ci.CursorKind.UNION_DECL) or not n.is_definition() or not n.spelling:
                continue
            name = ('C' + n.spelling) if n.spelling.startswith('_') else n.spelling
            if n.spelling in typedef_names:
                continue
            if name not in nim_types or name in incomplete or n.type.get_size() < 0:
                continue
            c_type = ('union ' if n.kind == ci.CursorKind.UNION_DECL else 'struct ') + n.spelling
            add(name, 'sizeof(' + c_type + ')', 'sizeof(' + bindings.identifier(name) + ')')
            fields(n, c_type, bindings.identifier(name), nim_path='value')
        lines = ['## Generated by scripts/generate_abi_test.py; do not edit.',
                 'import std/[strutils, unittest]', 'import ngis/gdal', '',
                 'when not defined(windows):',
                 '  const gdalCflags = staticExec("gdal-config --cflags").strip',
                 '  {.passC: gdalCflags.}', '', '{.emit: """', '#include <stddef.h>']
        lines += ['#include <' + h + '>' for h in bindings.HEADERS]
        lines += ['size_t ngis_abi_value(int i) {', '  static const size_t values[] = {']
        lines += ['    ' + c + ',' for _, c, _ in checks]
        lines += ['  };', '  return values[i];', '}', '""".}', '',
                  'proc cAbiValue(index: cint): csize_t {.importc: "ngis_abi_value", nodecl.}', '',
                  'suite "generated GDAL ABI":', '  test "public type sizes and field offsets":']
        # Every offset expression needs a variable of its corresponding parent type.
        for i, (label, _, nim_expr) in enumerate(checks):
            if nim_expr.startswith('cast[int]'):
                parent = label.split('.')[0]
                # Tagged records have a separate C spelling in label.
                nim_parent = parent.removeprefix('struct ').removeprefix('union ')
                if nim_parent.startswith('_'): nim_parent = 'C' + nim_parent
                lines += ['    block:', '      var value: ' + bindings.identifier(nim_parent),
                          '      checkpoint "' + label + '"',
                          '      check ' + nim_expr + ' == int(cAbiValue(' + str(i) + '))']
            else:
                lines += ['    checkpoint "' + label + '"',
                          '    check ' + nim_expr + ' == int(cAbiValue(' + str(i) + '))']
        dest = bindings.ROOT / 'tests/tgdal_generated_abi.nim'
        dest.write_text('\n'.join(lines) + '\n')
        print(f'{len(checks)} size/offset checks generated')
        if skipped_concrete:
            raise SystemExit('Concrete types missing from bindings: ' + ', '.join(sorted(skipped_concrete)))


if __name__ == '__main__':
    main()
