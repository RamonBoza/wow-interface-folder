local ZGV = ZygorGuidesViewer
if not ZGV then return end

-- Tooltip helper methods. Right now, just for finding Soulbound items.

-- make sure it has a name
local f = CreateFrame('GameTooltip', 'MyTooltip', UIParent, 'GameTooltipTemplate')

local function tooltipContains(string)
	-- initialize outside loop to prevent creating lots of copies that take lots of memory.
	local text;
	for i = 1, f:NumLines() do
		if _G["MyTooltipTextLeft"..i] then
			local left = _G["MyTooltipTextLeft"..i]:GetText()
			if left and string.find(left, string)~=nil then
				return true
			end
		end
		
		if _G["MyTooltipTextRight"..i] then
			local right = _G["MyTooltipTextRight"..i]:GetText()
			if right and string.find(right, string)~=nil then
				return true
			end
		end
	end
	return false
end

-- Or if the item can't be mailed or sold to a vendor.
function ZGV:isSoulbound(bag, slot)
	f:SetOwner(UIParent, 'ANCHOR_NONE')
	assert(bag ~= nil)
	assert(slot ~= nil)
	--Spoo(nil, nil, f)
	f:ClearLines()
	f:SetBagItem(bag, slot)
	--Spoo(nil, nil, MyTooltipTextLeft3:GetText())
	if tooltipContains(ITEM_SOULBOUND) or tooltipContains(ITEM_BIND_QUEST)  or tooltipContains(ITEM_CONJURED)
		or tooltipContains(ITEM_ACCOUNTBOUND) or tooltipContains(ITEM_BNETACCOUNTBOUND)
	 	-- Celebration Package has *no* indication that it is soulbound, even though it is.
		or tooltipContains("Requires WoW's")
	then
		--print("true")
		return true
	end
	--print("false")
	return false
end

function ZGV:isUnique(bag, slot)
	f:SetOwner(UIParent, 'ANCHOR_NONE')
	assert(bag ~= nil)
	assert(slot ~= nil)
	f:ClearLines()
	f:SetBagItem(bag, slot)
	if tooltipContains("Unique") then
		return true
	end
	return false
end
