-- Author      : Nogarder
-- Create Date : 2013/12/8 0:55:25

NPA.TextManager={}
local NPA_FontManager_SetText=NPA.FontManager.SetText

NPA.TextManager.CreateTextFrame=function(modulemain)
	--
	local frame=CreateFrame("Frame",nil,modulemain)
	frame:SetWidth(1)
	frame:SetHeight(1)
	frame:EnableMouse(false)
	--
	local text=frame:CreateFontString(nil,"OVERLAY")
	text:SetFont(ChatFontNormal:GetFont())
	text:SetPoint("CENTER",frame,"CENTER")
	frame.Text=text 
	--
	return frame
end

NPA.TextManager.SetText=function(textframe,text)
	local textstring=textframe.Text
	NPA_FontManager_SetText(textstring,text)
	textframe:SetWidth(textstring:GetWidth())
	textframe:SetHeight(textstring:GetHeight())
	textframe.Ziped=nil
end

NPA.TextManager.SetTextColor=function(textframe,color)
	textframe.Text:SetTextColor(color.R,color.G,color.B,color.A)
end
NPA.TextManager.SetTextColor2=function(textframe,r,g,b,a)
	textframe.Text:SetTextColor(r,g,b,a)
end