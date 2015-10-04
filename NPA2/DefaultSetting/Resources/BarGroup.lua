-- Author      : Nogarder
-- Create Date : 2012/8/25 12:08:11
NPA.SettingManager.RegisterDefault("BarGroup",function()
	return {
		CheckWithSubString="1",
		["1"]={
			HideWhenMax=false,
			EnableSizeChange=true,
			EnableTextureChange=false,
			--color mode 0=by setting,1=by percent
			ColorMode=0,
			PercentFrom=0,
			PercentTo=1,
			MinColor={
				R=1,
				G=1,
				B=1,
				A=1,
			},
			MaxColor={
				R=1,
				G=1,
				B=1,
				A=1,
			},
			Width=140,
			Height=20,
			ProfileName="Default",
			Direction=0,
			Layer="ARTWORK",
			AnchorData={
				From="LEFT",
				To="CENTER",
				OffsetX=-70,
				OffsetY=0,
			},
		}
	}
end)
