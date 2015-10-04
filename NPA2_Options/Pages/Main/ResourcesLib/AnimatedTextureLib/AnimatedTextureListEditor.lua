-- Author      : Nogarder
-- Create Date : 2015/2/8 18:13:12
-- Author      : Nogarder
-- Create Date : 2013/4/25 12:42:11
NPA_Options.RegisterPageFunc("AnimatedTextureListEditor",function()
	local pairs=pairs
	local table_insert=table.insert
	local table_getn=table.getn
	local table_remove=table.remove
	--localization
	local Localization=NPA_Options.Localization.PagesResourcesLibTextureLib
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	local Entry
	local EntryName
	local Parent
	--
	local main=NPA_Options.Template.CreatePriorityEdit(parent,Localization["Frames"],160,320,30,nil,nil)
	main:Hide()
	--
	local page=main.Frame
	local scroll=main.Scroll
	local UpdateFunc
	--generate button
	local generatebutton=NPA_Options.Template.CreateButton(main,400,20,Localization["Generate"])
	generatebutton:SetPoint("BOTTOMLEFT",main.Scroll,"TOPLEFT",0,30)
	generatebutton:SetPoint("BOTTOMRIGHT",main.Scroll,"TOPRIGHT",0,30)
	NPA_Options.Template.SetTooltips(Tooltips["Generate"],generatebutton)
	--
	local UpdatePreview=function()
		NPA_Options.SetPage("AnimatedTexturePreview",Parent,Entry)
	end
	--
	local Refresh=function()
		NPA_Options.Template.UpdatePriorityEdit(scroll,Entry)
		UpdatePreview()
	end
	--
	page.ButtonCreateFunc=function(button)
		local texture=button:CreateTexture()
		texture:SetPoint("TOPLEFT",button,"TOPLEFT",1,-1)
		texture:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",-1,1)
		button.Texture=texture

		local label=button:CreateFontString()
		NPA_Options.SetTextFont(label)
		label:SetPoint("CENTER",button,"CENTER",0,0)
		button.LabelText=label
		--
		button:HookScript("OnMouseUp",function()
			NPA_Options.SetPage("AnimatedTextureFrameEditor",main,Entry[button.EntryIndex],Refresh)
		end)
	end
	--
	generatebutton:HookScript("OnMouseUp",function()
		NPA_Options.SetPage("AnimatedTextureGenerator",main,Entry,Refresh)
	end)
	--
	page.ButtonUpdateFunc=function(button,index)
		button.LabelText:SetText(index)
		NPA.TextureManager.SetTextureWithData(button.Texture,Entry[button.EntryIndex])
	end
	--
	page.LoadFunc=function(default)
		Entry=CopyTable(NPA_Setting.AnimatedTexture[EntryName])
		Refresh()
	end
	page.SaveFunc=function(matchtable)
		--sort by new order then save
		local entry={}
		for index,index2 in pairs(matchtable)do
			entry[index]=CopyTable(Entry[index2])
		end

		NPA_Setting.AnimatedTexture[EntryName]=entry
		--refresh
		Entry=CopyTable(entry)
		Refresh()

		NPA.EventHandler.FireEvent(6,"NamePlate_ConditionUpdated")--this is handy ,just use it
		NPA_Options.RunFunc(UpdateFunc)
	end
	--
	page.OnCopyFunc=function(oldindex,newindex)
		Entry[newindex]=CopyTable(Entry[oldindex])
		Refresh()
	end
	page.OnDeleteFunc=function(oldindex)
		table_remove(Entry,oldindex)
		Refresh()
	end
	page.OnRenameFunc=function(oldindex,newindex)
		Entry[newindex]=CopyTable(Entry[oldindex])
		table_remove(Entry,oldindex)
		Refresh()
	end
	page.OnCreateFunc=function(newindex)
		Entry[newindex]=CopyTable(NPA.SettingManager.GetDefault("AnimatedTexture"))
		Refresh()
	end
	--
	main.OnSetFunc=function(name,parent,updatefunc)
		UpdateFunc=updatefunc
		Parent=parent
		EntryName=name
		page.LoadFunc()
	end
	NPA_Options.RegisterPage("AnimatedTextureListEditor",main)
end)
