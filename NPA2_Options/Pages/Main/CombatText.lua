-- Author      : Nogarder
-- Create Date : 2013/4/20 16:50:44
NPA_Options.RegisterPageFunc("CombatText",function()
	--localization
	local Localization=NPA_Options.Localization.PagesCombatText
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	--main page
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["CombatText"],100,80,nil,nil,nil,nil)
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
	NPA_Options.SetPageButton(conditionbutton,"CombatTextCondition",main)
	--Animation button
	local animationbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Animation"])
	animationbutton:SetPoint("TOPLEFT",conditionbutton,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Animation"],animationbutton,nil,2)
	NPA_Options.SetPageButton(animationbutton,"CombatTextAnimation",main)
	--
	NPA_Options.RegisterPage("CombatText",main)
end)