-- Author      : Nogarder
-- Create Date : 2012/6/27 14:27:07
local abs=abs
NPA_Options.Template.CreateBorder=function(frame,region,color,alpha,reside,size)
	local color=color or 1
	local alpha=alpha or 1
	local region=region or frame
	local reside=reside or -2
	local size=size or 3
	local topborder=frame:CreateTexture(nil,"OVERLAY")
	topborder:SetTexture("Interface\\Addons\\NPA2_Options\\texture\\Liner")
	topborder:SetPoint("BOTTOMLEFT",region,"TOPLEFT",0,reside)
	topborder:SetPoint("BOTTOMRIGHT",region,"TOPRIGHT",0,reside)
	topborder:SetVertexColor(color,color,color,alpha)
	topborder:SetHeight(size)

	local bottomborder=frame:CreateTexture(nil,"OVERLAY")
	bottomborder:SetTexture("Interface\\Addons\\NPA2_Options\\texture\\Liner")
	bottomborder:SetPoint("TOPLEFT",region,"BOTTOMLEFT",0,-reside)
	bottomborder:SetPoint("TOPRIGHT",region,"BOTTOMRIGHT",0,-reside)
	bottomborder:SetVertexColor(color,color,color,alpha)
	bottomborder:SetHeight(size)

	local leftborder=frame:CreateTexture(nil,"OVERLAY")
	leftborder:SetTexture("Interface\\Addons\\NPA2_Options\\texture\\Liner")
	leftborder:SetPoint("TOPRIGHT",region,"TOPLEFT",-reside,0)
	leftborder:SetPoint("BOTTOMRIGHT",region,"BOTTOMLEFT",-reside,0)
	leftborder:SetVertexColor(color,color,color,alpha)
	leftborder:SetWidth(size)
	NPA_Options.SetTextureRotation(leftborder,90)

	local rightborder=frame:CreateTexture(nil,"OVERLAY")
	rightborder:SetTexture("Interface\\Addons\\NPA2_Options\\texture\\Liner")
	rightborder:SetPoint("TOPLEFT",region,"TOPRIGHT",reside,0)
	rightborder:SetPoint("BOTTOMLEFT",region,"BOTTOMRIGHT",reside,0)
	rightborder:SetVertexColor(color,color,color,alpha)
	rightborder:SetWidth(size)
	NPA_Options.SetTextureRotation(rightborder,90)

end
