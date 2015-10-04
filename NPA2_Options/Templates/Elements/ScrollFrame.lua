-- Author      : Nogarder
-- Create Date : 2012/4/28 18:13:03
local Tooltips=NPA_Options.Localization.TemplatesElementsScrollFrame
--scroll frame uses slider and liner
--main
NPA_Options.ScrollFrame={}
--list
local NPA_Options_ScrollFrame_List={}
--update
NPA_Options.Template.UpdateScrollFrame=function(frame)
	local scroll=frame.Scroll
	local scrollwidth=scroll:GetWidth()
	local scrollheight=scroll:GetHeight()
	local framewidth=frame:GetWidth()
	local frameheight=frame:GetHeight()
	--if(framewidth<scrollwidth)then
	--	frame:SetWidth(scrollwidth)
	--elseif(frameheight<scrollheight)then
	--	frame:SetHeight(scrollheight)
	--end
	local xrange=framewidth-scrollwidth
	local yrange=frameheight-scrollheight
	if(xrange<1)then
		NPA_Options.Template.SetSlider(scroll.SliderX,1,1,1)
		scroll.SliderX:Hide()
	else
		NPA_Options.Template.SetSlider(scroll.SliderX,nil,nil,xrange)
		scroll.SliderX:Show()
	end
	if(yrange<1)then
		NPA_Options.Template.SetSlider(scroll.SliderY,1,1,1)
		scroll.SliderY:Hide()
	else
		NPA_Options.Template.SetSlider(scroll.SliderY,nil,nil,yrange)
		scroll.SliderY:Show()
	end
end
--set scroll
NPA_Options.Template.CreateScrollFrame=function(parent,width,height,noborder,nobackground,reversscrolly)
	local scroll=CreateFrame("ScrollFrame",nil,parent)
	scroll:EnableMouse(true)
	scroll:SetPoint("CENTER",UIParent,"CENTER")

	if(not noborder)then
		NPA_Options.Template.CreateBorder(scroll)
	end
	--set mouse wheel
	scroll:EnableMouseWheel(1)
	scroll:SetScript("OnMouseWheel",function(self,value)
		local slidery=self.SliderY
		if(slidery and slidery:IsShown())then
			local value=slidery.Value - floor(value *20)
			NPA_Options.Template.SetSlider(slidery,value)
			NPA_Options.HideTemplates(scroll)
		end
	end)
	--
	scroll:SetWidth(width)
	scroll:SetHeight(height)
	scroll:SetVerticalScroll(0)
	scroll:SetHorizontalScroll(0)
	--scroll child
	local frame=CreateFrame("Frame",nil,scroll)
	if(not nobackground)then
		NPA_Options.Template.CreateBackground(frame,nil,0.3,0.8)
	end
	scroll:SetScrollChild(frame)
	frame:SetHeight(1)
	frame:SetWidth(1)
	frame:EnableMouse(true)
	frame:SetPoint("TOPLEFT",scroll,"TOPLEFT",1,-1)
	--slider
	scroll.SliderX=NPA_Options.Template.CreateSlider(scroll,0,1,1,0,1,function(self)
		NPA_Options.HideTemplates(scroll)
		self:GetParent():SetHorizontalScroll(self.Value)
		end,
		true)
	scroll.SliderX:SetPoint("TOPLEFT",scroll,"BOTTOMLEFT",0,0)
	scroll.SliderX:SetPoint("TOPRIGHT",scroll,"BOTTOMRIGHT",0,0)
	scroll.SliderX:SetHeight(20)
	NPA_Options.Template.SetTooltips(Tooltips["DragThisToScroll"],scroll.SliderX,nil,3)
	--
	scroll.SliderY=NPA_Options.Template.CreateSlider(scroll,0,1,1,0,3,function(self)
		NPA_Options.HideTemplates(scroll)
		self:GetParent():SetVerticalScroll(self.Value)
		end,
		true)
	if(reversscrolly)then
		scroll.SliderY:SetPoint("TOPRIGHT",scroll,"TOPLEFT",0,0)
		scroll.SliderY:SetPoint("BOTTOMRIGHT",scroll,"BOTTOMLEFT",0,0)
	else
		scroll.SliderY:SetPoint("TOPLEFT",scroll,"TOPRIGHT",0,0)
		scroll.SliderY:SetPoint("BOTTOMLEFT",scroll,"BOTTOMRIGHT",0,0)
	end
	scroll.SliderY:SetWidth(20)
	NPA_Options.Template.SetTooltips(Tooltips["DragThisToScroll"],scroll.SliderY)
	--
	scroll.SliderX:SetFrameLevel(frame:GetFrameLevel()+3)
	scroll.SliderY:SetFrameLevel(frame:GetFrameLevel()+3)
	--show
	frame.Scroll=scroll
	scroll.Frame=frame
	frame:Show()
	scroll:Show()
	--update once
	NPA_Options.Template.UpdateScrollFrame(frame)
	--return pointer
	return frame
end
