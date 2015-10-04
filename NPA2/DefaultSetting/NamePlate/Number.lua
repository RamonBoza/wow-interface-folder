-- Author      : Nogarder
-- Create Date : 2012/12/11 10:53:15
NPA.SettingManager.RegisterDefault("NamePlateNumber",function()
	return {
		DataType="Health",
		AnchorFrame="MainFrame",
		FrameLevel=1,
		FrameAnchorData={
			From="CENTER",
			To="CENTER",
			OffsetX=0,
			OffsetY=0,
		},
		ProfileName="Default",
		ColorMode=0, --0=by custom color, 1=faction, 2=class, 3=threat
		--
		Scale=1,
		Alpha=1,
	}
end)
