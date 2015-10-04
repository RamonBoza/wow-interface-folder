local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Alliance" then return end

-- DAILIES RUNS

if UnitFactionGroup("player")=="Alliance" then




	ZygorGuidesViewer:RegisterGuide("GOLD\\Alliance Daily Runs\\The Anglers Dailies Run",[[
		description This guide will take you through The Anglers dailies
		meta goldtype="daily",levelreq=90,gold=34,time=15,icon="Interface\\ICONS\\Achievement_Faction_Anglers"
			#include "A_Anglers"
	]])
	ZygorGuidesViewer:RegisterGuide("GOLD\\Alliance Daily Runs\\The August Celestials Dailies Run",[[
		description This guide will take you through The August Celestials dailies
		meta goldtype="daily",levelreq=90,gold=84,time=15,icon="Interface\\ICONS\\Achievement_Faction_Celestials"
			#include "August_Celestials"
		step
		label end
			'This is the end of the current guide. Click here to go back to the beginning. |confirm |next "startaug"
	]])
	ZygorGuidesViewer:RegisterGuide("GOLD\\Alliance Daily Runs\\The Order of the Cloud Serpent Dailies Run",[[
		description Th is guide will take you through the Order of the Cloud Serpent dailies
		meta goldtype="daily",levelreq=90,gold=59,time=15,icon="Interface\\ICONS\\Achievement_Faction_SerpentRiders"
			#include "A_Cloud_Serpent"
	]])
	ZygorGuidesViewer:RegisterGuide("GOLD\\Alliance Daily Runs\\The Shado-Pan Dailies Run",[[
		description This guide will take you through the Shado-Pan dailies
		meta goldtype="daily",levelreq=90,gold=91,time=15,icon="Interface\\ICONS\\Achievement_Faction_ShadoPan"
			#include "Shado_Pan_Daily_A"
	]])
	ZygorGuidesViewer:RegisterGuide("GOLD\\Alliance Daily Runs\\The Tillers Dailies Run",[[
		description This guide will take you through The Tillers dailies
		meta goldtype="daily",levelreq=90,gold=78,time=15,icon="Interface\\ICONS\\Achievement_Faction_Tillers"
		step
			#include "A_Tillers_DailyQuest"
	]])
	ZygorGuidesViewer:RegisterGuide("GOLD\\Alliance Daily Runs\\The Golden Lotus Dailies Run",[[
		description This guide will take you through The Golden Lotus dailies
		meta goldtype="daily",levelreq=90,gold=145,time=15,icon="Interface\\ICONS\\Achievement_Faction_GoldenLotus"
		step
			'Routing to proper section |next "prequests" |only if not completedq(31511) and not completedq(31512)
			'Routing to proper section |next "dailies" |only if completedq(31511) or completedq(31512)
		step
		label "prequests"
			#include "Golden_Lotus_PreQuests"
			#include "Golden_Lotus"
	]])
	ZygorGuidesViewer:RegisterGuide("GOLD\\Alliance Daily Runs\\The Klaxxi Dailies Run",[[
		description This guide will take you through The Klaxxi dailies
		meta goldtype="daily",levelreq=90,gold=159,time=30,icon="Interface\\ICONS\\Achievement_Faction_Klaxxi"
			#include "A_Klaxxi"
	]])
	ZygorGuidesViewer:RegisterGuide("GOLD\\Alliance Daily Runs\\Operation:Shieldwall Dailies Run",[[
		description This guide will take you through quests for Operation: Shieldwall.
		meta goldtype="daily",levelreq=90,gold=101,time=30,icon="Interface\\ICONS\\Achievement_General_AllianceSlayer"
		step
			#include "Operation_Shieldwall_Daily"
	]])
	ZygorGuidesViewer:RegisterGuide("GOLD\\Alliance Daily Runs\\Kirin Tor Offensive Dailies Run",[[
		description This guide will take you through the bonus quests for the Kirin Tor.
		meta goldtype="daily",levelreq=90,gold=288,time=75,icon="Interface\\ICONS\\Achievement_Reputation_Kirintor_Offensive"
		step
			#include "Kirin_Tor_Offensive"
	]])
	ZygorGuidesViewer:RegisterGuide("GOLD\\Alliance Daily Runs\\Eastern Kingdoms Battle Pet Dailies Run",[[
		description This guide will take you through the Battle Pet Dailies in Eastern Kingdoms.
		meta goldtype="daily",levelreq=5,gold=238,time=45,icon="Interface\\ICONS\\PetJournalPortrait"
		condition valid completedq(31915)
		step
			goto Elwynn Forest 41.6,83.7
			.talk Julia Stevens##64330
			..accept Julia Stevens##31693
		step
			goto Elwynn Forest 41.6,83.7
			.talk Julia Stevens##64330
			|tip You will not be able to challenge Julia if you have the "Pet Recovery" debuff, wait for it to fall off.
			.' Let's fight!
			|tip Julia has 2 Beast type Pets. Use Mechanical type attacks on the Beast Pets. Julia's pets are level 2 so you shouldn't have any issues here.
			.' Defeat Julia Stevens |q 31693/1
		step
			goto Elwynn Forest 41.6,83.7
			.talk Julia Stevens##64330
			..turnin Julia Stevens##31693
		step
			goto Westfall 60.9,18.6
			.talk Old MacDonald##65648
			..accept Old MacDonald##31780
		step
			goto Westfall 60.9,18.6
			.talk Old MacDonald##65648
			|tip You will not be able to challenge Old MacDonald if you have the "Pet Recovery" debuff, wait for it to fall off.
			.' Let's fight!
			|tip Old MacDonald has 3 Beast type Pets. Use Mechanical type attacks on the Beast Pets. Old MacDonald's pets are level 3 so you shouldn't have any issues here.
			.' Defeat Old MacDonald |q 31780/1
		step
			goto Westfall 60.9,18.6
			.talk Old MacDonald##65648
			..turnin Old MacDonald##31780
		step
			goto Duskwood 19.9,44.7
			.talk Eric Davidson##65655
			..accept Eric Davidson##31850
		step
			goto Duskwood 19.9,44.7
			.talk Eric Davidson##65655
			|tip You will not be able to challenge Eric if you have the "Pet Recovery" debuff, wait for it to fall off.
			.' Let's fight!
			|tip Eric has 3 Beast type Pets. Use Mechanical type attacks on the Beast Pets. Eric's pets are level 7 so you shouldn't have any issues here.
			.' Defeat Eric Davidson |q 31850/1
		step
			goto Duskwood 19.9,44.7
			.talk Eric Davidson##65655
			..turnin Eric Davidson##31850
		step
			goto Northern Stranglethorn 46.0,40.3
			.talk Steven Lisbane##63194
			..accept Steven Lisbane##31852
		step
			goto Northern Stranglethorn 46.0,40.3
			.talk Steven Lisbane##63194
			|tip You will not be able to challenge Steven if you have the "Pet Recovery" debuff, wait for it to fall off.
			.' Let's fight!
			|tip Steven has a Magic type Pet and 2 Beast type Pets. Use Dragonkin type attacks on the Magic Pet and Mechanical type attacks on the Beast Pets. Steven's pets are level 9 so you shouldn't have any issues here.
			.' Defeat Steven Lisbane |q 31852/1
		step
			goto Northern Stranglethorn 46.0,40.3
			.talk Steven Lisbane##63194
			..turnin Steven Lisbane##31852
		step
			goto The Cape of Stranglethorn 51.4,73.3
			.talk Bill Buckler##65656
			..accept Bill Buckler##31851
		step
			goto The Cape of Stranglethorn 51.4,73.3
			.talk Bill Buckler##65656
			|tip You will not be able to challenge Bill if you have the "Pet Recovery" debuff, wait for it to fall off.
			.' Let's fight!
			|tip Bill has a Humanoid type Pet and 2 Flying type Pets. Use Undead type attacks on the Humanoid Pet and Magic type attacks on the Flying Pets. Bill's pets are level 11 so you shouldn't have any issues here.
			.' Defeat Bill Buckler |q 31851/1
		step
			goto The Cape of Stranglethorn 51.4,73.3
			.talk Bill Buckler##65656
			..turnin Bill Buckler##31851
		step
			goto Deadwind Pass 40.1,76.4
			.talk Lydia Accoste##66522
			..accept Grand Master Lydia Accost##31916
		step
			goto Deadwind Pass 40.1,76.4
			.talk Lydia Accoste##66522
			|tip You will not be able to challenge Lydia if you have the "Pet Recovery" debuff, wait for it to fall off.
			.' Let's fight!
			|tip Lydia has an Elemental type Pet and 2 Undead type Pets. Use Aquatic type attacks on the Elemental Pet and Critter type attacks on the Undead Pets. Your pets should be at least level 19 before fighting Lydia.
			.' Defeat Lydia Accoste |q 31916/1
		step
			goto 40.1,76.4
			.talk Lydia Accoste##66522
			..turnin Grand Master Lydia Accoste##31916
		step
			goto Swamp of Sorrows 76.8,41.5
			.talk Everessa##66518
			..accept Everessa##31913
		step
			goto Swamp of Sorrows 76.8,41.5
			.talk Everessa##66518
			|tip You will not be able to challenge Everessa if you have the "Pet Recovery" debuff, wait for it to fall off.
			.' Let's fight!
			|tip Everessa has a Flying Pet, a Beast Pet, and an Aquatic Pet. Use Magic type attacks on the Flying Pet, Mechanical type attacks on the Beast Pet, and Flying type attacks on the Aquatic Pet. Her pets are all level 16. You should be able to win with ease.
			.' Defeat Everessa |q 31913/1
		step
			goto Swamp of Sorrows 76.8,41.5
			.talk Everessa##66518
			..turnin Everessa##31913
		step
			goto Redridge Mountains 33.2,52.6
			.talk Lindsay##65651
			..accept Lindsay##31781
		step
			goto Redridge Mountains 33.2,52.6
			.talk Lindsay##65651
			|tip You will not be able to challenge Lindsay if you have the "Pet Recovery" debuff, wait for it to fall off.
			.' Let's fight!
			|tip Lindsay has 3 Critter type pets. Use Beast type attacks the Critter Pets. Her pets are all level 16. You should be able to win with ease.
			.' Defeat Lindsay |q 31781/1
		step
			goto Redridge Mountains 33.2,52.6
			.talk Lindsay##65651
			..turnin Lindsay##31781
		step
			goto Burning Steppes 25.5,47.4
			.talk Durin Darkhammer##66520
			..accept Durin Darkhammer##31914
		step
			goto Burning Steppes 25.5,47.4
			.talk Durin Darkhammer##66520
			|tip You will not be able to challenge Durin if you have the "Pet Recovery" debuff, wait for it to fall off.
			.' Let's fight!
			|tip Durin has a Flying type Pet, a Critter Pet, and an Elemental Pet. Use Magic type attacks on the Flying Pet, Beast type attacks on the Critter Pet, and Aquatic type attacks on the Elemental Pet. His pets are all level 17. You should be able to win with ease.
			.' Defeat Durin Darkhammer |q 31914/1
		step
			goto Burning Steppes 25.5,47.4
			.talk Durin Darkhammer##66520
			..turnin Durin Darkhammer##31914
		step
			goto Searing Gorge 35.3,27.8
			.talk Kortas Darkhammer##66515
			..accept Kortas Darkhammer##31912
		step
			goto Searing Gorge 35.3,27.8
			.talk Kortas Darkhammer##66515
			|tip You will not be able to challenge Kortas if you have the "Pet Recovery" debuff, wait for it to fall off.
			.' Let's fight!
			|tip Kortas has 3 Dragonkin type Pets. Use Humanoid type attacks on his pets. His pets are all around level 15 so your pet team should be able to defeat him easily.
			.' Defeat Kortas Darkhammer |q 31912/1
		step
			goto Searing Gorge 35.3,27.8
			.talk Kortas Darkhammer##66515
			..turnin Kortas Darkhammer##31912
		step
			goto The Hinterlands 63.0,54.6
			.talk David Kosse##66478
			..accept David Kosse##31910
		step
			goto The Hinterlands 63.0,54.6
			.talk David Kosse##66478
			|tip You will not be able to challenge David if you have the "Pet Recovery" debuff, wait for it to fall off.
			.' Let's fight!
			|tip David has a Beast Pet, a Critter Pet, and an Magic Pet. Use Mechanical type attacks on the Beast Pet, Beast type attacks on the Critter Pet, and Dragonkin type attacks on the Magic Pet. His pets are all around level 13 so your pet team should be able to defeat him easily.
			.' Defeat David Kosse |q 31910/1
		step
			goto The Hinterlands 63.0,54.6
			.talk David Kosse##66478
			..turnin David Kosse##31910
		step
			goto Eastern Plaguelands 67.0,52.4
			.talk Deiza Plaguehorn##66512
			..accept Deiza Plaguehorn##31911
		step
			goto Eastern Plaguelands 67.0,52.4
			.talk Deiza Plaguehorn##66512
			|tip You will not be able to challenge Deiza if you have the "Pet Recovery" debuff, wait for it to fall off.
			.' Let's fight!
			|tip Deiza has 2 Beast type Pets and an Undead type Pet. Use Mechanical type attacks on the Beast Pets and Critter type attacks on the Undead Pet. Her pets are all around level 14 so your pet team should be able to defeat her easily.
			.' Defeat Deiza Plaguehorn |q 31911/1
		step
			goto Eastern Plaguelands 67.0,52.4
			.talk Deiza Plaguehorn##66512
			..turnin Deiza Plaguehorn##31911
	]])
	ZygorGuidesViewer:RegisterGuide("GOLD\\Alliance Daily Runs\\Outland Battle Pet Dailies Run",[[
		description This guide will take you through the Battle Pet Dailies in Outland.
		meta goldtype="daily",levelreq=58,gold=99,time=15,icon="Interface\\ICONS\\PetJournalPortrait"
		condition valid completedq(31920)
		step
			goto Hellfire Peninsula 64.3,49.3
			.talk Nicki Tinytech##66550
			..accept Nicki Tinytech##31922
		step
			goto Hellfire Peninsula 64.3,49.3
			.talk Nicki Tinytech##66550
			|tip You will not be able to challenge Nicky if you have the "Pet Recovery" debuff, wait for it to fall off. 
			.' Let's fight!
			|tip Nicki has 3 Mechanical type Pets. Use Elemental type attacks on her pets. Her pets are all around level 20.
			.' Defeat Nicki Tinytech |q 31922/1
		step
			goto Hellfire Peninsula 64.3,49.3
			.talk Nicki Tinytech##66550
			..turnin Nicki Tinytech##31922
		step
			goto Zangarmarsh 17.2,50.5
			.talk Ras'an##66551
			..accept Ras'an##31923
		step
			goto Zangarmarsh 17.2,50.5
			.talk Ras'an##66551
			|tip You will not be able to challenge Ras'an if you have the "Pet Recovery" debuff, wait for it to fall off. 
			.' Let's fight!
			|tip Ras'an has a Flying Pet, a Humanoid Pet, and a Magic Pet. Use Magic type attacks on his Flying pet, Undead type attacks on his Humanoid pet, and Dragonkin type attacks on his Magic pet. His pets are all around level 21.
			.' Defeat Ras'an |q 31923/1
		step
			goto Zangarmarsh 17.2,50.5
			.talk Ras'an##66551
			..turnin Ras'an##31923
		step
			goto Nagrand 61.0,49.4
			.talk Narrok##66552
			..accept Narrok##31924
		step
			goto Nagrand 61.0,49.4
			.talk Narrok##66552
			|tip You will not be able to challenge Narrok if you have the "Pet Recovery" debuff, wait for it to fall off. 
			.' Let's fight!
			|tip Narrok has an Aquatic Pet, a Beast Pet, and a Critter Pet. Use Flying type attacks on his Aquatic pet, Mechanical type attacks on his Beast pet, and Beast type attacks on his Critter pet. His pets are all around level 22.
			.' Defeat Narrok |q 31924/1
		step
			goto Nagrand 61.0,49.4
			.talk Narrok##66552
			..turnin Narrok##31924
		step
			goto Shattrath City 58.8,70.1
			.talk Morulu The Elder##66553
			..accept Morulu The Elder##31925
		step
			goto Shattrath City 58.8,70.1
			.talk Morulu The Elder##66553
			|tip You will not be able to challenge Morulu if you have the "Pet Recovery" debuff, wait for it to fall off. 
			.' Let's fight!
			|tip Morulu has 3 Aquatic type Pets. Use Flying type attacks on his pets. His pets are all around level 23.
			.' Defeat Morulu The Elder |q 31925/1
		step
			goto Shattrath City 58.8,70.1
			.talk Morulu The Elder##66553
			..turnin Morulu The Elder##31925
		step
			goto Shadowmoon Valley 30.6,42.0
			.talk Bloodknight Antari##66557
			..accept Grand Master Antari##31926
		step
			goto Shadowmoon Valley 30.6,42.0
			.talk Bloodknight Antari##66557
			|tip You will not be able to challenge Bloodknight Antari if you have the "Pet Recovery" debuff, wait for it to fall off. 
			.' Let's fight!
			|tip Bloodknight Antari has an Elemental Pet, a Dragonkin Pet, and a Magic Pet. Use Aquatic type attacks on his Elemental pet, Humanoid type attacks on his Dragonkin pet, and Dragonkin type attacks on his Magic pet. Your pets should all be around level 24.
			.' Defeat Bloodknight Antari |q 31926/1
		step
			goto Shadowmoon Valley 30.6,42.0
			.talk Bloodknight Antari##66557
			..turnin Grand Master Antari##31926
	]])
	ZygorGuidesViewer:RegisterGuide("GOLD\\Alliance Daily Runs\\Northrend Battle Pet Dailies Run",[[
		description This guide will take you through the Battle Pet Dailies in Northrend.
		meta goldtype="daily",levelreq=68,gold=99,time=30,icon="Interface\\ICONS\\PetJournalPortrait"
		condition valid completedq(31928)
		step
			goto Howling Fjord 28.6,33.9
			.talk Beegle Blastfuse##66635
			..accept Beegle Blastfuse##31931
		step
			goto Howling Fjord 28.6,33.9
			.talk Beegle Blastfuse##66635
			|tip You will not be able to challenge Beegle Blastfuse if you have the "Pet Recovery" debuff, wait for it to fall off. 
			.' Let's fight!
			|tip Beegle Blastfuse has an Aquatic Pet and 2 Flying Pets. Use Flying type attacks on his Aquatic pet and Magic attacks on his Flying pets. Your pets should all be around level 25 before fighting Beegle.
			.' Defeat Beegle Blastfuse |q 31931/1
		step
			goto Howling Fjord 28.6,33.9
			.talk Beegle Blastfuse##66635
			..turnin Beegle Blastfuse##31931
		step
			goto Dragonblight 59.0,77.0
			.talk Okrut Dragonwaste##66638
			..accept Okrut Dragonwaste##31933
		step
			goto Dragonblight 59.0,77.0
			.talk Okrut Dragonwaste##66638
			|tip You will not be able to challenge Okrut Dragonwaste if you have the "Pet Recovery" debuff, wait for it to fall off. 
			.' Let's fight!
			|tip Okrut Dragonwaste has a Dragonkin Pet and 2 Undead Pets. Use Humanoid type attacks on his Dragonkin and Critter type attacks on his Undead. Your pets should all be level 25 before fighting Okrut.
			.' Defeat Okrut Dragonwaste |q 31933/1
		step
			goto Dragonblight 59.0,77.0
			.talk Okrut Dragonwaste##66638
			..accept Okrut Dragonwaste##31933
		step
			goto Crystalsong Forest 50.1,59.0
			.talk Nearly Headless Jacob##66636
			..accept Nearly Headless Jacob##31932
		step
			goto Crystalsong Forest 50.1,59.0
			.talk Nearly Headless Jacob##66636
			|tip You will not be able to challenge Nearly Headless Jacob if you have the "Pet Recovery" debuff, wait for it to fall off. 	
			.' Let's fight!
			|tip Nearly Headless Jacob has 3 Undead Pets. Critter type attacks will be the most useful against Jacob. You should also consider having an Aquatic pet or two. Your pets should all be level 25.
			.' Defeat Nearly Headless Jacob |q 31932/1
		step
			goto Crystalsong Forest 50.1,59.0
			.talk Nearly Headless Jacob##66636
			..turnin Nearly Headless Jacob##31932
		step
			goto Icecrown 77.4,19.6
			.talk Major Payne##66675
			..accept Grand Master Payne##31935
		step
			goto Icecrown 77.4,19.6
			.talk Major Payne##66675
			|tip You will not be able to challenge Major Payne if you have the "Pet Recovery" debuff, wait for it to fall off. 	
			.' Let's fight!
			|tip Major Payne has a Beast Pet, a Mechanical Pet, and an Elemental Pet. Use Mechanical type attacks on his Beast, Elemental type attacks on his Mechanical, and Aquatic type attacks on his Elemental. Your pets should be level 25 for this fight.
			.' Defeat Major Payne |q 31935/1
		step
			goto Icecrown 77.4,19.6
			.talk Major Payne##66675
			..accept Grand Master Payne##31935
		step
			goto Zul'Drak 13.2,66.8
			.talk Gutretch##66639
			..accept Gutretch##31934
		step
			goto Zul'Drak 13.2,66.8
			.talk Gutretch##66639
			|tip You will not be able to challenge Gutretch if you have the "Pet Recovery" debuff, wait for it to fall off. 	
			.' Let's fight!
			|tip Gutretch has 2 Beast type Pets and a Critter type Pet. Use Mechanical type attacks on his Beasts and Beast type attacks on his Critter. Your pets should all be level 25 for this fight.
			.' Defeat Gutretch |q 31934/1
		step
			goto Zul'Drak 13.2,66.8
			.talk Gutretch##66639
			..turnin Gutretch##31934
	]])
	ZygorGuidesViewer:RegisterGuide("GOLD\\Alliance Daily Runs\\Cataclysm Battle Pet Dailies Run",[[
		description This guide will take you through the Battle Pet Dailies in the Cataclysm Expansion.
		meta goldtype="daily",levelreq=80,gold=79,time=15,icon="Interface\\ICONS\\PetJournalPortrait"
		condition valid completedq(31970)
		step
			goto Mount Hyjal 61.4,32.7
			.talk Brok##66819
			..accept Brok##31972
		step
			goto Mount Hyjal 61.4,32.7
			.talk Brok##66819
			|tip You will not be able to challenge Brok if you have the "Pet Recovery" debuff, wait for it to fall off. 	
			.' Let's fight!
			|tip Brok has a Beast Pet, a Critter Pet, and a Magic Pet. Use Mechanical type attacks on his Beast, Beast type attacks on his Critter, and Dragonkin type attacks on his Magic. Your pets should all be level 25.
			.' Defeat Brok |q 31972/1
		step
			goto Mount Hyjal 61.4,32.7
			.talk Brok##66819
			..turnin Brok##31972
		step
			goto Deepholm 49.9,57.0
			.talk Bordin Steadyfist##66815
			..accept Bordin Steadyfist##31973
		step
			goto Deepholm 49.9,57.0
			.talk Bordin Steadyfist##66815
			|tip You will not be able to challenge Bordin Steadyfist if you have the "Pet Recovery" debuff, wait for it to fall off. 	
			.' Let's fight!
			|tip Bordin Steadyfist has a Critter Pet and 2 Elemental Pets. Use Beast type attacks on his Critter and Aquatic type attacks on his Elementals. Your pets should all be level 25.
			.' Defeat Bordin Steadyfist |q 31973/1
		step
			goto Deepholm 49.9,57.0
			.talk Bordin Steadyfist##66815
			..turnin Bordin Steadyfist##31973
		step
			goto Twilight Highlands 56.6,56.8
			.talk Goz Banefury##66822
			..accept Goz Banefury##31974
		step
			goto Twilight Highlands 56.6,56.8
			.talk Goz Banefury##66822
			|tip You will not be able to challenge Goz Banefury if you have the "Pet Recovery" debuff, wait for it to fall off. 	
			.' Let's fight!
			|tip Goz Banefury has a Beast Pet, an Elemental Pet, and a Magic Pet. Use Mechanical type attacks on his Beast, Aquatic type attacks on his Elemental, and Dragonkin type attacks on his Magic. Your pets should all be level 25.
			.' Defeat Goz Banefury |q 31974/1
		step
			goto Twilight Highlands 56.6,56.8
			.talk Goz Banefury##66822
			..turnin Goz Banefury##31974
		step
			goto Uldum 56.5,42.0
			.talk Obalis##66824
			..accept Grand Master Obalis##31971
		step
			goto Uldum 56.5,42.0
			.talk Obalis##66824
			|tip You will not be able to challenge Obalis if you have the "Pet Recovery" debuff, wait for it to fall off. 	
			.' Let's fight!
			|tip Obalis has a Beast Pet, a Flying Pet, and a Critter Pet. Use Mechanical type attacks on his Beast, Magic type attacks on his Flyer, and Beast type attacks on his Critter. Your pets should all be level 25.
			.' Defeat Obalis |q 31971/1
		step
			goto Uldum 56.5,42.0
			.talk Obalis##66824
			..turnin Grand Master Obalis##31971
	]])
	ZygorGuidesViewer:RegisterGuide("GOLD\\Alliance Daily Runs\\Pandaria Battle Pet Dailies Run",[[
		description This guide will take you through the Battle Pet Dailies in Eastern Kingdoms.
		meta goldtype="daily",levelreq=85,gold=139,time=30,icon="Interface\\ICONS\\PetJournalPortrait"
		condition valid completedq(31970)
		step
			goto The Jade Forest 48.0,54.2
			.talk Hyuna of the Shrines##66730
			..accept Grand Master Hyuna##31953
		step
			goto The Jade Forest 48.0,54.2
			.talk Hyuna of the Shrines##66730
			|tip You will not be able to challenge Hyuna of the Shrines if you have the "Pet Recovery" debuff, wait for it to fall off.
			.' Let's fight!
			|tip Hyuna of the Shrines has a Beast Pet, a Flying Pet, and an Aquatic Pet. Use Mechanical type attacks on her Beast, Magic type attacks on her Flyer, and Flying type attacks on her Aquatic. Your pets should all be level 25.
			.' Defeat Hyuna of the Shrines |q 31953/1
		step
			goto The Jade Forest 48.0,54.2
			.talk Hyuna of the Shrines##66730
			..turnin Grand Master Hyuna##31953
		step
			goto Vale of Eternal Blossoms 31.2,74.0
			.talk Aki the Chosen##66741
			..accept Zen Master Aki##31958
		step
			goto Vale of Eternal Blossoms 31.2,74.0
			.talk Aki the Chosen##66741
			|tip You will not be able to challenge Aki the Chosen if you have the "Pet Recovery" debuff, wait for it to fall off.
			.' Let's fight!
			|tip Aki the Chosen has an Aquatic Pet, a Critter Pet, and a Dragonkin Pet. Use Flying type attacks on her Aquatic, Beast type attacks on her Critter, and Humanoid type attacks on her Dragonkin. Your pets should all be level 25.
			.' Defeat Aki the Chosen |q 31958/1
		step
			goto Vale of Eternal Blossoms 31.2,74.0
			.talk Aki the Chosen##66741
			..turnin Zen Master Aki##31958
		step
			goto Kun-Lai Summit 35.8,73.8 
			.talk Courageous Yon##66738
			..accept Grand Master Yon##31956
		step
			goto Kun-Lai Summit 35.8,73.8 
			.talk Courageous Yon##66738
			|tip You will not be able to challenge Courageous Yon if you have the "Pet Recovery" debuff, wait for it to fall off.
			.' Let's fight!
			|tip Courageous Yon has a Flying Pet, and two Critter Pets. Use Beast type attacks on his Critters, and Magic type attacks on his Flying. Your pets should all be level 25.
			.' Defeat Courageous Yon |q 31956/1
			.' He can also be found at [44.7,52.4]
		step
			goto Kun-Lai Summit 35.8,73.8 
			.talk Courageous Yon##66738
			..turnin Grand Master Yon##31956
		step
			goto Townlong Steppes 36.3,52.2
			.talk Seeker Zusshi##66918
			..accept Grand Master Zusshi##31991
		step
			goto Townlong Steppes 36.3,52.2
			.talk Seeker Zusshi##66918
			|tip You will not be able to challenge Seeker Zusshi if you have the "Pet Recovery" debuff, wait for it to fall off.
			.' Let's fight!
			|tip Seeker Zusshi has an Aquatic Pet, a Critter Pet, and an Elemental Pet. Use Flying type attacks on his Aquatic, Aquatic type attacks on his Elemental, and Beast type attacks on his Critter. Your pets should all be level 25.
			.' Defeat Seeker Zusshi |q 31991/5
		step
			goto Townlong Steppes 36.3,52.2
			.talk Seeker Zusshi##66918
			..turnin Grand Master Zusshi##31991
		step
			goto Dread Wastes 55.1,37.6
			.talk Wastewalker Shu##66739
			..accept Grand Master Shu##31957
		step
			goto Dread Wastes 55.1,37.6
			.talk Wastewalker Shu##66739
			|tip You will not be able to challenge Wastewalker Shu if you have the "Pet Recovery" debuff, wait for it to fall off.
			.' Let's fight!
			|tip Wastewalker Shu has an Aquatic Pet, a Beast Pet, and an Elemental Pet. Use Flying type attacks on his Aquatic, Aquatic type attacks on his Elemental, and Mechanical type attacks on his Beast. Your pets should all be level 25.
			.' Defeat Wastewalker Shu |q 31957/1
		step
			goto Dread Wastes 55.1,37.6
			.talk Wastewalker Shu##66739
			..turnin Grand Master Shu##31957
		step
			goto Krasarang Wilds 62.2,45.9
			.talk Mo'ruk##66733
			..accept Mo'ruk##31954
		step
			goto Krasarang Wilds 62.2,45.9
			.talk Mo'ruk##66733
			|tip You will not be able to challenge Mo'ruk if you have the "Pet Recovery" debuff, wait for it to fall off.
			.' Let's fight!
			|tip Mo'ruk has a Beast Pet, a Flying Pet, and an Aquatic Pet. Use Mechanical type attacks on his Beast, Magic type attacks on his Flyer, and Flying type attacks on his Aquatic. Your pets should all be level 25.
			.' Defeat Mo'ruk |q 31954/1
		step
			goto Krasarang Wilds 62.2,45.9
			.talk Mo'ruk##66733
			..turnin Mo'ruk##31954
		step
			goto Valley of the Four Winds 46.0,43.7
			.talk Farmer Nishi##66734
			..accept Grand Master Nishi##31955
		step
			goto Valley of the Four Winds 46.0,43.7
			.talk Farmer Nishi##66734
			|tip You will not be able to challenge Farmer Nishi if you have the "Pet Recovery" debuff, wait for it to fall off.
			.' Let's fight!
			|tip Farmer Nishi has a Beast Pet, and two Elemental Pets. Use Mechanical type attacks on her Beast, and Aquatic type attacks on her Elementals. Your pets should all be level 25.
			.' Defeat Farmer Nishi |q 31955/1
		step
			goto Valley of the Four Winds 46.0,43.7
			.talk Farmer Nishi##66734
			..turnin Grand Master Nishi##31955
	]])
	ZygorGuidesViewer:RegisterGuide("GOLD\\Alliance Daily Runs\\Pandaren Spirits Battle Pet Dailies Run",[[
		description This guide will take you through the Battle Pet Dailies in Eastern Kingdoms.
		meta goldtype="daily",levelreq=90,gold=79,time=30,icon="Interface\\ICONS\\PetJournalPortrait"
		condition valid completedq(32428)
		step
			goto The Jade Forest 28.8,36.0
			.talk Whispering Pandaren Spirit##68464
			..accept Whispering Pandaren Spirit##32440
		step
			goto The Jade Forest 28.8,36.0
			.talk Whispering Pandaren Spirit##68464
			.' Challenge him to a pet battle and defeat him. |q 32440/1
		step
			goto The Jade Forest 28.8,36.0
			.talk Whispering Pandaren Spirit##68464
			..turnin Whispering Pandaren Spirit##32440
		step
			goto Kun-Lai Summit/0 65.0,93.9
			.talk Thundering Pandaren Spirit##68465
			..accept Thundering Pandaren Spirit##32441
		step
			goto Kun-Lai Summit/0 65.0,93.9
			.talk Thundering Pandaren Spirit##68465
			.' Challenge him to a pet battle and defeat him. |q 32441/1
		step
			goto Kun-Lai Summit/0 65.0,93.9
			.talk Thundering Pandaren Spirit##68465
			..turnin Thundering Pandaren Spirit##32441
		step
			goto Townlong Steppes 57.0,42.2
			.talk Burning Pandaren Spirit##68463
			..accept Burning Pandaren Spirit##32434
		step
			goto Townlong Steppes 57.0,42.2
			.talk Burning Pandaren Spirit##68463
			.' Challenge him to a pet battle and defeat him. |q 32434/1
		step
			goto Townlong Steppes 57.0,42.2
			.talk Burning Pandaren Spirit##68463
			..turnin Burning Pandaren Spirit##32434
		step
			goto Dread Wastes 61.2,87.6
			.talk Flowing Pandaren Spirit##68462
			..accept Flowing Pandaren Spirit##32439
		step
			goto Dread Wastes 61.2,87.6
			.talk Flowing Pandaren Spirit##68462
			.' Challenge him to a pet battle and defeat him. |q 32439/1
		step
			goto Dread Wastes 61.2,87.6
			.talk Flowing Pandaren Spirit##68462
			..turnin Flowing Pandaren Spirit##32439
	]])
	ZygorGuidesViewer:RegisterGuide("GOLD\\Alliance Daily Runs\\Beasts of Fable Battle Pet Dailies Run",[[
		description This guide will take you through the Beasts of Fable Daily Questline.
		meta goldtype="daily",levelreq=90,gold=59,time=30,icon="Interface\\ICONS\\PetJournalPortrait"
		step
			goto Vale of Eternal Blossoms 86.6,60.0
			.talk Sara Finkleswitch##64572
			..accept Beasts of Fable Book I##32604
			..accept Beasts of Fable Book II##32868
			..accept Beasts of Fable Book III##32869
		step
			goto Vale of Eternal Blossoms 11.0,70.9
			.' _No-No_
			.' This enemy is aquatic.
			.' It is strong against undead and weak to flying attacks.
			.' I would suggest that you use flying pets against this enemy.
			.' No-No defeated |q 32869/2
			'|modelnpc 68559
		step
			goto Valley of the Four Winds 40.5,43.7
			.' _Lucky Yi_
			.' This enemy is a critter.
			.' Is is strong against Elementals and weak to beast attacks.
			.' I would suggest using beast pets against this enemy.
			.' Lucky Yi defeated |q 32868/2
			'|modelnpc 68561
		step
			goto Valley of the Four Winds 25.3,78.5
			.' _Greyhoof_
			.' This enemy is a beast.
			.' It is strong against humanoids and weak against mechanical pets.
			.' I would suggest using a team of mechanical pets against this enemy.
			.' Greyhoof defeated |q 32868/1
			'|modelnpc 68560
		step
			goto Krasarang Wilds 36.3,37.3
			.' _Skitterer Xi'a_
			.' This enemy is aquatic.
			.' It is strong against undead and weak to flying pets.
			.' I would suggest using flying pets against this enemy.
			.' Xi'a defeated |q 32868/3
			'|modelnpc 68566
		step
			goto Dread Wastes 26.1,50.2
			.' _Gorespine_
			.' This enemy is a beast.
			.' It is strong against humanoids and weak against mechanical pets.
			.' I would suggest using a team of mechanical pets against this enemy.
			.' Gorespine defeated |q 32869/1
			'|modelnpc 68558
		step
			goto Townlong Steppes 72.3,79.8
			.' _Ti'un the Wanderer_
			.' This enemy is aquatic.
			.' It is strong against undead and weak to flying pets.
			.' I would suggest using flying pets against this enemy.
			.' Ti'un the Wanderer defeated |q 32869/3
			'|modelnpc 68562
		step
			goto Kun-Lai Summit 35.2,56.2
			.' This enemy is a beast.
			.' It is strong against humanoids and weak against mechanical pets.
			.' I would suggest using a team of mechanical pets against this enemy.
			.' Kafi defeated |q 32604/2
			'|modelnpc 68563
		step
			goto Kun-Lai Summit 67.9,84.7
			.' _Dos-Ryga_
			.' This enemy is aquatic.
			.' It is strong against undead and weak to flying pets.
			.' I would suggest using flying pets against this enemy.
			.' Dos-Ryga defeated |q 32604/3
			'|modelnpc 68564
		step
			goto The Jade Forest 48.4,71.0
			.' _Ka'wi the Gorger_
			.' This enemy is a beast.
			.' It is strong against humanoids and weak against mechanical pets.
			.' I would suggest using a team of mechanical pets against this enemy.
			.' Ka'wi the Gorger defeated |q 32604/1
			'|modelnpc 68555
		step
			goto The Jade Forest 57.0,29.1
			.' _Nitun_
			.' This enemy is a critter.
			.' Is is strong against Elementals and weak to beast attacks.
			.' I would suggest using beast pets against this enemy.
			.' Nitun defeated |q 32604/4
			'|modelnpc 68565
		step
			goto Vale of Eternal Blossoms 86.6,60.0
			.talk Sara Finkleswitch##64572
			..turnin Beasts of Fable Book I##32604
			..turnin Beasts of Fable Book II##32868
			..turnin Beasts of Fable Book III##32869
	]])
end



-- VENDOR RUNS

if UnitFactionGroup("player")=="Alliance" then
ZygorGuidesViewer:RegisterGuide("GOLD\\Alliance Vendor Runs\\Kalimdor Vendor Run",[[
		description This guide will take you through Vendor Runs
		meta goldtype="vendor",time=30,icon="Interface\\ICONS\\Achievement_Zone_Kalimdor_01"
		step
			goto The Exodar 64.6,68.6
			.talk Neii##16767
			..buy 1 Pattern: Bolt of Soulcloth##21894
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto The Exodar 66.6,74.0
			.talk Haferet##16748
			..buy 1 Pattern: Comfortable Insoles##25726
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto The Exodar 61.0,89.0
			.talk Arras##16713
			..buy 1 Plans: Adamantite Rapier##23593
			..buy 1 Plans: Adamantite Dagger##23592
			..buy 1 Plans: Adamantite Cleaver##23591
			..buy 1 Plans: Adamantite Maul##23590
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto The Exodar 53.0,90.0
			.talk Feera##16657
			..buy 1 Schematic: Adamantite Rifle##23799
			..buy 1 Schematic: White Smoke Flare##23811
			..buy 1 Schematic: Fel Iron Toolbox##23816
			..buy 1 Gyrochronatom##4389
			..buy 1 Bronze Framework##4382
			..buy 2 Bronze Tube##4371
			..buy 3 Silver Contact##4404
			..buy 4 Coarse Blasting Powder##4364
			..buy 4 Rough Blasting Powder##4357
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto The Exodar 28.0,62.1
			.talk Altaa##16705
			..buy 1 Recipe: Transmute Primal Might##23574
			..buy 1 Recipe: Elixir of Camouflage##22900
			..buy 1 Liferoot##3357
			..buy 1 Kingsblood##3356
			..buy 1 Wild Steelbloom##3355
			..buy 2 Bruiseweed##2453
			..buy 3 Earthroot##2449
			..buy 2 Mageroyal##785
			..buy 2 Peacebloom##2447
			..buy 3 Silverleaf##765
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto The Exodar 39.8,40.2
			.talk Egomis##16722
			..buy 1 Formula: Superior Wizard Oil##22563
			..buy 1 Formula: Large Prismatic Shard##22565
			..buy 1 Formula: Superior Mana Oil##22562
			..buy 2 Lesser Magic Essence##10938
			..buy 4 Strange Dust##10940
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto The Exodar 45.0,25.6
			.talk Arred##17512
			..buy 1 Design: Opal Necklace of Impact##21948
			..buy 1 Design: The Jade Eye##20975
			..buy 1 Design: Heavy Golden Necklace of Battle##20856
			..buy 1 Design: Amulet of the Moon##20854
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Darnassus 56.6,52.6
			.talk Layna Karner##52641
			..buy 1 Plans: Hardened Iron Shortsword##12162
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Darnassus 54.6,39.6
			.talk Ulthir##4226
			..buy 2 Recipe: Great Rage Potion##5643
			..buy 1 Recipe: Free Action Potion##5642
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Darnassus 58.2,35.0
			.talk Mythrin'dir##4229
			..buy 1 Formula: Enchant Bracer - Dodge##11223
			..buy 1 Design: Amulet of the Moon##20854
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Darnassus 60.0,37.2
			.talk Saenorion##4225
			..buy 1 Pattern: Green Whelp Bracers##7451
			..buy 1 Pattern: Barbaric Bracers##18949
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Darnassus 60.4,36.8
			.talk Elynna##4168
			..buy 1 Pattern: Orange Martial Shirt##10311
			..buy 1 Pattern: Greater Adept's Robe##6275
			..buy 1 Pattern: Blue Linen Robe##6272
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Moonglade 48.3,40.2
			.talk Lorelae Wintersong##12022
			..buy 1 Formula: Enchant Cloak - Superior Defense##16224
			..buy 1 Pattern: Felcloth Pants##14483
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Winterspring 59.7,49.3
			.talk Qia##11189
			..buy 1 Design: Necklace of the Diamond Tower##21957
			..buy 1 Pattern: Frostsaber Boots##15740
			..buy 1 Formula: Enchant Chest - Major Health##16221
			..buy 1 Pattern: Runecloth Bag##14468
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Winterspring 59.2,50.9
			.talk Daleohm##50129
			..buy 1 Plans: Frostguard##12836
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Winterspring 59.2,50.8
			.talk Xizzer Fizzbolt##11185
			..buy 1 Schematic: Delicate Arcanite Converter##16050
			..buy 1 Schematic: Powerful Seaforium Charge##18656
			..buy 1 Schematic: Masterwork Target Dummy##16046
			..buy 1 Schematic: Gyrofreeze Ice Reflector##18652
			..buy 1 Gyrochronatom##4389
			..buy 1 Bronze Framework##4382
			..buy 2 Bronze Tube##4371
			..buy 3 Silver Contact##4404
			..buy 4 Coarse Blasting Powder##4364
			..buy 4 Rough Blasting Powder##4357
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Winterspring 61.6,87.6
			.talk Vi'el##16015
			..buy 2 Felcloth##14256
			..buy 4 Gromsblood##8846
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Ashenvale 34.8,49.8
			.talk Lardan##3958
			..buy 1 Pattern: Barbaric Leggings##5973
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Ashenvale 35.0,52.0
			.talk Dalria##3954
			..buy 1 Formula: Enchant Bracer - Lesser Strength##11101
			..buy 1 Formula: Enchant Cloak - Minor Agility##11039
			..buy 1 Design: Wicked Moonstone Ring##20855
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Ashenvale 18.2,60.0
			.talk Harlown Darkweave##34601
			..buy 1 Pattern: Herbalist's Gloves##7361
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Northern Barrens 68.4,69.2
			.talk Gagsprocket##3495
			..buy 1 Schematic: Minor Recombobulator##14639
			..buy 1 Schematic: Green Firework##18648
			..buy 1 Gyrochronatom##4389
			..buy 1 Bronze Framework##4382
			..buy 2 Bronze Tube##4371
			..buy 3 Silver Contact##4404
			..buy 4 Coarse Blasting Powder##4364
			..buy 4 Rough Blasting Powder##4357
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Northern Barrens 67.0,73.4
			.talk Ranik##3499
			..buy 1 Design: Wicked Moonstone Ring##20855
			..buy 1 Pattern: Great Adept's Robe##6275
			..buy 2 Recipe: Rage Potion##5640
			..buy 1 Pattern; Blue Linen Robe##6272
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Dustwallow Marsh 66.4,51.4
			.talk Helenia Olden##4897
			..buy 1 Design: Truesilver Crab##21943
			..buy 1 Design: Black Pearl Panther##21941
			..buy 1 Pattern: Murloc Scale Bracers##5789
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Tanaris 50.8,28.0
			.talk Alchemist Pestlezugg##5594
			..buy 1 Recipe: Nature Protection Potion##6057
			..buy 1 Recipe: Transmute Mithril to Truesilver##9305
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Tanaris 50.7,28.7
			.talk Vizzklick##6568
			..buy 1 Pattern: Crimson Silk Robe##7088
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Tanaris 50.7,28.6
			.talk Haughty Modiste##40572
			..buy 1 Pattern: Dress Shoes##37915
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Tanaris 50.7,28.5
			.talk Blizrik Buckshot##8131
			..buy 1 Schematic: EZ-Thro Dynamite II##18650
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Tanaris 51.15,30.4
			.talk Krinkle Goodsteel##5411
			..buy 1 Plans: Golden Scale Coif##6047
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Un'Goro Crater 54.8,62.6
			.talk Nergal##12959
			..buy 1 Pattern: Devilsaur Leggings##15772
			..buy 1 Pattern: Devilsaur Gauntlets##15758
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Silithus 81.4,18.4
			.talk Zannok Hidepiercer##12956
			..buy 1 Pattern: Heavy Scorpid Helm##15762
			..buy 1 Heavy Scorpid Bracers##15724
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Silithus 55.5,36.8
			.talk Calandrath##15174
			..buy 1 Recipe: Greater Nature Protection Potion##13496
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Silithus 53.8,34.4
			.talk Mishta##15179
			..buy 1 Design: Emerald Crown of Destruction##21952
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Feralas 46.8,43.2
			.talk Logannas##8157
			..buy 1 Recipe: Ghost Dye##9302
			..buy 1 Recipe: Nature Protection Potion##6057
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Feralas 45.4,41.2
			.talk Pratt McGrubben##40226
			..buy 1 Pattern: Living Shoulders##15734
			..buy 1 Pattern: Turtle Scale Gloves##8385
			..buy 1 Pattern: Green Whelp Bracers##7451
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
	]])
	ZygorGuidesViewer:RegisterGuide("GOLD\\Alliance Vendor Runs\\Eastern Kingdoms Vendor Run",[[
		meta goldtype="vendor",time=45,icon="Interface\\ICONS\\Achievement_Zone_EasternKingdoms_01"
		step
			goto The Cape of Stranglethorn 40.8,82.2
			.talk Cowardly Crosby##2672
			..buy 1 Pattern: Admiral's Hat##10318
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto The Cape of Stranglethorn 42.6,74.8
			.talk Glyx Brewright##2848
			..buy 1 Recipe: Frost Protection Potion##6056
			..buy 1 Recipe: Nature Protection Potion##6057
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto The Cape of Stranglethorn 41.6,74.0
			.talk Jutak##2843
			..buy 1 Plans: Hardened Iron Shortsword##12162
			..buy 1 Daring Dirk##12248
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto The Cape of Stranglethorn 42.8,74.0
			.talk Blixrez Goodstitch##2846
			..buy 1 Pattern: Murloc Scale Bracers##5789
			..buy 1 Pattern: Thick Murloc Armor##5788
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto The Cape of Stranglethorn 42.6,72.8
			.talk Mrs. Gant##54232
			..buy 1 Recipe: Undermine Clam Chowder##16767
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto The Cape of Stranglethorn 43.0,72.8
			.talk Crazk Sparks##2838
			..buy 1 Schematic: Green Firework##18648
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto The Cape of Stranglethorn 43.6,73.0
			.talk Xizk Goodstitch##2670
			..buy 1 Pattern: Enchanter's Cowl##14630
			..buy 1 Pattern: Crimson Silk Cloak##7087
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto The Cape of Stranglethorn 43.2,71.6
			.talk Rikqiz##2699
			..buy 1 Pattern: Shadowskin Gloves##18239
			..buy 1 Pattern: Gem-Studded Leather Belt##14635
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto The Cape of Stranglethorn 43.0,70.6
			.talk Zarena Cromwind##2482
			..buy 1 Plans: Moonsteel Broadsword
			..buy 1 Big Stick##12251
			..buy 1 Staff of Protection##12252
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto The Cape of Stranglethorn 42.6,69.2
			.talk Narkk##2663
			..buy 1 Pattern: Black Swashbuckler's Shirt##10728
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Northern Stranglethorn 67.6,61.0
			.talk Knaz Blunderflame##8679
			..buy 1 Schematic: Deadly Scope##10602
			..buy 1 Gyrochronatom##4389
			..buy 1 Bronze Framework##4382
			..buy 2 Bronze Tube##4371
			..buy 3 Silver Contact##4404
			..buy 4 Coarse Blasting Powder##4364
			..buy 4 Rough Blasting Powder##4357
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Northern Stranglethorn 67.6,61.0
			.talk Gnaz Blunderflame##2687
			..buy 1 Schematic: Deadly Scope##13311
			..buy 1 Gyrochronatom##4389
			..buy 1 Bronze Framework##4382
			..buy 2 Bronze Tube##4371
			..buy 3 Silver Contact##4404
			..buy 4 Coarse Blasting Powder##4364
			..buy 4 Rough Blasting Powder##4357
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Northern Stranglethorn 43.6,23.0
			.talk Jaquilina Dramet##2483
			..buy 1 Plans: Massive Iron Axe##12164
			..buy 1 Midnight Axe##12250
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Westfall 57.6,53.8
			.talk Gina MacGregor##843
			..buy 1 Pattern: Blue Overalls##6274
			..buy 1 Pattern: Murloc Scale Breastplate##5787
			..buy 1 Pattern: Murloc Scale Belt##5786
			..buy 1 Pattern: Red Linen Bag##5771
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Duskwood 75.6,45.4
			.talk Sheri Zipstitch##2669 |tip On the top floor of this building.
			..buy 1 Pattern: Dark Silk Shirt##6401
			..buy 1 Pattern: Blue Overalls##6274
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Duskwood 75.8,45.4
			.talk Danielle Zipstitch##2668 |tip On the top floor of this building.
			..buy 1 Pattern: Bright Yellow Shirt##14627
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Duskwood 81.8,19.8
			.talk Kzixx##3134
			..buy 1 Schematic: Goblin Jumper Cables##7561
			..buy 1 Recipe: Holy Protection Potion##6053
			..buy 1 Strength of Will##4837
			..buy 1 Dreamer's Belt##4829
			..buy 1 Fireproof Orb##4836
			..buy 1 Wizard's Belt##4827
			..buy 1 Nightwind Belt##4828
			..buy 1 Orb of Power##4838
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Blasted Lands 62.4,16.0
			.talk Nina Lightbrew##8178
			..buy 1 Recipe: Elixir of Demonslaying##9300
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Redridge Mountains 78.6,63.6
			.talk Clyde Ranthal##2697
			..buy 1 Pattern: Black Whelp Cloak##7289
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Redridge Mountains 28.2,43.4
			.talk Amy Davenport##777
			..buy 1 Pattern: Red Woolen Bag##5772
			..buy 1 Pattern: Black Whelp Tunic##20576
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Elwynn Forest 83.2,66.6
			.talk Drake Lindgren##1250
			..buy 1 Pattern: Blue Linen Robe##6272
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Elwynn Forest 42.6,66.6
			.talk Antonio Perelli##844
			.' Note: He patrols between this spot and [75.0,72.4].
			..buy 1 Liferoot##3357
			..buy 1 Bear Bracers##4795
			..buy 1 Owl Bracers##4796
			..buy 1 Wolf Bracers##4794
			..buy 1 Executioner's Sword##4818
			..buy 1 Kingsblood##3356
			..buy 1 Wild Steelbloom##3355
			..buy 2 Blessed Claymore##4817
			..buy 2 Bruiseweed##2453
			..buy 1 Heavy Spiked Mace##4778
			..buy 1 Ironwood Maul##4777
			..buy 3 Earthroot##2449
			..buy 2 Mageroyal##785
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Elwynn Forest 42.0,67.0
			.talk Tharynn Bouden##66
			..buy 1 Pattern: Blue Linen Vest##6270
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Stormwind City 69.4,71.6
			.talk Bernard Gump##1302
			..buy 1 Liferoot##3357
			..buy 1 Wild Steelbloom##3355
			..buy 2 Bruiseweed##2453
			..buy 2 Earthroot##2449
			..buy 2 Mageroyal##785
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Stormwind City 64.6,71.6
			.talk Edna Mullby##1286
			..buy 1 Design: Heavy Golden Necklace of Battle##20856
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Stormwind City 55.6,85.6
			.talk Maria Lumere##1313
			..buy 1 Recipe: Elixir of Shadow Power##9301
			..buy 1 Liferoot##3357
			..buy 1 Wild Steelbloom##3355
			..buy 1 Kingsblood##3356
			..buy 2 Bruiseweed##2453
			..buy 6 Earthroot##2449
			..buy 2 Mageroyal##785
			..buy 3 Peacebloom##2447
			..buy 3 Silverleaf##765
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Stormwind City 53.2,81.6
			.talk Alexandra Bolero##1347
			..buy 1 Pattern: White Wedding Dress##10325
			..buy 1 Pattern: Blue Overalls##6274
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Stormwind City 42.6,76.8
			.talk Darian Singh##1304
			..buy 1 Schematic: Blue Firework##18649
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Stormwind City 63.2,37.6
			.talk Kaita Deepforge##5512
			..buy 1 Plans: Hardened Iron Shortsword##12162
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm

		step
			goto Badlands 65.0,38.8
			.talk "Chef" Overheat##48060
			..buy 3 Recipe: Undermine Clam Chowder##16767
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Badlands 91.0,38.4
			.talk Buckslappy##49918
			..buy 1 Schematic: EZ-Thro Dynamite II##18650
			..buy 1 Schematic: Green Firework##18648
			..buy 1 Red Firework##18647
			..buy 1 Blue Firework##18649
			..buy 1 Gyrochronatom##4389
			..buy 1 Bronze Framework##4382
			..buy 2 Bronze Tube##4371
			..buy 3 Silver Contact##4404
			..buy 4 Coarse Blasting Powder##4364
			..buy 3 Rough Blasting Powder##4357
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Loch Modan 82.6,63.2
			.talk Xandar Goodbeard##1685
			..buy 1 Recipe: Holy Protection Potion##6053
			..buy 1 Recipe: Rage Potion##5640
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Loch Modan 36.0,46.0
			.talk Rann Flamespinner##1474
			..buy 1 Pattern: Greater Adept's Robe##6275
			..buy 1 Pattern: Red Woolen Bag##5772
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Dun Morogh 17.8,74.6
			.talk High Admiral "Shelly" Jorrik##26081
			..buy 1 Plans: Solid Iron Maul##10858
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Ironforge 67.2,53.4
			.talk Soolie Berryfizz##5178
			..buy 1 Recipe: Elixir of Superior Defense##13478
			..buy 1 Recipe: Free Action Potion##5642
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Ironforge 68.2,44.0
			.talk Gearcutter Cogspinner##5175
			..buy 1 Schematic: Blue Firework##18649
			..buy 1 Schematic: Gnomish Universal Remote##7560
			..buy 1 Gyrochronatom##4389
			..buy 1 Bronze Framework##4382
			..buy 2 Bronze Tube##4371
			..buy 3 Silver Contact##4404
			..buy 4 Coarse Blasting Powder##4364
			..buy 4 Rough Blasting Powder##4357
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Ironforge 61.6,44.8
			.talk Tilli Thistlefuzz##5158
			..buy 1 Formula: Enchant 2H Weapon - Lesser Intellect##6349
			..buy 2 Lesser Magic Essence##10938
			..buy 4 Strange Dust##10940
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Ironforge 46.6,28.6
			.talk Burbik Gearspanner##5163
			..buy 1 Design: Opal Necklace of Impact##21948
			..buy 1 Design: The Jade Eye##20975
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Ironforge 44.2,29.6
			.talk Outfitter Eric##8681
			..buy 1 Pattern: Tuxedo Jacket##10326
			..buy 1 Pattern: Tuxedo Pants##10323
			..buy 1 Pattern: Tuxedo Shirt##10321
			..buy 1 Pattern: Pink Mageweave Shirt##10317
			..buy 1 Pattern: Lavender Mageweave Shirt##10314
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Ironforge 40.2,33.4
			.talk Bombus Finespindle##5128
			..buy 1 Pattern: Heavy Leather Ball##18731
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Wetlands 10.0,59.0
			.talk Jennabink Powerseam##1454
			..buy 1 Dreamer's Belt##4829
			..buy 1 Inferno Cloak##4790
			..buy 1 Nightwind Belt##4828
			..buy 1 Spirit Cloak##4792
			..buy 1 Sylvan Cloak##4793
			..buy 1 Wizard's Belt##4827
			..buy 1 Pattern: Greater Adept's Robe##6275
			..buy 1 Pattern: Red Woolen Bag##5772
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Wetlands 25.6,25.8
			.talk Wenna Silkbeard##2679
			..buy 1 Pattern: Green Leather Armor##7613
			..buy 1 Elite Shoulders##4835
			..buy 1 Dreamer's Belt##4829
			..buy 1 Mystic Sarong##4832
			..buy 1 Pattern: Azure Silk Gloves##7114
			..buy 1 Saber Leggings##4830
			..buy 1 Glorious Shoulders##4833
			..buy 1 Wizard's Belt##4827
			..buy 1 Nightwind Belt##4828
			..buy 1 Stalking Pants##4831
			..buy 1 Pattern: Red Whelp Gloves##7290
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Wetlands 26.8,26.0
			.talk Fradd Swiftgear##41435
			..buy 1 Schematic: Minor Recombobulator##14639
			..buy 1 Gyrochronatom##4389
			..buy 1 Bronze Framework##4382
			..buy 2 Bronze Tube##4371
			..buy 3 Silver Contact##4404
			..buy 4 Coarse Blasting Powder##4364
			..buy 4 Rough Blasting Powder##4357
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Wetlands 50.0,37.8
			.talk Kixxle##8305
			..buy 1 Liferoot##3357
			..buy 1 Wild Steelbloom##3355
			..buy 1 Kingsblood##3356
			..buy 2 Bruiseweed##2453
			..buy 2 Earthroot##2449
			..buy 2 Mageroyal##785
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Arathi Highlands 40.8,48.0
			.talk Jannos Ironwill##1471
			..buy 1 Plans: Solid Iron Maul##10858
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Arathi Highlands 40.6,48.2
			.talk Drovnar Strongbrew##2812
			.buy 1 Recipe: Frost Protection Potion##6056
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Arathi Highlands 40.4,48.8
			.talk Hammon Karwn##2810
			..buy 1 Design: Ruby Crown of Restoration##21942
			..buy 1 Pattern: Barbaric Leggings##5973
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Arathi Highlands 39.2,48.2
			.talk Androd Fadran##2816
			..buy 1 Pattern: Raptor Hide Belt##13288
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Hillsbrad Foothills 52.6,56.2
			.talk Zixil##3537 |tip He patrols between Tarren Mill and Southshore, but makes a stop here. You may need to search for him a bit.
			..buy 1 Schematic: Goblin Jumper Cables##7561
			..buy 1 Strength of Will##4837
			..buy 1 Dreamer's Belt##4829
			..buy 1 Fireproof Orb##4836
			..buy 1 Wizard's Belt##4827
			..buy 1 Nightwind Belt##4828
			..buy 1 Orb of Power##4838
			..buy 1 Pattern: Earthen Leather Shoulders##7362
			..buy 1 Formula: Enchant Boots - Minor Agility##6377
			..buy 1 Pattern: Red Woolen Bag##5772
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Hillsbrad Foothills 44.0,21.8
			.talk Bro'kin##2480
			..buy 1 Recipe: Frost Oil##14634
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Western Plaguelands 43.0,84.2
			.talk Leonard Porter##12942
			..buy 1 Pattern: Stormshroud Pants##15741
			..buy 1 Pattern: Wicked Leather Gauntlets##15725
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Hillsbrad Foothills 71.2,45.2
			.talk Zan Shivsproket##6777
			..buy 1 Schematic: Gnomish Cloaking Device##7742
			..buy 1 Gyrochronatom##4389
			..buy 1 Bronze Framework##4382
			..buy 2 Bronze Tube##4371
			..buy 3 Silver Contact##4404
			..buy 4 Coarse Blasting Powder##4364
			..buy 4 Rough Blasting Powder##4357
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto The Hinterlands 13.4,43.2
			.talk Nioma##8160
			..buy 1 Pattern: Nightscape Shoulders##8409
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto The Hinterlands 13.6,44.8
			.talk Harggan##8161
			..buy 1 Plans: Mithril Scale Bracers##7995
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto The Hinterlands 34.2,37.8
			.talk Ruppo Zipcoil##2688
			..buy 1 Schematic: Mithril Mechanical Dragonling##10609
			..buy 1 Gyrochronatom##4389
			..buy 1 Bronze Framework##4382
			..buy 2 Bronze Tube##4371
			..buy 3 Silver Contact##4404
			..buy 4 Coarse Blasting Powder##4364
			..buy 4 Rough Blasting Powder##4357
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto The Hinterlands 34.6,38.4
			.talk Gigget Zipcoil##12958
			..buy 1 Pattern: Ironfeather Shoulders##15735
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Eastern Plaguelands 74.2,51.0
			.talk Jase Farlane##12941
			..buy 1 Design: Ring of Bitter Shadows##21954
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
	]])
	ZygorGuidesViewer:RegisterGuide("GOLD\\Alliance Vendor Runs\\Outland/Northrend/Pandaria Vendor Run",[[
		description This guide will take you through Vendor Runs
		meta goldtype="vendor",time=30,icon="Interface\\ICONS\\ExpansionIcon_MistsOfPandaria"
		step
		label "start"
			goto Hellfire Peninsula 53.8,65.4
			.talk Jezebel Bican##30734
			..buy 2 Technique: Glyph of Counterspell##50166
			..buy 3 Scribe's Satchel##39489
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Shadowmoon Valley 55.8,58.2
			.talk Arrond##19521
			..buy 1 Pattern: Imbued Netherweave Tunic##21901
			..buy 1 Pattern: Imbued Netherweave Robe##21900
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Shadowmoon Valley 36.8,55.0
			.talk Mari Stonehand##19373
			..buy 1 Plans: Lesser Ward of Shielding##23638
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Terokkar Forest 57.6,53.4
			.talk Leeli Longhaggle##19042
			..buy 1 Recipe: Major Dreamless Sleep Potion##22911
			..buy 1 Recipe: Sneaking Potion##22901
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Terokkar Forest 39.4,70.0
			.talk Dealer Tariq##20986
			..buy 3 Mote of Life##22575
			..buy 3 Mote of Air##22572
			..buy 3 Mote of Earth##22573
			..buy 3 Mote of Fire##22574
			..buy 3 Mote of Mana##22576
			..buy 3 Mote of Shadow##22577
			..buy 3 Mote of Water##22578
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Shattrath City 64.0,71.8
			.talk Aaron Hollman##19662
			..buy 1 Plans: Adamantite Rapier##23593
			..buy 1 Plans: Adamantite Dagger##23592
			..buy 1 Plans: Adamantite Cleaver##23591
			..buy 1 Plans: Adamantite Maul##23590
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Shattrath City 63.6,70.0
			.talk Madame Ruby##19663
			..buy 1 Formula: Superior Wizard Oil##22563
			..buy 1 Formula: Large Prismatic Shard##22565
			..buy 1 Formula: Enchant Shield - Major Stamina##28282
			..buy 1 Formula: Superior Mana Oil##22562
			..buy 2 Lesser Magic Essence##10938
			..buy 4 Strange Dust##10940
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Shattrath City 64.8,69.6
			.talk Viggz Shinesparked##19661
			..buy 1 Schematic: Adamantite Rifle##23799
			..buy 2 Elemental Blasting Powder##23781
			..buy 2 Handful of Fel Iron Bolts##23783
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Shattrath City 72.6,31.6
			.talk Wind Trader Lathrai##18484
			..buy 1 Schematic: White Smoke Flare##23811
			..buy 1 Schematic: Fel Iron Toolbox##23816
			..buy 1 Gyrochronatom##4389
			..buy 1 Bronze Framework##4382
			..buy 2 Bronze Tube##4371
			..buy 3 Silver Contact##4404
			..buy 4 Coarse Blasting Powder##4364
			..buy 4 Rough Blasting Powder##4357
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Shattrath City 45.8,20.8
			.talk Skreah##19074
			..buy 1 Recipe: Transmute Primal Might##23574
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Nagrand 53.2,71.8
			.talk Borto##19017
			..buy 1 Pattern: Soulcloth Gloves##21902
			..buy 1 Pattern: Bolt of Soulcloth##21894
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Zangarmarsh 40.6,28.2
			.talk Muheru the Weaver##19722
			..buy 1 Pattern: Imbued Netherweave Boots##21899
			..buy 1 Pattern: Imbued Netherweave Pants##21898
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Zangarmarsh 68.6,50.2
			.talk Loolruna##19694
			..buy 1 Plans: Adamantite Breastplate##23596
			..buy 1 Plans: Adamantite Plate Bracers##23564
			..buy 1 Plans: Adamantite Plate Gloves##23595
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Zangarmarsh 67.8,48.0
			.talk Haalrun##18005
			..buy 1 Recipe: Elixir of Major Defense##22909
			..buy 1 Recipe Super Mana Potion##22907
			..buy 1 Recipe: Elixir of Major Frost Power##22902
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Blade's Edge Mountains 60.6,69.0
			.talk Bossi Pentapiston##21112
			..buy 1 Elemental Blasting Powder##23781
			..buy 3 Handful of Fel Iron Bolts##23783
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Netherstorm 32.6,66.6
			.talk Qiff##19575
			..buy 1 Felsteel Stabalizer##23787
			..buy 1 Khorium Power Core##23786
			..buy 1 Adamantite Frame##23784
			..buy 2 Handful of Fel Iron Bolts##23783
			..buy 1 Fel Iron Casing##23782
			..buy 2 Elemental Blasting Powder##23781
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Netherstorm 44.8,36.6
			.talk Dealer Najeeb##20981
			..buy 1 Hardened Adamantite Tube##23785
			..buy 2 Mote of Air##22572
			..buy 3 Mote of Water##22578
			..buy 3 Mote of Shadow##22577
			..buy 2 Adamantite Frame##23784
			..buy 2 Mote of Mana##22576
			..buy 1 Mote of Life##22575
			..buy 3 Mote of Fire##22574
			..buy 3 Mote of Earth##22573
			..buy 4 Handful of Fel Iron Bolts##23783
			..buy 4 Elemental Blasting Powder##23781
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Netherstorm 43.2,35.0
			.talk Dealer Sadaqat##20989
			..buy 1 Mana Thistle##22793
			..buy 3 Netherbloom##22791
			..buy 2 Dreaming Glory##22786
			..buy 3 Felweed##22785
			..buy 3 Icecap##13467
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Dalaran 42.4,37.6
			.talk Larana Drome##28723
			..buy 6 Technique: Glyph of Everlasting Affliction##50168
			..buy 5 Technique: Glyph of Counterspell##50166
			..buy 3 Scribe's Satchel##39489
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Dalaran 39.0,26.0
			.talk Bryan Landers##28722
			..buy 5 Schematic: Titanium Toolbox##23817
			..buy 1 Gyrochronatom##4389
			..buy 1 Bronze Framework##4382
			..buy 2 Bronze Tube##4371
			..buy 3 Silver Contact##4404
			..buy 4 Coarse Blasting Powder##4364
			..buy 4 Rough Blasting Powder##4357
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Icecrown 72.2,20.8
			.talk Fizzix Blastbolt##33594
			..buy 5 Schematic: Titanium Toolbox##23817
			..buy 1 Gyrochronatom##4389
			..buy 1 Bronze Framework##4382
			..buy 2 Bronze Tube##4371
			..buy 3 Silver Contact##4404
			..buy 4 Coarse Blasting Powder##4364
			..buy 4 Rough Blasting Powder##4357
			.' If these items are not available, or you have purchased everything you can at the moment, click here to continue. |confirm
		step
			goto Krasarang Wilds 16.6,79.6
			.talk Tinkmaster Overspark##67976
			..buy 1 Schematic: Adamantite Rifle##23799
			.' This is the last step of the guide:
			.' If these items are not available, click here to be routed back to the start of the guide. |confirm |next "start"
	]])
end



-- FARM VEGGIES

ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Cocoa Beans (Alliance)",[[
	condition valid raceclass("Alliance")
	step
		#include "A_Stormwind_Cooking_Dailies"
		..earn 1 Epicurean's Reward##81
	step
		goto Stormwind City 50.8,71.4
		.talk Bario Matalli##49701
		.buy Imported Supplies##68689
	step
		'Use the Imported Supplies in your bags. |use Imported Supplies##68689
		..goldcollect Cocoa Beans##62786
		..goldtracker
		.' Click here to sell items |confirm
	step
		#include "auctioneer"
]])