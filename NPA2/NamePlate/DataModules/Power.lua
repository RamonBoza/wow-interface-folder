-- Author      : Nogarder
-- Create Date : 2013/6/9 16:33:21
local NPA_Color_GetColorByPower=NPA.Color.GetColorByPower
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements

local NPA_FrameMacro_SetFrameTimer=NPA.FrameMacro.SetFrameTimer

local NPA_NumberManager_SetNumber=NPA.NumberManager.SetNumber
local NPA_NumberManager_SetNumberColor=NPA.NumberManager.SetNumberColor

local NPA_BarManager_SetBarGroupColor=NPA.BarManager.SetBarGroupColor
local NPA_BarManager_SetBarGroup=NPA.BarManager.SetBarGroup
--
NPA.NamePlateModuleManager.RegisterDataModule("BarGroup","Power",function(framedata,bargroupframe,setting)
	--add event elements
 	--hook name update
	NPA_NamePlateDataParser_AddElements(framedata,bargroupframe,"Power_Updated",function(framedata,unitdata)
		if(unitdata.PowerUpdated and unitdata.PowerMax~=0)then
			bargroupframe:Show()
			--
			NPA_BarManager_SetBarGroup(bargroupframe,(unitdata.Power or 0)/(unitdata.PowerMax or 1))
			if(setting.ColorMode==9)then
				local color=NPA_Color_GetColorByPower(unitdata.PowerType)
				NPA_BarManager_SetBarGroupColor(bargroupframe,color)
			end
			--set timer
			NPA_FrameMacro_SetFrameTimer(bargroupframe,unitdata.PowerUpdated,unitdata.PowerUpdated+1,
				function(nTime,data)
					--update alpha
					local percent=(data.EndTime-nTime)/data.Length
					bargroupframe:SetAlpha(setting.Alpha*percent)
				end,
				function()
					--hide when time out
					bargroupframe:Hide()
				end)
		else
			bargroupframe:Hide()
		end
	end)
end)
NPA.NamePlateModuleManager.RegisterDataModule("Number","Power",function(framedata,numberframe,setting)
	--add event elements
 	--hook name update
	NPA_NamePlateDataParser_AddElements(framedata,numberframe,"Power_Updated",function(framedata,unitdata)
		if(unitdata.PowerUpdated and unitdata.PowerMax~=0)then
			numberframe:Show()
			NPA_NumberManager_SetNumber(numberframe,unitdata.Power or 0,unitdata.PowerMax or 1)
			if(setting.ColorMode==9)then
				local color=NPA_Color_GetColorByPower(unitdata.PowerType)
				NPA_NumberManager_SetNumberColor(numberframe,color)
			end
			--set timer
			NPA_FrameMacro_SetFrameTimer(numberframe,unitdata.PowerUpdated,unitdata.PowerUpdated+1,
				function(nTime,data)
					--update alpha
					local percent=(data.EndTime-nTime)/data.Length
					numberframe:SetAlpha(setting.Alpha*percent)
				end,
				function()
					--hide when time out
					numberframe:Hide()
				end)
		else
			numberframe:Hide()
		end
	end)
end)
--
NPA.NamePlateModuleManager.RegisterDataModule("TextureGroup","Power",function(framedata,textureframe,setting)
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"Power_Updated",function(framedata,unitdata)
		if(unitdata.PowerUpdated and unitdata.PowerMax~=0)then
			textureframe:Show()
			--set timer
			NPA_FrameMacro_SetFrameTimer(textureframe,unitdata.PowerUpdated,unitdata.PowerUpdated+1,
				function(nTime,data)
					--update alpha
					local percent=(data.EndTime-nTime)/data.Length
					textureframe:SetAlpha(setting.Alpha*percent)
				end,
				function()
					--hide when time out
					textureframe:Hide()
				end)
		else
			textureframe:Hide()
		end
	end)
end)