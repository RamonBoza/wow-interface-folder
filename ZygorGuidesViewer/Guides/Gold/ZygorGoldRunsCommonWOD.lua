-- FARM VEGGIES




ZygorGuidesViewer:RegisterInclude("goldg_farm",[[
	step
		Start each day out by harvesting the crops from the previous day. |goto Valley of the Four Winds 51.9,48.3
		confirm
	step
		talk Merchant Greenfield##58718
		buy 4 %seed% |goto Valley of the Four Winds/0 52.9,52.1 |only if completedq(30257) and not completedq(31936)
		buy 8 %seed% |goto Valley of the Four Winds/0 52.9,52.1 |only if completedq(31936) and not completedq(31937)
		buy 12 %seed% |goto Valley of the Four Winds/0 52.9,52.1 |only if completedq(31937) and not completedq(32682)
		buy 16 %seed% |goto Valley of the Four Winds/0 52.9,52.1 |only if completedq(32682)
	step
		goto Valley of the Four Winds 51.9,48.3
		Plant the seeds in your farm. You will have to wait until the next say to harvest them.
		confirm
	step
		Next day, harvest:
		collect 20 %veggie% |only if completedq(30257) and not completedq(31936)
		collect 40 %veggie% |only if completedq(31936) and not completedq(31937)
		collect 60 %veggie% |only if completedq(31937) and not completedq(32682)
		collect 80 %veggie% |only if completedq(32682)
]])

--PLATE XMOG
ZygorGuidesViewer:RegisterGuide("GOLD\\Horde Daily Runs\\Jade Plate Set Transmog",[[
	description This guide will put you on the path to obtaining the Jade Plate Set
	meta goldtype="xmog",levelreq=70,gold=100,time=15,icon="Interface\\ICONS\\inv_chest_plate07"
		step
		label "begin"
			This guide will point you in the direction to each piece of the Jade Plate armors.
			Since they have a very low drop rate, do expect to farm for a bit for these items
			confirm always
		step
		label "Jade1"
			modelnpc Ice Thistle Yeti##7458 
			Follow the path into the cave, killing all Yeti as you come across them |goto Winterspring/0 71.7,51.7 |noway |c |next "Jade2"
			You will be able to skin _Thick and Rugged Leathers_ from the yetis |only if skill("Skinning")>=250
			map Winterspring/0 -- WINTERSPRING FARMING
			path follow smart; loop off; ants curved; dist 20
			path	63.0,53.4	65.1,54.5	66.3,56.3
			path	67.3,54.4	68.5,54.2	69.3,52.4
			path	69.7,53.7	69.5,55.0	70.1,53.7
			path	70.8,53.3	71.6,52.9	71.7,51.7
			goldcollect Jade Legplate##14920 |n
			goldcollect Jade Greaves##14913 |n |tip It's possible to get this from the path, but it has a significantly lower drop rate
			goldcollect Azure Whelpling##34535 |n
			goldcollect Thick Leather |n
			goldcollect Rugged Leather |n
			--goldcollect
			Click here to sell the items you have collected |confirm |next "sell"
			_
			Click here to continue farming more parts to the Jade Plate Set |confirm |next "Jade3"
		step
		label "Jade2"
			modelnpc Ice Thistle Yeti##7458
			Follow the path out of the cave, killing all Yeti as you come across them |goto 63.0,53.4 |noway |c |next "Jade1"
			You will be able to skin _Thick and Rugged Leathers_ from the yetis |only if skill("Skinning")>=250
			map Winterspring/0 -- WINTERSPRING FARMING
			path follow smart; loop off; ants curved; dist 20
			path	71.7,51.7	71.6,52.9	70.8,53.3
			path	70.1,53.7	69.5,55.0	69.7,53.7
			path	69.3,52.4	68.5,54.2	67.3,54.4
			path	66.3,56.3	65.1,54.5	63.0,53.4
			goldcollect Jade Legplate##14920 |n
			--goldcollect
			Click here to sell the items you have collected |confirm |next "sell"
			_
			Click here to continue farming more parts to the Jade Plate Set |confirm
		step
		label "Jade3"
			Kill everything inside of Zul'Farrak
			Follow the path through Zul'Farrak until you reach the temple area |goto Zul'Farrak/0 24.4,17.6 < 15 |noway |c
			map Zul'Farrak/0
			path follow smart; loop off; ants curved; dist 20
			path	57.3,80.8	59.0,67.8	57.3,55.9
			path	53.8,47.4	50.7,42.4	46.6,49.2
			path	41.2,52.0	36.1,47.2	33.9,44.2
			path	30.8,45.1	27.5,39.6	30.6,37.2
			path	33.1,38.0	34.8,35.3	34.8,28.5
			path	31.9,24.1	28.6,17.8	24.4,17.6
			goldcollect Jade Belt##14918 |n
			goldcollect Jade Bracers##14914 |n
			goldcollect Jade Gauntlets##14917 |n
			Click here to sell the items you have collected |confirm |next "sell"
			_
			Click here to continue farming more parts to the Jade Plate Set |confirm |next "Jade5"
		step
		label "Jade4"
			Kill everything inside of Zul'Farrak.
			Once you have, you will be able to reset the instance.
			This step will take you back to the start of the dungeon. _Reset_ if you wish to continue |goto Zul'Farrak/0 57.6,78.9 < 15 |noway |c
			map Zul'Farrak/0
			path follow smart; loop off; ants curved; dist 20
			path	32.1,16.6	39.8,20.8	46.7,20.3
			path	55.4,30.9	59.4,40.8	54.8,39.9
			path	52.9,44.7	57.6,57.6	58.9,67.2
			path	57.6,78.9
			goldcollect Jade Belt##14918 |n
			goldcollect Jade Bracers##14914 |n
			goldcollect Jade Gauntlets##14917 |n
			Click here to sell the items you have collected |confirm |next "sell"
			_
			Click here to continue farming more parts to the Jade Plate Set |confirm
		step
		label "Jade5"
			Follow the path and kill anything along the way.
			Do note that you can _kill anything in Un'Goro_ to have a chance for this to drop. |tip You can just fly in a giant circle killing everything if you wish.
			map Un'Goro Crater/0
			path follow smart; loop on; ants curved; dist 20
			path	68.5,75.3	66.7,70.0	68.2,64.0
			path	71.1,59.3	67.0,59.2	64.6,63.0
			path	60.7,62.4	58.0,61.5	57.4,68.2
			path	58.0,74.6	58.3,80.3	62.3,79.7
			path	66.6,77.8
			goldcollect Jade Breastplate##14915 |n
			goldcollect Jade Gauntlets##14917 |n |tip The gloves are more likely to drop from Ravensaurs in the area.
			Click here to sell the items you have collected |confirm |next "sell"
			_
			To try your hand at farming for these items in _Silithus_, click here |confirm
		step
		label "Jade6"
			Kill Twilight's Hammer enemies at the provided locations:
			_Staghelm Point_ located here |goto Silithus/0 69.7,16.6
			_Twilight Base Camp_ located here |goto Silithus/0 45.4,41.5
			_Twilight Post_ located here |goto Silithus/0 34.0,31.8
			_Twilight Outpost_ located here |goto Silithus/0 27.7,75.1
			goldcollect Jade Breastplate##14915 |n
			goldcollect Encrypted Twilight Text##20404 |n
			goldcollect Runecloth##14047 |n
			Click here to sell the items you have collected |confirm |next "sell"
			_
			To go back to farming in _Un'Goro_, click here |confirm |next "Jade5"
		step
		label "sell"
			#include "auctioneer"
			Click here to go back to the start |confirm |next "Jade1"
	]])

--[=[
ZygorGuidesViewer:RegisterGuide("GOLD\\Horde Daily Runs\\Saltstone Plate Set Transmog",[[
	description This guide will put you on the path to obtaining the Jade Plate Set
	meta goldtype="xmog",levelreq=70,gold=100,time=15,icon="Interface\\ICONS\\inv_chest_plate07"
	step
		Farming here _WILL FLAG YOU!_ |only Horde
	step
		Saltstone Shoulder Pads##14901
			Dire Maul
			1k Needles, Grimtotem, Southsea
	step

		Saltstone Surcoat##14895
			Dire Maul
			1k Needles, Grimtotem, Southsea

		Saltstone Gauntlets##14897
			Thousand Needles, Southsea Sailor
			Feralas, Grimtotem Marauder
			Dire Maul, Warpwood Guardian

		Saltstone Armsplints##14903
			Thousand Needles, Southsea Sailor
			Dire Maul, Warpwood Guardian
			Feralas, Grimtotem Marauder

		Saltstone Girdle##14898
			""

		Saltstone Legplates##14900
			Feralas, Grimtotem Marauder
			Thousand Needles, Southsea
			Thousand Needles, Den Whomper

		Saltstone Sabatons##14896
			Thousand Needles, Southsea
			Feralas, Grimtotem Marauder
			Thousand Needles, Den Whomper

	]])
--]=]

--MAIL XMOG
ZygorGuidesViewer:RegisterGuide("GOLD\\Horde Daily Runs\\Ebonhold Mail Set Transmog",[[
	description This guide will put you on the path to obtaining the Jade Plate Set
	meta goldtype="xmog",levelreq=70,gold=100,time=15,icon="Interface\\ICONS\\inv_chest_chain_17"
		step
			This guide will point you in the direction to each piece of the Ebonhold Mail armors.
			Since they have a very low drop rate, do expect to farm for a bit for these items
			confirm always
		step
		label "boots1"
			The _Ebonhold Boots_ can be looted from _Mithril Lockboxes_, so if you get them, have a rogue open them or send them to a rogue alt.
			Be sure to _kill everything_ along your path
			_
			_Go through_ the passage |goto Blackrock Spire/4 40.7,45.8 < 20
			_Go down_ the ramp |goto Blackrock Spire/3 49.6,39.9 < 20
			_Cross_ the bridge |goto 59.5,42.8 < 20
			_Cross_ the second bridge |goto 66.6,44.7 < 20
			_Go around_ the opening in the ground |goto 66.0,58.2 < 20
			_Enter_ the hallway |goto 57.0,57.8 < 20
			_Enter_ the room |goto 46.1,57.7 < 20
			Defeat Highlord Omokk |goto 35.7,55.5
			Once you reach the ogre room, you will be directed to the next section of farming |goto 35.7,55.5 < 20 |noway |c
			goldcollect Ebonhold Boots##8269 |n
			goldcollect Ebonhold Wristguards##8264 |n
			goldcollect Ebonhold Gauntlets##8267 |n
			goldcollect Ebonhold Girdle##8268 |n
			_
			goldcollect Runecloth##14047 |n
			collect ##5758 |n
		step
		label "boots2"
			_Cross_ the bridge |goto Blackrock Spire/3 47.8,57.7 < 20
			_Exit_ the hallway |goto Blackrock Spire/3 56.7,57.7 < 15
			_Go down_ the ramp |goto 57.0,51.1 < 10
			_Enter_ the doorway |goto Blackrock Spire/2 53.2,52.6 < 5
			_Go up_ the ramp and kill the enemies there |goto Blackrock Spire/2 55.3,61.5 < 10 |tip Come back down after you kill the enemies
			_Go down_ the ramp |goto Blackrock Spire/2 56.9,58.3 < 15
			_Enter_ the doorway |goto Blackrock Spire/1 54.2,61.6 < 15
			Defeat _War Master Voone_ |goto Blackrock Spire/1 52.9,54.4
			Once you reach War Master Voone, you will be directed to the next section of farming |goto Blackrock Spire/1 52.9,54.4 < 10 |noway |c
			goldcollect Ebonhold Boots##8269 |n
			goldcollect Ebonhold Wristguards##8264 |n
			goldcollect Ebonhold Gauntlets##8267 |n
			goldcollect Ebonhold Girdle##8268 |n
			_
			goldcollect Runecloth##14047 |n
			collect ##5758 |n
		step
		label "boots3"
			_Leave_ the room |goto Blackrock Spire/1 53.8,61.6 < 15
			_Enter_ the doorway |goto 66.0,50.7 < 15
			_Pass_ through the rocks |goto Blackrock Spire/3 61.9,46.2 < 15
			_Follow_ the path through Hordemar City |goto Blackrock Spire/1 50.4,51.6 < 15
			_Continue_ through the area |goto Blackrock Spire/1 49.1,63.9 < 20
			_Go up_ the ramp |goto 57.1,70.4 < 20
			_Continue_ up the ramp |goto Blackrock Spire/2 56.3,73.5 < 20
			_Follow_ the path up |goto Blackrock Spire/3 46.9,68.6 < 20
			_Continue_ along the path |goto Blackrock Spire/4 42.6,60.9 < 20
			Once you reach this point, you willbe directed to the next section of farming |goto Blackrock Spire/4 42.6,60.9 < 20 |noway |c
			goldcollect Ebonhold Boots##8269 |n
			goldcollect Ebonhold Wristguards##8264 |n
			goldcollect Ebonhold Gauntlets##8267 |n
			goldcollect Ebonhold Girdle##8268 |n
			_
			goldcollect Runecloth##14047 |n
			goldcollect Ironweb Spider Silk##14227 |n
			goldcollect Shadow Silk##10285 |n
			goldcollect Thick Spider's Silk##4337 |n
			collect ##5758 |n
		step
		label "boots4"
			_Enter_ the doorway |goto Blackrock Spire/4 42.8,74.0
			_Go up_ the ramp |goto Blackrock Spire/5 47.4,79.9
			_Enter_ the Storehouse |goto 53.8,84.6 
			Once you reach this point, you willbe directed to the next section of farming |goto 53.8,84.6  < 20 |noway |c
			goldcollect Ebonhold Boots##8269 |n
			goldcollect Ebonhold Wristguards##8264 |n
			goldcollect Ebonhold Gauntlets##8267 |n
			goldcollect Ebonhold Girdle##8268 |n
			_
			goldcollect Runecloth##14047 |n
			collect ##5758 |n
			collect Worg Carrier##12264 |n
		step
		label "boots5"
			_Go down_ the ramp |goto Blackrock Spire/5 51.4,79.9 < 15
			_Enter_ the room |goto 37.6,84.0 < 15
			_Go up_ the ramp |goto 40.0,77.1 < 15
			_Walk around_ the gap in the ground |goto Blackrock Spire/5 35.9,71.4 < 15
			_Cross_ the bridge |goto 37.4,63.7 < 15
			_Go through_ the doorway |goto Blackrock Spire/5 40.1,60.4 < 10
			_Enter_ the Battle Chamber |goto Blackrock Spire/6 50.8,60.5 < 15
			_Follow_ the path up |goto 59.0,65.3 < 15
			Defeat Overlord Wyrmthalak |goto 56.1,57.0
			Once you reach this point, you willbe directed to the next section of farming |goto 56.1,57.0 |noway |c
			goldcollect Ebonhold Boots##8269 |n
			goldcollect Ebonhold Wristguards##8264 |n
			goldcollect Ebonhold Gauntlets##8267 |n
			goldcollect Ebonhold Girdle##8268 |n
			_
			goldcollect Runecloth##14047 |n
			collect ##5758 |n
		step
		label "boots6"
			Pass through the hallway |goto Blackrock Spire/6 44.8,60.5 < 15
			Go through the second doorway |goto Blackrock Spire/6 40.8,60.4 < 8
			Jump down the ledge |goto Blackrock Spire/5 40.0,62.4 < 10
			Jump down to the bridge below |goto Blackrock Spire/4 46.6,57.8 < 15
			_Go through_ the doorway |goto Blackrock Spire/3 56.6,57.7 < 15
			_Enter_ the room |goto Blackrock Spire/3 66.1,58.7 < 15
			_Cross_ the bridge |goto 66.2,50.3 < 15
			_Cross_ the second bridge |goto 63.7,42.9 < 15
			_Go up_ the ramp |goto Blackrock Spire/3 54.5,37.4 < 15
			_Go through_ the passage |goto Blackrock Spire/4 40.3,47.0 < 15
			_Leave_ the instance |goto 37.8,41.4 < 15
			You can now reset the instance if you wish to |goto Burning Steppes/14 80.3,40.3
			_
			To continue farming here, click here to move back to the start. |confirm |next "boots1"
			_
			Click here to farm other parts of the Ebonhold set |confirm
		step
			talk Zidormi##88206
			Tell her: _Show me the Blasted Lands before the invasion._ |goto Blasted Lands/0 48.2,7.3
			confirm
		step
		label "chest1"
			Follow this path, killing Ashmane Boars, Dreadmaul Ogres, Snickerfang Hyena, Redstone Basilisk and Enthralled Cultists.
			map Blasted Lands/0
			path follow smart; loop off; ants curved; dist 20
			path	58.4,25.0	54.9,23.9	52.1,26.5
			path	54.2,31.0	56.7,37.0	53.7,38.8
			path	50.6,36.3	46.9,33.9
			goldcollect Ebonhold Armor##8265
			goldcollect Ebonhold Leggings##8271
			goldcollect Ebonhold Boots##8269
			_
			goldcollect Runecloth##14047
			To continue farming at another location, click here |confirm 
			_
			Click here to farm other parts of the Ebonhold set |confirm |next "wrist1"
		step
		label "chest2"
			map Swamp of Sorrows/0
			path follow smart; loop on; ants curved; dist 20
			path	37.4,51.9	33.8,55.5	30.6,54.7
			path	27.6,50.9	27.4,44.7	28.6,39.8
			path	32.0,38.8	34.4,35.7	37.3,34.8
			path	38.2,39.1	38.1,42.9	37.2,47.5
			path	33.9,47.9
			Kill the slimes in the area
			goldcollect Ebonhold Armor##8265 |n
			_
			goldcollect Sorrowmoss##13466 |n
			To continue farming here, click here to move back to the start. |confirm |next "chest1"
			_
			Click here to farm other parts of the Ebonhold set |confirm
		step
		label "wrist1"
			Go _down the stairs_, following the path _into the Sunken Temple_ |goto Swamp of Sorrows/0 69.7,53.6 < 10 |c
		step
			map The Temple of Atal'Hakkar/1
			path follow smart; loop off; ants curved; dist 20
			path	50.0,42.8	39.0,36.3	28.0,26.6
			path	23.8,63.0	31.0,61.2	42.8,52.4
			path	50.4,59.9	57.7,53.3	75.7,64.3
			path	76.1,38.7
			You will be guided to the next section once you reach this area. |goto 76.1,38.7 < 20 |noway |c
			goldcollect Ebonhold Wristguards##8264 |n
			goldcollect Ebonhold Gauntlets##8267 |n
			goldcollect Ebonhold Girdle##8268 |n
			_
			goldcollect Runecloth##14047 |n
		step
			map The Temple of Atal'Hakkar/1
			path follow smart; loop off; ants curved; dist 20
			path	75.0,63.5	69.7,62.1	57.0,51.5
			path	50.0,59.7	49.6,86.8	65.7,87.6
			goldcollect Ebonhold Wristguards##8264 |n
			goldcollect Ebonhold Gauntlets##8267 |n
			goldcollect Ebonhold Girdle##8268 |n
			_
			goldcollect Runecloth##14047 |n
			Click here to return to the start of the guide |confirm |next "boots1"
			_
			Click here to farm other parts of the Ebonhold set |confirm
		step
			label "sell"
			#include "auctioneer"
			Click here to go back to the start |confirm |next "boots1"
	]])

--LEATHER XMOG
ZygorGuidesViewer:RegisterGuide("GOLD\\Horde Daily Runs\\Imposing Leather Set Transmog",[[
	description This guide will put you on the path to obtaining the Jade Plate Set
	meta goldtype="xmog",levelreq=70,gold=100,time=15,icon="Interface\\ICONS\\inv_chest_leather_05"
	step
		This guide will point you in the direction to each piece of the Imposing armors.
		Since they have a very low drop rate, do expect to farm for a bit for these items
		confirm always
	step
	label "WS1"
		Shardtooth Bears spawn in a small area
		You will be provided with 2 locations to farm between
		map Winterspring/0
		path follow strict; loop; ants curved; dist 20
		path	59.6,33.6	58.2,28.8	55.2,30.6
		path	53.0,28.4	51.0,30.6	51.6,33.6
		goldcollect Imposing Bandana##15167 |n
		You will be directed to the next area to farm the _Imposing Bandana_ |goto Winterspring/0 51.6,33.6 < 20 |noway |c |next "WS2"
		_
		Click here to sell |confirm |next "sell"
			modelnpc Shardtooth Bear##7444
	step
	label "WS2"
		map Winterspring/0
		path follow strict; loop; ants curved; dist 30
		path	33.2,57.6	27.0,57.2
		This is a rather small path, be sure to search the area for bears
		_
		goldcollect Imposing Bandana##15167 |n
		modelnpc Shardtooth Bear##7444
		_
		Click here to return to farming the Imposing Bandana at the previous location |confirm |next "WS1"
		_
		_Click here to move on_ to farming Imposing Leather pieces from Southsea Pirates |confirm
		_Click here to sell_ any items you've collected  |confirm |next "sell"
	step
	label "DM1"
		Be sure to kill everything in the dungeon as you go through; Also reset if need be
		_Go down_ the ramp|goto Dire Maul/1 69.3,86.8 < 15
		_Cross_ through the open area |goto 69.3,80.3 < 20
		_Go up_ the ramp |goto 69.3,69.7 < 15
		_Walk around_ the ledge here |goto 64.7,68.2 < 20
		_Go up_ the ramp |goto 58.8,71.2 < 15
		_Continue_ up the ramp |goto 56.0,78.0 < 20
		_Go through_ the doorway |goto Dire Maul/1 40.7,78.1 < 20
		_Follow_ the path through the hallway |goto Dire Maul/1 30.1,77.5 < 20
		_Go through_ the doorway |goto Dire Maul/1 27.0,68.8 < 20
		_Walk around_ the wall |goto Dire Maul/1 25.1,57.1 < 20
		_Go up_ the ramp |goto 23.3,66.7 < 20
		_
		You will now be directed to the next part of Dire Maul |goto 23.3,66.7 < 20 |noway |c
		goldcollect Imposing Vest##15164 |n
		goldcollect Imposing Gloves##15166 |n
		goldcollect Imposing Pants##15168 |n
		goldcollect Imposing Boots##15162 |n
	step
		_Go up_ the ramp |goto Dire Maul/1 25.4,54.4 < 15
		_Go through_ the door |goto 28.9,65.7 < 15
		_Follow_ the path into the open room |goto 31.8,48.9 < 20
		Defeat King Gordok |goto Dire Maul/1 31.9,26.9
		_
		goldcollect Imposing Vest##15164 |n
		goldcollect Imposing Gloves##15166 |n
		goldcollect Imposing Pants##15168 |n
		goldcollect Imposing Boots##15162 |n
		Click here to continue farming in Dire Maul |confirm |next "DM1"
		_
		Click here to continue farming more pieces of the Imposing Leather Set |confirm
	step
	label "SSP1"
		map Tanaris/0 
		path follow smart; loop off; ants curved; dist 20
		path	68.4,42.3	69.9,43.3	71.2,44.6
		path	72.2,45.8	72.7,48.5	72.0,49.8
		path	69.9,50.7	69.6,52.7	69.1,54.5
		path	69.5,57.0
		goldcollect Imposing Pants##15168 |n
		goldcollect Imposing Gloves##15166 |n
		goldcollect Imposing Boots##15162 |n
		You will be routed back to the cave entrance of Southbreak Shore |goto Tanaris/0 69.5,57.0 < 30 |noway |c
		_
		Click here to move onto farming Zul'Farrak |confirm |next "ZF1"
	step
	label "SSP2"
		map Tanaris/0
		path follow smart; loop off; ants curved; dist 20
		path	69.5,57.0	69.1,54.5	69.6,52.7
		path	69.9,50.7	72.0,49.8	72.7,48.5
		path	72.2,45.8	71.2,44.6	69.9,43.3
		path	68.4,42.3
		goldcollect Imposing Pants##15168 |n
		goldcollect Imposing Gloves##15166 |n
		goldcollect Imposing Boots##15162 |n
		Click here to farm Southsea Pirates more |confirm |next "SSP1"
		_
		Click here to move on to farming Zul'Farrak |confirm
	step
	label "ZF1"
		Kill everything inside of Zul'Farrak
		Follow the path through Zul'Farrak until you reach the temple area |goto Zul'Farrak/0 24.4,17.6 < 15 |noway |c
		map Zul'Farrak/0
		path follow smart; loop off; ants curved; dist 20
		path	57.3,80.8	59.0,67.8	57.3,55.9
		path	53.8,47.4	50.7,42.4	46.6,49.2
		path	41.2,52.0	36.1,47.2	33.9,44.2
		path	30.8,45.1	27.5,39.6	30.6,37.2
		path	33.1,38.0	34.8,35.3	34.8,28.5
		path	31.9,24.1	28.6,17.8	24.4,17.6
		goldcollect Imposing Vest##15164 |n
		goldcollect Imposing Bandana##15167 |n
		Click here to sell the items you have collected |confirm |next "sell"
		_
		Click here to continue farming more parts to the Jade Plate Set |confirm |next 
	step
		Kill everything inside of Zul'Farrak.
		Once you have, you will be able to reset the instance.
		This step will take you back to the start of the dungeon. _Reset_ if you wish to continue |goto Zul'Farrak/0 57.6,78.9 < 15 |noway |c
		map Zul'Farrak/0
		path follow smart; loop off; ants curved; dist 20
		path	32.1,16.6	39.8,20.8	46.7,20.3
		path	55.4,30.9	59.4,40.8	54.8,39.9
		path	52.9,44.7	57.6,57.6	58.9,67.2
		path	57.6,78.9
		goldcollect Imposing Vest##15164 |n
		goldcollect Imposing Bandana##15167 |n
		Click here to sell the items you have collected |confirm |next "sell"
		_
		Click here to continue farming more parts to the Jade Plate Set |confirm
	step
	label "sell"
		#include "auctioneer"
		Click here to go back to the start |confirm |next "WS1"
	]])

--CLOTH XMOG
ZygorGuidesViewer:RegisterGuide("GOLD\\Horde Daily Runs\\Arachnidian Cloth Set Transmog",[[
	description This guide will put you on the path to obtaining the Jade Plate Set
	meta goldtype="xmog",levelreq=70,gold=100,time=15,icon="Interface\\ICONS\\inv_chest_cloth_35"
	step
		This guide will point you in the direction to each piece of the Arachnidian Cloth armors.
		Since they have a very low drop rate, do expect to farm for a bit for these items
		confirm always
	step
	label "Pauldron1"
		modelnpc Ice Thistle Yeti##7458 
		Follow the path into the cave, killing all Yeti as you come across them |goto Winterspring/0 71.7,51.7 |noway |c |next "Pauldron2"
		You will be able to skin _Thick and Rugged Leathers_ from the yetis |only if skill("Skinning")>=250
		map Winterspring/0 -- WINTERSPRING FARMING
		path follow loose; loop off; ants curved; dist 20
		path	63.0,53.4	65.1,54.5	66.3,56.3
		path	67.3,54.4	68.5,54.2	69.3,52.4
		path	69.7,53.7	69.5,55.0	70.1,53.7
		path	70.8,53.3	71.6,52.9	71.7,51.7
		goldcollect Arachnidian Pauldrons##14296 |n
		goldcollect Arachnidian Girdle##14289 |n
		goldcollect Arachnidian Footpads##14290 |n
		goldcollect Thick Leather |n |only if skill("Skinning")>=250
		goldcollect Rugged Leather |n |only if skill("Skinning")>=250
		_Click here to sell_ the items you have collected |confirm |next "sell"
		_
		_Click here to continue farming_ more parts to the Arachnidian Cloth Set |confirm |next "BEAR1"
	step
	label "Pauldron2"
		modelnpc Ice Thistle Yeti##7458 
		Follow the path into the cave, killing all Yeti as you come across them |goto 63.0,53.4 |noway |c |next "Pauldron3"
		You will be able to skin _Thick and Rugged Leathers_ from the yetis |only if skill("Skinning")>=250
		map Winterspring/0 -- WINTERSPRING FARMING
		path follow loose; loop off; ants curved; dist 20
		path	71.7,51.7	71.6,52.9	70.8,53.3
		path	70.1,53.7	69.5,55.0	69.7,53.7
		path	69.3,52.4	68.5,54.2	67.3,54.4
		path	66.3,56.3	65.1,54.5	63.0,53.4
		goldcollect Arachnidian Pauldrons##14296|n
		goldcollect Arachnidian Girdle##14289 |n
		goldcollect Arachnidian Footpads##14290 |n
		goldcollect Thick Leather |n |only if skill("Skinning")>=250
		goldcollect Rugged Leather |n |only if skill("Skinning")>=250
		_Click here to sell_ the items you have collected |confirm |next "sell"
		_
		_Click here to continue farming_ more parts to the Arachnidian Cloth Set |confirm |next "BEAR1"
	step
	label "Pauldron3" 
		map Winterspring/0 
		path follow smart; loop; ants curved; dist 30
		path	46.5,28.7	46.4,24.1	45.9,14.9
		path	48.7,16.4	49.3,19.5	51.4,19.8
		path	51.0,24.0
		Defeat Frostsabers along the path
		goldcollect Arachnidian Pauldrons##14296|n
		goldcollect Thick Leather |n |only if skill("Skinning")>=250
		goldcollect Rugged Leather |n |only if skill("Skinning")>=250
		_Click here to sell_ the items you have collected |confirm |next "sell"
		_
		_Click here to continue farming_ more parts to the Arachnidian Cloth Set |confirm
		_Click here_ to go back to _Yeti Farming_ |confirm |next "Pauldron1"
	step
	label "BEAR1"
		Shardtooth Bears spawn in a small area
		You will be provided with 2 locations to farm between
		map Winterspring/0
		path follow loose; loop off; ants curved; dist 30
		path	59.6,33.6	58.2,28.8	55.2,30.6
		path	53.0,28.4	51.0,30.6	51.6,33.6
		goldcollect Arachnidian Girdle##14289 |n
		goldcollect Arachnidian Footpads##14290 |n
		You will be directed to the next area to farm the Arachnidian Girdle and Footpads |goto Winterspring/0 51.6,33.6 < 20 |noway |c
		_
		Click here to sell |confirm |next "sell"
		modelnpc Shardtooth Bear##7444
	step
	label "BEAR2"
		map Winterspring/0
		path follow loose; loop; ants curved; dist 50
		path	33.2,57.6	27.0,57.2
		This is a rather small path, be sure to search the area for bears
		goldcollect Arachnidian Girdle##14289 |n
		goldcollect Arachnidian Footpads##14290 |n
		modelnpc Shardtooth Bear##7444
		_Click here to return to farming_ the Arachnidian Girdle and Footpads at the previous location |confirm |next "BEAR1"
		_
		_Click here to move on_ to farming Arachnidian Cloth pieces from Twilight enemies |confirm
		Click here to sell |confirm |next "sell"
	step
	label "Twilight1"
		Kill Twilight's Hammer enemies at the provided locations:
		_Staghelm Point_ located here |goto Silithus/0 69.7,16.6
		_Twilight Base Camp_ located here |goto Silithus/0 45.4,41.5
		_Twilight Post_ located here |goto Silithus/0 34.0,31.8
		_Twilight Outpost_ located here |goto Silithus/0 27.7,75.1
		Click the provided locations to toggle between them.
		goldcollect Arachnidian Armor##14288 |n
		goldcollect Arachnidian Legguards##14295 |n
		goldcollect Encrypted Twilight Text##20404 |n
		goldcollect Runecloth##14047 |n
		_Click here to sell_ the items you have collected |confirm |next "sell"
		_
		_Click here to move on_ to farming Arachnidian Cloth pieces from the Zul'Farrak dungeon |confirm 
	step
	label "ZF1"
		Kill everything inside of Zul'Farrak
		Follow the path through Zul'Farrak until you reach the temple area |goto Zul'Farrak/0 24.4,17.6 < 15 |noway |c
		map Zul'Farrak/0
		path follow smart; loop off; ants curved; dist 20
		path	57.3,80.8	59.0,67.8	57.3,55.9
		path	53.8,47.4	50.7,42.4	46.6,49.2
		path	41.2,52.0	36.1,47.2	33.9,44.2
		path	30.8,45.1	27.5,39.6	30.6,37.2
		path	33.1,38.0	34.8,35.3	34.8,28.5
		path	31.9,24.1	28.6,17.8	24.4,17.6
		goldcollect Arachnidian Bracelets##14291 |n
		goldcollect Arachnidian Gloves##14294 |n
		_Click here to sell_ the items you have collected |confirm |next "sell"
		_
		_Click here to continue farming_ more parts to the Arachnidian Cloth Set |confirm |next "WF1e"
	step
	label "ZF2"
		Kill everything inside of Zul'Farrak.
		Once you have, you will be able to reset the instance.
		This step will take you back to the start of the dungeon. _Reset_ if you wish to continue |goto Zul'Farrak/0 57.6,78.9 < 15 |noway |c
		map Zul'Farrak/0
		path follow smart; loop off; ants curved; dist 20
		path	32.1,16.6	39.8,20.8	46.7,20.3
		path	55.4,30.9	59.4,40.8	54.8,39.9
		path	52.9,44.7	57.6,57.6	58.9,67.2
		path	57.6,78.9
		goldcollect Arachnidian Bracelets##14291 |n
		goldcollect Arachnidian Gloves##14294 |n
		Click here to sell the items you have collected |confirm |next "sell"
	step	
	label "WF1e"
		map Winterspring/0 
		path follow smart; loop off; ants curved; dist 25
		path	66.2,46.5	66.8,48.4	67.8,50.1
		path	69.1,50.6
		Defeat the Winterfall enemies in the area
		goldcollect Arachnidian Girdle##14289 |n
		goldcollect Arachnidian Footpads##14290 |n
		Click here to sell the items you have collected |confirm |next "sell"
	step
	label "sell"
		#include "auctioneer"
		Click here to go back to the start |confirm |next "Pauldron1"

	]])

ZygorGuidesViewer:RegisterGuide("GOLD\\Horde Daily Runs\\Hibernal Cloth Set Transmog",[[
	description This guide will put you on the path to obtaining the Jade Plate Set
	meta goldtype="xmog",levelreq=70,gold=100,time=15,icon="Interface\\ICONS\\inv_shirt_06"
	step
		This guide will point you in the direction to each piece of the Hibernal Cloth armors.
		Since they have a very low drop rate, do expect to farm for a bit for these items
		confirm always
	step
	label "Strath1"
		_Follow_ the path through King's Square |goto Stratholme/1 66.3,75.6 < 20
		_Continue_ along the streets of King's Square |goto 67.3,59.3 < 20
		_Turn left_ here |goto 60.0,55.0 < 20
		_Defeat_ the enemies in the area |goto 57.1,66.1 < 20
		goldcollect Hibernal Cowl##8115 |n
		goldcollect Hibernal Mantle##8111 |n
		goldcollect Hibernal Bracers##8108 |n
		goldcollect Hibernal Gloves##8110 |n
		goldcollect Hibernal Sash##8114 |n
		goldcollect Hibernal Pants##8112 |n
		goldcollect Hibernal Boots##8107 |n
		Secondary items:
		goldcollect Runecloth##14047 |n
		goldcollect Mageweave Cloth##4338 |n
		goldcollect Righteous Orb##12811 |n
		You will now be directed to the next section of the guide |goto 57.1,66.1 < 20 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell"
	step
		_Make your way_ through the gate to Market Row |goto Stratholme/1 60.0,41.9 < 15 |tip You will be trapped. Defeat the enemies who come
		_Continue through_ Market Row |goto Stratholme/1 59.4,31.1 < 20
		_Go through_ the large gates into Crusaders' Square |goto Stratholme/1 46.6,25.1 < 20
		_Enter_ the Scarlet Bastion |goto Stratholme/1 32.0,34.7 < 20
		_Go through_ the door to The Hoard |goto Stratholme/1 19.8,51.2 < 10
		goldcollect Hibernal Cowl##8115 |n
		goldcollect Hibernal Mantle##8111 |n
		goldcollect Hibernal Bracers##8108 |n
		goldcollect Hibernal Gloves##8110 |n
		goldcollect Hibernal Sash##8114 |n
		goldcollect Hibernal Pants##8112 |n
		goldcollect Hibernal Boots##8107 |n
		Secondary items:
		goldcollect Runecloth##14047 |n
		goldcollect Mageweave Cloth##4338 |n
		goldcollect Righteous Orb##12811 |n
		You will now be directed to the next section of the guide |goto Stratholme/1 19.8,51.2 < 10 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell"
	step
		_Make your way_ through the Hoard and defeat Willey Hopebreaker |goto Stratholme/1 4.1,50.8
		goldcollect Runecloth##14047 |n
		goldcollect Hibernal Cowl##8115 |n
		goldcollect Hibernal Mantle##8111 |n
		goldcollect Hibernal Bracers##8108 |n
		goldcollect Hibernal Gloves##8110 |n
		goldcollect Hibernal Sash##8114 |n
		goldcollect Hibernal Pants##8112 |n
		goldcollect Hibernal Boots##8107 |n
		Secondary items:
		goldcollect Runecloth##14047 |n
		goldcollect Mageweave Cloth##4338 |n
		goldcollect Righteous Orb##12811 |n
		You will now be directed to the next section of the guide |goto Stratholme/1 4.1,50.8 < 10 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell"
	step
		_Leave_ The Hoard |goto Stratholme/1 19.1,52.1 < 20
		_Go through_ the doors |goto Stratholme/1 19.1,52.1 < 20
		_Defeat_ Balnazzar |goto Stratholme/1 20.3,82.0 < 20
		goldcollect Hibernal Cowl##8115 |n
		goldcollect Hibernal Mantle##8111 |n
		goldcollect Hibernal Bracers##8108 |n
		goldcollect Hibernal Gloves##8110 |n
		goldcollect Hibernal Sash##8114 |n
		goldcollect Hibernal Pants##8112 |n
		goldcollect Hibernal Boots##8107 |n
		Secondary items:
		goldcollect Runecloth##14047 |n
		goldcollect Mageweave Cloth##4338 |n
		goldcollect Righteous Orb##12811 |n
		You will now be directed to the next section of the guide |goto Stratholme/1 20.3,82.0 < 20 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell"
	step
		_Leave_ the Scarlet Bastion |goto Stratholme/1 32.2,34.4 < 20
		_Go through_ the gate and travel through Market Row |goto Stratholme/1 50.6,23.7 < 20
		_Continue through_ Market Row |goto 61.3,29.7 < 20
		_Cross under_ the bridge |goto Stratholme/1 77.3,18.8 < 20
		_Go through_ Festival Lane |goto 82.2,24.7 < 20
		_Continue through_ the area |goto 81.6,42.8 < 20
		_Go through_ the Stratholme Gates |goto Stratholme/1 77.2,49.4 < 20
		_Continue through_ the gates |goto 73.1,55.2 < 20
		_Leave_ Stratholme |goto Eastern Plaguelands/0 27.8,11.6
		goldcollect Hibernal Cowl##8115 |n
		goldcollect Hibernal Mantle##8111 |n
		goldcollect Hibernal Bracers##8108 |n
		goldcollect Hibernal Gloves##8110 |n
		goldcollect Hibernal Sash##8114 |n
		goldcollect Hibernal Pants##8112 |n
		goldcollect Hibernal Boots##8107 |n
		Secondary items:
		goldcollect Runecloth##14047 |n
		goldcollect Mageweave Cloth##4338 |n
		goldcollect Righteous Orb##12811 |n
		You will now be directed to the next section of the guide |goto Eastern Plaguelands/0 27.8,11.6 < 10 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell"
	step
		_Go through_ the gate |goto Eastern Plaguelands/0 43.5,19.2 < 20
		_Go through_ the Service Entrance Gate |goto Stratholme/2 67.5,80.8 < 20
		_Make your way_ through the gates |goto Stratholme/2 61.4,58.3 < 20
		_Turn left_ when you reach this area |goto Stratholme/2 67.4,51.8 < 20
		_Defeat_ Nerub'enkan |goto Stratholme/2 56.5,46.8 < 20
		_Defeat_ the Thuzadin Acolytes inside the building |goto Stratholme/2 53.5,49.2 < 20
		goldcollect Hibernal Cowl##8115 |n
		goldcollect Hibernal Mantle##8111 |n
		goldcollect Hibernal Bracers##8108 |n
		goldcollect Hibernal Gloves##8110 |n
		goldcollect Hibernal Sash##8114 |n
		goldcollect Hibernal Pants##8112 |n
		goldcollect Hibernal Boots##8107 |n
		Secondary items:
		goldcollect Runecloth##14047 |n
		goldcollect Mageweave Cloth##4338 |n
		goldcollect Righteous Orb##12811 |n
		You will now be directed to the next section of the guide |goto Stratholme/2 53.5,49.2 < 5 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell"
	step
		_Back track_ to the fork in the road here |goto Stratholme/2 66.0,51.4 < 20
		_Defeat_ Baroness Anastari |goto Stratholme/2 74.8,46.8
		_Defeat_ the Thuzadin Acolytes inside the building |goto Stratholme/2 78.0,48.0
		goldcollect Hibernal Cowl##8115 |n
		goldcollect Hibernal Mantle##8111 |n
		goldcollect Hibernal Bracers##8108 |n
		goldcollect Hibernal Gloves##8110 |n
		goldcollect Hibernal Sash##8114 |n
		goldcollect Hibernal Pants##8112 |n
		goldcollect Hibernal Boots##8107 |n
		Secondary items:
		goldcollect Runecloth##14047 |n
		goldcollect Mageweave Cloth##4338 |n
		goldcollect Righteous Orb##12811 |n
		You will now be directed to the next section of the guide |goto Stratholme/2 78.0,48.0 < 10 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell"
	step
		_Pass through_ the alleyway |goto Stratholme/2 68.6,34.6 < 20
		_Defeat_ Maleki the Pallid |goto 67.9,20.4 < 20
		_Defeat_ the Thuzadin Acolytes inside the building |goto Stratholme/2 70.0,16.8 < 20
		goldcollect Hibernal Cowl##8115 |n
		goldcollect Hibernal Mantle##8111 |n
		goldcollect Hibernal Bracers##8108 |n
		goldcollect Hibernal Gloves##8110 |n
		goldcollect Hibernal Sash##8114 |n
		goldcollect Hibernal Pants##8112 |n
		goldcollect Hibernal Boots##8107 |n
		Secondary items:
		goldcollect Runecloth##14047 |n
		goldcollect Mageweave Cloth##4338 |n
		goldcollect Righteous Orb##12811 |n
		You will now be directed to the next section of the guide |goto Stratholme/2 70.0,16.8 < 10 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell"
	step
		_Make your way_ through |goto Stratholme/2 62.1,25.1
		_Defeat_ Magistrate Barthilas |goto 57.1,14.6
		_Pass through_ the gates to Slaughter Square |goto Stratholme/2 51.4,19.5 < 20
		_Defeat_ the Venom Belchers, Bile Spewers, Ramstein the Gorger, the horde of zombies that flood the room and finally the Black Guard |goto Stratholme/2 45.5,19.6
		_Defeat_ Lord Aurius Rivendare |goto Stratholme/2 38.3,20.2 |noway |c		
		modelnpc Lord Aurius Rivendare##45412 |n
		modelnpc Venom Belcher##10417 |n
		modelnpc Bile Spewer##10416 |n
		modelnpc Ramstein the Gorger##10439 |n
		modelnpc Black Guard Sentry##10394 |n
		goldcollect Hibernal Cowl##8115 |n
		goldcollect Hibernal Mantle##8111 |n
		goldcollect Hibernal Bracers##8108 |n
		goldcollect Hibernal Gloves##8110 |n
		goldcollect Hibernal Sash##8114 |n
		goldcollect Hibernal Pants##8112 |n
		goldcollect Hibernal Boots##8107 |n
		Secondary items:
		goldcollect Runecloth##14047 |n
		goldcollect Mageweave Cloth##4338 |n
		goldcollect Righteous Orb##12811 |n
		_
		Click here if you are ready to sell |confirm |next "sell"
	step
		_Leave_ the Slaughter House |goto Stratholme/2 42.9,20.4 < 20
		_Leave_ the Slaughter Square |goto Stratholme/2 53.1,19.1 < 20
		_Make your way_ through the gauntlet |goto Stratholme/2 59.5,29.3 < 20
		_Go through_ the gate |goto 58.0,37.3 < 20
		_Head towards_ the gates |goto Stratholme/2 66.5,53.3 < 20
		_Pass through_ the gates |goto 61.5,58.4 < 20
		_Leave_ Stratholme |goto 67.3,86.6 < 20
		goldcollect Hibernal Cowl##8115 |n
		goldcollect Hibernal Mantle##8111 |n
		goldcollect Hibernal Bracers##8108 |n
		goldcollect Hibernal Gloves##8110 |n
		goldcollect Hibernal Sash##8114 |n
		goldcollect Hibernal Pants##8112 |n
		goldcollect Hibernal Boots##8107 |n
		Secondary items:
		goldcollect Runecloth##14047 |n
		goldcollect Mageweave Cloth##4338 |n
		goldcollect Righteous Orb##12811 |n
		_
		If you wish to return to farming Stratholme, _reset the instance, then click here_ |confirm |next "Strath1"
		_Click here to sell_ any items you have |confirm |next "sell"
		_Click here_ if you want _to continue farming for more_ Hibernal Armor |confirm
	step
	label "BRD1"
		_Follow_ the path into the open area |goto Blackrock Depths/1 39.2,75.6
		_Enter_ the stone tunnel |goto 45.0,78.8
		_Go down_ the path |goto 46.7,88.8 |tip Clear the side rooms
		_Defeat_ High Interrogator Gerstahn |goto 47.5,93.1
		goldcollect Hibernal Armor##8106 |n
		goldcollect Runecloth##14047 |n
		goldcollect Tender Wolf Meat##12208 |n
		goldcollect Red Wolf Meat##12203 |n
		You will now be directed to the next section of the guide |goto 47.5,93.1 < 20 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell"
	step
		_Make your way_ through the door |goto Blackrock Depths/1 48.3,97.8 < 20
		_Follow_ the curved path |goto 51.7,92.0 < 20
		_Continue_ along the path |goto 51.4,84.9 < 20
		_Move into_ the open room |goto 47.1,77.5 < 20
		_Make your way_ into the corridor |goto 45.6,67.3 < 20
		_Follow_ the path down |goto 47.6,58.6 < 20
		_Turn right_ into the room here |goto 54.4,59.0 < 20
		_Defeat_ Houndmaster Grebmar |goto Blackrock Depths/1 51.5,62.2 < 20
		goldcollect Hibernal Armor##8106 |n
		goldcollect Runecloth##14047 |n
		goldcollect Tender Wolf Meat##12208 |n
		goldcollect Red Wolf Meat##12203 |n
		You will now be directed to the next section of the guide |goto Blackrock Depths/1 51.5,62.2 < 10 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell"
	step
		_Leave_ the room |goto Blackrock Depths/1 54.8,59.3
		_Make your way_ through the tunnel |goto 55.7,68.0
		_Exit_ the tunnel into the open room |goto 48.1,72.5
		_Go through_ the door |goto Blackrock Depths/1 37.8,66.0
		_Go down_ to the path |goto 34.9,60.3
		_Defeat_ Bael'Gar |goto 25.0,52.7
		goldcollect Hibernal Armor##8106 |n
		goldcollect Runecloth##14047 |n
		goldcollect Tender Wolf Meat##12208 |n
		goldcollect Red Wolf Meat##12203 |n
		You will now be directed to the next section of the guide |goto 25.0,52.7 < 10 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell"
	step
		_Follow_ the path |goto Blackrock Depths/1 28.4,56.2
		_Make your way_ towards the giant gates |goto 36.8,59.6
		_Go through_ the gate |goto Blackrock Depths/1 44.4,50.0
		_Defeat_ Lord Incendius |goto Blackrock Depths/1 56.5,31.4
		goldcollect Hibernal Armor##8106 |n
		goldcollect Runecloth##14047 |n
		goldcollect Tender Wolf Meat##12208 |n
		goldcollect Red Wolf Meat##12203 |n
		You will now be directed to the next section of the guide |goto 56.5,31.4 < 10 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell"
	step
		_Go up_ the ramp |goto Blackrock Depths/1 61.2,24.3 < 15
		_Continue_ up the ramp |goto Blackrock Depths/1 66.5,25.7 < 15
		_Go through_ the door |goto Blackrock Depths/2 60.4,60.0 < 15
		_Enter_ the Black Vault |goto Blackrock Depths/1 59.0,35.0 < 15
		Defeat Warder Stilgiss |goto Blackrock Depths/2 60.9,68.2 < 10
		goldcollect Hibernal Armor##8106 |n
		goldcollect Runecloth##14047 |n
		goldcollect Tender Wolf Meat##12208 |n
		goldcollect Red Wolf Meat##12203 |n
		You will now be directed to the next section of the guide |goto Blackrock Depths/2 60.9,68.2 < 10 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell"
	step
		_Leave_ the room |goto Blackrock Depths/2 58.5,64.1 < 15
		_Enter_ the doorway |goto Blackrock Depths/2 54.4,65.0 < 15
		_Go up_ the stairs |goto Blackrock Depths/2 53.3,68.1 <15
		_Enter_ the pathway |goto 56.3,76.0 < 20
		_Follow_ the path back |goto Blackrock Depths/2 56.3,93.4 < 15
		Defeat Pyromancer Loregrain |goto 54.2,96.3
		goldcollect Hibernal Armor##8106 |n
		goldcollect Runecloth##14047 |n
		goldcollect Tender Wolf Meat##12208 |n
		goldcollect Red Wolf Meat##12203 |n
		You will now be directed to the next section of the guide |goto 54.2,96.3 < 10 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell"
	step
		_Go up_ the ramp |goto Blackrock Depths/2 55.7,90.0 < 20
		_Go down_ the ramp |goto Blackrock Depths/1 45.9,63.1 < 15
		_Jump down_ here |goto Blackrock Depths/2 42.1,89.7 < 15
		_Click_ the switch |goto 41.2,88.3
		goldcollect Hibernal Armor##8106 |n
		goldcollect Runecloth##14047 |n
		goldcollect Tender Wolf Meat##12208 |n
		goldcollect Red Wolf Meat##12203 |n
		You will now be directed to the next section of the guide |goto 41.2,88.3 < 10 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell"
	step
		_Go up_ the ramp |goto Blackrock Depths/2 42.2,90.4 < 20
		Make your way _into the hallway_ |goto Blackrock Depths/2 46.0,86.3 < 20
		_Go down_ the hallway |goto Blackrock Depths/2 47.4,81.7 < 20
		_Go through_ the door |goto Blackrock Depths/1 43.1,47.3 < 20
		_Go into_ the open room |goto Blackrock Depths/2 38.6,77.3 < 20
		_Go down_ the ramp |goto 36.4,80.6< 20
		Deafeat General Angerforge |goto 36.6,84.4
		goldcollect Hibernal Armor##8106 |n
		goldcollect Runecloth##14047 |n
		goldcollect Tender Wolf Meat##12208 |n
		goldcollect Red Wolf Meat##12203 |n
		You will now be directed to the next section of the guide |goto 36.6,84.4 < 10 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell" 
	step
		_Go up_ the stairs |goto Blackrock Depths/2 36.5,80.1 < 15
		_Go down_ the ramp |goto 36.5,76.5 < 15
		Defeat Golem Lord Argelmach |goto Blackrock Depths/2 36.7,65.5 
		goldcollect Hibernal Armor##8106 |n
		goldcollect Runecloth##14047 |n
		goldcollect Tender Wolf Meat##12208 |n
		goldcollect Red Wolf Meat##12203 |n
		You will now be directed to the next section of the guide |goto Blackrock Depths/2 36.7,65.5  < 10 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell" 
	step
		_Go down_ the hallway |goto Blackrock Depths/2 40.8,68.3 < 15
		_Go up_ the stairs |goto Blackrock Depths/2 46.9,65.0 < 15
		_Continue up_ the stairs |goto Blackrock Depths/2 51.8,65.4 < 15
		talk Plugger Spazzring##9499
		buy 2 Dark Iron Ale Mug##11325 |goto Blackrock Depths/2 49.8,61.2 < 15
		goldcollect Hibernal Armor##8106 |n
		goldcollect Runecloth##14047 |n
		goldcollect Tender Wolf Meat##12208 |n
		goldcollect Red Wolf Meat##12203 |n
		_
		Click here if you are ready to sell |confirm |next "sell" 
	step
		talk Private Rocknot##9503
		accept Rocknot's Ale##4295 |goto 51.03,60.67 |instant
		Attack the Bar Patrons, it will force the Fireguard Destroyer out
		Defeat Fireguard Destroyer |goto Blackrock Depths/2 52.4,63.3 < 15
		_Go down_ the ramp |goto Blackrock Depths/1 53.0,32.0 < 15
		_Enter_ the doorway then go down the stairs |goto Blackrock Depths/2 53.4,56.1 < 15
		Defeat Ambassador Flamelash |goto Blackrock Depths/2 53.6,49.1
		goldcollect Hibernal Armor##8106 |n
		goldcollect Runecloth##14047 |n
		goldcollect Tender Wolf Meat##12208 |n
		goldcollect Red Wolf Meat##12203 |n
		You will now be directed to the next section of the guide |goto Blackrock Depths/2 53.6,49.1 < 10 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell" 
	step
		_Go through_ the doorway |goto Blackrock Depths/2 49.4,41.9
		_Make your way_ through the room |goto Blackrock Depths/2 48.5,34.4 < 20 |tip Clear the entire room 
		_Go down_ the ramp |goto 50.1,29.1 < 15
		talk Doom'rel##9039 |goto Blackrock Depths/2 56.5,21.9
		Tell him: _Your bondage is at an end, Doom'rel. I challenge you!_
		goldcollect Hibernal Armor##8106 |n
		goldcollect Runecloth##14047 |n
		goldcollect Tender Wolf Meat##12208 |n
		goldcollect Red Wolf Meat##12203 |n
		After you complete the event, click here to continue |confirm
		_
		Click here if you are ready to sell |confirm |next "sell" 
	step
		_Go through_ the door |goto Blackrock Depths/2 57.5,23.6 < 15
		_Continue_ through the giant doors |goto Blackrock Depths/2 60.8,18.6 < 15
		kill Shadowforge Flame Keeper##9956 |n
		collect Shadowforge Torch##11885 |n
		click Shadowforge Brazier
		Light the Shadowforge Brazier |goto Blackrock Depths/2 71.5,16.9
		goldcollect Hibernal Armor##8106 |n
		goldcollect Runecloth##14047 |n
		goldcollect Tender Wolf Meat##12208 |n
		goldcollect Red Wolf Meat##12203 |n
		After you light this torch, click here to continue |confirm
		_
		Click here if you are ready to sell |confirm |next "sell" 
	step
		kill Shadowforge Flame Keeper##9956 |n
		collect Shadowforge Torch##11885 |n
		click Shadowforge Brazier
		Light the Shadowforge Brazier |goto Blackrock Depths/2 71.9,6.9 < 15
		_Go through_ the doorway |goto Blackrock Depths/2 75.1,11.1 < 15
		Defeat Magmus |goto Blackrock Depths/2 81.5,11.9
		goldcollect Hibernal Armor##8106 |n
		goldcollect Runecloth##14047 |n
		goldcollect Tender Wolf Meat##12208 |n
		goldcollect Red Wolf Meat##12203 |n
		You will now be directed to the next section of the guide |goto Blackrock Depths/2 81.5,11.9 < 10 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell" 
	step
		_Go through_ the giant doors |goto Blackrock Depths/2 85.8,11.9 < 15
		Clear out the room as you go through it
		Defeat Emperor Dagran Thaurissan |goto 93.1,11.9
		goldcollect Hibernal Armor##8106 |n
		goldcollect Runecloth##14047 |n
		goldcollect Tender Wolf Meat##12208 |n
		goldcollect Red Wolf Meat##12203 |n
		After you defeat Emperor Dagran, click here to continue |confirm
		_
		Click here if you are ready to sell |confirm |next "sell" 
	step
		_Go through_ the big doors |goto Blackrock Depths/2 85.4,12.0 < 20
		_Continue_ through the big doors |goto 74.9,12.9 < 20
		_Go up_ the ramp |goto Blackrock Depths/2 59.8,20.0
		_Go down_ the ramp |goto 59.0,23.7
		_Enter_ the molten core |goto Blackrock Depths/2 68.4,38.3 < 10
		goldcollect Hibernal Armor##8106 |n
		goldcollect Runecloth##14047 |n
		goldcollect Tender Wolf Meat##12208 |n
		goldcollect Red Wolf Meat##12203 |n
		You will now be directed to the next section of the guide |goto Blackrock Depths/2 68.4,38.3 < 10 |noway |c
		_
		Click here if you are ready to sell |confirm |next "sell"  |goto Blackrock Depths/2 68.4,38.3 < 10
	step	
		_Leave_ the Molten Core |goto Burning Steppes/16 54.4,83.5 < 20
		This step will take you back to the start of the dungeon. _Reset_ if you wish to continue |confirm |next "BRD1"
		_
		_Click here_ if you wish _to return to farming Stratholme_ |confirm |next "Strath1"
		_
		_Click here to sell_ the items you have |confirm |next "sell"  |goto Blackrock Depths/2 68.4,38.3 < 10
	step
	label "sell"
		#include "auctioneer"
		Click here to go back to the start |confirm |next "Strath1"
		Click here to go back to farming Blackrock Depths |confirm |next "BRD1"				
	]])


ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Green Cabbage",[[
	condition valid completedq(30257)
	meta goldtype="till",levelreq=86,time=1440,icon="Interface\\ICONS\\INV_Misc_Food_Vendor_GreenCabbage"
	#include "goldg_farm",seed="Green Cabbage Seeds##79102",veggie="Green Cabbage##74840"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Mogu Pumpkin",[[
	condition valid completedq(30257)
	meta goldtype="till",levelreq=86,time=1440,icon="Interface\\ICONS\\INV_Misc_Food_Vendor_MoguPumpkin"
	#include "goldg_farm",seed="Mogu Pumpkin Seeds##80592",veggie="Mogu Pumpkin##74842"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Juicycrunch Carrot",[[
	condition valid completedq(30257)
	meta goldtype="till",levelreq=86,time=1440,icon="Interface\\ICONS\\INV_Misc_Food_Vendor_Carrot"
	#include "goldg_farm",seed="Juicycrunch Carrot Seeds##80590",veggie="Juicycrunch Carrot##74841"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Scallion",[[
	condition valid completedq(30257)
	meta goldtype="till",levelreq=86,time=1440,icon="Interface\\ICONS\\INV_Misc_Food_Vendor_Scallions"
	#include "goldg_farm",seed="Scallion Seeds##80591",veggie="Scallions##74843"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Red Blossom Leek",[[
	condition valid completedq(30257)
	meta goldtype="till",levelreq=86,time=1440,icon="Interface\\ICONS\\INV_Misc_Food_Vendor_RedBlossomLeek"
	#include "goldg_farm",seed="Red Blossom Leek Seeds##80593",veggie="Red Blossom Leek##74844"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Witchberries",[[
	condition valid completedq(30257)
	meta goldtype="till",levelreq=86,time=1440,icon="Interface\\ICONS\\INV_Misc_Food_Vendor_Witchberries"
	#include "goldg_farm",seed="Witchberry Seeds##89326",veggie="Witchberries##74846"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Jade Squash",[[
	condition valid completedq(30257)
	meta goldtype="till",levelreq=86,time=1440,icon="Interface\\ICONS\\INV_Misc_Food_Vendor_JadeSquash"
	#include "goldg_farm",seed="Jade Squash Seeds##89328",veggie="Jade Squash##74847"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Striped Melon",[[
	condition valid completedq(30257)
	meta goldtype="till",levelreq=86,time=1440,icon="Interface\\ICONS\\INV_Misc_Food_Vendor_StripedMelon"
	#include "goldg_farm",seed="Striped Melon Seeds##89329",veggie="Striped Melon##74848"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Pink Turnips",[[
	condition valid completedq(30257)
	meta goldtype="till",levelreq=86,time=1440,icon="Interface\\ICONS\\INV_Misc_Food_Vendor_PinkTurnip"
	#include "goldg_farm",seed="Pink Turnip Seeds##80594",veggie="Pink Turnip##74849"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\White Turnips",[[
	condition valid completedq(30257)
	meta goldtype="till",levelreq=86,time=1440,icon="Interface\\ICONS\\INV_Misc_Food_Vendor_WhiteTurnip"
	#include "goldg_farm",seed="White Turnip Seeds##80595",veggie="White Turnip##74850"
]])