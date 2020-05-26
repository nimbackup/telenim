# I know this code is really, really far from perfect,
# maybe I should've used macros to properly operate on AST instead
# of strings, but the thing is that we don't need to generate definitions
# every day, we just need to generate them *once* for one tdlib version
# so this code is pretty rough and it's made to complete that task
# TODO:
# - How do make comments for different branches of an object variant?
# - A few name conflicts in object variants with a lot of branches, maybe detect that
# somehow?

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
    maybeNull: bool
  
  TlObj = object
    name: string
    fields: seq[TlField]
    comment: string
  
  TlClass = object
    objs: seq[TlObj]
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


var tabl = newTable[string, TlClass]()
var pairs: seq[tuple[name, typ: string]]
var comments = newTable[string, string]()
var classComment = ""
var inClass = false

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
  
  typ <- >+lets * ":" * >+lets:
    # Save name:type for that pair
    pairs.add(($1, $2))

  typedef <- >+lets * " " * *(typ * " ") * "=" * ?S * >+lets * ";" * *'\n':
    let curName = $1
    let class = $2

    if class notin tabl:
      tabl[class] = TlClass(comment: classComment)
      classComment = ""
    
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
    tabl[class].objs.add TlObj(name: curName, fields: fields, comment: comm)
    # Clean pairs sequence
    pairs = @[]
    comments = newTable[string, string]()

  tl <- ?nl * *(doccomment | comment | typedef) * ?nl

let data = readFile("td_api.tl")

let dd = parser.match(data)

proc processType(name: string, maybeNull: bool): string = 
  # https://core.telegram.org/tdlib/docs/td__json__client_8h.html
  # We replace individual object names with base class name
  # since we currently use case objects
  for clsName, class in tabl:
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

var outFile = open("tdlib_types.nim", fmWrite)

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
outFile.writeLine "import json_custom, options, json"
outFile.writeLine "export json_custom, options, json"
outFile.writeLine "\ntype"
for clsName, class in tabl:
  if class.objs.len == 1:
    outFile.writeLine makeSingleObj(clsName, class)
  else:
    outFile.writeLine makeCaseObj(clsName, class)