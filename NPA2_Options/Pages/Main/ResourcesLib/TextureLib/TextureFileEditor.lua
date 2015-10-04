-- Author      : Nogarder
-- Create Date : 2012/7/24 10:24:00
NPA_Options.RegisterPageFunc("TextureFileEditor",function()

	local pairs=pairs
	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesWindowTextureFileEditor
	local Tooltips=Localization.Tooltips
	--
	local EntryName
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["TextureEdit"],410,350,nil,nil,nil)
	main:Hide()
	local title=main.Scroll.Title
	local page=main.Frame
	--
	--elements
	local step=-20
	--save
	local savebutton=NPA_Options.Template.CreateSpecialButton(page,130,15,"Save")
	savebutton:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	--reset
	local resetbutton=NPA_Options.Template.CreateSpecialButton(page,130,15,"Reset")
	resetbutton:SetPoint("TOPRIGHT",page,"TOPRIGHT",-5,-5)
	--cancel
	local cancelbutton=NPA_Options.Template.CreateSpecialButton(page,65,15,"Cancel")
	cancelbutton:SetPoint("LEFT",savebutton,"RIGHT",5,0)
	cancelbutton:SetPoint("RIGHT",resetbutton,"LEFT",-5,0)
	--texture file

	local textureselector=NPA_Options.Template.CreateTextureFileSelectorButton(page,main,400,Localization["NameOrPath"],Tooltips["MustExistWhenLoad"])
	textureselector:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,step)
	--font mode
	local modeselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["BlendMode"],Tooltips["BlendMode"],NPA_Options.InfoLib.GetTextureMode)
	modeselector:SetPoint("TOPLEFT",textureselector,"BOTTOMLEFT",0,step)
	--angle
	local angleslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,359,1,0,Localization["Angle"],Tooltips["Angle"])
	angleslider:SetPoint("TOPLEFT",modeselector,"BOTTOMLEFT",0,step)
	--left
	local leftslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,1,0.01,0,Localization["Left"],Tooltips["Left"])
	leftslider:SetPoint("TOPLEFT",angleslider,"BOTTOMLEFT",0,step)
	--right
	local rightslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,1,0.01,0,Localization["Right"],Tooltips["Right"])
	rightslider:SetPoint("TOPLEFT",leftslider,"BOTTOMLEFT",0,step)
	--top
	local topslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,1,0.01,0,Localization["Top"],Tooltips["Top"])
	topslider:SetPoint("TOPLEFT",rightslider,"BOTTOMLEFT",0,step)
	--bottom
	local bottomslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,1,0.01,0,Localization["Bottom"],Tooltips["Bottom"])
	bottomslider:SetPoint("TOPLEFT",topslider,"BOTTOMLEFT",0,step)
	--color
	local colorbutton=NPA_Options.Template.CreateColorButton(page,200,20,Localization["Color"],main,Tooltips["Color"])
	colorbutton:SetPoint("TOPLEFT",bottomslider,"BOTTOMLEFT",0,step)
	--preview
	local preview1=page:CreateTexture(nil,"OVERLAY")
	preview1:SetPoint("TOPLEFT",modeselector,"TOPRIGHT",25,0)
	preview1:SetHeight(40)
	preview1:SetPoint("RIGHT",page,"RIGHT",-5,0)
	local preview1bg=CreateFrame("Frame",nil,page)
	preview1bg:SetPoint("TOPLEFT",preview1,"TOPLEFT",-1,1)
	preview1bg:SetPoint("BOTTOMRIGHT",preview1,"BOTTOMRIGHT",1,-1)
	NPA_Options.Template.CreateLinerBorder(preview1bg)
	--
	local preview2=page:CreateTexture(nil,"OVERLAY")
	preview2:SetPoint("TOPLEFT",preview1,"BOTTOMLEFT",0,step)
	preview2:SetPoint("TOPRIGHT",preview1,"BOTTOMRIGHT",0,step)
	preview2:SetHeight(preview1:GetWidth())
	local preview2bg=CreateFrame("Frame",nil,page)
	preview2bg:SetPoint("TOPLEFT",preview2,"TOPLEFT",-1,1)
	preview2bg:SetPoint("BOTTOMRIGHT",preview2,"BOTTOMRIGHT",1,-1)
	NPA_Options.Template.CreateLinerBorder(preview2bg)
	
	local previewbg=page:CreateTexture(nil,"BACKGROUND")
	previewbg:SetTexture(0,0,0,1)
	previewbg:SetPoint("TOPLEFT",modeselector,"TOPRIGHT",25,0)
	previewbg:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT",-5,5)
	--function
	local RefreshPreview=function()
		NPA_Options.SetTexture(preview1,nil,textureselector.Value,modeselector.Value,colorbutton.Value,
			angleslider.Value,leftslider.Value,rightslider.Value,topslider.Value,bottomslider.Value)
		NPA_Options.SetTexture(preview2,nil,textureselector.Value,modeselector.Value,colorbutton.Value,
			angleslider.Value,leftslider.Value,rightslider.Value,topslider.Value,bottomslider.Value)
	end
	--
	local LoadData=function(default)
		title:SetText(Localization["TextureEdit"]..EntryName)
		if(title:GetWidth()>200)then
			title:ClearAllPoints()
			title:SetPoint("BOTTOMLEFT",main.Frame.Scroll,"TOPLEFT",5,0)
		else
			title:ClearAllPoints()
			title:SetPoint("BOTTOM",main.Frame.Scroll,"TOP",0,0)
		end
		--page
		if(default)then
			entry=NPA.SettingManager.GetDefault("Texture")["Default"]
		else
			entry=NPA_Setting.Texture[EntryName] or NPA.SettingManager.GetDefault("Texture")["Default"]
		end
		--font
		local value=entry.Texture
		NPA_Options.Template.SetDropDownEditor(textureselector,value)
		--mode
		local value=entry.Mode
		NPA_Options.Template.SetDropDownEditor(modeselector,value)
		--angle
		local value=entry.RAngle
		NPA_Options.Template.SetSliderEdit(angleslider,value)
		--left
		local value=entry.Left
		NPA_Options.Template.SetSliderEdit(leftslider,value)
		--right
		local value=entry.Right
		NPA_Options.Template.SetSliderEdit(rightslider,value)
		--top
		local value=entry.Top
		NPA_Options.Template.SetSliderEdit(topslider,value)
		--bottom
		local value=entry.Bottom
		NPA_Options.Template.SetSliderEdit(bottomslider,value)
		--color
		NPA_Options.Template.SetColorButton(colorbutton,entry.Color)
		--
		RefreshPreview()
	end
	local SaveData=function()
		local entry=NPA_Setting.Texture[EntryName]
		--texturefile
		entry.Texture=textureselector.Value
		--mode
		entry.Mode=modeselector.Value
		--angle
		entry.RAngle=angleslider.Value
		--left
		entry.Left=leftslider.Value
		--right
		entry.Right=rightslider.Value
		--top
		entry.Top=topslider.Value
		--bottom
		entry.Bottom=bottomslider.Value
		--color
		entry.Color=CopyTable(colorbutton.Value)
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
	textureselector.OnValueUpdateFunc=RefreshPreview
	modeselector.OnValueUpdateFunc=RefreshPreview
	angleslider.OnValueUpdateFunc=RefreshPreview
	leftslider.OnValueUpdateFunc=RefreshPreview
	rightslider.OnValueUpdateFunc=RefreshPreview
	topslider.OnValueUpdateFunc=RefreshPreview
	bottomslider.OnValueUpdateFunc=RefreshPreview
	colorbutton.OnValueUpdateFunc=RefreshPreview
	--
	main.OnSetFunc=function(entryname,onvalueupdatefunc,refreshfunc)
		main.OnValueUpdateFunc=onvalueupdatefunc
		main.RefreshFunc=refreshfunc
		EntryName=entryname
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("TextureFileEditor",main)

end)