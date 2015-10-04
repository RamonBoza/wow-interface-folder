-- Author      : Nogarder
-- Create Date : 2012/12/11 11:04:06
local table_getn=table.getn
local wipe=wpie
--
local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
local NPA_EventHandler_RegisterEvent=NPA.EventHandler.RegisterEvent
local NPA_EventHandler_UnregisterEventByName=NPA.EventHandler.UnregisterEventByName
local NPA_ConditionChecker_BuildConditionList=NPA.ConditionChecker.BuildConditionList
--
--create condition list for every framedata
local PriorityLists={}
NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnHook","NamePlate_ProfileManager",function(framedata)
	PriorityLists[framedata]={}
end)
NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_PreOnShow","NamePlate_ProfileManager",function(framedata)
	NPA_EventHandler_FireEvent(8,"BaseEvent_PreOnShow",framedata)
end)
--
NPA.EventHandler.RegisterEvent(6,"NamePlate_ConditionUpdated","NamePlate_ProfileManager",function()
	--build condition check list
	for _,data in pairs(PriorityLists)do
		data={}
	end
	local settings=NPA_Setting.NamePlateCondition
	--
	local EventRegister=function(event,func)
		NPA_EventHandler_RegisterEvent(8,event,"NamePlate_ProfileManager",function(framedata,isloopback)
			if(isloopback)then
				return
			end
			local prioritylist=PriorityLists[framedata]
			if(prioritylist)then
				func(prioritylist,framedata)
			end
		end)
	end
	--
	local count=table_getn(settings)
	local UpdateFunc=function(framedata,prioritylist)
		for i=1,count do
			if(prioritylist[i])then
				local profile
				if(prioritylist[i]==-1)then
					profile=NPA_Setting.NamePlate["Default"]
				else
					profile=NPA_Setting.NamePlate[settings[i].Profile]
				end
				if(profile)then
					if(profile~=framedata.Profile)then
						--only fire event when different
						framedata.Profile=profile
						NPA_EventHandler_FireEvent(1,"NamePlate_ProfileChange",framedata,profile)
					end
					return
				end
			end
		end
		--when nothing matches, set to default profile
		framedata.Profile=NPA_Setting.NamePlate["Default"]
		NPA_EventHandler_FireEvent(1,"NamePlate_ProfileChange",framedata,profile)
	end
	--clear old register
	NPA_EventHandler_UnregisterEventByName(8,"NamePlate_ProfileManager")
	--
	NPA_ConditionChecker_BuildConditionList(settings,EventRegister,UpdateFunc)
	--update all
	--no argument
	for framedata,_ in pairs(PriorityLists)do
		--request a refresh from nameplate
		NPA_EventHandler_FireEvent(1,"NamePlate_RequireDefaultMain_OnShow",framedata)
	end
end)
