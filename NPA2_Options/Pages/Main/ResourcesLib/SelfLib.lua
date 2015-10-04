-- Author      : Nogarder
-- Create Date : 2013/9/8 16:55:16
NPA_Options.RegisterPageFunc("SelfLib",function()
	local CopyTable=CopyTable
	--localization
	local Localization=NPA_Options.Localization.PagesSelfLib
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,nil,210,110,nil,nil)
	main:Hide()
	local page=main.Frame
	--
	page:SetWidth(210)
	page:SetHeight(240)
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
	local label=NPA_Options.Template.CreateText(page,Localization["Color"])
	label:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,-5)
	local colorbutton=NPA_Options.Template.CreateColorButton(page,200,20,nil,main)
	colorbutton:SetPoint("TOPLEFT",label,"BOTTOMLEFT",0,-5)

	local label2=NPA_Options.Template.CreateText(page,Localization["Text"])
	label2:SetPoint("TOPLEFT",colorbutton,"TOPLEFT",0,-20)

	local editbox=NPA_Options.Template.CreateEditBox(page,200,20)
	editbox:SetPoint("TOPLEFT",label2,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips.Text,editbox)
	--scripts
	local Refresh=function(default)
		local entry
		if(default)then
			entry=NPA.SettingManager.GetDefault("SelfLib")
		else
			entry=NPA_Setting.SelfLib
		end
		NPA_Options.Template.SetColorButton(colorbutton,entry.Color)
		editbox:SetText(entry.Text)
	end
	local Save=function()
		local entry=NPA_Setting.SelfLib
		entry.Color=CopyTable(colorbutton.Value)
		entry.Text=editbox:GetText()
	end
	local Reset=function()
		Refresh(true)
	end
	savebutton:HookScript("OnMouseUp",Save)
	cancelbutton:HookScript("OnMouseUp",Refresh)
	resetbutton:HookScript("OnMouseUp",Reset)
	--
	main.OnSetFunc=Refresh
	----
	NPA_Options.RegisterPage("SelfLib",main)

end)