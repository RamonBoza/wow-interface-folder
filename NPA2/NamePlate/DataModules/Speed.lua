-- Author      : Nogarder
-- Create Date : 2013/7/16 13:03:25
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements

local NPA_FrameMacro_SetFrameTimer=NPA.FrameMacro.SetFrameTimer

local NPA_NumberManager_SetNumber=NPA.NumberManager.SetNumber
local NPA_NumberManager_SetNumberColor=NPA.NumberManager.SetNumberColor

local NPA_BarManager_SetBarGroupColor=NPA.BarManager.SetBarGroupColor
local NPA_BarManager_SetBarGroup=NPA.BarManager.SetBarGroup
--
NPA.NamePlateModuleManager.RegisterDataModule("BarGroup","Speed",function(framedata,bargroupframe,setting)
	--add event elements
 	--hook name update
	NPA_NamePlateDataParser_AddElements(framedata,bargroupframe,"Speed_Updated",function(framedata,unitdata)
		if(unitdata.SpeedUpdated and unitdata.Speed~=0)then
			bargroupframe:Show()
			NPA_BarManager_SetBarGroup(bargroupframe,unitdata.Speed/7)
			--set timer
			NPA_FrameMacro_SetFrameTimer(bargroupframe,unitdata.SpeedUpdated,unitdata.SpeedUpdated+1,
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
NPA.NamePlateModuleManager.RegisterDataModule("Number","Speed",function(framedata,numberframe,setting)
	--add event elements
 	--hook name update
	NPA_NamePlateDataParser_AddElements(framedata,numberframe,"Speed_Updated",function(framedata,unitdata)
		if(unitdata.SpeedUpdated and unitdata.Speed~=0)then
			numberframe:Show()
			NPA_NumberManager_SetNumber(numberframe,unitdata.Speed,7)
			--set timer
			NPA_FrameMacro_SetFrameTimer(numberframe,unitdata.SpeedUpdated,unitdata.SpeedUpdated+1,
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
NPA.NamePlateModuleManager.RegisterDataModule("TextureGroup","Speed",function(framedata,textureframe,setting)
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"Speed_Updated",function(framedata,unitdata)
		if(unitdata.SpeedUpdated and unitdata.Speed~=0)then
			textureframe:Show()
			--set timer
			NPA_FrameMacro_SetFrameTimer(textureframe,unitdata.SpeedUpdated,unitdata.SpeedUpdated+1,
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