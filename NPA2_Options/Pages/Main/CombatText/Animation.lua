-- Author      : Nogarder
-- Create Date : 2013/4/24 13:28:36
NPA_Options.RegisterPageFunc("CombatTextAnimation",function()
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
		for name,_ in pairs(NPA_Setting.CombatText.Animation)do
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
		--fire a combattext update event
		NPA.EventHandler.FireEvent(6,"CombatText_SettingUpdated")
	end
	--
	listeditor.OnCopyFunc=function(oldname,newname)
		NPA_Setting.CombatText.Animation[newname]=CopyTable(NPA_Setting.CombatText.Animation[oldname])
		Refresh()
	end
	listeditor.OnDeleteFunc=function(oldname)
		NPA_Setting.CombatText.Animation[oldname]=nil
		Refresh()
	end
	listeditor.OnRenameFunc=function(oldname,newname)
		NPA_Setting.CombatText.Animation[newname]=CopyTable(NPA_Setting.CombatText.Animation[oldname])
		NPA_Setting.CombatText.Animation[oldname]=nil
		Refresh()
	end
	listeditor.OnCreateFunc=function(newname)
		NPA_Setting.CombatText.Animation[newname]={[1]=NPA.SettingManager.GetDefault("CombatTextAnimation")}
		Refresh()
	end
	--
	listeditor.OnClickFunc=function(name)
		--set module list
		NPA_Options.SetPage("CombatTextAnimationList",main,name,main)
	end
	----
	NPA_Options.RegisterPage("CombatTextAnimation",main)
end)