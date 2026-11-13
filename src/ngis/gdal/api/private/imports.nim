## Derive runtime procedure pointers from the generated ABI declarations.
import std/[dynlib, macros]
import ../../runtime

macro gdalImports*(declarations: untyped): untyped =
  result = newStmtList()
  let handle = genSym(nskParam, "handle")
  let assignments = newStmtList()
  for declaration in declarations:
    if declaration.kind == nnkCommentStmt:
      continue
    declaration.expectKind(nnkProcDef)
    if declaration[6].kind != nnkEmpty:
      error("runtime C imports must not contain a Nim body", declaration)
    let exportedName = declaration[0]
    if exportedName.kind != nnkPostfix or exportedName[0].strVal != "*":
      error("expected an exported C procedure", declaration)
    let name = exportedName[1].copyNimTree
    let pragmas = newNimNode(nnkPragma)
    var symbol = ""
    for pragma in declaration[4]:
      if pragma.kind == nnkExprColonExpr and pragma[0].eqIdent("importc"):
        symbol = pragma[1].strVal
      elif pragma.kind == nnkExprColonExpr and pragma[0].eqIdent("dynlib"):
        error("runtime C imports must not use dynlib", pragma)
      elif pragma.eqIdent("gdalCall"):
        when defined(windows) and defined(i386):
          pragmas.add ident"stdcall"
        else:
          pragmas.add ident"cdecl"
      else:
        pragmas.add pragma.copyNimTree
    if symbol.len == 0:
      error("runtime C imports need an explicit importc symbol", declaration)
    pragmas.add ident"gcsafe"
    let signature = newTree(nnkProcTy, declaration[3].copyNimTree, pragmas)
    result.add newTree(
      nnkVarSection, newIdentDefs(exportedName.copyNimTree, signature.copyNimTree)
    )
    assignments.add newAssignment(
      name,
      newTree(
        nnkCast,
        signature.copyNimTree,
        newCall(bindSym"symAddr", handle, newLit(symbol)),
      ),
    )
  let binder = genSym(nskProc, "bindGdalImports")
  result.add newProc(
    binder,
    params = [newEmptyNode(), newIdentDefs(handle, bindSym"LibHandle")],
    body = assignments,
    pragmas = newTree(
      nnkPragma, ident"gcsafe", newColonExpr(ident"raises", newNimNode(nnkBracket))
    ),
  )
  result.add newCall(bindSym"registerGdalImports", binder)
