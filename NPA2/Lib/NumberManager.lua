-- Author      : Nogarder
-- Create Date : 2012/8/28 9:14:39
local floor=floor
local mod=mod
local tostring=tostring
local string_len=string.len
local string_sub=string.sub
local string_format=string.format
local table_getn=table.getn
local NPA_FontManager_SetText=NPA.FontManager.SetText

--
NPA.NumberManager={}
---------------number
local NPA_NumberManager_GetTime=function(value,atype,decimal)
	--filter out really huge number (i.e. N/A aura)
	if(value>7200)then
		return "*"
	end

	if(atype==1)then
		if(decimal==true)then
			return floor(value*10)/10
		else
			return floor(value)
		end
	elseif(atype==2)then
		--short
		if(value>3600)then
			if(decimal==true)then
				return (floor(value/360)/10).."h"
			else
				return (floor(value/3600)).."h"
			end
		elseif(value>60)then
			if(decimal==true)	then
				return (floor(value/6)/10).."m"
			else
				return (floor(value/60)).."m"
			end
		elseif(value>10)then
			if(decimal==true)then
				return floor(value*10)/10
			else
				return floor(value)
			end
		elseif(decimal==true)then
			return floor(value*10)/10
		else
			return floor(value)
		end
	elseif(atype==3)then
		--break
		if(value>3600)then
			--local h=floor(value/3600)
			--local m=floor(mod(value,3600)/60)
			--local s=floor(mod(value,60))
			if(decimal==true)then
				return floor(value/3600).."h"..floor(mod(value,3600)/60).."m"..(floor(mod(value,60)*10)/10)
			else
				return floor(value/3600).."h"..floor(mod(value,3600)/60).."m"..(floor(mod(value,60)))
			end
		elseif(value>60)then
			if(decimal==true)then
				return floor(value/60).."m"..(floor(mod(value,60)*10)/10)
			else
				return floor(value/60).."m"..(floor(mod(value,60)))
			end
		elseif(value>10)then
			if(decimal==true)then
				return floor(value*10)/10
			else
				return floor(value)
			end
		else
			if(decimal==true)then
				return floor(value*10)/10
			else
				return floor(value)
			end
		end
	end
end
--
local NPA_NumberManager_GetNumber=function(value,atype,decimal)
	if(atype==1)then
		--value
		if(decimal==true)then
			return floor(value*10)/10
		else
			return floor(value)
		end
	elseif(atype==2)then
		--short
		if(value>1000000000)then
			if(decimal==true)then
				return (floor(value/100000000)/10).."g"
			else
				return (floor(value/1000000000)).."g"
			end
		elseif(value>1000000)then
			if(decimal==true)then
				return (floor(value/100000)/10).."m"
			else
				return (floor(value/1000000)).."m"
			end
		elseif(value>1000)then
			if(decimal==true)then
				return (floor(value/100)/10).."k"
			else
				return (floor(value/1000)).."k"
			end
		elseif(decimal==true)then
			return floor(value*10)/10
		else
			return floor(value)
		end
	elseif(atype==3)then
		--break
		local str=tostring(value)
		local ret=string_sub(str,-3,-1)
		str=string_sub(str,1,-4)
		while(string_len(str)>3)do
			ret=string_sub(str,-3,-1)..","..ret
			str=string_sub(str,1,-4)
		end
		if(str~="")then
			return str..","..ret
		else
			return ret
		end
	end
end
--
NPA.NumberManager.GetNumber2=function(value,atype)
	if(atype==1)then
		return value
	elseif(atype==2)then
		--short
		if(value>1000000000)then
			return (floor(value/1000000000)).."g"
		elseif(value>1000000)then
			return (floor(value/1000000)).."m"
		elseif(value>1000)then
			return (floor(value/1000)).."k"
		else
			return value
		end
	elseif(atype==3)then
		--break
		local str=tostring(value)
		local ret=string_sub(str,-3,-1)
		str=string_sub(str,1,-4)
		while(string_len(str)>3)do
			ret=string_sub(str,-3,-1)..","..ret
			str=string_sub(str,1,-4)
		end
		if(str~="")then
			return str..","..ret
		else
			return ret
		end
	elseif(atype==4)then
		--short with decimal
		if(value>1000000000)then
			return (floor(value/100000000)/10).."g"
		elseif(value>1000000)then
			return (floor(value/100000)/10).."m"
		elseif(value>1000)then
			return (floor(value/100)/10).."k"
		else
			return value
		end
	end
end
--
local NPA_NumberManager_GetNumberByType=function(value,atype,istime,decimal)
	--
	if(istime)then
		return NPA_NumberManager_GetTime(value,atype,decimal)
	else
		return NPA_NumberManager_GetNumber(value,atype,decimal)
	end
end
--
NPA.NumberManager.SetNumberColor=function(number,color)
	if(number.Value)then
		number.Value:SetTextColor(color.R,color.G,color.B,color.A)
	end
	if(number.Max)then
		number.Max:SetTextColor(color.R,color.G,color.B,color.A)
	end
	if(number.Percent)then
		number.Percent:SetTextColor(color.R,color.G,color.B,color.A)
	end
end
--
local GetPercent=function(value,max,decimal)
	if(decimal==true)then
		return floor(value/max*1000)/10
	else
		return floor(value/max*100)
	end
end
--create func
NPA.NumberManager.SetNumber=function(number,value,max,istime)
	local value=value or 0
	local max=max or 1
	--prevent deviding by 0
	if(max==0)then
		max=1
	end
	--
	local width=1
	local height=1
	--value
	--0=no value,--1=don't change --2=short,3=break
	local valuetype=number.ValueType
	local percent
	local percentcolorr,percentcolorg,percentcolorb,percentcolora

	if(valuetype~=0)then
		local str=NPA_NumberManager_GetNumberByType(value,valuetype,istime,number.ValueDecimal)
		NPA_FontManager_SetText(number.Value,str)
		width=width+number.Value:GetWidth()
		height=number.Value:GetHeight()
		if(number.ColorValueByPercent)then
			percent=GetPercent(value,max,number.PercentDecimal)
			percentcolorr=number.R+number.StepR*percent/100
			percentcolorg=number.G+number.StepG*percent/100
			percentcolorb=number.B+number.StepB*percent/100
			percentcolora=number.A+number.StepA*percent/100
			number.Value:SetTextColor(percentcolorr,percentcolorg,percentcolorb,percentcolora)
		end
	end
	--max
	--0=no value,--1=don't change --2=short,3=break
	local maxtype=number.MaxType
	if(maxtype~=0)then
		local str=NPA_NumberManager_GetNumberByType(max,maxtype,istime,number.MaxDecimal)
		if(valuetype~=0)then
			str="/"..str
			NPA_FontManager_SetText(number.Max,str)
		else
			NPA_FontManager_SetText(number.Max,str)
		end
		width=width+number.Max:GetWidth()
		local aheight=number.Max:GetHeight()
		if(aheight>height)then
			height=aheight
		end
	end
	--percent
	--0=no percent--1=percent, 2=with brackets 3=with mark, 4= with brackets and mark
	local percenttype=number.PercentType
	if(percenttype~=0)then
		percent=percent or GetPercent(value,max,number.PercentDecimal)
		if(percenttype==2)then
			percent="("..percent..")"
		elseif(percenttype==3)then
			percent=percent.."%"
		elseif(percenttype==4)then
			percent="("..percent.."%)"
		end
		NPA_FontManager_SetText(number.Percent,percent)
		width=width+number.Percent:GetWidth()
		local aheight=number.Percent:GetHeight()
		if(aheight>height)then
			height=aheight
		end
		if(number.ColorPercentByPercent)then
			percentcolorr=percentcolorr or (number.R+number.StepR*percent/100)
			percentcolorg=percentcolorg or (number.G+number.StepG*percent/100)
			percentcolorb=percentcolorb or (number.B+number.StepB*percent/100)
			percentcolora=percentcolora or (number.A+number.StepA*percent/100)
			number.Percent:SetTextColor(percentcolorr,percentcolorg,percentcolorb,percentcolora)
		end
	end
	number:SetWidth(width)
	number:SetHeight(height)
	number.Ziped=false
	number.CurrentValue=value
	number.MaxValue=max
	number.PercentValue=percent
end
--
--
local NPA_FontManager_ManageFont=NPA.FontManager.ManageFont
NPA.NumberManager.UpdateNumber=function(number,setting,colormode)
	local width=1
	local height=1

	if(not setting)then
		if(number.Value)then
			number.Value:Hide()
		end
		if(number.Max)then
			number.Max:Hide()
		end
		if(number.Percent)then
			number.Percent:Hide()
		end
		return
	end
	number.ValueType=setting.ValueType
	number.MaxType=setting.MaxType
	number.PercentType=setting.PercentType
	--value
	if(setting.ValueType~=0)then
		if(not number.Value)then
			number.Value=number:CreateFontString(nil,"OVERLAY")
			number.Value:SetPoint("BOTTOMLEFT",number,"BOTTOMLEFT")
		end
		NPA_FontManager_ManageFont(number.Value,setting.ValueTextData)
		if(colormode==0 and setting.ValueTextData.ColorMode==2)then
			number.ColorValueByPercent=true
			number.StepR=setting.MaxColor.R-setting.MinColor.R
			number.StepG=setting.MaxColor.G-setting.MinColor.G
			number.StepB=setting.MaxColor.B-setting.MinColor.B
			number.StepA=setting.MaxColor.A-setting.MinColor.A
			number.R=setting.MinColor.R
			number.G=setting.MinColor.G
			number.B=setting.MinColor.B
			number.A=setting.MinColor.A
		else
			number.ColorValueByPercent=nil
		end
		width=width+number.Value:GetWidth()
		if(height<number.Value:GetHeight())then
			height=number.Value:GetHeight()
		end
		--
		number.ValueDecimal=(not setting.ValueTextData.Decimal) --revers the setting
		--
		number.Value:Show()
	else
		if(number.Value)then
			number.Value:Hide()
		end
	end
	--mark
	if(setting.MaxType~=0)then
		if(not number.Max)then
			number.Max=number:CreateFontString(nil,"OVERLAY")
		end
		NPA_FontManager_ManageFont(number.Max,setting.MaxTextData)
		if(number.ValueType~=0)then
			number.Max:SetPoint("BOTTOMLEFT",number.Value,"BOTTOMRIGHT")
		else
			number.Max:SetPoint("BOTTOMLEFT",number,"BOTTOMLEFT")
		end
		width=width+number.Max:GetWidth()
		if(height<number.Max:GetHeight())then
			height=number.Max:GetHeight()
		end
		number.MaxDecimal=(not setting.MaxTextData.Decimal) --revers
		--
		number.Max:Show()
	else
		if(number.Max)then
			number.Max:Hide()
		end
	end
	--percent
	if(setting.PercentType~=0)then
		if(not number.Percent)then
			number.Percent=number:CreateFontString(nil,"OVERLAY")
		end
		NPA_FontManager_ManageFont(number.Percent,setting.PercentTextData)
		if(number.MaxType~=0)then
			number.Percent:SetPoint("BOTTOMLEFT",number.Max,"BOTTOMRIGHT")
		elseif(number.ValueType~=0)then
			number.Percent:SetPoint("BOTTOMLEFT",number.Value,"BOTTOMRIGHT")
		else
			number.Percent:SetPoint("BOTTOMLEFT",number,"BOTTOMLEFT")
		end
		if(colormode==0 and setting.PercentTextData.ColorMode==2)then
			number.ColorPercentByPercent=true
			number.StepR=setting.MaxColor.R-setting.MinColor.R
			number.StepG=setting.MaxColor.G-setting.MinColor.G
			number.StepB=setting.MaxColor.B-setting.MinColor.B
			number.StepA=setting.MaxColor.A-setting.MinColor.A
			number.R=setting.MinColor.R
			number.G=setting.MinColor.G
			number.B=setting.MinColor.B
			number.A=setting.MinColor.A
		else
			number.ColorPercentByPercent=nil
		end
		width=width+number.Percent:GetWidth()
		if(height<number.Percent:GetHeight())then
			height=number.Percent:GetHeight()
		end
		number.PercentDecimal=(not setting.PercentTextData.Decimal) --revers
		number.Percent:Show()
	else
		if(number.Percent)then
			number.Percent:Hide()
		end
	end
	number:SetWidth(width)
	number:SetHeight(height)
	number.Ziped=nil
	--
	NPA.NumberManager.SetNumber(number,number.CurrentValue,number.MaxValue)
end
--
NPA.NumberManager.CreateNumber=function(frame)
	local number=CreateFrame("Frame",nil,frame)
	return number
end
--
local NPA_NumberManager_UpdateNumber=NPA.NumberManager.UpdateNumber
local NPA_SettingManager_GetResources=NPA.SettingManager.GetResources
--
NPA.NumberManager.ManageNumber=function(numberframe,framesetting)
	local setting=NPA_SettingManager_GetResources("Number",framesetting.ProfileName)
	NPA_NumberManager_UpdateNumber(numberframe,setting,framesetting.ColorMode)
end
