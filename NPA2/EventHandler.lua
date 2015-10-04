-- Author      : Nogarder
-- Create Date : 2012/3/16 18:19:12
local pairs=pairs
local select=select
local GetTime=NPA.GetTime
local next=next
--main
NPA.EventHandler={}
--delayed event
local DelayedEventCount=0
local DelayedEventList={}
--func lists
local NPA_EventHandler_EventFuncs={
	[0]={}, --system event
	[1]={}, --nameplate frame event
	[2]={}, --data collector event
	[3]={}, --mainframe event
	[4]={}, --module event
	[5]={}, --combatlog event
	[6]={}, --setting event
	[7]={}, --data collector module event
	[8]={}, --data collector paser
	[9]={}, --fake combat log event
}
--using [5] speically for combatlog event 
--local NPA_EventHandler_CombatEventFuncs=NPA_EventHandler_EventFuncs[5]
--eventlist ,just for notes, the values don't mean anything yet
--nameplate event list notes
--local NPA_EventHandler_NamePlateEventList={ 
--	--[1] -- these are always fired with FrameData as parameter
--	["NamePlate_DefaultMain_OnUpdate"]=1,
--	["NamePlate_DefaultMain_OnShow"]=2,
--	["NamePlate_DefaultMain_OnHide"]=3,
--	["NamePlate_ModuleMain_OnShow"]=4,
--	["NamePlate_ModuleMain_OnHide"]=5,
--	["NamePlate_ModuleMain_OnUpdate"]=6,
--	["NamePlate_DefaultMain_OnHook"]=7,

--	["NamePlate_CastBar_OnShow"]=7,
--	--["NamePlate_CastBar_OnHide"]=7, --blizzard protect these ,can't use them now
--	--["NamePlate_CastBar_OnUpdate"]=7,

--	["NamePlate_GUIDAttached"]=11, 
--	["NamePlate_GUIDDetached"]=11,

--	["NamePlate_ProfileChange"]=12, --FrameData, ProfileEntry
--}
----data collector event list notes
--local NPA_EventHandler_DataCollectorEventList={
--	--[2] --parameters are different ,see below
--	["DataCollector_CollectUnit"]=9, -- Unit, UnitData
--	["DataCollector_CollectTooltips"]=10, --Unit, UnitData
--	["DataCollector_PlayerEnteringWorld"]=1,-- InstanceType,1=pve instance,2=arena,3=pvp battleground
--	["DataCollector_DefaultHealthBarValueChanged"]=1, --FrameData,UnitData
--	["DataCollector_Collectable_OnUpdate"]=1, --Unit,UnitData
--	["DataCollector_CollectableNamePlate_OnUpdate"]=1,--Unit,UnitData
--	["DataCollector_Raid_Target_Updated"]=1,--Unit,UnitData
--	["DataCollector_DefaultNamePlate_OnShow"]=1, --NPA_DataCollector_CollectableUnitToGUID
--	["DataCollector_UnitUpdated"]=1,--unit, unitdata
--	["DataCollector_TooltipsUpdated"]=1,--unit,linelist
--	["NamePlate_ClearData"]=1,--unitdata
--}
----mainframe event lists notes
--local NPA_EventHandler_MainFrameEventList={
--	--[3] 
--	["NPA_MainFrame_OnUpdate"]=8, -- elapse
--	["NPA_MainFrame_OnLoad"]=10, -- no parameter
--}
--local NPA_EventHandler_VisibleFrameDataCollectorModuleEventList={
--	--[4] --these are same with data collector module event but with additional frame data as paramater
--	--framedata, unitdata
--}
--local NPA_EventHandler_CombatLogEvent={
--	--[5] --placeholder
--	--normal combatlog event with customed timestamp
--}
----setting event list notes
--local NPA_EventHandler_SettingEventList={
--	--[6] --place holder
--	["ProfileManager_ProfileLoaded"]=1,-- no parameter
--	["SettingManager_SettingLoaded"]=1,-- no parameter
--	["NamePlate_ProfileKeyChange"]=1,-- profilename
--	["Resources_ProfileRefresh"]=1,--no parameter
--	["NamePlate_ConditionUpdated"]=1,--no parameter
--	["TargetArrow_SettingUpdated"]=1,--no parameter
--	["CombatText_SettingUpdated"]=1,--no parameter
--	["Tracker_SettingUpdated"]=1,--no parameter
--}
--local NPA_EventHandler_DataCollectorModuleUnitDataEventList={
--	--[7] these are always fired with a UnitData
--	["Name_Updated"]=12,
--	["Type_Updated"]=12,
--	["Threat_Updated"]=12,
--	["Alpha_Updated"]=12,
--	["Level_Updated"]=12,
--	["EliteState_Updated"]=12,
--	["BossState_Updated"]=12,
--	["Casting_Updated"]=11,
--	["Faction_Updated"]=11,

--	["GuildList_Updated"]=11,
--	["FriendList_Updated"]=11,
--	["GuessedHealth_Updated"]=11,
--	["Portrait_Updated"]=11,
--	["Position_Updated"]=11,
--	["Power_Updated"]=11,
--	["RaidIcon_Updated"]=11,
--	["Range_Updated"]=11,
--	["Speed_Updated"]=11,
--	["Tapped_Updated"]=12,
--	["Aura_Updated"]=11,
--}
--local NPA_EventHandler_DataCollectorModuleBasicDataEventList={
--	--[8] these are fired with a framedata, a unitdata, and a loop back bool
--	--framedata,unitdata,isloopback
--	["Name_Updated"]=12,
--	["Type_Updated"]=12,
--	["Threat_Updated"]=12,
--	["Alpha_Updated"]=12,
--	["Level_Updated"]=12,
--	["EliteState_Updated"]=12,
--	["BossState_Updated"]=12,
--	["SpellLock_Updated"]=12,
--	["Casting_Updated"]=12,
--	["Summoned_Updated"]=12,
--	["GUID_Attached"]=12,
--}
--local NPA_EventHandler_FakeCombatLogEvent={
--	["CC_DR_STARTED"], --unitdata, spellid,drtype, count
--	["CC_DR_ENDED"],arguments: unitdata,spellid,drtype
--["COOLDOWN_STARTED"],arguments:unitdata, spellid, time,count
--["COOLDOWN_ENDED"],arguments:unitdata, spellid,count
--}
NPA.EventHandler.UnregisterEventByName=function(eventtype,name)
	local funclist=NPA_EventHandler_EventFuncs[eventtype]
	if(funclist)then
		for event,list in pairs(funclist) do
			list[name]=nil
		end
	end
end
----register function
NPA.EventHandler.RegisterEvent=function(eventtype,event,name,func)
	local funclist=NPA_EventHandler_EventFuncs[eventtype]
	--register
	if(func)then
		if(not funclist)then
			NPA_EventHandler_EventFuncs[eventtype]={}
			funclist=NPA_EventHandler_EventFuncs[eventtype]
		end
		if(not funclist[event])then
			funclist[event]={}
		end
		funclist[event][name]=func
		if(eventtype==0)then --is system event
			--register system event
			NPA.MainFrame:RegisterEvent(event)
		end
	else
		--unregister if func is nil
		if(funclist[event])then
			funclist[event][name]=nil
			if(not next(funclist[event]))then
				funclist[event]=nil
				if(not next(NPA_EventHandler_EventFuncs[eventtype]))then
					NPA_EventHandler_EventFuncs[eventtype]=nil
				end
				if(eventtype==0)then --system event
					--no longer listening, unregister
					NPA.MainFrame:UnregisterEvent(event)
				end
			end
		end
	end
	----debug
	--print("------------------------")
	--print("register:")
	--print(eventtype)
	--print(event)
	--print(name)
	--print("------------------------")
	----debug
end
local RealFireEvent=function(eventtype,event,...)
	local eventlist=NPA_EventHandler_EventFuncs[eventtype]
	local funclist=eventlist[event]
	if(event~="Any")then
		if(funclist)then
			for _,func in pairs(funclist) do
				func(...)
			end
			----debug
			--for name,_ in pairs(funclist) do
			--	----debug
			--	if(eventtype==8 and event=="Type_Updated")then
			--		print("------------------------")
			--		print(name)
			--		print("fire at:"..NPA.GetTime())
			--		print("------------------------")
			--	end
			--end
			--debug

		end
		--function registered to "any" would be fired in any other event
		--with event as parameter 
		local funclist=eventlist["Any"]
		if(funclist)then
			for _,func in pairs(funclist) do
				func(event,...)
			end
		end
	else
		--fire with "Any" as parameter
		for _,func in pairs(funclist) do
			func(event,...)
		end
	end
end
--fire function
----------------------------dont use these yet------------------
--local delayedList={
--	[0]=true, --system event
--	[1]=true, --nameplate frame event
--	--[2]=true, --data collector event
--	[3]=true, --mainframe event
--	[4]=true, --module event
--	[5]=true, --combatlog event
--	--[6]=true, --setting event
--	[7]=true, --data collector module event
--}
--delay the event 
--local FireEvent=function(eventtype,event,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12,arg13)
--	--critical type doesn't delay
--	if(delayedList[eventtype]==nil)then
--		RealFireEvent(eventtype,event,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12,arg13)
--		return
--	end
--	if(not DelayedEventList[DelayedEventCount])then
--		DelayedEventList[DelayedEventCount]={}
--	end
--	local eventitem=DelayedEventList[DelayedEventCount]	
--	eventitem.EventType=eventtype
--	eventitem.Event=event
--	eventitem.Arg1=arg1
--	eventitem.Arg2=arg2
--	eventitem.Arg3=arg3
--	eventitem.Arg4=arg4
--	eventitem.Arg5=arg5
--	eventitem.Arg6=arg6
--	eventitem.Arg7=arg7
--	eventitem.Arg8=arg8
--	eventitem.Arg9=arg9
--	eventitem.Arg10=arg10
--	eventitem.Arg11=arg11
--	eventitem.Arg12=arg12
--	eventitem.Arg13=arg13
--	--
--	DelayedEventCount=DelayedEventCount+1
--end
--on frame update, run delayed event list
--local NPA_EventFrame=CreateFrame("Frame","NPA_MainFrame",UIParent)
----NPA.NPA_EventFrame=NPA_EventFrame
--NPA_EventFrame:SetScript("OnUpdate",function()
--	for i=0,DelayedEventCount-1 do
--		local eventitem=DelayedEventList[i]
--		RealFireEvent(eventitem.EventType,eventitem.Event,eventitem.Arg1,eventitem.Arg2,
--							  eventitem.Arg3,eventitem.Arg4,eventitem.Arg5,eventitem.Arg6,eventitem.Arg7,
--							  eventitem.Arg8,eventitem.Arg9,eventitem.Arg10,eventitem.Arg11,eventitem.Arg12,
--							  eventitem.Arg13)
--	end
--	DelayedEventCount=0
--end)
--
--max 13 arg
NPA.EventHandler.FireEvent=function(eventtype,event,...)
	--"any" event would fire every event in this eventtype
	if(event=="Any")then
		for eventname,funclist in pairs(NPA_EventHandler_EventFuncs[eventtype])do
			RealFireEvent(eventtype,eventname,...,"FireByAny")
		end
	else
		RealFireEvent(eventtype,event,...)
	end
	----debug
	--if(eventtype==6 and event=="SettingManager_SettingLoaded")then
	--	print("------------------------")
	--	print("fire at:"..NPA.GetTime())
	--	print(eventtype)
	--	print(event)
	--	print("------------------------")
	--	NPA.DumpTable(NPA_EventHandler_EventFuncs[eventtype][event])
	--end
	--debug
end
--

--debug function

NPA.EventHandler.GetEventList=function(eventtype)
	return NPA_EventHandler_EventFuncs[eventtype]
end