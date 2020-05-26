import asyncdispatch, strutils, os, strformat

import mathexpr

import telenim

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
    }, false)
  of asWaitEncryptionKey:
    discard await client.checkDatabaseEncryptionKey("")
  of asWaitPhoneNumber:
    discard await client.setAuthenticationPhoneNumber(
      Phone, phoneNumberAuthenticationSettings(false, true, false).toCustom(PhoneNumberAuthenticationSettings)
    )
  of asWaitCode:
    stdout.write "enter auth code: "
    let code = stdin.readLine()
    discard await client.checkAuthenticationCode(code)
  of asWaitRegistration:
    echo "Registration not implemented yet"
    quit(1)
  of asWaitPassword:
    discard await client.checkAuthenticationPassword(Password)
  else:
    echo authState

import mathexpr, tables

proc editMsg(client: TdlibClient, msg: Message, text: string): Future[Message] {.async.} = 
  result = await client.editMessageText(
    msg.chatId, msg.id,
    inputMessageText(
      formattedText(text, @[]).toCustom(FormattedText), true, false
    ).toCustom(InputMessageContent)
  )
  #[
  client.send(%*{
    "@type": "editMessageText",
    "chat_id": msg.chatId,
    "message_id": msg.id,
    "input_message_content": {
      "@type": "inputMessageText",
      "text": {
        "@type": "formattedText",
        "text": text
      }
    }
  })
  result = client.waitFut(tfMessage, message)
  ]#

proc handleMsgUpdate(client: TdlibClient, update: Update): Future[bool] {.async.} = 
  result = true
  let msg = update.nmMessage
  if not msg.isOutgoing:
    return
  let cid = msg.chatId
  let mid = msg.id
  let replyId = msg.replyToMessageId
  let msgText = if msg.content.kind == mText:
    msg.content.messageteText.text else: ""
  if msgText.len == 0 or msgText[0] != '.':
    return
  let parts = msgText[1..^1].split(Whitespace)
  if parts.len == 0: return
  case parts[0]
  of "status":
    echo await client.editMsg(msg, "All up and running!")
  of "version":
    const gitRev = 
      if dirExists(".git") and gorgeEx("git status").exitCode == 0:
        staticExec("git rev-parse HEAD")
      else: "unknown"

    echo await client.editMsg(msg, fmt"""Telenim userbot example
    Git hash - {gitRev}
    Compiled on {CompileDate} {CompileTime}""".unindent)
  of "solve":
    let expr = parts[1..^1].join(" ")
    let e = newEvaluator()
    
    try:
      let res = e.eval(expr)
      echo await client.editMsg(msg, expr & " = " & $res)
    except:
      echo await client.editMsg(msg, "Not a valid math expression!")
  of "count":
    if parts.len < 2:
      discard await client.editMsg(msg, "Usage: .count {to: int}")
      return
    let countTo = parts[1]
    try:
      let to = countTo.parseInt()
      for i in 0 ..< to:
        discard await client.editMsg(msg, fmt"{i}")

    except:
      discard await client.editMsg(msg, "Usage: .count {to: int}")
  of "tell":
    for part in 1 ..< parts.len:
      discard await client.editMsg(msg, parts[part])
      await sleepAsync(100)
    discard await client.editMsg(msg, parts[1..^1].join(" "))
  of "oof":
    if parts.len < 2:
      discard await client.editMsg(msg, "Usage: .oof {count: int}")
    else:
      var data = "oo"
      for i in 0 .. parseInt(parts[1]):
        discard await client.editMsg(msg, data & "f")
        data &= "o"
  of "repeat":
    if parts.len < 3:
      discard await client.editMsg(msg, "Usage: .repeat {message} {count:int}")
    let cnt = parts[^1].parseInt()
    #for i in 0 ..< cnt:
    #  discard await client.send %*{
    #    "@type": "sendMessage",
  
  of "chatid":
    discard await client.editMsg(msg, "This chat's ID: " & $msg.chatId)
  of "ping":
    let ping = await client.pingProxy(0)
    discard await client.editMsg(msg, $(ping.seconds * 1000))

proc handleEvent(client: TdlibClient, event: JsonNode): Future[bool] {.async.} =
  result = true
  let typ = event["@type"].getStr()
  # TODO: Is this check correct?
  if typ.startsWith("update"):
    let update = event.toCustom(Update)
    case update.kind
    of uAuthorizationState:
      result = await client.handleAuth(update)
    of uNewMessage:
      result = await client.handleMsgUpdate(update)
    else:
      discard
  completeFut(event)

proc main {.async.} =
  let client = newTdlibClient()

  while true:
    let event = await client.getEvent()
    asyncCheck client.handleEvent(event)

waitFor main()