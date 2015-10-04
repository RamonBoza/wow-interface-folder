-- Author      : Nogarder
-- Create Date : 2013/6/6 17:22:46
NPA_Options.RegisterPageFunc("TrackerNameplates",function()
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
		for name,_ in pairs(NPA_Setting.Tracker.Nameplates)do
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
		NPA.EventHandler.FireEvent(6,"Tracker_SettingUpdated")
	end
	--
	listeditor.OnCopyFunc=function(oldname,newname)
		NPA_Setting.Tracker.Nameplates[newname]=CopyTable(NPA_Setting.Tracker.Nameplates[oldname])
		Refresh()
	end
	listeditor.OnDeleteFunc=function(oldname)
		NPA_Setting.Tracker.Nameplates[oldname]=nil
		Refresh()
	end
	listeditor.OnRenameFunc=function(oldname,newname)
		NPA_Setting.Tracker.Nameplates[newname]=CopyTable(NPA_Setting.Tracker.Nameplates[oldname])
		NPA_Setting.Tracker.Nameplates[oldname]=nil
		Refresh()
	end
	listeditor.OnCreateFunc=function(newname)
		NPA_Setting.Tracker.Nameplates[newname]=NPA.SettingManager.GetDefault("TrackerNameplates")
		Refresh()
	end
	--
	listeditor.OnClickFunc=function(name)
		--set module list
		NPA_Options.SetPage("TrackerNameplatesEditor",main,name)
	end
	----
	NPA_Options.RegisterPage("TrackerNameplates",main)
end)