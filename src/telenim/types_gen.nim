# I know this code is really, really far from perfect,
# maybe I should've used macros to properly operate on AST instead
# of strings, but the thing is that we don't need to generate definitions
# every day, we just need to generate them *once* for one tdlib version
# so this code is pretty rough and it's made to complete that task
# TODO:
# - How do make comments for different branches of an object variant?
# - A few name conflicts in object variants with a lot of branches, maybe detect that
# somehow?
# - Helper procs to access fields shared across a lot of different branches,
# something like this:
when false:
  proc chatId(u: Update): int64 = 
    case u.kind
    of uMessageSendAcknowledged:
      u.msgChatId
    of uMessageContent:
      u.mcChatId
    # other branches too
    else:
      raise newException(
        ValueError, "Can't access chatId from Update with kind " & $u.kind
      )


import parseutils, strutils, strformat, strscans
import tables
import sequtils, algorithm
import sugar

import npeg

type
  TlField = object
    name: string
    typ: string
    comment: string
    # True if there's "may be null" in the comment
    maybeNull: bool
  
  TlObj = object
    name: string
    fields: seq[TlField]
    comment: string
  
  TlClass = object
    # Objects which inherit from that class
    objs: seq[TlObj]
    # Comment for the class itself
    comment: string
  
  TlFunction = object
    params: seq[TlField]
    # Return value of the function is always a class
    retVal: string
    comment: string

func toCamelCase*(str: string, firstUpper = false): string =
  var makeUpper = firstUpper
  for i, c in str:
    if c == '_':
      makeUpper = true
    elif makeUpper:
      result.add(c.toUpperAscii())
      makeUpper = false
    else:
      result.add(c)


var classes = newTable[string, TlClass]()
var functions = newTable[string, TlFunction]()
var pairs: seq[tuple[name, typ: string]]
var comments = newTable[string, string]()
var classComment = ""
var inClass = false
var inFunctions = false

let parser = peg("tl"):
  S <- {'\9'..'\13',' '}

  nl <- *({'\9'..'\13',' ', '\n', '\r'})

  lets <- (Alnum | {'_', '<', '>'})

  entry <- >*lets * " " * >*(Print - {'\n', '@'}):
    let (name, val) = ($1, $2)
    # Special handling for class description because otherwise
    # it would get shadowed by following type declarations
    if name == "class":
      inClass = true
    elif name == "description" and inClass:
      classComment = val
      inClass = false
    else:
      comments[name] = val.strip()

  doccomment <- "//" * "@" * *(entry * ?"@") * *'\n'
  
  comment <- "//" * *(Print - '\n') * *'\n'

  funsection <- "---functions---" * *'\n':
    inFunctions = true
    inClass = false
  
  typ <- >+lets * ":" * >+lets:
    # Save name:type for that pair
    pairs.add(($1, $2))

  typedef <- >+lets * " " * *(typ * " ") * "=" * ?S * >+lets * ";" * *'\n':
    let curName = $1
    let class = $2
    # XXX: Do we need the second check at all?
    if not inFunctions:
      if class notin classes:
        classes[class] = TlClass(comment: classComment)
        classComment = ""
    else:
      functions[curName] = TlFunction(retVal: class)
    
    var fields: seq[TlField]

    # Add pairs for the current object
    for x in pairs:
      let comm = comments.getOrDefault(x.name)
      fields.add TlField(
        name: x.name,
        typ: x.typ,
        comment: comm,
        maybeNull: "may be null" in comm
      )
    
    # Add new object to the class
    let comm = comments.getOrDefault("description")
    if not inFunctions:
      classes[class].objs.add TlObj(name: curName, fields: fields, comment: comm)
    else:
      functions[curName].params = fields
      functions[curName].comment = comm
    # Clean pairs sequence
    pairs = @[]
    comments = newTable[string, string]()

  tl <- ?nl * *(doccomment | comment | typedef | funsection) * ?nl

let data = readFile("td_api.tl")
let match = parser.match(data)
doAssert match.ok == true

proc processType(name: string, maybeNull: bool): string = 
  # https://core.telegram.org/tdlib/docs/td__json__client_8h.html
  # We replace individual object names with base class name
  # since we currently use case objects
  for clsName, class in classes:
    for obj in class.objs:
      if obj.name == name:
        result = if maybeNull: &"Option[{clsName}]" else: clsName
        return
  result = case name
  of "int32": "int32"
  # max int value which can fit into json
  of "int53": "int64"
  # use strings there
  of "int64": "string"
  # base64 encoded - need to decode
  of "bytes": "string"
  of "Bool": "bool"
  of "string": "string"
  of "double": "float"
  else:
    # Handle vectors of vectors and just vectors (recursively)
    var vectype: string
    if scanf(name, "vector<vector<$+>>", vectype):
      "seq[seq[" & processType(vectype, false) & "]]"
    elif scanf(name, "vector<$+>", vectype):
      "seq[" & processType(vectype, false) & "]"
    else:
      name
  if maybeNull:
    result = &"Option[{result}]" 

proc processField(nimName, jsonName: string): string = 
  # Use "typ" instead of "type" because why not
  var name = if nimName == "type": "typ" else: nimName
  # workaround for syntax highlighting being broken (in my editor).
  # yes, really.
  let nameq = '"' & jsonName & '"'
  &"{name}* {{.jsonName: {nameq}.}}"

proc commonPrefixUtil(a, b: string): string = 
  for i in 0 ..< min(a.len, b.len):
    if a[i] == b[i]:
      result.add a[i]
    else:
      break

proc commonPrefix(data: seq[string]): string = 
  result = data[0]
  for i in 1 ..< data.len:
    result = commonPrefixUtil(result, data[i])

proc abbreviate(names: seq[string], obj: string): string =
  # Given class name and object name, makes a shorthand
  # abbreviation for the object kind in enum
  # E.g. given "NetworkType", "networkTypeMobileRoaming"
  # returns "ntMobileRoaming"
  # find the common prefix
  let prefix = commonPrefix(names)
  # uppercase first letter in it
  let prefix2 = prefix[0].toUpperAscii() & prefix[1..^1]
  # only get uppercase letters from the prefix for the abbreviation
  for c in prefix2:
    if c in {'A' .. 'Z'}:
      result.add c.toLowerAscii()
  # add object name without common prefix
  result.add obj.replace(prefix, "")

proc getSuffix(clsName, objname, abrev: string): string = 
  let suff = objname.replace(clsname[0].toLowerAscii() & clsname[1..^1], "")
  result = suff[0..min(3, suff.len - 1)].toLowerAscii()

proc uniquate(clsName, objName, field: string): string = 
  # clsName -> Update, objName -> updateNewMessage
  # field -> chatId
  let clslower = clsName[0].toLowerAscii() & clsName[1..^1] # update
  let suff = objName.replace(clslower, "") # NewMessage
  result = ""
  for c in suff:
    if c in {'A' .. 'Z'}:
      result.add c.toLowerAscii()
  if result.len == 1:
    result = objName[0..^3].toLowerAscii()
  # result -> nm
  result.add field.toUpperAscii()[0] & field[1..^1]
  # result -> nmChatId

proc makeSingleObj(clsName: string, class: TlClass): string =
  let obj = class.objs[0]
  result.add "  " & clsName & "* = object\n"
  if obj.comment != "":
    result.add "    ## " & obj.comment & "\n"
  # No reason to export kind for simple objects
  # since we'll operate on Nim types after all
  result.add "    kind {.jsonName: \"@type\".}: string\n" 
  for field in obj.fields:
    let name = processField(field.name.toCamelCase(), field.name)
    let typ = processType(field.typ, field.maybeNull)
    let comment = if field.comment != "":
      " ## " & field.comment
    else: ""
    result.add "    " & name & ": " & typ & comment & "\n"

proc makeCaseObj(clsName: string, class: TlClass): string = 
  let objs = class.objs
  var enumvals = newTable[string, string]()
  for obj in objs:
    enumvals[obj.name] = abbreviate(objs.mapIt(it.name), obj.name)
  # enum name
  let enumName = clsName & "Kind"
  result.add "  " & enumName & "* {.pure.} = enum\n"
  # enum members
  for key, val in enumvals:
    result.add fmt"    {val} = " & '"' & key & "\"," & "\n"
  result.add "\n"
  # object name
  result.add "  " & clsName & "* = object\n"
  if class.comment != "":
    result.add "    ## " & class.comment & "\n"
  # kind field for the object variant
  result.add "    case kind* {.jsonName: \"@type\".}: " & enumName & "\n"
  for obj in objs:
    # generate branch
    result.add "    of " & enumvals[obj.name] & ":\n"
    if obj.comment != "":
      result.add "      ## " & obj.comment & "\n"
    # empty branch - no fields
    if obj.fields.len == 0: 
      result.add "      discard\n"
      continue
    for field in obj.fields:
      let uniqName = uniquate(clsName, obj.name, toCamelCase(field.name))
      let name = processField(uniqName, field.name)
      let typ = processType(field.typ, field.maybeNull)
      let comment = if field.comment != "":
        " ## " & field.comment
      else: ""
      result.add "      " & name & ": " & typ & comment & "\n"

var outFile = open("types.nim", fmWrite)

import std/[times, sha1, os]

const gitRev = 
  if dirExists(".git") and gorgeEx("git status").exitCode == 0:
    staticExec("git rev-parse HEAD")
  else: "unknown"

outFile.writeLine fmt"""
# This file was automatically generated by tdgen.nim
# Do not modify it directly - fix tdgen.nim instead!
# Generated on {now()}
# td_api.tl sha1sum - {toLowerAscii $secureHash("data")}
# Git hash - {gitRev}
"""
outFile.writeLine "import json_custom, options, json, tables"
outFile.writeLine "export json_custom, options, json"
outFile.writeLine "\ntype"
for clsName, class in classes:
  if class.objs.len == 1:
    outFile.writeLine makeSingleObj(clsName, class)
  else:
    outFile.writeLine makeCaseObj(clsName, class)

proc makeFunctions(): string = 
  result.add "  TdlibFutureKind = enum\n"
  # func return val -> enum member
  var enumvals = newTable[string, string]()
  # enum
  for name, fun in functions:
    if fun.retVal in enumvals: continue

    enumvals[fun.retVal] = "tf" & fun.retVal
    result.add "    " & enumvals[fun.retVal] & ",\n"

  result.add "\n  TdlibFuture = ref object\n"
  result.add "    case kind: TdlibFutureKind\n"
  # object variant
  for retVal, enumVal in enumvals:
    result.add "    of " & enumVal & ":"
    result.add " " & retVal.toLowerAscii() & ": " & retVal & "\n"
  result.add """
  TdlibEntry = tuple
    kind: TdlibFutureKind
    fut: Future[TdlibFuture]
# TODO: Is this the best/most efficient way?
var futs = newTable[int, TdlibEntry]()

template waitFut(client, kind, field: untyped): untyped = 
  let fut = newFuture[TdlibFuture]()
  futs[client.counter] = (kind, fut)
  let tdlibFut = await fut
  tdlibFut.field

proc completeFut(event: sink JsonNode) = 
  # TODO: Ideally this check shouldn't be there and *all* events we receive
  # should have that field (except updates of course)
  if "@extra" notin event:
    return
  # Get the index of the future
  let idx = parseInt(event["@extra"].getStr())
  event.delete("@extra")
  let waitingFut = futs[idx]
  var completedFut = TdlibFuture(kind: waitingFut.kind)
  case completedFut.kind
"""

#[
  case completedFut.kind
  of tfMessage:
    completedFut.msg = event.toCustom(Message)
  of tfSeconds:
    completedFut.secs = event.toCustom(Seconds)
  of tfOk:
    discard
]#

  for retVal, enumVal in enumvals:
    result.add "  of " & enumVal & ":\n"
    result.add &"    completedFut.{retVal.toLowerAscii()} = event.toCustom({retVal})\n"

  result.add """
  futs.del(idx)
  waitingFut.fut.complete completedFut

"""

  # functions
  for name, fun in functions:
    var procParams = @["client: TdlibClient"]
    var jsonParams = @[fmt"""    "@type": "{name}" """]
    for param in fun.params:
      var name = toCamelCase(param.name).multiReplace({
        "type": "typ", "method": "metod"
      })

      let typ = processType(param.typ, false)
      if not param.maybeNull:
        procParams.add fmt"{name}: {typ}"
      else:
        procParams.add fmt"{name} = none({typ})"
      jsonParams.add fmt""""{param.name}": {name}"""
    
    let retType = processType(fun.retVal, false)
    result.add "proc " & name & "*(" & procParams.join(", ")
    result.add "): Future[" & retType & "] {.async.} = \n"
    result.add "  ## " & fun.comment & "\n"
    for field in fun.params:
      result.add &"  ## **{field.name}** - {field.comment}\n" 
    result.add "  client.send %*{\n"
    # "@type": "editInlineMessageText"
    result.add jsonParams.join(", \n    ")
    result.add "\n  }\n"

    #  result = client.waitFut(tfAuthorizationState, authorizationstate)
    result.add "  result = client.waitFut(" & enumvals[fun.retVal] & ", "
    result.add fun.retVal.toLowerAscii() & ")\n\n"

outFile.writeLine makeFunctions()

when false:
  type
    TdlibFutureKind = enum
      tfMessage,
      tfSeconds,
      tfAuthorizationState
      tfOk
    
    TdlibFuture = ref object
      case kind: TdlibFutureKind
      of tfMessage: 
        message: Message
      of tfSeconds: 
        seconds: Seconds
      of tfAuthorizationState:
        authorizationstate: AuthorizationState
      of tfOk: 
        ok: Ok
    
    TdlibEntry = tuple
      kind: TdlibFutureKind
      fut: Future[TdlibFuture]

  # TODO: Is this the best/most efficient way?
  var futs = newTable[int, TdlibEntry]()

  template waitFut(client, kind, field: untyped): untyped = 
    let fut = newFuture[TdlibFuture]()
    futs[client.counter] = (kind, fut)
    let tdlibFut = await fut
    tdlibFut.field

  proc getAuthorizationState*(client: TdlibClient): Future[AuthorizationState] {.async.} = 
    client.send %*{
      "@type": "getAuthorizationState"
    }
    result = client.waitFut(tfAuthorizationState, authorizationstate)

  proc setTdlibParameters*(client: TdlibClient, parameters: TdlibParameters): Future[Ok] {.async.} = 
    client.send %*{
      "@type": "setTdlibParameters",
      "parameters": parameters
    }
    result = client.waitFut(tfOk, ok)
