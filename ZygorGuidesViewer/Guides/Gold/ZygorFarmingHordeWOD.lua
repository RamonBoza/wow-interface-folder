local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Horde" then return end

-- Cooking Farming
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Clam Meat, Small Lustrous Pearl",[[
	condition valid raceclass("Horde")
	meta goldtype="route",levelreq={3,4},itemtype="misc"
	step
		map Echo Isles
		path follow smart; loop on; ants curved
		path	64.9,25.9	67.2,18.3	65.2,10.4
		path	59.4,9.3	54.9,13.1	56.7,23.7
		kill Spitescale Wavethrasher##38300+, Spitescale Siren##38301+ |tip Follow the path as well as enter the cave when you come across it
		use Small Barnacled Clam##5523
		goldcollect 324 Clam Meat##5503
		goldcollect 8 Small Lustrous Pearl##5498
		|meta crap_items_follow=1
		goldtracker
		_Click here_ to sell items |confirm
	step
		#include "auctioneer"
]])