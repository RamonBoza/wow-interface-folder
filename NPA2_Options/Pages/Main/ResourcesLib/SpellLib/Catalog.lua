-- Author      : Nogarder
-- Create Date : 2012/11/13 14:23:13
NPA_Options.RegisterPageFunc("SpellLibCatalog",function()

	local pairs=pairs
	local CopyTable=CopyTable
	local table_insert=table.insert
	--localization
	local Localization=NPA_Options.Localization.PagesSpellLibCatalog
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["SelectSpell"],200,340,nil,nil,nil)
	main:Hide()
	local page=main.Frame
	page:SetWidth(200)
	page:SetHeight(340)
	--spellcheckbox
	local spellcheckboxlist=NPA_Options.Template.CreateSpellCheckBoxList(page,170,200,main)
	spellcheckboxlist.Scroll:SetPoint("TOPLEFT",page,"TOPLEFT",5,-30)
	NPA_Options.Template.SetCheckBoxList(spellcheckboxlist)
	--moveto
	local movetobutton=NPA_Options.Template.CreateButton(page,60,15,Localization["MoveTo"])
	movetobutton:SetPoint("TOPLEFT",spellcheckboxlist.Scroll,"BOTTOMLEFT",0,-50)
	NPA_Options.Template.SetTooltips(Tooltips["MoveTo"],movetobutton,nil,2)
	--catalog edit
	local catalogedit=NPA_Options.Template.CreateDropDownEditor(page,130,Localization["Catalog"],Tooltips["Catalog"],NPA_Options.InfoLib.Spell.GetCatalogList,20)
	catalogedit.Label:SetPoint("BOTTOMLEFT",catalogedit,"TOPLEFT",0,0)
	catalogedit:SetPoint("LEFT",movetobutton,"RIGHT",5,0)

	catalogedit.FreeEdit=true
	--delete button
	local deletebutton=NPA_Options.Template.CreateButton(page,190,15,Localization["Delete"])
	deletebutton:SetPoint("TOPLEFT",movetobutton,"BOTTOMLEFT",0,-25)
	NPA_Options.Template.SetTooltips(Tooltips["Delete"],deletebutton,nil,2)
	--script
	movetobutton:HookScript("OnMouseUp",function()
		local value
		if(catalogedit.Value=="")then
			value=Localization["Unsorted"]
		else
			value=catalogedit.Value
		end
		local count=0
		for spellid,checked in pairs(spellcheckboxlist.Value)do
			if(checked==true)then
				NPA_Setting.SpellLib[spellid].Catalog=value
				count=count+1
			end
		end
		print(Localization["Moved"]..":"..count)
		NPA_Options.Template.UpdateCheckBoxList(spellcheckboxlist,{})
	end)
	deletebutton:HookScript("OnMouseUp",function()
		local count=0
		for spellid,checked in pairs(spellcheckboxlist.Value)do
			if(checked==true)then
				NPA_Setting.SpellLib[spellid]=nil
				count=count+1
			end
		end
		print(Localization["Deleted"]..":"..count)
		NPA_Options.Template.UpdateCheckBoxList(spellcheckboxlist,{})
	end)
	--
	main.OnSetFunc=function()
		NPA_Options.Template.SetDropDownEditor(catalogedit,Localization["Unsorted"])
	end
	----
	NPA_Options.RegisterPage("SpellLibCatalog",main)

end)