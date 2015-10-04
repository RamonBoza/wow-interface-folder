-- Author      : Nogarder
-- Create Date : 2012/12/29 13:00:54
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements
local NPA_TextureManager_ManageTexture2=NPA.TextureManager.ManageTexture2
NPA.NamePlateModuleManager.RegisterDataModule("Icon","Class",function(framedata,textureframe,setting)
	--add event elements
 	--name update
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"Type_Updated",function(framedata,unitdata)
		if(unitdata.Type==1 and unitdata.Class and NPA_Setting.Class[unitdata.Class])then
			textureframe:Show()
			local texturename=NPA_Setting.Class[unitdata.Class].ProfileName
			NPA_TextureManager_ManageTexture2(textureframe.Icon,texturename)
		else
			textureframe:Hide()
		end
	end)
end)
