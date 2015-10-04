-- Author      : Nogarder
-- Create Date : 2012/8/27 4:53:26
NPA_Options.RegisterPageFunc("BarEditor",function()

	local floor=floor
	local pairs=pairs
	local table_insert=table.insert
	local table_getn=table.getn
	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesWindowBarEditor
	local Tooltips=Localization.Tooltips
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["BarEdit"],420,460,nil,nil,nil)
	main:Hide()
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
	local cancelbutton=NPA_Options.Template.CreateSpecialButton(page,130,15,"Cancel")
	cancelbutton:SetPoint("LEFT",savebutton,"RIGHT",5,0)
	cancelbutton:SetPoint("RIGHT",resetbutton,"LEFT",-5,0)
	--leftside
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
	--hide when out max check box
	local hidewhenmaxbox=NPA_Options.Template.CreateCheckBox(page,200,20,Localization["HideWhenMax"])
	hidewhenmaxbox:SetPoint("TOPLEFT",layerselector,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetTooltips(Tooltips["HideWhenMax"],hidewhenmaxbox)
	--enable size change
	local sizechangeenablebox=NPA_Options.Template.CreateCheckBox(page,200,20,Localization["EnableSizeChange"])
	sizechangeenablebox:SetPoint("TOPLEFT",hidewhenmaxbox,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetTooltips(Tooltips["EnableSizeChange"],sizechangeenablebox)
	--enable texture change
	local texturechangeenablebox=NPA_Options.Template.CreateCheckBox(page,200,20,Localization["EnableTextureChange"])
	texturechangeenablebox:SetPoint("TOPLEFT",sizechangeenablebox,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetTooltips(Tooltips["EnableTextureChange"],texturechangeenablebox)
	--preview
	local previewframe=NPA_Options.Template.CreateAnchorPreview(page)
	previewframe:SetPoint("TOPLEFT",texturechangeenablebox,"BOTTOMLEFT",0,-5)
	previewframe:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT",-5,5)
	local previewtexture=previewframe:CreateTexture(nil,"OVERLAY")
	previewtexture:SetPoint("CENTER",previewframe.Preview2,"CENTER")
	--preview percent slider
	local percentslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,100,1,0,Localization["Percent"])
	percentslider:SetPoint("BOTTOMLEFT",page,"BOTTOMLEFT",5,5)
	NPA_Options.Template.SetSliderEdit(percentslider,100)
	local NPA_BarManager_SetBar=NPA.BarManager.SetBar
	percentslider.OnValueUpdateFunc=function()
		NPA_BarManager_SetBar(previewtexture,percentslider.Value/100)
	end

	--rightside--
	--color
	local GetColorMode=function()
		return {
			[1]={
				Text=Localization["ByPercent"],
				Value=1,
			},
			[2]={
				Text=Localization["ByTextureSetting"],
				Value=0
			}
		}
	end
	local colormodeselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["ColorMode"],nil,GetColorMode)
	colormodeselector:SetPoint("TOPRIGHT",resetbutton,"BOTTOMRIGHT",-20,step)
	--min color button
	local mincolorbutton=NPA_Options.Template.CreateColorButton(page,200,20,Localization["MinColor"],main,Tooltips["MinColor"])
	mincolorbutton:SetPoint("TOPLEFT",colormodeselector,"BOTTOMLEFT",0,step)
	--max color button
	local maxcolorbutton=NPA_Options.Template.CreateColorButton(page,200,20,Localization["MaxColor"],main,Tooltips["MaxColor"])
	maxcolorbutton:SetPoint("TOPLEFT",mincolorbutton,"BOTTOMLEFT",0,step)
	--minslider
	local minslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,100,1,0,Localization["PercentFrom"],Tooltips["PercentFrom"])
	minslider:SetPoint("TOPLEFT",maxcolorbutton,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetSliderEdit(minslider,0)
	--maxslider
	local maxslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,100,1,0,Localization["PercentTo"],Tooltips["PercentTo"])
	maxslider:SetPoint("TOPLEFT",minslider,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetSliderEdit(maxslider,1)
	--direction
	local directionslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,360,1,0,Localization["Direction"],Tooltips["Direction"])
	directionslider:SetPoint("TOPLEFT",maxslider,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetSliderEdit(directionslider,0)
	--anchor editor
	local anchoreditbutton=NPA_Options.Template.CreateButton(page,200,20,Localization["EditAnchor"])
	anchoreditbutton.Value={}
	anchoreditbutton:SetPoint("TOPLEFT",directionslider,"BOTTOMLEFT",0,step)
	--
	maxslider.OnValueUpdateFunc=function()
		NPA_Options.Template.SetSliderEdit(minslider,nil,nil,maxslider.Value)
	end
	--script
	local NPA_BarManager_ManageBar=NPA.BarManager.ManageBar
	local RefreshPreview=function()
		NPA_Options.HideTemplates()
		--
		local data={
			ProfileName=textureselector.Value,
			Width=widthslider.Value,
			Height=heightslider.Value,
			AnchorData=anchoreditbutton.Value,
			ColorMode=colormodeselector.Value,
			Layer="OVERLAY",
			MinColor=mincolorbutton.Value,
			MaxColor=maxcolorbutton.Value,
			PercentFrom=minslider.Value,
			PercentTo=maxslider.Value,
			Direction=directionslider.Value,
			HideWhenMax=hidewhenmaxbox.Checked,
			EnableSizeChange=sizechangeenablebox.Checked,
			EnableTextureChange=texturechangeenablebox.Checked,
		}
		NPA_BarManager_ManageBar(previewtexture,data,1,1,true)
		NPA_BarManager_SetBar(previewtexture,percentslider.Value/100)
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
		--leftside
		--font
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
		--sizechange enablebox
		local value=entry.HideWhenMax
		NPA_Options.Template.SetCheckBox(hidewhenmaxbox,value)
		--sizechange enablebox
		local value=entry.EnableSizeChange
		NPA_Options.Template.SetCheckBox(sizechangeenablebox,value)
		--texturechange enablebox
		local value=entry.EnableTextureChange
		NPA_Options.Template.SetCheckBox(texturechangeenablebox,value)
		--anchor
		local value=entry.AnchorData
		anchoreditbutton.Value=CopyTable(value)
		--rightside
		--color mode
		local value=entry.ColorMode
		NPA_Options.Template.SetDropDownEditor(colormodeselector,value)
		--mincolor
		local value=entry.MinColor
		NPA_Options.Template.SetColorButton(mincolorbutton,value)
		--max color
		local value=entry.MaxColor
		NPA_Options.Template.SetColorButton(maxcolorbutton,value)
		--minslider
		local value=entry.PercentFrom*100
		NPA_Options.Template.SetSliderEdit(minslider,value)
		--maxslider
		local value=entry.PercentTo*100
		NPA_Options.Template.SetSliderEdit(maxslider,value)
		NPA_Options.Template.SetSliderEdit(minslider,nil,nil,maxslider.Value)
		--direction
		local value=entry.Direction
		NPA_Options.Template.SetSliderEdit(directionslider,value)
		--
		RefreshPreview()
	end
	local SaveData=function()
		local entry=main.Entry
		--leftside
		--font
		entry.ProfileName=textureselector.Value
		--width
		entry.Width=widthslider.Value
		--height
		entry.Height=heightslider.Value
		--layer
		entry.Layer=layerselector.Value
		--size change enablebox
		entry.HideWhenMax=hidewhenmaxbox.Checked
		--size change enablebox
		entry.EnableSizeChange=sizechangeenablebox.Checked
		--texture change enablebox
		entry.EnableTextureChange=texturechangeenablebox.Checked
		--anchor
		entry.AnchorData=CopyTable(anchoreditbutton.Value)
		--rightside
		--color mode
		entry.ColorMode=colormodeselector.Value
		--min color
		entry.MinColor=CopyTable(mincolorbutton.Value)
		--max color
		entry.MaxColor=CopyTable(maxcolorbutton.Value)
		--minslider
		entry.PercentFrom=minslider.Value/100
		--maxslider
		entry.PercentTo=maxslider.Value/100
		--direction
		entry.Direction=directionslider.Value
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
		NPA_Options.SetPage("AnchorEditor",main,entry,RefreshPreview,true)
	end)
	--
	textureselector.OnValueUpdateFunc=RefreshPreview
	colormodeselector.OnValueUpdateFunc=RefreshPreview
	hidewhenmaxbox.OnValueUpdateFunc=RefreshPreview
	sizechangeenablebox.OnValueUpdateFunc=RefreshPreview
	texturechangeenablebox.OnValueUpdateFunc=RefreshPreview
	widthslider.OnValueUpdateFunc=RefreshPreview
	heightslider.OnValueUpdateFunc=RefreshPreview
	mincolorbutton.OnValueUpdateFunc=RefreshPreview
	maxcolorbutton.OnValueUpdateFunc=RefreshPreview
	directionslider.OnValueUpdateFunc=RefreshPreview

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
	NPA_Options.RegisterPage("BarEditor",main)

end)