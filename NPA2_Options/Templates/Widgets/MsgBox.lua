-- Author      : Nogarder
-- Create Date : 2013/4/17 13:57:35
local Localization=NPA_Options.Localization.TemplatesWidgetsMsgBox
--
local frame=NPA_Options.Template.CreateFrame(UIParent,100,30,nil,true," ")
frame:Hide()
frame:SetPoint("CENTER",UIParent,"CENTER")
frame:SetMovable(1)

NPA_Options.Template.CreateBackground(frame,frame,0,1)
--
local yesbutton=NPA_Options.Template.CreateSystemButton(frame,40,20,Localization["Yes"])
yesbutton:SetPoint("LEFT",frame,"LEFT",5,0)
yesbutton:HookScript("OnClick",function()
	NPA_Options.RunFunc(frame.OnYesButtonClickedFunc)
	frame:Hide()
end)
local nobutton=NPA_Options.Template.CreateButton(frame,40,20,Localization["No"])
nobutton:SetPoint("RIGHT",frame,"RIGHT",-5,0)
nobutton:HookScript("OnMouseUp",function()
	--NPA_Options.RunFunc(frame.OnNoButtonClickedFunc)
	frame:Hide()
end)
--
local closer=NPA_Options.Template.SetCloser(frame,nil,2)
closer:SetPoint("LEFT",editbox,"RIGHT",0,0)
--
frame:SetScript("OnMouseDown",function(self)
	frame:StartMoving()
end)
frame:SetScript("OnMouseUp",function(self)
	frame:StopMovingOrSizing()
end)
--
NPA_Options.Template.SetMsgBox=function(parent,text,onyesbuttonclickedfunc)
	frame:ClearAllPoints()
	--
	frame:Hide()
	frame.Label:SetText(text)
	frame:SetParent(parent)
	frame:SetFrameLevel(parent:GetFrameLevel()+6)
	--
	frame.OnYesButtonClickedFunc=onyesbuttonclickedfunc
	--
	NPA_Options.Animation.ShowFrame(frame)
	return frame
end
NPA_Options.Template.HideMsgBox=function()
	frame:Hide()
end
--
NPA_Options.RegisterTemplate(frame,NPA_Options.Template.HideMsgBox)
