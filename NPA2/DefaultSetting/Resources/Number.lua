-- Author      : Nogarder
-- Create Date : 2012/7/28 11:55:07
NPA.SettingManager.RegisterDefault("Number",function()
	return {
		ValueType=1,--0=no value,--1=don't change --2=short,3=break
		["ValueTextData"]={
			ProfileName="Default",
			Height=11,
			--0=custom
			--1=by font
			--2=by percent
			ColorMode=0,
			Color={
				R=1,
				G=1,
				B=1,
				A=1
			},
			Width=0,
			Decimal=false
		},	
		--
		MaxType=1,--0=no value,--1=don't change --2=short,3=break
		["MaxTextData"]={
			ProfileName="Default",
			Height=11,
			--0=custom
			--1=by font
			--2=by percent
			ColorMode=0,
			Color={
				R=1,
				G=1,
				B=1,
				A=1
			},
			Width=0,
			Decimal=false
		},
		PercentType=4,	--0=no percent--1=percent, 2=with brackets 3=with mark, 4= with brackets and mark
		["PercentTextData"]={
			ProfileName="Default",
			Height=11,
			--0=custom
			--1=by font
			--2=by percent
			ColorMode=0,
			Color={
				R=1,
				G=1,
				B=1,
				A=1
			},
			Width=0,
			Decimal=false
		},
		MaxColor={
			R=0,
			G=1,
			B=0,
			A=1,
		},
		MinColor={
			R=1,
			G=0,
			B=0,
			A=1,
		},
	}
end)