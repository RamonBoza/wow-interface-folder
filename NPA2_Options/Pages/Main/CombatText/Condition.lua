-- Author      : Nogarder
-- Create Date : 2013/4/20 16:50:57
NPA_Options.RegisterPageFunc("CombatTextCondition",function()
	local pairs=pairs
	local CopyTable=CopyTable
	--localization
	local Localization=nil
	---
	local parent=NPA_Options.MainFrame
	local modulelist={}
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,nil,120,240,nil,nil,nil)
	main:Hide()

	local listeditor=NPA_Options.Template.CreateListEditor(main.Frame,nil,120,240,main)
	listeditor.NoDefault=true
	listeditor.RefreshFunc=function(list)
		local profiledata={}
		--build data here
		local i=1
		for name,_ in pairs(NPA_Setting.CombatText.Condition)do
			profiledata[i]={
				Text=name,
				Value=name
			}
			i=i+1
		end
		NPA_Options.Template.UpdateListEditor(list,profiledata)
		--editor
		NPA_Options.ClosePages(main,true)
	end
	--Refresh
	local Refresh=function()
		--fire a targetarrow update event
		NPA.EventHandler.FireEvent(6,"CombatText_SettingUpdated")
	end
	--
	listeditor.OnCopyFunc=function(oldname,newname)
		NPA_Setting.CombatText.Condition[newname]=CopyTable(NPA_Setting.CombatText.Condition[oldname])
		Refresh()
	end
	listeditor.OnDeleteFunc=function(oldname)
		NPA_Setting.CombatText.Condition[oldname]=nil
		Refresh()
	end
	listeditor.OnRenameFunc=function(oldname,newname)
		NPA_Setting.CombatText.Condition[newname]=CopyTable(NPA_Setting.CombatText.Condition[oldname])
		NPA_Setting.CombatText.Condition[oldname]=nil
		Refresh()
	end
	listeditor.OnCreateFunc=function(newname)
		NPA_Setting.CombatText.Condition[newname]=NPA.SettingManager.GetDefault("CombatTextCondition")
		Refresh()
	end
	--
	listeditor.OnClickFunc=function(name)
		--set module list
		NPA_Options.SetPage("CombatTextConditionEditor",main,name)
	end
	----
	NPA_Options.RegisterPage("CombatTextCondition",main)
end)