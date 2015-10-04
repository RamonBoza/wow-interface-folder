-- Author      : Nogarder
-- Create Date : 2015/1/7 21:29:46
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements
local NPA_FrameMacro_SetFrameTimer=NPA.FrameMacro.SetFrameTimer

local NPA_TextManager_SetText=NPA.TextManager.SetText
local NPA_TextManager_SetTextColor2=NPA.TextManager.SetTextColor2
--
NPA.NamePlateModuleManager.RegisterDataModule("Text","Range",function(framedata,textframe,setting)
	--add event elements
	--using settings
	--
	NPA_NamePlateDataParser_AddElements(framedata,textframe,"Range_Updated",function(framedata,unitdata)
		local rangetext
		if(unitdata.RangeUpdated)then
			if(unitdata.Exact and unitdata.Exact~=0)then
				rangetext=unitdata.Exact
			elseif(unitdata.RangeClose and unitdata.RangeFar and (unitdata.RangeClose~=0 or unitdata.RangeFar~=0))then
				if(unitdata.RangeFar==100)then
					rangetext=unitdata.RangeClose.."-*"
				elseif(unitdata.RangeFar==unitdata.RangeClose)then
					rangetext=unitdata.RangeClose
				else
					rangetext=unitdata.RangeClose.."-"..unitdata.RangeFar
				end
			end
		end
		if(rangetext)then
			--show it
			textframe:Show()
			NPA_TextManager_SetText(textframe,rangetext)
			--set timer, hide after 1s
			NPA_FrameMacro_SetFrameTimer(textframe,unitdata.RangeUpdated,unitdata.RangeUpdated+1,
				function(nTime,data)
					--update alpha
					local percent=(data.EndTime-nTime)/data.Length
					textframe:SetAlpha(setting.Alpha*percent)
				end,
				function()
					--hide when time out
					textframe:Hide()
				end)
		else
			textframe:Hide()
		end
	end)
end)
--
NPA.NamePlateModuleManager.RegisterDataModule("TextureGroup","Range",function(framedata,textureframe,setting)
	--add event elements
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"ModuleMain_OnUpdate",function(framedata)
		if(unitdata.RangeUpdated)then
			--show it
			textureframe:Show()
		else
			textureframe:Hide()
		end
	end)
end)