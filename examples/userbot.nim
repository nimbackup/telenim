import std / [asyncdispatch, strutils, os, strformat, tables]
import mathexpr
import telenim

template dawait(data: untyped): untyped = discard await data

proc parseConfig(path: string): (string, string, int32, string) = 
  let a = parseJson(staticRead(path))
  (
    a["phone"].getStr(),
    a{"password"}.getStr(""),
    int32 a["api_id"].getInt(),
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
    dawait client.setTdlibParameters(
      tdlibParameters(
        useTestDc = false,
        filesDirectory = "tdlib",
        useFileDatabase = false,
        useChatInfoDatabase = false,
        useMessageDatabase = false,
        ignoreFileNames = false,
        databaseDirectory = "tdlib",
        useSecretChats = true,
        apiId = ApiId,
        apiHash = ApiHash,
        systemLanguageCode = "en",
        deviceModel = "Desktop",
        systemVersion = "Linux",
        applicationVersion = "0.1",
        enableStorageOptimizer = true
      )
    )
  of asWaitEncryptionKey:
    dawait client.checkDatabaseEncryptionKey("")
  of asWaitPhoneNumber:
    dawait client.setAuthenticationPhoneNumber(
      Phone, phoneNumberAuthenticationSettings(false, true, false)
    )
  of asWaitCode:
    stdout.write "enter auth code: "
    let code = stdin.readLine()
    dawait client.checkAuthenticationCode(code)
  of asWaitRegistration:
    echo "Registration not implemented yet"
    quit(1)
  of asWaitPassword:
    dawait client.checkAuthenticationPassword(Password)
  else:
    echo authState

proc editMsg(client: TdlibClient, msg: Message, text: string): Future[Message] {.async.} = 
  result = await client.editMessageText(
    msg.chatId, msg.id,
    inputMessageText(
      formattedText(text, @[]).toCustom(FormattedText), true, false
    )
  )

proc handleMsgUpdate(client: TdlibClient, update: Update): Future[bool] {.async.} = 
  result = true
  let msg = update.nmMessage
  if not msg.isOutgoing:
    return
  let msgText = if msg.content.kind == mText:
    msg.content.messageteText.text else: ""
  if msgText.len == 0 or msgText[0] != '.':
    return
  let parts = msgText[1..^1].split(Whitespace)
  if parts.len == 0: return
  case parts[0]
  of "status":
    dawait client.editMsg(msg, "All up and running!")
  of "version":
    const gitRev = 
      if dirExists(".git") and gorgeEx("git status").exitCode == 0:
        staticExec("git rev-parse HEAD")
      else: "unknown"

    dawait client.editMsg(msg, fmt"""Telenim userbot example
    Git hash - {gitRev}
    Compiled on {CompileDate} {CompileTime}""".unindent)
  of "solve":
    let expr = parts[1..^1].join(" ")
    let e = newEvaluator()
    
    try:
      let res = e.eval(expr)
      dawait client.editMsg(msg, expr & " = " & $res)
    except:
      dawait client.editMsg(msg, "Not a valid math expression!")
  of "count":
    if parts.len < 2:
      dawait client.editMsg(msg, "Usage: .count {to: int}")
      return
    let countTo = parts[1]
    try:
      let to = countTo.parseInt()
      for i in 1 .. to:
        dawait client.editMsg(msg, fmt"{i}")

    except:
      dawait client.editMsg(msg, "Usage: .count {to: int}")
  of "tell":
    for part in 1 ..< parts.len:
      dawait client.editMsg(msg, parts[part])
      await sleepAsync(100)
    dawait client.editMsg(msg, parts[1..^1].join(" "))
  of "oof":
    if parts.len < 2:
      dawait client.editMsg(msg, "Usage: .oof {count: int}")
    else:
      var data = "oo"
      for i in 0 .. parseInt(parts[1]):
        dawait client.editMsg(msg, data & "f")
        data &= "o"
  of "repeat":
    if parts.len < 3:
      dawait client.editMsg(msg, "Usage: .repeat {message} {count:int}")
    let cnt = parts[^1].parseInt()
    #for i in 0 ..< cnt:
    #  dawait client.send %*{
    #    "@type": "sendMessage",
  
  of "chatid":
    dawait client.editMsg(msg, "This chat's ID: " & $msg.chatId)
  of "ping":
    let ping = await client.pingProxy(0)
    dawait client.editMsg(msg, $(ping.seconds * 1000))

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