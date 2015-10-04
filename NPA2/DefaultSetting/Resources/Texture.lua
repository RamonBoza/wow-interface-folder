-- Author      : Nogarder
-- Create Date : 2012/7/13 15:57:40
NPA.SettingManager.RegisterDefault("AnimatedTexture",function()
	return {
		Color={		R=1,		G=1,		B=1, A=1},
		Texture="Interface\\TargetingFrame\\UI-RaidTargetingIcons",
		Mode="BLEND",
		Top=0,
		Left=0,
		Bottom=1,
		Right=1,
		RAngle=0,
		Time=1, --0.01s
	}
end)

NPA.SettingManager.RegisterDefault("Texture",function()
	--default
	local setting={
		["Default"]={
			Color={
				R=1,
				G=1,
				B=1,
				A=1,
			},
			Texture="Interface\\TargetingFrame\\UI-StatusBar",
			Mode="BLEND",
			Top=0,
			Bottom=1,
			Left=0,
			Right=1,
			RAngle=0,
		}
	}
	--classicon
	for class,coord in pairs(CLASS_ICON_TCOORDS) do
		setting["PlayerClassIcon_"..class]={
			Color={
				R=1,
				G=1,
				B=1,
				A=1
			},
			Texture="Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",
			Mode="BLEND",
			Top=coord[3],
			Bottom=coord[4],
			Left=coord[1],
			Right=coord[2],
			RAngle=0,
		}
	end
	--raid icon
	--1 = Yellow 4-point Star 
	--2 = Orange Circle 
	--3 = Purple Diamond 
	--4 = Green Triangle 
	--5 = White Crescent Moon 
	--6 = Blue Square 
	--7 = Red "X" Cross 
	--8 = White Skull
	setting["RaidTarget1_YellowStar"]={
		Color={		R=1,		G=1,		B=1,A=1},
		Texture="Interface\\TargetingFrame\\UI-RaidTargetingIcons",
		Mode="BLEND",
		Top=0,
		Left=0,
		Bottom=0.25,
		Right=0.25,
		RAngle=0,
	}
	setting["RaidTarget2_OrangeCircle"]={
		Color={		R=1,		G=1,		B=1,A=1},
		Texture="Interface\\TargetingFrame\\UI-RaidTargetingIcons",
		Mode="BLEND",
		Top=0,
		Left=0.25,
		Bottom=0.25,
		Right=0.5,
		RAngle=0,
	}

	setting["RaidTarget3_PurpleDiamond"]={
		Color={		R=1,		G=1,		B=1,A=1},
		Texture="Interface\\TargetingFrame\\UI-RaidTargetingIcons",
		Mode="BLEND",
		Top=0,
		Left=0.5,
		Bottom=0.25,
		Right=0.75,
		RAngle=0,
	}

	setting["RaidTarget4_GreenTriangle"]={
		Color={		R=1,		G=1,		B=1,A=1},
		Texture="Interface\\TargetingFrame\\UI-RaidTargetingIcons",
		Mode="BLEND",
		Top=0,
		Left=0.75,
		Bottom=0.25,
		Right=1,
		RAngle=0,
	}

	setting["RaidTarget5_SilverMoon"]={
		Color={		R=1,		G=1,		B=1,A=1},
		Texture="Interface\\TargetingFrame\\UI-RaidTargetingIcons",
		Mode="BLEND",
		Top=0.25,
		Left=0,
		Bottom=0.5,
		Right=0.25,
		RAngle=0,
	}

	setting["RaidTarget6_BlueSquare"]={
		Color={		R=1,		G=1,		B=1,A=1},
		Texture="Interface\\TargetingFrame\\UI-RaidTargetingIcons",
		Mode="BLEND",
		Top=0.25,
		Left=0.25,
		Bottom=0.5,
		Right=0.5,
		RAngle=0,
	}

	setting["RaidTarget7_RedCross"]={
		Color={		R=1,		G=1,		B=1,A=1},
		Texture="Interface\\TargetingFrame\\UI-RaidTargetingIcons",
		Mode="BLEND",
		Top=0.25,
		Left=0.5,
		Bottom=0.5,
		Right=0.75,
		RAngle=0,
	}

	setting["RaidTarget8_WhiteSkull"]={
		Color={		R=1,		G=1,		B=1,A=1},
		Texture="Interface\\TargetingFrame\\UI-RaidTargetingIcons",
		Mode="BLEND",
		Top=0.25,
		Left=0.75,
		Bottom=0.5,
		Right=1,
		RAngle=0,
	}

	--role
	setting["Role_Tank"]={
		Color={		R=1,		G=1,		B=1,A=1},
		Texture="Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES",
		Mode="BLEND",
		Top=0.33,
		Left=0,
		Bottom=0.63,
		Right=0.3,
		RAngle=0,
	}
	setting["Role_Damager"]={
		Color={		R=1,		G=1,		B=1,A=1},
		Texture="Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES",
		Mode="BLEND",
		Top=0.33,
		Left=0.3,
		Bottom=0.63,
		Right=0.6,
		RAngle=0,
	}
	setting["Role_Healer"]={
		Color={		R=1,		G=1,		B=1,A=1},
		Texture="Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES",
		Mode="BLEND",
		Top=0,
		Left=0.3,
		Bottom=0.3,
		Right=0.6,
		RAngle=0,
	}
	setting["Role_None"]={
		Color={		R=1,		G=1,		B=1,A=1},
		Texture="",
		Mode="BLEND",
		Top=0,
		Left=0,
		Bottom=1,
		Right=1,
		RAngle=0,
	}

	return setting
end)