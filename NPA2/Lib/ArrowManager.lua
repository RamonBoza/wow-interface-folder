-- Author      : Nogarder
-- Create Date : 2013/4/20 11:33:17
local sqrt=sqrt
local atan=atan
local abs=abs
local floor=floor
local table_getn=table.getn
local NPA_GetTime=NPA.GetTime
--
local NPA_TextureManager_ManageTexture2=NPA.TextureManager.ManageTexture2
local NPA_TextureManager_SetTextureRotation=NPA.TextureManager.SetTextureRotation
local NPA_TextureManager_SetTextureColor=NPA.TextureManager.SetTextureColor
local NPA_TextureManager_SetTextureColorRGBA=NPA.TextureManager.SetTextureColorRGBA
--
NPA.ArrowManager={}
--
-- on update control function for animated arrow
local NPA_ArrowManager_Arrow_OnUpdate=function(arrow,elapse)
	--check parent
	if(not arrow:GetParent():IsShown())then
		arrow:Hide()
	end
	--get coordinates
	local startx,starty=arrow:GetCenter()
	local endx,endy=arrow.EndPoint:GetCenter()
	--sometime coordinates are not aviliable, hide it
	if((not startx) or (not endx))then
		arrow:Hide()
		return
	end
	--check life, it will only show in a certain time
	if(arrow.LifeTime)then
		arrow.LifeTime=arrow.LifeTime-elapse
		if(arrow.LifeTime<0)then
			arrow:Hide()
			return
		else
			--set alpha by lifetime
			local alpha=arrow.Alpha*arrow.LifeTime/arrow.MaxLifeTime +arrow.FadeAlpha --using life time for alpha
			arrow:SetAlpha(alpha)
		end
	end
	--check coordinates changes
	if(arrow.SpeedPerSecond==0)then
		--if no animation and not moving, then don't need to change
		if(startx==arrow.StartX and starty==arrow.StartY and endx==arrow.EndX and endy==arrow.EndY and arrow.Focus~=true)then
			--not changed, dont do anything
			return
		else
			--record this change
			arrow.StartX=startx
			arrow.StartY=starty
			arrow.EndX=endx
			arrow.EndY=endy
		end
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
	local length=sqrt(lengthx*lengthx+lengthy*lengthy)
	--arrow count
	local count=floor(length/arrow.Gap)
	--adjust number by limit
	if(count>arrow.MaxPerLine)then
		--outnumbered, set it to max
		count=arrow.MaxPerLine
	elseif(count<=0)then
		--too narrow for even one arrow, hide all texture and return
		for i=1, table_getn(arrow.Texture) do
			arrow.Texture[i]:Hide()
		end
		return
	end
	--step and offset
	local stepx=lengthx/count
	local stepy=lengthy/count
	--angle
	local angle=atan(lengthy/abs(lengthx))
	if(lengthx<0)then
		angle=180-angle
	end
	--
	local startsize=arrow.StartSize
	local sizestep=(arrow.EndSize-arrow.StartSize)/count
	--
	local nTime=NPA_GetTime()--speed and blink seed
	local	offset=arrow.SpeedPerSecond*nTime --persecond * time
	offset=offset-floor(offset) --using <1 part
	--only reset color when moved, should speed it up a little
	if(count~=arrow.Count)then
		local colorstepr=(arrow.EndColor.R-arrow.Color.R)/count
		local colorstepg=(arrow.EndColor.G-arrow.Color.G)/count
		local colorstepb=(arrow.EndColor.B-arrow.Color.B)/count
		local colorstepa=(arrow.EndColor.A-arrow.Color.A)/count
		--set animation
		for i=1,count do
			if(not arrow.Texture[i])then --create texture if not exists
				arrow.Texture[i]=arrow:CreateTexture(nil,"OVERLAY")
				NPA_TextureManager_ManageTexture2(arrow.Texture[i],arrow.TextureFileName)--,arrow.Color)
			end			
			local texture=arrow.Texture[i]

			local colorr=arrow.Color.R+colorstepr*i
			local colorg=arrow.Color.G+colorstepg*i
			local colorb=arrow.Color.B+colorstepb*i
			local colora=arrow.Color.A+colorstepa*i
			NPA_TextureManager_SetTextureColorRGBA(texture,colorr,colorg,colorb,colora)
			--size
			--set offset
			local index=i-1+offset
			texture:SetPoint("CENTER",arrow,"CENTER",stepx*index,stepy*index)
			--
			local size=startsize+sizestep*index
			texture:SetHeight(size)
			texture:SetWidth(size)
			--set rotation
			NPA_TextureManager_SetTextureRotation(texture,arrow.TextureLeft,arrow.TextureRight,arrow.TextureTop,arrow.TextureBottom,angle)
			--show it
			texture:Show()
		end
	else
		for i=1,count do
			local texture=arrow.Texture[i]
			--size
			--set offset
			local index=i-1+offset
			texture:SetPoint("CENTER",arrow,"CENTER",stepx*index,stepy*index)
			--
			local size=startsize+sizestep*index
			texture:SetHeight(size)
			texture:SetWidth(size)
			--set rotation
			NPA_TextureManager_SetTextureRotation(texture,arrow.TextureLeft,arrow.TextureRight,arrow.TextureTop,arrow.TextureBottom,angle)
		end
	end
	--hide unused textures (if exists)
	for i=count+1, table_getn(arrow.Texture) do
		arrow.Texture[i]:Hide()
	end
	arrow.Count=count
end

NPA.ArrowManager.SetColor=function(arrow,color,endcolor)
	arrow.Color=color
	arrow.EndColor=endcolor
end

NPA.ArrowManager.CreateArrow=function(parent)
	arrow=CreateFrame("Frame",nil,UIParent)
	arrow.Parent=parent
	arrow:SetScript("OnUpdate",NPA_ArrowManager_Arrow_OnUpdate)
	arrow:Hide()
	arrow:EnableMouse(false)
	arrow:SetWidth(1)
	arrow:SetHeight(1)
	--using a texture for endpoint anchor
	arrow.EndPoint=arrow:CreateTexture(nil,"BACKGROUND")
	arrow.EndPoint:SetHeight(1)
	arrow.EndPoint:SetWidth(1)
	--init it
	arrow.Texture={}
	--
	arrow.Gap=10
	arrow.MaxPerLine=5
	arrow.TextureFileName=""
	arrow.SpeedPerSecond=0
	arrow.StartSize=10
	arrow.EndSize=10
	arrow.LifeTime=0
	arrow.MaxLifeTime=0
	arrow.Alpha=1
	arrow.StartX=nil
	arrow.StartY=nil
	arrow.EndX=nil
	arrow.EndY=nil
	--return pointer
	return arrow
end

NPA.ArrowManager.ManageArrow=function(arrow,setting,lifetime,fadealpha)
	fadealpha=fadealpha or 0
	--
	arrow.Gap=setting.Gap
	arrow.MaxPerLine=setting.MaxPerLine
	arrow.TextureFileName=setting.TextureFileName
	arrow.SpeedPerSecond=setting.SpeedPerSecond
	arrow.StartSize=setting.StartSize
	arrow.EndSize=setting.EndSize
	arrow.LifeTime=lifetime
	arrow.MaxLifeTime=lifetime
	arrow.Alpha=setting.Alpha - fadealpha
	arrow.Color=setting.Color
	arrow.EndColor=setting.EndColor
	arrow.Count=0
	arrow.FadeAlpha=fadealpha
	--
	if(setting.AlphaWithParent)then
		arrow:SetParent(arrow.Parent)
	else
		arrow:SetParent(UIParent)
	end
	arrow:SetFrameLevel(arrow.Parent:GetFrameLevel()+3)
	--manage all textures
	for i=1,table_getn(arrow.Texture)do
		NPA_TextureManager_ManageTexture2(arrow.Texture[i],arrow.TextureFileName)--,arrow.Color)
	end
	--texture rotation data
	local texturedata=NPA.SettingManager.GetResources("Texture",arrow.TextureFileName)
	arrow.TextureLeft=texturedata.Left
	arrow.TextureRight=texturedata.Right
	arrow.TextureTop=texturedata.Top
	arrow.TextureBottom=texturedata.Bottom
	--reset position so it will update
	arrow.StartX=nil
	arrow.StartY=nil
	arrow.EndX=nil
	arrow.EndY=nil
	--show it
	arrow:Show()
end