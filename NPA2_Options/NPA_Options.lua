-- Author      : Nogarder
-- Create Date : 2012/4/11 15:41:17
--
NPA_Options.Start=function()
	--by this time localization loading should be done
	--release localization resources
	--NPA_Options.Localization=nil
	--
	if(NPA_Options.MainFrame:IsShown())then
		NPA_Options.ClosePages(NPA_Options.MainPage)
		NPA_Options.MainFrame:Hide()
	else
		NPA_Options.HideTemplates()
		NPA_Options.MainFrame:StopMovingOrSizing()
		NPA_Options.MainFrame:ClearAllPoints()
		NPA_Options.MainFrame:SetPoint("CENTER",UIParent,"CENTER",0,0)
		NPA_Options.Animation.ClearAll()
		NPA_Options.MainFrame:Show()
		NPA_Options.Animation.ShowFrame(NPA_Options.MainPage)
		NPA_Options.MainPage:ClearAllPoints()
		NPA_Options.MainPage:SetPoint("CENTER",NPA_Options.MainFrame,"CENTER",-50,120)
	end
end