-- Author      : Nogarder
-- Create Date : 2012/12/11 10:25:22
NPA.SettingManager.RegisterDefault("NamePlateIconGroup",function()
	return {
		DataType="Aura",
		AnchorFrame="MainFrame",
		FrameLevel=1,
		--
		Scale=1,
		Alpha=1,
		--
		FrameAnchorData={
			From="CENTER",
			To="CENTER",
			OffsetX=0,
			OffsetY=0,
		},
		PerRow=6,
		Max=12,
		Direction=1,
		TimeLimit=60,
		GapX=2,
		GapY=2,
		StackMin=0,
		StackMax=1000,
		--
		DataRules={
			CheckWithSubString="Debuff", --used for setting manager only, means check with one default
			["Debuff"]={
				FilterType=2, -- 1 =buff, 2=debuff,3 =spell list, 4=school list
				SpellList={
					DontCheck=true --means don't check values in this table
				},
				SchoolList={
					["None"]=true,
					["Bleed"]=true,
					["Enrage"]=true,
					["Magic"]=true,
					["Poison"]=true,
					["Curse"]=true,
				},
				Priority=1,
				FromType=1, --1= everyone, 2=me
				Scale=1,
				Alpha=1,
				FrameLevel=1,
				Width=10,
				Height=10,
				--modules
				Modules={
					CheckWithSubString="Icon",
					["Icon"]={
						ModuleType="Icon", --icon, bargroup, texture,text, number
						DataType="Stack",
						Width=10,
						Height=10,
						ProfileName=" ",
						AnchorData={
							From="CENTER",
							To="CENTER",
							OffsetX=0,
							OffsetY=0,
						},
						Alpha=1,
						Scale=1,
						FrameLevel=1,
						ColorMode=0, --0=by setting, 1=by school
					}
				}
			},
		}
	}
end)
