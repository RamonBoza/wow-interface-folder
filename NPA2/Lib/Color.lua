-- Author      : Nogarder
-- Create Date : 2012/8/31 9:48:27
local UnitLevel=UnitLevel
--
NPA.Color={}
local NPA_ColorListFaction={}
local NPA_ColorListClass={}
local NPA_ColorListThreat={}
local NPA_ColorListSpellSchool={}
local NPA_ColorListSpellType={}
local NPA_ColorListLevel={}
local NPA_ColorListPower={}
--
local DefaultColor={R=1,G=1,B=1,A=1}
--
NPA.Color.GetColorByFaction=function(faction)
	if(faction)then
		return NPA_ColorListFaction[faction] or DefaultColor, nil
	else
		return DefaultColor,true
	end
end
NPA.Color.GetColorByClass=function(class,type)
	if(class and type==1)then
		return NPA_ColorListClass[class] or DefaultColor, nil
	else
		return DefaultColor,true
	end
end
NPA.Color.GetColorByThreat=function(threatstatus)
	if(threatstatus)then
		return NPA_ColorListThreat[threatstatus] or DefaultColor, nil
	else
		return DefaultColor,true
	end
end
--
NPA.Color.GetColorByPower=function(power)
	if(power)then
		return NPA_ColorListPower[power] or DefaultColor, nil
	else
		return DefaultColor,true
	end
end
--
--local SpellSchoolColorTable={
--	[1]={R=1,G=1,B=0,A=1}, --physical
--	[2]={R=1,G=1,B=0.5,A=1}, --holy
--	[4]={R=1,G=0.3,B=0,A=1}, --fire
--	[8]={R=0.25,G=1,B=0.25,A=1}, --nature
--	[16]={R=0.5,G=1,B=1,A=1},--frost
--	[32]={R=0.5,G=0.5,B=1,A=1},--shadow
--	[64]={R=1,g=0.5,B=1,A=1}--arcane
--}
NPA.Color.GetColorBySpellSchool=function(spellschool)
	--place holder
	if(not spellschool)then
		return DefaultColor
	end
	return NPA_ColorListSpellSchool[spellschool] or DefaultColor
end

NPA.Color.GetColorByLevel=function(level)
	local level=level or 0
	local playerlevel=UnitLevel("player")
	if(level-playerlevel>3)then -- +3=red
		return NPA_ColorListLevel["High"]
	elseif(playerlevel-level>5)then-- -5=grey
		return NPA_ColorListLevel["Low"]
	elseif(playerlevel-level>3)then -- -3=green
		return NPA_ColorListLevel["Over"]
	else --in range is yellow
		return NPA_ColorListLevel["InRange"]
	end
end

NPA.Color.GetColorBySpellType=function(spelltype)
	if(not spelltype)then
		return DefaultColor
	else
		return NPA_ColorListSpellType[spelltype] or DefaultColor
	end
end

NPA.EventHandler.RegisterEvent(6,"SettingManager_SettingLoaded","ColorManager",function()
	--build data cache
	--faction
	NPA_ColorListFaction=NPA_Setting.Color["Faction"]
	--class
	NPA_ColorListClass={}
	for class,entry in pairs(NPA_Setting.Class)do
		NPA_ColorListClass[class]=entry.Color
	end
	--threat
	NPA_ColorListThreat=NPA_Setting.Color["Threat"]
	--spellschool
	NPA_ColorListSpellSchool=NPA_Setting.Color["SpellSchool"]
	--spelltype
	NPA_ColorListSpellType=NPA_Setting.Color["SpellType"]
	--placeholder- level
	NPA_ColorListLevel={
		["High"]={R=1,G=0,B=0,A=1},
		["Low"]={R=0.3,G=0.3,B=0.3,A=1},
		["Over"]={R=0,G=1,B=0,A=1},
		["InRange"]={R=1,G=1,B=0,A=1},
	}
	--power
	NPA_ColorListPower=NPA_Setting.Color["Power"]
end)
