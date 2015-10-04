-- Author      : Nogarder
-- Create Date : 2013/4/7 11:30:38
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements

local UnitGUID=UnitGUID
--3 = securely tanking, 2 = insecurely tanking
--1 = not tanking but higher threat than tank, 0 = not tanking and lower threat than tank
--4 or nil = no threat at all
NPA.NamePlateModuleManager.RegisterDataModule("TextureGroup","Threat_None",function(framedata,textureframe,setting)
	textureframe:Hide()
	--add event elements
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"Threat_Updated",function(framedata,unitdata)
		local unitdata=unitdata
		--endtime==nil means casting is ended
		if(unitdata.ThreatStatus==nil or unitdata.ThreatStatus==4)then
			--show it
			textureframe:Show()
		else
			textureframe:Hide()
		end
	end)
end)
--
NPA.NamePlateModuleManager.RegisterDataModule("TextureGroup","Threat_Low",function(framedata,textureframe,setting)
	textureframe:Hide()
	--add event elements
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"Threat_Updated",function(framedata,unitdata)
		local unitdata=unitdata
		--endtime==nil means casting is ended
		if(unitdata.ThreatStatus==0)then
			--show it
			textureframe:Show()
		else
			textureframe:Hide()
		end
	end)
end)
--
NPA.NamePlateModuleManager.RegisterDataModule("TextureGroup","Threat_High",function(framedata,textureframe,setting)
	textureframe:Hide()
	--add event elements
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"Threat_Updated",function(framedata,unitdata)
		local unitdata=unitdata
		--endtime==nil means casting is ended
		if(unitdata.ThreatStatus==1)then
			--show it
			textureframe:Show()
		else
			textureframe:Hide()
		end
	end)
end)
--
NPA.NamePlateModuleManager.RegisterDataModule("TextureGroup","Threat_Tanking",function(framedata,textureframe,setting)
	textureframe:Hide()
	--add event elements
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"Threat_Updated",function(framedata,unitdata)
		local unitdata=unitdata
		--endtime==nil means casting is ended
		if(unitdata.ThreatStatus==3)then
			--show it
			textureframe:Show()
		else
			textureframe:Hide()
		end
	end)
end)
--
NPA.NamePlateModuleManager.RegisterDataModule("TextureGroup","Threat_Losing",function(framedata,textureframe,setting)
	textureframe:Hide()
	--add event elements
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"Threat_Updated",function(framedata,unitdata)
		local unitdata=unitdata
		--endtime==nil means casting is ended
		if(unitdata.ThreatStatus==2)then
			--show it
			textureframe:Show()
		else
			textureframe:Hide()
		end
	end)
end)
