-- Author      : Nogarder
-- Create Date : 2012/6/21 13:20:37
local Tooltips=NPA_Options.Localization.TemplatesWidgetsInputBox
--
local editbox=NPA_Options.Template.CreateEditBox(UIParent,200,20)
editbox:Hide()
editbox:SetFrameLevel(255)
editbox:SetFrameStrata("Tooltip")
editbox:SetPoint("CENTER",UIParent,"CENTER")
NPA_Options.Template.SetTooltips(Tooltips["EscToCancel"],editbox,nil,2)

NPA_Options.Template.CreateBackground(editbox,editbox,0,1,-10)

local label=NPA_Options.Template.CreateText(editbox,Tooltips["InputValue"])
label:SetPoint("BOTTOM",editbox,"TOP")
--
local button=NPA_Options.Template.CreateButton(editbox,20,20,"+")
button:SetPoint("LEFT",editbox,"RIGHT",1,0)
button:HookScript("OnMouseUp",function()
	NPA_Options.RunFunc(editbox.OnButtonClickedFunc,editbox:GetText())
end)
NPA_Options.Template.SetTooltips(Tooltips["+"],button)
--
local closer=NPA_Options.Template.SetCloser(editbox,nil,2)
closer:SetPoint("RIGHT",editbox,"LEFT",1,0)
--
editbox:SetScript("OnEnterPressed",function(self)
	NPA_Options.RunFunc(self.CallBackFunc,self:GetText())
	self:Hide()
end)
editbox:SetScript("OnCursorChanged",function(self)
	NPA_Options.RunFunc(self.OnValueUpdateFunc)
	end)
editbox:SetScript("OnEscapePressed",function(self)
	self:Hide()
end)
NPA_Options.Template.SetInputBox=function(parent,text,defaultvalue,onbuttonclickedfunc)
	editbox:ClearAllPoints()
	--
	editbox:Hide()
	label:SetText(text)
	--editbox:SetParent(parent)
	editbox:SetText(defaultvalue or nil)
	editbox.CallBackFunc=nil
	editbox.OnValueUpdateFunc=nil
	editbox.CallBackFunc=nil
	NPA_Options.Animation.ShowFrame(editbox)
	--
	if(onbuttonclickedfunc)then
		editbox.OnButtonClickedFunc=onbuttonclickedfunc
		button:Show()
	else
		button:Hide()
	end
	--
	editbox:SetFocus()
	return editbox
end
NPA_Options.Template.HideInputBox=function()
	editbox:Hide()
end
--
NPA_Options.RegisterTemplate(editbox,NPA_Options.Template.HideInputBox)
