-- Author      : Nogarder
-- Create Date : 2012/12/14 12:59:16
local pairs=pairs
local table_getn=table.getn
--
local NPA_TextureManager_ManageTextureGroup=NPA.TextureManager.ManageTextureGroup
local NPA_NamePlateDataParser_RemoveElements=NPA.NamePlateDataParser.RemoveElements
local NPA_TextureManager_CreateTextureGroup=NPA.TextureManager.CreateTextureGroup

local NPA_FrameMacro_ResetFrameTimer=NPA.FrameMacro.ResetFrameTimer
--
NPA.NamePlateModuleManager.RegisterModule("TextureGroup",function(framedata,profile,modulemain,funclist,framegroup)
	local group=modulemain["TextureGroup"]
	local i=1
	--
	if(profile)then
		for name,setting in pairs(profile.TextureGroupSetting)do
			if(not group[i])then
				group[i]=NPA_TextureManager_CreateTextureGroup(modulemain)
				group[i]:HookScript("OnShow",NPA.NamePlateModuleManager.ModuleOnShow)
				group[i]:HookScript("OnHide",NPA.NamePlateModuleManager.ModuleOnHide)
			end
			local textureframe=group[i]
			textureframe:Show()
			--
			NPA_TextureManager_ManageTextureGroup(textureframe,setting.TextureGroup)
			--texture group also have data type
			--remove old elements
			NPA_FrameMacro_ResetFrameTimer(textureframe)
			NPA_NamePlateDataParser_RemoveElements(framedata,textureframe)
			--register update event to data parser
			local funclist2=funclist[setting.DataType]
			if(funclist2)then
				funclist2(framedata,textureframe,setting)
			end
			--
			--set framelevel
			textureframe:SetFrameLevel(setting.FrameLevel+textureframe:GetParent():GetFrameLevel())
			--set alpha
			textureframe:SetAlpha(setting.Alpha)
			--set scale
			textureframe:SetScale(setting.Scale)
			--register in framegroup for anchor management
			framegroup[name.."TextureGroup"]={
				Frame=textureframe,
				AnchorFrame=setting.AnchorFrame,
				AnchorData=setting.FrameAnchorData
			}
			--
			i=i+1
		end
	end
	--hide extra if exists
	for j=i,table_getn(group)do
		--remove old elements
		NPA_FrameMacro_ResetFrameTimer(group[j])
		NPA_NamePlateDataParser_RemoveElements(framedata,group[j])
		--hide
		group[j]:Hide()
	end
end)