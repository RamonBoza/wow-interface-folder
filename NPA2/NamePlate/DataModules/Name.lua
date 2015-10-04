-- Author      : Nogarder
-- Create Date : 2012/12/11 13:41:06
local NPA_Color_GetColorByFaction=NPA.Color.GetColorByFaction
local NPA_Color_GetColorByClass=NPA.Color.GetColorByClass
local NPA_Color_GetColorByThreat=NPA.Color.GetColorByThreat
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements

local NPA_TextManager_SetText=NPA.TextManager.SetText
local NPA_TextManager_SetTextColor=NPA.TextManager.SetTextColor
local NPA_TextManager_SetTextColor2=NPA.TextManager.SetTextColor2

NPA.NamePlateModuleManager.RegisterDataModule("Text","Name",function(framedata,textframe,setting)
	--add event elements
 	--hook name update
	NPA_NamePlateDataParser_AddElements(framedata,textframe,"Name_Updated",function(framedata,unitdata)
		textframe:Show()
		NPA_TextManager_SetText(textframe,unitdata.Name)
	end)
	--color mode
	local colormode=setting.ColorMode
	if(colormode==1)then --color by faction
		--hook faction update
		NPA_NamePlateDataParser_AddElements(framedata,textframe,"Type_Updated",function(framedata,unitdata)
			local color=NPA_Color_GetColorByFaction(unitdata.Faction)
			NPA_TextManager_SetTextColor(textframe,color)
		end)
	elseif(colormode==2)then --color by class
		--hook class update
		NPA_NamePlateDataParser_AddElements(framedata,textframe,"Type_Updated",function(framedata,unitdata)
			local color=NPA_Color_GetColorByClass(unitdata.Class,unitdata.Type)
			NPA_TextManager_SetTextColor(textframe,color)
		end)
	elseif(colormode==3)then --color by threat
		--hook threat update
		NPA_NamePlateDataParser_AddElements(framedata,textframe,"Threat_Updated",function(framedata,unitdata)
			local color=NPA_Color_GetColorByThreat(unitdata.ThreatStatus)
			NPA_TextManager_SetTextColor(textframe,color)
		end)
	elseif(colormode==4 and framedata.Default)then
		NPA_NamePlateDataParser_AddElements(framedata,textframe,"ModuleMain_OnUpdate",function(framedata,unitdata)
			local r,g,b,a=framedata.Default.NameText:GetTextColor()
			NPA_TextManager_SetTextColor2(textframe,framedata.Default.NameText:GetTextColor())
		end)
	end
end)