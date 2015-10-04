-- Author      : Nogarder
-- Create Date : 2013/4/6 11:27:21
NPA_Options.RegisterPageFunc("NamePlateIconGroupRulesModulesEditor",function()

	local pairs=pairs
	local CopyTable=CopyTable
	local table_insert=table.insert
	local table_getn=table.getn
	--
	local Localization=NPA_Options.Localization.PagesModuleListIconGroupRulesModulesEditor
	local Tooltips=Localization.Tooltips
	--
	local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["EditModule"],210,530,nil,nil,nil)
	main:Hide()
	local page=main.Frame
	--
	--elements
	local step=-20
	local Setting
	local SpellList
	local SchoolList
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
	--filtertype
	local GetModuleType=function()
		return Localization.ModuleTypeList
	end
	local moduletypeselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["ModuleType"],Tooltips["ModuleType"],GetModuleType)
	moduletypeselector:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,step)
	--datatype
	local GetDataType=function()
		return Localization.DataTypeList
	end
	local datatypeselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["DataType"],Tooltips["DataType"],GetDataType)
	datatypeselector:SetPoint("TOPLEFT",moduletypeselector,"BOTTOMLEFT",0,step)
	--bar type selector
	local bargroupselector=NPA_Options.Template.CreateBarGroupSelectorButton(page,main,160)
	bargroupselector:SetPoint("TOPLEFT",datatypeselector,"BOTTOMLEFT",0,step)
	--texture
	local textureselector=NPA_Options.Template.CreateTextureSelectorButton(page,main,160)
	textureselector:SetPoint("TOPLEFT",datatypeselector,"BOTTOMLEFT",0,step)
	--number
	local numberselector=NPA_Options.Template.CreateNumberSelectorButton(page,main,160)
	numberselector:SetPoint("TOPLEFT",datatypeselector,"BOTTOMLEFT",0,step)
	--text
	local fontselector=NPA_Options.Template.CreateFontEditorButton(page,main,160)
	fontselector:SetPoint("TOPLEFT",datatypeselector,"BOTTOMLEFT",0,step)
	--icon has no selector
	--
	--color
	local GetColorMode=function()
		return Localization.ColorModeList
	end
	local colormodeselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["ColorMode"],Tooltips["ColorMode"],GetColorMode)
	colormodeselector:SetPoint("TOPLEFT",fontselector,"BOTTOMLEFT",0,step)
	--width slider
	local widthslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,1,40,1,20,"Width")
	widthslider:SetPoint("TOPLEFT",colormodeselector,"BOTTOMLEFT",0,step)
	--height slider
	local heightslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,1,40,1,20,"Height")
	heightslider:SetPoint("TOPLEFT",widthslider,"BOTTOMLEFT",0,step)
	--framelevel
	local framelevelslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,255,1,0,"Layer",true)
	framelevelslider:SetPoint("TOPLEFT",heightslider,"BOTTOMLEFT",0,step)
	--alpha slider
	local alphaslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,1,0.01,1,"Alpha",true)
	alphaslider:SetPoint("TOPLEFT",framelevelslider,"BOTTOMLEFT",0,step)
	--scale slider
	local scaleslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,1,0.01,1,"Scale")
	scaleslider:SetPoint("TOPLEFT",alphaslider,"BOTTOMLEFT",0,step)
	--anchor editor
	local anchoreditbutton=NPA_Options.Template.CreateSpecialButton(page,200,20,"EditAnchor")
	anchoreditbutton.Value={}
	anchoreditbutton:SetPoint("TOPLEFT",scaleslider,"BOTTOMLEFT",0,step)
	--preview
	local previewframe=NPA_Options.Template.CreateAnchorPreview(page)
	previewframe:SetPoint("TOPLEFT",anchoreditbutton,"BOTTOMLEFT",0,-5)
	previewframe:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT",-5,5)
	previewframe.Preview2:Hide()
	--previewbargroup
	local previewbargroup=NPA.BarManager.CreateBarGroup(previewframe)
	previewbargroup:SetPoint("CENTER",previewframe.Preview2,"CENTER")
	--previewnumber
	local previewnumber=NPA.NumberManager.CreateNumber(previewframe)
	previewnumber:SetPoint("CENTER",previewframe.Preview2,"CENTER")
	--previewtexture
	local previewtexture=previewframe:CreateTexture()
	previewtexture:SetPoint("CENTER",previewframe.Preview2,"CENTER")
	--previewtext
	local previewtext=previewframe:CreateFontString()
	previewtext:SetPoint("CENTER",previewframe.Preview2,"CENTER")
	previewtext:SetFont(GameFontNormal:GetFont())
	previewtext:SetText(Localization["TestText"])
	--
	--script
	local SetPreview=function()
		previewbargroup:Hide()
		previewnumber:Hide()
		previewtexture:Hide()
		previewtext:Hide()
		--
		local previewholder
		--
		local value=moduletypeselector.Value
		if(value=="BarGroup")then
			local setting={
				ProfileName=bargroupselector.Value,
				Width=widthslider.Value,
				Height=heightslider.Value,
				ColorMode=colormodeselector.Value
			}
			NPA.BarManager.ManageBarGroup(previewbargroup,setting)
			NPA.BarManager.SetBarGroup(previewbargroup,1)
			previewbargroup:Show()
			previewholder=previewbargroup
		elseif(value=="Texture")then
			local setting={
				ProfileName=textureselector.Value,
				Width=widthslider.Value,
				Height=heightslider.Value,
				Layer="OVERLAY",
			}
			NPA.TextureManager.ManageTexture(previewtexture,setting,nil,nil,true)
			previewtexture:Show()
			previewholder=previewtexture
		elseif(value=="Icon")then
			previewtexture:SetTexture(1,1,1,1)
			previewtexture:SetWidth(widthslider.Value)
			previewtexture:SetHeight(heightslider.Value)
			previewtexture:Show()
			previewholder=previewtexture
		elseif(value=="Number")then
			local setting={
				ProfileName=numberselector.Value,
				ColorMode=colormodeselector.Value
			}
			NPA.NumberManager.ManageNumber(previewnumber,setting)
			previewnumber:Show()
			previewholder=previewnumber
		elseif(value=="Text" or value=="ExtraInfo")then
			local setting={
				ProfileName=fontselector.Value,
				Width=widthslider.Value,
				Height=heightslider.Value,
			}
			NPA.FontManager.ManageFont2(previewtext,setting)
			previewtext:Show()
			previewholder=previewtext
		end
		--
		previewframe:SetAlpha(alphaslider.Value)
		--
		local anchordata=anchoreditbutton.Value
		NPA_Options.Template.SetAnchorPreview(previewframe,anchordata.From,anchordata.To,anchordata.OffsetX,anchordata.OffsetY,previewtext)
	end
	local RefreshDropDown=function()
		NPA_Options.HideTemplates()
		--
		local value=moduletypeselector.Value
		if(value=="BarGroup")then
			textureselector:Hide()
			numberselector:Hide()
			fontselector:Hide()
			bargroupselector:Show()
			--
			if(bargroupselector.Value==" ")then
				local entryname=next(NPA_Setting.BarGroup)
				NPA_Options.Template.SetDropDownEditor(bargroupselector,entryname)
			end
			--
			NPA_Options.Template.EnableDropDownEditor(datatypeselector)
		elseif(value=="Texture")then
			bargroupselector:Hide()
			numberselector:Hide()
			fontselector:Hide()
			textureselector:Show()
			--
			if(textureselector.Value==" ")then
				local entryname=next(NPA_Setting.Texture)
				NPA_Options.Template.SetDropDownEditor(textureselector,entryname)
			end
			--
			NPA_Options.Template.EnableDropDownEditor(textureselector)
			--
			NPA_Options.Template.DisableDropDownEditor(datatypeselector)
		elseif(value=="Number")then
			bargroupselector:Hide()
			textureselector:Hide()
			fontselector:Hide()
			numberselector:Show()
			--
			if(numberselector.Value==" ")then
				local entryname=next(NPA_Setting.Number)
				NPA_Options.Template.SetDropDownEditor(numberselector,entryname)
			end
			--
			NPA_Options.Template.EnableDropDownEditor(datatypeselector)
		elseif(value=="Text" or value=="ExtraInfo")then
			bargroupselector:Hide()
			textureselector:Hide()
			fontselector:Show()
			numberselector:Hide()
			--
			if(fontselector.Value==" ")then
				local entryname=next(NPA_Setting.Font)
				NPA_Options.Template.SetDropDownEditor(fontselector,entryname)
			end
			--
			NPA_Options.Template.DisableDropDownEditor(datatypeselector)
		elseif(value=="Icon")then
			--icon hide all
			bargroupselector:Hide()
			textureselector:Show()
			numberselector:Hide()
			fontselector:Hide()
			--
			NPA_Options.Template.DisableDropDownEditor(textureselector)
			--
			NPA_Options.Template.DisableDropDownEditor(datatypeselector)
		end
		SetPreview()
	end
	--
	local LoadData=function(default)
		local entry
		if(default)then
			--get default directly from setting manager
			entry=NPA.SettingManager.GetDefault("NamePlateIconGroup").DataRules.Modules
		else
			entry=Setting
		end
		--moduletype
		local value=entry.ModuleType
		NPA_Options.Template.SetDropDownEditor(moduletypeselector,value)
		--profile name
		--datatype --only enable when bargroup and number
		local value=entry.DataType
		NPA_Options.Template.SetDropDownEditor(datatypeselector,value)
		--
		local value=entry.ProfileName
		NPA_Options.Template.SetDropDownEditor(bargroupselector,value)
		NPA_Options.Template.SetDropDownEditor(textureselector,value)
		NPA_Options.Template.SetDropDownEditor(numberselector,value)
		NPA_Options.Template.SetDropDownEditor(fontselector,value)
		--colormode
		local value=entry.ColorMode
		NPA_Options.Template.SetDropDownEditor(colormodeselector,value)
		--width
		local value=entry.Width
		NPA_Options.Template.SetSliderEdit(widthslider,value)
		--height
		local value=entry.Height
		NPA_Options.Template.SetSliderEdit(heightslider,value)
		--framelevel
		local value=entry.FrameLevel
		NPA_Options.Template.SetSliderEdit(framelevelslider,value)
		--alpha
		local value=entry.Alpha
		NPA_Options.Template.SetSliderEdit(alphaslider,value)
		--scale
		local value=entry.Scale
		NPA_Options.Template.SetSliderEdit(scaleslider,value)
		--anchor
		local value=entry.AnchorData
		anchoreditbutton.Value=CopyTable(value)
		--
		NPA_Options.ClosePages(main,true)
		--
		RefreshDropDown()
	end
	local SaveData=function()
		local entry=Setting
		--moduletype
		entry.ModuleType=moduletypeselector.Value
		local value=moduletypeselector.Value
		if(value=="BarGroup")then
			entry.ProfileName=bargroupselector.Value
		elseif(value=="Texture")then
			entry.ProfileName=textureselector.Value
		elseif(value=="Number")then
			entry.ProfileName=numberselector.Value
		elseif(value=="Text" or value=="ExtraInfo")then
			entry.ProfileName=fontselector.Value
		elseif(value=="Icon")then
			--icon don't have one
			entry.ProfileName=" "
		end
		--data type
		entry.DataType=datatypeselector.Value
		--color mode
		entry.ColorMode=colormodeselector.Value
		--width
		entry.Width=widthslider.Value
		--height
		entry.Height=heightslider.Value
		--frame level
		entry.FrameLevel=framelevelslider.Value
		--alpha
		entry.Alpha=alphaslider.Value
		--scale
		entry.Scale=scaleslider.Value
		--anchor
		entry.AnchorData=CopyTable(anchoreditbutton.Value)
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
		SetPreview()
		NPA_Options.Animation.ShowFrame(main)
		LoadData()
		SetPreview()
	end)
	resetbutton:HookScript("OnMouseUp",function()
		NPA_Options.Animation.ShowFrame(main)
		LoadData(true)
		SetPreview()
	end)
	--
	widthslider.OnValueUpdateFunc=SetPreview
	heightslider.OnValueUpdateFunc=SetPreview
	alphaslider.OnValueUpdateFunc=SetPreview
	scaleslider.OnValueUpdateFunc=SetPreview
	bargroupselector.OnValueUpdateFunc=SetPreview
	textureselector.OnValueUpdateFunc=SetPreview
	numberselector.OnValueUpdateFunc=SetPreview
	fontselector.OnValueUpdateFunc=SetPreview
	--
	moduletypeselector.OnValueUpdateFunc=RefreshDropDown
	--
	main.SetPreview=SetPreview
	--
	anchoreditbutton:HookScript("OnMouseUp",function()
		local entry=anchoreditbutton.Value
		NPA_Options.SetPage("AnchorEditor",main,entry,SetPreview)
	end)
	--
	main.OnSetFunc=function(setting,onvalueupdatefunc)
		Setting=setting
		main.OnValueUpdateFunc=onvalueupdatefunc
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("NamePlateIconGroupRulesModulesEditor",main)

end)