-- Author      : Nogarder
-- Create Date : 2013/4/19 12:13:09
local tostring=tostring
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements
local NPA_TextureManager_ManageTexture2=NPA.TextureManager.ManageTexture2
NPA.NamePlateModuleManager.RegisterDataModule("Icon","RaidTarget",function(framedata,textureframe,setting)

	--add event elements
 	--name update
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"RaidTarget_Updated",function(framedata,unitdata)
		if(unitdata.RaidTarget)then
			local texturename=NPA_Setting.RaidTarget[tostring(unitdata.RaidTarget)]
			if(texturename)then
				textureframe:Show()
				NPA_TextureManager_ManageTexture2(textureframe.Icon,texturename)
			else
				textureframe:Hide()
			end
		else
			textureframe:Hide()
		end
	end)
end)
