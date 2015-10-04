-- Author      : Nogarder
-- Create Date : 2013/4/20 16:50:07
local pairs=pairs
local UnitGUID=UnitGUID
local next=next
local string_split=string.split
--
local NPA_InfoFromFlag_GetReaction=NPA.InfoFromFlag.GetReaction
local NPA_InfoFromFlag_GetPlayerPet=NPA.InfoFromFlag.GetPlayerPet
--
local NPA_DataCollector_GetUnitDataByGUID=NPA.DataCollector.GetUnitDataByGUID

local NPA_CombatTextManager_AddText=NPA.CombatTextManager.AddText

local NPA_SpellInfo_GetSpellInfo=NPA.SpellInfo.GetSpellInfo
--
local NPA_DataCollector_GetUnitDataByGUID=NPA.DataCollector.GetUnitDataByGUID
--
local NPA_FrameToGUID_GetFrameByGUID=NPA.FrameToGUID.GetFrameByGUID

local NPA_SpellInfo_GetSpellInfo=NPA.SpellInfo.GetSpellInfo

local NPA_NumberManager_GetNumber2=NPA.NumberManager.GetNumber2
--
local NPA_CombatText_OverkillList={
	--melee type
	["SWING_DAMAGE"]=1,
	["SWING_EXTRA_ATTACKS"]=1,
	["RANGE_DAMAGE"]=2,
	["RANGE_EXTRA_ATTACKS"]=2,
	["SPELL_DAMAGE"]=2,
	["SPELL_PERIODIC_DAMAGE"]=2,
	--damage shield type
	["SPELL_DAMAGE_SHIELD_DAMAGE"]=2,
	["SPELL_DAMAGE_SPLIT_DAMAGE"]=2,
	["SPELL_DAMAGE_SHIELD_MISSED"]=2,
	--energy type
	["SPELL_ENERGIZE"]=2, --get energy by spell
	["SPELL_DRAIN"]=2, --cause target to lose energy by spell
	["SPELL_LEECH"]=2, --cause target to lose energy ,and get energy for self, by spell
	--inturrpt type
	 --heal type
	["SPELL_HEAL"]=3,
	["SPELL_PERIODIC_HEAL"]=3,
}
local NPA_CombatText_CriticalCheckList={
	["SWING_DAMAGE"]=18,
	["SWING_EXTRA_ATTACKS"]=21,
	["RANGE_DAMAGE"]=21,
	["RANGE_EXTRA_ATTACKS"]=21,
	["SPELL_DAMAGE"]=21,
	["SPELL_PERIODIC_DAMAGE"]=21,
	----damage shield type
	--["SPELL_DAMAGE_SHIELD_DAMAGE"]=21,
	--["SPELL_DAMAGE_SPLIT_DAMAGE"]=21,
	--["SPELL_DAMAGE_SHIELD_MISSED"]=21,
	--inturrpt type
	 --heal type
	["SPELL_HEAL"]=18,
	["SPELL_PERIODIC_HEAL"]=18,
}
local NPA_CombatText_MultiStrikeCheckList={
	["SWING_DAMAGE"]=22,
	["SWING_EXTRA_ATTACKS"]=25,
	["RANGE_DAMAGE"]=25,
	["RANGE_EXTRA_ATTACKS"]=25,
	["SPELL_DAMAGE"]=25,
	["SPELL_PERIODIC_DAMAGE"]=25,
	----damage shield type
	--["SPELL_DAMAGE_SHIELD_DAMAGE"]=22,
	--["SPELL_DAMAGE_SPLIT_DAMAGE"]=22,
	--["SPELL_DAMAGE_SHIELD_MISSED"]=22,
	 --heal type
	["SPELL_HEAL"]=19,
	["SPELL_PERIODIC_HEAL"]=19,
}
--
local NPA_CombatText_CheckOverkillFunc={
	[1]=function(arg)
		return arg[12]==0
	end,
	[2]=function(arg)
		return arg[15]==0
	end,
	[3]=function(arg)
		local absorb=(arg[16] or 0) +(arg[17] or 0)
		return arg[15]==absorb
	end,
}
--
local GetType=function(guid,flag)
	--1=player 2=target 3=focus 4=mouseover ,5=pets --64=hostile 32=neutral, 16=friendly
	if(guid==UnitGUID("player"))then
		return 1
	elseif(guid==UnitGUID("target"))then
		return 2
	elseif(guid==UnitGUID("focus"))then
		return 3
	elseif(guid==UnitGUID("mouseover"))then
		return 4
	--elseif(guid==UnitGUID("pet") or NPA_InfoFromFlag_GetPlayerPet(flag))then
	elseif(NPA_InfoFromFlag_GetPlayerPet(flag))then --don't need to double check it ,don't know if unitguid is faster?
		return 5
	else -- other summoned
		local unitdata=NPA_DataCollector_GetUnitDataByGUID(UnitGUID("player"))
		if(unitdata and unitdata.Summon and unitdata.Summon[guid])then
			return 5
		else
			return NPA_InfoFromFlag_GetReaction(flag) -- hostile=64, neutral=32, friendly=16
		end
	end
end
local GetType2=function(guid)
	--1=player 2=target 3=focus 4=mouseover ,5=pets --64=hostile 32=neutral, 16=friendly
	if(guid==UnitGUID("player"))then
		return 1
	elseif(guid==UnitGUID("target"))then
		return 2
	elseif(guid==UnitGUID("focus"))then
		return 3
	elseif(guid==UnitGUID("mouseover"))then
		return 4
	elseif(guid==UnitGUID("pet"))then
		return 5
	else --other summoned
		local unitdata=NPA_DataCollector_GetUnitDataByGUID(UnitGUID("player"))
		if(unitdata and unitdata.Summon and unitdata.Summon[guid])then
			return 5
		end
	end
end
--
--return icon,text,school
--get number ,1=don't change --2=short,3=break
local GetIconAndTextOnTarget={
	--swing don't have icon
	["SWING_DAMAGE"]=function(arg,texttype,numbertype)
		local text,text2
		text="-"..NPA_NumberManager_GetNumber2(arg[12],numbertype)
		if(texttype==2)then --2=detail
			local absorb=(arg[15] or 0)+(arg[16] or 0)+(arg[17] or 0)
			if(absorb>0)then
				text2="(-"..NPA_NumberManager_GetNumber2(absorb,numbertype)..")"
			end
		end
		return nil,text,0,text2
	end,
	["SWING__EXTRA_ATTACKS"]=function(arg,texttype,numbertype) --same as damage
		local text,text2
		text="-"..NPA_NumberManager_GetNumber2(arg[12],numbertype)
		if(texttype==2)then --2=detail
			local absorb=(arg[15] or 0)+(arg[16] or 0)+(arg[17] or 0)
			if(absorb>0)then
				text2="(-"..NPA_NumberManager_GetNumber2(absorb,numbertype)..")"
			end
		end
		return nil,text,0
	end,
	--
	["SWING_MISSED"]=function(arg,texttype)
		local text,text2
		text="-"..arg[12]
		if(texttype==2)then --2=detail
			if(arg[15])then
				text2="(-"..arg[15]..")"
			end
		end
		return nil,text,0,text2
	end,
	--
	--range type-- range also don't have icon
	["RANGE_DAMAGE"]=function(arg,texttype,numbertype)
		local text,text2
		text="-"..NPA_NumberManager_GetNumber2(arg[15],numbertype)
		if(texttype==2)then --2=detail
			local absorb=(arg[18] or 0)+(arg[19] or 0)+(arg[20] or 0)
			if(absorb>0)then
				text2="(-"..NPA_NumberManager_GetNumber2(absorb,numbertype)..")"
			end
		end
		return nil,text,0,text2
	end,
	--
	["RANGE_EXTRA_ATTACKS"]=function(arg,texttype,numbertype) --same as damage
		local text,text2
		text="-"..NPA_NumberManager_GetNumber2(arg[15],numbertype)
		if(texttype==2)then --2=detail
			local absorb=(arg[18] or 0)+(arg[19] or 0)+(arg[20] or 0)
			if(absorb>0)then
				text2="(-"..NPA_NumberManager_GetNumber2(absorb,numbertype)..")"
			end
		end
		return nil,text,0,text2
	end,
	["RANGE_MISSED"]=function(arg,texttype)
		local text,text2
		text="-"..arg[15]
		if(texttype==2)then --2=detail
			if(arg[18])then
				text2="("..arg[18]..")"
			end
		end
		return nil,text,0,text2
	end,
	--spell damage type
	["SPELL_DAMAGE"]=function(arg,texttype,numbertype)
		local text,text2
		text="-"..NPA_NumberManager_GetNumber2(arg[15],numbertype)
		if(texttype==2)then --2=detail
			local absorb=(arg[18] or 0)+(arg[19] or 0)+(arg[20] or 0)
			if(absorb>0)then
				text2="(-"..NPA_NumberManager_GetNumber2(absorb,numbertype)..")"
			end
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[17],text2
	end,
	--
	["SPELL_PERIODIC_DAMAGE"]=function(arg,texttype,numbertype)
		local text,text2
		text="-"..NPA_NumberManager_GetNumber2(arg[15],numbertype)
		if(texttype==2)then --2=detail
			local absorb=(arg[18] or 0)+(arg[19] or 0)+(arg[20] or 0)
			if(absorb>0)then
				text2="(-"..NPA_NumberManager_GetNumber2(absorb,numbertype)..")"
			end
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[17],text2
	end,
	--
	["SPELL_MISSED"]=function(arg,texttype)
		local text,text2
		text="-"..arg[15]
		if(texttype==2)then --2=detail
			if(arg[18])then
				text2="("..arg[18]..")"
			end
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[14],text2
	end,
	--["SPELL_DISPEL_FAILED"]=function(arg,texttype,numbertype) --when to use these?
	--["SPELL_DAMAGE_SHIELD_DAMAGE"]=function(arg,texttype,numbertype)
	--["SPELL_DAMAGE_SPLIT_DAMAGE"]=
	--["SPELL_DAMAGE_SHIELD_MISSED"]=
	--aura apply type
	["SPELL_AURA_APPLIED"]=function(arg,texttype)
		local text,text2
		text="+"
		if(texttype==2)then --2=detail
			local drtype=NPA_SpellInfo_GetSpellInfo(arg[12]).PVPDRType
			if(drtype and drtype~="None")then
				text2="("..drtype..")("..(arg[5] or "?")..")"
			else
				text2="("..(arg[5] or "?")..")"
			end
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[14],text2
	end,
	["SPELL_AURA_APPLIED_DOSE"]=function(arg,texttype)
		local text,text2
		text="+"..arg[16]
		if(texttype==2)then --2=detail
			text2="("..(arg[5] or "?")..")"
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[14],text2
	end,
	--aura remove type
	["SPELL_AURA_REMOVED"]=function(arg,texttype)
		local text,text2
		text="-"
		if(texttype==2)then --2=detail
			text2="("..arg[15]..")"
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[14],text2
	end,
	--
	["SPELL_AURA_BROKEN"]=function(arg,texttype) --same as removed
		local text,text2
		text="X"
		if(texttype==2)then --2=detail
			text2="("..(arg[5] or "?")..")"
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[14],text2
	end,
	--
	["SPELL_AURA_BROKEN_SPELL"]=function(arg,texttype) --arg is slightly different
		local text,text2
		text="X"
		if(texttype==2)then --2=detail
			text2="("..(arg[5] or "?")..")"
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[14],text2
	end,
	--
	["SPELL_AURA_REMOVED_DOSE"]=function(arg,texttype)
		local text,text2
		text="-"..arg[16]
		if(texttype==2)then --2=detail
			text2="("..arg[15]..")"
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[14],text2
	end,
	["SPELL_STOLEN"]=function(arg,texttype)
		local text,text2
		text="X"
		if(texttype==2)then --2=detail
			text2="("..(arg[5] or "?")..")"
		end
		return NPA_SpellInfo_GetSpellInfo(arg[15]).Icon,text,arg[14],text2
	end,
	["SPELL_DISPEL"]=function(arg,texttype)
		local text,text2
		text="X"
		if(texttype==2)then --2=detail
			text2="("..(arg[5] or "?")..")"
		end
		return NPA_SpellInfo_GetSpellInfo(arg[15]).Icon,text,arg[14],text2
	end,
	--energy type
	["SPELL_ENERGIZE"]=function(arg,texttyp,numbertype)
		local text,text2
		text="+"..NPA_NumberManager_GetNumber2(arg[15],numbertype)
		if(texttype==2)then --2=detail
			text2="("..(arg[5] or "?")..")"
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[14],text2
	end,
	["SPELL_DRAIN"]=function(arg,texttype,numbertype)
		local text,text2
		text="-"..NPA_NumberManager_GetNumber2(arg[15],numbertype)
		if(texttype==2)then --2=detail
			text2="("..(arg[5] or "?")..")"
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[14],text2
	end,
	["SPELL_LEECH"]=function(arg,texttype,numbertype)
		local text,text2
		text="-"..NPA_NumberManager_GetNumber2(arg[15],numbertype)
		if(texttype==2)then --2=detail
			text2="("..(arg[5] or "?")..")"
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[14],text2
	end,
	--inturrpt type
	["SPELL_INTERRUPT"]=function(arg,texttype,numbertype)
		local text,text2
		text="X"..arg[16]
		if(texttype==2)then --2=detail
			text2="("..(arg[5] or "?")..")"
		end
		return NPA_SpellInfo_GetSpellInfo(arg[15]).Icon,text,arg[14],text2
	end,
	--summon type
	["SPELL_CREATE"]=function(arg,texttype)
		local text,text2
		text="->"..arg[9]
		if(texttype==2)then --2=detail
			text2="("..(arg[5] or "?")..")"
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[14],text2
	end,
	["SPELL_SUMMON"]=function(arg,texttype)
		local text,text2
		text="->"..arg[9]
		if(texttype==2)then --2=detail
			text2="("..arg[13]..")"
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[14],text2
	end,
	["SPELL_RESURRECT"]=function(arg,texttype)
		local text,text2
		text="=>"..arg[9]
		if(texttype==2)then --2=detail
			text2="("..arg[13]..")"
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[14],text2
	end,
	--special type
	--["UNIT_DIED"]=function(arg,texttype,numbertype) --died ,placeholder
	--	return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[14]
	--end,
	["UNIT_DESTROYED"]=function(arg,texttype)
		local text,text2
		text="X"..arg[9]
		if(texttype==2)then --2=detail
			text2="("..(arg[5] or "?")..")"
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[14],text2
	end,
	["ENVIRONMENTAL_DAMAGE"]=function(arg,texttype,numbertype)
		local text,text2
		text="-"..NPA_NumberManager_GetNumber2(arg[13],numbertype)
		if(texttype==2)then --2=detail
			text2="("..arg[12]..")"
		end
		return nil,text,0,text2
	end,
	--heal type
	["SPELL_HEAL"]=function(arg,texttype,numbertype)
		local text,text2
		local absorb=(arg[16] or 0) +(arg[17] or 0)
		if(absorb>0)then
			text="+"..NPA_NumberManager_GetNumber2((arg[15]-absorb),numbertype)
			if(texttype==2)then --2=detail
				text2="("..NPA_NumberManager_GetNumber2(absorb,numbertype)..")"
			end
		else
			text="+"..NPA_NumberManager_GetNumber2(arg[15],numbertype)
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[14],text2
	end,
	["SPELL_PERIODIC_HEAL"]=function(arg,texttype,numbertype) --same as heal
		local text,text2
		local absorb=(arg[16] or 0) +(arg[17] or 0)
		if(absorb>0)then
			text="+"..NPA_NumberManager_GetNumber2((arg[15]-absorb),numbertype)
			if(texttype==2)then --2=detail
				text2="("..NPA_NumberManager_GetNumber2(absorb,numbertype)..")"
			end
		else
			text="+"..NPA_NumberManager_GetNumber2(arg[15],numbertype)
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[14],text2
	end,
	---
	["SPELL_ABSORBED"]=function(arg,texttype,numbertype)
		local icon
		local school
		local text,text2
		if(arg[22])then
			text="(-)"..NPA_NumberManager_GetNumber2(arg[22],numbertype)
			if(texttype~=1)then
				text2="("..arg[20]..")"
			end
			icon=NPA_SpellInfo_GetSpellInfo(arg[19]).Icon
			id=arg[19]
			school=arg[21]
		elseif(arg[19])then
			text="(-)"..NPA_NumberManager_GetNumber2(arg[19],numbertype)
			if(texttype~=1)then
				text2="("..arg[17]..")"
			end
			icon=NPA_SpellInfo_GetSpellInfo(arg[16]).Icon
			school=arg[18]
		end
		return icon,text,school,text2
	end
}
local GetIconAndTextOnSource={
	--cast event
	["SPELL_CAST_START"]=function(arg,texttype)
		local text=arg[13] or ""
		local text2
		local spellinfo=NPA_SpellInfo_GetSpellInfo(arg[12])
		local casttime=spellinfo.CastTime
		if(texttype==2 and casttime and casttime>0)then
			text=text.."~"
			if(texttype==2)then
				text2=" ("..casttime..")"
			end
		else
			text=text.."~"
		end
		return spellinfo.Icon,text,arg[14],text2
	end,
	["SPELL_CAST_SUCCESS"]=function(arg)
		local text=(arg[13] or "").."->"
		local text2
		if(arg[9])then
			text2=" "..arg[9]
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[14],text2
	end,
	["SPELL_CAST_FAILED"]=function(arg,texttype)
		local text,text2
		text=(arg[13] or "").."X"
		if(texttype==2)then
			text2="("..(arg[15] or "")..")"
		end
		return NPA_SpellInfo_GetSpellInfo(arg[12]).Icon,text,arg[14],text2
	end,
}
--
local GetSpecialIconAndText={
	["CC_DR_STARTED"]=function(spellid,drtype,count)
		local text="DR"
		local text2="("..(drtype or "")..")"
		if(count and count>1)then
			text2=text2.."("..count..")"
		end
		return NPA_SpellInfo_GetSpellInfo(spellid).Icon,text,nil,text2
	end,
	["CC_DR_ENDED"]=function(spellid,drtype)
		local text="DR ends"
		local text2="("..(drtype or "")..")"
		return NPA_SpellInfo_GetSpellInfo(spellid).Icon,text,nil,text2
	end,
	["COOLDOWN_STARTED"]=function(spellid,time,count)
		local text="CD:"..(time or "").."s"
		local text2
		if(count and count>1)then
			text2="("..count..")"
		end
		return NPA_SpellInfo_GetSpellInfo(spellid).Icon,text,nil,text2
	end,
	["COOLDOWN_ENDED"]=function(spellid,count)
		local text="Ready"
		local text2
		if(count and count>1)then
			text2="("..count..")"
		end
		return NPA_SpellInfo_GetSpellInfo(spellid).Icon,text,nil,text2
	end,
}
--
NPA.EventHandler.RegisterEvent(6,"CombatText_SettingUpdated","CombatText_Main",function()
	--if setting is empty, unregister event
	if(next(NPA_Setting.CombatText))then
		local AnimationList=NPA_Setting.CombatText.Animation
		--
		local settings=NPA_Setting.CombatText.Condition
		--
		local string_find=string.find
		--
		NPA.EventHandler.RegisterEvent(5,"Any","CombatText_Main",function(event,arg)
			local targetframe=NPA_FrameToGUID_GetFrameByGUID(arg[8])
			local sourceframe=NPA_FrameToGUID_GetFrameByGUID(arg[4])
			--
			if((targetframe and GetIconAndTextOnTarget[event]) or
				(sourceframe and GetIconAndTextOnSource[event]))then

				local from=GetType(arg[4],arg[6])
				local to=GetType(arg[8],arg[10])
				--
				local crittype=NPA_CombatText_CriticalCheckList[event]
				--check critical
				if(crittype and arg[crittype])then
					crittype=1 
				else
					crittype=2
				end
				--check multistrike
				local multistrike=NPA_CombatText_MultiStrikeCheckList[event]
				if(multistrike and arg[multistrike])then
					multistrike=1
				else
					multistrike=2
				end
				--
				for _,setting in pairs(settings)do
					if(((setting.EventList[event]) and	--combat event filter
							((setting.SpellListType==0) or
							(setting.SpellListType==1 and setting.SpellList[arg[12] or 0]) or
							(setting.SpellListType==2 and not setting.SpellList[arg[12] or 0])
							) and
							(setting.IgnoreOverkill==false or 
							 (NPA_CombatText_OverkillList[event] and 
							 NPA_CombatText_CheckOverkillFunc[NPA_CombatText_OverkillList[event]](arg)~=true))
							) and
						(setting.From==0 or setting.From==from) and --from filter
						(setting.FromName=="" or (setting.FromExact==true and setting.FromName==arg[5]) or (setting.FromExact==false and string_find(arg[5],setting.FromName))) and --from name filter
						(setting.ToName=="" or (setting.ToExact==true and setting.ToName==arg[9]) or (setting.ToExact==false and string_find(arg[9],setting.ToName))) and --to name filter
						(setting.To==0 or setting.To==to) and --to filter
						(setting.CritType==0 or setting.CritType==crittype) and --crit filter
						(setting.MultiStrikeType==0 or setting.MultiStrikeType==multistrike)
						
						)then --event filter
							if(GetIconAndTextOnTarget[event])then
								local icon,text,school,detail=GetIconAndTextOnTarget[event](arg,setting.TextType,setting.NumberType)
								NPA_CombatTextManager_AddText(targetframe,icon,text,detail,school,setting,AnimationList[setting.AnimationName])
							elseif(GetIconAndTextOnSource[event])then
								local icon,text,school,detail=GetIconAndTextOnSource[event](arg,setting.TextType,setting.NumberType)
								NPA_CombatTextManager_AddText(sourceframe,icon,text,detail,school,setting,AnimationList[setting.AnimationName])
							end
					end
				end
			end
		end)
		NPA.EventHandler.RegisterEvent(9,"Any","CombatText_Main",function(event,unitdata,arg1,arg2,arg3)
			local targetframe=NPA_FrameToGUID_GetFrameByGUID(unitdata.GUID)
			if(targetframe and GetSpecialIconAndText[event])then
				local name=unitdata.Name
				local to=GetType2(unitdata.GUID)
				for _,setting in pairs(settings)do
					if( (setting.SpecialEventList[event]) and --combat event filter
						(setting.ToName=="" or (setting.ToExact==true and setting.ToName==name) or (setting.ToExact==false and string_find(name,setting.ToName))) and --to name filter
						(setting.To==0 or setting.To==to) --to filter
						)then
							local icon,text,school,detail=GetSpecialIconAndText[event](arg1,arg2,arg3)
							NPA_CombatTextManager_AddText(targetframe,icon,text,detail,school,setting,AnimationList[setting.AnimationName])
					end
				end
			end
		end)
	else
		NPA.EventHandler.RegisterEvent(5,"Any","CombatText_Main",nil)
		NPA.EventHandler.RegisterEvent(9,"Any","CombatText_Main",nil)
	end
end)
--

--EventList={
--	--melee type
--	["SWING_DAMAGE"]=true,
--	["SWING_MISSED"]=true,
--	["SWING_EXTRA_ATTACKS"]=true,
--range type
--	["RANGE_DAMAGE"]=true,
--	["RANGE_MISSED"]=true,
--	["RANGE_EXTRA_ATTACKS"]=true,
--	--spell damage type
--	["SPELL_DAMAGE"]=true,
-- ["SPELL_PERIODIC_DAMAGE"]=true,
--	["SPELL_MISSED"]=true,
--	["SPELL_DISPEL_FAILED"]=true, --dispel fail
--	--damage shield type
--	["SPELL_DAMAGE_SHIELD_DAMAGE"]=true,
--	["SPELL_DAMAGE_SPLIT_DAMAGE"]=true,
--	["SPELL_DAMAGE_SHIELD_MISSED"]=true,
--	--aura apply type
--	["SPELL_AURA_APPLIED"]=true,
--	["SPELL_AURA_APPLIED_DOSE"]=true,
--	--aura remove type
--	["SPELL_AURA_REMOVED"]=true,
--	["SPELL_AURA_REMOVED_DOSE"]=true,
--	["SPELL_AURA_BROKEN"]=true, --removed by melee --usually cc spell
--	["SPELL_AURA_BROKEN_SPELL"]=true, --removed by spell
--	["SPELL_STOLEN"]=true, --stolen for mage
--	["SPELL_DISPEL"]=true,
--	--energy type
--	["SPELL_ENERGIZE"]=true, --get energy by spell
--	["SPELL_DRAIN"]=true, --cause target to lose energy by spell
--	["SPELL_LEECH"]=true, --cause target to lose energy ,and get energy for self, by spell
--	--inturrpt type
--	["SPELL_INTERRUPT"]=true, --get interrupt by spell
--	--summon type
--	["SPELL_CREATE"]=true, --create something 
--	["SPELL_SUMMON"]=true, --summon, like pet, tottem,etc
--	["SPELL_RESURRECT"]=true, --resurrect someone
--	--special type
--	["UNIT_DIED"]=true, --unit just died
--	["UNIT_DESTROYED"]=true, --happens to old tottem when new tottem is summoned 
--	["ENVIRONMENTAL_DAMAGE"]=true, --environmental damage,
-- --heal type
--["SPELL_HEAL"]=true,
--["SPELL_PERIODIC_HEAL"]=true,
--cast type
--["SPELL_CAST_START"]=true,
--["SPELL_CAST_SUCCESS"]=true,
--["SPELL_CAST_FAILED"]=true
--}
--special(fake) combat log event event 9
--["CC_DR_STARTED"], arguments: unitdata, spellid,drtype, count
--["CC_DR_ENDED"],arguments: unitdata,spellid,drtype
--["COOLDOWN_STARTED"],arguments:unitdata, spellid, time,count
--["COOLDOWN_ENDED"],arguments:unitdata, spellid,count