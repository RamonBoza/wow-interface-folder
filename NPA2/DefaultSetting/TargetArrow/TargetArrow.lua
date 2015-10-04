-- Author      : Nogarder
-- Create Date : 2013/4/20 11:28:01
NPA.SettingManager.RegisterDefault("TargetArrow",function()
	return {
		--0=any, 1=friendly,2=neutral,3=hostile,4=self
		From=4,-- any, self, friendly, neutral, hostile
		To=0,
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
		FadeAlpha=0,
		LifeTime=1,
		AlphaWithParent=false,
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
		},
		RangeCheck=0,
		RangeColor={
			R=1,
			G=1,
			B=1,
			A=1,
		},
		RangeEndColor={
			R=1,
			G=1,
			B=1,
			A=1,
		},
	}
end)
