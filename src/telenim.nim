import json, os, asyncdispatch, strutils

import telenim/types
export types

const
  tdlib = "lib" / "libtdjson.so(|.1.6.0)"

{.push importc, dynlib: tdlib.}
proc td_json_client_create(): pointer
proc td_json_client_send(client: pointer, request: cstring)
proc td_json_client_receive(client: pointer, timeout: cdouble): cstring
proc td_json_client_execute(client: pointer, request: cstring): cstring
proc td_json_client_destroy(client: pointer)
{.pop.}

proc execute(query: JsonNode): JsonNode =
  let query = cstring($query)
  let res = td_json_client_execute(nil, query)
  if not res.isNil():
    result = parseJson($res)

type
  TdlibClientObj = object
    alive: bool
    impl: pointer
  
  TdlibClient* = ref TdlibClientObj

proc send*(client: TdlibClient, query: JsonNode) =
  td_json_client_send(client.impl, $query)

proc receive*(client: TdlibClient, timeout: float): JsonNode =
  let res = td_json_client_receive(client.impl, timeout)
  if not res.isNil():
    result = parseJson($res)

var 
  passingChannel: Channel[JsonNode]
  tdlibThread: Thread[(TdlibClient)]

proc `=destroy`(x: var TdlibClientObj) = 
  if x.alive == true:
    joinThread(tdlibThread)
    passingChannel.close()
    td_json_client_destroy(x.impl)
    x.alive = false

proc close*(x: TdlibClient) = 
  `=destroy`(x[])

proc tdlibProcess(client: (TdlibClient)) {.thread.} = 
  while true:
    let event = client.receive(0.01)
    if not event.isNil():
      passingChannel.send(event)

proc newTdlibClient*(loggingLevel = 1): TdlibClient = 
  ## Creates a new TDLib client instance
  result = TdlibClient(impl: td_json_client_create(), alive: true)
  passingChannel.open()
  createThread(tdlibThread, tdlibProcess, result)
  
  # Set logging to errors only
  result.send(%*{
    "@type": "setLogVerbosityLevel",
    "new_verbosity_level": loggingLevel
  })

proc getEvent*(client: TdlibClient): Future[JsonNode] {.async.} = 
  ## A loop which runs until it receives actual data
  ## and then returns it. If there's no data - sleeps for 10 ms
  while true:
    let event = passingChannel.tryRecv()
    if event.dataAvailable:
      return event.msg
    await sleepAsync(10)