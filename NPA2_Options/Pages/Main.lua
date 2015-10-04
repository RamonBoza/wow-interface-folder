-- Author      : Nogarder
-- Create Date : 2012/4/17 16:03:33
local table_insert=table.insert
--localization
local Localization=NPA_Options.Localization.PagesMain
local Tooltips=Localization.Tooltips
--
local parent=NPA_Options.MainFrame
--main page
																					--function(parent,title,width,height,noborder,nobackground,revers,dragframe)
local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,"NPA2",100,260,nil,nil,nil,NPA_Options.MainFrame)
main:SetPoint("CENTER",parent,"CENTER",-60,120)
local page=main.Frame
page:HookScript("OnHide",function()
	NPA_Options.MainFrame:Hide()
end)
local width=90
local step=-5
--core button
local corebutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Core"])
corebutton:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
NPA_Options.Template.SetTooltips(Tooltips["Core"],corebutton,nil,2)
NPA_Options.SetPageButton(corebutton,"Core",main)
--resourceslib button
local resourceslibbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["ResourcesLib"])
NPA_Options.Template.SetTooltips(Tooltips["ResourcesLib"],resourceslibbutton,nil,2)
resourceslibbutton:SetPoint("TOP",corebutton,"BOTTOM",0,step)
NPA_Options.SetPageButton(resourceslibbutton,"ResourcesLib",main)
--nameplate button
local nameplatebutton=NPA_Options.Template.CreateButton(page,width,15,Localization["NamePlate"])
NPA_Options.Template.SetTooltips(Tooltips["Appearance"],nameplatebutton,nil,2)
nameplatebutton:SetPoint("TOP",resourceslibbutton,"BOTTOM",0,step)
NPA_Options.SetPageButton(nameplatebutton,"NamePlate",main)
--combattext button
local combattextbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["CombatText"])
NPA_Options.Template.SetTooltips(Tooltips["CombatText"],combattextbutton,nil,2)
combattextbutton:SetPoint("TOP",nameplatebutton,"BOTTOM",0,step)
NPA_Options.SetPageButton(combattextbutton,"CombatText",main)
--targetarrow button
local targetarrowbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["TargetArrow"])
NPA_Options.Template.SetTooltips(Tooltips["TargetArrow"],targetarrowbutton,nil,2)
targetarrowbutton:SetPoint("TOP",combattextbutton,"BOTTOM",0,step)
NPA_Options.SetPageButton(targetarrowbutton,"TargetArrow",main)
--extraarrow button
local extraarrowbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["ExtraArrow"])
NPA_Options.Template.SetTooltips(Tooltips["ExtraArrow"],extraarrowbutton,nil,2)
extraarrowbutton:SetPoint("TOP",targetarrowbutton,"BOTTOM",0,step)
NPA_Options.SetPageButton(extraarrowbutton,"ExtraArrow",main)
--tracker button
local trackerbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Tracker"])
NPA_Options.Template.SetTooltips(Tooltips["Tracker"],trackerbutton,nil,2)
trackerbutton:SetPoint("TOP",extraarrowbutton,"BOTTOM",0,step)
NPA_Options.SetPageButton(trackerbutton,"Tracker",main) 
--profilemanager button
local profilemanagerbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["ProfileManager"])
NPA_Options.Template.SetTooltips(Tooltips["ProfileManager"],profilemanagerbutton,nil,2)
profilemanagerbutton:SetPoint("TOP",trackerbutton,"BOTTOM",0,step)
NPA_Options.SetPageButton(profilemanagerbutton,"ProfileManager",main)
--help button
local helpbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Help"])
NPA_Options.Template.SetTooltips(Tooltips["Help"],helpbutton,nil,2)
helpbutton:SetPoint("TOP",profilemanagerbutton,"BOTTOM",0,step)
--
helpbutton:HookScript("OnMouseUp",function()
	NPA_Options.HelpPage:ClearAllPoints()
	NPA_Options.HelpPage:SetPoint("TOPRIGHT",main,"TOPLEFT",-10,0)
	NPA_Options.Animation.ShowFrame(NPA_Options.HelpPage)
end)
--special reset ui button
local uiresetbutton=NPA_Options.Template.CreateSystemButton(page,width,15,Localization["ReloadUI"])
NPA_Options.Template.SetTooltips(Tooltips["ReloadUI"],uiresetbutton,nil,2)
uiresetbutton:SetPoint("BOTTOM",page,"BOTTOM",0,5)
uiresetbutton:SetScript("OnClick",function()
	local confirmbox=NPA_Options.Template.SetMsgBox(main,Localization["ReloadUI"],function()
		ReloadUI()
	end)
	confirmbox:SetPoint("LEFT",uiresetbutton,"RIGHT",10,0)
end)
--language selector
local GetAviliableLocalization=function()
	local data={}
	for name,ddata in pairs(NPA_Options.AviliableLocalization)do
		table_insert(data,{
			Text=name,
			Value=ddata.ID,
			Tooltips=ddata.Translator
		})
	end
	return data
end
local localizationbutton=NPA_Options.Template.CreateDropDownEditor(page,width,"Language",Tooltips["RequireReload"],GetAviliableLocalization)
localizationbutton:SetPoint("BOTTOMLEFT",uiresetbutton,"TOPLEFT",0,-step)
NPA_Options.Template.SetDropDownEditor(localizationbutton,NPA_Options.Locale)
localizationbutton.OnValueUpdateFunc=function()
	NPA_Language=localizationbutton.Value
end
--
local ziped
page:HookScript("OnShow",function()
	ziped=false
end)
main.Minimizer:SetScript("OnMouseUp",function()
	if(ziped)then
		NPA_Options.RestorePages(main)
		ziped=false
	else
		NPA_Options.MinimizePages(main)
		ziped=true
	end
end)
--
NPA_Options.RegisterPage("MainPage",main)
NPA_Options.MainPage=main
