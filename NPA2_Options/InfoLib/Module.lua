-- Author      : Nogarder
-- Create Date : 2012/7/22 8:15:29
local table_insert=table.insert
--module
NPA_Options.InfoLib.GetModules=function()
	local NPA_Options_Modules_Localization={}
	for value,name in pairs(NPA_Options.Localization.InfoLibModule)do
		if(value~="Tooltips" and value~="MainModule")then
			NPA_Options_Modules_Localization[value]=name
		end
	end
	return NPA_Options_Modules_Localization
end

NPA_Options.InfoLib.GetModulesButtonData=function()
	local NPA_Options_Modules=NPA_Options.InfoLib.GetModules()
	local Tooltips=NPA_Options.Localization.InfoLibModule.Tooltips
	--convert into new formation
	local modulesdata={}
	for value,name in pairs(NPA_Options_Modules)do
		table_insert(modulesdata,	{
			Text=name,
			Value=value,
			Tooltips=Tooltips[value]
		})
	end
	return modulesdata
end
--
NPA_Options.InfoLib.GetIconGroupModulesButtonData=function()
	local IconGroupModulesFilter={
			["Text"]=true,
			["BarGroup"]=true,
			["TextureGroup"]=true,
			["Number"]=true,
			["Icon"]=true,
	}
	local NPA_Options_Modules=NPA_Options.Localization.InfoLibModule.Tooltips
	local Tooltips=NPA_Options.Localization.InfoLibModule.Tooltips
	--convert into new formation
	local modulesdata={}
	for value,name in pairs(NPA_Options_Modules)do
		if(IconGroupModulesFilter[value])then
			table_insert(modulesdata,	{
				Text=name,
				Value=value,
				Tooltips=Tooltips[value]
			})
		end
	end
	return modulesdata
end
--
NPA_Options.InfoLib.GetModulesAnchorFrame=function()
	local NPA_Options_ModulesButtonData=NPA_Options.InfoLib.GetModulesButtonData()
	local NPA_Options_MainModule=NPA_Options.Localization.InfoLibModule.MainModule
	--
	table_insert(NPA_Options_ModulesButtonData,NPA_Options_MainModule)
	return NPA_Options_ModulesButtonData
end
