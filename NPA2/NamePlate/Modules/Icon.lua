-- Author      : Nogarder
-- Create Date : 2012/12/29 13:00:45
local pairs=pairs
local table_getn=table.getn
--
local NPA_NamePlateDataParser_RemoveElements=NPA.NamePlateDataParser.RemoveElements

local NPA_FrameMacro_ResetFrameTimer=NPA.FrameMacro.ResetFrameTimer

--
local NPA_Icon_CreateIconFrame=function(modulemain)
	--
	local frame=CreateFrame("Frame",nil,modulemain)
	frame:SetWidth(1)
	frame:SetHeight(1)
	frame:EnableMouse(false)
	--
	local texture=frame:CreateTexture()
	texture:SetPoint("CENTER",frame,"CENTER")
	frame.Icon=texture
	--
	return frame
end
--
NPA.NamePlateModuleManager.RegisterModule("Icon",function(framedata,profile,modulemain,funclist,framegroup)
	local group=modulemain["Icon"]
	local i=1
	--
	if(profile)then
		for name,setting in pairs(profile.IconSetting)do
			if(not group[i])then
				group[i]=NPA_Icon_CreateIconFrame(modulemain)
				group[i]:HookScript("OnShow",NPA.NamePlateModuleManager.ModuleOnShow)
				group[i]:HookScript("OnHide",NPA.NamePlateModuleManager.ModuleOnHide)
			end
			local textureframe=group[i]
			textureframe:Show()
			--set up icon
			local icon=textureframe.Icon
			icon:SetDrawLayer(setting.Layer)
			--set up frame size
			textureframe:SetWidth(setting.Width)
			textureframe:SetHeight(setting.Height)
			--using this to prevent a very strange bug that the texture doesn't resize with frame
			icon:SetWidth(setting.Width)
			icon:SetHeight(setting.Height)
			--remove old elements
			NPA_FrameMacro_ResetFrameTimer(textureframe)
			NPA_NamePlateDataParser_RemoveElements(framedata,textureframe)
			--register update event to data parser
			local funclist2=funclist[setting.DataType]
			if(funclist2)then
				funclist2(framedata,textureframe,setting)
			end
			--show/hide controls in data function textureframe:Show()
			--set framelevel
			textureframe:SetFrameLevel(setting.FrameLevel+textureframe:GetParent():GetFrameLevel())
			--set alpha
			textureframe:SetAlpha(setting.Alpha)
			--set scale
			textureframe:SetScale(setting.Scale)
			--register in framegroup for anchor management
			framegroup[name.."Icon"]={
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