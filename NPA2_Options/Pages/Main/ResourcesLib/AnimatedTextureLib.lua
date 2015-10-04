-- Author      : Nogarder
-- Create Date : 2015/2/8 18:08:37
NPA_Options.RegisterPageFunc("AnimatedTextureLib",function()

	local pairs=pairs
	local CopyTable=CopyTable
	--localization
	local Localization=NPA_Options.Localization.PagesResourcesLibTextureLib
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["SelectProfile"],260,320,nil,nil)
	main:Hide()

	local listeditor=NPA_Options.Template.CreateListEditor(main.Frame,nil,260,320,main,50)
	--script
	local Refresh=function()
		local texturelist={}
		--build data here
		local i=1
		for name,_ in pairs(NPA_Setting.AnimatedTexture)do
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
		NPA_Setting.AnimatedTexture[newname]=CopyTable(NPA_Setting.AnimatedTexture[oldname])
	end
	listeditor.OnDeleteFunc=function(oldname)
		NPA_Setting.AnimatedTexture[oldname]=nil
	end
	listeditor.OnRenameFunc=function(oldname,newname)
		NPA_Setting.AnimatedTexture[newname]=CopyTable(NPA_Setting.AnimatedTexture[oldname])
		NPA_Setting.AnimatedTexture[oldname]=nil
	end
	listeditor.OnCreateFunc=function(newname)
		NPA_Setting.AnimatedTexture[newname]={}
	end
	listeditor.OnClickFunc=function(name)
		--setup editor page
		NPA_Options.SetPage("AnimatedTextureListEditor",main,name,main,Refresh)
	end

	--
	local page=listeditor.Frame
	page.ButtonUpdateFunc=function(button)
		NPA.TextureManager.SetAnimatedTextureByEntry(button.Texture,NPA_Setting.AnimatedTexture[button.Value])
	end
	--	--
	page.ButtonCreateFunc=function(button)
		button:HookScript("OnHide",function()
			NPA.TextureManager.RemoveAnimatedTexture(button.Texture)
		end)
	end

	--
	main.OnSetFunc=function(name)
		if(name)then
			Refresh()
			NPA_Options.Template.SetSelectListFocus(listeditor,name)
			listeditor.OnClickFunc(name)
		end
	end
	----
	NPA_Options.RegisterPage("AnimatedTextureLib",main)

end)