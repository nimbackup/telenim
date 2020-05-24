# I know this code is really far from perfect,
# maybe I should've used macros to properly operate on AST instead
# of strings, but the thing is that we don't need to generate definitions
# every day, we just need to generate them *once* for one tdlib version
# so this code is pretty rough and it's made to complete that task
import parseutils, strutils, strformat, strscans, tables

let data = open("td_api.tl", fmRead)

var i = 0
var line: string

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

type
  TlField = object
    name: string
    typ: string
  
  TlObj = object
    name: string
    fields: seq[TlField]
  
  TlClass = object
    objs: seq[TlObj]

var tabl = newTable[string, TlClass]()

when false:
  proc makeNimType(): string = 
    result = fmt"  {hdr.name} = object of TlBase"
    for field in fields:
      var fname = field.name
      if fname == "type": fname = "`" & fname & "`"
      result.add "\n    " & fname & "*: " & toNimType(field.typ)

import npeg, tables

var pairs: seq[tuple[name, typ: string]]

let parser = peg("tl"):
  S <- {'\9'..'\13',' '}

  nl <- *({'\9'..'\13',' ', '\n', '\r'})

  lets <- (Alnum | {'_', '<', '>'})

  comment <- "//" * *(Print - '\n') * *'\n'
  
  typ <- >+lets * ":" * >+lets:
    # Save name:type for that pair
    pairs.add(($1, $2))


  typedef <- >+lets * " " * *(typ * " ") * "=" * ?S * >+lets * ";" * *'\n':
    let curName = $1
    let class = $2

    if class notin tabl:
      tabl[class] = TlClass()
    
    var fields: seq[TlField]

    # Add pairs for the current object
    for x in pairs:
      fields.add TlField(name: x.name, typ: x.typ)
    
    # Add new object to the class
    tabl[class].objs.add TlObj(name: curName, fields: fields)
    # Clean pairs sequence
    pairs = @[]

  tl <- ?nl * *(comment | typedef) * ?nl

let datas = readFile("td_api.tl")

let dd = parser.match(datas)

proc processType(name: string): string = 
  # https://core.telegram.org/tdlib/docs/td__json__client_8h.html
  for clsName, class in tabl:
    for obj in class.objs:
      if obj.name == name:
        return clsName
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
      "seq[seq[" & processType(vectype) & "]]"
    elif scanf(name, "vector<$+>", vectype):
      "seq[" & processType(vectype) & "]"
    else:
      name

proc processField(name: string): string = 
  # Use "typ" instead of "type" because why not
  var name = if name == "type": "typ" else: name
  let camel = toCamelCase(name)
  if camel == name:
    name & "*"
  else:
    &"{camel}* {{.jsonName: \"{name}\".}}"

proc makeSingleObj(clsName: string, obj: TlObj): string = 
  result.add "  " & clsName & " = object\n"
  # No reason to export kind for simple objects
  # since we'll operate on Nim types after all
  result.add "    kind {.jsonName: \"@type\".}: string\n" 
  for field in obj.fields:
    let name = processField(field.name)
    let typ = processType(field.typ)
    # If camelCase and snake_case variants are identical
    # (usually only happens for one-word names)
    result.add "    " & name & ": " & typ & "\n"

proc abbreviate(cls, name: string): string =
  # Given class name and object name, makes a shorthand
  # abbreviation for the object kind in enum
  # E.g. given "NetworkType", "networkTypeMobileRoaming"
  # returns "ntMobileRoaming"
  let lowercls = cls[0].toLowerAscii() & cls[1..^1]
  var abbrv = ""
  for chr in cls:
    if chr in {'A' .. 'Z'}:
      abbrv.add chr.toLowerAscii()
  result = abbrv & name.replace(lowercls, "")

proc makeCaseObj(clsName: string, objs: seq[TlObj]): string = 
  var enumvals = newTable[string, string]()
  for obj in objs:
    enumvals[obj.name] = abbreviate(clsName, obj.name)
  let enumName = clsName & "Kind"
  result.add "  " & enumName & " = enum\n"

  for key, val in enumvals:
    result.add fmt"    {val} = " & '"' & key & "\"," & "\n"
  result.add "\n"
  result.add "  " & clsName & " = object\n"
  # No reason to export kind for simple objects
  # since we'll operate on Nim types after all
  if objs.len > 0:
    result.add "    case kind* {.jsonName: \"@type\".}: " & enumName & "\n"
  for obj in objs:
    result.add "    of " & enumvals[obj.name] & ":\n"
    if obj.fields.len == 0: 
      result.add "      discard\n"
      continue
    for field in obj.fields:
      let name = processField(field.name)
      let typ = processType(field.typ)
      # If camelCase and snake_case variants are identical
      # (usually only happens for one-word names)
      result.add "      " & name & ": " & typ & "\n"

echo "type"
for clsName, class in tabl:
  # Simple - use class name for the object,
  # no need for any case objects
  if class.objs.len == 1:
    echo makeSingleObj(clsName, class.objs[0])
  else:
    echo makeCaseObj(clsName, class.objs)