-- Author      : Nogarder
-- Create Date : 2013/4/27 15:30:44
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements

local UnitGUID=UnitGUID
--
NPA.NamePlateModuleManager.RegisterDataModule("TextureGroup","Classification_WorldBoss",function(framedata,textureframe,setting)
	textureframe:Hide()
	--add event elements
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"Classification_Updated",function(framedata,unitdata)
		local unitdata=unitdata
		--endtime==nil means casting is ended
		if(unitdata.Classification=="worldboss")then
			--show it
			textureframe:Show()
		else
			textureframe:Hide()
		end
	end)
end)
--
NPA.NamePlateModuleManager.RegisterDataModule("TextureGroup","Classification_Elite",function(framedata,textureframe,setting)
	textureframe:Hide()
	--add event elements
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"Classification_Updated",function(framedata,unitdata)
		local unitdata=unitdata
		--endtime==nil means casting is ended
		if(unitdata.Classification=="elite")then
			--show it
			textureframe:Show()
		else
			textureframe:Hide()
		end
	end)
end)
