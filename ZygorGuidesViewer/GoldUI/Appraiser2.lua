local ZGV = ZygorGuidesViewer
if not ZGV then return end

local ZGVG=ZGV.Gold

local L = ZGV.L
local CHAIN = ZGV.ChainCall

if not ZGV.Gold.Appraiser then ZGV.Gold.Appraiser = {} end
local Appraiser = ZGV.Gold.Appraiser
local Gratuity = LibStub("LibGratuity-3.0")


local ROWCOUNT=14
local GOLD_FORMAT_TYPE=3

Appraiser.DraggedItem = {} -- used to check if item added to ah has been dragged from appraiser
Appraiser.OurDraggedItem = {}


function Appraiser.sort_buy(a,b)
	if not a or not b then return false end
	if not a.name or not b.name then return false end
	a,b=a.name,b.name
	return a<b
end

function Appraiser.sort_inventory(a,b)
	if not a.price or not b.price then return false end
	if a.statusId == b.statusId then
		return a.price > b.price
	else
		return a.statusId < b.statusId
	end
end


function Appraiser:Update()
	if not self.MainFrame then return end
	if not self.MainFrame:IsVisible() then return end

	self.needToUpdate = false


	if ZGV.Gold.Appraiser.MainFrame.hideTooltip then
		GameTooltip:Hide()
		ZGV.Gold.Appraiser.MainFrame.hideTooltip = false
	end

	local rownum=0
	local rowoff=0

	self.InventoryItems = {}
	self.FlatSellItems = {}
	self.SellItems = self.SellItems or {}
	self.BuyItems = self.BuyItems or {}
	self.GuideBuyItems = self.GuideBuyItems or {}

	-- Initialise
	if self.ActiveTab == "Inventory" then
		for bag=0, NUM_BAG_SLOTS do
			for slot=1, GetContainerNumSlots(bag) do
				self:AddItemToInventory(bag,slot)
			end
		end
	end
	if self.ActiveTab == "Buy" then
		-- Moved to guide step entry
	end

	-- Sort
	if self.ActiveTab == "Inventory" then
		sort(self.InventoryItems,Appraiser.sort_inventory)
	elseif self.ActiveTab == "Buy" then
		if next(self.GuideBuyItems) then
			sort(self.GuideBuyItems,Appraiser.sort_buy)
		end
		self.MergedBuyItems = {}
		local indexMerged = 1
		for indexBuy = #self.BuyItems,1,-1 do
			self.MergedBuyItems[indexMerged] = self.BuyItems[indexBuy]
			indexMerged = indexMerged + 1
		end
		for indexGuide,v in pairs(self.GuideBuyItems) do
			self.MergedBuyItems[indexMerged] = self.GuideBuyItems[indexGuide]
			indexMerged = indexMerged + 1
		end
	end

	-- Display
	if self.ActiveTab == "Inventory" then
		page = self.MainFrame.Inventory_Frame 
		self.MainFrame.offset = max(0,min(self.MainFrame.offset,#self.InventoryItems-ROWCOUNT))
		rowoff=self.MainFrame.offset
		for ii,invItem in ipairs(self.InventoryItems) do 
			rownum = ii-rowoff
			if rownum>0 and rownum<ROWCOUNT+1 then 
				local row = page.rows[rownum]
				row.icon:SetTexture(invItem.icon)
				row.name:SetText(invItem.count.." "..(invItem.name or "?"))
				row.status:SetText(invItem.statusIcon)
				row.price:SetText(ZGV.GetMoneyString(invItem.price or 0))
				row.item = invItem
				row:Show()
			end
		end

		self.MainFrame.scrollbar:TotalValue(#self.InventoryItems)
		self.MainFrame.scrollbar:SetValue(rowoff)
	elseif self.ActiveTab == "Buy" then
		page = self.MainFrame.Buy_Frame 
		self.MainFrame.offset = max(0,min(self.MainFrame.offset,#self.MergedBuyItems-ROWCOUNT))
		rowoff=self.MainFrame.offset
		for ii,invItem in ipairs(self.MergedBuyItems) do 
			rownum = ii-rowoff
			if rownum>0 and rownum<ROWCOUNT+1 then 
				local row = page.rows[rownum]
				row.icon:SetTexture(invItem.icon)
				row.name:SetText(invItem.count.." "..invItem.name)
				--row.deal:SetText((invItem.deals == 0 and "") or invItem.deals)
				row.item = invItem
				row:Show()
			end
		end
		
		self.MainFrame.scrollbar:TotalValue(#self.MergedBuyItems)
		self.MainFrame.scrollbar:SetValue(rowoff)
	end

	for r=rownum+1,ROWCOUNT do page.rows[r]:Hide() end

end

function Appraiser:InventoryToggleAll(state)
	if not state then
		self.SellItems = nil
	else
		for i,item in pairs(self.InventoryItems) do
			self.SellItems = self.SellItems or {}
			self.SellItems[item.bag] = self.SellItems[item.bag] or {}
			self.SellItems[item.bag][item.slot] = item
		end
	end
	self:Update()
end


function Appraiser:AddGuideItemsToBuy()
	self.GuideBuyItems = {}

	for goalid,goal in pairs(ZGV.CurrentStep.goals) do
		if goal.action == "buy" then
			local itemid = goal.targetid
			local count = goal.count
			local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(itemid)

			local newitem = {id=itemid,name=name,link=link,icon=texture,count=itemCount, price=trendprice,count=count, deals=deals, isManual=manual, priceMax=priceMax}
			table.insert(self.GuideBuyItems,newitem)
		end
	end
end

function Appraiser:AddItemToBuy(itemid,count,manual,priceMax)
	if not itemid then return end

	self.BuyItems = self.BuyItems or {}

	local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(itemid)

	local price = ZGV.Gold.Scan:GetPrice(itemid)

	local deals = 0
	local existing_count = 0
	local existing_index

	for index,item in pairs(self.BuyItems) do
		if item.id == itemid then
			existing_index = index
			existing_count = item.count
		end
	end

	if existing_index then
		self.BuyItems[existing_index].count = self.BuyItems[existing_index].count+count
	else
		local newitem = {id=itemid,name=name,link=link,icon=texture,price=trendprice,count=count, deals=deals, isManual=manual, priceMax=priceMax}
		table.insert(self.BuyItems,newitem)
	end

	if Appraiser.MainFrame then
		Appraiser:SetCurrentTab("Buy")
	end

	ZGV.NotificationCenter.AddButton(
	    "",
	   "Shopping list",
	    count.." "..name..(count>1 and "s" or ""),
	    ZGV.DIR.."\\Skins\\guideicons-big",
	    {0, 0.25, 0.25, 0.50},
	    nil,
	    nil,
	    1,
	    poptime,        -- nil atm
	    removetime,        -- nil atm
	    nil,            -- nil atm
	    nil,            -- nil atm
	    "gold")

end

function Appraiser:RemoveItemFromBuy(row)
	local itemid = row.item.id
	local count = row.item.count

	for i,v in pairs(self.BuyItems) do
		if v.id == itemid and v.count == count then
			table.remove(self.BuyItems,i)
		end
	end

	for i,v in pairs(self.GuideBuyItems) do
		if v.id == itemid and v.count == count then
			table.remove(self.GuideBuyItems,i)
		end
	end
	self.needToUpdate = true
end

function Appraiser:AddItemToInventory(bag,slot)
	local itemid=GetContainerItemID(bag,slot)
	local CachedPetCages = CachedPetCages or {}
	if itemid then
		--Gratuity:SetHyperlink("item:"..itemid)
		Gratuity:SetBagItem(bag,slot)
		local n = Gratuity:NumLines()
		local isbop = false
		local isboa = false
		local isbound = false
		local price = 0

		for i=1,n do
			local line=Gratuity:GetLine(i)
			if line then
				isbop = isbop or strfind(line, ITEM_BIND_ON_PICKUP)
				isboa = isboa or strfind(line, ITEM_BIND_TO_BNETACCOUNT)
				isboa = isboa or strfind(line, ITEM_BNETACCOUNTBOUND)
				isbound = isbound or strfind(line, ITEM_SOULBOUND)
			end
		end


		local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(itemid)
		local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag, slot)

		if isbop or isboa or isbound then return false end

		if itemid == 82800 then -- Caged pet
			-- regex correct, needs serverside support
			-- _,_,_,BattlePetId,_,BattlePetName = string.find(GetContainerItemLink(bag, slot),"(.*)battlepet:(%d+):(.*)%[(.*)%]")
			return false
		end


		local statusIcon, statusText, statusId

		price, statusId, statusText, statusIcon = ZGVG:GetSellPrice(itemid,itemCount)

		local exists = false
		for i,v in pairs(self.InventoryItems) do
			if v.itemid == itemid and not exists then
				exists = exists or true
				self.InventoryItems[i].count = self.InventoryItems[i].count + itemCount
				self.InventoryItems[i].price = self.InventoryItems[i].price + price
			end
		end
		if not exists then
			local newitem = {itemid=itemid,name=name,link=link,icon=texture,count=itemCount,price=price,bag=bag,slot=slot,statusText=statusText,statusIcon=statusIcon,statusId=statusId,BattlePetId=BattlePetId,BattlePetName=BattlePetName}
			table.insert(self.InventoryItems,newitem)
		end
	end
end

function Appraiser:SellItem(item)
	AuctionFrameTab_OnClick(AuctionFrameTab3)
end

function Appraiser:SearchForItem(item)
	AuctionFrameTab_OnClick(AuctionFrameTab1)
	BrowseName:SetText(item.name)
	QueryAuctionItems(item.name)

	Appraiser.itemForHighlights = item.id
	Appraiser.itemForHighlightsPrice = item.priceMax
	--Appraiser:HighlightDeals(item.id)
end


local function EventHandler(self, event, ...)
	args = {...}
	if event=="AUCTION_HOUSE_SHOW" then
		ZGV.Gold.Appraiser.OurItemBeingSold = false
		ZGV.Gold.Appraiser.OurDraggedItem = {}
		Appraiser:ShowWindow()
	elseif event=="AUCTION_HOUSE_CLOSED" then
		Appraiser:HideWindow()
		if ZGV.Gold.HelpPopup then
			ZGV.Gold.HelpPopup:Hide()
		end
	elseif event=="AUCTION_ITEM_LIST_UPDATE" then
		--Appraiser:HighlightDeals()
	end

	Appraiser.needToUpdate = true

	if ZGV.Gold.Appraiser.MainFrame then
		if event=="SS_STATE_CHANGE" then
			if ...~="SS_IDLE" and self.ActiveTab == "Inventory" then
				self.MainFrame.progressFrame:Show()
			end

			if ...=="SS_IDLE" then
				ZGV.Gold.Appraiser.MainFrame.progressFrame:SetPercent(100)
				ZGV.Gold.Appraiser.MainFrame.progressFrame:Hide()
				if ZGV.Gold.Appraiser.UpdateScanRunning then
					ZGV.Gold.Appraiser.UpdateScanRunning = false
					Appraiser.needToUpdate = true
				end
				Appraiser:SetSellData()

			elseif ... =="SS_QUERYING" then
				ZGV.Gold.Appraiser.MainFrame.progressFrame:SetPercent(40)
			elseif ... =="SS_SCANNING" then
				ZGV.Gold.Appraiser.MainFrame.progressFrame:SetPercent(60)
				elseif ... =="SS_ANALYZING" then
				ZGV.Gold.Appraiser.MainFrame.progressFrame:SetPercent(80)	
				Appraiser.needToUpdate = true
			end
		end

		if event=="ITEM_UNLOCKED" then
			ZGV.Gold.Appraiser.OurItemBeingSold = false
			ZGV.Gold.Appraiser.OurDraggedItem = {}
			Appraiser.needToUpdate = true
		end

		if event=="ITEM_LOCKED" then
			ZGV.Gold.Appraiser.DraggedItem[1] = args[1]
			ZGV.Gold.Appraiser.DraggedItem[2] = args[2]
			Appraiser.needToUpdate = true
		end
		if event=="NEW_AUCTION_UPDATE" then
			ZGV:ScheduleTimer(function() 
				if (ZGV.Gold.Appraiser.DraggedItem[1] == ZGV.Gold.Appraiser.OurDraggedItem[1] 
				and ZGV.Gold.Appraiser.DraggedItem[2] == ZGV.Gold.Appraiser.OurDraggedItem[2]) then
					ZGV.Gold.Appraiser.OurItemBeingSold = ZGV.Gold.Appraiser.OurDraggedItem[3]
					ZGV.Gold.Appraiser.OurItemBeingSoldName = ZGV.Gold.Appraiser.OurDraggedItem[5]
				else
					ZGV.Gold.Appraiser.OurItemBeingSold = false
				end
				ZGV.Gold.Appraiser.AuctionsStackSizeEntry = AuctionsStackSizeEntry:GetText()
				ZGV.Gold.Appraiser.AuctionsNumStacksEntry = AuctionsNumStacksEntry:GetText()
				ZGV.Gold.Appraiser.AuctionsMode = PriceDropDown.selectedValue

				Appraiser:SetSellData(true) 
				ZGV.Gold.Appraiser.OurDraggedItem = {}
			end, 0.2)
		end
	end
end

local function UpdateHandler(self, event)
	if not ZGV.Gold.Appraiser.MainFrame then return end
	if not ZGV.Gold.Appraiser.MainFrame:IsVisible() then return end

	if Appraiser.manualScanning then 
		Appraiser:ScanNextItem() 
	end
	if Appraiser.itemForHighlights and Appraiser.ActiveTab == "Buy" then
		Appraiser:HighlightDeals()
	end

	if Appraiser.needToUpdate then
		Appraiser:Update()
	end
	Appraiser:UpdateTimeStamp()
	Appraiser:CheckForSellPriceUpdate()

	local buttonScan = ZGV.Gold.Appraiser.MainFrame.Inventory_Frame.FooterScanButton
	local buttonAppr = ZGV.Gold.Appraiser.MainFrame.Inventory_Frame.FooterAppraiseButton
	local buttonReAp = ZGV.Gold.Appraiser.AHUpdateButton

	local canscan,delay = ZGVG.Scan:CanScanByName()
	if canscan then
		buttonAppr:SetText("|cFFFFFFFFAppraise")
		buttonAppr.soft_disabled=false
		buttonAppr.tooltip = "Update prices of items shown."

	else
		buttonAppr:SetText("|c88888888Appraise")
		buttonAppr.soft_disabled=true
		buttonAppr.tooltip = ("|cffff0000Auction scan not possible now, please wait ~%d minutes."):format(delay)

	end

	if canscan then
		local name, texture, count, quality, canUse, price, pricePerUnit, stackCount, totalCount = GetAuctionSellItemInfo();
		if name then
			buttonReAp:SetText("|cFFFFFFFFUpdate")
			buttonReAp.soft_disabled=false
			buttonReAp.tooltip = "Update price of listed item."
		else
			buttonReAp:SetText("|c88888888Update")
			buttonReAp.soft_disabled=true
			buttonReAp.tooltip = "|cffff0000No item listed."
		end
	else
		buttonReAp:SetText("|c88888888Update")
		buttonReAp.soft_disabled=true
		buttonReAp.tooltip = ("|cffff0000Auction scan not possible now, please wait ~%d minutes."):format(delay)
	end

	local canscan2,delay2 = ZGVG.Scan:CanScanFast()
	if canscan2 and ZGV.Gold.Scan.state=="SS_IDLE" then
		buttonScan.tooltip = "Run a fast auction scan."
		buttonScan:SetText("|cFFFFFFFFScan")
		buttonScan.soft_disabled=false
	else
		buttonScan:SetText("|c88888888Scan")
		buttonScan.soft_disabled=true
		buttonScan.tooltip = ("|cffff0000Auction scan not possible now, please wait ~%d minutes."):format(delay2)
	end
end


function Appraiser:CreateTrackerFrame()
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
	Appraiser.Events:RegisterEvent("NEW_AUCTION_UPDATE")
	ZGV:AddMessage("SS_STATE_CHANGE",EventHandler)
	Appraiser.Events:SetScript("OnEvent",EventHandler)
	Appraiser.Events:SetScript("OnUpdate",UpdateHandler)
end

tinsert(ZGV.startups,function(self)
	Appraiser:CreateTrackerFrame()
end)

function Appraiser:Scan()
	if ZGVG.Scan:CanScanFast() then
		if self.ActiveTab == "Inventory" then
			self.MainFrame.progressFrame:Show()
		end
		ZGVG.Scan:ScanFast()
		self.MainFrame.progressFrame:SetPercent(20)
	else 
		ZGV:Debug("&appraiser &scan Cannot perform AH scan")
	end
	self:Update()
end

function Appraiser:StartManualScan()
	if self.manualScanning then return end
	self.ScanItems = {}
	self.manualScanning = true
	for i,v in pairs(self.InventoryItems) do
		table.insert(self.ScanItems,v)
	end
end

function Appraiser:ScanNextItem()
	if Appraiser.manualScanning then
		if ZGVG.Scan:CanScanByName() and ZGVG.Scan.state=="SS_IDLE" then
			local item = tremove(Appraiser.ScanItems)
			if item then
				ZGVG.Scan:ScanByName(item.name)
			else
				Appraiser.manualScanning = false
			end
		end
		self:Update()
	end
end

function Appraiser:IsDeal(item,price)
	local trendprice = ZGV.Gold.servertrends.items[item].p_md
	if not trendprice then
		return false
	end

	if price and price ~= "__orderedIndex" and price<trendprice then
		return true
	else
		return false
	end
end

function Appraiser:InventoryDragStart(row)
	PickupContainerItem(row.item.bag, row.item.slot)
	local texture, count, locked, quality, readable, lootable, link, isFiltered = GetContainerItemInfo(row.item.bag, row.item.slot)
	self.OurDraggedItem = {row.item.bag, row.item.slot, row.item.itemid, row.item.count, row.item.name}
	AuctionFrameTab_OnClick(AuctionFrameTab3)
	self.UpdateScanRunning = row.item.itemid
	ZGVG.Scan:ScanByName(row.item.name)
end

function Appraiser:Reappraise()
	local name, texture, count, quality, canUse, price, pricePerUnit, stackCount, totalCount = GetAuctionSellItemInfo();
	if not name then
		self.OurItemBeingSold = false
		self.UpdateScanRunning = false
		return 
	end
	local itemName, itemLink = GetItemInfo(name)

	local name = GetAuctionSellItemInfo();
	local itemName, itemLink = GetItemInfo(name)
	local id = tonumber(itemLink:match("item:(%d+)"))

	if not id then 
		self.OurItemBeingSold = false
		self.UpdateScanRunning = false
		return 
	end

	Appraiser:SetSellDataColor(0.6,0.6,0.6,0.6)
	self.UpdateScanRunning = id
	self.OurItemBeingSold = id
	ZGVG.Scan:ScanByName(itemName)
end

function Appraiser:InventoryDragStop(row)
end

function Appraiser:SetSellData(initial)
	if self.OurItemBeingSold then
		local itemid = self.OurItemBeingSold 
		local countForSellCalc

		if initial then
			local stacksize, stackcount = Appraiser:GetSellStack(itemid)

			AuctionsStackSizeEntry:SetText(stacksize)
			AuctionsNumStacksEntry:SetText(stackcount)
		end

		if ZGV.Gold.Appraiser.AuctionsMode == 2 then
			countForSellCalc = self.AuctionsStackSizeEntry
		else
			countForSellCalc = 1
		end

		selling_price = ZGVG:GetSellPrice(itemid,countForSellCalc)

		local selling_price_gold, selling_price_silver, selling_price_copper

		selling_price_gold = floor(selling_price / (COPPER_PER_SILVER * SILVER_PER_GOLD));
		selling_price_silver = floor((selling_price - (selling_price_gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
		selling_price_copper = mod(selling_price, COPPER_PER_SILVER);


		StartPriceGold:SetText(selling_price_gold)
		StartPriceSilver:SetText(selling_price_silver)
		StartPriceCopper:SetText(selling_price_copper)

		BuyoutPriceGold:SetText(selling_price_gold)
		BuyoutPriceSilver:SetText(selling_price_silver)
		BuyoutPriceCopper:SetText(selling_price_copper)

		if self.UpdateScanRunning and self.UpdateScanRunning == self.OurItemBeingSold then
			Appraiser:SetSellDataColor(0.6,0.6,0.6,0.6)
		else
			Appraiser:SetSellDataColor(0,1,0,1)
			ZGV:ScheduleTimer(function() Appraiser:SetSellDataColor(1,1,1,1) end, 1)
		end
	end

	
	-- clean up
	--ZGV.Gold.Appraiser.OurDraggedItem[1] = nil
	--ZGV.Gold.Appraiser.OurDraggedItem[2] = nil
end

function Appraiser:SetSellDataColor(r,b,g,a)
	StartPriceGold:SetTextColor(r,b,g,a)
	StartPriceSilver:SetTextColor(r,b,g,a)
	StartPriceCopper:SetTextColor(r,b,g,a)
	BuyoutPriceGold:SetTextColor(r,b,g,a)
	BuyoutPriceSilver:SetTextColor(r,b,g,a)
	BuyoutPriceCopper:SetTextColor(r,b,g,a)
	AuctionsStackSizeEntry:SetTextColor(r,b,g,a)
	AuctionsNumStacksEntry:SetTextColor(r,b,g,a)
end

function Appraiser:GetSellStack(itemid)
	local _, _, _, _, _, class, subclass, maxStack, _, _, _ = GetItemInfo(itemid)

	local itemCountTotal = 0
	for bag=0, NUM_BAG_SLOTS do
		for slot=1, GetContainerNumSlots(bag) do
			local ItemIdInBag=GetContainerItemID(bag,slot)
			if ItemIdInBag and ItemIdInBag==itemid then
				local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag, slot)
				itemCountTotal = itemCountTotal + itemCount
			end
		end
	end

	if class==L['type_trade_goods'] then
		stacksize = math.min(maxStack/4,itemCountTotal)
		stackcount = math.floor(itemCountTotal/stacksize)
	else
		stacksize = 1
		stackcount = itemCountTotal
	end

	return stacksize, stackcount
end


function Appraiser:CheckForSellPriceUpdate()
	if not AuctionFrameAuctions then return end 
	if not self.OurItemBeingSold then return end

	local reSetPrices = false
	if self.AuctionsUndercut ~= ZGV.db.profile.appraiser_undercut then
		self.AuctionsUndercut = ZGV.db.profile.appraiser_undercut
		reSetPrices = true
	end
	if self.AuctionsStackSizeEntry ~= AuctionsStackSizeEntry:GetText() then
		self.AuctionsStackSizeEntry = AuctionsStackSizeEntry:GetText()
		reSetPrices = true
	end
	if self.AuctionsNumStacksEntry ~= AuctionsNumStacksEntry:GetText() then
		self.AuctionsNumStacksEntry = AuctionsNumStacksEntry:GetText()
		reSetPrices = true
	end
	if PriceDropDown.selectedValue and self.AuctionsMode ~= PriceDropDown.selectedValue then
		self.AuctionsMode = PriceDropDown.selectedValue
		reSetPrices = true
	end
	if reSetPrices then 
		self:SetSellData()
	end
end