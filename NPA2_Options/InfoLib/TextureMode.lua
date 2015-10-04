-- Author      : Nogarder
-- Create Date : 2012/4/11 14:37:04
--Texture render mode
NPA_Options.InfoLib.GetTextureMode=function()
	local NPA_Options_TextureMode=NPA_Options.Localization.InfoLibTextureMode
	--convert into new format
	local texturemode={}
	local i=0
	for name,value in pairs(NPA_Options_TextureMode)do
		i=i+1
		texturemode[i]={
			Text=name,
			Value=value
		}
	end
	return texturemode
end
