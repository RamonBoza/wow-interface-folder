-- Author      : Nogarder
-- Create Date : 2012/12/28 15:47:47
NPA_Options.RegisterPageFunc("NamePlateDefaultEditor",function()

	local pairs=pairs
	local CopyTable=CopyTable
	local table_insert=table.insert
	local table_getn=table.getn
	--
	local Localization=NPA_Options.Localization.PagesModueListDefaultEditor
	local Tooltips=Localization.Tooltips
	--
	local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["DefaultEdit"],210,560,nil,nil,nil)
	main:Hide()
	local page=main.Frame
	--elements
	local step=-20
	local Profile
	local EntryName
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
	--enable checkbox
	local enablecheckbox=NPA_Options.Template.CreateCheckBox(page,200,20,Localization["Enable"])
	enablecheckbox:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,step)
	--texture file
	local textureselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["NameOrPath"],Tooltips["MustExistWhenLoad"],NPA_Options.InfoLib.GetTexture,50)
	textureselector:SetPoint("TOPLEFT",enablecheckbox,"BOTTOMLEFT",0,step)
	textureselector.FreeEdit=true
	--font
	local fontselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["NameOrPath"],Tooltips["MustExistWhenLoad"],NPA_Options.InfoLib.GetFont)
	fontselector:SetPoint("TOPLEFT",enablecheckbox,"BOTTOMLEFT",0,step)
	fontselector.FreeEdit=true
	--widthslider
	local widthslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,200,1,0,Localization["Width"],Tooltips["Width"])
	widthslider:SetPoint("TOPLEFT",fontselector,"BOTTOMLEFT",0,step)
	--heightslider
	local heightslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,200,1,0,Localization["Height"],Tooltips["Height"])
	heightslider:SetPoint("TOPLEFT",widthslider,"BOTTOMLEFT",0,step)
	--self anchor
	local selfanchorselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["SelfAnchor"],Tooltips["SelfAnchor"],NPA_Options.InfoLib.GetAnchor)
	selfanchorselector:SetPoint("TOPLEFT",heightslider,"BOTTOMLEFT",0,step)
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
	local previewtext=NPA_Options.Template.CreateText(previewframe,Localization["TestText"])
	previewtext:SetPoint("CENTER",previewframe.Preview2,"CENTER")
	local previewtexture=previewframe:CreateTexture(nil,"OVERLAY")
	previewtexture:SetPoint("CENTER",previewframe.Preview2,"CENTER")
	--
	previewframe.Preview1:SetWidth(130)
	previewframe.Preview1:SetHeight(36)
	--script
	local SetPreview=function()
		local preview
		if(fontselector:IsShown())then
			preview=previewtext
		else
			preview	=previewtexture
		end
		NPA_Options.Template.SetAnchorPreview(previewframe,selfanchorselector.Value,toanchorselector.Value,offsetxslider.Value,offsetyslider.Value,preview)
	end
	local RefreshPreview=function()
		NPA_Options.HideTemplates()
		--
		local preview
		if(fontselector:IsShown())then
			preview=previewtext
			NPA_Options.SetTextFont(previewtext,nil,fontselector.Value,heightslider.Value)
		else
			preview	=previewtexture
			if(textureselector:IsShown())then
				preview:SetTexture(textureselector.Value)
			else
				preview:SetTexture(1,1,1,1)
			end
		end
		--
		preview:SetHeight(heightslider.Value)	
		preview:SetWidth(widthslider.Value)
	end
	--
	local LoadData=function(default)
		--
		local entry
		if(default)then
			--get default directly from setting manager
			entry=NPA.SettingManager.GetDefault("NamePlateDefault")[EntryName]
		else
			entry=Profile.DefaultSetting[EntryName]
		end
		--enable
		local value=entry.Enable
		NPA_Options.Template.SetCheckBox(enablecheckbox,value)
		--texture
		if(entry.Texture)then
			local value=entry.Texture
			NPA_Options.Template.SetDropDownEditor(textureselector,value)
			textureselector:Show()
			fontselector:Hide()
			previewtext:Hide()
			previewtexture:Show()
		elseif(entry.Font)then
			--font
			local value=entry.Font
			NPA_Options.Template.SetDropDownEditor(fontselector,value)
			textureselector:Hide()
			fontselector:Show()
			previewtexture:Hide()
			previewtext:Show()
		else
			textureselector:Hide()
			fontselector:Hide()
			previewtext:Hide()
			previewtexture:Show()
		end
		--width
		local value=entry.Width
		NPA_Options.Template.SetSliderEdit(widthslider,value)
		--height
		local value=entry.Height
		NPA_Options.Template.SetSliderEdit(heightslider,value)
		--anchor
		local value=entry.Anchor
		NPA_Options.Template.SetDropDownEditor(selfanchorselector,value)
		--anchor
		local value=entry.AnchorTo
		NPA_Options.Template.SetDropDownEditor(toanchorselector,value)
		--Offsetx
		local value=entry.OffsetX
		NPA_Options.Template.SetSliderEdit(offsetxslider,value)
		--Offsetx
		local value=entry.OffsetY
		NPA_Options.Template.SetSliderEdit(offsetyslider,value)
		--
		RefreshPreview()
		SetPreview()
	end
	local SaveData=function()
		local entry=Profile.DefaultSetting[EntryName]
		--enable
		entry.Enable=enablecheckbox.Checked
		--texture or font
		if(entry.Texture)then
			entry.Texture=textureselector.Value
		elseif(entry.Font)then
			entry.Font=fontselector.Value
		end
		--width
		entry.Width=widthslider.Value
		--height
		entry.Height=heightslider.Value
		--anchor
		entry.Anchor=selfanchorselector.Value
		--anchor
		entry.AnchorTo=toanchorselector.Value
		--Offsetx
		entry.OffsetX=offsetxslider.Value
		--Offsetx
		entry.OffsetY=offsetyslider.Value
		--
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
	textureselector.OnValueUpdateFunc=RefreshPreview
	fontselector.OnValueUpdateFunc=RefreshPreview
	widthslider.OnValueUpdateFunc=RefreshPreview
	heightslider.OnValueUpdateFunc=RefreshPreview
	offsetxslider.OnValueUpdateFunc=SetPreview
	offsetyslider.OnValueUpdateFunc=SetPreview
	selfanchorselector.OnValueUpdateFunc=SetPreview
	toanchorselector.OnValueUpdateFunc=SetPreview
	--
	main.OnSetFunc=function(profile,entryname,onvalueupdatefunc)
		Profile=profile
		EntryName=entryname
		main.OnValueUpdateFunc=onvalueupdatefunc
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("NamePlateDefaultEditor",main)

end)