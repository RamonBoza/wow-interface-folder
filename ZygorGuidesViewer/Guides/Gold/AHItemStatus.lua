local ZGV = ZygorGuidesViewer
if not ZGV then return end

local ZGVG=ZGV.Gold

if not ZGV.Gold.Auctions then ZGV.Gold.Auctions = {} end
local Auctions = ZGV.Gold.Auctions

Auctions.Flags = {
	ARMOR =		{mod=0,  type="Red",	name="Armor", description="May not sell quickly"},
	TRADEGOODS_1 =	{mod=10, type="Green",	name="Popular trade goods", description="Popular trade good, should sell very nicely."},
	TRADEGOODS_2 =	{mod=7,  type="Green",	name="Trade goods", description="Trade good, should sell nicely."},
	WEAPON =	{mod=0,  type="Red",	name="Weapon", description=""},
	CONSUMABLE =	{mod=5,  type="Green",	name="Consumable", description=""},
	GEMS =		{mod=0,  type="Green",	name="Gems", description=""},
	RECIPE =	{mod=0,  type="Green",	name="Recipe", description=""},
	XMOG =		{mod=5,  type="Green",	name="Transmogrification", description="Is used in popular xmog looks."},
	OLD =		{mod=-2, type="Red",	name="Olded expansion", description=""}, -- don't use together with xmog, use old_eq or old_weapon instead
	CURRENT =	{mod=2,  type="Green",	name="Current expansion", description=""},
	OLD_EQUIP =	{mod=0,  type="Green",	name="Older expansion", description=""},
	OLD_WEAPON =	{mod=0,	 type="Green",	name="Older expansion", description=""},
	TWINK =		{mod=0,	 type="Green",	name="Twinks", description=""},
	PVP =		{mod=0,	 type="Green",	name="Pvp", description=""},
	--NAME = {mod=0,  type="Green", name="", description=""},
} 

Auctions.BaseValues = {
	[ZGV.L["type_armor"]] = {
		[ZGV.L["subtype_armor_miscellaneous"]] = {"ARMOR"},
		[ZGV.L["subtype_armor_cloth"]] = {"ARMOR"},
		[ZGV.L["subtype_armor_leather"]] = {"ARMOR"},
		[ZGV.L["subtype_armor_mail"]] = {"ARMOR"},
		[ZGV.L["subtype_armor_plate"]] = {"ARMOR"},
		[ZGV.L["subtype_armor_shields"]] = {"ARMOR"},
		[ZGV.L["subtype_armor_librams"]] = {"ARMOR"},
		[ZGV.L["subtype_armor_idols"]] = {"ARMOR"},
		[ZGV.L["subtype_armor_totems"]] = {"ARMOR"},
		[ZGV.L["subtype_armor_sigils"]] = {"ARMOR"},
	},

	[ZGV.L["type_consumable"]] = {
		[ZGV.L["subtype_consumable_food_drink"]] = {"CONSUMABLE"},
		[ZGV.L["subtype_consumable_potion"]] = {"CONSUMABLE"},
		[ZGV.L["subtype_consumable_elixir"]] = {"CONSUMABLE"},
		[ZGV.L["subtype_consumable_flask"]] = {"CONSUMABLE"},
		[ZGV.L["subtype_consumable_bandage"]] = {"CONSUMABLE"},
		[ZGV.L["subtype_consumable_item_enhancement"]] = {"CONSUMABLE"},
		[ZGV.L["subtype_consumable_scroll"]] = {},
		[ZGV.L["subtype_consumable_other"]] = {},
		[ZGV.L["subtype_consumable_consumable"]] = {"CONSUMABLE"},
	},

	[ZGV.L["type_container"]] = {
		[ZGV.L["subtype_container_bag"]] = {},
		[ZGV.L["subtype_container_enchanting"]] = {},
		[ZGV.L["subtype_container_engineering"]] = {},
		[ZGV.L["subtype_container_gem"]] = {},
		[ZGV.L["subtype_container_herb"]] = {},
		[ZGV.L["subtype_container_mining"]] = {},
		[ZGV.L["subtype_container_soul"]] = {},
		[ZGV.L["subtype_container_leatherworking"]] = {},
	},

	[ZGV.L["type_gem"]] = {
		[ZGV.L["subtype_gem_blue"]] = {"GEMS"},
		[ZGV.L["subtype_gem_green"]] = {"GEMS"},
		[ZGV.L["subtype_gem_orange"]] = {"GEMS"},
		[ZGV.L["subtype_gem_meta"]] = {"GEMS"},
		[ZGV.L["subtype_gem_prismatic"]] = {"GEMS"},
		[ZGV.L["subtype_gem_purple"]] = {"GEMS"},
		[ZGV.L["subtype_gem_red"]] = {"GEMS"},
		[ZGV.L["subtype_gem_simple"]] = {"GEMS"},
		[ZGV.L["subtype_gem_yellow"]] = {"GEMS"},
	},

	[ZGV.L["type_key"]] = {
		[ZGV.L["subtype_key_key"]] = {},
	},

	[ZGV.L["type_miscellaneous"]] = {
		[ZGV.L["subtype_miscellaneous_junk"]] = {},
		[ZGV.L["subtype_miscellaneous_reagent"]] = {},
		[ZGV.L["subtype_miscellaneous_pet"]] = {},
		[ZGV.L["subtype_miscellaneous_holiday"]] = {},
		[ZGV.L["subtype_miscellaneous_mount"]] = {},
		[ZGV.L["subtype_miscellaneous_pther"]] = {},
	},

	[ZGV.L["type_reagent"]] = {
		[ZGV.L["subtype_reagent_reagent"]] = {},
	},

	[ZGV.L["type_recipe"]] = {
		[ZGV.L["subtype_recipe_alchemy"]] = {"RECIPE"},
		[ZGV.L["subtype_recipe_blacksmithing"]] = {"RECIPE"},
		[ZGV.L["subtype_recipe_book"]] = {"RECIPE"},
		[ZGV.L["subtype_recipe_cooking"]] = {"RECIPE"},
		[ZGV.L["subtype_recipe_enchanting"]] = {"RECIPE"},
		[ZGV.L["subtype_recipe_engineering"]] = {"RECIPE"},
		[ZGV.L["subtype_recipe_first_aid"]] = {"RECIPE"},
		[ZGV.L["subtype_recipe_leatherworking"]] = {"RECIPE"},
		[ZGV.L["subtype_recipe_tailoring"]] = {"RECIPE"},
	},

	[ZGV.L["type_trade_goods"]] = {
		[ZGV.L["subtype_trade_goods_cloth"]] = {"TRADEGOODS_1"},
		[ZGV.L["subtype_trade_goods_cooking"]] = {"TRADEGOODS_1"},
		[ZGV.L["subtype_trade_goods_devices"]] = {},
		[ZGV.L["subtype_trade_goods_elemental"]] = {"TRADEGOODS_1"},
		[ZGV.L["subtype_trade_goods_enchanting"]] = {"TRADEGOODS_1"},
		[ZGV.L["subtype_trade_goods_explosives"]] = {},
		[ZGV.L["subtype_trade_goods_herb"]] = {"TRADEGOODS_1"},
		[ZGV.L["subtype_trade_goods_item_enchantment"]] = {"TRADEGOODS_2"},
		[ZGV.L["subtype_trade_goods_jewelcrafting"]] = {"TRADEGOODS_1"},
		[ZGV.L["subtype_trade_goods_leather"]] = {"TRADEGOODS_1"},
		[ZGV.L["subtype_trade_goods_materials"]] = {"TRADEGOODS_1"},
		[ZGV.L["subtype_trade_goods_meat"]] = {"TRADEGOODS_2"},
		[ZGV.L["subtype_trade_goods_metal_stone"]] = {"TRADEGOODS_1"},
		[ZGV.L["subtype_trade_goods_other"]] = {"TRADEGOODS_2"},
		[ZGV.L["subtype_trade_goods_parts"]] = {"TRADEGOODS_2"},
		[ZGV.L["subtype_trade_goods_trade_goods"]] = {"TRADEGOODS_2"},
	},

	[ZGV.L["type_weapon"]] = {
		[ZGV.L["subtype_weapon_bows"]] = {"WEAPON"},
		[ZGV.L["subtype_weapon_crossbows"]] = {"WEAPON"},
		[ZGV.L["subtype_weapon_daggers"]] = {"WEAPON"},
		[ZGV.L["subtype_weapon_guns"]] = {"WEAPON"},
		[ZGV.L["subtype_weapon_fishing_poles"]] = {"WEAPON"},
		[ZGV.L["subtype_weapon_fist_weapons"]] = {"WEAPON"},
		[ZGV.L["subtype_weapon_miscellaneous"]] = {"WEAPON"},
		[ZGV.L["subtype_weapon_one_handed_axes"]] = {"WEAPON"},
		[ZGV.L["subtype_weapon_one_handed_maces"]] = {"WEAPON"},
		[ZGV.L["subtype_weapon_one_handed_swords"]] = {"WEAPON"},
		[ZGV.L["subtype_weapon_polearms"]] = {"WEAPON"},
		[ZGV.L["subtype_weapon_staves"]] = {"WEAPON"},
		[ZGV.L["subtype_weapon_thrown"]] = {"WEAPON"},
		[ZGV.L["subtype_weapon_two_handed_axes"]] = {"WEAPON"},
		[ZGV.L["subtype_weapon_two_handed_maces"]] = {"WEAPON"},
		[ZGV.L["subtype_weapon_two_handed_swords"]] = {"WEAPON"},
		[ZGV.L["subtype_weapon_wands"]] = {"WEAPON"},
	},

	[ZGV.L["type_glyph"]] = {
		[ZGV.L["subtype_glyph_death_knight"]] = {},
		[ZGV.L["subtype_glyph_druid"]] = {},
		[ZGV.L["subtype_glyph_hunter"]] = {},
		[ZGV.L["subtype_glyph_mage"]] = {},
		[ZGV.L["subtype_glyph_monk"]] = {},
		[ZGV.L["subtype_glyph_paladin"]] = {},
		[ZGV.L["subtype_glyph_priest"]] = {},
		[ZGV.L["subtype_glyph_rogue"]] = {},
		[ZGV.L["subtype_glyph_shaman"]] = {},
		[ZGV.L["subtype_glyph_warlock"]] = {},
		[ZGV.L["subtype_glyph_warrior"]] = {},
	},
}

Auctions.ItemStatus = {
--	[114234] = { OVERRIDE=10, "XMOG" },
--	[114230] = { "TRADEGOODS_1", "XMOG", "OLD" },
}