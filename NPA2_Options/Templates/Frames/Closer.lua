-- Author      : Nogarder
-- Create Date : 2012/4/15 18:14:30
local Localization=NPA_Options.Localization.TemplatesFramesCloser
--size
local NPA_Options_Template_Closer_Size=18
--set function
NPA_Options.Template.SetCloser=function(parent,closeframe,tooltipsdirection)
	--create one
	local frame=CreateFrame("Frame",nil,parent)
	frame:EnableMouse(1)
	frame:SetMovable(1)
	frame:SetScript("OnMouseUp",function(self)
			NPA_Options.ClosePages(self.CloseFrame)
		end)
	--cross
	frame:SetWidth(NPA_Options_Template_Closer_Size)
	frame:SetHeight(NPA_Options_Template_Closer_Size)
	local textureA=frame:CreateTexture(nil,"OVERLAY")
	textureA:SetPoint("TOPLEFT",frame,"TOPLEFT",0,0)
	textureA:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",0,0)
	textureA:SetTexture("Interface\\Addons\\NPA2_Options\\texture\\Liner")
	NPA_Options.SetTextureRotation(textureA,45)
	local textureB=frame:CreateTexture(nil,"OVERLAY")
	textureB:SetPoint("TOPLEFT",frame,"TOPLEFT",0,0)
	textureB:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",0,0)
	textureB:SetTexture("Interface\\Addons\\NPA2_Options\\texture\\Liner")
	NPA_Options.SetTextureRotation(textureB,135)
	--
	NPA_Options.Template.SetAutoFocus(frame)
	--set tooltips
	NPA_Options.Template.SetTooltips(Localization["ClickThisToClose"],frame,nil,tooltipsdirection)
	frame.CloseFrame=closeframe or parent
	--show
	frame:Show()
	--return
	return frame
end
