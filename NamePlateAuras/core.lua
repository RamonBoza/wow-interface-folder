local addons, C = ...

C.ACD		= LibStub("AceConfigDialog-3.0")
C.LDBI		= LibStub("LibDBIcon-1.0")
C.LDB		= LibStub("LibDataBroker-1.1")
C.LSM		= LibStub("LibSharedMedia-3.0")
C.L			= LibStub("AceLocale-3.0"):NewLocale(addons, "enUS", true)
C.DB		= "NPAurasDB"
C.ADB		= LibStub("AceDB-3.0")

local ACD 	= C.ACD
local LDBI 	= C.LDBI
local LDB 	= C.LDB
local L 	= C.L
local LSM 	= C.LSM
local ADB	= C.ADB

local DRs	= {}

local options, durationcache

local _adf = "NAD"
local npa_alea_elapsed = 0

----- minimap button config ---------------------------

local MinimapButton = LDB:NewDataObject(addons.." Minimap", {
	type = "data source",
	text = addons,
	desc = addons,
	icon = "Interface\\Icons\\spell_shadow_soulleech_2",
	OnClick = function()
		if ACD.OpenFrames[addons] then
			ACD:Close(addons)
		else
			ACD:Open(addons)
		end
	end,
	
	OnTooltipShow = function(tt)
		tt:ClearLines()
		tt:SetText(addons.." v"..C.myVersionT, 1, 1, 1)
		tt:AddLine("  ")
		tt:AddLine("Open options")
	end,
})

SLASH_NAMEPLATEAURAS1 = '/npa'
SlashCmdList["NAMEPLATEAURAS"] = function(msg, editBox)
	if ACD.OpenFrames[addons] then
		ACD:Close(addons)
	else
		ACD:Open(addons)
	end
end

local core = CreateFrame("Frame")
core:SetScript("OnEvent", function(self, event, ...)	
	self[event](self, event, ...)
end)

local numChildren = -1
local twipe = table.wipe
local tsort = table.sort
local tinsert = table.insert
local band = bit.band
local gsub = string.gsub
local tolower = string.lower
local match = string.match

local WorldFrame = WorldFrame
local UIParent = UIParent

local _myParent = CreateFrame("Frame", nil, UIParent)


local _onupdate = CreateFrame("Frame", addons.."_OnUpdate")

--------------------

local mult = 1

local backdropfadecolor = { .06, .06, .06,  0.3 }
local bordercolor = { 0.1,0.1,0.1,1 }

local movingstatus = false

local font = STANDARD_TEXT_FONT
local fontSize = 8
local fontOutline = 'OUTLINE'
local nonTargetAlpha = 0.6

local ordos_exists = false

-- LibNameplateRegistry1.0
local FSPAT = "%s*"..((_G.FOREIGN_SERVER_LABEL:gsub("^%s", "")):gsub("[%*()]", "%%%1")).."$"

local function RawGetPlateName(frame)

    local name = frame[_adf].name:GetText();

    return name:gsub(FSPAT,"");
end

local defaultSpells1 = {--Important spells, add them with huge icons.
	
	6358, --Seduction

	33786, --Cyclone
	5782, --Fear
	5484, --Howl of Terror
	45438, --Ice Block
	642, --Divine Shield
	8122, --Psychic Scream

	23335, -- Silverwing Flag (alliance WSG flag)
	23333, -- Warsong Flag (horde WSG flag)
	34976, -- Netherstorm Flag (EotS flag)
	2094, --Blind
	33206, --Pain Suppression (priest) 
	47585, --Dispersion (priest)

	87204, -- Shadow Priest 4pPVP
	
	110913, --Warlock temnaia sdelka
	108416, --Warlock Gertvenniy dogovor
	104773, --Warlock Tverdia reshimost
		
	871, --Warrior Shield Wall
	
	19263, --Hunter Deterance
	
	61336, --Druid
	
	31230, --Rogue
	
	6940, --Paladin
	31821, --Paladin
	
	48707, --DK
	
	108271, --Shaman
	30823, --Shaman
	
	53480, --Hunter
	
	108945, --Priest
	6346, --Priest
	15286, --Priest
	
	122783, --Monk
	122278, --Monk
	
	108292, -- HOTW
}

local defaultSpells2 = {--semi-important spells, add them with mid size icons.
	118038, -- warrior 
	45243, -- priest
	116849, -- monk poolp
	15487, --Silence (priest)
	10060, --Power Infusion (priest) 
	2825, --Bloodlust
	5246, --Intimidating Shout (warrior) 
	31224, --Cloak of Shadows (rogue) 
	498, --Divine Protection
	47476, --Strangulate (warlock) 
	31884, --Avenging Wrath (pally) 
	37587, --Bestial Wrath (hunter) 
	12472, --Icy Veins (mage)
	49039, --Lichborne (DK)
	48792, --Icebound Fortitude (DK)
	5277, --Evasion (rogue)
	53563, --Beacon of Light (pally)
	22812, --Barkskin (druid)
	67867, --Trampled (ToC arena spell when you run over someone)
    1022, --Hand of Protection (pally)
	10326, --Turn Evil (pally)

	46968, --Shockwave (warrior)
	46924, --Bladestorm (warrior)
	2983, --Sprint (rogue)
	2335, --Swiftness Potion
	6624, --Free Action Potion
	3448, --Lesser Invisibility Potion
	11464, --Invisibility Potion
	17634, --Potion of Petrification
	53905, --Indestructible Potion
	54221, --Potion of Speed
	1850, --Dash
	87204, --
	
	113860, --Warlock Черная душа: Страдание
	113861, --Warlock Черная душа: Знание	
	113858, --Warlock Черная душа: Изменчивость	
	23920, --Warrior Reflect
	1719, --Warrior Recklessness
	18499, --Warrior Berserk
	71, --Warrior  Defence Stance
	107574, --Warrior Avatar
	12292, --Warrior Bleed
	114028, --Warriot Mass Reflect	
	124974, --Druid
	102342, --Druid
	112071, --Druid Parad?	
	1966, -- Rogue faint	
	48263, --DK blood presens	
	77535, --DK Shield blood	
	16166, --Shaman	
	3045, --Hunter
	19574, --Hunter
	-- Druid
	99, -- Incapacitating Roar (talent)
	-- Hunter
	3355,	-- Freezing Trap
	1499,	-- Freezing Trap
	60192,  -- Freezing Trap
	19386,  -- Wyvern Sting
	-- Mage
	118, -- Polymorph
	28272, -- Polymorph (pig)
	28271, -- Polymorph (turtle)
	61305, -- Polymorph (black cat)
	61025, -- Polymorph (serpent) -- FIXME: gone ?
	61721, -- Polymorph (rabbit)
	61780, -- Polymorph (turkey)
	82691, -- Ring of Frost
	31661, -- Dragon's Breath
	-- Monk
	115078, -- Paralysis
--	123393, -- Breath of Fire (Glyphed)
	137460, -- Ring of Peace -- FIXME: correct spellIDs?
	-- Paladin
	20066, -- Repentance
	-- Priest
	605, -- Dominate Mind
	9484, -- Shackle Undead
	64044, -- Psychic Horror (Horror effect)
	88625, -- Holy Word: Chastise
	-- Rogue
	1776, -- Gouge
	6770, -- Sap
	-- Shaman
	51514, -- Hex
	-- Warlock
	710, -- Banish
	111397,
	137143, -- Blood Horror
	6789, -- Mortal Coil
	-- Pandaren
	107079, -- Quaking Palm
	-- Death Knight
	47476, -- Strangulate
	-- Druid
	114237, -- Glyph of Fae Silence
	-- Mage
	102051, -- Frostjaw
	-- Paladin
	31935, -- Avenger's Shield
	-- Priest
	15487, -- Silence
	-- Rogue
	1330, -- Garrote
	-- Blood Elf
	25046, -- Arcane Torrent (Energy version)
	28730, -- Arcane Torrent (Mana version)
	50613, -- Arcane Torrent (Runic power version)
	69179, -- Arcane Torrent (Rage version)
	80483, -- Arcane Torrent (Focus version)

	--[[ DISORIENTS ]]--
	-- Druid
	33786, -- Cyclone
	-- Paladin
	105421, -- Blinding Light -- FIXME: is this the right category? Its missing from blizzard's list
	10326, -- Turn Evil
	-- Priest
	8122, -- Psychic Scream
	-- Rogue
	2094, -- Blind
	-- Warlock
	5782, -- Fear -- probably unused
	118699, -- Fear -- new debuff ID since MoP
	130616, -- Fear (with Glyph of Fear)
	5484, -- Howl of Terror (talent)
	115268, -- Mesmerize (Shivarra)
	6358, -- Seduction (Succubus)
	-- Warrior
	5246, -- Intimidating Shout (main target)
	-- Death Knight
	108194, -- Asphyxiate
	91800, -- Gnaw (Ghoul)
	91797, -- Monstrous Blow (Dark Transformation Ghoul)
	115001, -- Remorseless Winter
	-- Druid
	22570, -- Maim
	5211, -- Mighty Bash
	1822, -- Rake (Stun from Prowl)
	163505, -- Rake (Stun from Prowl)
	-- Hunter
	109248, -- Binding Shot
	117526, -- Binding Shot
	19577, -- Intimidation
	24394, -- Intimidation
	-- Mage
	44572, -- Deep Freeze
	-- Monk
	119392, -- Charging Ox Wave
	113656, -- Fists of Fury
	120086, -- Fists of Fury
	119381, -- Leg Sweep
	-- Paladin
	853, -- Hammer of Justice
	119072, -- Holy Wrath
	105593, -- Fist of Justice
	-- Rogue
	1833, -- Cheap Shot
	408, -- Kidney Shot
	-- Shaman
	118345, -- Pulverize (Primal Earth Elemental)
	118905, -- Static Charge (Capacitor Totem)
	-- Warlock
	89766, -- Axe Toss (Felguard)
	30283, -- Shadowfury
	1122, --  Summon Infernal
	22703, -- Summon Infernal
	-- Warrior
	132168, -- Shockwave
	132169, -- Storm Bolt
	-- Tauren
	20549, -- War Stomp
	-- Death Knight
	96294, -- Chains of Ice (Chilblains Root)
	-- Druid
	339, -- Entangling Roots
	102359, -- Mass Entanglement (talent)
	113770, -- Entangling Roots (Treants)
	-- Hunter
	61685, 
	53148, -- Charge (Tenacity pet)
	135373, -- Entrapment (passive)
	136634, -- Narrow Escape (passive talent)
	-- Mage
	122, -- Frost Nova
	33395, -- Freeze (Water Elemental)
	111340, -- Ice Ward
	-- Monk
	116095, --
	116706, -- Disable

	-- Priest
	87194, -- Glyph of Mind Blast
	114404, -- Void Tendrils
	-- Shaman
	63685, -- Freeze (Frozen Power talent)
	64695, -- Earthgrab Totem
}


local function GetSpell(spellid)
	
	local name = GetSpellInfo(spellid)
	
	if not name then
		print(addons, "Invalid spellid:", spellid)
	end
	return name
end

local spellstringcache = {}

function C:SpellString(spellid)
	if not spellstringcache[spellid] then
		local name, _, icon = GetSpellInfo(spellid)
		spellstringcache[spellid] = "\124T"..( icon or "Interface\\Icons\\Inv_misc_questionmark" )..":10\124t ".. ( name or UNKNOWN )
	end
	
	return spellstringcache[spellid]
end

function C:GetSpells()
	local spellist_ = {}
	
	for k,v in pairs(defaultSpells1) do		
		local name = GetSpell(v)
		if name then
			spellist_[name] = { 2, v, showing = 1, auratype = 1 }
			
			self:SpellString(v)
		end
	end

	for k,v in pairs(defaultSpells2) do	
		local name = GetSpell(v)
		if name then
			spellist_[name] = { 1.5, v, showing = 1, auratype = 1 }
			
			self:SpellString(v)
		end
	end

	return spellist_
end


--------------------


core.NumTargetChecks = -1
core.CreatedPlates = {};
core.ByRaidIcon = {}			-- Raid Icon to GUID 
core.ByName = {}				-- Name to GUID (PVP)
core.AuraList = {}	-- Two Dimensional
core.AuraSpellID = {}
core.AuraSpellName = {}
core.AuraExpiration = {}
core.AuraStacks = {}
core.AuraCaster = {}
core.AuraDuration = {}
core.AuraTexture = {}
core.AuraType = {}
core.AuraTarget = {}
core.CachedAuraDurations = {}
core.BuffCache = {}
core.DebuffCache = {}
core.FrameToGuid = {}
core.ByBossName = {}
core.MyPlateToBlizzard = {}
core.AuraPurgeReady = {}

local Kyrilka = {}



core.RaidTargetReference = {
	["STAR"] = 0x00000001,
	["CIRCLE"] = 0x00000002,
	["DIAMOND"] = 0x00000004,
	["TRIANGLE"] = 0x00000008,
	["MOON"] = 0x00000010,
	["SQUARE"] = 0x00000020,
	["CROSS"] = 0x00000040,
	["SKULL"] = 0x00000080,
}

local flagtort = {
   [COMBATLOG_OBJECT_RAIDTARGET8] = "SKULL",
   [COMBATLOG_OBJECT_RAIDTARGET7] = "CROSS",
   [COMBATLOG_OBJECT_RAIDTARGET6] = "SQUARE",
   [COMBATLOG_OBJECT_RAIDTARGET5] = "MOON",
   [COMBATLOG_OBJECT_RAIDTARGET4] = "TRIANGLE",
   [COMBATLOG_OBJECT_RAIDTARGET3] = "DIAMOND",
   [COMBATLOG_OBJECT_RAIDTARGET2] = "CIRCLE",
   [COMBATLOG_OBJECT_RAIDTARGET1] = "STAR",
 }
 
core.RaidIconCoordinate = {
	[0]		= { [0]		= "STAR", [0.25]	= "MOON", },
	[0.25]	= { [0]		= "CIRCLE", [0.25]	= "SQUARE",	},
	[0.5]	= { [0]		= "DIAMOND", [0.25]	= "CROSS", },
	[0.75]	= { [0]		= "TRIANGLE", [0.25]	= "SKULL", }, 
}

local AURA_UPDATE_INTERVAL = 0.1
local AURA_TARGET_HOSTILE = 1
local AURA_TARGET_FRIENDLY = 2
local AuraList, AuraGUID = {}, {}

local RaidIconIndex = {
	"STAR",
	"CIRCLE",
	"DIAMOND",
	"TRIANGLE",
	"MOON",
	"SQUARE",
	"CROSS",
	"SKULL",
}
local TimeColors = {
	[0] = '|cffeeeeee',
	[1] = '|cffeeeeee',
	[2] = '|cffeeeeee',
	[3] = '|cffFFEE00',
	[4] = '|cfffe0000',
}

local function updateDebug(frame, myplate)
	local cleu = ( frame[_adf].guid and "CLEU status - GOOD" or "CLEU status - BAD" )
	
	local bytype = "nil"
	
	if RAID_CLASS_COLORS[frame[_adf].unitType] then
		bytype = frame[_adf].unitType
	else
		bytype = frame[_adf].unitType
	end
	
	local unit = frame[_adf].unit or "unknown"
	
	local name = myplate.nameText or "unknown"
	
	local isSmall = frame[_adf].isSmall and "minus" or "normal"
	
	myplate.test:SetFormattedText("%s\n%s\n%s\n%s\n%s", cleu, bytype, unit, name, isSmall)
	
	if not myplate.test:IsShown() then
		myplate.test:Show()
	end
end

function core:OnUpdate(elapsed)

	local count = WorldFrame:GetNumChildren()
	if(count ~= numChildren) then
		numChildren = count
		core:ScanFrames(WorldFrame:GetChildren())
	end
	
	core.PlateParent:Hide()
	for blizzPlate, plate in pairs(core.CreatedPlates) do
		if(blizzPlate:IsShown()) then
			if(not self.viewPort) then
		--		plate:SetPoint("CENTER", WorldFrame, "BOTTOMLEFT", blizzPlate:GetCenter())
			end
			core.SetAlpha(blizzPlate, plate)
		else
			plate:Hide()
		end
	end
	core.PlateParent:Show()

	
	if(npa_alea_elapsed and npa_alea_elapsed > 0.2) then
		for blizzPlate, plate in pairs(core.CreatedPlates) do
			if(blizzPlate:IsShown() and plate:IsShown()) then
				core.SetUnitInfo(blizzPlate, plate)
				blizzPlate[_adf].unitType = core:GetReaction(blizzPlate)
				
				if C.db.profile.showdebug then
					updateDebug(blizzPlate, plate)
				elseif plate.test:IsShown() then
					plate.test:Hide()
				end
			end
		end

		npa_alea_elapsed = 0
	else
		npa_alea_elapsed = (npa_alea_elapsed or 0) + elapsed
	end	
end

local blacklist = {}
function core:CheckFilter(myPlate)
	local name = myPlate.nameText --RawGetPlateName(self)
	
	local db = blacklist[name]
	
	if db and db.enable then
		if db.hide then
			myPlate:Hide()
			return
		else
			if(not myPlate:IsShown()) then
				myPlate:Show()
			end
		end
	elseif(not myPlate:IsShown()) then
		myPlate:Show()
	end
	return true
end

local color, scale

function core:SetAlpha(myPlate)
	if self:GetAlpha() < 1 then
		myPlate:SetAlpha(nonTargetAlpha)
	else
		myPlate:SetAlpha(1)
	end
end

function core:SetUnitInfo(myPlate)
	local plateName = myPlate.nameText --RawGetPlateName(self)
	
	if self:GetAlpha() == 1 and core.targetName and (core.targetName == plateName) then
		self[_adf].guid = UnitGUID("target")
		self[_adf].unit = "target"
		myPlate:SetFrameLevel(2)
		
		if plateName and UnitIsPlayer("target") then
			Kyrilka[plateName] = select(2, UnitClass("target"))
			core.ByName[plateName] = self[_adf].guid
		end
	
	
		if((core.NumTargetChecks > -1) or self[_adf].allowCheck) then
			core.NumTargetChecks = core.NumTargetChecks + 1
			if core.NumTargetChecks > 0 then
				core.NumTargetChecks = -1
			end
			
			core:UpdateAurasByUnitID('target')
			self[_adf].allowCheck = nil
		end
	elseif self[_adf].highlight:IsShown() and UnitExists("mouseover") and (UnitName("mouseover") == plateName) then
		self[_adf].guid = UnitGUID("mouseover")
		
		if(self[_adf].unit ~= "mouseover" or self[_adf].allowCheck) then
			myPlate:SetFrameLevel(1)		
			self[_adf].allowCheck = nil
		end
		
		
		self[_adf].unit = "mouseover"		
		
		if plateName and UnitIsPlayer("mouseover") then
			Kyrilka[plateName] = select(2, UnitClass("mouseover"))
			core.ByName[plateName] = self[_adf].guid
		end
		
		core:UpdateAurasByUnitID('mouseover')
	else
		myPlate:SetFrameLevel(0)
		self[_adf].unit = nil
	end

end

function core:UPDATE_MOUSEOVER_UNIT()
	npa_alea_elapsed = 0.1
end


function core:PLAYER_TARGET_CHANGED()
	if(UnitExists("target")) then
		self.targetName = UnitName("target")
		npa_alea_elapsed = 0.1
		core.NumTargetChecks = 0
	else
		self.targetName = nil
	end
end

local function Channeling()
	return UnitChannelInfo("player")
end

--[[
function core:PLAYER_STARTED_MOVING()
	
	if not movingstatus then
		movingstatus = true
	end
end

function core:PLAYER_STOPPED_MOVING()

	if movingstatus then
		movingstatus = false
	end
end

local _facing = CreateFrame("Frame")
_facing:SetScript("OnUpdate", function(self, elapsed)
	self.elapsed = ( self.elapsed or 0 ) + elapsed
	
	if self.elapsed < 0.1 then return end

	if self.rads ~= GetPlayerFacing() then
		self.rads = GetPlayerFacing()
		self.elapsed = 0
		print("UPDATE")
	end
end)
]]

core:RegisterEvent("PLAYER_LOGIN")

function C:UpdateMinimap() 
	if options.minimap.hide then
		LDBI:Show(addons.." Minimap")
	else
		LDBI:Hide(addons.." Minimap")
	end
end

function core:PLAYER_LOGIN()
	
	if not NPAurasSPDCache then NPAurasSPDCache = {} end

	SetCVar("ShowClassColorInNameplate", 1)	
	SetCVar("repositionfrequency", 0)

	durationcache = NPAurasSPDCache
	
	self.PlateParent = CreateFrame("Frame", nil, WorldFrame)
	self.PlateParent:SetFrameStrata("BACKGROUND")
	self.PlateParent:SetFrameLevel(0)
	
--	_onupdate:SetScript('OnUpdate',  core.OnUpdate)
	
	WorldFrame:HookScript("OnUpdate",  core.OnUpdate)
	
	
	C:DefaultOptions()
	C.options = C:OptionsTable()
	LibStub("AceConfig-3.0"):RegisterOptionsTable(addons, C.options)
	options = C.db.profile
	
	C:UpdateHeaderTableOptions()
	
	LDBI:Register(addons.." Minimap", MinimapButton, options)
	
	C:UpdateMinimap() 
	
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("UNIT_AURA")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	self:RegisterEvent("ARENA_OPPONENT_UPDATE")
	--[[
	self:RegisterEvent("PLAYER_STARTED_MOVING")
	self:RegisterEvent("PLAYER_STOPPED_MOVING")
	]]

	C:InitSupports()
end

function C:UpdateAllPlates()
	core:ForEachPlate("UpdateSettings")
end

function C:UpdateAllHeaders()
	core:ForEachPlate("ResetHeaders")
end

function core:ResetHeaders()
	local myPlate = core.CreatedPlates[self]
	
	myPlate.BuffWidget:Hide()
	myPlate.DebuffWidget:Hide()
	myPlate.BothHeader:Hide()
	
	if myPlate.BuffWidget then
		for index = 1, #myPlate.BuffWidget.icons do 
			core.PolledHideIn(myPlate.BuffWidget.icons[index], 0)
		end		
	end

	if myPlate.DebuffWidget then
		for index = 1, #myPlate.DebuffWidget.icons do 
			core.PolledHideIn(myPlate.DebuffWidget.icons[index], 0)
		end		
	end
	
	if myPlate.BothHeader then
		for index = 1, #myPlate.BothHeader.icons do 
			core.PolledHideIn(myPlate.BothHeader.icons[index], 0)
		end		
	end
	
end

function core:ForEachPlate(functionToRun, ...)
	for blizzPlate, plate in pairs(self.CreatedPlates) do
		if(blizzPlate) then
			self[functionToRun](blizzPlate, plate, ...)
		end
	end
end

function core:RoundColors(r, g, b)	
	return floor(r*100+.5)/100, floor(g*100+.5)/100, floor(b*100+.5)/100
end

function core:OnShow()
	local myPlate = core.CreatedPlates[self]	
	myPlate.nameText = RawGetPlateName(self)
	
	if(not core.CheckFilter(self, myPlate)) then return end
	self[_adf].isSmall = (self[_adf].healthBar:GetEffectiveScale() < 1 and true)
	
	
	myPlate:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT") --Prevent nameplate being in random location on screen when first shown

	self[_adf].unitType = core:GetReaction(self)

--	print("T", "OnShow", myPlate.nameText, self[_adf].isSmall)
	
	if(not self[_adf].isSmall) then
		self[_adf].allowCheck = true
		core:CheckRaidIcon(self)
		core:UpdateAuras(self)
	else
		self[_adf].allowCheck = false
	end
end

function core:OnHide()
	local myPlate = core.CreatedPlates[self]
	self[_adf].unitType = nil
	self[_adf].guid = nil
	self[_adf].unit = nil
	self[_adf].raidIconType = nil
	self[_adf].isSmall = nil
	self[_adf].allowCheck = nil

	if myPlate.BuffWidget then
		for index = 1, #myPlate.BuffWidget.icons do 
			core.PolledHideIn(myPlate.BuffWidget.icons[index], 0)
		end		
	end

	if myPlate.DebuffWidget then
		for index = 1, #myPlate.DebuffWidget.icons do 
			core.PolledHideIn(myPlate.DebuffWidget.icons[index], 0)
		end		
	end
	
	if myPlate.BothHeader then
		for index = 1, #myPlate.BothHeader.icons do 
			core.PolledHideIn(myPlate.BothHeader.icons[index], 0)
		end		
	end

	for i=1, #myPlate._cooldowns do
		myPlate._cooldowns[i]:Hide()
	end
	
	myPlate:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT") --Prevent nameplate being in random location on screen when first shown
end

function core:OnSizeChanged(x, y)
	self.f:Hide() -- Important, never move the frame while it's visible
	self.f:SetPoint('CENTER', WorldFrame, 'BOTTOMLEFT', x, y) -- Immediately reposition frame
	self.f:Show()
end

function core:SizeAuraHeader(myPlate, auraHeader, dbTable)
	local db = C.db.profile[dbTable]
	local baseSpacing = C.db.profile.spacing
	local numAuras = db.numAuras
	local auraWidth =  C.db.profile.aura_size -- ((width - (baseSpacing * (numAuras - 1))) / numAuras)
	local auraHeight = (db.stretchTexture and (auraWidth * 0.72) or auraWidth)

	for index = 1, numAuras do
		if not auraHeader.icons[index] then
			auraHeader.icons[index] = core:CreateAuraIcon(auraHeader, myPlate, dbTable); 
		end
		auraHeader.icons[index].id = index
		auraHeader.icons[index]:SetWidth(auraWidth)
		auraHeader.icons[index]:SetHeight(auraHeight)
		
		auraHeader.icons[index].width = auraWidth
		auraHeader.icons[index].height = auraHeight
		
		auraHeader.icons[index]:ClearAllPoints()
		if(dbTable == 'debuffs') then
			if(index == 1) then
				auraHeader.icons[index]:SetPoint("BOTTOMLEFT", auraHeader, "TOPLEFT",0, 0)
			else
				auraHeader.icons[index]:SetPoint("BOTTOMLEFT", auraHeader.icons[index-1], "BOTTOMRIGHT", baseSpacing, 0) 
			end
		elseif(dbTable == 'buffs') then
			if(index == 1) then
				auraHeader.icons[index]:SetPoint("BOTTOMRIGHT", auraHeader, "TOPRIGHT",0, 0)
			else
				auraHeader.icons[index]:SetPoint("BOTTOMRIGHT", auraHeader.icons[index-1], "BOTTOMLEFT", -baseSpacing, 0) 
			end
		end
	end
	
	
	if(numAuras > #auraHeader.icons) then
		for index = (numAuras + 1), #auraHeader.icons do
			core.PolledHideIn(auraHeader.icons[index], 0)
		end
	end

	auraHeader.numAuras = numAuras
end

do
	local format = format
	local gsub = gsub
	
	local function ShortValue(v)
		if v >= 1e9 then
			return ("%.1fb"):format(v / 1e9):gsub("%.?0+([kmb])$", "%1")
		elseif v >= 1e6 then
			return ("%.1fm"):format(v / 1e6):gsub("%.?0+([kmb])$", "%1")
		elseif v >= 1e3 or v <= -1e3 then
			return ("%.1fk"):format(v / 1e3):gsub("%.?0+([kmb])$", "%1")
		else
			return v
		end
	end
	function core:FormattedText(cur, maxx)

		local hp = ( cur / maxx ) * 100

		if hp >= 100 then
			return format("%s - %d%s", ShortValue(cur), hp, "%")
		else
			return format("%s - %.1f%s", ShortValue(cur), hp, "%")
		end
	end
end

local green =  {r = 0, g = 1, b = 0}

local testing = false

function core:UpdateSettings()
	local myPlate = core.CreatedPlates[self]
	
	self[_adf].name:SetFont( LSM:Fetch("font",C.db.profile.font), C.db.profile.font_size, C.db.profile.font_flag)
	self[_adf].level:SetFont( LSM:Fetch("font",C.db.profile.font), C.db.profile.font_size, C.db.profile.font_flag)
	
	if IsAddOnLoaded("ElvUI") or IsAddOnLoaded("AleaUI") or IsAddOnLoaded("TukUI") or IsAddOnLoaded("TidyPlates") then
		self[_adf].healthBar:GetStatusBarTexture():SetTexture('')
	else
		self[_adf].healthBar:GetStatusBarTexture():SetTexture(LSM:Fetch("statusbar", C.db.profile.statusbar))
	end
	
	self[_adf].border:SetVertexColor(C.db.profile.border_vertex_color[1], C.db.profile.border_vertex_color[2], C.db.profile.border_vertex_color[3], C.db.profile.border_vertex_color[4])
	
	
	--Buffs
	for index = 1, #myPlate.BuffWidget.icons do 
		if myPlate.BuffWidget.icons and myPlate.BuffWidget.icons[index] then
			myPlate.BuffWidget.icons[index].TimeLeft:SetFont(LSM:Fetch("font",C.db.profile.font_icon), C.db.profile.font_size_icon, C.db.profile.font_flag_icon)
			myPlate.BuffWidget.icons[index].Stacks:SetFont(LSM:Fetch("font",C.db.profile.font_icon), C.db.profile.font_size_icon, C.db.profile.font_flag_icon)
			
			if C.db.profile.show_text_background then
				myPlate.BuffWidget.icons[index].TimeLeft.bg:SetTexture(0, 0, 0, 1)
				myPlate.BuffWidget.icons[index].Stacks.bg:SetTexture(0, 0, 0, 1)
			else
				myPlate.BuffWidget.icons[index].TimeLeft.bg:SetTexture(0, 0, 0, 0)
				myPlate.BuffWidget.icons[index].Stacks.bg:SetTexture(0, 0, 0, 0)
			end
			
			myPlate.BuffWidget.icons[index].TimeLeft:SetPoint(C.db.profile.time_font_point, myPlate.BuffWidget.icons[index], C.db.profile.time_font_point, C.db.profile.time_font_xpos, C.db.profile.time_font_ypos)
			myPlate.BuffWidget.icons[index].TimeLeft:SetJustifyH(C.db.profile.time_font_justify)

			myPlate.BuffWidget.icons[index].Stacks:SetPoint(C.db.profile.stack_font_point, myPlate.BuffWidget.icons[index], C.db.profile.stack_font_point, C.db.profile.stack_font_xpos, C.db.profile.stack_font_ypos)
			myPlate.BuffWidget.icons[index].Stacks:SetJustifyH(C.db.profile.stack_font_justify)
			
			if C.db.profile.cooldownoverlay_texture then
				myPlate.BuffWidget.icons[index].Cooldown:SetSwipeColor(0, 0, 0, 0)
			else
				myPlate.BuffWidget.icons[index].Cooldown:SetSwipeColor(0, 0, 0, 0.6)
			end
	
			if C.db.profile.buffs.stretchTexture then
				myPlate.BuffWidget.icons[index].Icon:SetTexCoord(.07, 0.93, .23, 0.77)
			else
				myPlate.BuffWidget.icons[index].Icon:SetTexCoord(.07, .93, .07, .93)
			end
		end
	end

	local yOffset = C.db.profile.debuffs.stretchTexture and -8 or -2
	myPlate.BuffWidget:SetPoint('BOTTOMRIGHT', myPlate.DebuffWidget, 'TOPRIGHT', 0, yOffset)
	myPlate.BuffWidget:SetPoint('BOTTOMLEFT', myPlate.DebuffWidget, 'TOPLEFT', 0, yOffset)	
	myPlate.BuffWidget:SetHeight(C.db.profile.aura_size*3)
	
	--Debuffs
	for index = 1, #myPlate.DebuffWidget.icons do 
		if myPlate.DebuffWidget.icons and myPlate.DebuffWidget.icons[index] then
			myPlate.DebuffWidget.icons[index].TimeLeft:SetFont(LSM:Fetch("font",C.db.profile.font_icon), C.db.profile.font_size_icon, C.db.profile.font_flag_icon)
			myPlate.DebuffWidget.icons[index].Stacks:SetFont(LSM:Fetch("font",C.db.profile.font_icon), C.db.profile.font_size_icon, C.db.profile.font_flag_icon)
			
			if C.db.profile.show_text_background then
				myPlate.DebuffWidget.icons[index].TimeLeft.bg:SetTexture(0, 0, 0, 1)
				myPlate.DebuffWidget.icons[index].Stacks.bg:SetTexture(0, 0, 0, 1)
			else
				myPlate.DebuffWidget.icons[index].TimeLeft.bg:SetTexture(0, 0, 0, 0)
				myPlate.DebuffWidget.icons[index].Stacks.bg:SetTexture(0, 0, 0, 0)
			end
			
			myPlate.DebuffWidget.icons[index].TimeLeft:SetPoint(C.db.profile.time_font_point, myPlate.DebuffWidget.icons[index], C.db.profile.time_font_point, C.db.profile.time_font_xpos, C.db.profile.time_font_ypos)
			myPlate.DebuffWidget.icons[index].TimeLeft:SetJustifyH(C.db.profile.time_font_justify)

			myPlate.DebuffWidget.icons[index].Stacks:SetPoint(C.db.profile.stack_font_point, myPlate.DebuffWidget.icons[index], C.db.profile.stack_font_point, C.db.profile.stack_font_xpos, C.db.profile.stack_font_ypos)
			myPlate.DebuffWidget.icons[index].Stacks:SetJustifyH(C.db.profile.stack_font_justify)
			
			if C.db.profile.cooldownoverlay_texture then
				myPlate.DebuffWidget.icons[index].Cooldown:SetSwipeColor(0, 0, 0, 0)
			else
				myPlate.DebuffWidget.icons[index].Cooldown:SetSwipeColor(0, 0, 0, 0.6)
			end
			
			if C.db.profile.debuffs.stretchTexture then
				myPlate.DebuffWidget.icons[index].Icon:SetTexCoord(.07, 0.93, .23, 0.77)
			else
				myPlate.DebuffWidget.icons[index].Icon:SetTexCoord(.07, .93, .07, .93)
			end
		end
	end	
	myPlate.DebuffWidget:SetPoint('BOTTOMRIGHT', myPlate, 'TOPRIGHT', C.db.profile.frame_offset_x, C.db.profile.frame_offset)
	myPlate.DebuffWidget:SetPoint('BOTTOMLEFT', myPlate, 'TOPLEFT', C.db.profile.frame_offset_x, C.db.profile.frame_offset)
	
	
	-- BothHeader
	for index = 1, #myPlate.BothHeader.icons do 
		if myPlate.BothHeader.icons and myPlate.BothHeader.icons[index] then
			myPlate.BothHeader.icons[index].TimeLeft:SetFont(LSM:Fetch("font",C.db.profile.font_icon), C.db.profile.font_size_icon, C.db.profile.font_flag_icon)
			myPlate.BothHeader.icons[index].Stacks:SetFont(LSM:Fetch("font",C.db.profile.font_icon), C.db.profile.font_size_icon, C.db.profile.font_flag_icon)
			
			if C.db.profile.show_text_background then
				myPlate.BothHeader.icons[index].TimeLeft.bg:SetTexture(0, 0, 0, 1)
				myPlate.BothHeader.icons[index].Stacks.bg:SetTexture(0, 0, 0, 1)
			else
				myPlate.BothHeader.icons[index].TimeLeft.bg:SetTexture(0, 0, 0, 0)
				myPlate.BothHeader.icons[index].Stacks.bg:SetTexture(0, 0, 0, 0)
			end
			
			myPlate.BothHeader.icons[index].TimeLeft:SetPoint(C.db.profile.time_font_point, myPlate.BothHeader.icons[index], C.db.profile.time_font_point, C.db.profile.time_font_xpos, C.db.profile.time_font_ypos)
			myPlate.BothHeader.icons[index].TimeLeft:SetJustifyH(C.db.profile.time_font_justify)

			myPlate.BothHeader.icons[index].Stacks:SetPoint(C.db.profile.stack_font_point, myPlate.BothHeader.icons[index], C.db.profile.stack_font_point, C.db.profile.stack_font_xpos, C.db.profile.stack_font_ypos)
			myPlate.BothHeader.icons[index].Stacks:SetJustifyH(C.db.profile.stack_font_justify)
			
			if C.db.profile.cooldownoverlay_texture then
				myPlate.BothHeader.icons[index].Cooldown:SetSwipeColor(0, 0, 0, 0)
			else
				myPlate.BothHeader.icons[index].Cooldown:SetSwipeColor(0, 0, 0, 0.6)
			end
			
			if C.db.profile.debuffs.stretchTexture then
				myPlate.BothHeader.icons[index].Icon:SetTexCoord(.07, 0.93, .23, 0.77)
			else
				myPlate.BothHeader.icons[index].Icon:SetTexCoord(.07, .93, .07, .93)
			end
		end
	end	
	
	myPlate.BothHeader:SetPoint('BOTTOMRIGHT', myPlate, 'TOPRIGHT', C.db.profile.frame_offset_x, C.db.profile.frame_offset)
	myPlate.BothHeader:SetPoint('BOTTOMLEFT', myPlate, 'TOPLEFT', C.db.profile.frame_offset_x, C.db.profile.frame_offset)
	
	core:SizeAuraHeader(myPlate, myPlate.BuffWidget, 'buffs')
	core:SizeAuraHeader(myPlate, myPlate.DebuffWidget, 'debuffs')
	core:SizeAuraHeader(myPlate, myPlate.BothHeader, 'both')
	
	core.OnShow(self)
end

function core:CreatePlate(frame)
	
	frame[_adf] = {}
	
	frame[_adf].barFrame, frame[_adf].nameFrame = frame:GetChildren()
	
	frame[_adf].healthBar = frame[_adf].barFrame:GetChildren()
	
	frame[_adf].threat, frame[_adf].border, frame[_adf].highlight, frame[_adf].level, frame[_adf].bossIcon, frame[_adf].raidIcon, frame[_adf].eliteIcon = frame[_adf].barFrame:GetRegions()
	
	frame[_adf].name = frame[_adf].nameFrame:GetRegions()
	
	
	-- AleaUI
	frame[_adf].raidIcon = frame[_adf].raidIcon or frame.raidIcon
	frame[_adf].eliteIcon = frame[_adf].eliteIcon or frame.eliteIcon
	
	---
	--[[
	print("T1", frame.NAbarFrame, frame.NAnameFrame)
	print("T2", frame.NAhealthBar)
	print("T3", frame.NAthreat, frame.NAborder, frame.NAhighlight, frame.NAlevel, frame.NAbossIcon, frame.NAraidIcon, frame.NAeliteIcon)
	print("T4", frame.NAname)
	]]
	
	local myPlate = CreateFrame("Frame", nil, self.PlateParent)

	if(self.viewPort) then
		myPlate:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT")
	end
	
	myPlate._cooldowns = {}
	
	myPlate.test = myPlate:CreateFontString(nil, 'OVERLAY')
	myPlate.test:SetJustifyH("LEFT")
	myPlate.test:SetPoint("BOTTOM", myPlate, "TOP")
	myPlate.test:SetFont(STANDARD_TEXT_FONT, 9, "OUTLINE")
	myPlate.test:SetText("")

	local debuffHeader = CreateFrame("Frame", nil, myPlate)
	debuffHeader:SetHeight(3); debuffHeader:Show()  --32
	debuffHeader:SetPoint('BOTTOMRIGHT', myPlate, 'TOPRIGHT', 0, C.db.profile.frame_offset)
	debuffHeader:SetPoint('BOTTOMLEFT', myPlate, 'TOPLEFT', 0, C.db.profile.frame_offset)
	debuffHeader:SetFrameStrata("BACKGROUND")
	debuffHeader:SetFrameLevel(0)	
	debuffHeader.PollFunction = core.UpdateAuraTime
	debuffHeader.icons = {}
	debuffHeader.parent = frame
	
	if testing then	
		debuffHeader.bg = debuffHeader:CreateTexture(nil, "BACKGROUND")
		debuffHeader.bg:SetAllPoints()
		debuffHeader.bg:SetTexture(1, 0, 0, 0.5)
	end
	
	myPlate.DebuffWidget = debuffHeader		

	--Buffs
	local buffHeader = CreateFrame("Frame", nil, myPlate)
	buffHeader:SetHeight(3); buffHeader:Show()
	buffHeader:SetFrameStrata("BACKGROUND")
	buffHeader:SetFrameLevel(0)	
	buffHeader.PollFunction = core.UpdateAuraTime
	buffHeader.icons = {}
	buffHeader.parent = frame
	
	if testing then	
		buffHeader.bg = buffHeader:CreateTexture(nil, "BACKGROUND")
		buffHeader.bg:SetAllPoints()
		buffHeader.bg:SetTexture(0, 1, 0, 0.5)
	end
	myPlate.BuffWidget = buffHeader		
	
	
	
	local BothHeader = CreateFrame("Frame", nil, myPlate)
	BothHeader:SetHeight(3); BothHeader:Show()
	BothHeader:SetFrameStrata("BACKGROUND")
	BothHeader:SetFrameLevel(0)	
	BothHeader.PollFunction = core.UpdateAuraTime
	BothHeader.icons = {}
	BothHeader.parent = frame
	
	if testing then	
		BothHeader.bg = BothHeader:CreateTexture(nil, "BACKGROUND")
		BothHeader.bg:SetAllPoints()
		BothHeader.bg:SetTexture(0, 1, 0, 0.5)
	end
	myPlate.BothHeader = BothHeader	
	
	--Script Handlers
	frame:HookScript("OnShow", core.OnShow)
	frame:HookScript("OnHide", core.OnHide)
	
	local sizer = CreateFrame('frame', nil, myPlate)
	sizer.f = myPlate
	sizer:SetPoint('BOTTOMLEFT', WorldFrame)
	sizer:SetPoint('TOPRIGHT', frame, 'CENTER')
	sizer:SetScript('OnSizeChanged', core.OnSizeChanged)
					
	myPlate._owner = frame
	
	self.CreatedPlates[frame] = myPlate
	self.MyPlateToBlizzard[myPlate] = frame
	
	--[[
	myPlate._blizplate = frame
	myPlate._ismyplate = "ismyplate"
	
	myPlate.GetBlizzardPlate = function(self)	
		return self, self._blizplate, core.MyPlateToBlizzard[self]
	end
	]]
	
	core.UpdateSettings(frame)
end

function core:ScanFrames(...)
	for index = 1, select('#', ...) do
		local frame = select(index, ...)
		local name = frame:GetName()
		
		if(not core.CreatedPlates[frame] and (name and name:find("NamePlate%d"))) then
			core:CreatePlate(frame)
		end
	end
end

---------------------------------------------
--Auras
---------------------------------------------
do
	local PolledHideIn
	local Framelist = {}	
	local Watcherframe = CreateFrame("Frame")
	local WatcherframeActive = false
	local select = select
	local timeToUpdate = 0
	
	local function CheckFramelist(self)
		local curTime = GetTime()
		if curTime < timeToUpdate then return end
		local framecount = 0
		timeToUpdate = curTime + AURA_UPDATE_INTERVAL

		for frame, expiration in pairs(Framelist) do
		
			if ( expiration < curTime ) and not frame.unlimited then 
				frame:Hide(); 
				frame.Cooldown:Hide()
				
				if frame._parent then
					if core:RemoveAuraInstance(frame.guid, frame.spellid, frame.caster) then
						return core:UpdateAuras(frame._parent._owner, "CheckFrameList")
					end
				end
			else 
				if frame.Poll then 
					frame.Poll(core, frame, frame.expiration, frame.duration) 
				end
				
				if curTime < frame.expiration and C.db.profile.cooldownoverlay then
					frame.Cooldown:Show()
					frame.Cooldown:SetCooldown(frame.expiration-frame.duration, frame.duration)
				else
					frame.Cooldown:Hide()
				end
				
				framecount = framecount + 1
			end
		end

		if framecount == 0 then 
			Watcherframe:SetScript("OnUpdate", nil); 
			WatcherframeActive = false 
		end
	end
	
	function PolledHideIn(frame, expiration, unlimited)
		if(not frame) then return end
		
		if expiration <= 0 and not unlimited then 
			frame:Hide()
			frame.Cooldown:Hide()
			
			Framelist[frame] = nil
		else

			Framelist[frame] = expiration

			frame:Show()
			
			CheckFramelist()
			
			if not WatcherframeActive then 
				Watcherframe:SetScript("OnUpdate", CheckFramelist)
				WatcherframeActive = true
			end
		end
	end
	
	core.PolledHideIn = PolledHideIn
end

function core:GetSpellDuration(spellID, spellName, isPlayer)
	if spellID then
	
		local args = C.db.profile.spells[spellName]
		if args then
			if args.checkid then
				if args[2] == spellID then				
					if isPlayer then
						if args.pvpduration then return args.pvpduration end
					else
						if args.duration then return args.duration end
					end
				end
			else
				if isPlayer then
					if args.pvpduration then return args.pvpduration end
				else
					if args.duration then return args.duration end
				end
			end
		end
		return durationcache[spellID] 		
	end -- or core.CachedAuraDurations[spellID] end
end

function core:SetSpellDuration(spellID, duration, expirationTime)
	if spellID then 
	--	core.CachedAuraDurations[spellID] = duration 
		
		if expirationTime == 0 and duration == 0 then
			durationcache[spellID] = "instant"
		else
			durationcache[spellID] = duration
		end
	end
end

core.CachedAuraTypes = {}

function core:GetSpellType(spellID)
	if spellID then return core.CachedAuraTypes[spellID] end
end

function core:SetSpellType(spellID, tip)
	if spellID then core.CachedAuraTypes[spellID] = tip end
end

core.CacheSpellIDPurge = {}
function core:GetSpellPurge(spellID)
	if spellID then return core.CacheSpellIDPurge[spellID] end
end
function core:SetSpellPurge(spellID, status)
	if spellID and status then core.CacheSpellIDPurge[spellID] = status end
end


local types_to_color = {
	["BUFF"] = "color6",
	["DEBUFF"] = "color1",
	["Poison"] = "color5",
	["Magic"] = "color2",
	["Disease"] = "color4",
	["Curse"] = "color3",
	["purgeble"] = "purgeble",
}

local function UpdateBorderColor(self, types)
	if types == "black" or types == nil then
		self:SetBorderColor(bordercolor[1],bordercolor[2],bordercolor[3],1)
	else
		local c = C.db.profile[types_to_color[types] or "color1"]
		self:SetBorderColor(c[1],c[2],c[3],1)
	end
end

local function SetBorderColor(self, r, g, b,a)	
	
	if C.db.profile.border_style == 1 then -- Flat Border
		self.bordertop:SetTexture(r, g, b,a)
		self.borderbottom:SetTexture(r, g, b,a)
		self.borderleft:SetTexture(r, g, b,a)
		self.borderright:SetTexture(r, g, b,a)
		self.blizzBorder:SetVertexColor(r,g,b,0)
	elseif C.db.profile.border_style == 2 then -- Blizzard
		self.bordertop:SetTexture(r, g, b,0)
		self.borderbottom:SetTexture(r, g, b,0)
		self.borderleft:SetTexture(r, g, b,0)
		self.borderright:SetTexture(r, g, b,0)
		self.blizzBorder:SetVertexColor(r,g,b,1)		
	end
end

local function CreateBackdrop(parent, point)
	point = point or parent
	local noscalemult = mult * UIParent:GetScale()
	
	if point.bordertop then return end

	point.backdrop = parent:CreateTexture(nil, "BORDER")
	point.backdrop:SetDrawLayer("BORDER", -4)
	point.backdrop:SetAllPoints(point)
	point.backdrop:SetTexture(bordercolor[1],bordercolor[2],bordercolor[3], 0.6)		

	point.bordertop = parent:CreateTexture(nil, "BORDER")
	point.bordertop:SetPoint("TOPLEFT", point, "TOPLEFT", -noscalemult, noscalemult)
	point.bordertop:SetPoint("TOPRIGHT", point, "TOPRIGHT", noscalemult, noscalemult)
	point.bordertop:SetHeight(noscalemult)
	point.bordertop:SetTexture(unpack(bordercolor))	
	point.bordertop:SetDrawLayer("BORDER", 1)
		
	point.borderbottom = parent:CreateTexture(nil, "BORDER")
	point.borderbottom:SetPoint("BOTTOMLEFT", point, "BOTTOMLEFT", -noscalemult, -noscalemult)
	point.borderbottom:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", noscalemult, -noscalemult)
	point.borderbottom:SetHeight(noscalemult)
	point.borderbottom:SetTexture(unpack(bordercolor))	
	point.borderbottom:SetDrawLayer("BORDER", 1)
		
	point.borderleft = parent:CreateTexture(nil, "BORDER")
	point.borderleft:SetPoint("TOPLEFT", point, "TOPLEFT", -noscalemult, noscalemult)
	point.borderleft:SetPoint("BOTTOMLEFT", point, "BOTTOMLEFT", noscalemult, -noscalemult)
	point.borderleft:SetWidth(noscalemult)
	point.borderleft:SetTexture(unpack(bordercolor))	
	point.borderleft:SetDrawLayer("BORDER", 1)
		
	point.borderright = parent:CreateTexture(nil, "BORDER")
	point.borderright:SetPoint("TOPRIGHT", point, "TOPRIGHT", noscalemult, noscalemult)
	point.borderright:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", -noscalemult, -noscalemult)
	point.borderright:SetWidth(noscalemult)
	point.borderright:SetTexture(unpack(bordercolor))
	point.borderright:SetDrawLayer("BORDER", 1)
	
	
	point.blizzBorder = parent:CreateTexture(nil, "BORDER")
	point.blizzBorder:SetPoint("TOPLEFT", point, "TOPLEFT", -noscalemult, noscalemult)
	point.blizzBorder:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", noscalemult, -noscalemult)
	point.blizzBorder:SetWidth(1)
	point.blizzBorder:SetTexture("Interface\\Buttons\\UI-Debuff-Overlays")
	point.blizzBorder:SetDrawLayer("BORDER", 1)
	point.blizzBorder:SetTexCoord(0.296875,0.5703125,0,0.515625)

	point.SetBorderColor = SetBorderColor
end

--[[

	core.CreatedPlates = {};
	core.MyPlateToBlizzard = {}
	]]
local function FindMyPlate(self)
	local i=1
	local parent = self
	while i < 3 do	
		parent = parent:GetParent()
		i = i + 1
		if core.MyPlateToBlizzard[parent] then
			print("T", i, "find myFrame", core.MyPlateToBlizzard[parent]:GetName())
			return core.MyPlateToBlizzard[parent];
		end
	end
	
	return false
end

local function CompareParentFrames(self, parent2, comment)
	local i=1
	local parent = self
	while i < 3 do	
		parent = parent:GetParent()
		i = i + 1
		if core.MyPlateToBlizzard[parent] then
			break;
		end
	end
	
	if core.MyPlateToBlizzard[parent] then
		print("CompareParentFrames", comment, parent == parent2)
	end
end

function core:CreateAuraIcon(frame, parent, dbTable)
	local noscalemult = mult * UIParent:GetScale()
	local button = CreateFrame("Frame",nil,frame)
	--[[
	button.bord = button:CreateTexture(nil, "BACKGROUND")
	button.bord:SetDrawLayer('BACKGROUND', 2)
	button.bord:SetTexture(unpack(bordercolor))
	button.bord:SetPoint("TOPLEFT",button,"TOPLEFT", noscalemult,-noscalemult)
	button.bord:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",-noscalemult,noscalemult)
	]]
	
	button.FindMyPlate = FindMyPlate
	button.CompareParentFrames = CompareParentFrames
	
	CreateBackdrop(button)
	
	button.UpdateBorderColor = UpdateBorderColor
	
	
	button.Icon = button:CreateTexture(nil, "BORDER")
	button.Icon:SetPoint("TOPLEFT",button,"TOPLEFT", noscalemult,-noscalemult)
	button.Icon:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",-noscalemult,noscalemult)

	if C.db.profile[dbTable].stretchTexture then
		button.Icon:SetTexCoord(.07, 0.93, .23, 0.77)
	else
		button.Icon:SetTexCoord(.07, .93, .07, .93)
	end			
	
	button.Cooldown = CreateFrame("Cooldown", nil, _myParent, "CooldownFrameTemplate")
	button.Cooldown:SetFrameLevel(button:GetFrameLevel())
	button.Cooldown:SetAllPoints(button)	
	button.Cooldown:SetReverse(true)
	button.Cooldown:SetEdgeTexture("Interface\\Cooldown\\edge")
	button.Cooldown:SetDrawEdge(false)
	
	if C.db.profile.cooldownoverlay_texture then
		button.Cooldown:SetSwipeColor(0, 0, 0, 0)
	else
		button.Cooldown:SetSwipeColor(0, 0, 0, 0.6)
	end
	
	button.Cooldown:SetBlingTexture("")	
	parent._cooldowns[#parent._cooldowns+1] = button.Cooldown
	
	button._par = CreateFrame("Frame", nil, button)
	button._par:SetFrameLevel(button:GetFrameLevel()+1)
	button._par:SetAllPoints()
	button._par:SetFrameLevel(button.Cooldown:GetFrameLevel()+2)
	
	button.TimeLeft = button._par:CreateFontString(nil, 'ARTWORK', "GameFontWhite")
	button.TimeLeft:SetFont(LSM:Fetch("font",C.db.profile.font_icon), C.db.profile.font_size_icon, C.db.profile.font_flag_icon)
	button.TimeLeft:SetPoint(C.db.profile.time_font_point, button, C.db.profile.time_font_point, C.db.profile.time_font_xpos, C.db.profile.time_font_ypos)
	button.TimeLeft:SetJustifyH(C.db.profile.time_font_justify)
	
	button.TimeLeft.bg = button._par:CreateTexture(nil, 'ARTWORK')
	button.TimeLeft.bg:SetPoint("TOPLEFT", button.TimeLeft, "TOPLEFT")
	button.TimeLeft.bg:SetPoint("BOTTOMRIGHT", button.TimeLeft, "BOTTOMRIGHT")

	button.Stacks = button._par:CreateFontString(nil,"ARTWORK", "GameFontWhite")
	button.Stacks:SetFont(LSM:Fetch("font",C.db.profile.font_icon), C.db.profile.font_size_icon, C.db.profile.font_flag_icon)
	button.Stacks:SetPoint(C.db.profile.stack_font_point, button, C.db.profile.stack_font_point, C.db.profile.stack_font_xpos, C.db.profile.stack_font_ypos)
	button.Stacks:SetJustifyH(C.db.profile.stack_font_justify)
	
	button.Stacks.bg = button._par:CreateTexture(nil, 'ARTWORK')
	button.Stacks.bg:SetPoint("TOPLEFT", button.Stacks, "TOPLEFT")
	button.Stacks.bg:SetPoint("BOTTOMRIGHT", button.Stacks, "BOTTOMRIGHT")

	if C.db.profile.show_text_background then
		button.TimeLeft.bg:SetTexture(0, 0, 0, 1)
		button.Stacks.bg:SetTexture(0, 0, 0, 1)
	else
		button.TimeLeft.bg:SetTexture(0, 0, 0, 0)
		button.Stacks.bg:SetTexture(0, 0, 0, 0)
	end
			
	button._parent = parent --button:FindMyPlate()
	
--	button:CompareParentFrames(frame, "1")
--	button:CompareParentFrames(parent, "2")
	
	button.Poll = frame.PollFunction

	if testing then
		button.Hide = button.Show
		button:Show()
	else
		button:Hide() 
	end
	
	
	return button
end

do
	
	local hour, minute = 3600, 60
	local format = string.format
    local ceil = math.ceil
	local floor = math.floor
	local fmod = math.fmod
	
	function core:formatTimeRemaining(msecs)
		if msecs < 0 then msecs = 0 end
		
		if msecs >= hour then
			return "%dh", ceil(msecs / hour)
		elseif msecs >= minute then
			return "%dm", ceil(msecs / minute)
		else
			return "%.0fs", floor(msecs)
		end
    end
	
	local formatting_funcs = {
		[1] = function(msecs) -- 0s 1s 3s 1m 1h
			if msecs < 0 then msecs = 0 end		
			if msecs >= hour then
				return "%dh", ceil(msecs / hour)
			elseif msecs >= minute then
				return "%dm", ceil(msecs / minute)
			else
				return "%.0fs", floor(msecs)
			end		
		end,
		[2] = function(msecs) -- 0 1 3 1m 1h
			if msecs < 0 then msecs = 0 end		
			if msecs >= hour then
				return "%dh", ceil(msecs / hour)
			elseif msecs >= minute then
				return "%dm", ceil(msecs / minute)
			else
				return "%.0f", floor(msecs)
			end		
		end,
		[3] = function(msecs) -- 0.1 1.1 3.1 1m 1h
			if msecs < 0 then msecs = 0 end		
			if msecs >= hour then
				return "%dh", ceil(msecs / hour)
			elseif msecs >= minute then
				return "%dm", ceil(msecs / minute)
			else
				return "%.1f", msecs
			end		
		end,
		[4] = function(msecs)
			if msecs < 0 then msecs = 0 end	
			if msecs >= hour then
				return "%dh", ceil(msecs / hour)
			elseif msecs >= minute then
				return "%dm", ceil(msecs / minute)
			elseif msecs >= 10 then
				return "%.0f", msecs
			else
				return "%.1f", msecs
			end			
		end,
	}
	
	function core:UpdateAuraTime(frame, expiration, duration)
		if not C.db.profile.showdurationtext then
			frame.TimeLeft:SetText("")
			return
		end
	
		if expiration == 0 and duration == 0 then
			frame.TimeLeft:SetText("")
			return
		end
		
		local timeleft = expiration-GetTime()
		
		local color = C.db.profile.time_color3
		
		if timeleft < 3 then
			color = C.db.profile.time_color1
		elseif timeleft < 60 then
			color = C.db.profile.time_color2
		end
		
		frame.TimeLeft:SetFormattedText(formatting_funcs[C.db.profile.time_text_format or 1](timeleft))
		frame.TimeLeft:SetTextColor(color[1], color[2], color[3])
	end

end

function core:ClearAuraContext(frame)
	AuraList[frame] = nil
end

function core:RemoveAuraInstance(guid, spellID, caster)
	if guid and spellID and core.AuraList[guid] then
		local auraID = spellID..(tostring(caster or "UNKNOWN_CASTER"))
		local instanceID = tostring(guid)..auraID
		if core.AuraList[guid][auraID] then
			core.AuraSpellID[instanceID] = nil
			core.AuraExpiration[instanceID] = nil
			core.AuraStacks[instanceID] = nil
			core.AuraCaster[instanceID] = nil
			core.AuraDuration[instanceID] = nil
			core.AuraTexture[instanceID] = nil
			core.AuraType[instanceID] = nil
			core.AuraTarget[instanceID] = nil
			core.AuraSpellName[instanceID] = nil
			core.AuraPurgeReady[instanceID] = nil			
			core.AuraList[guid][auraID] = nil
			
			return true
		end
	end
	
	return false
end

function core:RemoveAuraInstanceByDest(guid, spellID)
	if guid and spellID and core.AuraList[guid] then
		local unitAuraList = self.AuraList[guid]
		for auraID, instanceID in pairs(unitAuraList) do	
			if spellID == self.AuraSpellID[instanceID] then
				self.AuraSpellID[instanceID] = nil
				self.AuraSpellID[instanceID] = nil
				self.AuraExpiration[instanceID] = nil
				self.AuraStacks[instanceID] = nil
				self.AuraCaster[instanceID] = nil
				self.AuraDuration[instanceID] = nil
				self.AuraTexture[instanceID] = nil
				self.AuraType[instanceID] = nil
				self.AuraTarget[instanceID] = nil
				self.AuraSpellName[instanceID] = nil
				self.AuraPurgeReady[instanceID] = nil
				
				unitAuraList[auraID] = nil
			
				return true
			end
		end
	end
	
	return false
end

function core:GetAuraList(guid)
	if guid and self.AuraList[guid] then return self.AuraList[guid] end
end

function core:GetAuraInstance(guid, auraID)
	if guid and auraID then
		local instanceID = guid..auraID
		return self.AuraSpellID[instanceID], 
			self.AuraExpiration[instanceID], 
			self.AuraStacks[instanceID], 
			self.AuraCaster[instanceID], 
			self.AuraDuration[instanceID], 
			self.AuraTexture[instanceID], 
			self.AuraType[instanceID], 
			self.AuraTarget[instanceID], 
			self.AuraSpellName[instanceID],
			self.AuraPurgeReady[instanceID]
	end
end

local function CheckFilter(filterlist, curval, spellName, spellID, auraTarget, caster, auraType)
	local arg = C.db.profile[filterlist][spellName]
	local filter = curval
	
	if arg then
		if not arg.deleted then
			if ( arg.auratype == 1 or arg.auratype == nil ) or ( arg.auratype == 2 and auraType == AURA_TYPE_BUFF ) or ( arg.auratype == 3 and auraType == AURA_TYPE_DEBUFF ) then
				if arg.checkid then
					if arg[2] == spellID then
						if arg.showing == 1 then
							filter = true;
						elseif arg.showing == 3 and caster == UnitGUID('player') then
							filter = true;
						elseif arg.showing == 4 and auraTarget == AURA_TARGET_HOSTILE then
							filter = true;
						elseif arg.showing == 5 and auraTarget == AURA_TARGET_FRIENDLY then
							filter = true;
						else 
							filter = false;
						end
					else
						filter = false;
					end
				else
					if arg.showing == 1 then
						filter = true;
					elseif arg.showing == 3 and caster == UnitGUID('player') then
						filter = true;
					elseif arg.showing == 4 and auraTarget == AURA_TARGET_HOSTILE then
						filter = true;
					elseif arg.showing == 5 and auraTarget == AURA_TARGET_FRIENDLY then
						filter = true;
					else 
						filter = false;
					end	
				end
			else
				filter = false;
			end
		end
	end
	return filter
end

local function CheckFilterBlacklist(spellName, spellID, auraTarget, caster, auraType)
	local arg = C.db.profile['blacklist'][spellName]
	local filter = false
	
	if arg then
		if not arg.deleted then
			if ( arg.auratype == 1 or arg.auratype == nil ) or ( arg.auratype == 2 and auraType == AURA_TYPE_BUFF ) or ( arg.auratype == 3 and auraType == AURA_TYPE_DEBUFF ) then
				if arg.checkid then
					if arg[2] == spellID then
						if arg.showing == 1 then
							filter = true;
						elseif arg.showing == 3 and caster == UnitGUID('player') then
							filter = true;
						elseif arg.showing == 4 and auraTarget == AURA_TARGET_HOSTILE then
							filter = true;
						elseif arg.showing == 5 and auraTarget == AURA_TARGET_FRIENDLY then
							filter = true;
						else 
							filter = false;
						end
					else
						filter = false;
					end
				else
					if arg.showing == 1 then
						filter = true;
					elseif arg.showing == 3 and caster == UnitGUID('player') then
						filter = true;
					elseif arg.showing == 4 and auraTarget == AURA_TARGET_HOSTILE then
						filter = true;
					elseif arg.showing == 5 and auraTarget == AURA_TARGET_FRIENDLY then
						filter = true;
					else 
						filter = false;
					end	
				end
			else
				filter = false;
			end
		end
	end
	return filter
end

function core:SetAuraInstance(guid, spellName, spellID, expiration, stacks, caster, duration, texture, auraType, auraTarget, isStealable)
	local filter = false
			
	if (C.db.profile.showmyspell and caster == UnitGUID('player')) then
		filter = true;
	end	
	if (C.db.profile.showpurgeblespells and auraTarget == AURA_TARGET_HOSTILE and isStealable and auraType == AURA_TYPE_BUFF ) then
		filter = true
	end
	if C.db.profile.showspellformlist then
		filter = CheckFilter('spells', filter, spellName, spellID, auraTarget, caster, auraType)
	end	
	if C.db.profile.showspellformcustom then
		filter = CheckFilter('custom_spelllist', filter, spellName, spellID, auraTarget, caster, auraType)
	end
	if C.db.profile.showspellformblacklist and filter then
		filter = not CheckFilterBlacklist(spellName, spellID, auraTarget, caster, auraType)
	end
	if filter ~= true then
		return false;
	end

	if guid and spellID and caster and texture then
		local auraID = spellID..(tostring(caster or "UNKNOWN_CASTER"))
		local instanceID = guid..auraID
		core.AuraList[guid] = core.AuraList[guid] or {}
		core.AuraList[guid][auraID] = instanceID
		core.AuraSpellID[instanceID] = spellID
		core.AuraExpiration[instanceID] = expiration
		core.AuraStacks[instanceID] = stacks
		core.AuraCaster[instanceID] = caster
		core.AuraDuration[instanceID] = duration
		core.AuraTexture[instanceID] = texture
		core.AuraType[instanceID] = auraType
		core.AuraTarget[instanceID] = auraTarget
		core.AuraSpellName[instanceID] = spellName
		core.AuraPurgeReady[instanceID] = isStealable
		
		return true
	end
	
	return false
end
do
	local throttle = {}
	local unit_list = {
		["target"] = true,
		["focus"] = true,
	--	["boss1"] = true,
	--	["boss2"] = true,
	--	["boss3"] = true,
	--	["boss4"] = true,
	--	["boss5"] = true,
		["arena1"] = true,
		["arena2"] = true,
		["arena3"] = true,
		["arena4"] = true,
		["arena5"] = true,
	
	}
	
	local function Do_Update(unit)
		
		if unit then			

			if unit == "target" then return true end			
			if UnitExists("target") and UnitIsUnit("target", unit) then return false end			
			if UnitExists("focus") and UnitIsUnit("focus", unit) then return false end
			
			return true
		end
		
		return false
	end

	function core:UNIT_AURA(event, unit)
		
		if unit == "player" then		
			ordos_exists = UnitAura("player", GetSpellInfo(148385))	
		end
		
		if unit and unit_list[unit] then
			
		--	if not throttle[unit] then throttle[unit] = 0 end			
		--	if GetTime() - throttle[unit] < 0 then return end

		--	throttle[unit] = GetTime() + 0.1
			
			self:UpdateAurasByUnitID(unit)
		end
	end
	
	--self:UpdateAurasByUnitID(unit)
end

local COMBATLOG_OBJECT_REACTION_HOSTILE = COMBATLOG_OBJECT_REACTION_HOSTILE
local COMBATLOG_OBJECT_REACTION_NEUTRAL = COMBATLOG_OBJECT_REACTION_NEUTRAL
local COMBATLOG_OBJECT_REACTION_FRIENDLY = COMBATLOG_OBJECT_REACTION_FRIENDLY
local COMBATLOG_OBJECT_TYPE_PLAYER = COMBATLOG_OBJECT_TYPE_PLAYER
local COMBATLOG_OBJECT_CONTROL_PLAYER = COMBATLOG_OBJECT_CONTROL_PLAYER

local function IsHostle(destFlags)
	return ( band(destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0 ) or ( band(destFlags, COMBATLOG_OBJECT_REACTION_NEUTRAL) > 0 ) 
end

local function IsFriendly(destFlags)
	return ( band(destFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) > 0 )
end

local function GetCLEUTargetType(destFlags)
	return IsFriendly(destFlags) and AURA_TARGET_FRIENDLY or AURA_TARGET_HOSTILE
end

function core:COMBAT_LOG_EVENT_UNFILTERED(_, _, event, ...)
	local _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, _, auraType, stackCount  = ...

	if  event == "SPELL_AURA_APPLIED" or 
		event == "SPELL_AURA_REFRESH" or 
		event == "SPELL_AURA_APPLIED_DOSE" or 
		event == "SPELL_AURA_REMOVED_DOSE" or 
		event == "SPELL_AURA_BROKEN" or 
		event == "SPELL_AURA_BROKEN_SPELL" or 
		event == "SPELL_AURA_REMOVED" --or
	--	event == "SPELL_STOLEN" or 
	--	event == "SPELL_DISPEL" 
		then	
		
		local do_update = false
		
		local isPlayer = ( band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) == COMBATLOG_OBJECT_TYPE_PLAYER ) or false
		
		if event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_REFRESH" then
			local duration = core:GetSpellDuration(spellID, spellName, isPlayer)
			local texture = GetSpellTexture(spellID)
			local isStealable = core:GetSpellPurge(spellID)
			local endTime
			
			if duration == "instant" then
				endTime = 0
				duration = 0
			else
				if event == 'SPELL_AURA_APPLIED' then
					DRs:GUIDGainedDRAura(destGUID, spellID, isPlayer)
				else
					DRs:GUIDRemovedDRAura(destGUID, spellID, isPlayer)
					DRs:GUIDGainedDRAura(destGUID, spellID, isPlayer)
				end
				
				duration = DRs:GetDRDuration(destGUID, spellID, duration)
				
				endTime = GetTime() + (duration or 0)
			end
	
			do_update = core:SetAuraInstance(destGUID, spellName, spellID, endTime, 1, sourceGUID, duration, texture, auraType, GetCLEUTargetType(destFlags), isStealable)
			
		elseif event == "SPELL_AURA_APPLIED_DOSE" or event == "SPELL_AURA_REMOVED_DOSE" then
			local duration = core:GetSpellDuration(spellID, spellName, isPlayer)
			local texture = GetSpellTexture(spellID)
			local isStealable = core:GetSpellPurge(spellID)
			local endTime
			
			if duration == "instant" then
				endTime = 0
				duration = 0
			else
				if event == 'SPELL_AURA_APPLIED' then
					DRs:GUIDGainedDRAura(destGUID, spellID, isPlayer)
				else
					DRs:GUIDRemovedDRAura(destGUID, spellID, isPlayer)
					DRs:GUIDGainedDRAura(destGUID, spellID, isPlayer)
				end
				
				duration = DRs:GetDRDuration(destGUID, spellID, duration)
			
				endTime = GetTime() + (duration or 0)
			end
			
			do_update = core:SetAuraInstance(destGUID, spellName,spellID, endTime, stackCount, sourceGUID, duration, texture, auraType, GetCLEUTargetType(destFlags), isStealable)
		elseif event == "SPELL_AURA_REMOVED" then
			do_update = core:RemoveAuraInstance(destGUID, spellID, sourceGUID)
		elseif event == "SPELL_AURA_BROKEN" or event == "SPELL_AURA_BROKEN_SPELL" then
			do_update = core:RemoveAuraInstance(destGUID, spellID, sourceGUID)
		elseif event == "SPELL_STOLEN" then
			local extraSpellID, extraSpellName, extraSchool, auraType = select(13, ...)
			local duration = core:GetSpellDuration(extraSpellID)
			local texture = GetSpellTexture(extraSpellID)
			local isStealable = core:GetSpellPurge(extraSpellID)
			
			if duration == "instant" then
				endTime = 0
				duration = 0
			else
				endTime = GetTime() + (duration or 0)
			end
			
			do_update = core:SetAuraInstance(sourceGUID, extraSpellName,extraSpellID, endTime, 0, sourceGUID, duration, texture, auraType, GetCLEUTargetType(sourceFlags), isStealable)
			do_update = core:RemoveAuraInstanceByDest(destGUID, extraSpellID)
	
		elseif event == "SPELL_DISPEL" then	
			if destGUID ~= sourceGUID then
				local extraSpellID, extraSpellName, extraSchool, auraType = select(13, ...)
				do_update = core:RemoveAuraInstanceByDest(destGUID, extraSpellID)
			end
		elseif event == "UNIT_DIED" or event == "SPELL_INSTAKILL" then		
			do_update = core:WipeAuraList(destGUID)
		end	

		local name, raidIcon
		if destName and isPlayer then 
			local rawName = strsplit("-", destName)			-- Strip server name from players
			core.ByName[rawName] = destGUID
			name = rawName
		end
		
		if flagtort[destRaidFlags] then
			core.ByRaidIcon[flagtort[destRaidFlags]] = destGUID
			raidIcon = flagtort[destRaidFlags]
		end

		if destName and core.ByBossName[destName] then
			name = destName
		end

		if do_update then
			local frame = self:SearchForFrame(destGUID, raidIcon, name)
			if(frame and not frame[_adf].isSmall) then
				core:UpdateAuras(frame, "CLEU")
			end
		end
	end	
end

function core:WipeAuraList(guid)
	local doupdate = false
	if guid and self.AuraList[guid] then
		local unitAuraList = self.AuraList[guid]
		for auraID, instanceID in pairs(unitAuraList) do
			self.AuraSpellID[instanceID] = nil
			self.AuraExpiration[instanceID] = nil
			self.AuraStacks[instanceID] = nil
			self.AuraCaster[instanceID] = nil
			self.AuraDuration[instanceID] = nil
			self.AuraTexture[instanceID] = nil
			self.AuraType[instanceID] = nil
			self.AuraTarget[instanceID] = nil
			self.AuraSpellName[instanceID] = nil
			self.AuraPurgeReady[instanceID] = nil
			
			unitAuraList[auraID] = nil
			
			doupdate = true
		end
		
		return doupdate
	end
	
	return doupdate
end

function core:UpdateAurasByUnitID(unit)

--	print("UpdateAurasByUnitID", unit)
	
	local guid = UnitGUID(unit)
	self:WipeAuraList(guid)


	local index = 1
	local name, _, texture, count, debuffType , duration, expirationTime, unitCaster, isStealable, _, spellID = UnitDebuff(unit, index)
	local isfriend = UnitIsFriend(unit,"player")
	
	while name do
		core:SetSpellDuration(spellID, duration, expirationTime)
		core:SetSpellType(spellID, debuffType)
		core:SetSpellPurge(spellID, isStealable)
		
		core:SetAuraInstance(guid, name, spellID, expirationTime, count, UnitGUID(unitCaster or ""), duration, texture, AURA_TYPE_DEBUFF, (isfriend and AURA_TARGET_FRIENDLY or AURA_TARGET_HOSTILE), isStealable)
		index = index + 1
		name , _, texture, count, debuffType, duration, expirationTime, unitCaster, isStealable, _, spellID = UnitDebuff(unit, index)
	end	

	index = 1
	local name, _, texture, count, debuffType, duration, expirationTime, unitCaster, isStealable, _, spellID = UnitBuff(unit, index);
	while name do
		core:SetSpellDuration(spellID, duration, expirationTime)
		core:SetSpellType(spellID, debuffType)
		core:SetSpellPurge(spellID, isStealable)
		
		core:SetAuraInstance(guid, name, spellID, expirationTime, count, UnitGUID(unitCaster or ""), duration, texture, AURA_TYPE_BUFF, (isfriend and AURA_TARGET_FRIENDLY or AURA_TARGET_HOSTILE), isStealable)
		index = index + 1
		name, _, texture, count, debuffType, duration, expirationTime, unitCaster, isStealable, _, spellID = UnitBuff(unit, index);
	end	
	
	local raidIcon, name
	if UnitPlayerControlled(unit) then 
		name = UnitName(unit) 
	elseif core.ByBossName[UnitName(unit)] then
		name = UnitName(unit)
	end
	raidIcon = RaidIconIndex[GetRaidTargetIndex(unit) or ""]
	if raidIcon then self.ByRaidIcon[raidIcon] = guid end

	local frame = self:SearchForFrame(guid, raidIcon, name)
	
--	print("UpdateAurasByUnitID(", unit, ")", guid, name, frame)
	if frame and not frame[_adf].isSmall then
		core:UpdateAuras(frame, "UA")
	end
end

function core:UpdateIcon(frame, texture, expiration, stacks, guid, spellid, spellname, duration, types, caster, isStealable)
	if frame and texture and expiration and guid and spellid then
		-- Icon
		frame.Icon:SetTexture(texture)
		
		local size = 1
		
		local opts = C.db.profile.spells[spellname]
			
		if opts and not opts.deleted then
			if opts.checkID then
				if opts[2] == spellid then		
					size = opts[1] or 1
				end
			else
				size = opts[1] or 1
			end
		end
		
		frame:SetWidth(frame.width*size)
		frame:SetHeight(frame.height*size)
		
		if C.db.profile.showpurgeblespells and isStealable then
			frame:UpdateBorderColor('purgeble')
		elseif C.db.profile.colorByType then
			frame:UpdateBorderColor(core:GetSpellType(spellid) or types)
		else
			frame:UpdateBorderColor("black")
		end
		
		-- Stacks
		if stacks > 1 then 
			frame.Stacks:SetText(stacks)
		else 
			frame.Stacks:SetText("") 
		end
		
		-- Expiration
		
		frame.guid = guid
		frame.spellid = spellid
		frame.expiration = expiration
		frame.duration = duration
		frame.caster = caster
		frame.unlimited = (expiration == 0 and duration == 0 ) and true or false
		frame:Show()
		
		if duration > 0 and C.db.profile.cooldownoverlay then
			frame.Cooldown:Show()
		else
			frame.Cooldown:Hide()
		end
		
		core.PolledHideIn(frame, expiration, frame.unlimited)
	else 
		if frame then
			frame.guid = nil
			frame.spellid = nil
			frame.caster = nil
			frame.unlimited = nil
			
			frame.Cooldown:Hide()
		end
		core.PolledHideIn(frame, 0)
	end
end

local rowchache = {}

function core:UpdateIconGrid(frame, guid, force, source)
	local myPlate = core.CreatedPlates[frame]
	local guid = guid or frame[_adf].guid or myPlate.guid
	local buffs = myPlate.BuffWidget 
	local debuffs = myPlate.DebuffWidget 
	local both = myPlate.BothHeader 
	local AurasOnUnit = self:GetAuraList(guid)
	local BuffSlotIndex = 1
	local DebuffSlotIndex = 1
	local instanceid
	local buff_i = 1
	local debuff_i = 1
	local both_i = 0
	
	local maxdebuffheight = 3

	if ( C.db.profile.showboth ) then
		if AurasOnUnit or force then
			both:Show()
			wipe(rowchache)
			local curtime = GetTime()
		
			for instanceid in pairs(AurasOnUnit) do
					
				local spellID, expiration, stacks, caster, duration, texture, types, target, spellname, isStealable = self:GetAuraInstance(guid, instanceid)
		
				if tonumber(spellID) then
					if ( ( expiration and expiration > 0 ) and ( duration and duration > 0 ) and expiration > curtime ) or ( expiration == 0 and duration == 0 ) then

						if both_i <= C.db.profile.both.numAuras then
							both_i = both_i + 1
							
							local lrow = ceil(both_i/C.db.profile.both.perrow)
						
						--	print('T2', both_i, ceil(both_i/C.db.profile.both.perrow), ( both_i - ( ( lrow - 1 ) * C.db.profile.both.perrow ) ))
							
							rowchache[lrow] = ( both_i - ( ( lrow - 1 ) * C.db.profile.both.perrow ) )
							
							self:UpdateIcon(both.icons[both_i], texture, expiration, stacks, guid, spellID, spellname, duration, types, caster, isStealable)
			
							if both_i >= C.db.profile.both.numAuras then
								break
							end
						end
					end
				end
			end
		end

		local spacing = C.db.profile.spacing or 3
		
		for i=1, #both.icons do
			both.icons[i]:ClearAllPoints()		
		end
	
		local perrowcur = 1		
		local maxperrow = 0

		
		for i=1, both_i do
			local lrow = ceil(i/C.db.profile.both.perrow)			
		--	local partial_1 = rowchache[lrow]%2  -- если 0 то середина между иконками 1 то середина иконки	

		--	print('T', perrowcur, i, partial_frame, perrowcur%2)
			if rowchache[lrow]%2 == 1 then
				local partial_frame = ceil(rowchache[lrow]*0.5)
				if partial_frame == perrowcur then
					both.icons[i]:SetPoint("BOTTOM", both, "TOP", 0, maxdebuffheight)
				elseif perrowcur < partial_frame then
					both.icons[i]:SetPoint("BOTTOMRIGHT", both.icons[i+1], "BOTTOMLEFT", -spacing, 0)
				elseif perrowcur > partial_frame then
					both.icons[i]:SetPoint("BOTTOMLEFT", both.icons[i-1], "BOTTOMRIGHT", spacing, 0)
				end
			else
				local partial_frame_1 = rowchache[lrow]*0.5
				if perrowcur == partial_frame_1 then
					both.icons[i]:SetPoint("BOTTOMRIGHT", both, "TOP", -spacing*0.5 , maxdebuffheight)
				elseif perrowcur == partial_frame_1+1 then
					both.icons[i]:SetPoint("BOTTOMLEFT", both, "TOP", spacing*0.5 , maxdebuffheight)
				elseif perrowcur < partial_frame_1 then
					both.icons[i]:SetPoint("BOTTOMRIGHT", both.icons[i+1], "BOTTOMLEFT", -spacing, 0)
				elseif perrowcur > partial_frame_1+1 then
					both.icons[i]:SetPoint("BOTTOMLEFT",both.icons[i-1], "BOTTOMRIGHT", spacing, 0)
				end	
			end
			
			perrowcur = perrowcur + 1
			
			if both.icons[i]:GetHeight() > maxperrow then
				maxperrow = both.icons[i]:GetHeight()
			end
				
			if perrowcur > C.db.profile.both.perrow then
				perrowcur = 1
				maxdebuffheight =  maxdebuffheight + maxperrow + spacing
				maxperrow = 0
			end
		end
		
		
		for i=both_i+1, #both.icons,1 do
			if both.icons[i] then
				core.PolledHideIn(both.icons[i], 0)
			end
		end
	else
		if AurasOnUnit or force then
			buffs:Show()
			debuffs:Show()
		
			local curtime = GetTime()

			for instanceid in pairs(AurasOnUnit) do
					
				local spellID, expiration, stacks, caster, duration, texture, types, target, spellname, isStealable = self:GetAuraInstance(guid, instanceid)
		
				if tonumber(spellID) then
					if ( ( expiration and expiration > 0 ) and ( duration and duration > 0 ) and expiration > curtime ) or ( expiration == 0 and duration == 0 ) then

						if(types == "BUFF") then
							if buff_i < C.db.profile.buffs.numAuras then							
								self:UpdateIcon(buffs.icons[buff_i], texture, expiration, stacks, guid, spellID, spellname, duration, types, caster, isStealable) 
								buff_i = buff_i + 1
							end
		
						else
							if debuff_i < C.db.profile.debuffs.numAuras then

								self:UpdateIcon(debuffs.icons[debuff_i], texture, expiration, stacks, guid, spellID, spellname, duration, types, caster, isStealable)
								
								if debuffs.icons[debuff_i]:GetHeight() > maxdebuffheight then
									maxdebuffheight = debuffs.icons[debuff_i]:GetHeight()
								end
								
								debuff_i = debuff_i + 1
							end
						end
					end
				end
			end
		end
		
		-- Clear Extra Slots
		buffs:SetHeight(maxdebuffheight+6)
		
		for i=buff_i, #buffs.icons,1 do
			if buffs.icons[i] then
				core.PolledHideIn(buffs.icons[i], 0)
			end
		end
		for i=debuff_i, #debuffs.icons,1 do
			if debuffs.icons[i] then
				core.PolledHideIn(debuffs.icons[i], 0)
			end
		end
	end
end

function core:GetReaction(frame)

	if ordos_exists then
		local plateName = RawGetPlateName(frame)
		if Kyrilka[plateName] then		
			return Kyrilka[plateName]
		end
	end
	
	local r, g, b = core:RoundColors(frame[_adf].healthBar:GetStatusBarColor())
	
	for class, _ in pairs(RAID_CLASS_COLORS) do
		local bb = b
		if class == 'MONK' then
			bb = bb - 0.01
		end
		
		if RAID_CLASS_COLORS[class].r == r and RAID_CLASS_COLORS[class].g == g and RAID_CLASS_COLORS[class].b == bb then
			return class
		end
	end

	if (r + b + b) == 1.59 then
		return 'TAPPED_NPC'
	elseif g + b == 0 then
		return 'HOSTILE_NPC'
	elseif r + b == 0 then
		return 'FRIENDLY_NPC'
	elseif r + g > 1.95 then
		return 'NEUTRAL_NPC'
	elseif r + g == 0 then
		return 'FRIENDLY_PLAYER'
	else
		return 'HOSTILE_PLAYER'
	end
end

function core:UpdateAuras(frame, source)
	-- Check for ID

	local guid = frame[_adf].guid
	local myPlate = core.CreatedPlates[frame]

	if not guid then
		-- Attempt to ID widget via Name or Raid Icon
		if RAID_CLASS_COLORS[frame[_adf].unitType] then 
			guid = core.ByName[myPlate.nameText]
		elseif frame[_adf].raidIcon:IsShown() then 
			guid = core.ByRaidIcon[frame[_adf].raidIconType] 
		elseif frame[_adf].bossIcon:IsShown() then
			guid = core.ByBossName[myPlate.nameText]
		elseif core.ByName[myPlate.nameText] and frame[_adf].unitType == "FRIENDLY_PLAYER" then
			guid = core.ByName[myPlate.nameText]
		end
		
		if guid then
			frame[_adf].guid = guid
		else
			myPlate.DebuffWidget:Hide()
			myPlate.BuffWidget:Hide()
			myPlate.BothHeader:Hide()
			return
		end
	end

	self:UpdateIconGrid(frame, guid, nil, "core:UpdateAuras")
end

function core:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	local name = nil
	
	for i=1, 5 do
		local unit = format("boss%d", i)
		if UnitExists(unit) and UnitCanAttack("player", unit) then
			local lastName = UnitName(unit)
			
			if name ~= lastName then
				core.ByBossName[lastName] = UnitGUID(unit)
			elseif name == lastName then
				core.ByBossName[lastName] = nil
			end
			
			name = lastName
		end
	end
end

function core:ARENA_OPPONENT_UPDATE()
	for i=1, 5 do
		local unit = format("arena%d", i)
		
		if UnitExists(unit) then --and UnitClassification(unit) == "worldboss" then
			core.ByName[UnitName(unit)] = UnitGUID(unit)
		end
		
	end
end


function core:UpdateAuraByLookup(guid)
 	if guid == UnitGUID("target") then
		core:UpdateAurasByUnitID("target")
	elseif guid == UnitGUID("mouseover") then
		core:UpdateAurasByUnitID("mouseover")
	end
end

function core:CheckRaidIcon(frame)
	if frame[_adf].raidIcon:IsShown() then
		local ux, uy = frame[_adf].raidIcon:GetTexCoord()
		frame[_adf].raidIconType = core.RaidIconCoordinate[ux][uy]	
	else
		frame[_adf].raidIconType = nil;
	end
end

function core:SearchNameplateByGUID(guid)
	for frame, _ in pairs(core.CreatedPlates) do
		if frame and frame:IsShown() and frame[_adf].guid == guid then
			return frame
		end
	end
end


local function SearchNameplateByName2(name)
	for frame, myPlate in pairs(core.CreatedPlates) do
		
		print(name, myPlate.nameText == name, RawGetPlateName(frame) == name)
		
	end
end

function core:SearchNameplateByName(sourceName)
	if not sourceName then return; end

	for frame, myPlate in pairs(core.CreatedPlates) do
		if frame and frame:IsShown() then
			if ( myPlate.nameText == sourceName and RAID_CLASS_COLORS[frame[_adf].unitType] ) then
				return frame
			elseif ( core.ByName[myPlate.nameText] and frame[_adf].unitType == "FRIENDLY_PLAYER" ) then
				return frame
			elseif ( core.ByBossName[sourceName] and myPlate.nameText == sourceName ) then			
				return frame
			end
		end
	end
end

function core:SearchNameplateByIconName(raidIcon)
	for frame, _ in pairs(core.CreatedPlates) do
		core:CheckRaidIcon(frame)
		if frame and frame:IsShown() and frame[_adf].raidIcon:IsShown() and (frame[_adf].raidIconType == raidIcon) then
			return frame
		end
	end		
end

function core:SearchForFrame(guid, raidIcon, name)
	local frame

	if guid then frame = self:SearchNameplateByGUID(guid) end
	if (not frame) and name then frame = self:SearchNameplateByName(name) end
	if (not frame) and raidIcon then frame = self:SearchNameplateByIconName(raidIcon) end
	
	return frame
end

local spellsAndProvidersByCategory = {

	--[[ TAUNT ]]--
	-- Death Knight
	[ 56222] = 'taunt', -- Dark Command
	[ 57603] = 'taunt', -- Death Grip
	-- I have also seen these two spellIDs used for the Death Grip debuff in MoP.
	-- I have not seen the first one here in any of my MoP testing, but it may still be valid.
	[ 49560] = 'taunt', -- Death Grip
	[ 51399] = 'taunt', -- Death Grip
	-- Druid
	[  6795] = 'taunt', -- Growl
	-- Hunter
	[ 20736] = 'taunt', -- Distracting Shot
	-- Monk
	[116189] = 'taunt', -- Provoke
	[115546] = 'taunt',
	[118635] = 'taunt', -- Provoke via the Black Ox Statue -- NEED TESTING
	[118585] = 'taunt', -- Leer of the Ox -- NEED TESTING
	[115543] = 'taunt',
	-- Paladin
	[ 62124] = 'taunt', -- Reckoning
	-- Warlock
	[ 17735] = 'taunt', -- Suffering (Voidwalker)
	-- Warrior
	[   355] = 'taunt', -- Taunt
	-- Shaman
	[ 36213] = 'taunt', -- Angered Earth (Earth Elemental)

	
	-- Druid
	[    99] = 'incapacitate', -- Incapacitating Roar (talent)
	-- Hunter
	[  3355] = 'incapacitate', -- Freezing Trap
	[  1499] = 'incapacitate',
	[ 60192] = 'incapacitate',
	[ 19386] = 'incapacitate', -- Wyvern Sting
	-- Mage
	[   118] = 'incapacitate', -- Polymorph
	[ 28272] = 'incapacitate', -- Polymorph (pig)
	[ 28271] = 'incapacitate', -- Polymorph (turtle)
	[ 61305] = 'incapacitate', -- Polymorph (black cat)
	[ 61025] = 'incapacitate', -- Polymorph (serpent) -- FIXME: gone ?
	[ 61721] = 'incapacitate', -- Polymorph (rabbit)
	[ 61780] = 'incapacitate', -- Polymorph (turkey)
	[ 82691] = 'incapacitate', -- Ring of Frost
	[ 31661] = 'incapacitate', -- Dragon's Breath
	-- Monk
	[115078] = 'incapacitate', -- Paralysis
	[123393] = 'incapacitate', -- Breath of Fire (Glyphed)
	[137460] = 'incapacitate', -- Ring of Peace -- FIXME: correct spellIDs?
	[116844] = 'incapacitate',
	-- Paladin
	[ 20066] = 'incapacitate', -- Repentance
	-- Priest
	[   605] = 'incapacitate', -- Dominate Mind
	[  9484] = 'incapacitate', -- Shackle Undead
	[ 64044] = 'incapacitate', -- Psychic Horror (Horror effect)
	[ 88625] = 'incapacitate', -- Holy Word: Chastise
	-- Rogue
	[  1776] = 'incapacitate', -- Gouge
	[  6770] = 'incapacitate', -- Sap
	-- Shaman
	[ 51514] = 'incapacitate', -- Hex
	-- Warlock
	[   710] = 'incapacitate', -- Banish
	[137143] = 'incapacitate', -- Blood Horror
	[111397] = 'incapacitate',
	[  6789] = 'incapacitate', -- Mortal Coil
	-- Pandaren
	[107079] = 'incapacitate', -- Quaking Palm

--[[ SILENCES ]]--
	-- Death Knight
	[108194] = 'silent', -- Asphyxiate (if target is immune to stun)
	[ 47476] = 'silent', -- Strangulate
	-- Druid
	[114237] = 'silent', -- Glyph of Fae Silence
	-- Mage
	[102051] = 'silent', -- Frostjaw
	-- Paladin
	[ 31935] = 'silent', -- Avenger's Shield
	-- Priest
	[ 15487] = 'silent', -- Silence
	-- Rogue
	[  1330] = 'silent', -- Garrote
	-- Blood Elf
	[ 25046] = 'silent', -- Arcane Torrent (Energy version)
	[ 28730] = 'silent', -- Arcane Torrent (Mana version)
	[ 50613] = 'silent', -- Arcane Torrent (Runic power version)
	[ 69179] = 'silent', -- Arcane Torrent (Rage version)
	[ 80483] = 'silent', -- Arcane Torrent (Focus version)

	--[[ DISORIENTS ]]--
	-- Druid
	[ 33786] = 'disorient', -- Cyclone
	-- Paladin
	[105421] = 'disorient', -- Blinding Light -- FIXME: is this the right category? Its missing from blizzard's list
	[ 10326] = 'disorient', -- Turn Evil
	-- Priest
	[  8122] = 'disorient', -- Psychic Scream
	-- Rogue
	[  2094] = 'disorient', -- Blind
	-- Warlock
	[  5782] = 'disorient', -- Fear -- probably unused
	[118699] = 'disorient', -- Fear -- new debuff ID since MoP
	[130616] = 'disorient', -- Fear (with Glyph of Fear)
	
	
	[  5484] = 'disorient', -- Howl of Terror (talent)
	[115268] = 'disorient', -- Mesmerize (Shivarra)
	[  6358] = 'disorient', -- Seduction (Succubus)
	-- Warrior
	[  5246] = 'disorient', -- Intimidating Shout (main target)

	--[[ STUNS ]]--
	-- Death Knight
	[108194] = 'stun', -- Asphyxiate
	[ 91800] = 'stun', -- Gnaw (Ghoul)
	[ 91797] = 'stun', -- Monstrous Blow (Dark Transformation Ghoul)
	[115001] = 'stun', -- Remorseless Winter
	-- Druid
	[ 22570] = 'stun', -- Maim
	[  5211] = 'stun', -- Mighty Bash
	[163505] = 'stun', -- Rake (Stun from Prowl)

	-- Hunter
	[117526] = 'stun', -- Binding Shot
	[109248] = 'stun',
	
	[ 24394] = 'stun', -- Intimidation
	[ 19577] = 'stun',
	-- Mage
	[ 44572] = 'stun', -- Deep Freeze
	-- Monk
	[119392] =  'stun', -- Charging Ox Wave
	[120086] =  'stun', -- Fists of Fury
	[113656] =  'stun',
	[119381] =  'stun', -- Leg Sweep
	-- Paladin
	[   853] = 'stun', -- Hammer of Justice
	[119072] = 'stun', -- Holy Wrath
	[105593] = 'stun', -- Fist of Justice
	-- Rogue
	[  1833] = 'stun', -- Cheap Shot
	[   408] = 'stun', -- Kidney Shot
	-- Shaman
	[118345] = 'stun', -- Pulverize (Primal Earth Elemental)
	[118905] = 'stun', -- Static Charge (Capacitor Totem)
	-- Warlock
	[ 89766] = 'stun', -- Axe Toss (Felguard)
	[ 30283] = 'stun', -- Shadowfury
	[ 22703] = 'stun', -- Summon Infernal
	[  1122] = 'stun',
	-- Warrior
	[132168] = 'stun', -- Shockwave
	[132169] = 'stun', -- Storm Bolt
	-- Tauren
	[ 20549] = 'stun', -- War Stomp

	--[[ ROOTS ]]--
	-- Death Knight
	[ 96294] = "root", -- Chains of Ice (Chilblains Root)
	-- Druid
	[   339] = "root", -- Entangling Roots
	[102359] = "root", -- Mass Entanglement (talent)
	[113770] = "root", -- Entangling Roots (Treants)
	-- Hunter
	[ 53148] = "root", -- Charge (Tenacity pet)
	[ 61685] = "root",
	[135373] = "root", -- Entrapment (passive)
	[136634] = "root", -- Narrow Escape (passive talent)
	-- Mage
	[   122] = "root", -- Frost Nova
	[ 33395] = "root", -- Freeze (Water Elemental)
	[111340] = "root", -- Ice Ward
	-- Monk
	[116706] = "root", -- Disable
	[116095] = "root",
	-- Priest
	[ 87194] = "root", -- Glyph of Mind Blast
	[114404] = "root", -- Void Tendrils
	-- Shaman
	[ 63685] = "root", -- Freeze (Frozen Power talent)
	[ 64695] = "root", -- Earthgrab Totem
	

	--[[ KNOCKBACK ]]--
	-- Death Knight
	[108199] = "knockback", -- Gorefiend's Grasp
	-- Druid
	[102793] = "knockback", -- Ursol's Vortex
	[132469] = "knockback", -- Typhoon
	-- Hunter
	[119403] = "knockback", -- Glyph of Explosive Trap
	-- Shaman
	[ 51490] = "knockback", -- Thunderstorm
	-- Warlock
	[  6360] = "knockback", -- Whiplash
	[115770] = "knockback", -- Fellash
}

DRs.GUIDDrEffects_reset = {}
DRs.GUIDDrEffects_diminished = {}
DRs.resetTimes = {
	default   = 18,
	knockback = 10,
}

DRs.pveDR = {
	["stun"] = true,
	["taunt"] = true,
	["cyclone"] = true,
}

do
	local drType, key, reset
	local GetTime = GetTime
	function DRs:GUIDGainedDRAura(dstGUID, spellID, dstIsPlayer)
		drType = spellsAndProvidersByCategory[spellID]
		if drType and ( dstIsPlayer or self.pveDR[drType] ) then
			key = dstGUID..drType
			reset = self.GUIDDrEffects_reset[key]
			if reset and reset <= GetTime() then
				self.GUIDDrEffects_diminished[key] = 1
			end
		end
	end
end
	
local function NextDR(diminished)
	if( diminished == 1 ) then
		return 0.50
	elseif( diminished == 0.50 ) then
		return 0.25
	end
	
	return 0
end

do
	local key
	local GetTime = GetTime
	local drType
	function DRs:GUIDRemovedDRAura(dstGUID, spellID, dstIsPlayer)
		drType = spellsAndProvidersByCategory[spellID]
		if drType and ( dstIsPlayer or self.pveDR[drType] ) then
			key = dstGUID..drType
			self.GUIDDrEffects_reset[key] = GetTime() +  ( DRs.resetTimes[drType] or DRs.resetTimes.default )

			self.GUIDDrEffects_diminished[key] = NextDR( self.GUIDDrEffects_diminished[key] or 1.0 )
		end
	end
end
	
do
	local GetTime = GetTime
	local duration, drType, key, reset
	function DRs:GetDRDuration(dstGUID, spellID, duration)
		drType = spellsAndProvidersByCategory[spellID]
		if drType then
			key = dstGUID..drType
			reset = self.GUIDDrEffects_reset[key]
			if reset and GetTime() < reset then
				return duration * (self.GUIDDrEffects_diminished[key] or 1)
			end
		end
		
		return duration
	end
end