-- Author      : Nogarder
-- Create Date : 2012/7/27 11:29:59
NPA_Options.RegisterPageFunc("ColorLib",function()

	--localization
	local Localization=NPA_Options.Localization.PagesResourcesLibColorLib
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["Color"],100,240,nil,nil)
	main:Hide()
	local page=main.Frame
	--
	page:SetWidth(100)
	page:SetHeight(240)
	--
	local width=90
	local step=-5
	--faction color button
	local factionbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Faction"])
	factionbutton:SetPoint("TOP",page,"TOP",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Faction"],factionbutton,nil,2)
	NPA_Options.SetPageButton(factionbutton,"ColorLibFaction",main)
	--player color button
	local playerbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Class"])
	playerbutton:SetPoint("TOPLEFT",factionbutton,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Class"],playerbutton,nil,2)
	NPA_Options.SetPageButton(playerbutton,"ClassLib",main)
	--threat color button
	local threatbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Threat"])
	threatbutton:SetPoint("TOPLEFT",playerbutton,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Threat"],threatbutton,nil,2)
	NPA_Options.SetPageButton(threatbutton,"ColorLibThreat",main)
	--spellschool color button
	local spellschoolbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["SpellSchool"])
	spellschoolbutton:SetPoint("TOPLEFT",threatbutton,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["SpellSchool"],spellschoolbutton,nil,2)
	NPA_Options.SetPageButton(spellschoolbutton,"ColorLibSpellSchool",main)
	--spelltype color button
	local spelltypebutton=NPA_Options.Template.CreateButton(page,width,15,Localization["SpellType"])
	spelltypebutton:SetPoint("TOPLEFT",spellschoolbutton,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["SpellType"],spelltypebutton,nil,2)
	NPA_Options.SetPageButton(spelltypebutton,"ColorLibSpellType",main)
	--power color button
	local powerbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Power"])
	powerbutton:SetPoint("TOPLEFT",spelltypebutton,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Power"],powerbutton,nil,2)
	NPA_Options.SetPageButton(powerbutton,"ColorLibPower",main)
	----
	NPA_Options.RegisterPage("ColorLib",main)

end)