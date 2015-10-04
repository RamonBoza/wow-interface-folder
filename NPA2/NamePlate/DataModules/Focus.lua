-- Author      : Nogarder
-- Create Date : 2013/4/7 11:23:11
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements

local UnitGUID=UnitGUID

NPA.NamePlateModuleManager.RegisterDataModule("TextureGroup","Focus",function(framedata,textureframe,setting)
	--add event elements
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"ModuleMain_OnUpdate",function(framedata)
		--endtime==nil means casting is ended
		if(UnitExists("focus") and framedata.GUID==UnitGUID("focus"))then
			--show it
			textureframe:Show()
		else
			textureframe:Hide()
		end
	end)
end)