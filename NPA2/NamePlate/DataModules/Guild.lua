-- Author      : Nogarder
-- Create Date : 2013/8/14 13:26:24
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements
local NPA_TextManager_SetText=NPA.TextManager.SetText

NPA.NamePlateModuleManager.RegisterDataModule("Text","Guild",function(framedata,textframe,setting)
	--add event elements
 	--hook name update
	NPA_NamePlateDataParser_AddElements(framedata,textframe,"Guild_Updated",function(framedata,unitdata)
		if(unitdata.Guild)then
			textframe:Show()
			NPA_TextManager_SetText(textframe,unitdata.Guild)
		else
			textframe:Hide()
		end
	end)
end)