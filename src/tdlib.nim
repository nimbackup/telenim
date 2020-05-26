import json, os, strformat, asyncdispatch, strutils

import tdlib_types
const
  tdlib = "lib" / "libtdjson.so(|.1.6.0)"

proc parseConfig(path: string): (string, string, string, string) = 
  let a = parseJson(staticRead(path))
  (
    a["phone"].getStr(), 
    a{"password"}.getStr(""), 
    a["api_id"].getStr(), 
    a["api_hash"].getStr()
  )

# TODO: Use parsetoml with proper runtime config?
const (Phone, Password, ApiId, ApiHash) = parseConfig("config.json")

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
  
  TdlibClient = ref TdlibClientObj

proc send(client: TdlibClient, query: JsonNode) =
  td_json_client_send(client.impl, $query)

proc receive(client: TdlibClient, timeout: float): JsonNode =
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

proc close(x: TdlibClient) = 
  `=destroy`(x[])

proc tdlibProcess(client: (TdlibClient)) {.thread.} = 
  while true:
    let event = client.receive(0.01)
    if not event.isNil():
      passingChannel.send(event)

proc newTdlibClient(loggingLevel = 1): TdlibClient = 
  result = TdlibClient(impl: td_json_client_create(), alive: true)
  passingChannel.open()
  createThread(tdlibThread, tdlibProcess, result)
  
  # Set logging to errors only
  result.send(%*{
    "@type": "setLogVerbosityLevel",
    "new_verbosity_level": loggingLevel
  })

proc handleAuth(client: TdlibClient, update: Update): Future[bool] {.async.} = 
  result = true
  let authState = update.asAuthorizationState

  case authState.kind
  of asClosed:
    result = false
  
  of asWaitTdlibParameters:
    client.send(%*{
      "@type": "setTdlibParameters", "parameters": {
        "database_directory": "tdlib",
        "use_message_database": true,
        "use_secret_chats": true,
        "api_id": ApiId,
        "api_hash": ApiHash,
        "system_language_code": "en",
        "device_model": "Desktop",
        "system_version": "Linux",
        "application_version": "1.0",
        "enable_storage_optimizer": true
      }
    })
  of asWaitEncryptionKey:
    client.send(%*{"@type": "checkDatabaseEncryptionKey", "encryption_key": ""})
  of asWaitPhoneNumber:
    client.send(%*{"@type": "setAuthenticationPhoneNumber", "phone_number": Phone})
  of asWaitCode:
    stdout.write "enter auth code: "
    let code = stdin.readLine()
    client.send(%*{"@type": "checkAuthenticationCode", "code": code})
  of asWaitRegistration:
    echo "Registration not implemented yet"
    quit(1)
  of asWaitPassword:
    client.send(%*{"@type": "checkAuthenticationPassword", "password": Password})
  else:
    echo authState

import mathexpr

proc handleMsgUpdate(client: TdlibClient, update: Update): Future[bool] {.async.} = 
  result = true
  # We only need to process our own messages
  let msg = update.nmMessage
  if not msg.isOutgoing:
    return
  let cid = msg.chatId
  let mid = msg.id
  let msgText = if msg.content.kind == mText:
    msg.content.messageteText.text else: ""
  #echo event.pretty()
  case msgText
  of ".status":
    client.send(%*{
      "@type": "editMessageText",
      "chat_id": cid,
      "message_id": mid,
      "input_message_content": {
        "@type": "inputMessageText",
        "text": {
          "@type": "formattedText",
          "text": "All up and running!"
        }
      }
    })
  else:
    discard
  if msgText.startsWith ".solve":
    let expr = msgText.split(".solve ")[1]
    let e = newEvaluator()
    
    try:
      let res = e.eval(expr)
      client.send(%*{
        "@type": "editMessageText",
        "chat_id": cid,
        "message_id": mid,
        "input_message_content": {
          "@type": "inputMessageText",
          "text": {
            "@type": "formattedText",
            "text": expr & " = " & $res
          }
        }
      })
    except:
      client.send(%*{
        "@type": "editMessageText",
        "chat_id": cid,
        "message_id": mid,
        "input_message_content": {
          "@type": "inputMessageText",
          "text": {
            "@type": "formattedText",
            "text": "Not a valid math expression!"
          }
        }
      })

proc handleEvent(client: TdlibClient, event: JsonNode): Future[bool] {.async.} =
  result = true
  let typ = event["@type"].getStr()
  if typ.startsWith("update"):
    echo "trying to deserialize..."
    echo event.pretty()
    let update = event.toCustom(Update)
    if update.kind == uAuthorizationState:
      echo "before auth"
      result = await client.handleAuth(update)
    elif update.kind == uNewMessage:
      echo "before new msg"
      result = await client.handleMsgUpdate(update)

proc getEvent(client: TdlibClient): Future[JsonNode] {.async.} = 
  # A loop which runs until it receives actual data
  # and then returns it. If there's no data - sleeps for 10 ms
  while true:
    let event = passingChannel.tryRecv()
    if event.dataAvailable:
      return event.msg
    await sleepAsync(10)

proc main {.async.} =
  let client = newTdlibClient()

  while true:
    let event = await client.getEvent()
    asyncCheck client.handleEvent(event)

waitFor main()