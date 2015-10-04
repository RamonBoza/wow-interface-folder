-- Author      : Nogarder
-- Create Date : 2012/7/23 10:31:50
NPA_Options.RegisterPageFunc("TextureGroupEditor",function()

	local pairs=pairs
	local CopyTable=CopyTable
	--localization
	local Localization=NPA_Options.Localization.TemplatesWindowTextureGroupEditor
	--
	local	ProfileName
	local	MasterKey
	local	SubKey
	local Entry
	---
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["SelectTexture"],400,300)
	main:Hide()
	--
	local listeditor=NPA_Options.Template.CreateListEditor(main.Frame,nil,120,300,main)
	listeditor.NoDefault=true
	--
	local Refresh=function(list)
		local profiledata={}
		--build data here
		local i=1
		for name,entry in pairs(Entry)do
			profiledata[i]={
				Text=name,
				Value=name,
				ProfileName=entry.ProfileName,
			}
			i=i+1
		end
		NPA_Options.Template.UpdateListEditor(listeditor,profiledata)
		--setup preview
		NPA_Options.SetPage("TextureGroupPreview",main,Entry)
		NPA_Options.RunFunc(main.OnValueUpdateFunc)
	end
	--
	listeditor.RefreshFunc=Refresh
	--
	local GetDefault=function()
		return NPA_Options.RunFunc(main.GetDefaultFunc)
	end
	local OnUpdate=function()
		NPA.EventHandler.FireEvent(6,"NamePlate_ProfileKeyChange",ProfileName)
		Refresh()
	end
	listeditor.OnCopyFunc=function(oldname,newname)
		Entry[newname]=CopyTable(Entry[oldname])
		OnUpdate()
	end
	listeditor.OnDeleteFunc=function(oldname)
		Entry[oldname]=nil
		OnUpdate()
	end
	listeditor.OnRenameFunc=function(oldname,newname)
		Entry[newname]=CopyTable(Entry[oldname])
		Entry[oldname]=nil
		OnUpdate()
	end
	listeditor.OnCreateFunc=function(newname)
		Entry[newname]=NPA_Options.RunFunc(main.GetDefaultFunc)
		OnUpdate()
	end
	listeditor.OnClickFunc=function(name,button)
		if(button=="LeftButton")then
			local entry=Entry[name]
			NPA_Options.SetPage("TextureEditor",main,entry,nil,nil,OnUpdate)
			--setup preview
			NPA_Options.SetPage("TextureGroupPreview",main,Entry)
		end
	end
	--
	main.OnSetFunc=function(entry,getdefaultfunc,onvalueupdatefunc)
		Entry=entry
		main.GetDefaultFunc=getdefaultfunc
		main.OnValueUpdateFunc=onvalueupdatefunc
		--setup preview
		NPA_Options.SetPage("TextureGroupPreview",main,Entry)
	end
	--
	NPA_Options.RegisterPage("TextureGroupEditor",main)

end)