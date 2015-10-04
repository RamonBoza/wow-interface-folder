-- Author      : Nogarder
-- Create Date : 2013/5/3 12:41:43
--localization
local IndexLocalization=NPA_Options.Localization.Help.Index
local TextLocalization=NPA_Options.Localization.Help.Text
--
--main page
local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,"NamePlate Advance 2 Build "..NPA.Version,410,430,nil,nil,true,nil)
main:Hide()
main.LinkTo=NPA_Options.MainPage
--
local page=main.Frame
--
local selectlist=NPA_Options.Template.CreateSelectList(page,380,200)
selectlist:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
selectlist:SetPoint("TOPRIGHT",page,"TOPRIGHT",-25,-5)
--	
local textbox=NPA_Options.Template.CreateMultiLineEditBox(page,380,180)
textbox.Scroll:SetPoint("TOPLEFT",selectlist,"BOTTOMLEFT",0,-15)
textbox.Scroll:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT",-25,5)
textbox:SetMaxLetters(65535)
--textbox:HookScript("OnCursorChanged",function()
--		textbox:ClearFocus()
--	end)
--
local title=NPA_Options.Template.CreateText(page)
title:SetPoint("BOTTOM",textbox.Scroll,"TOP",0,2)
--
selectlist.ButtonClickFunc=function(button)
	title:SetText(button.Text)
	textbox:SetText(TextLocalization[button.Value])
end
--
main:SetScript("OnShow",function()
	--init list
	NPA_Options.Template.UpdateSelectList(selectlist,IndexLocalization,true)
	main.Dragged=true
end)
--
NPA_Options.RegisterPage("Help",main)
NPA_Options.HelpPage=main
