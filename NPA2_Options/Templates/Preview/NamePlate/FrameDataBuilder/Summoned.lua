-- Author      : Nogarder
-- Create Date : 2013/4/17 13:54:53
NPA_Options.RegisterPageFunc("NamePlatePreviewFrameDataSummoned",function()

	local CopyTable=CopyTable
	local random=random
	local floor=floor
	local table_getn=table.getn
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	local Tooltips=Localization.Tooltips
	--
	local FrameData
	local RefreshFunc
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["Summoned"],210,140,nil)
	main:SetPoint("CENTER",UIParent,"CENTER",0,0)
	main:Hide()
	--
	local page=main.Frame
	--
	local width=200
	local step=-10
	--spellid slider
	local spellidslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,100000,1,0,Localization["SpellId"])
	spellidslider:SetPoint("TOPLEFT",page,"TOPLEFT",5,-20)
	NPA_Options.Template.SetSliderEdit(spellidslider,172)
	--icon preview
	local previewtexture=page:CreateTexture()
	previewtexture:SetWidth(40)
	previewtexture:SetHeight(40)
	previewtexture:SetPoint("TOPLEFT",spellidslider,"BOTTOMLEFT",0,step)
	previewtexture:SetTexture(NPA.SpellInfo.GetSpellInfo(172).Icon)
	--set button
	local setbutton=NPA_Options.Template.CreateButton(page,width,20,Localization["Set"])
	setbutton:SetPoint("TOPLEFT",previewtexture,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetTooltips(Tooltips["Set"],setbutton,nil,2)
	--
	setbutton:HookScript("OnMouseUp",function()
		FrameData.UnitData.SummonedBy=spellidslider.Value
		NPA.EventHandler.FireEvent(8,"Summoned_Updated",FrameData)
	end)
	--
	spellidslider.OnValueUpdateFunc=function()
		previewtexture:SetTexture(NPA.SpellInfo.GetSpellInfo(spellidslider.Value).Icon)
	end
	--
	main.OnSetFunc=function(parentframe)
		FrameData=parentframe.FrameData
	end
	--
	NPA_Options.RegisterPage("NamePlatePreviewFrameDataSummoned",main)
end)