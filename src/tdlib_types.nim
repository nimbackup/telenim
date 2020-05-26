import json_custom, options, json
export json_custom, options, json

type
  PollOption * = object
    ## Describes one answer option of a poll
    kind {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: string ## Option text, 1-100 characters
    voterCount* {.jsonName: "voter_count".}: int32 ## Number of voters for this option, available only for closed or voted polls
    votePercentage* {.jsonName: "vote_percentage".}: int32 ## The percentage of votes for this option, 0-100
    isChosen* {.jsonName: "is_chosen".}: bool ## True, if the option was chosen by the user
    isBeingChosen* {.jsonName: "is_being_chosen".}: bool ## True, if the option is being chosen by a pending setPollAnswer request

  PaymentReceipt * = object
    ## Contains information about a successful payment
    kind {.jsonName: "@type".}: string
    date* {.jsonName: "date".}: int32 ## Point in time (Unix timestamp) when the payment was made
    paymentsProviderUserId* {.jsonName: "payments_provider_user_id".}: int32 ## User identifier of the payment provider bot
    invoice* {.jsonName: "invoice".}: Invoice ## Contains information about the invoice
    orderInfo* {.jsonName: "order_info".}: Option[OrderInfo] ## Contains order information; may be null
    shippingOption* {.jsonName: "shipping_option".}: Option[ShippingOption] ## Chosen shipping option; may be null
    credentialsTitle* {.jsonName: "credentials_title".}: string ## Title of the saved credentials

  CheckChatUsernameResultKind * {.pure.} = enum
    ccurPublicChatsTooMuch = "checkChatUsernameResultPublicChatsTooMuch",
    ccurUsernameOccupied = "checkChatUsernameResultUsernameOccupied",
    ccurUsernameInvalid = "checkChatUsernameResultUsernameInvalid",
    ccurPublicGroupsUnavailable = "checkChatUsernameResultPublicGroupsUnavailable",
    ccurOk = "checkChatUsernameResultOk",

  CheckChatUsernameResult * = object
    ## Represents result of checking whether a username can be set for a chat
    case kind* {.jsonName: "@type".}: CheckChatUsernameResultKind
    of ccurOk:
      ## The username can be set
      discard
    of ccurUsernameInvalid:
      ## The username is invalid
      discard
    of ccurUsernameOccupied:
      ## The username is occupied
      discard
    of ccurPublicChatsTooMuch:
      ## The user has too much chats with username, one of them should be made private first
      discard
    of ccurPublicGroupsUnavailable:
      ## The user can't be a member of a public supergroup
      discard

  TextEntityTypeKind * {.pure.} = enum
    tetItalic = "textEntityTypeItalic",
    tetMentionName = "textEntityTypeMentionName",
    tetHashtag = "textEntityTypeHashtag",
    tetCashtag = "textEntityTypeCashtag",
    tetBankCardNumber = "textEntityTypeBankCardNumber",
    tetBotCommand = "textEntityTypeBotCommand",
    tetEmailAddress = "textEntityTypeEmailAddress",
    tetMention = "textEntityTypeMention",
    tetPre = "textEntityTypePre",
    tetUrl = "textEntityTypeUrl",
    tetPhoneNumber = "textEntityTypePhoneNumber",
    tetTextUrl = "textEntityTypeTextUrl",
    tetBold = "textEntityTypeBold",
    tetStrikethrough = "textEntityTypeStrikethrough",
    tetPreCode = "textEntityTypePreCode",
    tetCode = "textEntityTypeCode",
    tetUnderline = "textEntityTypeUnderline",

  TextEntityType * = object
    ## Represents a part of the text which must be formatted differently
    case kind* {.jsonName: "@type".}: TextEntityTypeKind
    of tetMention:
      ## A mention of a user by their username
      discard
    of tetHashtag:
      ## A hashtag text, beginning with "#"
      discard
    of tetCashtag:
      ## A cashtag text, beginning with "$" and consisting of capital english letters (i.e. "$USD")
      discard
    of tetBotCommand:
      ## A bot command, beginning with "/". This shouldn't be highlighted if there are no bots in the chat
      discard
    of tetUrl:
      ## An HTTP URL
      discard
    of tetEmailAddress:
      ## An email address
      discard
    of tetPhoneNumber:
      ## A phone number
      discard
    of tetBankCardNumber:
      ## A bank card number. The getBankCardInfo method can be used to get information about the bank card
      discard
    of tetBold:
      ## A bold text
      discard
    of tetItalic:
      ## An italic text
      discard
    of tetUnderline:
      ## An underlined text
      discard
    of tetStrikethrough:
      ## A strikethrough text
      discard
    of tetCode:
      ## Text that must be formatted as if inside a code HTML tag
      discard
    of tetPre:
      ## Text that must be formatted as if inside a pre HTML tag
      discard
    of tetPreCode:
      ## Text that must be formatted as if inside pre, and code HTML tags
      pcLanguage* {.jsonName: "language".}: string ## Programming language of the code; as defined by the sender
    of tetTextUrl:
      ## A text description shown instead of a raw URL
      tuUrl* {.jsonName: "url".}: string ## HTTP or tg:// URL to be opened when the link is clicked
    of tetMentionName:
      ## A text shows instead of a raw mention of the user (e.g., when the user has no username)
      mnUserId* {.jsonName: "user_id".}: int32 ## Identifier of the mentioned user

  BotCommand * = object
    ## Represents a command supported by a bot
    kind {.jsonName: "@type".}: string
    command* {.jsonName: "command".}: string ## Text of the bot command
    description* {.jsonName: "description".}: string ## Represents a command supported by a bot

  BackgroundFillKind * {.pure.} = enum
    bfGradient = "backgroundFillGradient",
    bfSolid = "backgroundFillSolid",

  BackgroundFill * = object
    ## Describes a fill of a background
    case kind* {.jsonName: "@type".}: BackgroundFillKind
    of bfSolid:
      ## Describes a solid fill of a background
      backgroundfillsolColor* {.jsonName: "color".}: int32 ## A color of the background in the RGB24 format
    of bfGradient:
      ## Describes a gradient fill of a background
      backgroundfillgradieTopColor* {.jsonName: "top_color".}: int32 ## A top color of the background in the RGB24 format
      backgroundfillgradieBottomColor* {.jsonName: "bottom_color".}: int32 ## A bottom color of the background in the RGB24 format
      backgroundfillgradieRotationAngle* {.jsonName: "rotation_angle".}: int32 ## Clockwise rotation angle of the gradient, in degrees; 0-359. Should be always divisible by 45

  Users * = object
    ## Represents a list of users
    kind {.jsonName: "@type".}: string
    totalCount* {.jsonName: "total_count".}: int32 ## Approximate total count of users found
    userIds* {.jsonName: "user_ids".}: seq[int32] ## A list of user identifiers

  Call * = object
    ## Describes a call
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32 ## Call identifier, not persistent
    userId* {.jsonName: "user_id".}: int32 ## Peer user identifier
    isOutgoing* {.jsonName: "is_outgoing".}: bool ## True, if the call is outgoing
    state* {.jsonName: "state".}: CallState ## Call state

  BankCardInfo * = object
    ## Information about a bank card
    kind {.jsonName: "@type".}: string
    title* {.jsonName: "title".}: string ## Title of the bank card description
    actions* {.jsonName: "actions".}: seq[BankCardActionOpenUrl] ## Actions that can be done with the bank card number

  FoundMessages * = object
    ## Contains a list of messages found by a search
    kind {.jsonName: "@type".}: string
    messages* {.jsonName: "messages".}: seq[Message] ## List of messages
    nextFromSearchId* {.jsonName: "next_from_search_id".}: string ## Value to pass as from_search_id to get more results

  ChatsNearby * = object
    ## Represents a list of chats located nearby
    kind {.jsonName: "@type".}: string
    usersNearby* {.jsonName: "users_nearby".}: seq[ChatNearby] ## List of users nearby
    supergroupsNearby* {.jsonName: "supergroups_nearby".}: seq[ChatNearby] ## List of location-based supergroups nearby

  CallId * = object
    ## Contains the call identifier
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32 ## Call identifier

  CustomRequestResult * = object
    ## Contains the result of a custom request
    kind {.jsonName: "@type".}: string
    result* {.jsonName: "result".}: string ## A JSON-serialized result

  InputPassportElementErrorSourceKind * {.pure.} = enum
    ipeesTranslationFile = "inputPassportElementErrorSourceTranslationFile",
    ipeesFrontSide = "inputPassportElementErrorSourceFrontSide",
    ipeesDataField = "inputPassportElementErrorSourceDataField",
    ipeesFiles = "inputPassportElementErrorSourceFiles",
    ipeesTranslationFiles = "inputPassportElementErrorSourceTranslationFiles",
    ipeesFile = "inputPassportElementErrorSourceFile",
    ipeesSelfie = "inputPassportElementErrorSourceSelfie",
    ipeesReverseSide = "inputPassportElementErrorSourceReverseSide",
    ipeesUnspecified = "inputPassportElementErrorSourceUnspecified",

  InputPassportElementErrorSource * = object
    ## Contains the description of an error in a Telegram Passport element; for bots only
    case kind* {.jsonName: "@type".}: InputPassportElementErrorSourceKind
    of ipeesUnspecified:
      ## The element contains an error in an unspecified place. The error will be considered resolved when new data is added
      inputpassportelementerrorsourceunspecifiElementHash* {.jsonName: "element_hash".}: string ## Current hash of the entire element
    of ipeesDataField:
      ## A data field contains an error. The error is considered resolved when the field's value changes
      dfFieldName* {.jsonName: "field_name".}: string ## Field name
      dfDataHash* {.jsonName: "data_hash".}: string ## Current data hash
    of ipeesFrontSide:
      ## The front side of the document contains an error. The error is considered resolved when the file with the front side of the document changes
      fsFileHash* {.jsonName: "file_hash".}: string ## Current hash of the file containing the front side
    of ipeesReverseSide:
      ## The reverse side of the document contains an error. The error is considered resolved when the file with the reverse side of the document changes
      rsFileHash* {.jsonName: "file_hash".}: string ## Current hash of the file containing the reverse side
    of ipeesSelfie:
      ## The selfie contains an error. The error is considered resolved when the file with the selfie changes
      inputpassportelementerrorsourceselfFileHash* {.jsonName: "file_hash".}: string ## Current hash of the file containing the selfie
    of ipeesTranslationFile:
      ## One of the files containing the translation of the document contains an error. The error is considered resolved when the file with the translation changes
      tfFileHash* {.jsonName: "file_hash".}: string ## Current hash of the file containing the translation
    of ipeesTranslationFiles:
      ## The translation of the document contains an error. The error is considered resolved when the list of files changes
      tfFileHashes* {.jsonName: "file_hashes".}: seq[string] ## Current hashes of all files with the translation
    of ipeesFile:
      ## The file contains an error. The error is considered resolved when the file changes
      inputpassportelementerrorsourcefiFileHash* {.jsonName: "file_hash".}: string ## Current hash of the file which has the error
    of ipeesFiles:
      ## The list of attached files contains an error. The error is considered resolved when the file list changes
      inputpassportelementerrorsourcefilFileHashes* {.jsonName: "file_hashes".}: seq[string] ## Current hashes of all attached files

  ChatMembersFilterKind * {.pure.} = enum
    cmfBanned = "chatMembersFilterBanned",
    cmfMembers = "chatMembersFilterMembers",
    cmfAdministrators = "chatMembersFilterAdministrators",
    cmfContacts = "chatMembersFilterContacts",
    cmfBots = "chatMembersFilterBots",
    cmfRestricted = "chatMembersFilterRestricted",

  ChatMembersFilter * = object
    ## Specifies the kind of chat members to return in searchChatMembers
    case kind* {.jsonName: "@type".}: ChatMembersFilterKind
    of cmfContacts:
      ## Returns contacts of the user
      discard
    of cmfAdministrators:
      ## Returns the owner and administrators
      discard
    of cmfMembers:
      ## Returns all chat members, including restricted chat members
      discard
    of cmfRestricted:
      ## Returns users under certain restrictions in the chat; can be used only by administrators in a supergroup
      discard
    of cmfBanned:
      ## Returns users banned from the chat; can be used only by administrators in a supergroup or in a channel
      discard
    of cmfBots:
      ## Returns bot members of the chat
      discard

  PassportElements * = object
    ## Contains information about saved Telegram Passport elements
    kind {.jsonName: "@type".}: string
    elements* {.jsonName: "elements".}: seq[PassportElement] ## Telegram Passport elements

  JsonObjectMember * = object
    ## Represents one member of a JSON object
    kind {.jsonName: "@type".}: string
    key* {.jsonName: "key".}: string ## Member's key
    value* {.jsonName: "value".}: JsonValue ## Member's value

  EmailAddressAuthenticationCodeInfo * = object
    ## Information about the email address authentication code that was sent
    kind {.jsonName: "@type".}: string
    emailAddressPattern* {.jsonName: "email_address_pattern".}: string ## Pattern of the email address to which an authentication code was sent
    length* {.jsonName: "length".}: int32 ## Length of the code; 0 if unknown

  PasswordState * = object
    ## Represents the current state of 2-step verification
    kind {.jsonName: "@type".}: string
    hasPassword* {.jsonName: "has_password".}: bool ## True, if a 2-step verification password is set
    passwordHint* {.jsonName: "password_hint".}: string ## Hint for the password; may be empty
    hasRecoveryEmailAddress* {.jsonName: "has_recovery_email_address".}: bool ## True, if a recovery email is set
    hasPassportData* {.jsonName: "has_passport_data".}: bool ## True, if some Telegram Passport elements were saved
    recoveryEmailAddressCodeInfo* {.jsonName: "recovery_email_address_code_info".}: Option[EmailAddressAuthenticationCodeInfo] ## Information about the recovery email address to which the confirmation email was sent; may be null

  Error * = object
    ## An object of this type can be returned on every function call, in case of an error
    kind {.jsonName: "@type".}: string
    code* {.jsonName: "code".}: int32 ## Error code; subject to future changes. If the error code is 406, the error message must not be processed in any way and must not be displayed to the user
    message* {.jsonName: "message".}: string ## Error message; subject to future changes

  UserProfilePhoto * = object
    ## Contains full information about a user profile photo
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string ## Unique user profile photo identifier
    addedDate* {.jsonName: "added_date".}: int32 ## Point in time (Unix timestamp) when the photo has been added
    sizes* {.jsonName: "sizes".}: seq[PhotoSize] ## Available variants of the user photo, in different sizes

  DatedFile * = object
    ## File with the date it was uploaded
    kind {.jsonName: "@type".}: string
    file* {.jsonName: "file".}: File ## The file
    date* {.jsonName: "date".}: int32 ## Point in time (Unix timestamp) when the file was uploaded

  LanguagePackInfo * = object
    ## Contains information about a language pack
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string ## Unique language pack identifier
    baseLanguagePackId* {.jsonName: "base_language_pack_id".}: string ## Identifier of a base language pack; may be empty. If a string is missed in the language pack, then it should be fetched from base language pack. Unsupported in custom language packs
    name* {.jsonName: "name".}: string ## Language name
    nativeName* {.jsonName: "native_name".}: string ## Name of the language in that language
    pluralCode* {.jsonName: "plural_code".}: string ## A language code to be used to apply plural forms. See https://www.unicode.org/cldr/charts/latest/supplemental/language_plural_rules.html for more info
    isOfficial* {.jsonName: "is_official".}: bool ## True, if the language pack is official
    isRtl* {.jsonName: "is_rtl".}: bool ## True, if the language pack strings are RTL
    isBeta* {.jsonName: "is_beta".}: bool ## True, if the language pack is a beta language pack
    isInstalled* {.jsonName: "is_installed".}: bool ## True, if the language pack is installed by the current user
    totalStringCount* {.jsonName: "total_string_count".}: int32 ## Total number of non-deleted strings from the language pack
    translatedStringCount* {.jsonName: "translated_string_count".}: int32 ## Total number of translated strings from the language pack
    localStringCount* {.jsonName: "local_string_count".}: int32 ## Total number of non-deleted strings from the language pack available locally
    translationUrl* {.jsonName: "translation_url".}: string ## Link to language translation interface; empty for custom local language packs

  TdlibParameters * = object
    ## Contains parameters for TDLib initialization
    kind {.jsonName: "@type".}: string
    useTestDc* {.jsonName: "use_test_dc".}: bool ## If set to true, the Telegram test environment will be used instead of the production environment
    databaseDirectory* {.jsonName: "database_directory".}: string ## The path to the directory for the persistent database; if empty, the current working directory will be used
    filesDirectory* {.jsonName: "files_directory".}: string ## The path to the directory for storing files; if empty, database_directory will be used
    useFileDatabase* {.jsonName: "use_file_database".}: bool ## If set to true, information about downloaded and uploaded files will be saved between application restarts
    useChatInfoDatabase* {.jsonName: "use_chat_info_database".}: bool ## If set to true, the library will maintain a cache of users, basic groups, supergroups, channels and secret chats. Implies use_file_database
    useMessageDatabase* {.jsonName: "use_message_database".}: bool ## If set to true, the library will maintain a cache of chats and messages. Implies use_chat_info_database
    useSecretChats* {.jsonName: "use_secret_chats".}: bool ## If set to true, support for secret chats will be enabled
    apiId* {.jsonName: "api_id".}: int32 ## Application identifier for Telegram API access, which can be obtained at https://my.telegram.org
    apiHash* {.jsonName: "api_hash".}: string ## Application identifier hash for Telegram API access, which can be obtained at https://my.telegram.org
    systemLanguageCode* {.jsonName: "system_language_code".}: string ## IETF language tag of the user's operating system language; must be non-empty
    deviceModel* {.jsonName: "device_model".}: string ## Model of the device the application is being run on; must be non-empty
    systemVersion* {.jsonName: "system_version".}: string ## Version of the operating system the application is being run on; must be non-empty
    applicationVersion* {.jsonName: "application_version".}: string ## Application version; must be non-empty
    enableStorageOptimizer* {.jsonName: "enable_storage_optimizer".}: bool ## If set to true, old files will automatically be deleted
    ignoreFileNames* {.jsonName: "ignore_file_names".}: bool ## If set to true, original file names will be ignored. Otherwise, downloaded files will be saved under names as close as possible to the original name

  PageBlockHorizontalAlignmentKind * {.pure.} = enum
    pbhaLeft = "pageBlockHorizontalAlignmentLeft",
    pbhaCenter = "pageBlockHorizontalAlignmentCenter",
    pbhaRight = "pageBlockHorizontalAlignmentRight",

  PageBlockHorizontalAlignment * = object
    ## Describes a horizontal alignment of a table cell content
    case kind* {.jsonName: "@type".}: PageBlockHorizontalAlignmentKind
    of pbhaLeft:
      ## The content should be left-aligned
      discard
    of pbhaCenter:
      ## The content should be center-aligned
      discard
    of pbhaRight:
      ## The content should be right-aligned
      discard

  PassportRequiredElement * = object
    ## Contains a description of the required Telegram Passport element that was requested by a service
    kind {.jsonName: "@type".}: string
    suitableElements* {.jsonName: "suitable_elements".}: seq[PassportSuitableElement] ## List of Telegram Passport elements any of which is enough to provide

  CallDiscardReasonKind * {.pure.} = enum
    cdrMissed = "callDiscardReasonMissed",
    cdrDisconnected = "callDiscardReasonDisconnected",
    cdrDeclined = "callDiscardReasonDeclined",
    cdrHungUp = "callDiscardReasonHungUp",
    cdrEmpty = "callDiscardReasonEmpty",

  CallDiscardReason * = object
    ## Describes the reason why a call was discarded
    case kind* {.jsonName: "@type".}: CallDiscardReasonKind
    of cdrEmpty:
      ## The call wasn't discarded, or the reason is unknown
      discard
    of cdrMissed:
      ## The call was ended before the conversation started. It was cancelled by the caller or missed by the other party
      discard
    of cdrDeclined:
      ## The call was ended before the conversation started. It was declined by the other party
      discard
    of cdrDisconnected:
      ## The call was ended during the conversation because the users were disconnected
      discard
    of cdrHungUp:
      ## The call was ended because one of the parties hung up
      discard

  MaskPosition * = object
    ## Position on a photo where a mask should be placed
    kind {.jsonName: "@type".}: string
    point* {.jsonName: "point".}: MaskPoint ## Part of the face, relative to which the mask should be placed
    xShift* {.jsonName: "x_shift".}: float ## Shift by X-axis measured in widths of the mask scaled to the face size, from left to right. (For example, -1.0 will place the mask just to the left of the default mask position)
    yShift* {.jsonName: "y_shift".}: float ## Shift by Y-axis measured in heights of the mask scaled to the face size, from top to bottom. (For example, 1.0 will place the mask just below the default mask position)
    scale* {.jsonName: "scale".}: float ## Mask scaling coefficient. (For example, 2.0 means a doubled size)

  Photo * = object
    ## Describes a photo
    kind {.jsonName: "@type".}: string
    hasStickers* {.jsonName: "has_stickers".}: bool ## True, if stickers were added to the photo
    minithumbnail* {.jsonName: "minithumbnail".}: Option[Minithumbnail] ## Photo minithumbnail; may be null
    sizes* {.jsonName: "sizes".}: seq[PhotoSize] ## Available variants of the photo, in different sizes

  ChatListKind * {.pure.} = enum
    clArchive = "chatListArchive",
    clMain = "chatListMain",

  ChatList * = object
    ## Describes a list of chats
    case kind* {.jsonName: "@type".}: ChatListKind
    of clMain:
      ## A main list of chats
      discard
    of clArchive:
      ## A list of chats usually located at the top of the main chat list. Unmuted chats are automatically moved from the Archive to the Main chat list when a new message arrives
      discard

  LabeledPricePart * = object
    ## Portion of the price of a product (e.g., "delivery cost", "tax amount")
    kind {.jsonName: "@type".}: string
    label* {.jsonName: "label".}: string ## Label for this portion of the product price
    amount* {.jsonName: "amount".}: int64 ## Currency amount in minimal quantity of the currency

  InputInlineQueryResultKind * {.pure.} = enum
    iiqrDocument = "inputInlineQueryResultDocument",
    iiqrPhoto = "inputInlineQueryResultPhoto",
    iiqrLocation = "inputInlineQueryResultLocation",
    iiqrGame = "inputInlineQueryResultGame",
    iiqrAnimation = "inputInlineQueryResultAnimation",
    iiqrAudio = "inputInlineQueryResultAudio",
    iiqrSticker = "inputInlineQueryResultSticker",
    iiqrContact = "inputInlineQueryResultContact",
    iiqrArticle = "inputInlineQueryResultArticle",
    iiqrVoiceNote = "inputInlineQueryResultVoiceNote",
    iiqrVenue = "inputInlineQueryResultVenue",
    iiqrVideo = "inputInlineQueryResultVideo",

  InputInlineQueryResult * = object
    ## Represents a single result of an inline query; for bots only
    case kind* {.jsonName: "@type".}: InputInlineQueryResultKind
    of iiqrAnimation:
      ## Represents a link to an animated GIF or an animated (i.e. without sound) H.264/MPEG-4 AVC video
      inputinlinequeryresultanimatiId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inputinlinequeryresultanimatiTitle* {.jsonName: "title".}: string ## Title of the query result
      inputinlinequeryresultanimatiThumbnailUrl* {.jsonName: "thumbnail_url".}: string ## URL of the result thumbnail (JPEG, GIF, or MPEG4), if it exists
      inputinlinequeryresultanimatiThumbnailMimeType* {.jsonName: "thumbnail_mime_type".}: string ## MIME type of the video thumbnail. If non-empty, must be one of "image/jpeg", "image/gif" and "video/mp4"
      inputinlinequeryresultanimatiVideoUrl* {.jsonName: "video_url".}: string ## The URL of the video file (file size must not exceed 1MB)
      inputinlinequeryresultanimatiVideoMimeType* {.jsonName: "video_mime_type".}: string ## MIME type of the video file. Must be one of "image/gif" and "video/mp4"
      inputinlinequeryresultanimatiVideoDuration* {.jsonName: "video_duration".}: int32 ## Duration of the video, in seconds
      inputinlinequeryresultanimatiVideoWidth* {.jsonName: "video_width".}: int32 ## Width of the video
      inputinlinequeryresultanimatiVideoHeight* {.jsonName: "video_height".}: int32 ## Height of the video
      inputinlinequeryresultanimatiReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup ## The message reply markup. Must be of type replyMarkupInlineKeyboard or null
      inputinlinequeryresultanimatiInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent ## The content of the message to be sent. Must be one of the following types: InputMessageText, InputMessageAnimation, InputMessageLocation, InputMessageVenue or InputMessageContact
    of iiqrArticle:
      ## Represents a link to an article or web page
      inputinlinequeryresultarticId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inputinlinequeryresultarticUrl* {.jsonName: "url".}: string ## URL of the result, if it exists
      inputinlinequeryresultarticHideUrl* {.jsonName: "hide_url".}: bool ## True, if the URL must be not shown
      inputinlinequeryresultarticTitle* {.jsonName: "title".}: string ## Title of the result
      inputinlinequeryresultarticDescription* {.jsonName: "description".}: string ## Represents a link to an article or web page
      inputinlinequeryresultarticThumbnailUrl* {.jsonName: "thumbnail_url".}: string ## URL of the result thumbnail, if it exists
      inputinlinequeryresultarticThumbnailWidth* {.jsonName: "thumbnail_width".}: int32 ## Thumbnail width, if known
      inputinlinequeryresultarticThumbnailHeight* {.jsonName: "thumbnail_height".}: int32 ## Thumbnail height, if known
      inputinlinequeryresultarticReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup ## The message reply markup. Must be of type replyMarkupInlineKeyboard or null
      inputinlinequeryresultarticInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent ## The content of the message to be sent. Must be one of the following types: InputMessageText, InputMessageLocation, InputMessageVenue or InputMessageContact
    of iiqrAudio:
      ## Represents a link to an MP3 audio file
      inputinlinequeryresultaudId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inputinlinequeryresultaudTitle* {.jsonName: "title".}: string ## Title of the audio file
      inputinlinequeryresultaudPerformer* {.jsonName: "performer".}: string ## Performer of the audio file
      inputinlinequeryresultaudAudioUrl* {.jsonName: "audio_url".}: string ## The URL of the audio file
      inputinlinequeryresultaudAudioDuration* {.jsonName: "audio_duration".}: int32 ## Audio file duration, in seconds
      inputinlinequeryresultaudReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup ## The message reply markup. Must be of type replyMarkupInlineKeyboard or null
      inputinlinequeryresultaudInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent ## The content of the message to be sent. Must be one of the following types: InputMessageText, InputMessageAudio, InputMessageLocation, InputMessageVenue or InputMessageContact
    of iiqrContact:
      ## Represents a user contact
      inputinlinequeryresultcontaId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inputinlinequeryresultcontaContact* {.jsonName: "contact".}: Contact ## User contact
      inputinlinequeryresultcontaThumbnailUrl* {.jsonName: "thumbnail_url".}: string ## URL of the result thumbnail, if it exists
      inputinlinequeryresultcontaThumbnailWidth* {.jsonName: "thumbnail_width".}: int32 ## Thumbnail width, if known
      inputinlinequeryresultcontaThumbnailHeight* {.jsonName: "thumbnail_height".}: int32 ## Thumbnail height, if known
      inputinlinequeryresultcontaReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup ## The message reply markup. Must be of type replyMarkupInlineKeyboard or null
      inputinlinequeryresultcontaInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent ## The content of the message to be sent. Must be one of the following types: InputMessageText, InputMessageLocation, InputMessageVenue or InputMessageContact
    of iiqrDocument:
      ## Represents a link to a file
      inputinlinequeryresultdocumeId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inputinlinequeryresultdocumeTitle* {.jsonName: "title".}: string ## Title of the resulting file
      inputinlinequeryresultdocumeDescription* {.jsonName: "description".}: string ## Represents a link to a file
      inputinlinequeryresultdocumeDocumentUrl* {.jsonName: "document_url".}: string ## URL of the file
      inputinlinequeryresultdocumeMimeType* {.jsonName: "mime_type".}: string ## MIME type of the file content; only "application/pdf" and "application/zip" are currently allowed
      inputinlinequeryresultdocumeThumbnailUrl* {.jsonName: "thumbnail_url".}: string ## The URL of the file thumbnail, if it exists
      inputinlinequeryresultdocumeThumbnailWidth* {.jsonName: "thumbnail_width".}: int32 ## Width of the thumbnail
      inputinlinequeryresultdocumeThumbnailHeight* {.jsonName: "thumbnail_height".}: int32 ## Height of the thumbnail
      inputinlinequeryresultdocumeReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup ## The message reply markup. Must be of type replyMarkupInlineKeyboard or null
      inputinlinequeryresultdocumeInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent ## The content of the message to be sent. Must be one of the following types: InputMessageText, InputMessageDocument, InputMessageLocation, InputMessageVenue or InputMessageContact
    of iiqrGame:
      ## Represents a game
      inputinlinequeryresultgaId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inputinlinequeryresultgaGameShortName* {.jsonName: "game_short_name".}: string ## Short name of the game
      inputinlinequeryresultgaReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup ## Message reply markup. Must be of type replyMarkupInlineKeyboard or null
    of iiqrLocation:
      ## Represents a point on the map
      inputinlinequeryresultlocatiId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inputinlinequeryresultlocatiLocation* {.jsonName: "location".}: Location ## Location result
      inputinlinequeryresultlocatiLivePeriod* {.jsonName: "live_period".}: int32 ## Amount of time relative to the message sent time until the location can be updated, in seconds
      inputinlinequeryresultlocatiTitle* {.jsonName: "title".}: string ## Title of the result
      inputinlinequeryresultlocatiThumbnailUrl* {.jsonName: "thumbnail_url".}: string ## URL of the result thumbnail, if it exists
      inputinlinequeryresultlocatiThumbnailWidth* {.jsonName: "thumbnail_width".}: int32 ## Thumbnail width, if known
      inputinlinequeryresultlocatiThumbnailHeight* {.jsonName: "thumbnail_height".}: int32 ## Thumbnail height, if known
      inputinlinequeryresultlocatiReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup ## The message reply markup. Must be of type replyMarkupInlineKeyboard or null
      inputinlinequeryresultlocatiInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent ## The content of the message to be sent. Must be one of the following types: InputMessageText, InputMessageLocation, InputMessageVenue or InputMessageContact
    of iiqrPhoto:
      ## Represents link to a JPEG image
      inputinlinequeryresultphoId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inputinlinequeryresultphoTitle* {.jsonName: "title".}: string ## Title of the result, if known
      inputinlinequeryresultphoDescription* {.jsonName: "description".}: string ## Represents link to a JPEG image
      inputinlinequeryresultphoThumbnailUrl* {.jsonName: "thumbnail_url".}: string ## URL of the photo thumbnail, if it exists
      inputinlinequeryresultphoPhotoUrl* {.jsonName: "photo_url".}: string ## The URL of the JPEG photo (photo size must not exceed 5MB)
      inputinlinequeryresultphoPhotoWidth* {.jsonName: "photo_width".}: int32 ## Width of the photo
      inputinlinequeryresultphoPhotoHeight* {.jsonName: "photo_height".}: int32 ## Height of the photo
      inputinlinequeryresultphoReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup ## The message reply markup. Must be of type replyMarkupInlineKeyboard or null
      inputinlinequeryresultphoInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent ## The content of the message to be sent. Must be one of the following types: InputMessageText, InputMessagePhoto, InputMessageLocation, InputMessageVenue or InputMessageContact
    of iiqrSticker:
      ## Represents a link to a WEBP or TGS sticker
      inputinlinequeryresultstickId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inputinlinequeryresultstickThumbnailUrl* {.jsonName: "thumbnail_url".}: string ## URL of the sticker thumbnail, if it exists
      inputinlinequeryresultstickStickerUrl* {.jsonName: "sticker_url".}: string ## The URL of the WEBP or TGS sticker (sticker file size must not exceed 5MB)
      inputinlinequeryresultstickStickerWidth* {.jsonName: "sticker_width".}: int32 ## Width of the sticker
      inputinlinequeryresultstickStickerHeight* {.jsonName: "sticker_height".}: int32 ## Height of the sticker
      inputinlinequeryresultstickReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup ## The message reply markup. Must be of type replyMarkupInlineKeyboard or null
      inputinlinequeryresultstickInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent ## The content of the message to be sent. Must be one of the following types: InputMessageText, inputMessageSticker, InputMessageLocation, InputMessageVenue or InputMessageContact
    of iiqrVenue:
      ## Represents information about a venue
      inputinlinequeryresultvenId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inputinlinequeryresultvenVenue* {.jsonName: "venue".}: Venue ## Venue result
      inputinlinequeryresultvenThumbnailUrl* {.jsonName: "thumbnail_url".}: string ## URL of the result thumbnail, if it exists
      inputinlinequeryresultvenThumbnailWidth* {.jsonName: "thumbnail_width".}: int32 ## Thumbnail width, if known
      inputinlinequeryresultvenThumbnailHeight* {.jsonName: "thumbnail_height".}: int32 ## Thumbnail height, if known
      inputinlinequeryresultvenReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup ## The message reply markup. Must be of type replyMarkupInlineKeyboard or null
      inputinlinequeryresultvenInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent ## The content of the message to be sent. Must be one of the following types: InputMessageText, InputMessageLocation, InputMessageVenue or InputMessageContact
    of iiqrVideo:
      ## Represents a link to a page containing an embedded video player or a video file
      inputinlinequeryresultvidId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inputinlinequeryresultvidTitle* {.jsonName: "title".}: string ## Title of the result
      inputinlinequeryresultvidDescription* {.jsonName: "description".}: string ## Represents a link to a page containing an embedded video player or a video file
      inputinlinequeryresultvidThumbnailUrl* {.jsonName: "thumbnail_url".}: string ## The URL of the video thumbnail (JPEG), if it exists
      inputinlinequeryresultvidVideoUrl* {.jsonName: "video_url".}: string ## URL of the embedded video player or video file
      inputinlinequeryresultvidMimeType* {.jsonName: "mime_type".}: string ## MIME type of the content of the video URL, only "text/html" or "video/mp4" are currently supported
      inputinlinequeryresultvidVideoWidth* {.jsonName: "video_width".}: int32 ## Width of the video
      inputinlinequeryresultvidVideoHeight* {.jsonName: "video_height".}: int32 ## Height of the video
      inputinlinequeryresultvidVideoDuration* {.jsonName: "video_duration".}: int32 ## Video duration, in seconds
      inputinlinequeryresultvidReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup ## The message reply markup. Must be of type replyMarkupInlineKeyboard or null
      inputinlinequeryresultvidInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent ## The content of the message to be sent. Must be one of the following types: InputMessageText, InputMessageVideo, InputMessageLocation, InputMessageVenue or InputMessageContact
    of iiqrVoiceNote:
      ## Represents a link to an opus-encoded audio file within an OGG container, single channel audio
      vnId* {.jsonName: "id".}: string ## Unique identifier of the query result
      vnTitle* {.jsonName: "title".}: string ## Title of the voice note
      vnVoiceNoteUrl* {.jsonName: "voice_note_url".}: string ## The URL of the voice note file
      vnVoiceNoteDuration* {.jsonName: "voice_note_duration".}: int32 ## Duration of the voice note, in seconds
      vnReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup ## The message reply markup. Must be of type replyMarkupInlineKeyboard or null
      vnInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent ## The content of the message to be sent. Must be one of the following types: InputMessageText, InputMessageVoiceNote, InputMessageLocation, InputMessageVenue or InputMessageContact

  BasicGroupFullInfo * = object
    ## Contains full information about a basic group
    kind {.jsonName: "@type".}: string
    description* {.jsonName: "description".}: string ## Contains full information about a basic group
    creatorUserId* {.jsonName: "creator_user_id".}: int32 ## User identifier of the creator of the group; 0 if unknown
    members* {.jsonName: "members".}: seq[ChatMember] ## Group members
    inviteLink* {.jsonName: "invite_link".}: string ## Invite link for this group; available only after it has been generated at least once and only for the group creator

  MessageForwardOriginKind * {.pure.} = enum
    mfoUser = "messageForwardOriginUser",
    mfoHiddenUser = "messageForwardOriginHiddenUser",
    mfoChannel = "messageForwardOriginChannel",

  MessageForwardOrigin * = object
    ## Contains information about the origin of a forwarded message
    case kind* {.jsonName: "@type".}: MessageForwardOriginKind
    of mfoUser:
      ## The message was originally written by a known user
      messageforwardoriginusSenderUserId* {.jsonName: "sender_user_id".}: int32 ## Identifier of the user that originally sent the message
    of mfoHiddenUser:
      ## The message was originally written by a user, which is hidden by their privacy settings
      huSenderName* {.jsonName: "sender_name".}: string ## Name of the sender
    of mfoChannel:
      ## The message was originally a post in a channel
      messageforwardoriginchannChatId* {.jsonName: "chat_id".}: int64 ## Identifier of the chat from which the message was originally forwarded
      messageforwardoriginchannMessageId* {.jsonName: "message_id".}: int64 ## Message identifier of the original message; 0 if unknown
      messageforwardoriginchannAuthorSignature* {.jsonName: "author_signature".}: string ## Original post author signature

  PageBlockTableCell * = ref object
    ## Represents a cell of a table
    kind {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: Option[RichText] ## Cell text; may be null. If the text is null, then the cell should be invisible
    isHeader* {.jsonName: "is_header".}: bool ## True, if it is a header cell
    colspan* {.jsonName: "colspan".}: int32 ## The number of columns the cell should span
    rowspan* {.jsonName: "rowspan".}: int32 ## The number of rows the cell should span
    align* {.jsonName: "align".}: PageBlockHorizontalAlignment ## Horizontal cell content alignment
    valign* {.jsonName: "valign".}: PageBlockVerticalAlignment ## Vertical cell content alignment

  TopChatCategoryKind * {.pure.} = enum
    tccInlineBots = "topChatCategoryInlineBots",
    tccUsers = "topChatCategoryUsers",
    tccCalls = "topChatCategoryCalls",
    tccForwardChats = "topChatCategoryForwardChats",
    tccBots = "topChatCategoryBots",
    tccChannels = "topChatCategoryChannels",
    tccGroups = "topChatCategoryGroups",

  TopChatCategory * = object
    ## Represents the categories of chats for which a list of frequently used chats can be retrieved
    case kind* {.jsonName: "@type".}: TopChatCategoryKind
    of tccUsers:
      ## A category containing frequently used private chats with non-bot users
      discard
    of tccBots:
      ## A category containing frequently used private chats with bot users
      discard
    of tccGroups:
      ## A category containing frequently used basic groups and supergroups
      discard
    of tccChannels:
      ## A category containing frequently used channels
      discard
    of tccInlineBots:
      ## A category containing frequently used chats with inline bots sorted by their usage in inline mode
      discard
    of tccCalls:
      ## A category containing frequently used chats used for calls
      discard
    of tccForwardChats:
      ## A category containing frequently used chats used to forward messages
      discard

  Emojis * = object
    ## Represents a list of emoji
    kind {.jsonName: "@type".}: string
    emojis* {.jsonName: "emojis".}: seq[string] ## List of emojis

  Supergroup * = object
    ## Represents a supergroup or channel with zero or more members (subscribers in the case of channels). From the point of view of the system, a channel is a special kind of a supergroup: only administrators can post and see the list of members, and posts from all administrators use the name and photo of the channel instead of individual names and profile photos. Unlike supergroups, channels can have an unlimited number of subscribers
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32 ## Supergroup or channel identifier
    username* {.jsonName: "username".}: string ## Username of the supergroup or channel; empty for private supergroups or channels
    date* {.jsonName: "date".}: int32 ## Point in time (Unix timestamp) when the current user joined, or the point in time when the supergroup or channel was created, in case the user is not a member
    status* {.jsonName: "status".}: ChatMemberStatus ## Status of the current user in the supergroup or channel; custom title will be always empty
    memberCount* {.jsonName: "member_count".}: int32 ## Number of members in the supergroup or channel; 0 if unknown. Currently it is guaranteed to be known only if the supergroup or channel was found through SearchPublicChats
    hasLinkedChat* {.jsonName: "has_linked_chat".}: bool ## True, if the channel has a discussion group, or the supergroup is the designated discussion group for a channel
    hasLocation* {.jsonName: "has_location".}: bool ## True, if the supergroup is connected to a location, i.e. the supergroup is a location-based supergroup
    signMessages* {.jsonName: "sign_messages".}: bool ## True, if messages sent to the channel should contain information about the sender. This field is only applicable to channels
    isSlowModeEnabled* {.jsonName: "is_slow_mode_enabled".}: bool ## True, if the slow mode is enabled in the supergroup
    isChannel* {.jsonName: "is_channel".}: bool ## True, if the supergroup is a channel
    isVerified* {.jsonName: "is_verified".}: bool ## True, if the supergroup or channel is verified
    restrictionReason* {.jsonName: "restriction_reason".}: string ## If non-empty, contains a human-readable description of the reason why access to this supergroup or channel must be restricted
    isScam* {.jsonName: "is_scam".}: bool ## True, if many users reported this supergroup as a scam

  ValidatedOrderInfo * = object
    ## Contains a temporary identifier of validated order information, which is stored for one hour. Also contains the available shipping options
    kind {.jsonName: "@type".}: string
    orderInfoId* {.jsonName: "order_info_id".}: string ## Temporary identifier of the order information
    shippingOptions* {.jsonName: "shipping_options".}: seq[ShippingOption] ## Available shipping options

  PersonalDetails * = object
    ## Contains the user's personal details
    kind {.jsonName: "@type".}: string
    firstName* {.jsonName: "first_name".}: string ## First name of the user written in English; 1-255 characters
    middleName* {.jsonName: "middle_name".}: string ## Middle name of the user written in English; 0-255 characters
    lastName* {.jsonName: "last_name".}: string ## Last name of the user written in English; 1-255 characters
    nativeFirstName* {.jsonName: "native_first_name".}: string ## Native first name of the user; 1-255 characters
    nativeMiddleName* {.jsonName: "native_middle_name".}: string ## Native middle name of the user; 0-255 characters
    nativeLastName* {.jsonName: "native_last_name".}: string ## Native last name of the user; 1-255 characters
    birthdate* {.jsonName: "birthdate".}: Date ## Birthdate of the user
    gender* {.jsonName: "gender".}: string ## Gender of the user, "male" or "female"
    countryCode* {.jsonName: "country_code".}: string ## A two-letter ISO 3166-1 alpha-2 country code of the user's country
    residenceCountryCode* {.jsonName: "residence_country_code".}: string ## A two-letter ISO 3166-1 alpha-2 country code of the user's residence country

  TestString * = object
    ## A simple object containing a string; for testing only
    kind {.jsonName: "@type".}: string
    value* {.jsonName: "value".}: string ## String

  InputThumbnail * = object
    ## A thumbnail to be sent along with a file; should be in JPEG or WEBP format for stickers, and less than 200 KB in size
    kind {.jsonName: "@type".}: string
    thumbnail* {.jsonName: "thumbnail".}: InputFile ## Thumbnail file to send. Sending thumbnails by file_id is currently not supported
    width* {.jsonName: "width".}: int32 ## Thumbnail width, usually shouldn't exceed 320. Use 0 if unknown
    height* {.jsonName: "height".}: int32 ## Thumbnail height, usually shouldn't exceed 320. Use 0 if unknown

  Session * = object
    ## Contains information about one session in a Telegram application used by the current user. Sessions should be shown to the user in the returned order
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string ## Session identifier
    isCurrent* {.jsonName: "is_current".}: bool ## True, if this session is the current session
    isPasswordPending* {.jsonName: "is_password_pending".}: bool ## True, if a password is needed to complete authorization of the session
    apiId* {.jsonName: "api_id".}: int32 ## Telegram API identifier, as provided by the application
    applicationName* {.jsonName: "application_name".}: string ## Name of the application, as provided by the application
    applicationVersion* {.jsonName: "application_version".}: string ## The version of the application, as provided by the application
    isOfficialApplication* {.jsonName: "is_official_application".}: bool ## True, if the application is an official application or uses the api_id of an official application
    deviceModel* {.jsonName: "device_model".}: string ## Model of the device the application has been run or is running on, as provided by the application
    platform* {.jsonName: "platform".}: string ## Operating system the application has been run or is running on, as provided by the application
    systemVersion* {.jsonName: "system_version".}: string ## Version of the operating system the application has been run or is running on, as provided by the application
    logInDate* {.jsonName: "log_in_date".}: int32 ## Point in time (Unix timestamp) when the user has logged in
    lastActiveDate* {.jsonName: "last_active_date".}: int32 ## Point in time (Unix timestamp) when the session was last used
    ip* {.jsonName: "ip".}: string ## IP address from which the session was created, in human-readable format
    country* {.jsonName: "country".}: string ## A two-letter country code for the country from which the session was created, based on the IP address
    region* {.jsonName: "region".}: string ## Region code from which the session was created, based on the IP address

  Sticker * = object
    ## Describes a sticker
    kind {.jsonName: "@type".}: string
    setId* {.jsonName: "set_id".}: string ## The identifier of the sticker set to which the sticker belongs; 0 if none
    width* {.jsonName: "width".}: int32 ## Sticker width; as defined by the sender
    height* {.jsonName: "height".}: int32 ## Sticker height; as defined by the sender
    emoji* {.jsonName: "emoji".}: string ## Emoji corresponding to the sticker
    isAnimated* {.jsonName: "is_animated".}: bool ## True, if the sticker is an animated sticker in TGS format
    isMask* {.jsonName: "is_mask".}: bool ## True, if the sticker is a mask
    maskPosition* {.jsonName: "mask_position".}: Option[MaskPosition] ## Position where the mask should be placed; may be null
    thumbnail* {.jsonName: "thumbnail".}: Option[PhotoSize] ## Sticker thumbnail in WEBP or JPEG format; may be null
    sticker* {.jsonName: "sticker".}: File ## File containing the sticker

  Date * = object
    ## Represents a date according to the Gregorian calendar
    kind {.jsonName: "@type".}: string
    day* {.jsonName: "day".}: int32 ## Day of the month, 1-31
    month* {.jsonName: "month".}: int32 ## Month, 1-12
    year* {.jsonName: "year".}: int32 ## Year, 1-9999

  Animation * = object
    ## Describes an animation file. The animation must be encoded in GIF or MPEG4 format
    kind {.jsonName: "@type".}: string
    duration* {.jsonName: "duration".}: int32 ## Duration of the animation, in seconds; as defined by the sender
    width* {.jsonName: "width".}: int32 ## Width of the animation
    height* {.jsonName: "height".}: int32 ## Height of the animation
    fileName* {.jsonName: "file_name".}: string ## Original name of the file; as defined by the sender
    mimeType* {.jsonName: "mime_type".}: string ## MIME type of the file, usually "image/gif" or "video/mp4"
    minithumbnail* {.jsonName: "minithumbnail".}: Option[Minithumbnail] ## Animation minithumbnail; may be null
    thumbnail* {.jsonName: "thumbnail".}: Option[PhotoSize] ## Animation thumbnail; may be null
    animation* {.jsonName: "animation".}: File ## File containing the animation

  Poll * = object
    ## Describes a poll
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string ## Unique poll identifier
    question* {.jsonName: "question".}: string ## Poll question, 1-255 characters
    options* {.jsonName: "options".}: seq[PollOption] ## List of poll answer options
    totalVoterCount* {.jsonName: "total_voter_count".}: int32 ## Total number of voters, participating in the poll
    recentVoterUserIds* {.jsonName: "recent_voter_user_ids".}: seq[int32] ## User identifiers of recent voters, if the poll is non-anonymous
    isAnonymous* {.jsonName: "is_anonymous".}: bool ## True, if the poll is anonymous
    typ* {.jsonName: "type".}: PollType ## Type of the poll
    openPeriod* {.jsonName: "open_period".}: int32 ## Amount of time the poll will be active after creation, in seconds
    closeDate* {.jsonName: "close_date".}: int32 ## Point in time (Unix timestamp) when the poll will be automatically closed
    isClosed* {.jsonName: "is_closed".}: bool ## True, if the poll is closed

  Chat * = object
    ## A chat. (Can be a private chat, basic group, supergroup, or secret chat)
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int64 ## Chat unique identifier
    typ* {.jsonName: "type".}: ChatType ## Type of the chat
    chatList* {.jsonName: "chat_list".}: Option[ChatList] ## A chat list to which the chat belongs; may be null
    title* {.jsonName: "title".}: string ## Chat title
    photo* {.jsonName: "photo".}: Option[ChatPhoto] ## Chat photo; may be null
    permissions* {.jsonName: "permissions".}: ChatPermissions ## Actions that non-administrator chat members are allowed to take in the chat
    lastMessage* {.jsonName: "last_message".}: Option[Message] ## Last message in the chat; may be null
    order* {.jsonName: "order".}: string ## Descending parameter by which chats are sorted in the main chat list. If the order number of two chats is the same, they must be sorted in descending order by ID. If 0, the position of the chat in the list is undetermined
    source* {.jsonName: "source".}: Option[ChatSource] ## Source of the chat in a chat list; may be null
    isPinned* {.jsonName: "is_pinned".}: bool ## True, if the chat is pinned
    isMarkedAsUnread* {.jsonName: "is_marked_as_unread".}: bool ## True, if the chat is marked as unread
    hasScheduledMessages* {.jsonName: "has_scheduled_messages".}: bool ## True, if the chat has scheduled messages
    canBeDeletedOnlyForSelf* {.jsonName: "can_be_deleted_only_for_self".}: bool ## True, if the chat messages can be deleted only for the current user while other users will continue to see the messages
    canBeDeletedForAllUsers* {.jsonName: "can_be_deleted_for_all_users".}: bool ## True, if the chat messages can be deleted for all users
    canBeReported* {.jsonName: "can_be_reported".}: bool ## True, if the chat can be reported to Telegram moderators through reportChat
    defaultDisableNotification* {.jsonName: "default_disable_notification".}: bool ## Default value of the disable_notification parameter, used when a message is sent to the chat
    unreadCount* {.jsonName: "unread_count".}: int32 ## Number of unread messages in the chat
    lastReadInboxMessageId* {.jsonName: "last_read_inbox_message_id".}: int64 ## Identifier of the last read incoming message
    lastReadOutboxMessageId* {.jsonName: "last_read_outbox_message_id".}: int64 ## Identifier of the last read outgoing message
    unreadMentionCount* {.jsonName: "unread_mention_count".}: int32 ## Number of unread messages with a mention/reply in the chat
    notificationSettings* {.jsonName: "notification_settings".}: ChatNotificationSettings ## Notification settings for this chat
    actionBar* {.jsonName: "action_bar".}: Option[ChatActionBar] ## Describes actions which should be possible to do through a chat action bar; may be null
    pinnedMessageId* {.jsonName: "pinned_message_id".}: int64 ## Identifier of the pinned message in the chat; 0 if none
    replyMarkupMessageId* {.jsonName: "reply_markup_message_id".}: int64 ## Identifier of the message from which reply markup needs to be used; 0 if there is no default custom reply markup in the chat
    draftMessage* {.jsonName: "draft_message".}: Option[DraftMessage] ## A draft of a message in the chat; may be null
    clientData* {.jsonName: "client_data".}: string ## Contains client-specific data associated with the chat. (For example, the chat position or local chat notification settings can be stored here.) Persistent if the message database is used

  Proxy * = object
    ## Contains information about a proxy server
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32 ## Unique identifier of the proxy
    server* {.jsonName: "server".}: string ## Proxy server IP address
    port* {.jsonName: "port".}: int32 ## Proxy server port
    lastUsedDate* {.jsonName: "last_used_date".}: int32 ## Point in time (Unix timestamp) when the proxy was last used; 0 if never
    isEnabled* {.jsonName: "is_enabled".}: bool ## True, if the proxy is enabled now
    typ* {.jsonName: "type".}: ProxyType ## Type of the proxy

  VoiceNote * = object
    ## Describes a voice note. The voice note must be encoded with the Opus codec, and stored inside an OGG container. Voice notes can have only a single audio channel
    kind {.jsonName: "@type".}: string
    duration* {.jsonName: "duration".}: int32 ## Duration of the voice note, in seconds; as defined by the sender
    waveform* {.jsonName: "waveform".}: string ## A waveform representation of the voice note in 5-bit format
    mimeType* {.jsonName: "mime_type".}: string ## MIME type of the file; as defined by the sender
    voice* {.jsonName: "voice".}: File ## File containing the voice note

  StickerSetInfo * = object
    ## Represents short information about a sticker set
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string ## Identifier of the sticker set
    title* {.jsonName: "title".}: string ## Title of the sticker set
    name* {.jsonName: "name".}: string ## Name of the sticker set
    thumbnail* {.jsonName: "thumbnail".}: Option[PhotoSize] ## Sticker set thumbnail in WEBP format with width and height 100; may be null
    isInstalled* {.jsonName: "is_installed".}: bool ## True, if the sticker set has been installed by current user
    isArchived* {.jsonName: "is_archived".}: bool ## True, if the sticker set has been archived. A sticker set can't be installed and archived simultaneously
    isOfficial* {.jsonName: "is_official".}: bool ## True, if the sticker set is official
    isAnimated* {.jsonName: "is_animated".}: bool ## True, is the stickers in the set are animated
    isMasks* {.jsonName: "is_masks".}: bool ## True, if the stickers in the set are masks
    isViewed* {.jsonName: "is_viewed".}: bool ## True for already viewed trending sticker sets
    size* {.jsonName: "size".}: int32 ## Total number of stickers in the set
    covers* {.jsonName: "covers".}: seq[Sticker] ## Contains up to the first 5 stickers from the set, depending on the context. If the client needs more stickers the full set should be requested

  LocalFile * = object
    ## Represents a local file
    kind {.jsonName: "@type".}: string
    path* {.jsonName: "path".}: string ## Local path to the locally available file part; may be empty
    canBeDownloaded* {.jsonName: "can_be_downloaded".}: bool ## True, if it is possible to try to download or generate the file
    canBeDeleted* {.jsonName: "can_be_deleted".}: bool ## True, if the file can be deleted
    isDownloadingActive* {.jsonName: "is_downloading_active".}: bool ## True, if the file is currently being downloaded (or a local copy is being generated by some other means)
    isDownloadingCompleted* {.jsonName: "is_downloading_completed".}: bool ## True, if the local copy is fully available
    downloadOffset* {.jsonName: "download_offset".}: int32 ## Download will be started from this offset. downloaded_prefix_size is calculated from this offset
    downloadedPrefixSize* {.jsonName: "downloaded_prefix_size".}: int32 ## If is_downloading_completed is false, then only some prefix of the file starting from download_offset is ready to be read. downloaded_prefix_size is the size of that prefix
    downloadedSize* {.jsonName: "downloaded_size".}: int32 ## Total downloaded file bytes. Should be used only for calculating download progress. The actual file size may be bigger, and some parts of it may contain garbage

  DraftMessage * = object
    ## Contains information about a message draft
    kind {.jsonName: "@type".}: string
    replyToMessageId* {.jsonName: "reply_to_message_id".}: int64 ## Identifier of the message to reply to; 0 if none
    date* {.jsonName: "date".}: int32 ## Point in time (Unix timestamp) when the draft was created
    inputMessageText* {.jsonName: "input_message_text".}: InputMessageContent ## Content of the message draft; this should always be of type inputMessageText

  AuthorizationStateKind * {.pure.} = enum
    asWaitCode = "authorizationStateWaitCode",
    asWaitPassword = "authorizationStateWaitPassword",
    asClosing = "authorizationStateClosing",
    asReady = "authorizationStateReady",
    asWaitPhoneNumber = "authorizationStateWaitPhoneNumber",
    asClosed = "authorizationStateClosed",
    asWaitOtherDeviceConfirmation = "authorizationStateWaitOtherDeviceConfirmation",
    asWaitTdlibParameters = "authorizationStateWaitTdlibParameters",
    asWaitRegistration = "authorizationStateWaitRegistration",
    asLoggingOut = "authorizationStateLoggingOut",
    asWaitEncryptionKey = "authorizationStateWaitEncryptionKey",

  AuthorizationState * = object
    ## Represents the current authorization state of the client
    case kind* {.jsonName: "@type".}: AuthorizationStateKind
    of asWaitTdlibParameters:
      ## TDLib needs TdlibParameters for initialization
      discard
    of asWaitEncryptionKey:
      ## TDLib needs an encryption key to decrypt the local database
      wekIsEncrypted* {.jsonName: "is_encrypted".}: bool ## True, if the database is currently encrypted
    of asWaitPhoneNumber:
      ## TDLib needs the user's phone number to authorize. Call `setAuthenticationPhoneNumber` to provide the phone number, or use `requestQrCodeAuthentication`, or `checkAuthenticationBotToken` for other authentication options
      discard
    of asWaitCode:
      ## TDLib needs the user's authentication code to authorize
      wcCodeInfo* {.jsonName: "code_info".}: AuthenticationCodeInfo ## Information about the authorization code that was sent
    of asWaitOtherDeviceConfirmation:
      ## The user needs to confirm authorization on another logged in device by scanning a QR code with the provided link
      wodcLink* {.jsonName: "link".}: string ## A tg:// URL for the QR code. The link will be updated frequently
    of asWaitRegistration:
      ## The user is unregistered and need to accept terms of service and enter their first name and last name to finish registration
      wrTermsOfService* {.jsonName: "terms_of_service".}: TermsOfService ## Telegram terms of service
    of asWaitPassword:
      ## The user has been authorized, but needs to enter a password to start using the application
      wpPasswordHint* {.jsonName: "password_hint".}: string ## Hint for the password; may be empty
      wpHasRecoveryEmailAddress* {.jsonName: "has_recovery_email_address".}: bool ## True, if a recovery email address has been set up
      wpRecoveryEmailAddressPattern* {.jsonName: "recovery_email_address_pattern".}: string ## Pattern of the email address to which the recovery email was sent; empty until a recovery email has been sent
    of asReady:
      ## The user has been successfully authorized. TDLib is now ready to answer queries
      discard
    of asLoggingOut:
      ## The user is currently logging out
      discard
    of asClosing:
      ## TDLib is closing, all subsequent queries will be answered with the error 500. Note that closing TDLib can take a while. All resources will be freed only after authorizationStateClosed has been received
      discard
    of asClosed:
      ## TDLib client is in its final state. All databases are closed and all resources are released. No other updates will be received after this. All queries will be responded to
      discard

  PassportElementTypeKind * {.pure.} = enum
    petEmailAddress = "passportElementTypeEmailAddress",
    petTemporaryRegistration = "passportElementTypeTemporaryRegistration",
    petAddress = "passportElementTypeAddress",
    petUtilityBill = "passportElementTypeUtilityBill",
    petPhoneNumber = "passportElementTypePhoneNumber",
    petInternalPassport = "passportElementTypeInternalPassport",
    petRentalAgreement = "passportElementTypeRentalAgreement",
    petIdentityCard = "passportElementTypeIdentityCard",
    petBankStatement = "passportElementTypeBankStatement",
    petPersonalDetails = "passportElementTypePersonalDetails",
    petDriverLicense = "passportElementTypeDriverLicense",
    petPassport = "passportElementTypePassport",
    petPassportRegistration = "passportElementTypePassportRegistration",

  PassportElementType * = object
    ## Contains the type of a Telegram Passport element
    case kind* {.jsonName: "@type".}: PassportElementTypeKind
    of petPersonalDetails:
      ## A Telegram Passport element containing the user's personal details
      discard
    of petPassport:
      ## A Telegram Passport element containing the user's passport
      discard
    of petDriverLicense:
      ## A Telegram Passport element containing the user's driver license
      discard
    of petIdentityCard:
      ## A Telegram Passport element containing the user's identity card
      discard
    of petInternalPassport:
      ## A Telegram Passport element containing the user's internal passport
      discard
    of petAddress:
      ## A Telegram Passport element containing the user's address
      discard
    of petUtilityBill:
      ## A Telegram Passport element containing the user's utility bill
      discard
    of petBankStatement:
      ## A Telegram Passport element containing the user's bank statement
      discard
    of petRentalAgreement:
      ## A Telegram Passport element containing the user's rental agreement
      discard
    of petPassportRegistration:
      ## A Telegram Passport element containing the registration page of the user's passport
      discard
    of petTemporaryRegistration:
      ## A Telegram Passport element containing the user's temporary registration
      discard
    of petPhoneNumber:
      ## A Telegram Passport element containing the user's phone number
      discard
    of petEmailAddress:
      ## A Telegram Passport element containing the user's email address
      discard

  PassportAuthorizationForm * = object
    ## Contains information about a Telegram Passport authorization form that was requested
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32 ## Unique identifier of the authorization form
    requiredElements* {.jsonName: "required_elements".}: seq[PassportRequiredElement] ## Information about the Telegram Passport elements that need to be provided to complete the form
    privacyPolicyUrl* {.jsonName: "privacy_policy_url".}: string ## URL for the privacy policy of the service; may be empty

  Stickers * = object
    ## Represents a list of stickers
    kind {.jsonName: "@type".}: string
    stickers* {.jsonName: "stickers".}: seq[Sticker] ## List of stickers

  ChatEventActionKind * {.pure.} = enum
    cePhotoChanged = "chatEventPhotoChanged",
    ceLinkedChatChanged = "chatEventLinkedChatChanged",
    ceMemberInvited = "chatEventMemberInvited",
    ceSlowModeDelayChanged = "chatEventSlowModeDelayChanged",
    ceInvitesToggled = "chatEventInvitesToggled",
    ceIsAllHistoryAvailableToggled = "chatEventIsAllHistoryAvailableToggled",
    ceMessageEdited = "chatEventMessageEdited",
    ceMemberJoined = "chatEventMemberJoined",
    ceStickerSetChanged = "chatEventStickerSetChanged",
    ceMessageDeleted = "chatEventMessageDeleted",
    ceTitleChanged = "chatEventTitleChanged",
    ceMemberRestricted = "chatEventMemberRestricted",
    ceLocationChanged = "chatEventLocationChanged",
    ceSignMessagesToggled = "chatEventSignMessagesToggled",
    ceUsernameChanged = "chatEventUsernameChanged",
    ceMessageUnpinned = "chatEventMessageUnpinned",
    ceMessagePinned = "chatEventMessagePinned",
    ceMemberLeft = "chatEventMemberLeft",
    ceMemberPromoted = "chatEventMemberPromoted",
    ceDescriptionChanged = "chatEventDescriptionChanged",
    cePollStopped = "chatEventPollStopped",
    cePermissionsChanged = "chatEventPermissionsChanged",

  ChatEventAction * = object
    ## Represents a chat event
    case kind* {.jsonName: "@type".}: ChatEventActionKind
    of ceMessageEdited:
      ## A message was edited
      emeOldMessage* {.jsonName: "old_message".}: Message ## The original message before the edit
      emeNewMessage* {.jsonName: "new_message".}: Message ## The message after it was edited
    of ceMessageDeleted:
      ## A message was deleted
      emdMessage* {.jsonName: "message".}: Message ## Deleted message
    of cePollStopped:
      ## A poll in a message was stopped
      epsMessage* {.jsonName: "message".}: Message ## The message with the poll
    of ceMessagePinned:
      ## A message was pinned
      empMessage* {.jsonName: "message".}: Message ## Pinned message
    of ceMessageUnpinned:
      ## A message was unpinned
      discard
    of ceMemberJoined:
      ## A new member joined the chat
      discard
    of ceMemberLeft:
      ## A member left the chat
      discard
    of ceMemberInvited:
      ## A new chat member was invited
      emiUserId* {.jsonName: "user_id".}: int32 ## New member user identifier
      emiStatus* {.jsonName: "status".}: ChatMemberStatus ## New member status
    of ceMemberPromoted:
      ## A chat member has gained/lost administrator status, or the list of their administrator privileges has changed
      empUserId* {.jsonName: "user_id".}: int32 ## Chat member user identifier
      empOldStatus* {.jsonName: "old_status".}: ChatMemberStatus ## Previous status of the chat member
      empNewStatus* {.jsonName: "new_status".}: ChatMemberStatus ## New status of the chat member
    of ceMemberRestricted:
      ## A chat member was restricted/unrestricted or banned/unbanned, or the list of their restrictions has changed
      emrUserId* {.jsonName: "user_id".}: int32 ## Chat member user identifier
      emrOldStatus* {.jsonName: "old_status".}: ChatMemberStatus ## Previous status of the chat member
      emrNewStatus* {.jsonName: "new_status".}: ChatMemberStatus ## New status of the chat member
    of ceTitleChanged:
      ## The chat title was changed
      etcOldTitle* {.jsonName: "old_title".}: string ## Previous chat title
      etcNewTitle* {.jsonName: "new_title".}: string ## New chat title
    of cePermissionsChanged:
      ## The chat permissions was changed
      epcOldPermissions* {.jsonName: "old_permissions".}: ChatPermissions ## Previous chat permissions
      epcNewPermissions* {.jsonName: "new_permissions".}: ChatPermissions ## New chat permissions
    of ceDescriptionChanged:
      ## The chat description was changed
      edcOldDescription* {.jsonName: "old_description".}: string ## Previous chat description
      edcNewDescription* {.jsonName: "new_description".}: string ## New chat description
    of ceUsernameChanged:
      ## The chat username was changed
      eucOldUsername* {.jsonName: "old_username".}: string ## Previous chat username
      eucNewUsername* {.jsonName: "new_username".}: string ## New chat username
    of cePhotoChanged:
      ## The chat photo was changed
      epcOldPhoto* {.jsonName: "old_photo".}: Option[Photo] ## Previous chat photo value; may be null
      epcNewPhoto* {.jsonName: "new_photo".}: Option[Photo] ## New chat photo value; may be null
    of ceInvitesToggled:
      ## The can_invite_users permission of a supergroup chat was toggled
      eitCanInviteUsers* {.jsonName: "can_invite_users".}: bool ## New value of can_invite_users permission
    of ceLinkedChatChanged:
      ## The linked chat of a supergroup was changed
      elccOldLinkedChatId* {.jsonName: "old_linked_chat_id".}: int64 ## Previous supergroup linked chat identifier
      elccNewLinkedChatId* {.jsonName: "new_linked_chat_id".}: int64 ## New supergroup linked chat identifier
    of ceSlowModeDelayChanged:
      ## The slow_mode_delay setting of a supergroup was changed
      esmdcOldSlowModeDelay* {.jsonName: "old_slow_mode_delay".}: int32 ## Previous value of slow_mode_delay
      esmdcNewSlowModeDelay* {.jsonName: "new_slow_mode_delay".}: int32 ## New value of slow_mode_delay
    of ceSignMessagesToggled:
      ## The sign_messages setting of a channel was toggled
      esmtSignMessages* {.jsonName: "sign_messages".}: bool ## New value of sign_messages
    of ceStickerSetChanged:
      ## The supergroup sticker set was changed
      esscOldStickerSetId* {.jsonName: "old_sticker_set_id".}: string ## Previous identifier of the chat sticker set; 0 if none
      esscNewStickerSetId* {.jsonName: "new_sticker_set_id".}: string ## New identifier of the chat sticker set; 0 if none
    of ceLocationChanged:
      ## The supergroup location was changed
      elcOldLocation* {.jsonName: "old_location".}: Option[ChatLocation] ## Previous location; may be null
      elcNewLocation* {.jsonName: "new_location".}: Option[ChatLocation] ## New location; may be null
    of ceIsAllHistoryAvailableToggled:
      ## The is_all_history_available setting of a supergroup was toggled
      eiahatIsAllHistoryAvailable* {.jsonName: "is_all_history_available".}: bool ## New value of is_all_history_available

  Message * = object
    ## Describes a message
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int64 ## Message identifier, unique for the chat to which the message belongs
    senderUserId* {.jsonName: "sender_user_id".}: int32 ## Identifier of the user who sent the message; 0 if unknown. Currently, it is unknown for channel posts and for channel posts automatically forwarded to discussion group
    chatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
    sendingState* {.jsonName: "sending_state".}: Option[MessageSendingState] ## Information about the sending state of the message; may be null
    schedulingState* {.jsonName: "scheduling_state".}: Option[MessageSchedulingState] ## Information about the scheduling state of the message; may be null
    isOutgoing* {.jsonName: "is_outgoing".}: bool ## True, if the message is outgoing
    canBeEdited* {.jsonName: "can_be_edited".}: bool ## True, if the message can be edited. For live location and poll messages this fields shows whether editMessageLiveLocation or stopPoll can be used with this message by the client
    canBeForwarded* {.jsonName: "can_be_forwarded".}: bool ## True, if the message can be forwarded
    canBeDeletedOnlyForSelf* {.jsonName: "can_be_deleted_only_for_self".}: bool ## True, if the message can be deleted only for the current user while other users will continue to see it
    canBeDeletedForAllUsers* {.jsonName: "can_be_deleted_for_all_users".}: bool ## True, if the message can be deleted for all users
    isChannelPost* {.jsonName: "is_channel_post".}: bool ## True, if the message is a channel post. All messages to channels are channel posts, all other messages are not channel posts
    containsUnreadMention* {.jsonName: "contains_unread_mention".}: bool ## True, if the message contains an unread mention for the current user
    date* {.jsonName: "date".}: int32 ## Point in time (Unix timestamp) when the message was sent
    editDate* {.jsonName: "edit_date".}: int32 ## Point in time (Unix timestamp) when the message was last edited
    forwardInfo* {.jsonName: "forward_info".}: Option[MessageForwardInfo] ## Information about the initial message sender; may be null
    replyToMessageId* {.jsonName: "reply_to_message_id".}: int64 ## If non-zero, the identifier of the message this message is replying to; can be the identifier of a deleted message
    ttl* {.jsonName: "ttl".}: int32 ## For self-destructing messages, the message's TTL (Time To Live), in seconds; 0 if none. TDLib will send updateDeleteMessages or updateMessageContent once the TTL expires
    ttlExpiresIn* {.jsonName: "ttl_expires_in".}: float ## Time left before the message expires, in seconds
    viaBotUserId* {.jsonName: "via_bot_user_id".}: int32 ## If non-zero, the user identifier of the bot through which this message was sent
    authorSignature* {.jsonName: "author_signature".}: string ## For channel posts, optional author signature
    views* {.jsonName: "views".}: int32 ## Number of times this message was viewed
    mediaAlbumId* {.jsonName: "media_album_id".}: string ## Unique identifier of an album this message belongs to. Only photos and videos can be grouped together in albums
    restrictionReason* {.jsonName: "restriction_reason".}: string ## If non-empty, contains a human-readable description of the reason why access to this message must be restricted
    content* {.jsonName: "content".}: MessageContent ## Content of the message
    replyMarkup* {.jsonName: "reply_markup".}: Option[ReplyMarkup] ## Reply markup for the message; may be null

  SecretChatStateKind * {.pure.} = enum
    scsClosed = "secretChatStateClosed",
    scsReady = "secretChatStateReady",
    scsPending = "secretChatStatePending",

  SecretChatState * = object
    ## Describes the current secret chat state
    case kind* {.jsonName: "@type".}: SecretChatStateKind
    of scsPending:
      ## The secret chat is not yet created; waiting for the other user to get online
      discard
    of scsReady:
      ## The secret chat is ready to use
      discard
    of scsClosed:
      ## The secret chat is closed
      discard

  NetworkStatisticsEntryKind * {.pure.} = enum
    nseCall = "networkStatisticsEntryCall",
    nseFile = "networkStatisticsEntryFile",

  NetworkStatisticsEntry * = object
    ## Contains statistics about network usage
    case kind* {.jsonName: "@type".}: NetworkStatisticsEntryKind
    of nseFile:
      ## Contains information about the total amount of data that was used to send and receive files
      networkstatisticsentryfiFileType* {.jsonName: "file_type".}: FileType ## Type of the file the data is part of
      networkstatisticsentryfiNetworkType* {.jsonName: "network_type".}: NetworkType ## Type of the network the data was sent through. Call setNetworkType to maintain the actual network type
      networkstatisticsentryfiSentBytes* {.jsonName: "sent_bytes".}: int64 ## Total number of bytes sent
      networkstatisticsentryfiReceivedBytes* {.jsonName: "received_bytes".}: int64 ## Total number of bytes received
    of nseCall:
      ## Contains information about the total amount of data that was used for calls
      networkstatisticsentrycaNetworkType* {.jsonName: "network_type".}: NetworkType ## Type of the network the data was sent through. Call setNetworkType to maintain the actual network type
      networkstatisticsentrycaSentBytes* {.jsonName: "sent_bytes".}: int64 ## Total number of bytes sent
      networkstatisticsentrycaReceivedBytes* {.jsonName: "received_bytes".}: int64 ## Total number of bytes received
      networkstatisticsentrycaDuration* {.jsonName: "duration".}: float ## Total call duration, in seconds

  ChatSourceKind * {.pure.} = enum
    csMtprotoProxy = "chatSourceMtprotoProxy",
    csPublicServiceAnnouncement = "chatSourcePublicServiceAnnouncement",

  ChatSource * = object
    ## Describes a reason why the chat is shown in a chat list
    case kind* {.jsonName: "@type".}: ChatSourceKind
    of csMtprotoProxy:
      ## The chat is sponsored by the user's MTProxy server
      discard
    of csPublicServiceAnnouncement:
      ## The chat contains a public service announcement
      psaType* {.jsonName: "type".}: string ## The type of the announcement
      psaText* {.jsonName: "text".}: string ## The text of the announcement

  Messages * = object
    ## Contains a list of messages
    kind {.jsonName: "@type".}: string
    totalCount* {.jsonName: "total_count".}: int32 ## Approximate total count of messages found
    messages* {.jsonName: "messages".}: Option[seq[Message]] ## List of messages; messages may be null

  EncryptedCredentials * = object
    ## Contains encrypted Telegram Passport data credentials
    kind {.jsonName: "@type".}: string
    data* {.jsonName: "data".}: string ## The encrypted credentials
    hash* {.jsonName: "hash".}: string ## The decrypted data hash
    secret* {.jsonName: "secret".}: string ## Secret for data decryption, encrypted with the service's public key

  LanguagePackStrings * = object
    ## Contains a list of language pack strings
    kind {.jsonName: "@type".}: string
    strings* {.jsonName: "strings".}: seq[LanguagePackString] ## A list of language pack strings

  TestVectorIntObject * = object
    ## A simple object containing a vector of objects that hold a number; for testing only
    kind {.jsonName: "@type".}: string
    value* {.jsonName: "value".}: seq[TestInt] ## Vector of objects

  Ok * = object
    ## An object of this type is returned on a successful function call for certain functions
    kind {.jsonName: "@type".}: string

  InputFileKind * {.pure.} = enum
    ifLocal = "inputFileLocal",
    ifGenerated = "inputFileGenerated",
    ifRemote = "inputFileRemote",
    ifId = "inputFileId",

  InputFile * = object
    ## Points to a file
    case kind* {.jsonName: "@type".}: InputFileKind
    of ifId:
      ## A file defined by its unique ID
      inputfileId* {.jsonName: "id".}: int32 ## Unique file identifier
    of ifRemote:
      ## A file defined by its remote ID. The remote ID is guaranteed to be usable only if the corresponding file is still accessible to the user and known to TDLib.
      inputfileremoId* {.jsonName: "id".}: string ## Remote file identifier
    of ifLocal:
      ## A file defined by a local path
      inputfilelocPath* {.jsonName: "path".}: string ## Local path to the file
    of ifGenerated:
      ## A file generated by the client
      inputfilegeneratOriginalPath* {.jsonName: "original_path".}: string ## Local path to a file from which the file is generated; may be empty if there is no such file
      inputfilegeneratConversion* {.jsonName: "conversion".}: string ## String specifying the conversion applied to the original file; should be persistent across application restarts. Conversions beginning with '#' are reserved for internal TDLib usage
      inputfilegeneratExpectedSize* {.jsonName: "expected_size".}: int32 ## Expected size of the generated file; 0 if unknown

  Contact * = object
    ## Describes a user contact
    kind {.jsonName: "@type".}: string
    phoneNumber* {.jsonName: "phone_number".}: string ## Phone number of the user
    firstName* {.jsonName: "first_name".}: string ## First name of the user; 1-255 characters in length
    lastName* {.jsonName: "last_name".}: string ## Last name of the user
    vcard* {.jsonName: "vcard".}: string ## Additional data about the user in a form of vCard; 0-2048 bytes in length
    userId* {.jsonName: "user_id".}: int32 ## Identifier of the user, if known; otherwise 0

  CallConnection * = object
    ## Describes the address of UDP reflectors
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string ## Reflector identifier
    ip* {.jsonName: "ip".}: string ## IPv4 reflector address
    ipv6* {.jsonName: "ipv6".}: string ## IPv6 reflector address
    port* {.jsonName: "port".}: int32 ## Reflector port number
    peerTag* {.jsonName: "peer_tag".}: string ## Connection peer tag

  KeyboardButton * = object
    ## Represents a single button in a bot keyboard
    kind {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: string ## Text of the button
    typ* {.jsonName: "type".}: KeyboardButtonType ## Type of the button

  ProxyTypeKind * {.pure.} = enum
    ptSocks5 = "proxyTypeSocks5",
    ptMtproto = "proxyTypeMtproto",
    ptHttp = "proxyTypeHttp",

  ProxyType * = object
    ## Describes the type of a proxy server
    case kind* {.jsonName: "@type".}: ProxyTypeKind
    of ptSocks5:
      ## A SOCKS5 proxy server
      proxytypesockUsername* {.jsonName: "username".}: string ## Username for logging in; may be empty
      proxytypesockPassword* {.jsonName: "password".}: string ## Password for logging in; may be empty
    of ptHttp:
      ## A HTTP transparent proxy server
      proxytypehtUsername* {.jsonName: "username".}: string ## Username for logging in; may be empty
      proxytypehtPassword* {.jsonName: "password".}: string ## Password for logging in; may be empty
      proxytypehtHttpOnly* {.jsonName: "http_only".}: bool ## Pass true if the proxy supports only HTTP requests and doesn't support transparent TCP connections via HTTP CONNECT method
    of ptMtproto:
      ## An MTProto proxy server
      proxytypemtproSecret* {.jsonName: "secret".}: string ## The proxy's secret in hexadecimal encoding

  LoginUrlInfoKind * {.pure.} = enum
    luiRequestConfirmation = "loginUrlInfoRequestConfirmation",
    luiOpen = "loginUrlInfoOpen",

  LoginUrlInfo * = object
    ## Contains information about an inline button of type inlineKeyboardButtonTypeLoginUrl
    case kind* {.jsonName: "@type".}: LoginUrlInfoKind
    of luiOpen:
      ## An HTTP url needs to be open
      loginurlinfoopUrl* {.jsonName: "url".}: string ## The URL to open
      loginurlinfoopSkipConfirm* {.jsonName: "skip_confirm".}: bool ## True, if there is no need to show an ordinary open URL confirm
    of luiRequestConfirmation:
      ## An authorization confirmation dialog needs to be shown to the user
      rcUrl* {.jsonName: "url".}: string ## An HTTP URL to be opened
      rcDomain* {.jsonName: "domain".}: string ## A domain of the URL
      rcBotUserId* {.jsonName: "bot_user_id".}: int32 ## User identifier of a bot linked with the website
      rcRequestWriteAccess* {.jsonName: "request_write_access".}: bool ## True, if the user needs to be requested to give the permission to the bot to send them messages

  UserPrivacySettingKind * {.pure.} = enum
    upsAllowChatInvites = "userPrivacySettingAllowChatInvites",
    upsShowStatus = "userPrivacySettingShowStatus",
    upsShowPhoneNumber = "userPrivacySettingShowPhoneNumber",
    upsAllowCalls = "userPrivacySettingAllowCalls",
    upsShowProfilePhoto = "userPrivacySettingShowProfilePhoto",
    upsShowLinkInForwardedMessages = "userPrivacySettingShowLinkInForwardedMessages",
    upsAllowPeerToPeerCalls = "userPrivacySettingAllowPeerToPeerCalls",
    upsAllowFindingByPhoneNumber = "userPrivacySettingAllowFindingByPhoneNumber",

  UserPrivacySetting * = object
    ## Describes available user privacy settings
    case kind* {.jsonName: "@type".}: UserPrivacySettingKind
    of upsShowStatus:
      ## A privacy setting for managing whether the user's online status is visible
      discard
    of upsShowProfilePhoto:
      ## A privacy setting for managing whether the user's profile photo is visible
      discard
    of upsShowLinkInForwardedMessages:
      ## A privacy setting for managing whether a link to the user's account is included in forwarded messages
      discard
    of upsShowPhoneNumber:
      ## A privacy setting for managing whether the user's phone number is visible
      discard
    of upsAllowChatInvites:
      ## A privacy setting for managing whether the user can be invited to chats
      discard
    of upsAllowCalls:
      ## A privacy setting for managing whether the user can be called
      discard
    of upsAllowPeerToPeerCalls:
      ## A privacy setting for managing whether peer-to-peer connections can be used for calls
      discard
    of upsAllowFindingByPhoneNumber:
      ## A privacy setting for managing whether the user can be found by their phone number. Checked only if the phone number is not known to the other user. Can be set only to "Allow contacts" or "Allow all"
      discard

  PushMessageContentKind * {.pure.} = enum
    pmcChatDeleteMember = "pushMessageContentChatDeleteMember",
    pmcAnimation = "pushMessageContentAnimation",
    pmcChatAddMembers = "pushMessageContentChatAddMembers",
    pmcLocation = "pushMessageContentLocation",
    pmcVideo = "pushMessageContentVideo",
    pmcScreenshotTaken = "pushMessageContentScreenshotTaken",
    pmcAudio = "pushMessageContentAudio",
    pmcSticker = "pushMessageContentSticker",
    pmcChatChangePhoto = "pushMessageContentChatChangePhoto",
    pmcMediaAlbum = "pushMessageContentMediaAlbum",
    pmcDocument = "pushMessageContentDocument",
    pmcGameScore = "pushMessageContentGameScore",
    pmcPhoto = "pushMessageContentPhoto",
    pmcPoll = "pushMessageContentPoll",
    pmcBasicGroupChatCreate = "pushMessageContentBasicGroupChatCreate",
    pmcHidden = "pushMessageContentHidden",
    pmcText = "pushMessageContentText",
    pmcMessageForwards = "pushMessageContentMessageForwards",
    pmcChatJoinByLink = "pushMessageContentChatJoinByLink",
    pmcInvoice = "pushMessageContentInvoice",
    pmcChatChangeTitle = "pushMessageContentChatChangeTitle",
    pmcContact = "pushMessageContentContact",
    pmcContactRegistered = "pushMessageContentContactRegistered",
    pmcVideoNote = "pushMessageContentVideoNote",
    pmcGame = "pushMessageContentGame",
    pmcVoiceNote = "pushMessageContentVoiceNote",

  PushMessageContent * = object
    ## Contains content of a push message notification
    case kind* {.jsonName: "@type".}: PushMessageContentKind
    of pmcHidden:
      ## A general message with hidden content
      pushmessagecontenthiddIsPinned* {.jsonName: "is_pinned".}: bool ## True, if the message is a pinned message with the specified content
    of pmcAnimation:
      ## An animation message (GIF-style).
      pushmessagecontentanimatiAnimation* {.jsonName: "animation".}: Option[Animation] ## Message content; may be null
      pushmessagecontentanimatiCaption* {.jsonName: "caption".}: string ## Animation caption
      pushmessagecontentanimatiIsPinned* {.jsonName: "is_pinned".}: bool ## True, if the message is a pinned message with the specified content
    of pmcAudio:
      ## An audio message
      pushmessagecontentaudAudio* {.jsonName: "audio".}: Option[Audio] ## Message content; may be null
      pushmessagecontentaudIsPinned* {.jsonName: "is_pinned".}: bool ## True, if the message is a pinned message with the specified content
    of pmcContact:
      ## A message with a user contact
      pushmessagecontentcontaName* {.jsonName: "name".}: string ## Contact's name
      pushmessagecontentcontaIsPinned* {.jsonName: "is_pinned".}: bool ## True, if the message is a pinned message with the specified content
    of pmcContactRegistered:
      ## A contact has registered with Telegram
      discard
    of pmcDocument:
      ## A document message (a general file)
      pushmessagecontentdocumeDocument* {.jsonName: "document".}: Option[Document] ## Message content; may be null
      pushmessagecontentdocumeIsPinned* {.jsonName: "is_pinned".}: bool ## True, if the message is a pinned message with the specified content
    of pmcGame:
      ## A message with a game
      pushmessagecontentgaTitle* {.jsonName: "title".}: string ## Game title, empty for pinned game message
      pushmessagecontentgaIsPinned* {.jsonName: "is_pinned".}: bool ## True, if the message is a pinned message with the specified content
    of pmcGameScore:
      ## A new high score was achieved in a game
      gsTitle* {.jsonName: "title".}: string ## Game title, empty for pinned message
      gsScore* {.jsonName: "score".}: int32 ## New score, 0 for pinned message
      gsIsPinned* {.jsonName: "is_pinned".}: bool ## True, if the message is a pinned message with the specified content
    of pmcInvoice:
      ## A message with an invoice from a bot
      pushmessagecontentinvoiPrice* {.jsonName: "price".}: string ## Product price
      pushmessagecontentinvoiIsPinned* {.jsonName: "is_pinned".}: bool ## True, if the message is a pinned message with the specified content
    of pmcLocation:
      ## A message with a location
      pushmessagecontentlocatiIsLive* {.jsonName: "is_live".}: bool ## True, if the location is live
      pushmessagecontentlocatiIsPinned* {.jsonName: "is_pinned".}: bool ## True, if the message is a pinned message with the specified content
    of pmcPhoto:
      ## A photo message
      pushmessagecontentphoPhoto* {.jsonName: "photo".}: Option[Photo] ## Message content; may be null
      pushmessagecontentphoCaption* {.jsonName: "caption".}: string ## Photo caption
      pushmessagecontentphoIsSecret* {.jsonName: "is_secret".}: bool ## True, if the photo is secret
      pushmessagecontentphoIsPinned* {.jsonName: "is_pinned".}: bool ## True, if the message is a pinned message with the specified content
    of pmcPoll:
      ## A message with a poll
      pushmessagecontentpoQuestion* {.jsonName: "question".}: string ## Poll question
      pushmessagecontentpoIsRegular* {.jsonName: "is_regular".}: bool ## True, if the poll is regular and not in quiz mode
      pushmessagecontentpoIsPinned* {.jsonName: "is_pinned".}: bool ## True, if the message is a pinned message with the specified content
    of pmcScreenshotTaken:
      ## A screenshot of a message in the chat has been taken
      discard
    of pmcSticker:
      ## A message with a sticker
      pushmessagecontentstickSticker* {.jsonName: "sticker".}: Option[Sticker] ## Message content; may be null
      pushmessagecontentstickEmoji* {.jsonName: "emoji".}: string ## Emoji corresponding to the sticker; may be empty
      pushmessagecontentstickIsPinned* {.jsonName: "is_pinned".}: bool ## True, if the message is a pinned message with the specified content
    of pmcText:
      ## A text message
      pushmessagecontentteText* {.jsonName: "text".}: string ## Message text
      pushmessagecontentteIsPinned* {.jsonName: "is_pinned".}: bool ## True, if the message is a pinned message with the specified content
    of pmcVideo:
      ## A video message
      pushmessagecontentvidVideo* {.jsonName: "video".}: Option[Video] ## Message content; may be null
      pushmessagecontentvidCaption* {.jsonName: "caption".}: string ## Video caption
      pushmessagecontentvidIsSecret* {.jsonName: "is_secret".}: bool ## True, if the video is secret
      pushmessagecontentvidIsPinned* {.jsonName: "is_pinned".}: bool ## True, if the message is a pinned message with the specified content
    of pmcVideoNote:
      ## A video note message
      vnVideoNote* {.jsonName: "video_note".}: Option[VideoNote] ## Message content; may be null
      vnIsPinned* {.jsonName: "is_pinned".}: bool ## True, if the message is a pinned message with the specified content
    of pmcVoiceNote:
      ## A voice note message
      vnVoiceNote* {.jsonName: "voice_note".}: Option[VoiceNote] ## Message content; may be null
      vnoteIsPinned* {.jsonName: "is_pinned".}: bool ## True, if the message is a pinned message with the specified content
    of pmcBasicGroupChatCreate:
      ## A newly created basic group
      discard
    of pmcChatAddMembers:
      ## New chat members were invited to a group
      camMemberName* {.jsonName: "member_name".}: string ## Name of the added member
      camIsCurrentUser* {.jsonName: "is_current_user".}: bool ## True, if the current user was added to the group
      camIsReturned* {.jsonName: "is_returned".}: bool ## True, if the user has returned to the group themself
    of pmcChatChangePhoto:
      ## A chat photo was edited
      discard
    of pmcChatChangeTitle:
      ## A chat title was edited
      cctTitle* {.jsonName: "title".}: string ## New chat title
    of pmcChatDeleteMember:
      ## A chat member was deleted
      cdmMemberName* {.jsonName: "member_name".}: string ## Name of the deleted member
      cdmIsCurrentUser* {.jsonName: "is_current_user".}: bool ## True, if the current user was deleted from the group
      cdmIsLeft* {.jsonName: "is_left".}: bool ## True, if the user has left the group themself
    of pmcChatJoinByLink:
      ## A new member joined the chat by invite link
      discard
    of pmcMessageForwards:
      ## A forwarded messages
      mfTotalCount* {.jsonName: "total_count".}: int32 ## Number of forwarded messages
    of pmcMediaAlbum:
      ## A media album
      maTotalCount* {.jsonName: "total_count".}: int32 ## Number of messages in the album
      maHasPhotos* {.jsonName: "has_photos".}: bool ## True, if the album has at least one photo
      maHasVideos* {.jsonName: "has_videos".}: bool ## True, if the album has at least one video

  PersonalDocument * = object
    ## A personal document, containing some information about a user
    kind {.jsonName: "@type".}: string
    files* {.jsonName: "files".}: seq[DatedFile] ## List of files containing the pages of the document
    translation* {.jsonName: "translation".}: seq[DatedFile] ## List of files containing a certified English translation of the document

  TermsOfService * = object
    ## Contains Telegram terms of service
    kind {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: FormattedText ## Text of the terms of service
    minUserAge* {.jsonName: "min_user_age".}: int32 ## The minimum age of a user to be able to accept the terms; 0 if any
    showPopup* {.jsonName: "show_popup".}: bool ## True, if a blocking popup with terms of service must be shown to the user

  ChatMemberStatusKind * {.pure.} = enum
    cmsCreator = "chatMemberStatusCreator",
    cmsRestricted = "chatMemberStatusRestricted",
    cmsMember = "chatMemberStatusMember",
    cmsAdministrator = "chatMemberStatusAdministrator",
    cmsBanned = "chatMemberStatusBanned",
    cmsLeft = "chatMemberStatusLeft",

  ChatMemberStatus * = object
    ## Provides information about the status of a member in a chat
    case kind* {.jsonName: "@type".}: ChatMemberStatusKind
    of cmsCreator:
      ## The user is the owner of a chat and has all the administrator privileges
      chatmemberstatuscreatCustomTitle* {.jsonName: "custom_title".}: string ## A custom title of the owner; 0-16 characters without emojis; applicable to supergroups only
      chatmemberstatuscreatIsMember* {.jsonName: "is_member".}: bool ## True, if the user is a member of the chat
    of cmsAdministrator:
      ## The user is a member of a chat and has some additional privileges. In basic groups, administrators can edit and delete messages sent by others, add new members, and ban unprivileged members. In supergroups and channels, there are more detailed options for administrator privileges
      chatmemberstatusadministratCustomTitle* {.jsonName: "custom_title".}: string ## A custom title of the administrator; 0-16 characters without emojis; applicable to supergroups only
      chatmemberstatusadministratCanBeEdited* {.jsonName: "can_be_edited".}: bool ## True, if the current user can edit the administrator privileges for the called user
      chatmemberstatusadministratCanChangeInfo* {.jsonName: "can_change_info".}: bool ## True, if the administrator can change the chat title, photo, and other settings
      chatmemberstatusadministratCanPostMessages* {.jsonName: "can_post_messages".}: bool ## True, if the administrator can create channel posts; applicable to channels only
      chatmemberstatusadministratCanEditMessages* {.jsonName: "can_edit_messages".}: bool ## True, if the administrator can edit messages of other users and pin messages; applicable to channels only
      chatmemberstatusadministratCanDeleteMessages* {.jsonName: "can_delete_messages".}: bool ## True, if the administrator can delete messages of other users
      chatmemberstatusadministratCanInviteUsers* {.jsonName: "can_invite_users".}: bool ## True, if the administrator can invite new users to the chat
      chatmemberstatusadministratCanRestrictMembers* {.jsonName: "can_restrict_members".}: bool ## True, if the administrator can restrict, ban, or unban chat members
      chatmemberstatusadministratCanPinMessages* {.jsonName: "can_pin_messages".}: bool ## True, if the administrator can pin messages; applicable to groups only
      chatmemberstatusadministratCanPromoteMembers* {.jsonName: "can_promote_members".}: bool ## True, if the administrator can add new administrators with a subset of their own privileges or demote administrators that were directly or indirectly promoted by them
    of cmsMember:
      ## The user is a member of a chat, without any additional privileges or restrictions
      discard
    of cmsRestricted:
      ## The user is under certain restrictions in the chat. Not supported in basic groups and channels
      chatmemberstatusrestrictIsMember* {.jsonName: "is_member".}: bool ## True, if the user is a member of the chat
      chatmemberstatusrestrictRestrictedUntilDate* {.jsonName: "restricted_until_date".}: int32 ## Point in time (Unix timestamp) when restrictions will be lifted from the user; 0 if never. If the user is restricted for more than 366 days or for less than 30 seconds from the current time, the user is considered to be restricted forever
      chatmemberstatusrestrictPermissions* {.jsonName: "permissions".}: ChatPermissions ## User permissions in the chat
    of cmsLeft:
      ## The user is not a chat member
      discard
    of cmsBanned:
      ## The user was banned (and hence is not a member of the chat). Implies the user can't return to the chat or view messages
      chatmemberstatusbannBannedUntilDate* {.jsonName: "banned_until_date".}: int32 ## Point in time (Unix timestamp) when the user will be unbanned; 0 if never. If the user is banned for more than 366 days or for less than 30 seconds from the current time, the user is considered to be banned forever

  Hashtags * = object
    ## Contains a list of hashtags
    kind {.jsonName: "@type".}: string
    hashtags* {.jsonName: "hashtags".}: seq[string] ## A list of hashtags

  PushReceiverId * = object
    ## Contains a globally unique push receiver identifier, which can be used to identify which account has received a push notification
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string ## The globally unique identifier of push notification subscription

  SecretChat * = object
    ## Represents a secret chat
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32 ## Secret chat identifier
    userId* {.jsonName: "user_id".}: int32 ## Identifier of the chat partner
    state* {.jsonName: "state".}: SecretChatState ## State of the secret chat
    isOutbound* {.jsonName: "is_outbound".}: bool ## True, if the chat was created by the current user; otherwise false
    ttl* {.jsonName: "ttl".}: int32 ## Current message Time To Live setting (self-destruct timer) for the chat, in seconds
    keyHash* {.jsonName: "key_hash".}: string ## Hash of the currently used key for comparison with the hash of the chat partner's key. This is a string of 36 little-endian bytes, which must be split into groups of 2 bits, each denoting a pixel of one of 4 colors FFFFFF, D5E6F3, 2D5775, and 2F99C9.
    layer* {.jsonName: "layer".}: int32 ## Secret chat layer; determines features supported by the other client. Video notes are supported if the layer >= 66; nested text entities and underline and strikethrough entities are supported if the layer >= 101

  ConnectedWebsite * = object
    ## Contains information about one website the current user is logged in with Telegram
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string ## Website identifier
    domainName* {.jsonName: "domain_name".}: string ## The domain name of the website
    botUserId* {.jsonName: "bot_user_id".}: int32 ## User identifier of a bot linked with the website
    browser* {.jsonName: "browser".}: string ## The version of a browser used to log in
    platform* {.jsonName: "platform".}: string ## Operating system the browser is running on
    logInDate* {.jsonName: "log_in_date".}: int32 ## Point in time (Unix timestamp) when the user was logged in
    lastActiveDate* {.jsonName: "last_active_date".}: int32 ## Point in time (Unix timestamp) when obtained authorization was last used
    ip* {.jsonName: "ip".}: string ## IP address from which the user was logged in, in human-readable format
    location* {.jsonName: "location".}: string ## Human-readable description of a country and a region, from which the user was logged in, based on the IP address

  MessageContentKind * {.pure.} = enum
    mVideo = "messageVideo",
    mDice = "messageDice",
    mCall = "messageCall",
    mChatChangeTitle = "messageChatChangeTitle",
    mGameScore = "messageGameScore",
    mPinMessage = "messagePinMessage",
    mChatUpgradeFrom = "messageChatUpgradeFrom",
    mVoiceNote = "messageVoiceNote",
    mLocation = "messageLocation",
    mChatJoinByLink = "messageChatJoinByLink",
    mChatUpgradeTo = "messageChatUpgradeTo",
    mPaymentSuccessfulBot = "messagePaymentSuccessfulBot",
    mSupergroupChatCreate = "messageSupergroupChatCreate",
    mWebsiteConnected = "messageWebsiteConnected",
    mPoll = "messagePoll",
    mBasicGroupChatCreate = "messageBasicGroupChatCreate",
    mChatAddMembers = "messageChatAddMembers",
    mChatDeleteMember = "messageChatDeleteMember",
    mExpiredVideo = "messageExpiredVideo",
    mPassportDataReceived = "messagePassportDataReceived",
    mText = "messageText",
    mContact = "messageContact",
    mVideoNote = "messageVideoNote",
    mCustomServiceAction = "messageCustomServiceAction",
    mUnsupported = "messageUnsupported",
    mPassportDataSent = "messagePassportDataSent",
    mExpiredPhoto = "messageExpiredPhoto",
    mAnimation = "messageAnimation",
    mDocument = "messageDocument",
    mSticker = "messageSticker",
    mChatSetTtl = "messageChatSetTtl",
    mAudio = "messageAudio",
    mChatChangePhoto = "messageChatChangePhoto",
    mContactRegistered = "messageContactRegistered",
    mGame = "messageGame",
    mInvoice = "messageInvoice",
    mPaymentSuccessful = "messagePaymentSuccessful",
    mChatDeletePhoto = "messageChatDeletePhoto",
    mVenue = "messageVenue",
    mScreenshotTaken = "messageScreenshotTaken",
    mPhoto = "messagePhoto",

  MessageContent * = object
    ## Contains the content of a message
    case kind* {.jsonName: "@type".}: MessageContentKind
    of mText:
      ## A text message
      messageteText* {.jsonName: "text".}: FormattedText ## Text of the message
      messageteWebPage* {.jsonName: "web_page".}: Option[WebPage] ## A preview of the web page that's mentioned in the text; may be null
    of mAnimation:
      ## An animation message (GIF-style).
      messageanimatiAnimation* {.jsonName: "animation".}: Animation ## The animation description
      messageanimatiCaption* {.jsonName: "caption".}: FormattedText ## Animation caption
      messageanimatiIsSecret* {.jsonName: "is_secret".}: bool ## True, if the animation thumbnail must be blurred and the animation must be shown only while tapped
    of mAudio:
      ## An audio message
      messageaudAudio* {.jsonName: "audio".}: Audio ## The audio description
      messageaudCaption* {.jsonName: "caption".}: FormattedText ## Audio caption
    of mDocument:
      ## A document message (general file)
      messagedocumeDocument* {.jsonName: "document".}: Document ## The document description
      messagedocumeCaption* {.jsonName: "caption".}: FormattedText ## Document caption
    of mPhoto:
      ## A photo message
      messagephoPhoto* {.jsonName: "photo".}: Photo ## The photo description
      messagephoCaption* {.jsonName: "caption".}: FormattedText ## Photo caption
      messagephoIsSecret* {.jsonName: "is_secret".}: bool ## True, if the photo must be blurred and must be shown only while tapped
    of mExpiredPhoto:
      ## An expired photo message (self-destructed after TTL has elapsed)
      discard
    of mSticker:
      ## A sticker message
      messagestickSticker* {.jsonName: "sticker".}: Sticker ## The sticker description
    of mVideo:
      ## A video message
      messagevidVideo* {.jsonName: "video".}: Video ## The video description
      messagevidCaption* {.jsonName: "caption".}: FormattedText ## Video caption
      messagevidIsSecret* {.jsonName: "is_secret".}: bool ## True, if the video thumbnail must be blurred and the video must be shown only while tapped
    of mExpiredVideo:
      ## An expired video message (self-destructed after TTL has elapsed)
      discard
    of mVideoNote:
      ## A video note message
      vnVideoNote* {.jsonName: "video_note".}: VideoNote ## The video note description
      vnIsViewed* {.jsonName: "is_viewed".}: bool ## True, if at least one of the recipients has viewed the video note
      vnIsSecret* {.jsonName: "is_secret".}: bool ## True, if the video note thumbnail must be blurred and the video note must be shown only while tapped
    of mVoiceNote:
      ## A voice note message
      vnVoiceNote* {.jsonName: "voice_note".}: VoiceNote ## The voice note description
      vnCaption* {.jsonName: "caption".}: FormattedText ## Voice note caption
      vnIsListened* {.jsonName: "is_listened".}: bool ## True, if at least one of the recipients has listened to the voice note
    of mLocation:
      ## A message with a location
      messagelocatiLocation* {.jsonName: "location".}: Location ## The location description
      messagelocatiLivePeriod* {.jsonName: "live_period".}: int32 ## Time relative to the message sent date until which the location can be updated, in seconds
      messagelocatiExpiresIn* {.jsonName: "expires_in".}: int32 ## Left time for which the location can be updated, in seconds. updateMessageContent is not sent when this field changes
    of mVenue:
      ## A message with information about a venue
      messagevenVenue* {.jsonName: "venue".}: Venue ## The venue description
    of mContact:
      ## A message with a user contact
      messagecontaContact* {.jsonName: "contact".}: Contact ## The contact description
    of mDice:
      ## A dice message. The dice value is randomly generated by the server
      messagediInitialStateSticker* {.jsonName: "initial_state_sticker".}: Option[Sticker] ## The animated sticker with the initial dice animation; may be null if unknown. updateMessageContent will be sent when the sticker became known
      messagediFinalStateSticker* {.jsonName: "final_state_sticker".}: Option[Sticker] ## The animated sticker with the final dice animation; may be null if unknown. updateMessageContent will be sent when the sticker became known
      messagediEmoji* {.jsonName: "emoji".}: string ## Emoji on which the dice throw animation is based
      messagediValue* {.jsonName: "value".}: int32 ## The dice value. If the value is 0, the dice don't have final state yet
      messagediSuccessAnimationFrameNumber* {.jsonName: "success_animation_frame_number".}: int32 ## Number of frame after which a success animation like a shower of confetti needs to be shown on updateMessageSendSucceeded
    of mGame:
      ## A message with a game
      messagegaGame* {.jsonName: "game".}: Game ## The game description
    of mPoll:
      ## A message with a poll
      messagepoPoll* {.jsonName: "poll".}: Poll ## The poll description
    of mInvoice:
      ## A message with an invoice from a bot
      messageinvoiTitle* {.jsonName: "title".}: string ## Product title
      messageinvoiDescription* {.jsonName: "description".}: string ## A message with an invoice from a bot
      messageinvoiPhoto* {.jsonName: "photo".}: Option[Photo] ## Product photo; may be null
      messageinvoiCurrency* {.jsonName: "currency".}: string ## Currency for the product price
      messageinvoiTotalAmount* {.jsonName: "total_amount".}: int64 ## Product total price in the minimal quantity of the currency
      messageinvoiStartParameter* {.jsonName: "start_parameter".}: string ## Unique invoice bot start_parameter. To share an invoice use the URL https://t.me/{bot_username}?start={start_parameter}
      messageinvoiIsTest* {.jsonName: "is_test".}: bool ## True, if the invoice is a test invoice
      messageinvoiNeedShippingAddress* {.jsonName: "need_shipping_address".}: bool ## True, if the shipping address should be specified
      messageinvoiReceiptMessageId* {.jsonName: "receipt_message_id".}: int64 ## The identifier of the message with the receipt, after the product has been purchased
    of mCall:
      ## A message with information about an ended call
      messagecaDiscardReason* {.jsonName: "discard_reason".}: CallDiscardReason ## Reason why the call was discarded
      messagecaDuration* {.jsonName: "duration".}: int32 ## Call duration, in seconds
    of mBasicGroupChatCreate:
      ## A newly created basic group
      bgccTitle* {.jsonName: "title".}: string ## Title of the basic group
      bgccMemberUserIds* {.jsonName: "member_user_ids".}: seq[int32] ## User identifiers of members in the basic group
    of mSupergroupChatCreate:
      ## A newly created supergroup or channel
      sccTitle* {.jsonName: "title".}: string ## Title of the supergroup or channel
    of mChatChangeTitle:
      ## An updated chat title
      cctTitle* {.jsonName: "title".}: string ## New chat title
    of mChatChangePhoto:
      ## An updated chat photo
      ccpPhoto* {.jsonName: "photo".}: Photo ## New chat photo
    of mChatDeletePhoto:
      ## A deleted chat photo
      discard
    of mChatAddMembers:
      ## New chat members were added
      camMemberUserIds* {.jsonName: "member_user_ids".}: seq[int32] ## User identifiers of the new members
    of mChatJoinByLink:
      ## A new member joined the chat by invite link
      discard
    of mChatDeleteMember:
      ## A chat member was deleted
      cdmUserId* {.jsonName: "user_id".}: int32 ## User identifier of the deleted chat member
    of mChatUpgradeTo:
      ## A basic group was upgraded to a supergroup and was deactivated as the result
      cutSupergroupId* {.jsonName: "supergroup_id".}: int32 ## Identifier of the supergroup to which the basic group was upgraded
    of mChatUpgradeFrom:
      ## A supergroup has been created from a basic group
      cufTitle* {.jsonName: "title".}: string ## Title of the newly created supergroup
      cufBasicGroupId* {.jsonName: "basic_group_id".}: int32 ## The identifier of the original basic group
    of mPinMessage:
      ## A message has been pinned
      pmMessageId* {.jsonName: "message_id".}: int64 ## Identifier of the pinned message, can be an identifier of a deleted message or 0
    of mScreenshotTaken:
      ## A screenshot of a message in the chat has been taken
      discard
    of mChatSetTtl:
      ## The TTL (Time To Live) setting messages in a secret chat has been changed
      cstTtl* {.jsonName: "ttl".}: int32 ## New TTL
    of mCustomServiceAction:
      ## A non-standard action has happened in the chat
      csaText* {.jsonName: "text".}: string ## Message text to be shown in the chat
    of mGameScore:
      ## A new high score was achieved in a game
      gsGameMessageId* {.jsonName: "game_message_id".}: int64 ## Identifier of the message with the game, can be an identifier of a deleted message
      gsGameId* {.jsonName: "game_id".}: string ## Identifier of the game; may be different from the games presented in the message with the game
      gsScore* {.jsonName: "score".}: int32 ## New score
    of mPaymentSuccessful:
      ## A payment has been completed
      psInvoiceMessageId* {.jsonName: "invoice_message_id".}: int64 ## Identifier of the message with the corresponding invoice; can be an identifier of a deleted message
      psCurrency* {.jsonName: "currency".}: string ## Currency for the price of the product
      psTotalAmount* {.jsonName: "total_amount".}: int64 ## Total price for the product, in the minimal quantity of the currency
    of mPaymentSuccessfulBot:
      ## A payment has been completed; for bots only
      psbInvoiceMessageId* {.jsonName: "invoice_message_id".}: int64 ## Identifier of the message with the corresponding invoice; can be an identifier of a deleted message
      psbCurrency* {.jsonName: "currency".}: string ## Currency for price of the product
      psbTotalAmount* {.jsonName: "total_amount".}: int64 ## Total price for the product, in the minimal quantity of the currency
      psbInvoicePayload* {.jsonName: "invoice_payload".}: string ## Invoice payload
      psbShippingOptionId* {.jsonName: "shipping_option_id".}: string ## Identifier of the shipping option chosen by the user; may be empty if not applicable
      psbOrderInfo* {.jsonName: "order_info".}: Option[OrderInfo] ## Information about the order; may be null
      psbTelegramPaymentChargeId* {.jsonName: "telegram_payment_charge_id".}: string ## Telegram payment identifier
      psbProviderPaymentChargeId* {.jsonName: "provider_payment_charge_id".}: string ## Provider payment identifier
    of mContactRegistered:
      ## A contact has registered with Telegram
      discard
    of mWebsiteConnected:
      ## The current user has connected a website by logging in using Telegram Login Widget on it
      wcDomainName* {.jsonName: "domain_name".}: string ## Domain name of the connected website
    of mPassportDataSent:
      ## Telegram Passport data has been sent
      pdsTypes* {.jsonName: "types".}: seq[PassportElementType] ## List of Telegram Passport element types sent
    of mPassportDataReceived:
      ## Telegram Passport data has been received; for bots only
      pdrElements* {.jsonName: "elements".}: seq[EncryptedPassportElement] ## List of received Telegram Passport elements
      pdrCredentials* {.jsonName: "credentials".}: EncryptedCredentials ## Encrypted data credentials
    of mUnsupported:
      ## Message content that is not supported by the client
      discard

  IdentityDocument * = object
    ## An identity document
    kind {.jsonName: "@type".}: string
    number* {.jsonName: "number".}: string ## Document number; 1-24 characters
    expiryDate* {.jsonName: "expiry_date".}: Option[Date] ## Document expiry date; may be null
    frontSide* {.jsonName: "front_side".}: DatedFile ## Front side of the document
    reverseSide* {.jsonName: "reverse_side".}: DatedFile ## Reverse side of the document; only for driver license and identity card
    selfie* {.jsonName: "selfie".}: Option[DatedFile] ## Selfie with the document; may be null
    translation* {.jsonName: "translation".}: seq[DatedFile] ## List of files containing a certified English translation of the document

  DatabaseStatistics * = object
    ## Contains database statistics
    kind {.jsonName: "@type".}: string
    statistics* {.jsonName: "statistics".}: string ## Database statistics in an unspecified human-readable format

  ChatInviteLink * = object
    ## Contains a chat invite link
    kind {.jsonName: "@type".}: string
    inviteLink* {.jsonName: "invite_link".}: string ## Chat invite link

  PassportElementErrorSourceKind * {.pure.} = enum
    peesFiles = "passportElementErrorSourceFiles",
    peesSelfie = "passportElementErrorSourceSelfie",
    peesTranslationFile = "passportElementErrorSourceTranslationFile",
    peesReverseSide = "passportElementErrorSourceReverseSide",
    peesDataField = "passportElementErrorSourceDataField",
    peesTranslationFiles = "passportElementErrorSourceTranslationFiles",
    peesFile = "passportElementErrorSourceFile",
    peesUnspecified = "passportElementErrorSourceUnspecified",
    peesFrontSide = "passportElementErrorSourceFrontSide",

  PassportElementErrorSource * = object
    ## Contains the description of an error in a Telegram Passport element
    case kind* {.jsonName: "@type".}: PassportElementErrorSourceKind
    of peesUnspecified:
      ## The element contains an error in an unspecified place. The error will be considered resolved when new data is added
      discard
    of peesDataField:
      ## One of the data fields contains an error. The error will be considered resolved when the value of the field changes
      dfFieldName* {.jsonName: "field_name".}: string ## Field name
    of peesFrontSide:
      ## The front side of the document contains an error. The error will be considered resolved when the file with the front side changes
      discard
    of peesReverseSide:
      ## The reverse side of the document contains an error. The error will be considered resolved when the file with the reverse side changes
      discard
    of peesSelfie:
      ## The selfie with the document contains an error. The error will be considered resolved when the file with the selfie changes
      discard
    of peesTranslationFile:
      ## One of files with the translation of the document contains an error. The error will be considered resolved when the file changes
      tfFileIndex* {.jsonName: "file_index".}: int32 ## Index of a file with the error
    of peesTranslationFiles:
      ## The translation of the document contains an error. The error will be considered resolved when the list of translation files changes
      discard
    of peesFile:
      ## The file contains an error. The error will be considered resolved when the file changes
      passportelementerrorsourcefiFileIndex* {.jsonName: "file_index".}: int32 ## Index of a file with the error
    of peesFiles:
      ## The list of attached files contains an error. The error will be considered resolved when the list of files changes
      discard

  NetworkTypeKind * {.pure.} = enum
    ntMobile = "networkTypeMobile",
    ntNone = "networkTypeNone",
    ntOther = "networkTypeOther",
    ntMobileRoaming = "networkTypeMobileRoaming",
    ntWiFi = "networkTypeWiFi",

  NetworkType * = object
    ## Represents the type of a network
    case kind* {.jsonName: "@type".}: NetworkTypeKind
    of ntNone:
      ## The network is not available
      discard
    of ntMobile:
      ## A mobile network
      discard
    of ntMobileRoaming:
      ## A mobile roaming network
      discard
    of ntWiFi:
      ## A Wi-Fi network
      discard
    of ntOther:
      ## A different network type (e.g., Ethernet network)
      discard

  Venue * = object
    ## Describes a venue
    kind {.jsonName: "@type".}: string
    location* {.jsonName: "location".}: Location ## Venue location; as defined by the sender
    title* {.jsonName: "title".}: string ## Venue name; as defined by the sender
    address* {.jsonName: "address".}: string ## Venue address; as defined by the sender
    provider* {.jsonName: "provider".}: string ## Provider of the venue database; as defined by the sender. Currently only "foursquare" needs to be supported
    id* {.jsonName: "id".}: string ## Identifier of the venue in the provider database; as defined by the sender
    typ* {.jsonName: "type".}: string ## Type of the venue in the provider database; as defined by the sender

  ChatStatisticsMessageInteractionCounters * = object
    ## Contains statistics about interactions with a message
    kind {.jsonName: "@type".}: string
    messageId* {.jsonName: "message_id".}: int64 ## Message identifier
    viewCount* {.jsonName: "view_count".}: int32 ## Number of times the message was viewed
    forwardCount* {.jsonName: "forward_count".}: int32 ## Number of times the message was forwarded

  BackgroundTypeKind * {.pure.} = enum
    btFill = "backgroundTypeFill",
    btWallpaper = "backgroundTypeWallpaper",
    btPattern = "backgroundTypePattern",

  BackgroundType * = object
    ## Describes the type of a background
    case kind* {.jsonName: "@type".}: BackgroundTypeKind
    of btWallpaper:
      ## A wallpaper in JPEG format
      backgroundtypewallpapIsBlurred* {.jsonName: "is_blurred".}: bool ## True, if the wallpaper must be downscaled to fit in 450x450 square and then box-blurred with radius 12
      backgroundtypewallpapIsMoving* {.jsonName: "is_moving".}: bool ## True, if the background needs to be slightly moved when device is tilted
    of btPattern:
      ## A PNG or TGV (gzipped subset of SVG with MIME type "application/x-tgwallpattern") pattern to be combined with the background fill chosen by the user
      backgroundtypepatteFill* {.jsonName: "fill".}: BackgroundFill ## Description of the background fill
      backgroundtypepatteIntensity* {.jsonName: "intensity".}: int32 ## Intensity of the pattern when it is shown above the filled background, 0-100
      backgroundtypepatteIsMoving* {.jsonName: "is_moving".}: bool ## True, if the background needs to be slightly moved when device is tilted
    of btFill:
      ## A filled background
      backgroundtypefiFill* {.jsonName: "fill".}: BackgroundFill ## Description of the background fill

  PageBlockRelatedArticle * = object
    ## Contains information about a related article
    kind {.jsonName: "@type".}: string
    url* {.jsonName: "url".}: string ## Related article URL
    title* {.jsonName: "title".}: string ## Article title; may be empty
    description* {.jsonName: "description".}: string ## Contains information about a related article
    photo* {.jsonName: "photo".}: Option[Photo] ## Article photo; may be null
    author* {.jsonName: "author".}: string ## Article author; may be empty
    publishDate* {.jsonName: "publish_date".}: int32 ## Point in time (Unix timestamp) when the article was published; 0 if unknown

  CanTransferOwnershipResultKind * {.pure.} = enum
    ctorPasswordNeeded = "canTransferOwnershipResultPasswordNeeded",
    ctorPasswordTooFresh = "canTransferOwnershipResultPasswordTooFresh",
    ctorSessionTooFresh = "canTransferOwnershipResultSessionTooFresh",
    ctorOk = "canTransferOwnershipResultOk",

  CanTransferOwnershipResult * = object
    ## Represents result of checking whether the current session can be used to transfer a chat ownership to another user
    case kind* {.jsonName: "@type".}: CanTransferOwnershipResultKind
    of ctorOk:
      ## The session can be used
      discard
    of ctorPasswordNeeded:
      ## The 2-step verification needs to be enabled first
      discard
    of ctorPasswordTooFresh:
      ## The 2-step verification was enabled recently, user needs to wait
      ptfRetryAfter* {.jsonName: "retry_after".}: int32 ## Time left before the session can be used to transfer ownership of a chat, in seconds
    of ctorSessionTooFresh:
      ## The session was created recently, user needs to wait
      stfRetryAfter* {.jsonName: "retry_after".}: int32 ## Time left before the session can be used to transfer ownership of a chat, in seconds

  InputBackgroundKind * {.pure.} = enum
    ibLocal = "inputBackgroundLocal",
    ibRemote = "inputBackgroundRemote",

  InputBackground * = object
    ## Contains information about background to set
    case kind* {.jsonName: "@type".}: InputBackgroundKind
    of ibLocal:
      ## A background from a local file
      inputbackgroundlocBackground* {.jsonName: "background".}: InputFile ## Background file to use. Only inputFileLocal and inputFileGenerated are supported. The file must be in JPEG format for wallpapers and in PNG format for patterns
    of ibRemote:
      ## A background from the server
      inputbackgroundremoBackgroundId* {.jsonName: "background_id".}: string ## The background identifier

  InputPassportElementError * = object
    ## Contains the description of an error in a Telegram Passport element; for bots only
    kind {.jsonName: "@type".}: string
    typ* {.jsonName: "type".}: PassportElementType ## Type of Telegram Passport element that has the error
    message* {.jsonName: "message".}: string ## Error message
    source* {.jsonName: "source".}: InputPassportElementErrorSource ## Error source

  PassportElementError * = object
    ## Contains the description of an error in a Telegram Passport element
    kind {.jsonName: "@type".}: string
    typ* {.jsonName: "type".}: PassportElementType ## Type of the Telegram Passport element which has the error
    message* {.jsonName: "message".}: string ## Error message
    source* {.jsonName: "source".}: PassportElementErrorSource ## Error source

  SearchMessagesFilterKind * {.pure.} = enum
    smfMention = "searchMessagesFilterMention",
    smfDocument = "searchMessagesFilterDocument",
    smfAudio = "searchMessagesFilterAudio",
    smfChatPhoto = "searchMessagesFilterChatPhoto",
    smfFailedToSend = "searchMessagesFilterFailedToSend",
    smfUnreadMention = "searchMessagesFilterUnreadMention",
    smfVoiceAndVideoNote = "searchMessagesFilterVoiceAndVideoNote",
    smfPhotoAndVideo = "searchMessagesFilterPhotoAndVideo",
    smfEmpty = "searchMessagesFilterEmpty",
    smfCall = "searchMessagesFilterCall",
    smfVideo = "searchMessagesFilterVideo",
    smfUrl = "searchMessagesFilterUrl",
    smfPhoto = "searchMessagesFilterPhoto",
    smfVoiceNote = "searchMessagesFilterVoiceNote",
    smfVideoNote = "searchMessagesFilterVideoNote",
    smfMissedCall = "searchMessagesFilterMissedCall",
    smfAnimation = "searchMessagesFilterAnimation",

  SearchMessagesFilter * = object
    ## Represents a filter for message search results
    case kind* {.jsonName: "@type".}: SearchMessagesFilterKind
    of smfEmpty:
      ## Returns all found messages, no filter is applied
      discard
    of smfAnimation:
      ## Returns only animation messages
      discard
    of smfAudio:
      ## Returns only audio messages
      discard
    of smfDocument:
      ## Returns only document messages
      discard
    of smfPhoto:
      ## Returns only photo messages
      discard
    of smfVideo:
      ## Returns only video messages
      discard
    of smfVoiceNote:
      ## Returns only voice note messages
      discard
    of smfPhotoAndVideo:
      ## Returns only photo and video messages
      discard
    of smfUrl:
      ## Returns only messages containing URLs
      discard
    of smfChatPhoto:
      ## Returns only messages containing chat photos
      discard
    of smfCall:
      ## Returns only call messages
      discard
    of smfMissedCall:
      ## Returns only incoming call messages with missed/declined discard reasons
      discard
    of smfVideoNote:
      ## Returns only video note messages
      discard
    of smfVoiceAndVideoNote:
      ## Returns only voice and video note messages
      discard
    of smfMention:
      ## Returns only messages with mentions of the current user, or messages that are replies to their messages
      discard
    of smfUnreadMention:
      ## Returns only messages with unread mentions of the current user, or messages that are replies to their messages. When using this filter the results can't be additionally filtered by a query or by the sending user
      discard
    of smfFailedToSend:
      ## Returns only failed to send messages. This filter can be used only if the message database is used
      discard

  BotInfo * = object
    ## Provides information about a bot and its supported commands
    kind {.jsonName: "@type".}: string
    description* {.jsonName: "description".}: string ## Provides information about a bot and its supported commands
    commands* {.jsonName: "commands".}: seq[BotCommand] ## A list of commands supported by the bot

  TestVectorString * = object
    ## A simple object containing a vector of strings; for testing only
    kind {.jsonName: "@type".}: string
    value* {.jsonName: "value".}: seq[string] ## Vector of strings

  Backgrounds * = object
    ## Contains a list of backgrounds
    kind {.jsonName: "@type".}: string
    backgrounds* {.jsonName: "backgrounds".}: seq[Background] ## A list of backgrounds

  Address * = object
    ## Describes an address
    kind {.jsonName: "@type".}: string
    countryCode* {.jsonName: "country_code".}: string ## A two-letter ISO 3166-1 alpha-2 country code
    state* {.jsonName: "state".}: string ## State, if applicable
    city* {.jsonName: "city".}: string ## City
    streetLine1* {.jsonName: "street_line1".}: string ## First line of the address
    streetLine2* {.jsonName: "street_line2".}: string ## Second line of the address
    postalCode* {.jsonName: "postal_code".}: string ## Address postal code

  ChatEventLogFilters * = object
    ## Represents a set of filters used to obtain a chat event log
    kind {.jsonName: "@type".}: string
    messageEdits* {.jsonName: "message_edits".}: bool ## True, if message edits should be returned
    messageDeletions* {.jsonName: "message_deletions".}: bool ## True, if message deletions should be returned
    messagePins* {.jsonName: "message_pins".}: bool ## True, if pin/unpin events should be returned
    memberJoins* {.jsonName: "member_joins".}: bool ## True, if members joining events should be returned
    memberLeaves* {.jsonName: "member_leaves".}: bool ## True, if members leaving events should be returned
    memberInvites* {.jsonName: "member_invites".}: bool ## True, if invited member events should be returned
    memberPromotions* {.jsonName: "member_promotions".}: bool ## True, if member promotion/demotion events should be returned
    memberRestrictions* {.jsonName: "member_restrictions".}: bool ## True, if member restricted/unrestricted/banned/unbanned events should be returned
    infoChanges* {.jsonName: "info_changes".}: bool ## True, if changes in chat information should be returned
    settingChanges* {.jsonName: "setting_changes".}: bool ## True, if changes in chat settings should be returned

  Notification * = object
    ## Contains information about a notification
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32 ## Unique persistent identifier of this notification
    date* {.jsonName: "date".}: int32 ## Notification date
    isSilent* {.jsonName: "is_silent".}: bool ## True, if the notification was initially silent
    typ* {.jsonName: "type".}: NotificationType ## Notification type

  TMeUrls * = object
    ## Contains a list of t.me URLs
    kind {.jsonName: "@type".}: string
    urls* {.jsonName: "urls".}: seq[TMeUrl] ## List of URLs

  LocalizationTargetInfo * = object
    ## Contains information about the current localization target
    kind {.jsonName: "@type".}: string
    languagePacks* {.jsonName: "language_packs".}: seq[LanguagePackInfo] ## List of available language packs for this application

  NotificationSettingsScopeKind * {.pure.} = enum
    nssGroupChats = "notificationSettingsScopeGroupChats",
    nssChannelChats = "notificationSettingsScopeChannelChats",
    nssPrivateChats = "notificationSettingsScopePrivateChats",

  NotificationSettingsScope * = object
    ## Describes the types of chats to which notification settings are applied
    case kind* {.jsonName: "@type".}: NotificationSettingsScopeKind
    of nssPrivateChats:
      ## Notification settings applied to all private and secret chats when the corresponding chat setting has a default value
      discard
    of nssGroupChats:
      ## Notification settings applied to all basic groups and supergroups when the corresponding chat setting has a default value
      discard
    of nssChannelChats:
      ## Notification settings applied to all channels when the corresponding chat setting has a default value
      discard

  UserFullInfo * = object
    ## Contains full information about a user (except the full list of profile photos)
    kind {.jsonName: "@type".}: string
    isBlocked* {.jsonName: "is_blocked".}: bool ## True, if the user is blacklisted by the current user
    canBeCalled* {.jsonName: "can_be_called".}: bool ## True, if the user can be called
    hasPrivateCalls* {.jsonName: "has_private_calls".}: bool ## True, if the user can't be called due to their privacy settings
    needPhoneNumberPrivacyException* {.jsonName: "need_phone_number_privacy_exception".}: bool ## True, if the current user needs to explicitly allow to share their phone number with the user when the method addContact is used
    bio* {.jsonName: "bio".}: string ## A short user bio
    shareText* {.jsonName: "share_text".}: string ## For bots, the text that is included with the link when users share the bot
    groupInCommonCount* {.jsonName: "group_in_common_count".}: int32 ## Number of group chats where both the other user and the current user are a member; 0 for the current user
    botInfo* {.jsonName: "bot_info".}: Option[BotInfo] ## If the user is a bot, information about the bot; may be null

  StorageStatisticsFast * = object
    ## Contains approximate storage usage statistics, excluding files of unknown file type
    kind {.jsonName: "@type".}: string
    filesSize* {.jsonName: "files_size".}: int64 ## Approximate total size of files
    fileCount* {.jsonName: "file_count".}: int32 ## Approximate number of files
    databaseSize* {.jsonName: "database_size".}: int64 ## Size of the database
    languagePackDatabaseSize* {.jsonName: "language_pack_database_size".}: int64 ## Size of the language pack database
    logSize* {.jsonName: "log_size".}: int64 ## Size of the TDLib internal log

  Proxies * = object
    ## Represents a list of proxy servers
    kind {.jsonName: "@type".}: string
    proxies* {.jsonName: "proxies".}: seq[Proxy] ## List of proxy servers

  ChatAdministrators * = object
    ## Represents a list of chat administrators
    kind {.jsonName: "@type".}: string
    administrators* {.jsonName: "administrators".}: seq[ChatAdministrator] ## A list of chat administrators

  TestInt * = object
    ## A simple object containing a number; for testing only
    kind {.jsonName: "@type".}: string
    value* {.jsonName: "value".}: int32 ## Number

  AutoDownloadSettingsPresets * = object
    ## Contains auto-download settings presets for the user
    kind {.jsonName: "@type".}: string
    low* {.jsonName: "low".}: AutoDownloadSettings ## Preset with lowest settings; supposed to be used by default when roaming
    medium* {.jsonName: "medium".}: AutoDownloadSettings ## Preset with medium settings; supposed to be used by default when using mobile data
    high* {.jsonName: "high".}: AutoDownloadSettings ## Preset with highest settings; supposed to be used by default when connected on Wi-Fi

  ReplyMarkupKind * {.pure.} = enum
    rmShowKeyboard = "replyMarkupShowKeyboard",
    rmRemoveKeyboard = "replyMarkupRemoveKeyboard",
    rmInlineKeyboard = "replyMarkupInlineKeyboard",
    rmForceReply = "replyMarkupForceReply",

  ReplyMarkup * = object
    ## Contains a description of a custom keyboard and actions that can be done with it to quickly reply to bots
    case kind* {.jsonName: "@type".}: ReplyMarkupKind
    of rmRemoveKeyboard:
      ## Instructs clients to remove the keyboard once this message has been received. This kind of keyboard can't be received in an incoming message; instead, UpdateChatReplyMarkup with message_id == 0 will be sent
      rkIsPersonal* {.jsonName: "is_personal".}: bool ## True, if the keyboard is removed only for the mentioned users or the target user of a reply
    of rmForceReply:
      ## Instructs clients to force a reply to this message
      frIsPersonal* {.jsonName: "is_personal".}: bool ## True, if a forced reply must automatically be shown to the current user. For outgoing messages, specify true to show the forced reply only for the mentioned users and for the target user of a reply
    of rmShowKeyboard:
      ## Contains a custom keyboard layout to quickly reply to bots
      skRows* {.jsonName: "rows".}: seq[seq[KeyboardButton]] ## A list of rows of bot keyboard buttons
      skResizeKeyboard* {.jsonName: "resize_keyboard".}: bool ## True, if the client needs to resize the keyboard vertically
      skOneTime* {.jsonName: "one_time".}: bool ## True, if the client needs to hide the keyboard after use
      skIsPersonal* {.jsonName: "is_personal".}: bool ## True, if the keyboard must automatically be shown to the current user. For outgoing messages, specify true to show the keyboard only for the mentioned users and for the target user of a reply
    of rmInlineKeyboard:
      ## Contains an inline keyboard layout
      ikRows* {.jsonName: "rows".}: seq[seq[InlineKeyboardButton]] ## A list of rows of inline keyboard buttons

  ChatMembers * = object
    ## Contains a list of chat members
    kind {.jsonName: "@type".}: string
    totalCount* {.jsonName: "total_count".}: int32 ## Approximate total count of chat members found
    members* {.jsonName: "members".}: seq[ChatMember] ## A list of chat members

  PageBlockListItem * = object
    ## Describes an item of a list page block
    kind {.jsonName: "@type".}: string
    label* {.jsonName: "label".}: string ## Item label
    pageBlocks* {.jsonName: "page_blocks".}: seq[PageBlock] ## Item blocks

  PhoneNumberAuthenticationSettings * = object
    ## Contains settings for the authentication of the user's phone number
    kind {.jsonName: "@type".}: string
    allowFlashCall* {.jsonName: "allow_flash_call".}: bool ## Pass true if the authentication code may be sent via flash call to the specified phone number
    isCurrentPhoneNumber* {.jsonName: "is_current_phone_number".}: bool ## Pass true if the authenticated phone number is used on the current device
    allowSmsRetrieverApi* {.jsonName: "allow_sms_retriever_api".}: bool ## For official applications only. True, if the app can use Android SMS Retriever API (requires Google Play Services >= 10.2) to automatically receive the authentication code from the SMS. See https://developers.google.com/identity/sms-retriever/ for more details

  WebPage * = object
    ## Describes a web page preview
    kind {.jsonName: "@type".}: string
    url* {.jsonName: "url".}: string ## Original URL of the link
    displayUrl* {.jsonName: "display_url".}: string ## URL to display
    typ* {.jsonName: "type".}: string ## Type of the web page. Can be: article, photo, audio, video, document, profile, app, or something else
    siteName* {.jsonName: "site_name".}: string ## Short name of the site (e.g., Google Docs, App Store)
    title* {.jsonName: "title".}: string ## Title of the content
    description* {.jsonName: "description".}: FormattedText ## Describes a web page preview
    photo* {.jsonName: "photo".}: Option[Photo] ## Image representing the content; may be null
    embedUrl* {.jsonName: "embed_url".}: string ## URL to show in the embedded preview
    embedType* {.jsonName: "embed_type".}: string ## MIME type of the embedded preview, (e.g., text/html or video/mp4)
    embedWidth* {.jsonName: "embed_width".}: int32 ## Width of the embedded preview
    embedHeight* {.jsonName: "embed_height".}: int32 ## Height of the embedded preview
    duration* {.jsonName: "duration".}: int32 ## Duration of the content, in seconds
    author* {.jsonName: "author".}: string ## Author of the content
    animation* {.jsonName: "animation".}: Option[Animation] ## Preview of the content as an animation, if available; may be null
    audio* {.jsonName: "audio".}: Option[Audio] ## Preview of the content as an audio file, if available; may be null
    document* {.jsonName: "document".}: Option[Document] ## Preview of the content as a document, if available (currently only available for small PDF files and ZIP archives); may be null
    sticker* {.jsonName: "sticker".}: Option[Sticker] ## Preview of the content as a sticker for small WEBP files, if available; may be null
    video* {.jsonName: "video".}: Option[Video] ## Preview of the content as a video, if available; may be null
    videoNote* {.jsonName: "video_note".}: Option[VideoNote] ## Preview of the content as a video note, if available; may be null
    voiceNote* {.jsonName: "voice_note".}: Option[VoiceNote] ## Preview of the content as a voice note, if available; may be null
    instantViewVersion* {.jsonName: "instant_view_version".}: int32 ## Version of instant view, available for the web page (currently can be 1 or 2), 0 if none

  User * = object
    ## Represents a user
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32 ## User identifier
    firstName* {.jsonName: "first_name".}: string ## First name of the user
    lastName* {.jsonName: "last_name".}: string ## Last name of the user
    username* {.jsonName: "username".}: string ## Username of the user
    phoneNumber* {.jsonName: "phone_number".}: string ## Phone number of the user
    status* {.jsonName: "status".}: UserStatus ## Current online status of the user
    profilePhoto* {.jsonName: "profile_photo".}: Option[ProfilePhoto] ## Profile photo of the user; may be null
    isContact* {.jsonName: "is_contact".}: bool ## The user is a contact of the current user
    isMutualContact* {.jsonName: "is_mutual_contact".}: bool ## The user is a contact of the current user and the current user is a contact of the user
    isVerified* {.jsonName: "is_verified".}: bool ## True, if the user is verified
    isSupport* {.jsonName: "is_support".}: bool ## True, if the user is Telegram support account
    restrictionReason* {.jsonName: "restriction_reason".}: string ## If non-empty, it contains a human-readable description of the reason why access to this user must be restricted
    isScam* {.jsonName: "is_scam".}: bool ## True, if many users reported this user as a scam
    haveAccess* {.jsonName: "have_access".}: bool ## If false, the user is inaccessible, and the only information known about the user is inside this class. It can't be passed to any method except GetUser
    typ* {.jsonName: "type".}: UserType ## Type of the user
    languageCode* {.jsonName: "language_code".}: string ## IETF language tag of the user's language; only available to bots

  LogVerbosityLevel * = object
    ## Contains a TDLib internal log verbosity level
    kind {.jsonName: "@type".}: string
    verbosityLevel* {.jsonName: "verbosity_level".}: int32 ## Log verbosity level

  TestBytes * = object
    ## A simple object containing a sequence of bytes; for testing only
    kind {.jsonName: "@type".}: string
    value* {.jsonName: "value".}: string ## Bytes

  UpdateKind * {.pure.} = enum
    uNewMessage = "updateNewMessage",
    uMessageEdited = "updateMessageEdited",
    uChatOnlineMemberCount = "updateChatOnlineMemberCount",
    uSavedAnimations = "updateSavedAnimations",
    uChatChatList = "updateChatChatList",
    uMessageSendAcknowledged = "updateMessageSendAcknowledged",
    uChatUnreadMentionCount = "updateChatUnreadMentionCount",
    uChatNotificationSettings = "updateChatNotificationSettings",
    uAuthorizationState = "updateAuthorizationState",
    uSupergroupFullInfo = "updateSupergroupFullInfo",
    uChatSource = "updateChatSource",
    uBasicGroupFullInfo = "updateBasicGroupFullInfo",
    uMessageMentionRead = "updateMessageMentionRead",
    uCall = "updateCall",
    uDiceEmojis = "updateDiceEmojis",
    uNewShippingQuery = "updateNewShippingQuery",
    uFileGenerationStop = "updateFileGenerationStop",
    uMessageSendFailed = "updateMessageSendFailed",
    uChatTitle = "updateChatTitle",
    uNotification = "updateNotification",
    uMessageLiveLocationViewed = "updateMessageLiveLocationViewed",
    uChatLastMessage = "updateChatLastMessage",
    uNotificationGroup = "updateNotificationGroup",
    uChatReadOutbox = "updateChatReadOutbox",
    uChatHasScheduledMessages = "updateChatHasScheduledMessages",
    uUserStatus = "updateUserStatus",
    uUserPrivacySettingRules = "updateUserPrivacySettingRules",
    uNewCustomEvent = "updateNewCustomEvent",
    uStickerSet = "updateStickerSet",
    uNewChosenInlineResult = "updateNewChosenInlineResult",
    uMessageContentOpened = "updateMessageContentOpened",
    uNewCallbackQuery = "updateNewCallbackQuery",
    uTrendingStickerSets = "updateTrendingStickerSets",
    uUser = "updateUser",
    uSelectedBackground = "updateSelectedBackground",
    uChatReplyMarkup = "updateChatReplyMarkup",
    uNewInlineQuery = "updateNewInlineQuery",
    uUnreadChatCount = "updateUnreadChatCount",
    uChatPhoto = "updateChatPhoto",
    uChatReadInbox = "updateChatReadInbox",
    uScopeNotificationSettings = "updateScopeNotificationSettings",
    uMessageViews = "updateMessageViews",
    uUnreadMessageCount = "updateUnreadMessageCount",
    uFavoriteStickers = "updateFavoriteStickers",
    uNewInlineCallbackQuery = "updateNewInlineCallbackQuery",
    uPoll = "updatePoll",
    uHavePendingNotifications = "updateHavePendingNotifications",
    uPollAnswer = "updatePollAnswer",
    uMessageSendSucceeded = "updateMessageSendSucceeded",
    uChatPermissions = "updateChatPermissions",
    uChatPinnedMessage = "updateChatPinnedMessage",
    uServiceNotification = "updateServiceNotification",
    uInstalledStickerSets = "updateInstalledStickerSets",
    uSupergroup = "updateSupergroup",
    uNewPreCheckoutQuery = "updateNewPreCheckoutQuery",
    uUserChatAction = "updateUserChatAction",
    uChatOrder = "updateChatOrder",
    uChatActionBar = "updateChatActionBar",
    uBasicGroup = "updateBasicGroup",
    uNewChat = "updateNewChat",
    uChatIsPinned = "updateChatIsPinned",
    uDeleteMessages = "updateDeleteMessages",
    uRecentStickers = "updateRecentStickers",
    uTermsOfService = "updateTermsOfService",
    uChatDraftMessage = "updateChatDraftMessage",
    uChatDefaultDisableNotification = "updateChatDefaultDisableNotification",
    uSecretChat = "updateSecretChat",
    uMessageContent = "updateMessageContent",
    uUserFullInfo = "updateUserFullInfo",
    uActiveNotifications = "updateActiveNotifications",
    uLanguagePackStrings = "updateLanguagePackStrings",
    uFileGenerationStart = "updateFileGenerationStart",
    uConnectionState = "updateConnectionState",
    uChatIsMarkedAsUnread = "updateChatIsMarkedAsUnread",
    uFile = "updateFile",
    uNewCustomQuery = "updateNewCustomQuery",
    uOption = "updateOption",
    uUsersNearby = "updateUsersNearby",

  Update * = object
    ## Contains notifications about data changes
    case kind* {.jsonName: "@type".}: UpdateKind
    of uAuthorizationState:
      ## The user authorization state has changed
      asAuthorizationState* {.jsonName: "authorization_state".}: AuthorizationState ## New authorization state
    of uNewMessage:
      ## A new message was received; can also be an outgoing message
      nmMessage* {.jsonName: "message".}: Message ## The new message
    of uMessageSendAcknowledged:
      ## A request to send a message has reached the Telegram server. This doesn't mean that the message will be sent successfully or even that the send message request will be processed. This update will be sent only if the option "use_quick_ack" is set to true. This update may be sent multiple times for the same message
      msaChatId* {.jsonName: "chat_id".}: int64 ## The chat identifier of the sent message
      msaMessageId* {.jsonName: "message_id".}: int64 ## A temporary message identifier
    of uMessageSendSucceeded:
      ## A message has been successfully sent
      mssMessage* {.jsonName: "message".}: Message ## Information about the sent message. Usually only the message identifier, date, and content are changed, but almost all other fields can also change
      mssOldMessageId* {.jsonName: "old_message_id".}: int64 ## The previous temporary message identifier
    of uMessageSendFailed:
      ## A message failed to send. Be aware that some messages being sent can be irrecoverably deleted, in which case updateDeleteMessages will be received instead of this update
      msfMessage* {.jsonName: "message".}: Message ## Contains information about the message which failed to send
      msfOldMessageId* {.jsonName: "old_message_id".}: int64 ## The previous temporary message identifier
      msfErrorCode* {.jsonName: "error_code".}: int32 ## An error code
      msfErrorMessage* {.jsonName: "error_message".}: string ## Error message
    of uMessageContent:
      ## The message content has changed
      mcChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      mcMessageId* {.jsonName: "message_id".}: int64 ## Message identifier
      mcNewContent* {.jsonName: "new_content".}: MessageContent ## New message content
    of uMessageEdited:
      ## A message was edited. Changes in the message content will come in a separate updateMessageContent
      meChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      meMessageId* {.jsonName: "message_id".}: int64 ## Message identifier
      meEditDate* {.jsonName: "edit_date".}: int32 ## Point in time (Unix timestamp) when the message was edited
      meReplyMarkup* {.jsonName: "reply_markup".}: Option[ReplyMarkup] ## New message reply markup; may be null
    of uMessageViews:
      ## The view count of the message has changed
      mvChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      mvMessageId* {.jsonName: "message_id".}: int64 ## Message identifier
      mvViews* {.jsonName: "views".}: int32 ## New value of the view count
    of uMessageContentOpened:
      ## The message content was opened. Updates voice note messages to "listened", video note messages to "viewed" and starts the TTL timer for self-destructing messages
      mcoChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      mcoMessageId* {.jsonName: "message_id".}: int64 ## Message identifier
    of uMessageMentionRead:
      ## A message with an unread mention was read
      mmrChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      mmrMessageId* {.jsonName: "message_id".}: int64 ## Message identifier
      mmrUnreadMentionCount* {.jsonName: "unread_mention_count".}: int32 ## The new number of unread mention messages left in the chat
    of uMessageLiveLocationViewed:
      ## A message with a live location was viewed. When the update is received, the client is supposed to update the live location
      mllvChatId* {.jsonName: "chat_id".}: int64 ## Identifier of the chat with the live location message
      mllvMessageId* {.jsonName: "message_id".}: int64 ## Identifier of the message with live location
    of uNewChat:
      ## A new chat has been loaded/created. This update is guaranteed to come before the chat identifier is returned to the client. The chat field changes will be reported through separate updates
      ncChat* {.jsonName: "chat".}: Chat ## The chat
    of uChatChatList:
      ## The list to which the chat belongs was changed. This update is guaranteed to be sent only when chat.order == 0 and the current or the new chat list is null
      cclChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      cclChatList* {.jsonName: "chat_list".}: Option[ChatList] ## The new chat's chat list; may be null
    of uChatTitle:
      ## The title of a chat was changed
      ctChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      ctTitle* {.jsonName: "title".}: string ## The new chat title
    of uChatPhoto:
      ## A chat photo was changed
      cpChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      cpPhoto* {.jsonName: "photo".}: Option[ChatPhoto] ## The new chat photo; may be null
    of uChatPermissions:
      ## Chat permissions was changed
      cpermsChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      cpPermissions* {.jsonName: "permissions".}: ChatPermissions ## The new chat permissions
    of uChatLastMessage:
      ## The last message of a chat was changed. If last_message is null, then the last message in the chat became unknown. Some new unknown messages might be added to the chat in this case
      clmChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      clmLastMessage* {.jsonName: "last_message".}: Option[Message] ## The new last message in the chat; may be null
      clmOrder* {.jsonName: "order".}: string ## New value of the chat order
    of uChatOrder:
      ## The order of the chat in the chat list has changed. Instead of this update updateChatLastMessage, updateChatIsPinned, updateChatDraftMessage, or updateChatSource might be sent
      coChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      coOrder* {.jsonName: "order".}: string ## New value of the order
    of uChatIsPinned:
      ## A chat was pinned or unpinned
      cipChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      cipIsPinned* {.jsonName: "is_pinned".}: bool ## New value of is_pinned
      cipOrder* {.jsonName: "order".}: string ## New value of the chat order
    of uChatIsMarkedAsUnread:
      ## A chat was marked as unread or was read
      cimauChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      cimauIsMarkedAsUnread* {.jsonName: "is_marked_as_unread".}: bool ## New value of is_marked_as_unread
    of uChatSource:
      ## A chat's source in the chat list has changed
      csChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      csSource* {.jsonName: "source".}: Option[ChatSource] ## New chat's source; may be null
      csOrder* {.jsonName: "order".}: string ## New value of chat order
    of uChatHasScheduledMessages:
      ## A chat's has_scheduled_messages field has changed
      chsmChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      chsmHasScheduledMessages* {.jsonName: "has_scheduled_messages".}: bool ## New value of has_scheduled_messages
    of uChatDefaultDisableNotification:
      ## The value of the default disable_notification parameter, used when a message is sent to the chat, was changed
      cddnChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      cddnDefaultDisableNotification* {.jsonName: "default_disable_notification".}: bool ## The new default_disable_notification value
    of uChatReadInbox:
      ## Incoming messages were read or number of unread messages has been changed
      criChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      criLastReadInboxMessageId* {.jsonName: "last_read_inbox_message_id".}: int64 ## Identifier of the last read incoming message
      criUnreadCount* {.jsonName: "unread_count".}: int32 ## The number of unread messages left in the chat
    of uChatReadOutbox:
      ## Outgoing messages were read
      croChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      croLastReadOutboxMessageId* {.jsonName: "last_read_outbox_message_id".}: int64 ## Identifier of last read outgoing message
    of uChatUnreadMentionCount:
      ## The chat unread_mention_count has changed
      cumcChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      cumcUnreadMentionCount* {.jsonName: "unread_mention_count".}: int32 ## The number of unread mention messages left in the chat
    of uChatNotificationSettings:
      ## Notification settings for a chat were changed
      cnsChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      cnsNotificationSettings* {.jsonName: "notification_settings".}: ChatNotificationSettings ## The new notification settings
    of uScopeNotificationSettings:
      ## Notification settings for some type of chats were updated
      snsScope* {.jsonName: "scope".}: NotificationSettingsScope ## Types of chats for which notification settings were updated
      snsNotificationSettings* {.jsonName: "notification_settings".}: ScopeNotificationSettings ## The new notification settings
    of uChatActionBar:
      ## The chat action bar was changed
      cabChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      cabActionBar* {.jsonName: "action_bar".}: Option[ChatActionBar] ## The new value of the action bar; may be null
    of uChatPinnedMessage:
      ## The chat pinned message was changed
      cpmChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      cpmPinnedMessageId* {.jsonName: "pinned_message_id".}: int64 ## The new identifier of the pinned message; 0 if there is no pinned message in the chat
    of uChatReplyMarkup:
      ## The default chat reply markup was changed. Can occur because new messages with reply markup were received or because an old reply markup was hidden by the user
      crmChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      crmReplyMarkupMessageId* {.jsonName: "reply_markup_message_id".}: int64 ## Identifier of the message from which reply markup needs to be used; 0 if there is no default custom reply markup in the chat
    of uChatDraftMessage:
      ## A chat draft has changed. Be aware that the update may come in the currently opened chat but with old content of the draft. If the user has changed the content of the draft, this update shouldn't be applied
      cdmChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      cdmDraftMessage* {.jsonName: "draft_message".}: Option[DraftMessage] ## The new draft message; may be null
      cdmOrder* {.jsonName: "order".}: string ## New value of the chat order
    of uChatOnlineMemberCount:
      ## The number of online group members has changed. This update with non-zero count is sent only for currently opened chats. There is no guarantee that it will be sent just after the count has changed
      comcChatId* {.jsonName: "chat_id".}: int64 ## Identifier of the chat
      comcOnlineMemberCount* {.jsonName: "online_member_count".}: int32 ## New number of online members in the chat, or 0 if unknown
    of uNotification:
      ## A notification was changed
      updatenotificatiNotificationGroupId* {.jsonName: "notification_group_id".}: int32 ## Unique notification group identifier
      updatenotificatiNotification* {.jsonName: "notification".}: Notification ## Changed notification
    of uNotificationGroup:
      ## A list of active notifications in a notification group has changed
      ngNotificationGroupId* {.jsonName: "notification_group_id".}: int32 ## Unique notification group identifier
      ngType* {.jsonName: "type".}: NotificationGroupType ## New type of the notification group
      ngChatId* {.jsonName: "chat_id".}: int64 ## Identifier of a chat to which all notifications in the group belong
      ngNotificationSettingsChatId* {.jsonName: "notification_settings_chat_id".}: int64 ## Chat identifier, which notification settings must be applied to the added notifications
      ngIsSilent* {.jsonName: "is_silent".}: bool ## True, if the notifications should be shown without sound
      ngTotalCount* {.jsonName: "total_count".}: int32 ## Total number of unread notifications in the group, can be bigger than number of active notifications
      ngAddedNotifications* {.jsonName: "added_notifications".}: seq[Notification] ## List of added group notifications, sorted by notification ID
      ngRemovedNotificationIds* {.jsonName: "removed_notification_ids".}: seq[int32] ## Identifiers of removed group notifications, sorted by notification ID
    of uActiveNotifications:
      ## Contains active notifications that was shown on previous application launches. This update is sent only if the message database is used. In that case it comes once before any updateNotification and updateNotificationGroup update
      anGroups* {.jsonName: "groups".}: seq[NotificationGroup] ## Lists of active notification groups
    of uHavePendingNotifications:
      ## Describes whether there are some pending notification updates. Can be used to prevent application from killing, while there are some pending notifications
      hpnHaveDelayedNotifications* {.jsonName: "have_delayed_notifications".}: bool ## True, if there are some delayed notification updates, which will be sent soon
      hpnHaveUnreceivedNotifications* {.jsonName: "have_unreceived_notifications".}: bool ## True, if there can be some yet unreceived notifications, which are being fetched from the server
    of uDeleteMessages:
      ## Some messages were deleted
      dmChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      dmMessageIds* {.jsonName: "message_ids".}: seq[int64] ## Identifiers of the deleted messages
      dmIsPermanent* {.jsonName: "is_permanent".}: bool ## True, if the messages are permanently deleted by a user (as opposed to just becoming inaccessible)
      dmFromCache* {.jsonName: "from_cache".}: bool ## True, if the messages are deleted only from the cache and can possibly be retrieved again in the future
    of uUserChatAction:
      ## User activity in the chat has changed
      ucaChatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
      ucaUserId* {.jsonName: "user_id".}: int32 ## Identifier of a user performing an action
      ucaAction* {.jsonName: "action".}: ChatAction ## The action description
    of uUserStatus:
      ## The user went online or offline
      usUserId* {.jsonName: "user_id".}: int32 ## User identifier
      usStatus* {.jsonName: "status".}: UserStatus ## New status of the user
    of uUser:
      ## Some data of a user has changed. This update is guaranteed to come before the user identifier is returned to the client
      updateusUser* {.jsonName: "user".}: User ## New data about the user
    of uBasicGroup:
      ## Some data of a basic group has changed. This update is guaranteed to come before the basic group identifier is returned to the client
      bgBasicGroup* {.jsonName: "basic_group".}: BasicGroup ## New data about the group
    of uSupergroup:
      ## Some data of a supergroup or a channel has changed. This update is guaranteed to come before the supergroup identifier is returned to the client
      updatesupergroSupergroup* {.jsonName: "supergroup".}: Supergroup ## New data about the supergroup
    of uSecretChat:
      ## Some data of a secret chat has changed. This update is guaranteed to come before the secret chat identifier is returned to the client
      scSecretChat* {.jsonName: "secret_chat".}: SecretChat ## New data about the secret chat
    of uUserFullInfo:
      ## Some data from userFullInfo has been changed
      ufiUserId* {.jsonName: "user_id".}: int32 ## User identifier
      ufiUserFullInfo* {.jsonName: "user_full_info".}: UserFullInfo ## New full information about the user
    of uBasicGroupFullInfo:
      ## Some data from basicGroupFullInfo has been changed
      bgfiBasicGroupId* {.jsonName: "basic_group_id".}: int32 ## Identifier of a basic group
      bgfiBasicGroupFullInfo* {.jsonName: "basic_group_full_info".}: BasicGroupFullInfo ## New full information about the group
    of uSupergroupFullInfo:
      ## Some data from supergroupFullInfo has been changed
      sfiSupergroupId* {.jsonName: "supergroup_id".}: int32 ## Identifier of the supergroup or channel
      sfiSupergroupFullInfo* {.jsonName: "supergroup_full_info".}: SupergroupFullInfo ## New full information about the supergroup
    of uServiceNotification:
      ## Service notification from the server. Upon receiving this the client must show a popup with the content of the notification
      snType* {.jsonName: "type".}: string ## Notification type. If type begins with "AUTH_KEY_DROP_", then two buttons "Cancel" and "Log out" should be shown under notification; if user presses the second, all local data should be destroyed using Destroy method
      snContent* {.jsonName: "content".}: MessageContent ## Notification content
    of uFile:
      ## Information about a file was updated
      updatefiFile* {.jsonName: "file".}: File ## New data about the file
    of uFileGenerationStart:
      ## The file generation process needs to be started by the client
      fgsGenerationId* {.jsonName: "generation_id".}: string ## Unique identifier for the generation process
      fgsOriginalPath* {.jsonName: "original_path".}: string ## The path to a file from which a new file is generated; may be empty
      fgsDestinationPath* {.jsonName: "destination_path".}: string ## The path to a file that should be created and where the new file should be generated
      fgsConversion* {.jsonName: "conversion".}: string ## String specifying the conversion applied to the original file. If conversion is "#url#" than original_path contains an HTTP/HTTPS URL of a file, which should be downloaded by the client
    of uFileGenerationStop:
      ## File generation is no longer needed
      fgstopGenerationId* {.jsonName: "generation_id".}: string ## Unique identifier for the generation process
    of uCall:
      ## New call was created or information about a call was updated
      updatecaCall* {.jsonName: "call".}: Call ## New data about a call
    of uUserPrivacySettingRules:
      ## Some privacy setting rules have been changed
      upsrSetting* {.jsonName: "setting".}: UserPrivacySetting ## The privacy setting
      upsrRules* {.jsonName: "rules".}: UserPrivacySettingRules ## New privacy rules
    of uUnreadMessageCount:
      ## Number of unread messages in a chat list has changed. This update is sent only if the message database is used
      umcChatList* {.jsonName: "chat_list".}: ChatList ## The chat list with changed number of unread messages
      umcUnreadCount* {.jsonName: "unread_count".}: int32 ## Total number of unread messages
      umcUnreadUnmutedCount* {.jsonName: "unread_unmuted_count".}: int32 ## Total number of unread messages in unmuted chats
    of uUnreadChatCount:
      ## Number of unread chats, i.e. with unread messages or marked as unread, has changed. This update is sent only if the message database is used
      uccChatList* {.jsonName: "chat_list".}: ChatList ## The chat list with changed number of unread messages
      uccTotalCount* {.jsonName: "total_count".}: int32 ## Approximate total number of chats in the chat list
      uccUnreadCount* {.jsonName: "unread_count".}: int32 ## Total number of unread chats
      uccUnreadUnmutedCount* {.jsonName: "unread_unmuted_count".}: int32 ## Total number of unread unmuted chats
      uccMarkedAsUnreadCount* {.jsonName: "marked_as_unread_count".}: int32 ## Total number of chats marked as unread
      uccMarkedAsUnreadUnmutedCount* {.jsonName: "marked_as_unread_unmuted_count".}: int32 ## Total number of unmuted chats marked as unread
    of uOption:
      ## An option changed its value
      updateoptiName* {.jsonName: "name".}: string ## The option name
      updateoptiValue* {.jsonName: "value".}: OptionValue ## The new option value
    of uStickerSet:
      ## A sticker set has changed
      ssStickerSet* {.jsonName: "sticker_set".}: StickerSet ## The sticker set
    of uInstalledStickerSets:
      ## The list of installed sticker sets was updated
      issIsMasks* {.jsonName: "is_masks".}: bool ## True, if the list of installed mask sticker sets was updated
      issStickerSetIds* {.jsonName: "sticker_set_ids".}: seq[string] ## The new list of installed ordinary sticker sets
    of uTrendingStickerSets:
      ## The list of trending sticker sets was updated or some of them were viewed
      tssStickerSets* {.jsonName: "sticker_sets".}: StickerSets ## The prefix of the list of trending sticker sets with the newest trending sticker sets
    of uRecentStickers:
      ## The list of recently used stickers was updated
      rsIsAttached* {.jsonName: "is_attached".}: bool ## True, if the list of stickers attached to photo or video files was updated, otherwise the list of sent stickers is updated
      rsStickerIds* {.jsonName: "sticker_ids".}: seq[int32] ## The new list of file identifiers of recently used stickers
    of uFavoriteStickers:
      ## The list of favorite stickers was updated
      fsStickerIds* {.jsonName: "sticker_ids".}: seq[int32] ## The new list of file identifiers of favorite stickers
    of uSavedAnimations:
      ## The list of saved animations was updated
      saAnimationIds* {.jsonName: "animation_ids".}: seq[int32] ## The new list of file identifiers of saved animations
    of uSelectedBackground:
      ## The selected background has changed
      sbForDarkTheme* {.jsonName: "for_dark_theme".}: bool ## True, if background for dark theme has changed
      sbBackground* {.jsonName: "background".}: Option[Background] ## The new selected background; may be null
    of uLanguagePackStrings:
      ## Some language pack strings have been updated
      lpsLocalizationTarget* {.jsonName: "localization_target".}: string ## Localization target to which the language pack belongs
      lpsLanguagePackId* {.jsonName: "language_pack_id".}: string ## Identifier of the updated language pack
      lpsStrings* {.jsonName: "strings".}: seq[LanguagePackString] ## List of changed language pack strings
    of uConnectionState:
      ## The connection state has changed
      csState* {.jsonName: "state".}: ConnectionState ## The new connection state
    of uTermsOfService:
      ## New terms of service must be accepted by the user. If the terms of service are declined, then the deleteAccount method should be called with the reason "Decline ToS update"
      tosTermsOfServiceId* {.jsonName: "terms_of_service_id".}: string ## Identifier of the terms of service
      tosTermsOfService* {.jsonName: "terms_of_service".}: TermsOfService ## The new terms of service
    of uUsersNearby:
      ## The list of users nearby has changed. The update is sent only 60 seconds after a successful searchChatsNearby request
      unUsersNearby* {.jsonName: "users_nearby".}: seq[ChatNearby] ## The new list of users nearby
    of uDiceEmojis:
      ## The list of supported dice emojis has changed
      deEmojis* {.jsonName: "emojis".}: seq[string] ## The new list of supported dice emojis
    of uNewInlineQuery:
      ## A new incoming inline query; for bots only
      niqId* {.jsonName: "id".}: string ## Unique query identifier
      niqSenderUserId* {.jsonName: "sender_user_id".}: int32 ## Identifier of the user who sent the query
      niqUserLocation* {.jsonName: "user_location".}: Option[Location] ## User location, provided by the client; may be null
      niqQuery* {.jsonName: "query".}: string ## Text of the query
      niqOffset* {.jsonName: "offset".}: string ## Offset of the first entry to return
    of uNewChosenInlineResult:
      ## The user has chosen a result of an inline query; for bots only
      ncirSenderUserId* {.jsonName: "sender_user_id".}: int32 ## Identifier of the user who sent the query
      ncirUserLocation* {.jsonName: "user_location".}: Option[Location] ## User location, provided by the client; may be null
      ncirQuery* {.jsonName: "query".}: string ## Text of the query
      ncirResultId* {.jsonName: "result_id".}: string ## Identifier of the chosen result
      ncirInlineMessageId* {.jsonName: "inline_message_id".}: string ## Identifier of the sent inline message, if known
    of uNewCallbackQuery:
      ## A new incoming callback query; for bots only
      ncqId* {.jsonName: "id".}: string ## Unique query identifier
      ncqSenderUserId* {.jsonName: "sender_user_id".}: int32 ## Identifier of the user who sent the query
      ncqChatId* {.jsonName: "chat_id".}: int64 ## Identifier of the chat where the query was sent
      ncqMessageId* {.jsonName: "message_id".}: int64 ## Identifier of the message, from which the query originated
      ncqChatInstance* {.jsonName: "chat_instance".}: string ## Identifier that uniquely corresponds to the chat to which the message was sent
      ncqPayload* {.jsonName: "payload".}: CallbackQueryPayload ## Query payload
    of uNewInlineCallbackQuery:
      ## A new incoming callback query from a message sent via a bot; for bots only
      nicqId* {.jsonName: "id".}: string ## Unique query identifier
      nicqSenderUserId* {.jsonName: "sender_user_id".}: int32 ## Identifier of the user who sent the query
      nicqInlineMessageId* {.jsonName: "inline_message_id".}: string ## Identifier of the inline message, from which the query originated
      nicqChatInstance* {.jsonName: "chat_instance".}: string ## An identifier uniquely corresponding to the chat a message was sent to
      nicqPayload* {.jsonName: "payload".}: CallbackQueryPayload ## Query payload
    of uNewShippingQuery:
      ## A new incoming shipping query; for bots only. Only for invoices with flexible price
      nsqId* {.jsonName: "id".}: string ## Unique query identifier
      nsqSenderUserId* {.jsonName: "sender_user_id".}: int32 ## Identifier of the user who sent the query
      nsqInvoicePayload* {.jsonName: "invoice_payload".}: string ## Invoice payload
      nsqShippingAddress* {.jsonName: "shipping_address".}: Address ## User shipping address
    of uNewPreCheckoutQuery:
      ## A new incoming pre-checkout query; for bots only. Contains full information about a checkout
      npcqId* {.jsonName: "id".}: string ## Unique query identifier
      npcqSenderUserId* {.jsonName: "sender_user_id".}: int32 ## Identifier of the user who sent the query
      npcqCurrency* {.jsonName: "currency".}: string ## Currency for the product price
      npcqTotalAmount* {.jsonName: "total_amount".}: int64 ## Total price for the product, in the minimal quantity of the currency
      npcqInvoicePayload* {.jsonName: "invoice_payload".}: string ## Invoice payload
      npcqShippingOptionId* {.jsonName: "shipping_option_id".}: string ## Identifier of a shipping option chosen by the user; may be empty if not applicable
      npcqOrderInfo* {.jsonName: "order_info".}: Option[OrderInfo] ## Information about the order; may be null
    of uNewCustomEvent:
      ## A new incoming event; for bots only
      nceEvent* {.jsonName: "event".}: string ## A JSON-serialized event
    of uNewCustomQuery:
      ## A new incoming query; for bots only
      ncqueryId* {.jsonName: "id".}: string ## The query identifier
      ncqData* {.jsonName: "data".}: string ## JSON-serialized query data
      ncqTimeout* {.jsonName: "timeout".}: int32 ## Query timeout
    of uPoll:
      ## A poll was updated; for bots only
      updatepoPoll* {.jsonName: "poll".}: Poll ## New data about the poll
    of uPollAnswer:
      ## A user changed the answer to a poll; for bots only
      paPollId* {.jsonName: "poll_id".}: string ## Unique poll identifier
      paUserId* {.jsonName: "user_id".}: int32 ## The user, who changed the answer to the poll
      paOptionIds* {.jsonName: "option_ids".}: seq[int32] ## 0-based identifiers of answer options, chosen by the user

  StickerSets * = object
    ## Represents a list of sticker sets
    kind {.jsonName: "@type".}: string
    totalCount* {.jsonName: "total_count".}: int32 ## Approximate total number of sticker sets found
    sets* {.jsonName: "sets".}: seq[StickerSetInfo] ## List of sticker sets

  CallStateKind * {.pure.} = enum
    csPending = "callStatePending",
    csDiscarded = "callStateDiscarded",
    csError = "callStateError",
    csExchangingKeys = "callStateExchangingKeys",
    csHangingUp = "callStateHangingUp",
    csReady = "callStateReady",

  CallState * = object
    ## Describes the current call state
    case kind* {.jsonName: "@type".}: CallStateKind
    of csPending:
      ## The call is pending, waiting to be accepted by a user
      callstatependiIsCreated* {.jsonName: "is_created".}: bool ## True, if the call has already been created by the server
      callstatependiIsReceived* {.jsonName: "is_received".}: bool ## True, if the call has already been received by the other party
    of csExchangingKeys:
      ## The call has been answered and encryption keys are being exchanged
      discard
    of csReady:
      ## The call is ready to use
      callstatereaProtocol* {.jsonName: "protocol".}: CallProtocol ## Call protocols supported by the peer
      callstatereaConnections* {.jsonName: "connections".}: seq[CallConnection] ## Available UDP reflectors
      callstatereaConfig* {.jsonName: "config".}: string ## A JSON-encoded call config
      callstatereaEncryptionKey* {.jsonName: "encryption_key".}: string ## Call encryption key
      callstatereaEmojis* {.jsonName: "emojis".}: seq[string] ## Encryption key emojis fingerprint
      callstatereaAllowP2p* {.jsonName: "allow_p2p".}: bool ## True, if peer-to-peer connection is allowed by users privacy settings
    of csHangingUp:
      ## The call is hanging up after discardCall has been called
      discard
    of csDiscarded:
      ## The call has ended successfully
      callstatediscardReason* {.jsonName: "reason".}: CallDiscardReason ## The reason, why the call has ended
      callstatediscardNeedRating* {.jsonName: "need_rating".}: bool ## True, if the call rating should be sent to the server
      callstatediscardNeedDebugInformation* {.jsonName: "need_debug_information".}: bool ## True, if the call debug information should be sent to the server
    of csError:
      ## The call has ended with an error
      callstateerrError* {.jsonName: "error".}: Error ## Error. An error with the code 4005000 will be returned if an outgoing call is missed because of an expired timeout

  ChatEvent * = object
    ## Represents a chat event
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string ## Chat event identifier
    date* {.jsonName: "date".}: int32 ## Point in time (Unix timestamp) when the event happened
    userId* {.jsonName: "user_id".}: int32 ## Identifier of the user who performed the action that triggered the event
    action* {.jsonName: "action".}: ChatEventAction ## Action performed by the user

  NotificationTypeKind * {.pure.} = enum
    ntnMessage = "notificationTypeNewMessage",
    ntnSecretChat = "notificationTypeNewSecretChat",
    ntnCall = "notificationTypeNewCall",
    ntnPushMessage = "notificationTypeNewPushMessage",

  NotificationType * = object
    ## Contains detailed information about a notification
    case kind* {.jsonName: "@type".}: NotificationTypeKind
    of ntnMessage:
      ## New message was received
      nmMessage* {.jsonName: "message".}: Message ## The message
    of ntnSecretChat:
      ## New secret chat was created
      discard
    of ntnCall:
      ## New call was received
      ncCallId* {.jsonName: "call_id".}: int32 ## Call identifier
    of ntnPushMessage:
      ## New message was received through a push notification
      npmMessageId* {.jsonName: "message_id".}: int64 ## The message identifier. The message will not be available in the chat history, but the ID can be used in viewMessages and as reply_to_message_id
      npmSenderUserId* {.jsonName: "sender_user_id".}: int32 ## Sender of the message; 0 if unknown. Corresponding user may be inaccessible
      npmSenderName* {.jsonName: "sender_name".}: string ## Name of the sender; can be different from the name of the sender user
      npmIsOutgoing* {.jsonName: "is_outgoing".}: bool ## True, if the message is outgoing
      npmContent* {.jsonName: "content".}: PushMessageContent ## Push message content

  EncryptedPassportElement * = object
    ## Contains information about an encrypted Telegram Passport element; for bots only
    kind {.jsonName: "@type".}: string
    typ* {.jsonName: "type".}: PassportElementType ## Type of Telegram Passport element
    data* {.jsonName: "data".}: string ## Encrypted JSON-encoded data about the user
    frontSide* {.jsonName: "front_side".}: DatedFile ## The front side of an identity document
    reverseSide* {.jsonName: "reverse_side".}: Option[DatedFile] ## The reverse side of an identity document; may be null
    selfie* {.jsonName: "selfie".}: Option[DatedFile] ## Selfie with the document; may be null
    translation* {.jsonName: "translation".}: seq[DatedFile] ## List of files containing a certified English translation of the document
    files* {.jsonName: "files".}: seq[DatedFile] ## List of attached files
    value* {.jsonName: "value".}: string ## Unencrypted data, phone number or email address
    hash* {.jsonName: "hash".}: string ## Hash of the entire element

  BasicGroup * = object
    ## Represents a basic group of 0-200 users (must be upgraded to a supergroup to accommodate more than 200 users)
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32 ## Group identifier
    memberCount* {.jsonName: "member_count".}: int32 ## Number of members in the group
    status* {.jsonName: "status".}: ChatMemberStatus ## Status of the current user in the group
    isActive* {.jsonName: "is_active".}: bool ## True, if the group is active
    upgradedToSupergroupId* {.jsonName: "upgraded_to_supergroup_id".}: int32 ## Identifier of the supergroup to which this group was upgraded; 0 if none

  RecoveryEmailAddress * = object
    ## Contains information about the current recovery email address
    kind {.jsonName: "@type".}: string
    recoveryEmailAddress* {.jsonName: "recovery_email_address".}: string ## Recovery email address

  ChatPermissions * = object
    ## Describes actions that a user is allowed to take in a chat
    kind {.jsonName: "@type".}: string
    canSendMessages* {.jsonName: "can_send_messages".}: bool ## True, if the user can send text messages, contacts, locations, and venues
    canSendMediaMessages* {.jsonName: "can_send_media_messages".}: bool ## True, if the user can send audio files, documents, photos, videos, video notes, and voice notes. Implies can_send_messages permissions
    canSendPolls* {.jsonName: "can_send_polls".}: bool ## True, if the user can send polls. Implies can_send_messages permissions
    canSendOtherMessages* {.jsonName: "can_send_other_messages".}: bool ## True, if the user can send animations, games, and stickers and use inline bots. Implies can_send_messages permissions
    canAddWebPagePreviews* {.jsonName: "can_add_web_page_previews".}: bool ## True, if the user may add a web page preview to their messages. Implies can_send_messages permissions
    canChangeInfo* {.jsonName: "can_change_info".}: bool ## True, if the user can change the chat title, photo, and other settings
    canInviteUsers* {.jsonName: "can_invite_users".}: bool ## True, if the user can invite new users to the chat
    canPinMessages* {.jsonName: "can_pin_messages".}: bool ## True, if the user can pin messages

  FileTypeKind * {.pure.} = enum
    ftSecure = "fileTypeSecure",
    ftVoiceNote = "fileTypeVoiceNote",
    ftVideo = "fileTypeVideo",
    ftAnimation = "fileTypeAnimation",
    ftProfilePhoto = "fileTypeProfilePhoto",
    ftNone = "fileTypeNone",
    ftSecretThumbnail = "fileTypeSecretThumbnail",
    ftPhoto = "fileTypePhoto",
    ftVideoNote = "fileTypeVideoNote",
    ftWallpaper = "fileTypeWallpaper",
    ftDocument = "fileTypeDocument",
    ftAudio = "fileTypeAudio",
    ftSecret = "fileTypeSecret",
    ftSticker = "fileTypeSticker",
    ftUnknown = "fileTypeUnknown",
    ftThumbnail = "fileTypeThumbnail",

  FileType * = object
    ## Represents the type of a file
    case kind* {.jsonName: "@type".}: FileTypeKind
    of ftNone:
      ## The data is not a file
      discard
    of ftAnimation:
      ## The file is an animation
      discard
    of ftAudio:
      ## The file is an audio file
      discard
    of ftDocument:
      ## The file is a document
      discard
    of ftPhoto:
      ## The file is a photo
      discard
    of ftProfilePhoto:
      ## The file is a profile photo
      discard
    of ftSecret:
      ## The file was sent to a secret chat (the file type is not known to the server)
      discard
    of ftSecretThumbnail:
      ## The file is a thumbnail of a file from a secret chat
      discard
    of ftSecure:
      ## The file is a file from Secure storage used for storing Telegram Passport files
      discard
    of ftSticker:
      ## The file is a sticker
      discard
    of ftThumbnail:
      ## The file is a thumbnail of another file
      discard
    of ftUnknown:
      ## The file type is not yet known
      discard
    of ftVideo:
      ## The file is a video
      discard
    of ftVideoNote:
      ## The file is a video note
      discard
    of ftVoiceNote:
      ## The file is a voice note
      discard
    of ftWallpaper:
      ## The file is a wallpaper or a background pattern
      discard

  ImportedContacts * = object
    ## Represents the result of an ImportContacts request
    kind {.jsonName: "@type".}: string
    userIds* {.jsonName: "user_ids".}: seq[int32] ## User identifiers of the imported contacts in the same order as they were specified in the request; 0 if the contact is not yet a registered user
    importerCount* {.jsonName: "importer_count".}: seq[int32] ## The number of users that imported the corresponding contact; 0 for already registered users or if unavailable

  Invoice * = object
    ## Product invoice
    kind {.jsonName: "@type".}: string
    currency* {.jsonName: "currency".}: string ## ISO 4217 currency code
    priceParts* {.jsonName: "price_parts".}: seq[LabeledPricePart] ## A list of objects used to calculate the total price of the product
    isTest* {.jsonName: "is_test".}: bool ## True, if the payment is a test payment
    needName* {.jsonName: "need_name".}: bool ## True, if the user's name is needed for payment
    needPhoneNumber* {.jsonName: "need_phone_number".}: bool ## True, if the user's phone number is needed for payment
    needEmailAddress* {.jsonName: "need_email_address".}: bool ## True, if the user's email address is needed for payment
    needShippingAddress* {.jsonName: "need_shipping_address".}: bool ## True, if the user's shipping address is needed for payment
    sendPhoneNumberToProvider* {.jsonName: "send_phone_number_to_provider".}: bool ## True, if the user's phone number will be sent to the provider
    sendEmailAddressToProvider* {.jsonName: "send_email_address_to_provider".}: bool ## True, if the user's email address will be sent to the provider
    isFlexible* {.jsonName: "is_flexible".}: bool ## True, if the total price depends on the shipping method

  ChatMember * = object
    ## A user with information about joining/leaving a chat
    kind {.jsonName: "@type".}: string
    userId* {.jsonName: "user_id".}: int32 ## User identifier of the chat member
    inviterUserId* {.jsonName: "inviter_user_id".}: int32 ## Identifier of a user that invited/promoted/banned this member in the chat; 0 if unknown
    joinedChatDate* {.jsonName: "joined_chat_date".}: int32 ## Point in time (Unix timestamp) when the user joined a chat
    status* {.jsonName: "status".}: ChatMemberStatus ## Status of the member in the chat
    botInfo* {.jsonName: "bot_info".}: Option[BotInfo] ## If the user is a bot, information about the bot; may be null. Can be null even for a bot if the bot is not a chat member

  Minithumbnail * = object
    ## Thumbnail image of a very poor quality and low resolution
    kind {.jsonName: "@type".}: string
    width* {.jsonName: "width".}: int32 ## Thumbnail width, usually doesn't exceed 40
    height* {.jsonName: "height".}: int32 ## Thumbnail height, usually doesn't exceed 40
    data* {.jsonName: "data".}: string ## The thumbnail in JPEG format

  InlineQueryResults * = object
    ## Represents the results of the inline query. Use sendInlineQueryResultMessage to send the result of the query
    kind {.jsonName: "@type".}: string
    inlineQueryId* {.jsonName: "inline_query_id".}: string ## Unique identifier of the inline query
    nextOffset* {.jsonName: "next_offset".}: string ## The offset for the next request. If empty, there are no more results
    results* {.jsonName: "results".}: seq[InlineQueryResult] ## Results of the query
    switchPmText* {.jsonName: "switch_pm_text".}: string ## If non-empty, this text should be shown on the button, which opens a private chat with the bot and sends the bot a start message with the switch_pm_parameter
    switchPmParameter* {.jsonName: "switch_pm_parameter".}: string ## Parameter for the bot start message

  InlineKeyboardButton * = object
    ## Represents a single button in an inline keyboard
    kind {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: string ## Text of the button
    typ* {.jsonName: "type".}: InlineKeyboardButtonType ## Type of the button

  JsonValueKind * {.pure.} = enum
    jvObject = "jsonValueObject",
    jvNull = "jsonValueNull",
    jvNumber = "jsonValueNumber",
    jvArray = "jsonValueArray",
    jvString = "jsonValueString",
    jvBoolean = "jsonValueBoolean",

  JsonValue * = object
    ## Represents a JSON value
    case kind* {.jsonName: "@type".}: JsonValueKind
    of jvNull:
      ## Represents a null JSON value
      discard
    of jvBoolean:
      ## Represents a boolean JSON value
      jsonvaluebooleValue* {.jsonName: "value".}: bool ## The value
    of jvNumber:
      ## Represents a numeric JSON value
      jsonvaluenumbValue* {.jsonName: "value".}: float ## The value
    of jvString:
      ## Represents a string JSON value
      jsonvaluestriValue* {.jsonName: "value".}: string ## The value
    of jvArray:
      ## Represents a JSON array
      jsonvaluearrValues* {.jsonName: "values".}: seq[JsonValue] ## The list of array elements
    of jvObject:
      ## Represents a JSON object
      jsonvalueobjeMembers* {.jsonName: "members".}: seq[JsonObjectMember] ## The list of object members

  Game * = object
    ## Describes a game
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string ## Game ID
    shortName* {.jsonName: "short_name".}: string ## Game short name. To share a game use the URL https://t.me/{bot_username}?game={game_short_name}
    title* {.jsonName: "title".}: string ## Game title
    text* {.jsonName: "text".}: FormattedText ## Game text, usually containing scoreboards for a game
    description* {.jsonName: "description".}: string ## Describes a game
    photo* {.jsonName: "photo".}: Photo ## Game photo
    animation* {.jsonName: "animation".}: Option[Animation] ## Game animation; may be null

  ChatLocation * = object
    ## Represents a location to which a chat is connected
    kind {.jsonName: "@type".}: string
    location* {.jsonName: "location".}: Location ## The location
    address* {.jsonName: "address".}: string ## Location address; 1-64 characters, as defined by the chat owner

  LanguagePackStringValueKind * {.pure.} = enum
    lpsvOrdinary = "languagePackStringValueOrdinary",
    lpsvDeleted = "languagePackStringValueDeleted",
    lpsvPluralized = "languagePackStringValuePluralized",

  LanguagePackStringValue * = object
    ## Represents the value of a string in a language pack
    case kind* {.jsonName: "@type".}: LanguagePackStringValueKind
    of lpsvOrdinary:
      ## An ordinary language pack string
      languagepackstringvalueordinaValue* {.jsonName: "value".}: string ## String value
    of lpsvPluralized:
      ## A language pack string which has different forms based on the number of some object it mentions. See https://www.unicode.org/cldr/charts/latest/supplemental/language_plural_rules.html for more info
      languagepackstringvaluepluralizZeroValue* {.jsonName: "zero_value".}: string ## Value for zero objects
      languagepackstringvaluepluralizOneValue* {.jsonName: "one_value".}: string ## Value for one object
      languagepackstringvaluepluralizTwoValue* {.jsonName: "two_value".}: string ## Value for two objects
      languagepackstringvaluepluralizFewValue* {.jsonName: "few_value".}: string ## Value for few objects
      languagepackstringvaluepluralizManyValue* {.jsonName: "many_value".}: string ## Value for many objects
      languagepackstringvaluepluralizOtherValue* {.jsonName: "other_value".}: string ## Default value
    of lpsvDeleted:
      ## A deleted language pack string, the value should be taken from the built-in english language pack
      discard

  DeviceTokenKind * {.pure.} = enum
    dtWindowsPush = "deviceTokenWindowsPush",
    dtApplePushVoIP = "deviceTokenApplePushVoIP",
    dtMicrosoftPushVoIP = "deviceTokenMicrosoftPushVoIP",
    dtTizenPush = "deviceTokenTizenPush",
    dtMicrosoftPush = "deviceTokenMicrosoftPush",
    dtSimplePush = "deviceTokenSimplePush",
    dtWebPush = "deviceTokenWebPush",
    dtUbuntuPush = "deviceTokenUbuntuPush",
    dtApplePush = "deviceTokenApplePush",
    dtFirebaseCloudMessaging = "deviceTokenFirebaseCloudMessaging",
    dtBlackBerryPush = "deviceTokenBlackBerryPush",

  DeviceToken * = object
    ## Represents a data needed to subscribe for push notifications through registerDevice method. To use specific push notification service, you must specify the correct application platform and upload valid server authentication data at https://my.telegram.org
    case kind* {.jsonName: "@type".}: DeviceTokenKind
    of dtFirebaseCloudMessaging:
      ## A token for Firebase Cloud Messaging
      fcmToken* {.jsonName: "token".}: string ## Device registration token; may be empty to de-register a device
      fcmEncrypt* {.jsonName: "encrypt".}: bool ## True, if push notifications should be additionally encrypted
    of dtApplePush:
      ## A token for Apple Push Notification service
      apDeviceToken* {.jsonName: "device_token".}: string ## Device token; may be empty to de-register a device
      apIsAppSandbox* {.jsonName: "is_app_sandbox".}: bool ## True, if App Sandbox is enabled
    of dtApplePushVoIP:
      ## A token for Apple Push Notification service VoIP notifications
      apvipDeviceToken* {.jsonName: "device_token".}: string ## Device token; may be empty to de-register a device
      apvipIsAppSandbox* {.jsonName: "is_app_sandbox".}: bool ## True, if App Sandbox is enabled
      apvipEncrypt* {.jsonName: "encrypt".}: bool ## True, if push notifications should be additionally encrypted
    of dtWindowsPush:
      ## A token for Windows Push Notification Services
      wpAccessToken* {.jsonName: "access_token".}: string ## The access token that will be used to send notifications; may be empty to de-register a device
    of dtMicrosoftPush:
      ## A token for Microsoft Push Notification Service
      mpChannelUri* {.jsonName: "channel_uri".}: string ## Push notification channel URI; may be empty to de-register a device
    of dtMicrosoftPushVoIP:
      ## A token for Microsoft Push Notification Service VoIP channel
      mpvipChannelUri* {.jsonName: "channel_uri".}: string ## Push notification channel URI; may be empty to de-register a device
    of dtWebPush:
      ## A token for web Push API
      wpEndpoint* {.jsonName: "endpoint".}: string ## Absolute URL exposed by the push service where the application server can send push messages; may be empty to de-register a device
      wpP256dhBase64url* {.jsonName: "p256dh_base64url".}: string ## Base64url-encoded P-256 elliptic curve Diffie-Hellman public key
      wpAuthBase64url* {.jsonName: "auth_base64url".}: string ## Base64url-encoded authentication secret
    of dtSimplePush:
      ## A token for Simple Push API for Firefox OS
      spEndpoint* {.jsonName: "endpoint".}: string ## Absolute URL exposed by the push service where the application server can send push messages; may be empty to de-register a device
    of dtUbuntuPush:
      ## A token for Ubuntu Push Client service
      upToken* {.jsonName: "token".}: string ## Token; may be empty to de-register a device
    of dtBlackBerryPush:
      ## A token for BlackBerry Push Service
      bbpToken* {.jsonName: "token".}: string ## Token; may be empty to de-register a device
    of dtTizenPush:
      ## A token for Tizen Push Service
      tpRegId* {.jsonName: "reg_id".}: string ## Push service registration identifier; may be empty to de-register a device

  PollTypeKind * {.pure.} = enum
    ptQuiz = "pollTypeQuiz",
    ptRegular = "pollTypeRegular",

  PollType * = object
    ## Describes the type of a poll
    case kind* {.jsonName: "@type".}: PollTypeKind
    of ptRegular:
      ## A regular poll
      polltyperegulAllowMultipleAnswers* {.jsonName: "allow_multiple_answers".}: bool ## True, if multiple answer options can be chosen simultaneously
    of ptQuiz:
      ## A poll in quiz mode, which has exactly one correct answer option and can be answered only once
      polltypequCorrectOptionId* {.jsonName: "correct_option_id".}: int32 ## 0-based identifier of the correct answer option; -1 for a yet unanswered poll
      polltypequExplanation* {.jsonName: "explanation".}: FormattedText ## Text that is shown when the user chooses an incorrect answer or taps on the lamp icon, 0-200 characters with at most 2 line feeds; empty for a yet unanswered poll

  NotificationGroupTypeKind * {.pure.} = enum
    ngtMessages = "notificationGroupTypeMessages",
    ngtCalls = "notificationGroupTypeCalls",
    ngtSecretChat = "notificationGroupTypeSecretChat",
    ngtMentions = "notificationGroupTypeMentions",

  NotificationGroupType * = object
    ## Describes the type of notifications in a notification group
    case kind* {.jsonName: "@type".}: NotificationGroupTypeKind
    of ngtMessages:
      ## A group containing notifications of type notificationTypeNewMessage and notificationTypeNewPushMessage with ordinary unread messages
      discard
    of ngtMentions:
      ## A group containing notifications of type notificationTypeNewMessage and notificationTypeNewPushMessage with unread mentions of the current user, replies to their messages, or a pinned message
      discard
    of ngtSecretChat:
      ## A group containing a notification of type notificationTypeNewSecretChat
      discard
    of ngtCalls:
      ## A group containing notifications of type notificationTypeNewCall
      discard

  ConnectionStateKind * {.pure.} = enum
    csUpdating = "connectionStateUpdating",
    csConnectingToProxy = "connectionStateConnectingToProxy",
    csReady = "connectionStateReady",
    csWaitingForNetwork = "connectionStateWaitingForNetwork",
    csConnecting = "connectionStateConnecting",

  ConnectionState * = object
    ## Describes the current state of the connection to Telegram servers
    case kind* {.jsonName: "@type".}: ConnectionStateKind
    of csWaitingForNetwork:
      ## Currently waiting for the network to become available. Use setNetworkType to change the available network type
      discard
    of csConnectingToProxy:
      ## Currently establishing a connection with a proxy server
      discard
    of csConnecting:
      ## Currently establishing a connection to the Telegram servers
      discard
    of csUpdating:
      ## Downloading data received while the client was offline
      discard
    of ConnectionStateKind.csReady:
      ## There is a working connection to the Telegram servers
      discard

  ChatNearby * = object
    ## Describes a chat located nearby
    kind {.jsonName: "@type".}: string
    chatId* {.jsonName: "chat_id".}: int64 ## Chat identifier
    distance* {.jsonName: "distance".}: int32 ## Distance to the chat location in meters

  LanguagePackString * = object
    ## Represents one language pack string
    kind {.jsonName: "@type".}: string
    key* {.jsonName: "key".}: string ## String key
    value* {.jsonName: "value".}: LanguagePackStringValue ## String value

  ChatReportReasonKind * {.pure.} = enum
    crrChildAbuse = "chatReportReasonChildAbuse",
    crrUnrelatedLocation = "chatReportReasonUnrelatedLocation",
    crrSpam = "chatReportReasonSpam",
    crrViolence = "chatReportReasonViolence",
    crrPornography = "chatReportReasonPornography",
    crrCopyright = "chatReportReasonCopyright",
    crrCustom = "chatReportReasonCustom",

  ChatReportReason * = object
    ## Describes the reason why a chat is reported
    case kind* {.jsonName: "@type".}: ChatReportReasonKind
    of crrSpam:
      ## The chat contains spam messages
      discard
    of crrViolence:
      ## The chat promotes violence
      discard
    of crrPornography:
      ## The chat contains pornographic messages
      discard
    of crrChildAbuse:
      ## The chat has child abuse related content
      discard
    of crrCopyright:
      ## The chat contains copyrighted content
      discard
    of crrUnrelatedLocation:
      ## The location-based chat is unrelated to its stated location
      discard
    of crrCustom:
      ## A custom reason provided by the user
      chatreportreasoncustText* {.jsonName: "text".}: string ## Report text

  AutoDownloadSettings * = object
    ## Contains auto-download settings
    kind {.jsonName: "@type".}: string
    isAutoDownloadEnabled* {.jsonName: "is_auto_download_enabled".}: bool ## True, if the auto-download is enabled
    maxPhotoFileSize* {.jsonName: "max_photo_file_size".}: int32 ## The maximum size of a photo file to be auto-downloaded
    maxVideoFileSize* {.jsonName: "max_video_file_size".}: int32 ## The maximum size of a video file to be auto-downloaded
    maxOtherFileSize* {.jsonName: "max_other_file_size".}: int32 ## The maximum size of other file types to be auto-downloaded
    videoUploadBitrate* {.jsonName: "video_upload_bitrate".}: int32 ## The maximum suggested bitrate for uploaded videos
    preloadLargeVideos* {.jsonName: "preload_large_videos".}: bool ## True, if the beginning of videos needs to be preloaded for instant playback
    preloadNextAudio* {.jsonName: "preload_next_audio".}: bool ## True, if the next audio track needs to be preloaded while the user is listening to an audio file
    useLessDataForCalls* {.jsonName: "use_less_data_for_calls".}: bool ## True, if "use less data for calls" option needs to be enabled

  MessageForwardInfo * = object
    ## Contains information about a forwarded message
    kind {.jsonName: "@type".}: string
    origin* {.jsonName: "origin".}: MessageForwardOrigin ## Origin of a forwarded message
    date* {.jsonName: "date".}: int32 ## Point in time (Unix timestamp) when the message was originally sent
    publicServiceAnnouncementType* {.jsonName: "public_service_announcement_type".}: string ## The type of a public service announcement for the forwarded message
    fromChatId* {.jsonName: "from_chat_id".}: int64 ## For messages forwarded to the chat with the current user (Saved Messages) or to the channel's discussion group, the identifier of the chat from which the message was forwarded last time; 0 if unknown
    fromMessageId* {.jsonName: "from_message_id".}: int64 ## For messages forwarded to the chat with the current user (Saved Messages) or to the channel's discussion group, the identifier of the original message from which the new message was forwarded last time; 0 if unknown

  Text * = object
    ## Contains some text
    kind {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: string ## Text

  PaymentResult * = object
    ## Contains the result of a payment request
    kind {.jsonName: "@type".}: string
    success* {.jsonName: "success".}: bool ## True, if the payment request was successful; otherwise the verification_url will be not empty
    verificationUrl* {.jsonName: "verification_url".}: string ## URL for additional payment credentials verification

  InlineKeyboardButtonTypeKind * {.pure.} = enum
    ikbtBuy = "inlineKeyboardButtonTypeBuy",
    ikbtLoginUrl = "inlineKeyboardButtonTypeLoginUrl",
    ikbtUrl = "inlineKeyboardButtonTypeUrl",
    ikbtCallback = "inlineKeyboardButtonTypeCallback",
    ikbtSwitchInline = "inlineKeyboardButtonTypeSwitchInline",
    ikbtCallbackGame = "inlineKeyboardButtonTypeCallbackGame",

  InlineKeyboardButtonType * = object
    ## Describes the type of an inline keyboard button
    case kind* {.jsonName: "@type".}: InlineKeyboardButtonTypeKind
    of ikbtUrl:
      ## A button that opens a specified URL
      inlinekeyboardbuttontypeuUrl* {.jsonName: "url".}: string ## HTTP or tg:// URL to open
    of ikbtLoginUrl:
      ## A button that opens a specified URL and automatically logs in in current user if they allowed to do that
      luUrl* {.jsonName: "url".}: string ## An HTTP URL to open
      luId* {.jsonName: "id".}: int32 ## Unique button identifier
      luForwardText* {.jsonName: "forward_text".}: string ## If non-empty, new text of the button in forwarded messages
    of ikbtCallback:
      ## A button that sends a special callback query to a bot
      inlinekeyboardbuttontypecallbaData* {.jsonName: "data".}: string ## Data to be sent to the bot via a callback query
    of ikbtCallbackGame:
      ## A button with a game that sends a special callback query to a bot. This button must be in the first column and row of the keyboard and can be attached only to a message with content of the type messageGame
      discard
    of ikbtSwitchInline:
      ## A button that forces an inline query to the bot to be inserted in the input field
      siQuery* {.jsonName: "query".}: string ## Inline query to be sent to the bot
      siInCurrentChat* {.jsonName: "in_current_chat".}: bool ## True, if the inline query should be sent from the current chat
    of ikbtBuy:
      ## A button to buy something. This button must be in the first column and row of the keyboard and can be attached only to a message with content of the type messageInvoice
      discard

  MessageSchedulingStateKind * {.pure.} = enum
    msssWhenOnline = "messageSchedulingStateSendWhenOnline",
    msssAtDate = "messageSchedulingStateSendAtDate",

  MessageSchedulingState * = object
    ## Contains information about the time when a scheduled message will be sent
    case kind* {.jsonName: "@type".}: MessageSchedulingStateKind
    of msssAtDate:
      ## The message will be sent at the specified date
      sadSendDate* {.jsonName: "send_date".}: int32 ## Date the message will be sent. The date must be within 367 days in the future
    of msssWhenOnline:
      ## The message will be sent when the peer will be online. Applicable to private chats only and when the exact online status of the peer is known
      discard

  TestVectorInt * = object
    ## A simple object containing a vector of numbers; for testing only
    kind {.jsonName: "@type".}: string
    value* {.jsonName: "value".}: seq[int32] ## Vector of numbers

  PaymentForm * = object
    ## Contains information about an invoice payment form
    kind {.jsonName: "@type".}: string
    invoice* {.jsonName: "invoice".}: Invoice ## Full information of the invoice
    url* {.jsonName: "url".}: string ## Payment form URL
    paymentsProvider* {.jsonName: "payments_provider".}: Option[PaymentsProviderStripe] ## Contains information about the payment provider, if available, to support it natively without the need for opening the URL; may be null
    savedOrderInfo* {.jsonName: "saved_order_info".}: Option[OrderInfo] ## Saved server-side order information; may be null
    savedCredentials* {.jsonName: "saved_credentials".}: Option[SavedCredentials] ## Contains information about saved card credentials; may be null
    canSaveCredentials* {.jsonName: "can_save_credentials".}: bool ## True, if the user can choose to save credentials
    needPassword* {.jsonName: "need_password".}: bool ## True, if the user will be able to save credentials protected by a password they set up

  Video * = object
    ## Describes a video file
    kind {.jsonName: "@type".}: string
    duration* {.jsonName: "duration".}: int32 ## Duration of the video, in seconds; as defined by the sender
    width* {.jsonName: "width".}: int32 ## Video width; as defined by the sender
    height* {.jsonName: "height".}: int32 ## Video height; as defined by the sender
    fileName* {.jsonName: "file_name".}: string ## Original name of the file; as defined by the sender
    mimeType* {.jsonName: "mime_type".}: string ## MIME type of the file; as defined by the sender
    hasStickers* {.jsonName: "has_stickers".}: bool ## True, if stickers were added to the video
    supportsStreaming* {.jsonName: "supports_streaming".}: bool ## True, if the video should be tried to be streamed
    minithumbnail* {.jsonName: "minithumbnail".}: Option[Minithumbnail] ## Video minithumbnail; may be null
    thumbnail* {.jsonName: "thumbnail".}: Option[PhotoSize] ## Video thumbnail; as defined by the sender; may be null
    video* {.jsonName: "video".}: File ## File containing the video

  FormattedText * = object
    ## A text with some entities
    kind {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: string ## The text
    entities* {.jsonName: "entities".}: seq[TextEntity] ## Entities contained in the text. Entities can be nested, but must not mutually intersect with each other.

  ChatAdministrator * = object
    ## Contains information about a chat administrator
    kind {.jsonName: "@type".}: string
    userId* {.jsonName: "user_id".}: int32 ## User identifier of the administrator
    customTitle* {.jsonName: "custom_title".}: string ## Custom title of the administrator
    isOwner* {.jsonName: "is_owner".}: bool ## True, if the user is the owner of the chat

  PassportElementKind * {.pure.} = enum
    pePersonalDetails = "passportElementPersonalDetails",
    peAddress = "passportElementAddress",
    pePassport = "passportElementPassport",
    pePhoneNumber = "passportElementPhoneNumber",
    peDriverLicense = "passportElementDriverLicense",
    peTemporaryRegistration = "passportElementTemporaryRegistration",
    peBankStatement = "passportElementBankStatement",
    peIdentityCard = "passportElementIdentityCard",
    peEmailAddress = "passportElementEmailAddress",
    pePassportRegistration = "passportElementPassportRegistration",
    peInternalPassport = "passportElementInternalPassport",
    peUtilityBill = "passportElementUtilityBill",
    peRentalAgreement = "passportElementRentalAgreement",

  PassportElement * = object
    ## Contains information about a Telegram Passport element
    case kind* {.jsonName: "@type".}: PassportElementKind
    of pePersonalDetails:
      ## A Telegram Passport element containing the user's personal details
      pdPersonalDetails* {.jsonName: "personal_details".}: PersonalDetails ## Personal details of the user
    of pePassport:
      ## A Telegram Passport element containing the user's passport
      passportelementpasspoPassport* {.jsonName: "passport".}: IdentityDocument ## Passport
    of peDriverLicense:
      ## A Telegram Passport element containing the user's driver license
      dlDriverLicense* {.jsonName: "driver_license".}: IdentityDocument ## Driver license
    of peIdentityCard:
      ## A Telegram Passport element containing the user's identity card
      icIdentityCard* {.jsonName: "identity_card".}: IdentityDocument ## Identity card
    of peInternalPassport:
      ## A Telegram Passport element containing the user's internal passport
      ipInternalPassport* {.jsonName: "internal_passport".}: IdentityDocument ## Internal passport
    of peAddress:
      ## A Telegram Passport element containing the user's address
      passportelementaddreAddress* {.jsonName: "address".}: Address ## Address
    of peUtilityBill:
      ## A Telegram Passport element containing the user's utility bill
      ubUtilityBill* {.jsonName: "utility_bill".}: PersonalDocument ## Utility bill
    of peBankStatement:
      ## A Telegram Passport element containing the user's bank statement
      bsBankStatement* {.jsonName: "bank_statement".}: PersonalDocument ## Bank statement
    of peRentalAgreement:
      ## A Telegram Passport element containing the user's rental agreement
      raRentalAgreement* {.jsonName: "rental_agreement".}: PersonalDocument ## Rental agreement
    of pePassportRegistration:
      ## A Telegram Passport element containing the user's passport registration pages
      prPassportRegistration* {.jsonName: "passport_registration".}: PersonalDocument ## Passport registration pages
    of peTemporaryRegistration:
      ## A Telegram Passport element containing the user's temporary registration
      trTemporaryRegistration* {.jsonName: "temporary_registration".}: PersonalDocument ## Temporary registration
    of pePhoneNumber:
      ## A Telegram Passport element containing the user's phone number
      pnPhoneNumber* {.jsonName: "phone_number".}: string ## Phone number
    of peEmailAddress:
      ## A Telegram Passport element containing the user's email address
      eaEmailAddress* {.jsonName: "email_address".}: string ## Email address

  StickerSet * = object
    ## Represents a sticker set
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string ## Identifier of the sticker set
    title* {.jsonName: "title".}: string ## Title of the sticker set
    name* {.jsonName: "name".}: string ## Name of the sticker set
    thumbnail* {.jsonName: "thumbnail".}: Option[PhotoSize] ## Sticker set thumbnail in WEBP format with width and height 100; may be null. The file can be downloaded only before the thumbnail is changed
    isInstalled* {.jsonName: "is_installed".}: bool ## True, if the sticker set has been installed by the current user
    isArchived* {.jsonName: "is_archived".}: bool ## True, if the sticker set has been archived. A sticker set can't be installed and archived simultaneously
    isOfficial* {.jsonName: "is_official".}: bool ## True, if the sticker set is official
    isAnimated* {.jsonName: "is_animated".}: bool ## True, is the stickers in the set are animated
    isMasks* {.jsonName: "is_masks".}: bool ## True, if the stickers in the set are masks
    isViewed* {.jsonName: "is_viewed".}: bool ## True for already viewed trending sticker sets
    stickers* {.jsonName: "stickers".}: seq[Sticker] ## List of stickers in this set
    emojis* {.jsonName: "emojis".}: seq[Emojis] ## A list of emoji corresponding to the stickers in the same order. The list is only for informational purposes, because a sticker is always sent with a fixed emoji from the corresponding Sticker object

  PublicMessageLink * = object
    ## Contains a public HTTPS link to a message in a supergroup or channel with a username
    kind {.jsonName: "@type".}: string
    link* {.jsonName: "link".}: string ## Message link
    html* {.jsonName: "html".}: string ## HTML-code for embedding the message

  Chats * = object
    ## Represents a list of chats
    kind {.jsonName: "@type".}: string
    chatIds* {.jsonName: "chat_ids".}: seq[int64] ## List of chat identifiers

  TextEntity * = object
    ## Represents a part of the text that needs to be formatted in some unusual way
    kind {.jsonName: "@type".}: string
    offset* {.jsonName: "offset".}: int32 ## Offset of the entity in UTF-16 code units
    length* {.jsonName: "length".}: int32 ## Length of the entity, in UTF-16 code units
    typ* {.jsonName: "type".}: TextEntityType ## Type of the entity

  ChatInviteLinkInfo * = object
    ## Contains information about a chat invite link
    kind {.jsonName: "@type".}: string
    chatId* {.jsonName: "chat_id".}: int64 ## Chat identifier of the invite link; 0 if the user is not a member of this chat
    typ* {.jsonName: "type".}: ChatType ## Contains information about the type of the chat
    title* {.jsonName: "title".}: string ## Title of the chat
    photo* {.jsonName: "photo".}: Option[ChatPhoto] ## Chat photo; may be null
    memberCount* {.jsonName: "member_count".}: int32 ## Number of members in the chat
    memberUserIds* {.jsonName: "member_user_ids".}: seq[int32] ## User identifiers of some chat members that may be known to the current user
    isPublic* {.jsonName: "is_public".}: bool ## True, if the chat is a public supergroup or channel, i.e. it has a username or it is a location-based supergroup

  LogStreamKind * {.pure.} = enum
    lsFile = "logStreamFile",
    lsEmpty = "logStreamEmpty",
    lsDefault = "logStreamDefault",

  LogStream * = object
    ## Describes a stream to which TDLib internal log is written
    case kind* {.jsonName: "@type".}: LogStreamKind
    of lsDefault:
      ## The log is written to stderr or an OS specific log
      discard
    of lsFile:
      ## The log is written to a file
      logstreamfiPath* {.jsonName: "path".}: string ## Path to the file to where the internal TDLib log will be written
      logstreamfiMaxFileSize* {.jsonName: "max_file_size".}: int64 ## The maximum size of the file to where the internal TDLib log is written before the file will be auto-rotated
    of lsEmpty:
      ## The log is written nowhere
      discard

  ChatPhoto * = object
    ## Describes the photo of a chat
    kind {.jsonName: "@type".}: string
    small* {.jsonName: "small".}: File ## A small (160x160) chat photo. The file can be downloaded only before the photo is changed
    big* {.jsonName: "big".}: File ## A big (640x640) chat photo. The file can be downloaded only before the photo is changed

  PageBlockVerticalAlignmentKind * {.pure.} = enum
    pbvaMiddle = "pageBlockVerticalAlignmentMiddle",
    pbvaBottom = "pageBlockVerticalAlignmentBottom",
    pbvaTop = "pageBlockVerticalAlignmentTop",

  PageBlockVerticalAlignment * = object
    ## Describes a Vertical alignment of a table cell content
    case kind* {.jsonName: "@type".}: PageBlockVerticalAlignmentKind
    of pbvaTop:
      ## The content should be top-aligned
      discard
    of pbvaMiddle:
      ## The content should be middle-aligned
      discard
    of pbvaBottom:
      ## The content should be bottom-aligned
      discard

  CallbackQueryAnswer * = object
    ## Contains a bot's answer to a callback query
    kind {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: string ## Text of the answer
    showAlert* {.jsonName: "show_alert".}: bool ## True, if an alert should be shown to the user instead of a toast notification
    url* {.jsonName: "url".}: string ## URL to be opened

  TMeUrlTypeKind * {.pure.} = enum
    tmutUser = "tMeUrlTypeUser",
    tmutSupergroup = "tMeUrlTypeSupergroup",
    tmutStickerSet = "tMeUrlTypeStickerSet",
    tmutChatInvite = "tMeUrlTypeChatInvite",

  TMeUrlType * = object
    ## Describes the type of a URL linking to an internal Telegram entity
    case kind* {.jsonName: "@type".}: TMeUrlTypeKind
    of tmutUser:
      ## A URL linking to a user
      tmeurltypeusUserId* {.jsonName: "user_id".}: int32 ## Identifier of the user
    of tmutSupergroup:
      ## A URL linking to a public supergroup or channel
      tmeurltypesupergroSupergroupId* {.jsonName: "supergroup_id".}: int64 ## Identifier of the supergroup or channel
    of tmutChatInvite:
      ## A chat invite link
      ciInfo* {.jsonName: "info".}: ChatInviteLinkInfo ## Chat invite link info
    of tmutStickerSet:
      ## A URL linking to a sticker set
      ssStickerSetId* {.jsonName: "sticker_set_id".}: string ## Identifier of the sticker set

  SendMessageOptions * = object
    ## Options to be used when a message is send
    kind {.jsonName: "@type".}: string
    disableNotification* {.jsonName: "disable_notification".}: bool ## Pass true to disable notification for the message. Must be false if the message is sent to a secret chat
    fromBackground* {.jsonName: "from_background".}: bool ## Pass true if the message is sent from the background
    schedulingState* {.jsonName: "scheduling_state".}: MessageSchedulingState ## Message scheduling state. Messages sent to a secret chat, live location messages and self-destructing messages can't be scheduled

  LogTags * = object
    ## Contains a list of available TDLib internal log tags
    kind {.jsonName: "@type".}: string
    tags* {.jsonName: "tags".}: seq[string] ## List of log tags

  GameHighScores * = object
    ## Contains a list of game high scores
    kind {.jsonName: "@type".}: string
    scores* {.jsonName: "scores".}: seq[GameHighScore] ## A list of game high scores

  KeyboardButtonTypeKind * {.pure.} = enum
    kbtRequestLocation = "keyboardButtonTypeRequestLocation",
    kbtRequestPhoneNumber = "keyboardButtonTypeRequestPhoneNumber",
    kbtRequestPoll = "keyboardButtonTypeRequestPoll",
    kbtText = "keyboardButtonTypeText",

  KeyboardButtonType * = object
    ## Describes a keyboard button type
    case kind* {.jsonName: "@type".}: KeyboardButtonTypeKind
    of kbtText:
      ## A simple button, with text that should be sent when the button is pressed
      discard
    of kbtRequestPhoneNumber:
      ## A button that sends the user's phone number when pressed; available only in private chats
      discard
    of kbtRequestLocation:
      ## A button that sends the user's location when pressed; available only in private chats
      discard
    of kbtRequestPoll:
      ## A button that allows the user to create and send a poll when pressed; available only in private chats
      rpForceRegular* {.jsonName: "force_regular".}: bool ## If true, only regular polls must be allowed to create
      rpForceQuiz* {.jsonName: "force_quiz".}: bool ## If true, only polls in quiz mode must be allowed to create

  InputIdentityDocument * = object
    ## An identity document to be saved to Telegram Passport
    kind {.jsonName: "@type".}: string
    number* {.jsonName: "number".}: string ## Document number; 1-24 characters
    expiryDate* {.jsonName: "expiry_date".}: Date ## Document expiry date, if available
    frontSide* {.jsonName: "front_side".}: InputFile ## Front side of the document
    reverseSide* {.jsonName: "reverse_side".}: InputFile ## Reverse side of the document; only for driver license and identity card
    selfie* {.jsonName: "selfie".}: InputFile ## Selfie with the document, if available
    translation* {.jsonName: "translation".}: seq[InputFile] ## List of files containing a certified English translation of the document

  TemporaryPasswordState * = object
    ## Returns information about the availability of a temporary password, which can be used for payments
    kind {.jsonName: "@type".}: string
    hasPassword* {.jsonName: "has_password".}: bool ## True, if a temporary password is available
    validFor* {.jsonName: "valid_for".}: int32 ## Time left before the temporary password expires, in seconds

  Animations * = object
    ## Represents a list of animations
    kind {.jsonName: "@type".}: string
    animations* {.jsonName: "animations".}: seq[Animation] ## List of animations

  OptionValueKind * {.pure.} = enum
    ovEmpty = "optionValueEmpty",
    ovInteger = "optionValueInteger",
    ovBoolean = "optionValueBoolean",
    ovString = "optionValueString",

  OptionValue * = object
    ## Represents the value of an option
    case kind* {.jsonName: "@type".}: OptionValueKind
    of ovBoolean:
      ## Represents a boolean option
      optionvaluebooleValue* {.jsonName: "value".}: bool ## The value of the option
    of ovEmpty:
      ## Represents an unknown option or an option which has a default value
      discard
    of ovInteger:
      ## Represents an integer option
      optionvalueintegValue* {.jsonName: "value".}: int32 ## The value of the option
    of ovString:
      ## Represents a string option
      optionvaluestriValue* {.jsonName: "value".}: string ## The value of the option

  InputPassportElementKind * {.pure.} = enum
    ipeUtilityBill = "inputPassportElementUtilityBill",
    ipeTemporaryRegistration = "inputPassportElementTemporaryRegistration",
    ipePersonalDetails = "inputPassportElementPersonalDetails",
    ipeDriverLicense = "inputPassportElementDriverLicense",
    ipePassport = "inputPassportElementPassport",
    ipeAddress = "inputPassportElementAddress",
    ipeInternalPassport = "inputPassportElementInternalPassport",
    ipeRentalAgreement = "inputPassportElementRentalAgreement",
    ipeIdentityCard = "inputPassportElementIdentityCard",
    ipePhoneNumber = "inputPassportElementPhoneNumber",
    ipeBankStatement = "inputPassportElementBankStatement",
    ipeEmailAddress = "inputPassportElementEmailAddress",
    ipePassportRegistration = "inputPassportElementPassportRegistration",

  InputPassportElement * = object
    ## Contains information about a Telegram Passport element to be saved
    case kind* {.jsonName: "@type".}: InputPassportElementKind
    of ipePersonalDetails:
      ## A Telegram Passport element to be saved containing the user's personal details
      pdPersonalDetails* {.jsonName: "personal_details".}: PersonalDetails ## Personal details of the user
    of ipePassport:
      ## A Telegram Passport element to be saved containing the user's passport
      inputpassportelementpasspoPassport* {.jsonName: "passport".}: InputIdentityDocument ## The passport to be saved
    of ipeDriverLicense:
      ## A Telegram Passport element to be saved containing the user's driver license
      dlDriverLicense* {.jsonName: "driver_license".}: InputIdentityDocument ## The driver license to be saved
    of ipeIdentityCard:
      ## A Telegram Passport element to be saved containing the user's identity card
      icIdentityCard* {.jsonName: "identity_card".}: InputIdentityDocument ## The identity card to be saved
    of ipeInternalPassport:
      ## A Telegram Passport element to be saved containing the user's internal passport
      ipInternalPassport* {.jsonName: "internal_passport".}: InputIdentityDocument ## The internal passport to be saved
    of ipeAddress:
      ## A Telegram Passport element to be saved containing the user's address
      inputpassportelementaddreAddress* {.jsonName: "address".}: Address ## The address to be saved
    of ipeUtilityBill:
      ## A Telegram Passport element to be saved containing the user's utility bill
      ubUtilityBill* {.jsonName: "utility_bill".}: InputPersonalDocument ## The utility bill to be saved
    of ipeBankStatement:
      ## A Telegram Passport element to be saved containing the user's bank statement
      bsBankStatement* {.jsonName: "bank_statement".}: InputPersonalDocument ## The bank statement to be saved
    of ipeRentalAgreement:
      ## A Telegram Passport element to be saved containing the user's rental agreement
      raRentalAgreement* {.jsonName: "rental_agreement".}: InputPersonalDocument ## The rental agreement to be saved
    of ipePassportRegistration:
      ## A Telegram Passport element to be saved containing the user's passport registration
      prPassportRegistration* {.jsonName: "passport_registration".}: InputPersonalDocument ## The passport registration page to be saved
    of ipeTemporaryRegistration:
      ## A Telegram Passport element to be saved containing the user's temporary registration
      trTemporaryRegistration* {.jsonName: "temporary_registration".}: InputPersonalDocument ## The temporary registration document to be saved
    of ipePhoneNumber:
      ## A Telegram Passport element to be saved containing the user's phone number
      pnPhoneNumber* {.jsonName: "phone_number".}: string ## The phone number to be saved
    of ipeEmailAddress:
      ## A Telegram Passport element to be saved containing the user's email address
      eaEmailAddress* {.jsonName: "email_address".}: string ## The email address to be saved

  BankCardActionOpenUrl * = object
    ## Describes an action associated with a bank card number
    kind {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: string ## Action text
    url* {.jsonName: "url".}: string ## The URL to be opened

  CallbackQueryPayloadKind * {.pure.} = enum
    cqpData = "callbackQueryPayloadData",
    cqpGame = "callbackQueryPayloadGame",

  CallbackQueryPayload * = object
    ## Represents a payload of a callback query
    case kind* {.jsonName: "@type".}: CallbackQueryPayloadKind
    of cqpData:
      ## The payload from a general callback button
      callbackquerypayloaddaData* {.jsonName: "data".}: string ## Data that was attached to the callback button
    of cqpGame:
      ## The payload from a game callback button
      callbackquerypayloadgaGameShortName* {.jsonName: "game_short_name".}: string ## A short name of the game that was attached to the callback button

  ShippingOption * = object
    ## One shipping option
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string ## Shipping option identifier
    title* {.jsonName: "title".}: string ## Option title
    priceParts* {.jsonName: "price_parts".}: seq[LabeledPricePart] ## A list of objects used to calculate the total shipping costs

  PageBlockCaption * = ref object
    ## Contains a caption of an instant view web page block, consisting of a text and a trailing credit
    kind {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: RichText ## Content of the caption
    credit* {.jsonName: "credit".}: RichText ## Block credit (like HTML tag <cite>)

  Sessions * = object
    ## Contains a list of sessions
    kind {.jsonName: "@type".}: string
    sessions* {.jsonName: "sessions".}: seq[Session] ## List of sessions

  Location * = object
    ## Describes a location on planet Earth
    kind {.jsonName: "@type".}: string
    latitude* {.jsonName: "latitude".}: float ## Latitude of the location in degrees; as defined by the sender
    longitude* {.jsonName: "longitude".}: float ## Longitude of the location, in degrees; as defined by the sender

  AuthenticationCodeTypeKind * {.pure.} = enum
    actFlashCall = "authenticationCodeTypeFlashCall",
    actTelegramMessage = "authenticationCodeTypeTelegramMessage",
    actSms = "authenticationCodeTypeSms",
    actCall = "authenticationCodeTypeCall",

  AuthenticationCodeType * = object
    ## Provides information about the method by which an authentication code is delivered to the user
    case kind* {.jsonName: "@type".}: AuthenticationCodeTypeKind
    of actTelegramMessage:
      ## An authentication code is delivered via a private Telegram message, which can be viewed in another client
      tmLength* {.jsonName: "length".}: int32 ## Length of the code
    of actSms:
      ## An authentication code is delivered via an SMS message to the specified phone number
      authenticationcodetypesLength* {.jsonName: "length".}: int32 ## Length of the code
    of actCall:
      ## An authentication code is delivered via a phone call to the specified phone number
      authenticationcodetypecaLength* {.jsonName: "length".}: int32 ## Length of the code
    of actFlashCall:
      ## An authentication code is delivered by an immediately cancelled call to the specified phone number. The number from which the call was made is the code
      fcPattern* {.jsonName: "pattern".}: string ## Pattern of the phone number from which the call will be made

  TextEntities * = object
    ## Contains a list of text entities
    kind {.jsonName: "@type".}: string
    entities* {.jsonName: "entities".}: seq[TextEntity] ## List of text entities

  Background * = object
    ## Describes a chat background
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string ## Unique background identifier
    isDefault* {.jsonName: "is_default".}: bool ## True, if this is one of default backgrounds
    isDark* {.jsonName: "is_dark".}: bool ## True, if the background is dark and is recommended to be used with dark theme
    name* {.jsonName: "name".}: string ## Unique background name
    document* {.jsonName: "document".}: Option[Document] ## Document with the background; may be null. Null only for filled backgrounds
    typ* {.jsonName: "type".}: BackgroundType ## Type of the background

  TestVectorStringObject * = object
    ## A simple object containing a vector of objects that hold a string; for testing only
    kind {.jsonName: "@type".}: string
    value* {.jsonName: "value".}: seq[TestString] ## Vector of objects

  ChatActionKind * {.pure.} = enum
    caRecordingVideoNote = "chatActionRecordingVideoNote",
    caRecordingVoiceNote = "chatActionRecordingVoiceNote",
    caChoosingLocation = "chatActionChoosingLocation",
    caUploadingVideoNote = "chatActionUploadingVideoNote",
    caRecordingVideo = "chatActionRecordingVideo",
    caCancel = "chatActionCancel",
    caUploadingDocument = "chatActionUploadingDocument",
    caTyping = "chatActionTyping",
    caChoosingContact = "chatActionChoosingContact",
    caStartPlayingGame = "chatActionStartPlayingGame",
    caUploadingVideo = "chatActionUploadingVideo",
    caUploadingVoiceNote = "chatActionUploadingVoiceNote",
    caUploadingPhoto = "chatActionUploadingPhoto",

  ChatAction * = object
    ## Describes the different types of activity in a chat
    case kind* {.jsonName: "@type".}: ChatActionKind
    of caTyping:
      ## The user is typing a message
      discard
    of caRecordingVideo:
      ## The user is recording a video
      discard
    of caUploadingVideo:
      ## The user is uploading a video
      uvProgress* {.jsonName: "progress".}: int32 ## Upload progress, as a percentage
    of caRecordingVoiceNote:
      ## The user is recording a voice note
      discard
    of caUploadingVoiceNote:
      ## The user is uploading a voice note
      uvnProgress* {.jsonName: "progress".}: int32 ## Upload progress, as a percentage
    of caUploadingPhoto:
      ## The user is uploading a photo
      upProgress* {.jsonName: "progress".}: int32 ## Upload progress, as a percentage
    of caUploadingDocument:
      ## The user is uploading a document
      udProgress* {.jsonName: "progress".}: int32 ## Upload progress, as a percentage
    of caChoosingLocation:
      ## The user is picking a location or venue to send
      discard
    of caChoosingContact:
      ## The user is picking a contact to send
      discard
    of caStartPlayingGame:
      ## The user has started to play a game
      discard
    of caRecordingVideoNote:
      ## The user is recording a video note
      discard
    of caUploadingVideoNote:
      ## The user is uploading a video note
      uvnoteProgress* {.jsonName: "progress".}: int32 ## Upload progress, as a percentage
    of caCancel:
      ## The user has cancelled the previous action
      discard

  SupergroupFullInfo * = object
    ## Contains full information about a supergroup or channel
    kind {.jsonName: "@type".}: string
    description* {.jsonName: "description".}: string ## Contains full information about a supergroup or channel
    memberCount* {.jsonName: "member_count".}: int32 ## Number of members in the supergroup or channel; 0 if unknown
    administratorCount* {.jsonName: "administrator_count".}: int32 ## Number of privileged users in the supergroup or channel; 0 if unknown
    restrictedCount* {.jsonName: "restricted_count".}: int32 ## Number of restricted users in the supergroup; 0 if unknown
    bannedCount* {.jsonName: "banned_count".}: int32 ## Number of users banned from chat; 0 if unknown
    linkedChatId* {.jsonName: "linked_chat_id".}: int64 ## Chat identifier of a discussion group for the channel, or a channel, for which the supergroup is the designated discussion group; 0 if none or unknown
    slowModeDelay* {.jsonName: "slow_mode_delay".}: int32 ## Delay between consecutive sent messages for non-administrator supergroup members, in seconds
    slowModeDelayExpiresIn* {.jsonName: "slow_mode_delay_expires_in".}: float ## Time left before next message can be sent in the supergroup, in seconds. An updateSupergroupFullInfo update is not triggered when value of this field changes, but both new and old values are non-zero
    canGetMembers* {.jsonName: "can_get_members".}: bool ## True, if members of the chat can be retrieved
    canSetUsername* {.jsonName: "can_set_username".}: bool ## True, if the chat username can be changed
    canSetStickerSet* {.jsonName: "can_set_sticker_set".}: bool ## True, if the supergroup sticker set can be changed
    canSetLocation* {.jsonName: "can_set_location".}: bool ## True, if the supergroup location can be changed
    canViewStatistics* {.jsonName: "can_view_statistics".}: bool ## True, if the channel statistics is available
    isAllHistoryAvailable* {.jsonName: "is_all_history_available".}: bool ## True, if new chat members will have access to old messages. In public or discussion groups and both public and private channels, old messages are always available, so this option affects only private supergroups without a linked chat. The value of this field is only available for chat administrators
    stickerSetId* {.jsonName: "sticker_set_id".}: string ## Identifier of the supergroup sticker set; 0 if none
    location* {.jsonName: "location".}: Option[ChatLocation] ## Location to which the supergroup is connected; may be null
    inviteLink* {.jsonName: "invite_link".}: string ## Invite link for this chat
    upgradedFromBasicGroupId* {.jsonName: "upgraded_from_basic_group_id".}: int32 ## Identifier of the basic group from which supergroup was upgraded; 0 if none
    upgradedFromMaxMessageId* {.jsonName: "upgraded_from_max_message_id".}: int64 ## Identifier of the last message in the basic group from which supergroup was upgraded; 0 if none

  StorageStatisticsByChat * = object
    ## Contains the storage usage statistics for a specific chat
    kind {.jsonName: "@type".}: string
    chatId* {.jsonName: "chat_id".}: int64 ## Chat identifier; 0 if none
    size* {.jsonName: "size".}: int64 ## Total size of the files in the chat
    count* {.jsonName: "count".}: int32 ## Total number of files in the chat
    byFileType* {.jsonName: "by_file_type".}: seq[StorageStatisticsByFileType] ## Statistics split by file types

  SavedCredentials * = object
    ## Contains information about saved card credentials
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string ## Unique identifier of the saved credentials
    title* {.jsonName: "title".}: string ## Title of the saved credentials

  PhotoSize * = object
    ## Photo description
    kind {.jsonName: "@type".}: string
    typ* {.jsonName: "type".}: string ## Thumbnail type (see https://core.telegram.org/constructor/photoSize)
    photo* {.jsonName: "photo".}: File ## Information about the photo file
    width* {.jsonName: "width".}: int32 ## Photo width
    height* {.jsonName: "height".}: int32 ## Photo height

  StorageStatistics * = object
    ## Contains the exact storage usage statistics split by chats and file type
    kind {.jsonName: "@type".}: string
    size* {.jsonName: "size".}: int64 ## Total size of files
    count* {.jsonName: "count".}: int32 ## Total number of files
    byChat* {.jsonName: "by_chat".}: seq[StorageStatisticsByChat] ## Statistics split by chats

  RemoteFile * = object
    ## Represents a remote file
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string ## Remote file identifier; may be empty. Can be used by the current user across application restarts or even from other devices. Uniquely identifies a file, but a file can have a lot of different valid identifiers.
    uniqueId* {.jsonName: "unique_id".}: string ## Unique file identifier; may be empty if unknown. The unique file identifier which is the same for the same file even for different users and is persistent over time
    isUploadingActive* {.jsonName: "is_uploading_active".}: bool ## True, if the file is currently being uploaded (or a remote copy is being generated by some other means)
    isUploadingCompleted* {.jsonName: "is_uploading_completed".}: bool ## True, if a remote copy is fully available
    uploadedSize* {.jsonName: "uploaded_size".}: int32 ## Size of the remote available part of the file; 0 if unknown

  MaskPointKind * {.pure.} = enum
    mpForehead = "maskPointForehead",
    mpEyes = "maskPointEyes",
    mpChin = "maskPointChin",
    mpMouth = "maskPointMouth",

  MaskPoint * = object
    ## Part of the face, relative to which a mask should be placed
    case kind* {.jsonName: "@type".}: MaskPointKind
    of mpForehead:
      ## A mask should be placed relatively to the forehead
      discard
    of mpEyes:
      ## A mask should be placed relatively to the eyes
      discard
    of mpMouth:
      ## A mask should be placed relatively to the mouth
      discard
    of mpChin:
      ## A mask should be placed relatively to the chin
      discard

  WebPageInstantView * = object
    ## Describes an instant view page for a web page
    kind {.jsonName: "@type".}: string
    pageBlocks* {.jsonName: "page_blocks".}: seq[PageBlock] ## Content of the web page
    viewCount* {.jsonName: "view_count".}: int32 ## Number of the instant view views; 0 if unknown
    version* {.jsonName: "version".}: int32 ## Version of the instant view, currently can be 1 or 2
    isRtl* {.jsonName: "is_rtl".}: bool ## True, if the instant view must be shown from right to left
    isFull* {.jsonName: "is_full".}: bool ## True, if the instant view contains the full page. A network request might be needed to get the full web page instant view

  UserPrivacySettingRules * = object
    ## A list of privacy rules. Rules are matched in the specified order. The first matched rule defines the privacy setting for a given user. If no rule matches, the action is not allowed
    kind {.jsonName: "@type".}: string
    rules* {.jsonName: "rules".}: seq[UserPrivacySettingRule] ## A list of rules

  ConnectedWebsites * = object
    ## Contains a list of websites the current user is logged in with Telegram
    kind {.jsonName: "@type".}: string
    websites* {.jsonName: "websites".}: seq[ConnectedWebsite] ## List of connected websites

  MessageLinkInfo * = object
    ## Contains information about a link to a message in a chat
    kind {.jsonName: "@type".}: string
    isPublic* {.jsonName: "is_public".}: bool ## True, if the link is a public link for a message in a chat
    chatId* {.jsonName: "chat_id".}: int64 ## If found, identifier of the chat to which the message belongs, 0 otherwise
    message* {.jsonName: "message".}: Option[Message] ## If found, the linked message; may be null
    forAlbum* {.jsonName: "for_album".}: bool ## True, if the whole media album to which the message belongs is linked

  AccountTtl * = object
    ## Contains information about the period of inactivity after which the current user's account will automatically be deleted
    kind {.jsonName: "@type".}: string
    days* {.jsonName: "days".}: int32 ## Number of days of inactivity before the account will be flagged for deletion; should range from 30-366 days

  Count * = object
    ## Contains a counter
    kind {.jsonName: "@type".}: string
    count* {.jsonName: "count".}: int32 ## Count

  StatisticsGraphKind * {.pure.} = enum
    sgAsync = "statisticsGraphAsync",
    sgData = "statisticsGraphData",
    sgError = "statisticsGraphError",

  StatisticsGraph * = object
    ## Describes a statistics graph
    case kind* {.jsonName: "@type".}: StatisticsGraphKind
    of sgData:
      ## A graph data
      statisticsgraphdaJsonData* {.jsonName: "json_data".}: string ## Graph data in JSON format
      statisticsgraphdaZoomToken* {.jsonName: "zoom_token".}: string ## If non-empty, a token which can be used to receive a zoomed in graph
    of sgAsync:
      ## The graph data to be asynchronously loaded through getChatStatisticsGraph
      statisticsgraphasyToken* {.jsonName: "token".}: string ## The token to use for data loading
    of sgError:
      ## An error message to be shown to the user instead of the graph
      statisticsgrapherrErrorMessage* {.jsonName: "error_message".}: string ## The error message

  PaymentsProviderStripe * = object
    ## Stripe payment provider
    kind {.jsonName: "@type".}: string
    publishableKey* {.jsonName: "publishable_key".}: string ## Stripe API publishable key
    needCountry* {.jsonName: "need_country".}: bool ## True, if the user country must be provided
    needPostalCode* {.jsonName: "need_postal_code".}: bool ## True, if the user ZIP/postal code must be provided
    needCardholderName* {.jsonName: "need_cardholder_name".}: bool ## True, if the cardholder name must be provided

  StatisticsValue * = object
    ## A statistics value
    kind {.jsonName: "@type".}: string
    value* {.jsonName: "value".}: float ## The value
    previousValue* {.jsonName: "previous_value".}: float ## The value for the previous day
    growthRatePercentage* {.jsonName: "growth_rate_percentage".}: float ## The growth rate of the value, as a percentage

  ChatEvents * = object
    ## Contains a list of chat events
    kind {.jsonName: "@type".}: string
    events* {.jsonName: "events".}: seq[ChatEvent] ## List of events

  GameHighScore * = object
    ## Contains one row of the game high score table
    kind {.jsonName: "@type".}: string
    position* {.jsonName: "position".}: int32 ## Position in the high score table
    userId* {.jsonName: "user_id".}: int32 ## User identifier
    score* {.jsonName: "score".}: int32 ## User score

  NotificationGroup * = object
    ## Describes a group of notifications
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32 ## Unique persistent auto-incremented from 1 identifier of the notification group
    typ* {.jsonName: "type".}: NotificationGroupType ## Type of the group
    chatId* {.jsonName: "chat_id".}: int64 ## Identifier of a chat to which all notifications in the group belong
    totalCount* {.jsonName: "total_count".}: int32 ## Total number of active notifications in the group
    notifications* {.jsonName: "notifications".}: seq[Notification] ## The list of active notifications

  ProfilePhoto * = object
    ## Describes a user profile photo
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string ## Photo identifier; 0 for an empty photo. Can be used to find a photo in a list of userProfilePhotos
    small* {.jsonName: "small".}: File ## A small (160x160) user profile photo. The file can be downloaded only before the photo is changed
    big* {.jsonName: "big".}: File ## A big (640x640) user profile photo. The file can be downloaded only before the photo is changed

  File * = object
    ## Represents a file
    kind {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32 ## Unique file identifier
    size* {.jsonName: "size".}: int32 ## File size; 0 if unknown
    expectedSize* {.jsonName: "expected_size".}: int32 ## Expected file size in case the exact file size is unknown, but an approximate size is known. Can be used to show download/upload progress
    local* {.jsonName: "local".}: LocalFile ## Information about the local copy of the file
    remote* {.jsonName: "remote".}: RemoteFile ## Information about the remote copy of the file

  UserProfilePhotos * = object
    ## Contains part of the list of user photos
    kind {.jsonName: "@type".}: string
    totalCount* {.jsonName: "total_count".}: int32 ## Total number of user profile photos
    photos* {.jsonName: "photos".}: seq[UserProfilePhoto] ## A list of photos

  FilePart * = object
    ## Contains a part of a file
    kind {.jsonName: "@type".}: string
    data* {.jsonName: "data".}: string ## File bytes

  MessageSendingStateKind * {.pure.} = enum
    mssFailed = "messageSendingStateFailed",
    mssPending = "messageSendingStatePending",

  MessageSendingState * = object
    ## Contains information about the sending state of the message
    case kind* {.jsonName: "@type".}: MessageSendingStateKind
    of mssPending:
      ## The message is being sent now, but has not yet been delivered to the server
      discard
    of mssFailed:
      ## The message failed to be sent
      messagesendingstatefailErrorCode* {.jsonName: "error_code".}: int32 ## An error code; 0 if unknown
      messagesendingstatefailErrorMessage* {.jsonName: "error_message".}: string ## Error message
      messagesendingstatefailCanRetry* {.jsonName: "can_retry".}: bool ## True, if the message can be re-sent
      messagesendingstatefailRetryAfter* {.jsonName: "retry_after".}: float ## Time left before the message can be re-sent, in seconds. No update is sent when this field changes

  InlineQueryResultKind * {.pure.} = enum
    iqrDocument = "inlineQueryResultDocument",
    iqrSticker = "inlineQueryResultSticker",
    iqrGame = "inlineQueryResultGame",
    iqrPhoto = "inlineQueryResultPhoto",
    iqrVoiceNote = "inlineQueryResultVoiceNote",
    iqrVideo = "inlineQueryResultVideo",
    iqrArticle = "inlineQueryResultArticle",
    iqrVenue = "inlineQueryResultVenue",
    iqrLocation = "inlineQueryResultLocation",
    iqrAudio = "inlineQueryResultAudio",
    iqrContact = "inlineQueryResultContact",
    iqrAnimation = "inlineQueryResultAnimation",

  InlineQueryResult * = object
    ## Represents a single result of an inline query
    case kind* {.jsonName: "@type".}: InlineQueryResultKind
    of iqrArticle:
      ## Represents a link to an article or web page
      inlinequeryresultarticId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inlinequeryresultarticUrl* {.jsonName: "url".}: string ## URL of the result, if it exists
      inlinequeryresultarticHideUrl* {.jsonName: "hide_url".}: bool ## True, if the URL must be not shown
      inlinequeryresultarticTitle* {.jsonName: "title".}: string ## Title of the result
      inlinequeryresultarticDescription* {.jsonName: "description".}: string ## Represents a link to an article or web page
      inlinequeryresultarticThumbnail* {.jsonName: "thumbnail".}: Option[PhotoSize] ## Result thumbnail; may be null
    of iqrContact:
      ## Represents a user contact
      inlinequeryresultcontaId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inlinequeryresultcontaContact* {.jsonName: "contact".}: Contact ## A user contact
      inlinequeryresultcontaThumbnail* {.jsonName: "thumbnail".}: Option[PhotoSize] ## Result thumbnail; may be null
    of iqrLocation:
      ## Represents a point on the map
      inlinequeryresultlocatiId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inlinequeryresultlocatiLocation* {.jsonName: "location".}: Location ## Location result
      inlinequeryresultlocatiTitle* {.jsonName: "title".}: string ## Title of the result
      inlinequeryresultlocatiThumbnail* {.jsonName: "thumbnail".}: Option[PhotoSize] ## Result thumbnail; may be null
    of iqrVenue:
      ## Represents information about a venue
      inlinequeryresultvenId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inlinequeryresultvenVenue* {.jsonName: "venue".}: Venue ## Venue result
      inlinequeryresultvenThumbnail* {.jsonName: "thumbnail".}: Option[PhotoSize] ## Result thumbnail; may be null
    of iqrGame:
      ## Represents information about a game
      inlinequeryresultgaId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inlinequeryresultgaGame* {.jsonName: "game".}: Game ## Game result
    of iqrAnimation:
      ## Represents an animation file
      inlinequeryresultanimatiId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inlinequeryresultanimatiAnimation* {.jsonName: "animation".}: Animation ## Animation file
      inlinequeryresultanimatiTitle* {.jsonName: "title".}: string ## Animation title
    of iqrAudio:
      ## Represents an audio file
      inlinequeryresultaudId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inlinequeryresultaudAudio* {.jsonName: "audio".}: Audio ## Audio file
    of iqrDocument:
      ## Represents a document
      inlinequeryresultdocumeId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inlinequeryresultdocumeDocument* {.jsonName: "document".}: Document ## Document
      inlinequeryresultdocumeTitle* {.jsonName: "title".}: string ## Document title
      inlinequeryresultdocumeDescription* {.jsonName: "description".}: string ## Represents a document
    of iqrPhoto:
      ## Represents a photo
      inlinequeryresultphoId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inlinequeryresultphoPhoto* {.jsonName: "photo".}: Photo ## Photo
      inlinequeryresultphoTitle* {.jsonName: "title".}: string ## Title of the result, if known
      inlinequeryresultphoDescription* {.jsonName: "description".}: string ## Represents a photo
    of iqrSticker:
      ## Represents a sticker
      inlinequeryresultstickId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inlinequeryresultstickSticker* {.jsonName: "sticker".}: Sticker ## Sticker
    of iqrVideo:
      ## Represents a video
      inlinequeryresultvidId* {.jsonName: "id".}: string ## Unique identifier of the query result
      inlinequeryresultvidVideo* {.jsonName: "video".}: Video ## Video
      inlinequeryresultvidTitle* {.jsonName: "title".}: string ## Title of the video
      inlinequeryresultvidDescription* {.jsonName: "description".}: string ## Represents a video
    of iqrVoiceNote:
      ## Represents a voice note
      vnId* {.jsonName: "id".}: string ## Unique identifier of the query result
      vnVoiceNote* {.jsonName: "voice_note".}: VoiceNote ## Voice note
      vnTitle* {.jsonName: "title".}: string ## Title of the voice note

  TextParseModeKind * {.pure.} = enum
    tpmHTML = "textParseModeHTML",
    tpmMarkdown = "textParseModeMarkdown",

  TextParseMode * = object
    ## Describes the way the text should be parsed for TextEntities
    case kind* {.jsonName: "@type".}: TextParseModeKind
    of tpmMarkdown:
      ## The text uses Markdown-style formatting
      textparsemodemarkdoVersion* {.jsonName: "version".}: int32 ## Version of the parser: 0 or 1 - Telegram Bot API "Markdown" parse mode, 2 - Telegram Bot API "MarkdownV2" parse mode
    of tpmHTML:
      ## The text uses HTML-style formatting. The same as Telegram Bot API "HTML" parse mode
      discard

  ChatStatistics * = object
    ## A detailed statistics about a chat
    kind {.jsonName: "@type".}: string
    period* {.jsonName: "period".}: DateRange ## A period to which the statistics applies
    memberCount* {.jsonName: "member_count".}: StatisticsValue ## Number of members in the chat
    meanViewCount* {.jsonName: "mean_view_count".}: StatisticsValue ## Mean number of times the recently sent messages was viewed
    meanShareCount* {.jsonName: "mean_share_count".}: StatisticsValue ## Mean number of times the recently sent messages was shared
    enabledNotificationsPercentage* {.jsonName: "enabled_notifications_percentage".}: float ## A percentage of users with enabled notifications for the chat
    memberCountGraph* {.jsonName: "member_count_graph".}: StatisticsGraph ## A graph containing number of members in the chat
    joinGraph* {.jsonName: "join_graph".}: StatisticsGraph ## A graph containing number of members joined and left the chat
    muteGraph* {.jsonName: "mute_graph".}: StatisticsGraph ## A graph containing number of members muted and unmuted the chat
    viewCountByHourGraph* {.jsonName: "view_count_by_hour_graph".}: StatisticsGraph ## A graph containing number of message views in a given hour in the last two weeks
    viewCountBySourceGraph* {.jsonName: "view_count_by_source_graph".}: StatisticsGraph ## A graph containing number of message views per source
    joinBySourceGraph* {.jsonName: "join_by_source_graph".}: StatisticsGraph ## A graph containing number of new member joins per source
    languageGraph* {.jsonName: "language_graph".}: StatisticsGraph ## A graph containing number of users viewed chat messages per language
    messageInteractionGraph* {.jsonName: "message_interaction_graph".}: StatisticsGraph ## A graph containing number of chat message views and shares
    instantViewInteractionGraph* {.jsonName: "instant_view_interaction_graph".}: StatisticsGraph ## A graph containing number of views of associated with the chat instant views
    recentMessageInteractions* {.jsonName: "recent_message_interactions".}: seq[ChatStatisticsMessageInteractionCounters] ## Detailed statistics about number of views and shares of recently sent messages

  PublicChatTypeKind * {.pure.} = enum
    pctIsLocationBased = "publicChatTypeIsLocationBased",
    pctHasUsername = "publicChatTypeHasUsername",

  PublicChatType * = object
    ## Describes a type of public chats
    case kind* {.jsonName: "@type".}: PublicChatTypeKind
    of pctHasUsername:
      ## The chat is public, because it has username
      discard
    of pctIsLocationBased:
      ## The chat is public, because it is a location-based supergroup
      discard

  ChatActionBarKind * {.pure.} = enum
    cabReportSpam = "chatActionBarReportSpam",
    cabAddContact = "chatActionBarAddContact",
    cabReportUnrelatedLocation = "chatActionBarReportUnrelatedLocation",
    cabSharePhoneNumber = "chatActionBarSharePhoneNumber",
    cabReportAddBlock = "chatActionBarReportAddBlock",

  ChatActionBar * = object
    ## Describes actions which should be possible to do through a chat action bar
    case kind* {.jsonName: "@type".}: ChatActionBarKind
    of cabReportSpam:
      ## The chat can be reported as spam using the method reportChat with the reason chatReportReasonSpam
      discard
    of cabReportUnrelatedLocation:
      ## The chat is a location-based supergroup, which can be reported as having unrelated location using the method reportChat with the reason chatReportReasonUnrelatedLocation
      discard
    of cabReportAddBlock:
      ## The chat is a private or secret chat, which can be reported using the method reportChat, or the other user can be added to the contact list using the method addContact, or the other user can be blocked using the method blockUser
      discard
    of cabAddContact:
      ## The chat is a private or secret chat and the other user can be added to the contact list using the method addContact
      discard
    of cabSharePhoneNumber:
      ## The chat is a private or secret chat with a mutual contact and the user's phone number can be shared with the other user using the method sharePhoneNumber
      discard

  Document * = object
    ## Describes a document of any type
    kind {.jsonName: "@type".}: string
    fileName* {.jsonName: "file_name".}: string ## Original name of the file; as defined by the sender
    mimeType* {.jsonName: "mime_type".}: string ## MIME type of the file; as defined by the sender
    minithumbnail* {.jsonName: "minithumbnail".}: Option[Minithumbnail] ## Document minithumbnail; may be null
    thumbnail* {.jsonName: "thumbnail".}: Option[PhotoSize] ## Document thumbnail in JPEG or PNG format (PNG will be used only for background patterns); as defined by the sender; may be null
    document* {.jsonName: "document".}: File ## File containing the document

  ScopeNotificationSettings * = object
    ## Contains information about notification settings for several chats
    kind {.jsonName: "@type".}: string
    muteFor* {.jsonName: "mute_for".}: int32 ## Time left before notifications will be unmuted, in seconds
    sound* {.jsonName: "sound".}: string ## The name of an audio file to be used for notification sounds; only applies to iOS applications
    showPreview* {.jsonName: "show_preview".}: bool ## True, if message content should be displayed in notifications
    disablePinnedMessageNotifications* {.jsonName: "disable_pinned_message_notifications".}: bool ## True, if notifications for incoming pinned messages will be created as for an ordinary unread message
    disableMentionNotifications* {.jsonName: "disable_mention_notifications".}: bool ## True, if notifications for messages with mentions will be created as for an ordinary unread message

  InputCredentialsKind * {.pure.} = enum
    icAndroidPay = "inputCredentialsAndroidPay",
    icApplePay = "inputCredentialsApplePay",
    icNew = "inputCredentialsNew",
    icSaved = "inputCredentialsSaved",

  InputCredentials * = object
    ## Contains information about the payment method chosen by the user
    case kind* {.jsonName: "@type".}: InputCredentialsKind
    of icSaved:
      ## Applies if a user chooses some previously saved payment credentials. To use their previously saved credentials, the user must have a valid temporary password
      inputcredentialssavSavedCredentialsId* {.jsonName: "saved_credentials_id".}: string ## Identifier of the saved credentials
    of icNew:
      ## Applies if a user enters new credentials on a payment provider website
      inputcredentialsnData* {.jsonName: "data".}: string ## Contains JSON-encoded data with a credential identifier from the payment provider
      inputcredentialsnAllowSave* {.jsonName: "allow_save".}: bool ## True, if the credential identifier can be saved on the server side
    of icAndroidPay:
      ## Applies if a user enters new credentials using Android Pay
      apData* {.jsonName: "data".}: string ## JSON-encoded data with the credential identifier
    of icApplePay:
      ## Applies if a user enters new credentials using Apple Pay
      apayData* {.jsonName: "data".}: string ## JSON-encoded data with the credential identifier

  Audio * = object
    ## Describes an audio file. Audio is usually in MP3 or M4A format
    kind {.jsonName: "@type".}: string
    duration* {.jsonName: "duration".}: int32 ## Duration of the audio, in seconds; as defined by the sender
    title* {.jsonName: "title".}: string ## Title of the audio; as defined by the sender
    performer* {.jsonName: "performer".}: string ## Performer of the audio; as defined by the sender
    fileName* {.jsonName: "file_name".}: string ## Original name of the file; as defined by the sender
    mimeType* {.jsonName: "mime_type".}: string ## The MIME type of the file; as defined by the sender
    albumCoverMinithumbnail* {.jsonName: "album_cover_minithumbnail".}: Option[Minithumbnail] ## The minithumbnail of the album cover; may be null
    albumCoverThumbnail* {.jsonName: "album_cover_thumbnail".}: Option[PhotoSize] ## The thumbnail of the album cover; as defined by the sender. The full size thumbnail should be extracted from the downloaded file; may be null
    audio* {.jsonName: "audio".}: File ## File containing the audio

  PassportElementsWithErrors * = object
    ## Contains information about a Telegram Passport elements and corresponding errors
    kind {.jsonName: "@type".}: string
    elements* {.jsonName: "elements".}: seq[PassportElement] ## Telegram Passport elements
    errors* {.jsonName: "errors".}: seq[PassportElementError] ## Errors in the elements that are already available

  VideoNote * = object
    ## Describes a video note. The video must be equal in width and height, cropped to a circle, and stored in MPEG4 format
    kind {.jsonName: "@type".}: string
    duration* {.jsonName: "duration".}: int32 ## Duration of the video, in seconds; as defined by the sender
    length* {.jsonName: "length".}: int32 ## Video width and height; as defined by the sender
    minithumbnail* {.jsonName: "minithumbnail".}: Option[Minithumbnail] ## Video minithumbnail; may be null
    thumbnail* {.jsonName: "thumbnail".}: Option[PhotoSize] ## Video thumbnail; as defined by the sender; may be null
    video* {.jsonName: "video".}: File ## File containing the video

  TMeUrl * = object
    ## Represents a URL linking to an internal Telegram entity
    kind {.jsonName: "@type".}: string
    url* {.jsonName: "url".}: string ## URL
    typ* {.jsonName: "type".}: TMeUrlType ## Type of the URL

  Seconds * = object
    ## Contains a value representing a number of seconds
    kind {.jsonName: "@type".}: string
    seconds* {.jsonName: "seconds".}: float ## Number of seconds

  CallProblemKind * {.pure.} = enum
    cpSilentLocal = "callProblemSilentLocal",
    cpDropped = "callProblemDropped",
    cpSilentRemote = "callProblemSilentRemote",
    cpDistortedSpeech = "callProblemDistortedSpeech",
    cpEcho = "callProblemEcho",
    cpNoise = "callProblemNoise",
    cpInterruptions = "callProblemInterruptions",

  CallProblem * = object
    ## Describes the exact type of a problem with a call
    case kind* {.jsonName: "@type".}: CallProblemKind
    of cpEcho:
      ## The user heard their own voice
      discard
    of cpNoise:
      ## The user heard background noise
      discard
    of cpInterruptions:
      ## The other side kept disappearing
      discard
    of cpDistortedSpeech:
      ## The speech was distorted
      discard
    of cpSilentLocal:
      ## The user couldn't hear the other side
      discard
    of cpSilentRemote:
      ## The other side couldn't hear the user
      discard
    of cpDropped:
      ## The call ended unexpectedly
      discard

  DeepLinkInfo * = object
    ## Contains information about a tg:// deep link
    kind {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: FormattedText ## Text to be shown to the user
    needUpdateApplication* {.jsonName: "need_update_application".}: bool ## True, if user should be asked to update the application

  UserStatusKind * {.pure.} = enum
    usRecently = "userStatusRecently",
    usOffline = "userStatusOffline",
    usEmpty = "userStatusEmpty",
    usLastWeek = "userStatusLastWeek",
    usOnline = "userStatusOnline",
    usLastMonth = "userStatusLastMonth",

  UserStatus * = object
    ## Describes the last time the user was online
    case kind* {.jsonName: "@type".}: UserStatusKind
    of usEmpty:
      ## The user status was never changed
      discard
    of usOnline:
      ## The user is online
      userstatusonliExpires* {.jsonName: "expires".}: int32 ## Point in time (Unix timestamp) when the user's online status will expire
    of usOffline:
      ## The user is offline
      userstatusoffliWasOnline* {.jsonName: "was_online".}: int32 ## Point in time (Unix timestamp) when the user was last online
    of usRecently:
      ## The user was online recently
      discard
    of usLastWeek:
      ## The user is offline, but was online last week
      discard
    of usLastMonth:
      ## The user is offline, but was online last month
      discard

  SupergroupMembersFilterKind * {.pure.} = enum
    smfAdministrators = "supergroupMembersFilterAdministrators",
    smfBots = "supergroupMembersFilterBots",
    smfContacts = "supergroupMembersFilterContacts",
    smfBanned = "supergroupMembersFilterBanned",
    smfSearch = "supergroupMembersFilterSearch",
    smfRestricted = "supergroupMembersFilterRestricted",
    smfRecent = "supergroupMembersFilterRecent",

  SupergroupMembersFilter * = object
    ## Specifies the kind of chat members to return in getSupergroupMembers
    case kind* {.jsonName: "@type".}: SupergroupMembersFilterKind
    of smfRecent:
      ## Returns recently active users in reverse chronological order
      discard
    of smfContacts:
      ## Returns contacts of the user, which are members of the supergroup or channel
      supergroupmembersfiltercontacQuery* {.jsonName: "query".}: string ## Query to search for
    of smfAdministrators:
      ## Returns the owner and administrators
      discard
    of smfSearch:
      ## Used to search for supergroup or channel members via a (string) query
      supergroupmembersfiltersearQuery* {.jsonName: "query".}: string ## Query to search for
    of smfRestricted:
      ## Returns restricted supergroup members; can be used only by administrators
      supergroupmembersfilterrestrictQuery* {.jsonName: "query".}: string ## Query to search for
    of smfBanned:
      ## Returns users banned from the supergroup or channel; can be used only by administrators
      supergroupmembersfilterbannQuery* {.jsonName: "query".}: string ## Query to search for
    of smfBots:
      ## Returns bot members of the supergroup or channel
      discard

  UserTypeKind * {.pure.} = enum
    utRegular = "userTypeRegular",
    utUnknown = "userTypeUnknown",
    utBot = "userTypeBot",
    utDeleted = "userTypeDeleted",

  UserType * = object
    ## Represents the type of a user. The following types are possible: regular users, deleted users and bots
    case kind* {.jsonName: "@type".}: UserTypeKind
    of utRegular:
      ## A regular user
      discard
    of utDeleted:
      ## A deleted user or deleted bot. No information on the user besides the user identifier is available. It is not possible to perform any active actions on this type of user
      discard
    of utBot:
      ## A bot (see https://core.telegram.org/bots)
      usertypebCanJoinGroups* {.jsonName: "can_join_groups".}: bool ## True, if the bot can be invited to basic group and supergroup chats
      usertypebCanReadAllGroupMessages* {.jsonName: "can_read_all_group_messages".}: bool ## True, if the bot can read all messages in basic group or supergroup chats and not just those addressed to the bot. In private and channel chats a bot can always read all messages
      usertypebIsInline* {.jsonName: "is_inline".}: bool ## True, if the bot supports inline queries
      usertypebInlineQueryPlaceholder* {.jsonName: "inline_query_placeholder".}: string ## Placeholder for inline queries (displayed on the client input field)
      usertypebNeedLocation* {.jsonName: "need_location".}: bool ## True, if the location of the user should be sent with every inline query to this bot
    of utUnknown:
      ## No information on the user besides the user identifier is available, yet this user has not been deleted. This object is extremely rare and must be handled like a deleted user. It is not possible to perform any actions on users of this type
      discard

  OrderInfo * = object
    ## Order information
    kind {.jsonName: "@type".}: string
    name* {.jsonName: "name".}: string ## Name of the user
    phoneNumber* {.jsonName: "phone_number".}: string ## Phone number of the user
    emailAddress* {.jsonName: "email_address".}: string ## Email address of the user
    shippingAddress* {.jsonName: "shipping_address".}: Option[Address] ## Shipping address for this order; may be null

  ChatTypeKind * {.pure.} = enum
    ctBasicGroup = "chatTypeBasicGroup",
    ctSupergroup = "chatTypeSupergroup",
    ctSecret = "chatTypeSecret",
    ctPrivate = "chatTypePrivate",

  ChatType * = object
    ## Describes the type of a chat
    case kind* {.jsonName: "@type".}: ChatTypeKind
    of ctPrivate:
      ## An ordinary chat with a user
      chattypeprivaUserId* {.jsonName: "user_id".}: int32 ## User identifier
    of ctBasicGroup:
      ## A basic group (i.e., a chat with 0-200 other users)
      bgBasicGroupId* {.jsonName: "basic_group_id".}: int32 ## Basic group identifier
    of ctSupergroup:
      ## A supergroup (i.e. a chat with up to GetOption("supergroup_max_size") other users), or channel (with unlimited members)
      chattypesupergroSupergroupId* {.jsonName: "supergroup_id".}: int32 ## Supergroup or channel identifier
      chattypesupergroIsChannel* {.jsonName: "is_channel".}: bool ## True, if the supergroup is a channel
    of ctSecret:
      ## A secret chat with a user
      chattypesecrSecretChatId* {.jsonName: "secret_chat_id".}: int32 ## Secret chat identifier
      chattypesecrUserId* {.jsonName: "user_id".}: int32 ## User identifier of the secret chat peer

  AuthenticationCodeInfo * = object
    ## Information about the authentication code that was sent
    kind {.jsonName: "@type".}: string
    phoneNumber* {.jsonName: "phone_number".}: string ## A phone number that is being authenticated
    typ* {.jsonName: "type".}: AuthenticationCodeType ## Describes the way the code was sent to the user
    nextType* {.jsonName: "next_type".}: Option[AuthenticationCodeType] ## Describes the way the next code will be sent to the user; may be null
    timeout* {.jsonName: "timeout".}: int32 ## Timeout before the code should be re-sent, in seconds

  PassportSuitableElement * = object
    ## Contains information about a Telegram Passport element that was requested by a service
    kind {.jsonName: "@type".}: string
    typ* {.jsonName: "type".}: PassportElementType ## Type of the element
    isSelfieRequired* {.jsonName: "is_selfie_required".}: bool ## True, if a selfie is required with the identity document
    isTranslationRequired* {.jsonName: "is_translation_required".}: bool ## True, if a certified English translation is required with the document
    isNativeNameRequired* {.jsonName: "is_native_name_required".}: bool ## True, if personal details must include the user's name in the language of their country of residence

  InputMessageContentKind * {.pure.} = enum
    imDice = "inputMessageDice",
    imAudio = "inputMessageAudio",
    imLocation = "inputMessageLocation",
    imGame = "inputMessageGame",
    imSticker = "inputMessageSticker",
    imVideoNote = "inputMessageVideoNote",
    imAnimation = "inputMessageAnimation",
    imContact = "inputMessageContact",
    imForwarded = "inputMessageForwarded",
    imInvoice = "inputMessageInvoice",
    imText = "inputMessageText",
    imPhoto = "inputMessagePhoto",
    imVoiceNote = "inputMessageVoiceNote",
    imVideo = "inputMessageVideo",
    imVenue = "inputMessageVenue",
    imDocument = "inputMessageDocument",
    imPoll = "inputMessagePoll",

  InputMessageContent * = object
    ## The content of a message to send
    case kind* {.jsonName: "@type".}: InputMessageContentKind
    of imText:
      ## A text message
      mtText* {.jsonName: "text".}: FormattedText ## Formatted text to be sent; 1-GetOption("message_text_length_max") characters. Only Bold, Italic, Underline, Strikethrough, Code, Pre, PreCode, TextUrl and MentionName entities are allowed to be specified manually
      mtDisableWebPagePreview* {.jsonName: "disable_web_page_preview".}: bool ## True, if rich web page previews for URLs in the message text should be disabled
      mtClearDraft* {.jsonName: "clear_draft".}: bool ## True, if a chat message draft should be deleted
    of imAnimation:
      ## An animation message (GIF-style).
      maAnimation* {.jsonName: "animation".}: InputFile ## Animation file to be sent
      maThumbnail* {.jsonName: "thumbnail".}: InputThumbnail ## Animation thumbnail, if available
      maDuration* {.jsonName: "duration".}: int32 ## Duration of the animation, in seconds
      maWidth* {.jsonName: "width".}: int32 ## Width of the animation; may be replaced by the server
      maHeight* {.jsonName: "height".}: int32 ## Height of the animation; may be replaced by the server
      maCaption* {.jsonName: "caption".}: FormattedText ## Animation caption; 0-GetOption("message_caption_length_max") characters
    of imAudio:
      ## An audio message
      maAudio* {.jsonName: "audio".}: InputFile ## Audio file to be sent
      maAlbumCoverThumbnail* {.jsonName: "album_cover_thumbnail".}: InputThumbnail ## Thumbnail of the cover for the album, if available
      maudioDuration* {.jsonName: "duration".}: int32 ## Duration of the audio, in seconds; may be replaced by the server
      maTitle* {.jsonName: "title".}: string ## Title of the audio; 0-64 characters; may be replaced by the server
      maPerformer* {.jsonName: "performer".}: string ## Performer of the audio; 0-64 characters, may be replaced by the server
      maudioCaption* {.jsonName: "caption".}: FormattedText ## Audio caption; 0-GetOption("message_caption_length_max") characters
    of imDocument:
      ## A document message (general file)
      mdDocument* {.jsonName: "document".}: InputFile ## Document to be sent
      mdThumbnail* {.jsonName: "thumbnail".}: InputThumbnail ## Document thumbnail, if available
      mdCaption* {.jsonName: "caption".}: FormattedText ## Document caption; 0-GetOption("message_caption_length_max") characters
    of imPhoto:
      ## A photo message
      mpPhoto* {.jsonName: "photo".}: InputFile ## Photo to send
      mpThumbnail* {.jsonName: "thumbnail".}: InputThumbnail ## Photo thumbnail to be sent, this is sent to the other party in secret chats only
      mpAddedStickerFileIds* {.jsonName: "added_sticker_file_ids".}: seq[int32] ## File identifiers of the stickers added to the photo, if applicable
      mpWidth* {.jsonName: "width".}: int32 ## Photo width
      mpHeight* {.jsonName: "height".}: int32 ## Photo height
      mpCaption* {.jsonName: "caption".}: FormattedText ## Photo caption; 0-GetOption("message_caption_length_max") characters
      mpTtl* {.jsonName: "ttl".}: int32 ## Photo TTL (Time To Live), in seconds (0-60). A non-zero TTL can be specified only in private chats
    of imSticker:
      ## A sticker message
      msSticker* {.jsonName: "sticker".}: InputFile ## Sticker to be sent
      msThumbnail* {.jsonName: "thumbnail".}: InputThumbnail ## Sticker thumbnail, if available
      msWidth* {.jsonName: "width".}: int32 ## Sticker width
      msHeight* {.jsonName: "height".}: int32 ## Sticker height
    of imVideo:
      ## A video message
      mvVideo* {.jsonName: "video".}: InputFile ## Video to be sent
      mvThumbnail* {.jsonName: "thumbnail".}: InputThumbnail ## Video thumbnail, if available
      mvAddedStickerFileIds* {.jsonName: "added_sticker_file_ids".}: seq[int32] ## File identifiers of the stickers added to the video, if applicable
      mvDuration* {.jsonName: "duration".}: int32 ## Duration of the video, in seconds
      mvWidth* {.jsonName: "width".}: int32 ## Video width
      mvHeight* {.jsonName: "height".}: int32 ## Video height
      mvSupportsStreaming* {.jsonName: "supports_streaming".}: bool ## True, if the video should be tried to be streamed
      mvCaption* {.jsonName: "caption".}: FormattedText ## Video caption; 0-GetOption("message_caption_length_max") characters
      mvTtl* {.jsonName: "ttl".}: int32 ## Video TTL (Time To Live), in seconds (0-60). A non-zero TTL can be specified only in private chats
    of imVideoNote:
      ## A video note message
      mvnVideoNote* {.jsonName: "video_note".}: InputFile ## Video note to be sent
      mvnThumbnail* {.jsonName: "thumbnail".}: InputThumbnail ## Video thumbnail, if available
      mvnDuration* {.jsonName: "duration".}: int32 ## Duration of the video, in seconds
      mvnLength* {.jsonName: "length".}: int32 ## Video width and height; must be positive and not greater than 640
    of imVoiceNote:
      ## A voice note message
      mvnVoiceNote* {.jsonName: "voice_note".}: InputFile ## Voice note to be sent
      mvnoteDuration* {.jsonName: "duration".}: int32 ## Duration of the voice note, in seconds
      mvnWaveform* {.jsonName: "waveform".}: string ## Waveform representation of the voice note, in 5-bit format
      mvnCaption* {.jsonName: "caption".}: FormattedText ## Voice note caption; 0-GetOption("message_caption_length_max") characters
    of imLocation:
      ## A message with a location
      mlLocation* {.jsonName: "location".}: Location ## Location to be sent
      mlLivePeriod* {.jsonName: "live_period".}: int32 ## Period for which the location can be updated, in seconds; should be between 60 and 86400 for a live location and 0 otherwise
    of imVenue:
      ## A message with information about a venue
      mvVenue* {.jsonName: "venue".}: Venue ## Venue to send
    of imContact:
      ## A message containing a user contact
      mcContact* {.jsonName: "contact".}: Contact ## Contact to send
    of imDice:
      ## A dice message
      mdEmoji* {.jsonName: "emoji".}: string ## Emoji on which the dice throw animation is based
      mdClearDraft* {.jsonName: "clear_draft".}: bool ## True, if a chat message draft should be deleted
    of imGame:
      ## A message with a game; not supported for channels or secret chats
      mgBotUserId* {.jsonName: "bot_user_id".}: int32 ## User identifier of the bot that owns the game
      mgGameShortName* {.jsonName: "game_short_name".}: string ## Short name of the game
    of imInvoice:
      ## A message with an invoice; can be used only by bots and only in private chats
      miInvoice* {.jsonName: "invoice".}: Invoice ## Invoice
      miTitle* {.jsonName: "title".}: string ## Product title; 1-32 characters
      miDescription* {.jsonName: "description".}: string ## A message with an invoice; can be used only by bots and only in private chats
      miPhotoUrl* {.jsonName: "photo_url".}: string ## Product photo URL; optional
      miPhotoSize* {.jsonName: "photo_size".}: int32 ## Product photo size
      miPhotoWidth* {.jsonName: "photo_width".}: int32 ## Product photo width
      miPhotoHeight* {.jsonName: "photo_height".}: int32 ## Product photo height
      miPayload* {.jsonName: "payload".}: string ## The invoice payload
      miProviderToken* {.jsonName: "provider_token".}: string ## Payment provider token
      miProviderData* {.jsonName: "provider_data".}: string ## JSON-encoded data about the invoice, which will be shared with the payment provider
      miStartParameter* {.jsonName: "start_parameter".}: string ## Unique invoice bot start_parameter for the generation of this invoice
    of imPoll:
      ## A message with a poll. Polls can't be sent to secret chats. Polls can be sent only to a private chat with a bot
      mpQuestion* {.jsonName: "question".}: string ## Poll question, 1-255 characters
      mpOptions* {.jsonName: "options".}: seq[string] ## List of poll answer options, 2-10 strings 1-100 characters each
      mpIsAnonymous* {.jsonName: "is_anonymous".}: bool ## True, if the poll voters are anonymous. Non-anonymous polls can't be sent or forwarded to channels
      mpType* {.jsonName: "type".}: PollType ## Type of the poll
      mpOpenPeriod* {.jsonName: "open_period".}: int32 ## Amount of time the poll will be active after creation, in seconds; for bots only
      mpCloseDate* {.jsonName: "close_date".}: int32 ## Point in time (Unix timestamp) when the poll will be automatically closed; for bots only
      mpIsClosed* {.jsonName: "is_closed".}: bool ## True, if the poll needs to be sent already closed; for bots only
    of imForwarded:
      ## A forwarded message
      mfFromChatId* {.jsonName: "from_chat_id".}: int64 ## Identifier for the chat this forwarded message came from
      mfMessageId* {.jsonName: "message_id".}: int64 ## Identifier of the message to forward
      mfInGameShare* {.jsonName: "in_game_share".}: bool ## True, if a game message should be shared within a launched game; applies only to game messages
      mfSendCopy* {.jsonName: "send_copy".}: bool ## True, if content of the message needs to be copied without a link to the original message. Always true if the message is forwarded to a secret chat
      mfRemoveCaption* {.jsonName: "remove_caption".}: bool ## True, if media caption of the message copy needs to be removed. Ignored if send_copy is false

  CallProtocol * = object
    ## Specifies the supported call protocols
    kind {.jsonName: "@type".}: string
    udpP2p* {.jsonName: "udp_p2p".}: bool ## True, if UDP peer-to-peer connections are supported
    udpReflector* {.jsonName: "udp_reflector".}: bool ## True, if connection through UDP reflectors is supported
    minLayer* {.jsonName: "min_layer".}: int32 ## The minimum supported API layer; use 65
    maxLayer* {.jsonName: "max_layer".}: int32 ## The maximum supported API layer; use 65
    libraryVersions* {.jsonName: "library_versions".}: seq[string] ## List of supported libtgvoip versions

  HttpUrl * = object
    ## Contains an HTTP URL
    kind {.jsonName: "@type".}: string
    url* {.jsonName: "url".}: string ## The URL

  UserPrivacySettingRuleKind * {.pure.} = enum
    upsrAllowContacts = "userPrivacySettingRuleAllowContacts",
    upsrAllowChatMembers = "userPrivacySettingRuleAllowChatMembers",
    upsrRestrictContacts = "userPrivacySettingRuleRestrictContacts",
    upsrAllowAll = "userPrivacySettingRuleAllowAll",
    upsrRestrictUsers = "userPrivacySettingRuleRestrictUsers",
    upsrRestrictChatMembers = "userPrivacySettingRuleRestrictChatMembers",
    upsrRestrictAll = "userPrivacySettingRuleRestrictAll",
    upsrAllowUsers = "userPrivacySettingRuleAllowUsers",

  UserPrivacySettingRule * = object
    ## Represents a single rule for managing privacy settings
    case kind* {.jsonName: "@type".}: UserPrivacySettingRuleKind
    of upsrAllowAll:
      ## A rule to allow all users to do something
      discard
    of upsrAllowContacts:
      ## A rule to allow all of a user's contacts to do something
      discard
    of upsrAllowUsers:
      ## A rule to allow certain specified users to do something
      auUserIds* {.jsonName: "user_ids".}: seq[int32] ## The user identifiers, total number of users in all rules must not exceed 1000
    of upsrAllowChatMembers:
      ## A rule to allow all members of certain specified basic groups and supergroups to doing something
      acmChatIds* {.jsonName: "chat_ids".}: seq[int64] ## The chat identifiers, total number of chats in all rules must not exceed 20
    of upsrRestrictAll:
      ## A rule to restrict all users from doing something
      discard
    of upsrRestrictContacts:
      ## A rule to restrict all contacts of a user from doing something
      discard
    of upsrRestrictUsers:
      ## A rule to restrict all specified users from doing something
      ruUserIds* {.jsonName: "user_ids".}: seq[int32] ## The user identifiers, total number of users in all rules must not exceed 1000
    of upsrRestrictChatMembers:
      ## A rule to restrict all members of specified basic groups and supergroups from doing something
      rcmChatIds* {.jsonName: "chat_ids".}: seq[int64] ## The chat identifiers, total number of chats in all rules must not exceed 20

  RichTextKind * {.pure.} = enum
    rtReference = "richTextReference",
    rtEmailAddress = "richTextEmailAddress",
    rtPhoneNumber = "richTextPhoneNumber",
    rts = "richTexts",
    rtSuperscript = "richTextSuperscript",
    rtItalic = "richTextItalic",
    rtStrikethrough = "richTextStrikethrough",
    rtMarked = "richTextMarked",
    rtAnchor = "richTextAnchor",
    rtAnchorLink = "richTextAnchorLink",
    rtPlain = "richTextPlain",
    rtUnderline = "richTextUnderline",
    rtUrl = "richTextUrl",
    rtFixed = "richTextFixed",
    rtIcon = "richTextIcon",
    rtSubscript = "richTextSubscript",
    rtBold = "richTextBold",

  RichText * = ref object
    ## Describes a text object inside an instant-view web page
    case kind* {.jsonName: "@type".}: RichTextKind
    of rtPlain:
      ## A plain text
      richtextplaText* {.jsonName: "text".}: string ## Text
    of rtBold:
      ## A bold rich text
      richtextboText* {.jsonName: "text".}: RichText ## Text
    of rtItalic:
      ## An italicized rich text
      richtextitalText* {.jsonName: "text".}: RichText ## Text
    of rtUnderline:
      ## An underlined rich text
      richtextunderliText* {.jsonName: "text".}: RichText ## Text
    of rtStrikethrough:
      ## A strikethrough rich text
      richtextstrikethrouText* {.jsonName: "text".}: RichText ## Text
    of rtFixed:
      ## A fixed-width rich text
      richtextfixText* {.jsonName: "text".}: RichText ## Text
    of rtUrl:
      ## A rich text URL link
      richtextuText* {.jsonName: "text".}: RichText ## Text
      richtextuUrl* {.jsonName: "url".}: string ## URL
      richtextuIsCached* {.jsonName: "is_cached".}: bool ## True, if the URL has cached instant view server-side
    of rtEmailAddress:
      ## A rich text email link
      eaText* {.jsonName: "text".}: RichText ## Text
      eaEmailAddress* {.jsonName: "email_address".}: string ## Email address
    of rtSubscript:
      ## A subscript rich text
      richtextsubscriText* {.jsonName: "text".}: RichText ## Text
    of rtSuperscript:
      ## A superscript rich text
      richtextsuperscriText* {.jsonName: "text".}: RichText ## Text
    of rtMarked:
      ## A marked rich text
      richtextmarkText* {.jsonName: "text".}: RichText ## Text
    of rtPhoneNumber:
      ## A rich text phone number
      pnText* {.jsonName: "text".}: RichText ## Text
      pnPhoneNumber* {.jsonName: "phone_number".}: string ## Phone number
    of rtIcon:
      ## A small image inside the text
      richtexticDocument* {.jsonName: "document".}: Document ## The image represented as a document. The image can be in GIF, JPEG or PNG format
      richtexticWidth* {.jsonName: "width".}: int32 ## Width of a bounding box in which the image should be shown; 0 if unknown
      richtexticHeight* {.jsonName: "height".}: int32 ## Height of a bounding box in which the image should be shown; 0 if unknown
    of rtReference:
      ## A rich text reference of a text on the same web page
      richtextreferenText* {.jsonName: "text".}: RichText ## The text
      richtextreferenReferenceText* {.jsonName: "reference_text".}: RichText ## The text to show on click
      richtextreferenUrl* {.jsonName: "url".}: string ## An HTTP URL, opening the reference
    of rtAnchor:
      ## An anchor
      richtextanchName* {.jsonName: "name".}: string ## Anchor name
    of rtAnchorLink:
      ## A link to an anchor on the same web page
      alText* {.jsonName: "text".}: RichText ## The link text
      alName* {.jsonName: "name".}: string ## The anchor name. If the name is empty, the link should bring back to top
      alUrl* {.jsonName: "url".}: string ## An HTTP URL, opening the anchor
    of rts:
      ## A concatenation of rich texts
      Texts* {.jsonName: "texts".}: seq[RichText] ## Texts

  NetworkStatistics * = object
    ## A full list of available network statistic entries
    kind {.jsonName: "@type".}: string
    sinceDate* {.jsonName: "since_date".}: int32 ## Point in time (Unix timestamp) when the app began collecting statistics
    entries* {.jsonName: "entries".}: seq[NetworkStatisticsEntry] ## Network statistics entries

  PageBlockKind * {.pure.} = enum
    pbPreformatted = "pageBlockPreformatted",
    pbParagraph = "pageBlockParagraph",
    pbTitle = "pageBlockTitle",
    pbHeader = "pageBlockHeader",
    pbDetails = "pageBlockDetails",
    pbPhoto = "pageBlockPhoto",
    pbAnimation = "pageBlockAnimation",
    pbSlideshow = "pageBlockSlideshow",
    pbKicker = "pageBlockKicker",
    pbAnchor = "pageBlockAnchor",
    pbList = "pageBlockList",
    pbCollage = "pageBlockCollage",
    pbAudio = "pageBlockAudio",
    pbFooter = "pageBlockFooter",
    pbSubtitle = "pageBlockSubtitle",
    pbVoiceNote = "pageBlockVoiceNote",
    pbEmbeddedPost = "pageBlockEmbeddedPost",
    pbDivider = "pageBlockDivider",
    pbAuthorDate = "pageBlockAuthorDate",
    pbCover = "pageBlockCover",
    pbRelatedArticles = "pageBlockRelatedArticles",
    pbBlockQuote = "pageBlockBlockQuote",
    pbChatLink = "pageBlockChatLink",
    pbMap = "pageBlockMap",
    pbTable = "pageBlockTable",
    pbPullQuote = "pageBlockPullQuote",
    pbSubheader = "pageBlockSubheader",
    pbVideo = "pageBlockVideo",
    pbEmbedded = "pageBlockEmbedded",

  PageBlock * = ref object
    ## Describes a block of an instant view web page
    case kind* {.jsonName: "@type".}: PageBlockKind
    of pbTitle:
      ## The title of a page
      pageblocktitTitle* {.jsonName: "title".}: RichText ## Title
    of pbSubtitle:
      ## The subtitle of a page
      pageblocksubtitSubtitle* {.jsonName: "subtitle".}: RichText ## Subtitle
    of pbAuthorDate:
      ## The author and publishing date of a page
      adAuthor* {.jsonName: "author".}: RichText ## Author
      adPublishDate* {.jsonName: "publish_date".}: int32 ## Point in time (Unix timestamp) when the article was published; 0 if unknown
    of pbHeader:
      ## A header
      pageblockheadHeader* {.jsonName: "header".}: RichText ## Header
    of pbSubheader:
      ## A subheader
      pageblocksubheadSubheader* {.jsonName: "subheader".}: RichText ## Subheader
    of pbKicker:
      ## A kicker
      pageblockkickKicker* {.jsonName: "kicker".}: RichText ## Kicker
    of pbParagraph:
      ## A text paragraph
      pageblockparagraText* {.jsonName: "text".}: RichText ## Paragraph text
    of pbPreformatted:
      ## A preformatted text paragraph
      pageblockpreformattText* {.jsonName: "text".}: RichText ## Paragraph text
      pageblockpreformattLanguage* {.jsonName: "language".}: string ## Programming language for which the text should be formatted
    of pbFooter:
      ## The footer of a page
      pageblockfootFooter* {.jsonName: "footer".}: RichText ## Footer
    of pbDivider:
      ## An empty block separating a page
      discard
    of pbAnchor:
      ## An invisible anchor on a page, which can be used in a URL to open the page from the specified anchor
      pageblockanchName* {.jsonName: "name".}: string ## Name of the anchor
    of pbList:
      ## A list of data blocks
      pageblockliItems* {.jsonName: "items".}: seq[PageBlockListItem] ## The items of the list
    of pbBlockQuote:
      ## A block quote
      bqText* {.jsonName: "text".}: RichText ## Quote text
      bqCredit* {.jsonName: "credit".}: RichText ## Quote credit
    of pbPullQuote:
      ## A pull quote
      pqText* {.jsonName: "text".}: RichText ## Quote text
      pqCredit* {.jsonName: "credit".}: RichText ## Quote credit
    of pbAnimation:
      ## An animation
      pageblockanimatiAnimation* {.jsonName: "animation".}: Option[Animation] ## Animation file; may be null
      pageblockanimatiCaption* {.jsonName: "caption".}: PageBlockCaption ## Animation caption
      pageblockanimatiNeedAutoplay* {.jsonName: "need_autoplay".}: bool ## True, if the animation should be played automatically
    of pbAudio:
      ## An audio file
      pageblockaudAudio* {.jsonName: "audio".}: Option[Audio] ## Audio file; may be null
      pageblockaudCaption* {.jsonName: "caption".}: PageBlockCaption ## Audio file caption
    of pbPhoto:
      ## A photo
      pageblockphoPhoto* {.jsonName: "photo".}: Option[Photo] ## Photo file; may be null
      pageblockphoCaption* {.jsonName: "caption".}: PageBlockCaption ## Photo caption
      pageblockphoUrl* {.jsonName: "url".}: string ## URL that needs to be opened when the photo is clicked
    of pbVideo:
      ## A video
      pageblockvidVideo* {.jsonName: "video".}: Option[Video] ## Video file; may be null
      pageblockvidCaption* {.jsonName: "caption".}: PageBlockCaption ## Video caption
      pageblockvidNeedAutoplay* {.jsonName: "need_autoplay".}: bool ## True, if the video should be played automatically
      pageblockvidIsLooped* {.jsonName: "is_looped".}: bool ## True, if the video should be looped
    of pbVoiceNote:
      ## A voice note
      vnVoiceNote* {.jsonName: "voice_note".}: Option[VoiceNote] ## Voice note; may be null
      vnCaption* {.jsonName: "caption".}: PageBlockCaption ## Voice note caption
    of pbCover:
      ## A page cover
      pageblockcovCover* {.jsonName: "cover".}: PageBlock ## Cover
    of pbEmbedded:
      ## An embedded web page
      pageblockembeddUrl* {.jsonName: "url".}: string ## Web page URL, if available
      pageblockembeddHtml* {.jsonName: "html".}: string ## HTML-markup of the embedded page
      pageblockembeddPosterPhoto* {.jsonName: "poster_photo".}: Option[Photo] ## Poster photo, if available; may be null
      pageblockembeddWidth* {.jsonName: "width".}: int32 ## Block width; 0 if unknown
      pageblockembeddHeight* {.jsonName: "height".}: int32 ## Block height; 0 if unknown
      pageblockembeddCaption* {.jsonName: "caption".}: PageBlockCaption ## Block caption
      pageblockembeddIsFullWidth* {.jsonName: "is_full_width".}: bool ## True, if the block should be full width
      pageblockembeddAllowScrolling* {.jsonName: "allow_scrolling".}: bool ## True, if scrolling should be allowed
    of pbEmbeddedPost:
      ## An embedded post
      epUrl* {.jsonName: "url".}: string ## Web page URL
      epAuthor* {.jsonName: "author".}: string ## Post author
      epAuthorPhoto* {.jsonName: "author_photo".}: Option[Photo] ## Post author photo; may be null
      epDate* {.jsonName: "date".}: int32 ## Point in time (Unix timestamp) when the post was created; 0 if unknown
      epPageBlocks* {.jsonName: "page_blocks".}: seq[PageBlock] ## Post content
      epCaption* {.jsonName: "caption".}: PageBlockCaption ## Post caption
    of pbCollage:
      ## A collage
      pageblockcollaPageBlocks* {.jsonName: "page_blocks".}: seq[PageBlock] ## Collage item contents
      pageblockcollaCaption* {.jsonName: "caption".}: PageBlockCaption ## Block caption
    of pbSlideshow:
      ## A slideshow
      pageblockslideshPageBlocks* {.jsonName: "page_blocks".}: seq[PageBlock] ## Slideshow item contents
      pageblockslideshCaption* {.jsonName: "caption".}: PageBlockCaption ## Block caption
    of pbChatLink:
      ## A link to a chat
      clTitle* {.jsonName: "title".}: string ## Chat title
      clPhoto* {.jsonName: "photo".}: Option[ChatPhoto] ## Chat photo; may be null
      clUsername* {.jsonName: "username".}: string ## Chat username, by which all other information about the chat should be resolved
    of pbTable:
      ## A table
      pageblocktabCaption* {.jsonName: "caption".}: RichText ## Table caption
      pageblocktabCells* {.jsonName: "cells".}: seq[seq[PageBlockTableCell]] ## Table cells
      pageblocktabIsBordered* {.jsonName: "is_bordered".}: bool ## True, if the table is bordered
      pageblocktabIsStriped* {.jsonName: "is_striped".}: bool ## True, if the table is striped
    of pbDetails:
      ## A collapsible block
      pageblockdetaiHeader* {.jsonName: "header".}: RichText ## Always visible heading for the block
      pageblockdetaiPageBlocks* {.jsonName: "page_blocks".}: seq[PageBlock] ## Block contents
      pageblockdetaiIsOpen* {.jsonName: "is_open".}: bool ## True, if the block is open by default
    of pbRelatedArticles:
      ## Related articles
      raHeader* {.jsonName: "header".}: RichText ## Block header
      raArticles* {.jsonName: "articles".}: seq[PageBlockRelatedArticle] ## List of related articles
    of pbMap:
      ## A map
      pageblockmLocation* {.jsonName: "location".}: Location ## Location of the map center
      pageblockmZoom* {.jsonName: "zoom".}: int32 ## Map zoom level
      pageblockmWidth* {.jsonName: "width".}: int32 ## Map width
      pageblockmHeight* {.jsonName: "height".}: int32 ## Map height
      pageblockmCaption* {.jsonName: "caption".}: PageBlockCaption ## Block caption

  DateRange * = object
    ## Represents a date range
    kind {.jsonName: "@type".}: string
    startDate* {.jsonName: "start_date".}: int32 ## Point in time (Unix timestamp) at which the date range begins
    endDate* {.jsonName: "end_date".}: int32 ## Point in time (Unix timestamp) at which the date range ends

  InputPersonalDocument * = object
    ## A personal document to be saved to Telegram Passport
    kind {.jsonName: "@type".}: string
    files* {.jsonName: "files".}: seq[InputFile] ## List of files containing the pages of the document
    translation* {.jsonName: "translation".}: seq[InputFile] ## List of files containing a certified English translation of the document

  InputStickerKind * {.pure.} = enum
    isStatic = "inputStickerStatic",
    isAnimated = "inputStickerAnimated",

  InputSticker * = object
    ## Describes a sticker that needs to be added to a sticker set
    case kind* {.jsonName: "@type".}: InputStickerKind
    of isStatic:
      ## A static sticker in PNG format, which will be converted to WEBP server-side
      inputstickerstatSticker* {.jsonName: "sticker".}: InputFile ## PNG image with the sticker; must be up to 512 KB in size and fit in a 512x512 square
      inputstickerstatEmojis* {.jsonName: "emojis".}: string ## Emojis corresponding to the sticker
      inputstickerstatMaskPosition* {.jsonName: "mask_position".}: Option[MaskPosition] ## For masks, position where the mask should be placed; may be null
    of isAnimated:
      ## An animated sticker in TGS format
      inputstickeranimatSticker* {.jsonName: "sticker".}: InputFile ## File with the animated sticker. Only local or uploaded within a week files are supported. See https://core.telegram.org/animated_stickers#technical-requirements for technical requirements
      inputstickeranimatEmojis* {.jsonName: "emojis".}: string ## Emojis corresponding to the sticker

  Updates * = object
    ## Contains a list of updates
    kind {.jsonName: "@type".}: string
    updates* {.jsonName: "updates".}: seq[Update] ## List of updates

  ChatNotificationSettings * = object
    ## Contains information about notification settings for a chat
    kind {.jsonName: "@type".}: string
    useDefaultMuteFor* {.jsonName: "use_default_mute_for".}: bool ## If true, mute_for is ignored and the value for the relevant type of chat is used instead
    muteFor* {.jsonName: "mute_for".}: int32 ## Time left before notifications will be unmuted, in seconds
    useDefaultSound* {.jsonName: "use_default_sound".}: bool ## If true, sound is ignored and the value for the relevant type of chat is used instead
    sound* {.jsonName: "sound".}: string ## The name of an audio file to be used for notification sounds; only applies to iOS applications
    useDefaultShowPreview* {.jsonName: "use_default_show_preview".}: bool ## If true, show_preview is ignored and the value for the relevant type of chat is used instead
    showPreview* {.jsonName: "show_preview".}: bool ## True, if message content should be displayed in notifications
    useDefaultDisablePinnedMessageNotifications* {.jsonName: "use_default_disable_pinned_message_notifications".}: bool ## If true, disable_pinned_message_notifications is ignored and the value for the relevant type of chat is used instead
    disablePinnedMessageNotifications* {.jsonName: "disable_pinned_message_notifications".}: bool ## If true, notifications for incoming pinned messages will be created as for an ordinary unread message
    useDefaultDisableMentionNotifications* {.jsonName: "use_default_disable_mention_notifications".}: bool ## If true, disable_mention_notifications is ignored and the value for the relevant type of chat is used instead
    disableMentionNotifications* {.jsonName: "disable_mention_notifications".}: bool ## If true, notifications for messages with mentions will be created as for an ordinary unread message

  StorageStatisticsByFileType * = object
    ## Contains the storage usage statistics for a specific file type
    kind {.jsonName: "@type".}: string
    fileType* {.jsonName: "file_type".}: FileType ## File type
    size* {.jsonName: "size".}: int64 ## Total size of the files
    count* {.jsonName: "count".}: int32 ## Total number of files