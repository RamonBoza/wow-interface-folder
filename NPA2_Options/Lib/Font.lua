-- Author      : Nogarder
-- Create Date : 2012/7/18 10:56:41
local TextList={}
local NPA_SettingManager_GetResources=NPA.SettingManager.GetResources
--
NPA_Options.SetTextFont=function(text,font,fontname,size,customcolor)
	if(font)then
		text:SetFont(font,size or 12,nil)
		text:SetTextColor(1,1,1,1)
		text:SetShadowOffset(1,-1)
	elseif(fontname)then
		local fontdata=NPA_SettingManager_GetResources("Font",fontname)
		NPA.FontManager.ManageFont4(text,fontdata,size or 12)
		--text:SetFont(fontdata.Font,size or 12,fontdata.Mode)
		--local color=customcolor or fontdata.Color
		--text:SetTextColor(color.R,color.G,color.B,color.A)
		--text:SetShadowOffset(fontdata.ShadowX,fontdata.ShadowY)
		NPA.FontManager.SetText(text,text:GetText())
		TextList[text]=fontname
	else
		text:SetFont(GameFontNormal:GetFont(),size or 12,nil)
		text:SetTextColor(1,1,1,1)
		text:SetShadowOffset(1,-1)
	end
end
--
NPA.EventHandler.RegisterEvent(6,"Resources_ProfileRefresh","NPA_Options_TextFontRefresh",function()
		for text,name in pairs(TextList)do
			if(text:IsShown())then
				NPA_Options.SetTextFont(text,name)
			end
		end
	end)
