-- Author      : Nogarder
-- Create Date : 2012/12/27 16:03:27
NPA.SettingManager.RegisterDefault("NamePlateDefault",function()
	return {
		--default healthbar anchored to default main frame
		["HealthBar"]={
			Enable=true,
			Width=105,
			Height=10,
			Anchor="BOTTOMLEFT",
			AnchorTo="BOTTOMLEFT",
			OffsetX=4,
			OffsetY=5,
			Texture="Interface\\TargetingFrame\\UI-TargetingFrame-BarFill",
		},
		--default threatglow anchored to default main frame
		["ThreatGlow"]={
			Enable=true,
			Width=143,
			Height=40,
			Anchor="BOTTOMLEFT",
			AnchorTo="BOTTOMLEFT",
			OffsetX=-8,
			OffsetY=-13,
			Texture="Interface\\TargetingFrame\\UI-TargetingFrame-Flash",
		},
		--default overlay anchored to default main frame
		["Overlay"]={
			Enable=true,
			Width=130,
			Height=36,
			Anchor="TOPLEFT",
			AnchorTo="TOPLEFT",
			OffsetX=0,
			OffsetY=0,
			Texture="Interface\\Tooltips\\Nameplate-Border",
		},
		--in 5.1 blizzard broke overlay texture by setting texture to nil, no idea why
		--default highlight anchored to default main frame
		["Highlight"]={
			Enable=true,
			Width=130,
			Height=36,
			Anchor="TOPLEFT",
			AnchorTo="TOPLEFT",
			OffsetX=0,
			OffsetY=0,
			Texture="",
		},
		--default nametext anchored to default main frame
		["NameText"]={
			Enable=true,
			Width=0,
			Height=13,
			Anchor="BOTTOM",
			AnchorTo="CENTER",
			OffsetX=0,
			OffsetY=0,
			Font=GameFontNormal:GetFont(),
		},
		--default highlight anchored to default main frame
		["LevelText"]={
			Enable=true,
			Width=0,
			Height=13,
			Anchor="CENTER",
			AnchorTo="BOTTOMRIGHT",
			OffsetX=-12,
			OffsetY=10,
			Font=GameFontNormal:GetFont(),
		},
		--default bossicon is anchored to center of level text
		--using same anchor setting as level text should do the same
		["BossIcon"]={
			Enable=true,
			Width=14,
			Height=14,
			Anchor="CENTER",
			AnchorTo="BOTTOMRIGHT",
			OffsetX=-12,
			OffsetY=10,
			Texture="Interface\\TargetingFrame\\UI-TargetingFrame-Skull",
		},
		--default raidicon is anchored to overlay region
		--using caculated offset at main frame
		["RaidIcon"]={
			Enable=true,
			Width=29,
			Height=29,
			Anchor="RIGHT",
			AnchorTo="TOPLEFT",
			OffsetX=0,
			OffsetY=-18,
			Texture="Interface\\TargetingFrame\\UI-RaidTargetingIcons",
		},
		--default eliteicon is anchored to center of leveltext 
		--using same anchor setting as level text 
		["EliteIcon"]={
			Enable=true,
			Width=43,
			Height=31,
			Anchor="CENTER",
			AnchorTo="BOTTOMRIGHT",
			OffsetX=-8,
			OffsetY=9,
			Texture="Interface\\Tooltips\\EliteNameplateicon",
		},
		--default castbar overlay anchored to default main frame
		--it's using same texture as overlay
		["CastBarOverlay"]={
			Enable=true,
			Width=130,
			Height=36,
			Anchor="CENTER",
			AnchorTo="CENTER",
			OffsetX=0,
			OffsetY=-18,
			Texture="Interface\\Tooltips\\Nameplate-Border",
		},
		--default castbar anchored to castbar overlay
		--using caculated anchor on mainframe
		["CastBar"]={
			Enable=true,
			Width=105,
			Height=10,
			Anchor="BOTTOMRIGHT",
			AnchorTo="CENTER",
			OffsetX=60,
			OffsetY=-5,
			Texture="Interface\\TargetingFrame\\UI-TargetingFrame-BarFill",
		},
		--default castbarshield anchored to castbar overlay
		--using caculated anchor on mainframe
		["CastBarShield"]={
			Enable=true,
			Width=130,
			Height=36,
			Anchor="CENTER",
			AnchorTo="CENTER",
			OffsetX=60,
			OffsetY=-36,
			Texture="Interface\\Tooltips\\Nameplate-CastBar-Shiled",
		},
		--default spell icon anchored to castbar overlay
		--using caculated anchor on mainframe
		["SpellIcon"]={
			Enable=true,
			Width="15",
			Height="15",
			Anchor="CENTER",
			AnchorTo="CENTER",
			OffsetX=-52,
			OffsetY=10,
		}
	}
end)
