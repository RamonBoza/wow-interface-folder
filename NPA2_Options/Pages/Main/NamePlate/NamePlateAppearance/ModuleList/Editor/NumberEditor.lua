-- Author      : Nogarder
-- Create Date : 2013/4/1 7:40:01
NPA_Options.RegisterPageFunc("NamePlateNumberEditor",function()

	local floor=floor
	local pairs=pairs
	local table_insert=table.insert
	local table_getn=table.getn
	local CopyTable=CopyTable
	--
	--localization
	local Localization=NPA_Options.Localization.PagesModuleListNumberEditor
	local Tooltips=Localization.Tooltips
	--
	local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["NumberEdit"],210,350,nil,nil,nil)
	main:Hide()
	local page=main.Frame
	--
	--elements
	local step=-20
	local Entry
	--save
	local savebutton=NPA_Options.Template.CreateSpecialButton(page,66,15,"Save")
	savebutton:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	--reset
	local resetbutton=NPA_Options.Template.CreateSpecialButton(page,66,15,"Reset")
	resetbutton:SetPoint("TOPRIGHT",page,"TOPRIGHT",-5,-5)
	--cancel
	local cancelbutton=NPA_Options.Template.CreateSpecialButton(page,66,15,"Cancel")
	cancelbutton:SetPoint("LEFT",savebutton,"RIGHT",5,0)
	cancelbutton:SetPoint("RIGHT",resetbutton,"LEFT",-5,0)
	--number typeselector
	local numberselector=NPA_Options.Template.CreateNumberSelectorButton(page,main,160)
	numberselector:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,step)
	--datatype
	local datatypeselector=NPA_Options.Template.CreateDataTypeList(page,200,"Number")
	datatypeselector:SetPoint("TOPLEFT",numberselector,"BOTTOMLEFT",0,step)
	--color
	local colormodeselector=NPA_Options.Template.CreateColorModeList(page,200,"Number",datatypeselector)
	colormodeselector:SetPoint("TOPLEFT",datatypeselector,"BOTTOMLEFT",0,step)
	--
	--anchor frame
	local anchorframeselector=NPA_Options.Template.CreateAnchorFrameList(page,200)
	anchorframeselector:SetPoint("TOPRIGHT",colormodeselector,"BOTTOMRIGHT",0,step)
	--framelevel
	local framelevelslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,255,1,0,"Layer","Layer",true)
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
	--script
	local SetPreview=function()
		local data={}
		--name
		data.ProfileName=numberselector.Value
		--color mode
		data.ColorMode=colormodeselector.Value
		--anchor
		data.AnchorData=anchoreditbutton.Value
		--
		NPA_Options.GetPage("NumberPreview").Update(data)
	end
	page.SetPreview=SetPreview
	--
	local RefreshPreview=function()
		NPA_Options.HideTemplates()
		--close anchor editor
		NPA_Options.ClosePages(main,true)
		-- setup preview
		NPA_Options.SetPage("NumberPreview",main,numberselector.Value)
		SetPreview()
	end
	--
	local EntryName=""
	local LoadData=function(default)
		local entry
		if(default)then
			entry=NPA.SettingManager.GetDefaultProfile("Default")["Default"]["NamePlate"]["Default"]["NumberSetting"][EntryName] or NPA.SettingManager.GetDefault("NamePlateNumber")
		else
			entry=Entry
		end
		--number
		local value=entry.ProfileName
		NPA_Options.Template.SetDropDownEditor(numberselector,value)
		--datatype
		local value=entry.DataType
		NPA_Options.Template.SetDropDownEditor(datatypeselector,value)
		--color mode
		local value=entry.ColorMode
		NPA_Options.Template.SetDropDownEditor(colormodeselector,value)
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
	end
	local SaveData=function()
		local entry=Entry
		--number
		entry.ProfileName=numberselector.Value
		--datatype
		entry.DataType=datatypeselector.Value
		--color mode
		entry.ColorMode=colormodeselector.Value
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
		--
		NPA_Options.SetPage("NumberPreview",main,numberselector.Value)
		SetPreview()
	end)
	--
	numberselector.OnValueUpdateFunc=RefreshPreview
	colormodeselector.OnValueUpdateFunc=SetPreview
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
	NPA_Options.RegisterPage("NamePlateNumberEditor",main)

end)