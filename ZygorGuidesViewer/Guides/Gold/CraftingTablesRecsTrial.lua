local ZGV = ZygorGuidesViewer
if not ZGV then return end

local ZGVG=ZGV.Gold
if not ZGVG then return end

if ZGV:DoMutex("GoldCraftingWOD") then return end

if not ZGV.Gold.Crafting then ZGV.Gold.Crafting = {} end
local Crafting = ZGV.Gold.Crafting

Crafting.AllRecipes = {
	[129] = {
	},
	[164] = {
		[2660] = {
			["name"] = "Rough Sharpening Stone",
			["spell"] = 2660,
			["productid"] = 2862,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 2835,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[2663] = {
			["name"] = "Copper Bracers",
			["spell"] = 2663,
			["productid"] = 2853,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 2,
					["id"] = 2840,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[3115] = {
			["name"] = "Rough Weightstone",
			["spell"] = 3115,
			["productid"] = 3239,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 2835,
				},
				{
					["num"] = 1,
					["id"] = 2589,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[12260] = {
			["name"] = "Rough Copper Vest",
			["spell"] = 12260,
			["productid"] = 10421,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 4,
					["id"] = 2840,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
	},
	[165] = {
		[2149] = {
			["name"] = "Handstitched Leather Boots",
			["spell"] = 2149,
			["productid"] = 2302,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 2320,
				},
				{
					["num"] = 2,
					["id"] = 2318,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[2152] = {
			["name"] = "Light Armor Kit",
			["spell"] = 2152,
			["productid"] = 2304,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 2318,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[2881] = {
			["name"] = "Light Leather",
			["spell"] = 2881,
			["productid"] = 2318,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 3,
					["id"] = 2934,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[7126] = {
			["name"] = "Handstitched Leather Vest",
			["spell"] = 7126,
			["productid"] = 5957,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 2320,
				},
				{
					["num"] = 3,
					["id"] = 2318,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[9058] = {
			["name"] = "Handstitched Leather Cloak",
			["spell"] = 9058,
			["productid"] = 7276,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 2320,
				},
				{
					["num"] = 2,
					["id"] = 2318,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[9059] = {
			["name"] = "Handstitched Leather Bracers",
			["spell"] = 9059,
			["productid"] = 7277,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 3,
					["id"] = 2320,
				},
				{
					["num"] = 2,
					["id"] = 2318,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
	},
	[393] = {
	},
	[202] = {
		[3918] = {
			["name"] = "Rough Blasting Powder",
			["spell"] = 3918,
			["productid"] = 4357,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 2835,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[3919] = {
			["name"] = "Rough Dynamite",
			["spell"] = 3919,
			["productid"] = 4358,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 4357,
				},
				{
					["num"] = 1,
					["id"] = 2589,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
	},
	[171] = {
		[2329] = {
			["name"] = "Elixir of Lion's Strength",
			["spell"] = 2329,
			["productid"] = 2454,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 765,
				},
				{
					["num"] = 1,
					["id"] = 3371,
				},
				{
					["num"] = 1,
					["id"] = 2449,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[2330] = {
			["name"] = "Minor Healing Potion",
			["spell"] = 2330,
			["productid"] = 118,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 765,
				},
				{
					["num"] = 1,
					["id"] = 3371,
				},
				{
					["num"] = 1,
					["id"] = 2447,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[7183] = {
			["name"] = "Elixir of Minor Defense",
			["spell"] = 7183,
			["productid"] = 5997,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 2,
					["id"] = 765,
				},
				{
					["num"] = 1,
					["id"] = 3371,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
	},
	[333] = {
		[7418] = {
			["name"] = "Enchant Bracer - Minor Health",
			["spell"] = 7418,
			["productid"] = 7418,
			["type"] = enchant,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 10940,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[7421] = {
			["name"] = "Runed Copper Rod",
			["spell"] = 7421,
			["productid"] = 6218,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 10940,
				},
				{
					["num"] = 1,
					["id"] = 10938,
				},
				{
					["num"] = 1,
					["id"] = 6217,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[7428] = {
			["name"] = "Enchant Bracer - Minor Dodge",
			["spell"] = 7428,
			["productid"] = 7428,
			["type"] = enchant,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 10940,
				},
				{
					["num"] = 1,
					["id"] = 10938,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
	},
	[755] = {
		[25255] = {
			["name"] = "Delicate Copper Wire",
			["spell"] = 25255,
			["productid"] = 20816,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 2,
					["id"] = 2840,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[25493] = {
			["name"] = "Braided Copper Ring",
			["spell"] = 25493,
			["productid"] = 20906,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 2,
					["id"] = 20816,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[26925] = {
			["name"] = "Woven Copper Ring",
			["spell"] = 26925,
			["productid"] = 21931,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 2,
					["id"] = 20816,
				},
				{
					["num"] = 1,
					["id"] = 2840,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
	},
	[773] = {
		[45382] = {
			["name"] = "Scroll of Stamina",
			["spell"] = 45382,
			["productid"] = 1180,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 39354,
				},
				{
					["num"] = 1,
					["id"] = 37101,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[48114] = {
			["name"] = "Scroll of Intellect",
			["spell"] = 48114,
			["productid"] = 955,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 39354,
				},
				{
					["num"] = 1,
					["id"] = 37101,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[48116] = {
			["name"] = "Scroll of Spirit",
			["spell"] = 48116,
			["productid"] = 1181,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 39354,
				},
				{
					["num"] = 1,
					["id"] = 37101,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[52738] = {
			["name"] = "Ivory Ink",
			["spell"] = 52738,
			["productid"] = 37101,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 39151,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
	},
	[182] = {
	},
	[185] = {
		[2538] = {
			["name"] = "Charred Wolf Meat",
			["spell"] = 2538,
			["productid"] = 2679,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 2672,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[2540] = {
			["name"] = "Roasted Boar Meat",
			["spell"] = 2540,
			["productid"] = 2681,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 769,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[8604] = {
			["name"] = "Herb Baked Egg",
			["spell"] = 8604,
			["productid"] = 6888,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 6889,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
	},
	[186] = {
		[2657] = {
			["name"] = "Smelt Copper",
			["spell"] = 2657,
			["productid"] = 2840,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 2770,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
	},
	[197] = {
		[2387] = {
			["name"] = "Linen Cloak",
			["spell"] = 2387,
			["productid"] = 2570,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 2320,
				},
				{
					["num"] = 1,
					["id"] = 2996,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[2393] = {
			["name"] = "White Linen Shirt",
			["spell"] = 2393,
			["productid"] = 2576,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 2320,
				},
				{
					["num"] = 1,
					["id"] = 2996,
				},
				{
					["num"] = 1,
					["id"] = 2324,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[2963] = {
			["name"] = "Bolt of Linen Cloth",
			["spell"] = 2963,
			["productid"] = 2996,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 2,
					["id"] = 2589,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[3915] = {
			["name"] = "Brown Linen Shirt",
			["spell"] = 3915,
			["productid"] = 4344,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 2320,
				},
				{
					["num"] = 1,
					["id"] = 2996,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
		[12044] = {
			["name"] = "Simple Linen Pants",
			["spell"] = 12044,
			["productid"] = 10045,
			["type"] = item,
			["nummade"] = {
				1,
				1,
			},
			["reagents"] = {
				{
					["num"] = 1,
					["id"] = 2320,
				},
				{
					["num"] = 1,
					["id"] = 2996,
				},
			},
			["source"] = "starter",
			["learnedat"] = "1",
		},
	},
}
