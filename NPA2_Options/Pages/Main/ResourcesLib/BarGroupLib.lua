-- Author      : Nogarder
-- Create Date : 2012/8/25 12:06:30
NPA_Options.RegisterPageFunc("BarGroupLib",function()

	local pairs=pairs
	local CopyTable=CopyTable
	--localization
	local Localization=NPA_Options.Localization.PagesResourcesLibBarGroup
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["SelectProfile"],165,240,nil,nil)
	main:Hide()
	--
	local listeditor=NPA_Options.Template.CreateListEditor(main.Frame,nil,165,240,main)
	--script
	local Refresh=function()
		local numberlist={}
		--build data here
		local i=1
		for name,_ in pairs(NPA_Setting.BarGroup)do
			numberlist[i]={
				Text=name,
				Value=name,
			}
			i=i+1
		end
		NPA_Options.Template.UpdateListEditor(listeditor,numberlist)
	end
	--
	listeditor.RefreshFunc=Refresh
	listeditor.OnCopyFunc=function(oldname,newname)
		NPA_Setting.BarGroup[newname]=CopyTable(NPA_Setting.BarGroup[oldname])
	end
	listeditor.OnDeleteFunc=function(oldname)
		NPA_Setting.BarGroup[oldname]=nil
	end
	listeditor.OnRenameFunc=function(oldname,newname)
		NPA_Setting.BarGroup[newname]=CopyTable(NPA_Setting.BarGroup[oldname])
		NPA_Setting.BarGroup[oldname]=nil
	end
	listeditor.OnCreateFunc=function(newname)
		NPA_Setting.BarGroup[newname]=CopyTable(NPA.SettingManager.GetDefault("BarGroup"))
	end
	listeditor.OnClickFunc=function(name)
		--setup editor page
		NPA_Options.SetPage("BarGroupEditor",main,name)
		--setup preview
		NPA_Options.SetPage("BarGroupPreview",main,name)
	end
	--
	main.OnSetFunc=function(name)
		if(name)then
			Refresh()
			NPA_Options.Template.SetSelectListFocus(listeditor,name)
			listeditor.OnClickFunc(name)
		end
	end
	--
	NPA_Options.RegisterPage("BarGroupLib",main)

end)