import parseutils, strutils, strformat, strscans

let data = open("td_api.tl", fmRead)

var i = 0
var line: string

proc toNimType(data: string): string = 
  # https://core.telegram.org/tdlib/docs/td__json__client_8h.html
  result = case data
  of "int32": "int32"
  # max int value which can fit into json
  of "int53": "int64"
  # use strings there
  of "int64": "string"
  # base64 encoded - need to decode
  of "bytes": "string"
  of "Bool": "bool"
  of "string": "string"
  else:
    # Handle vectors of vectors and just vectors (recursively)
    var vectype: string
    if scanf(data, "vector<vector<$+>>", vectype):
      "seq[seq[" & toNimType(vectype) & "]]"
    elif scanf(data, "vector<$+>", vectype):
      "seq[" & toNimType(vectype) & "]"
    else:
      data

proc makeNimType(hdr: tuple[name, class: string], fields: seq[tuple[name: string, typ: string]]): string = 
  result = fmt"  {hdr.name} = object of TlBase"
  for field in fields:
    var fname = field.name
    if fname == "type": fname = "`" & fname & "`"
    result.add "\n    " & fname & "*: " & toNimType(field.typ)

import npeg, tables



var tabl = newTable[(string, string), seq[tuple[name, typ: string]]]()

var pairs: seq[tuple[name, typ: string]]

let parser = peg("tl"):
  S <- {'\9'..'\13',' '}

  nl <- *({'\9'..'\13',' ', '\n', '\r'})

  lets <- (Alnum | {'_', '<', '>'})


  comment <- "//" * *(Print - '\n') * *'\n'
  
  typ <- >+lets * ":" * >+lets:
    pairs.add(($1, $2))


  typedef <- >+lets * " " * *(typ * " ") * "=" * ?S * >+lets * ";" * *'\n':
    let curName = $1
    let class = $2
    if (curName, class) notin tabl:
      tabl[(curName, class)] = @[]
    for x in pairs:
      tabl[(curName, class)].add (x.name, toNimType(x.typ))
    pairs = @[]

  tl <- ?nl * *(comment | typedef) * ?nl

let datas = readFile("td_api.tl")

let dd = parser.match(datas)
echo "type"
echo """  TlBase = object of RootObj
    `@type`: string
"""
for key, val in tabl:
  echo makeNimType(key, val)
  echo ""