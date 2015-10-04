-- Author      : Nogarder
-- Create Date : 2012/12/27 15:45:23
local pairs=pairs
local table_getn=table.getn
--
--note: highlight is not working ,blizzard did something to it

NPA.NamePlateModuleManager.RegisterModule("Default",function(framedata,profile)
	local default=framedata.Default
	if((not default) or (not profile))then
		return
	end
	--
	local setting=profile.DefaultSetting
	local parent=framedata.Parent
	--
	for name,region in pairs(default)do
		local aprofile=setting[name]
		if(aprofile)then
			--must clear points
			region:ClearAllPoints()
			--
			if(aprofile.Enable)then
				region:SetWidth(aprofile.Width)
				region:SetHeight(aprofile.Height)
				--
				local objtype=region:GetObjectType()
				if(objtype=="StatusBar")then
					region:SetStatusBarTexture(aprofile.Texture)
				elseif(objtype=="Texture")then
					region:SetTexture(aprofile.Texture)
				elseif(objtype=="FontString")then
					region:SetFont(aprofile.Font,aprofile.Height)
				end
				region:SetPoint(aprofile.Anchor,parent,aprofile.AnchorTo,aprofile.OffsetX,aprofile.OffsetY)
			else
				--set it out of screen so it won't be visible
				region:SetPoint("TOP",UIParent,"BOTTOM",0,-100)
				--set size to 0.1 it will not show but count as shown
				--dont need to set size
				--region:SetWidth(0.1)
				--region:SetHeight(0.1)
				--dont hide it ,some may need it shown
				--region:Hide()
			end
		end
	end
end)