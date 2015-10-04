-- Author      : Nogarder
-- Create Date : 2013/3/7 16:49:21
NPA_Options.RegisterPageFunc("About",function()
	--localization
	local Localization=NPA_Options.Localization
	--
	local parent=NPA_Options.MainFrame
	--main page
	local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,"NamePlate Advance 2 Build "..NPA.Version,400,200,nil,nil,nil,nil,NPA_Options.MainFrame)
	main:Hide()
	--
	local page=main.Frame
	--
	local abouttext=page:CreateFontString()
	abouttext:SetFont(GameFontNormal:GetFont())
	abouttext:SetText(Localization.About)
	abouttext:SetPoint("TOP",page,"TOP",0,-13)
	local translatortext=page:CreateFontString()
	translatortext:SetFont(GameFontNormal:GetFont())
	translatortext:SetText(Localization.Translator)
	translatortext:SetPoint("TOP",abouttext,"BOTTOM",0,-13)
	--
	NPA_Options.RegisterPage("About",main)
end)
