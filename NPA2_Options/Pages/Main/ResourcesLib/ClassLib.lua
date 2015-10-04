-- Author      : Nogarder
-- Create Date : 2012/7/27 16:31:03
NPA_Options.RegisterPageFunc("ClassLib",function()

	local CopyTable=CopyTable
	--localization
	local Localization=NPA_Options.Localization.PagesClassLibPlayer
	---
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["PlayerClass"],210,480,nil,nil)
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
	local data=NPA_Options.GetBasicTypeClass()
	local i=0
	local step=-90
	for value,text in pairs(data)do
		local label=NPA_Options.Template.CreateText(page,text)
		label:SetPoint("TOPLEFT",savebutton,"TOPLEFT",0,-25+step*i)
		local colorbutton=NPA_Options.Template.CreateColorButton(page,200,20,nil,main)
		colorbutton:SetPoint("TOPLEFT",label,"BOTTOMLEFT",0,-5)
		local iconbutton=NPA_Options.Template.CreateTextureSelectorButton(page,main,110)
		iconbutton:SetPoint("TOPRIGHT",colorbutton,"BOTTOMRIGHT",-60,-20)
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
			ColorButton=colorbutton,
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
			entry=NPA.SettingManager.GetDefault("Class")
		else
			entry=NPA_Setting.Class
		end
		for index,button in pairs(buttons)do
			NPA_Options.Template.SetColorButton(button.ColorButton,entry[index].Color)
			NPA_Options.Template.SetDropDownEditor(button.IconButton,entry[index].ProfileName)
			NPA_Options.SetTexture(button.IconPreview,entry[index].ProfileName)
		end
	end
	local Save=function()
		local entry=NPA_Setting.Class
		for index,button in pairs(buttons)do
			entry[index].Color=CopyTable(button.ColorButton.Value)
			entry[index].ProfileName=button.IconButton.Value
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
	NPA_Options.RegisterPage("ClassLib",main)

end)