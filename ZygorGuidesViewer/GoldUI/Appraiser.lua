-- Let's remove the Controller from the View . . . MVC, anybody? ~~Jeremiah


local ZGV = ZygorGuidesViewer
if not ZGV then return end

local ZGVG=ZGV.Gold


local L = ZGV.L
local CHAIN = ZGV.ChainCall

--local Appraiser = {}
--ZGV.Gold.Appraiser = Appraiser

if not ZGV.Gold.Appraiser then ZGV.Gold.Appraiser = {} end
local Appraiser = ZGV.Gold.Appraiser

Appraiser.manualScanning = false
Appraiser.manualItemsToScan = {}

local currentAppraiserView  -- current view
local buyView
local inventoryView
local postView

local ui = ZGV.UI
local SkinData = ui.SkinData

local cachedGetItemInfo = ZGV.cachedGetItemInfo

local vendorMarkup = Appraiser.vendorMarkup 

-- We want to do a scan, but can't do it yet.
Appraiser.delayedScanStart = false

local itemLocked

function Appraiser:ShowAppraiserTab(appraiserView)
	if appraiserView==nil then error("appraiserView cannot be nil") end
	if self==nil then error("self cannot be nil (forgot to use : syntax?)") end
	Frame:ClearItems()
	--Appraiser:LoadItemsIntoAppraiser()	
	self:RefreshAppraiserUI(appraiserView)
end

function Appraiser:ShowPostTab(appraiserView)
	if appraiserView==nil then error("appraiserView cannot be nil") end
	if self==nil then error("self cannot be nil (forgot to use : syntax?)") end
	Frame:ClearItems()
	self:RefreshPostUI(appraiserView)
end

-- Sets status to something special
function Appraiser:SetStatus(text, isBold)
	if text==nil then error("text must not be nil") end
	if self.frame then
		if isBold then
			Appraiser.updateTitle:SetFont(FONTBOLD,12)
		else
			Appraiser.updateTitle:SetFont(FONT,12)
		end
		Appraiser.updateTitle:SetText(text)
		Appraiser.timestamp:Hide()
	end
end

function Appraiser:AuctionWorthy(ContainerItemID)

	if not ContainerItemID then return false end -- It must exist . . .
	
	local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = cachedGetItemInfo(ContainerItemID)
	
	-- Well, so much for vendor price being an indicator, Dream Dust and 
	-- other enchanting materials have a 0 vendor price! ~~Jeremiah
	--if vendorPrice == 0 then -- Vendor price being 0 is a sure sign this can't be auctioned. Don't even try.
	--	return false
	--end
	
	if quality == 0 then -- Also don't try to auction vendor trash.
		return false
	end

	-- Include trade goods
	if class==L["type_trade_goods"] then 
		return true
	end
	
	-- Exclude Gear
	--if class==L["type_weapon"] or class==L["type_armor"] then
	--	return false
	--end
	
	--print("name: "..name.." | class: "..class.." subclass: "..subclass)
	
	-- Include by default
	return true
end

-- If automatic scanner isn't available. Scans items in bags.
function Appraiser:ManualScan(itemslist)
	if Appraiser.manualScanning then return end

	if itemslist=="BAGS" then  -- not used atm?
		ZGV:Debug("Running a slow scan of all items.")
		local alreadyadded={}
		for bag=0, NUM_BAG_SLOTS do
			for slot=1, GetContainerNumSlots(bag) do
				local itemid=GetContainerItemID(bag,slot)
				if itemid and Appraiser:AuctionWorthy(itemid) and not alreadyadded[itemid] then
					Appraiser:getCurrentView():UpdateIconText(itemid, "?")
					local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = cachedGetItemInfo(itemid)
					tinsert(Appraiser.manualItemsToScan, {name, itemid})
					alreadyadded[itemid]=1
				end
			end
		end
	elseif type(itemslist)=="table" and itemslist[1].frame then -- bloody hell, it's the ugly items-frames-list!
		ZGV:Debug("Running a manual scan of items in frame.")
		for i,itemrow in ipairs(itemslist) do
			local name = cachedGetItemInfo(itemrow.itemid)
			tinsert(Appraiser.manualItemsToScan, {name, itemrow.itemid})
		end
	else
		ZGV:Debug("Slow scan has nothing to do..? itemslist="..tostring(itemslist).." (stored in ZGV_ITEMSLIST)")
		ZGV_ITEMSLIST=itemslist
	end
	if next(Appraiser.manualItemsToScan) then Appraiser.manualScanning = true end
end

-- If automatic scanner isn't available. Scans items in bags.
function Appraiser:ManualScanPostedItems()
	if Appraiser.manualScanning then return end
	
	local postItemListByID = {}
	for key, val in pairs(self.postItemList) do
		postItemListByID[val.itemid] = val
	end
	--Spoo(nil, nil, postItemListByID)
	
	local alreadyadded={}
	
	for bag=0, NUM_BAG_SLOTS do
		for slot=1, GetContainerNumSlots(bag) do
			local itemid=GetContainerItemID(bag,slot)
			if itemid and postItemListByID[itemid] and not alreadyadded[itemid] then
				Appraiser:getCurrentView():UpdateIconText(itemid, "?")
				local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = cachedGetItemInfo(itemid)
				tinsert(Appraiser.manualItemsToScan, {name, itemid})
				alreadyadded[itemid]=1
			end
		end
	end
	if next(Appraiser.manualItemsToScan) then Appraiser.manualScanning = true end
end

function Appraiser:Scan(appraiserView,forceSlow,itemslist)
	-- Perform auction scan if available.

	if ZGVG.Scan:CanScanFast() and not forceSlow then
		if Appraiser.activeTab == "Appraiser" then
			progressFrame:Show()
		end
		ZGVG.Scan:ScanFast()
		appraiserView:ResetTimeStamp()
		progressFrame:SetPercent(20)
	elseif ZGVG.Scan:CanScanByName() and forceSlow then
		--Appraiser:ManualScan() -- Disabled on Andrew's request ~~ Jeremiah     -- well, re-enabled in WOD. ~~sinus
		Appraiser:ManualScan(itemslist)
	end
	appraiserView:RefreshUI()
end

-- Not proper, but easy . . .
function Appraiser:RescanBuyItem(itemid)
	--if number then print("NUMBER: "..number) else print("NUMBER: nil") end
	if not number then
		number = 1
	end
	
	--Spoo(nil, nil, Appraiser.buyItemList) 

	for index, item in pairs(Appraiser.buyItemList) do
		if Appraiser.buyItemList[number] and Appraiser.buyItemList[number].itemid and Appraiser.buyItemList[number].itemid==itemid then
			local itemName, _, itemRarity, itemLevel, minItemLevel, itemType, itemSubType = cachedGetItemInfo(itemid)
			QueryAuctionItems(itemName)
			ZGV:DelayedRun("AUCTION_ITEM_LIST_UPDATE", function()
				SetSelectedAuctionItem("list", index)
				ZGV.Gold.Appraiser:SetBuyItemInfoFromSearchItem(index)
				--ZGV:DelayedRun("AUCTION_ITEM_LIST_UPDATE", function()
					--ZGV.Gold.Appraiser:HighlightItem(0)
				--end)
				ZGV:SendMessage("BUY_ITEM_RESCANNED")
			end)
			return -- QueryAuctionItems can only be run once per click, no sense continuing the iterations.
		end
	end
	
	if number == 0 then
		--ZGV.Gold.Appraiser:HighlightItem(0)
	end
end

function Appraiser:RescanAllBuyItems(startNumber)
	error("not functional right now.")
	ZGV:DelayedRun(CanSendAuctionQuery, function()
		ZGV.Gold.Appraiser:RescanBuyItem(startNumber)
		ZGV:DelayedRun("AUCTION_ITEM_LIST_UPDATE", function()
			if startNumber-1 >= 0 then
				Appraiser:RescanAllBuyItems(startNumber-1)
			end
		end)
	end)
end

function Appraiser:UpdatePostText(appraiserView)
	if Appraiser.activeTab == "Post" then
		--self.mainBut:SetText("Post ("..Appraiser:GetNumberOfSellClicks()..")")
	end

	if appraiserView.postTabText then
		if Appraiser:GetNumberOfSellClicks() > 0 then
			local _, numItems = Appraiser:GetNumberOfSellClicks()
			appraiserView.postTabText:SetText("Post ("..numItems..")")
		else
			appraiserView.postTabText:SetText("Post")
		end
	end
end

-- Get number of clicks needed to sell and item (everything if itemid is blank).
-- Also returns total number of items and whether or not it was flood limited.
function Appraiser:GetNumberOfSellClicks(itemid)
	local numClicks = 0
	local numItems = 0
	for _, item in pairs(Appraiser.postItemList) do
	
		if (itemid~=nil and itemid== item.itemid) or itemid==nil then
			local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = cachedGetItemInfo(item.itemid)
			-- Check to see if one or two clicks is needed to sell
	
			stackSize, numStacks, totalItems, floodLimitedTotal, floodLimited =  self:getStackInfo(item.itemid)
			
			-- one click
			if stackSize > 0 and numStacks > 0 then
				numClicks = numClicks + 1
				numItems = numItems + 1
			end
	
			-- two clicks
			if stackSize > 0 and numStacks > 0 and totalItems > stackSize*numStacks then
				numClicks = numClicks + 1
			end
		end
	end
	return numClicks, numItems, floodLimited
end

function Appraiser:MyAddItem(appraiserView, item)
	-- Automatically called after :AddItem. new Item added is passed.
	local stackSize, numStacks = self:getStackInfo(item.itemid)
	if Appraiser:GetSellPrice(itemid, numStacks, stackSize) > 0 then
		self:UpdateSecText(item.itemid, ZGV.GetMoneyString(Appraiser:GetSellPrice(itemid, numStacks, stackSize), 0, "nocolor"))
		--ZGV.tempAltFrames.InventoryFrame:UpdateSecText(item.itemid, ZGV.GetMoneyString(ZGVG.Scan:GetPrice(item.itemid)*numStacks*stackSize, 0, "nocolor"))
	else
		--self:UpdateSecText(item.itemid, "No data")
		itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,itemEquipLoc, itemTexture, itemSellPrice = cachedGetItemInfo(item.itemid)
		self:UpdateSecText(item.itemid,ZGV.GetMoneyString(itemSellPrice*vendorMarkup, 0, "nocolor"))
		--ZGV.tempAltFrames.InventoryFrame:UpdateSecText(item.itemid,ZGV.GetMoneyString(itemSellPrice*vendorMarkup, 0, "nocolor"))
	end
end

function Appraiser:moveItemToList(list, itemid, item)
	error("Deprecated function. Please use addItemToList and removeItemFromList.")

	if list == "appraiser" then
		Appraiser.appraiserItemList[itemid] = item
		Appraiser.postItemList[itemid] = nil
		item.toggle:SetToggle(false, true)
		--Appraiser:RefreshUI()
		Appraiser:SetStatus("Removed "..item.descText:GetText().." from Post")
	elseif list == "post" then
		Appraiser.postItemList[itemid] = item
		--Appraiser.appraiserItemList[itemid] = nil
		item.toggle:SetToggle(true, true)
		--Appraiser:RefreshUI()
		--Spoo(nil, nil, item)
		Appraiser:SetStatus("Added "..item.descText:GetText().." to Post")
	else
		error("List must be appraiser or post")
	end
	
	if Appraiser.activeTab == "Appraiser" then
		Appraiser:UpdatePostText(Appraiser:getCurrentView())
	elseif Appraiser.activeTab == "Post" then
		Appraiser:UpdatePostText(Appraiser:getCurrentView())
	else
		error("Unknown active tab")
	end
	
end

function Appraiser:removeItemFromList(list, itemid)
	assert(type(itemid)=="number")
	if list == "appraiser" then
		-- Appraiser list is now local to the RefreshUI function, rather
		-- than being a global. ~~ Jeremiah		
	
		--for index, item in pairs(Appraiser.appraiserItemList) do
		--	if item.itemid == itemid then
		--		tremove(Appraiser.appraiserItemList, index)
		--	end
		--end
	elseif list == "post" then
		ZGV.tempAltFrames.PostFrame:RemoveItem(itemid)
		for index, item in pairs(Appraiser.postItemList) do
			if item.itemid == itemid then
				tremove(Appraiser.postItemList, index)
			end
		end
	else
		error("List must be appraiser or post")
	end
end

-- returns position of item
function Appraiser:addItemToList(list, item)
	if list == "appraiser" then
		if not tContains(Appraiser.appraiserItemList, item) then
			tinsert(Appraiser.appraiserItemList, item)
		end
	elseif list == "post" then
		ZGV.tempAltFrames.PostFrame:AddItem(item.itemid, 1, false)
		if not tContains(Appraiser.postItemList, item) then
			tinsert(Appraiser.postItemList, item)
		end
		Appraiser:UpdatePostText(Appraiser:getCurrentView())
	elseif list == "buy" then
		if not tContains(Appraiser.buyItemList, item) then
			tinsert(Appraiser.buyItemList, item)
		end
		--Appraiser:UpdatePostText()
	else
		error("List must be appraiser or post")
	end
end

function Appraiser:removeItemFromList2(list, item)
	if list == "appraiser" then
		for index, tempItem in pairs(Appraiser.appraiserItemList) do
			if item == tempItem then
				tremove(Appraiser.appraiserItemList, index)
			end
		end
	elseif list == "post" then
		ZGV.tempAltFrames.PostFrame:RemoveItem(item.itemid)
		for index, tempItem in pairs(Appraiser.postItemList) do
			if item == tempItem then
				tremove(Appraiser.postItemList, index)
			end
		end
		Appraiser:UpdatePostText(Appraiser:getCurrentView())
	else
		error("List must be appraiser or post")
	end
end

-- Track items that are bought.
Appraiser.buyItemList = {}
Appraiser.buyItemListByID = {}

-- TODO: Only temporary?
-- Works on the latest QueryAuctionItems.
-- NOTE: WoW's API puts the currently scanned page of auctions into the first indexes,
-- it does NOT start indexing using any sort of offset. My mistake . . . ~~Jeremiah

function Appraiser:ScanByName(name, page, returnTable)
	-- Starts the scanning. Calls GetAuctionsInfoPage when results arrive.
	-- Catch APPRAISER_SCANBYNAME_DONE for results!
	page=page or 0
	returnTable = returnTable or {}
	if page==0 then table.wipe(returnTable) end
	QueryAuctionItems(name, nil, nil, nil, nil, nil, page)
	ZGV:DelayedRun("AUCTION_ITEM_LIST_UPDATE", function()
		return Appraiser:GetAuctionsInfoPage(name, page, returnTable)
	end)
end

function Appraiser:GetAuctionsInfoPage(name, page, returnTable)
	-- Receives results. Calls SlowScan again when query cools down.
	batch, count = GetNumAuctionItems("list")
	--print("batch: "..batch.." count: "..count)
	returnTable[page]={}
	for index=1, batch do
		local itemname, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo = GetAuctionItemInfo("list",index)
		if itemname==name then
			returnTable[page][index] = {GetAuctionItemInfo("list",index)}
		end
	end

	--Spoo(nil, nil, returnTable)
	if (page+1)*batch >= count or batch == 0 then
		ZGV:Debug("&gold GetAuctionsInfo: End querying.")
		ZGV:SendMessage("APPRAISER_SCANBYNAME_DONE", (returnTable or {}))
	else
		ZGV:Debug("&gold GetAuctionsInfo: Querying page ".. page .."/"..ceil(count/50))
		ZGV:DelayedRun(CanSendAuctionQuery, function() Appraiser:ScanByName(name,page+1,returnTable) end)
	end
	return returnTable
end



local dealIcon = {}
function Appraiser:CreateDealIcons()
	local NUMICONS = 8
	for x=1, NUM_BROWSE_TO_DISPLAY do
		if not dealIcon[x] then
		selectedBrowseButton = _G["BrowseButton"..x]
			dealIcon[x] = CHAIN(CreateFrame("Button","dealIconButton",selectedBrowseButton))--,ZGV.DIR.."\\Skins\\goldguideicons",1,NUMICONS,1,2,nil))
				--:SetAllPoints(backFrame)
				:SetFrameStrata("HIGH")
				:SetPoint("TOPLEFT", selectedBrowseButton, "TOPLEFT", 3, -15)
				--:SetPoint("TOPLEFT", AuctionFrame, "TOPLEFT", 300, -85)
				--:SetPoint("BOTTOMRIGHT", selectedBrowseButton, "BOTTOMRIGHT", 3, 3)
				:SetSize(16,16)
				:Show()
			.__END
			
			dealIcon[x].texture = CHAIN(dealIcon[x]:CreateTexture("dealIconTexture","ARTWORK"))
				:SetSize(16,16)
				:SetTexture(ZGV.DIR.."\\Skins\\goldguideicons")
				:SetPoint("TOPLEFT", dealIcon[x], "TOPLEFT")
				--:SetPoint("BOTTOMRIGHT", dealIcon, "BOTTOMRIGHT")
			.__END
			BetterTexCoord(dealIcon[x].texture,1,NUMICONS,1,2)
		end
	end
end

local lastIDHighlighted = 0
local oldBrowse

function Appraiser:HighlightDeals(itemid)
	if not itemid then
		error("itemid required")
	end
	
	if type(itemid)=="table" then error("itemid cannot be a table") end
	
	--if not AuctionItemInfo then
	--	error("AuctionItemInfo required")
	--end
	
	
	
	if itemid and itemid ~= lastIDHighlighted then
		lastIDHighlighted = itemid
	else
		itemid = lastIDHighlighted
	end
	
	local AH = ZGV.db.realm.gold_scan_data
	AH=AH and AH[1] and AH[1][itemid]
	if not AH then 
		AH = ZGV.db.realm.gold_scan_data
	end
	local info
	local arr={}
	local offset = FauxScrollFrame_GetOffset(BrowseScrollFrame)
	--Spoo(nil, nil, BrowseScrollFrame)
	--Spoo(nil, nil, AH)
	
	if not oldBrowse then
		oldBrowse = AuctionFrameBrowse_Update
		AuctionFrameBrowse_Update = function(...)
			ZGV:DelayedRun("OnUpdate", function(self, itemid) if itemid then Appraiser:HighlightDeals(itemid) end end, itemid)
			return oldBrowse(...)
		end
	end
	
	if not dealIcon[1] then
		Appraiser:CreateDealIcons()
	end
	
	for x=1, NUM_BROWSE_TO_DISPLAY do
	--Spoo(nil, nil, _G["BrowseButton"..x])
		--print(GetAuctionItemInfo("list",x))
		local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo =  GetAuctionItemInfo("list",x+offset);
		
		if name == nil then
			--error("No auction information.")
			dealIcon[x]:Hide()
		end
		
		if ZGV.Gold.servertrends.items[itemid] then
			--browseButton = _G["BrowseButton"..x]
			--buttonItemName = _G["BrowseButton"..x]:GetRegions():GetText()
			--itemName = GetItemInfo(itemid)
			--Spoo(nil, nil, ZGV.Gold.servertrends.items[itemid])
			--print(itemName)
			ZGV.Gold.FAuctionDetail.chore.GetAuctionChoreData(nil, ZGV.Gold.servertrends.items[itemid], AH, ZGV.Gold.FAuctionDetail.chore, nil, arr)
			local highest = 0
			for _, data in pairs(arr) do
				if data.price > highest then
					highest = data.price
				end
			end
			--print(buttonItemName.." == "..itemName)
			--print(x.." "..buyoutPrice/count.." "..highest)
			if buyoutPrice/count < highest then
				dealIcon[x]:Show()
			else
				dealIcon[x]:Hide()
			end
		--elseif not ZGV.Gold.servertrends.items[itemid] then
		--	print(itemid.." not found")
		--	Spoo(nil, nil, ZGV.Gold.servertrends.items[itemid])
		else
			--if type(itemid)=="table" then Spoo(nil, nil, itemid) end
			--print("Nil ZGV.Gold.servertrends.items["..itemid.."]")
		--	Spoo(nil, nil, _G["BrowseButton"..x])
		end
	end
	--print("----")

	if forceError then error(NUM_BROWSE_TO_DISPLAY) end
end

-- Refreshes the items in the Browse tab and highlights good deals.
function Appraiser:RefreshAndHighlightItems(itemid)
	--Appraiser:RefreshBuyUI(appraiserView)
	ZGV.Gold.Appraiser:RescanBuyItem(itemid)--#ZGV.Gold.Appraiser.buyItemList
	--ZGV:DelayedRun(function()
	--	print("T")
	--	ZGV.Gold.Appraiser:RescanBuyItem(itemid)--#ZGV.Gold.Appraiser.buyItemList
		ZGV:DelayedRun("MSG BUY_ITEM_RESCANNED", function()
			ZGV.Gold.Appraiser:HighlightItemsByPrice(ZGV.Gold.Appraiser.buyItemListByID[itemid].price, itemid)
			--Spoo(nil, nil, _G["BrowseButton"..x])
		end)
	--end, "AUCTION_ITEM_LIST_UPDATE")
end

-- Highlights the items on the current page by price.
function Appraiser:HighlightItemsByPrice(price)
	for x=1, NUM_BROWSE_TO_DISPLAY do
		if _G["BrowseButton"..x].buyoutPrice ~= nil then
			if _G["BrowseButton"..x].buyoutPrice == price then
				Appraiser:HighlightItem(x, true)
			end
		end
	end
end

-- Highlights an item in green.
function Appraiser:HighlightItem(index, showHighlight)
	--if index and not lastHighlightIndex then
		lastHighlightIndex = index
	--elseif not index and not lastHighlightIndex then
	--	lastHighlightIndex = 0
	--end
	
	oldBrowse = AuctionFrameBrowse_Update
	
	-- NUM_BROWSE_TO_DISPLAY
	local offset = FauxScrollFrame_GetOffset(BrowseScrollFrame)
	--print(offset)
	if not BrowseScrollFrame:IsVisible() then offset=0 end
	if not backFrame then
		backFrame = CreateFrame("Frame", nil, AuctionFrame)                    
		backFrame:SetFrameStrata("HIGH")
		--backFrame:SetPoint("TOPLEFT", BrowseButton1, "TOPLEFT")
		--backFrame:SetPoint("BOTTOMRIGHT", BrowseButton1, "BOTTOMRIGHT")
		backFrameTexture = backFrame:CreateTexture()
		backFrameTexture:SetAllPoints(backFrame)
		backFrameTexture:SetTexture(0, 1, 0, 0.25)
		backFrame:SetBackdropBorderColor(0,1,0,1)
		backFrame:SetBackdrop(SkinData("StepBorderBackdrop"))
	end
	if (lastHighlightIndex > offset and lastHighlightIndex <= offset+NUM_BROWSE_TO_DISPLAY) then
		backFrameTexture:Show()
		selectedBrowseButton = _G["BrowseButton"..(lastHighlightIndex-offset)]
		backFrame:ClearAllPoints()
		--backFrame:SetAllPoints(selectedBrowseButton)
		backFrame:SetPoint("TOPLEFT", selectedBrowseButton, "TOPLEFT", -3, 3)
		backFrame:SetPoint("BOTTOMRIGHT", selectedBrowseButton, "BOTTOMRIGHT", 3, 3)
		backFrame:Hide()
		--backFrame:Show()
	else
		backFrame:Hide()
	end
	local NUMICONS=8
	if not dealIcon[index-offset] then
		dealIcon[index-offset] = CHAIN(CreateFrame("Button","dealIconButton",selectedBrowseButton))--,ZGV.DIR.."\\Skins\\goldguideicons",1,NUMICONS,1,2,nil))
			--:SetAllPoints(backFrame)
			:SetFrameStrata("HIGH")
			:SetPoint("TOPLEFT", selectedBrowseButton, "TOPLEFT", 3, -15)
			--:SetPoint("TOPLEFT", AuctionFrame, "TOPLEFT", 300, -85)
			--:SetPoint("BOTTOMRIGHT", selectedBrowseButton, "BOTTOMRIGHT", 3, 3)
			:SetSize(16,16)
			:Show()
		.__END
		
		dealIcon[index-offset].texture = CHAIN(dealIcon[index-offset]:CreateTexture("dealIconTexture","ARTWORK"))
			:SetSize(16,16)
			:SetTexture(ZGV.DIR.."\\Skins\\goldguideicons")
			:SetPoint("TOPLEFT", dealIcon[index-offset], "TOPLEFT")
			--:SetPoint("BOTTOMRIGHT", dealIcon, "BOTTOMRIGHT")
		.__END
		BetterTexCoord(dealIcon[index-offset].texture,1,NUMICONS,1,2)
	end
	
	if showHighlight and (lastHighlightIndex > offset and lastHighlightIndex <= offset+NUM_BROWSE_TO_DISPLAY) then
		dealIcon[index-offset]:Show()
	else
		dealIcon[index-offset]:Hide()
	end

	--if (lastHighlightIndex > offset and lastHighlightIndex <= offset+NUM_BROWSE_TO_DISPLAY) then
	--	dealIcon[index-offset]:Show()
	--else
	--	dealIcon[index-offset]:Hide()
	--end
	
	
	-- use 0th index to always hide it.
	if index == 0 and backFrame then
		backFrame:Hide()
	end
end

function Appraiser:RemoveAllHighlights()
	for index, item in pairs(dealIcon) do
		item:Hide()
	end
end

-- Takes any information from QueryAuctionItems and sets the matching item in the Buy tab to match the item. 
function Appraiser:SetBuyItemInfoFromSearchItem(auctionIndex)
	name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemid, hasAllInfo =  GetAuctionItemInfo("list",auctionIndex)
	--self:SetItemCount(""..itemid, 1, 1)
	currentAppraiserView:SetItemCount(""..itemid, count, count)
	currentAppraiserView:UpdateIconText(itemid, 1)
	--self:UpdateIconText(itemid, GetNumAuctionItems("list"))

	-- Very hackish.
	local item = currentAppraiserView.itemIdList[itemid]
	--Spoo(nil, nil, item)
	if item then -- TODO: Why is item nil in the first place sometimes?
		if not Appraiser.BuyPriceList[itemid] then
			Appraiser.BuyCountList[itemid] = count
			Appraiser.BuyPriceList[itemid] = ZGV.GetMoneyString(buyoutPrice or 9999, 0, "nocolor") 
			item.secText:SetText(ZGV.GetMoneyString(buyoutPrice or 9999, 0, "nocolor"))
			Appraiser:getCurrentView():SetItemCount(itemid, count, count)
		else
			item.secText:SetText(Appraiser.BuyPriceList[itemid])
		end
	end
	-- This should be the proper way, but doesn't work.
	--self:UpdateSecText(itemid, ZGV.GetMoneyString(buyoutPrice or 9999))
end

function Appraiser:RemoveBuyItem(itemid)
	local item = Appraiser.buyItemListByID[itemid]
	Appraiser:getCurrentView():RemoveItem(itemid)
	for index, currentItem in pairs(Appraiser.buyItemList) do
		if Appraiser.buyItemList[index].itemid == itemid then
			tremove(Appraiser.buyItemList, index)
		end
		Appraiser.buyItemListByID[itemid] = nil
	end
end

Appraiser.BuyPriceList = {} -- Not elegant, but wasn't given a lot of time to fix the problem.
Appraiser.BuyCountList = {}
function Appraiser:RefreshBuyUI(appraiserView)
	if not appraiserView then error("need to have appraiserView") end
	-- Remove existing items from UI
	for itemid, item in pairs(appraiserView.itemIdList) do
		appraiserView:RemoveItem(itemid)
	end

	-- Fill with new items
	for index, item in pairs(Appraiser.buyItemList) do
		itemid = item.itemid
		local AH=ZGV.db.realm.gold_scan_data -- Shamelessly stealing Sinus' secret sauce.
		--Spoo(nil, nil, AH)
		AH=AH and AH[1] and AH[1][itemid]
		--Spoo(nil, nil, ZGV.Gold.servertrends.items[itemid])
		
		local priceIndex = {}
		local countSum = 0
		for price, count in pairs(AH) do
			--print(count)
			if type(price) == "number" then
				countSum = count--countSum + count
				if not priceIndex[itemid] then priceIndex[itemid] = {} end
				if priceIndex[itemid][1] and priceIndex[itemid][1] > price then
					priceIndex[itemid][1] = price
					
					if priceIndex[itemid][2] then
						priceIndex[itemid][2] = priceIndex[itemid][2] + count
					else
						priceIndex[itemid][2] = count
					end
					table.insert(priceIndex, itemid, {price, count})
				else
					priceIndex[itemid][1] = price
					priceIndex[itemid][2] = count
					table.insert(priceIndex, itemid, {price, count})
				end
				if not Appraiser.buyItemListByID[itemid] then return end
				Appraiser.buyItemListByID[itemid].count=priceIndex[itemid][2]
				Appraiser.buyItemListByID[itemid].price=priceIndex[itemid][1]
			end
		end
		
		if Appraiser.BuyCountList[itemid] then
			myItem = appraiserView:AddItem(itemid, Appraiser.BuyCountList[itemid], false, "1")
		else
			myItem = appraiserView:AddItem(itemid, 1, false, "1")
			myItem.frame:Show()
		end
		--self:SetItemCount(itemid, nil, nil)
		
		if not Appraiser.BuyPriceList[itemid] then
			--print("!"..ZGV.GetMoneyString(priceIndex[itemid][1], 0, "nocolor"))
			appraiserView:UpdateSecText(itemid, ZGV.GetMoneyString(priceIndex[itemid][1], 0, "nocolor"))
		else
			--print("@"..Appraiser.BuyPriceList[itemid])
			appraiserView:UpdateSecText(itemid, Appraiser.BuyPriceList[itemid])
		end
		
		if Appraiser.totalAuctionItemsByID[itemid] then
			appraiserView:UpdateIconText(itemid, ""..Appraiser.totalAuctionItemsByID[itemid])
		end
		
		myItem.toggle:SetToggle(true) -- Default set to buy
		myItem.itemInfo = {GetItemInfo(itemid)}
		
		
		appraiserView:SetCallbackOnItem(itemid, function()
			Appraiser:RemoveBuyItem(itemid)
			Appraiser:RefreshBuyUI(appraiserView)
		end)
		
		appraiserView:SetClickCallbackOnItem(itemid, function()
			local itemName, _, itemRarity, itemLevel, minItemLevel, itemType, itemSubType = cachedGetItemInfo(itemid)
			Appraiser:RefreshAndHighlightItems(itemid)
			BrowseName:SetText(itemName)
		end)

		--self:UpdateIconText(itemid, ""..#AH.__orderedIndex)
		Appraiser.buyItemList[index]=myItem
		
	end
	
	if #Appraiser.buyItemList and #Appraiser.buyItemList > 0 then
		appraiserView.buyTabText:SetText("Buy ("..#Appraiser.buyItemList..")")
	else
		appraiserView.buyTabText:SetText("Buy")
	end
end

Appraiser.inPostRefresh = false
-- Refreshes the UI (post tab).
function Appraiser:RefreshPostUI(appraiserView)
	if not appraiserView then error("appraiserView required.") end

	--if Appraiser.inPostRefresh == true then
	--	error("RefreshPostUI cannot be recursively called.")
	--end
	--Appraiser.inPostRefresh = true

	-- Remove existing items from UI
	for itemid, item in pairs(appraiserView.itemIdList) do
		appraiserView:RemoveItem(itemid)
	end
	
	-- Fill with new items
	for _, item in pairs(Appraiser.postItemList) do
		appraiserView:AddItem(item)
		appraiserView:ItemButtonTooltip(item.itemid, "Remove from Post")
		appraiserView:UseAlternateItemCount(item.itemid, false)
	end

	-- Update "Post" button.
	Appraiser:UpdatePostText(appraiserView)
end

function Appraiser:Post()
	if not self.postItemList[1] then return end -- No items to post.
	Appraiser:SetStatus("Posting selected items . . .")
	
	local itemToPostID = self.postItemList[1].itemid
	
	if not self then return end
	for bag=0, NUM_BAG_SLOTS do
		for slot=1, GetContainerNumSlots(bag) do
			local itemid=GetContainerItemID(bag,slot)
			if itemid then
				local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = cachedGetItemInfo(itemid)
				--if self.itemIdList[itemid] and self.itemIdList[itemid].toggled and itemid==itemToPostID then
				if Appraiser:getCurrentView().itemIdList[itemid] and Appraiser:getCurrentView().itemIdList[itemid].toggle.curToggle and itemid==itemToPostID then
					PickupContainerItem(bag, slot)
					AuctionFrameAuctions.duration=3
					ClickAuctionSellItemButton(self)
					local stackSize, numStacks, totalItems = self:getStackInfo(itemid)

					if ZGVG.Scan:GetPrice(itemid) > 0 then
						StartAuction(ZGVG.Scan:GetPrice(itemid)*stackSize, ZGVG.Scan:GetPrice(itemid)*stackSize, 3, stackSize, numStacks)
					else
						itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,itemEquipLoc, itemTexture, itemSellPrice = cachedGetItemInfo(itemid)
						if itemSellPrice*vendorMarkup*stackSize == 0 then error("No valid price found for item.") end
						StartAuction(itemSellPrice*vendorMarkup*stackSize, itemSellPrice*vendorMarkup*stackSize, 3, stackSize, numStacks)
					end

					
					local numClicks,_,floodLimited = self:GetNumberOfSellClicks(itemid)
					
					Appraiser:UpdatePostText(Appraiser:getCurrentView())
					if numClicks <= 1 then
						Appraiser:getCurrentView():RemoveItem(itemid)
						self:removeItemFromList("appraiser", itemid)
						self:removeItemFromList("post", itemid)

						self:SetStatus("Posted "..stackSize*numStacks.." "..name)
						refreshIDOnNextUpdate = itemid
					else
						Appraiser:getCurrentView():SetItemCount(itemid)
						if floodLimited then
							self:SetStatus("Flood protected for "..name)
						else
							self:SetStatus("Confirmation needed for "..name)
						end
						refreshIDOnNextUpdate = itemid
					end
					Appraiser:getCurrentView():RefreshUI()
					return -- You can only call StartAuction once.
				end
			end
		end
	end
	self:ClearItems()
end

-- Sorts the list for Appraiser.
-- Currently sorts by price.
function Appraiser:ListSort(list)
	assert(list~=nil)
	local sortTable = {}
	local newList = {}

	-- Shallow copy the list
	for index, value in pairs(list) do
		sortTable[index]=value
	end

	-- Sort the list
	sort(sortTable, function(a,b)
		local stackSizeA, numStacksA = self:getStackInfo(a.itemid)
		local stackSizeB, numStacksB = self:getStackInfo(b.itemid)

		local priceA = ZGVG.Scan:GetPrice(a.itemid)*numStacksA*stackSizeA
		local priceB = ZGVG.Scan:GetPrice(b.itemid)*numStacksB*stackSizeB
		
		if priceA == 0 then
			local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,itemEquipLoc, itemTexture, itemSellPrice = cachedGetItemInfo(a.itemid)
			priceA =  itemSellPrice*vendorMarkup
		end

		if priceB == 0 then
			local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,itemEquipLoc, itemTexture, itemSellPrice = cachedGetItemInfo(b.itemid)
			priceB =  itemSellPrice*vendorMarkup
		end
		
		--return ZGVG.Scan:GetPrice(a.itemid)*numStacksA*stackSizeA > ZGVG.Scan:GetPrice(b.itemid)*numStacksB*stackSizeB
		
		--print(ZGV.Gold:GetItemPrice(a.itemid) .. " " .. ZGV.Gold:GetItemPrice(b.itemid))
		
		return priceA > priceB
		
		--return ZGV.Gold:GetItemPrice(a.itemid)*numStacksA*stackSizeA > ZGV.Gold:GetItemPrice(b.itemid)*numStacksB*stackSizeB
		
		--ZGVG.Scan:GetPrice(a.itemid)*numStacksA*stackSizeA > ZGVG.Scan:GetPrice(b.itemid)*numStacksB*stackSizeB
	end)
	
	return sortTable
end

function Appraiser:getItemCount(itemid) --TODO: remove? rework? what's it for anyway, if we have GetItemCount(id) ?
	local totalItemCount = 0
	local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice
	local texture, itemCount, locked, quality, readable
	for bag=0, NUM_BAG_SLOTS do
		for slot=1, GetContainerNumSlots(bag) do
			local currentItemid=GetContainerItemID(bag,slot)
			if currentItemid==itemid then
				name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = cachedGetItemInfo(itemid)
				texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag, slot);
				totalItemCount = totalItemCount + itemCount
			end
		end
	end
	return totalItemCount
end

-- Returns: stackSize, numStacks, floodLimitedItems, totalItems, floodLimited
-- Intended for use with StartAuction.
-- Always returns an integer; if you have multiple complete stacks and some partial stacks, it only counts the complete stacks.
-- If there's less than a stack, returns stackSize of how many items you have, and numStacks of 1.
-- If thee's none of the indicated item, returns 0, 0, 0, 0, false
-- Uses Smart Stacks as needed.
function Appraiser:getStackInfo(itemID)

	assert(itemID)
	local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(itemID)
	local floodLimited = false
	
	--if itemID == 104104 then
	--	print(class.."|"..subclass)
	--end
	local itemCountTotal = 0
	for bag=0, NUM_BAG_SLOTS do
		for slot=1, GetContainerNumSlots(bag) do
			local item=GetContainerItemID(bag,slot)
			if item and itemID==item then
				local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag, slot)
				itemCountTotal = itemCountTotal + itemCount
			end
		end
	end
	
	if itemCountTotal == 0 then
		return 0, 0, 0, 0, false
	end
	
	-- If the maximum stack size is set manually, use the manually set maximum stack size.
	
	if ZGV.db.profile.smartstack and ZGV.StackSizesByType and ZGV.StackSizesByType[class] then 
		if type(ZGV.StackSizesByType[class])=="number" then
			maxStack = ZGV.StackSizesByType[class]
		elseif type(ZGV.StackSizesByType[class])=="table" and ZGV.StackSizesByType[class][subclass] then
			maxStack = ZGV.StackSizesByType[class][subclass]
		end
	end
	
	
	if ZGV.db.profile.smartstack and ZGV.StackSizes and ZGV.StackSizes[itemID] and ZGV.StackSizes[itemID] < maxStack then
		maxStack = ZGV.StackSizes[itemID]
	end

	local choreItemInfoById = {}
	if ZGV.Gold.chores.route then
		for routeNumber, route in pairs(ZGV.Gold.chores.route) do
			for itemNumber, itemInfo in pairs(route.items) do
				choreItemInfoById[itemInfo[1]] = itemInfo
			end
		end	
	end
	
	floodLimitedTotal = itemCountTotal
	-- Cap # of items to demand
	if ZGV.db.profile.smartstack and choreItemInfoById[itemID] and choreItemInfoById[itemID].demand and itemCountTotal > choreItemInfoById[itemID].demand then
		floodLimitedTotal = choreItemInfoById[itemID].demand
		floodLimited = true
	end
	
	-- Crazy paper zeppelins, I tell you . . . .
	-- Yeah, got a bug when receiving a paper zeppelin while at the auction house. No joke.
	-- ~~Jeremiah
	if maxStack == nil then
		return 0, 0, 0, 0, false
	end
	
	if itemCountTotal > maxStack then
		return maxStack, floor(floodLimitedTotal/maxStack), itemCountTotal, floodLimitedTotal, floodLimited
	else
		return itemCountTotal, 1, itemCountTotal, floodLimitedTotal, floodLimited
	end
end

-- Normally, the view shouldn't be set outside of the Appraiser object, but
-- we need to be able to have a view for some tests before it's normally set up.
function Appraiser:SetAppraiserView(newView)
	if not ZGV.UseUnitTesting then error("Only available while testing.") end
	currentAppraiserView = newView
end

--------------------------------------------------------------------------------
function Appraiser:getCurrentView()
	return currentAppraiserView
end

function Appraiser:GetSellPrice(itemid, numStacks, stackSize)
	if ZGV.Gold.servertrends and ZGV.Gold.servertrends.items[itemid] and ZGV.Gold.servertrends.items[itemid].p_lo and ZGV.Gold.servertrends.items[itemid].p_lo > 0 then
		-- GetPrice only gets today's price, and there may be gaps. Check server trends first. ~~ Jeremiah
		return ZGV.Gold.servertrends.items[itemid].p_lo * numStacks * stackSize
	else
		return ZGV.Gold.Scan:GetPrice(itemid) * numStacks * stackSize
	end

end

--ZGV.Gold.AppraiserView:CreateAppraiserView()
local function EventHandler(self, event)
	if not currentAppraiserView then return end  -- not ready yet? bail.
	if event=="AUCTION_HOUSE_SHOW" then
		--[[
		if ZGV.db.profile.auction_enable == false then
			currentAppraiserView:ResetStatus()
			return 
		end
		--]]
		currentAppraiserView:Show()
		
		if itemsLoaded == false then
			currentAppraiserView:LoadItemsIntoAppraiser()
			itemsLoaded = true
		else
			--Appraiser.appraiserItemList = {}
			--Appraiser:LoadItemsIntoAppraiser()
		end

		ZGV:DelayedRun("OnUpdate", function()
			currentAppraiserView:RefreshUI()
		end)
		
		-- Add a time delayed update, which band-aids the issue of prices not appearing.
		-- TODO: There has to be a better way than this.
		ZGV:TimedDelayedRun(1, function()
				-- For now, we're forcing the issue: Always scan. But this *is* supposed to be optional, it just breaks when turned off.
				--Appraiser:Scan(currentAppraiserView)
				currentAppraiserView:RefreshUI()
		end)
		
		Appraiser.delayedScanStart = true
		currentAppraiserView.refreshOnBagUpdate = true
		currentAppraiserView.auctionHouseOpen = true
	elseif event=="AUCTION_HOUSE_CLOSED" then
		refreshOnBagUpdate = false
		currentAppraiserView:SetTab("Appraiser", true)
		currentAppraiserView:Hide()
		currentAppraiserView.auctionHouseOpen = false
	elseif event=="ITEM_LOCKED" then
		itemLocked = true
	elseif event=="ITEM_UNLOCKED" then
		itemLocked = false
	elseif event=="SS_OUT" then
		currentAppraiserView:UpdateStatus()
	elseif event=="SS_IDLE" then
		currentAppraiserView:UpdateStatus()
		--currentAppraiserView:RefreshUI()
		currentAppraiserView.progressFrame:SetPercent(100)
		currentAppraiserView.progressFrame:Hide()
	elseif event=="SS_QUERYING" then
		Appraiser:SetStatus("Querying, do not close auctions or attempt a search")
		progressFrame:SetPercent(40)
	elseif event=="SS_SCANNING" then
		Appraiser:SetStatus("Scanning")
		progressFrame:SetPercent(60)
	elseif event=="SS_ANALYZING" then
		Appraiser:SetStatus("Analyzing")
		progressFrame:SetPercent(80)
	elseif event=="AUCTION_OWNED_LIST_UPDATE" then
		-- This is an odd place to put it, but scanning isn't ready
		-- in AUCTION_HOUSE_SHOW, we have to delay it a bit more.
		if Appraiser.delayedScanStart == true and ZGV.db.profile.autoscan then
			Appraiser:Scan(Appraiser:getCurrentView())
			Appraiser.delayedScanStart = false
		end
	elseif event=="BAG_UPDATE_DELAYED" then
		Appraiser:UpdatePostText(currentAppraiserView)
		if refreshOnBagUpdate == true then
			currentAppraiserView:RefreshUI()
		end
		
		if refreshIDOnNextUpdate and refreshIDOnNextUpdate ~= 0 then
			currentAppraiserView:RefreshUI()
			--Spoo(nil, nil, self)
			isRemoved = currentAppraiserView:SetItemCount(refreshIDOnNextUpdate)
			if isRemoved == "item removed" then
				Appraiser:removeItemFromList("appraiser", refreshIDOnNextUpdate)
				Appraiser:removeItemFromList("post", refreshIDOnNextUpdate)
			end
			refreshIDOnNextUpdate = 0
		end
		
		-- Destroying an item keeps it locked apparently. Clear that on a bag update. 
		itemLocked = false

	elseif event=="UNIT_INVENTORY_CHANGED" then
		if refreshOnBagUpdate == true then
			currentAppraiserView:RefreshUI()
		end
	elseif event=="SS_NEEDTOQUERY" then
		-- ignore?
		
		-- Yeah, ignore, if it's already showing "Querying, do not close auctions or attempt a search"
		-- There's no need for more status messages thrown at the user ~~Jeremiah
	elseif event=="AUCTION_ITEM_LIST_UPDATE" then
		-- I only have delayed functions for this event; just here to
		-- prevent showing the event not found debug message. ~~Jeremiah
		--ZGV:DelayedRun("OnUpdate", function() Appraiser:HighlightDeals() end)
	else
		ZGV:Debug("Event not found: "..event)
	end
	
end

local function updateHandler()
	if not Appraiser.enabled or not currentAppraiserView then return end

	if refreshOnNextUpdate == true then
		currentAppraiserView:RefreshUI()
		refreshOnNextUpdate = false
	end

	if Appraiser.manualScanning then
		if ZGVG.Scan:CanScanByName() and ZGVG.Scan.state=="SS_IDLE" then
			local item = tremove(Appraiser.manualItemsToScan)
			if item then
				local name = item[1] 
				ZGVG.Scan:ScanByName(name)
				Appraiser:getCurrentView():UpdateIconText(item[2], "√")
			else
				-- Finish scan.
				Appraiser.manualScanning = false
			end
		end
	end
	
	if Appraiser.activeTab == "Appraiser" then  ZGV.Gold.AppraiserView:UpdateStatus()  end
	
	-- TODO: What did this do?
	if currentAppraiserView.nextUpdateSetStartingPrice > 0 then
		stackSize, numStacks, floodLimitedItems, totalItems, floodLimited = self:getStackInfo(currentAppraiserView.nextUpdateItemID)
		UIDropDownMenu_SetSelectedValue(PriceDropDown, 2)
		UIDropDownMenu_SetSelectedValue(DurationDropDown, 3)
		MoneyInputFrame_SetCopper(StartPrice, currentAppraiserView.nextUpdateSetStartingPrice)
		AuctionsStackSizeEntry:SetNumber(stackSize)
		AuctionsNumStacksEntry:SetNumber(numStacks)
		currentAppraiserView.nextUpdateSetStartingPrice = 0
		currentAppraiserView.nextUpdateItemID = nil
	end

	--if nextUpdateSetBuyoutPrice > 0 then
	--	MoneyInputFrame_SetCopper(BuyoutPrice, nextUpdateSetBuyoutPrice)
	--	nextUpdateSetBuyoutPrice = 0
	--end

end

-- Separate frame for events because Appraiser's own frame doesn't exist until it's first shown.
Appraiser.Events = CreateFrame("Frame")
Appraiser.Events:RegisterEvent("AUCTION_HOUSE_SHOW")
Appraiser.Events:RegisterEvent("AUCTION_HOUSE_CLOSED")
Appraiser.Events:RegisterEvent("AUCTION_OWNED_LIST_UPDATE")
Appraiser.Events:RegisterEvent("ITEM_LOCKED")
Appraiser.Events:RegisterEvent("ITEM_UNLOCKED")
Appraiser.Events:RegisterEvent("BAG_UPDATE_DELAYED")
Appraiser.Events:RegisterEvent("UNIT_INVENTORY_CHANGED")
Appraiser.Events:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")
ZGV:RegisterMessage("SS_STATE_CHANGE",EventHandler)
Appraiser.Events:SetScript("OnEvent",EventHandler)
Appraiser.Events:SetScript("OnUpdate",updateHandler)


Appraiser.BuyTab = {}


ZGVG=ZGV.Gold
ZGVGA=Appraiser
ZGVGAB=Appraiser.BuyTab

--2589=linen, 2592=wool, 4306=silk

function Appraiser.BuyTab:FocusItem(id)
	local name
	if type(id)=="string" then
		name=id
		local _,link = GetItemInfo(name)
		if not link then ZGV:Error("No link for %s",name) return end
		id = tonumber(link:match("item:(%d+)"))
		if not id then ZGV:Error("No id for %s",name) return end
	end
	name=name or (GetItemInfo(id))
	if not name then ZGV:Error("No name for %s",id) return end
	self.focused_item = id
	self.focused_item_name = name
	self.focused_item_auctions = {}
	self.focused_item_cheapest = {}
	ZGV:Debug("BUY focused on: %s",name)
	
	Appraiser.BuyTab:GetAuctionsForFocusedItem()
end

function Appraiser.BuyTab:DB_FocusItem_Linen() self:FocusItem(2589) end
function Appraiser.BuyTab:DB_FocusItem_Wool() self:FocusItem(2592) end
function Appraiser.BuyTab:DB_FocusItem_Silk() self:FocusItem(4306) end
function Appraiser.BuyTab:DB_FocusItem_FirstInResults() local itemname, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo = GetAuctionItemInfo("list",1)  self:FocusItem(itemId) end

-- "debug console":
-- /spoo ZGVGAB

-- FAKE TRENDS: ZGV.Gold.servertrends.items[id]={health=1,
function Appraiser.BuyTab:FakeTrends(id,p_lo,p_hi) --for debugging
	if not p_hi then id,p_lo,p_hi=self.focused_item,id,p_lo end  -- support for FakeTrends(10,20)
	ZGV.Gold.servertrends.items[id]={health=1,p_lo=p_lo,p_hi=p_hi}
end

function Appraiser.BuyTab:GetAuctionsForFocusedItem()
	Appraiser:ScanByName(self.focused_item_name)
	ZGV:DelayedRun("MSG APPRAISER_SCANBYNAME_DONE",function(auctions)
		local count=0 for pi,pa in ipairs(auctions) do for ai,au in pairs(pa) do count=count+1 end end
		ZGV:Debug("&gold "..count.." auctions on "..#auctions.." pages for ".. Appraiser.BuyTab.focused_item_name ..". Finding best price now...")
		Appraiser.BuyTab.focused_item_auctions = auctions
		Appraiser.BuyTab:FindCheapestResultForFocusedItem()
	end)
end

function Appraiser.BuyTab:FindCheapestResultForFocusedItem()
	local cheapest=999999999
	local pag,ind,auc=0,1,nil
	for pagenum,page in ipairs(self.focused_item_auctions) do
		for index,auction in pairs(page) do
			local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice = unpack(auction)
			local pricepi = ceil(buyoutPrice/count)
			if pricepi>0 and pricepi<cheapest then
				cheapest,pag,ind = pricepi,pagenum,index
				auc = auction
			end
		end
	end
	if cheapest==999999999 then return end
	self.focused_item_cheapest = { price=cheapest, page=pag, index=ind, auction=itm }
	Spoo(nil,nil,self.focused_item_cheapest)
end
ZGVGAB.FCRFFI=ZGVGAB.FindCheapestResultForFocusedItem

function Appraiser.BuyTab:BuyFocusedItem()
	if not self.focused_item_cheapest then ZGV:Debug("&gold Appraiser.BuyTab:BuyFocusedItem ERROR: no cheapest auction found") return end
	for i=1,50 do
		local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice = GetAuctionItemInfo("list")
		if name==self.focused_item_name
		or count==self.focused_item_cheapest.auction[3]
		or buyoutPrice==self.focused_item_cheapest.auction[10] then
			ZGV:Debug("&gold BUYING AUCTION NOW!!!: index "..i..": "..name.." x "..count.." for "..buyoutPrice.." ("..self.focused_item_cheapest.price.." ea)")
			return true
		end
	end
	ZGV:Debug("&gold FAILED TO BUY :(")
end

function Appraiser.BuyTab:VerifyResults()
	-- clone auction results, to detect tampering
	local batch, count = GetNumAuctionItems("list")
	--print("batch: "..batch.." count: "..count)
	for index=1,batch do
		local auc = {GetAuctionItemInfo("list",index)}
		for i=1,18 do if auc[i]~=self.auction_results[index][i] then return false end end
	end
	return true
end

-- StaticPopup_Show

StaticPopupDialogs["ZGV_DEBUG_INPUT"] = {
	text = "ZGV DEBUG INPUT",
	button1 = ACCEPT,
	button2 = CANCEL,
	hasEditBox = 1,
	maxLetters = 99,
	OnAccept = function(self)
		local text = self.editBox:GetText();
		self:CallbackAccept(text)
	end,
	EditBoxOnEnterPressed = function(self)
		self:GetParent().OnAccept(self:GetParent())
		self:GetParent():Hide();
	end,
	OnShow = function(self)
		self.editBox:SetFocus();
	end,
	OnHide = function(self)
		ChatEdit_FocusActiveWindow();
		self.editBox:SetText("");
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
}



tinsert(ZGV.startups,function(self)
	Appraiser.enabled = true

	if not currentAppraiserView then
		currentAppraiserView=true  -- in case the one below crashes
		-- TODO: Eventually, this goes away and is replaced by three views.
		currentAppraiserView = ZGV.Gold.AppraiserView:CreateAppraiserView()
		
		--buyView = AppraiserView:CreateAppraiserView()
		--inventoryView = AppraiserView:CreateAppraiserView()
		--postView = AppraiserView:CreateAppraiserView()
		
		currentAppraiserView:Hide()

		Appraiser.view = currentAppraiserView
	end

	ZGV:Debug("Appraiser enabled.")
end)
