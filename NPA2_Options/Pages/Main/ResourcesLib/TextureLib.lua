-- Author      : Nogarder
-- Create Date : 2012/7/24 10:41:25
NPA_Options.RegisterPageFunc("TextureLib",function()

	local pairs=pairs
	local CopyTable=CopyTable
	--localization
	local Localization=NPA_Options.Localization.PagesResourcesLibTextureLib
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["SelectProfile"],260,360,nil,nil)
	main:Hide()

	local listeditor=NPA_Options.Template.CreateListEditor(main.Frame,nil,260,360,main,50)
	--generate button
	local generatebutton=NPA_Options.Template.CreateButton(main,400,20,Localization["Generate"])
	generatebutton:SetPoint("BOTTOMLEFT",main.Scroll,"TOPLEFT",0,25)
	generatebutton:SetPoint("BOTTOMRIGHT",main.Scroll,"TOPRIGHT",0,25)
	NPA_Options.Template.SetTooltips(Tooltips["Generate"],generatebutton)
	--script
	local Refresh=function()
		local texturelist={}
		--build data here
		local i=1
		for name,_ in pairs(NPA_Setting.Texture)do
			texturelist[i]={
				Text=name,
				Value=name,
				TextureProfileName=name,
			}
			i=i+1
		end
		NPA_Options.Template.UpdateListEditor(listeditor,texturelist)
	end
	--
	listeditor.RefreshFunc=Refresh
	listeditor.OnCopyFunc=function(oldname,newname)
		NPA_Setting.Texture[newname]=CopyTable(NPA_Setting.Texture[oldname])
	end
	listeditor.OnDeleteFunc=function(oldname)
		NPA_Setting.Texture[oldname]=nil
	end
	listeditor.OnRenameFunc=function(oldname,newname)
		NPA_Setting.Texture[newname]=CopyTable(NPA_Setting.Texture[oldname])
		NPA_Setting.Texture[oldname]=nil
	end
	listeditor.OnCreateFunc=function(newname)
		NPA_Setting.Texture[newname]=CopyTable(NPA_Setting.Texture["Default"])
	end
	listeditor.OnClickFunc=function(name)
		--setup editor page
		NPA_Options.SetPage("TextureFileEditor",main,name,nil,Refresh)
	end
	--
	generatebutton:HookScript("OnMouseUp",function()
		local lib=NPA_Options.InfoLib.GetTexture()
		for _,data in pairs(lib)do
			if(not NPA_Setting.Texture[data.Text])then
				NPA_Setting.Texture[data.Text]=CopyTable(NPA.SettingManager.GetDefault("Texture")["Default"])
				NPA_Setting.Texture[data.Text].Texture=data.Value
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
	--on zip and unzip
	main.Scroll.OnMinimizedFunc=function()
		generatebutton:Hide()
	end
	main.Scroll.OnRestoredFunc=function()
		generatebutton:Show()
	end
	----
	NPA_Options.RegisterPage("TextureLib",main)

end)