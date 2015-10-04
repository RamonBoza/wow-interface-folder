-- Author      : Nogarder
-- Create Date : 2012/12/13 12:05:53
NPA_Options.RegisterPageFunc("NamePlateTextEditor",function()

	local pairs=pairs
	local CopyTable=CopyTable
	local table_insert=table.insert
	local table_getn=table.getn
	--
	local Localization=NPA_Options.Localization.PagesModueListTextEditor
	local Tooltips=Localization.Tooltips
	--
	local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["TextEdit"],210,640,nil,nil,nil)
	main:Hide()
	local page=main.Frame
	--
	--elements
	local step=-20
	local Entry
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
	--datatype
	local datatypeselector=NPA_Options.Template.CreateDataTypeList(page,200,"Text")
	datatypeselector:SetPoint("TOPLEFT",fontselector,"BOTTOMLEFT",0,step)
	--color
	local colormodeselector=NPA_Options.Template.CreateColorModeList(page,200,"Text",datatypeselector)
	colormodeselector:SetPoint("TOPLEFT",datatypeselector,"BOTTOMLEFT",0,step)
	--sizeslider
	local sizeslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,40,1,0,Localization["Size"],Tooltips["Size"])
	sizeslider:SetPoint("TOPLEFT",colormodeselector,"BOTTOMLEFT",0,step)
	--layer selector
	local layerselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["Layer"],Tooltips["Layer"],NPA_Options.InfoLib.GetLayer)
	layerselector:SetPoint("TOPLEFT",sizeslider,"BOTTOMLEFT",0,step)
	--limit width
	local widthslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,200,1,0,"Width")
	widthslider:SetPoint("TOPLEFT",layerselector,"BOTTOMLEFT",0,step)
	--anchor frame
	local anchorframeselector=NPA_Options.Template.CreateAnchorFrameList(page,200)
	anchorframeselector:SetPoint("TOPLEFT",widthslider,"BOTTOMLEFT",0,step)
	--framelevel
	local framelevelslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,255,1,0,"Layer",true)
	framelevelslider:SetPoint("TOPLEFT",anchorframeselector,"BOTTOMLEFT",0,step)
	--alpha slider
	local alphaslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,1,0.01,1,"Alpha",true)
	alphaslider:SetPoint("TOPLEFT",framelevelslider,"BOTTOMLEFT",0,step)
	--scale slider
	local scaleslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0.01,2,0.01,1,"Scale")
	scaleslider:SetPoint("TOPLEFT",alphaslider,"BOTTOMLEFT",0,step)
	--anchor editor
	local anchoreditbutton=NPA_Options.Template.CreateSpecialButton(page,200,20,"EditAnchor")
	anchoreditbutton.Value={}
	anchoreditbutton:SetPoint("TOPLEFT",scaleslider,"BOTTOMLEFT",0,step)
	--preview
	local previewframe=NPA_Options.Template.CreateAnchorPreview(page)
	previewframe:SetPoint("TOPLEFT",anchoreditbutton,"BOTTOMLEFT",0,-5)
	previewframe:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT",-5,5)
	local previewtext=NPA_Options.Template.CreateText(previewframe,Localization["TestText"])
	previewtext:SetPoint("CENTER",previewframe.Preview2,"CENTER")
	--script
	local SetPreview=function()
		local anchordata=anchoreditbutton.Value
		NPA_Options.Template.SetAnchorPreview(previewframe,anchordata.From,anchordata.To,anchordata.OffsetX,anchordata.OffsetY,previewtext)

		previewframe:SetAlpha(alphaslider.Value)
		previewtext:SetHeight(sizeslider.Value)	
		previewtext:SetWidth(widthslider.Value)
		NPA_Options.SetTextFont(previewtext,nil,fontselector.Value,sizeslider.Value)
	end
	local RefreshPreview=function()
		NPA_Options.HideTemplates()
		--close anchor editor
		NPA_Options.ClosePages(main,true)
	end
	--
	local EntryName=""
	local LoadData=function(default)
		--
		local entry
		if(default)then
			--get default directly from setting manager
			entry=NPA.SettingManager.GetDefaultProfile("Default")["Default"]["NamePlate"]["Default"]["TextSetting"][EntryName] or NPA.SettingManager.GetDefault("NamePlateText")
		else
			entry=Entry
		end
		--font
		local value=entry.ProfileName
		NPA_Options.Template.SetDropDownEditor(fontselector,value)
		--
		local value=entry.DataType
		NPA_Options.Template.SetDropDownEditor(datatypeselector,value)
		--color mode
		local value=entry.ColorMode
		NPA_Options.Template.SetDropDownEditor(colormodeselector,value)
		--size
		local value=entry.Height
		NPA_Options.Template.SetSliderEdit(sizeslider,value)
		--layer
		local value=entry.Layer
		NPA_Options.Template.SetDropDownEditor(layerselector,value)
		--width
		local value=entry.Width
		NPA_Options.Template.SetSliderEdit(widthslider,value)
		--anchorframe
		local value=entry.AnchorFrame
		NPA_Options.Template.SetDropDownEditor(anchorframeselector,value)
		--frame level
		local value=entry.FrameLevel
		NPA_Options.Template.SetSliderEdit(framelevelslider,value)
		--anchor
		local value=entry.FrameAnchorData
		anchoreditbutton.Value=CopyTable(value)
		--alpha
		local value=entry.Alpha
		NPA_Options.Template.SetSliderEdit(alphaslider,value)
		--scale
		local value=entry.Scale
		NPA_Options.Template.SetSliderEdit(scaleslider,value)
		--
		RefreshPreview()
		SetPreview()
	end
	local SaveData=function()
		local entry=Entry
		--font
		entry.ProfileName=fontselector.Value
		--datatype
		entry.DataType=datatypeselector.Value
		--color mode
		entry.ColorMode=colormodeselector.Value
		--size
		entry.Height=sizeslider.Value
		--layer
		entry.Layer=layerselector.Value
		--width
		entry.Width=widthslider.Value
		--anchorframe
		entry.AnchorFrame=anchorframeselector.Value
		--frame level
		entry.FrameLevel=framelevelslider.Value
		--anchor
		entry.FrameAnchorData=CopyTable(anchoreditbutton.Value)
		--alpha
		entry.Alpha=alphaslider.Value
		--scale
		entry.Scale=scaleslider.Value
		--fire event
		NPA_Options.RunFunc(main.OnValueUpdateFunc)
	end
	--
	savebutton:HookScript("OnMouseUp",function()
		NPA_Options.Animation.ShowFrame(main)
		SaveData()
		SetPreview()
	end)
	cancelbutton:HookScript("OnMouseUp",function()
		LoadData()
		SetPreview()
		NPA_Options.Animation.ShowFrame(main)
	end)
	resetbutton:HookScript("OnMouseUp",function()
		LoadData(true)
		SetPreview()
		NPA_Options.Animation.ShowFrame(main)
	end)
	--
	anchoreditbutton:HookScript("OnMouseUp",function()
		local entry=anchoreditbutton.Value
		NPA_Options.SetPage("AnchorEditor",main,entry,SetPreview)
	end)
	--
	fontselector.OnValueUpdateFunc=SetPreview
	colormodeselector.OnValueUpdateFunc=SetPreview
	sizeslider.OnValueUpdateFunc=SetPreview
	widthslider.OnValueUpdateFunc=SetPreview
	alphaslider.OnValueUpdateFunc=SetPreview
	scaleslider.OnValueUpdateFunc=SetPreview
	--
	main.OnSetFunc=function(entry,onvalueupdatefunc,entryname)
		Entry=entry
		EntryName=entryname or ""
		main.OnValueUpdateFunc=onvalueupdatefunc
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("NamePlateTextEditor",main)

end)