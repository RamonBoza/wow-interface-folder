-- Author      : Nogarder
-- Create Date : 2013/4/18 12:05:07
local string_sub=string.sub
local tonumber=tonumber
--
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements

local NPA_TextManager_SetText=NPA.TextManager.SetText

NPA.NamePlateModuleManager.RegisterDataModule("Text","UnitID",function(framedata,textframe)
	textframe:Show()
	NPA_TextManager_SetText(textframe,nil)
	--add event elements
	NPA_NamePlateDataParser_AddElements(framedata,textframe,"UnitID_Updated",function(framedata)
		NPA_TextManager_SetText(textframe,framedata.UnitData.UnitID)
	end)
end)
NPA.NamePlateModuleManager.RegisterDataModule("Text","Unit",function(framedata,textframe)
	textframe:Show()
	NPA_TextManager_SetText(textframe,nil)
	--add event elements
	NPA_NamePlateDataParser_AddElements(framedata,textframe,"Unit_Updated",function(framedata)
		NPA_TextManager_SetText(textframe,framedata.UnitData.Unit)
	end)
end)
--guid for special reason
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements
NPA.NamePlateModuleManager.RegisterDataModule("Text","GUID",function(framedata,textframe)
	textframe:Show()
	NPA_TextManager_SetText(textframe,nil)
	--add event elements
	NPA_NamePlateDataParser_AddElements(framedata,textframe,"UnitID_Updated",function(framedata)
		NPA_TextManager_SetText(textframe,framedata.GUID)
	end)
end)