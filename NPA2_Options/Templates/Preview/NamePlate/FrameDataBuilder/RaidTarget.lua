-- Author      : Nogarder
-- Create Date : 2013/4/19 13:23:03
NPA_Options.RegisterPageFunc("NamePlatePreviewFrameDataRaidTarget",function()

	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	local Tooltips=Localization.Tooltips
	--
	local FrameData
	local RefreshFunc
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["RaidTarget"],200,50,nil)
	main:SetPoint("CENTER",UIParent,"CENTER",0,0)
	main:Hide()
	--
	local page=main.Frame
	--
	--raidtarget dropdown
	local GetRaidTarget=function()
		local data=NPA_Options.GetBasicTypeRaidTarget()
		local i=0
		local raidtarget={}
		for value,text in pairs(data)do
			i=i+1
			raidtarget[i]={
				Text=text,
				Value=value,
				ProfileName=NPA_Setting.RaidTarget[value]
			}
		end
		return raidtarget
	end
	local raidtargetselector=NPA_Options.Template.CreateDropDownEditor(page,190,Localization["RaidTarget"],nil,GetRaidTarget)
	raidtargetselector:SetPoint("TOPLEFT",page,"TOPLEFT",5,-15)
	raidtargetselector.OnValueUpdateFunc=function()
		FrameData.UnitData.RaidTarget=raidtargetselector.Value
		NPA.EventHandler.FireEvent(8,"RaidTarget_Updated",FrameData)
	end
	raidtargetselector.Revers=true
	--
	local OnLoad=function()
		NPA_Options.Template.SetDropDownEditor(raidtargetselector,FrameData.UnitData.RaidTarget)
	end
	--
	main.OnSetFunc=function(parentframe)
		FrameData=parentframe.FrameData
		OnLoad()
	end
	--
	NPA_Options.RegisterPage("NamePlatePreviewFrameDataRaidTarget",main)

end)