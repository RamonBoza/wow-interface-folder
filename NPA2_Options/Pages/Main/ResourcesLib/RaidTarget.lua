-- Author      : Nogarder
-- Create Date : 2013/4/19 12:39:55
NPA_Options.RegisterPageFunc("RaidTarget",function()
	local CopyTable=CopyTable
	--localization
	--local Localization=NPA_Options.Localization.PagesRaidTarget
	---
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,nil,210,480,nil,nil)
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
	local buttons={}
	local data=NPA_Options.GetBasicTypeRaidTarget()
	local i=0
	local step=-70
	for value,text in pairs(data)do
		local label=NPA_Options.Template.CreateText(page,text)
		label:SetPoint("TOPLEFT",savebutton,"TOPLEFT",0,-25+step*i)
		local iconbutton=NPA_Options.Template.CreateTextureSelectorButton(page,main,120)
		iconbutton:SetPoint("TOPLEFT",label,"BOTTOMLEFT",40,-20)
		local texture=iconbutton:CreateTexture(nil,OVERLAY)
		texture:SetPoint("RIGHT",iconbutton,"LEFT",-5,0)
		texture:SetHeight(40)
		texture:SetWidth(40)
		--
		iconbutton.OnValueUpdateFunc=function()
			NPA_Options.SetTexture(texture,iconbutton.Value)
		end
		--
		buttons[value]={
			Label=label,
			IconButton=iconbutton,
			IconPreview=texture,
		}
		i=i+1
	end
	page:SetHeight(-step*i+30)
	NPA_Options.Template.UpdateScrollFrame(page)
	--scripts
	local Refresh=function(default)
		local entry
		if(default)then
			entry=NPA.SettingManager.GetDefault("RaidTarget")
		else
			entry=NPA_Setting.RaidTarget
		end
		for index,button in pairs(buttons)do
			NPA_Options.Template.SetDropDownEditor(button.IconButton,entry[index])
			NPA_Options.SetTexture(button.IconPreview,entry[index])
		end
	end
	local Save=function()
		local entry=NPA_Setting.RaidTarget
		for index,button in pairs(buttons)do
			entry[index]=button.IconButton.Value
		end
		NPA.EventHandler.FireEvent(6,"Resources_ProfileRefresh")
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
	NPA_Options.RegisterPage("RaidTarget",main)

end)