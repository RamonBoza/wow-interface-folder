-- Author      : Nogarder
-- Create Date : 2013/9/14 8:57:51
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements

local NPA_TextManager_SetText=NPA.TextManager.SetText

NPA.NamePlateModuleManager.RegisterDataModule("Text","Server",function(framedata,textframe,setting)
	--add event elements
 	--hook name update
	NPA_NamePlateDataParser_AddElements(framedata,textframe,"Name_Updated",function(framedata,unitdata)
		if(unitdata.Server)then
			textframe:Show()
			NPA_TextManager_SetText(textframe,unitdata.Server)
		else
			textframe:Hide()
		end
	end)
end)