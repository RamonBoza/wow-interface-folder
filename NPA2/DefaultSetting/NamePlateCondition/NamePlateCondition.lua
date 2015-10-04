-- Author      : Nogarder
-- Create Date : 2013/4/18 12:51:06
--conditiontype=
--"Default"=using system alpha
--"Name"
--"UnitID"
--"Target"
--"Summoned"
--"Player"
--etc.
NPA.SettingManager.RegisterDefault("NamePlateCondition",function()
	return {
		ConditionType="Any",
		Arg="",
		Profile="Default",
	}
end)
