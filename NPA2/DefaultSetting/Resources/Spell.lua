-- Author      : Nogarder
-- Create Date : 2012/12/17 9:01:26
NPA.SettingManager.RegisterDefault("Spell",function()
	--default bar
	return {
		NewName="",
		School=1,
		NewIcon="",
		CastTime=5,
		MinRange=5,
		MaxRange=40,
		CoolDown=20,
		CoolDownStack=0,
		CoolDownType=0, --0=cd on use 1=cd on lost
		Length=10,
		MaxStack=0,
		SpellType="None",
		DispelAble=false,
		PVPLength=5,
		PVPDRType="None",
		CounterSpellLength=0,
		Catalog="Unsorted",
		NoDR=false,
		IsShield=false,
		AffectSpellList={
			CheckWithSubString=1,
			IndexIsNumber=true,
			[1]={
				AffectType=0, --0=reduce cooldown 1=extend cooldown ,2=reduce duration,3=extend duration , 4= suppress ,5=related
				AffectAmount=0, --0=all,
			},
		}
	}
end)