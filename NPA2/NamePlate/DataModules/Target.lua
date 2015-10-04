-- Author      : Nogarder
-- Create Date : 2013/4/7 10:23:43
local NPA_Color_GetColorByFaction=NPA.Color.GetColorByFaction
local NPA_Color_GetColorByClass=NPA.Color.GetColorByClass
local NPA_Color_GetColorByThreat=NPA.Color.GetColorByThreat
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements

local NPA_DataCollector_GetUnitDataByGUID=NPA.DataCollector.GetUnitDataByGUID

local NPA_FrameMacro_SetFrameTimer=NPA.FrameMacro.SetFrameTimer

local NPA_TextManager_SetText=NPA.TextManager.SetText
local NPA_TextManager_SetTextColor2=NPA.TextManager.SetTextColor2

local UnitGUID=UnitGUID
--
NPA.NamePlateModuleManager.RegisterDataModule("Text","Target",function(framedata,textframe,setting)
	--add event elements
 	--hook name update
	local colormode=setting.ColorMode
	--
	local ColorFunc
	--
	if(colormode==1)then --color by faction
		ColorFunc=function(text,unitdata)
			local color=NPA_Color_GetColorByFaction(unitdata.Faction)
			text:SetTextColor(color.R,color.G,color.B,color.A)
		end
	elseif(colormode==2)then --color by class
		ColorFunc=function(text,unitdata)
			local color=NPA_Color_GetColorByClass(unitdata.Class,unitdata.Type)
			text:SetTextColor(color.R,color.G,color.B,color.A)
		end
	elseif(colormode==3)then --color by threat
		ColorFunc=function(text,unitdata)
			local color=NPA_Color_GetColorByThreat(unitdata.ThreatStatus)
			text:SetTextColor(color.R,color.G,color.B,color.A)
		end
	else
		ColorFunc=function()
		end
	end
	--using settings
	local You=NPA_Setting.SelfLib.Text
	local YouColor=NPA_Setting.SelfLib.Color
	if(You==nil or You=="")then
		You=UnitName("player")
		YouColor=nil
	end
	--
	NPA_NamePlateDataParser_AddElements(framedata,textframe,"Target_Updated",function(framedata,unitdata)
		if(unitdata.TargetUpdated and unitdata.TargetGUID)then
			local targetguid=unitdata.TargetGUID
			--show it
			textframe:Show()
			local targetunitdata=NPA_DataCollector_GetUnitDataByGUID(targetguid)
			if(targetguid==UnitGUID("player"))then
				NPA_TextManager_SetText(textframe,You)
				--color
				if(YouColor)then
					NPA_TextManager_SetTextColor2(textframe,YouColor.R,YouColor.G,YouColor.B,YouColor.A)
				else
					ColorFunc(textframe.Text,targetunitdata)
				end
			elseif(targetunitdata)then
				NPA_TextManager_SetText(textframe,"=>>"..(targetunitdata.Name or "Unknow").."<<=")
				--color
				ColorFunc(textframe.Text,targetunitdata)
			else --should not happen ,but just in case
				NPA_TextManager_SetText(textframe,"=>>Unknow<<=")
			end
			--set timer, hide after 1s
			NPA_FrameMacro_SetFrameTimer(textframe,unitdata.TargetUpdated,unitdata.TargetUpdated+1,
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
NPA.NamePlateModuleManager.RegisterDataModule("TextureGroup","Target",function(framedata,textureframe,setting)
	--add event elements
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"ModuleMain_OnUpdate",function(framedata)
		if(UnitExists("target") and framedata.GUID==UnitGUID("target"))then
			--show it
			textureframe:Show()
		else
			textureframe:Hide()
		end
	end)
end)