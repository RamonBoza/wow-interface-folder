-- Author      : Nogarder
-- Create Date : 2012/7/18 7:52:56
--set different lib with locale
NPA_Options.InfoLib.GetLayer=function()
	local NPA_Options_Layer=NPA_Options.Localization.InfoLibLayer
	--convert into new formation
	local layer={}
	local i=0
	for name,value in pairs(NPA_Options_Layer)do
		i=i+1
		layer[i]={
			Text=name,
			Value=value,
		}
	end
	return layer
end