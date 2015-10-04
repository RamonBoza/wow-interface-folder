-- Author      : Nogarder
-- Create Date : 2012/3/16 18:36:24
local pairs=pairs
local next=next
local UnitGUID=UnitGUID
local CopyTable=CopyTable
local NPA_GetTime=NPA.GetTime
-- main --using local for speed
NPA.DataCollector={}
--
local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
--data set
local NPA_DataCollector_UnitData={}
--unit-guid
local NPA_DataCollector_CollectableGUIDToUnit={}
local NPA_DataCollector_CollectableUnitToGUID={}
--module set
local NPA_DataCollector_ModuleFuc={}
local NPA_DataCollector_DataTransFerFuc={}
local NPA_DataCollector_DataClearUpFuc={}
--requested data stack -- only collect requested data
local NPA_DataCollector_RequestedModuleList={}
--list for modules using combatlog with unitdata
local NPA_DataCollector_CombatLogModuleList={}
local EnabledModuleList={}
--macro for check guid and create unitdata table
--it prevents GUID being nil by creating UnitData[0] 
local NPA_DataCollector_CheckGUID=function(guid)
	if(guid)then
		if(not NPA_DataCollector_UnitData[guid])then
			NPA_DataCollector_UnitData[guid]={GUID=guid}
		end
		return guid
	else
		--set a guid=0 to prevent nil
		--blizzard did this already by sending guid 0x00000 but would be no harm to do it again
		if(not NPA_DataCollector_UnitData[0])then
			NPA_DataCollector_UnitData[0]={GUID=0}
		end
		return 0
	end
end
------mcaro for Collectable unit update -- one guid can match multiple unit
local NPA_DataCollector_CollectUnit=function(unit)
	--check exists is done at collect with target
	--if((not unit) or (not UnitExists(unit)))then
	--	return
	--end
	--don't have to check if it's same, system should do it
	--clean up old guid to unit
	local oldguid=NPA_DataCollector_CollectableUnitToGUID[unit]
	if(oldguid and NPA_DataCollector_CollectableGUIDToUnit[oldguid])then
		NPA_DataCollector_CollectableGUIDToUnit[oldguid][unit]=nil
	end
	--register new guid to unit
	local guid=UnitGUID(unit)
	if(guid)then --check guid instead unit exists
		if(not NPA_DataCollector_CollectableGUIDToUnit[guid])then
			NPA_DataCollector_CollectableGUIDToUnit[guid]={}
		end
		NPA_DataCollector_CollectableGUIDToUnit[guid][unit]=true
		--check data set if not exists
		NPA_DataCollector_CheckGUID(guid)
		--fire collect event for collector modules
		NPA_EventHandler_FireEvent(2,"DataCollector_CollectUnit",unit,NPA_DataCollector_UnitData[guid])
	end
	--register unit to guid
	NPA_DataCollector_CollectableUnitToGUID[unit]=guid
end
--macro for collect unit and unit-target  --unit-pet only work for temmates so somehow useless
local NPA_DataCollector_CollectWithTarget=function(unit)
	if(unit)then
		NPA_DataCollector_CollectUnit(unit)
		--collect target if aviliable
		NPA_DataCollector_CollectUnit(unit.."target")
	end
end
--get system event then refire them again with unitdata
--a list of system events to use
--these event would come with unitid
local NPA_DataCollector_SystemEventList={
	["UNIT_TARGET"]=true,
	["UNIT_PET"]=true,
	["UNIT_HEALTH"]=true,
	["UNIT_SPELLCAST_CHANNEL_START"]=true,
	["UNIT_SPELLCAST_CHANNEL_STOP"]=true,
	["UNIT_SPELLCAST_DELAYED"]=true,
	["UNIT_SPELLCAST_INTERRUPTED"]=true,
	["UNIT_SPELLCAST_INTERRUPTIBLE"]=true,
	["UNIT_SPELLCAST_NOT_INTERRUPTIBLE"]=true,
	["ARENA_TEAM_UPDATE"]=true,
	["ARENA_OPPONENT_UPDATE"]=true
}
--
--		place holder
local NPA_DataCollector_UnitUpdate=function(unit)
	NPA_DataCollector_CollectWithTarget(unit)
	--fire a event into frametoguid ,it will then be redirected to modules
	NPA_EventHandler_FireEvent(2,"DataCollector_UnitUpdated",unit)
end
--register all event in the list with same format
for name,_ in pairs(NPA_DataCollector_SystemEventList) do
	NPA.EventHandler.RegisterEvent(0,name,"DataCollector_Main",NPA_DataCollector_UnitUpdate)
end
--release list
NPA_DataCollector_SystemEventList=nil
--these events don't come with unitid so add it mannully
--player target change
NPA.EventHandler.RegisterEvent(0,"PLAYER_TARGET_CHANGED","DataCollector_Main",function()
	NPA_DataCollector_UnitUpdate("target")
end)
--focus change
NPA.EventHandler.RegisterEvent(0,"PLAYER_FOCUS_CHANGED","DataCollector_Main",function()
	NPA_DataCollector_UnitUpdate("focus")
end)
--mouseover target change
--this event is fired when mouseover and mouseout but exclude player 
NPA.EventHandler.RegisterEvent(0,"CURSOR_UPDATE","DataCollector_Main",function(unit)
	NPA_DataCollector_UnitUpdate("mouseover")
end)
--this event is fired when mouseover but not mouseout, so it should work with that one above
NPA.EventHandler.RegisterEvent(0,"UPDATE_MOUSEOVER_UNIT","DataCollector_Main",function(unit)
	NPA_DataCollector_UnitUpdate("mouseover")
end)
--special events which would be useful
local NPA_EventHandler_CollectGroup=function()
	--collect player self
	NPA_DataCollector_CollectUnit("player")
	for i=1,5 do
		local unit="party"..i
		NPA_DataCollector_CollectWithTarget(unit)
		local unit=unit.."-pet"
		NPA_DataCollector_CollectWithTarget(unit)
	end
	for i=1,40 do
		local unit="raid"..i
		NPA_DataCollector_CollectWithTarget(unit)
		local unit=unit.."-pet"
		NPA_DataCollector_CollectWithTarget(unit)
	end
	for i=1,5 do
		local unit="arena"..i
		NPA_DataCollector_CollectWithTarget(unit)
		local unit=unit.."-pet"
		NPA_DataCollector_CollectWithTarget(unit)
	end
	NPA_EventHandler_FireEvent(2,"DataCollector_CollectGroup")
end
NPA.EventHandler.RegisterEvent(0,"PLAYER_ENTERING_WORLD","DataCollector_Main",function()
	--instance type
	--1 = instance
	--2 = arena
	--3 = pvp battleground
	--recognize in instance 
	local NPA_DataCollector_InInstance
	local ininstance,area=IsInInstance()
	if(ininstance)then
		if(area=="arena")then
			--check arena
			NPA_DataCollector_InInstance=2
			for i=1,5 do
				local unit="arena"..i
				NPA_DataCollector_CollectWithTarget(unit)
			end
		elseif(area=="pvp")then
			NPA_DataCollector_InInstance=3
		else
			NPA_DataCollector_InInstance=1
		end
	else
		NPA_DataCollector_InInstance=0
	end
	--fire a event
	--get instance name
	--name, type, difficultyIndex, difficultyName, maxPlayers, dynamicDifficulty,isDynamic, mapID = GetInstanceInfo()
	local instancename=GetInstanceInfo()
	NPA_EventHandler_FireEvent(2,"DataCollector_PlayerEnteringWorld",NPA_DataCollector_InInstance,instancename)
end)
--raid and party
NPA.EventHandler.RegisterEvent(0,"GROUP_ROSTER_UPDATE","DataCollector_Main",NPA_EventHandler_CollectGroup)
--arena
NPA.EventHandler.RegisterEvent(0,"ARENA_OPPONENT_UPDATE","DataCollector_Main",NPA_EventHandler_CollectGroup)
--role
NPA.EventHandler.RegisterEvent(0,"PLAYER_ROLES_ASSIGNED","DataCollector_Main",NPA_EventHandler_CollectGroup)
--function for modules to register/unregister combatlog event with unitdata as parameter
NPA.DataCollector.RegisterCombatLogEvent=function(event,modulename,func)
	if(func)then
		if(not NPA_DataCollector_CombatLogModuleList[event])then
			NPA_DataCollector_CombatLogModuleList[event]={}
		end
		NPA_DataCollector_CombatLogModuleList[event][modulename]=func
	else
		if(NPA_DataCollector_CombatLogModuleList[event])then
			NPA_DataCollector_CombatLogModuleList[event][modulename]=nil
			if(not next(NPA_DataCollector_CombatLogModuleList[event]))then
				NPA_DataCollector_CombatLogModuleList[event]=nil
			end
		end
	end
end
--register a combatlog event for combatlog event modules
--run those modules with unitdata attached
NPA.EventHandler.RegisterEvent(5,"Any","DataCollector_Main",function(event,arg)
	--[1]=timestamp
	--[2]=event
	--[3]=hidecaster
	--[4]=sourceGUID
	--[5]=srouceName
	--[6]=sourceFlags
	--[7]=sourceFlags2
	--[8]=destGUID
	--[9]=destName
	--[10]=destFlags
	--[11]=destFlags2
	if(NPA_DataCollector_CombatLogModuleList[event] or NPA_DataCollector_CombatLogModuleList["Any"])then
		--check guids with macro
		--source
		local sourceguid=NPA_DataCollector_CheckGUID(arg[4])
		--dest
		local destguid=NPA_DataCollector_CheckGUID(arg[8])
		--run modules asked for certain combatlog event
		local modulelist=NPA_DataCollector_CombatLogModuleList[event]
		if(modulelist)then
			for _,func in pairs(modulelist)do
				func(arg,NPA_DataCollector_UnitData[sourceguid],NPA_DataCollector_UnitData[destguid])
			end
		end
		--run modules asked for 'any' event
		local modulelist=NPA_DataCollector_CombatLogModuleList["Any"]
		if(modulelist)then
			for _,func in pairs(modulelist)do --don't have to include event as its same as arg[2]
				func(arg,NPA_DataCollector_UnitData[sourceguid],NPA_DataCollector_UnitData[destguid])
			end
		end
	end
end)
--
local NPA_DataCollector_CollectParty=function()
end

local NPA_DataCollector_CollectRaid=function()
end

local NPA_DataCollector_CollectArena=function()
end

local NPA_DataCollector_CollectBoss=function()
end
--fire evety collectable unit with unitdata, for some real-time update function
NPA.EventHandler.RegisterEvent(3,"NPA_MainFrame_OnUpdate","DataCollector_Main",function()
	--always collect player ,player pet  and focus in real time
	NPA_DataCollector_CollectWithTarget("player")
	NPA_DataCollector_CollectWithTarget("pet")
	NPA_DataCollector_CollectWithTarget("focus")
	NPA_DataCollector_CollectWithTarget("mouseover")
	--collect rest with selected function
	NPA_DataCollector_CollectParty()
	NPA_DataCollector_CollectRaid()
	NPA_DataCollector_CollectArena()
	NPA_DataCollector_CollectBoss()
	---fire collectable on update
	local nTime=NPA_GetTime()
	for unit,_ in pairs(NPA_DataCollector_CollectableUnitToGUID)do
		if(UnitExists(unit))then --check exists
			local guid=UnitGUID(unit)
			if(UnitExists(unit) and guid)then
				NPA_DataCollector_CheckGUID(guid)
				--fire event
				NPA_EventHandler_FireEvent(2,"DataCollector_Collectable_OnUpdate",unit,NPA_DataCollector_UnitData[guid],nTime)
			end
		end
	end
	--
end)
--fire when a nameplate is shown, along with all collectable unit
NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnShow","DataCollector_Main",function(framedata)
	--exists and in data set
	NPA_EventHandler_FireEvent(2,"DataCollector_DefaultNamePlate_OnShow",framedata,NPA_DataCollector_CollectableUnitToGUID)
	--force data update, don't use this
	--NPA_EventHandler_FireEvent(8,"Any",framedata)
end)
--
NPA.DataCollector.GetUnitFromGUID=function(guid)
	if(guid and NPA_DataCollector_CollectableGUIDToUnit[guid])then
		return next(NPA_DataCollector_CollectableGUIDToUnit[guid])
	end
end
local NPA_DataCollector_GetUnitFromGUID=NPA.DataCollector.GetUnitFromGUID
--fire every time a collectable frame is updated with unitdata, for some real-time update function
NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnUpdate","DataCollector_Main",function(framedata)
	--exists and in data set
	local unit=NPA_DataCollector_GetUnitFromGUID(framedata.GUID)
	if(unit)then
		--NPA_DataCollector_CheckGUID(framedata.GUID)
		NPA_EventHandler_FireEvent(2,"DataCollector_CollectableNamePlate_OnUpdate",unit,NPA_DataCollector_UnitData[framedata.GUID])
	end
end)
--register a raidicon event, fire it with all collectable unit and unitdata with it
NPA.EventHandler.RegisterEvent(0,"RAID_TARGET_UPDATE","DataCollector_Main",function()
	for unit,guid in pairs(NPA_DataCollector_CollectableUnitToGUID)do
		--NPA_DataCollector_CheckGUID(guid)
		NPA_EventHandler_FireEvent(2,"DataCollector_Raid_Target_Updated",unit,NPA_DataCollector_UnitData[guid])
	end
end)
	-----------------------------------------------------------------------------------------------------------
	-------------------------------manage collector modules
	--register function for modules
NPA.DataCollector.RegisterModule=function(datatype,initfunc,uninitfunc,onguidattachfunc,ondataclearupfunc)
	NPA_DataCollector_ModuleFuc[datatype]={
		Init=initfunc,
		Uninit=uninitfunc,
	}
	if(onguidattachfunc)then
		NPA_DataCollector_DataTransFerFuc[datatype]=onguidattachfunc
	end
	if(ondataclearupfunc)then
		NPA_DataCollector_DataClearUpFuc[datatype]=ondataclearupfunc
	end
end
--function for enable data collecting
NPA.DataCollector.RequestDataType=function(datatype)
	--datatype exists and not inited yet
	if(NPA_DataCollector_ModuleFuc[datatype] and (not NPA_DataCollector_RequestedModuleList[datatype]))then
		NPA_DataCollector_ModuleFuc[datatype].Init()
		NPA_DataCollector_RequestedModuleList[datatype]=true
	end
end
--function for disable data collecting
NPA.DataCollector.UnrequestDataType=function(datatype)
	--datatype exists
	if(NPA_DataCollector_ModuleFuc[datatype])then
		NPA_DataCollector_ModuleFuc[datatype].Uninit()
		NPA_DataCollector_RequestedModuleList[datatype]=nil
	end
end
	--function for requesting a data collect event
NPA.DataCollector.RequestDataCollect=function(guid)
	--if the guid is collectable
	local unitid=next(NPA_DataCollector_CollectableGUIDToUnit[guid] or {})
	if(unitid)then
		--fire a event for it
		--just need one unit -- they are all the same
		--don't have to check dataset exist , as it should be checked when guid=unit is created
		NPA_EventHandler_FireEvent(2,"DataCollector_CollectUnit",unitid,NPA_DataCollector_UnitData[guid])
	end
end
------------------------------------------------------------------------------------------------------------
NPA.EventHandler.RegisterEvent(1,"DataCollector_GUIDAttached","DataCollector_CollectorMain",function(framedata)
	local guid=NPA_DataCollector_CheckGUID(framedata.GUID)
	--also copy all data already collected on framedata
	local unitdata=NPA_DataCollector_UnitData[guid]
	local frameunitdata=framedata.DefaultUnitData
	--run data transfer funcs
	for name,_ in pairs(EnabledModuleList)do
		if(NPA_DataCollector_DataTransFerFuc[name])then
			NPA_DataCollector_DataTransFerFuc[name](unitdata,frameunitdata)
		end
	end
	--attach unitdata to framedata
	framedata.UnitData=unitdata
	--fire unitdata update event
	NPA_EventHandler_FireEvent(8,"Any",framedata)
	--fire a individual event
	NPA_EventHandler_FireEvent(8,"GUID_Attached",framedata)
end)
----
NPA.EventHandler.RegisterEvent(2,"NamePlate_ClearData","DataCollector_ClearDataParser",function(unitdata)
	for name,_ in pairs(EnabledModuleList)do
		if(NPA_DataCollector_DataClearUpFuc[name])then
			NPA_DataCollector_DataClearUpFuc[name](unitdata)
		end
	end
end)
--request data type
NPA.EventHandler.RegisterEvent(6,"SettingManager_SettingLoaded","DataCollector_CollectorMain",function()
	local request=NPA.DataCollector.RequestDataType
	local unrequest=NPA.DataCollector.UnrequestDataType
	--request data according to settings
	--clear list
	EnabledModuleList={}
	--request all
	local collectorlist=NPA_Setting.Core.DataCollectors
	for name,_ in pairs(NPA_DataCollector_ModuleFuc)do
		if(collectorlist[name]==true)then
			request(name)
			EnabledModuleList[name]=true
		else
			unrequest(name)
		end
	end
	--arena collector
	local ArenaCollectID={}
	for i=1,5 do
		ArenaCollectID[i]="arena"..i
	end
	if(NPA_Setting.Core.FastCollectArena)then
		NPA_DataCollector_CollectArena=function()
			for i=1,5 do
				NPA_DataCollector_CollectWithTarget(ArenaCollectID[i])
			end
		end
	else
		local count=1
		NPA_DataCollector_CollectArena=function()
			NPA_DataCollector_CollectWithTarget(ArenaCollectID[count])
			count=count+1
			if(count>5)then
				count=1
			end
		end
	end
	--party
	local PartyCollectID={}
	for i=1,5 do
		PartyCollectID[i]="party"..i
	end
	if(NPA_Setting.Core.FastCollectParty)then
		NPA_DataCollector_CollectParty=function()
			for i=1,5 do
				NPA_DataCollector_CollectWithTarget(PartyCollectID[i])
			end
		end
	else
		local count=1
		NPA_DataCollector_CollectParty=function()
			NPA_DataCollector_CollectWithTarget(PartyCollectID[count])
			count=count+1
			if(count>5)then
				count=1
			end
		end
	end
	--raid
	local RaidCollectID={}
	for i=1,40 do
		RaidCollectID[i]="raid"..i
	end
	if(NPA_Setting.Core.FastCollectRaid)then
		NPA_DataCollector_CollectRaid=function()
			for i=1,40 do
				NPA_DataCollector_CollectWithTarget(RaidCollectID[i])
			end
		end
	else
		local count=1
		NPA_DataCollector_CollectRaid=function()
			NPA_DataCollector_CollectWithTarget(RaidCollectID[count])
			count=count+1
			if(count>40)then
				count=1
			end
		end
	end
	--boss
	local BossCollectID={}
	for i=1,5 do
		BossCollectID[i]="boss"..i
	end
	if(NPA_Setting.Core.FastCollectBoss)then
		NPA_DataCollector_CollectBoss=function()
			for i=1,5 do
				NPA_DataCollector_CollectWithTarget(BossCollectID[i])
			end
		end
	else
		local count=1
		NPA_DataCollector_CollectBoss=function()
			NPA_DataCollector_CollectWithTarget(BossCollectID[count])
			count=count+1
			if(count>5)then
				count=1
			end
		end
	end
end)

--for debug reason
NPA.DataCollector.GetUnitDataByGUID=function(guid)
	return NPA_DataCollector_UnitData[guid]
end
