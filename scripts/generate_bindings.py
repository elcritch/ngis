#!/usr/bin/env python3
"""Generate the GDAL public C ABI using libclang (pip install clang==18.1.8).

Run with the GDAL 3.13.3 development headers installed. No generated declaration
is handwritten: unsupported types fail generation instead of becoming pointers.
"""
import argparse
import ast
import hashlib
import json
import os
import pathlib
import re
import subprocess
import sys
import tempfile
from clang import cindex as ci
from clang_support import configure_clang

HEADERS = """cpl_atomic_ops.h cpl_compressor.h cpl_conv.h cpl_csv.h cpl_error.h cpl_float.h cpl_hash_set.h
cpl_http.h cpl_list.h cpl_minixml.h cpl_multiproc.h cpl_port.h cpl_progress.h
cpl_quad_tree.h cpl_spawn.h cpl_string.h cpl_time.h cpl_virtualmem.h cpl_vsi.h
cpl_vsi_error.h gdal.h gdal_adbc.h gdal_alg.h gdal_csv.h gdal_frmts.h gdal_fwd.h
gdal_mem.h gdal_utils.h gdal_version.h gdal_vrt.h gdalalgorithm_c.h gdalgrid.h
gdalpansharpen.h gdalwarper.h gnm.h gnm_api.h ogr_api.h ogr_core.h
ogr_geocoding.h ogr_recordbatch.h ogr_srs_api.h""".split()
ROOT = pathlib.Path(__file__).resolve().parents[1]
CPP_ONLY_FUNCTIONS = {
    "CPLGreatestCommonDivisor", "CPLUnixTimeToYMDHMS",
    "CPLYMDHMSToUnixTime", "CPLParseRFC822DateTime",
}
NIM_FUNCTION_NAMES = {"CPLsprintf": "CPLsprintfBuffer", "CPLSPrintf": "CPLSPrintfText"}
for name in ("GDALCheckVersion", "VSIMallocVerbose", "VSIMallocAlignedAutoVerbose",
             "VSIMalloc2Verbose", "VSIMalloc3Verbose", "VSICallocVerbose",
             "VSIReallocVerbose", "VSIStrdupVerbose"):
    NIM_FUNCTION_NAMES[name] = name + "Raw"
KEYWORDS = set("addr and as asm bind block break case cast concept const continue converter defer discard distinct div do elif else end enum except export finally for from func if import in include interface is isnot iterator let macro method mixin mod nil not notin object of or out proc ptr raise ref return shl shr static template try tuple type using var when while with without xor yield".split())

def identifier(name):
    name = re.sub(r"\W", "_", name)
    if name.startswith("_"): name = "c" + name
    return "`" + name + "`" if name.lower() in KEYWORDS else name

def key(name):
    return name[:1] + name[1:].replace("_", "").lower()

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--include", type=pathlib.Path)
    parser.add_argument("--libclang")
    args = parser.parse_args()
    include = args.include or pathlib.Path(subprocess.check_output(["gdal-config", "--prefix"], text=True).strip()) / "include"
    version_header = (include / "gdal_version.h").read_text()
    version = tuple(int(re.search(r"#\s*define\s+GDAL_VERSION_" + part + r"\s+(\d+)", version_header).group(1)) for part in ("MAJOR", "MINOR", "REV"))
    if version != (3, 13, 3):
        raise RuntimeError(f"expected GDAL 3.13.3 headers, got {version}; update the pinned API deliberately")
    configure_clang(args.libclang)
    flags = ["-x", "c", "-std=c11", "-I" + str(include)]
    if sys.platform == "darwin":
        flags += ["-isysroot", subprocess.check_output(["xcrun", "--show-sdk-path"], text=True).strip()]
    with tempfile.TemporaryDirectory(prefix="ngis-bindgen-") as tmp:
        source = pathlib.Path(tmp) / "public.h"
        source.write_text("".join('#include "' + name + '"\n' for name in HEADERS))
        tu = ci.Index.create().parse(str(source), args=flags, options=ci.TranslationUnit.PARSE_DETAILED_PROCESSING_RECORD)
        errors = [str(d) for d in tu.diagnostics if d.severity >= ci.Diagnostic.Error]
        if errors: raise RuntimeError("\n".join(errors))
        def public(n):
            return n.location.file and pathlib.Path(n.location.file.name).parent.resolve() == include.resolve() and pathlib.Path(n.location.file.name).name in HEADERS
        nodes = [n for n in tu.cursor.get_children() if public(n)]
        aliases = {n.spelling: n for n in nodes if n.kind == ci.CursorKind.TYPEDEF_DECL}
        record_names, records, enums = {}, {}, {}
        def record(n, hint=""):
            n = n.get_definition() or n
            usr = n.get_usr()
            if usr in record_names: return record_names[usr]
            spelling = n.spelling
            name = spelling if spelling and "(" not in spelling else hint or "GdalRecord" + str(n.location.line) + "_" + str(n.location.column)
            if name.startswith("_"): name = "C" + name
            record_names[usr] = name
            if name not in records or n.is_definition(): records[name] = n
            for child in n.get_children():
                if child.kind in (ci.CursorKind.STRUCT_DECL, ci.CursorKind.UNION_DECL):
                    record(child, name + "_" + str(child.location.line))
            return name
        for n in nodes:
            if n.kind in (ci.CursorKind.STRUCT_DECL, ci.CursorKind.UNION_DECL): record(n)
            elif n.kind == ci.CursorKind.ENUM_DECL:
                enums[n.get_usr()] = n
        builtin = {
            ci.TypeKind.VOID: "void", ci.TypeKind.BOOL: "bool", ci.TypeKind.CHAR_S: "cchar",
            ci.TypeKind.CHAR_U: "cchar", ci.TypeKind.SCHAR: "cschar", ci.TypeKind.UCHAR: "uint8",
            ci.TypeKind.SHORT: "cshort", ci.TypeKind.USHORT: "cushort", ci.TypeKind.INT: "cint",
            ci.TypeKind.UINT: "cuint", ci.TypeKind.LONG: "clong", ci.TypeKind.ULONG: "culong",
            ci.TypeKind.LONGLONG: "clonglong", ci.TypeKind.ULONGLONG: "culonglong",
            ci.TypeKind.FLOAT: "cfloat", ci.TypeKind.DOUBLE: "cdouble", ci.TypeKind.LONGDOUBLE: "clongdouble",
        }
        system = {"size_t": "csize_t", "ptrdiff_t": "int", "intptr_t": "int", "uintptr_t": "uint",
                  "int8_t": "int8", "uint8_t": "uint8", "int16_t": "int16", "uint16_t": "uint16",
                  "int32_t": "int32", "uint32_t": "uint32", "int64_t": "int64", "uint64_t": "uint64",
                  "va_list": "GdalVaList", "__builtin_va_list": "GdalVaList", "FILE": "GdalFile"}
        external = {}
        def parameter_type(t):
            # C array parameters decay to pointers even when libclang preserves
            # their fixed or incomplete array spelling in argument_types().
            if t.kind in (ci.TypeKind.CONSTANTARRAY, ci.TypeKind.INCOMPLETEARRAY):
                element = t.element_type
                if element.kind == ci.TypeKind.POINTER and element.get_pointee().kind in (ci.TypeKind.CHAR_S, ci.TypeKind.CHAR_U):
                    return "cstringArray"
                return "ptr " + typ(element)
            return typ(t)

        def typ(t):
            k = t.kind
            if k in builtin: return builtin[k]
            if k == ci.TypeKind.TYPEDEF:
                name = t.get_declaration().spelling
                if name in aliases: return identifier(name)
                if name in system: return system[name]
                return typ(t.get_canonical())
            if k == ci.TypeKind.ELABORATED: return typ(t.get_named_type())
            if k == ci.TypeKind.POINTER:
                p = t.get_pointee()
                if p.kind in (ci.TypeKind.CHAR_S, ci.TypeKind.CHAR_U): return "cstring"
                if p.kind == ci.TypeKind.VOID: return "pointer"
                if p.kind == ci.TypeKind.POINTER and p.get_pointee().kind in (ci.TypeKind.CHAR_S, ci.TypeKind.CHAR_U): return "cstringArray"
                if p.kind in (ci.TypeKind.FUNCTIONPROTO, ci.TypeKind.FUNCTIONNOPROTO): return typ(p)
                return "ptr " + typ(p)
            if k in (ci.TypeKind.FUNCTIONPROTO, ci.TypeKind.FUNCTIONNOPROTO):
                argtypes = list(t.argument_types()) if k == ci.TypeKind.FUNCTIONPROTO else []
                params = ", ".join("a" + str(i) + ": " + parameter_type(a) for i, a in enumerate(argtypes))
                ret = typ(t.get_result())
                pragmas = "cdecl, raises: []" + (", varargs" if k == ci.TypeKind.FUNCTIONPROTO and t.is_function_variadic() else "")
                return "proc(" + params + ")" + (": " + ret if ret != "void" else "") + " {." + pragmas + ".}"
            if k == ci.TypeKind.CONSTANTARRAY: return "array[" + str(t.element_count) + ", " + typ(t.element_type) + "]"
            if k == ci.TypeKind.INCOMPLETEARRAY: return "UncheckedArray[" + typ(t.element_type) + "]"
            if k == ci.TypeKind.RECORD:
                n = t.get_declaration()
                if public(n): return identifier(record(n))
                name = "GdalSystem" + re.sub(r"\W", "", n.spelling)
                external[name] = n.spelling
                return name
            if k == ci.TypeKind.ENUM:
                n = t.get_declaration()
                return "cuint" if n.enum_type.kind == ci.TypeKind.UINT else "cint"
            if k == ci.TypeKind.UNEXPOSED and t.get_canonical().kind != k: return typ(t.get_canonical())
            raise RuntimeError("unsupported C type: " + t.spelling + " (" + str(k) + ")")
        declarations = []
        enum_aliases = []
        for name,n in aliases.items():
            if name in ("CPL_FILE_HANDLE", "CPL_PID", "VSIStatBufL"):
                continue
            underlying = typ(n.underlying_typedef_type)
            if n.underlying_typedef_type.get_canonical().kind == ci.TypeKind.ENUM:
                underlying = "distinct " + underlying
                enum_aliases.append(name)
            if name == "GPtrDiff_t": underlying = "int"
            if "CPL_STDCALL" in [t.spelling for t in n.get_tokens()]:
                underlying = underlying.replace("{.cdecl,", "{.gdalCall,")
            if key(name) != key(underlying): declarations.append("  " + identifier(name) + "* = " + underlying)
        # Mapping fields can discover additional anonymous records.
        done = set()
        while set(records) - done:
            for name in list(records):
                if name in done: continue
                done.add(name)
                n = records[name]
                attrs = "union, bycopy" if n.kind == ci.CursorKind.UNION_DECL else "bycopy" if n.is_definition() else "incompleteStruct"
                fields = []
                for f in n.get_children():
                    if f.kind == ci.CursorKind.FIELD_DECL:
                        fieldtype = typ(f.type)
                        bits = " {.bitsize: " + str(f.get_bitfield_width()) + ".}" if f.is_bitfield() else ""
                        fields.append("    " + identifier(f.spelling) + "*" + bits + ": " + fieldtype)
                declarations.append("  " + identifier(name) + "* {." + attrs + ".} = object" + ("\n" + "\n".join(fields) if fields else ""))
        functions = {}
        static_functions = []
        for n in nodes:
            if n.kind != ci.CursorKind.FUNCTION_DECL: continue
            if n.spelling in CPP_ONLY_FUNCTIONS:
                continue
            if n.storage_class == ci.StorageClass.STATIC:
                static_functions.append(n.spelling); continue
            params=[]; used=set()
            for i,p in enumerate(n.get_arguments()):
                name=p.spelling or "a"+str(i)
                if key(name) in used: name += str(i)
                used.add(key(name)); params.append(identifier(name)+": "+parameter_type(p.type))
            result=typ(n.result_type)
            tokens=[t.spelling for t in n.get_tokens()]
            prefix = tokens[:tokens.index(n.spelling)] if n.spelling in tokens else tokens
            call="gdalCall" if "CPL_STDCALL" in prefix else "cdecl"
            symbol = {"RPCInfoV1ToMD": "RPCInfoToMD", "GDALCreateRPCTransformerV1": "GDALCreateRPCTransformer", "GDALExtractRPCInfoV1": "GDALExtractRPCInfo"}.get(n.spelling, n.spelling)
            nim_name = NIM_FUNCTION_NAMES.get(n.spelling, n.spelling)
            pragmas=call + ', importc: "'+symbol+'", raises: []'
            if n.type.kind == ci.TypeKind.FUNCTIONPROTO and n.type.is_function_variadic(): pragmas+=", varargs"
            functions[n.spelling]={"header":pathlib.Path(n.location.file.name).name, "signature":n.type.spelling, "symbol": symbol,
                "nim":"proc "+identifier(nim_name)+"*("+", ".join(params)+")"+(": "+result if result!="void" else "")+" {."+pragmas+".}"}
            if nim_name != n.spelling:
                functions[n.spelling]["nim_name"] = nim_name
        constants={}
        evaluated={}
        for n in nodes:
            if n.kind == ci.CursorKind.ENUM_DECL:
                enum_name = next((name for name, alias in aliases.items() if alias.underlying_typedef_type.get_canonical().kind == ci.TypeKind.ENUM and alias.underlying_typedef_type.get_canonical().get_declaration().get_usr() == n.get_usr()), None)
                for child in n.get_children():
                    if child.kind == ci.CursorKind.ENUM_CONSTANT_DECL:
                        value=child.enum_value
                        evaluated[child.spelling] = value
                        literal = str(value)+( "'u32" if value>2147483647 else "")
                        constants[child.spelling] = identifier(enum_name) + "(" + literal + ")" if enum_name else literal
            elif n.kind == ci.CursorKind.VAR_DECL and n.type.kind == ci.TypeKind.CONSTANTARRAY:
                tokens = [token.spelling for token in n.get_tokens()]
                if "=" in tokens:
                    expression = " ".join(tokens[tokens.index("=") + 1:])
                    if re.fullmatch(r'(?:"(?:[^"\\]|\\.)*"\s*)+', expression):
                        constants[n.spelling] = json.dumps("".join(ast.literal_eval(x) for x in re.findall(r'"(?:[^"\\]|\\.)*"', expression)))
        macros={}
        for n in nodes:
            if n.kind == ci.CursorKind.MACRO_DEFINITION and pathlib.Path(n.location.file.name).name in HEADERS:
                ts=list(n.get_tokens())
                if len(ts)>1 and not (ts[1].spelling=="(" and ts[1].extent.start.offset==ts[0].extent.end.offset):
                    macros[n.spelling]=" ".join(t.spelling for t in ts[1:])
        ignored_macros={}
        def evaluate(name, seen=None):
            if name in evaluated:
                return evaluated[name]
            seen=set() if seen is None else seen
            if name in seen: raise ValueError("cyclic macro")
            seen=seen|{name}; expr=macros[name]
            if re.fullmatch(r'(?:"(?:[^"\\]|\\.)*"\s*)+',expr):
                return "".join(ast.literal_eval(x) for x in re.findall(r'"(?:[^"\\]|\\.)*"',expr))
            expr=re.sub(r"\b(0[xX][0-9a-fA-F]+|\d+)(?:ULL|LLU|UL|LU|LL|U|L)\b",r"\1",expr,flags=re.I)
            expr=re.sub(r"\((?:unsigned\s+int|int|GUIntBig|GIntBig|size_t|GDALDataType)\)","",expr)
            expr=re.sub(r"\bNULL\b", "0", expr)
            def replace(m):
                token=m.group()
                if token in macros or token in evaluated:
                    v=evaluate(token,seen)
                    if isinstance(v,(int,float)): return str(v)
                return token
            expr=re.sub(r"\b[A-Za-z_]\w*\b",replace,expr)
            tree=ast.parse(expr,mode="eval")
            allowed=(ast.Expression,ast.Constant,ast.UnaryOp,ast.BinOp,ast.Add,ast.Sub,ast.Mult,ast.Div,ast.FloorDiv,ast.Mod,ast.LShift,ast.RShift,ast.BitOr,ast.BitAnd,ast.BitXor,ast.Invert,ast.UAdd,ast.USub)
            if any(not isinstance(x,allowed) for x in ast.walk(tree)): raise ValueError("not a constant expression")
            return eval(compile(tree,"<macro>","eval"),{"__builtins__":{}},{})
        for name in macros:
            if name in constants: continue
            try:
                value=evaluate(name)
                evaluated[name] = value
                if macros[name] in constants:
                    constants[name] = constants[macros[name]]
                elif isinstance(value,str): constants[name]=json.dumps(value,ensure_ascii=True)
                elif isinstance(value,int): constants[name]=str(value)+("'u64" if value>4294967295 else "'u32" if value>2147483647 else "")
                elif isinstance(value,float): constants[name]=repr(value)
            except (ValueError,KeyError,SyntaxError,TypeError,ZeroDivisionError,OverflowError,RecursionError): ignored_macros[name]=macros[name]
        # Nim identifiers are case/underscore insensitive except for the first letter.
        occupied={key(name) for name in records}|{key(name) for name in aliases}|{key(name) for name in functions}
        macro_source = (ROOT / "src/ngis/gdal/api/macros.nim").read_text()
        manual = set(re.findall(r"^  (\w+)\*\s*=", macro_source, re.M))
        manual_symbols = manual | set(re.findall(r"^(?:proc|func|template) (\w+)\*", macro_source, re.M))
        constants={name:value for name,value in constants.items() if key(name) not in occupied and name not in manual | {"CPL_FRMT_GB_WITHOUT_PREFIX", "CPL_FILE_INVALID_HANDLE"}}
        system_types=["  GdalFile* {.importc: \"FILE\", header: \"<stdio.h>\", incompleteStruct.} = object",
                      "  GdalVaList* {.importc: \"va_list\", header: \"<stdarg.h>\".} = object"]
        for name,cname in external.items():
            if cname in ("stat", "tm"):
                continue
            header="<sys/stat.h>" if "stat" in cname else "<time.h>" if cname=="tm" else "<stdio.h>"
            system_types.append('  '+name+'* {.importc: "struct '+cname+'", header: "'+header+'", bycopy.} = object')
        banner="## Generated from GDAL 3.13.3 public C headers. Do not edit.\n## Regenerate with scripts/generate_bindings.py; see bindings.json for coverage.\nimport ./[library, systemtypes]\nimport ./private/imports\nexport library, systemtypes\n\nwhen defined(windows) and defined(i386):\n  {.pragma: gdalCall, stdcall.}\nelse:\n  {.pragma: gdalCall, cdecl.}\n\n"
        platform_types = '''when defined(windows):
  type
    CPL_FILE_HANDLE* = pointer
    CPL_PID* = cuint
  const
    CPL_FILE_INVALID_HANDLE* = nil
    CPL_FRMT_GB_WITHOUT_PREFIX* = "I64"
else:
  type
    CPL_FILE_HANDLE* = cint
    CPL_PID* = cint
  const
    CPL_FILE_INVALID_HANDLE* = -1
    CPL_FRMT_GB_WITHOUT_PREFIX* = "ll"
'''
        enum_ops = "\n".join("proc `==`*(a, b: " + identifier(name) + "): bool {.borrow.}\nproc `$`*(value: " + identifier(name) + "): string {.borrow.}" for name in enum_aliases)
        output=banner+platform_types+"type\n"+"\n".join(system_types+declarations)+"\n\n"+enum_ops+"\n\nconst\n"+"\n".join("  "+identifier(n)+"* = "+v for n,v in sorted(constants.items()))+"\n\ngdalImports:\n"+"\n".join("  "+f["nim"] for f in functions.values())+"\n\nwhen not gdalRuntimeEnabled:\n  try:\n    loadGdal()\n  except GdalLoadError:\n    discard\n"
        dest=ROOT/"src/ngis/gdal/api"
        (dest/"bindings.nim").write_text(output)
        macro_coverage = {}
        for name, expression in ignored_macros.items():
            category = "manual_equivalent" if name in manual_symbols else "cpp_only" if name == "OGRUnknownType" else "compiler_annotation" if name.startswith("CPL_") else "unimplemented"
            macro_coverage[name] = {"category": category, "expression": expression}
        missing = [name for name, entry in macro_coverage.items() if entry["category"] == "unimplemented"]
        if missing:
            raise RuntimeError("unimplemented public object macros: " + ", ".join(missing))
        manifest={"gdal_version":"3.13.3","headers":HEADERS,"excluded_cpp_functions":sorted(CPP_ONLY_FUNCTIONS),"header_sha256":{name:hashlib.sha256((include/name).read_bytes()).hexdigest() for name in HEADERS},"functions":{name:{k:v for k,v in f.items() if k!="nim"} for name,f in sorted(functions.items())},"static_inline_functions":sorted(set(static_functions)),"object_macro_equivalents":macro_coverage,"counts":{"functions":len(functions),"types":len(declarations),"constants":len(constants)}}
        (dest/"bindings.json").write_text(json.dumps(manifest,indent=2,sort_keys=True)+"\n")
        print(json.dumps(manifest["counts"]))

if __name__ == "__main__": main()
