-- Author      : Nogarder
-- Create Date : 2012/3/19 18:04:25
local UnitExists=UnitExists
local UnitName=UnitName
local UnitHealth=UnitHealth
local UnitHealthMax=UnitHealthMax
local UnitGUID=UnitGUID
local NPA_GetTime=NPA.GetTime
local UnitIsPlayer=UnitIsPlayer
--global
local pairs=pairs
local table_getn=table.getn
--main --using local for speed
NPA.FrameToGUID={}
local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
--store showing frames
local NPA_FrameToGUID_VisiableFrameData={}
--player name to guid data
local NPA_FrameToGUID_NameToGUID={}
local NPA_FrameToGUID_NameToPetGUID={}
--guid-to-frame lookup table
local NPA_FrameToGUID_GUIDToFrameData={}
--macro for add guid to framedata
local NPA_FrameToGUID_SetFrameDataGUID=function(framedata,guid)
	if(guid)then
		framedata.GUID=guid
		--add to guid to frame lookup table
		NPA_FrameToGUID_GUIDToFrameData[guid]=framedata
		--fire event to notify frame-guid based module
		NPA_EventHandler_FireEvent(1,"DataCollector_GUIDAttached",framedata)
		return true
	end
end
local NPA_FrameToGUID_ClearFrameDataGUID=function(framedata)
	if(framedata.GUID)then
		NPA_FrameToGUID_GUIDToFrameData[framedata.GUID]=nil
		framedata.GUID=nil
	end
end
--macro for setting player name to guid stack
local NPA_FrameToGUID_SetPlayerNameToGUID=function(unit)
	if(UnitIsPlayer(unit))then
		NPA_FrameToGUID_NameToGUID[UnitName(unit)]=UnitGUID(unit)
	end
end
NPA.FrameToGUID.GetPlayerNameToGUID=function(name)
	return NPA_FrameToGUID_NameToGUID[name]
end
--check nameplate type
local NPA_FrameToGUID_CheckColorIsPlayer=function(r,g,b)
	--check with color
	---green, blue, yellow are non-hostile
	if(r==0 and g>0.9 and b==0)then -- green is friendly npc
		return false
	elseif(r==0 and g==0 and b>0.9)then --- blue is friendly player 
		return true
	elseif(r>0.9 and g>0.9 and b==0)then --- yellow is netural npc or player 
		return false
	elseif(r>0.9 and g==0 and b==0)then -- red is hostile npc
		return false
	else --other should be hostile player with class color
		return true
	end
	--r>0.5 and g>0.5 and b>0.5 -- grey is tapped hostile/neutral
end
--------default nameplate events
--using default frame rather than module frame
--data start/stop being collectable when default show/hide, and module frame may not show/hide yet.
NPA.EventHandler.RegisterEvent(2,"DataCollector_DefaultNamePlate_OnShow","DataCollector_FrameToGUID",function(framedata)
	--count in when a nameplate is shown
	NPA_FrameToGUID_VisiableFrameData[framedata]=true
	--player name is unique ,hook it up directly
	--check with default nametext
	--the nametext should be updated before nameplate is shown
	--check color to make sure it's player
	local r,g,b=framedata.Default.HealthBar:GetStatusBarColor()
	if(NPA_FrameToGUID_CheckColorIsPlayer(r,g,b)==true)then
		NPA_FrameToGUID_SetFrameDataGUID(framedata,NPA_FrameToGUID_NameToGUID[framedata.Name])
	elseif(NPA_FrameToGUID_NameToPetGUID[framedata.Name]~=-1)then
		NPA_FrameToGUID_SetFrameDataGUID(framedata,NPA_FrameToGUID_NameToPetGUID[framedata.Name])
	end

	--it has a problem like this:
	--when the nameplate first show, it always gets alpha=1
	--then the alpha change due to targeting situation (i.e. non-targeted get alpha=0.5)
	--if using alpha=1 to detect targeting, this would be a problem
	--this problem can be solved by setting alpha!=1 here
	--using 0.5
	--this alpha is only a blink, it will be changed again by system to fit the targeting situation
	framedata.Parent:SetAlpha(0.5)
end)
NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnHide","DataCollector_FrameToGUID",function(framedata)
	--count out when a nameplate is hidden
	NPA_FrameToGUID_VisiableFrameData[framedata]=nil
	--remove from guid-to-frame lookup table if exists
	NPA_FrameToGUID_ClearFrameDataGUID(framedata)
	--also fire a guid remove event to alert frame-guid based modules
	NPA_EventHandler_FireEvent(1,"DataCollector_GUIDDetached",framedata)
end)
--------system events
--check guid when mouseover changed
NPA.EventHandler.RegisterEvent(0,"UPDATE_MOUSEOVER_UNIT","DataCollector_FrameToGUID",function()
	local target="mouseover"
	if(UnitExists(target))then
		local guid=UnitGUID(target)
		for framedata,_ in pairs(NPA_FrameToGUID_VisiableFrameData)do --only check visiable frame
			if((not framedata.GUID or framedata.GUID~=guid) and framedata.Default.Highlight:IsShown() and framedata.Name==UnitName(target))then-- or  --if default highlight is shown, then it's mouseover target
				--also check name, for accurcy
				--don't check player and name... should be done in name to guid part
				--(framedata.UnitData.Type==1 and framedata.Name==UnitName(target))))then --also, if name match and it's player (unique name) ,then it's mouseover target

				NPA_FrameToGUID_SetFrameDataGUID(framedata,guid)
				break
			end
		end
		NPA_FrameToGUID_SetPlayerNameToGUID(target)
	end
end)
--using this to detect target
--UNIT_TARGET happens BEFORE alpha change, so can't use this event
--it turned out OnUpdate can sometime also happens before alpha change -_- too bad
NPA.EventHandler.RegisterEvent(3,"NPA_MainFrame_OnUpdate","DataCollector_FrameToGUID",function()
	--check exists
	if(not UnitExists("target"))then
		return
	end
	--
	local name=UnitName("target")
	local guid=UnitGUID("target")
	for framedata,_ in pairs(NPA_FrameToGUID_VisiableFrameData)do --check visiable frame
		--check guid
		if((not framedata.GUID) and
			--blizzard default works like this
			--if there's no target, all nameplate alpha=0.99xxx, using >0.9
			--if there's a target ,the target nameplate will be alpha>0.9, others will be not
			framedata.Parent:GetAlpha()>0.9 and framedata.Name==name)then --also check name just in case.
				NPA_FrameToGUID_SetFrameDataGUID(framedata,guid)
				break
			end
	end
end)
--check when unit target changed, including player self
NPA.EventHandler.RegisterEvent(0,"UNIT_TARGET","DataCollector_FrameToGUID",function(unit)
	local target=unit.."target"
	if(UnitExists(target))then
		NPA_FrameToGUID_SetPlayerNameToGUID(target)
	end
end)
--setup name to guid list when collect
NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_FrameToGUID",function(unit)
	if(UnitIsPlayer(unit))then
		NPA_FrameToGUID_SetPlayerNameToGUID(unit)
	end
end)
--wrap up unitdata change with frame -- only when the frame matching guid is visible
NPA.EventHandler.RegisterEvent(7,"Any","DataCollector_FrameToGUID",function(event,unitdata)
	if(not unitdata)then
		return
	end
	local guid=unitdata.GUID
	if(guid and NPA_FrameToGUID_GUIDToFrameData[guid])then
		NPA_EventHandler_FireEvent(8,event,NPA_FrameToGUID_GUIDToFrameData[guid])
	end
end)

--this is for target arrow and combat text
local FrameDataList={}
--
NPA.FrameToGUID.CheckFrameByGUIDNoFake=function(guid)
	if(guid and NPA_FrameToGUID_GUIDToFrameData[guid])then
		return true
	else
		return false
	end
end
--
NPA.FrameToGUID.GetFrameByGUID=function(guid)
	--check guid to framedata
	local framedata=NPA_FrameToGUID_GUIDToFrameData[guid]
	if(framedata)then
		return framedata.ModuleMain
	else
		if(FrameDataList[guid])then
			return FrameDataList[guid]
		else --special check
			--check player
			if(guid==UnitGUID("player"))then --this may change so using real-time one
				return UIParent --player's position is UIParent Center
			end
			return nil
		end
	end
end
--this is for tracker module's fake nameplates
NPA.FrameToGUID.RegisterFrameByGUID=function(guid,modulemain)
	FrameDataList[guid]=modulemain
end

--
NPA.FrameToGUID.NameToGUID=function(name)
	return NPA_FrameToGUID_NameToGUID[name]
end

--power match functions
NPA.EventHandler.RegisterEvent(6,"SettingManager_SettingLoaded","DataCollector_FrameToGUID_PowerMatch",function()
	--check setting
	if(NPA_Setting.Core.PowerMatch==true)then
		local PowerMatch_DamageList={}
		local PowerMatch_NameList={}
		local PowerMatch_HeatlhBarValue={}
		local NPA_InfoFromFlag_GetPlayer=NPA.InfoFromFlag.GetPlayer
		--on clear part, clear up data
		NPA.EventHandler.RegisterEvent(2,"NamePlate_ClearData","DataCollector_FrameToGUID_PowerMatch",function(framedata)
			PowerMatch_DamageList[framedata]={}
			PowerMatch_HeatlhBarValue[framedata]=nil
		end)
		--also clear data when guid attached
		NPA.EventHandler.RegisterEvent(2,"DataCollector_GUIDAttached","DataCollector_FrameToGUID_PowerMatch",function(framedata)
			PowerMatch_DamageList[framedata]=nil
			PowerMatch_HeatlhBarValue[framedata]=nil
		end)

		--healthbar value change part
		NPA.EventHandler.RegisterEvent(1,"NamePlate_HealthBar_OnValueChanged","DataCollector_FrameToGUID_PowerMatch",function(framedata,value,_,max)
			--ignore those already hooked guid
			if(framedata.GUID)then
				return
			end
			--
			local checklist=PowerMatch_DamageList[framedata]
			if(PowerMatch_HeatlhBarValue[framedata])then
				local differ=value - PowerMatch_HeatlhBarValue[framedata]
				if(differ~=0)then
					local dguid=nil
					local checked=nil
					for guid,dvalue in pairs(checklist)do
						if(dvalue==differ and checked~=false)then
							if(dguid==nil)then --check if there're two or more match
								dguid=guid
								checked=true
							else
								--two match, not checked
								checked=false
							end
						end
						--clear up after compare
						checklist[guid]=0
					end
					--set up guid if there's only one match
					if(checked==true)then--guid match, clear up, set guid, and return
						NPA_FrameToGUID_SetFrameDataGUID(framedata,dguid)
						return
					end
				else
					--no differ ,just clear up compare data
					if(checklist)then
						for guid,_ in pairs(checklist)do
							checklist[guid]=0
						end
					end
				end
			else
				--first met, setup check list
				PowerMatch_DamageList[framedata]={}
			end
			PowerMatch_HeatlhBarValue[framedata]=value
		end)
		--combatlog tracker part
		local PowerMatch_EventFunc={
			--swing don't have icon
			["SWING_DAMAGE"]=function(arg)
				--swing damage, arg[12] would be the exact damage done
				return arg[12]
			end,
			["SWING__EXTRA_ATTACKS"]=function(arg)
				--same as swing damage, arg[12] would be the exact damage done
				return arg[12]
			end,
			--
			["RANGE_DAMAGE"]=function(arg)
				--range damage, arg[15]
				return arg[15]
			end,
			--
			["RANGE_EXTRA_ATTACKS"]=function(arg) --same as damage
				--same as range attack
				return arg[15]
			end,
			["SPELL_DAMAGE"]=function(arg,texttype)
				--spell damage , arg[15]
				return arg[15]
			end,
			--
			["SPELL_PERIODIC_DAMAGE"]=function(arg)
				--same as spell damage
				return arg[15]
			end,
			["SPELL_DAMAGE_SHIELD_DAMAGE"]=function(arg)
				--same as spell damage
				return arg[15]
			end,
			["SPELL_DAMAGE_SPLIT_DAMAGE"]=function(arg)
				--same as spell damage
				return arg[15]
			end,
			["SPELL_DRAIN"]=function(arg)
				--same as spell damage
				return arg[15]
			end,
			["SPELL_LEECH"]=function(arg)
				--same as spell damage
				return arg[15]
			end,
			["ENVIRONMENTAL_DAMAGE"]=function(arg)
				--arg[13]
				return arg[13]
			end,
			["SPELL_HEAL"]=function(arg)
				--heal type, exact amout = heal - overheal, also, return as negative damage
				local absorb=(arg[16] or 0) +(arg[17] or 0)
				if(absorb>0)then -- for unknow reason it would be negative... filter it out
					return -(arg[15]-absorb)
				else
					return -arg[15]
				end
			end,
			["SPELL_PERIODIC_HEAL"]=function(arg)
				--same as heal
				local absorb=(arg[16] or 0) +(arg[17] or 0)
				if(absorb>0)then -- for unknow reason it would be negative... filter it out
					return -(arg[15]-absorb)
				else
					return -arg[15]
				end
			end,
			---
		}
		local CheckPlayer=function(flag)
			if(NPA_InfoFromFlag_GetPlayer(flag)>0)then
				return true
			end
		end
		
		NPA.EventHandler.RegisterEvent(5,"Any","DataCollector_FrameToGUID_PowerMatch",function(event,arg)
			--filter out those doesn't have target or is player
			if(not arg[8] or CheckPlayer(arg[10])==true)then
				return
			end
			if(PowerMatch_EventFunc[event])then
				--record damage and name for matching
				local damage=PowerMatch_EventFunc[event](arg)
				for framedata,dataset in pairs(PowerMatch_DamageList)do
					if(framedata.Name==arg[9])then -- only when name matchs
						dataset[arg[8]]=(dataset[arg[8]] or 0) - damage--minus ,healing count as negative damage
					end
				end
			end
		end)
	else
		--unregister event
		NPA.EventHandler.RegisterEvent(2,"NamePlate_ClearData","DataCollector_FrameToGUID_PowerMatch",nil)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_HealthBar_OnValueChanged","DataCollector_FrameToGUID_PowerMatch",nil)
		NPA.EventHandler.RegisterEvent(5,"Any","DataCollector_FrameToGUID_PowerMatch",nil)
	end
	
end)
--power match functions

NPA.EventHandler.RegisterEvent(6,"SettingManager_SettingLoaded","DataCollector_FrameToGUID_PowerMatch2",function()
	--check setting
	if(NPA_Setting.Core.PetNameMatch==true)then
		NPA_FrameToGUID_NameToPet={}
		NPA.EventHandler.RegisterEvent(7,"Type_Updated","DataCollector_FrameToGUID_PetNameMatch",function(unitdata,_,name)
			local name=name or unitdata.Name
			if(name and unitdata.Type==3 and NPA_FrameToGUID_NameToPet[name]~=unitdata.GUID)then
				if(NPA_FrameToGUID_NameToPet[name])then
					--more than one match, set it to -1
					NPA_FrameToGUID_NameToPet[name]=-1
				else --not exists 
					NPA_FrameToGUID_NameToPet[name]=unitdata.GUID
				end
			end
		end)
		NPA.EventHandler.RegisterEvent(2,"DataCollector_DefaultNamePlate_OnShow","DataCollector_FrameToGUID_PetNameMatch",function(framedata)
			--pet name maybe unique ,hook it up directly
			--check with default nametext
			--the nametext should be updated before nameplate is shown
			--check color to make sure it's not player
			local r,g,b=framedata.Default.HealthBar:GetStatusBarColor()
			-- -1 means more than one match
			if(NPA_FrameToGUID_CheckColorIsPlayer(r,g,b)~=true and NPA_FrameToGUID_NameToPetGUID[framedata.Name]~=-1)then
				NPA_FrameToGUID_SetFrameDataGUID(framedata,NPA_FrameToGUID_NameToPetGUID[framedata.Name])
			end
		end)
	else
		NPA_FrameToGUID_NameToPetGUID={}
		NPA.EventHandler.RegisterEvent(7,"Type_Updated","DataCollector_FrameToGUID_PetNameMatch",nil)
		NPA.EventHandler.RegisterEvent(2,"DataCollector_DefaultNamePlate_OnShow","DataCollector_FrameToGUID_PetNameMatch",nil)
	end
end)