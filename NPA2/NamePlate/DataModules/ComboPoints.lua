-- Author      : Nogarder
-- Create Date : 2013/6/10 12:47:11
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements

local NPA_FrameMacro_SetFrameTimer=NPA.FrameMacro.SetFrameTimer

local NPA_NumberManager_SetNumber=NPA.NumberManager.SetNumber
local NPA_NumberManager_SetNumberColor=NPA.NumberManager.SetNumberColor

local NPA_BarManager_SetBarGroupColor=NPA.BarManager.SetBarGroupColor
local NPA_BarManager_SetBarGroup=NPA.BarManager.SetBarGroup

--
NPA.NamePlateModuleManager.RegisterDataModule("BarGroup","ComboPoints",function(framedata,bargroupframe,setting)
	--add event elements
 	--hook name update
	NPA_NamePlateDataParser_AddElements(framedata,bargroupframe,"ComboPoints_Updated",function(framedata,unitdata)
		if(unitdata.ComboPoints)then
			bargroupframe:Show()
			--using blizzard max_combo_points
			NPA_BarManager_SetBarGroup(bargroupframe,(unitdata.ComboPoints or 0)/(MAX_COMBO_POINTS))
		else
			bargroupframe:Hide()
		end
	end)
end)
NPA.NamePlateModuleManager.RegisterDataModule("Number","ComboPoints",function(framedata,numberframe,setting)
	--add event elements
 	--hook name update
	NPA_NamePlateDataParser_AddElements(framedata,numberframe,"ComboPoints_Updated",function(framedata,unitdata)
		if(unitdata.ComboPoints)then
			numberframe:Show()
			--prevent it to be zero
			NPA_NumberManager_SetNumber(numberframe,unitdata.ComboPoints or 0,MAX_COMBO_POINTS)
		else
			numberframe:Hide()
		end
	end)
end)
--
NPA.NamePlateModuleManager.RegisterDataModule("TextureGroup","ComboPoints",function(framedata,textureframe,setting)
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"ComboPoints_Updated",function(framedata,unitdata)
		if(unitdata.ComboPoints)then
			textureframe:Show()
		else
			textureframe:Hide()
		end
	end)
end)