-- Author      : Nogarder
-- Create Date : 2013/6/8 17:09:54
local pairs=pairs
local table_getn=table.getn
local table_insert=table.insert
local NPA_GetTime=NPA.GetTime
local UnitGUID=UnitGUID
local next=next
local tonumber=tonumber
--
--
local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
local NPA_EventHandler_RegisterEvent=NPA.EventHandler.RegisterEvent

local NPA_DataCollector_GetUnitDataByGUID=NPA.DataCollector.GetUnitDataByGUID
local NPA_FrameMacro_SetFrameTimer=NPA.FrameMacro.SetFrameTimer
local NPA_SettingManager_GetNamePlateProfileByName=NPA.SettingManager.GetNamePlateProfileByName

local NPA_ArrowManager_CreateArrow=NPA.ArrowManager.CreateArrow
local NPA_ArrowManager_ManageArrow=NPA.ArrowManager.ManageArrow
--
local NPA_FrameToGUID_RegisterFrameByGUID=NPA.FrameToGUID.RegisterFrameByGUID
local NPA_FrameToGUID_CheckFrameByGUIDNoFake=NPA.FrameToGUID.CheckFrameByGUIDNoFake
--
local TrackerList={}
local TrackerListByGroup={}
local TrackingList={}
local TrackedUnit={}
local NamePlateCount=0
--
NPA.Tracker={}
--
local NPA_Tracker_CreateTracker=function()
	--fake default nameplate
	local motherframe=CreateFrame("Frame",nil,NPA.MainFrame)
	motherframe:SetPoint("CENTER",UIParent,"CENTER",0,0)
	motherframe:SetWidth(1)
	motherframe:SetHeight(1)
	motherframe:Show()
	--fake modulemain
	local modulemain=CreateFrame("Frame",nil,motherframe)
	modulemain:SetPoint("CENTER",motherframe,"CENTER")
	modulemain:SetWidth(1)
	modulemain:SetHeight(1)
	modulemain.Parent=motherframe
	--modulemain["Default"]=modulemain
	--
	motherframe.FrameData={
		Parent=motherframe,
		ModuleMain=modulemain,
		UnitData={}
	}
	return motherframe
end
--
NPA.Tracker.CreateTracker=NPA_Tracker_CreateTracker
--
local GetAviliableNamePlate=function(group,unitdata)
	--find smallest index and aviliable nameplate in a group
	local dindex
	for index,tracker in pairs(TrackerListByGroup[group])do
		if((dindex==nil or index<dindex) and (not tracker:IsShown()))then
			dindex=index
		end
	end
	return TrackerListByGroup[group][dindex]
end
--
local NPA_Tracker_AddCondition=function(unitdata,setting,index,group)
	local trackedunit=TrackedUnit[group]
	if(not trackedunit)then
		return
	end
	if(not trackedunit[unitdata])then
		trackedunit[unitdata]={
			[index]=setting
		}
		--updated, return true
		return true
	end
	if(trackedunit[unitdata][index]==setting)then
		--not updated, return false
		return false
	else
		--updated, return true
		trackedunit[unitdata][index]=setting
		return true
	end
end
--
local NPA_Tracker_CheckGroup=function(group,oldsetting)
	--check if there's unit in one group which not shown
	local trackinglist=TrackingList[group]
	if(trackinglist)then
		for unitdata,settinglist in pairs(TrackedUnit[group])do
			if(not trackinglist[unitdata])then
				local checkedsetting
				for index,setting in pairs(settinglist)do
					if(setting==oldsetting)then
						--remove condition if ti's same as old one
						settinglist[index]=nil
					else
						checkedsetting=setting
						break
					end
				end
				if(checkedsetting)then
					if(NPA.Tracker.AddTracker(unitdata,group,checkedsetting)==false)then
						--return when no more aviliable nameplate
						return
					end
				end
			end
		end
	end
end
--
local NPA_Tracker_RemoveTracker=function(unitdata,group)
	--just hide it 
	local frame=TrackingList[group][unitdata]
	if(frame)then
		--unregister frame --this is for extra module like targetarrow/combattext
		NPA_FrameToGUID_RegisterFrameByGUID(unitdata.GUID,nil)
		--hide, check and remove old record
		frame:Hide()
		NPA_Tracker_CheckGroup(group,frame.Setting)
		--clear list
		TrackingList[group][unitdata]=nil
	end
end
--
local NPA_Tracker_AddTracker=function(unitdata,group,setting)
	--
	local nTime=NPA_GetTime()
	if(TrackingList[group][unitdata] and TrackingList[group][unitdata]:IsShown())then
		--already exists and shown ,reset timer limit
		NPA_FrameMacro_SetFrameTimer(TrackingList[group][unitdata],nTime,nTime+TrackingList[group][unitdata].TimeLimit)
		return true
	end
	local nameplate=GetAviliableNamePlate(group)
	--
	if(not nameplate)then
		--false mean no aviliable nameplate
		return false
	end
	--set it up
	local framedata=nameplate.FrameData
	framedata.UnitData=unitdata
	framedata.Profile=NPA_SettingManager_GetNamePlateProfileByName(setting.Profile)
	framedata.Setting=setting
	--timer
	NPA_FrameMacro_SetFrameTimer(nameplate,nTime,nTime+nameplate.TimeLimit,
		function(nTime,data,frame)
			frame:SetAlpha((data.EndTime-nTime)/data.Length)
		end,
		function(frame)
			--remove tracker
			NPA_Tracker_RemoveTracker(frame.FrameData.UnitData,frame.Group)
		end)
	--show it and fire event
	nameplate:Show()
	NPA.EventHandler.FireEvent(1,"NamePlate_ProfileChange",framedata,framedata.Profile)
	--record it
	TrackingList[group][unitdata]=nameplate
	--register frame if setting allowed
	NPA_FrameToGUID_RegisterFrameByGUID(unitdata.GUID,nameplate)
	--
	return true
end
NPA.Tracker.AddTracker=NPA_Tracker_AddTracker
--
local NPA_Tracker_CheckRealNameplateExists=function(unitdata,setting)
	if(setting.HideWhenConflict==true)then
		if(NPA_FrameToGUID_CheckFrameByGUIDNoFake(unitdata.GUID))then
			return false
		else
			return true
		end
	else
		return true
	end
end
--
local NPA_Tracker_SetTracker=function(unitdata)
	for group,unitdatalist in pairs(TrackedUnit)do
		--pick one setting, any would do
		if(unitdatalist[unitdata])then
			local _,setting=next(unitdatalist[unitdata])
			--check real nameplate for conflict and decide with setting
			if(setting and NPA_Tracker_CheckRealNameplateExists(unitdata,setting))then
				NPA_Tracker_AddTracker(unitdata,group,setting)
			else
				NPA_Tracker_RemoveTracker(unitdata,group)
			end
		else
			NPA_Tracker_RemoveTracker(unitdata,group)
		end
	end
end
local NPA_Tracker_CheckFaction=function(faction,setting)
	--faction, 1=friendly,2=neutral,3=hostile
	if(not faction)then
		--unit with no faction would always be tracked
		return true
	end
	if((faction==1 and setting.Friendly) or
		(faction==2 and setting.Neutral) or
			(faction==3 and setting.Hostile)
		)then
			return true
		end
	return false
end
--
NPA.EventHandler.RegisterEvent(6,"Tracker_SettingUpdated","Tracker_Main",function()
	--set nameplate
	local settings=NPA_Setting.Tracker.Nameplates
	local count=1
	TrackingList={}
	TrackerListByGroup={}
	for _,setting in pairs(settings)do
		if(not TrackerList[count])then
			TrackerList[count]=NPA_Tracker_CreateTracker()
		end
		local tracker=TrackerList[count]
		tracker:ClearAllPoints()
		tracker:SetPoint("CENTER",UIParent,"CENTER",setting.PosX,setting.PosY)
		tracker:SetScale(setting.Scale)
		tracker:SetAlpha(setting.Alpha)
		tracker:SetFrameLevel(setting.FrameLevel)
		tracker.Group=setting.Group
		tracker.Index=setting.Index
		tracker.TimeLimit=setting.TrackTime
		--sort by group
		if(not (TrackerListByGroup[setting.Group]))then
			TrackerListByGroup[setting.Group]={[setting.Index]=tracker}
		else
			TrackerListByGroup[setting.Group][setting.Index]=tracker
		end
		if(not TrackingList[setting.Group])then
			TrackingList[setting.Group]={}
		end
		--
		count=count+1
	end
	NamePlateCount=count-1
	--hide all nameplates
	for i=1,table_getn(TrackerList)do
		TrackerList[i]:Hide()
	end
	--prepare conditions
	local SpecialUnitCondition={}
	local TargetCondition={}
	local AuraCondition={}
	local WithCoolDownCondition={}
	local WithoutCoolDownCondition={}
	--
	local settings=NPA_Setting.Tracker.Condition
	TrackedUnit={}
	for index,setting in pairs(settings)do
		if(TrackingList[setting.Group])then
			--1="Unit is special unit",
			--2="Unit's target is special unit",
			--3="Unit is with special aura",
			--4="Unit is with special name",
			--5="Unit is with special unit id",
			--5="Unit's name includes special text",
			--6="Unit with cooldown",
			--7="Unit without cooldown",
			if(setting.ConditionType=="1")then
				table_insert(SpecialUnitCondition,index)
			elseif(setting.ConditionType=="2")then
				table_insert(TargetCondition,index)
			elseif(setting.ConditionType=="3")then
				table_insert(AuraCondition,index)
			elseif(setting.ConditionType=="6")then
				table_insert(WithCoolDownCondition,i)
			elseif(setting.ConditionType=="7")then
				table_insert(WithoutCoolDownCondition,i)
			end
			--
			if(not TrackedUnit[setting.Group])then
				TrackedUnit[setting.Group]={}
			end
		end
	end
	--register condition
	--special unit
	if(next(SpecialUnitCondition))then
		--keep track of every unitdata so it can be removed when target changed
		local unitdatalist={}
		--	
		NPA_EventHandler_RegisterEvent(2,"DataCollector_CollectUnit","Tracker_SpecialUnit",function(_,unitdata)
			local nTime=NPA_GetTime()
			for _,index in pairs(SpecialUnitCondition)do
				local setting=settings[index]
				if(setting)then
					if(unitdata.GUID==UnitGUID(setting.Arg) and NPA_Tracker_CheckFaction(unitdata.Faction,setting))then
						if(not unitdatalist[unitdata])then
							unitdatalist[unitdata]={[index]=setting}
						else
							unitdatalist[unitdata][index]=setting
						end
						NPA_Tracker_AddCondition(unitdata,setting,index,setting.Group)
					else
						if(unitdatalist[unitdata])then
							unitdatalist[unitdata][index]=nil
						end
						NPA_Tracker_AddCondition(unitdata,nil,index,setting.Group)
					end
				end
			end
			--also remove the old ones
			for unitdata,settinglist in pairs(unitdatalist)do
				local dupdated
				for index,setting in pairs(settinglist)do
					--check unitid and faction
					if(unitdata.GUID~=UnitGUID(setting.Arg) or  NPA_Tracker_CheckFaction(unitdata.Faction,setting)==false)then
						--remove this condition from tracking list
						TrackedUnit[setting.Group][unitdata][index]=nil
						--remove the record
						settinglist[index]=nil
						--
						dupdated=true
					end
				end
				if(dupdated==true)then
					NPA_Tracker_SetTracker(unitdata)
				end
			end
			--
			NPA_Tracker_SetTracker(unitdata)
		end)
	else
		NPA_EventHandler_RegisterEvent(7,"Any","Tracker_SpecialUnit",nil)
	end
	--target unit
	if(next(TargetCondition))then
		NPA_EventHandler_RegisterEvent(7,"Target_Updated","Tracker_TargetUnit",function(unitdata)
			local nTime=NPA_GetTime()
			for _,index in pairs(TargetCondition)do
				local setting=settings[index]
				if(unitdata.TargetGUID==UnitGUID(setting.Arg) and NPA_Tracker_CheckFaction(unitdata.Faction,setting))then
					NPA_Tracker_AddCondition(unitdata,setting,index,setting.Group)
				else
					NPA_Tracker_AddCondition(unitdata,nil,index,setting.Group)
				end
			end
			NPA_Tracker_SetTracker(unitdata)
		end)
	else
		NPA_EventHandler_RegisterEvent(7,"Target_Updated","Tracker_TargetUnit",nil)
	end
	--special unit
	if(next(AuraCondition))then
		NPA_EventHandler_RegisterEvent(7,"Aura_Updated","Tracker_Aura",function(unitdata)
			local updated
			local nTime=NPA_GetTime()
			--
			local auralist=unitdata.Aura
			if(not auralist)then
				return
			end
			--
			for _,index in pairs(AuraCondition)do
				local setting=settings[index]
				local spellid=tonumber(setting.Arg)
				--
				if(NPA_Tracker_CheckFaction(unitdata.Faction,setting))then
					local checked
					for i=1,table_getn(auralist)do
						--check with list
						if(auralist[i].SpellId==spellid and auralist[i].ExpirationTime>nTime)then
							checked=true
							break
						end
					end
					if(checked==true)then
						NPA_Tracker_AddCondition(unitdata,setting,index,setting.Group)
					else
						NPA_Tracker_AddCondition(unitdata,nil,index,setting.Group)
					end
				end
			end
			NPA_Tracker_SetTracker(unitdata)
		end)
	else
		NPA_EventHandler_RegisterEvent(7,"Aura_Updated","Tracker_Aura",nil)
	end
	--cooldown
	if(next(WithCoolDownCondition) or next(WithoutCoolDownCondition))then
		NPA_EventHandler_RegisterEvent(7,"CoolDown_Updated","Tracker_CoolDown",function(unitdata)
			if(not unitdata.CoolDown)then
				return
			end
			--
			local nTime=NPA_GetTime()
			--
			local update
			local auralist=unitdata.CoolDown
			--check with list
			for i=1,table_getn(WithCoolDownCondition)do
				local index=WithAuraCondition[i]
				local setting=settings[index]
				if(NPA_Tracker_CheckFaction(unitdata.Faction,setting))then
					local checked
					local spellid=tonumber(setting.Arg)
					for i=1,table_getn(auralist)do
						--check with list
						if(auralist[i].SpellId==spellid and auralist[i].ExpirationTime>nTime)then
							checked=true
							break
						end
					end
					if(checked==true and prioritylist[index]==nil)then
						NPA_Tracker_AddCondition(unitdata,setting,index,setting.Group)
						update=true
					elseif(checked==nil and prioritylist[index]~=nil)then
						NPA_Tracker_AddCondition(unitdata,nil,index,setting.Group)
						update=true
					end
				end
			end
			--check without list , just the revers version of with
			for i=1,table_getn(WithoutCoolDownCondition)do
				local index=WithoutAuraCondition[i]
				local setting=settings[index]
				if(NPA_Tracker_CheckFaction(unitdata.Faction,setting))then
					local spellid=tonumber(setting.Arg)
					local checked
					for i=1,table_getn(auralist)do
						--check with list
						if(auralist[i].SpellId==spellid and auralist[i].ExpirationTime>nTime)then
							checked=true
							break
						end
					end
					if(checked)then
						NPA_Tracker_AddCondition(unitdata,nil,index,setting.Group)
					else
						NPA_Tracker_AddCondition(unitdata,setting,index,setting.Group)
					end
				end
			end
			NPA_Tracker_SetTracker(unitdata)
		end)
	end
	--data parser 
	NPA.EventHandler.RegisterEvent(7,"Any","Tracker_DataParser",function(event,unitdata)
		for group,unitdatalist in pairs(TrackingList)do
			if(unitdatalist[unitdata])then
				NPA_EventHandler_FireEvent(8,event,unitdatalist[unitdata].FrameData)
			end
		end
	end)
	--refresh profile
	local RefreshProfile=function()
		for _,tracker in pairs(TrackerList)do
			if(tracker:IsShown() and tracker.FrameData.Profile)then
				NPA_EventHandler_FireEvent(1,"NamePlate_ProfileChange",tracker.FrameData,tracker.FrameData.Profile)
			end
		end
	end
	NPA.EventHandler.RegisterEvent(6,"NamePlate_ProfileRefresh","Tracker_ProfileManager",RefreshProfile)
	--when profile refreshs by NPA_Options
	--fire profilechange event with every visible frame
	--to refresh the display
	NPA.EventHandler.RegisterEvent(6,"Resources_ProfileRefresh","Tracker_ProfileManager",RefreshProfile)
	--when profile key changes, only fire with the frame which using them
	NPA.EventHandler.RegisterEvent(6,"NamePlate_ProfileKeyChange","Tracker_ProfileManager",function(profilename)
		local profile=NPA_Setting.NamePlate[profilename]
		for _,tracker in pairs(TrackerList)do
			if(tracker:IsShown() and tracker.FrameData.Profile==profile)then
				NPA_EventHandler_FireEvent(1,"NamePlate_ProfileChange",tracker.FrameData,profile)
			end
		end
	end)
end)
