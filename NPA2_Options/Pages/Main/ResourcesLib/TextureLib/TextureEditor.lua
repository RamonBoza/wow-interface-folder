-- Author      : Nogarder
-- Create Date : 2012/7/23 10:44:32
NPA_Options.RegisterPageFunc("TextureEditor",function()

	local floor=floor
	local pairs=pairs
	local CopyTable=CopyTable
	local table_insert=table.insert
	local table_getn=table.getn
	--
	local Localization=NPA_Options.Localization.TemplatesWindowTextureEditor
	local Tooltips=Localization.Tooltips
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["TextureEdit"],210,320,nil,nil,nil)
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
	--texture
	local textureselector=NPA_Options.Template.CreateTextureSelectorButton(page,main,160)
	textureselector:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,step)
	--width
	local widthslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,40,1,0,Localization["Width"],Tooltips["Width"])
	widthslider:SetPoint("TOPLEFT",textureselector,"BOTTOMLEFT",0,step)
	--height
	local heightslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,40,1,0,Localization["Height"],Tooltips["Height"])
	heightslider:SetPoint("TOPLEFT",widthslider,"BOTTOMLEFT",0,step)
	--layer
	local layerselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["Layer"],Tooltips["Layer"],NPA_Options.InfoLib.GetLayer)
	layerselector:SetPoint("TOPLEFT",heightslider,"BOTTOMLEFT",0,step)
	--anchor editor
	local anchoreditbutton=NPA_Options.Template.CreateButton(page,200,20,Localization["EditAnchor"])
	anchoreditbutton.Value={}
	anchoreditbutton:SetPoint("TOPLEFT",layerselector,"BOTTOMLEFT",0,step)
	--preview
	local previewframe=NPA_Options.Template.CreateAnchorPreview(page)
	previewframe:SetPoint("TOPLEFT",anchoreditbutton,"BOTTOMLEFT",0,-5)
	previewframe:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT",-5,5)
	local previewtexture=previewframe:CreateTexture(nil,"OVERLAY")
	previewtexture:SetPoint("CENTER",previewframe.Preview2,"CENTER")
	--script
	local RefreshPreview=function()
		previewtexture:SetWidth(widthslider.Value)
		previewtexture:SetHeight(heightslider.Value)
		NPA_Options.SetTexture(previewtexture,textureselector.Value)
		--
		local anchordata=anchoreditbutton.Value
		NPA_Options.Template.SetAnchorPreview(previewframe,anchordata.From,anchordata.To,anchordata.OffsetX,anchordata.OffsetY,previewtexture)
	end
	--
	local LoadData=function(default)
		local entry
		if(default and main.DefaultFunc)then
			entry=main.DefaultFunc()
		else
			entry=main.Entry
		end
		--texture
		local value=entry.ProfileName
		NPA_Options.Template.SetDropDownEditor(textureselector,value)
		--width
		local value=entry.Width
		NPA_Options.Template.SetSliderEdit(widthslider,value)
		--hegiht
		local value=entry.Height
		NPA_Options.Template.SetSliderEdit(heightslider,value)
		--layer
		local value=entry.Layer
		NPA_Options.Template.SetDropDownEditor(layerselector,value)
		--anchor
		local value=entry.AnchorData
		anchoreditbutton.Value=CopyTable(value)
		--
		RefreshPreview()
	end
	local SaveData=function()
		local entry=main.Entry
		--texture
		entry.ProfileName=textureselector.Value
		--width
		entry.Width=widthslider.Value
		--height
		entry.Height=heightslider.Value
		--layer
		entry.Layer=layerselector.Value
		--anchor
		entry.AnchorData=CopyTable(anchoreditbutton.Value)
		--fire event
		NPA_Options.RunFunc(main.OnSaveFunc)
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
	anchoreditbutton:HookScript("OnMouseUp",function()
		local entry=anchoreditbutton.Value
		NPA_Options.SetPage("AnchorEditor",main,entry,RefreshPreview)
	end)
	--
	textureselector.OnValueUpdateFunc=RefreshPreview
	widthslider.OnValueUpdateFunc=RefreshPreview
	heightslider.OnValueUpdateFunc=RefreshPreview
	--
	local CheckColorModeList=function(list,value)
		for i=1,table_getn(list)do
			if(list[i].Value==value)then
				return true
			end
		end
	end
	--
	main.OnSetFunc=function(entry,defaultfunc,onvalueupdatefunc,onsavefunc)
		main.Entry=entry
		main.DefaultFunc=defaultfunc
		main.OnValueUpdateFunc=onvalueupdatefunc
		main.OnSaveFunc=onsavefunc
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("TextureEditor",main)

end)