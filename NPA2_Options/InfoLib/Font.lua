-- Author      : Nogarder
-- Create Date : 2012/4/11 14:36:36
--font lib
--set different lib with locale
NPA_Options.InfoLib.GetFont=function()
	local NPA_Options_FontLib=NPA_Options.Localization.InfoLibFont
	--SharedMedia-3.0 support
	if(LibStub)then
		local sharemedia=LibStub:GetLibrary("LibSharedMedia-3.0",1)
		if(sharemedia)then
			for name,value in pairs(sharemedia.MediaTable.font) do
				NPA_Options_FontLib[name]=value
			end
		end
	end
	--convert into new format
	local fontlib={}
	local i=0
	for name,value in pairs(NPA_Options_FontLib)do
		i=i+1
		fontlib[i]={
			Text=name,
			Value=value,
			Font=value,
		}
	end
	return fontlib
end
