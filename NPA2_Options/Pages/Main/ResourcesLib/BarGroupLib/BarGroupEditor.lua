-- Author      : Nogarder
-- Create Date : 2012/8/27 4:52:52
NPA_Options.RegisterPageFunc("BarGroupEditor",function()

	local pairs=pairs
	--localization
	local Localization=NPA_Options.Localization.TemplatesWindowBarGroupEditor
	local Tooltips=Localization.Tooltips
	--
	local EntryName
	---
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["SelectBar"],165,240,nil,nil)
	main:Hide()
	--
	local listeditor=NPA_Options.Template.CreateListEditor(main.Frame,nil,165,240,main)
	listeditor.NoDefault=true
	--script
	local Refresh=function()
		local barlist={}
		--build data here
		local i=1
		for name,_ in pairs(NPA_Setting.BarGroup[EntryName])do
			barlist[i]={
				Text=name,
				Value=name,
			}
			i=i+1
		end
		NPA_Options.Template.UpdateListEditor(listeditor,barlist)
		--
		--NPA_Options.RunFunc(main.OnValueUpdateFunc)
	end
	--
	local OnUpdate=function()
		NPA.EventHandler.FireEvent(6,"Resources_ProfileRefresh")
		Refresh()
	end
	--
	listeditor.OnCopyFunc=function(oldname,newname)
		NPA_Setting.BarGroup[EntryName][newname]=CopyTable(NPA_Setting.BarGroup[EntryName][oldname])
		OnUpdate()
	end
	listeditor.OnDeleteFunc=function(oldname)
		NPA_Setting.BarGroup[EntryName][oldname]=nil
		OnUpdate()
	end
	listeditor.OnRenameFunc=function(oldname,newname)
		NPA_Setting.BarGroup[EntryName][newname]=CopyTable(NPA_Setting.BarGroup[EntryName][oldname])
		NPA_Setting.BarGroup[EntryName][oldname]=nil
		OnUpdate()
	end
	listeditor.OnCreateFunc=function(newname)
		NPA_Setting.BarGroup[EntryName][newname]=NPA.SettingManager.GetDefault("BarGroup")["1"]
		OnUpdate()
	end
	listeditor.OnClickFunc=function(name)
		--setup editor page
		NPA_Options.SetPage("BarEditor",main,NPA_Setting.BarGroup[EntryName][name],nil,nil,OnUpdate)
	end
	--
	main.OnSetFunc=function(entryname,onvalueupdatefunc)
		EntryName=entryname
		main.OnValueUpdateFunc=onvalueupdatefunc
		--
		Refresh()
	end
	--
	NPA_Options.RegisterPage("BarGroupEditor",main)

end)