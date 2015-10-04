-- Author      : Nogarder
-- Create Date : 2013/4/25 12:42:11
NPA_Options.RegisterPageFunc("CombatTextAnimationList",function()
	local pairs=pairs
	local table_insert=table.insert
	local table_getn=table.getn
	local table_remove=table.remove
	--localization
	local Localization=NPA_Options.Localization.PagesCombatText
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	local Entry
	local EntryName
	local Parent
	--
	local main=NPA_Options.Template.CreatePriorityEdit(parent,Localization["Animation"],160,320,30,nil,nil)
	main:Hide()
	--
	local page=main.Frame
	local scroll=main.Scroll
	--
	local UpdatePreview=function()
		NPA_Options.SetPage("CombatTextPreview",Parent,Entry)
	end
	--
	page.ButtonCreateFunc=function(button)
		local label=button:CreateFontString()
		NPA_Options.SetTextFont(label)
		label:SetPoint("CENTER",button,"CENTER",0,0)
		button.LabelText=label
		--
		button:HookScript("OnMouseUp",function()
			NPA_Options.SetPage("CombatTextAnimationEditor",main,Entry[button.EntryIndex],UpdatePreview,button.EntryIndex)
		end)
	end
	local Refresh=function()
		NPA_Options.Template.UpdatePriorityEdit(scroll,Entry)
		UpdatePreview()
	end
	--
	page.ButtonUpdateFunc=function(button,index)
		button.LabelText:SetText(index)
	end
	--
	page.LoadFunc=function(default)
		Entry=CopyTable(NPA_Setting.CombatText.Animation[EntryName])
		Refresh()
	end
	page.SaveFunc=function(matchtable)
		--sort by new order then save
		local entry={}
		for index,index2 in pairs(matchtable)do
			entry[index]=CopyTable(Entry[index2])
		end

		NPA_Setting.CombatText.Animation[EntryName]=entry
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
		local default=NPA.SettingManager.GetDefault("CombatTextAnimation")
		Entry[newindex]=CopyTable(default)
		Refresh()
	end
	--
	main.OnSetFunc=function(name,parent)
		Parent=parent
		EntryName=name
		page.LoadFunc()
	end
	NPA_Options.RegisterPage("CombatTextAnimationList",main)
end)
