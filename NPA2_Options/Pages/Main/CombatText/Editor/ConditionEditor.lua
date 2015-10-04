-- Author      : Nogarder
-- Create Date : 2013/4/24 13:43:16
NPA_Options.RegisterPageFunc("CombatTextConditionEditor",function()

	local pairs=pairs
	local CopyTable=CopyTable
	local table_insert=table.insert
	local table_getn=table.getn
	--
	local Localization=NPA_Options.Localization.PagesCombatText
	local Tooltips=Localization.Tooltips
	--
	local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["Condition"],1010,500,nil,nil,nil)
	main:Hide()
	local page=main.Frame
	--
	--elements
	local step=-20
	local Entry
	local CheckList={}
	local CheckList2={}
	local SpellList={}
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
	--animation selector
	local GetAnimationList=function()
		local data={}
		for name,_ in pairs(NPA_Setting.CombatText.Animation)do
			table_insert(data,{Text=name,Value=name})
		end
		return data
	end
	--from selector
	local animationselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["Animation"],Tooltips["Animation"],GetAnimationList)
	animationselector:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,step)
	--
	local GetFromToList=function()
		return Localization.FromToList
	end
	--from selector
	local fromselector=NPA_Options.Template.CreateDropDownEditor(page,97,Localization["From"],Tooltips["From"],GetFromToList)
	fromselector:SetPoint("TOPLEFT",animationselector,"BOTTOMLEFT",0,step)
	--from name editbox
	local fromnamelabel=NPA_Options.Template.CreateText(page,Localization["Name"])
	fromnamelabel:SetPoint("TOPLEFT",animationselector,"BOTTOMLEFT",103,-3)
	local fromnameeditbox=NPA_Options.Template.CreateEditBox(page,97,20)
	fromnameeditbox:SetPoint("TOPLEFT",fromnamelabel,"BOTTOMLEFT",0,-2)
	NPA_Options.Template.SetTooltips(Tooltips["Name"],fromnameeditbox)
	local fromnameexactcheckbox=NPA_Options.Template.CreateCheckBox(page,50,15,Localization["Exact"],Tooltips["Exact"])
	fromnameexactcheckbox:SetPoint("TOPRIGHT",animationselector,"BOTTOMLEFT",200,-3)
	--to selector
	local toselector=NPA_Options.Template.CreateDropDownEditor(page,97,Localization["To"],Tooltips["To"],GetFromToList)
	toselector:SetPoint("TOPLEFT",fromselector,"BOTTOMLEFT",0,step)
	--to name editbox
	local tonamelabel=NPA_Options.Template.CreateText(page,Localization["Name"])
	tonamelabel:SetPoint("TOPLEFT",fromselector,"BOTTOMLEFT",103,-3)
	local tonameeditbox=NPA_Options.Template.CreateEditBox(page,97,20)
	tonameeditbox:SetPoint("TOPLEFT",tonamelabel,"BOTTOMLEFT",0,-2)
	NPA_Options.Template.SetTooltips(Tooltips["Name"],tonameeditbox)
	local tonameexactcheckbox=NPA_Options.Template.CreateCheckBox(page,50,15,Localization["Exact"],Tooltips["Exact"])
	tonameexactcheckbox:SetPoint("TOPRIGHT",fromselector,"BOTTOMLEFT",200,-3)
	--crit selector
	local GetCritList=function()
		return Localization.CritList
	end
	local critselector=NPA_Options.Template.CreateDropDownEditor(page,97,Localization["Critical"],Tooltips["Critical"],GetCritList)
	critselector:SetPoint("TOPLEFT",toselector,"BOTTOMLEFT",0,step)
	--multistrike selector
	local GetMultiStrikeList=function()
		return Localization.MultiStrikeList
	end
	local multistrikeselector=NPA_Options.Template.CreateDropDownEditor(page,97,Localization["MultiStrike"],Tooltips["MultiStrike"],GetMultiStrikeList)
	multistrikeselector:SetPoint("TOPLEFT",toselector,"BOTTOMLEFT",103,step)
	--offset x slider
	local offsetxslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,-100,100,1,0,Localization["OffsetX"],Tooltips["OffsetX"])
	offsetxslider:SetPoint("TOPLEFT",critselector,"BOTTOMLEFT",0,step)
	--offset y slider
	local offsetyslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,-100,100,1,0,Localization["OffsetY"],Tooltips["OffsetY"])
	offsetyslider:SetPoint("TOPLEFT",offsetxslider,"BOTTOMLEFT",0,step)
	--font
	local fontselector=NPA_Options.Template.CreateFontEditorButton(page,main,77)
	fontselector:SetPoint("TOPLEFT",offsetyslider,"BOTTOMLEFT",0,step)
	--
	local GetValueType=function()
		local atype={
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
			[4]={
				Text=Localization["ShortAndDecimal"],
				Value=4,
			},
		}
		return atype
	end
	local numbertypeselector=NPA_Options.Template.CreateDropDownEditor(page,77,Localization["NumberType"],Tooltips["NumberType"],GetValueType)
	numbertypeselector:SetPoint("LEFT",fontselector,"RIGHT",65,0)
	--text width slider
	local textwidthslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,100,1,0,Localization["TextWidth"],Tooltips["TextWidth"])
	textwidthslider:SetPoint("TOPLEFT",fontselector,"BOTTOMLEFT",0,step)
	--text height slider
	local textheightslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,100,1,1,Localization["TextHeight"],Tooltips["TextHeight"])
	textheightslider:SetPoint("TOPLEFT",textwidthslider,"BOTTOMLEFT",0,step)
	--text type selector
	local GetTextType=function()
		return Localization.TextType
	end
	local texttypeselector=NPA_Options.Template.CreateDropDownEditor(page,77,Localization["DetailedType"],Tooltips["DetailedType"],GetTextType)
	texttypeselector:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",210,step)
	--font
	local fontselector2=NPA_Options.Template.CreateFontEditorButton(page,main,77)
	fontselector2:SetPoint("LEFT",texttypeselector,"RIGHT",25,0)
	--detail width slider
	local detailwidthslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,100,1,0,Localization["DetailWidth"],Tooltips["DetailWidth"])
	detailwidthslider:SetPoint("TOPLEFT",texttypeselector,"BOTTOMLEFT",0,step)
	--text height slider
	local detailheightslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,100,1,1,Localization["DetailHeight"],Tooltips["DetailHeight"])
	detailheightslider:SetPoint("TOPLEFT",detailwidthslider,"BOTTOMLEFT",0,step)
	--iconsize slider
	local iconsizeslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,100,1,1,Localization["IconSize"],Tooltips["IconSize"])
	iconsizeslider:SetPoint("TOPLEFT",detailheightslider,"BOTTOMLEFT",0,step)
	--bgtexture
	local bgtextureselector=NPA_Options.Template.CreateTextureSelectorButton(page,main,160)
	bgtextureselector:SetPoint("TOPLEFT",iconsizeslider,"BOTTOMLEFT",0,step)
	--bg width slider
	local bgwidthslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,-10,10,1,0,Localization["BGWidth"],Tooltips["BGWidth"])
	bgwidthslider:SetPoint("TOPLEFT",bgtextureselector,"BOTTOMLEFT",0,step)
	--bg height slider
	local bgheightslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,-10,10,1,1,Localization["BGHeight"],Tooltips["BGHeight"])
	bgheightslider:SetPoint("TOPLEFT",bgwidthslider,"BOTTOMLEFT",0,step)
	--bgcolor
	local bgcolorbutton=NPA_Options.Template.CreateColorButton(page,200,20,nil,main)
	bgcolorbutton:SetPoint("TOPLEFT",bgheightslider,"BOTTOMLEFT",0,step)
	--
	--ignore overkill checkbox
	local ignoreoverkillcheckbox=NPA_Options.Template.CreateCheckBox(page,200,20,Localization["IgnoreOverkill"],Tooltips["IgnoreOverkill"])
	ignoreoverkillcheckbox:SetPoint("TOPLEFT",fontselector2,"TOPRIGHT",65,0)
	--freefloat checkbox
	local freefloatcheckbox=NPA_Options.Template.CreateCheckBox(page,200,20,Localization["FreeFloat"],Tooltips["FreeFloat"])
	freefloatcheckbox:SetPoint("TOPLEFT",ignoreoverkillcheckbox,"BOTTOMLEFT",0,step)
	--hide with parent checkbox
	local hidewithparentcheckbox=NPA_Options.Template.CreateCheckBox(page,200,20,Localization["HideWithParent"],Tooltips["HideWithParent"])
	hidewithparentcheckbox:SetPoint("TOPLEFT",freefloatcheckbox,"BOTTOMLEFT",0,step)
	--spelllisttype 
	local GetSpellListType=function()
		return Localization.SpellListTypeList
	end
	local spelllisttypeselector=NPA_Options.Template.CreateDropDownEditor(page,97,Localization["SpellListType"],Tooltips["SpellListType"],GetSpellListType)
	spelllisttypeselector:SetPoint("TOPLEFT",hidewithparentcheckbox,"BOTTOMLEFT",0,step)
	----adjust framelevel, no better solution yet
	--spelllisttypeselector:SetFrameLevel(checkboxlist.Scroll:GetFrameLevel()+3)
	--edit spelllist
	local editspelllistbutton=NPA_Options.Template.CreateButton(page,97,20,Localization["EditSpellList"])
	editspelllistbutton:SetPoint("LEFT",spelllisttypeselector,"RIGHT",25,0)
	--editspelllistbutton:SetFrameLevel(checkboxlist.Scroll:GetFrameLevel()+3)
	--
	editspelllistbutton:HookScript("OnMouseUp",function()
		NPA_Options.SetPage("SpellListEditor",main,SpellList,function(name,checked)
			SpellList[name]=checked
		end)
	end)
	--right half of the page
	--checkbox list
	local checkboxlist=NPA_Options.Template.CreateCheckBoxList(page,180,320)
	checkboxlist.Scroll:SetPoint("TOPLEFT",ignoreoverkillcheckbox,"TOPRIGHT",10,0)
	
	NPA_Options.Template.SetCheckBoxList(checkboxlist,20,function(name,value)
			CheckList[name]=value
		end,
		nil,
		nil	)
	--
	local checkboxlist2=NPA_Options.Template.CreateCheckBoxList(page,140,320)
	checkboxlist2.Scroll:SetPoint("TOPLEFT",checkboxlist.Scroll,"TOPRIGHT",25,0)
	NPA_Options.Template.SetCheckBoxList(checkboxlist2,20,function(name,value)
			CheckList2[name]=value
		end,
		nil,
		nil)
	--preview
	local previewframe=CreateFrame("Frame",nil,page)
	previewframe:SetHeight(100)
	previewframe:SetPoint("BOTTOMLEFT",page,"BOTTOMLEFT",5,5)
	previewframe:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT",-5,5)
	--
	local previewbg=previewframe:CreateTexture(nil,"BACKGROUND")
	previewbg:SetPoint("TOPLEFT",previewframe,"TOPLEFT")
	previewbg:SetPoint("BOTTOMRIGHT",previewframe,"BOTTOMRIGHT")
	previewbg:SetTexture(0,0,0,0.25)
	--
	--NPA.CombatTextManager.AddText=function(parent,icon,text,school,setting,animation)
	local PreviewAnimation={
		[1]={
			SpeedType=0, --0=fixed ,1=vertical random, 2=horizonal random, 4=double random
			SpeedX=0,
			SpeedY=0,
			AccType=0,--0=fixed ,1=vertical random, 2=horizonal random, 4=double random
			AccX=0,
			AccY=0,
			StartAlpha=1,
			EndAlpha=1,
			StartSize=1,
			EndSize=1,
			ShakeRange=0,
			Lasts=1,
			FrameLevel=previewframe:GetFrameLevel()+3
		}
	}
	--
	local timer=0
	page:HookScript("OnUpdate",function(_,elapse)
		timer=timer+elapse
		if(timer>1)then
			timer=0
			--
			local entry={
				IconSize=iconsizeslider.Value,
				TextWidth=textwidthslider.Value,
				TextHeight=textheightslider.Value,
				TextFileName=fontselector.Value,
				--NumberType=numbertypeselector.Value,
				DetailWidth=detailwidthslider.Value,
				DetailHeight=detailheightslider.Value,
				DetailFileName=fontselector2.Value,
				BGWidth=bgwidthslider.Value,
				BGHeight=bgheightslider.Value,
				BGFileName=bgtextureselector.Value,
				BGColor=bgcolorbutton.Value,
			}
			--
			local icon="Interface\\Icons\\Trade_Engineering"
			--
			local text=NPA.NumberManager.GetNumber2(floor(random()*100000000),numbertypeselector.Value)
			local detail="(Detailed text)"
			--
			local school=math.pow(2,floor(random()*7))
			--set it
			NPA.CombatTextManager.AddText(previewframe,icon,text,detail,school,entry,PreviewAnimation)
		end
	end)
	--
	local UpdateCheckList=function()
		NPA_Options.Template.UpdateCheckBoxList(checkboxlist,CheckList,Localization["EventLocalization"])
	end
	local UpdateCheckList2=function()
		NPA_Options.Template.UpdateCheckBoxList(checkboxlist2,CheckList2,Localization["SpecialEventLocalization"],Localization["SpecialEventLocalizationTooltips"])
	end
	--
	local LoadData=function(default)
		--
		local entry
		if(default)then
			--get default directly from setting manager
			entry=NPA.SettingManager.GetDefault("CombatTextCondition")
		else
			entry=Entry
		end
		--animation
		local value=entry.AnimationName
		NPA_Options.Template.SetDropDownEditor(animationselector,value)
		--from selector
		local value=entry.From
		NPA_Options.Template.SetDropDownEditor(fromselector,value)
		--from name editbox
		local value=entry.FromName
		fromnameeditbox:SetText(value)
		local value=entry.FromExact
		NPA_Options.Template.SetCheckBox(fromnameexactcheckbox,value)
		--to selector
		local value=entry.To
		NPA_Options.Template.SetDropDownEditor(toselector,value)
		--to name editbox
		local value=entry.ToName
		tonameeditbox:SetText(value)
		local value=entry.ToExact
		NPA_Options.Template.SetCheckBox(tonameexactcheckbox,value)
		--crittype
		local value=entry.CritType
		NPA_Options.Template.SetDropDownEditor(critselector,value)
		--multistriketype
		local value=entry.MultiStrikeType
		NPA_Options.Template.SetDropDownEditor(multistrikeselector,value)
		--offset x
		local value=entry.OffsetX
		NPA_Options.Template.SetSliderEdit(offsetxslider,value)
		--offset y
		local value=entry.OffsetY
		NPA_Options.Template.SetSliderEdit(offsetyslider,value)
		--iconsize slider
		local value=entry.IconSize
		NPA_Options.Template.SetSliderEdit(iconsizeslider,value)
		--text file
		local value=entry.TextFileName
		NPA_Options.Template.SetDropDownEditor(fontselector,value)
		--text width slider
		local value=entry.TextWidth
		NPA_Options.Template.SetSliderEdit(textwidthslider,value)
		--text height slider
		local value=entry.TextHeight
		NPA_Options.Template.SetSliderEdit(textheightslider,value)
		--number type
		local value=entry.NumberType
		NPA_Options.Template.SetDropDownEditor(numbertypeselector,value)
		--detail font
		local value=entry.DetailFileName
		NPA_Options.Template.SetDropDownEditor(fontselector2,value)
		--detail width slider
		local value=entry.DetailWidth
		NPA_Options.Template.SetSliderEdit(detailwidthslider,value)
		--detail height slider
		local value=entry.DetailHeight
		NPA_Options.Template.SetSliderEdit(detailheightslider,value)
		--text type selector
		local value=entry.TextType
		NPA_Options.Template.SetDropDownEditor(texttypeselector,value)
		--bg file
		local value=entry.BGFileName
		NPA_Options.Template.SetDropDownEditor(bgtextureselector,value)
		--bg width slider
		local value=entry.BGWidth
		NPA_Options.Template.SetSliderEdit(bgwidthslider,value)
		--bg height slider
		local value=entry.BGHeight
		NPA_Options.Template.SetSliderEdit(bgheightslider,value)
		--bgcolor
		local value=entry.BGColor
		NPA_Options.Template.SetColorButton(bgcolorbutton,value)
		--combat event checklist
		CheckList=CopyTable(entry.EventList)
		CheckList2=CopyTable(entry.SpecialEventList)
		--spelllisttype
		local value=entry.SpellListType
		NPA_Options.Template.SetDropDownEditor(spelllisttypeselector,value)
		--spell list
		SpellList=CopyTable(entry.SpellList)
		--ignore overkill
		local value=entry.IgnoreOverkill
		NPA_Options.Template.SetCheckBox(ignoreoverkillcheckbox,value)
		--freefloat
		local value=entry.FreeFloat
		NPA_Options.Template.SetCheckBox(freefloatcheckbox,value)
		--freefloat
		local value=entry.HideWithParent
		NPA_Options.Template.SetCheckBox(hidewithparentcheckbox,value)
		--
		UpdateCheckList()
		UpdateCheckList2()
		--
	end
	--
	local SaveData=function()
		--animation
		Entry.AnimationName=animationselector.Value
		--from selector
		Entry.From=fromselector.Value
		--from name editbox
		Entry.FromName=fromnameeditbox:GetText() or ""
		Entry.FromExact=fromnameexactcheckbox.Checked
		--to selector
		Entry.To=toselector.Value
		--to name editbox
		Entry.ToName=tonameeditbox:GetText() or ""
		Entry.ToExact=tonameexactcheckbox.Checked
		--crittype
		Entry.CritType=critselector.Value
		--multistriketype
		Entry.MultiStrikeType=multistrikeselector.Value
		--offset x
		Entry.OffsetX=offsetxslider.Value
		--offsety
		Entry.OffsetY=offsetyslider.Value
		--iconsize slider
		IconSize=iconsizeslider.Value
		--text file
		Entry.TextFileName=fontselector.Value
		--text width slider
		Entry.TextWidth=textwidthslider.Value
		--text height slider
		Entry.TextHeight=textheightslider.Value
		--number type selector
		Entry.NumberType=numbertypeselector.Value
		--text type selector
		Entry.TextType=texttypeselector.Value
		--detail width
		Entry.DetailWidth=detailwidthslider.Value
		--detail height
		Entry.DetailHeight=detailheightslider.Value
		--detail font
		Entry.DetailFileName=fontselector2.Value
		--bg file
		Entry.BGFileName=bgtextureselector.Value
		--bg width slider
		Entry.BGWidth=bgwidthslider.Value
		--bg height slider
		Entry.BGHeight=bgheightslider.Value
		--bgcolor
		Entry.BGColor=CopyTable(bgcolorbutton.Value)
		--eventlist
		Entry.EventList=CopyTable(CheckList)
		Entry.SpecialEventList=CopyTable(CheckList2)
		--spelllist type
		Entry.SpellListType=spelllisttypeselector.Value
		--spelllist
		Entry.SpellList=CopyTable(SpellList)
		--ignore overkill
		Entry.IgnoreOverkill=ignoreoverkillcheckbox.Checked
		--free float
		Entry.FreeFloat=freefloatcheckbox.Checked
		--hide with parent
		Entry.HideWithParent=hidewithparentcheckbox.Checked
		--fire event
		NPA.EventHandler.FireEvent(6,"CombatText_SettingUpdated")
	end
	--
	savebutton:HookScript("OnMouseUp",function()
		NPA_Options.Animation.ShowFrame(main)
		SaveData()
	end)
	cancelbutton:HookScript("OnMouseUp",function()
		NPA_Options.ClosePages(main)
		NPA_Options.Animation.ShowFrame(main)
		LoadData()
	end)
	resetbutton:HookScript("OnMouseUp",function()
		NPA_Options.ClosePages(main)
		NPA_Options.Animation.ShowFrame(main)
		LoadData(true)
	end)
	--
	main.OnSetFunc=function(entryname)
		Entry=NPA_Setting.CombatText.Condition[entryname]
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("CombatTextConditionEditor",main)
end)