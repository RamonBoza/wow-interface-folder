-- Author      : Nogarder
-- Create Date : 2013/4/20 14:45:22
NPA_Options.RegisterPageFunc("TargetArrowEditor",function()

	local pairs=pairs
	local CopyTable=CopyTable
	local table_insert=table.insert
	local table_getn=table.getn
	--
	local Localization=NPA_Options.Localization.PagesTargetArrowEditor
	local Tooltips=Localization.Tooltips
	--
	local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["TargetArrowEdit"],420,490,nil,nil,nil)
	main:Hide()
	local page=main.Frame
	--
	--elements
	local step=-20
	local Entry
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
	--texture selector
	local textureselector=NPA_Options.Template.CreateTextureSelectorButton(page,main,370)
	textureselector:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,step)
	--
	local GetFromToList=function()
		return Localization.FromToList
	end
	--from selector
	local fromselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["From"],Tooltips["From"],GetFromToList)
	fromselector:SetPoint("TOPLEFT",textureselector,"BOTTOMLEFT",0,step)
	--to selector
	local toselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["To"],Tooltips["To"],GetFromToList)
	toselector:SetPoint("TOPLEFT",fromselector,"BOTTOMLEFT",0,step)
	--max per line slider
	local maxperlineslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,20,1,1,Localization["MaxPerLine"],Tooltips["MaxPerLine"])
	maxperlineslider:SetPoint("TOPLEFT",toselector,"BOTTOMLEFT",0,step)
	--gap slider
	local gapslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,100,1,1,Localization["Gap"],Tooltips["Gap"])
	gapslider:SetPoint("TOPLEFT",maxperlineslider,"BOTTOMLEFT",0,step)
	--speed per second slider
	local speedslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,10,1,1,Localization["SpeedPerSecond"],Tooltips["SpeedPerSecond"])
	speedslider:SetPoint("TOPLEFT",gapslider,"BOTTOMLEFT",0,step)
	--framelevel
	local framelevelslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,255,1,0,"Layer",true)
	framelevelslider:SetPoint("TOPLEFT",speedslider,"BOTTOMLEFT",0,step)
	--alpha slider
	local alphaslider=NPA_Options.Template.CreateSpecialSliderEdit(page,95,35,20,0,1,0.01,1,"Alpha",true)
	alphaslider:SetPoint("TOPLEFT",framelevelslider,"BOTTOMLEFT",0,step)
	--fadealpha slider
	local fadealphaslider=NPA_Options.Template.CreateSliderEdit(page,95,35,20,0,1,0.01,1,Localization["FadeAlpha"],Tooltips["FadeAlpha"])
	fadealphaslider:SetPoint("LEFT",alphaslider,"RIGHT",5,0)
	--liftime
	local lifetimeslider=NPA_Options.Template.CreateSliderEdit(page,95,35,20,0,1,0.01,1,Localization["LifeTime"],Tooltips["LifeTime"])
	lifetimeslider:SetPoint("LEFT",fadealphaslider,"RIGHT",5,0)

	--right half of page
	--start size slider
	local startsizeslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,100,1,10,Localization["StartSize"],Tooltips["StartSize"])
	startsizeslider:SetPoint("BOTTOMLEFT",fromselector,"BOTTOMRIGHT",30,0)
	--end size slider
	local endsizeslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,100,1,10,Localization["EndSize"],Tooltips["EndSize"])
	endsizeslider:SetPoint("TOPLEFT",startsizeslider,"BOTTOMLEFT",0,step)
	--startoffsetx
	local startoffsetxslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,-40,40,1,0,Localization["StartOffsetX"],Tooltips["StartOffsetX"])
	startoffsetxslider:SetPoint("TOPLEFT",endsizeslider,"BOTTOMLEFT",0,step)
	--startoffsety
	local startoffsetyslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,-40,40,1,0,Localization["StartOffsetY"],Tooltips["StartOffsetY"])
	startoffsetyslider:SetPoint("TOPLEFT",startoffsetxslider,"BOTTOMLEFT",0,step)
	--endoffsetx
	local endoffsetxslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,-40,40,1,0,Localization["EndOffsetX"],Tooltips["EndOffsetX"])
	endoffsetxslider:SetPoint("TOPLEFT",startoffsetyslider,"BOTTOMLEFT",0,step)
	--endoffsety
	local endoffsetyslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,-40,40,1,0,Localization["EndOffsetY"],Tooltips["EndOffsetY"])
	endoffsetyslider:SetPoint("TOPLEFT",endoffsetxslider,"BOTTOMLEFT",0,step)
	
	--color
	local colorbutton=NPA_Options.Template.CreateColorButton(page,97,20,Localization["StartColor"],main)
	colorbutton:SetPoint("TOPLEFT",alphaslider,"BOTTOMLEFT",0,step)
	local endcolorbutton=NPA_Options.Template.CreateColorButton(page,97,20,Localization["EndColor"],main)
	endcolorbutton:SetPoint("LEFT",colorbutton,"RIGHT",5,0)
	--alpha with parent
	local alphawithparentbox=NPA_Options.Template.CreateCheckBox(page,200,20,Localization["AlphaWithParent"])
	alphawithparentbox:SetPoint("LEFT",endcolorbutton,"RIGHT",5,0)
	NPA_Options.Template.SetTooltips(Tooltips["AlphaWithParent"],alphawithparentbox)
	--range color
	local rangecolorbutton=NPA_Options.Template.CreateColorButton(page,97,20,Localization["RangeStartColor"],main)
	rangecolorbutton:SetPoint("TOPLEFT",colorbutton,"BOTTOMLEFT",0,step)
	local rangeendcolorbutton=NPA_Options.Template.CreateColorButton(page,97,20,Localization["RangeEndColor"],main)
	rangeendcolorbutton:SetPoint("LEFT",rangecolorbutton,"RIGHT",5,0)
	--range slider
	local rangeslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,40,1,0,Localization["RangeCheck"],Tooltips["RangeCheck"])
	rangeslider:SetPoint("LEFT",rangeendcolorbutton,"RIGHT",5,0)

	--preview
	local previewframe=NPA_Options.Template.CreateAnchorPreview(page)
	previewframe:SetPoint("TOPLEFT",rangecolorbutton,"BOTTOMLEFT",0,-5)
	previewframe:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT",-5,5)
	local previewarrow=NPA.ArrowManager.CreateArrow(previewframe)
	previewarrow:SetPoint("LEFT",previewframe,"LEFT",0,0)
	previewarrow.EndPoint:SetPoint("RIGHT",previewframe,"RIGHT",0,0)
	--script
	local SetPreview=function()
		local entry={
			--texture selector
			TextureFileName=textureselector.Value,
			--max per line slider
			MaxPerLine=maxperlineslider.Value,
			--gap slider
			Gap=gapslider.Value,
			--speed per second slider
			SpeedPerSecond=speedslider.Value,
			--right half of page
			--start size slider
			StartSize=startsizeslider.Value,
			--end size slider
			EndSize=endsizeslider.Value,
			--color
			Color=CopyTable(colorbutton.Value),
			EndColor=CopyTable(endcolorbutton.Value),
			--
			Alpha=alphaslider.Value,
			AlphaWithParent=true,
		}
		--update it
		NPA.ArrowManager.ManageArrow(previewarrow,entry,nil)
	end
	--
	local EntryName=""
	local LoadData=function(default)
		--
		local entry
		if(default)then
			--get default directly from setting manager
			entry=NPA.SettingManager.GetDefaultProfile("Default")["Default"]["TargetArrow"][EntryName] or NPA.SettingManager.GetDefault("TargetArrow")
		else
			entry=Entry
		end
		--texture selector
		local value=entry.TextureFileName
		NPA_Options.Template.SetDropDownEditor(textureselector,value)
		--from selector
		local value=entry.From
		NPA_Options.Template.SetDropDownEditor(fromselector,value)
		--to selector
		local value=entry.To
		NPA_Options.Template.SetDropDownEditor(toselector,value)
		--max per line slider
		local value=entry.MaxPerLine
		NPA_Options.Template.SetSliderEdit(maxperlineslider,value)
		--gap slider
		local value=entry.Gap
		NPA_Options.Template.SetSliderEdit(gapslider,value)
		--speed per second slider
		local value=entry.SpeedPerSecond
		NPA_Options.Template.SetSliderEdit(speedslider,value)
		--framelevel
		local value=entry.FrameLevel
		NPA_Options.Template.SetSliderEdit(framelevelslider,value)
		--alpha slider
		local value=entry.Alpha
		NPA_Options.Template.SetSliderEdit(alphaslider,value)
		--fade alpha slider
		local value=entry.FadeAlpha
		NPA_Options.Template.SetSliderEdit(fadealphaslider,value)
		--life time slider
		local value=entry.LifeTime
		NPA_Options.Template.SetSliderEdit(lifetimeslider,value)
		--right half of page
		--start size slider
		local value=entry.StartSize
		NPA_Options.Template.SetSliderEdit(startsizeslider,value)
		--end size slider
		local value=entry.EndSize
		NPA_Options.Template.SetSliderEdit(endsizeslider,value)
		--startoffsetx
		local value=entry.StartOffsetX
		NPA_Options.Template.SetSliderEdit(startoffsetxslider,value)
		--startoffsety
		local value=entry.StartOffsetY
		NPA_Options.Template.SetSliderEdit(startoffsetyslider,value)
		--endoffsetx
		local value=entry.EndOffsetX
		NPA_Options.Template.SetSliderEdit(endoffsetxslider,value)
		--endoffsety
		local value=entry.EndOffsetY
		NPA_Options.Template.SetSliderEdit(endoffsetyslider,value)
		--color button
		local value=entry.Color
		NPA_Options.Template.SetColorButton(colorbutton,value)
		local value=entry.EndColor
		NPA_Options.Template.SetColorButton(endcolorbutton,value)
		--
		local value=entry.AlphaWithParent
		NPA_Options.Template.SetCheckBox(alphawithparentbox,value)
		--
		local value=entry.RangeColor
		NPA_Options.Template.SetColorButton(rangecolorbutton,value)
		local value=entry.RangeEndColor
		NPA_Options.Template.SetColorButton(rangeendcolorbutton,value)
		--
		local value=entry.RangeCheck
		NPA_Options.Template.SetSliderEdit(rangeslider,value)
		--
		SetPreview()
	end
	--
	local SaveData=function()
		--texture selector
		Entry.TextureFileName=textureselector.Value
		--from selector
		Entry.From=fromselector.Value
		--to selector
		Entry.To=toselector.Value
		--max per line slider
		Entry.MaxPerLine=maxperlineslider.Value
		--gap slider
		Entry.Gap=gapslider.Value
		--speed per second slider
		Entry.SpeedPerSecond=speedslider.Value
		--framelevel
		Entry.FrameLevel=framelevelslider.Value
		--alpha slider
		Entry.Alpha=alphaslider.Value
		Entry.FadeAlpha=fadealphaslider.Value
		--life time
		Entry.LifeTime=lifetimeslider.Value
		--right half of page
		--start size slider
		Entry.StartSize=startsizeslider.Value
		--end size slider
		Entry.EndSize=endsizeslider.Value
		--startoffsetx
		Entry.StartOffsetX=startoffsetxslider.Value
		--startoffsety
		Entry.StartOffsetY=startoffsetyslider.Value
		--endoffsetx
		Entry.EndOffsetX=endoffsetxslider.Value
		--endoffsety
		Entry.EndOffsetY=endoffsetyslider.Value
		--
		Entry.Color=CopyTable(colorbutton.Value)
		Entry.EndColor=CopyTable(endcolorbutton.Value)
		--
		Entry.AlphaWithParent=alphawithparentbox.Checked
		--
		Entry.RangeColor=CopyTable(rangecolorbutton.Value)
		Entry.RangeEndColor=CopyTable(rangeendcolorbutton.Value)
		--
		Entry.RangeCheck=rangeslider.Value
		--fire event
		NPA.EventHandler.FireEvent(6,"TargetArrow_SettingUpdated")
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
	maxperlineslider.OnValueUpdateFunc=SetPreview
	gapslider.OnValueUpdateFunc=SetPreview
	speedslider.OnValueUpdateFunc=SetPreview
	alphaslider.OnValueUpdateFunc=SetPreview
	textureselector.OnValueUpdateFunc=SetPreview
	startsizeslider.OnValueUpdateFunc=SetPreview
	endsizeslider.OnValueUpdateFunc=SetPreview
	colorbutton.OnValueUpdateFunc=SetPreview
	--
	main.OnSetFunc=function(entryname)
		Entry=NPA_Setting.TargetArrow[entryname]
		EntryName=entryname or ""
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("TargetArrowEditor",main)
end)