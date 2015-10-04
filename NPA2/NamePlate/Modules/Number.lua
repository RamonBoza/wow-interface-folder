-- Author      : Nogarder
-- Create Date : 2012/12/14 12:59:32
local pairs=pairs
local table_getn=table.getn
--
local NPA_NamePlateDataParser_RemoveElements=NPA.NamePlateDataParser.RemoveElements
local NPA_NumberManager_CreateNumber=NPA.NumberManager.CreateNumber
local NPA_NumberManager_ManageNumber=NPA.NumberManager.ManageNumber

local NPA_FrameMacro_ResetFrameTimer=NPA.FrameMacro.ResetFrameTimer

--
NPA.NamePlateModuleManager.RegisterModule("Number",function(framedata,profile,modulemain,funclist,framegroup)
	local group=modulemain["Number"]
	local i=1
	--
	if(profile)then
		for name,setting in pairs(profile.NumberSetting)do
			if(not group[i])then
				group[i]=NPA_NumberManager_CreateNumber(modulemain)
				group[i]:HookScript("OnShow",NPA.NamePlateModuleManager.ModuleOnShow)
				group[i]:HookScript("OnHide",NPA.NamePlateModuleManager.ModuleOnHide)
			end
			local numberframe=group[i]
			numberframe:Show()
			--
			NPA_NumberManager_ManageNumber(numberframe,setting)
			--remove old elements
			NPA_FrameMacro_ResetFrameTimer(numberframe)
			NPA_NamePlateDataParser_RemoveElements(framedata,numberframe)
			--register update event to data parser
			local funclist2=funclist[setting.DataType]
			if(funclist2)then
				funclist2(framedata,numberframe,setting)
			end
			--set framelevel
			numberframe:SetFrameLevel(setting.FrameLevel+numberframe:GetParent():GetFrameLevel())
			--set alpha
			numberframe:SetAlpha(setting.Alpha)
			--set alpha
			numberframe:SetScale(setting.Scale)
			--register in framegroup for anchor management
			framegroup[name.."Number"]={
				Frame=numberframe,
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