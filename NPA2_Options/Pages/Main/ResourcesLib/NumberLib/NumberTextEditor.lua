-- Author      : Nogarder
-- Create Date : 2012/7/17 12:26:01
NPA_Options.RegisterPageFunc("NumberTextEditor",function()

	local floor=floor
	local pairs=pairs
	local table_insert=table.insert
	local table_getn=table.getn
	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesWindowNumberTextEditor
	local Tooltips=Localization.Tooltips
	--
	local Entry
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["TextEdit"],210,305,nil,nil,nil)
	main:Hide()
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
	local fontselector=NPA_Options.Template.CreateFontEditorButton(page,main,160)
	fontselector:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,step)
	--color
	local GetColorMode=function()
		return main.ColorModeList
	end
	local colormodeselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["ColorMode"],nil,GetColorMode)
	colormodeselector:SetPoint("TOPLEFT",fontselector,"BOTTOMLEFT",0,step)
	--custom color button
	local colorbutton=NPA_Options.Template.CreateColorButton(page,200,20,Localization["CustomColor"],main)
	colorbutton:SetPoint("TOPLEFT",colormodeselector,"BOTTOMLEFT",0,step)
	--sizeslider
	local sizeslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,40,1,0,Localization["Size"],Tooltips["Size"])
	sizeslider:SetPoint("TOPLEFT",colorbutton,"BOTTOMLEFT",0,step)
	--limit width
	local widthslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,200,1,0,Localization["Width"],Tooltips["Width"])
	widthslider:SetPoint("TOPLEFT",sizeslider,"BOTTOMLEFT",0,step)
	--checkbox
	local decimalchecker=NPA_Options.Template.CreateCheckBox(page,200,20,Localization["Decimal"])
	NPA_Options.Template.SetTooltips(Tooltips["Decimal"],decimalchecker)
	decimalchecker:SetPoint("TOPLEFT",widthslider,"BOTTOMLEFT",0,step)
	--preview
	local previewtext=NPA_Options.Template.CreateText(page,Localization["TestText"])
	previewtext:SetPoint("TOPLEFT",decimalchecker,"BOTTOMLEFT",0,step)
	--script
	local RefreshPreview=function()
		NPA_Options.HideTemplates()
		--
		if(colormodeselector.Value==0)then
			colorbutton:SetAlpha(1)
			NPA_Options.Template.EnableColorButton(colorbutton)
		else
			colorbutton:SetAlpha(0.5)
			NPA_Options.Template.DisableColorButton(colorbutton)
		end
		--
		previewtext:SetHeight(sizeslider.Value)	
		previewtext:SetWidth(widthslider.Value)
		if(colormodeselector.Value==0)then
			NPA_Options.SetTextFont(previewtext,nil,fontselector.Value,sizeslider.Value,colorbutton.Value)
		else
			NPA_Options.SetTextFont(previewtext,nil,fontselector.Value,sizeslider.Value)
		end
	end
	--
	local LoadData=function(default)
		local entry
		if(default)then
			entry=NPA.SettingManager.GetDefault("NamePlateAppearance")[main.MasterKey][main.SubKey]
		else
			entry=Entry
		end
		--font
		local value=entry.ProfileName
		NPA_Options.Template.SetDropDownEditor(fontselector,value)
		--color mode
		local value=entry.ColorMode
		NPA_Options.Template.SetDropDownEditor(colormodeselector,value)
		--custom color
		local value=entry.Color
		NPA_Options.Template.SetColorButton(colorbutton,value)
		--size
		local value=entry.Height
		NPA_Options.Template.SetSliderEdit(sizeslider,value)
		--width
		local value=entry.Width
		NPA_Options.Template.SetSliderEdit(widthslider,value)
		--
		local value=entry.Decimal
		NPA_Options.Template.SetCheckBox(decimalchecker,value)
		--
		RefreshPreview()
	end
	local SaveData=function()
		local entry=Entry
		--font
		entry.ProfileName=fontselector.Value
		--color mode
		entry.ColorMode=colormodeselector.Value
		--customcolor
		entry.Color=CopyTable(colorbutton.Value)
		--size
		entry.Height=sizeslider.Value
		--width
		entry.Width=widthslider.Value
		--
		entry.Decimal=decimalchecker.Checked
		--
		NPA_Options.RunFunc(main.OnValueUpdateFunc)
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
	--
	fontselector.OnValueUpdateFunc=RefreshPreview
	colormodeselector.OnValueUpdateFunc=RefreshPreview
	sizeslider.OnValueUpdateFunc=RefreshPreview
	widthslider.OnValueUpdateFunc=RefreshPreview
	decimalchecker.OnValueUpdateFunc=RefreshPreview
	--
	local CheckColorModeList=function(list,value)
		for i=1,table_getn(list)do
			if(list[i].Value==value)then
				return true
			end
		end
	end
	--
	main.OnSetFunc=function(entry,onvalueupdatefunc,colormodelist)
		Entry=entry
		main.OnValueUpdateFunc=onvalueupdatefunc
		local colormodelist=colormodelist or {}
		main.ColorModeList=colormodelist
		--check for default
		local checked=CheckColorModeList(colormodelist,0)
		if(not checked)then
			table_insert(main.ColorModeList,{
				Text=Localization["Custom"],
				Value=0,
			})
		end
		local checked=CheckColorModeList(colormodelist,1)
		if(not checked)then
			table_insert(main.ColorModeList,{
				Text=Localization["ByFontSetting"],
				Value=1
			})
		end
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("NumberTextEditor",main)

end)