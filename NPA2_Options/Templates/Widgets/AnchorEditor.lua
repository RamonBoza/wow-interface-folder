-- Author      : Nogarder
-- Create Date : 2012/7/18 7:50:00
NPA_Options.RegisterPageFunc("AnchorEditor",function()

	local pairs=pairs
	local abs=abs
	--
	local Localization=NPA_Options.Localization.TemplatesWindowAnchorEditor
	local Tooltips=Localization.Tooltips
	--variables
	local Entry
	--
	local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["AnchorEdit"],210,290,nil,nil,nil)
	main:Hide()
	local page=main.Frame
	--
	--elements
	local step=-20
	--self anchor
	local selfanchorselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["SelfAnchor"],Tooltips["SelfAnchor"],NPA_Options.InfoLib.GetAnchor)
	selfanchorselector:SetPoint("TOPLEFT",page,"TOPLEFT",5,-15)
	--to anchor
	local toanchorselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["ToAnchor"],Tooltips["ToAnchor"],NPA_Options.InfoLib.GetAnchor)
	toanchorselector:SetPoint("TOPLEFT",selfanchorselector,"BOTTOMLEFT",0,step)
	--offsetxslider
	local offsetxslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,-40,40,1,0,Localization["OffsetX"],Tooltips["OffsetX"])
	offsetxslider:SetPoint("TOPLEFT",toanchorselector,"BOTTOMLEFT",0,step)
	--offsetyslider
	local offsetyslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,-40,40,1,0,Localization["OffsetY"],Tooltips["OffsetY"])
	offsetyslider:SetPoint("TOPLEFT",offsetxslider,"BOTTOMLEFT",0,step)
	--preview
	local previewframe=NPA_Options.Template.CreateAnchorPreview(page)
	previewframe:SetPoint("TOPLEFT",offsetyslider,"BOTTOMLEFT",0,-5)
	previewframe:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT",-5,5)
	--function
	local RefreshPreview=function()
		NPA_Options.Template.SetAnchorPreview(previewframe,selfanchorselector.Value,toanchorselector.Value,offsetxslider.Value,offsetyslider.Value)
		--
		local entry=Entry
		--self anchor
		entry.From=selfanchorselector.Value
		--to anchor
		entry.To=toanchorselector.Value
		--offset
		entry.OffsetX=offsetxslider.Value
		entry.OffsetY=offsetyslider.Value
		--run refresh
		NPA_Options.RunFunc(main.OnValueUpdateFunc)
	end
	--
	local LoadData=function(default)
		--page
		local entry
		if(default)then
			entry={
				From="CENTER",
				To="CENTER",
				OffsetX=0,
				OffsetY=0,
			}
		else
			entry=Entry
		end
		--self anchor
		local value=entry.From
		NPA_Options.Template.SetDropDownEditor(selfanchorselector,value)
		--to anchor
		local value=entry.To
		NPA_Options.Template.SetDropDownEditor(toanchorselector,value)
		--offset
		local value=entry.OffsetX
		NPA_Options.Template.SetSliderEdit(offsetxslider,value)
		local value=entry.OffsetY
		NPA_Options.Template.SetSliderEdit(offsetyslider,value)
		--
		RefreshPreview()
	end
	--
	selfanchorselector.OnValueUpdateFunc=RefreshPreview
	toanchorselector.OnValueUpdateFunc=RefreshPreview
	offsetxslider.OnValueUpdateFunc=RefreshPreview
	offsetyslider.OnValueUpdateFunc=RefreshPreview
	--on set function
	main.OnSetFunc=function(entry,onvalueupdatefunc,noanchorto,noanchorself)
		main.OnValueUpdateFunc=onvalueupdatefunc
		Entry=entry
		if(noanchorself)then
			NPA_Options.Template.DisableDropDownEditor(selfanchorselector)
		else
			NPA_Options.Template.EnableDropDownEditor(selfanchorselector)
		end
		if(noanchorto)then
			NPA_Options.Template.DisableDropDownEditor(toanchorselector)
		else
			NPA_Options.Template.EnableDropDownEditor(toanchorselector)
		end
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("AnchorEditor",main)

end)