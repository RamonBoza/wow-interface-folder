-- Author      : Nogarder
-- Create Date : 2012/7/27 11:32:14
NPA_Options.RegisterPageFunc("ColorLibFaction",function()

	local CopyTable=CopyTable
	--localization
	local Localization=NPA_Options.Localization.PagesColorLibFaction
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	local entry=NPA_Setting.Color["Faction"]
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["Faction"],210,165,nil,nil)
	main:Hide()
	local page=main.Frame
	--
	page:SetWidth(210)
	page:SetHeight(240)
	local width=200
	--
	local step=-25
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
	--friendly
	local friendlybutton=NPA_Options.Template.CreateColorButton(page,width,20,Localization["Friendly"],main,Tooltips["Friendly"])
	friendlybutton:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,step)
	--neutral
	local neutralbutton=NPA_Options.Template.CreateColorButton(page,width,20,Localization["Neutral"],main,Tooltips["Neutral"])
	neutralbutton:SetPoint("TOP",friendlybutton,"BOTTOM",0,step)
	--hostile
	local hostilebutton=NPA_Options.Template.CreateColorButton(page,width,20,Localization["Hostile"],main,Tooltips["Hostile"])
	hostilebutton:SetPoint("TOP",neutralbutton,"BOTTOM",0,step)
	--scripts
	local Refresh=function()
		NPA_Options.Template.SetColorButton(friendlybutton,entry[1])
		NPA_Options.Template.SetColorButton(neutralbutton,entry[2])
		NPA_Options.Template.SetColorButton(hostilebutton,entry[3])
	end
	local Save=function()
		entry[1]=CopyTable(friendlybutton.Value)
		entry[2]=CopyTable(neutralbutton.Value)
		entry[3]=CopyTable(hostilebutton.Value)
		NPA.EventHandler.FireEvent(6,"Resources_ProfileRefresh")
	end
	local Reset=function()
		local defaultcolor=NPA.SettingManager.GetDefault("Color")["Faction"]
		NPA_Options.Template.SetColorButton(friendlybutton,defaultcolor[1])
		NPA_Options.Template.SetColorButton(neutralbutton,defaultcolor[2])
		NPA_Options.Template.SetColorButton(hostilebutton,defaultcolor[3])
	end
	main:HookScript("OnShow",Refresh)
	savebutton:HookScript("OnMouseUp",Save)
	cancelbutton:HookScript("OnMouseUp",Refresh)
	resetbutton:HookScript("OnMouseUp",Reset)
	----
	NPA_Options.RegisterPage("ColorLibFaction",main)

end)