-- Author      : Nogarder
-- Create Date : 2013/4/7 17:06:02
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements
local NPA_Color_GetColorByLevel=NPA.Color.GetColorByLevel

local NPA_BarManager_SetBarGroupColor=NPA.BarManager.SetBarGroupColor
local NPA_BarManager_SetBarGroup=NPA.BarManager.SetBarGroup

local NPA_NumberManager_SetNumber=NPA.NumberManager.SetNumber
local NPA_NumberManager_SetNumberColor=NPA.NumberManager.SetNumberColor

local NPA_TextManager_SetText=NPA.TextManager.SetText
local NPA_TextManager_SetTextColor2=NPA.TextManager.SetTextColor2

NPA.NamePlateModuleManager.RegisterDataModule("Text","Quest",function(framedata,textframe,setting)
	--add event elements
 	--hook name update
	local colormode=setting.ColorMode
	NPA_NamePlateDataParser_AddElements(framedata,textframe,"Quest_Updated",function(framedata)
		local data=framedata.QuestData
		if(data)then
			textframe:Show()
			NPA_TextManager_SetText(textframe,data.Name)
			if(colormode==8)then
				local color=NPA_Color_GetColorByLevel(data.Level)
				NPA_TextManager_SetTextColor2(textframe,color.R,color.G,color.B,color.A)
			end
		else
			textframe:Hide()
		end
	end)
	--placeholder
end)
NPA.NamePlateModuleManager.RegisterDataModule("Number","Quest",function(framedata,numberframe,setting)
	--add event elements
 	--hook name update
	local colormode=setting.ColorMode
	NPA_NamePlateDataParser_AddElements(framedata,numberframe,"Quest_Updated",function(framedata)
		local data=framedata.QuestData
		if(data and data.Current)then
			numberframe:Show()
			NPA_NumberManager_SetNumber(numberframe,data.Current or 0,data.Max or 1)
			if(colormode==8)then
				local color=NPA_Color_GetColorByLevel(data.Level)
				NPA_NumberManager_SetNumberColor(numberframe,color)
			end
		else
			numberframe:Hide()
		end
	end)
end)

NPA.NamePlateModuleManager.RegisterDataModule("BarGroup","Quest",function(framedata,bargroupframe,setting)
	--add event elements
 	--name update
	local colormode=setting.ColorMode
	NPA_NamePlateDataParser_AddElements(framedata,bargroupframe,"Quest_Updated",function(framedata)
		local data=framedata.QuestData
		if(data and data.Current)then
			--show it
			bargroupframe:Show()
			NPA_BarManager_SetBarGroup(bargroupframe,data.Current/(data.Max or 1))
			if(colormode==5)then 
				if(castinfo and castinfo.EndTime)then
					local color=NPA_Color_GetColorByLevel(data.Level)
					NPA_BarManager_SetBarGroupColor(bargroupframe,color)
				end
			end
		else
			bargroupframe:Hide()
		end
	end)
end)
--
NPA.NamePlateModuleManager.RegisterDataModule("TextureGroup","Quest",function(framedata,textureframe,setting)
	--add event elements
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"Quest_Updated",function(framedata)
		local data=framedata.QuestData
		if(data)then
			textureframe:Show()
		else
			textureframe:Hide()
		end
	end)
end)