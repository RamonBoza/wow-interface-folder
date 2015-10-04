local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Alliance" then return end

-- Cooking Farming
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Clam Meat, Small Lustrous Pearl",[[
	condition valid raceclass("Alliance")
	meta goldtype="route",levelreq={17,18},itemtype="misc"
	step
		kill Murloc Nightcrawler##544+ |goto Redridge Mountains 71.8,56.1 |tip When you kill all 6, 2 more will spawn instantly
		use Small Barnacled Clam##5523
		goldcollect 196 Clam Meat##5503
		goldcollect 4 Small Lustrous Pearl##5498
		|meta crap_items_follow=1
		goldcollect 216 Wool Cloth##2592
		goldcollect 292 Linen Cloth##2589
		goldtracker
		_Click here_ to sell items |confirm
	step
		#include "auctioneer"
]])