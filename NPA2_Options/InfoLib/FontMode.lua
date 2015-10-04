-- Author      : Nogarder
-- Create Date : 2012/4/11 14:37:12
--Font rendering mode
NPA_Options.InfoLib.GetFontMode=function()
	local NPA_Options_FontMode=NPA_Options.Localization.InfoLibFontMode
	--convert into new format
	local fontmode={}
	local i=0
	for name,value in pairs(NPA_Options_FontMode)do
		i=i+1
		fontmode[i]={
			Text=name,
			Value=value
		}
	end
	return fontmode
end
