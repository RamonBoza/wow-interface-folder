-- Author      : Nogarder
-- Create Date : 2013/12/11 18:54:11

NPA.SettingManager.RegisterDefault("Role",function()
	local setting={}
	--
	setting["TANK"]="Role_Tank"
	setting["HEALER"]="Role_Healer"
	setting["DAMAGER"]="Role_Damager"
	setting["NONE"]="Role_None"

	return setting
end)
