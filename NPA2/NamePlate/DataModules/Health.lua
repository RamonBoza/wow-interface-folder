-- Author      : Nogarder
-- Create Date : 2012/12/27 15:36:24
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements

local NPA_Color_GetColorByFaction=NPA.Color.GetColorByFaction
local NPA_Color_GetColorByClass=NPA.Color.GetColorByClass
local NPA_Color_GetColorByThreat=NPA.Color.GetColorByThreat

local NPA_BarManager_SetBarGroupColor=NPA.BarManager.SetBarGroupColor
local NPA_BarManager_SetBarGroup=NPA.BarManager.SetBarGroup

local NPA_NumberManager_SetNumber=NPA.NumberManager.SetNumber
local NPA_NumberManager_SetNumberColor=NPA.NumberManager.SetNumberColor
--
NPA.NamePlateModuleManager.RegisterDataModule("BarGroup","Health",function(framedata,bargroupframe,setting)
	--add event elements
 	--hook name update
	NPA_NamePlateDataParser_AddElements(framedata,bargroupframe,"Health_Updated",function(framedata,unitdata)
		bargroupframe:Show()
		NPA_BarManager_SetBarGroup(bargroupframe,(unitdata.Health or 0)/(unitdata.HealthMax or 1))
	end)
	--color mode
	local colormode=setting.ColorMode
	if(colormode==1)then --color by faction
		--hook faction update
		NPA_NamePlateDataParser_AddElements(framedata,bargroupframe,"Type_Updated",function(framedata,unitdata)
			local color=NPA_Color_GetColorByFaction(unitdata.Faction)
			NPA_BarManager_SetBarGroupColor(bargroupframe,color)
		end)
	elseif(colormode==2)then --color by class
		--hook class update
		NPA_NamePlateDataParser_AddElements(framedata,bargroupframe,"Type_Updated",function(framedata,unitdata)
			local color,nomatch=NPA_Color_GetColorByClass(unitdata.Class,unitdata.Type)
			if(nomatch)then
				if(framedata.Default)then
					local r,g,b,a=framedata.Default.HealthBar:GetStatusBarColor()
					color={
						R=r,
						G=g,
						B=b,
						A=a
					}
				else
					color=NPA_Color_GetColorByFaction(unitdata.Faction)
				end
			end
			NPA_BarManager_SetBarGroupColor(bargroupframe,color)
		end)
	elseif(colormode==3)then --color by threat
		--hook threat update
		NPA_NamePlateDataParser_AddElements(framedata,bargroupframe,"Threat_Updated",function(framedata,unitdata)
			local color=NPA_Color_GetColorByThreat(unitdata.ThreatStatus)
			NPA_BarManager_SetBarGroupColor(bargroupframe,color)
		end)
	elseif(colormode==4 and framedata.Default)then
		NPA_NamePlateDataParser_AddElements(framedata,bargroupframe,"Type_Updated",function(framedata,unitdata)
			if(framedata.Default)then
				local r,g,b,a=framedata.Default.HealthBar:GetStatusBarColor()
				NPA_BarManager_SetBarGroupColor(bargroupframe,{R=r,G=g,B=b,A=a})
			end
		end)
	end
end)
--

NPA.NamePlateModuleManager.RegisterDataModule("Number","Health",function(framedata,numberframe,setting)
	--add event elements
 	--hook name update
	NPA_NamePlateDataParser_AddElements(framedata,numberframe,"Health_Updated",function(framedata)
		numberframe:Show()
		NPA_NumberManager_SetNumber(numberframe,framedata.UnitData.Health or 0,framedata.UnitData.HealthMax or 1)
		
	end)
	--color mode
	local colormode=setting.ColorMode
	if(colormode==1)then --color by faction
		--hook faction update
		NPA_NamePlateDataParser_AddElements(framedata,numberframe,"Type_Updated",function(framedata,unitdata)
			local color=NPA_Color_GetColorByFaction(unitdata.Faction)
			NPA_NumberManager_SetNumberColor(numberframe,color)
		end)
	elseif(colormode==2)then --color by class
		--hook class update
		NPA_NamePlateDataParser_AddElements(framedata,numberframe,"Type_Updated",function(framedata,unitdata)
			local color=NPA_Color_GetColorByClass(unitdata.Class,unitdata.Type)
			NPA_NumberManager_SetNumberColor(numberframe,color)
		end)
	elseif(colormode==3)then --color by threat
		--hook threat update
		NPA_NamePlateDataParser_AddElements(framedata,numberframe,"Threat_Updated",function(framedata,unitdata)
			local color=NPA_Color_GetColorByThreat(unitdata.ThreatStatus)
			NPA_NumberManager_SetNumberColor(numberframe,color)
		end)
	end
end)