-- Author      : Nogarder
-- Create Date : 2014/5/28 8:25:58

NPA.SettingManager.RegisterDefault("Unit",function()
	local setting={}
	--player
	setting.Name={
		["mouseover"]="mouseover",
		["target"]="target",
		["focus"]="focus",
		["party"]="party",
		["raid"]="raid",
		["arena"]="arena",
	}

	setting.Priority={
		["mouseover"]=1,
		["target"]=2,
		["focus"]=3,
		["party"]=4,
		["raid"]=5,
		["arena"]=6,
	}
	
	
	return setting
end)