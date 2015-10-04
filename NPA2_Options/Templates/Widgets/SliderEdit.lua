-- Author      : Nogarder
-- Create Date : 2012/7/16 5:36:17
local Localization=NPA_Options.Localization.TemplatesWidgetsSliderEdit
local Tooltips=Localization.Tooltips
local tonumber=tonumber
--
NPA_Options.Template.CreateSliderEdit=function(parent,width1,width2,height,min,max,step,value,label,tooltip,notextendable)
	local slideredit=CreateFrame("Frame",nil,parent)
	slideredit:SetWidth(width1+width2)
	slideredit:SetHeight(height)
	slideredit.Value=value
	NPA_Options.Template.SetTooltips(tooltip,slideredit,nil,nil,slideredit)
	--
	local editbox=NPA_Options.Template.CreateEditBox(slideredit,width2-1,height)
	editbox:SetPoint("RIGHT",slideredit,"RIGHT",0,0)
	NPA_Options.Template.SetTooltips(tooltip,editbox,nil,nil,slideredit)
	editbox:SetText(value)
	slideredit.EditBox=editbox
	--
	local labelmin=NPA_Options.Template.CreateText(slideredit," ",true)
	labelmin:SetPoint("LEFT",slideredit,"LEFT",0,0)
	labelmin:SetText(min)
	slideredit.LabelMin=labelmin
	--
	local labelmax=NPA_Options.Template.CreateText(slideredit," ",true)
	labelmax:SetPoint("RIGHT",editbox,"LEFT",-2,0)
	labelmax:SetText(max)
	slideredit.LabelMax=labelmax
	--
	local slider=NPA_Options.Template.CreateSlider(slideredit,min,max,step,value,1,function(self)
		if(self.UpdateByEditBox)then
			self.UpdateByEditBox=nil
		else
			editbox.UpdateBySlider=true
			slideredit.Value=self.Value
			slideredit.EditBox:SetText(self.Value)
			NPA_Options.RunFunc(slideredit.OnValueUpdateFunc,slideredit)
		end
	end)
	slider:SetPoint("LEFT",labelmin,"RIGHT",2,0)
	slider:SetPoint("RIGHT",labelmax,"LEFT",-2,0)
	slider:SetHeight(height)
	NPA_Options.Template.SetTooltips(tooltip,slider,nil,nil,slideredit)
	slideredit.Slider=slider
	--
	local label=NPA_Options.Template.CreateText(slideredit,label,true)
	label:SetPoint("BOTTOM",slideredit,"TOP",0,2)
	slideredit.Label=label
	--
	editbox:HookScript("OnCursorChanged",function()
		local slider=slideredit.Slider
		if(editbox.UpdateBySlider)then
			editbox.UpdateBySlider=nil
		else
			local value=tonumber(editbox:GetText())
			slider.UpdateByEditBox=true
			NPA_Options.Template.SetSlider(slider,value)
			slideredit.Value=slider.Value
			NPA_Options.RunFunc(slideredit.OnValueUpdateFunc,slideredit)
		end
	end)
	editbox:HookScript("OnEnterPressed",function()
		local value=tonumber(editbox:GetText())
		local slider=slideredit.Slider
		slider.UpdateByEditBox=true
		NPA_Options.Template.SetSlider(slider,value,nil,nil,nil,(not notextendable))
		slideredit.LabelMin:SetText(slideredit.Slider.Min)
		slideredit.LabelMax:SetText(slideredit.Slider.Max)
		--
		editbox:SetText(slider.Value)
	end)
	--
	return slideredit
end

NPA_Options.Template.SetSliderEdit=function(slideredit,value,min,max,step)
	NPA_Options.Template.SetSlider(slideredit.Slider,value,min,max,step,true,true)
	slideredit.EditBox.UpdateBySlider=true
	slideredit.EditBox:SetText(slideredit.Slider.Value)
	slideredit.LabelMin:SetText(slideredit.Slider.Min)
	slideredit.LabelMax:SetText(slideredit.Slider.Max)
	slideredit.Value=slideredit.Slider.Value
end
--macro for create special slider edit
NPA_Options.Template.CreateSpecialSliderEdit=function(parent,width1,width2,height,min,max,step,value,ttype,notextendable)
	return NPA_Options.Template.CreateSliderEdit(parent,width1,width2,height,min,max,step,value,Localization[ttype],Tooltips[ttype],notextendable)
end
--
--disable
NPA_Options.Template.DisableSliderEdit=function(editor)
	if(not editor.DisableLiner)then
		local texture=editor:CreateTexture(nil,"OVERLAY")
		texture:SetPoint("LEFT",editor,"LEFT",0,0)
		texture:SetPoint("RIGHT",editor,"RIGHT",0,0)
		texture:SetHeight(editor:GetHeight()/5)
		texture:SetTexture("Interface\\Addons\\NPA2_Options\\texture\\Liner")
		texture:Show()
		editor.DisableLiner=texture
	else
		editor.DisableLiner:Show()
	end
	editor:SetAlpha(0.5)
	editor:EnableMouse(false)
end
--macro for enable button
NPA_Options.Template.EnableSliderEdit=function(editor)
	if(editor.DisableLiner)then
		editor.DisableLiner:Hide()
	end
	editor:SetAlpha(1)
	editor:EnableMouse(true)
end
--
