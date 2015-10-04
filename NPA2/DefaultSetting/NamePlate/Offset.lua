-- Author      : Nogarder
-- Create Date : 2013/6/8 13:28:50

NPA.SettingManager.RegisterDefault("NamePlateOffset",function()
	return {
		ConditionType="Default", 
		Arg=" ",
		Offset={
			From="CENTER",
			To="CENTER",
			OffsetX=0,
			OffsetY=0,
		},
	}
end)
