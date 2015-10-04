-- Author      : Nogarder
-- Create Date : 2013/4/6 8:55:12
NPA_Options.RegisterPageFunc("NamePlateIconGroupRulesFilterEditor",function()

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
	local Filters
	local FilterType -- 1=spell list, 2=school list
	local Localization
	--elements
	local step=-20
	--spell list checkbox list
	local spelllist=NPA_Options.Template.CreateSpellCheckBoxList(page,200,400,main,true)
	spelllist.Scroll:SetPoint("TOPLEFT",page,"TOPLEFT",5,-30)
	NPA_Options.Template.SetCheckBoxList(spelllist)
	--
	local schoollist=NPA_Options.Template.CreateCheckBoxList(page,200,425)
	schoollist.Scroll:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	NPA_Options.Template.SetCheckBoxList(schoollist)
	--
	local LoadData=function()
		if(FilterType==1)then
			NPA_Options.Template.UpdateSpellCheckBoxList(spelllist,Filters)
			schoollist.Scroll:Hide()
			spelllist.Scroll:Show()
		elseif(FilterType==2)then
			--using infolib spell class as localization
			NPA_Options.Template.UpdateCheckBoxList(schoollist,Filters,NPA_Options.Localization.InfoLibSpell.Class)
			schoollist.Scroll:Show()
			spelllist.Scroll:Hide()
		end
	end
	--
	local OnValueUpdate=function(name,checked)
		Filters[name]=checked
	end
	--
	spelllist.OnValueUpdateFunc=OnValueUpdate
	schoollist.OnValueUpdateFunc=OnValueUpdate
	--
	main.OnSetFunc=function(filters,filtertype,localization)
		Filters=filters
		FilterType=filtertype
		Localization=localization
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("NamePlateIconGroupRulesFilterEditor",main)

end)
