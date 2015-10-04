-- Author      : Nogarder
-- Create Date : 2012/6/25 12:37:54

local focusbox=CreateFrame("Frame",nil)
focusbox:Hide()
focusbox:SetWidth(1)
focusbox:SetHeight(1)
NPA_Options.Template.CreateLinerBorder(focusbox,2)
NPA_Options.Template.SetLinerBorderFocus(focusbox,1)
--
NPA_Options.Template.SetFocusBox=function(frame,reside)
	local reside=reside or 2
	focusbox:ClearAllPoints()
	focusbox:SetPoint("TOPLEFT",frame,"TOPLEFT",-reside,reside)
	focusbox:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",reside,-reside)
	focusbox:SetParent(frame)
	NPA_Options.Template.SetLinerBorderFocus(focusbox,1)
	focusbox:Show()
end
NPA_Options.Template.HideFocusBox=function()
	focusbox:Hide()
end
--
NPA_Options.Template.FocusFocusBox=function(switch)
	NPA_Options.Template.SetLinerBorderFocus(focusbox,switch)
end
NPA_Options.Template.SetAutoFocus=function(frame)
	frame:HookScript("OnEnter",function()
			NPA_Options.Template.SetFocusBox(frame,0)
	end)
	frame:HookScript("OnLeave",function()
			focusbox:Hide()
	end)
	frame:HookScript("OnMouseDown",function()
		NPA_Options.Template.FocusFocusBox(nil)
	end)
	frame:HookScript("OnMouseUp",function()
		NPA_Options.Template.FocusFocusBox(1)
	end)
end
--
NPA_Options.RegisterTemplate(focusbox,NPA_Options.Template.HideFocusBox)
