local ZGV = ZygorGuidesViewer
if not ZGV then return end

local tinsert,tremove,print,ipairs,pairs,wipe,debugprofilestop,yield,resume=tinsert,tremove,print,ipairs,pairs,wipe,debugprofilestop,coroutine.yield,coroutine.resume

local FONT=ZGV.Font
local FONTBOLD=ZGV.FontBold
local L = ZGV.L
local CHAIN = ZGV.ChainCall
local cachedGetItemInfo = ZGV.cachedGetItemInfo

local ui = ZGV.UI

local GREEN = "|cff00ff00"
local RED = "|cffff0000"

local DEFAULT_WIDTH = 325

-- TODO maybe this shouldn't be in Gold.. Should probably be with IM stuff but IM scares me.
local ZGVG=ZGV.Gold
Mail = {}
ZGVG.Mail = Mail

local profile = {} -- Profile not available yet.

local altNames = {}

local earnedMoney = 0

-- Current valid states are:
-- sleeping (mailbox closed)
-- waiting (mailbox open, system idle)
-- collecting (collecting items and money from inbox)
-- sending (putting items in a message to send)
-- sent (message sent, waiting for MAIL_SUCCESS or MAIL_FAILED)
local mailState = "sleeping"

-- items attached to mail to be sent.
local attachedItems = {}

local ignoreLastItem = false

-- OOP style is kinda wacky in this file.... You have been warned.

-- Eliminate duplication, ensure consistency.
local function repopulateAll()
	CheckInbox()
	Mail:PopulateMeWithItems(Mail.collector)
	Mail:PopulateSenderItems(Mail.sender, SellWorthy)
end

tinsert(ZGV.startups,function(self)
	Mail:Toggle()
	
	if not ZGV.db.factionrealm.altNames then
		ZGV.db.factionrealm.altNames = {}
	end
	
	altNames = ZGV.db.factionrealm.altNames
	
	-- Always add self to alt names list.
	altNames[UnitName("player")]=UnitName("player")
	
	-- Swap collector, sender when user clicks on a mail tab.
	-- Blizzard function securely hooked.
	hooksecurefunc("MailFrameTab_OnClick",function(_, tab)
		if tab == 1 and ZGV.Gold.Mail.collector then
			ZGV.Gold.Mail.collector:Show()
			ZGV.Gold.Mail.sender:Hide()
			--ZGV.Gold.Mail.sender.suggestBox2:Hide()
		elseif ZGV.Gold.Mail.collector then
			ZGV.Gold.Mail.collector:Hide()
			ZGV.Gold.Mail.sender:Show()
			--ZGV.Gold.Mail.sender.suggestBox2:Show()
		end
		repopulateAll()
	end)
	
	profile = ZGV.db.profile
	if not profile["Mail"] then
		profile["Mail"] = {}
	end
	
	if not profile["Mail"].previousNames then
		profile["Mail"].previousNames = {}
	end
	--MailFrameTab_OnClick
	
	-- Make sure we have the latest friends list info from server.
	ShowFriends()

end)

local function OnEvent(self,event,...)
	if event == "MAIL_SHOW" then
		if ZGV.db.profile.mail_enable then
			if not Mail.collector then Mail:CreateCollector() end
			if not Mail.sender then Mail:CreateSender() end

			Mail:Show()
			Mail.collector:Show()
			Mail.sender:Hide()
	
			repopulateAll()
			mailState="waiting"
		end
	elseif event == "MAIL_INBOX_UPDATE" then
		if mailState=="collecting" then
			--Mail:CollectLastItem()
		else
			-- Don't use repopulateAll() - it calls CheckInbox,
			-- which triggers MAIL_INBOX_UPDATE immediately and
			-- overflows the stack with recursion
			Mail:PopulateMeWithItems(Mail.collector)
			Mail:PopulateSenderItems(Mail.sender, SellWorthy)
		end
		
		-- Hide mail icon if there's no more mail.
		-- Oddly enough, this fixes a Blizzard bug where the envelope doesn't disappear when returning items as well . . .
		-- Hopefully, this won't break anything by being in a common event?
		if GetInboxNumItems() == 0 then
			MiniMapMailFrame:Hide() -- Hide mail icon
		end
	elseif event == "MAIL_CLOSED" then
		Mail:StopCollecting()
		mailState="sleeping"
	elseif event == "MAIL_SEND_SUCCESS" then
		ZGV:ScheduleTimer(function() 
			repopulateAll()
		end, 0.4)
	elseif event == "MAIL_SUCCESS" then

		wipe(attachedItems)
		repopulateAll()

		Mail.sender:ReduceItemsCount(attachedItems)

		-- Add player to list of known recipients if success.
		if profile["Mail"].lastRecipient and (not profile["Mail"].previousNames[profile["Mail"].lastRecipient]) then
			profile["Mail"].previousNames[profile["Mail"].lastRecipient]=profile["Mail"].lastRecipient
		end
		--profile["Mail"].lastRecipient
		Mail.collector.statusText:SetText("Items collected")
		if mailState=="sent" then mailState="sending" end

		if mailState=="collecting" and ignoreLastItem==false then -- Keep collecting if we succeed.
			Mail:CollectLastItem()
		else
			ignoreLastItem=false
		end
	
		-- For mailbox updates when not using the sender (manually sent items)
		--Mail:PopulateSenderItems(Mail.sender, SellWorthy)
	elseif event == "MAIL_FAILED" then
		repopulateAll()
		if mailState=="sent" then mailState="sending" end
		
		if mailState=="sending" then
			Mail.sender.statusText:SetText("Failure encountered while sending mail")
		else
			Mail.collector.statusText:SetText("Failure encountered while collecting mail")
		end

		-- Remove from list if, for some reason, you can't send to the other player.
		if profile["Mail"].previousNames[profile["Mail"].lastRecipient] then
			profile["Mail"].previousNames[profile["Mail"].lastRecipient]=nil
		end
		Mail:StopCollecting()

	elseif event == "UNIT_INVENTORY_CHANGED" then
		--print("UNIT_INVENTORY_CHANGED")
	end
end

local function OnUpdate(...)
	--if mailState=="collecting" and ignore then
	--	collectDelay=-1
	--	Mail:CollectLastItem()
	--elseif collectDelay > 0 then
	--	collectDelay=collectDelay-1
	--end
	
	if mailState=="sending" then
		Mail:SendItems()
	end
end

local function SellWorthy(itemID)

	if not ContainerItemID then return false end -- It must exist . . .
	
	local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = cachedGetItemInfo(itemID)
	
	-- Except this is the mailbox, not the auction house . . .
	--if vendorPrice == 0 then -- Vendor price being 0 is a sure sign this can't be auctioned. Don't even try.
	--	return false
	--end
	
	-- Include trade goods
	if class==L["type_trade_goods"] then
		return true
	end
	
	-- Exclude Gear
	--if class=="Weapon" or class=="Armor" then
	--	return false
	--end
	
	--print("name: "..name.." | class: "..class.." subclass: "..subclass)
	
	-- Include by default
	return true
end

-- Puts items in the inbox into the scrollie
function Mail:PopulateMeWithItems(me, filter)

	if not filter then filter=function() return true end end

	if not me then return end
	me:ClearItems() -- Clear items before we add more.

	local numItems = GetInboxNumItems()
	
	local moneyAmountByItemID = {}
	local moneyAmountByItemText = {} -- Because sometimes we don't have the ID . . .
	local itemInfo
	
	local earnedMoney = 0

	for mailId=1,numItems do
		local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, itemCount, wasRead, wasReturned, textCreated, canReply, isGM, itemQuantity = GetInboxHeaderInfo(mailId)

		local skipMail = false
		local auctionLink = GetInboxItemLink(mailId,1)
		
		_, _, auctionSuccessItemName, itemCountText = string.find(subject, "Auction successful: (.*) %((%d+)%)")
		if auctionSuccessItemName and itemCountText then
			itemCount = tonumber(itemCountText)
			itemInfo = {GetItemInfo(auctionSuccessItemName)}
			if itemInfo and itemInfo[2] then
				_, _, itemIDString = string.find(itemInfo[2], "item:(%d+)")
				itemid = tonumber(itemIDString)
				if moneyAmountByItemID[itemid] then
					moneyAmountByItemID[itemid] = moneyAmountByItemID[itemid] + money
				else
					moneyAmountByItemID[itemid] = money
				end
				-- Add item to list if needed.
				local item = me:AddItem("sold:"..itemid,itemCount)
				
				CHAIN(item.secText)
					:SetText(ZGV.GetMoneyString(moneyAmountByItemID[itemid], 0, "nocolor"))
					:SetPoint("RIGHT",item.toggle,"LEFT",-35,0)
	
				CHAIN(item.toggle)
					:SetToggle(true) -- Collect items by default
					:SetPoint("RIGHT",-20,0)
					
				earnedMoney = earnedMoney + money
				money = 0 -- Don't add this to the overall money count if we're showing it elsewhere.
			else
				if moneyAmountByItemText[auctionSuccessItemName] then
					moneyAmountByItemText[auctionSuccessItemName] = moneyAmountByItemText[auctionSuccessItemName] + money
				else
					moneyAmountByItemText[auctionSuccessItemName] = money
				end
				--Spoo(nil, nil, GetInboxItem(mailId,1))
				local item = me:AddItem("sold: "..auctionSuccessItemName,tonumber(itemCountText))

				CHAIN(item.secText)
					:SetText(ZGV.GetMoneyString(moneyAmountByItemText[auctionSuccessItemName], 0, "nocolor"))
					:SetPoint("RIGHT",item.toggle,"LEFT",-35,0)
	
				CHAIN(item.toggle)
					:SetToggle(true) -- Collect items by default
					:SetPoint("RIGHT",-20,0)

				earnedMoney = earnedMoney + money
				money = 0 -- Don't add this to the overall money count if we're showing it elsewhere.
			end
		end

		_, _, auctionExpiredItemName = string.find(subject, "Auction expired: (.*)")
		if auctionExpiredItemName then
			local link = GetInboxItemLink(mailId,1)
			if link then
				local name,tex,count = GetInboxItem(mailId,attId)
				local itemid = tonumber(link:match("item:(%d+)"))
				if moneyAmountByItemID[itemid] then
					moneyAmountByItemID[itemid] = moneyAmountByItemID[itemid] + money
				else
					moneyAmountByItemID[itemid] = money
				end
				
				-- Add item to list if needed.
				local item = me:AddItem("expired:"..itemid, count)
				if item then
					CHAIN(item.secText)
						--:SetText(ZGV.GetMoneyString(moneyAmountByItemID[itemid], 0, "nocolor"))
						:SetPoint("RIGHT",item.toggle,"LEFT",-35,0)
		
					CHAIN(item.toggle)
						:SetToggle(true) -- Collect items by default
						:SetPoint("RIGHT",-20,0)
				end
				earnedMoney = earnedMoney + money
				money = 0 -- Don't add this to the overall money count if we're showing it elsewhere.
				skipMail = true
			end
		end

		_, _, auctionCancelledItemName = string.find(subject, "Auction cancelled: (.*)")
		if auctionCancelledItemName then
			local link = GetInboxItemLink(mailId,1)
			if link then
				local name,tex,count = GetInboxItem(mailId,attId)
				local itemid = tonumber(link:match("item:(%d+)"))
				if moneyAmountByItemID[itemid] then
					moneyAmountByItemID[itemid] = moneyAmountByItemID[itemid] + money
				else
					moneyAmountByItemID[itemid] = money
				end
				
				-- Add item to list if needed.
				local item = me:AddItem("cancelled:"..itemid, count)
				if item then
					CHAIN(item.secText)
						--:SetText(ZGV.GetMoneyString(moneyAmountByItemID[itemid], 0, "nocolor"))
						:SetPoint("RIGHT",item.toggle,"LEFT",-35,0)
		
					CHAIN(item.toggle)
						:SetToggle(true) -- Collect items by default
						:SetPoint("RIGHT",-20,0)
				end
				earnedMoney = earnedMoney + money
				money = 0 -- Don't add this to the overall money count if we're showing it elsewhere.
				skipMail = true
			end
		end

		_, _, auctionWonItemName = string.find(subject, "Auction won: (.*)")
		if auctionWonItemName then
			local link = GetInboxItemLink(mailId,1)
			if link then
				local name,tex,count = GetInboxItem(mailId,attId)
				local itemid = tonumber(link:match("item:(%d+)"))
				if moneyAmountByItemID[itemid] then
					moneyAmountByItemID[itemid] = moneyAmountByItemID[itemid] + money
				else
					moneyAmountByItemID[itemid] = money
				end
				
				-- Add item to list if needed.
				local item = me:AddItem("won:"..itemid, count)
				if item then
					CHAIN(item.secText)
						--:SetText(ZGV.GetMoneyString(moneyAmountByItemID[itemid], 0, "nocolor"))
						:SetPoint("RIGHT",item.toggle,"LEFT",-35,0)
		
					CHAIN(item.toggle)
						:SetToggle(true) -- Collect items by default
						:SetPoint("RIGHT",-20,0)
				end
				earnedMoney = earnedMoney + money
				money = 0 -- Don't add this to the overall money count if we're showing it elsewhere.
				skipMail = true
			end
		end
		
		if money > 0 then
			earnedMoney = earnedMoney + money
			local item = me:AddItem("money",money)

			CHAIN(item.secText)
				:SetText(ZGV.GetMoneyString(item.count, 0, "nocolor"))
				:SetPoint("RIGHT",item.toggle,"LEFT",-35,0)

			CHAIN(item.toggle)
				:SetToggle(true) -- Collect items by default
				:SetPoint("RIGHT",-20,0)
		end		

		ZGV.Gold.Mail.collector.totalEarned:SetText(GetMoneyString(earnedMoney))

		-- attId sometimes 1 indexed sometimes 0?!?
		for attId=1, ATTACHMENTS_MAX_RECEIVE do
			local link = GetInboxItemLink(mailId,attId)
			if link and not skipMail then
				local itemid = tonumber(link:match("item:(%d+)"))
				if filter(itemid) then
					local name,tex,count = GetInboxItem(mailId,attId)
		
					local item = me:AddItem(itemid,count)
		
					CHAIN(item.secText)
						:SetText(ZGV.GetMoneyString(moneyAmountByItemID[itemid] or 0, 0, "nocolor"))
						:SetPoint("RIGHT",item.toggle,"LEFT",-35,0)

					CHAIN(item.toggle)
						:SetToggle(true) -- Collect items by default
						:SetPoint("RIGHT",-20,0)
				end
			end
		end
	end
end

-- Puts items in the inbox into the scrollie
function Mail:PopulateSenderItems(me, filter)
	--print("populating")
	if not filter then filter=function() return true end end

	if not me then return end
	me:ClearItems() -- Clear items before we add more.

	--print("populating success")
	
	for bag=0, NUM_BAG_SLOTS do
		for slot=1, GetContainerNumSlots(bag) do
			local item=GetContainerItemID(bag,slot)
			if item  then
				local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = cachedGetItemInfo(item)
				if filter(item) and not ZGV:isSoulbound(bag, slot) then
					local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag, slot)
					local item = me:AddItem(item,itemCount, true)
		
					-- Repoint a few things so that it fits this view. Properly.
					item.descText:SetPoint("RIGHT",item.toggle,"LEFT",-5,0)
					item.toggle:SetPoint("RIGHT",-15,0)
				end
			end
		end
	end
end

function Mail:CreateBase()
	self.base = CHAIN(CreateFrame("Frame", "Zygor_Mail_Base", MailFrame))
		:SetPoint("TOPLEFT",MailFrame,"TOPRIGHT")
		:SetPoint("BOTTOMLEFT",MailFrame,"BOTTOMRIGHT")
		:SetWidth(DEFAULT_WIDTH)

		:RegisterEvent("MAIL_SHOW")
		:RegisterEvent("MAIL_INBOX_UPDATE")
		:RegisterEvent("MAIL_CLOSED")
		:RegisterEvent("MAIL_FAILED")
		:RegisterEvent("MAIL_SUCCESS")
		:RegisterEvent("MAIL_SEND_SUCCESS")
		:RegisterEvent("UNIT_INVENTORY_CHANGED")
		:SetScript("OnEvent",OnEvent)
		:SetScript("OnUpdate",OnUpdate)
	.__END

	--self.base.colBut = CHAIN(ui:Create("Button",self.base))
	--	:SetPoint("BOTTOMLEFT",self.base,"TOPLEFT")
	--	:SetText("Collector")
	--	:SetScript("OnClick",function()
	--		self.collector:Show()
	--		self.sender:Hide()
	--	end)
	--.__END

	--self.base.sendBut = CHAIN(ui:Create("Button",self.base))
	--	:SetPoint("LEFT",self.base.colBut,"RIGHT")
	--	:SetText("Sender")
	--	:SetScript("OnClick",function()
	--		self.collector:Hide()
	--		self.sender:Show()
	--	end)
	--.__END
end

function Mail:CreateCollector()
	if not self.base then return end

	local F = CHAIN(ui:Create("GoldFrameBaseWidget",self.base, "Zygor_Mail_Collector"))
		:SetAllPoints()
		--:SetTitle("Zygor Mail Collector")
		:SetTitle("")
		:ItemsColumnTitle("Items")
		:SecondColumnTitle("Earned")
		:ButtonColumnTitle("Collect")
		:CanDrag()
	.__END

	CHAIN(F.secondColText)
		:ClearAllPoints()
		:SetPoint("RIGHT",F.togButColText,"LEFT",-15,0)

	F.settings:SetScript("OnClick",function() ZGV:OpenOptions("gold") end)
	F.close:SetScript("OnClick",function() Mail:Hide() end)

	F.collectorTabText = CHAIN(F:CreateFontString())
		:SetPoint("TOPLEFT",5,-5)
		:SetFont(FONT,14)
		:SetText("Collector")
		:Show()
	.__END

	F.collectorTabButton = CHAIN(CreateFrame("Button", nil, F))
		:SetPoint("TOPLEFT",F.collectorTabText,"TOPLEFT")
		:SetPoint("BOTTOMRIGHT",F.collectorTabText,"BOTTOMRIGHT")
		:SetScript("OnClick", function()
			Mail:SetTab("collector")
		end)
		:Show()
	.__END
	
	F.senderTabText = CHAIN(F:CreateFontString())
		:SetPoint("TOPLEFT",100,-5)
		:SetFont(FONT,14)
		:SetTextColor(0.5,0.5,0.5)
		:SetText("Sender")
		:Show()
	.__END

	F.senderTabButton = CHAIN(CreateFrame("Button", nil, F))
		:SetPoint("TOPLEFT",F.senderTabText,"TOPLEFT")
		:SetPoint("BOTTOMRIGHT",F.senderTabText,"BOTTOMRIGHT")
		:SetScript("OnClick", function()
			Mail:SetTab("sender")
		end)
		:Show()
	.__END

	CHAIN(F.mainBut)
		:SetText("Collect")
		:SetScript("OnClick",function() Mail:StartCollecting() end)

	F.earnedText = CHAIN(F.frame:CreateFontString())
		:SetPoint("BOTTOMLEFT",5,8.5)
		:SetFont(FONT,12)
		:SetText("Earned:")
	.__END

	F.totalEarned = CHAIN(F.frame:CreateFontString())
		:SetPoint("LEFT",F.earnedText,"RIGHT",5,0)
		:SetFont(FONT,12)
		:SetText(RED..GetMoneyString(0))
	.__END

	F.statusText = CHAIN(F.frame:CreateFontString())
		:SetPoint("BOTTOMLEFT",F.frame,"BOTTOMLEFT",5,-20)
		:SetFont(FONT,12)
		:SetText("")
		:Show()
	.__END

	F:EnableCollapse(MailFrame)
	
	F.toggleCol:SetToggle(true)
	
	self.collector = F
end

function Mail:SetTab(tab)
	assert(type(tab)=="string")
	
	if tab=="collector" then
		MailFrameTab_OnClick(self, 1) -- Blizzard function, sets the tab that shows.
	elseif tab == "sender" then

		MailFrameTab_OnClick(self, 2) -- Blizzard function, sets the tab that shows.
	else
		error("tab must be collector or sender")
	end
end

-- TODO: This isn't localized.
-- Does its best to get the most recent sender.
function getRecentSender()

	-- See if we have one stored already
	if profile["Mail"] and profile["Mail"].lastRecipient then
	
		-- Note that we are trying to avoid sending mail back to the auction house.
		if profile["Mail"].lastRecipient~="" and profile["Mail"].lastRecipient~="Auction House" then
			return profile["Mail"].lastRecipient
		end
	end

	-- Ask Blizzard's API	
	local lastOne, lastTwo, lastThree = GetLatestThreeSenders()

	if lastOne and lastOne~="" and lastOne~="Auction House" then return lastOne end
	if lastTwo and lastTwo~="" and lastTwo~="Auction House" then return lastTwo end
	if lastThree and lastThree~="" and lastThree~="Auction House" then return lastThree end

	-- When all else fails, return a blank string
	return ""
end

-- Returns a list of suggested names based on prefix.
function Mail:suggestNames(prefix)
	local namesList={}
	
	self.sender.suggestBox2:removeAllItems()
	
	-- Always add self to "previous" names: Allows collection of all of the
	-- player's alt names.
	profile["Mail"].previousNames[UnitName("player")]=UnitName("player")
	
	-- Alts
	
	for _, name in pairs(altNames) do
		if prefix==string.sub(name, 1, string.len(prefix)) then
			--print(name)
			tinsert(namesList, name)
			--Spoo(nil, nil, self)
			--self.sender.suggestBox:Add(name)
			self.sender.suggestBox2:addItem(name, function()
				Mail.sender.editBox:SetText(name)
				Mail.sender.suggestBox2:HideFrame()
			end)

		end
	end
	
	-- Previous names
	for _, name in pairs(profile["Mail"].previousNames) do
		if prefix==string.sub(name, 1, string.len(prefix)) 
		  and altNames[name]==nil then -- avoid duplication
			--print(name)
			tinsert(namesList, name)
			--Spoo(nil, nil, self)
			--self.sender.suggestBox:Add(name)
			self.sender.suggestBox2:addItem(name, function()
				Mail.sender.editBox:SetText(name)
				Mail.sender.suggestBox2:HideFrame()
			end)

		end
	end
	
	-- Friends
	local numFriends, onlineFriends = GetNumFriends()
	--print("--"..numFriends..","..onlineFriends)
	for index=1,numFriends do
		name = GetFriendInfo(index)
		--print(name)
		if prefix==string.sub(name, 1, string.len(prefix))
		  and altNames[name]==nil and profile["Mail"].previousNames[name]==nil then -- avoid duplication
			tinsert(namesList, name)
			--self.sender.suggestBox:Add(name)
			self.sender.suggestBox2:addItem(name, function()
				Mail.sender.editBox:SetText(name)
				Mail.sender.suggestBox2:HideFrame()
			end)
		end
	end
	-- Guild members

	-- Remove self and AH from list of recipents.
	namesList[UnitName("player")] = nil
	namesList["Auction House"] = nil
	
	return namesList
end

function Mail:CreateSender()
	if not self.base then return end

	local F = CHAIN(ui:Create("GoldFrameBaseWidget",self.base, "Zygor_Mail_Sender"))
		:SetAllPoints()
		--:SetTitle("Zygor Mail Sender")
		:SetTitle("")
		:ItemsColumnTitle("Items")
		:ButtonColumnTitle("Send")
		:CanDrag()
	.__END

	F.settings:SetScript("OnClick",function() ZGV:OpenOptions("gold") end)
	F.close:SetScript("OnClick",function() Mail:Hide() end)

	CHAIN(F.mainBut)
		:SetText("Send")
		:SetScript("OnClick",function() Mail:StartSending() end)

	local editLabel = CHAIN(F.frame:CreateFontString())
		:SetFont(FONTBOLD,13)
		:SetPoint("BOTTOMLEFT",5,9)
		:SetJustifyH("LEFT")
		:SetWidth(25)
		:SetText("To: ")
	.__END

	F.editBox = CHAIN(ui:Create("EditBox",F.frame))
		:SetSize(100,15)
		:SetPoint("LEFT",editLabel,"RIGHT",5,-1.5)
		--:SetScript("OnEnterPressed",function() print("You hit enter what do!?") end)
		:SetScript("OnTextChanged",function(self, isUserInput)
			if isUserInput then
				Mail.sender.suggestBox2:ShowAll()
				Mail:suggestNames(Mail.sender.editBox:GetText())
				-- update dropdown
			end
		end)
		:SetText(getRecentSender())
	.__END
	
	F.collectorTabText = CHAIN(F:CreateFontString())
		:SetPoint("TOPLEFT",5,-5)
		:SetFont(FONT,14)
		:SetTextColor(0.5,0.5,0.5)
		:SetText("Collector")
		:Show()
	.__END

	F.collectorTabButton = CHAIN(CreateFrame("Button", nil, F))
		:SetPoint("TOPLEFT",F.collectorTabText,"TOPLEFT")
		:SetPoint("BOTTOMRIGHT",F.collectorTabText,"BOTTOMRIGHT")
		:SetScript("OnClick", function()
			Mail:SetTab("collector")
		end)
		:Show()
	.__END
	
	F.senderTabText = CHAIN(F:CreateFontString())
		:SetPoint("TOPLEFT",100,-5)
		:SetFont(FONT,14)
		:SetText("Sender")
		:Show()
	.__END

	F.senderTabButton = CHAIN(CreateFrame("Button", nil, F))
		:SetPoint("TOPLEFT",F.senderTabText,"TOPLEFT")
		:SetPoint("BOTTOMRIGHT",F.senderTabText,"BOTTOMRIGHT")
		:SetScript("OnClick", function()
			Mail:SetTab("sender")
		end)
		:Show()
	.__END

	F.statusText = CHAIN(F.frame:CreateFontString())
		:SetPoint("BOTTOMLEFT",F.frame,"BOTTOMLEFT",5,-20)
		:SetFont(FONT,12)
		:SetText("")
		:Show()
	.__END

	-- broken right now
	-- Suggest friends as you type 
	
	--F.suggestBox2 = ui:Create("SuggestBox", F.frame)
	F.suggestBox2 = ZGV.SuggestBox:New()
	F.suggestBox2:ClearAllPoints()
	F.suggestBox2:SetPoint("TOPLEFT",F.editBox, "BOTTOMLEFT", 0, -5)
	F.suggestBox2:SetPoint("BOTTOMRIGHT",F.editBox, "BOTTOMRIGHT", 0, -70)
	F.suggestBox2:SetButtonPoint("TOPLEFT",F.editBox, "TOPRIGHT", 7, 0)
	--Spoo(nil, nil, F.suggestBox2)
	--Mail:suggestNames(Mail.sender.editBox:GetText())
	--F.suggestBox2:addItem("TEST", function()
	--	print("TEST")
	--end)
	--F.suggestBox2:addItem("TEST2", function()
	--	print("TEST2")
	--end)
	
	F:EnableCollapse(MailFrame)
	
	
	--F.suggestBox = CHAIN(ui:Create("DropDown",F.frame))
	--	--:SetSize(160, 160)
	--	:SetPoint("TOP",F.editBox,"BOTTOM")
	--.__END

	--F.scanBut:Hide()
	self.sender = F

	for _, name in pairs(altNames) do
		if name ~= UnitName("player") then
			F.suggestBox2:addItem(name, function()
				Mail.sender.editBox:SetText(name)
				Mail.sender.suggestBox2:HideFrame()
			end)
		end
	end
	
	for _, name in pairs(profile["Mail"].previousNames) do
		if altNames[name]==nil then -- avoid duplication
			F.suggestBox2:addItem(name, function()
				Mail.sender.editBox:SetText(name)
				Mail.sender.suggestBox2:HideFrame()
			end)
		end
	end
end

function Mail:StartCollecting()
	mailState="collecting"
	Mail:CollectLastItem() -- kick off the process
end


function Mail:StopCollecting()
	mailState="waiting"
	
	-- Update UI with new status
	CheckInbox()
	Mail:PopulateMeWithItems(Mail.collector)
	Mail:PopulateSenderItems(Mail.sender, SellWorthy)
end

--[[ TODO Corner Cases:
		Not enough space in bags
		AH items not available right away?
		COD
		Multiple pages?
		Don't process isGM items
--]]
-- Collect only the last item, because collecting mail is server side and we have to wait for it to finish the previous item to continue collecting.
function Mail:CollectLastItem()
	if mailState~="collecting" then return end -- Safety check - don't collect when not supposed to.
	CheckInbox()
	local lastMail = GetInboxNumItems()
	local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply, isGM = GetInboxHeaderInfo(lastMail);
	local lastAttachment = hasItem
	local itemid
	if lastAttachment==nil then lastAttachment=0 end

	 -- Should really change this into a "for" loop - when lastMail is 0,
	 -- you don't want to loop once! A "repeat" loop is not ideal here. ~~ Jeremiah
	repeat
		packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply, isGM = GetInboxHeaderInfo(lastMail);

		if not money then money=0 end
		
		-- Take any money (if we want it). Once per message.
		if money > 0 and self.collector.itemIdList["money"] and self.collector.itemIdList["money"].toggle:IsChecked()==true then
			TakeInboxMoney(lastMail)
		--	earnedMoney = earnedMoney + money
		--	ZGV.Gold.Mail.collector.totalEarned:SetText(GetMoneyString(earnedMoney))
			return
		end
		
		lastAttachment=ATTACHMENTS_MAX_RECEIVE
		repeat 
			local link = GetInboxItemLink(lastMail, lastAttachment)
			if link then itemid = tonumber(link:match("item:(%d+)")) end
			
			-- Subject is nil sometimes - I suspect when lastMail is 0 . . . ~~ Jeremiah
			if subject == nil then return end
			_, _, auctionSuccessItemName, itemCountText = string.find(subject, "Auction successful: (.*) %((%d+)%)")
			
			
			--Spoo(nil, nil, self.collector.itemIdList)
			--print(link)
			--print(itemid)
			--print(subject)
			--if auctionSuccessItemName then print(auctionSuccessItemName) end

			if (not link) and auctionSuccessItemName 
			 and ((self.collector.itemIdList["sold:"..auctionSuccessItemName]
			 and self.collector.itemIdList["sold:"..auctionSuccessItemName].toggle:IsChecked()) or
			 (self.collector.itemIdList["sold: "..auctionSuccessItemName]
			 and self.collector.itemIdList["sold: "..auctionSuccessItemName].toggle:IsChecked())) then
				TakeInboxMoney(lastMail)
				return
			end
			
			if itemid and not self.collector.itemIdList[itemid] then
				-- Probably an item indexed with a string, such as "expired:12345"
				-- expired:12345
				-- cancelled:12345
				
				-- TODO: This is just a band-aid solution. Need a proper one. ~~Jeremiah
				if self.collector.itemIdList["cancelled:"..itemid] then
					self.collector.itemIdList[itemid] = self.collector.itemIdList["cancelled:"..itemid] 
				elseif self.collector.itemIdList["expired:"..itemid] then
					self.collector.itemIdList[itemid] = self.collector.itemIdList["expired:"..itemid] 
				elseif self.collector.itemIdList["won:"..itemid] then
					self.collector.itemIdList[itemid] = self.collector.itemIdList["won:"..itemid] 
				end
			end
			
			if itemid and self.collector.itemIdList[itemid].toggle:IsChecked()==true then
				--Spoo(nil, nil, self.collector.itemIdList[itemid])
				Mail.collector.statusText:SetText("Collecting "..self.collector.itemIdList[itemid].descText:GetText())
				
				local _, _, attachmentCount = GetInboxItem(lastMail,lastAttachment)
				
				TakeInboxItem(lastMail,lastAttachment)
				--print("Got item: "..self.collector.itemIdList[itemid].descText:GetText())
				
				--CheckInbox()
				--Mail:PopulateMeWithItems(Mail.collector)
				--Spoo(nil, nil, self.collector)
				--self.collector:RemoveItem(itemid)
				self.collector:ReduceItemCount(itemid, attachmentCount)
				return -- Can't take multiple items on a single OnUpdate, just break out of entire function.
			end
			
			-- The last attachment throws an extra MAIL_SUCCESS event; ignore it.
			if lastAttachment == 1 then
				ignoreLastItem = true
			end
			lastAttachment = lastAttachment - 1
		until lastAttachment == 0
		
		lastMail = lastMail - 1
	until lastMail<=0

	Mail.collector.statusText:SetText("Finished collecting items")
	Mail:StopCollecting() -- Went through entire mailbox, found nothing to collect.
end

function Mail:SendItems()
	local recipient
	if mailState~="sending" then return end;
	
	numSent = 0
	
	for bag=0, NUM_BAG_SLOTS do
		for slot=1, GetContainerNumSlots(bag) do
			local item=GetContainerItemID(bag,slot)
			--Spoo(nil, nil, self.sender)
			--print(type(self.sender.itemIdList[item]).."?")--nil?!?!
			if item and self.sender.itemIdList[item] and self.sender.itemIdList[item].toggle:IsChecked()==true then
				local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = cachedGetItemInfo(item)
				--if filter(item) then
				--		self:AddItem(item)
				--		self:UpdateSecText(item,GetMoneyString(vendorPrice))
					--local name,tex,count = GetInboxItem(mailId,attId)
		
					--local item = me:AddItem(item,count)
		
					--item.secText:SetText(GetMoneyString(0))
					--ZGV:isSoulbound(bag, slot)
					recipient = Mail.sender.editBox:GetText()
					if not Mail:IsValidRecipient(recipient) then
						print(recipient.." is not a valid recipient.")
						return
					end
					
					profile["Mail"].lastRecipient = recipient
					
					local _, itemCount = GetContainerItemInfo(bag, slot)
					UseContainerItem(bag,slot)
					
					tinsert(attachedItems, {item, itemCount})
					numSent = numSent + 1

					-- In game mail only allows 12 items in each mail.
					-- If a mail is full, send it and start a new mail.
					if numSent >= 12 then
						--print(Mail.sender.editBox:GetText())
						SendMail(recipient,"Zygor Package")
						numSent = 0
						mailState = "sent"
						return -- Let the server do its thing before continuing the next mail.
					end
				--end
			end
		end
	end

	-- Send any remaining mail
	if numSent > 0 then
		SendMail(recipient,"Zygor Package")
	else
		mailState="waiting"
	end
	
	-- Update UI with new status
	repopulateAll()
end

-- Checks the recipient for validity. In the future, may also warn when sending
-- to a new/unknown recipient.
function Mail:IsValidRecipient(name)
	if name == nil or name == "" then return false end
	
	return true
end

function Mail:StartSending()
	mailState="sending"
	Mail:SendItems()
end


function Mail:Show()
 	if not ZGV.db.profile.mail_enable then return end
	if not self.base then
		self:CreateBase()
		self.base:Show()
	end

	if ZGV.Gold.Mail.collector then
		self.collector:Show()
	end
end

function Mail:Hide()
	if not self.base then return end
	self.sender:Hide()
	self.collector:Hide()
end

function Mail:Toggle()
	--if ZGV.db.profile.mail_enable then --TODO
	if ZGV.db.profile.load_mail and ZGV.db.profile.mail_enable then
		Mail:Show()
	else
		Mail:Hide()
	end
end