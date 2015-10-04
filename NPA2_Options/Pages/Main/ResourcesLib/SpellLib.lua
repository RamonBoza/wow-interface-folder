-- Author      : Nogarder
-- Create Date : 2012/11/4 7:50:29
NPA_Options.RegisterPageFunc("SpellLib",function()

	local Localization=NPA_Options.Localization.PagesResourcesLibSpellLib
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["SpellLib"],100,240,nil,nil)
	main:Hide()
	local page=main.Frame
	--
	page:SetWidth(100)
	page:SetHeight(240)
	--
	local width=90
	local step=-5
	--autodetector button
	local autodetectorbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["AutoDetector"])
	autodetectorbutton:SetPoint("TOP",page,"TOP",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["AutoDetector"],autodetectorbutton,nil,2)
	NPA_Options.SetPageButton(autodetectorbutton,"SpellLibAutoDetector",main)
	--libeditor button
	local libeditorbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["LibEditor"])
	libeditorbutton:SetPoint("TOPLEFT",autodetectorbutton,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["LibEditor"],libeditorbutton,nil,2)
	NPA_Options.SetPageButton(libeditorbutton,"SpellLibLibEditor",main)
	--catalog button
	local catalogbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Catalog"])
	catalogbutton:SetPoint("TOPLEFT",libeditorbutton,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Catalog"],catalogbutton,nil,2)
	NPA_Options.SetPageButton(catalogbutton,"SpellLibCatalog",main)
	--
	NPA_Options.RegisterPage("SpellLib",main)

end)