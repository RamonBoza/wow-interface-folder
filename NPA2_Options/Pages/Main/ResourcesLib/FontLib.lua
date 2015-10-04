-- Author      : Nogarder
-- Create Date : 2012/7/12 17:17:11
NPA_Options.RegisterPageFunc("FontLib",function()

	local pairs=pairs
	local CopyTable=CopyTable
	--localization
	local Localization=NPA_Options.Localization.PagesResourcesLibFontLib
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["SelectProfile"],150,240,nil,nil)
	main:Hide()
	--
	local listeditor=NPA_Options.Template.CreateListEditor(main.Frame,nil,150,240,main)
	--generate button
	local generatebutton=NPA_Options.Template.CreateButton(main,400,20,Localization["Generate"])
	generatebutton:SetPoint("BOTTOMLEFT",main.Scroll,"TOPLEFT",0,25)
	generatebutton:SetPoint("BOTTOMRIGHT",main.Scroll,"TOPRIGHT",0,25)
	NPA_Options.Template.SetTooltips(Tooltips["Generate"],generatebutton)
	--script
	local Refresh=function()
		local fontlist={}
		--build data here
		local i=1
		for name,_ in pairs(NPA_Setting.Font)do
			fontlist[i]={
				Text=name,
				Value=name,
				FontProfileName=name,
			}
			i=i+1
		end
		NPA_Options.Template.UpdateListEditor(listeditor,fontlist)
	end
	--
	listeditor.RefreshFunc=Refresh
	listeditor.OnCopyFunc=function(oldname,newname)
		NPA_Setting.Font[newname]=CopyTable(NPA_Setting.Font[oldname])
	end
	listeditor.OnDeleteFunc=function(oldname)
		NPA_Setting.Font[oldname]=nil
	end
	listeditor.OnRenameFunc=function(oldname,newname)
		NPA_Setting.Font[newname]=CopyTable(NPA_Setting.Font[oldname])
		NPA_Setting.Font[oldname]=nil
	end
	listeditor.OnCreateFunc=function(newname)
		NPA_Setting.Font[newname]=CopyTable(NPA_Setting.Font["Default"])
	end
	listeditor.OnClickFunc=function(name)
		--setup editor page
		NPA_Options.SetPage("FontEditor",main,name,Refresh)
	end
	--
	generatebutton:HookScript("OnMouseUp",function()
		local lib=NPA_Options.InfoLib.GetFont()
		for _,data in pairs(lib)do
			if(not NPA_Setting.Font[data.Text])then
				NPA_Setting.Font[data.Text]=CopyTable(NPA.SettingManager.GetDefault("Font"))
				NPA_Setting.Font[data.Text].Font=data.Value
			end
		end
		Refresh()
	end)
	--
	main.OnSetFunc=function(name)
		if(name)then
			Refresh()
			NPA_Options.Template.SetSelectListFocus(listeditor,name)
			listeditor.OnClickFunc(name)
		end
	end
	----
	NPA_Options.RegisterPage("FontLib",main)

end)