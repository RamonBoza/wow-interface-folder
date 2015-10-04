-- Author      : Nogarder
-- Create Date : 2013/4/2 11:24:42
NPA_Options.RegisterPageFunc("ColorLibSpellSchool",function()

	local CopyTable=CopyTable
	--localization
	local Localization=NPA_Options.Localization.PagesColorLibSpellSchool
	---
	local parent=NPA_Options.MainFrame
	local entry=NPA_Setting.Color["SpellSchool"]
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["SpellSchool"],210,350,nil,nil)
	main:Hide()
	local page=main.Frame
	--
	page:SetWidth(210)
	local width=200
	--
	--save
	local buttonwidth=(210-15)/3
	local savebutton=NPA_Options.Template.CreateSpecialButton(page,buttonwidth,15,"Save")
	savebutton:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	--reset
	local resetbutton=NPA_Options.Template.CreateSpecialButton(page,buttonwidth,15,"Reset")
	resetbutton:SetPoint("TOPRIGHT",page,"TOPRIGHT",-5,-5)
	--cancel
	local cancelbutton=NPA_Options.Template.CreateSpecialButton(page,buttonwidth,15,"Cancel")
	cancelbutton:SetPoint("LEFT",savebutton,"RIGHT",5,0)
	cancelbutton:SetPoint("RIGHT",resetbutton,"LEFT",-5,0)
	--buttons
	local buttons={}
	local data=NPA_Options.GetBasicTypeSpellSchool()
	local i=0
	local step=-45
	for value,text in pairs(data)do
		i=i+1
		buttons[value]=NPA_Options.Template.CreateColorButton(page,width,20,text,main,Localization["Change"]..text..Localization["sColor"])
		buttons[value]:SetPoint("TOPLEFT",savebutton,"TOPLEFT",0,step*i)
	end
	page:SetHeight(-step*i+30)
	NPA_Options.Template.UpdateScrollFrame(page)
	--scripts
	local Refresh=function()
		for index,button in pairs(buttons)do
			NPA_Options.Template.SetColorButton(button,entry[index])
		end
	end
	local Save=function()
		for index,button in pairs(buttons)do
			entry[index]=CopyTable(button.Value)
		end
		NPA.EventHandler.FireEvent(6,"Resources_ProfileRefresh")
	end
	local Reset=function()
		local defaultcolor=NPA.SettingManager.GetDefault("Color")["SpellSchool"]
		for index,button in pairs(buttons)do
			NPA_Options.Template.SetColorButton(button,defaultcolor[index])
		end
	end
	main:HookScript("OnShow",Refresh)
	savebutton:HookScript("OnMouseUp",Save)
	cancelbutton:HookScript("OnMouseUp",Refresh)
	resetbutton:HookScript("OnMouseUp",Reset)
	----
	NPA_Options.RegisterPage("ColorLibSpellSchool",main)

end)