-- Author      : Nogarder
-- Create Date : 2012/12/14 11:53:17
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements
local NPA_Color_GetColorByLevel=NPA.Color.GetColorByLevel

local NPA_TextManager_SetText=NPA.TextManager.SetText
local NPA_TextManager_SetTextColor=NPA.TextManager.SetTextColor
local NPA_TextManager_SetTextColor2=NPA.TextManager.SetTextColor2

NPA.NamePlateModuleManager.RegisterDataModule("Text","Level",function(framedata,textframe,setting)
	--add event elements
 	--hook name update
	local colormode=setting.ColorMode
	NPA_NamePlateDataParser_AddElements(framedata,textframe,"Level_Updated",function(framedata,unitdata)
		textframe:Show()
		NPA_TextManager_SetText(textframe,unitdata.Level)
		if(colormode==8)then
			local color=NPA_Color_GetColorByLevel(unitdata.Level)
			NPA_TextManager_SetTextColor(textframe,color)
		end
	end)
	if(colormode==4)then
		NPA_NamePlateDataParser_AddElements(framedata,textframe,"DefaultMain_OnUpdate",function(framedata,unitdata)
			if(framedata.Default)then
				NPA_TextManager_SetTextColor2(textframe,framedata.Default.LevelText:GetTextColor())
			end
		end)
	end
end)