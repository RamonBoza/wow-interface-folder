--[[
Libraries
--]]
local StopWatch = LibStub:GetLibrary("BigLibTimer6"):Register(StopWatch)

--[[
Variables
--]]
local UnsavedVar = {}
local SavedVar
if type(SavedVar) ~= "table" then
	SavedVar = {}
	SavedVar["enableAddon"] = true
end

--[[
Functions
--]]
local function GetNormalCVars()
	UnsavedVar["Sound_EnableAllSound"] = GetCVar("Sound_EnableAllSound")
	UnsavedVar["Sound_MasterVolume"] = GetCVar("Sound_MasterVolume")
	UnsavedVar["Sound_EnableSoundWhenGameIsInBG"] = GetCVar("Sound_EnableSoundWhenGameIsInBG")
	UnsavedVar["Sound_EnableSFX"] = GetCVar("Sound_EnableSFX")
	UnsavedVar["Sound_EnableMusic"] = GetCVar("Sound_EnableMusic")
	UnsavedVar["Sound_EnableAmbience"] = GetCVar("Sound_EnableAmbience")
end

local function SetNormalCVars()
	StopWatch:ClearAllTimers()
	UnsavedVar["warned"] = false
	SetCVar("Sound_EnableAllSound",UnsavedVar["Sound_EnableAllSound"])
	SetCVar("Sound_MasterVolume",UnsavedVar["Sound_MasterVolume"])
	SetCVar("Sound_EnableSoundWhenGameIsInBG",UnsavedVar["Sound_EnableSoundWhenGameIsInBG"])
	SetCVar("Sound_EnableSFX",UnsavedVar["Sound_EnableSFX"])
	SetCVar("Sound_EnableMusic",UnsavedVar["Sound_EnableMusic"])
	SetCVar("Sound_EnableAmbience",UnsavedVar["Sound_EnableAmbience"])
end

local function SetTempCVars()
	SetCVar("Sound_EnableAllSound","1")
	SetCVar("Sound_MasterVolume","1")
	SetCVar("Sound_EnableSoundWhenGameIsInBG","1")
	SetCVar("Sound_EnableSFX","0")
	SetCVar("Sound_EnableMusic","0")
	SetCVar("Sound_EnableAmbience","0")
end

local function AudioWarn(fileName)
	if (fileName == 15) then
		GetNormalCVars()
		SetTempCVars()
	end
	if (fileName == "RBG") then
		SetTempCVars()
		StopWatch:SetTimer("5 second loop", 5, nil, AudioWarn, "RBG")
		PlaySoundFile("Interface\\AddOns\\ArenaReminder\\Sounds\\queue.mp3", "Master");
	end
	PlaySoundFile("Interface\\AddOns\\ArenaReminder\\Sounds\\"..fileName..".mp3", "Master");
end

--[[
Frame Creation & Event Registration
--]]
local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
EventFrame:RegisterEvent("PLAYER_ALIVE")
EventFrame:RegisterEvent("CVAR_UPDATE")

--[[
Startup
--]]
GetNormalCVars()
UnsavedVar["warned"] = false

--[[
Event Handler
--]]
EventFrame:SetScript("OnEvent", function(self,event,...) 
	 if (event == "UPDATE_BATTLEFIELD_STATUS") then
	 
			local status, mapName = GetBattlefieldStatus(1)
			if (status == "confirm" and string.find(string.lower(mapName),"arena")) then
				AudioWarn("queue")
				UnsavedVar["warned"] = true
				StopWatch:SetTimer("15 second warning", 15-.5, nil, AudioWarn, 15) -- remove partial time to sync
				StopWatch:SetTimer("10 second warning", 20-.5, nil, AudioWarn, 10)
				StopWatch:SetTimer("5 second warning", 25-.5, nil, AudioWarn, 5)
				StopWatch:SetTimer("4 second warning", 26-.5, nil, AudioWarn, 4)
				StopWatch:SetTimer("3 second warning", 27-.5, nil, AudioWarn, 3)
				StopWatch:SetTimer("2 second warning", 28-.5, nil, AudioWarn, 2)
				StopWatch:SetTimer("1 second warning", 29-.5, nil, AudioWarn, 1)
				StopWatch:SetTimer("Missed queue", 30, nil, AudioWarn, "missed")
			end
			
			if (status == "confirm" and string.find(string.lower(mapName),"rated battleground")) then
				AudioWarn("RBG")
			end
			
			if (status ~= "confirm") then
				if (UnsavedVar["warned"]) then -- consider adding a 25s time check here
					--AudioWarn("missed")
				end
				SetNormalCVars()
			end
			
			if (UnsavedVar["wasInArena"] and not IsActiveBattlefieldArena()) then
				--if (UnitIsGroupLeader("player")) then
					UnsavedVar["openPVPFrame"] = true
				--end
			end
			UnsavedVar["wasInArena"] = IsActiveBattlefieldArena()
		
	 end
	 
	 if (event == "PLAYER_ENTERING_WORLD") then
		SetNormalCVars()
		if GetCVar("showAllEnemyDebuffs") == "1" then -- fix for show debuffs not working
			SetCVar("showAllEnemyDebuffs", "0")
			SetCVar("showAllEnemyDebuffs", "1")
		end
	 end
	 
	 if (event == "PLAYER_ALIVE") then 
		if (UnsavedVar["openPVPFrame"]) then
			TogglePVPUI()
			UnsavedVar["openPVPFrame"] = false
		end
	 end
	 
	 if (event == "CVAR_UPDATE") then -- user manually changed vars
		GetNormalCVars()
	 end
	 
end)