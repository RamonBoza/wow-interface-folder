-- Author      : Nogarder
-- Create Date : 2013/6/6 16:20:00
NPA.SettingManager.RegisterDefault("TrackerCondition",function()
	return {
		Friendly=true,
		Hostile=true,
		Neutral=true,
		EnableExtraModule=true,
		HideWhenConflict=true,
		ConditionType="1",
		Arg="Player",
		Profile="Default",
		Group=1,
	}
end)
NPA.SettingManager.RegisterDefault("TrackerNameplates",function()
	return {
		PosX=0,
		PosY=0,
		Alpha=1,
		Scale=1,
		FrameLevel=1,
		Group=1,
		Index=1,
		TrackTime=10,
	}
end)
