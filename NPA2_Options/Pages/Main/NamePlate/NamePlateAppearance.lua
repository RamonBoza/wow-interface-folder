-- Author      : Nogarder
-- Create Date : 2012/4/28 16:25:15
NPA_Options.RegisterPageFunc("NamePlateAppearanceProfileList",function()

	local pairs=pairs
	local CopyTable=CopyTable
	--localization
	local Localization=NPA_Options.Localization.PagesMainNamePlateAppearance
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["SelectProfile"],120,240,nil,nil,nil)
	main:Hide()

	local listeditor=NPA_Options.Template.CreateListEditor(main.Frame,nil,120,240,main)

	listeditor.RefreshFunc=function(list)
		local profiledata={}
		--build data here
		local i=1
		for name,_ in pairs(NPA_Setting.NamePlate)do
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
	listeditor.OnCopyFunc=function(oldname,newname)
		NPA_Setting.NamePlate[newname]=CopyTable(NPA_Setting.NamePlate[oldname])
	end
	listeditor.OnDeleteFunc=function(oldname)
		NPA_Setting.NamePlate[oldname]=nil
	end
	listeditor.OnRenameFunc=function(oldname,newname)
		NPA_Setting.NamePlate[newname]=CopyTable(NPA_Setting.NamePlate[oldname])
		NPA_Setting.NamePlate[oldname]=nil
	end
	listeditor.OnCreateFunc=function(newname)
		NPA_Setting.NamePlate[newname]=CopyTable(NPA_Setting.NamePlate["Default"])
	end
	listeditor.OnClickFunc=function(name)
		--set preview
		NPA_Options.SetPage("NamePlatePreview",main,name)
		--set module list
		NPA_Options.SetPage("NamePlateAppearanceModuleList",main,name)
	end

	----
	NPA_Options.RegisterPage("NamePlateAppearanceProfileList",main)

end)