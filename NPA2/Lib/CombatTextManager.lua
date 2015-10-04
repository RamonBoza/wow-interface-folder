-- Author      : Nogarder
-- Create Date : 2013/4/20 16:51:51
local max=max
local random=random
local abs=abs
--
NPA.CombatTextManager={}
--
local NPA_TextureManager_ManageTexture3=NPA.TextureManager.ManageTexture3
local NPA_FontManager_ManageFont3=NPA.FontManager.ManageFont3
local NPA_Color_GetColorBySpellSchool=NPA.Color.GetColorBySpellSchool
local NPA_FontManager_SetText=NPA.FontManager.SetText
--
local CombatTextList={}
local CurrentCount=1
local MaxText=100 --max 100
--
local GetXY={
	--0=fixed ,1=topleft 2=topright 3=bottomleft 4=bottomright 5=top  6=bottom 7=left 8=right
	[0]=function(dx,dy)
		return dx,dy
	end,
	[1]=function(dx,dy)
		return -random()*abs(dx),random()*abs(dy)
	end,
	[2]=function(dx,dy)
		return random()*abs(dx),random()*abs(dy)
	end,
	[3]=function(dx,dy)
		return -random()*abs(dx),-random()*abs(dy)
	end,
	[4]=function(dx,dy)
		return random()*abs(dx),-random()*abs(dy)
	end,
	[5]=function(dx,dy)
		return (random()*2-1)*abs(dx),random()*abs(dy)
	end,
	[6]=function(dx,dy)
		return (random()*2-1)*abs(dx),-random()*abs(dy)
	end,
	[7]=function(dx,dy)
		return -random()*abs(dx),(random()*2-1)*abs(dy)
	end,
	[8]=function(dx,dy)
		return random()*abs(dx),(random()*2-1)*abs(dy)
	end
}
--
local SetStart1=function(frame,parent,setting)
	frame.PosX=setting.OffsetX or 0
	frame.PosY=setting.OffsetY or 0

	frame.AnchorFrame:ClearAllPoints()
	frame.AnchorFrame:SetPoint("CENTER",parent,"CENTER",frame.PosX,frame.PosY)
end
local SetStart2=function(frame,parent,setting)
	local x,y=parent:GetCenter()
	frame.PosX=(setting.OffsetX or 0)+x
	frame.PosY=(setting.OffsetY or 0)+y
	frame.AnchorFrame:ClearAllPoints()
	frame.AnchorFrame:SetPoint("CENTER",UIParent,"BOTTOMLEFT",frame.PosX,frame.PosY)
end
--
local SetPos1=function(self)
	self.AnchorFrame:ClearAllPoints()
	if(self.ShakeRange>0)then
		self.AnchorFrame:SetPoint("CENTER",self.Parent,"CENTER",self.PosX+(random()-0.5)*2*self.ShakeRange,self.PosY+(random()-0.5)*2*self.ShakeRange)
	else
		self.AnchorFrame:SetPoint("CENTER",self.Parent,"CENTER",self.PosX,self.PosY)
	end
end
local SetPos2=function(self)
	self.AnchorFrame:ClearAllPoints()
	if(self.ShakeRange>0)then
		self.AnchorFrame:SetPoint("CENTER",UIParent,"BOTTOMLEFT",self.PosX+(random()-0.5)*2*self.ShakeRange,self.PosY+(random()-0.5)*2*self.ShakeRange)
	else
		self.AnchorFrame:SetPoint("CENTER",UIParent,"BOTTOMLEFT",self.PosX,self.PosY)
	end
end
--
local CheckHide1=function(self)
	if(not self.Parent:IsShown())then
		return true
	else
		return false
	end
end
local CheckHide3=function()
	return false
end
local CheckHide2=function(self)
	if(not self.Parent:IsShown())then
		self.PosX,self.PosY=self.AnchorFrame:GetCenter()
		local scale=self.AnchorFrame:GetEffectiveScale()
		self.PosX=self.PosX*scale
		self.PosY=self.PosY*scale
		self.SetPos=SetPos2
		self.CheckHide=CheckHide3
	end
end
--
local TextOnUpdate=function(self,elapse)
	if(self.CheckHide(self))then
		self:Hide()
		return
	end
	--
	self.AnimationTime=self.AnimationTime-elapse --check time
	if(self.AnimationTime<0)then
		self.AnimationCurrent=self.AnimationCurrent+1
		local animation=self.Animation[self.AnimationCurrent]
		if(not animation)then --no more animation, hide it
			self:Hide()
			return
		end
		--more animation, init it
		self.SpeedX,self.SpeedY=GetXY[animation.SpeedType](animation.SpeedX,animation.SpeedY)
		self.AccX,self.AccY=GetXY[animation.AccType](animation.AccX,animation.AccY)
		--
		self.AlphaStep=(animation.EndAlpha-animation.StartAlpha)/animation.Lasts
		self.EndAlpha=animation.EndAlpha
		self.SizeStep=(animation.EndSize-animation.StartSize)/animation.Lasts
		self.EndSize=animation.EndSize
		self.AnimationTime=animation.Lasts+self.AnimationTime
		self.ShakeRange=animation.ShakeRange
		self:SetFrameLevel(animation.FrameLevel+self:GetParent():GetFrameLevel())
	end
	--init animation
	self.PosX=self.PosX+self.SpeedX*elapse
	self.PosY=self.PosY+self.SpeedY*elapse
	self.SpeedX=self.SpeedX+self.AccX
	self.SpeedY=self.SpeedY+self.AccY
	--
	self:SetAlpha(self.EndAlpha-self.AlphaStep*self.AnimationTime)
	self:SetScale(self.EndSize-self.SizeStep*self.AnimationTime)
	--
	self.SetPos(self)
end
--
local CreateText=function()
	local anchorframe=CreateFrame("Frame",nil,UIParent)
	anchorframe:SetFrameStrata("TOOLTIP")
	anchorframe:EnableMouse(false)
	anchorframe:SetWidth(1)
	anchorframe:SetHeight(1)
	anchorframe:Show()

	local frame=CreateFrame("Frame",nil,anchorframe)
	frame:SetFrameStrata("TOOLTIP")
	frame:EnableMouse(false)
	frame:SetWidth(1)
	frame:SetHeight(1)
	frame:Hide()
	frame:SetPoint("CENTER",anchorframe,"CENTER",0,0)
	frame:SetScript("OnUpdate",TextOnUpdate)

	local icon=frame:CreateTexture(nil,"OVERLAY")
	icon:SetWidth(10)
	icon:SetHeight(10)
	icon:SetPoint("LEFT",frame,"LEFT",0,0)

	local text=frame:CreateFontString(nil,"OVERLAY")
	text:SetPoint("LEFT",icon,"RIGHT",0,0)
	text:SetFont(GameFontNormal:GetFont())

	local detail=frame:CreateFontString(nil,"OVERLAY")
	detail:SetPoint("LEFT",text,"RIGHT",0,0)
	detail:SetFont(GameFontNormal:GetFont())
	
	local background=frame:CreateTexture(nil,"BACKGROUND")
	background:SetPoint("TOPLEFT",frame,"TOPLEFT",0,0)
	background:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",0,0)

	frame.Text=text
	frame.Detail=detail
	frame.Icon=icon
	frame.Background=background
	frame.AnchorFrame=anchorframe

	return frame
end

NPA.CombatTextManager.AddText=function(parent,icon,text,detail,school,setting,animation)
	--
	if((not animation) or (not parent))then
		return
	end
	--
	if(not CombatTextList[CurrentCount])then
		CombatTextList[CurrentCount]=CreateText()
	end
	--
	local frame=CombatTextList[CurrentCount]
	--
	if(text==nil)then
		frame.Text:SetWidth(1)
		frame.Text:SetHeight(1)
	else
		NPA_FontManager_ManageFont3(frame.Text,setting.TextFileName,setting.TextWidth,setting.TextHeight)
		local color=NPA_Color_GetColorBySpellSchool(school)
		frame.Text:SetTextColor(color.R,color.G,color.B,color.A)
	end
	if(detail==nil)then
		frame.Detail:SetWidth(1)
		frame.Detail:SetHeight(1)
	else
		NPA_FontManager_ManageFont3(frame.Detail,setting.DetailFileName,setting.DetailWidth,setting.DetailHeight)
		local color=NPA_Color_GetColorBySpellSchool(school)
		frame.Detail:SetTextColor(color.R,color.G,color.B,color.A)
	end
	--
	frame.Icon:SetTexture(icon)
	if(icon==nil)then
		frame.Icon:SetWidth(1)
		frame.Icon:SetHeight(1)
	else
		frame.Icon:SetWidth(setting.IconSize)
		frame.Icon:SetHeight(setting.IconSize)
	end
	--
	NPA_FontManager_SetText(frame.Text,text)
	NPA_FontManager_SetText(frame.Detail,detail)

	--
	frame:SetWidth(frame.Text:GetWidth()+frame.Icon:GetWidth()+frame.Detail:GetWidth()) --text width could be variable
	frame:SetHeight(max(frame.Detail:GetHeight(),max(frame.Text:GetHeight(),frame.Icon:GetHeight())))
	--
	frame.Background:SetPoint("TOPLEFT",frame,"TOPLEFT",-setting.BGWidth,setting.BGHeight)
	frame.Background:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",setting.BGWidth,-setting.BGHeight)
	NPA_TextureManager_ManageTexture3(frame.Background,setting.BGFileName,setting.BGColor)
	--init animation
	frame.Animation=animation
	frame.AnimationTime=0
	frame.AnimationCurrent=0
	--
	frame:SetAlpha(0)
	frame:SetScale(0.1)
	--
	if(setting.FreeFloat)then
		frame.SetStart=SetStart2
		frame.SetPos=SetPos2
	else
		frame.SetStart=SetStart1
		frame.SetPos=SetPos1
	end
	if(setting.HideWithParent)then
		frame.CheckHide=CheckHide1
	else
		frame.CheckHide=CheckHide2
	end
	frame.SetStart(frame,parent,setting)
	--
	frame.Parent=parent
	--
	frame:Show()
	--
	CurrentCount=CurrentCount+1
	if(CurrentCount>MaxText)then
		CurrentCount=1
	end
end