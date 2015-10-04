-- Author      : Nogarder
-- Create Date : 2012/7/27 16:31:53
NPA_Options.GetBasicTypeThreat=function()
	return NPA_Options.Localization.InfoLibBasicType.Threat
end
NPA_Options.GetBasicTypeFaction=function()
	return NPA_Options.Localization.InfoLibBasicType.Faction
end
NPA_Options.GetBasicTypeType=function()
	return NPA_Options.Localization.InfoLibBasicType.Type
end
NPA_Options.GetBasicTypeClass=function()
	local classlocalization=NPA_Options.Localization.InfoLibBasicType.Class
	local class={}
	for name,_ in pairs(RAID_CLASS_COLORS)do
		class[name]=classlocalization[name] or name
	end
	return class
end
NPA_Options.GetBasicTypeRole=function()
	return NPA_Options.Localization.InfoLibBasicType.Role
end
NPA_Options.GetBasicTypeSpellSchool=function()
	return NPA_Options.Localization.InfoLibSpell.School
end

NPA_Options.GetBasicTypeSpellType=function()
	return NPA_Options.Localization.InfoLibSpell.Class
end

NPA_Options.GetBasicTypeRaidTarget=function()
	local raidtargetlocalization=NPA_Options.Localization.InfoLibBasicType.RaidTarget
	local data={}
	for index,_ in pairs(NPA_Setting.RaidTarget)do
		data[index]=raidtargetlocalization[index] or index
	end
	return data
end

NPA_Options.GetBasicTypePower=function()
	local powerlocalization=NPA_Options.Localization.InfoLibBasicType.Power
	local data={}
	for index,_ in pairs(NPA_Setting.Color["Power"])do
		data[index]=powerlocalization[index] or index
	end
	return data
end