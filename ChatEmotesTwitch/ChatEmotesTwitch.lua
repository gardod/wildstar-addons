-----------------------------------------------------------------------------------------------
-- Client Lua Script for ChatEmotesTwitch
-- Andrej@Jabbit
-----------------------------------------------------------------------------------------------
require "Apollo"
require "Sound"
 
-----------------------------------------------------------------------------------------------
-- ChatEmotesTwitch Module Definition
-----------------------------------------------------------------------------------------------
local ChatEmotesTwitch = {} 
 
-----------------------------------------------------------------------------------------------
-- Constants
-----------------------------------------------------------------------------------------------
local tEmoticons = {
	[":)"] = { sprite="ChatEmotesTwitch:1" },
	[":("] = { sprite="ChatEmotesTwitch:2" },
	[":o"] = { sprite="ChatEmotesTwitch:3" },
	[":O"] = { sprite="ChatEmotesTwitch:3" },
	[":z"] = { sprite="ChatEmotesTwitch:4" },
	[":Z"] = { sprite="ChatEmotesTwitch:4" },
	["-.-"] = { sprite="ChatEmotesTwitch:4" },
	["B)"] = { sprite="ChatEmotesTwitch:5" },
	[":/"] = { sprite="ChatEmotesTwitch:6" },
	[";)"] = { sprite="ChatEmotesTwitch:7" },
	[";p"] = { sprite="ChatEmotesTwitch:8" },
	[";P"] = { sprite="ChatEmotesTwitch:8" },
	[":p"] = { sprite="ChatEmotesTwitch:9" },
	[":P"] = { sprite="ChatEmotesTwitch:9" },
	["R)"] = { sprite="ChatEmotesTwitch:10" },
	["o_O"] = { sprite="ChatEmotesTwitch:11" },
	[":D"] = { sprite="ChatEmotesTwitch:12" },
	[">("] = { sprite="ChatEmotesTwitch:13" },
	[">.<"] = { sprite="ChatEmotesTwitch:13" },
	["<3"] = { sprite="ChatEmotesTwitch:14" },
	["BibleThump"] = { sprite="ChatEmotesTwitch:15" },
	["FrankerZ"] = { sprite="ChatEmotesTwitch:16" },
	["KAPOW"] = { sprite="ChatEmotesTwitch:17" },
	["Kappa"] = { sprite="ChatEmotesTwitch:18" },
	["Keepo"] = { sprite="ChatEmotesTwitch:19" },
	["Kreygasm"] = { sprite="ChatEmotesTwitch:20" },
	["PJSalt"] = { sprite="ChatEmotesTwitch:21" },
	["ResidentSleeper"] = { sprite="ChatEmotesTwitch:22" },
	["RalpherZ"] = { sprite="ChatEmotesTwitch:23" },
	["PoohBear"] = { sprite="ChatEmotesTwitch:24" },
	["Pooh"] = { sprite="ChatEmotesTwitch:24" },
	["pooh"] = { sprite="ChatEmotesTwitch:24" },
	["FailFish"] = { sprite="ChatEmotesTwitch:25" },
	["OpieOP"] = { sprite="ChatEmotesTwitch:26" },
	["SwiftRage"] = { sprite="ChatEmotesTwitch:27" },
	["lirikThump"] = { sprite="ChatEmotesTwitch:28" },
	["PedoBear"] = { sprite="ChatEmotesTwitch:29" },
	["4Head"] = { sprite="ChatEmotesTwitch:30" },
	["DansGame"] = { sprite="ChatEmotesTwitch:31" },
	["MrDestructoid"] = { sprite="ChatEmotesTwitch:32" },
	["BabyRage"] = { sprite="ChatEmotesTwitch:33" },
	["lnuBrick"] = { sprite="ChatEmotesTwitch:34" },
	["Briex"] = { sprite="ChatEmotesTwitch:34" },
	["Brieq"] = { sprite="ChatEmotesTwitch:34" },
	["BloodTrail"] = { sprite="ChatEmotesTwitch:35" },
	["TheThing"] = { sprite="ChatEmotesTwitch:36" },
	["TriHard"] = { sprite="ChatEmotesTwitch:37" },
	["ConcernDoge"] = { sprite="ChatEmotesTwitch:38" },
	["DogeWitIt"] = { sprite="ChatEmotesTwitch:39" },
	["GabeN"] = { sprite="ChatEmotesTwitch:40" },
	["zybakFace"] = { sprite="ChatEmotesTwitch:41" },
	["riPepperonis"] = { sprite="ChatEmotesTwitch:42" },
	["Rekt"] = { sprite="ChatEmotesTwitch:43" },
	["trkPopcorn"] = { sprite="ChatEmotesTwitch:44" },
	["PogChamp"] = { sprite="ChatEmotesTwitch:45" },
	["acouGrill"] = { sprite="ChatEmotesTwitch:46" },
	["wickedFedora"] = { sprite="ChatEmotesTwitch:47" },
	["zorzPray"] = { sprite="ChatEmotesTwitch:48" },
	["badHype"] = { sprite="ChatEmotesTwitch:49" },
	["danRekt"] = { sprite="ChatEmotesTwitch:50" },
	["neoMustache"] = { sprite="ChatEmotesTwitch:51" },
	["sigRESET"] = { sprite="ChatEmotesTwitch:52", width=66 },
	["SMOrc"] = { sprite="ChatEmotesTwitch:53" },
	["krippDonger"] = { sprite="ChatEmotesTwitch:54" },
	["rwgStayTrue"] = { sprite="ChatEmotesTwitch:55" },
	["rwgLetItGo"] = { sprite="ChatEmotesTwitch:56" },
	["lleucaRNG"] = { sprite="ChatEmotesTwitch:57" },
	["letoRNGesus"] = { sprite="ChatEmotesTwitch:58" },
	["pashaBajceps"] = { sprite="ChatEmotesTwitch:59" },
	["sodaRIP"] = { sprite="ChatEmotesTwitch:60" },
	["HeyGuys"] = { sprite="ChatEmotesTwitch:61" },
	["FlaskOfSpeed"] = { sprite="ChatEmotesTwitch:62" },
	["zybakWIPE"] = { sprite="ChatEmotesTwitch:63" },
	["rwgLIGHTS"] = { sprite="ChatEmotesTwitch:64" },
	["esperaldaFace"] = { sprite="ChatEmotesTwitch:65" },
	["espeFace"] = { sprite="ChatEmotesTwitch:65" },
	["tenriFace"] = { sprite="ChatEmotesTwitch:66", sound="tenri-mathematician" },
	["ViciousFace"] = { sprite="ChatEmotesTwitch:67" },
	["koraFace"] = { sprite="ChatEmotesTwitch:68" },
	["benFace"] = { sprite="ChatEmotesTwitch:69" },
	["GigaFace"] = { sprite="ChatEmotesTwitch:70" },
	["gigaFace"] = { sprite="ChatEmotesTwitch:71" },
	["moGod"] = { sprite="ChatEmotesTwitch:72" },
	["vimFace"] = { sprite="ChatEmotesTwitch:73" },
	["VimFace"] = { sprite="ChatEmotesTwitch:74" },
	["walrusFace"] = { sprite="ChatEmotesTwitch:75" },
	["vairaFace"] = { sprite="ChatEmotesTwitch:76" },
	["LilZ"] = { sprite="ChatEmotesTwitch:76" },
	["ZreknarF"] = { sprite="ChatEmotesTwitch:77" },
	["KaneFace"] = { sprite="ChatEmotesTwitch:78" },
	["TenriFace"] = { sprite="ChatEmotesTwitch:79" },
	["hasanFace"] = { sprite="ChatEmotesTwitch:80" },
	["kaneFace"] = { sprite="ChatEmotesTwitch:81" },
	["HasanFace"] = { sprite="ChatEmotesTwitch:82" },
	["YuullFace"] = { sprite="ChatEmotesTwitch:83", sound="yuull-carrying_retards" },
	["itsyFace"] = { sprite="ChatEmotesTwitch:84" },
	["byonaFace"] = { sprite="ChatEmotesTwitch:85", sound="byona-allah_short" },
	["ByonaFace"] = { sprite="ChatEmotesTwitch:86", sound="byona-allah_long" },
	["kiritoFace"] = { sprite="ChatEmotesTwitch:87" },
	["viciousFace"] = { sprite="ChatEmotesTwitch:88" },
	["yanaFace"] = { sprite="ChatEmotesTwitch:89" },
	["bitchFace"] = { sprite="ChatEmotesTwitch:90" },
	["kungenFace"] = { sprite="ChatEmotesTwitch:91" },
	["KinaeFace"] = { sprite="ChatEmotesTwitch:92" },
	["kinaeFace"] = { sprite="ChatEmotesTwitch:93" },
	["tailOffFace"] = { sprite="ChatEmotesTwitch:94" },
	["mindBlown"] = { sprite="ChatEmotesTwitch:95" },
	["LootRage"] = { sprite="ChatEmotesTwitch:96" },
	["lootRage"] = { sprite="ChatEmotesTwitch:97" },
	["BrokeBack"] = { sprite="ChatEmotesTwitch:98" },
	["lirikAppa"] = { sprite="ChatEmotesTwitch:99" },
	["lirikCLENCH"] = { sprite="ChatEmotesTwitch:100" },
	["lirikMLG"] = { sprite="ChatEmotesTwitch:101" },
	["lirikTEN"] = { sprite="ChatEmotesTwitch:102" },
	["moreDots"] = { sprite="ChatEmotesTwitch:103" },
	["MoreDots"] = { sprite="ChatEmotesTwitch:104" },
	["KrippDonger"] = { sprite="ChatEmotesTwitch:106" },
	["lokohhFood"] = { sprite="ChatEmotesTwitch:107" },
	["PJLokohh"] = { sprite="ChatEmotesTwitch:108" },
	["eleGiggle"] = { sprite="ChatEmotesTwitch:109" },
	["nippeFace"] = { sprite="ChatEmotesTwitch:110" },
	["nipFace"] = { sprite="ChatEmotesTwitch:110" },
	["lirikREKT"] = { sprite="ChatEmotesTwitch:111" },
	["lirikRIP"] = { sprite="ChatEmotesTwitch:112" },
	["lirikGasm"] = { sprite="ChatEmotesTwitch:113" },
	["lirikH"] = { sprite="ChatEmotesTwitch:114" },
	["lirikHug"] = { sprite="ChatEmotesTwitch:115" },
	["lirikTRASH"] = { sprite="ChatEmotesTwitch:116" },
	["lirikPOOP"] = { sprite="ChatEmotesTwitch:117" },
	["panicBasket"] = { sprite="ChatEmotesTwitch:118" },
	["duDudu"] = { sprite="ChatEmotesTwitch:119" },
	["EleGiggle"] = { sprite="ChatEmotesTwitch:120" },
	["WutFace"] = { sprite="ChatEmotesTwitch:121" },
	["wutFace"] = { sprite="ChatEmotesTwitch:122" },
	["KappaPride"] = { sprite="ChatEmotesTwitch:123" },
	["VaultBoy"] = { sprite="ChatEmotesTwitch:124" },
	["CodexFace"] = { sprite="ChatEmotesTwitch:125" },
	["CoolCat"] = { sprite="ChatEmotesTwitch:126" },
	["abuxFace"] = { sprite="ChatEmotesTwitch:127" },
	["AbuxFace"] = { sprite="ChatEmotesTwitch:128" },
	["RareMing"] = { sprite="ChatEmotesTwitch:129" },
	["deIlluminati"] = { sprite="ChatEmotesTwitch:130" },
	["MichaelPls"] = { sprite="ChatEmotesTwitch:131", width=18 },
	["MingLee"] = { sprite="ChatEmotesTwitch:132" },
	["mingLee"] = { sprite="ChatEmotesTwitch:133" },
	["AngelThump"] = { sprite="ChatEmotesTwitch:134", width=56 },
	["D:"] = { sprite="ChatEmotesTwitch:135" },
	["FeelsGoodMan"] = { sprite="ChatEmotesTwitch:136" },
	["FeelsBadMan"] = { sprite="ChatEmotesTwitch:137" },
	["FeelsBirthdayMan"] = { sprite="ChatEmotesTwitch:138" },
	["KKona"] = { sprite="ChatEmotesTwitch:139" },
	["RebeccaBlack"] = { sprite="ChatEmotesTwitch:140" },
	["OhMyGoodness"] = { sprite="ChatEmotesTwitch:141" },
	["Citto"] = { sprite="ChatEmotesTwitch:142", width=18, sound="konga" },
	["(ditto)"] = { sprite="ChatEmotesTwitch:143", width=18 },
	["Ditto"] = { sprite="ChatEmotesTwitch:143", width=18 },
	["KappaRoss"] = { sprite="ChatEmotesTwitch:144" },
	["NotLikeThis"] = { sprite="ChatEmotesTwitch:145" },
	["JohnCena"] = { sprite="ChatEmotesTwitch:146", sound="JohnCena" },
	["Hanzo"] = { sprite="ChatEmotesTwitch:147", sound="Hanzo" },
	["KappaClaus"] = { sprite="ChatEmotesTwitch:148" },
	["Stitch"] = { sprite="ChatEmotesTwitch:149", sound="Stitch" },
	["prezFace"] = { sprite="ChatEmotesTwitch:150" },
	["aariFace"] = { sprite="ChatEmotesTwitch:151", sound="aari-smash" },
	["zaidraFace"] = { sprite="ChatEmotesTwitch:152" },
	["bykkFace"] = { sprite="ChatEmotesTwitch:153" },
	["TTFace"] = { sprite="ChatEmotesTwitch:154" },
	["AariWitIt"] = { sprite="ChatEmotesTwitch:155" },
	["cojamoFace"] = { sprite="ChatEmotesTwitch:156", sound="cojamo-spacebar" },
	["CojamoFace"] = { sprite="ChatEmotesTwitch:157" },
	["lokohhFace"] = { sprite="ChatEmotesTwitch:158", sound="lokohh-the_cock" },
	["LokohhFace"] = { sprite="ChatEmotesTwitch:159" },
	["nikalliFace"] = { sprite="ChatEmotesTwitch:160" },
	["NikalliFace"] = { sprite="ChatEmotesTwitch:161" },
	["walzyFace"] = { sprite="ChatEmotesTwitch:162", sound="walzy-3rd_world_retard" },
	["WalzyFace"] = { sprite="ChatEmotesTwitch:163" },
	["yuullFace"] = { sprite="ChatEmotesTwitch:164" },
	["scultiFace"] = { sprite="ChatEmotesTwitch:165" },
	["scultiQQ"] = { sprite="ChatEmotesTwitch:166" },
	["ANELE"] = { sprite="ChatEmotesTwitch:167" },
	["CorgiDerp"] = { sprite="ChatEmotesTwitch:168" },
	["KappaWealth"] = { sprite="ChatEmotesTwitch:169" },
	["PartyTime"] = { sprite="ChatEmotesTwitch:170" },
	["DogFace"] = { sprite="ChatEmotesTwitch:171" },
	["VoHiYo"] = { sprite="ChatEmotesTwitch:172" },
	["OhMyDog"] = { sprite="ChatEmotesTwitch:173" },
	["cmonBruh"] = { sprite="ChatEmotesTwitch:174" },
	["VapeNation"] = { sprite="ChatEmotesTwitch:175" },
	["eloiseWb"] = { sprite="ChatEmotesTwitch:176" },
	["LUL"] = { sprite="ChatEmotesTwitch:177" },
	["cookieFace"] = { sprite="ChatEmotesTwitch:178" },
	["cookieH"] = { sprite="ChatEmotesTwitch:179" },
	["cookieGASM"] = { sprite="ChatEmotesTwitch:180" },
	["cookieRIP"] = { sprite="ChatEmotesTwitch:181" },
}
local bNameEmote = false
local Jita = nil

-- Copied from ChatLog
local knSaveVersion = 8
local kstrColorChatRegular 		= "ff7fffb9"
local kstrColorChatShout		= "ffd9eef7"
local kstrColorChatRoleplay 	= "ff58e3b0"
local kstrColorNonSelectedEntry = "UI_BtnTextHoloNormal"
local kstrBubbleFont 			= "CRB_Dialog"
local kstrDialogFont 			= "CRB_Dialog"
local kstrDialogFontRP 			= "CRB_Dialog_I"
local kstrGMIcon 				= "Icon_Windows_UI_GMIcon"
local karEvalColors = {
	[Item.CodeEnumItemQuality.Inferior] 		= "ItemQuality_Inferior",
	[Item.CodeEnumItemQuality.Average] 			= "ItemQuality_Average",
	[Item.CodeEnumItemQuality.Good] 			= "ItemQuality_Good",
	[Item.CodeEnumItemQuality.Excellent] 		= "ItemQuality_Excellent",
	[Item.CodeEnumItemQuality.Superb] 			= "ItemQuality_Superb",
	[Item.CodeEnumItemQuality.Legendary] 		= "ItemQuality_Legendary",
	[Item.CodeEnumItemQuality.Artifact]		 	= "ItemQuality_Artifact",
}
local karChannelTypeToColor = {
	[ChatSystemLib.ChatChannel_Command] 		= { Channel = "ChannelCommand", 		},
	[ChatSystemLib.ChatChannel_System] 			= { Channel = "ChannelSystem", 			},
	[ChatSystemLib.ChatChannel_Debug] 			= { Channel = "ChannelDebug", 			},
	[ChatSystemLib.ChatChannel_Say] 			= { Channel = "ChannelSay", 			},
	[ChatSystemLib.ChatChannel_Yell] 			= { Channel = "ChannelShout", 			},
	[ChatSystemLib.ChatChannel_Whisper] 		= { Channel = "ChannelWhisper", 		},
	[ChatSystemLib.ChatChannel_Party] 			= { Channel = "ChannelParty", 			},
	[ChatSystemLib.ChatChannel_Emote] 			= { Channel = "ChannelEmote", 			},
	[ChatSystemLib.ChatChannel_AnimatedEmote] 	= { Channel = "ChannelEmote", 			},
	[ChatSystemLib.ChatChannel_Zone] 			= { Channel = "ChannelZone", 			},
	[ChatSystemLib.ChatChannel_ZoneGerman]		= { Channel = "ChannelZone", 			},
	[ChatSystemLib.ChatChannel_ZoneFrench]		= { Channel = "ChannelZone", 			},
	[ChatSystemLib.ChatChannel_ZonePvP] 		= { Channel = "ChannelPvP", 			},
	[ChatSystemLib.ChatChannel_Trade] 			= { Channel = "ChannelTrade",			},
	[ChatSystemLib.ChatChannel_Guild] 			= { Channel = "ChannelGuild", 			},
	[ChatSystemLib.ChatChannel_GuildOfficer] 	= { Channel = "ChannelGuildOfficer",	},
	[ChatSystemLib.ChatChannel_Society] 		= { Channel = "ChannelCircle2",			},
	[ChatSystemLib.ChatChannel_Custom] 			= { Channel = "ChannelCustom", 			},
	[ChatSystemLib.ChatChannel_NPCSay] 			= { Channel = "ChannelNPC", 			},
	[ChatSystemLib.ChatChannel_NPCYell] 		= { Channel = "ChannelNPC",		 		},
	[ChatSystemLib.ChatChannel_NPCWhisper]		= { Channel = "ChannelNPC", 			},
	[ChatSystemLib.ChatChannel_Datachron] 		= { Channel = "ChannelNPC", 			},
	[ChatSystemLib.ChatChannel_Combat] 			= { Channel = "ChannelGeneral", 		},
	[ChatSystemLib.ChatChannel_Realm] 			= { Channel = "ChannelSupport", 		},
	[ChatSystemLib.ChatChannel_Loot] 			= { Channel = "ChannelLoot", 			},
	[ChatSystemLib.ChatChannel_PlayerPath] 		= { Channel = "ChannelGeneral", 		},
	[ChatSystemLib.ChatChannel_Instance] 		= { Channel = "ChannelInstance", 		},
	[ChatSystemLib.ChatChannel_WarParty] 		= { Channel = "ChannelWarParty",		},
	[ChatSystemLib.ChatChannel_WarPartyOfficer] = { Channel = "ChannelWarPartyOfficer", },
	[ChatSystemLib.ChatChannel_Nexus] 			= { Channel = "ChannelNexus", 			},
	[ChatSystemLib.ChatChannel_NexusGerman]		= { Channel = "ChannelNexus", 			},
	[ChatSystemLib.ChatChannel_NexusFrench]		= { Channel = "ChannelNexus", 			},
	[ChatSystemLib.ChatChannel_AccountWhisper] 	= { Channel = "ChannelAccountWisper", 	},
}

-----------------------------------------------------------------------------------------------
-- Initialization
-----------------------------------------------------------------------------------------------
function ChatEmotesTwitch:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self 

    -- initialize variables here
	self.soundEnable = true
	self.settings = {
		sound = true,
		soundcd = 10,
		name = false
	}
	
    return o
end

function ChatEmotesTwitch:Init()
	local bHasConfigureFunction = false
	local strConfigureButtonText = ""
	local tDependencies = {}
    Apollo.RegisterAddon(self, bHasConfigureFunction, strConfigureButtonText, tDependencies)
end

-----------------------------------------------------------------------------------------------
-- ChatEmotesTwitch OnLoad
-----------------------------------------------------------------------------------------------
function ChatEmotesTwitch:OnLoad()
	self:InitializeHooks()
	
	Apollo.LoadSprites("Sprites.xml")
	
	Apollo.RegisterEventHandler("CET_Sound", "OnSound", self)
	Apollo.RegisterSlashCommand("cet", "OnSlashCommand", self)
	Apollo.RegisterSlashCommand("ac", "OnSlashCommand", self)
end

function ChatEmotesTwitch:InitializeHooks()
	local crb = Apollo.GetAddon("ChatLog")
	if crb ~= nil then
		crb.HelperGenerateChatMessage = self.HelperGenerateChatMessage
		crb.OnRestore = self.OnRestoreFix
	end
	local eveo = Apollo.GetAddon("Jita")
	if eveo ~= nil then
		Jita = eveo
		eveo:Extend("ChatWindow").GenerateChatMessageGeneric = self.GenerateChatMessageGeneric
	end
end

-----------------------------------------------------------------------------------------------
-- ChatEmotesTwitch Settings
-----------------------------------------------------------------------------------------------
function ChatEmotesTwitch:OnSlashCommand(slash, args)
	local arg = args:gmatch([[[^%s]+]])
	local cmd = arg()
	local cmd = cmd and cmd:lower() or ""
	local arg1 = arg()
	local arg1 = arg1 and arg1:lower() or ""
	
	if cmd == "sound" then
		self.settings.sound = not self.settings.sound
		Print(("Playing sounds: %s"):format(tostring(self.settings.sound)))
	elseif cmd == "soundcd" then
		local newcd = tonumber(arg1)
		if type(newcd) == "number" then
			self.settings.soundcd = newcd
		end
		Print(("Sound CD is: %ss"):format(tostring(self.settings.soundcd)))
	elseif cmd == "name" then
		self.settings.name = not self.settings.name
		bNameEmote = self.settings.name
		Print(("Using emotes in names: %s"):format(tostring(self.settings.name)))
	else
		Print(("/%s [command]"):format(slash))
		Print("Available commands:")
		Print("sound  - toggle emote sounds")
		Print("soundcd [seconds]  - set cooldown on sounds")
		Print("name   - toggle emotes in names")
	end
end

function ChatEmotesTwitch:OnSave(eType)
	if eType ~= GameLib.CodeEnumAddonSaveLevel.Account then
		return
	end

	return self.settings
end

function ChatEmotesTwitch:OnRestore(eType, tSavedData)
	if eType ~= GameLib.CodeEnumAddonSaveLevel.Account then
		return
	end

	for key, value in pairs(tSavedData) do
		self.settings[key] = value
	end
	
	bNameEmote = self.settings.name
end

-----------------------------------------------------------------------------------------------
-- ChatEmotesTwitch Functions
-----------------------------------------------------------------------------------------------
function ChatEmotesTwitch:OnRestoreFix(eType, tSavedData)
	if not tSavedData or tSavedData.nVersion ~= knSaveVersion then
		return
	end

	if tSavedData.bEnableNCFade ~= nil then
		self.bEnableNCFade = tSavedData.bEnableNCFade
	end
	if tSavedData.bEnableBGFade ~= nil then
		self.bEnableBGFade = tSavedData.bEnableBGFade
	end
	if tSavedData.nBGOpacity ~= nil then
		self.nBGOpacity = tSavedData.nBGOpacity
	end
	if tSavedData.bShowChannel ~= nil then
		self.bShowChannel = tSavedData.bShowChannel
	end
	if tSavedData.bShowTimestamp ~= nil then
		self.bShowTimestamp = tSavedData.bShowTimestamp
	end
	if tSavedData.bProfanityFilter ~= nil then
		self.bProfanityFilter = tSavedData.bProfanityFilter
	end
	if tSavedData.eRoleplayOption ~= nil then
		self.eRoleplayOption = tSavedData.eRoleplayOption
	end
	if tSavedData.bEnableChatLineFade ~= nil then
		self.bEnableChatLineFade = tSavedData.bEnableChatLineFade
	end
	
	self.nFontSize = tSavedData.nFontSize
	if tSavedData.tWindow and #tSavedData.tWindow > 0 then
		self.tWindow = tSavedData.tWindow
	end
end

function ChatEmotesTwitch:OnSound(file)
	if self.settings.sound and self.soundEnable then
		Sound.PlayFile("Sound\\" .. file .. ".wav")
		if self.settings.soundcd > 0 then
			self.soundEnable = false
			self.soundTimer = ApolloTimer.Create(self.settings.soundcd, false, "OnSoundEnable", self)
		end
	end
end

function ChatEmotesTwitch:OnSoundEnable()
	self.soundEnable = true
end

function ChatEmotesTwitch:HelperGenerateChatMessage(tQueuedMessage)
	if tQueuedMessage.xml then
		return
	end

	local eChannelType = tQueuedMessage.eChannelType
	local tMessage = tQueuedMessage.tMessage

	-- Different handling for combat log
	if eChannelType == ChatSystemLib.ChatChannel_Combat then
		-- no formats in combat, roll it all up into one.
		local strMessage = ""
		for idx, tSegment in ipairs(tMessage.arMessageSegments) do
			strMessage = strMessage .. tSegment.strText
		end
		tQueuedMessage.strMessage = strMessage
		return
	end

	local xml = XmlDoc.new()

	local crText = self.arChatColor[eChannelType] or ApolloColor.new("white")
	local crChannel = ApolloColor.new(karChannelTypeToColor[eChannelType].Channel or "white")
	local crPlayerName = nil
	if tMessage.bCrossFaction then
		crPlayerName = ApolloColor.new("ChatPlayerNameHostile")
	else
		crPlayerName = ApolloColor.new("ChatPlayerName")
	end

	local strTime = ""
	if self.bShowTimestamp then
		strTime = self:HelperGetTimeStr()
	end

	local strWhisperName = tMessage.strSender
	if tMessage.strRealmName:len() > 0 and eChannelType ~= ChatSystemLib.ChatChannel_AccountWhisper then
		-- Name/Realm formatting needs to be very specific for cross realm chat to work
		strWhisperName = strWhisperName .. "@" .. tMessage.strRealmName
	end
	local strDisplayName = strWhisperName

	--strWhisperName must only be sender@realm, or friends equivelent name.

	local strPresenceState = ""
	if tMessage.bAutoResponse then
		strPresenceState = '('..Apollo.GetString("AutoResponse_Prefix")..')'
	end

	if tMessage.nPresenceState == FriendshipLib.AccountPresenceState_Away then
		strPresenceState = '<'..Apollo.GetString("Command_Friendship_AwayFromKeyboard")..'>'
	elseif tMessage.nPresenceState == FriendshipLib.AccountPresenceState_Busy then
		strPresenceState = '<'..Apollo.GetString("Command_Friendship_DoNotDisturb")..'>'
	end

	if eChannelType == ChatSystemLib.ChatChannel_Whisper then
		if not tMessage.bSelf then
			self.tLastWhisperer = { strCharacterName = strWhisperName, eChannelType = ChatSystemLib.ChatChannel_Whisper }--record the last incoming whisperer for quick response
		end
		Sound.Play(Sound.PlayUISocialWhisper)
		self:InsertIntoRecent(strWhisperName, false)
	elseif eChannelType == ChatSystemLib.ChatChannel_AccountWhisper then

		local tPreviousWhisperer = self.tLastWhisperer

		local tAccountFriends = FriendshipLib.GetAccountList()
		for idx, tAccountFriend in pairs(tAccountFriends) do
			if tAccountFriend.arCharacters ~= nil then
				for idx, tCharacter in pairs(tAccountFriend.arCharacters) do
					if tCharacter.strCharacterName == tMessage.strSender and (tMessage.strRealmName:len() == 0 or tCharacter.strRealm == tMessage.strRealmName) then
						if not tMessage.bSelf or (tPreviousWhisperer and tPreviousWhisperer.strCharacterName == tMessage.strSender) then
							self.tLastWhisperer =
							{
								strCharacterName = tMessage.strSender,
								strRealmName = tCharacter.strRealm,
								strDisplayName = tAccountFriend.strCharacterName,
								eChannelType = ChatSystemLib.ChatChannel_AccountWhisper
							}
						end
						strDisplayName = tAccountFriend.strCharacterName
					end
				end
			end
		end
		Sound.Play(Sound.PlayUISocialWhisper)
		self:InsertIntoRecent(strDisplayName, true)
	end

	-- We build strings backwards, right to left
	if eChannelType == ChatSystemLib.ChatChannel_AnimatedEmote then -- emote animated channel gets special formatting
		xml:AddLine(strTime, crChannel, self.strFontOption, "Left")

	elseif eChannelType == ChatSystemLib.ChatChannel_Emote then -- emote channel gets special formatting
		xml:AddLine(strTime, crChannel, self.strFontOption, "Left")
		if strDisplayName:len() > 0 then
			if tMessage.bGM then
				xml:AppendImage(kstrGMIcon, 16, 16)
			end
			local strCross = tMessage.bCrossFaction and "true" or "false"--has to be a string or a number due to code restriction
			xml:AppendText(strDisplayName, crPlayerName, self.strFontOption, {strCharacterName = strWhisperName, nReportId = tMessage.nReportId, strCrossFaction = strCross}, "Source")
		end
		xml:AppendText(" ")
	else
		local strChannel
		if eChannelType == ChatSystemLib.ChatChannel_Society then
			strChannel = (string.format("%s ", String_GetWeaselString(Apollo.GetString("ChatLog_GuildCommand"), tQueuedMessage.strChannelName, tQueuedMessage.strChannelCommand))) --String DB removed empty characters at the end of string, so have to hardcode it here.
		else
			strChannel = String_GetWeaselString(Apollo.GetString("CRB_Brackets_Space"), tQueuedMessage.strChannelName)
		end

		if self.bShowChannel ~= true then
			strChannel = ""
		end

		xml:AddLine(strTime .. strChannel, crChannel, self.strFontOption, "Left")
		if strDisplayName:len() > 0 then

			local strWhisperNamePrefix = ""
			if eChannelType == ChatSystemLib.ChatChannel_Whisper or eChannelType == ChatSystemLib.ChatChannel_AccountWhisper then
				if tMessage.bSelf then
					strWhisperNamePrefix = Apollo.GetString("ChatLog_To")
				else
					strWhisperNamePrefix = Apollo.GetString("ChatLog_From")
				end
			end

			xml:AppendText( strWhisperNamePrefix, crText, self.strFontOption)

			if tMessage.bGM then
				xml:AppendImage(kstrGMIcon, 20, 19)
			end

			local strCross = tMessage.bCrossFaction and "true" or "false"--has to be a string or a number due to code restriction
			
			-- Emote replace in name
			if bNameEmote then
				for word in strDisplayName:gmatch("%S+") do
					if tEmoticons[word] then
						local emote = tEmoticons[word]
						local s, e = strDisplayName:find(word, 1, true)
						local y = 18
						local x = 22
						
						if emote.width then x = emote.width end
						--if emote.sound then Event_FireGenericEvent("CET_Sound", emote.sound) end
						
						xml:AppendText(strDisplayName:sub(1, s-1), crPlayerName, self.strFontOption, {strCharacterName = strWhisperName, nReportId = tMessage.nReportId , strCrossFaction = strCross}, "Source")
						xml:AppendImage(emote.sprite, x, y)

						strDisplayName = strDisplayName:sub(e+1)
					end
				end
			end
			
			xml:AppendText( strDisplayName, crPlayerName, self.strFontOption, {strCharacterName = strWhisperName, nReportId = tMessage.nReportId , strCrossFaction = strCross}, "Source")
		end
		xml:AppendText( strPresenceState .. Apollo.GetString("Chat_ColonBreak"), crChannel, self.strFontOption, "Left")
	end

	local xmlBubble = nil
	if tMessage.bShowChatBubble then
		xmlBubble = XmlDoc.new() -- This is the speech bubble form
		xmlBubble:AddLine("", crChannel, self.strFontOption, "Center")
		--[[  DEBUG
		local strMessage = ""
		for idx, tSegment in ipairs(tMessage.arMessageSegments) do
			strMessage = strMessage .. " | " .. tSegment.strText
		end
		xmlBubble:AppendText(strMessage, crBubbleText, strBubbleFont)
		tQueuedMessage.bHasVisibleText = bHasVisibleText
		tQueuedMessage.xmlBubble = xmlBubble
		return
		]]--
	end

	local bHasVisibleText = false
	for idx, tSegment in ipairs( tMessage.arMessageSegments ) do
		local strText = tSegment.strText
		local bAlien = tSegment.bAlien
		local bShow = false

		if self.eRoleplayOption == 3 then
			bShow = not tSegment.bRolePlay
		elseif self.eRoleplayOption == 2 then
			bShow = tSegment.bRolePlay
		else
			bShow = true;
		end

		if bShow then
			local crChatText = crText;
			local crBubbleText = kstrColorChatRegular
			local strChatFont = self.strFontOption
			local strBubbleFont = kstrBubbleFont
			local tLink = {}


			if tSegment.uItem ~= nil then -- item link
				-- replace me with correct colors
				strText = String_GetWeaselString(Apollo.GetString("CRB_Brackets"), tSegment.uItem:GetName())
				crChatText = karEvalColors[tSegment.uItem:GetItemQuality()]
				crBubbleText = ApolloColor.new("white")

				tLink.strText = strText
				tLink.uItem = tSegment.uItem

			elseif tSegment.uQuest ~= nil then -- quest link
				-- replace me with correct colors
				strText = String_GetWeaselString(Apollo.GetString("CRB_Brackets"), tSegment.uQuest:GetTitle())
				crChatText = ApolloColor.new("green")
				crBubbleText = ApolloColor.new("green")

				tLink.strText = strText
				tLink.uQuest = tSegment.uQuest

			elseif tSegment.uArchiveArticle ~= nil then -- archive article
				-- replace me with correct colors
				strText = String_GetWeaselString(Apollo.GetString("CRB_Brackets"), tSegment.uArchiveArticle:GetTitle())
				crChatText = ApolloColor.new("ffb7a767")
				crBubbleText = ApolloColor.new("ffb7a767")

				tLink.strText = strText
				tLink.uArchiveArticle = tSegment.uArchiveArticle
				
			elseif tSegment.tNavPoint ~= nil then
				-- replace me with correct colors
				strText = String_GetWeaselString(Apollo.GetString("CRB_Brackets"), "NavPoint")
				crChatText = ApolloColor.new("blue")
				crBubbleText = ApolloColor.new("blue")

				tLink.strText = strText
				tLink.tNavPoint = tSegment.tNavPoint
				
			else
				if tSegment.bRolePlay then
					crBubbleText = kstrColorChatRoleplay
					strChatFont = self.strRPFontOption
					strBubbleFont = kstrDialogFontRP
				end

				if bAlien or tSegment.bProfanity then -- Weak filter. Note only profanity is scrambled.
					strChatFont = self.strAlienFontOption
					strBubbleFont = self.strAlienFontOption
				end
			end

			-- Emote replace
			for word in strText:gmatch("%S+") do
				if tEmoticons[word] then
					local emote = tEmoticons[word]
					local s, e = strText:find(word, 1, true)
					local y = 18
					local x = 22
					
					if emote.width then x = emote.width end
					if emote.sound then Event_FireGenericEvent("CET_Sound", emote.sound) end
					
					xml:AppendText(strText:sub(1, s-1), crChatText, strChatFont)
					xml:AppendImage(emote.sprite, x, y)
					
					if xmlBubble then
						xmlBubble:AppendText(strText:sub(1, s-1), crBubbleText, strBubbleFont)
						xmlBubble:AppendImage(emote.sprite, x, y)
					end
					
					strText = strText:sub(e+1)
				end
			end
			
			if next(tLink) == nil then
				if eChannelType == ChatSystemLib.ChatChannel_AnimatedEmote then
					local strCross = tMessage.bCrossFaction and "true" or "false"--has to be a string or a number due to code restriction
					xml:AppendText(strText, crChatText, strChatFont, {strCharacterName = strWhisperName, nReportId = tMessage.nReportId, strCrossFaction = strCross}, "Source")
				else
					xml:AppendText(strText, crChatText, strChatFont)
				end
			else
				local strLinkIndex = tostring( self:HelperSaveLink(tLink) )
				-- append text can only save strings as attributes.
				xml:AppendText(strText, crChatText, strChatFont, {strIndex=strLinkIndex} , "Link")
			end

			if xmlBubble then
				xmlBubble:AppendText(strText, crBubbleText, strBubbleFont) -- Format for bubble; regular
			end

			bHasVisibleText = bHasVisibleText or self:HelperCheckForEmptyString(strText)
		end
	end

	tQueuedMessage.bHasVisibleText = bHasVisibleText
	tQueuedMessage.xml = xml
	tQueuedMessage.xmlBubble = xmlBubble
end

function ChatEmotesTwitch:GenerateChatMessageGeneric(message)
	if message.XmlObj then
		return message.XmlObj
	end

	local channel = Jita.Client.Channels[message.Channel]

	local channelType    = channel:GetType()
	local channelName    = channel:GetName()
	local channelCommand = channel:GetCommand()
	local channelAbbr    = channel:GetAbbreviation()
	local content        = message.Content

	channelAbbr = Jita.Consts.ChatChannelsAbbreviations[channelType] or channelAbbr

	local xmlPlayerName = XmlDoc.new()
	local xmlLine       = XmlDoc.new()

	local crText    = Jita.Consts.ChatMessagesColors[channelType] or ApolloColor.new("white")
	local crChannel = Jita.Consts.ChatMessagesColors[channelType] or ApolloColor.new("white")

	local crPlayerName = ApolloColor.new("ChatPlayerName")

	if content.bCrossFaction then
		crPlayerName = ApolloColor.new("ChatPlayerNameHostile")
	end

	local strCharacterName       = content.strSender
	local strDisplayName         = content.strDisplayName 

	local strAWPeerCharacterName = content.strAWPeerCharacterName
	local strAWPeerDisplayName   = content.strAWPeerDisplayName

	local source = {
		strCharacterName = strCharacterName,
		nReportId        = content.nReportId,
		strCrossFaction  = content.bCrossFaction and "true" or "false" 
	}

	if content.bSelf 
	and self.StreamType == Jita.Client.EnumStreamsTypes.SEGREGATED
	and Jita.Player.Name
	then
		source.strCharacterName = Jita.Player.Name
		source.nReportId        = nil
		source.strCrossFaction  = "false" 
	end

	--

	xmlLine:AddLine("", crChannel, self.MessageTextFont, "Left")
	xmlPlayerName:AddLine("", crPlayerName, self.MessageTextFont, "Left")

	-- Keepme:
	-- xmlLine:AppendText("#" .. message.ID .. " ", crChannel, self.MessageTextFont, "Left")

	local strTime = ""

	if self.MessageDisplayMode == 'Inline' and Jita.UserSettings.ChatWindow_MessageShowTimestamp == true then
		strTime = message.StrTime

		if self.StreamType == Jita.Client.EnumStreamsTypes.SEGREGATED then
			strTime = "[" .. message.StrTime .. "]"
		end

		xmlLine:AppendText(strTime .. " ", crChannel, self.MessageTextFont, "Left")
	end

	if Jita.UserSettings.ChatWindow_MessageShowPlayerRange == true
	and not content.bSelf
	and message.Range
	and message.Range > 0
	then
		xmlLine:AppendText("[" .. message.Range .. "m] ", "ChatEmote", "CRB_Pixel", "Left")
	end

	if self.MessageDisplayMode == 'Block' then
		xmlPlayerName:AppendText(strDisplayName, crPlayerName, self.MessageTextFont, source, "Source")

		if content.bGM then
			xmlPlayerName:AppendText(" ")
			xmlPlayerName:AppendImage(Jita.Consts.kstrGMIcon, 20, 19)
		end
	end

	-- emote channels gets special formatting
	if channelType == ChatSystemLib.ChatChannel_Emote 
	or channelType == ChatSystemLib.ChatChannel_AnimatedEmote
	then
		if strDisplayName:len() > 0 then
			if content.bGM and self.MessageDisplayMode == 'Inline' then
				xmlPlayerName:AppendImage(Jita.Consts.kstrGMIcon, 16, 16)
				xmlPlayerName:AppendText(" ")
			end

			-- only non-animated emotes get player name appended 
			if channelType == ChatSystemLib.ChatChannel_Emote then
				xmlLine:AppendText(strDisplayName, crPlayerName, self.MessageTextFont, source, "Source")
				xmlLine:AppendText(" ")
			end
		end
	else
		local strChannel = ""

		if channelType == ChatSystemLib.ChatChannel_Society
		or channelType == ChatSystemLib.ChatChannel_Custom
		then
			if Jita.UserSettings.ChatWindow_MessageUseChannelAbbr == true then
				strChannel = (string.format("%s ", String_GetWeaselString(Apollo.GetString("ChatLog_GuildCommand"), string.upper(string.sub(channelName, 1, 1)) , channelCommand)))
			else
				strChannel = (string.format("%s ", String_GetWeaselString(Apollo.GetString("ChatLog_GuildCommand"), channelName, channelCommand)))
			end
		else
			if Jita.UserSettings.ChatWindow_MessageUseChannelAbbr == true
			and channelAbbr ~= ''
			then
				strChannel = String_GetWeaselString(Apollo.GetString("CRB_Brackets_Space"), string.upper(channelAbbr))
			else
				strChannel = String_GetWeaselString(Apollo.GetString("CRB_Brackets_Space"), channelName)
			end
		end

		if Jita.UserSettings.ChatWindow_MessageShowChannelName == true
		or self.StreamType == Jita.Client.EnumStreamsTypes.AGGREGATED -- on aggregated mode we show channel because "the obs"
		then
			xmlPlayerName:AppendText(" @ ", "ChatEmote", self.MessageTextFont, "Left")
			xmlPlayerName:AppendText(strChannel, crChannel, self.MessageTextFont, "Left")

			if self.MessageDisplayMode == 'Inline' then
				xmlLine:AppendText(strChannel, crChannel, self.MessageTextFont, "Left")
			end
		end

		local strPresenceState = ""

		if content.bAutoResponse then
			strPresenceState = '('..Apollo.GetString("AutoResponse_Prefix")..')'
		end

		if content.nPresenceState == FriendshipLib.AccountPresenceState_Away then
			strPresenceState = '<'..Apollo.GetString("Command_Friendship_AwayFromKeyboard")..'>'
		elseif content.nPresenceState == FriendshipLib.AccountPresenceState_Busy then
			strPresenceState = '<'..Apollo.GetString("Command_Friendship_DoNotDisturb")..'>'
		end

		if strDisplayName:len() > 0 then
			if self.MessageDisplayMode == 'Inline' then
				if content.bGM then
					xmlLine:AppendImage(Jita.Consts.kstrGMIcon, 20, 19)
					xmlLine:AppendText(" ")
				end

				if self.StreamType == Jita.Client.EnumStreamsTypes.AGGREGATED 
				and (channelType == ChatSystemLib.ChatChannel_Whisper or channelType == ChatSystemLib.ChatChannel_AccountWhisper)
				and content.bSelf
				and content.strSender
				then
					xmlLine:AppendText(Apollo.GetString("ChatLog_To"), crChannel, self.MessageTextFont, "Left")

					if channelType == ChatSystemLib.ChatChannel_AccountWhisper
					and strAWPeerDisplayName
					and strAWPeerDisplayName:len() > 0
					then
						xmlLine:AppendText(strAWPeerDisplayName, crPlayerName, self.MessageTextFont, source, "Source")
					else
						xmlLine:AppendText(content.strSender, crPlayerName, self.MessageTextFont, source, "Source")
					end
				else
					xmlLine:AppendText(strDisplayName, crPlayerName, self.MessageTextFont, source, "Source")
				end

				xmlLine:AppendText(strPresenceState .. Apollo.GetString("Chat_ColonBreak"), crChannel, self.MessageTextFont, "Left")
			end
		end
	end

	local xmlBubble = nil

	if Jita.UserSettings.ChatWindow_MessageShowBubble == true then
		xmlBubble = XmlDoc.new()

		xmlBubble:AddLine("", crChannel, self.MessageTextFont, "Center")
	end

	--

	local bHasVisibleText = false

	for idx, tSegment in ipairs(content.arMessageSegments) do
		local strText       = tSegment.strText 
		local bAlien        = tSegment.bAlien
		local bShow         = false

		if Jita.UserSettings.ChatWindow_MessageHighlightRolePlay == true
		and strText and strText:len() > 0
		then
			strText = string.gsub(strText, "  "    , " ")
			strText = string.gsub(strText, "%-%-"  , "—")
			strText = string.gsub(strText, "%. "   , ".  ")
			strText = string.gsub(strText, "%! "   , "!  ")
			strText = string.gsub(strText, "%? "   , "?  ")
			strText = string.gsub(strText, "%.%.%.", "…")
		end

		if self.eRoleplayOption == 3 then
			bShow = not tSegment.bRolePlay
		elseif self.eRoleplayOption == 2 then
			bShow = tSegment.bRolePlay
		else
			bShow = true;
		end

		if bShow then
			local crChatText = crText;
			local crBubbleText = Jita.Consts.kstrColorChatRegular
			local strChatFont = self.MessageTextFont
			local strBubbleFont = Jita.Consts.kstrBubbleFont
			local tLink = {}

			if tSegment.uItem ~= nil then -- item link
				-- replace me with correct colors
				strText = String_GetWeaselString(Apollo.GetString("CRB_Brackets"), tSegment.uItem:GetName())
				crChatText = Jita.Consts.karEvalColors[tSegment.uItem:GetItemQuality()]
				crBubbleText = ApolloColor.new("white")

				tLink.strText = strText
				tLink.uItem = tSegment.uItem

			elseif tSegment.uQuest ~= nil then -- quest link
				-- replace me with correct colors
				strText = String_GetWeaselString(Apollo.GetString("CRB_Brackets"), tSegment.uQuest:GetTitle())
				crChatText = ApolloColor.new("green")
				crBubbleText = ApolloColor.new("green")

				tLink.strText = strText
				tLink.uQuest = tSegment.uQuest

			elseif tSegment.uArchiveArticle ~= nil then -- archive article
				-- replace me with correct colors
				strText = String_GetWeaselString(Apollo.GetString("CRB_Brackets"), tSegment.uArchiveArticle:GetTitle())
				crChatText = ApolloColor.new("ffb7a767")
				crBubbleText = ApolloColor.new("ffb7a767")

				tLink.strText = strText
				tLink.uArchiveArticle = tSegment.uArchiveArticle

			elseif tSegment.tNavPoint ~= nil then
				-- replace me with correct colors
				strText = String_GetWeaselString(Apollo.GetString("CRB_Brackets"), "NavPoint")
				crChatText = ApolloColor.new("ffb7a767")
				crBubbleText = ApolloColor.new("ffb7a767")

				tLink.strText = strText
				tLink.tNavPoint = tSegment.tNavPoint

			else
				if tSegment.bRolePlay then
					crBubbleText  = Jita.Consts.kstrColorChatRoleplay
					strChatFont   = self.MessageTextFont
					strBubbleFont = Jita.Consts.kstrDialogFontRP
				end

				if bAlien or tSegment.bProfanity then -- Weak filter. Note only profanity is scrambled.
					strChatFont   = "CRB_AlienMedium"
					strBubbleFont = "CRB_AlienMedium"
				end

				if message.Range ~= nil
				and message.Range > Jita.UserSettings.ChatWindow_SayEmoteRange
				and Jita.UserSettings.ChatWindow_MessageAlienateOutOfRange == true
				then
					strChatFont   = "CRB_AlienMedium"
					strBubbleFont = "CRB_AlienMedium"
				end
			end

			-- Emote replace
			for word in strText:gmatch("%S+") do
				if tEmoticons[word] then
					local emote = tEmoticons[word]
					local s, e = strText:find(word, 1, true)
					local y = 18
					local x = 22
					
					if emote.width then x = emote.width end
					if emote.sound then Event_FireGenericEvent("CET_Sound", emote.sound) end
					
					xmlLine:AppendText(strText:sub(1, s-1), crChatText, strChatFont)
					xmlLine:AppendImage(emote.sprite, x, y)
					
					if xmlBubble then
						xmlBubble:AppendText(strText:sub(1, s-1), crBubbleText, strBubbleFont)
						xmlBubble:AppendImage(emote.sprite, x, y)
					end
					
					strText = strText:sub(e+1)
				end
			end
			
			if next(tLink) == nil then 
				local highlights = self:HighlightChatMessageContent(strText, channelType)

				if highlights then
					for _, part in ipairs(highlights) do
						local hText  = part[1]
						local hColor = Jita.Consts.ChatMessagesColors[part[2]] or crChatText
						local hType  = part[3]

						if hType and hType == "URL" then
							xmlLine:AppendText(hText, hColor, strChatFont, {URL = hText}, "URL")
						else
							xmlLine:AppendText(hText, hColor, strChatFont)
						end
					end
				else
					xmlLine:AppendText(strText, crChatText, strChatFont)
				end
			else
				local strLinkIndex = tostring(self:HelperSaveLink(tLink))

				xmlLine:AppendText(strText, crChatText, strChatFont, {strIndex = strLinkIndex}, "Link")
			end

			if xmlBubble then
				xmlBubble:AppendText(strText, crBubbleText, strBubbleFont) -- Format for bubble; regular
			end

			bHasVisibleText = bHasVisibleText or Jita.Utils:StringEmpty(strText)
		end
	end

	message.XmlObj = 
	{
		XmlPlayerName  = xmlPlayerName  ,
		XmlLine        = xmlLine        ,
		XmlBubble      = xmlBubble      ,
		HasVisibleText = bHasVisibleText
	}

	return message.XmlObj
end


-----------------------------------------------------------------------------------------------
-- ChatEmotesTwitch Instance
-----------------------------------------------------------------------------------------------
local ChatEmotesTwitchInst = ChatEmotesTwitch:new()
ChatEmotesTwitchInst:Init()
