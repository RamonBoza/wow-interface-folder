-- Author      : Nogarder
-- Create Date : 2012/12/14 12:58:55
local pairs=pairs
local table_getn=table.getn
--
local NPA_BarManager_ManageBarGroup=NPA.BarManager.ManageBarGroup
local NPA_NamePlateDataParser_RemoveElements=NPA.NamePlateDataParser.RemoveElements
local NPA_BarManager_CreateBarGroup=NPA.BarManager.CreateBarGroup

local NPA_FrameMacro_ResetFrameTimer=NPA.FrameMacro.ResetFrameTimer
--
NPA.NamePlateModuleManager.RegisterModule("BarGroup",function(framedata,profile,modulemain,funclist,framegroup)
	local group=modulemain["BarGroup"]
	local i=1
	--
	if(profile)then
		for name,setting in pairs(profile.BarGroupSetting)do
			if(not group[i])then
				group[i]=NPA_BarManager_CreateBarGroup(modulemain)
				group[i]:HookScript("OnShow",NPA.NamePlateModuleManager.ModuleOnShow)
				group[i]:HookScript("OnHide",NPA.NamePlateModuleManager.ModuleOnHide)
			end
			local bargroupframe=group[i]
			bargroupframe:Show()
			--
			NPA_BarManager_ManageBarGroup(bargroupframe,setting)
			--remove old elements
			NPA_FrameMacro_ResetFrameTimer(bargroupframe)
			NPA_NamePlateDataParser_RemoveElements(framedata,bargroupframe)
			--register update event to data parser
			local funclist2=funclist[setting.DataType]
			if(funclist2)then
				funclist2(framedata,bargroupframe,setting)
			end
			--set framelevel
			bargroupframe:SetFrameLevel(setting.FrameLevel+bargroupframe:GetParent():GetFrameLevel())
			--set alpha
			bargroupframe:SetAlpha(setting.Alpha)
			--set scale
			bargroupframe:SetScale(setting.Scale)
			--register in framegroup for anchor management
			framegroup[name.."BarGroup"]={
				Frame=bargroupframe,
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