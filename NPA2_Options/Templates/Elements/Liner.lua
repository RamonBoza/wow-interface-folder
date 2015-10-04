-- Author      : Nogarder
-- Create Date : 2012/4/11 16:04:29
--global
local atan=atan
local strfind=strfind
local abs=abs
local Math_Pi=3.14
local table_getn=table.getn
local floor=floor
local sqrt=sqrt
--liner texture size, use for both width and height
--rotation requires width and height are same
local LinerSize=10
local MinNumberPerLine=3
local MaxNumberPerLine=30
local LinerScale=0.5
--moving speed factor
local Speed=2
-- on update control function for animated liner
local NPA_Options_Template_Liner_OnUpdateControl=function(liner,elapse)
	--set position
	if(not liner:GetParent():IsShown())then
		liner:Hide()
		return
	end
	local startx,starty=liner:GetCenter()
	local endx,endy=liner.EndPoint:GetCenter()
	if((not startx) or (not endx))then
		liner:Hide()
		return
	end
	if(startx==liner.StartX and starty==liner.StartY and endx==liner.EndX and endy==liner.EndY and liner.Focus~=true)then
		return
	else
		liner.StartX=startx
		liner.StartY=starty
		liner.EndX=endx
		liner.EndY=endy
	end
		
	--caculate premeters
	local lengthx=endx-startx
	local lengthy=endy-starty
	if(lengthx==0)then
		lengthx=1
	end
	if(lengthy==0)then
		lengthy=1
	end
	-- lenth=sqrt(a^2+b^2)
	local lenth=sqrt(lengthx*lengthx+lengthy*lengthy)
	--scale and number
	local number,scale
	local size=LinerSize/liner.DScale
	if(lenth/MinNumberPerLine>size)then
		--can be more than minimum number at normal size,change number
		scale=1
		number=floor(lenth/size)-1
		if(number>MaxNumberPerLine)then
			number=MaxNumberPerLine
		end
	else
		--too narrow for normal size, set number to minimum then adjust size
		scale=lenth/size/MinNumberPerLine
		number=MinNumberPerLine-1
	end
	--step and offset
	local dscale=liner:GetScale()
	local stepx=lengthx/number/dscale
	local stepy=lengthy/number/dscale
	--angle
	local angle=atan(lengthy/abs(lengthx))
	if(lengthx<0)then
		angle=-angle--Math_Pi-angle
	end
	
	--set animation
	if(liner.Focus)then
		liner.Offset=liner.Offset+elapse*Speed
		if(liner.Offset>1)then
			liner.Offset=liner.Offset-1
		end
	end

	for i=1,number do
		local texture
		if(not liner.Texture[i])then --create texture if not exists
			texture=liner:CreateTexture(nil,"OVERLAY")
			texture:SetTexture("Interface\\Addons\\NPA2_Options\\texture\\Liner")
			texture:SetBlendMode("BLEND")
			liner.Texture[i]=texture
		else
			texture=liner.Texture[i]
		end
		--show it
		texture:SetHeight(size*scale*LinerScale)
		texture:SetWidth(size*scale*LinerScale)
		--set offset
		local index=i-1+liner.Offset
		texture:SetPoint("CENTER",liner,"CENTER",stepx*index,stepy*index)
		--set rotation
		NPA_Options.SetTextureRotation(texture,angle)
		texture:Show()
	end
	--hide unused textures (if exists)
	for i=number+1, table_getn(liner.Texture) do
		liner.Texture[i]:Hide()
	end
end

--struct point={
--		Frame=<frame>,
--		Anchor=<Anchor>,
--		OffsetX=<offsetx>,
--		OffsetY=<offsety>,
--	}

--create function
NPA_Options.Template.CreateLiner=function(parent,startpoint,endpoint,dscale)
	liner=CreateFrame("Frame",nil,parent)
	liner:SetScript("OnUpdate",NPA_Options_Template_Liner_OnUpdateControl)
	--init it
	liner.DScale=dscale or 1
	liner.Texture={}
	liner.Offset=0.5
	liner:SetWidth(1)
	liner:SetHeight(1)
	if(startpoint)then
		liner:SetPoint("CENTER",startpoint.Frame,startpoint.Anchor,startpoint.OffsetX,startpoint.OffsetY)
	end
	liner.EndPoint=liner:CreateTexture(nil,"BACKGROUND")
	liner.EndPoint:SetHeight(1)
	liner.EndPoint:SetWidth(1)
	if(endpoint)then
		liner.EndPoint:SetPoint("CENTER",endpoint.Frame,endpoint.Anchor,endpoint.OffsetX,endpoint.OffsetY)
	end
	liner:Show()
	--return pointer
	return liner
end
--turn on or off animating
NPA_Options.Template.SetLinerFocus=function(liner,switch)
	if(switch)then
		liner.Focus=true
		--set script
	else
		liner.Focus=nil
	end
end

--macro for create rectangle border
NPA_Options.Template.CreateLinerBorder=function(frame,scale,autofocus,reside)
	local reside=reside or 0
	local width=frame:GetWidth()/2
	local height=frame:GetHeight()/2
	--top is left to right
	frame.TopBorder=NPA_Options.Template.CreateLiner(
		frame,
		{
			Frame=frame,
			Anchor="TOPLEFT",
			OffsetX=0,
			OffsetY=reside,
			},
		{
			Frame=frame,
			Anchor="TOPRIGHT",
			OffsetX=0,
			OffsetY=reside,
			},
		scale)
	--bottom is right to left
	frame.BottomBorder=NPA_Options.Template.CreateLiner(
		frame,
		{
			Frame=frame,
			Anchor="BOTTOMRIGHT",
			OffsetX=0,
			OffsetY=-reside,
			},
		{
			Frame=frame,
			Anchor="BOTTOMLEFT",
			OffsetX=0,
			OffsetY=-reside,
			},
		scale)
	--left is down to up
	frame.LeftBorder=NPA_Options.Template.CreateLiner(
		frame,
		{
			Frame=frame,
			Anchor="BOTTOMLEFT",
			OffsetX=-reside,
			OffsetY=0,
			},
		{
			Frame=frame,
			Anchor="TOPLEFT",
			OffsetX=-reside,
			OffsetY=0,
			},
		scale)
	--right is up to down
	frame.RightBorder=NPA_Options.Template.CreateLiner(
		frame,
		{
			Frame=frame,
			Anchor="TOPRIGHT",
			OffsetX=reside,
			OffsetY=0,
			},
		{
			Frame=frame,
			Anchor="BOTTOMRIGHT",
			OffsetX=reside,
			OffsetY=0,
			},
		scale)
end
--macro for show/hide rectangle border
NPA_Options.Template.ShowLinerBorder=function(frame)
	frame.TopBorder:Show()
	frame.BottomBorder:Show()
	frame.LeftBorder:Show()
	frame.RightBorder:Show()
end
NPA_Options.Template.HideLinerBorder=function(frame)
	frame.TopBorder:Hide()
	frame.BottomBorder:Hide()
	frame.LeftBorder:Hide()
	frame.RightBorder:Hide()
end
--macro for turn on/off border animation
NPA_Options.Template.SetLinerBorderFocus=function(frame,switch)
	NPA_Options.Template.SetLinerFocus(frame.TopBorder,switch)
	NPA_Options.Template.SetLinerFocus(frame.BottomBorder,switch)
	NPA_Options.Template.SetLinerFocus(frame.LeftBorder,switch)
	NPA_Options.Template.SetLinerFocus(frame.RightBorder,switch)
end
