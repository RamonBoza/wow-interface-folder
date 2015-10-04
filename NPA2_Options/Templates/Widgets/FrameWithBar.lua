-- Author      : Nogarder
-- Create Date : 2012/6/17 11:24:32
local Tooltips=NPA_Options.Localization.TemplatesWidgetsFrameWithBar
--
local NPA_Options_Template_FrameWithBar_Reset=function(self)
	self.Dragged=nil
	self.Scroll:SetScale(1)
	self.ZoomSlider.Value=1
	--NPA_Options.Animation.RestoreScroll(self.Scroll)
	self:ClearAllPoints()
	if(self.LinkTo)then
		if(self.LinkType=="BOTTOMRIGHT")then
			self:SetPoint("TOPRIGHT",self.LinkTo.Scroll,"BOTTOMRIGHT",self:GetWidth(),-40)
		elseif(self.LinkType=="BOTTOMLEFT")then
			self:SetPoint("TOPLEFT",self.LinkTo.Scroll,"BOTTOMLEFT",0,-40)
		else
			if(self.LinkTo.Scroll.Revers)then
				self:SetPoint("TOPLEFT",self.LinkTo.Scroll,"TOPRIGHT",3,0)
			elseif(self.Scroll.Revers)then
				self:SetPoint("TOPRIGHT",self.LinkTo,"TOPLEFT",-10,0)
			else
				if(self.LinkTo.Scroll.SliderY:IsShown())then
					self:SetPoint("TOPLEFT",self.LinkTo.Scroll.SliderY,"TOPRIGHT",3,0)
				else
					self:SetPoint("TOPLEFT",self.LinkTo.Scroll,"TOPRIGHT",3,0)
				end
			end
		end
	else
		self:SetPoint("CENTER",NPA_Options.MainFrame,"CENTER",-50,120)
	end
	NPA_Options.RunFunc(self.OnReset)
end
NPA_Options.Template.CreateFrameWithBar=function(parent,title,width,height,noborder,nobackground,revers,dragframe)
	--dragger
	local dragger=NPA_Options.Template.CreateDragger(parent,dragframe)
	dragger:SetPoint("CENTER",UIParent,"CENTER",0,0)
	--
	local frame=NPA_Options.Template.CreateScrollFrame(dragger,1,1,noborder,nobackground,revers)
	frame:HookScript("OnMouseDown",function()
		NPA_Options.Template.SwitchCircle(dragger.Circle,1)
		if(dragger.Dragged)then
			(dragframe or dragger):StartMoving()
		else
			NPA_Options.MainFrame:StartMoving()
		end
	end)
	frame:HookScript("OnMouseUp",function()
		NPA_Options.Template.SwitchCircle(dragger.Circle,nil)
		if(dragger.Dragged)then
			(dragframe or dragger):StopMovingOrSizing()
		else
			NPA_Options.MainFrame:StopMovingOrSizing()
		end
	end)
	frame.Scroll:HookScript("OnMouseDown",function()
		NPA_Options.Template.SwitchCircle(dragger.Circle,1)
		if(dragger.Dragged)then
			(dragframe or dragger):StartMoving()
		else
			NPA_Options.MainFrame:StartMoving()
		end
	end)
	frame.Scroll:HookScript("OnMouseUp",function()
		NPA_Options.Template.SwitchCircle(dragger.Circle,nil)
		if(dragger.Dragged)then
			(dragframe or dragger):StopMovingOrSizing()
		else
			NPA_Options.MainFrame:StopMovingOrSizing()
		end
	end)

	frame.Scroll:SetWidth(width)
	frame.Scroll:SetHeight(height)
	frame:SetWidth(width)
	frame:SetHeight(height)
	if(revers)then
		frame.Scroll:SetPoint("TOPRIGHT",dragger,"TOPLEFT",-2,0)
		frame.Scroll.Revers=true
	else
		frame.Scroll:SetPoint("TOPLEFT",dragger,"TOPRIGHT",2,0)
	end
	dragger.Frame=frame
	dragger.Scroll=frame.Scroll
	frame.Scroll.Dragger=dragger
	--NPA_Options.Template.SetTooltips=function(text,frame,point,direction,parent)
	NPA_Options.Template.SetTooltips(Tooltips["DragToMove"],frame,nil,2,frame.Scroll)
	--title
	local title=NPA_Options.Template.CreateText(frame.Scroll,title)
	title:SetPoint("BOTTOM",frame.Scroll,"TOP",0,3)
	frame.Scroll.Title=title
	--sidebar
	local sidebar=CreateFrame("Frame",nil,dragger)
	sidebar:SetPoint("TOP",dragger,"TOP",0,0)
	sidebar:SetWidth(20)
	sidebar:SetHeight(240)
	dragger.SideBar=sidebar
	--
	NPA_Options.Template.CreateBackground(sidebar)
	--buttons
	--closer
	local closer=NPA_Options.Template.SetCloser(sidebar,dragger,2)
	closer:SetPoint("BOTTOM",sidebar,"BOTTOM",0,0)

	dragger.Closer=closer
	--reseter
	local reseter=CreateFrame("Frame",nil,sidebar)
	reseter:EnableMouse(1)
	reseter:SetScript("OnMouseUp",function()
		NPA_Options_Template_FrameWithBar_Reset(dragger)
	end)
	reseter:SetWidth(20)
	reseter:SetHeight(20)
	reseter.Circle=NPA_Options.Template.CreateCircle(reseter,9,2)
	reseter.Circle:SetPoint("CENTER",reseter,"CENTER",0,0)
	reseter:SetScript("OnEnter",function(self)
		NPA_Options.Template.SwitchCircle(self.Circle,1)
	end)
	reseter:SetScript("OnLeave",function(self)
		NPA_Options.Template.SwitchCircle(self.Circle,nil)
	end)
	--
	NPA_Options.Template.SetTooltips(Tooltips["ClickThisToReset"],reseter,nil,2)

	reseter:SetPoint("TOP",dragger,"BOTTOM",0,0)
	dragger.Reseter=reseter
	--minimizer
	local minimizer=CreateFrame("Frame",nil,sidebar)
	minimizer:SetHeight(20)
	minimizer:SetWidth(20)
	minimizer:SetPoint("TOP",reseter,"BOTTOM",0,0)
	NPA_Options.Template.SetTooltips(Tooltips["ClickToMinimize"],minimizer,nil,2)
	NPA_Options.Template.SetAutoFocus(minimizer)
	--
	local texture=minimizer:CreateTexture(nil,"OVERLAY")
	texture:SetPoint("LEFT",minimizer,"LEFT",4,0)
	texture:SetPoint("RIGHT",minimizer,"RIGHT",-4,0)
	texture:SetHeight(8)
	texture:SetTexture("Interface\\Addons\\NPA2_Options\\texture\\Liner")
	texture:Show()
	--
	minimizer:SetScript("OnMouseUp",function()
		if(frame.Scroll.Minimized)then
			NPA_Options.Animation.RestoreScroll(frame.Scroll)
			NPA_Options.RunFunc(frame.OnRestoreFunc)
		else
			NPA_Options.Animation.MinimizeScroll(frame.Scroll)
			NPA_Options.RunFunc(frame.OnMinimizeFunc)
		end
	end)
	dragger.Minimizer=minimizer
	--zoom slider
	local zoomslider=NPA_Options.Template.CreateSlider(sidebar,0.5,3,0.01,1,3,
		function(self)
			frame.Scroll:SetScale(self.Value)
			NPA_Options.RunFunc(dragger.OnScaleFunc,self.Value)
		end)
	zoomslider:SetWidth(20)
	zoomslider:SetPoint("TOP",minimizer,"BOTTOM",0,-2)
	zoomslider:SetPoint("BOTTOM",closer,"TOP",0,2)
	NPA_Options.Template.SetTooltips(Tooltips["DragToScale"],zoomslider,nil,2)
	dragger.ZoomSlider=zoomslider
	--scripts
	dragger:HookScript("OnShow",function(self)
		NPA_Options_Template_FrameWithBar_Reset(self)
		NPA_Options.Animation.RestoreScroll(frame.Scroll)
	end)
	dragger:HookScript("OnHide",function(self)
		NPA_Options.UnregisterMinimize(self)
		NPA_Options.RunFunc(dragger.OnHideFunc)
	end)
	return dragger
end