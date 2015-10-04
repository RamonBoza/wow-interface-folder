local name,ZGV=...

local ZGVG=ZGV.Gold

ZGVG.Scan={}

local Scan=ZGVG.Scan


Scan.state = "SS_OUT"
Scan.queryspin = 0

local MassScanInterval = 15*60


local yield=coroutine.yield
local floor=math.floor
local round=math.round

tinsert(ZGV.startups,{"Gold scan startup",function(self)
	--self:AddEvent("CHAT_MSG_SYSTEM","CHAT_MSG_SYSTEM_QuestTracking")
	--self:AddEvent("QUEST_LOG_UPDATE","QUEST_LOG_UPDATE_QuestTracking")
	--self:AddEvent("QUEST_COMPLETE","QUEST_COMPLETE_QuestTracking")

	Scan:CreateWorkFrame()
	Scan:CreateUIFrame()

	Scan.db = ZGV.db

	if not Scan.db.realm.gold_scan_data then Scan.db.realm.gold_scan_data={} end
	Scan.data = Scan.db.realm.gold_scan_data

	--if not Scan.db.realm.gold_scan_rawdata then Scan.db.realm.gold_scan_rawdata={} end
	--Scan.rawdata = Scan.db.realm.gold_scan_rawdata
	Scan.rawdata = {}

	--hooksecurefunc("SetAbandonQuest",self.QuestTracking_hook_SetAbandonQuest)
	--hooksecurefunc("AbandonQuest",self.QuestTracking_hook_AbandonQuest)
	Scan.enabled = true
	ZGV:Debug("Gold: Scan enabled.")
end})




local orderedPairs = ZGV.OrderedPairs



function Scan:ScanFast()
	if not select(2,CanSendAuctionQuery()) or self.state=="SS_OUT" then return FALSE end
	QueryAuctionItems("", nil, nil, 0, 0, 0, 0, 0, 0, true) -- FULL SCAN!
	table.wipe(self.rawdata)
	self.queried_by_name = nil
	self:SetState("SS_QUERYING")
	self.db.realm.LastScan=time()
	self.db.realm.LastScanAvailable=time()
	return true
end

function Scan:ScanByName(name)
	if not select(1,CanSendAuctionQuery()) or self.state=="SS_OUT" or name=="" then
		ZGV:Debug("&scan Scan:ScanByName|cffffee00",name,"|rcan't scan yet!")
		return FALSE
	end
	ZGV:Debug("&scan Scan:ScanByName|cffffee00",name)
	QueryAuctionItems(name, nil, nil, 0, 0, 0, 0, 0, 0, false, true)  -- 6.0.2: query by exact name
	table.wipe(self.rawdata)
	self.queried_by_name = name
	self.scan_page = 1
	self:SetState("SS_QUERYING")
end

function Scan:CanScanByName()
	local canOne,canMass = CanSendAuctionQuery()
	if canOne then return true else return false end
end

function Scan:CanScanFast()
	local canOne,canMass = CanSendAuctionQuery()
	if canMass then
		self.db.realm.LastScanAvailable=time()
		return true,0
	else
		if not self.db.realm.LastScanAvailable then self.db.realm.LastScanAvailable=time()+999999 end
		return nil, 15 - (time() - (self.db.realm.LastScanAvailable or 9999999999))/60
	end
end

function Scan:GetScanFastTimeString(can,when) -- time remaining, in minutes
	if not when then can,when=self:CanScanFast() end
	if can then return("You can scan now.")
	elseif (when > 1000) then return("Next scan: unknown")
	elseif (when>1) then return(("Next scan: in ~%d minutes"):format(when))
	elseif (when>=0) then return("Next scan: almost there!")
	else return("Next scan unknown!")
	end
end


--[[
	function Scan:CmdScanFast()
		local canMass,when = self:CanScanFast()

		if not canMass then
			print ("cannot mass",self:GetScanFastTime(when))
			return
		end

		local scanned = self:ScanFast()

		if not scanned then print("Scan failed!") return end
	end
--]]






local hasQueried = false
local PAGELENGTH = 50

local consecutive_updates=0

function Scan.EventHandler(frame,event,arg1,arg2)
	self=Scan
	if event=="AUCTION_HOUSE_SHOW" then
		self.FWORK:Show()
		self:SetState("SS_IDLE")
		--hasQueried = false
	elseif event=="AUCTION_HOUSE_CLOSED" then
		self.FWORK:Hide()
		self:SetState("SS_OUT")
	elseif event=="AUCTION_ITEM_LIST_UPDATE" then
		-- Delaying scan because results tend to arrive with several subsequent A_I_L_U events
		self.last_AILU_time = GetTime()
		self.last_AILU_count = self.last_AILU_count + 1
		if self.state=="SS_QUERYING"
		-- or (self.state=="SS_IDLE" and self:GetAuctionCount("list")>PAGELENGTH) --leech  -- creates an infinite loop! ~~ Jeremiah
		then
			self.last_AILU_count = 1
			if self.queried_by_name then -- this is a slow scan, just go ahead and scan results.
				self:SetState("SS_SCANNING")
			else
				self:Debug("Scan:EventHandler |cff77bbff%s - they come in floods, waiting for 2s pause...",event)
				self:SetState("SS_RECEIVING")
			end
		end

		--if self.state=="SS_QUERYING" then
		-- let's leech instead.

		--if hasQueried == false then
			--self:SetState("SS_SCANNING")
			--hasQueried = true
		--end
		--end
	end
end


Scan.last_AILU_count=0
Scan.last_AILU_time=0

local lasttime=0
function Scan:Work()
	if self.state=="SS_QUERYING" then
		return
	end
	if self.state=="SS_RECEIVING" then
		if GetTime()-self.last_AILU_time > 3.000 then  -- 1000 ms passed since the last AILU event... this maaay not be good, but let's start with this.
			self:Debug("Scan:Work - got %d AILUs, 3000 ms passed since then, moving from RECEIVING to SCANNING",self.last_AILU_count)
			self:SetState("SS_SCANNING")
		else
			self:Debug("Scan:Work - got %d AILUs so far",self.last_AILU_count)
		end
		return
	end
	if self.state=="SS_SCANNING" then
		self:ScanAuctions()
		return
	end
	if self.state=="SS_ANALYZING" then
		self:AnalyzeAuctions("go")
		return
	end
	if self.state=="SS_NEEDTOQUERY" then
		if CanSendAuctionQuery() then
			ZGV:Debug("&scan Running queued query for|cffffee00",self.queried_by_name,"|rpage",self.scan_page)
			self:queryfunc()
			self:SetState("SS_QUERYING")
		else
			if GetTime()-lasttime>1.000 then self:Debug("SS_NEEDTOQUERY Still can't query, waiting...") lasttime=GetTime() end
		end
	end
end

local delay,interval=0,0.1
function Scan.UpdateHandler(frame,elapsed)
	delay=delay+elapsed  if delay>interval then delay=0 else return end
	--[[
	if consecutive_updates>1 then
		ZGV:Debug("Scan:UpdateHandler: |cff335588AUCTION_ITEM_LIST_UPDATE x",consecutive_updates)
		consecutive_updates=0
	end
	--]]
	Scan:Work()
end






local last_full_scan=0

local scanning_throttle_ms = 100 --ms
local scanning_throttle_rows = 1000 --rows
local scanning_throttle_sec = 10000 --rows/sec!   -- now using ZGV.db.profile.ahscanintensity!
local scanning_current_sec,scanning_last_sec,scanning_this_sec
function Scan:ScanAuctions()
	local batch,total = self:GetAuctionCount("list")
	local goodlinks,badlinks,uniqueids,unwanted=0,0,0,0

	
	scanning_throttle_sec = ZGV.db.profile.ahscanintensity


	local tim=time()
	tim = 1  -- store only current data

	local newitems={}

	if batch>PAGELENGTH then  -- full scan? prepare to wipe.
		if not self.last_scanned_in_batch and time()-last_full_scan<10 then
			-- A new full scan in 10 seconds? You gotta be kidding.
			-- This is an "echo" of an update, IGNORE, or we'll accidentally the whole thing.
			ZGV:Debug("&scan ScanAuctions |cffff8800refusing to scan too frequent full scans.")
			last_full_scan=time()
			self:SetState("SS_IDLE")
			return
		end
		last_full_scan=time()
		if self.data then self.data.wipe_me=true end
	else
		self.last_scanned_in_batch=nil
	end

	local saved_Id

	self.last_scanned_in_batch = self.last_scanned_in_batch or 0  -- this means we're in partial processing of a full scan

	--self:Debug("Scan:ScanAuctions rows %d - %d , total %d",self.last_scanned_in_batch+1,batch,total)

	local t1 = debugprofilestop()

	local rowsnow=0

	scanning_current_sec = floor(GetTime())
	if scanning_last_sec~=scanning_current_sec then scanning_last_sec=scanning_current_sec  scanning_this_sec=0 end

	for i=self.last_scanned_in_batch+1,batch do
		local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo = GetAuctionItemInfo("list", i)

		if itemId and name then
			if not self.queried_by_name or name==self.queried_by_name then
				tinsert(self.rawdata,itemId ..":".. count ..":".. buyoutPrice)

				--[[
					--local link = GetAuctionItemLink("list", i)
					--local id = tonumber(link:match("item:(%d+)"))
					
					--local itemdata --  = dataset[itemId]
					--if not itemdata then itemdata={} dataset[itemId]=itemdata end
				--]]
				--[[
					local IDstring = zc.ItemIDStrfromLink (itemLink);
					
					if (Atr_ILevelHist_Update) then
						Atr_ILevelHist_Update(itemLink)
					end
					
					local OKitemLevel = true
					if (self.minItemLevel or self.maxItemLevel) then
						local _, _, _, iLevel, _ = GetItemInfo(itemLink);
						if ((self.minItemLevel and iLevel < self.minItemLevel) or (self.maxItemLevel and iLevel > self.maxItemLevel)) then
							OKitemLevel = false
						end
					end
					
					if (OKitemLevel) then
						if (owner == nil) then
							numNilOwners = numNilOwners + 1
						end

						if (self.exactMatchText == nil or zc.StringSame (name, self.exactMatchText)) then

							if (self.items[IDstring] == nil) then
								self.items[IDstring] = Atr_FindScanAndInit (IDstring, name)
							end
							
							local curpage = (tonumber(self.current_page)-1)

							local scn = self.items[IDstring]

							if (scn) then
								scn:AddScanItem (count, buyoutPrice, owner, 1, curpage)
								scn:UpdateItemLink (itemLink)
							end
						end
					end
				--]]

				goodlinks=goodlinks+1
				saved_Id=itemId
			else
				unwanted=unwanted+1
			end
			
			if not newitems[itemId] then
				newitems[itemId]=1
				uniqueids=uniqueids+1
			end

		else
			badlinks=badlinks+1
		end

		rowsnow=rowsnow+1

		if (batch<total or total<=PAGELENGTH) and (not self.queried_by_name or not name:find(self.queried_by_name)) then
			-- whoa, it's not our search!
			ZGV:Debug("&scan Scan:ScanAuctions, it's not our search, sorry! (What the hell are we doing here anyway!?)")
			self:SetState("SS_IDLE")
			return
		end

		scanning_this_sec = scanning_this_sec + 1
		
		--if t2-t1 > scanning_throttle_ms  or  rowsnow>scanning_throttle_rows then
		if scanning_this_sec>=scanning_throttle_sec
		or debugprofilestop()-t1 >= scanning_throttle_ms
		or rowsnow>=scanning_throttle_rows
		then
			self:Debug("&scan FastScan |cffffaa00running|r! Did |cffffffff%d|r rows now. Progress %d/%d = |cffffdd00%d%%|r. %d good, %d bad, %d unique, %d raw. (%d in sec)",
			rowsnow,
			i,total,i/total*100,
			goodlinks,badlinks,uniqueids,#self.rawdata,
			scanning_this_sec)
			--self:SetState("SS_SCANNING") -- why set to the same, I wonder
			self.last_scanned_in_batch=i
			self.scan_progress = i/total
			return
			-- lame excuse for a coroutine. TODO: coroutinize it? maybe? not direly needed, I guess... ~~sinus
		end

	end

	-- we're done!

	self.last_scanned_in_batch=nil

	if batch>PAGELENGTH then
		self:Debug("FastScan |cff88ff00OVER|r: %d total, %d good, %d bad, %d unique, %d rows",batch,goodlinks,badlinks,uniqueids,#self.rawdata)
		self:SetState("SS_ANALYZING")
		self:AnalyzeAuctions("reset")
		self.data.wipe_one = nil
	elseif batch==PAGELENGTH and (self.scan_page*PAGELENGTH<total) and self.queried_by_name then
		self.scan_page = self.scan_page + 1
		if CanSendAuctionQuery() then
			self:Debug("SlowScan for |cffffee00%s|r |cffffaa00running|r: got %d rows, %d total, %d good, %d bad, %d unwanted, %d unique. This was page %d, going for next.",self.queried_by_name, #self.rawdata,total, goodlinks,badlinks,unwanted,uniqueids,self.scan_page-1)
			QueryAuctionItems(self.queried_by_name, nil, nil, 0, 0, 0, self.scan_page-1, 0, 0, false)
			self:SetState("SS_QUERYING")
		else
			self:Debug("SlowScan for |cffffee00%s|r |cffffaa00running|r: got %d rows, %d total, %d good, %d bad, %d unwanted, %d unique. This was page %d, WAITING for next.",self.queried_by_name, #self.rawdata,total, goodlinks,badlinks,unwanted,uniqueids,self.scan_page-1)
			self:SetState("SS_NEEDTOQUERY")
			self.queryfunc = function(self)
				QueryAuctionItems(self.queried_by_name, nil, nil, 0, 0, 0, self.scan_page-1, 0, 0, false, true)
				self:SetState("SS_QUERYING")
			end
		end
	else
		-- end
		self:Debug("SlowScan for |cffffee00%s|r |cff88ff00OVER|r: got %d rows, %d total, %d good, %d bad, %d unwanted, %d unique.",self.queried_by_name, #self.rawdata,total, goodlinks,badlinks,unwanted,uniqueids)
		self:SetState("SS_ANALYZING")
		self:AnalyzeAuctions("reset")
		self.data.wipe_one = saved_Id
	end

	--[[
	-- in some cases..???
	-- error when scanning?
	self:SetState("SS_IDLE")
	--]]

end

function Scan:GetAuctionCount(typ)
	local batch,total = GetNumAuctionItems(typ)
	return batch,(total>500000 or total<0) and batch or total,total
end


local analyze_throttle = 50 --ms
function Scan:AnalyzeAuctions(cmd)  -- Abominable Self-coroutine.
	-- selfdriver:
	if cmd=="reset" then self.analyzethread=nil return end
	if cmd=="go" then  self.analyzethread=self.analyzethread or coroutine.create(self.AnalyzeAuctions)  local suc,err=coroutine.resume(self.analyzethread,self)  if not suc then ZGV:Debug("&scan ERROR ANALYZING "..err) self.analyzethread=nil self:SetState("SS_IDLE") end return  end
	-- end of selfdriver

	local tim=time()

	self.data.today = 1 --tim - tim%86400
	self.data[self.data.today] = self.data[self.data.today] or {}
	data_byitems = self.data[self.data.today]

	local first_wipes
	if self.data.wipe_me then
		self:Debug("AnalyzeAuctions: wipe requested, wiping.")
		table.wipe(data_byitems)
		self.data.wipe_me=nil
	end

	if self.data.wipe_one then
		if data_byitems[self.data.wipe_one] then table.wipe(data_byitems[self.data.wipe_one]) end
	end

	-- Condense raw data only.

	local save_itemId,save_data

	local new=0

	local newitems={}

	local t1=debugprofilestop()
	
	for i,rawline in ipairs(self.rawdata) do
		
		-- itemId ..":".. count ..":".. minBid ..":".. buyoutPrice
		local itemId,count,buyoutPrice = strsplit(":",rawline)

		itemId=tonumber(itemId)
		count=tonumber(count)
		buyoutPrice=round(buyoutPrice/count)

		if buyoutPrice>0
		or itemId==82800 --pet cage
		then  -- no buyout, no deal.
			if not data_byitems[itemId] then data_byitems[itemId]={} end
			if not newitems[itemId] then newitems[itemId]=1 new=new+1 end

			local dat=data_byitems[itemId]
			-- store all the data about the item in here.
			-- FIRST PASS.

			-- just get the minimum
			-- or don't
			--[[
			buyoutPrice=buyoutPrice/count
			dat.min = dat.min and min(dat.min,buyoutPrice) or buyoutPrice
			--]]

			if not dat[buyoutPrice] then dat[buyoutPrice]=count else dat[buyoutPrice]=dat[buyoutPrice]+count end

			save_itemId=itemId
			save_data=dat

		end

		if i%100==0 then
			if debugprofilestop()-t1>analyze_throttle then
				self.analysis_progress = i / #self.rawdata
				self:Debug("AnalyzeAuctions: %d%% (%d / %d)",self.analysis_progress*100,i,#self.rawdata)
				yield()
				t1=debugprofilestop()
			end
		end
	end

	-- now: data_byitems[itemid]={[12300]=1,[12301]=10,[12299]=1000}

	-- Now let's do some stats.

	--[[

	local new=0
	for itemid=1,100000 do if data[itemid] then -- force sort; pairs or ipairs wouldn't suffice
		-- itemId ..":".. count ..":".. minBid ..":".. buyoutPrice

		local stats={}

		for i,countprice in ipairs(data[itemid]) do
			local count,price = strsplit(":",countprice)
			stats[price]=
		end


		local count,buyoutPrice = strsplit(":",v)
		itemId=tonumber(itemId)

		if not data[itemId] then data[itemId]={} new=new+1 end
		local dat=data[itemId]

		-- just get the minimum
		buyoutPrice=buyoutPrice/count
		dat.min = dat.min and min(dat.min,buyoutPrice) or buyoutPrice



		if i%5000==0 then 
			self.analysis_progress = i / #self.rawdata
			yield()
		end
	end end

	--]]

	ZGV:Print(("Analysis complete. %d items scanned in %d auctions."):format(new,#self.rawdata))

	table.wipe(self.rawdata)

	if self.queried_by_name then
		ZGV:Debug("&scan Results for|cffffee00",self.queried_by_name,"|cff888888##",save_itemId,"|r:")
		if save_data then for k,v in pairs(save_data) do ZGV:Debug("&scan "..k..","..v) end else ZGV:Debug("&scan NONE") end
		if save_itemId then self:DebugItem(save_itemId) end
	end
	self.queried_by_name = false

	ZGV:SendMessage("GOLD_SCANNED")

	self:SetState("SS_IDLE")
end


function Scan:SetState(state)
	self:Debug("SetState %s",state)
	if self.state=="SS_QUERYING" and state=="SS_OUT" then
		ZGV:Debug("&scan Query cancelled.")
	end
	if state=="SS_NEEDTOQUERY" then lasttime=GetTime() end  -- timestamp last attempt to query, just cosmetics

	local oldstate = self.state
	self.state=state

	-- Output an event when the state changes
	if oldstate~=state then
		ZGV:SendMessage("SS_STATE_CHANGE", state)
	end
	
	-- add specific state change handlers here
end

function Scan:ReAnalyze()
	self:SetState("SS_ANALYZING")
	self:AnalyzeAuctions("reset")
end

local function percentile(itemdata,perc,total)
	local tempcount=0
	local targetcount=floor(perc*total)
	for price,count in orderedPairs(itemdata) do
		tempcount=tempcount+count
		if tempcount>=targetcount then return price end
	end
end

function Scan:GetAnalysis(itemid)
	local data = self.data[self.data.today]
	if not data then return false,"no data for today" end
	local itemdata = data[itemid]
	if not itemdata then return false,"no data for item" end
	
	local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemid)
	ZGV:Debug("&scan Analysing: ",itemLink)
	ZGV:Debug("&scan - vendor "..GetMoneyString(itemSellPrice))

	local totalcount=0
	local sum=0
	local pricemin,pricemax
	for price,count in orderedPairs(itemdata) do
		totalcount=totalcount+count
		sum=sum+(price*count)
		if not pricemin or pricemin>price then pricemin=price end
		if not pricemax or pricemax<price then pricemax=price end
	end
	ZGV:Debug("&scan seen "..totalcount.." times")
	ZGV:Debug("&scan min "..GetMoneyString(pricemin).." max "..GetMoneyString(pricemax))
	ZGV:Debug("&scan median "..GetMoneyString(percentile(itemdata,0.5,totalcount)))
	ZGV:Debug("&scan 10 perc "..GetMoneyString(percentile(itemdata,0.1,totalcount)))
	ZGV:Debug("&scan 90 perc "..GetMoneyString(percentile(itemdata,0.9,totalcount)))
	ZGV:Debug("&scan average "..GetMoneyString(sum/totalcount))
	ZGV:Debug("&scan center "..GetMoneyString((pricemin+pricemax)/2))
end

function Scan:GetPrice(itemid)
	local data = self.data[self.data.today]
	if not data then return 0,"no data for today at all" end
	local itemdata = data[itemid]
	if not itemdata then return 0,"no data for item" end
	for price,count in orderedPairs(itemdata) do
		if price then return price end
	end
end

function Scan:GetPrices(itemid)
	local data = self.data[self.data.today]
	if not data then return nil,"no data for today at all" end
	local itemdata = data[itemid]
	if not itemdata then return nil,"no data for item" end
	return itemdata
end

function Scan:CreateWorkFrame()
	local CHAIN=ZGV.ChainCall
	self.FWORK = CHAIN(CreateFrame("FRAME","ZGGoldScanWork"))
		:RegisterEvent("AUCTION_HOUSE_SHOW") --
		:RegisterEvent("AUCTION_HOUSE_CLOSED") --
		:RegisterEvent("AUCTION_ITEM_LIST_UPDATE") --
		:RegisterEvent("AUCTION_BIDDER_LIST_UPDATE")
		:RegisterEvent("AUCTION_OWNED_LIST_UPDATE")
		:RegisterEvent("AUCTION_MULTISELL_START")
		:RegisterEvent("AUCTION_MULTISELL_UPDATE")
		:RegisterEvent("AUCTION_MULTISELL_FAILURE")
		:RegisterEvent("NEW_AUCTION_UPDATE")
		:RegisterEvent("CHAT_MSG_ADDON")
		:SetScript("OnEvent",Scan.EventHandler)
		:SetScript("OnUpdate",Scan.UpdateHandler)
		:Hide()
		.__END
end










local delay,interval=0, 0.5
function Scan.UIFrameOnUpdate(frame,elapsed)
	if not Scan.enabled then return end
	delay=delay+elapsed  if delay>interval then delay=0 else return end

	local s=Scan.state

	local canMass,when = Scan:CanScanFast()
	frame.ScanButton:SetEnabled(canMass and Scan.state=="SS_IDLE")

	-- state
	if Scan.state=="SS_IDLE" then s=Scan:GetScanFastTimeString(canMass,when)
 	elseif Scan.state=="SS_QUERYING" then  Scan.queryspin=(Scan.queryspin+1)%5  s="Querying" .. strrep(".",Scan.queryspin+1)
	elseif Scan.state=="SS_ANALYZING" then  s=("Analyzing (%d%%)"):format((Scan.analysis_progress or 0)*100)
	end
	frame.MainText:SetText(s)

end

function Scan.UIFrameOnShow(frame)
	frame:SetPoint("BOTTOMRIGHT",AuctionFrame,"TOPRIGHT")
end

function Scan.UIFrameOnEvent(frame,event,arg1,arg2)
	if event=="AUCTION_HOUSE_SHOW" then
		--frame:Show()
	elseif event=="AUCTION_HOUSE_CLOSED" then
		frame:Hide()
	end
	--Scan.UIFrameOnUpdate(frame,999)
end

function Scan:CreateUIFrame()
	local FONT=ZGV.Font
	local CHAIN=ZGV.ChainCall

	local function SkinData(property)  return ZGV.CurrentSkinStyle:SkinData(property)  end

	self.FUI=CHAIN(CreateFrame("FRAME","ZGGoldScanUI",UIParent))
		:SetSize(200,100)
		:SetFrameStrata("DIALOG")
		:SetBackdrop(SkinData("MoneyBackdrop"))
		:SetBackdropColor(unpack(SkinData("MoneyBackdropColor")))
		:SetBackdropBorderColor(unpack(SkinData("MoneyBackdropBorderColor")))
		:SetMovable(true) :SetClampedToScreen(true) :RegisterForDrag("LeftButton")
		:RegisterEvent("AUCTION_HOUSE_SHOW") --
		:RegisterEvent("AUCTION_HOUSE_CLOSED") --
		:SetScript("OnDragStart",function(self) self:StartMoving() end)
		:SetScript("OnDragStop",function(self) self:StopMovingOrSizing() end)
		:SetScript("OnEvent",Scan.UIFrameOnEvent)
		:SetScript("OnUpdate",Scan.UIFrameOnUpdate)
		:SetScript("OnShow",Scan.UIFrameOnShow)
		:SetUserPlaced(true)
		:Hide()
		.__END
		--:RegisterEvent("PLAYER_ENTERING_WORLD")

	self.FUI.MainText = CHAIN(self.FUI:CreateFontString())
		:SetPoint("TOP",self.FUI,"Top",0,0)
		:SetJustifyV("TOP")
		:SetFont(FONT,11)
		:SetParent(self.FUI)
	.__END

	self.FUI.ScanButton = CHAIN(CreateFrame("BUTTON",self.FUI:GetName().."_ScanButton",self.FUI,"UIPanelButtonTemplate"))
		:SetPoint("TOP",self.FUI,"Top",0,-20)
		:SetSize(60,20)
		:SetText("Scan")
		:SetScript("OnClick",function() Scan:ScanFast() end)
		:Show()
	.__END

	self.FUI.ScanDelay = CHAIN(self.FUI:CreateFontString())
		:SetPoint("TOP",self.FUI,"Top",0,-40)
		:SetJustifyV("TOP")
		:SetFont(FONT,11)
		:SetParent(self.FUI)
	.__END


end


function Scan:DebugItem(id)
	local typ
	if not id then
		typ,id = GetCursorInfo()
		if typ~="item" then ZGV:Debug("&scan Cursor has no item.") return end
	end

	ZGV:Debug("&scan Debug for item #",id)

	if  ZGV.Gold.servertrends
	and ZGV.Gold.servertrends.items
	and ZGV.Gold.servertrends.items[id] then
		local data=ZGV.Gold.servertrends.items[id]
		if next(data) then
			ZGV:Debug("&scan Server data: health",data.health,", q",data.q_lo,"-",data.q_hi,", p",ZGV.GetMoneyString(data.p_lo or -1),"-",ZGV.GetMoneyString(data.p_hi or -1))
		else
			ZGV:Debug("&scan Server data: NONE!?")
		end
	else
		ZGV:Debug("&scan No server data for item")
	end

	if  ZGV.db.realm.gold_scan_data
	and ZGV.db.realm.gold_scan_data[1]
	and ZGV.db.realm.gold_scan_data[1][id] then
		ZGV:Debug("&scan AH data:")
		for k,v in pairs(ZGV.db.realm.gold_scan_data[1][id]) do
			ZGV:Debug("&scan "..k..","..v)
		end
	else
		ZGV:Debug("&scan No AH data for item")
	end

	ZGV:Debug("&scan ZGV.Gold.Scan:GetPrice :")
	ZGV:Debug("&scan  ",ZGV.GetMoneyString(Scan:GetPrice(id)))

end

function Scan:Debug(s,...)
	return ZGV:Debug("&gold &scan &_SUB "..s,...)
end