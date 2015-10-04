-- Author      : Nogarder
-- Create Date : 2013/9/8 16:59:56

NPA.SettingManager.RegisterDefault("SelfLib",function()
	local setting={}
	--
	setting.Color={ --red
			R=1,
			G=0,
			B=0,
			A=1,
		}

	setting.Text="-->You<--"

	return setting
end)
