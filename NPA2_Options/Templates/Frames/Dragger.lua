-- Author      : Nogarder
-- Create Date : 2012/4/15 18:14:30
local Localization=NPA_Options.Localization.TemplatesFramesDragger
--dragger uses circle
--macro for get coordinates
local NPA_Options_Anchor_GetPointCoordinates=NPA_Options.Anchor.GetPointCoordinates
--size
local NPA_Options_Template_Dragger_Size=20
--set function
NPA_Options.Template.CreateDragger=function(parent,dragframe,posx,posy,anchor,danchor,offsetx,offsety)
	--create one
	local frame=CreateFrame("Frame",nil,parent)
	frame:EnableMouse(1)
	frame:SetMovable(true)
	frame:SetScript("OnEnter",function(self)
			NPA_Options.Template.SwitchCircle(self.Circle,1)
		end)
	frame:SetScript("OnLeave",function(self)
			NPA_Options.Template.SwitchCircle(self.Circle,nil)
		end)
	frame:SetScript("OnMouseDown",function(self)
			(dragframe or self):StartMoving()
			self.Dragged=true
		end)
	frame:SetScript("OnMouseUp",function(self)
			(dragframe or self):StopMovingOrSizing()
		end)
	frame:SetWidth(NPA_Options_Template_Dragger_Size)
	frame:SetHeight(NPA_Options_Template_Dragger_Size)
	local textureA=frame:CreateTexture(nil,"OVERLAY")
	textureA:SetPoint("TOP",frame,"TOP",0,0)
	textureA:SetPoint("BOTTOM",frame,"BOTTOM",0,0)
	textureA:SetWidth(NPA_Options_Template_Dragger_Size/8)
	textureA:SetTexture("Interface\\Addons\\NPA2_Options\\texture\\Liner")
	local textureB=frame:CreateTexture(nil,"OVERLAY")
	textureB:SetPoint("LEFT",frame,"LEFT",0,0)
	textureB:SetPoint("RIGHT",frame,"RIGHT",0,0)
	textureB:SetHeight(NPA_Options_Template_Dragger_Size/8)
	textureB:SetTexture("Interface\\Addons\\NPA2_Options\\texture\\Liner")
	NPA_Options.SetTextureRotation(textureB,90)
	--
	frame.Circle=NPA_Options.Template.CreateCircle(frame,NPA_Options_Template_Dragger_Size/2.5,2)
	frame.Circle:SetPoint("CENTER",frame,"CENTER",0,0)
	--
	if(posx and posy)then
		--set point
		--caculate center
		local x=parent:GetLeft()+parent:GetWidth()/2-frame:GetWidth()/2
		local y=parent:GetBottom()+parent:GetHeight()/2-frame:GetHeight()/2
		frame:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",x+posx,y+posy)
		--reset anchor
		parent:ClearAllPoints()
		parent:SetPoint(anchor or "CENTER",frame,danchor or "CENTER",offsetx or -posx,offsety or -posy)
		--set tooltips
		--set type by position
		local tooltipsdirection
		if(posx>=0 and posy>=0)then
			tooltipsdirection=1
		elseif(posx<0 and posy>=0)then
			tooltipsdirection=2
		elseif(posx>=0 and posy<0)then
			tooltipsdirection=3
		elseif(posx<0 and posy<0)then
			tooltipsdirection=4
		end
		NPA_Options.Template.SetTooltips(Localization["DragThis"],frame,nil,tooltipsdirection)
	else
		NPA_Options.Template.SetTooltips(Localization["DragThis"],frame,nil,2)
	end
	--show
	frame:Show()
	--return
	return frame
end
