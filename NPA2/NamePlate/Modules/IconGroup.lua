-- Author      : Nogarder
-- Create Date : 2012/12/14 12:59:23
local pairs=pairs
local table_getn=table.getn
--
local NPA_IconGroupManager_ManageIconGroup=NPA.IconGroupManager.ManageIconGroup
local NPA_NamePlateDataParser_RemoveElements=NPA.NamePlateDataParser.RemoveElements
local NPA_IconGroupManager_CreateIconGroup=NPA.IconGroupManager.CreateIconGroup

local NPA_FrameMacro_ResetFrameTimer=NPA.FrameMacro.ResetFrameTimer
--
NPA.NamePlateModuleManager.RegisterModule("IconGroup",function(framedata,profile,modulemain,funclist,framegroup)
	local group=modulemain["IconGroup"]
	local i=1
	--
	if(profile)then
		for name,setting in pairs(profile.IconGroupSetting)do
			if(not group[i])then
				group[i]=NPA_IconGroupManager_CreateIconGroup(modulemain)
				group[i]:HookScript("OnShow",NPA.NamePlateModuleManager.ModuleOnShow)
				group[i]:HookScript("OnHide",NPA.NamePlateModuleManager.ModuleOnHide)
			end
			local icongroup=group[i]
			--init values
			icongroup.DivideCount=nil
			--
			NPA_IconGroupManager_ManageIconGroup(icongroup,setting)
			--texture group also have data type
			--remove old elements
			--don't reset timer, it has its own timer
			--NPA_FrameMacro_ResetFrameTimer(icongroup)
			NPA_NamePlateDataParser_RemoveElements(framedata,icongroup)
			--register update event to data parser
			local funclist2=funclist[setting.DataType]
			if(funclist2)then
				funclist2(framedata,icongroup,setting)
			end
			--start hidding
			icongroup:Hide()
			--set framelevel
			icongroup:SetFrameLevel(setting.FrameLevel+icongroup:GetParent():GetFrameLevel())
			--set alpha
			icongroup:SetAlpha(setting.Alpha)
			--set scale
			icongroup:SetScale(setting.Scale)
			--register in framegroup for anchor management
			framegroup[name.."IconGroup"]={
				Frame=icongroup,
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
		--don't reset timer, it has its own timer
		--NPA_FrameMacro_ResetFrameTimer(icongroup)
		NPA_NamePlateDataParser_RemoveElements(framedata,group[j])
		--hide
		group[j]:Hide()
	end
end)