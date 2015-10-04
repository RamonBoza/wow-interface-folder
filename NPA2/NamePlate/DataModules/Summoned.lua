-- Author      : Nogarder
-- Create Date : 2013/4/17 13:46:53
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements
local NPA_SpellInfo_GetSpellInfo=NPA.SpellInfo.GetSpellInfo
NPA.NamePlateModuleManager.RegisterDataModule("Icon","Summoned",function(framedata,textureframe,setting)
	--add event elements
 	--name update
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"Summoned_Updated",function(framedata,unitdata)
		if(unitdata.SummonedBy)then
			textureframe:Show()
			local texture=NPA_SpellInfo_GetSpellInfo(unitdata.SummonedBy).Icon
			textureframe.Icon:SetTexCoord(0,1,0,1)
			textureframe.Icon:SetTexture(texture)
		else
			textureframe:Hide()
		end
	end)
end)
