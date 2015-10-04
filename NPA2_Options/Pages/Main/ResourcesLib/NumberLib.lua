-- Author      : Nogarder
-- Create Date : 2012/7/29 9:51:55
NPA_Options.RegisterPageFunc("NumberLib",function()

	local pairs=pairs
	local CopyTable=CopyTable
	--localization
	local Localization=NPA_Options.Localization.PagesResourcesLibNumberLib
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["SelectProfile"],120,240,nil,nil)
	main:Hide()
	--
	local listeditor=NPA_Options.Template.CreateListEditor(main.Frame,nil,120,240,main)
	--
	local OnSaveFunc
	--script
	local Refresh=function()
		local numberlist={}
		--build data here
		local i=1
		for name,_ in pairs(NPA_Setting.Number)do
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
		NPA_Setting.Number[newname]=CopyTable(NPA_Setting.Number[oldname])
	end
	listeditor.OnDeleteFunc=function(oldname)
		NPA_Setting.Number[oldname]=nil
	end
	listeditor.OnRenameFunc=function(oldname,newname)
		NPA_Setting.Number[newname]=CopyTable(NPA_Setting.Number[oldname])
		NPA_Setting.Number[oldname]=nil
	end
	listeditor.OnCreateFunc=function(newname)
		NPA_Setting.Number[newname]=CopyTable(NPA_Setting.Number["Default"])
	end
	listeditor.OnClickFunc=function(name)
		--setup editor page
		NPA_Options.SetPage("NumberEditor",main,name,nil)--OnSaveFunc)
	end
	--
	main.OnSetFunc=function(name,onsavefunc)
		OnSaveFunc=onsavefunc
		--
		if(name)then
			Refresh()
			NPA_Options.Template.SetSelectListFocus(listeditor,name)
			listeditor.OnClickFunc(name)
		end
	end
	--
	NPA_Options.RegisterPage("NumberLib",main)

end)