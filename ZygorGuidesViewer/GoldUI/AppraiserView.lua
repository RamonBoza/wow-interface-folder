-- BrowseButton1...x

local ZGV = ZygorGuidesViewer
if not ZGV then return end

local FONT=ZGV.Font
local FONTBOLD=ZGV.FontBold
local L = ZGV.L
local CHAIN = ZGV.ChainCall
local cachedGetItemInfo = ZGV.cachedGetItemInfo

local ZGVG=ZGV.Gold
local AppraiserView = {}
ZGVG.AppraiserView = AppraiserView

local Appraiser

if not ZGV.Gold.Appraiser then
	Appraiser = {}
	ZGV.Gold.Appraiser = Appraiser
else
	Appraiser = ZGV.Gold.Appraiser 
end

local ui = ZGV.UI
local SkinData = ui.SkinData

local itemLocked = false

local itemsLoaded = false

local refreshOnBagUpdate = false
local refreshOnNextUpdate = false
local refreshIDOnNextUpdate = 0

local nextUpdateSetStartingPrice = 0
local nextUpdateSetBuyoutPrice = 0
local nextUpdateItemID = nil

local auctionHouseOpen = false

Appraiser.vendorMarkup = 3 -- Vendor markup for when we have no other price available.

local vendorMarkup = Appraiser.vendorMarkup 

local itemid_waiting_for = nil

Appraiser.totalAuctionItemsByID = {} -- apparently not easy to get this info from Sinus' scan?

-- Delays running a function until the next OnUpdate or a specified event.
-- I do this so often, might as well formalize it.
-- NOTE: Delayed functions use the impled "self," so make sure you use the colon syntax, and make sure they take "self."
-- TODO: This is available outside of Appraiser; depricate it.


function AppraiserView:Show()
	--if not self.frame then
		-- Dirty... Just replace the old table with this one because it got created now.
	--	Appraiser = self:CreateAppraiserView()
	--	ZGVG.Appraiser = Appraiser

	--	self = Appraiser
	--end
	
	if ZGV.db.profile.auction_enable == false then return end

	self:oldShow()
	
	self:UpdateTimeStamp()
	self:UpdateStatus()
	
	self:ClearAllPoints()
	self:SetPoint("TOPLEFT",AuctionFrame,"TOPRIGHT", 0, -13)
	self:SetPoint("BOTTOMLEFT",AuctionFrame,"BOTTOMRIGHT",0,11)

	self:IconColumnTitle("Status")
	--self:oldHide()
	--self:Scan()
end

function AppraiserView:Hide()
	if self.oldHide then
		self:UpdateStatus()
		self:oldHide()
	end
end


-- Updates the status to show the time
function AppraiserView:UpdateStatus()
	if self.frame then
		self.updateTitle:SetText("LAST UPDATED:")
		self.updateTitle:SetFont(FONTBOLD,12)
		self.lastTimeStampReset = ZGV.db.realm.LastScan
		self.timestamp:Show()

		-- moved over to GoldUI as ScanButton_OnUpdate.
		--[[
		if ZGVG.Scan.state~="SS_IDLE" or Appraiser.manualScanning then
			self.scanBut:SetText("|c88888888Scanning...")
			self.scanBut.tooltip = "Auction scan is underway. Please wait."
			self.scanBut.soft_disabled=true
		else
			if IsShiftKeyDown() then
				local canscan,delay = ZGVG.Scan:CanScanByName()
				if canscan then
					self.scanBut:SetText("|cFFFFFFFFSlow Scan")
					self.scanBut.tooltip = "Run a slow auction scan of the items shown.\nRelease |cff88ff00Shift|r to run a fast scan "..(ZGVG.Scan:CanScanFast() and "|cffff0000(not available!)|r" or "")
					self.scanBut.soft_disabled=false
				else
					self.scanBut:SetText("|cFF666666Slow Scan")
					self.scanBut.tooltip = ("|cffff0000Auction scan not possible now.\nPlease wait a few seconds."):format(delay)
					self.scanBut.soft_disabled=true
				end
			else
				local canscan,delay = ZGVG.Scan:CanScanFast()
				if canscan then
					self.scanBut:SetText("|cFFFFFFFFScan")
					self.scanBut.tooltip = "Run a fast auction scan.\nHold |cff88ff00Shift|r to force a slow scan of the items shown."
					self.scanBut.soft_disabled=false
				else
					self.scanBut:SetText("|cFF666666Scan")
					self.scanBut.tooltip = ("|cffff0000Auction scan not possible now, please wait ~%d minutes.|r\nHold |cff88ff00Shift|r to force a slow scan instead."):format(delay)
					self.scanBut.soft_disabled=true
				end
			end
		end
		if self.scanBut:IsMouseOver() then self.scanBut:GetScript("OnEnter")(self.scanBut) end
		--]]
	end
end

-- TODO IN PROGRESS: Rewriting tabs to act like the MailboxUI tabs.
-- IE, as separate windows that hide and show, rather than a single "morphing" window.
function AppraiserView:SetTab(tabName, auctionHouseHidden)
	--self:AddTab("Appraiser") -- Maybe someday, move tabs to GoldFrameBaseWidget.lua.
	if ZGVG.HelpPopup then ZGVG.HelpPopup:Next(tabName) end		-- Try to advance the popup if it is time.
	if tabName == "Appraiser" then
		Appraiser.activeTab = tabName
		self.toggleCol:SetToggle(false, true)
		self.appraiserTabText:SetTextColor(1,1,1)
		self.postTabText:SetTextColor(0.5,0.5,0.5)
		self.buyTabText:SetTextColor(0.5,0.5,0.5)
		self:IconColumnTitle("Status")
		self:SecondColumnTitle("Price")
		self:ButtonColumnTitle("Sell")
		self:ItemsColumnTitle("Auctionable Items")
		self.mainBut:Hide()
		refreshOnBagUpdate = true
		self.smartStacksCheckbox:Hide()
		if not auctionHouseHidden then
			ZGV.Gold.Appraiser:HighlightItem(0)
		end
	elseif tabName == "Post" then
		--Spoo(nil, nil, self)
		Appraiser.activeTab = tabName
		self.toggleCol:SetToggle(true, true)
		self.appraiserTabText:SetTextColor(0.5,0.5,0.5)
		self.postTabText:SetTextColor(1,1,1)
		self.buyTabText:SetTextColor(0.5,0.5,0.5)
		self.mainBut:SetText("Post")
		self.mainBut:Enable()
		self.mainBut.tooltip = nil
		self.mainBut:SetScript("OnClick",function()  Appraiser:Post()  end)
		self:IconColumnTitle("Status")
		self:SecondColumnTitle("Price")
		self:ButtonColumnTitle("Sell")
		self:ItemsColumnTitle("Auctionable Items")
		Appraiser:UpdatePostText(self)
		refreshOnBagUpdate = true
		self.smartStacksCheckbox:Show()
		Appraiser:ManualScanPostedItems()

		AuctionFrameTab_OnClick(AuctionFrameTab3, "LeftButton", "", 3)
		--AuctionsButton_OnClick(self, "LeftButton")
		if not auctionHouseHidden then
			ZGV.Gold.Appraiser:HighlightItem(0)
		end
	elseif tabName == "Buy" then
		Appraiser.activeTab = tabName
		self.toggleCol:SetToggle(true, true)
		self.appraiserTabText:SetTextColor(0.5,0.5,0.5)
		self.postTabText:SetTextColor(0.5,0.5,0.5)
		self.buyTabText:SetTextColor(1,1,1)
		self.mainBut:SetText("Buy")
		self.mainBut:Enable()
		self.mainBut.tooltip = nil
		self.mainBut:SetScript("OnClick",function(_, button, down)
			-- AUCTION_ITEM_LIST_UPDATE
			local itemName, itemLink, itemRarity, itemLevel, _, itemType, itemSubType = GetItemInfo(Appraiser.buyItemList[1].itemInfo[1])
			
			-- Don't bother with a new query if you don't know what the item is . . .
			if itemName then

				QueryAuctionItems(itemName)
				
				--ZGV:DelayedRun("AUCTION_ITEM_LIST_UPDATE", function(self)
				--	Appraiser:GetAuctionsInfo(itemName)
				--end)
			end
			SetSelectedAuctionItem("list", 1)
			local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo =  GetAuctionItemInfo("list",1)
			
			
			-- For now, just simulate a buy.
			if Appraiser.totalAuctionItemsByID[Appraiser.buyItemList[1].itemid] and Appraiser.totalAuctionItemsByID[Appraiser.buyItemList[1].itemid] > 0 then
				Appraiser.totalAuctionItemsByID[Appraiser.buyItemList[1].itemid] = Appraiser.totalAuctionItemsByID[Appraiser.buyItemList[1].itemid] - 1
			end
						
			Appraiser:RefreshBuyUI(self)
			
			-- Do an actual buy if right clicked.
			if button == "RightButton" then
				if buyoutPrice and buyoutPrice > 0 and Appraiser.buyItemList[1].toggled then
					PlaceAuctionBid("list",1,buyoutPrice)
				end
			end
		end)
		
		self:IconColumnTitle("Deals")
		self:SecondColumnTitle(" ")
		self:ButtonColumnTitle("Buy")
		self:ItemsColumnTitle("Items")
		refreshOnBagUpdate = true
		self.smartStacksCheckbox:Hide()
		AuctionFrameTab_OnClick(AuctionFrameTab1, "LeftButton", "", 3)		
		--Appraiser:RescanBuyItem()
		if not auctionHouseHidden then
			-- Disabled for now; highlights an item in the "Buy" tab. ~~Jeremiah
			--ZGV.Gold.Appraiser:HighlightItem(1)
--			Appraiser:RescanAllBuyItems(1)
		end
	else
		error("SetTab: Unknown tab name:"..tabName)
	end
	self:RefreshUI()
end

function AppraiserView:RefreshUI()
	if self.auctionHouseOpen == false then return end -- Don't even bother if auction house is closed.

	if ZGV.Gold.FUI then ZGV.Gold:Update() end

	
	if Appraiser.activeTab == "Appraiser" then

		-- Load items into Appraiser list
		local appraiserItemList = self:LoadItemsIntoAppraiser()
		
		-- Get them sorted!
		appraiserItemList = Appraiser:ListSort(appraiserItemList)
		
		-- Remove existing items from UI
		for itemid, item in pairs(self.itemIdList) do
			self:RemoveItem(itemid)
		end
		
		-- Fill with new items
		for _, item in pairs(appraiserItemList) do
			if Appraiser:AuctionWorthy(item.itemid) then
				self:AddItem(item, nil, nil, "?")
				--Spoo(nil, nil, self)
	
				if item.toggle:IsChecked() then
					self:ItemButtonTooltip(item.itemid, "Remove from Post")
				else
					self:ItemButtonTooltip(item.itemid, "Add to Post")
				end
			end
			
			-- And take the opportunity to set the correct price.
			self:UseAlternateItemCount(item.itemid, true)
		end

		self:UpdateStatus()
		
	elseif Appraiser.activeTab == "Post" then
		Appraiser:RefreshPostUI(self)
	elseif Appraiser.activeTab == "Buy" then
		Appraiser:RefreshBuyUI(self)
	else
		error("RefreshUI: Unknown tab name.")
	end
end

-- Track items that are posted.
Appraiser.postItemList = {}

-- This list contains frames, and frames should be recycled, and having the list as local was causing issues  . . .
Appraiser.appraiserItemList = {}
Appraiser.appraiserItemListByID = {}

-- Returns created list.
function AppraiserView:LoadItemsIntoAppraiser()
	local appraiserItemList = Appraiser.appraiserItemList or {}
	for bag=0, NUM_BAG_SLOTS do
		for slot=1, GetContainerNumSlots(bag) do
			local newItem = self:createUIItem(bag, slot)
			if newItem ~= nil then
				tinsert(appraiserItemList, newItem)
				Appraiser.appraiserItemListByID[newItem.itemid] = newItem
				--Appraiser.postItemList[newItem.itemid] = nil
			end
		end
	end
	appraiserItemList = Appraiser:ListSort(appraiserItemList)
	return appraiserItemList
end

-- Creates a UI item from an item in the bags.
function AppraiserView:createUIItem(bag, slot)
	local itemid=GetContainerItemID(bag,slot)

	if not ZGVG.Scan.data then error("Item will have nil price.") end
	
	if itemid and Appraiser:AuctionWorthy(itemid) and not ZGV:isSoulbound(bag, slot) and not Appraiser.appraiserItemListByID[itemid] then
		local stackSize, numStacks = Appraiser:getStackInfo(itemid)
		--Spoo(nil, nil, self)
		if ZGVG.Scan:GetPrice(itemid) > 0 then
			--if itemid==82280 then print(ZGV.GetMoneyString(ZGVG.Scan:GetPrice(itemid)*numStacks*stackSize, 0, "nocolor").."X") end
			--print(ZGV.GetMoneyString(ZGVG.Scan:GetPrice(itemid)*numStacks*stackSize, 0, "nocolor"))
			self:UpdateSecText(itemid,ZGV.GetMoneyString(Appraiser:GetSellPrice(itemid, numStacks, stackSize), 0, "nocolor"), nil, true)
			--print("1:"..itemid)
			ZGV.tempAltFrames.InventoryFrame:UpdateSecText(itemid,ZGV.GetMoneyString(Appraiser:GetSellPrice(itemid, numStacks, stackSize), 0, "nocolor"), true)
		else
			itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice, Z = cachedGetItemInfo(itemid)
			
			--if itemid==82280 then print(itemName.." "..itemSellPrice.." x "..vendorMarkup) end
			self:UpdateSecText(itemid,ZGV.GetMoneyString(itemSellPrice*vendorMarkup, 0, "nocolor"))
			--print(itemid)
			ZGV.tempAltFrames.InventoryFrame:UpdateSecText(itemid,ZGV.GetMoneyString(itemSellPrice*vendorMarkup, 0, "nocolor"))
			--self:UpdateSecText(itemid,"No data")
		end

		--ZGV.Gold.chores.route[#].items[#][1] -- ID of item
		--ZGV.Gold.chores.route[#].items[#][2] -- Amount of item player is expected to collect?
		--ZGV.Gold.chores.route[#].items[#]["demand"]
		--ZGV.Gold.chores.route[#].items[#]["price"]
		--ZGV.Gold.chores.route[#].items[#]["scale"]
		--ZGV.Gold.chores.route[#].items[#]["stable"]
		
		-- Get information about chore items, sort by ID.
		local choreItemInfoById = {}
		local newItem
		--ZGV.Gold:Update()
		
		--Spoo(nil, nil, ZGV.Gold.servertrends.items)
		local newIconText = ""
		local newIconTooltip = ""
		
		if ZGV.Gold.servertrends and ZGV.Gold.servertrends.items[itemid] then
			local highPrice = ZGV.Gold.servertrends.items[itemid].p_hi
			local lowPrice = ZGV.Gold.servertrends.items[itemid].p_lo
			local currentPrice = ZGV.Gold.Scan:GetPrice(itemid)
	
			if currentPrice > 0 then
				if currentPrice > highPrice then
					newIconText = "|cff00ff00↑"
					newIconTooltip = "Prices are up, sell now!"
				elseif currentPrice < lowPrice then
					newIconText = "|cffff0000↓"
					newIconTooltip = "Prices are down, you may want to wait"
				else
					newIconText = "|cffffff00●"
					newIconTooltip = "Prices are normal"
				end
			else
				newIconText = "|cFFAAAAAA?"
				newIconTooltip = "No scanner data for item"
			end
		else
			newIconText = "|cFFAAAAAA●"
			newIconTooltip = "No trend data for item"
		end
		
		self:UpdateIconText(itemid, newIconText)
		
		-- TODO: Should be moved to GoldFrameBaseWidget.lua? But then we can't use GetContainerItemLink - how to resolve?
		local battlePedID
		local battlePetName
		if itemid == 82800 then -- Battle pet found, need extra processing. 
			--print(GetContainerItemLink(bag, slot))
			--print(gsub(GetContainerItemLink(bag, slot), "\124", "\124\124"))
			local _, _, Color, Ltype, Id, Level, Unknown1, Health, Power, Speed, Suffix, Unique, Name = string.find(GetContainerItemLink(bag, slot), 
			"|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(0x%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
			battlePedID = Id
			battlePetName = Name
			--print(Name)
			--Spoo(nil, nil, newItem)
			--newItem.descText:SetText(Name)
		end
		
		newItem = self:AddItem(itemid, nil, nil, newIconText, battlePedID, battlePetName)
		
		ZGV.tempAltFrames.InventoryFrame:AddItem(itemid, nil, nil, newIconText, battlePedID, battlePetName)
		
		self:IconTooltip(itemid, newIconTooltip)

		self:SetItemCount(itemid)	
		
		if ZGV.db.profile.smartstack then --  and Appraiser.activeTab == "Post"
			local stackSize, numStacks, floodLimitedTotal, totalItems = Appraiser:getStackInfo(itemid)
			if totalItems == 0 or stackSize > Appraiser:getItemCount(itemid) then
				-- Don't set the item count if it's 0 or larger than the number of items the player has.
			else
				self:SetItemCount(itemid, totalItems, floodLimitedTotal)
			end
		end
		
		self:SetCallbackOnItem(itemid, function()

			if Appraiser.activeTab == "Appraiser" then
				if newItem.toggle:IsChecked() then
					Appraiser:addItemToList("post", newItem)
					self:ItemButtonTooltip(itemid, "Remove from Post")
				else
					--Spoo(nil, nil, newItem)
					ZGV.tempAltFrames.PostFrame:RemoveItem(newItem.itemid)
					Appraiser:removeItemFromList2("post", newItem)
					self:ItemButtonTooltip(itemid, "Add to Post")
				end
				
			else
				--Appraiser:addItemToList("appraiser", newItem)
				ZGV.tempAltFrames.PostFrame:RemoveItem(newItem.itemid)
				Appraiser:removeItemFromList2("post", newItem)
				self:RemoveItem(itemid)
			end
			
		end)
		self:addDragStartCallbackToItem(itemid, function()
			if itemLocked == false then
				PickupContainerItem(bag, slot)
			end
		end)
		self:addDragStopCallbackToItem(itemid, function()
			-- Can't set the price on the same OnUpdate, as Blizzard
			-- will set it. Wait for the next OnUpdate to update.
			nextUpdateItemID = itemid
			nextUpdateSetStartingPrice = ZGVG.Scan:GetPrice(itemid)
			nextUpdateSetBuyoutPrice = ZGVG.Scan:GetPrice(itemid)
		end)
		newItem:SetScript("OnEnter",function()
			GameTooltip:SetOwner( self.frame, "ANCHOR_RIGHT")
			GameTooltip:SetBagItem(bag, slot)
			GameTooltip:Show()
		end)
		newItem:SetScript("OnLeave",function()
			GameTooltip:FadeOut()
		end)
		
		--self:ItemButtonTooltip(item, "Add to Post")
		
		return newItem
	end
end

--[[
ZGV:DelayedRun("AUCTION_ITEM_LIST_UPDATE", function()
	--print(type(AuctionFrameBrowse_Update))
	local OLD_AuctionFrameBrowse_Update = AuctionFrameBrowse_Update
	AuctionFrameBrowse_Update = function()
		--Appraiser:HighlightItem(0)
		OLD_AuctionFrameBrowse_Update()
	end
end)
--]]

local lastHighlightIndex = nil
local backFrame
local backFrameTexture

local function GetAuctionsInfoFinished(...)
	--Spoo(nil, nil, {...})
	--self.UpdateIconText(self, itemid, ""..Appraiser.totalAuctionItemsByID[itemid])
end

ZGV:RegisterMessage("DELAYED_RUN_RETURN",GetAuctionsInfoFinished)
--ZGV:RegisterMessage("GET_AUCTIONS_INFO_FINISHED",GetAuctionsInfoFinished)

-- Creates an item for the Buy list from an itemid.
function Appraiser:CreateBuyItem(appraiserView, itemid)
	--Spoo(nil, nil, appraiserView)
	newItem = appraiserView:AddItem(itemid, countSum)
	newItem.toggle:SetToggle(true) -- Default set to buy
	newItem.itemInfo = {GetItemInfo(itemid)}
	tinsert(Appraiser.buyItemList, newItem)
	Appraiser.buyItemListByID[itemid]=newItem


	-- Do this commented out stuff in RefreshBuyUI
	
	-- Query for new item.
	local itemName, _, itemRarity, itemLevel, minItemLevel, itemType, itemSubType = cachedGetItemInfo(itemid)
	--print("Level: "..itemLevel.." MinLevel: "..minItemLevel)
	
	appraiserView:SetClickCallbackOnItem(itemid, function()
		Appraiser:RefreshAndHighlightItems(itemid)
		BrowseName:SetText(itemName)
	end)
	
	QueryAuctionItems(itemName)

	--ZGV.Gold.Appraiser:DelayedRun("AUCTION_ITEM_LIST_UPDATE", function()
	--	print("RUN")
	--	Appraiser:GetAuctionsInfo()
	--end)
	
	--Appraiser:DelayedRun("AUCTION_ITEM_LIST_UPDATE", function(self, itemid)
	--	--print("?"..itemid)
	--	if not Appraiser.totalAuctionItemsByID[itemid] then
	--		_, Appraiser.totalAuctionItemsByID[itemid]=GetNumAuctionItems("list")
	--	end
	--	self.UpdateIconText(self, itemid, ""..totalAuctionItemsByID[itemid])
	--end, itemid)
	return newItem
end

ZGV.tempAltFrames = {} -- temporary, eventually move everything into Appraiser and stop letting Appraiser itself be a frame.

function AppraiserView:CreateAppraiserView()
	local ui = ZGV.UI
	local SkinData = ui.SkinData

	local F = CHAIN(ui:Create("GoldFrameBaseWidget",UIParent, "ZygorAppraiser"))
		:SetPoint("CENTER")
		:SetTitle("Zygor Appraiser")
		:ItemsColumnTitle("Auctionable Items")
		:SecondColumnTitle("Price")
		:ButtonColumnTitle("Sell")
		:SetScript("OnUpdate",function(self,elapsed)
			--TODO throttle this so it isn't updated constantly. Maybe only every few seconds
			self:UpdateTimeStamp()
			self:UpdateStatus()
		end)
	.__END
	
	-- TABS ----------------------------------------------------------------
	ZGV.tempAltFrames.InventoryFrame = 
		CHAIN(ui:Create("GoldFrameBaseWidget",UIParent, "ZygorInventoryFrame"))
		:SetPoint("CENTER")
		:SetTitle("Zygor Inventory")
		:ItemsColumnTitle("Auctionable Items")
		:SecondColumnTitle("Price")
		:ButtonColumnTitle("Sell")
		:SetScript("OnUpdate",function(self,elapsed)
			--TODO throttle this so it isn't updated constantly. Maybe only every few seconds
			--self:UpdateTimeStamp()
		end)
		:Hide()
	.__END
	ZGV.tempAltFrames.InventoryFrame:IconColumnTitle("Status")

	ZGV.tempAltFrames.PostFrame = CHAIN(ui:Create("GoldFrameBaseWidget",UIParent, "ZygorPostFrame"))
		:SetPoint("CENTER")
		:SetTitle("Zygor Post")
		:ItemsColumnTitle("Auctionable Items")
		:SecondColumnTitle("Price")
		:ButtonColumnTitle("Sell")
		:SetScript("OnUpdate",function(self,elapsed)
			--TODO throttle this so it isn't updated constantly. Maybe only every few seconds
			--self:UpdateTimeStamp()
		end)
		:Hide()
	.__END 
	ZGV.tempAltFrames.PostFrame:IconColumnTitle("Status")
	
	ZGV.tempAltFrames.BuyFrame = CHAIN(ui:Create("GoldFrameBaseWidget",UIParent, "ZygorBuyFrame"))
		:SetPoint("CENTER")
		:SetTitle("Zygor Buy")
		:ItemsColumnTitle("Items")
		:SecondColumnTitle("")
		:ButtonColumnTitle("Buy")
		:SetScript("OnUpdate",function(self,elapsed)
			--TODO throttle this so it isn't updated constantly. Maybe only every few seconds
			--self:UpdateTimeStamp()
		end)
			:Hide()
	.__END 
	------------------------------------------------------------------------

	
	--F.stacksToggle:SetToggle(true) -- After so that .MyToggle gets ran. MyToggle is gone.

	F.title:Hide()

	F.appraiserTabText = CHAIN(F:CreateFontString())
		:SetPoint("TOPLEFT",5,-5)
		:SetFont(FONT,14)
		--:SetTextColor(0.4,0.4,0.4)
		:SetText("Inventory")
		:Show()
	.__END

	F.appraiserTabButton = CHAIN(CreateFrame("Button", nil, F))
		:SetPoint("TOPLEFT",F.appraiserTabText,"TOPLEFT")
		:SetPoint("BOTTOMRIGHT",F.appraiserTabText,"BOTTOMRIGHT")
		:SetScript("OnClick", function(self) self:GetParent().SetTab(self:GetParent(), "Appraiser") end)
		:Show()
	.__END

	F.postTabText = CHAIN(F:CreateFontString())
		:SetPoint("TOPLEFT",110,-5)
		:SetFont(FONT,14)
		:SetTextColor(0.5,0.5,0.5)
		:SetText("Post")
		:Show()
	.__END

	F.postTabButton = CHAIN(CreateFrame("Button", nil, F))
		:SetPoint("TOPLEFT",F.postTabText,"TOPLEFT")
		:SetPoint("BOTTOMRIGHT",F.postTabText,"BOTTOMRIGHT")
		:SetScript("OnClick", function(self)
			-- TODO: Why did I need GetParent?
			--Spoo(nil, nil,self:GetParent()) 
			self:GetParent().SetTab(self:GetParent(), "Post")
		end)
		:Show()
	.__END
	
	F.buyTabText = CHAIN(F:CreateFontString())
		:SetPoint("TOPLEFT",170,-5)
		:SetFont(FONT,14)
		:SetTextColor(0.5,0.5,0.5)
		:SetText("Buy")
		:Show()
	.__END

	F.buyTabButton = CHAIN(CreateFrame("Button", nil, F))
		:SetPoint("TOPLEFT",F.buyTabText,"TOPLEFT")
		:SetPoint("BOTTOMRIGHT",F.buyTabText,"BOTTOMRIGHT")
		:SetScript("OnClick", function(self) self:GetParent():SetTab("Buy") end)
		:Show()
	.__END

	if ZGV.DEV then
		F.debugmenu = CreateFrame("FRAME","ZGVGoldAppraiserDebugMenu",F,"UIDropDownMenuTemplate")

		F.debugButton = CHAIN(CreateFrame("Button", nil, F, "UIPanelButtonTemplate"))
		:SetPoint("BOTTOMRIGHT",F,"TOPRIGHT",0,0)
		:SetScript("OnClick", function(self)
			local tab = Appraiser.activeTab
			if tab=="Buy" then
				UIDropDownMenu_SetAnchor(F.debugmenu, 0, 0, "TOP", self, "BOTTOM")

				F.debugmenu.displayMode = "MENU"

				local menu={}

				tinsert(menu,{
					text = "blah", func=error, notCheckable=true,
					})

				EasyMenu(menu,F.debugmenu,0,0,"MENUUU",10)
				UIDropDownMenu_SetWidth(F.debugmenu, 200)
			end
		end)
		:SetSize(60,15)
		:SetText("DEBUG")
		:Show()
		.__END
	end

	Appraiser.activeTab = "Appraiser"
	--refreshOnBagUpdate = true


	--[[
		-- moved over to GoldUI into CreateScanButton
	CHAIN(F.scanBut)
		:SetText("|cFF888888Scan")
		:SetScript("OnClick",function(self) if self.soft_disabled then return end Appraiser:Scan(Appraiser:getCurrentView(),(IsShiftKeyDown() and "force slow"),F.items) end)
		:SetScript("OnEnter",function(self) CHAIN(GameTooltip):SetOwner(self, "ANCHOR_BOTTOM") :SetText(type(self.tooltip)=="function" and self:tooltip() or tostring(self.tooltip)) :Show() end)
		:SetScript("OnLeave",function(self) GameTooltip:Hide() end)
	--]]
	

	CHAIN(F.mainBut)
		:SetText("|cFF888888Buy")
		--:SetScript("OnClick",function() Appraiser:Scan(Appraiser:getCurrentView()) end)
		:SetScript("OnEnter",function(self) CHAIN(GameTooltip):SetOwner(self, "ANCHOR_BOTTOM") :SetText(type(self.tooltip)=="function" and self:tooltip() or tostring(self.tooltip)) :Show() end)
		:SetScript("OnLeave",function(self) GameTooltip:Hide() end)

	-- Footer
	F.tex = CHAIN(F:CreateTexture(nil,"ARTWORK"))
		:SetPoint("BOTTOMLEFT",5,5)
		:SetTexture(ZGV.DIR.."\\Skins\\Default\\Stealth\\titlebuttons")
		:SetTexCoord(16/32,17/32,2/4,3/4)
		:SetSize(15,15)
	.__END

	F.updateTitle = CHAIN(F:CreateFontString())
		:SetPoint("LEFT",F.tex,"RIGHT",5,0)
		:SetFont(FONTBOLD,12)
		:SetText("LAST UPDATED:")
	.__END

	F.timestamp = CHAIN(F:CreateFontString())
		:SetPoint("LEFT",F.updateTitle,"RIGHT",5,0)
		:SetFont(FONT,12)
		:SetText("no time")
	.__END
	
	F.smartStacksCheckbox = CHAIN(ui:Create("ToggleButton",F.mainBut))
		:SetPoint("LEFT",F.mainBut,"RIGHT",-260,-1)
		:SetText("Smart stacks")
		:SetParent(F.mainBut)
		:SetToggle(ZGV.db.profile.smartstack)
		:Hide()
	.__END
	
	F.progressFrame = CHAIN(CreateFrame("Frame","progressFrame",F))
		:SetBackdrop(SkinData("ProgressBarBackdrop"))
		:SetBackdropColor(unpack(SkinData("ProgressBarBackdropColor")))
		:SetBackdropBorderColor(unpack(SkinData("ProgressBarBackdropBorderColor")))
		:SetSize(F:GetWidth(),7)
		:SetHeight(SkinData("ProgressBarHeight"))
		:SetFrameStrata("HIGH")
		:SetFrameLevel(3)
		:SetPoint("TOP",F,"BOTTOM",0,0)
		:Show()
	.__END
	
	F.progressFrame.tex = CHAIN(F.progressFrame:CreateTexture())
		:SetHeight(SkinData("ProgressBarHeight")-2)
		:SetPoint("TOPLEFT",F.progressFrame,"TOPLEFT",1,-1)
		:SetTexture(unpack(SkinData("ProgressBarTexture")))
		:SetVertexColor(unpack(ZGV.CurrentSkinStyle:SkinData("ProgressBarColor") or {0,1,0,1}))
		--:SetFrameStrata("HIGH")
		--:SetFrameLevel(3)
		--:Show()
	.__END 
	
	F.progressFrame.SetPercent = function(self, percent)
		self.tex:SetWidth((percent / 100)*(self:GetWidth()-2))
	end
	
	F.goldGuideButton = CHAIN(CreateFrame("Button", "GoldGuideButton" , F))
		:SetSize(25,25)
		:SetPoint("CENTER", F, "TOPRIGHT", -14, -12)
		:SetNormalTexture(ZGV.DIR.."\\Skins\\guideicons-big")
		:SetScript("OnClick", function() ZGV.Gold:Show() end)
		:Show()
	.__END
	
	F.goldGuideButton:SetScript("OnEnter",function()
		GameTooltip:SetOwner(F.goldGuideButton, "ANCHOR_CURSOR")
		GameTooltip:AddLine("Open Gold Guide")
		GameTooltip:Show()
	end)
	
	F.goldGuideButton:SetScript("OnLeave",function()
		GameTooltip:FadeOut()
	end)
	
	--F.goldGuideButton:GetHighlightTexture():SetTexCoord(2/4,3/4,1/4,2/4)
	F.goldGuideButton:GetNormalTexture():SetTexCoord(0/4,1/4,1/4,2/4)

	
	F.smartStacksCheckbox:RegisterOnEnterCallback(function()
		GameTooltip:SetOwner(F.smartStacksCheckbox, "ANCHOR_CURSOR")
		GameTooltip:AddLine("Dynamically set the best stack size and amount posted")
		GameTooltip:Show()
	end)
	F.smartStacksCheckbox:RegisterOnLeaveCallback(function()
		GameTooltip:FadeOut()
	end)
	
	F.smartStacksCheckbox:RegisterToggleCallback(function()
		ZGV.db.profile.smartstack = F.smartStacksCheckbox:IsChecked() -- now cleaner with a one-liner! :) ~~sinus
	end)

	-- Can only parent the collapse widget when the Auction House is showing.	
	ZGV:DelayedRun("AUCTION_HOUSE_SHOW", function() F:EnableCollapse(AuctionFrame) end)

	F.toggleCol:RegisterToggleCallback(function()
	
		if F.toggleCol:IsChecked() then 
			local appraiserItemList = F:LoadItemsIntoAppraiser()
			
			-- Add if going from unchecked to checked.
			for index, item in pairs(appraiserItemList) do
				if Appraiser.activeTab == "Post" then
					Appraiser:RefreshPostUI()
				else
					Appraiser:addItemToList("post", item)
				end
			end
		else
			local appraiserItemList = F:LoadItemsIntoAppraiser()
			
			-- Remove if going from checked to unchecked.
			for index, item in pairs(appraiserItemList) do
				Appraiser:removeItemFromList2("post", item)
				if Appraiser.activeTab == "Post" then
					Appraiser:RefreshPostUI(Appraiser:getCurrentView())
				end
			end
		end
	end)

	F:RegisterEvent("MODIFIER_STATE_CHANGE")
	F:SetScript("OnEvent",function(self,event)
		ZGV:Debug("&gold "..event)
		if event=="MODIFIER_STATE_CHANGE" then
			AppraiserView:UpdateStatus()
		end
	end)
	
	F.oldShow = F.Show
	F.oldHide = F.Hide
	
	for f,fun in pairs(self) do
		F[f]=fun
	end

	F:UpdateTimeStamp()
	
	F:ClearAllPoints()
	F:SetPoint("TOPLEFT",AuctionFrame,"TOPRIGHT", 0, -13)
	F:SetPoint("BOTTOMLEFT",AuctionFrame,"BOTTOMRIGHT",0,11)

	F:IconColumnTitle("Status")
	
	F.nextUpdateSetStartingPrice = 0
	F.nextUpdateItemID = nil
	
	return F
end

if ZGV.UseUnitTesting then
	tinsert(ZGV.startups, function()
		ZGV.StartAppraiserTest()
	end)
end
