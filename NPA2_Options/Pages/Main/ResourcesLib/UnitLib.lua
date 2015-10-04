-- Author      : Nogarder
-- Create Date : 2014/5/28 8:47:20

NPA_Options.RegisterPageFunc("UnitLib",function()

	local CopyTable=CopyTable
	--localization
	local Localization=NPA_Options.Localization.PagesUnitLib
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,nil,210,420,nil,nil)
	main:Hide()
	local page=main.Frame
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
	local data=Localization.UnitData
	local i=0
	local step=-65
	for value,text in pairs(data)do
		local label=NPA_Options.Template.CreateText(page,text)
		label:SetPoint("TOPLEFT",savebutton,"TOPLEFT",0,-30+step*i)
		--
		local editbox=NPA_Options.Template.CreateEditBox(page,100,20,true)
		editbox:SetPoint("LEFT",label,"RIGHT",5,0)
		--
		local slideredit=NPA_Options.Template.CreateSliderEdit(page,180,15,20,0,10,1,1,Localization["Priority"],Tooltips["Priority"])
		slideredit:SetPoint("TOPLEFT",label,"BOTTOMLEFT",0,-20)
		--
		buttons[value]={
			EditBox=editbox,
			SliderEdit=slideredit
		}
		i=i+1
	end
	page:SetHeight(-step*i+30)
	NPA_Options.Template.UpdateScrollFrame(page)
	--scripts
	local Refresh=function(default)
		local entry
		if(default)then
			entry=NPA.SettingManager.GetDefault("Unit")
		else
			entry=NPA_Setting.Unit
		end
		for index,button in pairs(buttons)do
			button.EditBox:SetText(entry.Name[index])
			NPA_Options.Template.SetSliderEdit(button.SliderEdit,entry.Priority[index])
		end
	end
	local Save=function()
		local entry=NPA_Setting.Unit
		for index,button in pairs(buttons)do
			entry.Name[index]=button.EditBox:GetText()
			entry.Priority[index]=button.SliderEdit.Value
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
	NPA_Options.RegisterPage("UnitLib",main)

end)
