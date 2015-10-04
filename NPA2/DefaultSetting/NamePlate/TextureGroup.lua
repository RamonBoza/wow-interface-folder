-- Author      : Nogarder
-- Create Date : 2012/12/11 10:25:00
NPA.SettingManager.RegisterDefault("NamePlateTextureGroup",function()
	return {
		DataType="None",
		AnchorFrame="MainFrame",
		FrameLevel=1,
		--
		Scale=1,
		Alpha=1,
		--
		Width=20,
		Height=20,
		--
		FrameAnchorData={
			From="CENTER",
			To="CENTER",
			OffsetX=0,
			OffsetY=0,
		},
		TextureGroup={
			CheckWithSubString="1", --used for setting manager only,means check with one default
			["1"]={
				ProfileName="Default",
				AnchorData={
					From="CENTER",
					To="CENTER",
					OffsetX=0,
					OffsetY=0,
				},
				Height=20,
				Width=140,
				Layer="BACKGROUND",
			}
		},
	}
end)
