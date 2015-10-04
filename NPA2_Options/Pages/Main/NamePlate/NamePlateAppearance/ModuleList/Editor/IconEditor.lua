-- Author      : Nogarder
-- Create Date : 2012/8/28 8:39:37
NPA_Options.RegisterPageFunc("NamePlateIconEditor",function()

	local floor=floor
	local pairs=pairs
	local table_insert=table.insert
	local table_getn=table.getn
	local CopyTable=CopyTable
	--
	--localization
	local Localization=NPA_Options.Localization.PagesModuleListIconEditor
	local Tooltips=Localization.Tooltips
	--
	local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["IconEdit"],210,400,nil,nil,nil)
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
	--datatype
	local datatypeselector=NPA_Options.Template.CreateDataTypeList(page,200,"Icon")
	datatypeselector:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,step)
	--anchor frame
	local anchorframeselector=NPA_Options.Template.CreateAnchorFrameList(page,200)
	anchorframeselector:SetPoint("TOPRIGHT",datatypeselector,"BOTTOMRIGHT",0,step)
	--width slider
	local widthslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,200,1,0,"Width")
	widthslider:SetPoint("TOPLEFT",anchorframeselector,"BOTTOMLEFT",0,step)
	--height slider
	local heightslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,200,1,0,"Height")
	heightslider:SetPoint("TOPLEFT",widthslider,"BOTTOMLEFT",0,step)
	--framelevel
	local framelevelslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,255,1,0,"Layer",true)
	framelevelslider:SetPoint("TOPLEFT",heightslider,"BOTTOMLEFT",0,step)
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
	--script
	local SetPreview=function()
		local anchordata=anchoreditbutton.Value
		NPA_Options.Template.SetAnchorPreview(previewframe,anchordata.From,anchordata.To,anchordata.OffsetX,anchordata.OffsetY,previewtext)

		previewframe.Preview2:SetWidth(widthslider.Value)
		previewframe.Preview2:SetHeight(heightslider.Value)
	end
	local RefreshPreview=function()
		NPA_Options.HideTemplates()
		--close anchor editor
		NPA_Options.ClosePages(main,true)
	end
	local EntryName=""
	local LoadData=function(default)
		local entry
		if(default)then
			entry=NPA.SettingManager.GetDefaultProfile("Default")["Default"]["NamePlate"]["Default"]["IconSetting"][EntryName] or NPA.SettingManager.GetDefault("NamePlateIcon")
		else
			entry=Entry
		end
		--datatype
		local value=entry.DataType
		NPA_Options.Template.SetDropDownEditor(datatypeselector,value)
		--width
		local value=entry.Width
		NPA_Options.Template.SetSliderEdit(widthslider,value)
		--height
		local value=entry.Height
		NPA_Options.Template.SetSliderEdit(heightslider,value)
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
		--datatype
		entry.DataType=datatypeselector.Value
		--width
		entry.Width=widthslider.Value
		--height
		entry.Height=heightslider.Value
		--anchorframe
		entry.AnchorFrame=anchorframeselector.Value
		--framelevel
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
	end)
	cancelbutton:HookScript("OnMouseUp",function()
		SetPreview()
		NPA_Options.Animation.ShowFrame(main)
		LoadData()
	end)
	resetbutton:HookScript("OnMouseUp",function()
		NPA_Options.Animation.ShowFrame(main)
		LoadData(true)
	end)
	--
	anchoreditbutton:HookScript("OnMouseUp",function()
		local entry=anchoreditbutton.Value
		NPA_Options.SetPage("AnchorEditor",main,entry,SetPreview)
	end)
	--
	widthslider.OnValueUpdateFunc=SetPreview
	heightslider.OnValueUpdateFunc=SetPreview
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
	NPA_Options.RegisterPage("NamePlateIconEditor",main)

end)