-- Author      : Nogarder
-- Create Date : 2012/12/29 13:00:33
NPA.SettingManager.RegisterDefault("NamePlateIcon",function()
	return {
		AnchorFrame="MainFrame",
		FrameLevel=1,
		FrameAnchorData={
			From="CENTER",
			To="CENTER",
			OffsetX=-70,
			OffsetY=0,
		},
		Width=20,
		Height=20,
		Layer="BACKGROUND",
		--
		DataType="Class",
		--
		Scale=1,
		Alpha=1,
	}
end)
