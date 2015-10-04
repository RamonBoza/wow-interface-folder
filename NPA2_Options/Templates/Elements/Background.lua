-- Author      : Nogarder
-- Create Date : 2012/6/17 13:35:45

NPA_Options.Template.CreateBackground=function(frame,region,color,alpha,reside)
	local region=region or frame
	local reside=reside or 0
	local background=frame:CreateTexture(nil,"BACKGROUND")
	background:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	background:SetPoint("TOPLEFT",region,"TOPLEFT",-reside,reside)
	background:SetPoint("BOTTOMRIGHT",region,"BOTTOMRIGHT",reside,-reside)
	local ac=color or 1
	local alpha=alpha or 0.25
	background:SetVertexColor(ac,ac,ac,alpha)
	background:Show()
	return background
end
