-- Author      : Nogarder
-- Create Date : 2012/8/22 8:48:00
local string_find=string.find
local max=max
local min=min
local floor=floor
--
local Localization=NPA_Options.Localization.TemplatesWidgetsAnchorPreview
--anchor preview frame
NPA_Options.Template.CreateAnchorPreview=function(parent)
	--preview
	local previewframeparent=CreateFrame("Frame",nil,parent)--NPA_Options.MainFrame)
	local previewframe=CreateFrame("Frame",nil,previewframeparent)
	previewframe:SetPoint("TOPLEFT",previewframeparent,"TOPLEFT")
	previewframe:SetPoint("BOTTOMRIGHT",previewframeparent,"BOTTOMRIGHT")
	--
	--parent:HookScript("OnShow",function()
	--	previewframe:Show()
	--end)
	--parent:HookScript("OnHide",function()
	--	previewframe:Hide()
	--end)
	--parent.OnRestoreFunc=function()
	--	previewframe:Show()
	--end
	--parent.OnMinimizeFunc=function()
	--	previewframe:Hide()
	--end

	previewframe:SetFrameLevel(parent:GetFrameLevel()+3)
	
	local previewbg=previewframe:CreateTexture(nil,"BACKGROUND")
	previewbg:SetPoint("TOPLEFT",previewframe,"TOPLEFT")
	previewbg:SetPoint("BOTTOMRIGHT",previewframe,"BOTTOMRIGHT")
	previewbg:SetTexture(0,0,0,0.25)
	local preview1=previewframe:CreateTexture(nil,"BORDER")
	preview1:SetWidth(20)
	preview1:SetHeight(20)
	preview1:SetPoint("CENTER",previewframe,"CENTER",0,0)
	preview1:SetTexture(1,1,1,0.25)
	local preview11=previewframe:CreateTexture(nil,"OVERLAY")
	preview11:SetWidth(5)
	preview11:SetHeight(5)
	preview11:SetTexture(1,0,0,0.25)
	local preview2=previewframe:CreateTexture(nil,"ARTWORK")
	preview2:SetWidth(20)
	preview2:SetHeight(20)
	preview2:SetTexture(0,1,0,0.25)
	local preview21=previewframe:CreateTexture(nil,"OVERLAY")
	preview21:SetWidth(5)
	preview21:SetHeight(5)
	preview21:SetTexture(1,0,0,0.25)
	local liner=NPA_Options.Template.CreateLiner(previewframe,nil,nil,2)
	liner:SetPoint("CENTER",preview11,"CENTER")
	liner.EndPoint:SetPoint("CENTER",preview21,"CENTER")
	local scaling=NPA_Options.Template.CreateText(previewframe," ")
	scaling:SetPoint("BOTTOMRIGHT",previewframe,"BOTTOMRIGHT")
	---
	previewframe.Preview1=preview1
	previewframe.Preview11=preview11
	previewframe.Preview2=preview2
	previewframe.Preview21=preview21
	previewframe.Background=previewbg
	previewframe.Scaling=scaling
	previewframeparent.PreviewChild=previewframe
	previewframeparent.Preview1=preview1
	previewframeparent.Preview11=preview11
	previewframeparent.Preview2=preview2
	previewframeparent.Preview21=preview21
	previewframeparent.Background=previewbg
	previewframeparent.Scaling=scaling
	return previewframeparent
end
NPA_Options.Template.SetAnchorPreview=function(previewframeparent,anchor,toanchor,offsetx,offsety,exframe)
	local previewframe=previewframeparent.PreviewChild
	previewframe.Preview11:ClearAllPoints()
	previewframe.Preview11:SetPoint(toanchor,previewframe.Preview1,toanchor)
	previewframe.Preview21:ClearAllPoints()
	previewframe.Preview21:SetPoint(anchor,previewframe.Preview2,anchor)
	previewframe.Preview2:ClearAllPoints()
	if(exframe)then
		exframe:ClearAllPoints()
		exframe:SetPoint(anchor,previewframe.Preview1,toanchor,offsetx,offsety)
		previewframe.Preview2:ClearAllPoints()
		previewframe.Preview2:SetPoint("TOPLEFT",exframe,"TOPLEFT")
		previewframe.Preview2:SetPoint("BOTTOMRIGHT",exframe,"BOTTOMRIGHT")
	else
		previewframe.Preview2:ClearAllPoints()
		previewframe.Preview2:SetPoint(anchor,previewframe.Preview1,toanchor,offsetx,offsety)
	end
	--caculate displayed scale to make sure preview always shown inside
	local oscale=previewframe:GetScale()
	local width=previewframe:GetWidth()/2*oscale
	local height=previewframe:GetHeight()/2*oscale
	local previewwidth=previewframe.Preview2:GetWidth()+20
	local previewheight=previewframe.Preview2:GetHeight()+20
	local previewwidth2=10
	local previewheight2=10
	--set offset based on anchor
	local offsetx=offsetx
	local offsety=offsety
	--
	if(string_find(toanchor,"LEFT"))then
		offsetx=offsetx-previewwidth2
	elseif(string_find(toanchor,"RIGHT"))then
		offsetx=offsetx+previewwidth2
	end
	if(string_find(toanchor,"TOP"))then
		offsety=offsety-previewheight2
	elseif(string_find(toanchor,"BOTTOM"))then
		offsety=offsety+previewheight2
	end
	--caculate border 
	local left=0
	local right=0
	local top=0
	local bottom=0
	--
	if(string_find(anchor,"LEFT"))then
		left=left+previewwidth
		right=right+previewwidth
	elseif(string_find(anchor,"RIGHT"))then
		left=left-previewwidth
		right=right-previewwidth
	else
		right=right+previewwidth/2
		left=left-previewwidth/2
	end
	if(string_find(anchor,"TOP"))then
		top=top-previewheight
		bottom=bottom-previewheight
	elseif(string_find(anchor,"BOTTOM"))then
		top=top+previewheight
		bottom=bottom+previewheight
	else
		top=top+previewheight/2
		bottom=bottom-previewheight/2
	end
	--
	left=floor(left+offsetx)
	right=floor(right+offsetx)
	top=floor(top+offsety)
	bottom=floor(bottom+offsety)
	--caculate scale with the biggest value on x and y
	local scalex,scaley,scale
	if(left~=0 or right~=0)then
		scalex=width/max(abs(left),abs(right))
	else
		scalex=1
	end
	if(top~=0 or bottom~=0)then
		scaley=height/max(abs(top),abs(bottom))
	else
		scaley=1
	end
	--using the smaller one
	scale=min(scalex,scaley)
	--but not bigger than 100%
	if(scale>1)then
		scale=1
	end
	--also must be bigger than 0
	if(scale<0.1)then
		scale=0.1
	end
	previewframe:SetScale(scale)
	previewframe.Scaling:SetText(Localization["Scaling"]..(floor(scale*10000)/100).."%")
end
