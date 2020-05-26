# This is a bit of a hack, basically I copied json.to macro
# and then added support for custom field names with pragma
# After https://github.com/nim-lang/Nim/pull/11526 gets merged
# we can make a PR to the json module in stdlib to implement
# the same functionality
import json, tables, macros, options, strutils
export json, options

template jsonName*(name: string) {.pragma.}

macro isRefSkipDistinct(arg: typed): untyped =
  var impl = getTypeImpl(arg)
  if impl.kind == nnkBracketExpr and impl[0].eqIdent("typeDesc"):
    impl = getTypeImpl(impl[1])
  while impl.kind == nnkDistinctTy:
    impl = getTypeImpl(impl[0])
  result = newLit(impl.kind == nnkRefTy)

proc initFromJson(dst: var string; jsonNode: JsonNode; jsonPath: var string)
proc initFromJson(dst: var bool; jsonNode: JsonNode; jsonPath: var string)
proc initFromJson(dst: var JsonNode; jsonNode: JsonNode; jsonPath: var string)
proc initFromJson[T: SomeInteger](dst: var T; jsonNode: JsonNode, jsonPath: var string)
proc initFromJson[T: SomeFloat](dst: var T; jsonNode: JsonNode; jsonPath: var string)
proc initFromJson[T: enum](dst: var T; jsonNode: JsonNode; jsonPath: var string)
proc initFromJson[T](dst: var seq[T]; jsonNode: JsonNode; jsonPath: var string)
proc initFromJson[S,T](dst: var array[S,T]; jsonNode: JsonNode; jsonPath: var string)
proc initFromJson[T](dst: var Table[string,T];jsonNode: JsonNode; jsonPath: var string)
proc initFromJson[T](dst: var OrderedTable[string,T];jsonNode: JsonNode; jsonPath: var string)
proc initFromJson[T](dst: var ref T; jsonNode: JsonNode; jsonPath: var string)
proc initFromJson[T](dst: var Option[T]; jsonNode: JsonNode; jsonPath: var string)
proc initFromJson[T: distinct](dst: var T;jsonNode: JsonNode; jsonPath: var string)
proc initFromJson[T: object|tuple](dst: var T; jsonNode: JsonNode; jsonPath: var string)


template verifyJsonKind(node: JsonNode, kinds: set[JsonNodeKind],
                        ast: string) =
  if node == nil:
    raise newException(KeyError, "key not found: " & ast)
  elif  node.kind notin kinds:
    let msg = "Incorrect JSON kind. Wanted '$1' in '$2' but got '$3'." % [
      $kinds,
      ast,
      $node.kind
    ]
    raise newException(JsonKindError, msg)

proc initFromJson(dst: var string; jsonNode: JsonNode; jsonPath: var string) =
  verifyJsonKind(jsonNode, {JString, JNull}, jsonPath)
  # since strings don't have a nil state anymore, this mapping of
  # JNull to the default string is questionable. `none(string)` and
  # `some("")` have the same potentional json value `JNull`.
  if jsonNode.kind == JNull:
    dst = ""
  else:
    dst = jsonNode.str

proc initFromJson(dst: var bool; jsonNode: JsonNode; jsonPath: var string) =
  verifyJsonKind(jsonNode, {JBool}, jsonPath)
  dst = jsonNode.bval

proc initFromJson(dst: var JsonNode; jsonNode: JsonNode; jsonPath: var string) =
  dst = jsonNode.copy

proc initFromJson[T: SomeInteger](dst: var T; jsonNode: JsonNode, jsonPath: var string) =
  verifyJsonKind(jsonNode, {JInt}, jsonPath)
  dst = T(jsonNode.num)

proc initFromJson[T: SomeFloat](dst: var T; jsonNode: JsonNode; jsonPath: var string) =
  verifyJsonKind(jsonNode, {JInt, JFloat}, jsonPath)
  if jsonNode.kind == JFloat:
    dst = T(jsonNode.fnum)
  else:
    dst = T(jsonNode.num)

proc initFromJson[T: enum](dst: var T; jsonNode: JsonNode; jsonPath: var string) =
  verifyJsonKind(jsonNode, {JString}, jsonPath)
  dst = parseEnum[T](jsonNode.getStr)

proc initFromJson[T](dst: var seq[T]; jsonNode: JsonNode; jsonPath: var string) =
  verifyJsonKind(jsonNode, {JArray}, jsonPath)
  dst.setLen jsonNode.len
  let orignalJsonPathLen = jsonPath.len
  for i in 0 ..< jsonNode.len:
    jsonPath.add '['
    jsonPath.addInt i
    jsonPath.add ']'
    initFromJson(dst[i], jsonNode[i], jsonPath)
    jsonPath.setLen orignalJsonPathLen

proc initFromJson[S,T](dst: var array[S,T]; jsonNode: JsonNode; jsonPath: var string) =
  verifyJsonKind(jsonNode, {JArray}, jsonPath)
  let originalJsonPathLen = jsonPath.len
  for i in 0 ..< jsonNode.len:
    jsonPath.add '['
    jsonPath.addInt i
    jsonPath.add ']'
    initFromJson(dst[i], jsonNode[i], jsonPath)
    jsonPath.setLen originalJsonPathLen

proc initFromJson[T](dst: var Table[string,T];jsonNode: JsonNode; jsonPath: var string) =
  dst = initTable[string, T]()
  verifyJsonKind(jsonNode, {JObject}, jsonPath)
  let originalJsonPathLen = jsonPath.len
  for key in keys(jsonNode.fields):
    jsonPath.add '.'
    jsonPath.add key
    initFromJson(mgetOrPut(dst, key, default(T)), jsonNode[key], jsonPath)
    jsonPath.setLen originalJsonPathLen

proc initFromJson[T](dst: var OrderedTable[string,T];jsonNode: JsonNode; jsonPath: var string) =
  dst = initOrderedTable[string,T]()
  verifyJsonKind(jsonNode, {JObject}, jsonPath)
  let originalJsonPathLen = jsonPath.len
  for key in keys(jsonNode.fields):
    jsonPath.add '.'
    jsonPath.add key
    initFromJson(mgetOrPut(dst, key, default(T)), jsonNode[key], jsonPath)
    jsonPath.setLen originalJsonPathLen

proc initFromJson[T](dst: var ref T; jsonNode: JsonNode; jsonPath: var string) =
  verifyJsonKind(jsonNode, {JObject, JNull}, jsonPath)
  if jsonNode.kind == JNull:
    dst = nil
  else:
    dst = new(T)
    initFromJson(dst[], jsonNode, jsonPath)

proc initFromJson[T](dst: var Option[T]; jsonNode: JsonNode; jsonPath: var string) =
  if jsonNode != nil and jsonNode.kind != JNull:
    dst = some(default(T))
    initFromJson(dst.get, jsonNode, jsonPath)

macro assignDistinctImpl[T : distinct](dst: var T;jsonNode: JsonNode; jsonPath: var string) =
  let typInst = getTypeInst(dst)
  let typImpl = getTypeImpl(dst)
  let baseTyp = typImpl[0]

  result = quote do:
    when nimvm:
      var tmp: `baseTyp`
      initFromJson( tmp, `jsonNode`, `jsonPath`)
      `dst` = `typInst`(tmp)
    else:
      initFromJson( `baseTyp`(`dst`), `jsonNode`, `jsonPath`)

proc initFromJson[T : distinct](dst: var T; jsonNode: JsonNode; jsonPath: var string) =
  assignDistinctImpl(dst, jsonNode, jsonPath)

proc detectIncompatibleType(typeExpr, lineinfoNode: NimNode): void =
  if typeExpr.kind == nnkTupleConstr:
    error("Use a named tuple instead of: " & typeExpr.repr, lineinfoNode)

proc hasPragma(n: NimNode, id: string): NimNode =
  for p in pragma(n):
    case p.kind
    of nnkSym:
      if eqIdent($p, id):
        return p
    of nnkExprColonExpr:
      if eqIdent($p[0], id):
        return p
    else:
      doAssert false, "bad assumption about the ast: " & $p.kind

proc findPragmaExprForFieldSym(arg: NimNode, fieldSym: NimNode): NimNode =
  case arg.kind
  of nnkRecList, nnkRecCase:
    for it in arg.children:
      result = findPragmaExprForFieldSym(it, fieldSym)
      if result != nil:
        return
  of nnkOfBranch:
    return findPragmaExprForFieldSym(arg[1], fieldSym)
  of nnkElse:
    return findPragmaExprForFieldSym(arg[0], fieldSym)
  of nnkIdentDefs:
    for i in 0 ..< arg.len-2:
      let child = arg[i]
      result = findPragmaExprForFieldSym(child, fieldSym)
      if result != nil:
        return
  of nnkIdent, nnkSym, nnkPostfix:
    return nil
  of nnkPragmaExpr:
    var ident = arg[0]
    if ident.kind == nnkPostfix: ident = ident[1]
    if ident.kind == nnkAccQuoted: ident = ident[0]
    if eqIdent(ident, fieldSym):
      return arg[1]
  else:
    return

proc getPragmaName(sym: NimNode, name = "jsonName"): (bool, string) = 
  let owner = sym.owner.getImpl()[2]
  if owner.len < 3:
    return
  let pragma = findPragmaExprForFieldSym(owner[2], sym)
  if pragma.kind == nnkPragma and $pragma[0][0] == name:
    result = (true, pragma[0][1].strVal)

proc foldObjectBody(dst, typeNode, tmpSym, jsonNode, jsonPath, originalJsonPathLen: NimNode): void {.compileTime.} =
  case typeNode.kind
  of nnkEmpty:
    discard
  of nnkRecList, nnkTupleTy:
    for it in typeNode:
      foldObjectBody(dst, it, tmpSym, jsonNode, jsonPath, originalJsonPathLen)

  of nnkIdentDefs:
    typeNode.expectLen 3
    let fieldSym = typeNode[0]

    var name = fieldSym.strVal
    let maybePragma = getPragmaName(fieldSym)
    if maybePragma[0]: name = maybePragma[1]

    let fieldNameLit = newLit(name)
    let fieldPathLit = newLit("." & name)
    let fieldType = typeNode[1]

    detectIncompatibleType(fieldType, fieldSym)

    dst.add quote do:
      jsonPath.add `fieldPathLit`
      when nimvm:
        when isRefSkipDistinct(`tmpSym`.`fieldSym`):
          # workaround #12489
          var tmp: `fieldType`
          initFromJson(tmp, getOrDefault(`jsonNode`,`fieldNameLit`), `jsonPath`)
          `tmpSym`.`fieldSym` = tmp
        else:
          initFromJson(`tmpSym`.`fieldSym`, getOrDefault(`jsonNode`,`fieldNameLit`), `jsonPath`)
      else:
        initFromJson(`tmpSym`.`fieldSym`, getOrDefault(`jsonNode`,`fieldNameLit`), `jsonPath`)
      jsonPath.setLen `originalJsonPathLen`

  of nnkRecCase:
    let kindSym = typeNode[0][0]
    var name = kindSym.strVal
    let maybePragma = getPragmaName(kindSym)
    if maybePragma[0]: name = maybePragma[1]

    let kindNameLit = newLit(name)
    let kindPathLit = newLit("." & name)
    let kindType = typeNode[0][1]
    let kindOffsetLit = newLit(uint(getOffset(kindSym)))
    dst.add quote do:
      var kindTmp: `kindType`
      jsonPath.add `kindPathLit`
      initFromJson(kindTmp, `jsonNode`[`kindNameLit`], `jsonPath`)
      jsonPath.setLen `originalJsonPathLen`
      when defined js:
        `tmpSym`.`kindSym` = kindTmp
      else:
        when nimvm:
          `tmpSym`.`kindSym` = kindTmp
        else:
          # fuck it, assign kind field anyway
          ((cast[ptr `kindType`](cast[uint](`tmpSym`.addr) + `kindOffsetLit`))[]) = kindTmp
    dst.add nnkCaseStmt.newTree(nnkDotExpr.newTree(tmpSym, kindSym))
    for i in 1 ..< typeNode.len:
      foldObjectBody(dst, typeNode[i], tmpSym, jsonNode, jsonPath, originalJsonPathLen)

  of nnkOfBranch, nnkElse:
    let ofBranch = newNimNode(typeNode.kind)
    for i in 0 ..< typeNode.len-1:
      ofBranch.add copyNimTree(typeNode[i])
    let dstInner = newNimNode(nnkStmtListExpr)
    foldObjectBody(dstInner, typeNode[^1], tmpSym, jsonNode, jsonPath, originalJsonPathLen)
    # resOuter now contains the inner stmtList
    ofBranch.add dstInner
    dst[^1].expectKind nnkCaseStmt
    dst[^1].add ofBranch

  of nnkObjectTy:
    typeNode[0].expectKind nnkEmpty
    typeNode[1].expectKind {nnkEmpty, nnkOfInherit}
    if typeNode[1].kind == nnkOfInherit:
      let base = typeNode[1][0]
      var impl = getTypeImpl(base)
      while impl.kind in {nnkRefTy, nnkPtrTy}:
        impl = getTypeImpl(impl[0])
      foldObjectBody(dst, impl, tmpSym, jsonNode, jsonPath, originalJsonPathLen)
    let body = typeNode[2]
    foldObjectBody(dst, body, tmpSym, jsonNode, jsonPath, originalJsonPathLen)

  else:
    error("unhandled kind: " & $typeNode.kind, typeNode)

macro assignObjectImpl[T](dst: var T; jsonNode: JsonNode; jsonPath: var string) =
  let typeSym = getTypeInst(dst)
  let originalJsonPathLen = genSym(nskLet, "originalJsonPathLen")
  result = newStmtList()
  result.add quote do:
    let `originalJsonPathLen` = len(`jsonPath`)
  if typeSym.kind in {nnkTupleTy, nnkTupleConstr}:
    detectIncompatibleType(typeSym, dst)
    foldObjectBody(result, typeSym, dst, jsonNode, jsonPath, originalJsonPathLen)
  else:
    foldObjectBody(result, typeSym.getTypeImpl, dst, jsonNode, jsonPath, originalJsonPathLen)

proc initFromJson[T : object|tuple](dst: var T; jsonNode: JsonNode; jsonPath: var string) =
  assignObjectImpl(dst, jsonNode, jsonPath)

proc toCustom*[T](node: JsonNode, t: typedesc[T]): T =
  var jsonPath = ""
  initFromJson(result, node, jsonPath)

when isMainModule:
  type
    DataKind = enum
      testA, testB, testC
    
    Data = object
      case kind {.jsonName: "@type".}: DataKind
      of testA:
        aLength {.jsonName: "length".}: int32
        tarra: float
      of testB:
        bLength {.jsonName: "length".}: int32
        hal: int
      of testC:
        data: string
  
  let a = %*{
    "@type": "testB",
    "length": 15,
    "hal": 3
  }

  let parsed = a.toCustom(Data)
  doAssert parsed.kind == testB
  doAssert parsed.bLength == 15
  doAssert parsed.hal == 3
  echo "Seems to work fine!"