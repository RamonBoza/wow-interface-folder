-- Author      : Nogarder
-- Create Date : 2012/7/27 10:54:27
NPA.SettingManager.RegisterDefault("Color",function()
	local setting={}
	--threat
	setting["Threat"]={}
	for i=0,3 do
		local r,g,b=GetThreatStatusColor(i)
		setting["Threat"][i]={R=r,G=g,B=b,A=1}
	end
	setting["Threat"][4]={R=1,G=1,B=1,A=1}
	--faction
	setting["Faction"]={
		[1]={ --friendly
			R=0,
			G=1,
			B=0,
			A=1,
		},
		[2]={ --netural
			R=1,
			G=1,
			B=0,
			A=1,
		},
		[3]={ --hostile
			R=1,
			G=0,
			B=0,
			A=1,
		},
	}
	--spell school
	setting["SpellSchool"]={
		[1]={R=1,G=1,B=0,A=1}, --physical
		[2]={R=1,G=1,B=0.5,A=1}, --holy
		[4]={R=1,G=0.3,B=0,A=1}, --fire
		[8]={R=0.25,G=1,B=0.25,A=1}, --nature
		[16]={R=0.5,G=1,B=1,A=1},--frost
		[32]={R=0.5,G=0.5,B=1,A=1},--shadow
		[64]={R=1,G=0.5,B=1,A=1}--arcane
	}
	setting["SpellType"]={
		["Magic"]={R=0,G=0,B=1,A=1},
		["Poison"]={R=0,G=1,B=0,A=1},
		["Curse"]={R=1,G=0,B=1,A=1},
		["Disease"]={R=0.6,G=0.6,B=0,A=1},
		["Enrage"]={R=1,G=0,B=0,A=1}, --hopefully blizzard fixed this, it was ""
		["Bleed"]={R=1,G=1,B=0,A=1},
		["None"]={R=1,G=1,B=1,A=1} -- none=physic 
	}
	--power
	--	-2	health 
	--0	mana 
	--1	rage 
	--2	focus 
	--3	energy 
	--4	pet happiness 
	--5	runes 
	--6	runic power 
	--7	soul shard 
	--8	eclipse energy (solar is negative, lunar is positive) 
	--9	holy power
	setting["Power"]={
		[0]={R=0,G=0,B=1,A=1}, --mana
		[1]={R=1,G=0,B=0,A=1}, --rage
		[2]={R=0.9,G=0.5,B=0.2,A=1}, --focus
		[3]={R=1,G=1,B=0,A=1}, --energy
		[6]={R=0,G=0.8,B=0.9,A=1} --runic power
	}
	return setting
end)

