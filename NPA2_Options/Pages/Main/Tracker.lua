-- Author      : Nogarder
-- Create Date : 2013/6/6 15:58:44
NPA_Options.RegisterPageFunc("Tracker",function()
	--localization
	local Localization=NPA_Options.Localization.PagesTracker
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	--main page
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["Tracker"],100,80,nil,nil,nil,nil)
	main:SetPoint("CENTER",parent,"CENTER",-60,120)
	main:Hide()
	--
	local page=main.Frame
	page:SetWidth(100)
	page:SetHeight(80)
	local width=90
	local step=-5
	--condition button
	local conditionbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Condition"])
	conditionbutton:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Condition"],conditionbutton,nil,2)
	NPA_Options.SetPageButton(conditionbutton,"TrackerCondition",main)
	--Animation button
	local nameplatesbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Nameplates"])
	nameplatesbutton:SetPoint("TOPLEFT",conditionbutton,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["NamePlates"],nameplatesbutton,nil,2)
	NPA_Options.SetPageButton(nameplatesbutton,"TrackerNameplates",main)
	--
	NPA_Options.RegisterPage("Tracker",main)
end)