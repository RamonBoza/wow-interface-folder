local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Horde" then return end
if ZGV:DoMutex("DailiesHMOP") then return end
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Dailies Guides\\Pandaria (85 - 90)\\The Anglers Dailies",[[
description This guide will take you through The Anglers dailies
description Becoming Exalted with The Anglers allows you to purchase a companion pet, fishing poles, and water mounts.
startlevel 90
#include "H_Anglers"
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Dailies Guides\\Pandaria (85 - 90)\\The August Celestials Dailies",[[
description This guide will take you through The August Celestials dailies
description Becoming Exalted with The August Celestials allows you to purchase flying mounts and armor for your character.
completion quests
startlevel 90
#include "August_Celestials"
step
label end
'This is the end of the current guide. Click here to go back to the beginning. |confirm |next "startaug"
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Dailies Guides\\Pandaria (85 - 90)\\The Order of the Cloud Serpent Dailies",[[
description This guide will take you through the Order of the Cloud Serpent dailies
description Becoming Exalted with The Order of the Cloud Serpent allows you to purchase flying mounts and designs for companion pets.
completion quests,10,11,18
startlevel 90
#include "H_Cloud_Serpent"
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Dailies Guides\\Pandaria (85 - 90)\\The Shado-Pan Dailies",[[
description This guide will take you through the Shado-Pan dailies
description Becoming Exalted with The Shado-Pan allows you to purchase ground mounts and armor for your character.
completion quests
startlevel 90
#include "Shado_Pan_Daily_H"
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Dailies Guides\\Pandaria (85 - 90)\\The Tillers Dailies",[[
description This guide will take you through The Tillers dailies
description Becoming Exalted with The Tillers allows you to purchase ground mounts and recipes for your character.
startlevel 90
completion quests
step
#include "H_Tillers"
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Dailies Guides\\Pandaria (85 - 90)\\The Golden Lotus Dailies",[[
description This guide will take you through The Golden Lotus dailies
description Becoming Exalted with the Golden Lotus allows you to purchase a CC trinket with fun visuals, some armor for Justice Points, epic chests, rings, and shoulders for Valor Points, and ground mounts.
achieveid 7315,6546
startlevel 90
step
'Routing to proper section |next "prequests" |only if not completedq(31511)
'Routing to proper section |next "dailies" |only if completedq(31511)
step
label "prequests"
#include "Golden_Lotus_PreQuests"
#include "Golden_Lotus"
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Dailies Guides\\Pandaria (85 - 90)\\The Klaxxi Dailies",[[
description This guide will take you through The Klaxxi dailies
description Becoming Exalted with The Klaxxi allows you to purchase ground mounts, plans for blacksmithing, armor, and weapons for your character.
startlevel 90
#include "H_Klaxxi"
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Dailies Guides\\Pandaria (85 - 90)\\Pandaria Cooking Dailies",[[
description This guide will take you through the Cooking dailies
completion quests
startlevel 90
step
label "start"
'Proceeding to Cooking Dailies |condition completedq(30257) |next "cookday" |only if completedq(30257)
'Moving to the Cooking prequests. |next |condition not completedq(30257) |only if not completedq(30257)
step
#include "tillers_prequests"
step
label "cookday"
#include "H_MOP_Cooking_Dailies"
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Dailies Guides\\Pandaria (85 - 90)\\Dominance Offensive Dailies",[[
description This guide will take you through The Dominance Offensive dailies
description Becoming Exalted with the Dominance Offensive allows you to purchase an epic flying mount, epic armor, and battle pets for your character.
startlevel 90
#include "Dominance_Offensive"
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Dailies Guides\\Pandaria (85 - 90)\\Beast Master Dailies (Dominance Offensive)",[[
description This guide will take you through the bonus Dominance Offensive Dailies.
startlevel 90
#include "Sturdy_Traps"
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Dailies Guides\\Pandaria (85 - 90)\\Sunreaver Onslaught Dailies",[[
description This guide will take you through the Sunreaver Onslaught Dailies.
startlevel 90
step
#include "Sunreavers_dailies"
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Dailies Guides\\Pandaria (85 - 90)\\Timeless Isle Dailies",[[
description This guide will help you complete the dailies on the Timeless Isle
description Completing these dailies awards you with Timeless Coins, as well as Valor Points
condition suggested level>=90
startlevel 90
step
'Routing to proper section |next "prequests" |only if not completedq(33333)
'Routing to proper section |next "dailies" |only if completedq(33333)
step
label "prequests"
#include "timeless_isle_prequests"
step
label "dailies"
.talk 73303
..accept 33374 |goto Timeless Isle 42.9,55.3
step
.talk 72870
..accept 33334 |goto Timeless Isle 34.6,53.7 |tip This is a weekly quest
..accept 33338 |goto Timeless Isle 34.6,53.7 |tip This is a weekly quest
step
label "rares"
'This quest requires you to kill 5 _rare spawns_ on the Timeless Isle.
'Most of the spawns are on a timer, so you will need to wait for them to respawn. If there are other conditions, they are listed with the mob.
|tip It's recommended that you have at least 1-2 other people helping you with this, as some of the rare spawns have a lot of health.
|confirm
step
.from Monstrous Spineclaw##73166
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 26.9,76.4 |next "out"
step
.from Great Turtle Furyshell##73161
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 25.6,55.5 |next "out"
step
.from Chelon##72045
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 25.2,35.7 |next "out"
step
.from Ironfur Steelhorn##73160 |tip He can spawn in the place of any of the steelhorns in this area.
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |goto Timeless Isle/0 37.3,43.0 |q 33334/1 |next "out"
step
.from Spirit of Jadefire##72769
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/22 56.0,30.7 |next "out"
step
.from Rock Moss##73157
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/22 45.4,29.4 |next "out"
step
.from Tsavo'ka##72808
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 54.6,44.3 |next "out"
step
.' Wait for the cave-in, then click the hammer that spawns here. It may take a minute for the hammer to spawn, but it shouldn't be too long. |goto Timeless Isle/0 59.2,48.3
|confirm
step
.click Cave-In
.from Spelurk##71864+
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 59.1,48.6 |next "out"
step
.from Golganarr##72970
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 62.5,63.5 |next "out"
step
.from Bufo##72775 |tip Bufo cn spawn in the place of any Gulp Frog in this area.
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 62.7,74.6 |next "out"
step
.from Rattleskew##72048
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 60.7,88.0 |next "out"
step
.from Zesqua##72245
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 46.9,87.3 |next "out"
step
.talk 72151
.' Ask him to fish up Karkanos for you. |goto Timeless Isle/0 34.0,83.8
|confirm
step
.from Karkanos##72193
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 34.2,84.7 |next "out"
step
.from Gu'chi the Swarmbringer##72909 |tip He walks around the village here, so some searching may be necessary.
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 40.4,78.0 |next "out"
step
.from Skunky Brew Alemental##71908+ |goto Timeless Isle/0 38.0,77.6 |tip You will have to wait for these to spawn as a random event. After killing 10, Zhu-Gon will spawn.
|confirm
step
.from Zhu-Gon the Sour##71919+
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 38.0,77.6 |next "out"
step
.from Cranegnasher##73854
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 44.5,69.0 |next "out"
step
.from Imperial Python##73163
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle 44.4,65.5 |next "out"
step
.from Emerald Gander##73158
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 40.7,68.8 |next "out"
step
.from Jakur of Ordon##73169
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 51.5,83.3 |next "out"
step
.from Watcher Osu##73170
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 57.5,77.1 |next "out"
step
.from Champion of the Black Flame##73171 |tip The all 3 walk up and down this path here, some searching may be necessary.
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 70.9,49.9 |next "out"
step
.from Huolon##73167
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 72.9,48.7 |next "out"
step
.from Leafmender##73277
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 67.3,44.1 |next "out"
step
.from Cinderfall##73175 |tip On the bridge up above.
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 54.0,52.4 |next "out"
step
.from Garnia##73282
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 64.8,28.8 |next "out"
step
.from Flintlord Gairan##73172
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle 48.2,38.4 |next "out"
step
.from Urdur the Cauterizer##73173
.' Click here if he is not available or you have just killed him |confirm |next
..' Kill 5 rares on the Timeless Isle |q 33334/1 |goto Timeless Isle/0 45.4,26.6 |next "out"
step
.from Evermaw##73279
.' He swims in a circle around the isle. He's very fast, so you will either need some kind of water-walking, or the Cursed Swabby Helmet in order to fight him.
.' He has also been found around the following coordinates:
.' [14.5,56.5]
.' [16.1,63.9]
.' [33.3,2.6]
.' [63.4,6.9]
.' [79.6,30.4]
.' [79.0,70.0]
.' [75.0,84.0]
.' [55.0,91.0]
.' [30.0,89.0]
.collect 1 Mist-Filled Spirit Lantern##104115 |tip This is a guaranteed drop.
.' Click here if he is not available or you have just killed him |confirm |goto Timeless Isle/0 14.1,37.5 |next "rares"
..' Kill 5 rares on the Timeless Isle |q 33334/1 |next "out"
step
label "out"
.from Ironfur Great Bull##72844+
.from Brilliant Windfeather##72762+
.from Death Adder##72841+
.from Great Turtle##72764+
.from Elder Great Turtle##72765+
.' Kill 20 Elite creatures on the Timeless Isle |q 33374/1 |goto Timeless Isle 27.0,58.6
step
.from Ironfur Great Bull##72844+, Ironfur Herdling##72842+, Ironfur Grazer##72843+
.from Great Turtle##72764+, Great Turtle Hatchling##72763+, Elder Great Turtle##72765+
.from Windfeather Chick##71143+, Windfeather Nestkeeper##72761+, Brilliant Windfeather##72762+
.from Death Adder##72841+
.get 50 Epoch Stone##105715 |q 33338/1 |goto Timeless Isle 27.0,58.6
step
.talk 73570
..accept 33211 |goto Timeless Isle/0 65.0,50.5
step
.talk 73570
.' Answer a question about Warcraft's lore. |q 33211/1 |goto Timeless Isle/0 65.0,50.5 |tip If you miss it, don't worry, you can just keep guessing until you get one right.
step
.talk 73570
..turnin 33211 |goto Timeless Isle/0 65.0,50.5
step
.talk 73303
..turnin 33374 |goto Timeless Isle 42.9,55.3
step
.talk 72870
..turnin 33334 |goto Timeless Isle 34.6,53.7
..turnin 33338 |goto Timeless Isle 34.6,53.7
step
label "end"
'You have reached the end of the guide for today.
.' Click here to go back to the beginning of the dailies. |confirm |next "dailies"
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Events Guides\\Brawler's Guild\\Brawl'gar Arena", [[
description This guide will help you achieve rank 10 in the Brawler's Guild.
startlevel 90
#include "H_Brawl"
]])
