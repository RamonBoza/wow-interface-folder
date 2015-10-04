-- Author      : Nogarder
-- Create Date : 2012/12/11 10:25:13
NPA.SettingManager.RegisterDefault("NamePlateBarGroup",function()
	return {
		AnchorFrame="MainFrame",
		FrameLevel=1,
		FrameAnchorData={
			From="CENTER",
			To="CENTER",
			OffsetX=0,
			OffsetY=0,
		},
		ProfileName="Default",
		Width=140,
		Height=10,
		SmoothTime=1,
		ShadowAlpha=0.5,
		ColorMode=0, --0=by custom color, 1=faction, 2=class, 3=threat, 4=default, 5=percent
		--
		DataType="Health",
		--
		Scale=1,
		Alpha=1,
	}
end)
