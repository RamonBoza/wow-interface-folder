-- Author      : Nogarder
-- Create Date : 2012/4/11 14:54:13
--uses scroll and liner
NPA_Options.Template.CreateFrame=function(parent,width,height,noborder,nobackground,labeltext,labelpoint)
	--create
	local frame=CreateFrame("Frame",nil,parent)

	if(not noborder)then
		NPA_Options.Template.CreateBorder(frame)
	end
	if(not nobackground)then
		NPA_Options.Template.CreateBackground(frame,nil,0.3,0.8)
	end

	frame:SetWidth(width)
	frame:SetHeight(height)
	frame:EnableMouse(true)
	--label
	if(labeltext)then
		local label=NPA_Options.Template.CreateText(frame,labeltext)
		if(labelpoint==1)then
			--1=left
			label:SetPoint("BOTTOMLEFT",frame,"TOPLEFT",0,0)
		elseif(labelpoint==2)then
			--2=right
			label:SetPoint("BOTTOMRIGHT",frame,"TOPRIGHT",0,0)
		else
			--center by default
			label:SetPoint("BOTTOM",frame,"TOP",0,0)
		end
		frame.Label=label
	end
	--show frame
	frame:Show()
	--return pointer
	return frame
end
--
NPA_Options.Template.DisableFrame=function(frame)
	if(not frame.DisableLinerA)then
		local texture1=frame:CreateTexture(nil,"OVERLAY")
		texture1:SetPoint("TOPLEFT",frame,"TOPLEFT",0,0)
		texture1:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",0,0)
		texture1:SetTexture("Interface\\Addons\\NPA2_Options\\texture\\Liner")
		NPA_Options.SetTextureRotation(texture1,45)
		local texture2=frame:CreateTexture(nil,"OVERLAY")
		texture2:SetPoint("TOPRIGHT",frame,"TOPRIGHT",0,0)
		texture2:SetPoint("BOTTOMLEFT",frame,"BOTTOMLEFT",0,0)
		texture2:SetTexture("Interface\\Addons\\NPA2_Options\\texture\\Liner")
		NPA_Options.SetTextureRotation(texture2,-45)
		frame.DisableLinerA=texture1
		frame.DisableLinerB=texture2
	else
		frame.DisableLinerA:Show()
		frame.DisableLinerB:Show()
	end
	Frame:EnableMouse(false)
end
NPA_Options.Template.EnableFrame=function(frame)
	if(frame.DisableLinerA)then
		frame.DisableLinerA:Hide()
		frame.DisableLinerB:Hide()
	end
	Frame:EnableMouse(true)
end