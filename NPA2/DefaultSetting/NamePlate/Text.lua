-- Author      : Nogarder
-- Create Date : 2012/12/11 10:24:47
NPA.SettingManager.RegisterDefault("NamePlateText",function()
	return {
		AnchorFrame="MainFrame",
		FrameLevel=1,
		FrameAnchorData={
			From="CENTER",
			To="CENTER",
			OffsetX=0,
			OffsetY=40,
		},
		Layer="BACKGROUND",
		ProfileName="Default",
		Height=11,
		Width=0,
		Color={
			R=1,
			G=1,
			B=1,
			A=1
		},
		ColorMode=0, --0=by custom color, 1=faction, 2=class, 3=threat
		--
		DataType="Name",
		--
		Scale=1,
		Alpha=1,
	}
end)
