-- Author      : Nogarder
-- Create Date : 2012/11/7 11:02:40
local bit_band=bit.band
local table_insert=table.insert
--
NPA_Options.InfoLib.Spell={}
--
NPA_Options.InfoLib.Spell.GetSchoolName=function(id)
	local NPA_Options_Spell_School=NPA_Options.Localization.InfoLibSpell.School
	--
	local text=""
	for mask,name in pairs(NPA_Options_Spell_School)do
		if(bit_band(id,mask)>0)then
			text=text.."["..name.."]"
		end
	end
	return text
end
--
NPA_Options.InfoLib.Spell.GetClassList=function()
	local NPA_Options_Spell_Class=NPA_Options.Localization.InfoLibSpell.Class
	--convert into button list data
	local data={}
	for value,name in pairs(NPA_Options_Spell_Class)do
		table_insert(data,{Text=name,Value=value})
	end
	return data
end

local GetColorFromCatalog=function(catalogname)
	for value,name in pairs(NPA_Options.Localization.InfoLibBasicType.Class)do
		if(name==catalogname)then
			return (NPA_Setting.Class[value] or {}).Color
		end
	end
end
NPA_Options.InfoLib.Spell.GetCatalogList=function(withcount)
	local typelist=CopyTable(NPA_Options.Localization.InfoLibSpell.Catalog)
	--
	local data={}
	for name,value in pairs(typelist)do
		table_insert(data,{
			Text=value,
			Value=name,
			Color=GetColorFromCatalog(name)
		})
	end
	return data
end

NPA_Options.InfoLib.Spell.GetPVPDRType=function()
	local drtype=NPA_Options.Localization.InfoLibSpell.DrType
	--insert custom catalog
	for _,spelldata in pairs(NPA_Setting.SpellLib)do
		drtype[spelldata.PVPDRType]=drtype[spelldata.PVPDRType] or spelldata.PVPDRType
	end
	--
	local data={}
	for value,name in pairs(drtype)do
		table_insert(data,{Text=name,Value=value})
	end
	return data
end

NPA_Options.InfoLib.Spell.GetCoolDownType=function()
	return NPA_Options.Localization.InfoLibSpell.CDType
end

NPA_Options.InfoLib.Spell.GetAffectType=function()
	return NPA_Options.Localization.InfoLibSpell.AffectType
end
