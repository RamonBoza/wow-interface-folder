-- Author      : Nogarder
-- Create Date : 2013/6/6 15:59:06
NPA_Options.RegisterPageFunc("TrackerConditionEditor",function()

	local pairs=pairs
	local CopyTable=CopyTable
	local table_insert=table.insert
	local table_getn=table.getn
	--
	local Localization=NPA_Options.Localization.PagesTracker
	local Tooltips=Localization.Tooltips
	--
	local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["Condition"],210,390,nil,nil,nil)
	main:Hide()
	local page=main.Frame
	--
	--elements
	local step=-20
	local Entry
	local NameplateList={}
	--save
	local savebutton=NPA_Options.Template.CreateSpecialButton(page,66,15,"Save")
	savebutton:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	--reset
	local resetbutton=NPA_Options.Template.CreateSpecialButton(page,66,15,"Reset")
	resetbutton:SetPoint("TOPRIGHT",page,"TOPRIGHT",-5,-5)
	--cancel
	local cancelbutton=NPA_Options.Template.CreateSpecialButton(page,66,15,"Cancel")
	cancelbutton:SetPoint("LEFT",savebutton,"RIGHT",5,0)
	cancelbutton:SetPoint("RIGHT",resetbutton,"LEFT",-5,0)
	--hide when conflict checkbox
	local hidewhenconflictcheckbox=NPA_Options.Template.CreateCheckBox(page,200,20,Localization["HideWhenConflict"])
	hidewhenconflictcheckbox:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,step)
	--friendly checkbox
	local friendlycheckbox=NPA_Options.Template.CreateCheckBox(page,200,20,Localization["Friendly"])
	friendlycheckbox:SetPoint("TOPLEFT",hidewhenconflictcheckbox,"BOTTOMLEFT",0,step)
	--neutral checkbox
	local neutralcheckbox=NPA_Options.Template.CreateCheckBox(page,200,20,Localization["Neutral"])
	neutralcheckbox:SetPoint("TOPLEFT",friendlycheckbox,"BOTTOMLEFT",0,step)
	--hostile checkbox
	local hostilecheckbox=NPA_Options.Template.CreateCheckBox(page,200,20,Localization["Hostile"])
	hostilecheckbox:SetPoint("TOPLEFT",neutralcheckbox,"BOTTOMLEFT",0,step)
	--using extra module checkbox
	local extramodulecheckbox=NPA_Options.Template.CreateCheckBox(page,200,20,Localization["ExtraModule"])
	NPA_Options.Template.SetTooltips(Tooltips["ExtraModule"],extramodulecheckbox)
	extramodulecheckbox:SetPoint("TOPLEFT",hostilecheckbox,"BOTTOMLEFT",0,step)
	--
	local GetConditionTypeList=function()
		return Localization.ConditionTypeList
	end
	--conditiontype selector
	local conditiontypeselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["ConditionType"],Tooltips["ConditionType"],GetConditionTypeList)
	conditiontypeselector:SetPoint("TOPLEFT",extramodulecheckbox,"BOTTOMLEFT",0,step)
	--
	local GetArgList=function()
		if(conditiontypeselector.Value=="1" or conditiontypeselector.Value=="2")then
			return Localization.UnitArgumentList
		else
			return {}
		end
	end
	--arg selector
	local argselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["Arg"],Tooltips["Arg"],GetArgList)
	argselector:SetPoint("TOPLEFT",conditiontypeselector,"BOTTOMLEFT",0,step)
	argselector.ParentPage=main
	--profile
	local GetProfileList=function()
		local list={}
		for name,_ in pairs(NPA_Setting.NamePlate)do
			table_insert(list,{Text=name,Value=name})
		end
		return list
	end
	---profile selector
	local profileselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["Profile"],Tooltips["Profile"],GetProfileList,20)
	profileselector:SetPoint("TOPLEFT",argselector,"BOTTOMLEFT",0,step)
	---group slider
	local groupslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,100,1,1,Localization["Group"],Tooltips["Group"])
	groupslider:SetPoint("TOPLEFT",profileselector,"BOTTOMLEFT",0,step)
	--
	local RefreshEditor=function()
		if(conditiontypeselector.Value=="1" or conditiontypelist=="2")then
			argselector.IsSpellPicker=false
			argselector.FreeEdit=false
		else
			if(conditiontypeselector.Value=="3" or conditiontypeselector.Value=="6" or conditiontypeselector.Value=="7")then
				argselector.IsSpellPicker=true
			else
				argselector.IsSpellPicker=false
			end
			argselector.FreeEdit=true
		end
		NPA_Options.Template.SetDropDownEditor(argselector,Entry.Arg,nil)
	end
	--
	conditiontypeselector.OnValueUpdateFunc=RefreshEditor
	--
	local LoadData=function(default)
		local entry
		if(default)then
			--get default directly from setting manager
			entry=NPA.SettingManager.GetDefault("TrackerCondition")
		else
			entry=Entry
		end
		--friendly
		local value=entry.Friendly
		NPA_Options.Template.SetCheckBox(friendlycheckbox,value)
		--neutral
		local value=entry.Neutral
		NPA_Options.Template.SetCheckBox(neutralcheckbox,value)
		--hostile
		local value=entry.Hostile
		NPA_Options.Template.SetCheckBox(hostilecheckbox,value)
		--hide when conflict
		local value=entry.HideWhenConflict
		NPA_Options.Template.SetCheckBox(hidewhenconflictcheckbox,value)
		--conditiontype selector
		local value=entry.ConditionType
		NPA_Options.Template.SetDropDownEditor(conditiontypeselector,value)
		--arg selector
		local value=entry.Arg
		NPA_Options.Template.SetDropDownEditor(argselector,value)
		--groupslider
		local value=entry.Group
		NPA_Options.Template.SetSliderEdit(groupslider,value)
		--profile
		local value=entry.Profile
		NPA_Options.Template.SetDropDownEditor(profileselector,value)
		--extra module
		local value=entry.EnableExtraModule
		NPA_Options.Template.SetCheckBox(extramodulecheckbox,value)	
	end
	--
	local SaveData=function()
		--friendly
		Entry.Friendly=friendlycheckbox.Checked
		--neutral
		Entry.Neutral=neutralcheckbox.Checked
		--hostile
		Entry.Hostile=hostilecheckbox.Checked
		--hide when conflict
		Entry.HideWhenConflict=hidewhenconflictcheckbox.Checked
		--conditiontype selector
		Entry.ConditionType=conditiontypeselector.Value
		--arg selector
		Entry.Arg=argselector.Value
		--profile
		Entry.Profile=profileselector.Value
		--group
		Entry.Group=groupslider.Value
		--extra module
		Entry.EnableExtraModule=extramodulecheckbox.Checked
		--fire event
		NPA.EventHandler.FireEvent(6,"Tracker_SettingUpdated")
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
	main.OnSetFunc=function(entryname)
		Entry=NPA_Setting.Tracker.Condition[entryname]
		--
		LoadData()
		RefreshEditor()
	end
	--
	NPA_Options.RegisterPage("TrackerConditionEditor",main)
end)