-- Author      : Nogarder
-- Create Date : 2012/7/28 11:37:45
NPA_Options.RegisterPageFunc("NumberEditor",function()

	local pairs=pairs
	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesWindowNumberEditor
	local Tooltips=Localization.Tooltips
	--
	local EntryName
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["NumberEdit"],210,420,nil,nil,nil)
	main:Hide()
	local page=main.Frame
	--
	local OnSaveFunc
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
	--min color button
	local mincolorbutton=NPA_Options.Template.CreateColorButton(page,200,20,Localization["MinColor"],main,Tooltips["MinColor"])
	mincolorbutton:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,step)
	--max color button
	local maxcolorbutton=NPA_Options.Template.CreateColorButton(page,200,20,Localization["MaxColor"],main,Tooltips["MaxColor"])
	maxcolorbutton:SetPoint("TOPLEFT",mincolorbutton,"BOTTOMLEFT",0,step)
	--value type dropdown
	local GetValueType=function()
		local atype={
			[4]={
				Text=Localization["DontShow"],
				Value=0,
			},
			[1]={
				Text=Localization["Value"],
				Value=1,
			},
			[2]={
				Text=Localization["Short"],
				Value=2,
			},
			[3]={
				Text=Localization["Break"],
				Value=3,
			},
		}
		return atype
	end
	local valuetypeselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["Value"],Tooltips["Value"],GetValueType)
	valuetypeselector:SetPoint("TOPLEFT",maxcolorbutton,"BOTTOMLEFT",0,step)
	--value text editor button
	local ValueColor={
		[1]={
			Text=Localization["ByPercent"],
			Value=2
		}
	}
	local valuebutton=NPA_Options.Template.CreateNumberTextEditorButton(page,200,20,Localization["Edit"]..Localization["Value"]..Localization["Font"],main,ValueColor)
	valuebutton:SetPoint("TOPLEFT",valuetypeselector,"BOTTOMLEFT",0,-5)
	--max selector
	local maxtypeselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["Max"],Tooltips["Max"],GetValueType)
	maxtypeselector:SetPoint("TOPLEFT",valuebutton,"BOTTOMLEFT",0,step)
	--max text editor button
	local maxbutton=NPA_Options.Template.CreateNumberTextEditorButton(page,200,20,Localization["Edit"]..Localization["Max"]..Localization["Font"],main)
	maxbutton:SetPoint("TOPLEFT",maxtypeselector,"BOTTOMLEFT",0,-5)
	--percentselector
	local GetPercentType=function()
		local atype={
			[5]={
				Text=Localization["DontShow"],
				Value=0,
			},
			[1]={
				Text=Localization["Percent"],
				Value=1,
			},
			[2]={
				Text=Localization["Percent"].."+"..Localization["Brackets"],
				Value=2,
			},
			[3]={
				Text=Localization["Percent"].."+"..Localization["PercentMark"],
				Value=3,
			},
			[4]={
				Text=Localization["Percent"].."+"..Localization["Brackets"].."+"..Localization["PercentMark"],
				Value=4,
			},
		}
		return atype
	end
	local percentselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["Percent"],Tooltips["Percent"],GetPercentType)
	percentselector:SetPoint("TOPLEFT",maxbutton,"BOTTOMLEFT",0,step)
	--percent text editor button
	local percentbutton=NPA_Options.Template.CreateNumberTextEditorButton(page,200,20,Localization["Edit"]..Localization["Percent"]..Localization["Font"],main,ValueColor)
	percentbutton:SetPoint("TOPLEFT",percentselector,"BOTTOMLEFT",0,-5)
	--preview
	local previewbg=page:CreateTexture(nil,"BACKGROUND")
	previewbg:SetTexture(0,0,0,1)
	previewbg:SetPoint("TOPLEFT",percentbutton,"BOTTOMLEFT",0,-5)
	previewbg:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT",-5,5)
	local preview1=NPA.NumberManager.CreateNumber(page)
	preview1:SetPoint("TOPLEFT",percentbutton,"BOTTOMLEFT",0,-10)
	preview1:Show()
	--minslider
	local maxslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,10,1000000000,1,0,Localization["PreviewMax"])
	maxslider:SetPoint("BOTTOMLEFT",page,"BOTTOMLEFT",5,5)
	NPA_Options.Template.SetSliderEdit(maxslider,100000000)
	local minslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,1000,1,0,Localization["PreviewValue"])
	minslider:SetPoint("BOTTOMLEFT",maxslider,"TOPLEFT",0,-step)
	NPA_Options.Template.SetSliderEdit(minslider,5000000)
	--function
	local SetPreview=function()
		NPA.NumberManager.SetNumber(preview1,minslider.Value,maxslider.Value)
	end
	--
	maxslider.OnValueUpdateFunc=function()
		NPA_Options.Template.SetSliderEdit(minslider,nil,nil,maxslider.Value)
		SetPreview()
	end
	minslider.OnValueUpdateFunc=SetPreview
	--
	local RefreshPreview=function()
		NPA_Options.HideTemplates()
		--
		local setting={}
		setting.ValueType=valuetypeselector.Value
		setting.ValueTextData=valuebutton.Value
		setting.MaxType=maxtypeselector.Value
		setting.MaxTextData=maxbutton.Value
		setting.PercentType=percentselector.Value
		setting.PercentTextData=percentbutton.Value
		setting.MinColor=mincolorbutton.Value
		setting.MaxColor=maxcolorbutton.Value

		NPA.NumberManager.UpdateNumber(preview1,setting,0)
	end
	--
	local LoadData=function(default)
		--page
		if(default)then
			entry=NPA.SettingManager.GetDefault("Number")["Default"]
		else
			entry=NPA_Setting.Number[EntryName]
		end
		--value type
		local value=entry.ValueType
		NPA_Options.Template.SetDropDownEditor(valuetypeselector,value)
		--value text data
		local value=entry.ValueTextData
		valuebutton.Value=CopyTable(value)
		--max type
		local value=entry.MaxType
		NPA_Options.Template.SetDropDownEditor(maxtypeselector,value)
		--max text data
		local value=entry.MaxTextData
		maxbutton.Value=CopyTable(value)
		--percent type
		local value=entry.PercentType
		NPA_Options.Template.SetDropDownEditor(percentselector,value)
		--max text data
		local value=entry.PercentTextData
		percentbutton.Value=CopyTable(value)
		--min color
		local value=entry.MinColor
		NPA_Options.Template.SetColorButton(mincolorbutton,value)
		--max color
		local value=entry.MaxColor
		NPA_Options.Template.SetColorButton(maxcolorbutton,value)
		--
		RefreshPreview()
	end
	local SaveData=function()
		NPA_Options.HideTemplates()
		--
		local entry=NPA_Setting.Number[EntryName]
		--value type
		entry.ValueType=valuetypeselector.Value
		--value text data
		entry.ValueTextData=CopyTable(valuebutton.Value)
		--max type
		entry.MaxType=maxtypeselector.Value
		--max text data
		entry.MaxTextData=CopyTable(maxbutton.Value)
		--percent type
		entry.PercentType=percentselector.Value
		--max text data
		entry.PercentTextData=CopyTable(percentbutton.Value)
		--min color
		entry.MinColor=CopyTable(mincolorbutton.Value)
		--max color
		entry.MaxColor=CopyTable(maxcolorbutton.Value)
		--fire event
		NPA.EventHandler.FireEvent(6,"Resources_ProfileRefresh")
		--
		NPA_Options.RunFunc(OnSaveFunc)
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
	valuetypeselector.OnValueUpdateFunc=RefreshPreview
	valuebutton.OnValueUpdateFunc=RefreshPreview
	maxtypeselector.OnValueUpdateFunc=RefreshPreview
	maxbutton.OnValueUpdateFunc=RefreshPreview
	percentselector.OnValueUpdateFunc=RefreshPreview
	percentbutton.OnValueUpdateFunc=RefreshPreview
	mincolorbutton.OnValueUpdateFunc=RefreshPreview
	maxcolorbutton.OnValueUpdateFunc=RefreshPreview
	--
	main.OnSetFunc=function(entryname,onsavefunc)
		EntryName=entryname
		OnSaveFunc=onsavefunc
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("NumberEditor",main)

end)