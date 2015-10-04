-- Author      : Nogarder
-- Create Date : 2014/11/22 17:01:54

local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements

local NPA_NumberManager_SetNumber=NPA.NumberManager.SetNumber
local NPA_NumberManager_SetNumberColor=NPA.NumberManager.SetNumberColor

local NPA_BarManager_SetBarGroupColor=NPA.BarManager.SetBarGroupColor
local NPA_BarManager_SetBarGroup=NPA.BarManager.SetBarGroup
--
NPA.NamePlateModuleManager.RegisterDataModule("BarGroup","Shield",function(framedata,bargroupframe,setting)
	--add event elements
 	--hook name update
	NPA_NamePlateDataParser_AddElements(framedata,bargroupframe,"Shield_Updated",function(framedata,unitdata)
		if(unitdata.Shield and unitdata.Shield>1)then
			bargroupframe:Show()
			--
			if(not unitdata.ShieldMax)then
				unitdata.ShieldMax=unitdata.HealthMax or 1
			else
				if(unitdata.ShieldMax<unitdata.Shield)then
					unitdata.ShieldMax=unitdata.Shield
				else
					unitdata.ShieldMax=unitdata.HealthMax or 1
				end
			end	
			--
			NPA_BarManager_SetBarGroup(bargroupframe,unitdata.Shield/unitdata.ShieldMax)
		else
			bargroupframe:Hide()
		end
	end)
end)
NPA.NamePlateModuleManager.RegisterDataModule("Number","Shield",function(framedata,numberframe,setting)
	--add event elements
 	--hook name update
	NPA_NamePlateDataParser_AddElements(framedata,numberframe,"Shield_Updated",function(framedata,unitdata)
		if(unitdata.Shield and unitdata.Shield>1)then
			numberframe:Show()
			--
			if(not unitdata.ShieldMax)then
				unitdata.ShieldMax=unitdata.HealthMax or 1
			else
				if(unitdata.ShieldMax<unitdata.Shield)then
					unitdata.ShieldMax=unitdata.Shield
				else
					unitdata.ShieldMax=unitdata.HealthMax or 1
				end
			end	
			--
			NPA_NumberManager_SetNumber(numberframe,unitdata.Shield,unitdata.ShieldMax)
		else
			numberframe:Hide()
		end
	end)
end)
--
NPA.NamePlateModuleManager.RegisterDataModule("TextureGroup","Shield",function(framedata,textureframe,setting)
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"Shield_Updated",function(framedata,unitdata)
		if(unitdata.Shield and unitdata.Shield>1)then
			textureframe:Show()
		else
			textureframe:Hide()
		end
	end)
end)