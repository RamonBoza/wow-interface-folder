-- Author      : Nogarder
-- Create Date : 2012/11/7 11:26:02
-- Author      : Nogarder
-- Create Date : 2012/11/7 11:02:40
local bit_band=bit.band
--
NPA_Options.InfoLib.Unit={}
--
NPA_Options.InfoLib.Unit.GetUnitType=function(flag)
	local NPA_Options_Unit_Type=NPA_Options.Localization.InfoLibUnit
	local text=""
	for mask,name in pairs(NPA_Options_Unit_Type)do
		if(bit_band(flag,mask)>0)then
			text=text.."["..name.."]"
		end
	end
	return text
end
--

