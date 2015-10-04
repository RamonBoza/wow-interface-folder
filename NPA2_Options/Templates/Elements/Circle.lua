-- Author      : Nogarder
-- Create Date : 2012/4/23 18:29:45
--global
local atan=atan
local table_insert=table.insert
local abs=abs
local Math_Pi=3.14
local table_getn=table.getn
local floor=floor
local sqrt=sqrt
local table_insert=table.insert
local sin=sin
local cos=cos
--main
NPA_Options.Template.Circle={}
--circle texture size, use for both width and height
--rotation requires width and height are same
local CircleSize=10
local MinNumberPerRound=3
local MaxNumberPerRound=24
local CircleScale=0.6
--moving speed factor
local Speed=3
--macro for set texture rotation
local NPA_Options_SetTextureRotation=NPA_Options.SetTextureRotation
local NPA_Options_Template_Circle_SetTexture=function(main,index,step,radius,offset)
	local texture=main.Texture[index]
	local angle=(index+offset)*step
	local posx=sin(angle)*radius
	local posy=cos(angle)*radius
	texture:SetPoint("CENTER",main,"CENTER",posx,posy)
	--set rotation
	NPA_Options_SetTextureRotation(texture,-angle)
end

-- on update control function for animated circle
NPA_Options_Template_Circle_OnUpdateControl=function(circle,elapse)
	--set animation
	if(circle.Focus==true)then
		circle.Offset=circle.Offset+elapse*Speed
		if(circle.Offset>1)then
			circle.Offset=circle.Offset-1
		end
		for i=1,circle.Number do
			NPA_Options_Template_Circle_SetTexture(circle,i,circle.Step,circle.Radius,circle.Offset)
		end
	end
end
--
NPA_Options.Template.SetCircleSize=function(circle,radius)
	circle.Radius=radius
	--caculate premeters
	local length=2*Math_Pi*radius
	--scale and number
	local number,scale
	local size=CircleSize/circle.Dscale
	if(length/MinNumberPerRound>size)then
		--can be more than minimum number at normal size,change number
		scale=1
		number=floor(length/size)-1
		if(number>MaxNumberPerRound)then
			number=MaxNumberPerRound
		end
	else
		--too narrow for normal size, set number to minimum then adjust size
		scale=length/size/MinNumberPerRound
		number=MinNumberPerRound-1
	end
	circle.Number=number
	--step and offset
	local step=360/number
	circle.Step=step
	circle.Offset=0
	circle.Texture=circle.Texture or {}
	for i=1,number do
		if(not circle.Texture[i])then --create texture if not exists
			local texture=circle:CreateTexture("NPA_Options_Border_Texture","OVERLAY")
			texture:SetTexture("Interface\\Addons\\NPA2_Options\\texture\\Liner")
			texture:SetBlendMode("BLEND")
			circle.Texture[i]=texture
		end
		--show it
		circle.Texture[i]:SetHeight(size*scale*CircleScale)
		circle.Texture[i]:SetWidth(size*scale*CircleScale)
		circle.Texture[i]:Show()
		--set rotation
		NPA_Options_Template_Circle_SetTexture(circle,i,step,radius,0)
	end
	--hide extra texture
	for i=number+1, table_getn(circle.Texture) do
		circle.Texture[i]:Hide()
	end
end
--create function
NPA_Options.Template.CreateCircle=function(parent,radius,dscale)
	circle=CreateFrame("Frame",nil,parent)
	circle:SetScript("OnUpdate",NPA_Options_Template_Circle_OnUpdateControl)
	--init it
	circle.Focus=nil
	circle:SetWidth(1)
	circle:SetHeight(1)
	circle.Dscale=dscale or 1
	--update
	NPA_Options.Template.SetCircleSize(circle,radius)
	--
	circle:Show()
	--return pointer
	return circle
end

--turn on or off animating
NPA_Options.Template.SwitchCircle=function(circle,switch)
	if(not circle)then
		return
	end

	if(switch)then
		circle.Focus=true
		--set script
	else
		circle.Focus=nil
	end
end