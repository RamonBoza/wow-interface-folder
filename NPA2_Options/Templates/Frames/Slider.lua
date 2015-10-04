-- Author      : Nogarder
-- Create Date : 2012/4/11 15:03:31
--global
local floor=floor
local mod=mod
--macro for setting marker
local NPA_Options_Template_Slider_SetMarker=function(frame)
	--caculate related position
	local pos=(frame.Value-frame.Min)/(frame.Max-frame.Min)-1/2
	--direction=
	--1=left to right
	--2=right to left
	--3=up to down
	--4=down to up
	local height=frame:GetHeight()
	local width=frame:GetWidth()
	if(frame.Direction==1)then
		--left to right
		frame.Marker:SetWidth(height)
		frame.Marker:SetHeight(height)
		frame.Marker:SetPoint("CENTER",frame,"CENTER",pos*width,0)
		--rotate 90
		NPA_Options.SetTextureRotation(frame.Marker,90)
	elseif(frame.Direction==2)then
		--right to left
		frame.Marker:SetWidth(height)
		frame.Marker:SetHeight(height)
		frame.Marker:SetPoint("CENTER",frame,"CENTER",-pos*width,0)
		--rotate 90
		NPA_Options.SetTextureRotation(frame.Marker,90)
	elseif(frame.Direction==3)then
		--up to down
		frame.Marker:SetWidth(width)
		frame.Marker:SetHeight(width)
		frame.Marker:SetPoint("CENTER",frame,"CENTER",0,-pos*height)
		--rotate 0
		NPA_Options.SetTextureRotation(frame.Marker,0)
	elseif(frame.Direction==4)then
		--down to up
		frame.Marker:SetWidth(width)
		frame.Marker:SetHeight(width)
		frame.Marker:SetPoint("CENTER",frame,"CENTER",0,pos*height)
		--rotate 0
		NPA_Options.SetTextureRotation(frame.Marker,0)
	end
end
--create function
--set
NPA_Options.Template.CreateSlider=function(parent,min,max,step,value,direction,onupdatefunc,solidbackground)
	--create
	local frame=CreateFrame("Frame",nil,parent)
	if(solidbackground)then
		NPA_Options.Template.CreateBackground(frame,nil,0.5,1)
	else
		NPA_Options.Template.CreateBackground(frame)
	end
	--init it
	frame.Min=min
	frame.Max=max
	frame.Step=step
	frame:EnableMouse(1)
	frame.Value=value
	frame.Direction=direction
	frame.MouseDown=nil
	frame.OnUpdateFunc=onupdatefunc

	--marker
	frame.Marker=frame:CreateTexture(nil,"OVERLAY")
	frame.Marker:SetTexture("Interface\\Addons\\NPA2_Options\\texture\\Liner")
	frame.Marker:SetPoint("CENTER",frame,"CENTER",0,0)
	frame.Marker:Show()

	frame.MouseDown=nil
	--scripts
	NPA_Options.Template.SetAutoFocus(frame)
	frame:SetScript("OnHide",function(frame)
			frame.MouseDown=nil
		end)
	frame:SetScript("OnMouseDown",function(frame)
			frame.MouseDown=true
		end)
	frame:SetScript("OnMouseUp",function(frame)
			frame.MouseDown=nil
		end)
	frame:SetScript("OnMouseWheel",function(frame,value)
			local value=frame.Value - floor(value*20)*frame.Step
			NPA_Options.Template.SetSlider(frame,value)
		end)
	frame:SetScript("OnUpdate",function(frame)
			--has button down, drag it
			if(frame.MouseDown)then
				--caculate related position
				local x,y=GetCursorPosition()
				local value
				local scale=frame:GetEffectiveScale()
				if(frame.Direction==1)then
					--left to right use x
					value=(x-frame:GetLeft()*scale)/frame:GetWidth()/scale
				elseif(frame.Direction==2)then
					--right to left use x
					value=(frame:GetRight()*scale-x)/frame:GetWidth()/scale
				elseif(frame.Direction==3)then
					--up to down use y
					value=(frame:GetTop()*scale-y)/frame:GetHeight()/scale
				elseif(frame.Direction==4)then
					--down to up use y
					value=(y-frame:GetBottom()*scale)/frame:GetHeight()/scale
				end
				--change related value to value
				local crange=(frame.Max-frame.Min)/frame.Step
				value=floor(value*crange)*frame.Step+frame.Min
				--limit the value
				if(value>frame.Max)then
					value=frame.Max
				elseif(value<frame.Min)then
					value=frame.Min
				end

				if(frame.Value~=value)then
					frame.Value=value
					frame.OnUpdateFunc(frame)
				end
			end
			NPA_Options_Template_Slider_SetMarker(frame)
		end)

	--show
	frame:Show()
	--return pointer
	return frame
end
--set
NPA_Options.Template.SetSlider=function(frame,value,min,max,step,extend,noupdate)
	if(value)then
		frame.Value=value
	end
	if(min)then
		frame.Min=min
	end
	if(max)then
		frame.Max=max
		if((not value)and frame.Value>max)then
			frame.Value=max
		end
	end
	if(step)then
		frame.Step=step
	end
	
	frame.Value=floor(frame.Value/frame.Step)*frame.Step

	--extend the limit if switched
	if(extend)then
		if(frame.Value<frame.Min)then
			frame.Min=frame.Value
		elseif(frame.Value>frame.Max)then
			frame.Max=frame.Value
		end
	else
		if(frame.Value<frame.Min)then
			frame.Value=frame.Min
		elseif(frame.Value>frame.Max)then
			frame.Value=frame.Max
		end
	end
	
	NPA_Options_Template_Slider_SetMarker(frame)
	if(not noupdate)then
		NPA_Options.RunFunc(frame.OnUpdateFunc,frame)
	end
end
