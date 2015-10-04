-- Author      : Nogarder
-- Create Date : 2013/4/25 15:18:40
NPA_Options.RegisterPageFunc("SpellListEditor",function()

	local pairs=pairs
	local CopyTable=CopyTable
	local table_insert=table.insert
	local table_getn=table.getn
	--
	local Localization=NPA_Options.Localization.PagesModuleListIconGroupRulesEditor
	--local Tooltips=Localization.Tooltips
	--
	local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,nil,230,455,nil,nil,nil)
	main:Hide()
	local page=main.Frame
	--
	local SpellListData
	--elements
	local spelllist=NPA_Options.Template.CreateSpellCheckBoxList(page,200,400,main,true)
	spelllist.Scroll:SetPoint("TOPLEFT",page,"TOPLEFT",5,-30)
	NPA_Options.Template.SetCheckBoxList(spelllist)
	--
	local LoadData=function()
		NPA_Options.Template.UpdateSpellCheckBoxList(spelllist,SpellListData)
	end
	--
	main.OnSetFunc=function(spelllistdata,onvalueupdatefunc)
		SpellListData=spelllistdata
		--
		spelllist.OnValueUpdateFunc=onvalueupdatefunc
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("SpellListEditor",main)
end)
