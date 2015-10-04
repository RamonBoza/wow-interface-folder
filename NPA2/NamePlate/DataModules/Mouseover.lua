-- Author      : Nogarder
-- Create Date : 2013/4/7 10:24:06
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements

local UnitGUID=UnitGUID

NPA.NamePlateModuleManager.RegisterDataModule("TextureGroup","Mouseover",function(framedata,textureframe,setting)
	--add event elements
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"ModuleMain_OnUpdate",function(framedata,unitdata)
		--endtime==nil means casting is ended
		if(UnitExists("mouseover") and framedata.GUID==UnitGUID("mouseover"))then
			--show it
			textureframe:Show()
		else
			textureframe:Hide()
		end
	end)
end)

