-- Author      : Nogarder
-- Create Date : 2012/3/27 11:00:23
local string_format=string.format
local string_len=string.len
local string_gsub=string.gsub
local string_gmatch=string.gmatch
local table_getn=table.getn
local NPA_ClearTable=NPA.ClearTable
--main
NPA.FontManager={}
-----------------font manager--------------------------------
local DecimalToHex=function(value)
	local str=string_format("%x",value*255)
	if(string_len(str)==1)then
		str="0"..str
	end
	return str
end
local ColorStepCache={}
NPA.FontManager.CacheColorStringStep=function(text,color,colorend,stepcount,revers)
	if(not ColorStepCache[text])then
		ColorStepCache[text]={}
	else
		NPA_ClearTable(ColorStepCache[text])
	end
	--
	local colorstepr=(colorend.R-color.R)/stepcount
	local colorstepg=(colorend.G-color.G)/stepcount
	local colorstepb=(colorend.B-color.B)/stepcount
	local colorstepa=(colorend.A-color.A)/stepcount
	local currentcolorr=color.R
	local currentcolorg=color.G
	local currentcolorb=color.B
	local currentcolora=color.A
	
	local tab=ColorStepCache[text]
	for i=1,stepcount+1 do
		tab[i]="|c"..DecimalToHex(currentcolora)..DecimalToHex(currentcolorr)..DecimalToHex(currentcolorg)..DecimalToHex(currentcolorb)
		currentcolorr=currentcolorr+colorstepr
		currentcolorg=currentcolorg+colorstepg
		currentcolorb=currentcolorb+colorstepb
		currentcolora=currentcolora+colorstepa
	end
	tab[0]=tab[stepcount+1]
	for i=stepcount+2,table_getn(tab) do
		if(tab[i])then
			tab[i]=nil
		end
	end
	tab.Revers=revers
end
--
NPA.FontManager.ClearCacheColorStringStep=function(text)
	ColorStepCache[text]=nil
end
--
NPA.FontManager.ColorStringByStep=function(text,str)
	if(str==nil or ColorStepCache[text]==nil)then
		return str
	end
	local tab=ColorStepCache[text]

	local ret=""
	local lastcolor=tab[0]
	--get the string's length in unicode
	local _,length=string_gsub(str, "[^\128-\193]", "")
	if(tab.Revers)then
		local index=1
		for uchar in string_gmatch(str, "([%z\1-\127\194-\244][\128-\191]*)") do
			ret=ret..((tab[index] or lastcolor)..uchar)
			index=index+1
		end
	else
		local index=length
		---unicode word by word, it's weird, right?
		for uchar in string_gmatch(str, "([%z\1-\127\194-\244][\128-\191]*)") do
			ret=ret..((tab[index] or lastcolor)..uchar)
			index=index-1
		end
	end
	return ret
end
--
local NPA_FontManager_CacheColorStringStep=NPA.FontManager.CacheColorStringStep
local NPA_FontManager_ClearCacheColorStringStep=NPA.FontManager.ClearCacheColorStringStep
local NPA_FontManager_ColorStringByStep=NPA.FontManager.ColorStringByStep
----
local SetColorChange=function(font,fontdata)
	if(fontdata.ColorChange)then
		NPA_FontManager_CacheColorStringStep(font,fontdata.Color,fontdata.Color2,fontdata.ColorChangeStep,fontdata.ColorChangeRevers)
	else
		NPA_FontManager_ClearCacheColorStringStep(font)
	end
end
----------------------------------------
NPA.FontManager.SetText=function(font,str)
	local text=NPA_FontManager_ColorStringByStep(font,str)
	font:SetText(text)
end
----------------------------------------
NPA.FontManager.ManageFont=function(font,data)
	local fontdata=NPA.SettingManager.GetResources("Font",data.ProfileName)
	font:SetFont((fontdata.Font or ChatFontNormal:GetFont()),data.Height,fontdata.Mode)
	--
	if(data.ColorMode==0)then
		local color=fontdata.Color
		font:SetTextColor(color.R,color.G,color.B,color.A)
	end
	--
	font:SetShadowOffset(fontdata.ShadowX,fontdata.ShadowY)
	--
	if(data.Layer)then
		font:SetDrawLayer(data.Layer)
	end
	--
	font:SetHeight(data.Height)
	font:SetWidth(data.Width)
	--
	local anchordata=data.AnchorData
	if(anchordata)then
		font:ClearAllPoints()
		font:SetPoint(anchordata.From,font:GetParent(),anchordata.To,anchordata.OffsetX,anchordata.OffsetY)
	end
	--
	SetColorChange(font,fontdata)
end
NPA.FontManager.ManageFont2=function(font,data)
	local fontdata=NPA.SettingManager.GetResources("Font",data.ProfileName)
	font:SetFont((fontdata.Font or ChatFontNormal:GetFont()),data.Height,fontdata.Mode)
	--
	if(data.ColorMode==0)then
		local color=fontdata.Color
		font:SetTextColor(color.R,color.G,color.B,color.A)
	end
	--
	font:SetShadowOffset(fontdata.ShadowX,fontdata.ShadowY)
	--
	SetColorChange(font,fontdata)
end

NPA.FontManager.ManageFont3=function(font,profilename,width,height)
	local fontdata=NPA.SettingManager.GetResources("Font",profilename)
	font:SetFont((fontdata.Font or ChatFontNormal:GetFont()),height,fontdata.Mode)
	--
	font:SetWidth(width)
	font:SetHeight(height)
	--
	font:SetShadowOffset(fontdata.ShadowX,fontdata.ShadowY)
	--
	SetColorChange(font,fontdata)
end

NPA.FontManager.ManageFont4=function(font,fontdata,height)
	font:SetFont((fontdata.Font or ChatFontNormal:GetFont()),height,fontdata.Mode)
	--
	--font:SetHeight(height)
	--
	font:SetShadowOffset(fontdata.ShadowX,fontdata.ShadowY)
	local color=fontdata.Color
	font:SetTextColor(color.R,color.G,color.B,color.A)
	--
	SetColorChange(font,fontdata)
end