-- Author      : Nogarder
-- Create Date : 2015/2/3 15:50:48
NPA_Options.RegisterPageFunc("ExtraArrow",function()

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
		for name,_ in pairs(NPA_Setting.ExtraArrow)do
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
		NPA.EventHandler.FireEvent(6,"ExtraArrow_SettingUpdated")
	end
	--
	listeditor.OnCopyFunc=function(oldname,newname)
		NPA_Setting.ExtraArrow[newname]=CopyTable(NPA_Setting.ExtraArrow[oldname])
		Refresh()
	end
	listeditor.OnDeleteFunc=function(oldname)
		NPA_Setting.ExtraArrow[oldname]=nil
		Refresh()
	end
	listeditor.OnRenameFunc=function(oldname,newname)
		NPA_Setting.ExtraArrow[newname]=CopyTable(NPA_Setting.ExtraArrow[oldname])
		NPA_Setting.ExtraArrow[oldname]=nil
		Refresh()
	end
	listeditor.OnCreateFunc=function(newname)
		NPA_Setting.ExtraArrow[newname]=NPA.SettingManager.GetDefault("ExtraArrow")
		Refresh()
	end
	--
	listeditor.OnClickFunc=function(name)
		--set module list
		NPA_Options.SetPage("ExtraArrowEditor",main,name)
	end
	----
	NPA_Options.RegisterPage("ExtraArrow",main)
end)