-- Author      : Nogarder
-- Create Date : 2013/4/20 14:45:22
NPA_Options.RegisterPageFunc("ExtraArrowEditor",function()

	local pairs=pairs
	local CopyTable=CopyTable
	local table_insert=table.insert
	local table_getn=table.getn
	--
	local Localization=NPA_Options.Localization.PagesTargetArrowEditor
	local Tooltips=Localization.Tooltips
	--
	local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["ExtraArrowEdit"],420,440,nil,nil,nil)
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
	--To unit editor
	local touniteditorlabel=NPA_Options.Template.CreateText(page,Localization["ToUnit"])
	touniteditorlabel:SetPoint("TOPLEFT",textureselector,"BOTTOMLEFT",0,step)
	--
	local touniteditor=NPA_Options.Template.CreateEditBox(page,200,20)
	touniteditor:SetPoint("TOPLEFT",touniteditorlabel,"BOTTOMLEFT",0,-2)
	NPA_Options.Template.SetTooltips(Tooltips["ToUnit"],touniteditor,nil,2)
	--max per line slider
	local maxperlineslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,20,1,1,Localization["MaxPerLine"],Tooltips["MaxPerLine"])
	maxperlineslider:SetPoint("TOPLEFT",touniteditor,"BOTTOMLEFT",0,step)
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
	local alphaslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,1,0.01,1,"Alpha",true)
	alphaslider:SetPoint("TOPLEFT",framelevelslider,"BOTTOMLEFT",0,step)
	--
	--right half of page
	--start size slider
	local startsizeslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,100,1,10,Localization["StartSize"],Tooltips["StartSize"])
	startsizeslider:SetPoint("BOTTOMLEFT",touniteditor,"BOTTOMRIGHT",10,0)
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
	local colorbutton=NPA_Options.Template.CreateColorButton(page,200,20,Localization["Color"],main)
	colorbutton:SetPoint("TOPLEFT",alphaslider,"BOTTOMLEFT",0,step)
	--endcolor
	local endcolorbutton=NPA_Options.Template.CreateColorButton(page,200,20,Localization["EndColor"],main)
	endcolorbutton:SetPoint("LEFT",colorbutton,"RIGHT",5,0)
	--preview
	local previewframe=NPA_Options.Template.CreateAnchorPreview(page)
	previewframe:SetPoint("LEFT",alphaslider,"LEFT")
	previewframe:SetPoint("TOP",colorbutton,"BOTTOM",0,-5)
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
			Alpha=1,
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
			entry=NPA.SettingManager.GetDefaultProfile("Default")["Default"]["ExtraArrow"][EntryName] or NPA.SettingManager.GetDefault("ExtraArrow")
		else
			entry=Entry
		end
		--texture selector
		local value=entry.TextureFileName
		NPA_Options.Template.SetDropDownEditor(textureselector,value)
		--from selector
		local value=entry.ToUnit
		touniteditor:SetText(value)
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
		NPA_Options.Template.SetColorButton(colorbutton,entry.Color)
		local value=entry.EndColor
		NPA_Options.Template.SetColorButton(endcolorbutton,entry.Color)
		--
		SetPreview()
	end
	--
	local SaveData=function()
		--texture selector
		Entry.TextureFileName=textureselector.Value
		--from selector
		Entry.ToUnit=tostring(touniteditor:GetText() or "")
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
		--fire event
		NPA.EventHandler.FireEvent(6,"ExtraArrow_SettingUpdated")
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
		Entry=NPA_Setting.ExtraArrow[entryname]
		EntryName=entryname or ""
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("ExtraArrowEditor",main)
end)