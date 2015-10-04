-- Author      : Nogarder
-- Create Date : 2012/12/19 13:04:14
NPA_Options.RegisterPageFunc("NamePlateTextureGroupEditor",function()

	local pairs=pairs
	local CopyTable=CopyTable
	local table_insert=table.insert
	--localization
	local Localization=NPA_Options.Localization.PagesModueListTextureGroupEditor
	local Tooltips=Localization.Tooltips
	--
	local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["TextureGroupEdit"],340,430,nil,nil,nil)
	main:Hide()
	local page=main.Frame
	page:SetWidth(210)
	--
	local TextureGroupSetting={}
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
	--datatype
	local datatypeselector=NPA_Options.Template.CreateDataTypeList(page,200,"TextureGroup")
	datatypeselector:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,step)
	--anchor frame
	local anchorframeselector=NPA_Options.Template.CreateAnchorFrameList(page,200)
	anchorframeselector:SetPoint("TOPLEFT",datatypeselector,"BOTTOMLEFT",0,step)
	--framelevel
	local framelevelslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,255,1,0,"Layer",true)
	framelevelslider:SetPoint("TOPLEFT",anchorframeselector,"BOTTOMLEFT",0,step)
	--alpha slider
	local alphaslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,1,0.01,1,"Alpha",true)
	alphaslider:SetPoint("TOPLEFT",framelevelslider,"BOTTOMLEFT",0,step)
	--scale slider
	local scaleslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0.01,2,0.01,1,"Scale")
	scaleslider:SetPoint("TOPLEFT",alphaslider,"BOTTOMLEFT",0,step)
	--width slider
	local widthslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,200,1,0,"Width")
	widthslider:SetPoint("TOPLEFT",scaleslider,"BOTTOMLEFT",0,step)
	--height slider
	local heightslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,200,1,0,"Height")
	heightslider:SetPoint("TOPLEFT",widthslider,"BOTTOMLEFT",0,step)
	--anchor editor
	local anchoreditbutton=NPA_Options.Template.CreateSpecialButton(page,200,20,"EditAnchor")
	anchoreditbutton.Value={}
	anchoreditbutton:SetPoint("TOPLEFT",heightslider,"BOTTOMLEFT",0,step)
	--preview
	local previewframe=NPA_Options.Template.CreateAnchorPreview(page)
	previewframe:SetPoint("TOPLEFT",anchoreditbutton,"BOTTOMLEFT",0,-5)
	previewframe:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT",-5,5)
	--
	--texture group editor
	local listeditor=NPA_Options.Template.CreateListEditor(nil,nil,120,300,page,nil,nil,main.Scroll)
	listeditor.NoDefault=true
	listeditor:SetPoint("TOPLEFT",main.Frame,"TOPRIGHT",5,0)
	listeditor:SetPoint("BOTTOMRIGHT",main.Scroll,"BOTTOMRIGHT",-5,5)
	listeditor.Frame:HookScript("OnMouseDown",page:GetScript("OnMouseDown"))
	listeditor.Frame:HookScript("OnMouseUp",page:GetScript("OnMouseUp"))
	--
	--script
	local SetPreview=function()
		NPA_Options.HideTemplates()
		--set alpha
		previewframe:SetAlpha(alphaslider.Value)
		--
		local anchordata=anchoreditbutton.Value
		NPA_Options.Template.SetAnchorPreview(previewframe,anchordata.From,anchordata.To,anchordata.OffsetX,anchordata.OffsetY)
	end
	--
	local Refresh=function()
		local profiledata={}
		--build data here
		local i=1
		for name,entry in pairs(TextureGroupSetting)do
			profiledata[i]={
				Text=name,
				Value=name,
				ProfileName=entry.ProfileName,
			}
			i=i+1
		end
		NPA_Options.Template.UpdateListEditor(listeditor,profiledata)
		--
		--close anchor editor
		NPA_Options.ClosePages(main,true)
		--setup preview
		NPA_Options.SetPage("TextureGroupPreview",main,TextureGroupSetting)
		NPA_Options.RunFunc(main.OnValueUpdateFunc)
	end
	--
	local EntryName=""
	local LoadData=function(default)
		NPA_Options.ClosePages(main,true)
		--
		local entry
		if(default)then
			--get default directly from setting manager
			entry=NPA.SettingManager.GetDefaultProfile("Default")["Default"]["NamePlate"]["Default"]["TextureGroupSetting"][EntryName] or NPA.SettingManager.GetDefault("NamePlateTextureGroup")
		else
			entry=Entry
		end
		--datatype
		local value=entry.DataType
		NPA_Options.Template.SetDropDownEditor(datatypeselector,value)
		--anchorframe
		local value=entry.AnchorFrame
		NPA_Options.Template.SetDropDownEditor(anchorframeselector,value)
		--frame level
		local value=entry.FrameLevel
		NPA_Options.Template.SetSliderEdit(framelevelslider,value)
		--anchor
		local value=entry.FrameAnchorData
		anchoreditbutton.Value=CopyTable(value)
		--texturegroup
		local value=entry.TextureGroup
		TextureGroupSetting=CopyTable(value)
		--clear type
		TextureGroupSetting.Type=nil
		--alpha
		local value=entry.Alpha
		NPA_Options.Template.SetSliderEdit(alphaslider,value)
		--scale
		local value=entry.Scale
		NPA_Options.Template.SetSliderEdit(scaleslider,value)
		--width
		local value=entry.Width
		NPA_Options.Template.SetSliderEdit(widthslider,value)
		--height
		local value=entry.Height
		NPA_Options.Template.SetSliderEdit(heightslider,value)
		--
		SetPreview()
		Refresh()

	end
	local SaveData=function()
		local entry=Entry
		--datatype
		entry.DataType=datatypeselector.Value
		--anchorframe
		entry.AnchorFrame=anchorframeselector.Value
		--frame level
		entry.FrameLevel=framelevelslider.Value
		--anchor
		entry.FrameAnchorData=CopyTable(anchoreditbutton.Value)
		--texturegruop
		entry.TextureGroup=CopyTable(TextureGroupSetting)
		--alpha
		entry.Alpha=alphaslider.Value
		--scale
		entry.Scale=scaleslider.Value
		--width
		entry.Width=widthslider.Value
		--height
		entry.Height=heightslider.Value
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
		--setup preview
		NPA_Options.SetPage("TextureGroupPreview",main,TextureGroupSetting)
		NPA_Options.RunFunc(main.OnValueUpdateFunc)

	end)
	--
	listeditor.RefreshFunc=Refresh
	--
	local GetDefault=function()
		return NPA_Options.RunFunc(main.GetDefaultFunc)
	end
	local OnUpdate=function()
		NPA.EventHandler.FireEvent(6,"NamePlate_ProfileKeyChange",ProfileName)
		Refresh()
	end
	listeditor.OnCopyFunc=function(oldname,newname)
		TextureGroupSetting[newname]=CopyTable(TextureGroupSetting[oldname])
		Refresh()
	end
	listeditor.OnDeleteFunc=function(oldname)
		TextureGroupSetting[oldname]=nil
		NPA_Options.ClosePages(main,true)
		Refresh()
	end
	listeditor.OnRenameFunc=function(oldname,newname)
		TextureGroupSetting[newname]=CopyTable(TextureGroupSetting[oldname])
		TextureGroupSetting[oldname]=nil
		NPA_Options.ClosePages(main,true)
		Refresh()
	end
	listeditor.OnCreateFunc=function(newname)
		TextureGroupSetting[newname]=NPA.SettingManager.GetDefault("NamePlateTextureGroup").TextureGroup["1"]
		Refresh()
	end
	listeditor.OnClickFunc=function(name,button)
		if(button=="LeftButton")then
			local entry=TextureGroupSetting[name]
			NPA_Options.SetPage("TextureEditor",main,entry,nil,nil,OnUpdate)
			--setup preview
			NPA_Options.SetPage("TextureGroupPreview",main,TextureGroupSetting)
		end
	end
	--
	alphaslider.OnValueUpdateFunc=SetPreview
	--
	main.OnSetFunc=function(entry,onvalueupdatefunc,entryname)
		Entry=entry
		EntryName=entryname or ""
		main.OnValueUpdateFunc=onvalueupdatefunc
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("NamePlateTextureGroupEditor",main)

end)