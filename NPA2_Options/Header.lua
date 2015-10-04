-- Author      : Nogarder
-- Create Date : 2012/4/11 14:43:22
--header and macros
local CopyTable=CopyTable
local pairs=pairs
--
NPA_Options={}
NPA_Options.Version="2015.3.17"
--header
NPA_Options.InfoLib={}
NPA_Options.Template={}
--localization
if((not NPA_Language) or NPA_Language=="Default")then
	NPA_Options.Locale=GetLocale() 
else
	NPA_Options.Locale=NPA_Language
end
NPA_Options.Localization=nil
NPA_Options.AviliableLocalization={["Default ("..GetLocale()..")"]="Default"}
--mainframe
NPA_Options.MainFrame=CreateFrame("Frame","NPA_Options_MainFrame",UIParent)
NPA_Options.MainFrame:SetPoint("CENTER",UIParent,"CENTER",0,0)
NPA_Options.MainFrame:SetMovable(true)
NPA_Options.MainFrame:SetWidth(1)
NPA_Options.MainFrame:SetHeight(1)
NPA_Options.MainFrame:Hide()
NPA_Options.MainFrame:SetFrameStrata("TOOLTIP")
--macro for check and run function
NPA_Options.RunFunc=function(func,...)
	if(func)then
		return func(...)
	end
end
--macro for match path to name in lib
NPA_Options.CheckLib=function(value,libfunc)
	local data=libfunc() or {}
	for _,unit in pairs(data) do
		if(unit.Value==value)then
			return unit
		end
	end
end
