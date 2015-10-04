-- Author      : Nogarder
-- Create Date : 2015/2/3 15:30:58
NPA.SettingManager.RegisterDefault("ExtraArrow",function()
	return {
		ToUnit="focus",
		Gap=30,
		MaxPerLine=10,
		TextureFileName="Arrow",
		SpeedPerSecond=1,
		StartSize=5,
		EndSize=10,
		StartOffsetX=0,
		StartOffsetY=0,
		EndOffsetX=0,
		EndOffsetY=0,
		--
		FrameLevel=1,
		Alpha=1,
		Color={
			R=1,
			G=1,
			B=1,
			A=1,
		},
		EndColor={
			R=1,
			G=1,
			B=1,
			A=1,
		}
	}
end)
