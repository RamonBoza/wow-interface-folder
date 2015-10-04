-- Author      : Nogarder
-- Create Date : 2012/8/31 7:02:23
NPA.SettingManager.RegisterDefault("Class",function()
	local setting={}
	--player
	local pairs=pairs
	local CLASS_ICON_TCOORDS=CLASS_ICON_TCOORDS
	local RAID_CLASS_COLORS=RAID_CLASS_COLORS
	--
	for class,_ in pairs(CLASS_ICON_TCOORDS) do
		local color=RAID_CLASS_COLORS[class]
		setting[class]={
			ProfileName="PlayerClassIcon_"..class, -- this is handled in textures
			Color={
				R=color.r,
				G=color.g,
				B=color.b,
				A=1
			}
		}
	end
	--placeholder
	--creature
	--totem
	--vendor
	return setting
end)