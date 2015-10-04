-- Author      : Nogarder
-- Create Date : 2012/7/13 15:47:01
NPA_Options.RegisterPageFunc("FontEditor",function()

	local pairs=pairs
	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesWindowFontEditor
	local Tooltips=Localization.Tooltips
	--
	local EntryName
	--
	local parent=NPA_Options.MainFrame
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["FontEdit"],210,420,nil,nil,nil)
	main:Hide()
	local title=main.Scroll.Title
	local page=main.Frame
	--
	--elements
	local step=-20
	--save
	local savebutton=NPA_Options.Template.CreateSpecialButton(page,65,15,"Save")
	savebutton:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	--reset
	local resetbutton=NPA_Options.Template.CreateSpecialButton(page,65,15,"Reset")
	resetbutton:SetPoint("TOPRIGHT",page,"TOPRIGHT",-5,-5)
	--cancel
	local cancelbutton=NPA_Options.Template.CreateSpecialButton(page,65,15,"Cancel")
	cancelbutton:SetPoint("LEFT",savebutton,"RIGHT",5,0)
	cancelbutton:SetPoint("RIGHT",resetbutton,"LEFT",-5,0)
	--font
	local fontselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["NameOrPath"],Tooltips["MustExistWhenLoad"],NPA_Options.InfoLib.GetFont)
	fontselector:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,step)
	fontselector.FreeEdit=true
	--font mode
	local modeselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["RenderMode"],Tooltips["RenderMode"],NPA_Options.InfoLib.GetFontMode)
	modeselector:SetPoint("TOPLEFT",fontselector,"BOTTOMLEFT",0,step)
	--shadowxslider
	local shadowxslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,-10,10,1,0,Localization["ShadowOffsetX"],Tooltips["ShadowOffsetX"])
	shadowxslider:SetPoint("TOPLEFT",modeselector,"BOTTOMLEFT",0,step)
	--shadowyslider
	local shadowyslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,-10,10,1,0,Localization["ShadowOffsetY"],Tooltips["ShadowOffsetY"])
	shadowyslider:SetPoint("TOPLEFT",shadowxslider,"BOTTOMLEFT",0,step)
	--color
	local colorbutton=NPA_Options.Template.CreateColorButton(page,200,20,Localization["Color"],main,Tooltips["Color"])
	colorbutton:SetPoint("TOPLEFT",shadowyslider,"BOTTOMLEFT",0,step)
	--checkbox
	local colorchangechecker=NPA_Options.Template.CreateCheckBox(page,127,20,Localization["ColorChange"])
	NPA_Options.Template.SetTooltips(Tooltips["ColorChange"],colorchangechecker)
	colorchangechecker:SetPoint("TOPLEFT",colorbutton,"BOTTOMLEFT",0,step)
	local colorchangereverschecker=NPA_Options.Template.CreateCheckBox(page,67,20,Localization["ColorChangeRevers"])
	NPA_Options.Template.SetTooltips(Tooltips["ColorChangeRevers"],colorchangereverschecker)
	colorchangereverschecker:SetPoint("LEFT",colorchangechecker,"RIGHT",5,0)
	--color button 2
	local colorbutton2=NPA_Options.Template.CreateColorButton(page,200,20,Localization["ColorChangeEnd"],main,Tooltips["ColorChangeEnd"])
	colorbutton2:SetPoint("TOPLEFT",colorchangechecker,"BOTTOMLEFT",0,step)
	--colorchangestepslider
	local colorchangestepslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,10,1,0,Localization["ColorChangeStep"],Tooltips["ColorChangeStep"])
	colorchangestepslider:SetPoint("TOPLEFT",colorbutton2,"BOTTOMLEFT",0,step)
	--preview
	local previewbg=page:CreateTexture(nil,"BACKGROUND")
	previewbg:SetTexture(0,0,0,1)
	previewbg:SetPoint("TOPLEFT",colorchangestepslider,"BOTTOMLEFT",0,step)
	previewbg:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT",-5,5)
	local preview1=NPA_Options.Template.CreateText(page,Localization["PreviewText"])
	preview1:SetPoint("TOPLEFT",colorchangestepslider,"BOTTOMLEFT",5,step-5)
	local preview2=NPA_Options.Template.CreateText(page,Localization["PreviewText"])
	preview2:SetPoint("TOPLEFT",preview1,"BOTTOMLEFT",0,-5)
	--
	local TestString=Localization["PreviewText"]
	--function
	local RefreshPreview=function()
		local fontdata={
			Font=fontselector.Value,
			--mode
			Mode=modeselector.Value,
			--shadowxslider
			ShadowX=shadowxslider.Value,
			ShadowY=shadowyslider.Value,
			--color
			Color=CopyTable(colorbutton.Value),
			Color2=CopyTable(colorbutton2.Value),
			ColorChange=colorchangechecker.Checked,
			ColorChangeStep=colorchangestepslider.Value,
			ColorChangeRevers=colorchangereverschecker.Checked
		}

		NPA.FontManager.ManageFont4(preview1,fontdata,12)
		NPA.FontManager.ManageFont4(preview2,fontdata,20)
		NPA.FontManager.SetText(preview1,TestString)
		NPA.FontManager.SetText(preview2,TestString)
	end
	--
	local LoadData=function(default)
		title:SetText(Localization["FontEdit"]..EntryName)
		if(title:GetWidth()>200)then
			title:ClearAllPoints()
			title:SetPoint("BOTTOMLEFT",main.Frame.Scroll,"TOPLEFT",5,0)
		else
			title:ClearAllPoints()
			title:SetPoint("BOTTOM",main.Frame.Scroll,"TOP",0,0)
		end
		--page
		if(default)then
			entry=NPA.SettingManager.GetDefault("Font")["Default"]
		else
			entry=NPA_Setting.Font[EntryName]
		end
		--font
		local value=entry.Font
		NPA_Options.Template.SetDropDownEditor(fontselector,value)
		--mode
		local value=entry.Mode
		NPA_Options.Template.SetDropDownEditor(modeselector,value)
		--shadowxslider
		local value=entry.ShadowX
		NPA_Options.Template.SetSliderEdit(shadowxslider,value)
		local value=entry.ShadowY
		NPA_Options.Template.SetSliderEdit(shadowyslider,value)
		--color
		NPA_Options.Template.SetColorButton(colorbutton,entry.Color)
		NPA_Options.Template.SetColorButton(colorbutton2,entry.Color2)
		NPA_Options.Template.SetSliderEdit(colorchangestepslider,entry.ColorChangeStep)
		NPA_Options.Template.SetCheckBox(colorchangechecker,entry.ColorChange)
		NPA_Options.Template.SetCheckBox(colorchangereverschecker,entry.ColorChangeRevers)
		--
		RefreshPreview()
	end
	local SaveData=function()
		local entry=NPA_Setting.Font[EntryName]
		--font
		entry.Font=fontselector.Value
		--mode
		entry.Mode=modeselector.Value
		--shadowxslider
		entry.ShadowX=shadowxslider.Value
		entry.ShadowY=shadowyslider.Value
		--color
		entry.Color=CopyTable(colorbutton.Value)
		entry.Color2=CopyTable(colorbutton2.Value)
		entry.ColorChange=colorchangechecker.Checked
		entry.ColorChangeStep=colorchangestepslider.Value
		entry.ColorChangeRevers=colorchangereverschecker.Checked
		--fire event
		NPA.EventHandler.FireEvent(6,"Resources_ProfileRefresh")
		--
		NPA_Options.RunFunc(main.RefreshFunc)
	end
	--
	savebutton:HookScript("OnMouseUp",function()
		NPA_Options.Animation.ShowFrame(main)
		SaveData()
	end)
	cancelbutton:HookScript("OnMouseUp",function()
		NPA_Options.Animation.ShowFrame(main)
		LoadData()
	end)
	resetbutton:HookScript("OnMouseUp",function()
		NPA_Options.Animation.ShowFrame(main)
		LoadData(true)
	end)
	--
	fontselector.OnValueUpdateFunc=RefreshPreview
	modeselector.OnValueUpdateFunc=RefreshPreview
	shadowxslider.OnValueUpdateFunc=RefreshPreview
	shadowyslider.OnValueUpdateFunc=RefreshPreview
	colorbutton.OnValueUpdateFunc=RefreshPreview
	colorbutton2.OnValueUpdateFunc=RefreshPreview
	colorchangechecker.OnValueUpdateFunc=RefreshPreview
	colorchangestepslider.OnValueUpdateFunc=RefreshPreview
	colorchangereverschecker.OnValueUpdateFunc=RefreshPreview
	--
	main.OnSetFunc=function(entryname,refreshfunc)
		EntryName=entryname
		main.RefreshFunc=refreshfunc
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("FontEditor",main)

end)