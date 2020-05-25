import json_custom
export json_custom

type

  PollOption* = object
    kind* {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: string
    voterCount* {.jsonName: "voter_count".}: int32
    votePercentage* {.jsonName: "vote_percentage".}: int32
    isChosen* {.jsonName: "is_chosen".}: bool
    isBeingChosen* {.jsonName: "is_being_chosen".}: bool

  PaymentReceipt* = object
    kind* {.jsonName: "@type".}: string
    date* {.jsonName: "date".}: int32
    paymentsProviderUserId* {.jsonName: "payments_provider_user_id".}: int32
    invoice* {.jsonName: "invoice".}: Invoice
    orderInfo* {.jsonName: "order_info".}: OrderInfo
    shippingOption* {.jsonName: "shipping_option".}: ShippingOption
    credentialsTitle* {.jsonName: "credentials_title".}: string

  CheckChatUsernameResultKind* = enum
    ccurPublicChatsTooMuch = "checkChatUsernameResultPublicChatsTooMuch",
    ccurUsernameOccupied = "checkChatUsernameResultUsernameOccupied",
    ccurUsernameInvalid = "checkChatUsernameResultUsernameInvalid",
    ccurPublicGroupsUnavailable = "checkChatUsernameResultPublicGroupsUnavailable",
    ccurOk = "checkChatUsernameResultOk",

  CheckChatUsernameResult* = object
    case kind* {.jsonName: "@type".}: CheckChatUsernameResultKind
    of ccurOk:
      discard
    of ccurUsernameInvalid:
      discard
    of ccurUsernameOccupied:
      discard
    of ccurPublicChatsTooMuch:
      discard
    of ccurPublicGroupsUnavailable:
      discard

  TextEntityTypeKind* = enum
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

  TextEntityType* = object
    case kind* {.jsonName: "@type".}: TextEntityTypeKind
    of tetMention:
      discard
    of tetHashtag:
      discard
    of tetCashtag:
      discard
    of tetBotCommand:
      discard
    of tetUrl:
      discard
    of tetEmailAddress:
      discard
    of tetPhoneNumber:
      discard
    of tetBankCardNumber:
      discard
    of tetBold:
      discard
    of tetItalic:
      discard
    of tetUnderline:
      discard
    of tetStrikethrough:
      discard
    of tetCode:
      discard
    of tetPre:
      discard
    of tetPreCode:
      pcLanguage* {.jsonName: "language".}: string
    of tetTextUrl:
      tuUrl* {.jsonName: "url".}: string
    of tetMentionName:
      mnUserId* {.jsonName: "user_id".}: int32

  BotCommand* = object
    kind* {.jsonName: "@type".}: string
    command* {.jsonName: "command".}: string
    description* {.jsonName: "description".}: string

  BackgroundFillKind* = enum
    bfGradient = "backgroundFillGradient",
    bfSolid = "backgroundFillSolid",

  BackgroundFill* = object
    case kind* {.jsonName: "@type".}: BackgroundFillKind
    of bfSolid:
      backgroundfillsolColor* {.jsonName: "color".}: int32
    of bfGradient:
      backgroundfillgradieTopColor* {.jsonName: "top_color".}: int32
      backgroundfillgradieBottomColor* {.jsonName: "bottom_color".}: int32
      backgroundfillgradieRotationAngle* {.jsonName: "rotation_angle".}: int32

  Users* = object
    kind* {.jsonName: "@type".}: string
    totalCount* {.jsonName: "total_count".}: int32
    userIds* {.jsonName: "user_ids".}: seq[int32]

  Call* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32
    userId* {.jsonName: "user_id".}: int32
    isOutgoing* {.jsonName: "is_outgoing".}: bool
    state* {.jsonName: "state".}: CallState

  BankCardInfo* = object
    kind* {.jsonName: "@type".}: string
    title* {.jsonName: "title".}: string
    actions* {.jsonName: "actions".}: seq[BankCardActionOpenUrl]

  FoundMessages* = object
    kind* {.jsonName: "@type".}: string
    messages* {.jsonName: "messages".}: seq[Message]
    nextFromSearchId* {.jsonName: "next_from_search_id".}: string

  ChatsNearby* = object
    kind* {.jsonName: "@type".}: string
    usersNearby* {.jsonName: "users_nearby".}: seq[ChatNearby]
    supergroupsNearby* {.jsonName: "supergroups_nearby".}: seq[ChatNearby]

  CallId* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32

  CustomRequestResult* = object
    kind* {.jsonName: "@type".}: string
    result* {.jsonName: "result".}: string

  InputPassportElementErrorSourceKind* = enum
    ipeesTranslationFile = "inputPassportElementErrorSourceTranslationFile",
    ipeesFrontSide = "inputPassportElementErrorSourceFrontSide",
    ipeesDataField = "inputPassportElementErrorSourceDataField",
    ipeesFiles = "inputPassportElementErrorSourceFiles",
    ipeesTranslationFiles = "inputPassportElementErrorSourceTranslationFiles",
    ipeesFile = "inputPassportElementErrorSourceFile",
    ipeesSelfie = "inputPassportElementErrorSourceSelfie",
    ipeesReverseSide = "inputPassportElementErrorSourceReverseSide",
    ipeesUnspecified = "inputPassportElementErrorSourceUnspecified",

  InputPassportElementErrorSource* = object
    case kind* {.jsonName: "@type".}: InputPassportElementErrorSourceKind
    of ipeesUnspecified:
      inputpassportelementerrorsourceunspecifiElementHash* {.jsonName: "element_hash".}: string
    of ipeesDataField:
      dfFieldName* {.jsonName: "field_name".}: string
      dfDataHash* {.jsonName: "data_hash".}: string
    of ipeesFrontSide:
      fsFileHash* {.jsonName: "file_hash".}: string
    of ipeesReverseSide:
      rsFileHash* {.jsonName: "file_hash".}: string
    of ipeesSelfie:
      inputpassportelementerrorsourceselfFileHash* {.jsonName: "file_hash".}: string
    of ipeesTranslationFile:
      tfFileHash* {.jsonName: "file_hash".}: string
    of ipeesTranslationFiles:
      tfFileHashes* {.jsonName: "file_hashes".}: seq[string]
    of ipeesFile:
      inputpassportelementerrorsourcefiFileHash* {.jsonName: "file_hash".}: string
    of ipeesFiles:
      inputpassportelementerrorsourcefilFileHashes* {.jsonName: "file_hashes".}: seq[string]

  ChatMembersFilterKind* = enum
    cmfBanned = "chatMembersFilterBanned",
    cmfMembers = "chatMembersFilterMembers",
    cmfAdministrators = "chatMembersFilterAdministrators",
    cmfContacts = "chatMembersFilterContacts",
    cmfBots = "chatMembersFilterBots",
    cmfRestricted = "chatMembersFilterRestricted",

  ChatMembersFilter* = object
    case kind* {.jsonName: "@type".}: ChatMembersFilterKind
    of cmfContacts:
      discard
    of cmfAdministrators:
      discard
    of cmfMembers:
      discard
    of cmfRestricted:
      discard
    of cmfBanned:
      discard
    of cmfBots:
      discard

  PassportElements* = object
    kind* {.jsonName: "@type".}: string
    elements* {.jsonName: "elements".}: seq[PassportElement]

  JsonObjectMember* = object
    kind* {.jsonName: "@type".}: string
    key* {.jsonName: "key".}: string
    value* {.jsonName: "value".}: JsonValue

  EmailAddressAuthenticationCodeInfo* = object
    kind* {.jsonName: "@type".}: string
    emailAddressPattern* {.jsonName: "email_address_pattern".}: string
    length* {.jsonName: "length".}: int32

  PasswordState* = object
    kind* {.jsonName: "@type".}: string
    hasPassword* {.jsonName: "has_password".}: bool
    passwordHint* {.jsonName: "password_hint".}: string
    hasRecoveryEmailAddress* {.jsonName: "has_recovery_email_address".}: bool
    hasPassportData* {.jsonName: "has_passport_data".}: bool
    recoveryEmailAddressCodeInfo* {.jsonName: "recovery_email_address_code_info".}: EmailAddressAuthenticationCodeInfo

  Error* = object
    kind* {.jsonName: "@type".}: string
    code* {.jsonName: "code".}: int32
    message* {.jsonName: "message".}: string

  UserProfilePhoto* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string
    addedDate* {.jsonName: "added_date".}: int32
    sizes* {.jsonName: "sizes".}: seq[PhotoSize]

  DatedFile* = object
    kind* {.jsonName: "@type".}: string
    file* {.jsonName: "file".}: File
    date* {.jsonName: "date".}: int32

  LanguagePackInfo* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string
    baseLanguagePackId* {.jsonName: "base_language_pack_id".}: string
    name* {.jsonName: "name".}: string
    nativeName* {.jsonName: "native_name".}: string
    pluralCode* {.jsonName: "plural_code".}: string
    isOfficial* {.jsonName: "is_official".}: bool
    isRtl* {.jsonName: "is_rtl".}: bool
    isBeta* {.jsonName: "is_beta".}: bool
    isInstalled* {.jsonName: "is_installed".}: bool
    totalStringCount* {.jsonName: "total_string_count".}: int32
    translatedStringCount* {.jsonName: "translated_string_count".}: int32
    localStringCount* {.jsonName: "local_string_count".}: int32
    translationUrl* {.jsonName: "translation_url".}: string

  TdlibParameters* = object
    kind* {.jsonName: "@type".}: string
    useTestDc* {.jsonName: "use_test_dc".}: bool
    databaseDirectory* {.jsonName: "database_directory".}: string
    filesDirectory* {.jsonName: "files_directory".}: string
    useFileDatabase* {.jsonName: "use_file_database".}: bool
    useChatInfoDatabase* {.jsonName: "use_chat_info_database".}: bool
    useMessageDatabase* {.jsonName: "use_message_database".}: bool
    useSecretChats* {.jsonName: "use_secret_chats".}: bool
    apiId* {.jsonName: "api_id".}: int32
    apiHash* {.jsonName: "api_hash".}: string
    systemLanguageCode* {.jsonName: "system_language_code".}: string
    deviceModel* {.jsonName: "device_model".}: string
    systemVersion* {.jsonName: "system_version".}: string
    applicationVersion* {.jsonName: "application_version".}: string
    enableStorageOptimizer* {.jsonName: "enable_storage_optimizer".}: bool
    ignoreFileNames* {.jsonName: "ignore_file_names".}: bool

  PageBlockHorizontalAlignmentKind* = enum
    pbhaLeft = "pageBlockHorizontalAlignmentLeft",
    pbhaCenter = "pageBlockHorizontalAlignmentCenter",
    pbhaRight = "pageBlockHorizontalAlignmentRight",

  PageBlockHorizontalAlignment* = object
    case kind* {.jsonName: "@type".}: PageBlockHorizontalAlignmentKind
    of pbhaLeft:
      discard
    of pbhaCenter:
      discard
    of pbhaRight:
      discard

  PassportRequiredElement* = object
    kind* {.jsonName: "@type".}: string
    suitableElements* {.jsonName: "suitable_elements".}: seq[PassportSuitableElement]

  CallDiscardReasonKind* = enum
    cdrMissed = "callDiscardReasonMissed",
    cdrDisconnected = "callDiscardReasonDisconnected",
    cdrDeclined = "callDiscardReasonDeclined",
    cdrHungUp = "callDiscardReasonHungUp",
    cdrEmpty = "callDiscardReasonEmpty",

  CallDiscardReason* = object
    case kind* {.jsonName: "@type".}: CallDiscardReasonKind
    of cdrEmpty:
      discard
    of cdrMissed:
      discard
    of cdrDeclined:
      discard
    of cdrDisconnected:
      discard
    of cdrHungUp:
      discard

  MaskPosition* = object
    kind* {.jsonName: "@type".}: string
    point* {.jsonName: "point".}: MaskPoint
    xShift* {.jsonName: "x_shift".}: float
    yShift* {.jsonName: "y_shift".}: float
    scale* {.jsonName: "scale".}: float

  Photo* = object
    kind* {.jsonName: "@type".}: string
    hasStickers* {.jsonName: "has_stickers".}: bool
    minithumbnail* {.jsonName: "minithumbnail".}: Minithumbnail
    sizes* {.jsonName: "sizes".}: seq[PhotoSize]

  ChatListKind* = enum
    clArchive = "chatListArchive",
    clMain = "chatListMain",

  ChatList* = object
    case kind* {.jsonName: "@type".}: ChatListKind
    of clMain:
      discard
    of clArchive:
      discard

  LabeledPricePart* = object
    kind* {.jsonName: "@type".}: string
    label* {.jsonName: "label".}: string
    amount* {.jsonName: "amount".}: int64

  InputInlineQueryResultKind* = enum
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

  InputInlineQueryResult* = object
    case kind* {.jsonName: "@type".}: InputInlineQueryResultKind
    of iiqrAnimation:
      inputinlinequeryresultanimatiId* {.jsonName: "id".}: string
      inputinlinequeryresultanimatiTitle* {.jsonName: "title".}: string
      inputinlinequeryresultanimatiThumbnailUrl* {.jsonName: "thumbnail_url".}: string
      inputinlinequeryresultanimatiThumbnailMimeType* {.jsonName: "thumbnail_mime_type".}: string
      inputinlinequeryresultanimatiVideoUrl* {.jsonName: "video_url".}: string
      inputinlinequeryresultanimatiVideoMimeType* {.jsonName: "video_mime_type".}: string
      inputinlinequeryresultanimatiVideoDuration* {.jsonName: "video_duration".}: int32
      inputinlinequeryresultanimatiVideoWidth* {.jsonName: "video_width".}: int32
      inputinlinequeryresultanimatiVideoHeight* {.jsonName: "video_height".}: int32
      inputinlinequeryresultanimatiReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup
      inputinlinequeryresultanimatiInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent
    of iiqrArticle:
      inputinlinequeryresultarticId* {.jsonName: "id".}: string
      inputinlinequeryresultarticUrl* {.jsonName: "url".}: string
      inputinlinequeryresultarticHideUrl* {.jsonName: "hide_url".}: bool
      inputinlinequeryresultarticTitle* {.jsonName: "title".}: string
      inputinlinequeryresultarticDescription* {.jsonName: "description".}: string
      inputinlinequeryresultarticThumbnailUrl* {.jsonName: "thumbnail_url".}: string
      inputinlinequeryresultarticThumbnailWidth* {.jsonName: "thumbnail_width".}: int32
      inputinlinequeryresultarticThumbnailHeight* {.jsonName: "thumbnail_height".}: int32
      inputinlinequeryresultarticReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup
      inputinlinequeryresultarticInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent
    of iiqrAudio:
      inputinlinequeryresultaudId* {.jsonName: "id".}: string
      inputinlinequeryresultaudTitle* {.jsonName: "title".}: string
      inputinlinequeryresultaudPerformer* {.jsonName: "performer".}: string
      inputinlinequeryresultaudAudioUrl* {.jsonName: "audio_url".}: string
      inputinlinequeryresultaudAudioDuration* {.jsonName: "audio_duration".}: int32
      inputinlinequeryresultaudReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup
      inputinlinequeryresultaudInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent
    of iiqrContact:
      inputinlinequeryresultcontaId* {.jsonName: "id".}: string
      inputinlinequeryresultcontaContact* {.jsonName: "contact".}: Contact
      inputinlinequeryresultcontaThumbnailUrl* {.jsonName: "thumbnail_url".}: string
      inputinlinequeryresultcontaThumbnailWidth* {.jsonName: "thumbnail_width".}: int32
      inputinlinequeryresultcontaThumbnailHeight* {.jsonName: "thumbnail_height".}: int32
      inputinlinequeryresultcontaReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup
      inputinlinequeryresultcontaInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent
    of iiqrDocument:
      inputinlinequeryresultdocumeId* {.jsonName: "id".}: string
      inputinlinequeryresultdocumeTitle* {.jsonName: "title".}: string
      inputinlinequeryresultdocumeDescription* {.jsonName: "description".}: string
      inputinlinequeryresultdocumeDocumentUrl* {.jsonName: "document_url".}: string
      inputinlinequeryresultdocumeMimeType* {.jsonName: "mime_type".}: string
      inputinlinequeryresultdocumeThumbnailUrl* {.jsonName: "thumbnail_url".}: string
      inputinlinequeryresultdocumeThumbnailWidth* {.jsonName: "thumbnail_width".}: int32
      inputinlinequeryresultdocumeThumbnailHeight* {.jsonName: "thumbnail_height".}: int32
      inputinlinequeryresultdocumeReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup
      inputinlinequeryresultdocumeInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent
    of iiqrGame:
      inputinlinequeryresultgaId* {.jsonName: "id".}: string
      inputinlinequeryresultgaGameShortName* {.jsonName: "game_short_name".}: string
      inputinlinequeryresultgaReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup
    of iiqrLocation:
      inputinlinequeryresultlocatiId* {.jsonName: "id".}: string
      inputinlinequeryresultlocatiLocation* {.jsonName: "location".}: Location
      inputinlinequeryresultlocatiLivePeriod* {.jsonName: "live_period".}: int32
      inputinlinequeryresultlocatiTitle* {.jsonName: "title".}: string
      inputinlinequeryresultlocatiThumbnailUrl* {.jsonName: "thumbnail_url".}: string
      inputinlinequeryresultlocatiThumbnailWidth* {.jsonName: "thumbnail_width".}: int32
      inputinlinequeryresultlocatiThumbnailHeight* {.jsonName: "thumbnail_height".}: int32
      inputinlinequeryresultlocatiReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup
      inputinlinequeryresultlocatiInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent
    of iiqrPhoto:
      inputinlinequeryresultphoId* {.jsonName: "id".}: string
      inputinlinequeryresultphoTitle* {.jsonName: "title".}: string
      inputinlinequeryresultphoDescription* {.jsonName: "description".}: string
      inputinlinequeryresultphoThumbnailUrl* {.jsonName: "thumbnail_url".}: string
      inputinlinequeryresultphoPhotoUrl* {.jsonName: "photo_url".}: string
      inputinlinequeryresultphoPhotoWidth* {.jsonName: "photo_width".}: int32
      inputinlinequeryresultphoPhotoHeight* {.jsonName: "photo_height".}: int32
      inputinlinequeryresultphoReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup
      inputinlinequeryresultphoInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent
    of iiqrSticker:
      inputinlinequeryresultstickId* {.jsonName: "id".}: string
      inputinlinequeryresultstickThumbnailUrl* {.jsonName: "thumbnail_url".}: string
      inputinlinequeryresultstickStickerUrl* {.jsonName: "sticker_url".}: string
      inputinlinequeryresultstickStickerWidth* {.jsonName: "sticker_width".}: int32
      inputinlinequeryresultstickStickerHeight* {.jsonName: "sticker_height".}: int32
      inputinlinequeryresultstickReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup
      inputinlinequeryresultstickInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent
    of iiqrVenue:
      inputinlinequeryresultvenId* {.jsonName: "id".}: string
      inputinlinequeryresultvenVenue* {.jsonName: "venue".}: Venue
      inputinlinequeryresultvenThumbnailUrl* {.jsonName: "thumbnail_url".}: string
      inputinlinequeryresultvenThumbnailWidth* {.jsonName: "thumbnail_width".}: int32
      inputinlinequeryresultvenThumbnailHeight* {.jsonName: "thumbnail_height".}: int32
      inputinlinequeryresultvenReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup
      inputinlinequeryresultvenInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent
    of iiqrVideo:
      inputinlinequeryresultvidId* {.jsonName: "id".}: string
      inputinlinequeryresultvidTitle* {.jsonName: "title".}: string
      inputinlinequeryresultvidDescription* {.jsonName: "description".}: string
      inputinlinequeryresultvidThumbnailUrl* {.jsonName: "thumbnail_url".}: string
      inputinlinequeryresultvidVideoUrl* {.jsonName: "video_url".}: string
      inputinlinequeryresultvidMimeType* {.jsonName: "mime_type".}: string
      inputinlinequeryresultvidVideoWidth* {.jsonName: "video_width".}: int32
      inputinlinequeryresultvidVideoHeight* {.jsonName: "video_height".}: int32
      inputinlinequeryresultvidVideoDuration* {.jsonName: "video_duration".}: int32
      inputinlinequeryresultvidReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup
      inputinlinequeryresultvidInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent
    of iiqrVoiceNote:
      vnId* {.jsonName: "id".}: string
      vnTitle* {.jsonName: "title".}: string
      vnVoiceNoteUrl* {.jsonName: "voice_note_url".}: string
      vnVoiceNoteDuration* {.jsonName: "voice_note_duration".}: int32
      vnReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup
      vnInputMessageContent* {.jsonName: "input_message_content".}: InputMessageContent

  BasicGroupFullInfo* = object
    kind* {.jsonName: "@type".}: string
    description* {.jsonName: "description".}: string
    creatorUserId* {.jsonName: "creator_user_id".}: int32
    members* {.jsonName: "members".}: seq[ChatMember]
    inviteLink* {.jsonName: "invite_link".}: string

  MessageForwardOriginKind* = enum
    mfoUser = "messageForwardOriginUser",
    mfoHiddenUser = "messageForwardOriginHiddenUser",
    mfoChannel = "messageForwardOriginChannel",

  MessageForwardOrigin* = object
    case kind* {.jsonName: "@type".}: MessageForwardOriginKind
    of mfoUser:
      messageforwardoriginusSenderUserId* {.jsonName: "sender_user_id".}: int32
    of mfoHiddenUser:
      huSenderName* {.jsonName: "sender_name".}: string
    of mfoChannel:
      messageforwardoriginchannChatId* {.jsonName: "chat_id".}: int64
      messageforwardoriginchannMessageId* {.jsonName: "message_id".}: int64
      messageforwardoriginchannAuthorSignature* {.jsonName: "author_signature".}: string

  PageBlockTableCell* = object
    kind* {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: RichText
    isHeader* {.jsonName: "is_header".}: bool
    colspan* {.jsonName: "colspan".}: int32
    rowspan* {.jsonName: "rowspan".}: int32
    align* {.jsonName: "align".}: PageBlockHorizontalAlignment
    valign* {.jsonName: "valign".}: PageBlockVerticalAlignment

  TopChatCategoryKind* = enum
    tccInlineBots = "topChatCategoryInlineBots",
    tccUsers = "topChatCategoryUsers",
    tccCalls = "topChatCategoryCalls",
    tccForwardChats = "topChatCategoryForwardChats",
    tccBots = "topChatCategoryBots",
    tccChannels = "topChatCategoryChannels",
    tccGroups = "topChatCategoryGroups",

  TopChatCategory* = object
    case kind* {.jsonName: "@type".}: TopChatCategoryKind
    of tccUsers:
      discard
    of tccBots:
      discard
    of tccGroups:
      discard
    of tccChannels:
      discard
    of tccInlineBots:
      discard
    of tccCalls:
      discard
    of tccForwardChats:
      discard

  Emojis* = object
    kind* {.jsonName: "@type".}: string
    emojis* {.jsonName: "emojis".}: seq[string]

  Supergroup* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32
    username* {.jsonName: "username".}: string
    date* {.jsonName: "date".}: int32
    status* {.jsonName: "status".}: ChatMemberStatus
    memberCount* {.jsonName: "member_count".}: int32
    hasLinkedChat* {.jsonName: "has_linked_chat".}: bool
    hasLocation* {.jsonName: "has_location".}: bool
    signMessages* {.jsonName: "sign_messages".}: bool
    isSlowModeEnabled* {.jsonName: "is_slow_mode_enabled".}: bool
    isChannel* {.jsonName: "is_channel".}: bool
    isVerified* {.jsonName: "is_verified".}: bool
    restrictionReason* {.jsonName: "restriction_reason".}: string
    isScam* {.jsonName: "is_scam".}: bool

  ValidatedOrderInfo* = object
    kind* {.jsonName: "@type".}: string
    orderInfoId* {.jsonName: "order_info_id".}: string
    shippingOptions* {.jsonName: "shipping_options".}: seq[ShippingOption]

  PersonalDetails* = object
    kind* {.jsonName: "@type".}: string
    firstName* {.jsonName: "first_name".}: string
    middleName* {.jsonName: "middle_name".}: string
    lastName* {.jsonName: "last_name".}: string
    nativeFirstName* {.jsonName: "native_first_name".}: string
    nativeMiddleName* {.jsonName: "native_middle_name".}: string
    nativeLastName* {.jsonName: "native_last_name".}: string
    birthdate* {.jsonName: "birthdate".}: Date
    gender* {.jsonName: "gender".}: string
    countryCode* {.jsonName: "country_code".}: string
    residenceCountryCode* {.jsonName: "residence_country_code".}: string

  TestString* = object
    kind* {.jsonName: "@type".}: string
    value* {.jsonName: "value".}: string

  InputThumbnail* = object
    kind* {.jsonName: "@type".}: string
    thumbnail* {.jsonName: "thumbnail".}: InputFile
    width* {.jsonName: "width".}: int32
    height* {.jsonName: "height".}: int32

  Session* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string
    isCurrent* {.jsonName: "is_current".}: bool
    isPasswordPending* {.jsonName: "is_password_pending".}: bool
    apiId* {.jsonName: "api_id".}: int32
    applicationName* {.jsonName: "application_name".}: string
    applicationVersion* {.jsonName: "application_version".}: string
    isOfficialApplication* {.jsonName: "is_official_application".}: bool
    deviceModel* {.jsonName: "device_model".}: string
    platform* {.jsonName: "platform".}: string
    systemVersion* {.jsonName: "system_version".}: string
    logInDate* {.jsonName: "log_in_date".}: int32
    lastActiveDate* {.jsonName: "last_active_date".}: int32
    ip* {.jsonName: "ip".}: string
    country* {.jsonName: "country".}: string
    region* {.jsonName: "region".}: string

  Sticker* = object
    kind* {.jsonName: "@type".}: string
    setId* {.jsonName: "set_id".}: string
    width* {.jsonName: "width".}: int32
    height* {.jsonName: "height".}: int32
    emoji* {.jsonName: "emoji".}: string
    isAnimated* {.jsonName: "is_animated".}: bool
    isMask* {.jsonName: "is_mask".}: bool
    maskPosition* {.jsonName: "mask_position".}: MaskPosition
    thumbnail* {.jsonName: "thumbnail".}: PhotoSize
    sticker* {.jsonName: "sticker".}: File

  Date* = object
    kind* {.jsonName: "@type".}: string
    day* {.jsonName: "day".}: int32
    month* {.jsonName: "month".}: int32
    year* {.jsonName: "year".}: int32

  Animation* = object
    kind* {.jsonName: "@type".}: string
    duration* {.jsonName: "duration".}: int32
    width* {.jsonName: "width".}: int32
    height* {.jsonName: "height".}: int32
    fileName* {.jsonName: "file_name".}: string
    mimeType* {.jsonName: "mime_type".}: string
    minithumbnail* {.jsonName: "minithumbnail".}: Minithumbnail
    thumbnail* {.jsonName: "thumbnail".}: PhotoSize
    animation* {.jsonName: "animation".}: File

  Poll* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string
    question* {.jsonName: "question".}: string
    options* {.jsonName: "options".}: seq[PollOption]
    totalVoterCount* {.jsonName: "total_voter_count".}: int32
    recentVoterUserIds* {.jsonName: "recent_voter_user_ids".}: seq[int32]
    isAnonymous* {.jsonName: "is_anonymous".}: bool
    typ* {.jsonName: "type".}: PollType
    openPeriod* {.jsonName: "open_period".}: int32
    closeDate* {.jsonName: "close_date".}: int32
    isClosed* {.jsonName: "is_closed".}: bool

  Chat* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int64
    typ* {.jsonName: "type".}: ChatType
    chatList* {.jsonName: "chat_list".}: ChatList
    title* {.jsonName: "title".}: string
    photo* {.jsonName: "photo".}: ChatPhoto
    permissions* {.jsonName: "permissions".}: ChatPermissions
    lastMessage* {.jsonName: "last_message".}: Message
    order* {.jsonName: "order".}: string
    source* {.jsonName: "source".}: ChatSource
    isPinned* {.jsonName: "is_pinned".}: bool
    isMarkedAsUnread* {.jsonName: "is_marked_as_unread".}: bool
    hasScheduledMessages* {.jsonName: "has_scheduled_messages".}: bool
    canBeDeletedOnlyForSelf* {.jsonName: "can_be_deleted_only_for_self".}: bool
    canBeDeletedForAllUsers* {.jsonName: "can_be_deleted_for_all_users".}: bool
    canBeReported* {.jsonName: "can_be_reported".}: bool
    defaultDisableNotification* {.jsonName: "default_disable_notification".}: bool
    unreadCount* {.jsonName: "unread_count".}: int32
    lastReadInboxMessageId* {.jsonName: "last_read_inbox_message_id".}: int64
    lastReadOutboxMessageId* {.jsonName: "last_read_outbox_message_id".}: int64
    unreadMentionCount* {.jsonName: "unread_mention_count".}: int32
    notificationSettings* {.jsonName: "notification_settings".}: ChatNotificationSettings
    actionBar* {.jsonName: "action_bar".}: ChatActionBar
    pinnedMessageId* {.jsonName: "pinned_message_id".}: int64
    replyMarkupMessageId* {.jsonName: "reply_markup_message_id".}: int64
    draftMessage* {.jsonName: "draft_message".}: DraftMessage
    clientData* {.jsonName: "client_data".}: string

  Proxy* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32
    server* {.jsonName: "server".}: string
    port* {.jsonName: "port".}: int32
    lastUsedDate* {.jsonName: "last_used_date".}: int32
    isEnabled* {.jsonName: "is_enabled".}: bool
    typ* {.jsonName: "type".}: ProxyType

  VoiceNote* = object
    kind* {.jsonName: "@type".}: string
    duration* {.jsonName: "duration".}: int32
    waveform* {.jsonName: "waveform".}: string
    mimeType* {.jsonName: "mime_type".}: string
    voice* {.jsonName: "voice".}: File

  StickerSetInfo* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string
    title* {.jsonName: "title".}: string
    name* {.jsonName: "name".}: string
    thumbnail* {.jsonName: "thumbnail".}: PhotoSize
    isInstalled* {.jsonName: "is_installed".}: bool
    isArchived* {.jsonName: "is_archived".}: bool
    isOfficial* {.jsonName: "is_official".}: bool
    isAnimated* {.jsonName: "is_animated".}: bool
    isMasks* {.jsonName: "is_masks".}: bool
    isViewed* {.jsonName: "is_viewed".}: bool
    size* {.jsonName: "size".}: int32
    covers* {.jsonName: "covers".}: seq[Sticker]

  LocalFile* = object
    kind* {.jsonName: "@type".}: string
    path* {.jsonName: "path".}: string
    canBeDownloaded* {.jsonName: "can_be_downloaded".}: bool
    canBeDeleted* {.jsonName: "can_be_deleted".}: bool
    isDownloadingActive* {.jsonName: "is_downloading_active".}: bool
    isDownloadingCompleted* {.jsonName: "is_downloading_completed".}: bool
    downloadOffset* {.jsonName: "download_offset".}: int32
    downloadedPrefixSize* {.jsonName: "downloaded_prefix_size".}: int32
    downloadedSize* {.jsonName: "downloaded_size".}: int32

  DraftMessage* = object
    kind* {.jsonName: "@type".}: string
    replyToMessageId* {.jsonName: "reply_to_message_id".}: int64
    date* {.jsonName: "date".}: int32
    inputMessageText* {.jsonName: "input_message_text".}: InputMessageContent

  AuthorizationStateKind* = enum
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

  AuthorizationState* = object
    case kind* {.jsonName: "@type".}: AuthorizationStateKind
    of asWaitTdlibParameters:
      discard
    of asWaitEncryptionKey:
      wekIsEncrypted* {.jsonName: "is_encrypted".}: bool
    of asWaitPhoneNumber:
      discard
    of asWaitCode:
      wcCodeInfo* {.jsonName: "code_info".}: AuthenticationCodeInfo
    of asWaitOtherDeviceConfirmation:
      wodcLink* {.jsonName: "link".}: string
    of asWaitRegistration:
      wrTermsOfService* {.jsonName: "terms_of_service".}: TermsOfService
    of asWaitPassword:
      wpPasswordHint* {.jsonName: "password_hint".}: string
      wpHasRecoveryEmailAddress* {.jsonName: "has_recovery_email_address".}: bool
      wpRecoveryEmailAddressPattern* {.jsonName: "recovery_email_address_pattern".}: string
    of asReady:
      discard
    of asLoggingOut:
      discard
    of asClosing:
      discard
    of asClosed:
      discard

  PassportElementTypeKind* = enum
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

  PassportElementType* = object
    case kind* {.jsonName: "@type".}: PassportElementTypeKind
    of petPersonalDetails:
      discard
    of petPassport:
      discard
    of petDriverLicense:
      discard
    of petIdentityCard:
      discard
    of petInternalPassport:
      discard
    of petAddress:
      discard
    of petUtilityBill:
      discard
    of petBankStatement:
      discard
    of petRentalAgreement:
      discard
    of petPassportRegistration:
      discard
    of petTemporaryRegistration:
      discard
    of petPhoneNumber:
      discard
    of petEmailAddress:
      discard

  PassportAuthorizationForm* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32
    requiredElements* {.jsonName: "required_elements".}: seq[PassportRequiredElement]
    privacyPolicyUrl* {.jsonName: "privacy_policy_url".}: string

  Stickers* = object
    kind* {.jsonName: "@type".}: string
    stickers* {.jsonName: "stickers".}: seq[Sticker]

  ChatEventActionKind* = enum
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

  ChatEventAction* = object
    case kind* {.jsonName: "@type".}: ChatEventActionKind
    of ceMessageEdited:
      emeOldMessage* {.jsonName: "old_message".}: Message
      emeNewMessage* {.jsonName: "new_message".}: Message
    of ceMessageDeleted:
      emdMessage* {.jsonName: "message".}: Message
    of cePollStopped:
      epsMessage* {.jsonName: "message".}: Message
    of ceMessagePinned:
      empMessage* {.jsonName: "message".}: Message
    of ceMessageUnpinned:
      discard
    of ceMemberJoined:
      discard
    of ceMemberLeft:
      discard
    of ceMemberInvited:
      emiUserId* {.jsonName: "user_id".}: int32
      emiStatus* {.jsonName: "status".}: ChatMemberStatus
    of ceMemberPromoted:
      empUserId* {.jsonName: "user_id".}: int32
      empOldStatus* {.jsonName: "old_status".}: ChatMemberStatus
      empNewStatus* {.jsonName: "new_status".}: ChatMemberStatus
    of ceMemberRestricted:
      emrUserId* {.jsonName: "user_id".}: int32
      emrOldStatus* {.jsonName: "old_status".}: ChatMemberStatus
      emrNewStatus* {.jsonName: "new_status".}: ChatMemberStatus
    of ceTitleChanged:
      etcOldTitle* {.jsonName: "old_title".}: string
      etcNewTitle* {.jsonName: "new_title".}: string
    of cePermissionsChanged:
      epcOldPermissions* {.jsonName: "old_permissions".}: ChatPermissions
      epcNewPermissions* {.jsonName: "new_permissions".}: ChatPermissions
    of ceDescriptionChanged:
      edcOldDescription* {.jsonName: "old_description".}: string
      edcNewDescription* {.jsonName: "new_description".}: string
    of ceUsernameChanged:
      eucOldUsername* {.jsonName: "old_username".}: string
      eucNewUsername* {.jsonName: "new_username".}: string
    of cePhotoChanged:
      epcOldPhoto* {.jsonName: "old_photo".}: Photo
      epcNewPhoto* {.jsonName: "new_photo".}: Photo
    of ceInvitesToggled:
      eitCanInviteUsers* {.jsonName: "can_invite_users".}: bool
    of ceLinkedChatChanged:
      elccOldLinkedChatId* {.jsonName: "old_linked_chat_id".}: int64
      elccNewLinkedChatId* {.jsonName: "new_linked_chat_id".}: int64
    of ceSlowModeDelayChanged:
      esmdcOldSlowModeDelay* {.jsonName: "old_slow_mode_delay".}: int32
      esmdcNewSlowModeDelay* {.jsonName: "new_slow_mode_delay".}: int32
    of ceSignMessagesToggled:
      esmtSignMessages* {.jsonName: "sign_messages".}: bool
    of ceStickerSetChanged:
      esscOldStickerSetId* {.jsonName: "old_sticker_set_id".}: string
      esscNewStickerSetId* {.jsonName: "new_sticker_set_id".}: string
    of ceLocationChanged:
      elcOldLocation* {.jsonName: "old_location".}: ChatLocation
      elcNewLocation* {.jsonName: "new_location".}: ChatLocation
    of ceIsAllHistoryAvailableToggled:
      eiahatIsAllHistoryAvailable* {.jsonName: "is_all_history_available".}: bool

  Message* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int64
    senderUserId* {.jsonName: "sender_user_id".}: int32
    chatId* {.jsonName: "chat_id".}: int64
    sendingState* {.jsonName: "sending_state".}: Option[MessageSendingState]
    schedulingState* {.jsonName: "scheduling_state".}: Option[MessageSchedulingState]
    isOutgoing* {.jsonName: "is_outgoing".}: bool
    canBeEdited* {.jsonName: "can_be_edited".}: bool
    canBeForwarded* {.jsonName: "can_be_forwarded".}: bool
    canBeDeletedOnlyForSelf* {.jsonName: "can_be_deleted_only_for_self".}: bool
    canBeDeletedForAllUsers* {.jsonName: "can_be_deleted_for_all_users".}: bool
    isChannelPost* {.jsonName: "is_channel_post".}: bool
    containsUnreadMention* {.jsonName: "contains_unread_mention".}: bool
    date* {.jsonName: "date".}: int32
    editDate* {.jsonName: "edit_date".}: int32
    forwardInfo* {.jsonName: "forward_info".}: Option[MessageForwardInfo]
    replyToMessageId* {.jsonName: "reply_to_message_id".}: int64
    ttl* {.jsonName: "ttl".}: int32
    ttlExpiresIn* {.jsonName: "ttl_expires_in".}: float
    viaBotUserId* {.jsonName: "via_bot_user_id".}: int32
    authorSignature* {.jsonName: "author_signature".}: string
    views* {.jsonName: "views".}: int32
    mediaAlbumId* {.jsonName: "media_album_id".}: string
    restrictionReason* {.jsonName: "restriction_reason".}: string
    content* {.jsonName: "content".}: MessageContent
    replyMarkup* {.jsonName: "reply_markup".}: Option[ReplyMarkup]

  SecretChatStateKind* = enum
    scsClosed = "secretChatStateClosed",
    scsReady = "secretChatStateReady",
    scsPending = "secretChatStatePending",

  SecretChatState* = object
    case kind* {.jsonName: "@type".}: SecretChatStateKind
    of scsPending:
      discard
    of scsReady:
      discard
    of scsClosed:
      discard

  NetworkStatisticsEntryKind* = enum
    nseCall = "networkStatisticsEntryCall",
    nseFile = "networkStatisticsEntryFile",

  NetworkStatisticsEntry* = object
    case kind* {.jsonName: "@type".}: NetworkStatisticsEntryKind
    of nseFile:
      networkstatisticsentryfiFileType* {.jsonName: "file_type".}: FileType
      networkstatisticsentryfiNetworkType* {.jsonName: "network_type".}: NetworkType
      networkstatisticsentryfiSentBytes* {.jsonName: "sent_bytes".}: int64
      networkstatisticsentryfiReceivedBytes* {.jsonName: "received_bytes".}: int64
    of nseCall:
      networkstatisticsentrycaNetworkType* {.jsonName: "network_type".}: NetworkType
      networkstatisticsentrycaSentBytes* {.jsonName: "sent_bytes".}: int64
      networkstatisticsentrycaReceivedBytes* {.jsonName: "received_bytes".}: int64
      networkstatisticsentrycaDuration* {.jsonName: "duration".}: float

  ChatSourceKind* = enum
    csMtprotoProxy = "chatSourceMtprotoProxy",
    csPublicServiceAnnouncement = "chatSourcePublicServiceAnnouncement",

  ChatSource* = object
    case kind* {.jsonName: "@type".}: ChatSourceKind
    of csMtprotoProxy:
      discard
    of csPublicServiceAnnouncement:
      psaType* {.jsonName: "type".}: string
      psaText* {.jsonName: "text".}: string

  Messages* = object
    kind* {.jsonName: "@type".}: string
    totalCount* {.jsonName: "total_count".}: int32
    messages* {.jsonName: "messages".}: seq[Message]

  EncryptedCredentials* = object
    kind* {.jsonName: "@type".}: string
    data* {.jsonName: "data".}: string
    hash* {.jsonName: "hash".}: string
    secret* {.jsonName: "secret".}: string

  LanguagePackStrings* = object
    kind* {.jsonName: "@type".}: string
    strings* {.jsonName: "strings".}: seq[LanguagePackString]

  TestVectorIntObject* = object
    kind* {.jsonName: "@type".}: string
    value* {.jsonName: "value".}: seq[TestInt]

  Ok* = object
    kind* {.jsonName: "@type".}: string

  InputFileKind* = enum
    ifLocal = "inputFileLocal",
    ifGenerated = "inputFileGenerated",
    ifRemote = "inputFileRemote",
    ifId = "inputFileId",

  InputFile* = object
    case kind* {.jsonName: "@type".}: InputFileKind
    of ifId:
      inputfileId* {.jsonName: "id".}: int32
    of ifRemote:
      inputfileremoId* {.jsonName: "id".}: string
    of ifLocal:
      inputfilelocPath* {.jsonName: "path".}: string
    of ifGenerated:
      inputfilegeneratOriginalPath* {.jsonName: "original_path".}: string
      inputfilegeneratConversion* {.jsonName: "conversion".}: string
      inputfilegeneratExpectedSize* {.jsonName: "expected_size".}: int32

  Contact* = object
    kind* {.jsonName: "@type".}: string
    phoneNumber* {.jsonName: "phone_number".}: string
    firstName* {.jsonName: "first_name".}: string
    lastName* {.jsonName: "last_name".}: string
    vcard* {.jsonName: "vcard".}: string
    userId* {.jsonName: "user_id".}: int32

  CallConnection* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string
    ip* {.jsonName: "ip".}: string
    ipv6* {.jsonName: "ipv6".}: string
    port* {.jsonName: "port".}: int32
    peerTag* {.jsonName: "peer_tag".}: string

  KeyboardButton* = object
    kind* {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: string
    typ* {.jsonName: "type".}: KeyboardButtonType

  ProxyTypeKind* = enum
    ptSocks5 = "proxyTypeSocks5",
    ptMtproto = "proxyTypeMtproto",
    ptHttp = "proxyTypeHttp",

  ProxyType* = object
    case kind* {.jsonName: "@type".}: ProxyTypeKind
    of ptSocks5:
      proxytypesockUsername* {.jsonName: "username".}: string
      proxytypesockPassword* {.jsonName: "password".}: string
    of ptHttp:
      proxytypehtUsername* {.jsonName: "username".}: string
      proxytypehtPassword* {.jsonName: "password".}: string
      proxytypehtHttpOnly* {.jsonName: "http_only".}: bool
    of ptMtproto:
      proxytypemtproSecret* {.jsonName: "secret".}: string

  LoginUrlInfoKind* = enum
    luiRequestConfirmation = "loginUrlInfoRequestConfirmation",
    luiOpen = "loginUrlInfoOpen",

  LoginUrlInfo* = object
    case kind* {.jsonName: "@type".}: LoginUrlInfoKind
    of luiOpen:
      loginurlinfoopUrl* {.jsonName: "url".}: string
      loginurlinfoopSkipConfirm* {.jsonName: "skip_confirm".}: bool
    of luiRequestConfirmation:
      rcUrl* {.jsonName: "url".}: string
      rcDomain* {.jsonName: "domain".}: string
      rcBotUserId* {.jsonName: "bot_user_id".}: int32
      rcRequestWriteAccess* {.jsonName: "request_write_access".}: bool

  UserPrivacySettingKind* = enum
    upsAllowChatInvites = "userPrivacySettingAllowChatInvites",
    upsShowStatus = "userPrivacySettingShowStatus",
    upsShowPhoneNumber = "userPrivacySettingShowPhoneNumber",
    upsAllowCalls = "userPrivacySettingAllowCalls",
    upsShowProfilePhoto = "userPrivacySettingShowProfilePhoto",
    upsShowLinkInForwardedMessages = "userPrivacySettingShowLinkInForwardedMessages",
    upsAllowPeerToPeerCalls = "userPrivacySettingAllowPeerToPeerCalls",
    upsAllowFindingByPhoneNumber = "userPrivacySettingAllowFindingByPhoneNumber",

  UserPrivacySetting* = object
    case kind* {.jsonName: "@type".}: UserPrivacySettingKind
    of upsShowStatus:
      discard
    of upsShowProfilePhoto:
      discard
    of upsShowLinkInForwardedMessages:
      discard
    of upsShowPhoneNumber:
      discard
    of upsAllowChatInvites:
      discard
    of upsAllowCalls:
      discard
    of upsAllowPeerToPeerCalls:
      discard
    of upsAllowFindingByPhoneNumber:
      discard

  PushMessageContentKind* = enum
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

  PushMessageContent* = object
    case kind* {.jsonName: "@type".}: PushMessageContentKind
    of pmcHidden:
      pushmessagecontenthiddIsPinned* {.jsonName: "is_pinned".}: bool
    of pmcAnimation:
      pushmessagecontentanimatiAnimation* {.jsonName: "animation".}: Animation
      pushmessagecontentanimatiCaption* {.jsonName: "caption".}: string
      pushmessagecontentanimatiIsPinned* {.jsonName: "is_pinned".}: bool
    of pmcAudio:
      pushmessagecontentaudAudio* {.jsonName: "audio".}: Audio
      pushmessagecontentaudIsPinned* {.jsonName: "is_pinned".}: bool
    of pmcContact:
      pushmessagecontentcontaName* {.jsonName: "name".}: string
      pushmessagecontentcontaIsPinned* {.jsonName: "is_pinned".}: bool
    of pmcContactRegistered:
      discard
    of pmcDocument:
      pushmessagecontentdocumeDocument* {.jsonName: "document".}: Document
      pushmessagecontentdocumeIsPinned* {.jsonName: "is_pinned".}: bool
    of pmcGame:
      pushmessagecontentgaTitle* {.jsonName: "title".}: string
      pushmessagecontentgaIsPinned* {.jsonName: "is_pinned".}: bool
    of pmcGameScore:
      gsTitle* {.jsonName: "title".}: string
      gsScore* {.jsonName: "score".}: int32
      gsIsPinned* {.jsonName: "is_pinned".}: bool
    of pmcInvoice:
      pushmessagecontentinvoiPrice* {.jsonName: "price".}: string
      pushmessagecontentinvoiIsPinned* {.jsonName: "is_pinned".}: bool
    of pmcLocation:
      pushmessagecontentlocatiIsLive* {.jsonName: "is_live".}: bool
      pushmessagecontentlocatiIsPinned* {.jsonName: "is_pinned".}: bool
    of pmcPhoto:
      pushmessagecontentphoPhoto* {.jsonName: "photo".}: Photo
      pushmessagecontentphoCaption* {.jsonName: "caption".}: string
      pushmessagecontentphoIsSecret* {.jsonName: "is_secret".}: bool
      pushmessagecontentphoIsPinned* {.jsonName: "is_pinned".}: bool
    of pmcPoll:
      pushmessagecontentpoQuestion* {.jsonName: "question".}: string
      pushmessagecontentpoIsRegular* {.jsonName: "is_regular".}: bool
      pushmessagecontentpoIsPinned* {.jsonName: "is_pinned".}: bool
    of pmcScreenshotTaken:
      discard
    of pmcSticker:
      pushmessagecontentstickSticker* {.jsonName: "sticker".}: Sticker
      pushmessagecontentstickEmoji* {.jsonName: "emoji".}: string
      pushmessagecontentstickIsPinned* {.jsonName: "is_pinned".}: bool
    of pmcText:
      pushmessagecontentteText* {.jsonName: "text".}: string
      pushmessagecontentteIsPinned* {.jsonName: "is_pinned".}: bool
    of pmcVideo:
      pushmessagecontentvidVideo* {.jsonName: "video".}: Video
      pushmessagecontentvidCaption* {.jsonName: "caption".}: string
      pushmessagecontentvidIsSecret* {.jsonName: "is_secret".}: bool
      pushmessagecontentvidIsPinned* {.jsonName: "is_pinned".}: bool
    of pmcVideoNote:
      vnVideoNote* {.jsonName: "video_note".}: VideoNote
      videonIsPinned* {.jsonName: "is_pinned".}: bool
    of pmcVoiceNote:
      vnVoiceNote* {.jsonName: "voice_note".}: VoiceNote
      voicenIsPinned* {.jsonName: "is_pinned".}: bool
    of pmcBasicGroupChatCreate:
      discard
    of pmcChatAddMembers:
      camMemberName* {.jsonName: "member_name".}: string
      camIsCurrentUser* {.jsonName: "is_current_user".}: bool
      camIsReturned* {.jsonName: "is_returned".}: bool
    of pmcChatChangePhoto:
      discard
    of pmcChatChangeTitle:
      cctTitle* {.jsonName: "title".}: string
    of pmcChatDeleteMember:
      cdmMemberName* {.jsonName: "member_name".}: string
      cdmIsCurrentUser* {.jsonName: "is_current_user".}: bool
      cdmIsLeft* {.jsonName: "is_left".}: bool
    of pmcChatJoinByLink:
      discard
    of pmcMessageForwards:
      mfTotalCount* {.jsonName: "total_count".}: int32
    of pmcMediaAlbum:
      maTotalCount* {.jsonName: "total_count".}: int32
      maHasPhotos* {.jsonName: "has_photos".}: bool
      maHasVideos* {.jsonName: "has_videos".}: bool

  PersonalDocument* = object
    kind* {.jsonName: "@type".}: string
    files* {.jsonName: "files".}: seq[DatedFile]
    translation* {.jsonName: "translation".}: seq[DatedFile]

  TermsOfService* = object
    kind* {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: FormattedText
    minUserAge* {.jsonName: "min_user_age".}: int32
    showPopup* {.jsonName: "show_popup".}: bool

  ChatMemberStatusKind* = enum
    cmsCreator = "chatMemberStatusCreator",
    cmsRestricted = "chatMemberStatusRestricted",
    cmsMember = "chatMemberStatusMember",
    cmsAdministrator = "chatMemberStatusAdministrator",
    cmsBanned = "chatMemberStatusBanned",
    cmsLeft = "chatMemberStatusLeft",

  ChatMemberStatus* = object
    case kind* {.jsonName: "@type".}: ChatMemberStatusKind
    of cmsCreator:
      chatmemberstatuscreatCustomTitle* {.jsonName: "custom_title".}: string
      chatmemberstatuscreatIsMember* {.jsonName: "is_member".}: bool
    of cmsAdministrator:
      chatmemberstatusadministratCustomTitle* {.jsonName: "custom_title".}: string
      chatmemberstatusadministratCanBeEdited* {.jsonName: "can_be_edited".}: bool
      chatmemberstatusadministratCanChangeInfo* {.jsonName: "can_change_info".}: bool
      chatmemberstatusadministratCanPostMessages* {.jsonName: "can_post_messages".}: bool
      chatmemberstatusadministratCanEditMessages* {.jsonName: "can_edit_messages".}: bool
      chatmemberstatusadministratCanDeleteMessages* {.jsonName: "can_delete_messages".}: bool
      chatmemberstatusadministratCanInviteUsers* {.jsonName: "can_invite_users".}: bool
      chatmemberstatusadministratCanRestrictMembers* {.jsonName: "can_restrict_members".}: bool
      chatmemberstatusadministratCanPinMessages* {.jsonName: "can_pin_messages".}: bool
      chatmemberstatusadministratCanPromoteMembers* {.jsonName: "can_promote_members".}: bool
    of cmsMember:
      discard
    of cmsRestricted:
      chatmemberstatusrestrictIsMember* {.jsonName: "is_member".}: bool
      chatmemberstatusrestrictRestrictedUntilDate* {.jsonName: "restricted_until_date".}: int32
      chatmemberstatusrestrictPermissions* {.jsonName: "permissions".}: ChatPermissions
    of cmsLeft:
      discard
    of cmsBanned:
      chatmemberstatusbannBannedUntilDate* {.jsonName: "banned_until_date".}: int32

  Hashtags* = object
    kind* {.jsonName: "@type".}: string
    hashtags* {.jsonName: "hashtags".}: seq[string]

  PushReceiverId* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string

  SecretChat* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32
    userId* {.jsonName: "user_id".}: int32
    state* {.jsonName: "state".}: SecretChatState
    isOutbound* {.jsonName: "is_outbound".}: bool
    ttl* {.jsonName: "ttl".}: int32
    keyHash* {.jsonName: "key_hash".}: string
    layer* {.jsonName: "layer".}: int32

  ConnectedWebsite* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string
    domainName* {.jsonName: "domain_name".}: string
    botUserId* {.jsonName: "bot_user_id".}: int32
    browser* {.jsonName: "browser".}: string
    platform* {.jsonName: "platform".}: string
    logInDate* {.jsonName: "log_in_date".}: int32
    lastActiveDate* {.jsonName: "last_active_date".}: int32
    ip* {.jsonName: "ip".}: string
    location* {.jsonName: "location".}: string

  MessageContentKind* = enum
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

  MessageContent* = object
    case kind* {.jsonName: "@type".}: MessageContentKind
    of mText:
      messageteText* {.jsonName: "text".}: FormattedText
      messageteWebPage* {.jsonName: "web_page".}: Option[WebPage]
    of mAnimation:
      messageanimatiAnimation* {.jsonName: "animation".}: Animation
      messageanimatiCaption* {.jsonName: "caption".}: FormattedText
      messageanimatiIsSecret* {.jsonName: "is_secret".}: bool
    of mAudio:
      messageaudAudio* {.jsonName: "audio".}: Audio
      messageaudCaption* {.jsonName: "caption".}: FormattedText
    of mDocument:
      messagedocumeDocument* {.jsonName: "document".}: Document
      messagedocumeCaption* {.jsonName: "caption".}: FormattedText
    of mPhoto:
      messagephoPhoto* {.jsonName: "photo".}: Photo
      messagephoCaption* {.jsonName: "caption".}: FormattedText
      messagephoIsSecret* {.jsonName: "is_secret".}: bool
    of mExpiredPhoto:
      discard
    of mSticker:
      messagestickSticker* {.jsonName: "sticker".}: Sticker
    of mVideo:
      messagevidVideo* {.jsonName: "video".}: Video
      messagevidCaption* {.jsonName: "caption".}: FormattedText
      messagevidIsSecret* {.jsonName: "is_secret".}: bool
    of mExpiredVideo:
      discard
    of mVideoNote:
      vnVideoNote* {.jsonName: "video_note".}: VideoNote
      vnIsViewed* {.jsonName: "is_viewed".}: bool
      vnIsSecret* {.jsonName: "is_secret".}: bool
    of mVoiceNote:
      vnVoiceNote* {.jsonName: "voice_note".}: VoiceNote
      vnCaption* {.jsonName: "caption".}: FormattedText
      vnIsListened* {.jsonName: "is_listened".}: bool
    of mLocation:
      messagelocatiLocation* {.jsonName: "location".}: Location
      messagelocatiLivePeriod* {.jsonName: "live_period".}: int32
      messagelocatiExpiresIn* {.jsonName: "expires_in".}: int32
    of mVenue:
      messagevenVenue* {.jsonName: "venue".}: Venue
    of mContact:
      messagecontaContact* {.jsonName: "contact".}: Contact
    of mDice:
      messagediInitialStateSticker* {.jsonName: "initial_state_sticker".}: Sticker
      messagediFinalStateSticker* {.jsonName: "final_state_sticker".}: Sticker
      messagediEmoji* {.jsonName: "emoji".}: string
      messagediValue* {.jsonName: "value".}: int32
      messagediSuccessAnimationFrameNumber* {.jsonName: "success_animation_frame_number".}: int32
    of mGame:
      messagegaGame* {.jsonName: "game".}: Game
    of mPoll:
      messagepoPoll* {.jsonName: "poll".}: Poll
    of mInvoice:
      messageinvoiTitle* {.jsonName: "title".}: string
      messageinvoiDescription* {.jsonName: "description".}: string
      messageinvoiPhoto* {.jsonName: "photo".}: Photo
      messageinvoiCurrency* {.jsonName: "currency".}: string
      messageinvoiTotalAmount* {.jsonName: "total_amount".}: int64
      messageinvoiStartParameter* {.jsonName: "start_parameter".}: string
      messageinvoiIsTest* {.jsonName: "is_test".}: bool
      messageinvoiNeedShippingAddress* {.jsonName: "need_shipping_address".}: bool
      messageinvoiReceiptMessageId* {.jsonName: "receipt_message_id".}: int64
    of mCall:
      messagecaDiscardReason* {.jsonName: "discard_reason".}: CallDiscardReason
      messagecaDuration* {.jsonName: "duration".}: int32
    of mBasicGroupChatCreate:
      bgccTitle* {.jsonName: "title".}: string
      bgccMemberUserIds* {.jsonName: "member_user_ids".}: seq[int32]
    of mSupergroupChatCreate:
      sccTitle* {.jsonName: "title".}: string
    of mChatChangeTitle:
      cctTitle* {.jsonName: "title".}: string
    of mChatChangePhoto:
      ccpPhoto* {.jsonName: "photo".}: Photo
    of mChatDeletePhoto:
      discard
    of mChatAddMembers:
      camMemberUserIds* {.jsonName: "member_user_ids".}: seq[int32]
    of mChatJoinByLink:
      discard
    of mChatDeleteMember:
      cdmUserId* {.jsonName: "user_id".}: int32
    of mChatUpgradeTo:
      cutSupergroupId* {.jsonName: "supergroup_id".}: int32
    of mChatUpgradeFrom:
      cufTitle* {.jsonName: "title".}: string
      cufBasicGroupId* {.jsonName: "basic_group_id".}: int32
    of mPinMessage:
      pmMessageId* {.jsonName: "message_id".}: int64
    of mScreenshotTaken:
      discard
    of mChatSetTtl:
      cstTtl* {.jsonName: "ttl".}: int32
    of mCustomServiceAction:
      csaText* {.jsonName: "text".}: string
    of mGameScore:
      gsGameMessageId* {.jsonName: "game_message_id".}: int64
      gsGameId* {.jsonName: "game_id".}: string
      gsScore* {.jsonName: "score".}: int32
    of mPaymentSuccessful:
      psInvoiceMessageId* {.jsonName: "invoice_message_id".}: int64
      psCurrency* {.jsonName: "currency".}: string
      psTotalAmount* {.jsonName: "total_amount".}: int64
    of mPaymentSuccessfulBot:
      psbInvoiceMessageId* {.jsonName: "invoice_message_id".}: int64
      psbCurrency* {.jsonName: "currency".}: string
      psbTotalAmount* {.jsonName: "total_amount".}: int64
      psbInvoicePayload* {.jsonName: "invoice_payload".}: string
      psbShippingOptionId* {.jsonName: "shipping_option_id".}: string
      psbOrderInfo* {.jsonName: "order_info".}: OrderInfo
      psbTelegramPaymentChargeId* {.jsonName: "telegram_payment_charge_id".}: string
      psbProviderPaymentChargeId* {.jsonName: "provider_payment_charge_id".}: string
    of mContactRegistered:
      discard
    of mWebsiteConnected:
      wcDomainName* {.jsonName: "domain_name".}: string
    of mPassportDataSent:
      pdsTypes* {.jsonName: "types".}: seq[PassportElementType]
    of mPassportDataReceived:
      pdrElements* {.jsonName: "elements".}: seq[EncryptedPassportElement]
      pdrCredentials* {.jsonName: "credentials".}: EncryptedCredentials
    of mUnsupported:
      discard

  IdentityDocument* = object
    kind* {.jsonName: "@type".}: string
    number* {.jsonName: "number".}: string
    expiryDate* {.jsonName: "expiry_date".}: Date
    frontSide* {.jsonName: "front_side".}: DatedFile
    reverseSide* {.jsonName: "reverse_side".}: DatedFile
    selfie* {.jsonName: "selfie".}: DatedFile
    translation* {.jsonName: "translation".}: seq[DatedFile]

  DatabaseStatistics* = object
    kind* {.jsonName: "@type".}: string
    statistics* {.jsonName: "statistics".}: string

  ChatInviteLink* = object
    kind* {.jsonName: "@type".}: string
    inviteLink* {.jsonName: "invite_link".}: string

  PassportElementErrorSourceKind* = enum
    peesFiles = "passportElementErrorSourceFiles",
    peesSelfie = "passportElementErrorSourceSelfie",
    peesTranslationFile = "passportElementErrorSourceTranslationFile",
    peesReverseSide = "passportElementErrorSourceReverseSide",
    peesDataField = "passportElementErrorSourceDataField",
    peesTranslationFiles = "passportElementErrorSourceTranslationFiles",
    peesFile = "passportElementErrorSourceFile",
    peesUnspecified = "passportElementErrorSourceUnspecified",
    peesFrontSide = "passportElementErrorSourceFrontSide",

  PassportElementErrorSource* = object
    case kind* {.jsonName: "@type".}: PassportElementErrorSourceKind
    of peesUnspecified:
      discard
    of peesDataField:
      dfFieldName* {.jsonName: "field_name".}: string
    of peesFrontSide:
      discard
    of peesReverseSide:
      discard
    of peesSelfie:
      discard
    of peesTranslationFile:
      tfFileIndex* {.jsonName: "file_index".}: int32
    of peesTranslationFiles:
      discard
    of peesFile:
      passportelementerrorsourcefiFileIndex* {.jsonName: "file_index".}: int32
    of peesFiles:
      discard

  NetworkTypeKind* = enum
    ntMobile = "networkTypeMobile",
    ntNone = "networkTypeNone",
    ntOther = "networkTypeOther",
    ntMobileRoaming = "networkTypeMobileRoaming",
    ntWiFi = "networkTypeWiFi",

  NetworkType* = object
    case kind* {.jsonName: "@type".}: NetworkTypeKind
    of ntNone:
      discard
    of ntMobile:
      discard
    of ntMobileRoaming:
      discard
    of ntWiFi:
      discard
    of ntOther:
      discard

  Venue* = object
    kind* {.jsonName: "@type".}: string
    location* {.jsonName: "location".}: Location
    title* {.jsonName: "title".}: string
    address* {.jsonName: "address".}: string
    provider* {.jsonName: "provider".}: string
    id* {.jsonName: "id".}: string
    typ* {.jsonName: "type".}: string

  ChatStatisticsMessageInteractionCounters* = object
    kind* {.jsonName: "@type".}: string
    messageId* {.jsonName: "message_id".}: int64
    viewCount* {.jsonName: "view_count".}: int32
    forwardCount* {.jsonName: "forward_count".}: int32

  BackgroundTypeKind* = enum
    btFill = "backgroundTypeFill",
    btWallpaper = "backgroundTypeWallpaper",
    btPattern = "backgroundTypePattern",

  BackgroundType* = object
    case kind* {.jsonName: "@type".}: BackgroundTypeKind
    of btWallpaper:
      backgroundtypewallpapIsBlurred* {.jsonName: "is_blurred".}: bool
      backgroundtypewallpapIsMoving* {.jsonName: "is_moving".}: bool
    of btPattern:
      backgroundtypepatteFill* {.jsonName: "fill".}: BackgroundFill
      backgroundtypepatteIntensity* {.jsonName: "intensity".}: int32
      backgroundtypepatteIsMoving* {.jsonName: "is_moving".}: bool
    of btFill:
      backgroundtypefiFill* {.jsonName: "fill".}: BackgroundFill

  PageBlockRelatedArticle* = object
    kind* {.jsonName: "@type".}: string
    url* {.jsonName: "url".}: string
    title* {.jsonName: "title".}: string
    description* {.jsonName: "description".}: string
    photo* {.jsonName: "photo".}: Photo
    author* {.jsonName: "author".}: string
    publishDate* {.jsonName: "publish_date".}: int32

  CanTransferOwnershipResultKind* = enum
    ctorPasswordNeeded = "canTransferOwnershipResultPasswordNeeded",
    ctorPasswordTooFresh = "canTransferOwnershipResultPasswordTooFresh",
    ctorSessionTooFresh = "canTransferOwnershipResultSessionTooFresh",
    ctorOk = "canTransferOwnershipResultOk",

  CanTransferOwnershipResult* = object
    case kind* {.jsonName: "@type".}: CanTransferOwnershipResultKind
    of ctorOk:
      discard
    of ctorPasswordNeeded:
      discard
    of ctorPasswordTooFresh:
      ptfRetryAfter* {.jsonName: "retry_after".}: int32
    of ctorSessionTooFresh:
      stfRetryAfter* {.jsonName: "retry_after".}: int32

  InputBackgroundKind* = enum
    ibLocal = "inputBackgroundLocal",
    ibRemote = "inputBackgroundRemote",

  InputBackground* = object
    case kind* {.jsonName: "@type".}: InputBackgroundKind
    of ibLocal:
      inputbackgroundlocBackground* {.jsonName: "background".}: InputFile
    of ibRemote:
      inputbackgroundremoBackgroundId* {.jsonName: "background_id".}: string

  InputPassportElementError* = object
    kind* {.jsonName: "@type".}: string
    typ* {.jsonName: "type".}: PassportElementType
    message* {.jsonName: "message".}: string
    source* {.jsonName: "source".}: InputPassportElementErrorSource

  PassportElementError* = object
    kind* {.jsonName: "@type".}: string
    typ* {.jsonName: "type".}: PassportElementType
    message* {.jsonName: "message".}: string
    source* {.jsonName: "source".}: PassportElementErrorSource

  SearchMessagesFilterKind* = enum
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

  SearchMessagesFilter* = object
    case kind* {.jsonName: "@type".}: SearchMessagesFilterKind
    of smfEmpty:
      discard
    of smfAnimation:
      discard
    of smfAudio:
      discard
    of smfDocument:
      discard
    of smfPhoto:
      discard
    of smfVideo:
      discard
    of smfVoiceNote:
      discard
    of smfPhotoAndVideo:
      discard
    of smfUrl:
      discard
    of smfChatPhoto:
      discard
    of smfCall:
      discard
    of smfMissedCall:
      discard
    of smfVideoNote:
      discard
    of smfVoiceAndVideoNote:
      discard
    of smfMention:
      discard
    of smfUnreadMention:
      discard
    of smfFailedToSend:
      discard

  BotInfo* = object
    kind* {.jsonName: "@type".}: string
    description* {.jsonName: "description".}: string
    commands* {.jsonName: "commands".}: seq[BotCommand]

  TestVectorString* = object
    kind* {.jsonName: "@type".}: string
    value* {.jsonName: "value".}: seq[string]

  Backgrounds* = object
    kind* {.jsonName: "@type".}: string
    backgrounds* {.jsonName: "backgrounds".}: seq[Background]

  Address* = object
    kind* {.jsonName: "@type".}: string
    countryCode* {.jsonName: "country_code".}: string
    state* {.jsonName: "state".}: string
    city* {.jsonName: "city".}: string
    streetLine1* {.jsonName: "street_line1".}: string
    streetLine2* {.jsonName: "street_line2".}: string
    postalCode* {.jsonName: "postal_code".}: string

  ChatEventLogFilters* = object
    kind* {.jsonName: "@type".}: string
    messageEdits* {.jsonName: "message_edits".}: bool
    messageDeletions* {.jsonName: "message_deletions".}: bool
    messagePins* {.jsonName: "message_pins".}: bool
    memberJoins* {.jsonName: "member_joins".}: bool
    memberLeaves* {.jsonName: "member_leaves".}: bool
    memberInvites* {.jsonName: "member_invites".}: bool
    memberPromotions* {.jsonName: "member_promotions".}: bool
    memberRestrictions* {.jsonName: "member_restrictions".}: bool
    infoChanges* {.jsonName: "info_changes".}: bool
    settingChanges* {.jsonName: "setting_changes".}: bool

  Notification* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32
    date* {.jsonName: "date".}: int32
    isSilent* {.jsonName: "is_silent".}: bool
    typ* {.jsonName: "type".}: NotificationType

  TMeUrls* = object
    kind* {.jsonName: "@type".}: string
    urls* {.jsonName: "urls".}: seq[TMeUrl]

  LocalizationTargetInfo* = object
    kind* {.jsonName: "@type".}: string
    languagePacks* {.jsonName: "language_packs".}: seq[LanguagePackInfo]

  NotificationSettingsScopeKind* = enum
    nssGroupChats = "notificationSettingsScopeGroupChats",
    nssChannelChats = "notificationSettingsScopeChannelChats",
    nssPrivateChats = "notificationSettingsScopePrivateChats",

  NotificationSettingsScope* = object
    case kind* {.jsonName: "@type".}: NotificationSettingsScopeKind
    of nssPrivateChats:
      discard
    of nssGroupChats:
      discard
    of nssChannelChats:
      discard

  UserFullInfo* = object
    kind* {.jsonName: "@type".}: string
    isBlocked* {.jsonName: "is_blocked".}: bool
    canBeCalled* {.jsonName: "can_be_called".}: bool
    hasPrivateCalls* {.jsonName: "has_private_calls".}: bool
    needPhoneNumberPrivacyException* {.jsonName: "need_phone_number_privacy_exception".}: bool
    bio* {.jsonName: "bio".}: string
    shareText* {.jsonName: "share_text".}: string
    groupInCommonCount* {.jsonName: "group_in_common_count".}: int32
    botInfo* {.jsonName: "bot_info".}: BotInfo

  StorageStatisticsFast* = object
    kind* {.jsonName: "@type".}: string
    filesSize* {.jsonName: "files_size".}: int64
    fileCount* {.jsonName: "file_count".}: int32
    databaseSize* {.jsonName: "database_size".}: int64
    languagePackDatabaseSize* {.jsonName: "language_pack_database_size".}: int64
    logSize* {.jsonName: "log_size".}: int64

  Proxies* = object
    kind* {.jsonName: "@type".}: string
    proxies* {.jsonName: "proxies".}: seq[Proxy]

  ChatAdministrators* = object
    kind* {.jsonName: "@type".}: string
    administrators* {.jsonName: "administrators".}: seq[ChatAdministrator]

  TestInt* = object
    kind* {.jsonName: "@type".}: string
    value* {.jsonName: "value".}: int32

  AutoDownloadSettingsPresets* = object
    kind* {.jsonName: "@type".}: string
    low* {.jsonName: "low".}: AutoDownloadSettings
    medium* {.jsonName: "medium".}: AutoDownloadSettings
    high* {.jsonName: "high".}: AutoDownloadSettings

  ReplyMarkupKind* = enum
    rmShowKeyboard = "replyMarkupShowKeyboard",
    rmRemoveKeyboard = "replyMarkupRemoveKeyboard",
    rmInlineKeyboard = "replyMarkupInlineKeyboard",
    rmForceReply = "replyMarkupForceReply",

  ReplyMarkup* = object
    case kind* {.jsonName: "@type".}: ReplyMarkupKind
    of rmRemoveKeyboard:
      rkIsPersonal* {.jsonName: "is_personal".}: bool
    of rmForceReply:
      frIsPersonal* {.jsonName: "is_personal".}: bool
    of rmShowKeyboard:
      skRows* {.jsonName: "rows".}: seq[seq[KeyboardButton]]
      skResizeKeyboard* {.jsonName: "resize_keyboard".}: bool
      skOneTime* {.jsonName: "one_time".}: bool
      skIsPersonal* {.jsonName: "is_personal".}: bool
    of rmInlineKeyboard:
      ikRows* {.jsonName: "rows".}: seq[seq[InlineKeyboardButton]]

  ChatMembers* = object
    kind* {.jsonName: "@type".}: string
    totalCount* {.jsonName: "total_count".}: int32
    members* {.jsonName: "members".}: seq[ChatMember]

  PageBlockListItem* = object
    kind* {.jsonName: "@type".}: string
    label* {.jsonName: "label".}: string
    pageBlocks* {.jsonName: "page_blocks".}: seq[PageBlock]

  PhoneNumberAuthenticationSettings* = object
    kind* {.jsonName: "@type".}: string
    allowFlashCall* {.jsonName: "allow_flash_call".}: bool
    isCurrentPhoneNumber* {.jsonName: "is_current_phone_number".}: bool
    allowSmsRetrieverApi* {.jsonName: "allow_sms_retriever_api".}: bool

  WebPage* = object
    kind* {.jsonName: "@type".}: string
    url* {.jsonName: "url".}: string
    displayUrl* {.jsonName: "display_url".}: string
    typ* {.jsonName: "type".}: string
    siteName* {.jsonName: "site_name".}: string
    title* {.jsonName: "title".}: string
    description* {.jsonName: "description".}: FormattedText
    photo* {.jsonName: "photo".}: Photo
    embedUrl* {.jsonName: "embed_url".}: string
    embedType* {.jsonName: "embed_type".}: string
    embedWidth* {.jsonName: "embed_width".}: int32
    embedHeight* {.jsonName: "embed_height".}: int32
    duration* {.jsonName: "duration".}: int32
    author* {.jsonName: "author".}: string
    animation* {.jsonName: "animation".}: Animation
    audio* {.jsonName: "audio".}: Audio
    document* {.jsonName: "document".}: Document
    sticker* {.jsonName: "sticker".}: Sticker
    video* {.jsonName: "video".}: Video
    videoNote* {.jsonName: "video_note".}: VideoNote
    voiceNote* {.jsonName: "voice_note".}: VoiceNote
    instantViewVersion* {.jsonName: "instant_view_version".}: int32

  User* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32
    firstName* {.jsonName: "first_name".}: string
    lastName* {.jsonName: "last_name".}: string
    username* {.jsonName: "username".}: string
    phoneNumber* {.jsonName: "phone_number".}: string
    status* {.jsonName: "status".}: UserStatus
    profilePhoto* {.jsonName: "profile_photo".}: ProfilePhoto
    isContact* {.jsonName: "is_contact".}: bool
    isMutualContact* {.jsonName: "is_mutual_contact".}: bool
    isVerified* {.jsonName: "is_verified".}: bool
    isSupport* {.jsonName: "is_support".}: bool
    restrictionReason* {.jsonName: "restriction_reason".}: string
    isScam* {.jsonName: "is_scam".}: bool
    haveAccess* {.jsonName: "have_access".}: bool
    typ* {.jsonName: "type".}: UserType
    languageCode* {.jsonName: "language_code".}: string

  LogVerbosityLevel* = object
    kind* {.jsonName: "@type".}: string
    verbosityLevel* {.jsonName: "verbosity_level".}: int32

  TestBytes* = object
    kind* {.jsonName: "@type".}: string
    value* {.jsonName: "value".}: string

  UpdateKind* = enum
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

  Update* = object
    case kind* {.jsonName: "@type".}: UpdateKind
    of uAuthorizationState:
      asAuthorizationState* {.jsonName: "authorization_state".}: AuthorizationState
    of uNewMessage:
      nmMessage* {.jsonName: "message".}: Message
    of uMessageSendAcknowledged:
      msaChatId* {.jsonName: "chat_id".}: int64
      msaMessageId* {.jsonName: "message_id".}: int64
    of uMessageSendSucceeded:
      mssMessage* {.jsonName: "message".}: Message
      mssOldMessageId* {.jsonName: "old_message_id".}: int64
    of uMessageSendFailed:
      msfMessage* {.jsonName: "message".}: Message
      msfOldMessageId* {.jsonName: "old_message_id".}: int64
      msfErrorCode* {.jsonName: "error_code".}: int32
      msfErrorMessage* {.jsonName: "error_message".}: string
    of uMessageContent:
      mcChatId* {.jsonName: "chat_id".}: int64
      mcMessageId* {.jsonName: "message_id".}: int64
      mcNewContent* {.jsonName: "new_content".}: MessageContent
    of uMessageEdited:
      meChatId* {.jsonName: "chat_id".}: int64
      meMessageId* {.jsonName: "message_id".}: int64
      meEditDate* {.jsonName: "edit_date".}: int32
      meReplyMarkup* {.jsonName: "reply_markup".}: ReplyMarkup
    of uMessageViews:
      mvChatId* {.jsonName: "chat_id".}: int64
      mvMessageId* {.jsonName: "message_id".}: int64
      mvViews* {.jsonName: "views".}: int32
    of uMessageContentOpened:
      mcoChatId* {.jsonName: "chat_id".}: int64
      mcoMessageId* {.jsonName: "message_id".}: int64
    of uMessageMentionRead:
      mmrChatId* {.jsonName: "chat_id".}: int64
      mmrMessageId* {.jsonName: "message_id".}: int64
      mmrUnreadMentionCount* {.jsonName: "unread_mention_count".}: int32
    of uMessageLiveLocationViewed:
      mllvChatId* {.jsonName: "chat_id".}: int64
      mllvMessageId* {.jsonName: "message_id".}: int64
    of uNewChat:
      ncChat* {.jsonName: "chat".}: Chat
    of uChatChatList:
      cclChatId* {.jsonName: "chat_id".}: int64
      cclChatList* {.jsonName: "chat_list".}: ChatList
    of uChatTitle:
      ctChatId* {.jsonName: "chat_id".}: int64
      ctTitle* {.jsonName: "title".}: string
    of uChatPhoto:
      cphotoChatId* {.jsonName: "chat_id".}: int64
      cpPhoto* {.jsonName: "photo".}: ChatPhoto
    of uChatPermissions:
      cpermChatId* {.jsonName: "chat_id".}: int64
      cpPermissions* {.jsonName: "permissions".}: ChatPermissions
    of uChatLastMessage:
      clmChatId* {.jsonName: "chat_id".}: int64
      clmLastMessage* {.jsonName: "last_message".}: Message
      clmOrder* {.jsonName: "order".}: string
    of uChatOrder:
      coChatId* {.jsonName: "chat_id".}: int64
      coOrder* {.jsonName: "order".}: string
    of uChatIsPinned:
      cipChatId* {.jsonName: "chat_id".}: int64
      cipIsPinned* {.jsonName: "is_pinned".}: bool
      cipOrder* {.jsonName: "order".}: string
    of uChatIsMarkedAsUnread:
      cimauChatId* {.jsonName: "chat_id".}: int64
      cimauIsMarkedAsUnread* {.jsonName: "is_marked_as_unread".}: bool
    of uChatSource:
      csChatId* {.jsonName: "chat_id".}: int64
      csSource* {.jsonName: "source".}: ChatSource
      csOrder* {.jsonName: "order".}: string
    of uChatHasScheduledMessages:
      chsmChatId* {.jsonName: "chat_id".}: int64
      chsmHasScheduledMessages* {.jsonName: "has_scheduled_messages".}: bool
    of uChatDefaultDisableNotification:
      cddnChatId* {.jsonName: "chat_id".}: int64
      cddnDefaultDisableNotification* {.jsonName: "default_disable_notification".}: bool
    of uChatReadInbox:
      criChatId* {.jsonName: "chat_id".}: int64
      criLastReadInboxMessageId* {.jsonName: "last_read_inbox_message_id".}: int64
      criUnreadCount* {.jsonName: "unread_count".}: int32
    of uChatReadOutbox:
      croChatId* {.jsonName: "chat_id".}: int64
      croLastReadOutboxMessageId* {.jsonName: "last_read_outbox_message_id".}: int64
    of uChatUnreadMentionCount:
      cumcChatId* {.jsonName: "chat_id".}: int64
      cumcUnreadMentionCount* {.jsonName: "unread_mention_count".}: int32
    of uChatNotificationSettings:
      cnsChatId* {.jsonName: "chat_id".}: int64
      cnsNotificationSettings* {.jsonName: "notification_settings".}: ChatNotificationSettings
    of uScopeNotificationSettings:
      snsScope* {.jsonName: "scope".}: NotificationSettingsScope
      snsNotificationSettings* {.jsonName: "notification_settings".}: ScopeNotificationSettings
    of uChatActionBar:
      cabChatId* {.jsonName: "chat_id".}: int64
      cabActionBar* {.jsonName: "action_bar".}: ChatActionBar
    of uChatPinnedMessage:
      cpmChatId* {.jsonName: "chat_id".}: int64
      cpmPinnedMessageId* {.jsonName: "pinned_message_id".}: int64
    of uChatReplyMarkup:
      crmChatId* {.jsonName: "chat_id".}: int64
      crmReplyMarkupMessageId* {.jsonName: "reply_markup_message_id".}: int64
    of uChatDraftMessage:
      cdmChatId* {.jsonName: "chat_id".}: int64
      cdmDraftMessage* {.jsonName: "draft_message".}: DraftMessage
      cdmOrder* {.jsonName: "order".}: string
    of uChatOnlineMemberCount:
      comcChatId* {.jsonName: "chat_id".}: int64
      comcOnlineMemberCount* {.jsonName: "online_member_count".}: int32
    of uNotification:
      updatenotificatiNotificationGroupId* {.jsonName: "notification_group_id".}: int32
      updatenotificatiNotification* {.jsonName: "notification".}: Notification
    of uNotificationGroup:
      ngNotificationGroupId* {.jsonName: "notification_group_id".}: int32
      ngType* {.jsonName: "type".}: NotificationGroupType
      ngChatId* {.jsonName: "chat_id".}: int64
      ngNotificationSettingsChatId* {.jsonName: "notification_settings_chat_id".}: int64
      ngIsSilent* {.jsonName: "is_silent".}: bool
      ngTotalCount* {.jsonName: "total_count".}: int32
      ngAddedNotifications* {.jsonName: "added_notifications".}: seq[Notification]
      ngRemovedNotificationIds* {.jsonName: "removed_notification_ids".}: seq[int32]
    of uActiveNotifications:
      anGroups* {.jsonName: "groups".}: seq[NotificationGroup]
    of uHavePendingNotifications:
      hpnHaveDelayedNotifications* {.jsonName: "have_delayed_notifications".}: bool
      hpnHaveUnreceivedNotifications* {.jsonName: "have_unreceived_notifications".}: bool
    of uDeleteMessages:
      dmChatId* {.jsonName: "chat_id".}: int64
      dmMessageIds* {.jsonName: "message_ids".}: seq[int64]
      dmIsPermanent* {.jsonName: "is_permanent".}: bool
      dmFromCache* {.jsonName: "from_cache".}: bool
    of uUserChatAction:
      ucaChatId* {.jsonName: "chat_id".}: int64
      ucaUserId* {.jsonName: "user_id".}: int32
      ucaAction* {.jsonName: "action".}: ChatAction
    of uUserStatus:
      usUserId* {.jsonName: "user_id".}: int32
      usStatus* {.jsonName: "status".}: UserStatus
    of uUser:
      updateusUser* {.jsonName: "user".}: User
    of uBasicGroup:
      bgBasicGroup* {.jsonName: "basic_group".}: BasicGroup
    of uSupergroup:
      updatesupergroSupergroup* {.jsonName: "supergroup".}: Supergroup
    of uSecretChat:
      scSecretChat* {.jsonName: "secret_chat".}: SecretChat
    of uUserFullInfo:
      ufiUserId* {.jsonName: "user_id".}: int32
      ufiUserFullInfo* {.jsonName: "user_full_info".}: UserFullInfo
    of uBasicGroupFullInfo:
      bgfiBasicGroupId* {.jsonName: "basic_group_id".}: int32
      bgfiBasicGroupFullInfo* {.jsonName: "basic_group_full_info".}: BasicGroupFullInfo
    of uSupergroupFullInfo:
      sfiSupergroupId* {.jsonName: "supergroup_id".}: int32
      sfiSupergroupFullInfo* {.jsonName: "supergroup_full_info".}: SupergroupFullInfo
    of uServiceNotification:
      snType* {.jsonName: "type".}: string
      snContent* {.jsonName: "content".}: MessageContent
    of uFile:
      updatefiFile* {.jsonName: "file".}: File
    of uFileGenerationStart:
      fgsGenerationId* {.jsonName: "generation_id".}: string
      fgsOriginalPath* {.jsonName: "original_path".}: string
      fgsDestinationPath* {.jsonName: "destination_path".}: string
      fgsConversion* {.jsonName: "conversion".}: string
    of uFileGenerationStop:
      fgstopGenerationId* {.jsonName: "generation_id".}: string
    of uCall:
      updatecaCall* {.jsonName: "call".}: Call
    of uUserPrivacySettingRules:
      upsrSetting* {.jsonName: "setting".}: UserPrivacySetting
      upsrRules* {.jsonName: "rules".}: UserPrivacySettingRules
    of uUnreadMessageCount:
      umcChatList* {.jsonName: "chat_list".}: ChatList
      umcUnreadCount* {.jsonName: "unread_count".}: int32
      umcUnreadUnmutedCount* {.jsonName: "unread_unmuted_count".}: int32
    of uUnreadChatCount:
      uccChatList* {.jsonName: "chat_list".}: ChatList
      uccTotalCount* {.jsonName: "total_count".}: int32
      uccUnreadCount* {.jsonName: "unread_count".}: int32
      uccUnreadUnmutedCount* {.jsonName: "unread_unmuted_count".}: int32
      uccMarkedAsUnreadCount* {.jsonName: "marked_as_unread_count".}: int32
      uccMarkedAsUnreadUnmutedCount* {.jsonName: "marked_as_unread_unmuted_count".}: int32
    of uOption:
      updateoptiName* {.jsonName: "name".}: string
      updateoptiValue* {.jsonName: "value".}: OptionValue
    of uStickerSet:
      ssStickerSet* {.jsonName: "sticker_set".}: StickerSet
    of uInstalledStickerSets:
      issIsMasks* {.jsonName: "is_masks".}: bool
      issStickerSetIds* {.jsonName: "sticker_set_ids".}: seq[string]
    of uTrendingStickerSets:
      tssStickerSets* {.jsonName: "sticker_sets".}: StickerSets
    of uRecentStickers:
      rsIsAttached* {.jsonName: "is_attached".}: bool
      rsStickerIds* {.jsonName: "sticker_ids".}: seq[int32]
    of uFavoriteStickers:
      fsStickerIds* {.jsonName: "sticker_ids".}: seq[int32]
    of uSavedAnimations:
      saAnimationIds* {.jsonName: "animation_ids".}: seq[int32]
    of uSelectedBackground:
      sbForDarkTheme* {.jsonName: "for_dark_theme".}: bool
      sbBackground* {.jsonName: "background".}: Background
    of uLanguagePackStrings:
      lpsLocalizationTarget* {.jsonName: "localization_target".}: string
      lpsLanguagePackId* {.jsonName: "language_pack_id".}: string
      lpsStrings* {.jsonName: "strings".}: seq[LanguagePackString]
    of uConnectionState:
      csState* {.jsonName: "state".}: ConnectionState
    of uTermsOfService:
      tosTermsOfServiceId* {.jsonName: "terms_of_service_id".}: string
      tosTermsOfService* {.jsonName: "terms_of_service".}: TermsOfService
    of uUsersNearby:
      unUsersNearby* {.jsonName: "users_nearby".}: seq[ChatNearby]
    of uDiceEmojis:
      deEmojis* {.jsonName: "emojis".}: seq[string]
    of uNewInlineQuery:
      niqId* {.jsonName: "id".}: string
      niqSenderUserId* {.jsonName: "sender_user_id".}: int32
      niqUserLocation* {.jsonName: "user_location".}: Location
      niqQuery* {.jsonName: "query".}: string
      niqOffset* {.jsonName: "offset".}: string
    of uNewChosenInlineResult:
      ncirSenderUserId* {.jsonName: "sender_user_id".}: int32
      ncirUserLocation* {.jsonName: "user_location".}: Location
      ncirQuery* {.jsonName: "query".}: string
      ncirResultId* {.jsonName: "result_id".}: string
      ncirInlineMessageId* {.jsonName: "inline_message_id".}: string
    of uNewCallbackQuery:
      ncqId* {.jsonName: "id".}: string
      ncqSenderUserId* {.jsonName: "sender_user_id".}: int32
      ncqChatId* {.jsonName: "chat_id".}: int64
      ncqMessageId* {.jsonName: "message_id".}: int64
      ncqChatInstance* {.jsonName: "chat_instance".}: string
      ncqPayload* {.jsonName: "payload".}: CallbackQueryPayload
    of uNewInlineCallbackQuery:
      nicqId* {.jsonName: "id".}: string
      nicqSenderUserId* {.jsonName: "sender_user_id".}: int32
      nicqInlineMessageId* {.jsonName: "inline_message_id".}: string
      nicqChatInstance* {.jsonName: "chat_instance".}: string
      nicqPayload* {.jsonName: "payload".}: CallbackQueryPayload
    of uNewShippingQuery:
      nsqId* {.jsonName: "id".}: string
      nsqSenderUserId* {.jsonName: "sender_user_id".}: int32
      nsqInvoicePayload* {.jsonName: "invoice_payload".}: string
      nsqShippingAddress* {.jsonName: "shipping_address".}: Address
    of uNewPreCheckoutQuery:
      npcqId* {.jsonName: "id".}: string
      npcqSenderUserId* {.jsonName: "sender_user_id".}: int32
      npcqCurrency* {.jsonName: "currency".}: string
      npcqTotalAmount* {.jsonName: "total_amount".}: int64
      npcqInvoicePayload* {.jsonName: "invoice_payload".}: string
      npcqShippingOptionId* {.jsonName: "shipping_option_id".}: string
      npcqOrderInfo* {.jsonName: "order_info".}: OrderInfo
    of uNewCustomEvent:
      nceEvent* {.jsonName: "event".}: string
    of uNewCustomQuery:
      ncqueryId* {.jsonName: "id".}: string
      ncqData* {.jsonName: "data".}: string
      ncqTimeout* {.jsonName: "timeout".}: int32
    of uPoll:
      updatepoPoll* {.jsonName: "poll".}: Poll
    of uPollAnswer:
      paPollId* {.jsonName: "poll_id".}: string
      paUserId* {.jsonName: "user_id".}: int32
      paOptionIds* {.jsonName: "option_ids".}: seq[int32]

  StickerSets* = object
    kind* {.jsonName: "@type".}: string
    totalCount* {.jsonName: "total_count".}: int32
    sets* {.jsonName: "sets".}: seq[StickerSetInfo]

  CallStateKind* = enum
    csPending = "callStatePending",
    csDiscarded = "callStateDiscarded",
    csError = "callStateError",
    csExchangingKeys = "callStateExchangingKeys",
    csHangingUp = "callStateHangingUp",
    csReady = "callStateReady",

  CallState* = object
    case kind* {.jsonName: "@type".}: CallStateKind
    of csPending:
      callstatependiIsCreated* {.jsonName: "is_created".}: bool
      callstatependiIsReceived* {.jsonName: "is_received".}: bool
    of csExchangingKeys:
      discard
    of csReady:
      callstatereaProtocol* {.jsonName: "protocol".}: CallProtocol
      callstatereaConnections* {.jsonName: "connections".}: seq[CallConnection]
      callstatereaConfig* {.jsonName: "config".}: string
      callstatereaEncryptionKey* {.jsonName: "encryption_key".}: string
      callstatereaEmojis* {.jsonName: "emojis".}: seq[string]
      callstatereaAllowP2p* {.jsonName: "allow_p2p".}: bool
    of csHangingUp:
      discard
    of csDiscarded:
      callstatediscardReason* {.jsonName: "reason".}: CallDiscardReason
      callstatediscardNeedRating* {.jsonName: "need_rating".}: bool
      callstatediscardNeedDebugInformation* {.jsonName: "need_debug_information".}: bool
    of csError:
      callstateerrError* {.jsonName: "error".}: Error

  ChatEvent* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string
    date* {.jsonName: "date".}: int32
    userId* {.jsonName: "user_id".}: int32
    action* {.jsonName: "action".}: ChatEventAction

  NotificationTypeKind* = enum
    ntnMessage = "notificationTypeNewMessage",
    ntnSecretChat = "notificationTypeNewSecretChat",
    ntnCall = "notificationTypeNewCall",
    ntnPushMessage = "notificationTypeNewPushMessage",

  NotificationType* = object
    case kind* {.jsonName: "@type".}: NotificationTypeKind
    of ntnMessage:
      nmMessage* {.jsonName: "message".}: Message
    of ntnSecretChat:
      discard
    of ntnCall:
      ncCallId* {.jsonName: "call_id".}: int32
    of ntnPushMessage:
      npmMessageId* {.jsonName: "message_id".}: int64
      npmSenderUserId* {.jsonName: "sender_user_id".}: int32
      npmSenderName* {.jsonName: "sender_name".}: string
      npmIsOutgoing* {.jsonName: "is_outgoing".}: bool
      npmContent* {.jsonName: "content".}: PushMessageContent

  EncryptedPassportElement* = object
    kind* {.jsonName: "@type".}: string
    typ* {.jsonName: "type".}: PassportElementType
    data* {.jsonName: "data".}: string
    frontSide* {.jsonName: "front_side".}: DatedFile
    reverseSide* {.jsonName: "reverse_side".}: DatedFile
    selfie* {.jsonName: "selfie".}: DatedFile
    translation* {.jsonName: "translation".}: seq[DatedFile]
    files* {.jsonName: "files".}: seq[DatedFile]
    value* {.jsonName: "value".}: string
    hash* {.jsonName: "hash".}: string

  BasicGroup* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32
    memberCount* {.jsonName: "member_count".}: int32
    status* {.jsonName: "status".}: ChatMemberStatus
    isActive* {.jsonName: "is_active".}: bool
    upgradedToSupergroupId* {.jsonName: "upgraded_to_supergroup_id".}: int32

  RecoveryEmailAddress* = object
    kind* {.jsonName: "@type".}: string
    recoveryEmailAddress* {.jsonName: "recovery_email_address".}: string

  ChatPermissions* = object
    kind* {.jsonName: "@type".}: string
    canSendMessages* {.jsonName: "can_send_messages".}: bool
    canSendMediaMessages* {.jsonName: "can_send_media_messages".}: bool
    canSendPolls* {.jsonName: "can_send_polls".}: bool
    canSendOtherMessages* {.jsonName: "can_send_other_messages".}: bool
    canAddWebPagePreviews* {.jsonName: "can_add_web_page_previews".}: bool
    canChangeInfo* {.jsonName: "can_change_info".}: bool
    canInviteUsers* {.jsonName: "can_invite_users".}: bool
    canPinMessages* {.jsonName: "can_pin_messages".}: bool

  FileTypeKind* = enum
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

  FileType* = object
    case kind* {.jsonName: "@type".}: FileTypeKind
    of ftNone:
      discard
    of ftAnimation:
      discard
    of ftAudio:
      discard
    of ftDocument:
      discard
    of ftPhoto:
      discard
    of ftProfilePhoto:
      discard
    of ftSecret:
      discard
    of ftSecretThumbnail:
      discard
    of ftSecure:
      discard
    of ftSticker:
      discard
    of ftThumbnail:
      discard
    of ftUnknown:
      discard
    of ftVideo:
      discard
    of ftVideoNote:
      discard
    of ftVoiceNote:
      discard
    of ftWallpaper:
      discard

  ImportedContacts* = object
    kind* {.jsonName: "@type".}: string
    userIds* {.jsonName: "user_ids".}: seq[int32]
    importerCount* {.jsonName: "importer_count".}: seq[int32]

  Invoice* = object
    kind* {.jsonName: "@type".}: string
    currency* {.jsonName: "currency".}: string
    priceParts* {.jsonName: "price_parts".}: seq[LabeledPricePart]
    isTest* {.jsonName: "is_test".}: bool
    needName* {.jsonName: "need_name".}: bool
    needPhoneNumber* {.jsonName: "need_phone_number".}: bool
    needEmailAddress* {.jsonName: "need_email_address".}: bool
    needShippingAddress* {.jsonName: "need_shipping_address".}: bool
    sendPhoneNumberToProvider* {.jsonName: "send_phone_number_to_provider".}: bool
    sendEmailAddressToProvider* {.jsonName: "send_email_address_to_provider".}: bool
    isFlexible* {.jsonName: "is_flexible".}: bool

  ChatMember* = object
    kind* {.jsonName: "@type".}: string
    userId* {.jsonName: "user_id".}: int32
    inviterUserId* {.jsonName: "inviter_user_id".}: int32
    joinedChatDate* {.jsonName: "joined_chat_date".}: int32
    status* {.jsonName: "status".}: ChatMemberStatus
    botInfo* {.jsonName: "bot_info".}: BotInfo

  Minithumbnail* = object
    kind* {.jsonName: "@type".}: string
    width* {.jsonName: "width".}: int32
    height* {.jsonName: "height".}: int32
    data* {.jsonName: "data".}: string

  InlineQueryResults* = object
    kind* {.jsonName: "@type".}: string
    inlineQueryId* {.jsonName: "inline_query_id".}: string
    nextOffset* {.jsonName: "next_offset".}: string
    results* {.jsonName: "results".}: seq[InlineQueryResult]
    switchPmText* {.jsonName: "switch_pm_text".}: string
    switchPmParameter* {.jsonName: "switch_pm_parameter".}: string

  InlineKeyboardButton* = object
    kind* {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: string
    typ* {.jsonName: "type".}: InlineKeyboardButtonType

  JsonValueKind* = enum
    jvObject = "jsonValueObject",
    jvNull = "jsonValueNull",
    jvNumber = "jsonValueNumber",
    jvArray = "jsonValueArray",
    jvString = "jsonValueString",
    jvBoolean = "jsonValueBoolean",

  JsonValue* = object
    case kind* {.jsonName: "@type".}: JsonValueKind
    of jvNull:
      discard
    of jvBoolean:
      jsonvaluebooleValue* {.jsonName: "value".}: bool
    of jvNumber:
      jsonvaluenumbValue* {.jsonName: "value".}: float
    of jvString:
      jsonvaluestriValue* {.jsonName: "value".}: string
    of jvArray:
      jsonvaluearrValues* {.jsonName: "values".}: seq[JsonValue]
    of jvObject:
      jsonvalueobjeMembers* {.jsonName: "members".}: seq[JsonObjectMember]

  Game* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string
    shortName* {.jsonName: "short_name".}: string
    title* {.jsonName: "title".}: string
    text* {.jsonName: "text".}: FormattedText
    description* {.jsonName: "description".}: string
    photo* {.jsonName: "photo".}: Photo
    animation* {.jsonName: "animation".}: Animation

  ChatLocation* = object
    kind* {.jsonName: "@type".}: string
    location* {.jsonName: "location".}: Location
    address* {.jsonName: "address".}: string

  LanguagePackStringValueKind* = enum
    lpsvOrdinary = "languagePackStringValueOrdinary",
    lpsvDeleted = "languagePackStringValueDeleted",
    lpsvPluralized = "languagePackStringValuePluralized",

  LanguagePackStringValue* = object
    case kind* {.jsonName: "@type".}: LanguagePackStringValueKind
    of lpsvOrdinary:
      languagepackstringvalueordinaValue* {.jsonName: "value".}: string
    of lpsvPluralized:
      languagepackstringvaluepluralizZeroValue* {.jsonName: "zero_value".}: string
      languagepackstringvaluepluralizOneValue* {.jsonName: "one_value".}: string
      languagepackstringvaluepluralizTwoValue* {.jsonName: "two_value".}: string
      languagepackstringvaluepluralizFewValue* {.jsonName: "few_value".}: string
      languagepackstringvaluepluralizManyValue* {.jsonName: "many_value".}: string
      languagepackstringvaluepluralizOtherValue* {.jsonName: "other_value".}: string
    of lpsvDeleted:
      discard

  DeviceTokenKind* = enum
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

  DeviceToken* = object
    case kind* {.jsonName: "@type".}: DeviceTokenKind
    of dtFirebaseCloudMessaging:
      fcmToken* {.jsonName: "token".}: string
      fcmEncrypt* {.jsonName: "encrypt".}: bool
    of dtApplePush:
      apDeviceToken* {.jsonName: "device_token".}: string
      apIsAppSandbox* {.jsonName: "is_app_sandbox".}: bool
    of dtApplePushVoIP:
      apvipDeviceToken* {.jsonName: "device_token".}: string
      apvipIsAppSandbox* {.jsonName: "is_app_sandbox".}: bool
      apvipEncrypt* {.jsonName: "encrypt".}: bool
    of dtWindowsPush:
      wpAccessToken* {.jsonName: "access_token".}: string
    of dtMicrosoftPush:
      mpChannelUri* {.jsonName: "channel_uri".}: string
    of dtMicrosoftPushVoIP:
      mpvipChannelUri* {.jsonName: "channel_uri".}: string
    of dtWebPush:
      wpEndpoint* {.jsonName: "endpoint".}: string
      wpP256dhBase64url* {.jsonName: "p256dh_base64url".}: string
      wpAuthBase64url* {.jsonName: "auth_base64url".}: string
    of dtSimplePush:
      spEndpoint* {.jsonName: "endpoint".}: string
    of dtUbuntuPush:
      upToken* {.jsonName: "token".}: string
    of dtBlackBerryPush:
      bbpToken* {.jsonName: "token".}: string
    of dtTizenPush:
      tpRegId* {.jsonName: "reg_id".}: string

  PollTypeKind* = enum
    ptQuiz = "pollTypeQuiz",
    ptRegular = "pollTypeRegular",

  PollType* = object
    case kind* {.jsonName: "@type".}: PollTypeKind
    of ptRegular:
      polltyperegulAllowMultipleAnswers* {.jsonName: "allow_multiple_answers".}: bool
    of ptQuiz:
      polltypequCorrectOptionId* {.jsonName: "correct_option_id".}: int32
      polltypequExplanation* {.jsonName: "explanation".}: FormattedText

  NotificationGroupTypeKind* = enum
    ngtMessages = "notificationGroupTypeMessages",
    ngtCalls = "notificationGroupTypeCalls",
    ngtSecretChat = "notificationGroupTypeSecretChat",
    ngtMentions = "notificationGroupTypeMentions",

  NotificationGroupType* = object
    case kind* {.jsonName: "@type".}: NotificationGroupTypeKind
    of ngtMessages:
      discard
    of ngtMentions:
      discard
    of ngtSecretChat:
      discard
    of ngtCalls:
      discard

  ConnectionStateKind* {.pure.} = enum
    csUpdating = "connectionStateUpdating",
    csConnectingToProxy = "connectionStateConnectingToProxy",
    csReady = "connectionStateReady",
    csWaitingForNetwork = "connectionStateWaitingForNetwork",
    csConnecting = "connectionStateConnecting",

  ConnectionState* = object
    case kind* {.jsonName: "@type".}: ConnectionStateKind
    of csWaitingForNetwork:
      discard
    of csConnectingToProxy:
      discard
    of csConnecting:
      discard
    of csUpdating:
      discard
    of ConnectionStateKind.csReady:
      discard

  ChatNearby* = object
    kind* {.jsonName: "@type".}: string
    chatId* {.jsonName: "chat_id".}: int64
    distance* {.jsonName: "distance".}: int32

  LanguagePackString* = object
    kind* {.jsonName: "@type".}: string
    key* {.jsonName: "key".}: string
    value* {.jsonName: "value".}: LanguagePackStringValue

  ChatReportReasonKind* = enum
    crrChildAbuse = "chatReportReasonChildAbuse",
    crrUnrelatedLocation = "chatReportReasonUnrelatedLocation",
    crrSpam = "chatReportReasonSpam",
    crrViolence = "chatReportReasonViolence",
    crrPornography = "chatReportReasonPornography",
    crrCopyright = "chatReportReasonCopyright",
    crrCustom = "chatReportReasonCustom",

  ChatReportReason* = object
    case kind* {.jsonName: "@type".}: ChatReportReasonKind
    of crrSpam:
      discard
    of crrViolence:
      discard
    of crrPornography:
      discard
    of crrChildAbuse:
      discard
    of crrCopyright:
      discard
    of crrUnrelatedLocation:
      discard
    of crrCustom:
      chatreportreasoncustText* {.jsonName: "text".}: string

  AutoDownloadSettings* = object
    kind* {.jsonName: "@type".}: string
    isAutoDownloadEnabled* {.jsonName: "is_auto_download_enabled".}: bool
    maxPhotoFileSize* {.jsonName: "max_photo_file_size".}: int32
    maxVideoFileSize* {.jsonName: "max_video_file_size".}: int32
    maxOtherFileSize* {.jsonName: "max_other_file_size".}: int32
    videoUploadBitrate* {.jsonName: "video_upload_bitrate".}: int32
    preloadLargeVideos* {.jsonName: "preload_large_videos".}: bool
    preloadNextAudio* {.jsonName: "preload_next_audio".}: bool
    useLessDataForCalls* {.jsonName: "use_less_data_for_calls".}: bool

  MessageForwardInfo* = object
    kind* {.jsonName: "@type".}: string
    origin* {.jsonName: "origin".}: MessageForwardOrigin
    date* {.jsonName: "date".}: int32
    publicServiceAnnouncementType* {.jsonName: "public_service_announcement_type".}: string
    fromChatId* {.jsonName: "from_chat_id".}: int64
    fromMessageId* {.jsonName: "from_message_id".}: int64

  Text* = object
    kind* {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: string

  PaymentResult* = object
    kind* {.jsonName: "@type".}: string
    success* {.jsonName: "success".}: bool
    verificationUrl* {.jsonName: "verification_url".}: string

  InlineKeyboardButtonTypeKind* = enum
    ikbtBuy = "inlineKeyboardButtonTypeBuy",
    ikbtLoginUrl = "inlineKeyboardButtonTypeLoginUrl",
    ikbtUrl = "inlineKeyboardButtonTypeUrl",
    ikbtCallback = "inlineKeyboardButtonTypeCallback",
    ikbtSwitchInline = "inlineKeyboardButtonTypeSwitchInline",
    ikbtCallbackGame = "inlineKeyboardButtonTypeCallbackGame",

  InlineKeyboardButtonType* = object
    case kind* {.jsonName: "@type".}: InlineKeyboardButtonTypeKind
    of ikbtUrl:
      inlinekeyboardbuttontypeuUrl* {.jsonName: "url".}: string
    of ikbtLoginUrl:
      luUrl* {.jsonName: "url".}: string
      luId* {.jsonName: "id".}: int32
      luForwardText* {.jsonName: "forward_text".}: string
    of ikbtCallback:
      inlinekeyboardbuttontypecallbaData* {.jsonName: "data".}: string
    of ikbtCallbackGame:
      discard
    of ikbtSwitchInline:
      siQuery* {.jsonName: "query".}: string
      siInCurrentChat* {.jsonName: "in_current_chat".}: bool
    of ikbtBuy:
      discard

  MessageSchedulingStateKind* = enum
    msssWhenOnline = "messageSchedulingStateSendWhenOnline",
    msssAtDate = "messageSchedulingStateSendAtDate",

  MessageSchedulingState* = object
    case kind* {.jsonName: "@type".}: MessageSchedulingStateKind
    of msssAtDate:
      sadSendDate* {.jsonName: "send_date".}: int32
    of msssWhenOnline:
      discard

  TestVectorInt* = object
    kind* {.jsonName: "@type".}: string
    value* {.jsonName: "value".}: seq[int32]

  PaymentForm* = object
    kind* {.jsonName: "@type".}: string
    invoice* {.jsonName: "invoice".}: Invoice
    url* {.jsonName: "url".}: string
    paymentsProvider* {.jsonName: "payments_provider".}: PaymentsProviderStripe
    savedOrderInfo* {.jsonName: "saved_order_info".}: OrderInfo
    savedCredentials* {.jsonName: "saved_credentials".}: SavedCredentials
    canSaveCredentials* {.jsonName: "can_save_credentials".}: bool
    needPassword* {.jsonName: "need_password".}: bool

  Video* = object
    kind* {.jsonName: "@type".}: string
    duration* {.jsonName: "duration".}: int32
    width* {.jsonName: "width".}: int32
    height* {.jsonName: "height".}: int32
    fileName* {.jsonName: "file_name".}: string
    mimeType* {.jsonName: "mime_type".}: string
    hasStickers* {.jsonName: "has_stickers".}: bool
    supportsStreaming* {.jsonName: "supports_streaming".}: bool
    minithumbnail* {.jsonName: "minithumbnail".}: Minithumbnail
    thumbnail* {.jsonName: "thumbnail".}: PhotoSize
    video* {.jsonName: "video".}: File

  FormattedText* = object
    kind* {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: string
    entities* {.jsonName: "entities".}: seq[TextEntity]

  ChatAdministrator* = object
    kind* {.jsonName: "@type".}: string
    userId* {.jsonName: "user_id".}: int32
    customTitle* {.jsonName: "custom_title".}: string
    isOwner* {.jsonName: "is_owner".}: bool

  PassportElementKind* = enum
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

  PassportElement* = object
    case kind* {.jsonName: "@type".}: PassportElementKind
    of pePersonalDetails:
      pdPersonalDetails* {.jsonName: "personal_details".}: PersonalDetails
    of pePassport:
      passportelementpasspoPassport* {.jsonName: "passport".}: IdentityDocument
    of peDriverLicense:
      dlDriverLicense* {.jsonName: "driver_license".}: IdentityDocument
    of peIdentityCard:
      icIdentityCard* {.jsonName: "identity_card".}: IdentityDocument
    of peInternalPassport:
      ipInternalPassport* {.jsonName: "internal_passport".}: IdentityDocument
    of peAddress:
      passportelementaddreAddress* {.jsonName: "address".}: Address
    of peUtilityBill:
      ubUtilityBill* {.jsonName: "utility_bill".}: PersonalDocument
    of peBankStatement:
      bsBankStatement* {.jsonName: "bank_statement".}: PersonalDocument
    of peRentalAgreement:
      raRentalAgreement* {.jsonName: "rental_agreement".}: PersonalDocument
    of pePassportRegistration:
      prPassportRegistration* {.jsonName: "passport_registration".}: PersonalDocument
    of peTemporaryRegistration:
      trTemporaryRegistration* {.jsonName: "temporary_registration".}: PersonalDocument
    of pePhoneNumber:
      pnPhoneNumber* {.jsonName: "phone_number".}: string
    of peEmailAddress:
      eaEmailAddress* {.jsonName: "email_address".}: string

  StickerSet* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string
    title* {.jsonName: "title".}: string
    name* {.jsonName: "name".}: string
    thumbnail* {.jsonName: "thumbnail".}: PhotoSize
    isInstalled* {.jsonName: "is_installed".}: bool
    isArchived* {.jsonName: "is_archived".}: bool
    isOfficial* {.jsonName: "is_official".}: bool
    isAnimated* {.jsonName: "is_animated".}: bool
    isMasks* {.jsonName: "is_masks".}: bool
    isViewed* {.jsonName: "is_viewed".}: bool
    stickers* {.jsonName: "stickers".}: seq[Sticker]
    emojis* {.jsonName: "emojis".}: seq[Emojis]

  PublicMessageLink* = object
    kind* {.jsonName: "@type".}: string
    link* {.jsonName: "link".}: string
    html* {.jsonName: "html".}: string

  Chats* = object
    kind* {.jsonName: "@type".}: string
    chatIds* {.jsonName: "chat_ids".}: seq[int64]

  TextEntity* = object
    kind* {.jsonName: "@type".}: string
    offset* {.jsonName: "offset".}: int32
    length* {.jsonName: "length".}: int32
    typ* {.jsonName: "type".}: TextEntityType

  ChatInviteLinkInfo* = object
    kind* {.jsonName: "@type".}: string
    chatId* {.jsonName: "chat_id".}: int64
    typ* {.jsonName: "type".}: ChatType
    title* {.jsonName: "title".}: string
    photo* {.jsonName: "photo".}: ChatPhoto
    memberCount* {.jsonName: "member_count".}: int32
    memberUserIds* {.jsonName: "member_user_ids".}: seq[int32]
    isPublic* {.jsonName: "is_public".}: bool

  LogStreamKind* = enum
    lsFile = "logStreamFile",
    lsEmpty = "logStreamEmpty",
    lsDefault = "logStreamDefault",

  LogStream* = object
    case kind* {.jsonName: "@type".}: LogStreamKind
    of lsDefault:
      discard
    of lsFile:
      logstreamfiPath* {.jsonName: "path".}: string
      logstreamfiMaxFileSize* {.jsonName: "max_file_size".}: int64
    of lsEmpty:
      discard

  ChatPhoto* = object
    kind* {.jsonName: "@type".}: string
    small* {.jsonName: "small".}: File
    big* {.jsonName: "big".}: File

  PageBlockVerticalAlignmentKind* = enum
    pbvaMiddle = "pageBlockVerticalAlignmentMiddle",
    pbvaBottom = "pageBlockVerticalAlignmentBottom",
    pbvaTop = "pageBlockVerticalAlignmentTop",

  PageBlockVerticalAlignment* = object
    case kind* {.jsonName: "@type".}: PageBlockVerticalAlignmentKind
    of pbvaTop:
      discard
    of pbvaMiddle:
      discard
    of pbvaBottom:
      discard

  CallbackQueryAnswer* = object
    kind* {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: string
    showAlert* {.jsonName: "show_alert".}: bool
    url* {.jsonName: "url".}: string

  TMeUrlTypeKind* = enum
    tmutUser = "tMeUrlTypeUser",
    tmutSupergroup = "tMeUrlTypeSupergroup",
    tmutStickerSet = "tMeUrlTypeStickerSet",
    tmutChatInvite = "tMeUrlTypeChatInvite",

  TMeUrlType* = object
    case kind* {.jsonName: "@type".}: TMeUrlTypeKind
    of tmutUser:
      tmeurltypeusUserId* {.jsonName: "user_id".}: int32
    of tmutSupergroup:
      tmeurltypesupergroSupergroupId* {.jsonName: "supergroup_id".}: int64
    of tmutChatInvite:
      ciInfo* {.jsonName: "info".}: ChatInviteLinkInfo
    of tmutStickerSet:
      ssStickerSetId* {.jsonName: "sticker_set_id".}: string

  SendMessageOptions* = object
    kind* {.jsonName: "@type".}: string
    disableNotification* {.jsonName: "disable_notification".}: bool
    fromBackground* {.jsonName: "from_background".}: bool
    schedulingState* {.jsonName: "scheduling_state".}: MessageSchedulingState

  LogTags* = object
    kind* {.jsonName: "@type".}: string
    tags* {.jsonName: "tags".}: seq[string]

  GameHighScores* = object
    kind* {.jsonName: "@type".}: string
    scores* {.jsonName: "scores".}: seq[GameHighScore]

  KeyboardButtonTypeKind* = enum
    kbtRequestLocation = "keyboardButtonTypeRequestLocation",
    kbtRequestPhoneNumber = "keyboardButtonTypeRequestPhoneNumber",
    kbtRequestPoll = "keyboardButtonTypeRequestPoll",
    kbtText = "keyboardButtonTypeText",

  KeyboardButtonType* = object
    case kind* {.jsonName: "@type".}: KeyboardButtonTypeKind
    of kbtText:
      discard
    of kbtRequestPhoneNumber:
      discard
    of kbtRequestLocation:
      discard
    of kbtRequestPoll:
      rpForceRegular* {.jsonName: "force_regular".}: bool
      rpForceQuiz* {.jsonName: "force_quiz".}: bool

  InputIdentityDocument* = object
    kind* {.jsonName: "@type".}: string
    number* {.jsonName: "number".}: string
    expiryDate* {.jsonName: "expiry_date".}: Date
    frontSide* {.jsonName: "front_side".}: InputFile
    reverseSide* {.jsonName: "reverse_side".}: InputFile
    selfie* {.jsonName: "selfie".}: InputFile
    translation* {.jsonName: "translation".}: seq[InputFile]

  TemporaryPasswordState* = object
    kind* {.jsonName: "@type".}: string
    hasPassword* {.jsonName: "has_password".}: bool
    validFor* {.jsonName: "valid_for".}: int32

  Animations* = object
    kind* {.jsonName: "@type".}: string
    animations* {.jsonName: "animations".}: seq[Animation]

  OptionValueKind* = enum
    ovEmpty = "optionValueEmpty",
    ovInteger = "optionValueInteger",
    ovBoolean = "optionValueBoolean",
    ovString = "optionValueString",

  OptionValue* = object
    case kind* {.jsonName: "@type".}: OptionValueKind
    of ovBoolean:
      optionvaluebooleValue* {.jsonName: "value".}: bool
    of ovEmpty:
      discard
    of ovInteger:
      optionvalueintegValue* {.jsonName: "value".}: int32
    of ovString:
      optionvaluestriValue* {.jsonName: "value".}: string

  InputPassportElementKind* = enum
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

  InputPassportElement* = object
    case kind* {.jsonName: "@type".}: InputPassportElementKind
    of ipePersonalDetails:
      pdPersonalDetails* {.jsonName: "personal_details".}: PersonalDetails
    of ipePassport:
      inputpassportelementpasspoPassport* {.jsonName: "passport".}: InputIdentityDocument
    of ipeDriverLicense:
      dlDriverLicense* {.jsonName: "driver_license".}: InputIdentityDocument
    of ipeIdentityCard:
      icIdentityCard* {.jsonName: "identity_card".}: InputIdentityDocument
    of ipeInternalPassport:
      ipInternalPassport* {.jsonName: "internal_passport".}: InputIdentityDocument
    of ipeAddress:
      inputpassportelementaddreAddress* {.jsonName: "address".}: Address
    of ipeUtilityBill:
      ubUtilityBill* {.jsonName: "utility_bill".}: InputPersonalDocument
    of ipeBankStatement:
      bsBankStatement* {.jsonName: "bank_statement".}: InputPersonalDocument
    of ipeRentalAgreement:
      raRentalAgreement* {.jsonName: "rental_agreement".}: InputPersonalDocument
    of ipePassportRegistration:
      prPassportRegistration* {.jsonName: "passport_registration".}: InputPersonalDocument
    of ipeTemporaryRegistration:
      trTemporaryRegistration* {.jsonName: "temporary_registration".}: InputPersonalDocument
    of ipePhoneNumber:
      pnPhoneNumber* {.jsonName: "phone_number".}: string
    of ipeEmailAddress:
      eaEmailAddress* {.jsonName: "email_address".}: string

  BankCardActionOpenUrl* = object
    kind* {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: string
    url* {.jsonName: "url".}: string

  CallbackQueryPayloadKind* = enum
    cqpData = "callbackQueryPayloadData",
    cqpGame = "callbackQueryPayloadGame",

  CallbackQueryPayload* = object
    case kind* {.jsonName: "@type".}: CallbackQueryPayloadKind
    of cqpData:
      callbackquerypayloaddaData* {.jsonName: "data".}: string
    of cqpGame:
      callbackquerypayloadgaGameShortName* {.jsonName: "game_short_name".}: string

  ShippingOption* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string
    title* {.jsonName: "title".}: string
    priceParts* {.jsonName: "price_parts".}: seq[LabeledPricePart]

  PageBlockCaption* = object
    kind* {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: RichText
    credit* {.jsonName: "credit".}: RichText

  Sessions* = object
    kind* {.jsonName: "@type".}: string
    sessions* {.jsonName: "sessions".}: seq[Session]

  Location* = object
    kind* {.jsonName: "@type".}: string
    latitude* {.jsonName: "latitude".}: float
    longitude* {.jsonName: "longitude".}: float

  AuthenticationCodeTypeKind* = enum
    actFlashCall = "authenticationCodeTypeFlashCall",
    actTelegramMessage = "authenticationCodeTypeTelegramMessage",
    actSms = "authenticationCodeTypeSms",
    actCall = "authenticationCodeTypeCall",

  AuthenticationCodeType* = object
    case kind* {.jsonName: "@type".}: AuthenticationCodeTypeKind
    of actTelegramMessage:
      tmLength* {.jsonName: "length".}: int32
    of actSms:
      authenticationcodetypesLength* {.jsonName: "length".}: int32
    of actCall:
      authenticationcodetypecaLength* {.jsonName: "length".}: int32
    of actFlashCall:
      fcPattern* {.jsonName: "pattern".}: string

  TextEntities* = object
    kind* {.jsonName: "@type".}: string
    entities* {.jsonName: "entities".}: seq[TextEntity]

  Background* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string
    isDefault* {.jsonName: "is_default".}: bool
    isDark* {.jsonName: "is_dark".}: bool
    name* {.jsonName: "name".}: string
    document* {.jsonName: "document".}: Document
    typ* {.jsonName: "type".}: BackgroundType

  TestVectorStringObject* = object
    kind* {.jsonName: "@type".}: string
    value* {.jsonName: "value".}: seq[TestString]

  ChatActionKind* = enum
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

  ChatAction* = object
    case kind* {.jsonName: "@type".}: ChatActionKind
    of caTyping:
      discard
    of caRecordingVideo:
      discard
    of caUploadingVideo:
      uvProgress* {.jsonName: "progress".}: int32
    of caRecordingVoiceNote:
      discard
    of caUploadingVoiceNote:
      uvnProgress* {.jsonName: "progress".}: int32
    of caUploadingPhoto:
      upProgress* {.jsonName: "progress".}: int32
    of caUploadingDocument:
      udProgress* {.jsonName: "progress".}: int32
    of caChoosingLocation:
      discard
    of caChoosingContact:
      discard
    of caStartPlayingGame:
      discard
    of caRecordingVideoNote:
      discard
    of caUploadingVideoNote:
      uvnoteProgress* {.jsonName: "progress".}: int32
    of caCancel:
      discard

  SupergroupFullInfo* = object
    kind* {.jsonName: "@type".}: string
    description* {.jsonName: "description".}: string
    memberCount* {.jsonName: "member_count".}: int32
    administratorCount* {.jsonName: "administrator_count".}: int32
    restrictedCount* {.jsonName: "restricted_count".}: int32
    bannedCount* {.jsonName: "banned_count".}: int32
    linkedChatId* {.jsonName: "linked_chat_id".}: int64
    slowModeDelay* {.jsonName: "slow_mode_delay".}: int32
    slowModeDelayExpiresIn* {.jsonName: "slow_mode_delay_expires_in".}: float
    canGetMembers* {.jsonName: "can_get_members".}: bool
    canSetUsername* {.jsonName: "can_set_username".}: bool
    canSetStickerSet* {.jsonName: "can_set_sticker_set".}: bool
    canSetLocation* {.jsonName: "can_set_location".}: bool
    canViewStatistics* {.jsonName: "can_view_statistics".}: bool
    isAllHistoryAvailable* {.jsonName: "is_all_history_available".}: bool
    stickerSetId* {.jsonName: "sticker_set_id".}: string
    location* {.jsonName: "location".}: ChatLocation
    inviteLink* {.jsonName: "invite_link".}: string
    upgradedFromBasicGroupId* {.jsonName: "upgraded_from_basic_group_id".}: int32
    upgradedFromMaxMessageId* {.jsonName: "upgraded_from_max_message_id".}: int64

  StorageStatisticsByChat* = object
    kind* {.jsonName: "@type".}: string
    chatId* {.jsonName: "chat_id".}: int64
    size* {.jsonName: "size".}: int64
    count* {.jsonName: "count".}: int32
    byFileType* {.jsonName: "by_file_type".}: seq[StorageStatisticsByFileType]

  SavedCredentials* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string
    title* {.jsonName: "title".}: string

  PhotoSize* = object
    kind* {.jsonName: "@type".}: string
    typ* {.jsonName: "type".}: string
    photo* {.jsonName: "photo".}: File
    width* {.jsonName: "width".}: int32
    height* {.jsonName: "height".}: int32

  StorageStatistics* = object
    kind* {.jsonName: "@type".}: string
    size* {.jsonName: "size".}: int64
    count* {.jsonName: "count".}: int32
    byChat* {.jsonName: "by_chat".}: seq[StorageStatisticsByChat]

  RemoteFile* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string
    uniqueId* {.jsonName: "unique_id".}: string
    isUploadingActive* {.jsonName: "is_uploading_active".}: bool
    isUploadingCompleted* {.jsonName: "is_uploading_completed".}: bool
    uploadedSize* {.jsonName: "uploaded_size".}: int32

  MaskPointKind* = enum
    mpForehead = "maskPointForehead",
    mpEyes = "maskPointEyes",
    mpChin = "maskPointChin",
    mpMouth = "maskPointMouth",

  MaskPoint* = object
    case kind* {.jsonName: "@type".}: MaskPointKind
    of mpForehead:
      discard
    of mpEyes:
      discard
    of mpMouth:
      discard
    of mpChin:
      discard

  WebPageInstantView* = object
    kind* {.jsonName: "@type".}: string
    pageBlocks* {.jsonName: "page_blocks".}: seq[PageBlock]
    viewCount* {.jsonName: "view_count".}: int32
    version* {.jsonName: "version".}: int32
    isRtl* {.jsonName: "is_rtl".}: bool
    isFull* {.jsonName: "is_full".}: bool

  UserPrivacySettingRules* = object
    kind* {.jsonName: "@type".}: string
    rules* {.jsonName: "rules".}: seq[UserPrivacySettingRule]

  ConnectedWebsites* = object
    kind* {.jsonName: "@type".}: string
    websites* {.jsonName: "websites".}: seq[ConnectedWebsite]

  MessageLinkInfo* = object
    kind* {.jsonName: "@type".}: string
    isPublic* {.jsonName: "is_public".}: bool
    chatId* {.jsonName: "chat_id".}: int64
    message* {.jsonName: "message".}: Message
    forAlbum* {.jsonName: "for_album".}: bool

  AccountTtl* = object
    kind* {.jsonName: "@type".}: string
    days* {.jsonName: "days".}: int32

  Count* = object
    kind* {.jsonName: "@type".}: string
    count* {.jsonName: "count".}: int32

  StatisticsGraphKind* = enum
    sgAsync = "statisticsGraphAsync",
    sgData = "statisticsGraphData",
    sgError = "statisticsGraphError",

  StatisticsGraph* = object
    case kind* {.jsonName: "@type".}: StatisticsGraphKind
    of sgData:
      statisticsgraphdaJsonData* {.jsonName: "json_data".}: string
      statisticsgraphdaZoomToken* {.jsonName: "zoom_token".}: string
    of sgAsync:
      statisticsgraphasyToken* {.jsonName: "token".}: string
    of sgError:
      statisticsgrapherrErrorMessage* {.jsonName: "error_message".}: string

  PaymentsProviderStripe* = object
    kind* {.jsonName: "@type".}: string
    publishableKey* {.jsonName: "publishable_key".}: string
    needCountry* {.jsonName: "need_country".}: bool
    needPostalCode* {.jsonName: "need_postal_code".}: bool
    needCardholderName* {.jsonName: "need_cardholder_name".}: bool

  StatisticsValue* = object
    kind* {.jsonName: "@type".}: string
    value* {.jsonName: "value".}: float
    previousValue* {.jsonName: "previous_value".}: float
    growthRatePercentage* {.jsonName: "growth_rate_percentage".}: float

  ChatEvents* = object
    kind* {.jsonName: "@type".}: string
    events* {.jsonName: "events".}: seq[ChatEvent]

  GameHighScore* = object
    kind* {.jsonName: "@type".}: string
    position* {.jsonName: "position".}: int32
    userId* {.jsonName: "user_id".}: int32
    score* {.jsonName: "score".}: int32

  NotificationGroup* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32
    typ* {.jsonName: "type".}: NotificationGroupType
    chatId* {.jsonName: "chat_id".}: int64
    totalCount* {.jsonName: "total_count".}: int32
    notifications* {.jsonName: "notifications".}: seq[Notification]

  ProfilePhoto* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: string
    small* {.jsonName: "small".}: File
    big* {.jsonName: "big".}: File

  File* = object
    kind* {.jsonName: "@type".}: string
    id* {.jsonName: "id".}: int32
    size* {.jsonName: "size".}: int32
    expectedSize* {.jsonName: "expected_size".}: int32
    local* {.jsonName: "local".}: LocalFile
    remote* {.jsonName: "remote".}: RemoteFile

  UserProfilePhotos* = object
    kind* {.jsonName: "@type".}: string
    totalCount* {.jsonName: "total_count".}: int32
    photos* {.jsonName: "photos".}: seq[UserProfilePhoto]

  FilePart* = object
    kind* {.jsonName: "@type".}: string
    data* {.jsonName: "data".}: string

  MessageSendingStateKind* = enum
    mssFailed = "messageSendingStateFailed",
    mssPending = "messageSendingStatePending",

  MessageSendingState* = object
    case kind* {.jsonName: "@type".}: MessageSendingStateKind
    of mssPending:
      discard
    of mssFailed:
      messagesendingstatefailErrorCode* {.jsonName: "error_code".}: int32
      messagesendingstatefailErrorMessage* {.jsonName: "error_message".}: string
      messagesendingstatefailCanRetry* {.jsonName: "can_retry".}: bool
      messagesendingstatefailRetryAfter* {.jsonName: "retry_after".}: float

  InlineQueryResultKind* = enum
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

  InlineQueryResult* = object
    case kind* {.jsonName: "@type".}: InlineQueryResultKind
    of iqrArticle:
      inlinequeryresultarticId* {.jsonName: "id".}: string
      inlinequeryresultarticUrl* {.jsonName: "url".}: string
      inlinequeryresultarticHideUrl* {.jsonName: "hide_url".}: bool
      inlinequeryresultarticTitle* {.jsonName: "title".}: string
      inlinequeryresultarticDescription* {.jsonName: "description".}: string
      inlinequeryresultarticThumbnail* {.jsonName: "thumbnail".}: PhotoSize
    of iqrContact:
      inlinequeryresultcontaId* {.jsonName: "id".}: string
      inlinequeryresultcontaContact* {.jsonName: "contact".}: Contact
      inlinequeryresultcontaThumbnail* {.jsonName: "thumbnail".}: PhotoSize
    of iqrLocation:
      inlinequeryresultlocatiId* {.jsonName: "id".}: string
      inlinequeryresultlocatiLocation* {.jsonName: "location".}: Location
      inlinequeryresultlocatiTitle* {.jsonName: "title".}: string
      inlinequeryresultlocatiThumbnail* {.jsonName: "thumbnail".}: PhotoSize
    of iqrVenue:
      inlinequeryresultvenId* {.jsonName: "id".}: string
      inlinequeryresultvenVenue* {.jsonName: "venue".}: Venue
      inlinequeryresultvenThumbnail* {.jsonName: "thumbnail".}: PhotoSize
    of iqrGame:
      inlinequeryresultgaId* {.jsonName: "id".}: string
      inlinequeryresultgaGame* {.jsonName: "game".}: Game
    of iqrAnimation:
      inlinequeryresultanimatiId* {.jsonName: "id".}: string
      inlinequeryresultanimatiAnimation* {.jsonName: "animation".}: Animation
      inlinequeryresultanimatiTitle* {.jsonName: "title".}: string
    of iqrAudio:
      inlinequeryresultaudId* {.jsonName: "id".}: string
      inlinequeryresultaudAudio* {.jsonName: "audio".}: Audio
    of iqrDocument:
      inlinequeryresultdocumeId* {.jsonName: "id".}: string
      inlinequeryresultdocumeDocument* {.jsonName: "document".}: Document
      inlinequeryresultdocumeTitle* {.jsonName: "title".}: string
      inlinequeryresultdocumeDescription* {.jsonName: "description".}: string
    of iqrPhoto:
      inlinequeryresultphoId* {.jsonName: "id".}: string
      inlinequeryresultphoPhoto* {.jsonName: "photo".}: Photo
      inlinequeryresultphoTitle* {.jsonName: "title".}: string
      inlinequeryresultphoDescription* {.jsonName: "description".}: string
    of iqrSticker:
      inlinequeryresultstickId* {.jsonName: "id".}: string
      inlinequeryresultstickSticker* {.jsonName: "sticker".}: Sticker
    of iqrVideo:
      inlinequeryresultvidId* {.jsonName: "id".}: string
      inlinequeryresultvidVideo* {.jsonName: "video".}: Video
      inlinequeryresultvidTitle* {.jsonName: "title".}: string
      inlinequeryresultvidDescription* {.jsonName: "description".}: string
    of iqrVoiceNote:
      vnId* {.jsonName: "id".}: string
      vnVoiceNote* {.jsonName: "voice_note".}: VoiceNote
      vnTitle* {.jsonName: "title".}: string

  TextParseModeKind* = enum
    tpmHTML = "textParseModeHTML",
    tpmMarkdown = "textParseModeMarkdown",

  TextParseMode* = object
    case kind* {.jsonName: "@type".}: TextParseModeKind
    of tpmMarkdown:
      textparsemodemarkdoVersion* {.jsonName: "version".}: int32
    of tpmHTML:
      discard

  ChatStatistics* = object
    kind* {.jsonName: "@type".}: string
    period* {.jsonName: "period".}: DateRange
    memberCount* {.jsonName: "member_count".}: StatisticsValue
    meanViewCount* {.jsonName: "mean_view_count".}: StatisticsValue
    meanShareCount* {.jsonName: "mean_share_count".}: StatisticsValue
    enabledNotificationsPercentage* {.jsonName: "enabled_notifications_percentage".}: float
    memberCountGraph* {.jsonName: "member_count_graph".}: StatisticsGraph
    joinGraph* {.jsonName: "join_graph".}: StatisticsGraph
    muteGraph* {.jsonName: "mute_graph".}: StatisticsGraph
    viewCountByHourGraph* {.jsonName: "view_count_by_hour_graph".}: StatisticsGraph
    viewCountBySourceGraph* {.jsonName: "view_count_by_source_graph".}: StatisticsGraph
    joinBySourceGraph* {.jsonName: "join_by_source_graph".}: StatisticsGraph
    languageGraph* {.jsonName: "language_graph".}: StatisticsGraph
    messageInteractionGraph* {.jsonName: "message_interaction_graph".}: StatisticsGraph
    instantViewInteractionGraph* {.jsonName: "instant_view_interaction_graph".}: StatisticsGraph
    recentMessageInteractions* {.jsonName: "recent_message_interactions".}: seq[ChatStatisticsMessageInteractionCounters]

  PublicChatTypeKind* = enum
    pctIsLocationBased = "publicChatTypeIsLocationBased",
    pctHasUsername = "publicChatTypeHasUsername",

  PublicChatType* = object
    case kind* {.jsonName: "@type".}: PublicChatTypeKind
    of pctHasUsername:
      discard
    of pctIsLocationBased:
      discard

  ChatActionBarKind* = enum
    cabReportSpam = "chatActionBarReportSpam",
    cabAddContact = "chatActionBarAddContact",
    cabReportUnrelatedLocation = "chatActionBarReportUnrelatedLocation",
    cabSharePhoneNumber = "chatActionBarSharePhoneNumber",
    cabReportAddBlock = "chatActionBarReportAddBlock",

  ChatActionBar* = object
    case kind* {.jsonName: "@type".}: ChatActionBarKind
    of cabReportSpam:
      discard
    of cabReportUnrelatedLocation:
      discard
    of cabReportAddBlock:
      discard
    of cabAddContact:
      discard
    of cabSharePhoneNumber:
      discard

  Document* = object
    kind* {.jsonName: "@type".}: string
    fileName* {.jsonName: "file_name".}: string
    mimeType* {.jsonName: "mime_type".}: string
    minithumbnail* {.jsonName: "minithumbnail".}: Minithumbnail
    thumbnail* {.jsonName: "thumbnail".}: PhotoSize
    document* {.jsonName: "document".}: File

  ScopeNotificationSettings* = object
    kind* {.jsonName: "@type".}: string
    muteFor* {.jsonName: "mute_for".}: int32
    sound* {.jsonName: "sound".}: string
    showPreview* {.jsonName: "show_preview".}: bool
    disablePinnedMessageNotifications* {.jsonName: "disable_pinned_message_notifications".}: bool
    disableMentionNotifications* {.jsonName: "disable_mention_notifications".}: bool

  InputCredentialsKind* = enum
    icAndroidPay = "inputCredentialsAndroidPay",
    icApplePay = "inputCredentialsApplePay",
    icNew = "inputCredentialsNew",
    icSaved = "inputCredentialsSaved",

  InputCredentials* = object
    case kind* {.jsonName: "@type".}: InputCredentialsKind
    of icSaved:
      inputcredentialssavSavedCredentialsId* {.jsonName: "saved_credentials_id".}: string
    of icNew:
      inputcredentialsnData* {.jsonName: "data".}: string
      inputcredentialsnAllowSave* {.jsonName: "allow_save".}: bool
    of icAndroidPay:
      apData* {.jsonName: "data".}: string
    of icApplePay:
      apayData* {.jsonName: "data".}: string

  Audio* = object
    kind* {.jsonName: "@type".}: string
    duration* {.jsonName: "duration".}: int32
    title* {.jsonName: "title".}: string
    performer* {.jsonName: "performer".}: string
    fileName* {.jsonName: "file_name".}: string
    mimeType* {.jsonName: "mime_type".}: string
    albumCoverMinithumbnail* {.jsonName: "album_cover_minithumbnail".}: Minithumbnail
    albumCoverThumbnail* {.jsonName: "album_cover_thumbnail".}: PhotoSize
    audio* {.jsonName: "audio".}: File

  PassportElementsWithErrors* = object
    kind* {.jsonName: "@type".}: string
    elements* {.jsonName: "elements".}: seq[PassportElement]
    errors* {.jsonName: "errors".}: seq[PassportElementError]

  VideoNote* = object
    kind* {.jsonName: "@type".}: string
    duration* {.jsonName: "duration".}: int32
    length* {.jsonName: "length".}: int32
    minithumbnail* {.jsonName: "minithumbnail".}: Minithumbnail
    thumbnail* {.jsonName: "thumbnail".}: PhotoSize
    video* {.jsonName: "video".}: File

  TMeUrl* = object
    kind* {.jsonName: "@type".}: string
    url* {.jsonName: "url".}: string
    typ* {.jsonName: "type".}: TMeUrlType

  Seconds* = object
    kind* {.jsonName: "@type".}: string
    seconds* {.jsonName: "seconds".}: float

  CallProblemKind* = enum
    cpSilentLocal = "callProblemSilentLocal",
    cpDropped = "callProblemDropped",
    cpSilentRemote = "callProblemSilentRemote",
    cpDistortedSpeech = "callProblemDistortedSpeech",
    cpEcho = "callProblemEcho",
    cpNoise = "callProblemNoise",
    cpInterruptions = "callProblemInterruptions",

  CallProblem* = object
    case kind* {.jsonName: "@type".}: CallProblemKind
    of cpEcho:
      discard
    of cpNoise:
      discard
    of cpInterruptions:
      discard
    of cpDistortedSpeech:
      discard
    of cpSilentLocal:
      discard
    of cpSilentRemote:
      discard
    of cpDropped:
      discard

  DeepLinkInfo* = object
    kind* {.jsonName: "@type".}: string
    text* {.jsonName: "text".}: FormattedText
    needUpdateApplication* {.jsonName: "need_update_application".}: bool

  UserStatusKind* = enum
    usRecently = "userStatusRecently",
    usOffline = "userStatusOffline",
    usEmpty = "userStatusEmpty",
    usLastWeek = "userStatusLastWeek",
    usOnline = "userStatusOnline",
    usLastMonth = "userStatusLastMonth",

  UserStatus* = object
    case kind* {.jsonName: "@type".}: UserStatusKind
    of usEmpty:
      discard
    of usOnline:
      userstatusonliExpires* {.jsonName: "expires".}: int32
    of usOffline:
      userstatusoffliWasOnline* {.jsonName: "was_online".}: int32
    of usRecently:
      discard
    of usLastWeek:
      discard
    of usLastMonth:
      discard

  SupergroupMembersFilterKind* = enum
    smfAdministrators = "supergroupMembersFilterAdministrators",
    smfBots = "supergroupMembersFilterBots",
    smfContacts = "supergroupMembersFilterContacts",
    smfBanned = "supergroupMembersFilterBanned",
    smfSearch = "supergroupMembersFilterSearch",
    smfRestricted = "supergroupMembersFilterRestricted",
    smfRecent = "supergroupMembersFilterRecent",

  SupergroupMembersFilter* = object
    case kind* {.jsonName: "@type".}: SupergroupMembersFilterKind
    of smfRecent:
      discard
    of smfContacts:
      supergroupmembersfiltercontacQuery* {.jsonName: "query".}: string
    of smfAdministrators:
      discard
    of smfSearch:
      supergroupmembersfiltersearQuery* {.jsonName: "query".}: string
    of smfRestricted:
      supergroupmembersfilterrestrictQuery* {.jsonName: "query".}: string
    of smfBanned:
      supergroupmembersfilterbannQuery* {.jsonName: "query".}: string
    of smfBots:
      discard

  UserTypeKind* = enum
    utRegular = "userTypeRegular",
    utUnknown = "userTypeUnknown",
    utBot = "userTypeBot",
    utDeleted = "userTypeDeleted",

  UserType* = object
    case kind* {.jsonName: "@type".}: UserTypeKind
    of utRegular:
      discard
    of utDeleted:
      discard
    of utBot:
      usertypebCanJoinGroups* {.jsonName: "can_join_groups".}: bool
      usertypebCanReadAllGroupMessages* {.jsonName: "can_read_all_group_messages".}: bool
      usertypebIsInline* {.jsonName: "is_inline".}: bool
      usertypebInlineQueryPlaceholder* {.jsonName: "inline_query_placeholder".}: string
      usertypebNeedLocation* {.jsonName: "need_location".}: bool
    of utUnknown:
      discard

  OrderInfo* = object
    kind* {.jsonName: "@type".}: string
    name* {.jsonName: "name".}: string
    phoneNumber* {.jsonName: "phone_number".}: string
    emailAddress* {.jsonName: "email_address".}: string
    shippingAddress* {.jsonName: "shipping_address".}: Address

  ChatTypeKind* = enum
    ctBasicGroup = "chatTypeBasicGroup",
    ctSupergroup = "chatTypeSupergroup",
    ctSecret = "chatTypeSecret",
    ctPrivate = "chatTypePrivate",

  ChatType* = object
    case kind* {.jsonName: "@type".}: ChatTypeKind
    of ctPrivate:
      chattypeprivaUserId* {.jsonName: "user_id".}: int32
    of ctBasicGroup:
      bgBasicGroupId* {.jsonName: "basic_group_id".}: int32
    of ctSupergroup:
      chattypesupergroSupergroupId* {.jsonName: "supergroup_id".}: int32
      chattypesupergroIsChannel* {.jsonName: "is_channel".}: bool
    of ctSecret:
      chattypesecrSecretChatId* {.jsonName: "secret_chat_id".}: int32
      chattypesecrUserId* {.jsonName: "user_id".}: int32

  AuthenticationCodeInfo* = object
    kind* {.jsonName: "@type".}: string
    phoneNumber* {.jsonName: "phone_number".}: string
    typ* {.jsonName: "type".}: AuthenticationCodeType
    nextType* {.jsonName: "next_type".}: AuthenticationCodeType
    timeout* {.jsonName: "timeout".}: int32

  PassportSuitableElement* = object
    kind* {.jsonName: "@type".}: string
    typ* {.jsonName: "type".}: PassportElementType
    isSelfieRequired* {.jsonName: "is_selfie_required".}: bool
    isTranslationRequired* {.jsonName: "is_translation_required".}: bool
    isNativeNameRequired* {.jsonName: "is_native_name_required".}: bool

  InputMessageContentKind* = enum
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

  InputMessageContent* = object
    case kind* {.jsonName: "@type".}: InputMessageContentKind
    of imText:
      mtText* {.jsonName: "text".}: FormattedText
      mtDisableWebPagePreview* {.jsonName: "disable_web_page_preview".}: bool
      mtClearDraft* {.jsonName: "clear_draft".}: bool
    of imAnimation:
      maAnimation* {.jsonName: "animation".}: InputFile
      maThumbnail* {.jsonName: "thumbnail".}: InputThumbnail
      maDuration* {.jsonName: "duration".}: int32
      maWidth* {.jsonName: "width".}: int32
      maHeight* {.jsonName: "height".}: int32
      maCaption* {.jsonName: "caption".}: FormattedText
    of imAudio:
      maAudio* {.jsonName: "audio".}: InputFile
      maAlbumCoverThumbnail* {.jsonName: "album_cover_thumbnail".}: InputThumbnail
      maudioDuration* {.jsonName: "duration".}: int32
      maTitle* {.jsonName: "title".}: string
      maPerformer* {.jsonName: "performer".}: string
      maudioCaption* {.jsonName: "caption".}: FormattedText
    of imDocument:
      mdDocument* {.jsonName: "document".}: InputFile
      mdThumbnail* {.jsonName: "thumbnail".}: InputThumbnail
      mdCaption* {.jsonName: "caption".}: FormattedText
    of imPhoto:
      mpPhoto* {.jsonName: "photo".}: InputFile
      mpThumbnail* {.jsonName: "thumbnail".}: InputThumbnail
      mpAddedStickerFileIds* {.jsonName: "added_sticker_file_ids".}: seq[int32]
      mpWidth* {.jsonName: "width".}: int32
      mpHeight* {.jsonName: "height".}: int32
      mpCaption* {.jsonName: "caption".}: FormattedText
      mpTtl* {.jsonName: "ttl".}: int32
    of imSticker:
      msSticker* {.jsonName: "sticker".}: InputFile
      msThumbnail* {.jsonName: "thumbnail".}: InputThumbnail
      msWidth* {.jsonName: "width".}: int32
      msHeight* {.jsonName: "height".}: int32
    of imVideo:
      mvVideo* {.jsonName: "video".}: InputFile
      mvThumbnail* {.jsonName: "thumbnail".}: InputThumbnail
      mvAddedStickerFileIds* {.jsonName: "added_sticker_file_ids".}: seq[int32]
      mvDuration* {.jsonName: "duration".}: int32
      mvWidth* {.jsonName: "width".}: int32
      mvHeight* {.jsonName: "height".}: int32
      mvSupportsStreaming* {.jsonName: "supports_streaming".}: bool
      mvCaption* {.jsonName: "caption".}: FormattedText
      mvTtl* {.jsonName: "ttl".}: int32
    of imVideoNote:
      mvnVideoNote* {.jsonName: "video_note".}: InputFile
      mvnThumbnail* {.jsonName: "thumbnail".}: InputThumbnail
      mvnDuration* {.jsonName: "duration".}: int32
      mvnLength* {.jsonName: "length".}: int32
    of imVoiceNote:
      mvnVoiceNote* {.jsonName: "voice_note".}: InputFile
      mvnoteDuration* {.jsonName: "duration".}: int32
      mvnWaveform* {.jsonName: "waveform".}: string
      mvnCaption* {.jsonName: "caption".}: FormattedText
    of imLocation:
      mlLocation* {.jsonName: "location".}: Location
      mlLivePeriod* {.jsonName: "live_period".}: int32
    of imVenue:
      mvVenue* {.jsonName: "venue".}: Venue
    of imContact:
      mcContact* {.jsonName: "contact".}: Contact
    of imDice:
      mdEmoji* {.jsonName: "emoji".}: string
      mdClearDraft* {.jsonName: "clear_draft".}: bool
    of imGame:
      mgBotUserId* {.jsonName: "bot_user_id".}: int32
      mgGameShortName* {.jsonName: "game_short_name".}: string
    of imInvoice:
      miInvoice* {.jsonName: "invoice".}: Invoice
      miTitle* {.jsonName: "title".}: string
      miDescription* {.jsonName: "description".}: string
      miPhotoUrl* {.jsonName: "photo_url".}: string
      miPhotoSize* {.jsonName: "photo_size".}: int32
      miPhotoWidth* {.jsonName: "photo_width".}: int32
      miPhotoHeight* {.jsonName: "photo_height".}: int32
      miPayload* {.jsonName: "payload".}: string
      miProviderToken* {.jsonName: "provider_token".}: string
      miProviderData* {.jsonName: "provider_data".}: string
      miStartParameter* {.jsonName: "start_parameter".}: string
    of imPoll:
      mpQuestion* {.jsonName: "question".}: string
      mpOptions* {.jsonName: "options".}: seq[string]
      mpIsAnonymous* {.jsonName: "is_anonymous".}: bool
      mpType* {.jsonName: "type".}: PollType
      mpOpenPeriod* {.jsonName: "open_period".}: int32
      mpCloseDate* {.jsonName: "close_date".}: int32
      mpIsClosed* {.jsonName: "is_closed".}: bool
    of imForwarded:
      mfFromChatId* {.jsonName: "from_chat_id".}: int64
      mfMessageId* {.jsonName: "message_id".}: int64
      mfInGameShare* {.jsonName: "in_game_share".}: bool
      mfSendCopy* {.jsonName: "send_copy".}: bool
      mfRemoveCaption* {.jsonName: "remove_caption".}: bool

  CallProtocol* = object
    kind* {.jsonName: "@type".}: string
    udpP2p* {.jsonName: "udp_p2p".}: bool
    udpReflector* {.jsonName: "udp_reflector".}: bool
    minLayer* {.jsonName: "min_layer".}: int32
    maxLayer* {.jsonName: "max_layer".}: int32
    libraryVersions* {.jsonName: "library_versions".}: seq[string]

  HttpUrl* = object
    kind* {.jsonName: "@type".}: string
    url* {.jsonName: "url".}: string

  UserPrivacySettingRuleKind* = enum
    upsrAllowContacts = "userPrivacySettingRuleAllowContacts",
    upsrAllowChatMembers = "userPrivacySettingRuleAllowChatMembers",
    upsrRestrictContacts = "userPrivacySettingRuleRestrictContacts",
    upsrAllowAll = "userPrivacySettingRuleAllowAll",
    upsrRestrictUsers = "userPrivacySettingRuleRestrictUsers",
    upsrRestrictChatMembers = "userPrivacySettingRuleRestrictChatMembers",
    upsrRestrictAll = "userPrivacySettingRuleRestrictAll",
    upsrAllowUsers = "userPrivacySettingRuleAllowUsers",

  UserPrivacySettingRule* = object
    case kind* {.jsonName: "@type".}: UserPrivacySettingRuleKind
    of upsrAllowAll:
      discard
    of upsrAllowContacts:
      discard
    of upsrAllowUsers:
      auUserIds* {.jsonName: "user_ids".}: seq[int32]
    of upsrAllowChatMembers:
      acmChatIds* {.jsonName: "chat_ids".}: seq[int64]
    of upsrRestrictAll:
      discard
    of upsrRestrictContacts:
      discard
    of upsrRestrictUsers:
      ruUserIds* {.jsonName: "user_ids".}: seq[int32]
    of upsrRestrictChatMembers:
      rcmChatIds* {.jsonName: "chat_ids".}: seq[int64]

  RichTextKind* = enum
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

  RichText = ref object
    case kind* {.jsonName: "@type".}: RichTextKind
    of rtPlain:
      richtextplaText* {.jsonName: "text".}: string
    of rtBold:
      richtextboText* {.jsonName: "text".}: RichText
    of rtItalic:
      richtextitalText* {.jsonName: "text".}: RichText
    of rtUnderline:
      richtextunderliText* {.jsonName: "text".}: RichText
    of rtStrikethrough:
      richtextstrikethrouText* {.jsonName: "text".}: RichText
    of rtFixed:
      richtextfixText* {.jsonName: "text".}: RichText
    of rtUrl:
      richtextuText* {.jsonName: "text".}: RichText
      richtextuUrl* {.jsonName: "url".}: string
      richtextuIsCached* {.jsonName: "is_cached".}: bool
    of rtEmailAddress:
      eaText* {.jsonName: "text".}: RichText
      eaEmailAddress* {.jsonName: "email_address".}: string
    of rtSubscript:
      richtextsubscriText* {.jsonName: "text".}: RichText
    of rtSuperscript:
      richtextsuperscriText* {.jsonName: "text".}: RichText
    of rtMarked:
      richtextmarkText* {.jsonName: "text".}: RichText
    of rtPhoneNumber:
      pnText* {.jsonName: "text".}: RichText
      pnPhoneNumber* {.jsonName: "phone_number".}: string
    of rtIcon:
      richtexticDocument* {.jsonName: "document".}: Document
      richtexticWidth* {.jsonName: "width".}: int32
      richtexticHeight* {.jsonName: "height".}: int32
    of rtReference:
      richtextreferenText* {.jsonName: "text".}: RichText
      richtextreferenReferenceText* {.jsonName: "reference_text".}: RichText
      richtextreferenUrl* {.jsonName: "url".}: string
    of rtAnchor:
      richtextanchName* {.jsonName: "name".}: string
    of rtAnchorLink:
      alText* {.jsonName: "text".}: RichText
      alName* {.jsonName: "name".}: string
      alUrl* {.jsonName: "url".}: string
    of rts:
      Texts* {.jsonName: "texts".}: seq[RichText]

  NetworkStatistics* = object
    kind* {.jsonName: "@type".}: string
    sinceDate* {.jsonName: "since_date".}: int32
    entries* {.jsonName: "entries".}: seq[NetworkStatisticsEntry]

  PageBlockKind* = enum
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

  PageBlock = ref object
    case kind* {.jsonName: "@type".}: PageBlockKind
    of pbTitle:
      pageblocktitTitle* {.jsonName: "title".}: RichText
    of pbSubtitle:
      pageblocksubtitSubtitle* {.jsonName: "subtitle".}: RichText
    of pbAuthorDate:
      adAuthor* {.jsonName: "author".}: RichText
      adPublishDate* {.jsonName: "publish_date".}: int32
    of pbHeader:
      pageblockheadHeader* {.jsonName: "header".}: RichText
    of pbSubheader:
      pageblocksubheadSubheader* {.jsonName: "subheader".}: RichText
    of pbKicker:
      pageblockkickKicker* {.jsonName: "kicker".}: RichText
    of pbParagraph:
      pageblockparagraText* {.jsonName: "text".}: RichText
    of pbPreformatted:
      pageblockpreformattText* {.jsonName: "text".}: RichText
      pageblockpreformattLanguage* {.jsonName: "language".}: string
    of pbFooter:
      pageblockfootFooter* {.jsonName: "footer".}: RichText
    of pbDivider:
      discard
    of pbAnchor:
      pageblockanchName* {.jsonName: "name".}: string
    of pbList:
      pageblockliItems* {.jsonName: "items".}: seq[PageBlockListItem]
    of pbBlockQuote:
      bqText* {.jsonName: "text".}: RichText
      bqCredit* {.jsonName: "credit".}: RichText
    of pbPullQuote:
      pqText* {.jsonName: "text".}: RichText
      pqCredit* {.jsonName: "credit".}: RichText
    of pbAnimation:
      pageblockanimatiAnimation* {.jsonName: "animation".}: Animation
      pageblockanimatiCaption* {.jsonName: "caption".}: PageBlockCaption
      pageblockanimatiNeedAutoplay* {.jsonName: "need_autoplay".}: bool
    of pbAudio:
      pageblockaudAudio* {.jsonName: "audio".}: Audio
      pageblockaudCaption* {.jsonName: "caption".}: PageBlockCaption
    of pbPhoto:
      pageblockphoPhoto* {.jsonName: "photo".}: Photo
      pageblockphoCaption* {.jsonName: "caption".}: PageBlockCaption
      pageblockphoUrl* {.jsonName: "url".}: string
    of pbVideo:
      pageblockvidVideo* {.jsonName: "video".}: Video
      pageblockvidCaption* {.jsonName: "caption".}: PageBlockCaption
      pageblockvidNeedAutoplay* {.jsonName: "need_autoplay".}: bool
      pageblockvidIsLooped* {.jsonName: "is_looped".}: bool
    of pbVoiceNote:
      vnVoiceNote* {.jsonName: "voice_note".}: VoiceNote
      vnCaption* {.jsonName: "caption".}: PageBlockCaption
    of pbCover:
      pageblockcovCover* {.jsonName: "cover".}: PageBlock
    of pbEmbedded:
      pageblockembeddUrl* {.jsonName: "url".}: string
      pageblockembeddHtml* {.jsonName: "html".}: string
      pageblockembeddPosterPhoto* {.jsonName: "poster_photo".}: Photo
      pageblockembeddWidth* {.jsonName: "width".}: int32
      pageblockembeddHeight* {.jsonName: "height".}: int32
      pageblockembeddCaption* {.jsonName: "caption".}: PageBlockCaption
      pageblockembeddIsFullWidth* {.jsonName: "is_full_width".}: bool
      pageblockembeddAllowScrolling* {.jsonName: "allow_scrolling".}: bool
    of pbEmbeddedPost:
      epUrl* {.jsonName: "url".}: string
      epAuthor* {.jsonName: "author".}: string
      epAuthorPhoto* {.jsonName: "author_photo".}: Photo
      epDate* {.jsonName: "date".}: int32
      epPageBlocks* {.jsonName: "page_blocks".}: seq[PageBlock]
      epCaption* {.jsonName: "caption".}: PageBlockCaption
    of pbCollage:
      pageblockcollaPageBlocks* {.jsonName: "page_blocks".}: seq[PageBlock]
      pageblockcollaCaption* {.jsonName: "caption".}: PageBlockCaption
    of pbSlideshow:
      pageblockslideshPageBlocks* {.jsonName: "page_blocks".}: seq[PageBlock]
      pageblockslideshCaption* {.jsonName: "caption".}: PageBlockCaption
    of pbChatLink:
      clTitle* {.jsonName: "title".}: string
      clPhoto* {.jsonName: "photo".}: ChatPhoto
      clUsername* {.jsonName: "username".}: string
    of pbTable:
      pageblocktabCaption* {.jsonName: "caption".}: RichText
      pageblocktabCells* {.jsonName: "cells".}: seq[seq[PageBlockTableCell]]
      pageblocktabIsBordered* {.jsonName: "is_bordered".}: bool
      pageblocktabIsStriped* {.jsonName: "is_striped".}: bool
    of pbDetails:
      pageblockdetaiHeader* {.jsonName: "header".}: RichText
      pageblockdetaiPageBlocks* {.jsonName: "page_blocks".}: seq[PageBlock]
      pageblockdetaiIsOpen* {.jsonName: "is_open".}: bool
    of pbRelatedArticles:
      raHeader* {.jsonName: "header".}: RichText
      raArticles* {.jsonName: "articles".}: seq[PageBlockRelatedArticle]
    of pbMap:
      pageblockmLocation* {.jsonName: "location".}: Location
      pageblockmZoom* {.jsonName: "zoom".}: int32
      pageblockmWidth* {.jsonName: "width".}: int32
      pageblockmHeight* {.jsonName: "height".}: int32
      pageblockmCaption* {.jsonName: "caption".}: PageBlockCaption

  DateRange* = object
    kind* {.jsonName: "@type".}: string
    startDate* {.jsonName: "start_date".}: int32
    endDate* {.jsonName: "end_date".}: int32

  InputPersonalDocument* = object
    kind* {.jsonName: "@type".}: string
    files* {.jsonName: "files".}: seq[InputFile]
    translation* {.jsonName: "translation".}: seq[InputFile]

  InputStickerKind* = enum
    isStatic = "inputStickerStatic",
    isAnimated = "inputStickerAnimated",

  InputSticker* = object
    case kind* {.jsonName: "@type".}: InputStickerKind
    of isStatic:
      inputstickerstatSticker* {.jsonName: "sticker".}: InputFile
      inputstickerstatEmojis* {.jsonName: "emojis".}: string
      inputstickerstatMaskPosition* {.jsonName: "mask_position".}: MaskPosition
    of isAnimated:
      inputstickeranimatSticker* {.jsonName: "sticker".}: InputFile
      inputstickeranimatEmojis* {.jsonName: "emojis".}: string

  Updates* = object
    kind* {.jsonName: "@type".}: string
    updates* {.jsonName: "updates".}: seq[Update]

  ChatNotificationSettings* = object
    kind* {.jsonName: "@type".}: string
    useDefaultMuteFor* {.jsonName: "use_default_mute_for".}: bool
    muteFor* {.jsonName: "mute_for".}: int32
    useDefaultSound* {.jsonName: "use_default_sound".}: bool
    sound* {.jsonName: "sound".}: string
    useDefaultShowPreview* {.jsonName: "use_default_show_preview".}: bool
    showPreview* {.jsonName: "show_preview".}: bool
    useDefaultDisablePinnedMessageNotifications* {.jsonName: "use_default_disable_pinned_message_notifications".}: bool
    disablePinnedMessageNotifications* {.jsonName: "disable_pinned_message_notifications".}: bool
    useDefaultDisableMentionNotifications* {.jsonName: "use_default_disable_mention_notifications".}: bool
    disableMentionNotifications* {.jsonName: "disable_mention_notifications".}: bool

  StorageStatisticsByFileType* = object
    kind* {.jsonName: "@type".}: string
    fileType* {.jsonName: "file_type".}: FileType
    size* {.jsonName: "size".}: int64
    count* {.jsonName: "count".}: int32


let a = %*{
  "@type": "message",
  "id": 8607760384,
  "sender_user_id": 993214420,
  "chat_id": 993214420,
  "is_outgoing": true,
  "can_be_edited": true,
  "can_be_forwarded": true,
  "can_be_deleted_only_for_self": true,
  "can_be_deleted_for_all_users": false,
  "is_channel_post": false,
  "contains_unread_mention": false,
  "date": 1590364295,
  "edit_date": 1590364296,
  "reply_to_message_id": 0,
  "ttl": 0,
  "ttl_expires_in": 0.0,
  "via_bot_user_id": 0,
  "author_signature": "",
  "views": 0,
  "media_album_id": "0",
  "restriction_reason": "",
  "content": {
    "@type": "messageText",
    "text": {
      "@type": "formattedText",
      "text": "All up and running!",
      "entities": []
    }
  }
}

echo a.toCustom(Message)