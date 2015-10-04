-- Author      : Nogarder
-- Create Date : 2013/12/11 20:18:09

local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements
local NPA_TextureManager_ManageTexture2=NPA.TextureManager.ManageTexture2
NPA.NamePlateModuleManager.RegisterDataModule("Icon","Role",function(framedata,textureframe,setting)
	--add event elements
 	--name update
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"Role_Updated",function(framedata,unitdata)
		if(unitdata.Type==1 and unitdata.Role and NPA_Setting.Role[unitdata.Role])then
			textureframe:Show()
			local texturename=NPA_Setting.Role[unitdata.Role]
			NPA_TextureManager_ManageTexture2(textureframe.Icon,texturename)
		else
			textureframe:Hide()
		end
	end)
end)
