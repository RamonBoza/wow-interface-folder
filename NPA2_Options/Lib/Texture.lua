-- Author      : Nogarder
-- Create Date : 2012/4/15 18:39:57
local NPA_SettingManager_GetResources=NPA.SettingManager.GetResources
--use for rotate texture
--macro for rotate coordinate
local NPA_TextureManager_Rotation=function(x,y,angle)
	local ca=cos(angle)--floor(cos(angle)*1000)/1000
	local sa=sin(angle)--floor(sin(angle)*1000)/1000
	return x*ca-y*sa,x*sa+y*ca
end
--rotate texture
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
NPA_Options.SetTextureRotation=function(texture,angle,scale)
	scale=scale or 1
	local dleft=-0.5*scale
	local dright=0.5*scale
	local dtop=-0.5*scale
	local dbottom=0.5*scale
	
	local tlx,tly=NPA_TextureManager_Rotation(dleft,dtop,angle)
	local blx,bly=NPA_TextureManager_Rotation(dleft,dbottom,angle)
	local trx,try=NPA_TextureManager_Rotation(dright,dtop,angle)
	local brx,bry=NPA_TextureManager_Rotation(dright,dbottom,angle)

	tlx=tlx+0.5
	tly=tly+0.5
	blx=blx+0.5
	bly=bly+0.5
	trx=trx+0.5
	try=try+0.5
	brx=brx+0.5
	bry=bry+0.5

	texture:SetTexCoord(tlx,tly,blx,bly,trx,try,brx,bry)
end
--
local TextureList={}
NPA_Options.SetTexture=function(texture,texturename,texturefile,blendmode,color,angle,left,right,top,bottom)
	if(texturename)then
		local data={
			ProfileName=texturename,
			Mode=blendmode,
			Color=color,
			RAngle=angle,
			Left=left,
			Right=right,
			Top=top,
			Bottom=bottom,
			Width=texture:GetWidth(),
			Height=texture:GetHeight(),
			Layer="ARTWORK"
		}
		NPA.TextureManager.ManageTexture(texture,data,1,1,true,nil,0,0)
		--
		texture:Show()
		--store it
		TextureList[texture]=texturename
	elseif(texturefile)then
		texture:SetBlendMode(blendmode)
		texture:SetVertexColor(color.R,color.G,color.B,color.A)

		if(angle==nil or angle==0)then
			texture:SetTexCoord(left,right,top,bottom)
		else
			NPA_TextureManager_SetTextureRotation(texture,left,right,top,bottom,angle)
		end
		--
		texture:SetTexture(texturefile)
		texture:Show()
	else
		texture:Hide()
	end
end
--
NPA.EventHandler.RegisterEvent(6,"Resources_ProfileRefresh","NPA_Options_TextureRefresh",function()
		for texture,name in pairs(TextureList)do
			if(texture:IsShown())then
				NPA_Options.SetTexture(texture,name)
			end
		end
	end)
