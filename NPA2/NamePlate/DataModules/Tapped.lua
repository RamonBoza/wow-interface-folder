-- Author      : Nogarder
-- Create Date : 2013/7/17 22:29:50

local NPA_FrameMacro_SetFrameTimer=NPA.FrameMacro.SetFrameTimer
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements
--
NPA.NamePlateModuleManager.RegisterDataModule("TextureGroup","Tapped",function(framedata,textureframe,setting)
	textureframe:Hide()
	--add event elements
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"ModuleMain_OnUpdate",function(framedata)
		--endtime==nil means casting is ended
		if(framedata.UnitData.Tapped)then
			--show it
			textureframe:Show()
		else
			textureframe:Hide()
		end
	end)
end)