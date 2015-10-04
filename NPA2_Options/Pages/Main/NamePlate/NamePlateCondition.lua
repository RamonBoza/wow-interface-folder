-- Author      : Nogarder
-- Create Date : 2013/4/10 10:28:43
NPA_Options.RegisterPageFunc("NamePlateCondition",function()

	local pairs=pairs
	local table_insert=table.insert
	local table_getn=table.getn
	local table_remove=table.remove
	--localization
	--basicly same as alpha condition, so using pages module list will do
	local Localization=NPA_Options.Localization.PagesModuleList
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	local Entry={}
	--
	local main=NPA_Options.Template.CreatePriorityEdit(parent,Localization["SelectProfile"],400,320,50,nil,nil)
	main:Hide()
	--
	local page=main.Frame
	local scroll=main.Scroll
	page.KeepDefault=true

	local GetConditionType=function()
		return Localization.NamePlateConditionType
	end
	--generate list by setting
	local GetProfileList=function()
		local list={}
		for name,_ in pairs(NPA_Setting.NamePlate)do
			table_insert(list,{Text=name,Value=name})
		end
		return list
	end
	--
	local GetConditionArgument={
		["Target"]=function()
			return Localization.TargetArgumentList
		end,
		["Summoned"]=function()
			return Localization.FactionArgumentList
		end,
		["Player"]=function()
			return Localization.FactionArgumentList
		end,
		["NonPlayer"]=function()
			return Localization.FactionArgumentList
		end,
		["Pet"]=function()
			return Localization.FactionArgumentList
		end,
		["Guardian"]=function()
			return Localization.FactionArgumentList
		end,
		["Classification"]=function()
			return Localization.ClassificationArgumentList
		end,
		["Role"]=function()
			return Localization.RoleArgumentList
		end,
		["Threat"]=function()
			local list={}
			for index,locale in pairs(NPA_Options.GetBasicTypeThreat())do
				table.insert(list,{
					Value=index,
					Text=locale
				})
			end
			return list
		end,
		["Casting"]=function()
			return Localization.TargetArgumentList
		end
	}
	--place holder for dropdownmenu without data
	local EmptyFunc=function()
		return {}
	end
	--
	local SetButtonDisplay=function(button,entry)
		NPA_Options.Template.SetDropDownEditor(button.ConditionTypeSelector,entry.ConditionType)
		--
		if(entry.ConditionType=="Any" or entry.ConditionType=="Quest" or entry.ConditionType=="Tapped"
			or entry.ConditionType=="FriendList" or  entry.ConditionType=="PartyList" or entry.ConditionType=="RaidList"
			or entry.ConditionType=="GuildList" or entry.ConditionType=="NotCasting")then
			NPA_Options.Template.DisableDropDownEditor(button.ArgumentSelector)
		else
			NPA_Options.Template.EnableDropDownEditor(button.ArgumentSelector)
			if(GetConditionArgument[button.ConditionTypeSelector.Value])then
				--using dropdown editor force match
				NPA_Options.Template.SetDropDownEditor(button.ArgumentSelector,entry.Arg,GetConditionArgument[button.ConditionTypeSelector.Value],true)
				button.ArgumentSelector.FreeEdit=false
			else
				--set free edit
				button.ArgumentSelector.FreeEdit=true
				--if it's spell type, show spellselector
				if(entry.ConditionType=="WithAura" or entry.ConditionType=="WithoutAura"
					or entry.ConditionType=="WithCoolDown" or entry.ConditionType=="WithoutCoolDown"
					)then
						button.ArgumentSelector.IsSpellPicker=true
					else
						button.ArgumentSelector.IsSpellPicker=false
					end
				NPA_Options.Template.SetDropDownEditor(button.ArgumentSelector,entry.Arg,EmptyFunc)
			end
		end
		--
		NPA_Options.Template.SetDropDownEditor(button.ProfileSelector,entry.Profile)
	end
	--
	page.ButtonCreateFunc=function(button)
		local label=button:CreateFontString()
		NPA_Options.SetTextFont(label)
		label:SetPoint("LEFT",button,"LEFT",10,0)
		--condition
		local conditiontypeselector=NPA_Options.Template.CreateDropDownEditor(button,100,Localization["ConditionType"],Tooltips["ConditionType"],GetConditionType,20)
		conditiontypeselector:SetPoint("LEFT",label,"RIGHT",10,0)
		--argument
		local argumentselector=NPA_Options.Template.CreateDropDownEditor(button,100,Localization["ConditionArgument"],Tooltips["ConditionArgument"],nil,20)
		argumentselector:SetPoint("LEFT",conditiontypeselector,"RIGHT",30,0)
		argumentselector.ParentPage=main
		---profile selector
		local profileselector=NPA_Options.Template.CreateDropDownEditor(button,130,Localization["SelectProfile"],Tooltips["SelectProfile"],GetProfileList,20)
		profileselector:SetPoint("LEFT",argumentselector,"RIGHT",30,0)
		----spell picker
		--local spellpickerbutton=NPA_Options.Template.CreateButton(argumentselector,15,15,"+")
		--spellpickerbutton:SetPoint("LEFT",argumentselector,"RIGHT",0,0)
		--
		button.LabelText=label
		button.ConditionTypeSelector=conditiontypeselector
		button.ArgumentSelector=argumentselector
		button.ProfileSelector=profileselector
		button.SpellPickerButton=spellpickerbutton
		--
		conditiontypeselector.OnValueUpdateFunc=function()
			Entry[button.EntryIndex].ConditionType=conditiontypeselector.Value
			--
			SetButtonDisplay(button,Entry[button.EntryIndex])
		end
		--
		argumentselector.OnValueUpdateFunc=function()
			Entry[button.EntryIndex].Arg=argumentselector.Value
		end
		--
		profileselector.OnValueUpdateFunc=function()
			Entry[button.EntryIndex].Profile=profileselector.Value
		end
		--
		--spellpickerbutton:HookScript("OnMouseUp",function()
		--	NPA_Options.SetPage("SpellLookUp",main,"",function(value)

		--	end)
		--end)
	end
	page.ButtonUpdateFunc=function(button,index)
		button.LabelText:SetText(index)
		SetButtonDisplay(button,Entry[index])
	end

	local Refresh=function()
		NPA_Options.Template.UpdatePriorityEdit(scroll,Entry)
	end
	--
	page.LoadFunc=function(default)
		--load entry
		if(default)then
			Entry=NPA.SettingManager.GetDefault("NamePlateCondition")
		else
			Entry=CopyTable(NPA_Setting.NamePlateCondition)
		end
		Refresh()
	end
	page.SaveFunc=function(matchtable)
		--sort by new order then save
		local entry={}
		for index,index2 in pairs(matchtable)do
			entry[index]=CopyTable(Entry[index2])
		end

		NPA_Setting.NamePlateCondition=entry
		--refresh
		Entry=CopyTable(entry)
		Refresh()
		--also fire an event
		NPA.EventHandler.FireEvent(6,"NamePlate_ConditionUpdated")
	end
	--
	page.OnCopyFunc=function(oldindex,newindex)
		Entry[newindex]=CopyTable(Entry[oldindex])
		Refresh()
	end
	page.OnDeleteFunc=function(oldindex)
		table_remove(Entry,oldindex)
		Refresh()
	end
	page.OnRenameFunc=function(oldindex,newindex)
		Entry[newindex]=CopyTable(Entry[oldindex])
		table_remove(Entry,oldindex)
		Refresh()
	end
	page.OnCreateFunc=function(newindex)
		local default=NPA.SettingManager.GetDefault("NamePlateCondition")
		Entry[newindex]=CopyTable(default)
		Refresh()
	end
	--
	main.OnSetFunc=function()
		page.LoadFunc()
	end
	--
	NPA_Options.RegisterPage("NamePlateCondition",main)

end)