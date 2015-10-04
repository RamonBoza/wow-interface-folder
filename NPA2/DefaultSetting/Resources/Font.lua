-- Author      : Nogarder
-- Create Date : 2012/7/13 15:56:31
NPA.SettingManager.RegisterDefault("Font",function()
	return {
		Font=GameFontNormal:GetFont(),
		ShadowX=1,
		ShadowY=-1,
		Mode="OUTLINE",
		Color={
			R=1,
			G=1,
			B=1,
			A=1,
		},
		Color2={
			R=1,
			G=1,
			B=1,
			A=1,
		},
		ColorChange=false,
		ColorChangeStep=5,	
		ColorChangeRevers=false,
	}
end)