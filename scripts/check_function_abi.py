#!/usr/bin/env python3
"""Audit function coverage and linkage against the installed GDAL headers.

Requires the clang Python bindings and a compatible libclang. Parses the headers
independently as C and C++; a declaration that is C++-mangled cannot be loaded
using a C symbol name. Compares all callable parameter/return shapes, scalar
widths, pointer depth, array decay, callback signatures and calling-convention
markers. It does not prove structure layout or per-build symbol availability.
"""
import argparse
import ctypes
import json
import pathlib
import re
import subprocess
import sys
import tempfile

from clang import cindex as clang
from clang_support import configure_clang

ROOT = pathlib.Path(__file__).resolve().parents[1]
LEGACY = {
    "RPCInfoV1ToMD": "RPCInfoToMD",
    "GDALCreateRPCTransformerV1": "GDALCreateRPCTransformer",
    "GDALExtractRPCInfoV1": "GDALExtractRPCInfo",
}


def declarations(tu, include):
    result = {}

    def visit(node):
        kind = node._kind_id
        if kind == clang.CursorKind.FUNCTION_DECL.value:
            if (node.location.file and
                pathlib.Path(node.location.file.name).parent.resolve() == include and
                node.storage_class != clang.StorageClass.STATIC):
                result.setdefault(node.spelling, set()).add(node.mangled_name)
        elif kind in (clang.CursorKind.TRANSLATION_UNIT.value,
                      clang.CursorKind.LINKAGE_SPEC.value,
                      clang.CursorKind.NAMESPACE.value):
            for child in node.get_children():
                visit(child)

    visit(tu.cursor)
    return result


def top_split(text, delimiter=","):
    """Split only outside Nim parentheses, brackets, and pragma blocks."""
    result, stack, start = [], [], 0
    matching = {')': '(', ']': '[', '}': '{'}
    for i, char in enumerate(text):
        if char in '([{':
            stack.append(char)
        elif char in ')]}':
            if not stack or stack.pop() != matching[char]:
                raise ValueError(f"unbalanced Nim signature: {text}")
        elif char == delimiter and not stack:
            result.append(text[start:i].strip())
            start = i + 1
    result.append(text[start:].strip())
    return [item for item in result if item]


def close_paren(text, start):
    depth = 0
    for index in range(start, len(text)):
        if text[index] == '(':
            depth += 1
        elif text[index] == ')':
            depth -= 1
            if depth == 0:
                return index
    raise ValueError("unbalanced proc declaration")


def nim_proc(text):
    """Return the parameter types, return type, and pragmas of a Nim proc type."""
    opening = text.index('(')
    end = close_paren(text, opening)
    args = []
    for part in top_split(text[opening + 1:end]):
        if ':' not in part:
            raise ValueError(f"unsupported Nim formal parameter {part!r}")
        args.append(part.split(':', 1)[1].strip())
    tail = text[end + 1:]
    pragma = tail.find('{.')
    if pragma < 0:
        raise ValueError("missing proc pragma")
    ret = tail[:pragma].strip()
    if ret.startswith(':'):
        ret = ret[1:].strip()
    elif ret:
        raise ValueError(f"unsupported return type: {ret}")
    return args, ret or 'void', tail[pragma:tail.find('.}', pragma) + 2]


def nim_functions(source):
    found = {}
    pattern = re.compile(r'^[ \t]*proc\s+(`?\w+`?)\*\s*\(', re.M)
    for match in pattern.finditer(source):
        name = match.group(1).strip('`')
        end = close_paren(source, match.end() - 1)
        pragma = source.find('{.', end)
        pragma_end = source.find('.}', pragma)
        if pragma < 0 or pragma_end < 0:
            raise ValueError(f"missing pragma for {name}")
        found[name] = nim_proc(source[match.start():pragma_end + 2])
    return found


def c_nodes(tu, include):
    functions, aliases, alias_nodes = {}, {}, {}
    def visit(node):
        kind = node._kind_id
        if kind == clang.CursorKind.TYPEDEF_DECL.value:
            aliases[node.spelling] = node.underlying_typedef_type
            alias_nodes[node.spelling] = node
        elif kind == clang.CursorKind.FUNCTION_DECL.value:
            if (node.location.file and pathlib.Path(node.location.file.name).parent.resolve() == include
                    and node.storage_class != clang.StorageClass.STATIC):
                functions[node.spelling] = node
        elif kind in (clang.CursorKind.TRANSLATION_UNIT.value, clang.CursorKind.LINKAGE_SPEC.value):
            for child in node.get_children():
                visit(child)
    visit(tu.cursor)
    return functions, aliases, alias_nodes


def c_shape(t, formal=False):
    t = t.get_canonical()
    kind = t.kind
    if kind in (clang.TypeKind.CONSTANTARRAY, clang.TypeKind.INCOMPLETEARRAY,
                clang.TypeKind.VARIABLEARRAY):
        if formal:
            return ('ptr', c_shape(t.element_type))
        return ('array', c_shape(t.element_type))
    if kind == clang.TypeKind.POINTER:
        return ('ptr', c_shape(t.get_pointee()))
    if kind in (clang.TypeKind.FUNCTIONPROTO, clang.TypeKind.FUNCTIONNOPROTO):
        params = [] if kind == clang.TypeKind.FUNCTIONNOPROTO else [c_shape(a, True) for a in t.argument_types()]
        return ('fn', tuple(params), c_shape(t.get_result()),
                kind == clang.TypeKind.FUNCTIONPROTO and t.is_function_variadic())
    # Pointer depth, arrays, callback structure and void return are ABI-critical.
    # Scalar base types are checked separately by the generated layout tests.
    if kind == clang.TypeKind.VOID:
        return ('void',)
    if kind == clang.TypeKind.ENUM:
        return c_shape(t.get_declaration().enum_type)
    integer_kinds = {
        clang.TypeKind.CHAR_S: 'char', clang.TypeKind.CHAR_U: 'char',
        clang.TypeKind.SCHAR: 'signed', clang.TypeKind.UCHAR: 'unsigned',
        clang.TypeKind.SHORT: 'signed', clang.TypeKind.USHORT: 'unsigned',
        clang.TypeKind.INT: 'signed', clang.TypeKind.UINT: 'unsigned',
        clang.TypeKind.LONG: 'signed', clang.TypeKind.ULONG: 'unsigned',
        clang.TypeKind.LONGLONG: 'signed', clang.TypeKind.ULONGLONG: 'unsigned',
        clang.TypeKind.BOOL: 'bool',
        clang.TypeKind.FLOAT: 'float', clang.TypeKind.DOUBLE: 'float',
        clang.TypeKind.LONGDOUBLE: 'float',
    }
    if kind in integer_kinds:
        return (integer_kinds[kind], t.get_size())
    return ('value',)


def nim_alias_callbacks(source):
    callbacks = {}
    for match in re.finditer(r'^  (\w+)\*\s*=\s*proc\s*\(', source, re.M):
        opening = source.index('(', match.start())
        end = close_paren(source, opening)
        pragma = source.find('{.', end)
        pragma_end = source.find('.}', pragma)
        if pragma >= 0 and pragma_end >= 0:
            callbacks[match.group(1)] = nim_proc(source[match.start():pragma_end + 2])
    return callbacks


def nim_shape(name, aliases, callbacks, nim_aliases=None, seen=frozenset()):
    if nim_aliases is None: nim_aliases = {}
    name = name.strip()
    if name.startswith('ptr '):
        return ('ptr', nim_shape(name[4:], aliases, callbacks, nim_aliases, seen))
    if name.startswith(('array[', 'UncheckedArray[')):
        return ('array',)  # never acceptable as a C function parameter
    if name in ('cstring', 'pointer'):
        return ('ptr', ('char', 1) if name == 'cstring' else ('void',))
    if name == 'cstringArray':
        return ('ptr', ('ptr', ('char', 1)))
    if name == 'void':
        return ('void',)
    if name.startswith('proc('):
        return ('ptr', nim_callback_shape(nim_proc(name), aliases, callbacks, nim_aliases))
    if name in callbacks:
        return ('ptr', nim_callback_shape(callbacks[name], aliases, callbacks, nim_aliases))
    if name == 'GdalVaList' and 'va_list' in aliases:
        return c_shape(aliases['va_list'], True)
    primitive = {
        'bool': ('bool', 1), 'cchar': ('char', 1),
        'cschar': ('signed', 1), 'int8': ('signed', 1), 'uint8': ('unsigned', 1),
        'cshort': ('signed', ctypes.sizeof(ctypes.c_short)), 'int16': ('signed', 2),
        'cushort': ('unsigned', ctypes.sizeof(ctypes.c_ushort)), 'uint16': ('unsigned', 2),
        'cint': ('signed', ctypes.sizeof(ctypes.c_int)), 'int32': ('signed', 4),
        'cuint': ('unsigned', ctypes.sizeof(ctypes.c_uint)), 'uint32': ('unsigned', 4),
        'clong': ('signed', ctypes.sizeof(ctypes.c_long)),
        'culong': ('unsigned', ctypes.sizeof(ctypes.c_ulong)),
        'clonglong': ('signed', ctypes.sizeof(ctypes.c_longlong)), 'int64': ('signed', 8),
        'culonglong': ('unsigned', ctypes.sizeof(ctypes.c_ulonglong)), 'uint64': ('unsigned', 8),
        'int': ('signed', ctypes.sizeof(ctypes.c_void_p)),
        'uint': ('unsigned', ctypes.sizeof(ctypes.c_void_p)),
        'csize_t': ('unsigned', ctypes.sizeof(ctypes.c_size_t)),
        'cfloat': ('float', ctypes.sizeof(ctypes.c_float)),
        'cdouble': ('float', ctypes.sizeof(ctypes.c_double)),
        'clongdouble': ('float', ctypes.sizeof(ctypes.c_longdouble)),
    }
    if name in primitive:
        return primitive[name]
    if name in nim_aliases and name not in seen:
        return nim_shape(nim_aliases[name], aliases, callbacks, nim_aliases, seen | {name})
    if name in aliases:
        return c_shape(aliases[name])
    return ('value',)


def nim_callback_shape(callback, aliases, callbacks, nim_aliases=None):
    args, ret, pragmas = callback
    return ('fn', tuple(nim_shape(a, aliases, callbacks, nim_aliases) for a in args),
            nim_shape(ret, aliases, callbacks, nim_aliases), 'varargs' in pragmas)


def shape_failures(c_functions, aliases, alias_nodes, nim, source, selected):
    callbacks = nim_alias_callbacks(source)
    nim_aliases = {}
    for match in re.finditer(r'^  (\w+)\*\s*=\s*(?:distinct\s+)?([^\n]+)', source, re.M):
        name, rhs = match.group(1), match.group(2).strip()
        if re.fullmatch(r'(?:ptr\s+)*[A-Za-z][A-Za-z0-9_]*', rhs):
            nim_aliases[name] = rhs
    nim_aliases['CPL_FILE_HANDLE'] = 'pointer' if sys.platform == 'win32' else 'cint'
    nim_aliases['CPL_PID'] = 'cuint' if sys.platform == 'win32' else 'cint'
    failures = []
    checked_params = 0
    for name, callback in callbacks.items():
        if name not in aliases:
            failures.append(f"{name}: callback typedef missing from C headers")
            continue
        expected = c_shape(aliases[name])
        actual = ('ptr', nim_callback_shape(callback, aliases, callbacks, nim_aliases))
        if expected != actual:
            failures.append(f"{name}: callback type mismatch: C {expected}, Nim {actual}")
        tokens = [t.spelling for t in alias_nodes[name].get_tokens()]
        expected_call = 'gdalCall' if 'CPL_STDCALL' in tokens else 'cdecl'
        if expected_call not in callback[2]:
            failures.append(f"{name}: callback requires {expected_call}, got {callback[2]}")
    for name in sorted(selected):
        nim_name = selected[name].get("nim_name", "c" + name if name.startswith("_") else name)
        if name not in c_functions or nim_name not in nim:
            if nim_name not in nim: failures.append(f"{name}: missing Nim declaration")
            continue
        cursor = c_functions[name]
        actual, ret, pragmas = nim[nim_name]
        expected_args = list(cursor.get_arguments())
        if len(actual) != len(expected_args):
            failures.append(f"{name}: C has {len(expected_args)} parameters, Nim has {len(actual)}")
            continue
        for index, (c_arg, n_arg) in enumerate(zip(expected_args, actual)):
            checked_params += 1
            want = c_shape(c_arg.type, True)
            have = nim_shape(n_arg, aliases, callbacks, nim_aliases)
            if want != have:
                failures.append(f"{name} parameter {index + 1}: C {c_arg.type.spelling} {want}, Nim {n_arg} {have}")
            if n_arg.startswith('proc('):
                nested = nim_proc(n_arg)
                callback_tokens = [t.spelling for t in c_arg.get_tokens()]
                expected_call = 'gdalCall' if 'CPL_STDCALL' in callback_tokens else 'cdecl'
                if expected_call not in nested[2]:
                    failures.append(f"{name} parameter {index + 1}: callback requires {expected_call}")
        want, have = c_shape(cursor.result_type), nim_shape(ret, aliases, callbacks, nim_aliases)
        if want != have:
            failures.append(f"{name} return: C {cursor.result_type.spelling} {want}, Nim {ret} {have}")
        tokens = [t.spelling for t in cursor.get_tokens()]
        prefix = tokens[:tokens.index(name)] if name in tokens else tokens
        expected_call = 'gdalCall' if 'CPL_STDCALL' in prefix else 'cdecl'
        if expected_call not in pragmas:
            failures.append(f"{name}: function requires {expected_call}, got {pragmas}")
        if (cursor.type.kind == clang.TypeKind.FUNCTIONPROTO and cursor.type.is_function_variadic()) != ('varargs' in pragmas):
            failures.append(f"{name}: variadic mismatch")
    return failures, checked_params, len(callbacks)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--include", type=pathlib.Path)
    parser.add_argument("--libclang")
    parser.add_argument("--bindings", type=pathlib.Path,
                        default=ROOT / "src/ngis/gdal/bindings.nim")
    args = parser.parse_args()
    configure_clang(args.libclang)
    include = (args.include or pathlib.Path(subprocess.check_output(
        ["gdal-config", "--prefix"], text=True).strip()) / "include").resolve()
    manifest = json.loads((ROOT / "src/ngis/gdal/bindings.json").read_text())
    flags = ["-I" + str(include)]
    if sys.platform == "darwin":
        flags += ["-isysroot", subprocess.check_output(
            ["xcrun", "--show-sdk-path"], text=True).strip()]
    with tempfile.TemporaryDirectory(prefix="ngis-function-abi-") as tmp:
        source = pathlib.Path(tmp) / "headers.h"
        source.write_text("".join('#include "' + h + '"\n' for h in manifest["headers"]))
        index = clang.Index.create()
        parsed = []
        tus = []
        for language, standard in (("c", "c11"), ("c++", "c++17")):
            tu = index.parse(str(source), args=["-x", language, "-std=" + standard] + flags)
            errors = [str(d) for d in tu.diagnostics if d.severity >= clang.Diagnostic.Error]
            if errors:
                raise RuntimeError("\n".join(errors))
            tus.append(tu)
            parsed.append(declarations(tu, include))
    c_decls, cpp_decls = parsed
    # Clang's Mach-O mangled names include the assembler's leading underscore.
    prefix = "_" if sys.platform == "darwin" else ""
    cpp_only = {name for name, names in cpp_decls.items()
                if prefix + name not in names}
    functions = manifest["functions"]
    failures = []
    for name, info in functions.items():
        symbol = LEGACY.get(name, name)
        if info["symbol"] != symbol:
            failures.append(f"{name}: wrong imported symbol {info['symbol']!r}; expected {symbol!r}")
        if name not in c_decls:
            failures.append(f"{name}: no matching external declaration in C headers")
        if name in cpp_only:
            failures.append(f"{name}: C++ linkage; cannot import as C symbol {symbol!r}")
    for name in sorted(c_decls.keys() - functions.keys() - cpp_only):
        failures.append(f"{name}: C-linkage declaration missing from manifest")
    source = args.bindings.read_text()
    nim = nim_functions(source)
    imports = re.search(r'^gdalImports:\s*\n((?:[ \t]+[^\n]*\n|\n)*)', source, re.M)
    imported = nim_functions(imports.group(1)) if imports else {}
    for name, info in functions.items():
        nim_name = info.get("nim_name", "c" + name if name.startswith("_") else name)
        if nim_name not in imported:
            failures.append(f"{name}: declaration missing from gdalImports block")
            continue
        pragmas = imported[nim_name][2]
        symbol = re.search(r'\bimportc\s*:\s*"([^"]+)"', pragmas)
        if not symbol or symbol.group(1) != info["symbol"]:
            failures.append(f"{name}: incorrect importc symbol in declaration")
        if re.search(r'\bdynlib\b', pragmas):
            failures.append(f"{name}: dynlib pragma bypasses runtime loader")
    if imports:
        outside = source[:imports.start()] + source[imports.end():]
        for name, (_, _, pragmas) in nim_functions(outside).items():
            if re.search(r'\bimportc\b', pragmas):
                failures.append(f"{name}: importc declaration outside gdalImports")
    c_functions, aliases, alias_nodes = c_nodes(tus[0], include)
    shape_errors, checked_params, callbacks = shape_failures(
        c_functions, aliases, alias_nodes, nim, source, functions)
    failures.extend(shape_errors)
    if failures:
        print("\n".join(failures), file=sys.stderr)
        return 1
    print(f"Checked {len(functions)} functions and {checked_params} parameter shapes; found {callbacks} Nim callback types")
    return 0


if __name__ == "__main__":
    sys.exit(main())
