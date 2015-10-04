-- Author      : Nogarder
-- Create Date : 2012/3/16 15:38:56
--global
local floor = floor
local cos=cos
local sin=sin
local abs=abs
local pairs=pairs
local table_getn=table.getn
local NPA_GetTime=NPA.GetTime
local NPA_RunFunc=NPA.RunFunc
local string_split=string.split
local next=next
--
local NPA_SettingManager_GetResources=NPA.SettingManager.GetResources
--main
NPA.TextureManager={}
-----------------------------------------------------------------------------------------------
-----------------macro for rotation--------------------------------
local NPA_TextureManager_Rotation=function(x,y,angle)
	local ca=floor(cos(angle)*1000)/1000
	local sa=floor(sin(angle)*1000)/1000
	return x*ca-y*sa,x*sa+y*ca
end
---
local NPA_TextureManager_GetRotatedCoord=function(left,right,top,bottom,angle)
	local centerx=(left+right)/2
	local centery=(top+bottom)/2
	local width=(right-left)/2
	local height=(bottom-top)/2

	local dleft=left-centerx
	local dright=right-centerx
	local dtop=top-centery
	local dbottom=bottom-centery
	
	local tlx,tly=NPA_TextureManager_Rotation(dleft,dtop,angle)
	local blx,bly=NPA_TextureManager_Rotation(dleft,dbottom,angle)
	local trx,try=NPA_TextureManager_Rotation(dright,dtop,angle)
	local brx,bry=NPA_TextureManager_Rotation(dright,dbottom,angle)

	return {
		TLx=tlx,
		TLy=tly,
		BLx=blx,
		BLy=bly,
		TRx=trx,
		TRy=try,
		BRx=brx,
		BRy=bry,
		CTx=centerx,
		CTy=centery,
		CWidth=width,
		CHeight=height,
		RAngle=angle
	}
end
--function for texture rotation
local NPA_TextureManager_SetTextureRotation=function(texture,left,right,top,bottom,angle)
	local centerx=(left+right)/2
	local centery=(top+bottom)/2

	local dleft=left-centerx
	local dright=right-centerx
	local dtop=top-centery
	local dbottom=bottom-centery
	
	local tlx,tly=NPA_TextureManager_Rotation(dleft,dtop,angle)
	local blx,bly=NPA_TextureManager_Rotation(dleft,dbottom,angle)
	local trx,try=NPA_TextureManager_Rotation(dright,dtop,angle)
	local brx,bry=NPA_TextureManager_Rotation(dright,dbottom,angle)

	tlx=tlx+centerx
	tly=tly+centery
	blx=blx+centerx
	bly=bly+centery
	trx=trx+centerx
	try=try+centery
	brx=brx+centerx
	bry=bry+centery

	texture:SetTexCoord(tlx,tly,blx,bly,trx,try,brx,bry)
end
--
NPA.TextureManager.SetTextureRotation=NPA_TextureManager_SetTextureRotation
--
NPA.TextureManager.SetBarTextureCoord=function(texture)
	local bardata=texture.BarData
	local rpercent=bardata.Percent
	local coorddata=bardata.RotatedTexCoord

	local direction=bardata.Direction+coorddata.RAngle
	local coordstepx=floor(cos(direction)*1000)/1000
	local coordstepy=floor(sin(direction)*1000)/1000

	local ax=rpercent*coordstepx
	local ay=rpercent*coordstepy

	local dcenterx=coorddata.CTx-ax*coorddata.CWidth
	local dcentery=coorddata.CTy-ay*coorddata.CHeight

	local scalex=1-abs(ax)
	local scaley=1-abs(ay)
	local tlx=coorddata.TLx*scalex+dcenterx
	local tly=coorddata.TLy*scaley+dcentery
	local blx=coorddata.BLx*scalex+dcenterx
	local bly=coorddata.BLy*scaley+dcentery
	local trx=coorddata.TRx*scalex+dcenterx
	local try=coorddata.TRy*scaley+dcentery
	local brx=coorddata.BRx*scalex+dcenterx
	local bry=coorddata.BRy*scaley+dcentery

	texture:SetTexCoord(tlx,tly,blx,bly,trx,try,brx,bry)
end
--
local AnimatedTextureList={}
--data={
-- Entry=setting entry
-- CurrentEntry=entry
-- CurrentIndex=index
-- CurrentTime=time
-- Time=time
local NPA_TextureManager_SetBarTextureCoord=NPA.TextureManager.SetBarTextureCoord
--
NPA.TextureManager.SetTextureWithData=function(texture,texturedata)
	if(not texturedata)then
		texture:SetTexture(nil)
		return
	end
	texture:SetBlendMode(texturedata.Mode)
	local color=texturedata.Color
	texture:SetVertexColor(color.R,color.G,color.B,color.A)

	if(texture.BarData)then --store up texturedata and wait for setbar
		texture.BarData.RotatedTexCoord=NPA_TextureManager_GetRotatedCoord(texturedata.Left,texturedata.Right,texturedata.Top,texturedata.Bottom,texturedata.RAngle)
		NPA_TextureManager_SetBarTextureCoord(texture,texture.BarData)
	else
		local angle=texturedata.RAngle
		if(angle==0)then
			texture:SetTexCoord(texturedata.Left,texturedata.Right,texturedata.Top,texturedata.Bottom)
		else
			NPA_TextureManager_SetTextureRotation(texture,texturedata.Left,texturedata.Right,texturedata.Top,texturedata.Bottom,angle)
		end
	end
	texture:SetTexture(texturedata.Texture)
end
local NPA_TextureManager_SetTextureWithData=NPA.TextureManager.SetTextureWithData
local NPA_TextureManager_ResetAnimatedTexture=function(texture,data)
	data.Time=0
	data.CurrentIndex=1
	data.CurrentTime=data.Entry[1].Time
	NPA_TextureManager_SetTextureWithData(texture,data.Entry[1])
end
--
local LastUpdate=0
NPA.EventHandler.RegisterEvent(3,"NPA_MainFrame_OnUpdate","Lib_TextureManager",function()
	local nTime=NPA_GetTime()
	local elapse=nTime-LastUpdate
	for texture,data in pairs(AnimatedTextureList)do
		if(data.Entry)then
			if(texture:IsShown())then
				data.Time=data.Time+elapse
				if(data.Time>data.CurrentTime)then
					data.Time=data.Time-data.CurrentTime
					data.CurrentIndex=data.CurrentIndex+1
					texturedata=data.Entry[data.CurrentIndex]
					if(not texturedata)then
						data.CurrentIndex=1
						texturedata=data.Entry[1]
					end
					if(texturedata)then
						NPA_TextureManager_SetTextureWithData(texture,texturedata)
						data.CurrentTime=texturedata.Time
					else
						--no usable data, clean it
						texture:SetTexture(nil)
						AnimatedTextureList[texture]=nil
					end
				end
			elseif(data.Time~=0)then
				NPA_TextureManager_ResetAnimatedTexture(texture,data)
			end
		else
			texture:SetTexture(nil)
			AnimatedTextureList[texture]=nil
		end
	end
	LastUpdate=nTime
end)

NPA.TextureManager.RemoveAnimatedTexture=function(texture)
	AnimatedTextureList[texture]=nil
end
local NPA_TextureManager_RemoveAnimatedTexture=NPA.TextureManager.RemoveAnimatedTexture
NPA.TextureManager.SetAnimatedTexture=function(texture,entryname)
	local entry=NPA_SettingManager_GetResources("AnimatedTexture",entryname)
	if(entry and next(entry))then
		if(not AnimatedTextureList[texture])then
			AnimatedTextureList[texture]={}
		end
		local data=AnimatedTextureList[texture]
		data.Entry=entry
		NPA_TextureManager_ResetAnimatedTexture(texture,data)
	end
end
--
NPA.TextureManager.SetAnimatedTextureByEntry=function(texture,entry)
	if(entry and next(entry))then
		if(not AnimatedTextureList[texture])then
			AnimatedTextureList[texture]={}
		end
		local data=AnimatedTextureList[texture]
		data.Entry=entry
		NPA_TextureManager_ResetAnimatedTexture(texture,data)
	end
end
--
local NPA_TextureManager_SetAnimatedTexture=NPA.TextureManager.SetAnimatedTexture
NPA.TextureManager.ManageAnimatedTexture=function(texture,entryname,data,scalex,scaley,noanchor,offsetx,offsety)
	NPA_TextureManager_SetAnimatedTexture(texture,entryname)
	
	local scalex=scalex or 1
	local scaley=scaley or 1
	local offsetx=offsetx or 0
	local offsety=offsety or 0

	texture:SetHeight(data.Height*scaley)
	texture:SetWidth(data.Width*scalex)

	texture:SetDrawLayer(data.Layer)

	if(not noanchor)then
		texture:ClearAllPoints()

		local anchordata=data.AnchorData
		texture:SetPoint(anchordata.From,texture:GetParent(),anchordata.To,anchordata.OffsetX*scalex+offsetx,anchordata.OffsetY*scaley+offsety)
	end
end
local NPA_TextureManager_ManageAnimatedTexture=NPA.TextureManager.ManageAnimatedTexture
--manage texture
NPA.TextureManager.ManageTexture=function(texture,data,scalex,scaley,noanchor,nocolor,offsetx,offsety)
	--filter animated texture
	local _,name2=string_split("@",data.ProfileName)
	if(name2)then
		NPA_TextureManager_ManageAnimatedTexture(texture,name2,data,scalex,scaley,noanchor,offsetx,offsety)
		return
	end

	NPA_TextureManager_RemoveAnimatedTexture(texture)
	
	local texturedata=NPA_SettingManager_GetResources("Texture",data.ProfileName)
	NPA_TextureManager_SetTextureWithData(texture,texturedata)

	local scalex=scalex or 1
	local scaley=scaley or 1
	local offsetx=offsetx or 0
	local offsety=offsety or 0

	texture:SetHeight(data.Height*scaley)
	texture:SetWidth(data.Width*scalex)

	texture:SetDrawLayer(data.Layer)

	if(not noanchor)then
		texture:ClearAllPoints()

		local anchordata=data.AnchorData
		texture:SetPoint(anchordata.From,texture:GetParent(),anchordata.To,anchordata.OffsetX*scalex+offsetx,anchordata.OffsetY*scaley+offsety)
	end
end
--manage texture2
NPA.TextureManager.ManageTexture2=function(texture,texturename)
	--filter out animated texture
	local _,name2=string_split("@",texturename)
	if(name2)then
		NPA_TextureManager_SetAnimatedTexture(texture,name2)
		return
	end

	NPA_TextureManager_RemoveAnimatedTexture(texture)
	--
	local texturedata=NPA_SettingManager_GetResources("Texture",texturename)

	NPA_TextureManager_SetTextureWithData(texture,texturedata)
	
--	texture:SetBlendMode(texturedata.Mode)

--	local color=texturedata.Color
--	texture:SetVertexColor(color.R,color.G,color.B,color.A)

--	local angle=texturedata.RAngle
--	if(angle==0)then
--		texture:SetTexCoord(texturedata.Left,texturedata.Right,texturedata.Top,texturedata.Bottom)
--	else
--		NPA_TextureManager_SetTextureRotation(texture,texturedata.Left,texturedata.Right,texturedata.Top,texturedata.Bottom,angle)
--	end
	texture:SetTexture(texturedata.Texture)
end
--manage texture3
NPA.TextureManager.ManageTexture3=function(texture,texturename,color)
	--filter out animated texture
	local _,name2=string_split("@",texturename)
	if(name2)then
		NPA_TextureManager_SetAnimatedTexture(texture,name2)
		return
	end
	NPA_TextureManager_RemoveAnimatedTexture(texture)

	local texturedata=NPA_SettingManager_GetResources("Texture",texturename)
	NPA_TextureManager_SetTextureWithData(texture,texturedata)

--	texture:SetBlendMode(texturedata.Mode)

	local colordata=texturedata.Color
	texture:SetVertexColor(colordata.R*color.R,colordata.G*color.G,colordata.B*color.B,colordata.A*color.A)
	texture.Color=colordata
--	local angle=texturedata.RAngle
--	if(angle==0)then
--		texture:SetTexCoord(texturedata.Left,texturedata.Right,texturedata.Top,texturedata.Bottom)
--	else
--		NPA_TextureManager_SetTextureRotation(texture,texturedata.Left,texturedata.Right,texturedata.Top,texturedata.Bottom,angle)
--	end
	texture:SetTexture(texturedata.Texture)
end
NPA.TextureManager.SetTextureColor=function(texture,color)
	if(texture.Color)then
		local colordata=texture.Color
		texture:SetVertexColor(colordata.R*color.R,colordata.G*color.G,colordata.B*color.B,colordata.A*color.A)
	else
		texture:SetVertexColor(color.R,color.G,color.B,color.A)
	end
end
NPA.TextureManager.SetTextureColorRGBA=function(texture,r,g,b,a)
	if(texture.Color)then
		local colordata=texture.Color
		texture:SetVertexColor(colordata.R*r,colordata.G*g,colordata.B*b,colordata.A*a)
	else
		texture:SetVertexColor(r,g,b,a)
	end
end
-----------------------------------------------------------
--------texture group-------------------------
--setcolor
NPA.TextureManager.SetTextureGroupColor=function(texturegroup,r,g,b,a)
	local textures=texturegroup.Textures
	for i=1,table_getn(textures)do
		if(textures[i]:IsShown())then
			textures[i]:SetVertexColor(r,g,b,a)
		end
	end
end
--manage
local NPA_TextureManager_ManageTexture=NPA.TextureManager.ManageTexture
NPA.TextureManager.ManageTextureGroup=function(texturegroup,setting)
	--font
	local i=0
	local textures=texturegroup.Textures
	for name,data in pairs(setting)do
		if(name~="Type")then
			i=i+1
			if(not textures[i])then
				textures[i]=texturegroup:CreateTexture()
			end
			NPA_TextureManager_ManageTexture(textures[i],data)
			textures[i]:Show()
		end
	end
	texturegroup.Count=i
	for j=i+1,table_getn(textures) do
		textures[j]:Hide()
	end
	
	texturegroup:SetWidth((setting.Width or 1))
	texturegroup:SetHeight((setting.Height or 1))
	texturegroup.Ziped=nil
end
--create
NPA.TextureManager.CreateTextureGroup=function(mainframe)
	local texturegroup=CreateFrame("Frame",nil,mainframe)
	texturegroup:SetPoint("CENTER",mainframe,"CENTER")
	texturegroup:SetWidth(1)
	texturegroup:SetHeight(1)
	texturegroup.Parent=mainframe
	texturegroup.Count=0
	texturegroup.Textures={}
	texturegroup:EnableMouse(false)
	texturegroup:SetScript("OnHide",function(self)
		local textures=self.Textures
		for i=1,self.Count do
			textures[i]:Hide()
		end
	end)
	texturegroup:SetScript("OnShow",function(self)
		local textures=self.Textures
		for i=1,self.Count do
			textures[i]:Show()
		end
	end)
	return texturegroup
end
--
--
NPA.TextureManager.CreateIconFrame=function(mainframe)
	local textureframe=CreateFrame("Frame",nil,mainframe)
	textureframe:SetWidth(1)
	textureframe:SetHeight(1)
	textureframe:EnableMouse(false)
	--
	local icon=textureframe:CreateTexture()
	icon:SetPoint("TOPLEFT",textureframe,"TOPLEFT",0,0)
	icon:SetPoint("BOTTOMRIGHT",textureframe,"BOTTOMRIGHT",0,0)
	icon:Show()
	textureframe.Icon=icon
	--
	return textureframe
end
