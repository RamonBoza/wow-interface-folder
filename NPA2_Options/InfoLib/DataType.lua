-- Author      : Nogarder
-- Create Date : 2013/3/22 3:36:46
local table_insert=table.insert
--
local Localization=NPA_Options.Localization.InfoLibDataType
--
 NPA_Options.InfoLib.GetDataType=function(groupname)
	local datatype=NPA.NamePlateModuleManager.GetDataType(groupname)
	local datatypelist={}
	for datatype,_ in pairs(datatype) do
		table_insert(datatypelist,{
			Text=Localization[datatype] or datatype,
			Value=datatype
		})
	end
	 return datatypelist
end