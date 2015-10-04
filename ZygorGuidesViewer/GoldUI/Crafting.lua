local ZGV = ZygorGuidesViewer
if not ZGV then return end

local ZGVG=ZGV.Gold

if not ZGV.Gold.Crafting then ZGV.Gold.Crafting = {} end
local Crafting = ZGV.Gold.Crafting


Crafting.CraftToRecipe = {}
Crafting.AllCraftToRecipe = {}
Crafting.ItemSources = {}

function Crafting:GetCraftToRecipe()
	local ignoreSpells = { 143255, 114780 }
	for i,v in pairs(ZGV.db.char.RecipesKnown) do
		for k,r in pairs(v) do
			local ignore = false
			for _,ignoredSpell in pairs(ignoreSpells) do
				ignore = ignore or (r.spell == ignoredSpell)
			end
			if not ignore and not self.CraftToRecipe[r.productid] then self.CraftToRecipe[r.productid] = r end
		end
	end
end

function Crafting:GetAllCraftToRecipe()
	for proff,crafts in pairs(ZGV.Gold.Crafting.AllRecipes) do
		for id,craft in pairs(crafts) do
			self.AllCraftToRecipe[craft.productid] = true
		end
	end
end


Crafting.EnchantToScroll = {}

Crafting.AllRecipes = {
	[164] = {},
	[165] = {},
	[393] = {},
	[202] = {},
	[171] = {},
	[333] = {},
	[755] = {},
	[773] = {},
	[182] = {},
	[185] = {},
	[186] = {},
	[197] = {},
}
