-- Author      : Nogarder
-- Create Date : 2013/4/20 16:50:23
NPA.SettingManager.RegisterDefault("CombatTextCondition",function()
	return {
		--1=player 2=target 3=focus 4=mouseover ,64=hostile 32=neutral, 16=friendly
		From=0,
		To=0,
		FromName="",
		FromExact=false,
		ToName="",
		ToExact=false,
		CritType=0, -- 0=both, 1=crit 2=non-crit
		MultiStrikeType=0, --0=both,1=multistrike,2=non-multistrike
		IconSize=20,
		TextWidth=0,
		TextHeight=20,
		TextType=2,
		TextFileName="Default",
		NumberType=1,
		DetailWidth=0,
		DetailHeight=20,
		DetailFileName="Default",
		BGWidth=10,
		BGHeight=10,
		BGFileName="Default",
		IgnoreOverkill=false,
		BGColor={
			R=1,
			G=1,
			B=1,
			A=1,
		},
		OffsetX=0,
		OffsetY=0,
		FreeFloat=false,
		HideWithParent=true,
		EventList={
			["SWING_DAMAGE"]=true,
			["SWING_MISSED"]=true,
			["SWING_EXTRA_ATTACKS"]=true,
			--range type
			["RANGE_DAMAGE"]=true,
			["RANGE_MISSED"]=true,
			["RANGE_EXTRA_ATTACKS"]=true,
			--spell damage type
			["SPELL_DAMAGE"]=true,
			["SPELL_PERIODIC_DAMAGE"]=true,
			["SPELL_MISSED"]=true,
			["SPELL_DISPEL_FAILED"]=true, --dispel fail
			----damage shield type --don't use these yet
			--["SPELL_DAMAGE_SHIELD_DAMAGE"]=true,
			--["SPELL_DAMAGE_SPLIT_DAMAGE"]=true,
			--["SPELL_DAMAGE_SHIELD_MISSED"]=true,
			--aura apply type
			["SPELL_AURA_APPLIED"]=true,
			["SPELL_AURA_APPLIED_DOSE"]=true,
			--aura remove type
			["SPELL_AURA_REMOVED"]=true,
			["SPELL_AURA_REMOVED_DOSE"]=true,
			["SPELL_AURA_BROKEN"]=true, --removed by melee --usually cc spell
			["SPELL_AURA_BROKEN_SPELL"]=true, --removed by spell
			["SPELL_STOLEN"]=true, --stolen for mage
			["SPELL_DISPEL"]=true,
			--energy type
			["SPELL_ENERGIZE"]=true, --get energy by spell
			["SPELL_DRAIN"]=true, --cause target to lose energy by spell
			["SPELL_LEECH"]=true, --cause target to lose energy ,and get energy for self, by spell
			--inturrpt type
			["SPELL_INTERRUPT"]=true, --get interrupt by spell
			--summon type
			["SPELL_CREATE"]=true, --create something 
			["SPELL_SUMMON"]=true, --summon, like pet, tottem,etc
			["SPELL_RESURRECT"]=true, --resurrect someone
			--special type
			["UNIT_DIED"]=true, --unit just died
			["UNIT_DESTROYED"]=true, --happens to old tottem when new tottem is summoned 
			["ENVIRONMENTAL_DAMAGE"]=true, --environmental damage,
			 --heal type
			["SPELL_HEAL"]=true,
			["SPELL_PERIODIC_HEAL"]=true,
			--cast type
			["SPELL_CAST_START"]=true,
			["SPELL_CAST_SUCCESS"]=false,
			["SPELL_CAST_FAILED"]=true,
			--absorb type
			["SPELL_ABSORBED"]=true
		},
		SpecialEventList={
			["CC_DR_STARTED"]=false,
			["CC_DR_ENDED"]=false,
			["COOLDOWN_STARTED"]=false,
			["COOLDOWN_ENDED"]=false,
		},
		--
		AnimationName="None",
		SpellListType=0, --0=disable, 1=include, 2=exclude
		SpellList={
			DontCheck=true
		}
	}
end)
NPA.SettingManager.RegisterDefault("CombatTextAnimation",function()
	return {
		SpeedType=1, --0=fixed ,1=topleft 2=topright 3=bottomleft 4=bottomright 5=top  6=bottom 7=left 8=right
		SpeedX=20,
		SpeedY=20,
		AccType=1, --0=fixed ,1=topleft 2=topright 3=bottomleft 4=bottomright 5=top  6=bottom 7=left 8=right
		AccX=20,
		AccY=20,
		StartAlpha=1,
		EndAlpha=1,
		StartSize=1,
		EndSize=1,
		ShakeRange=0,
		Lasts=2,
		FrameLevel=1,
	}
end)
