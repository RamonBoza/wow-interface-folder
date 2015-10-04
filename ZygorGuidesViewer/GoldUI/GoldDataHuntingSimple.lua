
tinsert(ZGV.startups,function(self)

	if not ZGV.db.profile.load_gold then return end

	do return end --actually.

	ZGV.Gold.chores:AddChore{typ="route",name="Route Silverleaf",items={[765]=150},time=30,reqs={herbalism=1}}
	ZGV.Gold.chores:AddChore{typ="route",name="Route Peacebloom",items={[2447]=200},time=20,reqs={herbalism=1}}
	ZGV.Gold.chores:AddChore{typ="route",name="Route Fool's Cap",items={[79011]=180},time=25,reqs={herbalism=600,level=87}}
	ZGV.Gold.chores:AddChore{typ="route",name="Route Pandaria Herbs",items={[79011]=100,[79010]=60,[72235]=90},time=45,reqs={herbalism=400,level=87}}

	ZGV.Gold.chores:AddChore{typ="route",name="Hyjal Elementals",
		route={ map="Mount Hyjal", points={15.9,46.2,  18.0,55.5,  20.5,59.4,  23.3,59.9,  24.8,60.5,  32.5,63.6,  32.6,58.7,  34.7,57.0,  39.7,53.2,  38.1,51.0,  35.9,51.7} },
		mobs={"Flame Terror##52219","Brimstone Destroyer##52794"},
		mobslevel=85,
		mobsavoid={"Charred Flamewalker##52791"},
		items={["Volatile Fire##52325"]=114,["Crackling Crystals##60485"]=276,["Shimmering Shards##60486"]=96},
		reqs=nil,
		}

	ZGV.Gold.chores:AddChore{typ="route",name="Twilight Elementals",
		route={ map="Twilight Highlands", points={70.9,50.3,    69.8,47.8,    67.7,44.7,  65.2,41.5,    63.1,41.5,    63.5,44.1,  65.8,46.9,    67.1,51.2} },
	        mobs={"Muddied Water Elemental##44011"},
		mobslevel=84,
		items={["Volatile Water##52326"]=66,["Crackling Crystals##60485"]=360,["Shimmering Shards##60486"]=78}--,["Elementium Lockbox##68729"]=6}
		}

	ZGV.Gold.chores:AddChore{typ="route",name="Uldum Elementals",
		route={ map="Uldum", points={43.9,36.9,    41.4,38.1,    39.9,39.6,  39.5,38.3,    39.5,41.9,    38.5,43.6,  38.0,45.1,    39.3,44.0,    39.8,46.7,  40.4,44.9,    42.1,43.0,    40.9,42.5,  42.0,42.5,    41.8,40.6, } },
		mobs={"Scion of Al'Akir##45755"},
		mobslevel=83,
		items={["Volatile Air##52328"]=66,["Crackling Crystals##60485"]=336,["Shimmering Shards##60486"]=30}
	}


	--[[
	Right now, this is a mess.
	The Chores below are separate from the Guides listed even further down... and they should be combined, at some point.
	--]]

	ZGV.Gold.chores:AddChore{typ="route",name="Volatile Fire",
		route={ map="Mount Hyjal", points={15.9,46.2,  18.0,55.5,  20.5,59.4,  23.3,59.9,  24.8,60.5,  32.5,63.6,  32.6,58.7,  34.7,57.0,  39.7,53.2,  38.1,51.0,  35.9,51.7} },
		-- .from Flame Terror##52219+
		-- .from Brimstone Destroyer##52794+ |tip Avoid Charred Flamewalker##52791
		items={["Volatile Fire##52325"]=114,["Crackling Crystals##60485"]=276,["Shimmering Shards##60486"]=96},
		mobslevel=85,
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Volatile Water",
		route={ map="Twilight Highlands/0", points={70.9,50.3,  69.8,47.8,  67.7,44.7,  65.2,41.5,  63.1,41.5,  63.5,44.1,  65.8,46.9,  67.1,51.2} },
		-- .from Muddied Water Elemental##44011+
		items={["Volatile Water##52326"]=66,["Crackling Crystals##60485"]=360,["Shimmering Shards##60486"]=78},--["Flamewashed Mace##62067"]=(1),["Wolk\'s Blunted Shiv##62066"]=(2),["Figurine - King of Boars##65895"]=(1),["Elementium Lockbox##68729"]=(1)},
		mobslevel=84,
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Volatile Air",
		route={ map="Uldum/0 ", points={43.9,36.9,  41.4,38.1,  39.9,39.6,  39.5,38.3,  39.5,41.9,  38.5,43.6,  38.0,45.1,  39.3,44.0,  39.8,46.7,  40.4,44.9,  42.1,43.0,  40.9,42.5,  42.0,42.5,  41.8,40.6} },
		-- .from Scion of Al\'Akir##45755+
		items={["Shimmering Shards##60486"]=30,["Crackling Crystals##60485"]=336,["Volatile Air##52328"]=66},--["Pockmarked Cloth Vest##62091"]=(1),["Clammy Mail Boots##62083"]=(1),["Figurine - Earthen Guardian##65897"]=(1),["Figurine - King of Boars##65895"]=(1)},
		mobslevel=83,
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Volatile Earth",
		route={ map="Twilight Highlands", points={58.3,29.8,  57.2,29.8,  56.9,32.0,  58.5,32.4,  58.8,31.1} },
		-- .from Obsidian Stoneslave##47226+
		items={["Volatile Earth##52327"]=84,["Crackling Crystals##60485"]=252,["Shimmering Shards##60486"]=102},
		mobslevel=84,
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Runecloth",
		route={ map="Silithus", points={44.5,38.0,  46.5,40.4,  44.9,44.7,  42.9,41.4,  34.2,33.7,  31.6,32.1,  32.9,30.1,  35.2,29.9} },
		-- .from Twilight Avenger##11880+
		-- .from Twilight Geolord##11881+ |tip AVOID Twilight Stonecaller##11882+
		items={["Runecloth##14047"]=330,["Roasted Quail##8952"]=84},
		mobslevel={54,55}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Felcloth",
		route={ map="Blasted Lands ", points={40.8,66.0,  38.8,65.7,  36.8,68.9,  35.6,65.6,  32.8,64.3,  32.8,67.8,  34.3,70.7,  35.9,70.0,  36.6,72.4,  32.7,75.0,  36.5,75.4,  39.8,75.3,  40.7,71.0} },
		-- .from Doomguard Destroyer##41470
		-- .from Dreadlord Defiler##41471 
		--|tip AVOID Corrupted Darkwood Treant##45119+, Felspore Bog Lord##45125+
		items={["Corroded Skull##62276"]=84,["Broken Horn##68731"]=306,["Felcloth##14256"]=18},--["Smooth Leather Armor##3976"]=(1),["Spiked Dagger##13822"]=(1),["Jagged Axe##13818"]=(1)},
		mobslevel={58,59}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Linen Cloth,Wool Cloth",
		--goto Wetlands/0 67.3,47.3
		-- .from Dragonmaw Whelpstealer##42041+
		-- .from Ebon Slavehunter##42043+
		items={["Linen Cloth##2589"]=708,["Wool Cloth##2592"]=522,["Healing Potion##929"]=30,["Melon Juice##1205"]=45,["Mutton Chop##3770"]=80},
		mobslevel={24,25}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Silk Cloth",
		route={ map="Thousand Needles", points={10.7,9.2,  11.6,9.4, 13.7,7.9,  12.6,4.9} },
		-- .from Grimtotem Pillager##39947+
		items={["Silk Cloth##4306"]=402,["Mageweave Cloth##4338"]=49,["Mulgore Spice Bread##4544"]=30,["Greater Healing Potion##1710"]=12,["Mana Potion##3827"]=12,["Sweet Nectar##1708"]=18},
		mobslevel={39,40}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Righteous Orb, Mageweave Cloth",
		--goto Stratholme/1 33.4,33.0
		-- .from Risen Guardsman##10418+, Risen Initiate##10420+, Risen Defender##10421+, Risen Sorcerer##10422+, Willey Hopebreaker##10997+, Risen Gallant##10424+, Risen Inquisitor##10426+, Risen Monk##11043+, Instructor Galford##10811+
		items={["Mageweave Cloth##4338"]=822,["Fine Aged Cheddar##3927"]=216,["Righteous Orb##12811"]=18,["Superior Healing Potion##3928"]=162,["Raw Black Truffle##4608"]=288,["Moonberry Juice##1645"]=150,["Greater Mana Potion##6149"]=36,["Runecloth##14047"]=24},--["Tome of Knowledge##13385"]=(1),["Crochet Cloak##3939"]=(2),["Crochet Belt##3936"]=(1),["Ichor of Undeath##7972 "]=(1),["Whetted Claymore##4018"]=(1),["Thick Leather Belt##3961"]=(1),["Mistscape Pants##4046"]=(1),["Overlinked Chain Shoulderpads##4006"]=(1),["Balanced Long Bow##4025"]=(1),["Archivist Cape##13386"]=(1),["Master Cannoneer Boots##13381"]=(1),["Willey's Back Scratcher##22404"]=(1),["Heavy Flint Axe##4019"]=(1),["Aquamarine##7909"]=(2),["Plans: Heartseeker##12839"]=(1),["Battlefield Destroyer##8199"]=(1),["Fine Pointed Dagger##4023"]=(1),["Champion's Gauntlets##7541"]=(1),["Helm of the New Moon##22407"]=(1),["Diamond-Tip Bludgeon##15227"]=(1),["Splintering Battle Axe##4020"]=(1),["Barrage Girdle##18721"]=(1),["Onyx Choker##12032"]=(1)},
		mobslevel={45,46,"ELITE"}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Frostweave Cloth",
		--goto Icecrown/0 43.3,78.4
		-- .from Chosen Zealot##32175+ |tip These have a slightly increased respawn rate. However, they are the best for farming frostweave as they have a high drop rate and 24 spawn at once.
		items={["Frostweave Cloth##33470"]=330,["Fur Clothing Scraps##43851"]=240,["Thick Fur Clothing Scraps##43852"]=180},
		mobslevel=80,
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Netherweave Cloth",
		route={ map="Shadowmoon Valley/0 ", points={51.1,58.8,  53.0,59.3,  53.2,60.5,  52.8,63.2,  52.8,65.4,  52.9,69.0,  52.5,71.8,  47.3,71.1,  45.8,71.3,  45.2,69.2,  45.6,66.1,  48.0,67.2} },
		-- .from Illidari Watcher##22093+
		-- .from Eclipsion Cavalier##22018+
		-- .from Eclipsion Soldier##22016+
		-- .from Eclipsion Spellbinder##22017+
		-- .from Eclipsion Blood Knight##19795+
		-- .from Eclipsion Bloodwarder##19806+
		-- .from Eclipsion Archmage##19796+
		-- .from Eclipsion Centurion##19792+
		-- .from Val\'zareq the Conqueror##21979+
		--|tip AVOID Eclipsion Dragonhawk##20502+, Son of Corok##19824+
		items={["Sunfury Signet##30810"]=306,["Netherweave Cloth##21877"]=768,["Super Healing Potion##22829"]=18,["Crystal Fragments##29580"]=18,["Arcane Tome##29739"]=18,["Purified Draenic Water##27860"]=48,["Deteriorating Plate Bracers##25391"]=(1),["Scroll of Spirit VI##33460"]=(1),["Scroll of Protection VI##33459"]=(1),["Scroll of Strength VI##33462"]=(1)},
		mobslevel={68,70}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Windwool Cloth",
		route={ map="Krasarang Wilds", points={49.2,89.1,  47.5,91.5,  45.8,92.5,  44.6,90.8,  42.3,89.4,  42.7,87.6,  44.4,88.0,  46.7,89.2} },
		-- .from Unga Treasure-Hider##60357+
		-- .from Unga Fish-Getter##60299+
		-- .from Unga Villager##60358+
		items={["Windwool Cloth##72988"]=156,["Boiled Silkworm Pupa##81405"]=36,["Roasted Barley Tea##81406"]=36,["Four Wind Soju##81407"]=18,["Mote of Harmony##89112"]=24,["Jade Squash##74847"]=12,["Snowy Helm of the Tiger##82180"]=(1),["Snowy Sabatons of the Tiger##82183"]=(1),["Striped Melon##74848"]=12,["Mudsoaked Belt##9078"]=(1)},
		mobslevel=87,
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Iceweb Spider Silk",
		route={ map="Zul'Drak", points={36.2,57.9,  35.8,50.8,  35.1,47.9,  36.4,47.6,  38.2,53.6,  38.9,57.8} },
		-- .from Trapdoor Crawler##28221+
		items={["Iceweb Spider Silk##42253"]=108,["Drakkari Offerings##38551"]=120,["Icy Spinneret##44758"]=288,["Acid-Drenched Fangs##44759"]=78,["Frozen Bracers##33382"]=(1),["Jormungar Pauldrons##36353"]=(1),["Chipped Timber Axe##33426"]=(1)},
		mobslevel={75,76}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Viseclaw Meat",
		route={ map="Krasarang Wilds", points={52.3,47.5,  56.4,49.8,  57.4,43.9,  60.1,40.7,  54.3,44.5} },
		-- .from Flesh-Eating Sandsnapper##65823+
		-- .from Viseclaw Scuttler##58881+
		-- .from Viseclaw Fisher##58880+
		--#tip AVOID Elder Viseclaw##61091+
		items={["Viseclaw Meat##85506"]=126,["Shiny Carapace##82328"]=270,["Mote of Harmony##89112"]=(1),["Cheng's Irrepressible Girdle##87506"]=(1),["Raw Crab Meat##74838"]=78},
		mobslevel={86,87},
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Raw Crab Meat",
		--goto Dread Wastes/0 38.7,62.2
		-- .from Muck Sifter##65790+
		--|tip AVOID Brineshell Snapper##63981+, Muckscale Slayer##63999+
		items={["Mote of Harmony##89112"]=24,["Viseclaw Meat##85506"]=90,["Raw Crab Meat##74838"]=114,["Shiny Carapace##82328"]=96},
		mobslevel=90,
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Embersilk Cloth",
		route={ map="Deepholm", points={68.0,25.5,  68.9,24.7,  70.6,24.7,  72.6,26.9,  73.1,28.5,  74.6,27.7}, loop=false },
		-- .from Verlok Pillartumbler##43513+
		items={["Scavenged Animal Parts##68197"]=24,["Ruined Embersilk Scraps##68198"]=78,["Sparkling Oasis Water##58256"]=54,["Embersilk Cloth##53010"]=240,["Roasted Beef##58268"]=36,["Flamewashed Mace##62067"]=(1),["Clammy Mail Gloves##62073"]=(1),["Nethander Spellblade of the Sorcerer##55438"]=(1),["Mirkfallon Ring of the Galeburst##55419"]=(1),["Wolk's Blunted Shiv##62066"]=(1),["Nethander Crystal##55375"]=(1),["Rocktusk Shoulder##55690 "]=(1),["Brightwood Wristwraps##55708"]=(1),["Mereldar Ring of the Zephyr##55421"]=(1)},
		mobslevel=83,
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Clam Meat And Small Lustrous Pearl ",
		route={ map="Echo Isles/0", points={64.9,25.9,  67.2,18.3,  65.2,10.4,  59.4,9.3,  54.9,13.1,  56.7,23.7} },
		reqs={faction="Horde"},
		-- .from Spitescale Wavethrasher##38300+
		-- .from Spitescale Siren##38301+
		--.\' Follow the path, as well as enter the cave when you come across it.
		items={["Crawler Meat##2674"]=6,["Cracked Pincer##62514"]=6,["Clam Meat##5503"]=336,["Small Barnacled Clam##5523"]=336,["Small Brown Pouch##4496"]=(2),["Small Blue Pouch##828"]=(1),["Raw Slitherskin Mackerel##6303"]=(1),["Small Lustrous Pearl##5498"]=(2)},
		mobslevel={3,4}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Clam Meat (Alliance)/Small Lustrous Pearl (Alliance)/Murloc Fin (Both Factions)",
		--goto Redridge Mountains/0 71.8,56.1
		 --There will be one that spawns and patrols up on the ramp found here [71.8,57.8]
		-- .from Murloc Nightcrawler##544+
		-- When you kill all 6, 2 more will spawn instantly.
		items={["Thick Murloc Scale##5785"]=102,["Murloc Fin##1468"]=336,["Linen Cloth##2589"]=396,["Raw Longjaw Mud Snapper##6289"]=102,["Wool Cloth##2592"]=258,["Ice Cold Milk##1179"]=36,["Small Barnacled Clam##5523"]=306,["Clam Meat##5503"]=306,["Small Lustrous Pearl##5498"]=12,["Shadowgem##1210"]=12,["Lesser Healing Potion##858"]=24,["Patched Leather Boots##1788"]=(1),["Canvas Vest##1770"]=(1),["Stock Shortsword##1817"]=(1),["Northern Shortsword of Power##2078"]=(1),["Short-Handled Battle Axe##1812"]=(1),["Dirty Blunderbuss##2781"]=(1),["Patched Leather Bracers##1789"]=1,["Minor Mana Potion##2455"]=(1),["Sergeant's Warhammer##2079"]=(1),["Seer's Boots##2983"]=(1),["Patched Leather Boots##1788"]=(1),["Battered Mallet##1814"]=(1),["Patched Leather Gloves##1791"]=(1),["Soldier's Armor##6545"]=(1)},
		mobslevel={17,18}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Black Pearl/Iridescent Pearl/Golden Pearl/Zesty Clam Meat",
		route={ map="Blasted Lands/0 ", points={72.9,61.3,  71.3,63.2,  70.1,71.3,  67.5,75.2,  63.2,75.9,  60.3,77.9,  58.5,76.6,  59.0,73.2,  60.4,70.0,  61.4,63.2,  65.7,69.0,  68.6,63.2,  70.9,60.6} },
		-- .from Bloodwash Enchantress##41387+, Bloodwash Barbarian##41386+, Bloodwash Gambler##41404+, Bloodwash Idolater##41405+
		items={["Big-Mouth Clam##7973"]=264,["Zesty Clam Meat##7974"]=264,["Runecloth##14047"]=408,["Major Healing Potion##13446"]=18,["Raw Spinefin Halibut##8959"]=30,["Major Mana Potion##13444"]=6,["Golden Pearl##13926"]=6,["Black Pearl##Black Pearl"]=6,["Iridescent Pearl##5500"]=6,["Jagged Axe##13818 "]=(1),["Light Plate Helmet##8755"]=(1),["Imperfect Draenethyst Fragment##10593"]=(1),["Formula: Enchant Bracer - Superior Spiri##16218"]=(1),["Star Ruby##7910"]=(1),["Imbued Plate Vambraces##10375"]=(1)},
		mobslevel={56,57}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Small Egg",
		--goto Westfall/0 26.9,42.5
		-- .from Greater Fleshripper##154+
		items={["Small Egg##6889"]=372,["Severed Talon##5114"]=306,["Broken Wishbone##5115"]=162,
		["Gypsy Gloves##9755"]=1,
		["Gypsy Buckler of the Tiger##9753"]=1,
		["Calico Belt##3374"]=1,
		["Dwarven Hatchet of Agility##2073"]=1,
		["Warped Leather Bracers##1504"]=1,
		["Recipe: Cooked Crab Claw##2698"]=1,
		["Recipe: Westfall Stew##728"]=1,
		["Calico Pants##1499"]=1,
		["Tigerseye##818"]=1},
		mobslevel={12,13}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Stringy Wolf Meat",
		route={ map="Tirisfal Glades", points={86.0,39.5,  88.3,43.8,  90.2,47.9,  86.5,46.9,  81.2,47.0,  80.6,41.7} },
		-- .from Ravenous Darkhound##1549
		items={["Stringy Wolf Meat##2672"]=438,["Shed Fur##62328"]=270,["Fractured Canine##3299"]=12,
		["Worn Leather Pants##1423"]=1,
		["Cracked Sledge##1414"]=1,
		["Infantry Gauntlets##6510"]=1,
		["Patchwork Belt##3370"]=1,
		["Burnt Leather Belt##4666"]=1,
		["Malachite##774"]=1,
		["Crude Bastard Sword##1412"]=1,
		["Journeyman\'s Boots##2959"]=1},
		mobslevel={9,10}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Chunk Of Boar Meat",
		route={ map="Westfall", points={55.2,27.6,  57.0,31.3,  60.2,30.1,  62.5,24.1,  59.7,17.2,  56.9,16.5,  54.1,24.8} },
		-- .from Young Goretusk##454+
		-- .from Goretusk##157+
		items={["Chipped Boar Tusk##771"]=24,["Ruined Pelt##4865"]=132,["Goretusk Liver##723"]=126,["Boar Ribs##2677"]=18,["Chunk of Boar Meat##769"]=180,["Large Boar Tusk##2295"]=36,["Broken Barn Door##68724"]=18,["Tough Jerky##117"]=114,["Staunch Hammer of Intellect##4569"]=(1),["Tigerseye##818"]=(1),["Cracked Sledge##1414"]=(1),["Journeyman\'s Pants##2958"]=(1),["Old Greatsword##1513"]=(1),["Warped Leather Gloves##1506"]=(1),["Short Bastard Sword of the Eagle##3192"]=(1),["Worn Hatchet##1516"]=(1),["Patchwork Pants##1431"]=(1),["Patchwork Armor##1433"]=(1),["Simple Shoes##9743"]=(1)},
		mobslevel={10,13}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Raw Tiger Steak",
		route={ map="The Jade Forest", points={63.2,24.2,  62.8,25.8,  61.4,26.3,  61.7,24.6,  61.9,22.6} },
		-- .from Windward Tiger##63537+
		-- .from Windward Alpha##67085+
		--|tip AVOID Shadowfae Trickster##65635+
		items={["Raw Tiger Steak##74833"]=144,["Sharp Fangs##81194"]=204,["Mote of Harmony##89112"]=24,["Massive Fang##81212"]=(1),["Mountain Gauntlets of the Monkey##82188"]=(1)},
		mobslevel=90,
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Mushan Ribs",
		route={ map="Dread Wastes", points={44.3,22.6,  47.8,21.5,  49.8,18.7,  54.4,16.1}, follow="strict" },
		-- .from Frightened Mushan##62760+
		--|tip AVOID Amberscale Basilisk##66188+, Nagging Dreadling##65996+, Dread Lurker##62751+
		items={["Mushan Ribs##74834"]=96,["Enormous Tooth##81197"]=162,["Mote of Harmony##89112"]=18,["Shattered Bone Fragment##83157"]=24},
		mobslevel=90,
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Raw Turtle Meat",
		route={ map="The Jade Forest", points={65.4,34.2,  65.7,28.1,  66.8,27.0,  69.3,26.4,  69.3,30.7,  68.4,32.5} },
		-- .from Saltback Turtle##58218+
		-- .from Saltback Yearling##58219+
		--|tip AVOID Slitherscale Ripper##58212+, Slitherscale Eggdrinker##63532+
		items={["Turtle Shell##81201"]=216,["Raw Turtle Meat##74837"]=108,["Gleaming Turtle Shell##81217"]=18,["Temple Helm of the Bouldercrag##82290"]=(1)},
		mobslevel={87,90}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Wildfowl Breast",
		--goto Valley of the Four Winds/0 25.4,43.8
		-- .from Whitefisher Crane##56752+
		--|tip AVOID Emperor Tern##56751+
		items={["Soft Down Feather##81203"]=276,["Mote of Harmony##89112"]=24,["Wildfowl Breast##74839"]=102,["Ornamental Feather##81221"]=(1),["Steppe Greaves of the Marksman##82024"]=(1)},
		mobslevel=87,
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Raw Crocolisk Belly",
		--goto Dread Wastes/0 64.7,59.0
		-- .from Coldbite Crocolisk##62023+
		--|tip AVOID Nalash Verdantis##50776+, Lake Strider##66880+, Mistblade Ripper##61970+
		items={["Raw Crocolisk Belly##"]=108,["Crocolisk Tear##"]=156,["High Quality Crocolisk Leather##"]=(1)},
		mobslevel=90,
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Eternal Air/Crystallized Air",
		--goto Borean Tundra/0 44.1,9.0
		-- .from Enraged Tempest##25415+
		items={["Primordial Infusion##36810"]=354,["Crystallized Air##37700 (12 Eternal Air)"]=120,["Elemental Husk##36809"]=84},
		mobslevel={70,71}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Eternal Earth/Crystallized Earth",
		--goto Sholazar Basin/0 72.0,58.0
		-- .from Lifeblood Elemental##29124+
		items={["Efflorescing Shards##39513"]=90,["Hoary Crystals##39512"]=300,["Crystallized Earth##37701 (13 Eternal Earth)"]=138,["Tethys Sash of Arcane Protection##36011"]=(1),["Frost-Worn Plate Bracers##33414"]=(1)},
		mobslevel=76,
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Eternal Fire/Crystallized Fire",
		route={ map="The Storm Peaks", points={62.6,41.8,  62.3,40.8,  61.6,39.7,  61.2,39.5,  61.6,38.6,  61.7,39.4}, follow="strict" },
		-- .from Wailing Winds##30450+
		items={["Hoary Crystals##39512"]=330,["Crystallized Fire##37702 (15 Eternal Fire)"]=156,["Efflorescing Shards##39513"]=96},
		mobslevel={79,80}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Eternal Life/Crystallized Life",
		route={ map="Wintergrasp", points={11.6,60.0,  13.1,63.7,  10.4,64.7, 06.3,65.0,  5.2,59.0,  6.9,57.9} },
		-- .from Living Lasher##30845
		items={["Adamant Mallet of Agility##36497"]=(1),["Frigid Mail Belt##33398"]=(1),["Frigid Mail Bracers##33400"]=(1),["Revolting Flower##44775"]=30,["Ice-Piercing Thorn##44774"]=198,["Crystallized Life##37704 (15 Eternal Life)"]=156},
		mobslevel=80,
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Eternal Shadow/Crystallized Shadow",
		--goto Dragonblight/0 74.3,23.6 |n
		--.\' Enter the cave here |goto Dragonblight/0 74.3,23.6 |noway |c
		route={ map="Dragonblight", points={74.9,22.2,  75.6,20.9,  75.3,19.9,  74.6,20.5} },
		-- .from Deathbringer Revenant##27382+
		items={["Crystallized Shadow##37703 (15 Eternal Shadow)"]=150,["Primordial Infusion##36810"]=372,["Elemental Husk##36809"]=126,["Icesmashing Mace##33431"]=(1),["Ice-Bound Plate Bracers##33406"]=(1),["Bristlepine Handwraps of Intellect##35990"]=(1)},
		mobslevel={72,73}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Eternal Water/Crystallized Water",
		--goto Dragonblight/0 67.6,52.9
		-- .from Ice Revenant##26283+
		items={["Elemental Husk##36809"]=84,["Crystallized Water##37705"]=132,["Primordial Infusion##36810"]=354,["Thread-Bare Cloth Gloves##33361"]=(1),["Bristlepine Robe of Intellect##35989"]=(1)},
		mobslevel={72,73}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Mote Of Air",
		route={ map="Shadowmoon Valley", points={59.4,69.9,  61.1,68.4,  62.4,63.8,  68.7,67.7,  63.1,60.7,  64.4,56.5,  60.1,54.0,  59.0,59.8,  60.9,60.4,  58.7,66.0} },
		-- .from Enraged Air Spirit##21060+
		items={["Elemental Fragment##24508"]=144,["Mote of Air##22572"]=66,["Primordial Essence##24511"]=36},
		mobslevel={69,70}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Mote Of Earth",
		route={ map="Nagrand", points={24.4,71.8,  27.7,74.9,  28.5,78.4,  29.9,81.2,  34.7,82.0,  38.5,83.2,  41.0,85.4}, follow="strict" },
		-- .from Shattered Rumbler##17157+
		items={["Primordial Essence##24511"]=96,["Mote of Earth##22573"]=78,["Elemental Fragment##24508"]=300,["Battle Scythe of Strength##25233"]=(1),["Nobility Torch of the Whale##25291"]=(1),["Oshu'gun Crystal Powder Sample##26042"]=30,["Corroded Mace##25401"]=(1),["Essence of Earth##7076"]=(1)},
		mobslevel={66,67}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Mote Of Fire",
		route={ map="Hellfire Peninsula", points={57.4,22.4,  58.5,19.7,  60.5,20.1,  63.2,18.3,  65.4,17.9,  67.0,18.1,  67.1,19.9,  66.2,20.3,  63.8,20.4,  61.1,21.6} },
		-- .from Incandescent Fel Spark##22323+
		--|tip AVOID Wrath Herald##24919+, Felblood Initiate##24918+
		items={["Elemental Fragment##24508"]=372,["Mote of Fire##22574"]=174,["Epidote Stone Necklace of Shadow Protect##25069"]=(1),["Primordial Essence##24511"]=42,["Corroded Mail Circlet##25377"]=(1),["Sharpened Stilleto##25403"]=(1),["Essence of Fire##7078"]=(1)},
		mobslevel={70,71}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Mote Of Mana",
		route={ map="Netherstorm", points={54.7,88.0,  56.8,85.6,  57.4,87.1,  55.3,89.7,  54.5,90.2} },
		-- .from Mageslayer##18866+
		-- .from Mana Seeker##18867+
		items={["Elemental Fragment##24508"]=324,["Primordial Essence##24511"]=120,["Mote of Mana##22576 (18 Primal Mana)"]=180,["Dense War Staff##25404"]=(1),["Dilapidated Cloth Belt##25341"]=(1),["Dilapidated Cloth Boots##25342"]=(1)},
		mobslevel={68,69}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Mote Of Life",
		route={ map="Zangarmarsh", points={85.4,38.2,  85.1,41.0,  83.2,44.1,  81.0,43.4,  79.3,41.1,  78.7,38.3,  79.4,33.7,  82.0,32.3} },
		-- .from Withered Giant##18124+
		-- .from Withered Bog Lord##19402+
		--|tip AVOID Parched Hydra##20324+
		items={["Blighted Fungus##25452"]=102,["Unidentified Plant Parts##24401"]=96,["Bog Lord Tendril##24291"]=78,["Creeping Moss##25450"]=300,["Mote of Life##22575"]=96,["Moldy Leather Bracers##25352"]=(1),["Loosely Threaded Hat##24580"]=(1),["Azurite Ring of Spirit##25045"]=(1)},
		mobslevel={61,62}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Mote Of Shadow",
		route={ map="Nagrand", points={38.1,66.3,  35.2,65.6,  32.9,68.2,  32.2,70.8,  32.4,73.5,  35.3,77.1,  37.5,76.7,  39.4,74.1,  39.9,70.7,  39.2,68.0} },
		-- .from Voidspawn##17981+
		items={["Feralfen Hood of the Eagle##24633"]=(1),["Moldy Leather Boots##25351"]=(1),["Tarnished Plate Gloves##25385"]=1,["Decaying Leather Gloves##25361"]=(1),["Eroded Axe##25397"]=(1),["Daggerfen Stitchpants of the Gorilla##24754"]=(1),["Mote of Shadow##22577"]=105,["Silvermoon Crescent Axe of Agility##25205"]=(1),["Deteriorating Blade##25399"]=(1),["Netherweave Cloth##21877"]=375,["Oshu'gun Crystal Powder Sample##26042"]=65},
		mobslevel={65,66}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Mote Of Water",
		route={ map="Nagrand", points={44.5,46.5,  40.6,46.1,  41.6,40.4,  43.3,40.4,  44.4,42.3} },
		-- .from Muck Spawn##17154
		items={["Oshu'gun Crystal Powder Sample##26042"]=42,["Primordial Essence##24511"]=90,["Essence of Water##7080"]=90,["Elemental Fragment##24508"]=276,["Dilapidated Cloth Shoulderpads##25347"]=(1),["Broken Longbow##25406"]=(1)},
		mobslevel={64,66}
	}
--[[
	ZGV.Gold.chores:AddChore{typ="route",name="Green Cabbage",
		\'Routing to proper section |next "farm" |only if completedq(30257)
		\'Routing to proper section |next "kill" |only if not completedq(30257)
	label "farm"
		goto Valley of the Four Winds 51.9,48.3
		\'Start each day out by harvesting the crops from the previous day.
		|confirm
		goto Valley of the Four Winds/0 52.9,52.1
		.talk Merchant Greenfield##58718
		.buy 4 Green Cabbage Seeds##79102 |only if completedq(30257) and not completedq(31936)
		.buy 8 Green Cabbage Seeds##79102 |only if completedq(31936) and not completedq(31937)
		.buy 12 Green Cabbage Seeds##79102 |only if completedq(31937) and not completedq(32682)
		.buy 16 Green Cabbage Seeds##79102 |only if completedq(32682)
		|only if completedq(30257)
		goto Valley of the Four Winds 51.9,48.3
		\'Plant the Green Cabbage Seeds in your garden. You will have to wait until the next say to harvest them.
		.\' Click here if you wish to kill mobs for more Green Cabbages. Note that the mobs have a very low drop rate. |confirm |next "kill"
		.\' Click here to be taken to the beginning of the guide. |confirm |next "farm"
	label "kill"
		route={ map="Valley of the Four Winds", points={78.9,21.6,  80.8,19.6,  82.8,17.9,  84.7,14.2,  85.2,24.3,  84.8,26.6,  82.7,31.5} },
		-- .from Snagtooth Pesterling##65504+
		-- .from Snagtooth Tool-Grabber##56185+
		-- .from Snagtooth Virmen##56184+
		-- .from Snagtooth Hooligan##56462+
		-- .from Snagtooth Troublemaker##55873+
		|tip The drop rate on these items from mobs is extremely low. We suggest using the Tillers' farm to plant seeds and grow these crops instead.
		items={["Juicycrunch Carrot##74841"]=2,["Mogu Pumpkin##74842"]=3,["Green Cabbage##74840"]=2,["Mote of Harmony##89112"]=15,["Windwool Cloth##72988"]=33,["Roasted Barley Tea##81406"]=18,["Miner Breastplate of the Champion##82122"]=(1),["Dried Peaches##81403"]=21,["Wall Girdle of the Landslide##81990"]=(1),["Mudsoaked Belt##90788"]=(1),["Leggings of the Scorched Man##87464"]=(1),["Corroded Timber Axe##90807"]=(1),["Silent Shoulders of the Galeburst##81975"]=(1)},
		mobslevel=86,
	ZGV.Gold.chores:AddChore{typ="route",name="Mogu Pumpkin",
		Routing to proper section |next "farm" |only if completedq(30257)
		Routing to proper section |next "kill" |only if not completedq(30257)
	label "farm"
		goto Valley of the Four Winds 51.9,48.3
		Start each day out by harvesting the crops from the previous day.
		|confirm
		goto Valley of the Four Winds/0 52.9,52.1
		.talk Merchant Greenfield##58718
		.buy 4 Mogu Pumpkin Seeds##80592 |only if completedq(30257) and not completedq(31936)
		.buy 8 Mogu Pumpkin Seeds##80592 |only if completedq(31936) and not completedq(31937)
		.buy 12 Mogu Pumpkin Seeds##80592 |only if completedq(31937) and not completedq(32682)
		.buy 16 Mogu Pumpkin Seeds##80592 |only if completedq(32682)
		|only if completedq(30257)
		goto Valley of the Four Winds 51.9,48.3
		\'Plant the Mogu Pumpkin Seeds in your garden. You will have to wait until the next say to harvest them.
		.\' Click here if you wish to kill mobs for more Mogu Pumpkins. Note that the mobs have a very low drop rate. |confirm |next "kill"
		.\' Click here to be taken to the beginning of the guide. |confirm |next "farm"
	label "kill"
		route={ map="Valley of the Four Winds", points={78.9,21.6,  80.8,19.6,  82.8,17.9,  84.7,14.2,  85.2,24.3,  84.8,26.6,  82.7,31.5} },
		-- .from Snagtooth Pesterling##65504+
		-- .from Snagtooth Tool-Grabber##56185+
		-- .from Snagtooth Virmen##56184+
		-- .from Snagtooth Hooligan##56462+
		-- .from Snagtooth Troublemaker##55873+
		|tip The drop rate on these items from mobs is extremely low. We suggest using the Tillers' farm to plant seeds and grow these crops instead.
		items={["Juicycrunch Carrot##74841"]=2,["Mogu Pumpkin##74842"]=3,["Green Cabbage##74840"]=2,["Mote of Harmony##89112"]=15,["Windwool Cloth##72988"]=33,["Roasted Barley Tea##81406"]=18,["Miner Breastplate of the Champion##82122"]=(1),["Dried Peaches##81403"]=21,["Wall Girdle of the Landslide##81990"]=(1),["Mudsoaked Belt##90788"]=(1),["Leggings of the Scorched Man##87464"]=(1),["Corroded Timber Axe##90807"]=(1),["Silent Shoulders of the Galeburst##81975"]=(1)},
		mobslevel=86,
	ZGV.Gold.chores:AddChore{typ="route",name="Juicycrunch Carrot ",(HORDE)
		Routing to proper section |next "farm" |only if completedq(30257)
		Routing to proper section |next "kill" |only if not completedq(30257)
	label "farm"
		goto Valley of the Four Winds 51.9,48.3
		Start each day out by harvesting the crops from the previous day.
		|confirm
		goto Valley of the Four Winds/0 52.9,52.1
		.talk Merchant Greenfield##58718
		.buy 4 Juicycrunch Carrot Seeds##80590 |only if completedq(30257) and not completedq(31936)
		.buy 8 Juicycrunch Carrot Seeds##80590 |only if completedq(31936) and not completedq(31937)
		.buy 12 Juicycrunch Carrot Seeds##80590 |only if completedq(31937) and not completedq(32682)
		.buy 16 Juicycrunch Carrot Seeds##80590 |only if completedq(32682)
		|only if completedq(30257)
		goto Valley of the Four Winds 51.9,48.3
		\'Plant the Juicycrunch Carrot Seeds in your garden. You will have to wait until the next say to harvest them.
		.\' Click here if you wish to kill mobs for more Juicycrunch Carrots. Note that the mobs have a very low drop rate. |confirm |next "kill"
		.\' Click here to be taken to the beginning of the guide. |confirm |next "farm"
	label "kill"
		route={ map="Krasarang Wilds", points={8.1,67.4,  9.8,64.3,  11.1,67.5,  12.0,67.9,  14.1,68.8} },
		-- .from Shieldwall Marine##67354+
		items={["Lion's Landing Commission##91838"]=180,["Juicycrunch Carrot##74841"]=120,["Windwool Cloth##72988"]=36,["Red Blossom Leek##74844"]=78,["Scruffy Cloth Boots##90758"]=(1),["Yak Gauntlets of the Windflurry##82243"]=(1),["Drape of Flowing Gauze##87429"]=(1),["Temple Sabatons of the Beast##82293"]=(1)},
		mobslevel=90,
	ZGV.Gold.chores:AddChore{typ="route",name="Juicycrunch Carrot ",(ALLIANCE)
		Routing to proper section |next "farm" |only if completedq(30257)
		Routing to proper section |next "kill" |only if not completedq(30257)
	label "farm"
		goto Valley of the Four Winds 51.9,48.3
		\'Start each day out by harvesting the crops from the previous day.
		|confirm
		goto Valley of the Four Winds/0 52.9,52.1
		.talk Merchant Greenfield##58718
		.buy 4 Juicycrunch Carrot Seeds##80590 |only if completedq(30257) and not completedq(31936)
		.buy 8 Juicycrunch Carrot Seeds##80590 |only if completedq(31936) and not completedq(31937)
		.buy 12 Juicycrunch Carrot Seeds##80590 |only if completedq(31937) and not completedq(32682)
		.buy 16 Juicycrunch Carrot Seeds##80590 |only if completedq(32682)
		|only if completedq(30257)
		goto Valley of the Four Winds 51.9,48.3
		\'Plant the Juicycrunch Carrot Seeds in your garden. You will have to wait until the next say to harvest them.
		.\' Click here if you wish to kill mobs for more Juicycrunch Carrots. Note that the mobs have a very low drop rate. |confirm |next "kill"
		.\' Click here to be taken to the beginning of the guide. |confirm |next "farm"
	label "kill"
		route={ map="Krasarang Wilds/0", points={13.1,63.9,  11.5,65.3,  10.4,62.9 9.4,59.5,  12.2,58.6} },
		-- .from Heavy Mook##67399+
		items={["Mote of Harmony##89112"]=24,["Domination Point Commission##91877"]=318,["Red Blossom Leek##74844"]=36,["Juicycrunch Carrot##74841"]=36,["Windwool Cloth##72988"]=18,["Scruffy Cloth Shoulderpads##90767"]=(1),["Skewered Peanut Chicken##81413"]=6},
		mobslevel=90,
	ZGV.Gold.chores:AddChore{typ="route",name="SCALLION",
		Routing to proper section |next "farm" |only if completedq(30257)
		Routing to proper section |next "kill" |only if not completedq(30257)
	label "farm"
		goto Valley of the Four Winds 51.9,48.3
		\'Start each day out by harvesting the crops from the previous day.
		|confirm
		goto Valley of the Four Winds/0 52.9,52.1
		.talk Merchant Greenfield##58718
		.buy 4 Scallion Seeds##80591 |only if completedq(30257) and not completedq(31936)
		.buy 8 Scallion Seeds##80591 |only if completedq(31936) and not completedq(31937)
		.buy 12 Scallion Seeds##80591 |only if completedq(31937) and not completedq(32682)
		.buy 16 Scallion Seeds##80591 |only if completedq(32682)
		|only if completedq(30257)
		goto Valley of the Four Winds 51.9,48.3
		\'Plant the Scallion Seeds in your garden. You will have to wait until the next say to harvest them.
		.\' Click here if you wish to kill mobs for more Scallions. Note that the mobs have a very low drop rate. |confirm |next "kill"
		.\' Click here to be taken to the beginning of the guide. |confirm |next "farm"
	label "kill"
		goto Krasarang Wilds/0 61.8,40.3
		-- .from Riverblade Raider##59714+
		-- .from Riverblade Thief##64034+
		items={["Skewered Peanut Chicken##81413"]=42,["Mote of Harmony##89112"]=36,["Windwool Cloth##72988"]=42,["Scallions##74843"]=2,["Witchberries##74846"]=2,["Thresher Britches of the Monkey##82204"]=(1),["Highpeak Breastplate of the Whale##82232"]=(1),["Pearl Milk Tea##81414"]=6},
		mobslevel=90,
	ZGV.Gold.chores:AddChore{typ="route",name="Red Blossom Leek ",(HORDE)
		Routing to proper section |next "farm" |only if completedq(30257)
		Routing to proper section |next "kill" |only if not completedq(30257)
	label "farm"
		goto Valley of the Four Winds 51.9,48.3
		Start each day out by harvesting the crops from the previous day.
		|confirm
		goto Valley of the Four Winds/0 52.9,52.1
		.talk Merchant Greenfield##58718
		.buy 4 Red Blossom Leek Seeds##80593 |only if completedq(30257) and not completedq(31936)
		.buy 8 Red Blossom Leek Seeds##80593 |only if completedq(31936) and not completedq(31937)
		.buy 12 Red Blossom Leek Seeds##80593 |only if completedq(31937) and not completedq(32682)
		.buy 16 Red Blossom Leek Seeds##80593 |only if completedq(32682)
		|only if completedq(30257)
		goto Valley of the Four Winds 51.9,48.3
		Plant the Red Blossom Leek Seeds in your garden. You will have to wait until the next say to harvest them.
		 Click here if you wish to kill mobs for more Red Blossom Leeks. Note that the mobs have a very low drop rate. |confirm |next "kill"
		 Click here to be taken to the beginning of the guide. |confirm |next "farm"
	label "kill"
		route={ map="Krasarang Wilds", points={8.1,67.4,  9.8,64.3,  11.1,67.5,  12.0,67.9,  14.1,68.8} },
		-- .from Shieldwall Marine##67354+
		items={["Lion's Landing Commission##91838"]=180,["Juicycrunch Carrot##74841"]=120,["Windwool Cloth##72988"]=36,["Red Blossom Leek##74844"]=78,["Scruffy Cloth Boots##90758"]=(1),["Yak Gauntlets of the Windflurry##82243"]=(1),["Drape of Flowing Gauze##87429"]=(1),["Temple Sabatons of the Beast##82293"]=(1)},
		mobslevel=90,
	ZGV.Gold.chores:AddChore{typ="route",name="Red Blossom Leek ",(ALLIANCE)
		Routing to proper section |next "farm" |only if completedq(30257)
		Routing to proper section |next "kill" |only if not completedq(30257)
	label "farm"
		goto Valley of the Four Winds 51.9,48.3
		Start each day out by harvesting the crops from the previous day.
		|confirm
		goto Valley of the Four Winds/0 52.9,52.1
		.talk Merchant Greenfield##58718
		.buy 4 Red Blossom Leek Seeds##80593 |only if completedq(30257) and not completedq(31936)
		.buy 8 Red Blossom Leek Seeds##80593 |only if completedq(31936) and not completedq(31937)
		.buy 12 Red Blossom Leek Seeds##80593 |only if completedq(31937) and not completedq(32682)
		.buy 16 Red Blossom Leek Seeds##80593 |only if completedq(32682)
		|only if completedq(30257)
		goto Valley of the Four Winds 51.9,48.3
		Plant the Red Blossom Leek Seeds in your garden. You will have to wait until the next say to harvest them.
		 Click here if you wish to kill mobs for more Red Blossom Leeks. Note that the mobs have a very low drop rate. |confirm |next "kill"
		 Click here to be taken to the beginning of the guide. |confirm |next "farm"
	label "kill"
		route={ map="Krasarang Wilds/0", points={13.1,63.9,  11.5,65.3,  10.4,62.9 9.4,59.5,  12.2,58.6} },
		-- .from Heavy Mook##67399+
		items={["Red Blossom Leek##74844"]=36,["Juicycrunch Carrot##74841"]=36,["Mote of Harmony##89112"]=24,["Domination Point Commission##91877"]=318,["Windwool Cloth##72988"]=18,["Skewered Peanut Chicken##81413"]=6,["Scruffy Cloth Shoulderpads##90767"]=(1)},
		mobslevel=90,
	ZGV.Gold.chores:AddChore{typ="route",name="Witchberries",
		Routing to proper section |next "farm" |only if completedq(30257)
		Routing to proper section |next "kill" |only if not completedq(30257)
	label "farm"
		goto Valley of the Four Winds 51.9,48.3
		Start each day out by harvesting the crops from the previous day.
		|confirm
		goto Valley of the Four Winds/0 52.9,52.1
		.talk Merchant Greenfield##58718
		.buy 4 Witchberry Seeds##89326 |only if completedq(30257) and not completedq(31936)
		.buy 8 Witchberry Seeds##89326 |only if completedq(31936) and not completedq(31937)
		.buy 12 Witchberry Seeds##89326 |only if completedq(31937) and not completedq(32682)
		.buy 16 Witchberry Seeds##89326 |only if completedq(32682)
		|only if completedq(30257)
		goto Valley of the Four Winds 51.9,48.3
		Plant the Witchberry Seeds in your garden. You will have to wait until the next say to harvest them.
		 Click here if you wish to kill mobs for more Witchberriess. Note that the mobs have a very low drop rate. |confirm |next "kill"
		 Click here to be taken to the beginning of the guide. |confirm |next "farm"
	label "kill"
		goto Krasarang Wilds/0 61.8,40.3
		-- .from Riverblade Raider##59714+
		-- .from Riverblade Thief##64034+
		items={["Scallions##74843"]=2,["Witchberries##74846"]=2,["Skewered Peanut Chicken##81413"]=42,["Mote of Harmony##89112"]=36,["Windwool Cloth##72988"]=42,["Pearl Milk Tea##81414"]=6,["Thresher Britches of the Monkey##82204"]=(1),["Highpeak Breastplate of the Whale##82232"]=(1)},
		mobslevel=90,
	ZGV.Gold.chores:AddChore{typ="route",name="Jade Squash",
		Routing to proper section |next "farm" |only if completedq(30257)
		Routing to proper section |next "kill" |only if not completedq(30257)
	label "farm"
		goto Valley of the Four Winds 51.9,48.3
		Start each day out by harvesting the crops from the previous day.
		|confirm
		goto Valley of the Four Winds/0 52.9,52.1
		.talk Merchant Greenfield##58718
		.buy 4 Jade Squash Seeds##89328 |only if completedq(30257) and not completedq(31936)
		.buy 8 Jade Squash Seeds##89328 |only if completedq(31936) and not completedq(31937)
		.buy 12 Jade Squash Seeds##89328 |only if completedq(31937) and not completedq(32682)
		.buy 16 Jade Squash Seeds##89328 |only if completedq(32682)
		|only if completedq(30257)
		goto Valley of the Four Winds 51.9,48.3
		Plant the Jade Squash Seeds in your garden. You will have to wait until the next say to harvest them.
		 Click here if you wish to kill mobs for more Jade Squash. Note that the mobs have a very low drop rate. |confirm |next "kill"
		 Click here to be taken to the beginning of the guide. |confirm |next "farm"
	label "kill"
		route={ map="Krasarang Wilds", points={49.2,89.1,  47.5,91.5,  45.8,92.5,  44.6,90.8,  42.3,89.4,  42.7,87.6,  44.4,88.0,  46.7,89.2} },
		-- .from Unga Treasure-Hider##60357+
		-- .from Unga Fish-Getter##60299+
		-- .from Unga Villager##60358+
		items={["Windwool Cloth##72988"]=156,["Boiled Silkworm Pupa##81405"]=36,["Roasted Barley Tea##81406"]=36,["Four Wind Soju##81407"]=18,["Mote of Harmony##89112"]=24,["Jade Squash##74847"]=12,["Snowy Helm of the Tiger##82180"]=(1),["Snowy Sabatons of the Tiger##82183"]=(1),["Striped Melon##74848"]=12,["Mudsoaked Belt##9078"]=(1)},
		mobslevel=87,
	ZGV.Gold.chores:AddChore{typ="route",name="Striped Melon",
		Routing to proper section |next "farm" |only if completedq(30257)
		Routing to proper section |next "kill" |only if not completedq(30257)
	label "farm"
		goto Valley of the Four Winds 51.9,48.3
		Start each day out by harvesting the crops from the previous day.
		|confirm
		goto Valley of the Four Winds/0 52.9,52.1
		.talk Merchant Greenfield##58718
		.buy 4 Striped Melon Seeds##89329 |only if completedq(30257) and not completedq(31936)
		.buy 8 Striped Melon Seeds##89329 |only if completedq(31936) and not completedq(31937)
		.buy 12 Striped Melon Seeds##89329 |only if completedq(31937) and not completedq(32682)
		.buy 16 Striped Melon Seeds##89329 |only if completedq(32682)
		|only if completedq(30257)
		goto Valley of the Four Winds 51.9,48.3
		Plant the Striped Melon Seeds in your garden. You will have to wait until the next say to harvest them.
		 Click here if you wish to kill mobs for more Striped Melons. Note that the mobs have a very low drop rate. |confirm |next "kill"
		 Click here to be taken to the beginning of the guide. |confirm |next "farm"
	label "kill"
		route={ map="Krasarang Wilds", points={49.2,89.1,  47.5,91.5,  45.8,92.5,  44.6,90.8,  42.3,89.4,  42.7,87.6,  44.4,88.0,  46.7,89.2} },
		-- .from Unga Treasure-Hider##60357+
		-- .from Unga Fish-Getter##60299+
		-- .from Unga Villager##60358+
		items={["Windwool Cloth##72988"]=156,["Boiled Silkworm Pupa##81405"]=36,["Roasted Barley Tea##81406"]=36,["Four Wind Soju##81407"]=18,["Mote of Harmony##89112"]=24,["Jade Squash##74847"]=12,["Snowy Helm of the Tiger##82180"]=(1),["Snowy Sabatons of the Tiger##82183"]=(1),["Striped Melon##74848"]=12,["Mudsoaked Belt##9078"]=(1)},
		mobslevel=87,
	ZGV.Gold.chores:AddChore{typ="route",name="Pink Turnips",
		Routing to proper section |next "farm" |only if completedq(30257)
		Routing to proper section |next "kill" |only if not completedq(30257)
	label "farm"
		goto Valley of the Four Winds 51.9,48.3
		Start each day out by harvesting the crops from the previous day.
		|confirm
		goto Valley of the Four Winds/0 52.9,52.1
		.talk Merchant Greenfield##58718
		.buy 4 Pink Turnip Seeds##80594 |only if completedq(30257) and not completedq(31936)
		.buy 8 Pink Turnip Seeds##80594 |only if completedq(31936) and not completedq(31937)
		.buy 12 Pink Turnip Seeds##80594 |only if completedq(31937) and not completedq(32682)
		.buy 16 Pink Turnip Seeds##80594 |only if completedq(32682)
		|only if completedq(30257)
		goto Valley of the Four Winds 51.9,48.3
		Plant the Pink Turnip Seeds in your garden. You will have to wait until the next say to harvest them.
		 Click here if you wish to kill mobs for more Pink Turnips. Note that the mobs have a very low drop rate. |confirm |next "kill"
		 Click here to be taken to the beginning of the guide. |confirm |next "farm"
	label "kill"
		route={ map="Townlong Steppes", points={68.9,53.8,  66.6,52.4,  66.7,48.1,  67.5,45.3,  67.7,48.1} },
		-- .from Osul Marauder##60692+
		-- .from Osul Spitfire##66289+
		-- .from Osul Sharphorn##60647+
		items={["Mote of Harmony##89112"]=18,["Roasted Barley Tea##81406"]=18,["Windwool Cloth##72988"]=36,["Boiled Silkworm Pupa##81405"]=12,["Pink Turnip##74849"]=3,["White Turnip##74850"]=3},
		mobslevel=88,
	ZGV.Gold.chores:AddChore{typ="route",name="White Turnips",
		Routing to proper section |next "farm" |only if completedq(30257)
		Routing to proper section |next "kill" |only if not completedq(30257)
	label "farm"
		goto Valley of the Four Winds 51.9,48.3
		Start each day out by harvesting the crops from the previous day.
		|confirm
		goto Valley of the Four Winds/0 52.9,52.1
		.talk Merchant Greenfield##58718
		.buy 4 White Turnip Seeds##80595 |only if completedq(30257) and not completedq(31936)
		.buy 8 White Turnip Seeds##80595 |only if completedq(31936) and not completedq(31937)
		.buy 12 White Turnip Seeds##80595 |only if completedq(31937) and not completedq(32682)
		.buy 16 White Turnip Seeds##80595 |only if completedq(32682)
		|only if completedq(30257)
		goto Valley of the Four Winds 51.9,48.3
		Plant the White Turnip Seeds in your garden. You will have to wait until the next say to harvest them.
		 Click here if you wish to kill mobs for more White Turnips. Note that the mobs have a very low drop rate. |confirm |next "kill"
		 Click here to be taken to the beginning of the guide. |confirm |next "farm"
	label "kill"
		route={ map="Townlong Steppes", points={68.9,53.8,  66.6,52.4,  66.7,48.1,  67.5,45.3,  67.7,48.1} },
		-- .from Osul Marauder##60692+
		-- .from Osul Spitfire##66289+
		-- .from Osul Sharphorn##60647+
		items={["Mote of Harmony##89112"]=18,["Roasted Barley Tea##81406"]=18,["Windwool Cloth##72988"]=36,["Boiled Silkworm Pupa##81405"]=12,["Pink Turnip##74849"]=3,["White Turnip##74850"]=3},
		mobslevel=88,
	ZGV.Gold.chores:AddChore{typ="route",name="Cocoa Beans ",(ALLIANCE)
		#include "A_Stormwind_Cooking_Dailies"
		..earn 1 Epicurean\'s Reward##81
		goto Stormwind City 50.8,71.4
		.talk Bario Matalli##49701
		.buy Imported Supplies##68689
		Use the Imported Supplies in your bags. |use Imported Supplies##68689
		..collect Cocoa Beans##62786
	ZGV.Gold.chores:AddChore{typ="route",name="Cocoa Beans ",(HORDE)
		#include "H_Org_Cooking_Dailies"
		..earn 1 Epicurean\'s Reward##81
		goto Orgrimmar 56.8,62.6
		.talk Shazdar##49737
		.buy Imported Supplies##68689
		Use the Imported Supplies in your bags. |use Imported Supplies##68689
		..collect Cocoa Beans##62786
	--]]
	ZGV.Gold.chores:AddChore{typ="route",name="Jaggal Pearl/Jaggal Clam Meat/Shadow Pearl",
		--goto Shadowmoon Valley 52.5,27
		 --Clear the Naga here then enter the cave, killing the ones in there.
		-- .from Coilskar Sorceress##19767+, Coilskar Myrmidon##19765+, Keeper of the Cistern##20795+, Coilskar Muckwatcher##19788+
		--avoid		-- .from Coilskar Cobra##19784+		-- .from Enraged Water Spirit##21059+
		items={["Coilskar Chest Key##30426"]=210,["Fish Oil##17058"]=144,["Iridescent Scale##30812"]=18,["Jaggal Clam##24476"]=48,["Shiny Fish Scales##17057"]=84,["Sunspring Carp##27858"]=42,["Super Healing Potion##22829"]=12,["Jaggal Clam Meat##24477"]=48,["Shadow Pearl##24479"]=6,["Jaggal Pearl##24478"]=6,["Purified Draenic Water##27860"]=(1),["Broken Longbow##25406"]=(1),["Sharpened Stilleto##25403"]=(1)},
		mobslevel={68,70}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Siren's Tear/Northsea Pearl",
		route={ map="Borean Tundra ", points={41.5,18.7,  41.0,16.1,  39.1,15.4,  37.3,15.5,  38.4,17.0,  40.0,19.6} },
		-- .from Winterfin Warrior##25217+, Winterfin Shorestriker##25215+, Winterfin Oracle##25216+
		items={["Darkwater Clam##36781"]=90,["Winterfin Clam##34597"]=114,["Fish Oil##17058"]=114,["Shiny Fish Scales##17057"]=120,["Fillet of Icefin##33451"]=30,["Northsea Pearl##36783"]=12,["Siren's Tear##36784"]=6,["Aquatic Greatstaff of the Beast##36697"]=(1),["Farshire Gloves of the Owl##35958"]=(1),["Super Healing Potion##22829"]=(1),["Thread-Bare Cloth Shoulderpads##33363"]=(1),["Fur-Lined Bracers##33375"]=(1),["Chipped Timber Axe##33426"]=(1),["Suede Cloak of Frost Protection##36404"]=(1),["Icy Mail Bracers##33393"]=(1)},
		mobslevel={69,70}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Globe Of Water, Essence Of Water, Elemental Water",
		route={ map="Swamp of Sorrows ", points={17.2,55.7,  16.7,60.5,  16.5,66.1,  20.0,65.8,  21.0,59.3,  21.0,55.1} },
		-- .from Purespring Elemental##46953+
		items={["Inert Elemental Piece##55985"]=168,["Inert Elemental Shard##55984"]=336,["Globe of Water##7079"]=18,["Essence of Water##7080"]=12,["Elemental Water##7070"]=48,["Laminated Scale Bracers##3994"]=(1),["Smooth Leather Belt##3969"]=(1),["Wanderer's Cloak of Agility##10108"]=(1)},
		mobslevel={54,55}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Breath Of Wind, Essence Of Air, Elemental Air",
		--goto Silithus 36.6,16.7 |n
		-- .from Dust Stormer##11744
		-- .from Cyclone Warrior##11745
		-- Bounce back between the first coordinate and [28.8,27.4].
		items={["Elemental Air##7069"]=36,["Inert Elemental Shard##55984"]=150,["Breath of Wind##7081"]=30,["Inert Elemental Piece##55985"]=102,["Essence of Air##7082"]=18,["Deflecting Tower##3987"]=(1),["Impenetrable Cloak of the Eagle##15661"]=(1),["Stout War Staff##13823"]=(1),["Bloodlust Gauntlets##14802"]=(1)},
		mobslevel={54,55}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Core Of Earth, Essence Of Earth, Elemental Earth",
		route={ map="Winterspring", points={61.2,59.9,  59.9,60.3,  57.8,58.7,  59.1,57.1} },
		-- .from Frostshard Rumbler##48960+
		items={["Core of Earth##7075"]=30,["Elemental Earth##7067"]=36,["Essence of Earth##7076"]=18,["Inert Elemental Shard##55984"]=270,["Inert Elemental Piece##55985"]=114,["Smooth Leather Helmet##8753"]=(1),["Twill Pants##3949"]=(1),["Arachnidian Gloves of the Whale##14294"]=(1),["Deflecting Tower##3987"]=(1),["Twill Cover##8754"]=(1),["Lofty Belt of the Bear##14927"]=(1)},
		mobslevel={51,52}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Core Of Elements, Essence Of Fire, Elemental Fire",
		route={ map="Un\'Goro Crater", points={54.4,56.2,  53.4,51.0,  55.1,48.7,  54.5,44.0,  52.7,42.5,  52.2,45.5,  49.3,48.4,  48.6,43.9,  46.3,46.5,  45.5,51.3,  47.5,53.6,  50.2,54.3} },
		-- .from Living Blaze##6521+
		-- .from Blazerunner##9376+
		--[[
		..collect Inert Elemental Shard##55984
		..collect Core of Elements##22527
		..collect Inert Elemental Piece##55985
		..collect Fine Longsword##13816
		..collect Elemental Fire##7068
		..collect Essence of Fire##7078
		..collect Twill Bracers##3946
		..collect Heart of Fire##7077
		--]]
		mobslevel={52,53}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Raptor Egg, Raptor Hide, Raptor Flesh, Large Fang",
		route={ map="Arathi Highlands/0", points={42.5,84.7,  42.3,76.7,  45.3,70.7,  48.9,67.4}, loop=false },
		-- .from Highland Fleshstalker##2561+
		--|tip AVOID Boulderfist Brute##2566+, Giant Plains Creeper##2565+
		items={["Raptor Egg##3685"]=300,["Raptor Hide##4461"]=156,["Raptor Flesh##12184"]=276,["Large Fang##5637"]=12,["Keen Raptor Tooth##1697"]=102,["Tiny Raptor Tooth##54832"]=264,["Curved Raptor Talon##1696"]=42,["Long Bastard Sword##1830"]=(1),["Tower Shield##2222"]=(1),["Deft Stiletto##2766"]=(1),["Tough Leather Gloves##1807"]=(1)},
		mobslevel={28,29}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Essence Of Undeath",
		route={ map="Eastern Plaguelands", points={75.3,76.7,  76.8,77.0,  80.3,77.9,  80.9,74.3,  76.8,73.4,  72.5,70.7} },
		-- .from Scarlet Warder##9447+ , Scarlet Cleric##9449+, Scarlet Curate##9450+, Scarlet Archmage##9451+, Scarlet Praetorian##9448+
		-- Enter the buildings and kill the mobs inside as well.
		items={["Essence of Undeath##12808"]=12,["Mageweave Cloth##4338"]=288,["Moonberry Juice##1645"]=30,["Superior Healing Potion##3928"]=6,["Fine Aged Cheddar##3927"]=24,["Silk Cloth##4306"]=108,["Raw Black Truffle##4608"]=24,["Crochet Bracers##3938"]=(1),["Star Ruby##7910"]=(1),["Trueshot Bow of the Tiger##4087"]=(1),["Embossed Plate Leggings of the Bear##9970"]=(1),["Sentinel Musket##4026"]=(1),["Overlink Chain Belt##4000"]=(1),["Sorcerer Hat##9878"]=(1),["Thick Leather hat##8750"]=(1),["Greater Mana Potion##6149"]=(1),["Citrine##3864"]=(1),["Heavy War Staff##4024"]=(1)},
		mobslevel={41,42}
	}
	ZGV.Gold.chores:AddChore{typ="route",name="Ichor Of Undeath",
		--goto Scholomance/2 59.6,19.1
		-- .from Risen Guard##58822+
		-- .from Reanimated Corpse##59501+
		items={["Superior Healing Potion##3928"]=30,["Greater Mana Potion##6149"]=12,["Mageweave Cloth##4338"]=324,["Soft Banana Bread##4601"]=90,["Silk Cloth##4306"]=216,["Moonberry Juice##1645"]=180,["Raw Black Truffle##4608"]=36,["Bone Fragments##22526"]=76,["Ichor of Undeath##7972"]=36,["Crushing Maul##4022"]=(1),["Wraithplate Treads##88348"]=(1),["Embossed Plate Helmet of the Bear##9969"]=(1),["Protective Pavise##3986"]=(1)},
		--Reset the Instance as needed.
		mobslevel={41,42,"elite"}
	}
	--[[
	ZGV.Gold.chores:AddChore{typ="route",name="Frozen Orb, Chaos Orb",
		 Frozen orbs come the last boss of Heroic Wrath of the Lich King Instances.
		Ahn''Kahet: Average of 10m
		Azjol-Nerub: Average of 5m
		The Culling of Stratholme: Average of 10m
		Trial of the Champion: Average of 15m
		Drak\'Tharon Keep: Average of 8m
		Gundrak: Average of 8m
		Halls of Reflection: Average of 15m
		Pit of Saron: Average of 10m
		The Forge of Souls: Average of 5m
		The Nexus: Average of 10m
		The Oculus: Average 10m
		The Violet Hold: Average 10m
		Hall of Lightning: AVerage 8m
		Halls of Stone: Average 10m
		Utgarde Keep: Average 8m
		Utgarde Pinnacle: 8m
		 Chaos orbs come from the last boss of cataclysm ranked heroic instances.
		Throne of the Tides: Average of 10m
		Blackrock Caverns: Average of 10m
		End Time: Average of 10m
		Grim Batol: Average of 12m
		Hall of Origination: Average of 15m
		Hour of Twilight: Average of 15m
		Lost City of the Tol\'vir: Average of 10m
		The Stonecore: Average of 10m
		The Vortex Pinnacle: Average of 10m
		Well of Eternity: Average of 12m
		Zul\'Aman: Average of 15m
		Zul\'Gurub: Average of 15m
	--]]


end)



local example_prices = {}
ZGV.Gold.data.example_prices = example_prices

example_prices[765]=002000
example_prices[2447]=003000
example_prices[79011]=021000
example_prices[79010]=024000
example_prices[72235]=018000
