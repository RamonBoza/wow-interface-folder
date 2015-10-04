-- Author      : Nogarder
-- Create Date : 2012/7/28 13:06:08
--global
local floor = floor
local cos=cos
local sin=sin
local abs=abs
local table_getn=table.getn
local string_find=string.find
local CopyTable=CopyTable
--
local NPA_BarManager_BarList={}
--main
NPA.BarManager={}
local NPA_TextureManager_ManageTexture=NPA.TextureManager.ManageTexture
local NPA_SettingManager_GetResources=NPA.SettingManager.GetResources
-----------------------------------------------------------------------------------------------
-------------------------------------------------
local NPA_TextureManager_SetBarTextureCoord=NPA.TextureManager.SetBarTextureCoord

--set bar percent
NPA.BarManager.SetBar=function(bar,percent,nocolor)
	--get data
	local bardata=NPA_BarManager_BarList[bar]
	--revers percent
	local rpercent=1-percent
	--caculate texture coordinates
	if(bardata.Direction)then --only change texcoord when required
		bardata.Percent=rpercent
		NPA_TextureManager_SetBarTextureCoord(bar)
	end
	--caculate bar width and height when required
	if(bardata.BarWidth)then
		local width=bardata.BarWidth-bardata.BarStepX*rpercent
		local height=bardata.BarHeight-bardata.BarStepY*rpercent
		bar:SetWidth(width)
		bar:SetHeight(height)
	end
	--caculate bar color if required
	if(bardata.ColorEnd and (not nocolor))then
		local r=bardata.ColorEnd.R-bardata.ColorStep.R*rpercent
		local g=bardata.ColorEnd.G-bardata.ColorStep.G*rpercent
		local b=bardata.ColorEnd.B-bardata.ColorStep.B*rpercent
		local a=bardata.ColorEnd.A-bardata.ColorStep.A*rpercent
		bar:SetVertexColor(r,g,b,a)
	end
end
--

--set up a bar
local NPA_BarManager_SetBar=NPA.BarManager.SetBar
NPA.BarManager.ManageBar=function(texture,data,scalex,scaley,noanchor,offsetx,offsety)
	--prepare texture coordinates data
	local bardata=NPA_BarManager_BarList[texture]
	if(not bardata)then
		NPA_BarManager_BarList[texture]={}
		bardata=NPA_BarManager_BarList[texture]
	end
	--
	if(data.EnableTextureChange==true)then
		bardata.Direction=data.Direction
		bardata.Percent=1
		texture.BarData=bardata
		--set bardata for texturemanager to handle
	else
		bardata.Direction=nil
		bardata.Percent=nil
		texture.BarData=nil
	end
	--prepare bar data
	if(data.EnableSizeChange==true)then
		bardata.BarWidth=data.Width*scalex
		bardata.BarHeight=data.Height*scaley
		bardata.BarStepX=abs(bardata.BarWidth*floor(cos(data.Direction)*1000)/1000)
		bardata.BarStepY=abs(bardata.BarHeight*floor(sin(data.Direction)*1000)/1000)
	else
		bardata.BarWidth=nil
		bardata.BarHeight=nil
		bardata.BarStepX=nil
		bardata.BarStepY=nil
	end
	--prepare color data
	local nocolor
	if(data.ColorMode==1)then
		bardata.ColorEnd=CopyTable(data.MaxColor)
		bardata.ColorStep={
			R=data.MaxColor.R-data.MinColor.R,
			G=data.MaxColor.G-data.MinColor.G,
			B=data.MaxColor.B-data.MinColor.B,
			A=data.MaxColor.A-data.MinColor.A,
		}
		nocolor=true
	else
		bardata.ColorEnd=nil
		bardata.ColorStep=nil
	end
	--manage it with texture manager
	NPA_TextureManager_ManageTexture(texture,data,scalex,scaley,noanchor,nocolor,offsetx,offsety)
	--init it with 100%
	NPA_BarManager_SetBar(texture,1)
end
-----------bar group--------------
--------------------------------
local NPA_BarManager_SetBarGroupPercent=function(bargroup,percent)
	--with caculating method below, don't have to check percent boundary
	bargroup.Percent=percent
	local nocolor
	if(bargroup.ColorMode~=0)then
		nocolor=true
	end
	--caculate each bar
	local bars=bargroup.Bars
	for i=1,bargroup.Count do
		local bar=bars[i]
		--over its range ,show it as 100%
		if(percent>bar.PercentTo)then
			if(bar.HideWhenMax==true)then
				bar:Hide()
			else
				NPA_BarManager_SetBar(bar,1,nocolor)
				bar:Show()
			end
		elseif(percent>bar.PercentFrom)then --in range,set it with caculated percent
			local barpercent=(percent-bar.PercentFrom)/bar.PercentLength
			NPA_BarManager_SetBar(bar,barpercent,nocolor)
			bar:Show()
		else--less than its range, hide it
			bar:Hide()
		end
	end
end
---
local NPA_BarManager_ShadowGroupOnUpdate=function(shadowgroup,elapsed)
	if(shadowgroup.Percent~=shadowgroup.TargetPercent)then
		local step=shadowgroup.PercentStep*elapsed
		if(abs(shadowgroup.Percent-shadowgroup.TargetPercent)<=abs(step))then
			shadowgroup:Hide()
			shadowgroup.ParentGroup:SetAlpha(1)
		else
			NPA_BarManager_SetBarGroupPercent(shadowgroup,shadowgroup.Percent+step)
		end
	end
end
--
NPA.BarManager.SetBarGroup=function(bargroup,percent,forcerefresh,forcesync,value,max)
	if(percent==bargroup.Percent and (not forcerefresh))then
		return
	end
	if(not percent)then
		percent=(value or 0)/(max or 1)
	end
	if(bargroup.ShadowAlpha)then
		local shadowgroup=bargroup.ShadowGroup
		--
		if(percent>=shadowgroup.Percent)then
			bargroup:SetAlpha(bargroup.ShadowAlpha)
			shadowgroup:SetAlpha(1)
		else
			bargroup:SetAlpha(1)
			shadowgroup:SetAlpha(bargroup.ShadowAlpha)
		end
		shadowgroup.TargetPercent=percent
		shadowgroup.PercentStep=(percent-shadowgroup.Percent)/bargroup.SmoothTime
		if(forcesync)then
			NPA_BarManager_SetBarGroupPercent(shadowgroup,percent)
		end
		--
		shadowgroup:Show()
	end
	--
	NPA_BarManager_SetBarGroupPercent(bargroup,percent)
	--
	bargroup:Show()
end
--
local NPA_BarManager_SetBarGroupColor=function(bargroup,color)
	local bars=bargroup.Bars
	local r=color.R
	local g=color.G
	local b=color.B
	local a=color.A
	for i=1,bargroup.Count do
		bars[i]:SetVertexColor(r,g,b,a)
	end
end
--
NPA.BarManager.SetBarGroupColor=function(bargroup,color)
	NPA_BarManager_SetBarGroupColor(bargroup,color)

	if(bargroup.SmoothTime and bargroup.ShadowAlpha~=0)then
		NPA_BarManager_SetBarGroupColor(bargroup.ShadowGroup,color)
	end
end
--
local NPA_BarManager_CaculateBarBorder=function(anchorfrom,offsetx,offsety,width,height)
	local left,right,top,bottom
	if(string_find(anchorfrom,"LEFT"))then
		left=offsetx
		right=offsetx+width
	elseif(string_find(anchorfrom,"RIGHT"))then
		left=offsetx-width
		right=offsetx
	else
		left=offsetx-width/2
		right=offsetx+width/2
	end
	if(string_find(anchorfrom,"TOP"))then
		top=offsety
		bottom=offsety-height
	elseif(string_find(anchorfrom,"BOTTOM"))then
		top=offsety+height
		bottom=offsety
	else
		top=offsety+height/2
		bottom=offsety-height/2
	end
	return left,right,top,bottom
end
--
local NPA_BarManager_SetBarGroup=NPA.BarManager.SetBarGroup
local NPA_BarManager_ManageBar=NPA.BarManager.ManageBar
local NPA_BarManager_ManageBarGroupSet=function(bargroup,settingname,width,height)
	local setting=NPA_SettingManager_GetResources("BarGroup",settingname)
	--
	--init each bar in the group
	local i=0
	local bars=bargroup.Bars
	--setup texture group
	for _,bardata in pairs(setting)do
		i=i+1
		if(not bars[i])then
			bars[i]=bargroup:CreateTexture(nil,"ARTWORK")
		end
		local bar=bars[i]
		bar.HideWhenMax=bardata.HideWhenMax
		bar.PercentFrom=bardata.PercentFrom
		bar.PercentTo=bardata.PercentTo
		bar.PercentLength=bardata.PercentTo-bardata.PercentFrom
	end
	--store the count
	bargroup.Count=i
	--hide extra bar
	for j=i+1,table_getn(bars)do
		bars[j]:Hide()
	end
	--caculating size
	local scalex,scaley,offsetx,offsety
	if(width and height)then
		local left
		local right
		local top
		local bottom
		--
		for _,bardata in pairs(setting)do
			--caculate border
			local anchordata=bardata.AnchorData
			local barleft,barright,bartop,barbottom=NPA_BarManager_CaculateBarBorder(anchordata.From,anchordata.OffsetX,anchordata.OffsetY,bardata.Width,bardata.Height)
			if(left==nil or barleft<left)then
				left=barleft
			end
			if(right==nil or barright>right)then
				right=barright
			end
			if(top==nil or bartop>top)then
				top=bartop
			end
			if(bottom==nil or barbottom<bottom)then
				bottom=barbottom
			end		
		end
		--caculate scale
		local groupwidth=right-left
		local groupheight=top-bottom
		scalex=width/groupwidth
		scaley=height/groupheight
		offsetx=-(right+left)/2*scalex
		offsety=-(top+bottom)/2*scaley
	else
		scalex=1
		scaley=1
		offsetx=0
		offsety=0
	end
	--set bars with scale
	i=0
	for _,bardata in pairs(setting)do
		i=i+1
		NPA_BarManager_ManageBar(bars[i],bardata,scalex,scaley,nil,offsetx,offsety)
	end
	--
	bargroup:SetAlpha(1)
	--
	NPA_BarManager_SetBarGroup(bargroup,bargroup.Percent,true)
end
--
NPA.BarManager.ManageBarGroup=function(bargroup,setting)
	--
	bargroup:SetWidth(setting.Width)
	bargroup:SetHeight(setting.Height)
	bargroup.SmoothTime=setting.SmoothTime
	bargroup.ColorMode=setting.ColorMode
	bargroup.Ziped=nil
	--
	if(setting.SmoothTime and setting.ShadowAlpha~=0)then	--setup shadow group for smoothing
		local shadowgroup=bargroup.ShadowGroup
		shadowgroup:SetWidth(setting.Width)
		shadowgroup:SetHeight(setting.Height)
		shadowgroup.ColorMode=setting.ColorMode
		shadowgroup.ParentGroup=bargroup
		--
		NPA_BarManager_ManageBarGroupSet(shadowgroup,setting.ProfileName,setting.Width,setting.Height)
		shadowgroup:Hide()
		--
		bargroup.ShadowAlpha=setting.ShadowAlpha
	elseif(bargroup.ShadowGroup)then
		bargroup.ShadowAlpha=nil
		bargroup.ShadowGroup:Hide()
	end
	--
	NPA_BarManager_ManageBarGroupSet(bargroup,setting.ProfileName,setting.Width,setting.Height)
end
--
NPA.BarManager.CreateBarGroup=function(mainframe)
	local bargroup=CreateFrame("Frame",nil,mainframe)
	bargroup.Percent=1
	bargroup.Count=0
	bargroup.Bars={}
	--
	local shadowgroup=CreateFrame("Frame",nil,bargroup)
	shadowgroup:Hide()
	shadowgroup:SetScript("OnUpdate",NPA_BarManager_ShadowGroupOnUpdate)
	shadowgroup:SetPoint("CENTER",bargroup,"CENTER")
	shadowgroup.Percent=1
	shadowgroup.Count=0
	shadowgroup.Bars={}
	bargroup.ShadowGroup=shadowgroup
	--
	return bargroup
end
