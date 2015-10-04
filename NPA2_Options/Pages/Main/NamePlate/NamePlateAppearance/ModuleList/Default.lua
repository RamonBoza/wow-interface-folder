-- Author      : Nogarder
-- Create Date : 2012/12/27 15:44:52
NPA_Options.RegisterPageFunc("NamePlateAppearanceDefault",function()

	local pairs=pairs
	local table_insert=table.insert
	--localization
	local Localization=NPA_Options.Localization.PagesModuleListDefault
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	local EntryName
	local Preview=NPA_Options.GetPage("NamePlatePreview")
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["SelectRegion"],400,320,nil,nil,nil)
	main:Hide()
	--
	local page=main.Frame
	--
	local selectlist=NPA_Options.Template.CreateSelectList(nil,150,270,nil,nil,page)
	--
	selectlist.RefreshFunc=function(list)
		--update editor content
		local listdata={}
		for name,_ in pairs(NPA_Setting.NamePlate[EntryName].DefaultSetting)do
			table_insert(listdata,{
				Text=Localization[name],
				Value=name,
				Tooltips=Tooltips[name]
			})
		end
		--
		NPA_Options.Template.UpdateSelectList(selectlist,listdata)
		--editor
		NPA_Options.ClosePages(main,true)
	end
	--
	local FireEvent=function()
		NPA.EventHandler.FireEvent(6,"NamePlate_ProfileKeyChange",EntryName)
	end
	--
	selectlist.ButtonClickFunc=function(button)
		local name=button.Value
		--set edit page
		--get data type from module manager
		NPA_Options.SetPage("NamePlateDefaultEditor",main,NPA_Setting.NamePlate[EntryName],name,
			--on value update
			FireEvent)
	end
	--
	main.OnSetFunc=function(entryname)
		EntryName=entryname
		selectlist.RefreshFunc(selectlist)
	end
	--
	NPA_Options.RegisterPage("NamePlateAppearanceDefault",main)

end)