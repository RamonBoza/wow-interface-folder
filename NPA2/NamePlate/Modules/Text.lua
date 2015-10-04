-- Author      : Nogarder
-- Create Date : 2012/12/13 10:20:19
local pairs=pairs
local table_getn=table.getn
--
local NPA_FontManager_ManageFont=NPA.FontManager.ManageFont
local NPA_NamePlateDataParser_RemoveElements=NPA.NamePlateDataParser.RemoveElements

local NPA_FrameMacro_ResetFrameTimer=NPA.FrameMacro.ResetFrameTimer
--
NPA.NamePlateModuleManager.RegisterModule("Text",function(framedata,profile,modulemain,funclist,framegroup)
	local group=modulemain["Text"]
	local i=1
	--
	if(profile)then
		for name,setting in pairs(profile.TextSetting)do
			if(not group[i])then
				group[i]=NPA.TextManager.CreateTextFrame(modulemain)
				group[i]:HookScript("OnShow",NPA.NamePlateModuleManager.ModuleOnShow)
				group[i]:HookScript("OnHide",NPA.NamePlateModuleManager.ModuleOnHide)
			end
			local textframe=group[i]
			textframe:Show()
			--
			NPA_FontManager_ManageFont(textframe.Text,setting)
			--remove old elements
			NPA_FrameMacro_ResetFrameTimer(textframe)
			NPA_NamePlateDataParser_RemoveElements(framedata,textframe)
			--register update event to data parser
			local funclist2=funclist[setting.DataType]
			if(funclist2)then
				funclist2(framedata,textframe,setting)
			end
			--set framelevel
			textframe:SetFrameLevel(setting.FrameLevel+textframe:GetParent():GetFrameLevel())
			--set alpha
			textframe:SetAlpha(setting.Alpha)
			--set scale
			textframe:SetScale(setting.Scale)
			--register in framegroup for anchor management
			framegroup[name.."Text"]={
				Frame=textframe,
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