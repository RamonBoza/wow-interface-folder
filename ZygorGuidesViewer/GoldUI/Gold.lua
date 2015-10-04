local name,ZGV=...
local Gratuity = LibStub("LibGratuity-3.0")

ZGV.Gold = {}

local ZGVG=ZGV.Gold


ZGV.Gold.data = {}
ZGV.Gold.data.chores = {}

ZGVG.OVERPRICE = 1.2


local CHAIN = ZGV.ChainCall


-- ZGVG:GetSellPrice uses these:
local PRICESTATUS_GOUGED=2
local PRICESTATUS_UP=3
local PRICESTATUS_DOWN=5
local PRICESTATUS_NORMAL=4
local PRICESTATUS_EMPTY=1
local PRICESTATUS_NODATA=6
local PRICESTATUS_UNSTABLE=7


tinsert(ZGV.startups,{"Gold guides parsing", function ()
	self=ZGVG
	if not ZGV.db.profile.load_gold then return end
	ZGVG:Startup()
	ZGVG:SetPriceModel("zygor")

	ZGVG.usefulness = ZGV.StackSizes

	local t = debugprofilestop()

	-- parse all the gold guides
	for gui,guide in ipairs(ZGV.registeredguides) do
		if guide.type=="GOLD" then
			-- let's make a chore out of this guide.
			guide:Parse(true)

			local chore = {}
			chore.name=guide.title_short
			chore.guide=guide
			chore.meta=guide.meta

			if guide.meta and guide.meta.goldtype=="route" then

				chore.typ="route"

				-- chore.route ?? no need to set this, this is obsolete.
				local items={}
				local crap
				for si,step in ipairs(guide.steps) do
					for gi,g in ipairs(step.goals) do
						if g.meta and g.meta.crap_items_follow then crap=true end
						--if g.action=="goldcollect" and not g.force_nocomplete and g.targetid and (not crap or g.count>=10) then
						if g.action=="goldcollect" and not g.force_nocomplete and g.targetid and not crap then
							tinsert(items,{g.targetid,g.count,crap})
						end
					end
				end
				chore.items = items

			elseif guide.meta and guide.meta.goldtype=="vendor" then
			
				chore.typ="vendor"
				chore.gold=guide.meta.gold
				chore.time=guide.meta.time

				-- chore.route ?? no need to set this, this is obsolete.
				local items={}
				local crap
				for si,step in ipairs(guide.steps) do
					for gi,g in ipairs(step.goals) do
						if g.meta and g.meta.crap_items_follow then crap=true end
						if g.action=="buy" and not g.force_nocomplete and g.targetid and (not crap or g.count>=10) then
							tinsert(items,{g.targetid,g.count,crap})
						end
					end
				end
				chore.items = items

			elseif guide.meta and guide.meta.goldtype=="till" then
			
				chore.typ="till"
				chore.time=1440

				-- chore.route ?? no need to set this, this is obsolete.
				local items={}
				local crap
				for si,step in ipairs(guide.steps) do
					for gi,g in ipairs(step.goals) do
						if g.meta and g.meta.crap_items_follow then crap=true end
						if g.action=="collect" and not g.force_nocomplete and g.targetid and (not crap or g.count>=10) and g:IsVisible() then
							tinsert(items,{g.targetid,g.count,crap})
						end
					end
				end
				chore.items = items

			elseif guide.meta and guide.meta.goldtype=="daily" then
			
				chore.typ="daily"
				chore.gold=guide.meta.gold
				chore.time=guide.meta.time
			
			elseif guide.meta and guide.meta.goldtype=="xmog" then

				chore.typ="xmog"

				local items={}
				local crap
				local added_items = {}
				for si,step in ipairs(guide.steps) do
					for gi,g in ipairs(step.goals) do
						if g.meta and g.meta.crap_items_follow then crap=true end
						if g.action=="goldcollect" and g.targetid and not crap then
							if not added_items[g.targetid] then
								tinsert(items,{g.targetid,g.count,crap})
								added_items[g.targetid] = true
							end
						end
					end
				end
				chore.items = items
			end

			if chore.typ then ZGV.Gold.chores:AddChore(chore) end

			if debugprofilestop()-t>100 then t=debugprofilestop() coroutine.yield("more gold to do") end
		end
	end
	ZGV:RegisterMessage("GOLD_SCANNED")
end } )


function ZGVG:Startup()
	ZGVG.ControlFrame = CHAIN(CreateFrame("FRAME"))
		:RegisterEvent("AUCTION_HOUSE_SHOW")
		:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")
		:SetScript("OnEvent",ZGVG.ControlFrame_OnEvent)
		:Show()
		.__END
end

function ZGVG.ControlFrame_OnEvent(frame,event)
	--print("ControlFrame event",event)
	if event=="AUCTION_HOUSE_SHOW" then
		if not ZGVG.scanButton then
			--print("Adding scan button")
			ZGVG:CreateScanButton(AuctionFrame)
		end
		ZGV:ScheduleTimer(function() ZGVG.ScanButton_OnUpdate(ZGVG.scanButton) end, 0.1)
	end
	ZGVG.ScanButton_OnUpdate(ZGVG.scanButton,event)
end

function ZGVG:CreateScanButton(hostframe)
	ZGVG.scanButton = CHAIN(ZGV.UI:Create("Button",hostframe))
		:SetSize(100,20)
		:SetPoint("TOPRIGHT",-20,25)
		:SetFont(FONT,12)
		:SetText("Zygor Scan")
		:RegisterForClicks("AnyUp")
		:SetScript("OnClick",function(self) if self.soft_disabled then return end ZGVG.Scan:ScanFast() end)
		:SetScript("OnEnter",function(self) CHAIN(GameTooltip):SetOwner(self, "ANCHOR_BOTTOM") :SetText(type(self.tooltip)=="function" and self:tooltip() or tostring(self.tooltip)) :Show() end)
		:SetScript("OnLeave",function(self) GameTooltip:Hide() end)
		.__END

	ZGVG.ScanButton_OnUpdate(ZGVG.scanButton)

	ZGV:AddMessage("SS_STATE_CHANGE",function(...) return ZGVG.ScanButton_OnUpdate(ZGVG.scanButton,...) end)
end

function ZGVG.ScanButton_OnUpdate(button,event)
	self = button

	--print("SB_OnUpdate",event)

	if ZGVG.Scan.state=="SS_QUERYING"
	or ZGVG.Scan.state=="SS_SCANNING"
	or ZGVG.Scan.state=="SS_ANALYZING"
	or ZGVG.Appraiser.manualScanning then
		button:SetText("|c88888888Scanning...")
		button.tooltip = "Auction scan is underway. Please wait."
		button.soft_disabled=true
	elseif ZGVG.Scan.state=="SS_IDLE" then
		if IsShiftKeyDown() and false then --DISABLED IN THE TEMPORARY BUTTON.
			local canscan,delay = ZGVG.Scan:CanScanByName()
			if canscan then
				button:SetText("|cFFFFFFFFSlow Scan")
				button.tooltip = "Run a slow auction scan of the items shown.\nRelease |cff88ff00Shift|r to run a fast scan "..(ZGVG.Scan:CanScanFast() and "|cffff0000(not available!)|r" or "")
				button.soft_disabled=false
			else
				button:SetText("|cFF666666Slow Scan")
				button.tooltip = ("|cffff0000Auction scan not possible now.\nPlease wait a few seconds."):format(delay)
				button.soft_disabled=true
			end
		else
			local canscan,delay = ZGVG.Scan:CanScanFast()
			if canscan then
				button:SetText("|cFFFFFFFFZygor Scan")
				button.tooltip = "Run a fast auction scan." --\nHold |cff88ff00Shift|r to force a slow scan of the items shown."
				button.soft_disabled=false
			else
				button:SetText("|cFF666666Zygor Scan")
				button.tooltip = ("|cffff0000Auction scan not possible now, please wait ~%d minutes."--[[|r\nHold |cff88ff00Shift|r to force a slow scan instead."--]]):format(delay)
				button.soft_disabled=true
			end
		end
	else
		button:SetText("|cFF666666Zygor Scan")
		button.tooltip = ("|cffff0000Auction scan not possible now.\nPlease wait a few seconds."):format(delay)
		button.soft_disabled=true
	end
	if button:IsMouseOver() then button:GetScript("OnEnter")(button) end
end



function ZGVG:GetItemPrice(id)
	local vendor = select(11,GetItemInfo(id)) or 0
	if self.pricemodel=="example" then
		return vendor,self.data.example_prices[id] or 0
	elseif self.pricemodel=="zygor" then
		return vendor,self.Scan:GetPrice(id) or 0
	elseif self.pricemodel=="auctionator" and IsAddOnLoaded("Auctionator") then
		return vendor,GetAuctionBuyout(id) or 0
	elseif self.pricemodel=="auctioneer" and IsAddOnLoaded("Auc-Advanced") then
		return vendor,AucAdvanced.API.GetMarketValue(id) or 0
	else
		return vendor,0
	end
end

function ZGVG:SetPriceModel(model)
	self.pricemodel=model
	if not self.FUI then return end
	if self.FUI.PriceModelButton then self.FUI.PriceModelButton:SetText("Prices: "..model) end
	if ZGVG.FUI:IsShown() then self:Update() end
end

function ZGVG:LoadChore(chore)
	ZGV:SetGuide(chore.guide or "GOLD\\"..chore.name)
end



local chore_protos = {}
ZGVG.chore_protos = chore_protos
chore_protos.daily = {}
chore_protos.route = {}
chore_protos.vendor = {}
chore_protos.xmog = {}
chore_protos.till = {}
chore_protos.auction = {}
chore_protos.crafting = {}

local chore_proto={}

function chore_proto:Init()
	self.time = self.time or 60

	if self.typ=="route" then self:InitRoute() end
end

function chore_proto:SetPriceModel(model)
	self._pricemodel = model
end

function chore_proto:CalculateDetails()
	if self.calculated_details then return self.calculated_details end
	local dyna_title = {}
	local s = ""

	self.display_name = nil

	if self.items then
		--local ids_sorted = {}
		--for itemid,count in pairs(chore.items) do tinsert(ids_sorted,itemid) end
		--sort(ids_sorted,function(a,b) return chore.items[a]>chore.items[b] end)

		local itemstrings = {}
		local good_items = {}
		self.good_items=good_items
		local bad_items = {}
		self.bad_items=bad_items

		self.has_unstable=nil
		self.has_gouged=nil
		self.has_empty=nil

		self.scale=100 -- we'll be adjusting this right below.

		--for quality=3,0,-1 do
			
		local trends = ZGV.Gold.servertrends
		trends = trends and trends.items

			--for i,itemid in ipairs(ids_sorted) do
			--	local count=chore.items[itemid]

		local herbalism = ZGV:GetSkill("Herbalism").level
		local mining = ZGV:GetSkill("Mining").level
		self.crap_rate=false
			
		for i,itemdata in ipairs(self.items) do
			local itemid,count,crap=unpack(itemdata)
			count = count or 1
			local itemname,itemlink,_,_,_,_,_,_,_,itemicon,itemvendor = GetItemInfo(itemid)

			if self.meta and self.meta.herbalismcrapuntil and herbalism<self.meta.herbalismcrapuntil then  count=count/10  self.crap_rate=true end
			if self.meta and self.meta.miningcrapuntil and mining<self.meta.miningcrapuntil then  count=count/10  self.crap_rate=true  end
			--if itemq and itemq>0 then

			local trend = trends and trends[itemid]

			if not crap then
				-- primary items

				itemdata.stable = trend and trend.health==1
				if self.typ=="xmog" then itemdata.stable=true end  -- xmog is always stable, or so we say. 

				local useful = ZGVG.usefulness[itemid]
				
				local vendor,scanprice = ZGVG:GetItemPrice(itemid)
				local sellprice, statusId,statusText,statusIcon = ZGVG:GetSellPrice(itemid)

				itemdata.vendorprice=vendor

				if self.typ=="xmog" then sellprice=scanprice or trend.p_md end  -- xmog is sooo gullible

				if trend and itemdata.stable then

					itemdata.price = sellprice

					itemdata.demand = trend.q_md or (trend.q_lo + trend.q_hi)/2  -- TEMPORARY. Doubling the market is bad too, but we have to start with something.
					if self.typ=="xmog" then itemdata.demand=1 end  -- xmog is always wanted... marginally.

					itemdata.scale = itemdata.demand/count

					-- scale whole route
					if self.scale>itemdata.scale then  self.scale=itemdata.scale  end
					--if itemdata.scale<1 then  self.has_overscaled=true  end

					if statusId==PRICESTATUS_GOUGED then
						self.has_gouged=true
						itemdata.gouged=true
					elseif statusId==PRICESTATUS_EMPTY then
						self.has_empty=true
						itemdata.empty=true
					end


					local is = ("%d %s (%s each = %s total); demand: %d  %s%s"):format(
						count, itemlink or "#"..itemid,
						ZGV.GetMoneyString(itemdata.price),ZGV.GetMoneyString(itemdata.price*count),
						itemdata.demand,
						itemdata.scale<1 and (" |cffff0000LOW DEMAND, %d daily max!|r"):format(itemdata.demand) or "",
						itemdata.gouged and (" |cff88ff00GOUGED: %s > %s|r"):format(ZGV.GetMoneyString(price),ZGV.GetMoneyString(trend.p_hi*ZGVG.OVERPRICE))
							or (itemdata.empty and (" |cff00ff00EMPTY!|r") or "")
						)

					tinsert(good_items,{itemname,is,count=count,price=itemdata.price,profit=itemdata.price*count,stable=true,itemdata=itemdata})


				elseif trend and not itemdata.stable then

					itemdata.price = trend.p_md or vendor or 0

					self.has_unstable=true
				
					local is = ("%d %s (%s each = %s total); |cffff0000market unstable|r"):format(
						count, itemlink or "#"..itemid,
						ZGV.GetMoneyString(itemdata.price),ZGV.GetMoneyString(itemdata.price*count)
					)

					tinsert(bad_items,{itemname,is,count=count,price=itemdata.price,profit=itemdata.price*count,stable=false,itemdata=itemdata})


				elseif not trend then

					itemdata.price = vendor or 0

					local is = ("%d %s (%s each = %s total); %s|cffaa0000no history data|r"):format(
						count, itemlink or "#"..itemid,
						ZGV.GetMoneyString(itemdata.price),ZGV.GetMoneyString(itemdata.price*count),
						useful and "useful, but " or ""
						)

					tinsert(bad_items,{itemname,is,count=count,price=itemdata.price,profit=itemdata.price*count,stable=false,itemdata=itemdata,no_trend=true})

				end
			
				
			elseif crap and count>=10 then

				itemdata.stable=false
				itemdata.demand=0

				itemdata.price = ZGVG:GetItemPrice(itemid) or vendor or 0

				local is = ("%d %s (%s each = %s total) |cff888888<- vendor|r"):format(count,itemlink or "#"..itemid,ZGV.GetMoneyString(itemdata.price),ZGV.GetMoneyString(itemdata.price*count))

				tinsert(bad_items,{itemname,is,count=count,price=itemdata.price,profit=itemdata.price*count,itemdata=itemdata,no_trend=true})

			end

		end

		GOODITEMS=good_items
		sort(good_items,function(a,b)
			if a.stable and b.stable then return a.profit>b.profit
			elseif a.stable~=b.stable then return a.stable
			else return a.profit>b.profit
			end
		end)
		for i,it in ipairs(good_items) do
			tinsert(itemstrings,it[2])
			if it.stable then tinsert(dyna_title,it[1]) end
		end

		if #bad_items>0 then
			tinsert(itemstrings,"---------")
			sort(bad_items,function(a,b)
				if a.stable and b.stable then return a.profit>b.profit
				elseif a.stable~=b.stable then return a.stable
				else return a.profit>b.profit
				end
			end)
			for i,it in ipairs(bad_items) do
				tinsert(itemstrings,it[2])
			end
		end

		--end
		s = s .. (" - get (per hour):\n%s\n"):format(table.concat(itemstrings,"\n"))
	end

	--[[
	if self.mobs  then
		local mobs={}
		for m,mid in ipairs(self.mobs) do
			tinsert(mobs,ZGV.Localizers:GetTranslatedNPC(mid) or mid)
		end
		s = s .. ("\n - kill %s\n"):format(table.concat(mobs,", "))
	end
	--]]

	if self.typ=="route" then
		local quality = nil
		if self.good_items and #self.good_items>0 then
			_,_, quality ,_,_,_,_,_,_,_,_ = GetItemInfo(self.good_items[1]["itemdata"][1])
			self.display_name = table.concat(dyna_title," / ")
		elseif self.bad_items and #self.bad_items>0 then
			_,_, quality ,_,_,_,_,_,_,_,_ = GetItemInfo(self.bad_items[1]["itemdata"][1])
			self.display_name = self.bad_items[1][1]
		end
		if quality then
			local r, g, b, hex = GetItemQualityColor(quality);
			self.display_name="|c"..hex..self.display_name
		end
	end

	if ZGV.db.profile.debug_show_gold_titles_plain then self.display_name=nil end


	self.display_name = self.display_name or self.name


	self.calculated_details = s

	return s
end

function chore_proto:AreRequirementsMet(ignore_skill,ignore_level)
	if ZGV.Gold.any_skill then ignore_skill=true end
	if ZGV.Gold.any_level then ignore_level=true end
	if self.meta then
		if self.meta.levelreq and not ignore_level then
			local level = ZGV:GetPlayerPreciseLevel()
			if type(self.meta.levelreq)=="number" and level<self.meta.levelreq then return false,"level" end
			if type(self.meta.levelreq)=="table" and level<self.meta.levelreq[1] then return false,"level" end
		end
		if self.meta.skillreq and not ignore_skill then
			for skill,skillid in pairs(ZGV.skillIDs) do
				local req = self.meta.skillreq[string.lower(skill)]
				if req and (ZGV:GetSkill(skill).level<req) then return false,"skill" end
			end
		end
	end
	if self.guide and self.guide:GetStatus()=="INVALID" then return false,"badguide" end
	return true
end



local choreset_proto = {}




function ZGVG.compare_chores(a,b)
	a,b=a:GetProfitPerHour(),b:GetProfitPerHour()
	return a>b
end

function ZGVG.compare_chores_goldrun(a,b)
	if a.time and b.time and a.time~=b.time then
		return a.time<b.time
	else -- times equal
		a=a.GetProfit and a:GetProfit() or (a.gold and a.gold*10000) or 0
		b=b.GetProfit and b:GetProfit() or (b.gold and b.gold*10000) or 0
		return a>b
	end
end

function ZGVG.compare_chores_useful(a,b)
	a,b=a.useful or 0,b.useful or 0
	return a>b
end

function ZGVG.compare_chores_smart(a,b)
	local pa,pb=a:GetSmartProfitPerHour(),b:GetSmartProfitPerHour()
	return pa>pb
end

function ZGVG.compare_chores_auction(a,b)
	a,b=a.profit,b.profit
	return a>b
end

function ZGVG.compare_chores_crafting(a,b)
	if a.profit and b.profit and a.profit~=b.profit then
		return a.profit>b.profit
	else -- times equal
		return a.recipe.name<b.recipe.name
	end
end





setmetatable(chore_protos.daily,{__index=chore_proto,__lt=ZGVG.compare_chores})
setmetatable(chore_protos.vendor,{__index=chore_proto,__lt=ZGVG.compare_chores})
setmetatable(chore_protos.xmog,{__index=chore_proto,__lt=ZGVG.compare_chores})
setmetatable(chore_protos.till,{__index=chore_proto,__lt=ZGVG.compare_chores})
setmetatable(chore_protos.route,{__index=chore_proto})
setmetatable(chore_protos.auction,{__index=chore_proto})
setmetatable(chore_protos.crafting,{__index=chore_proto})








function chore_protos.daily:GetType()
	return "daaaaily"
end

function chore_protos.daily:GetProfitPerHour()
	local time = self.time
	if type(time)=="table" then time=(time[1]+time[2])/2 end
	ZGV:Debug("&gold "..time.." "..self.gold.." ".. (self.gold*10000) * 60 / (time or 60))
	return (self.gold*10000) * 60 / (time or 60)
end









function chore_protos.route:GetType()
	return "routeeee"
end

function chore_protos.route:GetProfitPerHour()  -- NOT SMART. Stupid as hell.
	if not self:AreRequirementsMet() then return -1 end
	local profit=0
	if not self.items then return 0 end
	for i,pair in ipairs(self.items) do
		local id,num,crap=unpack(pair)
		local vendorprice,ahprice = ZGVG:GetItemPrice(id)
		if not crap and ahprice>0 then
			profit=profit + num * ahprice
		else
			profit=profit + num * (vendorprice or 0)
		end
	end
	self.profitperhour_is_smart=false
	return profit * 60 / self.time
end

function chore_protos.route:GetSmartProfitPerHour()
	if not self:AreRequirementsMet() then return -1 end
	if self.profitperhour then return self.profitperhour end
	local profit=0
	if not self.items then return 0 end

	local trends = ZGV.Gold.servertrends
	if not trends then return self:GetProfitPerHour() end  -- not so smart without trends
	trends=trends.items

	if not self.calculated_details then self:CalculateDetails() end -- this calculates self.items, self.good_items etc
	for i,itemdata in ipairs(self.items) do
		local id,num,crap=unpack(itemdata)
		num = num or 1
		local trend = trends[id]
		if not crap and itemdata.stable then
			-- good healthy profits!

			-- WAIT. Gouged? Missing?
			profit = profit + num * itemdata.price

		else
			-- otherwise assume vendor
			profit=profit + num * itemdata.vendorprice
			-- or ZERO PROFIT HERE!
		end
	end

	self.profitperhour = profit * 60 / self.time
	self.profitperhour_is_smart=true
	return self.profitperhour
end

-- parse out mobs, items, maps...
function chore_protos.route:InitRoute()
	if self.route then
		if type(self.route.map)=="string" then self.route.map=ZGV.LibRover.data.MapIDsByName[self.route.map] or 0 end

		-- split route into points
		if type(self.route.points)=="table" and type(self.route.points[1])=="number" then
			local pts={}
			for i=1,#self.route.points,2 do
				local x,y=self.route.points[i],self.route.points[i+1]
				tinsert(pts,{map=self.route.map,floor=0,x=x,y,y})
			end
			self.route.points=pts
		end

	end

	-- parse mob IDs
	if type(self.mobs)=="table" then
		local _
		for i=1,#self.mobs do
			local mob = self.mobs[i]
			if type(mob)=="string" then _,self.mobs[i]=ZGV.Parser.ParseID(mob) end
			if not self.mobs[i] then ZGV:Debug("&gold Bad mob ID in chore route: "..self.name.."-"..mob) end
		end
	end

	-- parse items
	if type(self.items)=="table" then
		for i,pair in ipairs(self.items) do
			local item,count=unpack(pair)
			local _
			local id=tonumber(item)
			if not id and type(item)=="string" then
				_,id=ZGV.Parser.ParseID(item)
				pair[1]=id
			end
			if not id then ZGV:Debug("&gold Bad item in chore route: "..self.name.."-"..item) end
			pair[1],pair[2]=id,count
		end
	end
end

function chore_protos.route:tostring()
	return self.name or (self.guide and self.guide.title_short and "GUIDE: ".. self.guide.title_short) or ""
end

--[[
		adb = ns.adb.auctionator["Alliance"]

		GetLastListings = function (item)
			if not adb[item] then return end
			local lday = 0
			local i
			for day, data in pairs(adb[item]) do
				if day > lday then
					lday, i = day, data
				end
			end
			if i then return i.posts.current, i.posts.min, i.posts.max end
		end

--]]



local prices={}

local UNDERCUT=1 - 0.01
local AHCUT=1 - 0.05
local M=ZGV.GetMoneyString

local function UNDERCUT(price,limit)
	local uc=0
	if price>1000000 then uc=10000
	elseif price>100000 then uc=1000
	elseif price>10000 then uc=100
	elseif price>1000 then uc=10
	elseif price>100 then uc=5
	else uc=1 end
	while price-uc<=limit do uc=floor(price-limit)/4 end
	return price-uc
end

function chore_protos.auction.GetAuctionChoreData(id,ST,auctions,chore,tooltip,arr)
	if chore then id=chore.itemid end

	
	table.wipe(prices)
	for price,count in pairs(auctions) do
		if type(price)=="number" then tinsert(prices,price) end
	end
	table.sort(prices)


	local targetprice
	if not chore then
		targetprice=0
		for pi=1,#prices do
			targetprice=prices[pi]
			if targetprice>=ST.p_lo then  break  end
		end
		if targetprice<ST.p_lo then targetprice=ST.p_lo end
		if targetprice>ST.p_hi then targetprice=0 end
	else
		targetprice=chore.targetprice
	end

	
	local name,link,_,_,_,class,subclass,_,_,icon,vendor  = GetItemInfo(id)

	local limitcount=ST.q_lo

	if tooltip then
		tooltip:AddLine(("Good prices for %s are from %s to %s."):format(link,M(ST.p_lo),M(ST.p_hi)))
		tooltip:AddLine(("Aiming for: %s. Demand limit: %d"):format(M(targetprice),limitcount))
		tooltip:AddLine("BUYOUT up to...")
	end


	local totalcount=0
	local totalcost=0

	local maxprofit=0
	local maxprofitprice=0
	local maxnextprice=0
	local maxprofittotalcost=0
	local maxprofittotalcount=0

	local lastprofit=0


	for pi=1,#prices do
		local price=prices[pi]
		local count=auctions[price]
		-- suppose we buy those...
		totalcost = totalcost + price * count
		totalcount = totalcount + count

		local nextprice = min(prices[pi+1] or 99999999,price<targetprice and targetprice or 99999999)
		if pi==#prices then nextprice=price end

		local saleprice = nextprice
		if saleprice==prices[pi+1] then saleprice=UNDERCUT(saleprice,price) end


		local sale = totalcount * saleprice
		local profit = floor((sale*AHCUT)-totalcost)
		local perc = (profit/totalcost)*100
		--if totalcount>chore.count then break end

		local blockade = profit<=lastprofit
		lastprofit=profit

		if (not chore or arr) then
			if nextprice==99999999 then break end
			if price>=targetprice then break end
			if totalcount>limitcount then break end
		end

		-- else...

		if not chore then
			if profit>maxprofit then
				maxprofit=profit
				maxprofitprice=price
				maxnextprice=nextprice
				maxprofittotalcost=totalcost
				maxprofittotalcount=totalcount
			end
		end
		if tooltip then
			local r,g,b
			if price==chore.price then r,g,b=0.3,1,0 end
			tooltip:AddLine(("|cff%s>>>|r %d x %s (cost: %s, sell |cffffffff%d|r at %s for %s, profit: %s (%d%%))"):format(
			 (profit<=0 and "888888") or
			 (price==chore.price and "00ff00") or
			 (price<chore.price and (blockade and "ff8800" or "ffff00")) or
			 (price>chore.price and (blockade and "aa0000" or "ff0000")),
			count,M(price),
			M(totalcost),
			totalcount,M(saleprice),M(sale), -- sell x at x for x
			M(profit),
			perc)
			, r,g,b)
		end
		--]]
		--[[
		if chore then
			print(("|cff%s>>>|r %d x %s (cost: %s, sell |cffffffff%d|r at %s for %s, profit: %s (%d%%))"):format(
			 (profit<=0 and "888888") or
			 (price==chore.price and "00ff00") or
			 (price<chore.price and (blockade and "ff8800" or "ffff00")) or
			 (price>chore.price and (blockade and "aa0000" or "ff0000")),
			count,M(price),
			M(totalcost),
			totalcount,M(saleprice),M(sale), -- sell x at x for x
			M(profit),
			perc)
			, r,g,b)
		end
		--]]

		if arr then
			local color = (profit<=0 and "888888") or  (price==chore.price and "00ff00") or
			 (price<chore.price and (blockade and "ff8800" or "ffff00")) or
			 (price>chore.price and (blockade and "aa0000" or "ff0000"))
			tinsert(arr,{
				count=count,
				totalcost=totalcost,
				totalcount=totalcount,
				saleprice=saleprice,
				sale_v1=sale,
				profit_v1=profit,
				perc=perc,

				blockade=blockade,
				color=color,

				name=name,
				targetprice=targetprice,
				price=price,
				cost=price*count,
				sale=saleprice*count,
				profit=((saleprice-price)*count)
				})
		end

		if (not chore or arr) and nextprice>=targetprice then break end
		--if price>=targetprice then break end
	end


	local itemstatus = 0
	local itemstatus_override = false

	local flags = {}

	table.wipe(flags)
	if ZGV.Gold.Auctions.BaseValues[class] and ZGV.Gold.Auctions.BaseValues[class][subclass] then
		for i,v in pairs(ZGV.Gold.Auctions.BaseValues[class][subclass]) do
			table.insert(flags,v)
		end
	end

	if ZGV.Gold.Auctions.ItemStatus[id] then
		for i,v in pairs(ZGV.Gold.Auctions.ItemStatus[id]) do
			if i~="OVERRIDE" then table.insert(flags,v) end
		end
		if ZGV.Gold.Auctions.ItemStatus[id].OVERRIDE then
			status_override = ZGV.Gold.Auctions.ItemStatus[id].OVERRIDE
		end
	end

	if itemstatus_override then
		itemstatus = itemstatus_override
	else	
		itemstatus = 0
		for i,flag in pairs(flags) do
			if shooter_explain then 
				print(flag,ZGV.Gold.Auctions.Flags[string.upper(flag)].mod)
				table.insert(shooter_debug[2],ZGV.Gold.Auctions.Flags[string.upper(flag)])
			end
			itemstatus = itemstatus + ZGV.Gold.Auctions.Flags[string.upper(flag)].mod
		end
	end

	
	local category = 4
	if class == ZGV.L["type_armor"] or class == ZGV.L["type_weapon"] then
		category = 1
	elseif class == ZGV.L["type_trade_goods"] then
		category = 2
	elseif class == ZGV.L["type_consumable"] then
		category = 3
	end

	if not chore and maxprofit>0 and targetprice>0 and maxprofittotalcost<GetMoney() then
		chore = {typ="auction",
			itemid=id,
			name=GetItemInfo(id),
			cost=maxprofittotalcost,
			count=maxprofittotalcount,
			profit=maxprofit,
			price=maxprofitprice,
			perc=(maxprofit/maxprofittotalcost)*100,
			at_target=(maxnextprice==targetprice),
			targetprice=targetprice,
			itemstatus=itemstatus,
			category=category,
			flags=flags
			}
		setmetatable(chore,{__index=ZGVG.chore_protos.auction})
	
		return chore
	end

end



local function Chore_GetProfit_Items(self)
	if not self:AreRequirementsMet() then return -1 end
	local profit=0
	if not self.items then return 0 end

	--[[
	for i,pair in ipairs(self.items) do
		local id,num,crap=unpack(pair)
		local vendorprice,ahprice = ZGVG:GetItemPrice(id)
		if not crap and ahprice>0 then
			profit=profit + num * ahprice
		else
			profit=profit + num * (vendorprice or 0)
		end
	end
	--]]
	for i,item in pairs(self.good_items) do
		profit = profit + item.profit
	end
	return profit
end

local function Chore_GetProfitPerHour_Items(self)
	if not self:AreRequirementsMet() then return -1 end
	return self:GetProfit() * 60 / (type(self.time)=="number" and self.time or self.time[1]+self.time[2]/2)
end

function EG(requested)
	print("Running EG on",requested)
	if not requested then
		ZGV:Debug("&gold No id given")
		requested = 104403
	end
	local debugstate = ZGV.db.profile.debug
	ZGV.db.profile.debug = true
	local recipe
	for skillid,skills in pairs(ZGV.Gold.Crafting.AllRecipes) do
		for spellid,recipe in pairs(ZGVG.Crafting.AllRecipes[skillid]) do
			if spellid == requested then
				ZGV:Debug("&gold "..skillid..","..spellid)
				Spoo(nil,nil,ZGVG.Crafting.AllRecipes[skillid][spellid])
				ZGV.Gold.chore_protos.crafting.GetCraftingDetails(ZGVG.Crafting.AllRecipes[skillid][spellid],skillid)
			end
		end
	end
	ZGV.db.profile.debug = debugstate
end 

function chore_protos.crafting.GetCraftingDetails(recipe,skillid)
	local cost = 0
	local price = 0
	local profit = 0
	local costcomment = ""
	local profitcomment = ""
	local comments = {}
	local items_buy = {}
	local items_craft = {}
	local items_farm = {}
	local items_vendor = {}
	local comment_line = 1
	local expert = false
	local unknown = false
	local skip = false

	if not next(ZGV.Gold.Crafting.CraftToRecipe) then	
		ZGV:Debug("Filling craft table")
		ZGV.Gold.Crafting:GetCraftToRecipe()
	end

	if not next(ZGV.Gold.Crafting.AllCraftToRecipe) then	
		ZGV:Debug("Filling all crafts table")
		ZGV.Gold.Crafting:GetAllCraftToRecipe()
	end

	local function get_source_for(itemId)
		if ZGV.Gold.Crafting.ItemSources[itemId] and ZGV.Gold.Crafting.ItemSources[itemId]["vendor"] then
			return "vendor" -- some npc sells it
		end
		
		Gratuity:SetHyperlink("item:"..itemId)
		local n = Gratuity:NumLines()
		local isbop = false

		for i=1,n do
			local line=Gratuity:GetLine(i)
			if line then
				isbop = isbop or strfind(line, ITEM_BIND_ON_PICKUP)
			end
		end
		local iscraftable = ZGV.Gold.Crafting.CraftToRecipe[itemId]
		local iscraftableatall = ZGV.Gold.Crafting.AllCraftToRecipe[itemId]

		if isbop and iscraftableatall and iscraftable then return "craft" end	-- only way to get it is to craft it
		if isbop and iscraftableatall and not iscraftable then return "craft but cannot" end	-- only way to get it is to craft it, but we cannot
		if not isbop and iscraftableatall and not iscraftable then return "buy crafted" end	-- someone else has to make it
		if not isbop and not iscraftable then return "buy" end	-- someone else has to make it
		if isbop and iscraftable then return "craft but cannot" end	-- we can learn to make it
		if isbop then return "farm" end				-- we have to farm it
		return "craft or buy"					-- maybe we can craft it
	end

	local function add_comment_line(icon,text,num,link,price)
		if price then price = ZGV.GetMoneyString(tonumber(price)) end
		comments[#comments+1] = {icon,text,num,link,price}
	end

	local function add_to_guide_list(itemtable,itemid,itemname,number,link,totalprice,maxprice,expert)
		if not expert then expert = false end
		totalprice = tonumber(totalprice)
		maxprice = tonumber(maxprice)
		local _,_,_,_,_,_,_,_,_,icon = GetItemInfo(itemid)
		if itemtable[itemid] then
			itemtable[tonumber(itemid)].count = itemtable[itemid].count + tonumber(number)
			itemtable[tonumber(itemid)].totalprice = itemtable[itemid].totalprice + tonumber(totalprice)
			itemtable[tonumber(itemid)].maxprice = itemtable[itemid].maxprice + tonumber(maxprice)
		else
			itemtable[tonumber(itemid)] = { count = tonumber(number), icon=icon, link=link, id=itemid, name=get_name_from_link(itemname), totalprice=totalprice, maxprice=maxprice, expert=expert }
		end
	end

	function get_name_from_link(link)
		return string.gsub(link,"(.*)|c(.*)|h%[(.*)]|h(.*)","%3")
	end

	local function get_item_price(id)
		local ST=ZGV.Gold.servertrends
		local price = 0
		if ST and ST.items[id] and ST.items[id].p_md~=0 then
			price = ST.items[id].p_md
		else
			price = ZGVG:GetItemPrice(id)
		end

		return price
	end

	local function get_ah_prices(id,needed)
		local scandata = ZGV.db.realm.gold_scan_data[1]
		local total_price = 0
		local max_price = 0
		local item_found = 0
		local expert = false

		if not scandata or not scandata[id] then
			expert = true
			return total_price,max_price,expert
		end

		ZGV:Debug("Scan data found")
		for scanprice,scanamount in pairs(scandata[id]) do
			if scanprice ~= "__orderedIndex" then
				local need = needed - item_found
				local found = math.min(need,scanamount)
				item_found = item_found + found
				total_price = total_price + (found*scanprice)

				max_price = math.max(max_price,scanprice)

				if item_found == needed then
					ZGV:Debug("Found enough")
					break
				end
			end
		end

		if item_found < needed then 
			ZGV:Debug("Not enough")
			expert = true
			total_price = get_item_price(id)*needed
			max_price = get_item_price(id)
		end

		ZGV:Debug("Result: "..total_price.." "..max_price.." "..tostring(expert))
		return total_price,max_price,expert
	end




	for i,comp in pairs(recipe.reagents) do
		local component_cost_to_buy = 0
		local component_cost_to_craft = 0
		local component_cost = 0

		local subcost = 0

		local source = get_source_for(comp.id)
		local component_rec = ZGV.Gold.Crafting.CraftToRecipe[comp.id]
 
		local compname, complink,_,_,_,_,_,_,_,compicon = GetItemInfo(comp.id)

		local craftsNeeded = comp.num
		if component_rec then
			craftsNeeded = math.ceil(comp.num/component_rec.nummade[1])
		end

		if not compname or not complink then
			compname = "unknown, propably wod"
			complink = ""
			ZGV:Debug("No idea what this is: "..comp.id)
			--skip = true
			--return 0, 0, {}, {}, {}, {}, false, true, true
		end

		ZGV:Debug("Checking "..complink)
		ZGV:Debug("Source returned: " ..source)

		if source == "vendor" then
			local single = ZGV.Gold.Crafting.ItemSources[comp.id]["cost"]
			local total = single * comp.num
			add_to_guide_list(items_vendor,comp.id,complink,comp.num,complink,single,total)
			subcost = total
		elseif source == "farm" then
			ZGV:Debug("Adding "..complink.." to farm")
			
			add_to_guide_list(items_farm,comp.id,complink,comp.num,complink,0,0)
			add_comment_line(compicon,"Farm",comp.num,complink)
			expert = true
		elseif source == "craft or buy" then
			ZGV:Debug("Adding "..complink.." to craft/buy")
				

			local component_cost_to_buy, _, localExpert = get_ah_prices(comp.id,comp.num)
			local component_expert = false

			for i,subcomp in pairs(component_rec.reagents) do
				local _ = GetItemInfo(subcomp.id)

				ZGV:Debug("Checking "..subcomp.id.." for "..recipe.name)
				local subcomp_price, max_price, localExpert = get_ah_prices(subcomp.id,subcomp.num)
				ZGV:Debug("Checking "..subcomp.id.." for "..recipe.name.." - price is "..subcomp_price)
				expert = expert or localExpert
				component_expert = expert or component_expert

				component_cost_to_craft = component_cost_to_craft + subcomp_price
				ZGV:Debug("Checking "..subcomp.id.." for "..recipe.name.." - component_cost_to_craft is "..component_cost_to_craft)
			end


			
			if component_cost_to_buy<component_cost_to_craft and not component_expert then
				ZGV:Debug("Adding "..complink.." to buy")
				add_comment_line(compicon,"Buy",comp.num,complink,component_cost_to_buy)
				add_to_guide_list(items_buy,comp.id,complink,comp.num,complink,component_cost_to_buy,component_cost_to_buy)
				subcost = subcost + component_cost_to_buy
			else
				ZGV:Debug("Adding "..complink.." to craft")
				add_comment_line(compicon,"Craft",comp.num,complink)
				add_to_guide_list(items_craft,comp.id,complink,comp.num,complink,0,0)


				for i,subcomp in pairs(component_rec.reagents) do
					local _ = GetItemInfo(subcomp.id)
					local subcomp_price, max_price, localExpert = get_ah_prices(subcomp.id,subcomp.num*craftsNeeded)
					expert = expert or localExpert

					ZGV:Debug("Adding "..subcomp.link.." to buy")

					add_comment_line(subcomp.texture," + buy",(craftsNeeded*subcomp.num),subcomp.link,subcomp_price)
					add_to_guide_list(items_buy,subcomp.id,subcomp.link,subcomp.num*craftsNeeded,subcomp.link,subcomp_price,max_price,localExpert)
					ZGV:Debug("subcomp_price for subcomp.id is "..tostring(subcomp_price))
					subcost = subcost + subcomp_price
					
					--[[
					add_comment_line(subcomp.texture," + buy",(craftsNeeded*subcomp.num),subcomp.link,subcompcost)
					add_to_guide_list(items_buy,subcomp.id,subcomp.link,subcomp.num*craftsNeeded)
					subcost = subcost + (subcomp.num*subcompcost)
					--]]
				end
			end
		elseif source == "craft" or source == "craft but cannot" then
			add_comment_line(compicon,"Craft",comp.num,complink)
			local craftexpert = false or (source == "craft but cannot")
			add_to_guide_list(items_craft,comp.id,complink,comp.num,complink,0,0,craftexpert)
			ZGV:Debug(source.." "..comp.num.." "..complink)
			ZGV:Debug("Adding "..complink.." to craft "..source)
			if component_rec and not craftexpert then
				ZGV:Debug("Rec known")
				for i,subcomp in pairs(component_rec.reagents) do
					local _ = GetItemInfo(subcomp.id)
					local component_cost_to_craft, max_price, localExpert = get_ah_prices(subcomp.id,subcomp.num*craftsNeeded)
					expert = expert or localExpert
					add_comment_line(comp.texture," + buy",(craftsNeeded*subcomp.num),subcomp.link,subcompcost)
					add_to_guide_list(items_buy,subcomp.id,subcomp.link,subcomp.num*craftsNeeded,subcomp.link,component_cost_to_craft,max_price,localExpert)
					--ZGV:Debug("Sub: " .. subcomp.link .." , ".. subcompcost.." , "..subcomp.num*subcompcost)
					subcost = subcost + component_cost_to_craft
				end
			end
		else  -- buy ZGVG:GetItemPrice
			ZGV:Debug("Adding "..complink.." fallback to buy")
			local component_cost_to_buy, max_price, localExpert = get_ah_prices(comp.id,comp.num)
			expert = expert or localExpert
			if component_cost_to_buy == 0 then
				component_cost_to_buy = get_item_price(comp.id)*comp.num -- fallback, get some price at least
				max_price = get_item_price(comp.id)			 -- fallback, get some price at least
			end

			add_comment_line(compicon,"Buy",comp.num,complink,component_cost_to_buy)
			add_to_guide_list(items_buy,comp.id,complink,comp.num,complink,component_cost_to_buy,max_price,localExpert)
			subcost = component_cost_to_buy
		end
		ZGV:Debug("Subcost".." , "..(subcost or 0))

		cost = cost + subcost
	end

	ZGV:Debug("Final crafting cost".." , "..(cost or 0))

	--if recipe.producttype=="enchant" then
	if skillid==333 then
		local scrollId = ZGV.Gold.Crafting.EnchantToScroll[recipe.spell]
		if not scrollId then
			ZGV:Debug("Unknown scroll ID")
			price = ZGVG:GetSellPrice(tonumber(recipe.spell))
		else
			ZGV:Debug("Getting sell price for known scroll "..scrollId)
			--price = get_item_price(tonumber(ZGV.Gold.Crafting.EnchantToScroll[recipe.spell]))
			price = ZGVG:GetSellPrice(scrollId)
		end
	else
		ZGV:Debug("Getting sell price for known item "..recipe.productid)
		price = ZGVG:GetSellPrice(recipe.productid)
	end
	ZGV:Debug("Final selling price".." , "..(price or 0))

	profit = math.max(0,price-cost)

	ZGV:Debug("Final profit".." , "..(profit or 0))

	unknown = not ZGV.Gold.Crafting.CraftToRecipe[recipe.productid]

	return cost, profit, comments, items_buy, items_craft, items_farm, items_vendor, expert, unknown, skip
end

function chore_protos.crafting.IsRelevant(recipe,cost,profit,expert,unknown)
	local filters = { rarity = 2, ilvl = 50, minlevel = 10 }
	_, _, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, _, _, _, _ = GetItemInfo(recipe.productid)


	if profit == 0 then return false end
	if cost == 0 then return false end

	if (not ZGV.db.profile.gold_crafting_mode or ZGV.db.profile.gold_crafting_mode == 0) and expert then return false end

	if unknown then
		if ZGV.db.profile.gold_crafting_mode and ZGV.db.profile.gold_crafting_mode == 1 then
			if recipe.source == "undefined" then 
				return false
			end
		else 
			return false
		end
	end


	--	if itemRarity and itemRarity < filters.rarity then return false end
	--	if itemLevel and itemLevel < filters.ilvl then return false end


	return true
end



chore_protos.vendor.GetProfit = Chore_GetProfit_Items
chore_protos.vendor.GetProfitPerHour = Chore_GetProfitPerHour_Items
chore_protos.xmog.GetProfit = Chore_GetProfit_Items
--chore_protos.xmog.GetProfitPerHour = Chore_GetProfitPerHour_Items
chore_protos.xmog.GetProfitPerHour = Chore_GetProfit_Items

chore_protos.till.GetProfit = Chore_GetProfit_Items




ZGV.Gold.chores = {}

local chores=ZGV.Gold.chores

function ZGV.Gold.chores:AddChore(data)
	local typ = data.typ
	setmetatable(data,{__index=chore_protos[typ] or chore_proto,__lt=ZGVG.compare_chores})

	data:Init()

	-- store
	if not chores[typ] then local choreset={} setmetatable(choreset,{__index=choreset_proto}) chores[typ]=choreset end
	tinsert(chores[typ],data)
end

function ZGVG:GetSellPrice(itemid,itemCount)
	--ZGV:Debug("&Appraiser checking for "..itemCount.." "..itemid)
	itemCount = itemCount or 1
	local minprice = nil
	local scandata = ZGV.db.realm.gold_scan_data[1]
	local emptyMarket = true

	if not itemCount or itemCount=="" then 
		return 0, 0, "err", "err"
	end

	local errortext
	minprice,errortext = ZGVG.Scan:GetPrice(itemid)
	emptyMarket=not minprice

	local statusIcon, statusText, priceOverride


	if ZGV.db.profile.appraiser_undercut == 0 then
		undercutprice = (minprice or 0)
	elseif ZGV.db.profile.appraiser_undercut > 10000 then
		undercutprice = (minprice or 0) - (ZGV.db.profile.appraiser_undercut-10000)
	else
		undercutprice = (minprice or 0) * (1-(ZGV.db.profile.appraiser_undercut/100))
	end

	
	if ZGV.Gold.servertrends and ZGV.Gold.servertrends.items[itemid] then
		local itemtrend = ZGV.Gold.servertrends.items[itemid]

		if itemtrend.p_lo and itemtrend.p_lo > 0 then
			local highPrice = itemtrend.p_hi
			local lowPrice = itemtrend.p_lo	

			if ZGV.db.profile.gold_profitlevel then
				local level = ZGV.db.profile.gold_profitlevel
				local median = itemtrend.p_md or (itemtrend.p_hi+itemtrend.p_lo)/2
				if level<0.5 then
					lowPrice = itemtrend.p_lo + (median-itemtrend.p_lo)*level*2
				else
					lowPrice = median + (itemtrend.p_hi-median)*(level-0.5)*2
				end
			end
				

			if (undercutprice or 0) > 0 then
				if undercutprice > highPrice*ZGVG.OVERPRICE then
					statusIcon = "|cff00ff00^"
					statusText = "Prices gouged, sell now!"
					priceOverride = highPrice*ZGVG.OVERPRICE
					statusId = PRICESTATUS_GOUGED
				elseif undercutprice > highPrice then
					statusIcon = "|cff00ff00↑"
					statusText = "Prices are up, sell now!"
					statusId = PRICESTATUS_UP
				elseif undercutprice < lowPrice then
					statusIcon = "|cffff0000↓"
					statusText = "Prices are down, you may want to wait"
					statusId = PRICESTATUS_DOWN
				else
					statusIcon = "|cffffff00●"
					statusText = "Prices are normal"
					statusId = PRICESTATUS_NORMAL
				end
			else
				if emptyMarket or errortext=="no data for item" then
					statusIcon = "|cff00ff00●"
					statusText = "Market is empty, sell now!"
					statusId = PRICESTATUS_EMPTY
					priceOverride = highPrice*ZGVG.OVERPRICE
				else
					statusIcon = "|cFFAAAAAA?"
					statusText = "No scanner data for item"
					statusId = PRICESTATUS_NODATA
					priceOverride = 0
				end
			end

			if itemtrend.health and itemtrend.health~=1 then
				statusIcon = "|cFFFF0000●"
				statusText = "Item market unstable"
				statusId = PRICESTATUS_UNSTABLE
			end
		else
			statusIcon = "|cFFAAAAAA●"
			statusText = "No trend data for item"
			statusId = PRICESTATUS_NODATA
			--priceOverride = 0
		end
	else
		statusIcon = "|cFFAAAAAA●"
		statusText = "No trend data for item"
		statusId = PRICESTATUS_NODATA
		--priceOverride = 0
	end

	--ZGV:Debug("&Appraiser priceOverride is "..(priceOverride or "not set"))
	--ZGV:Debug("&Appraiser undercutprice is "..(undercutprice or "not set").." conf "..ZGV.db.profile.appraiser_undercut)

	price = (priceOverride or (undercutprice>0 and undercutprice) or minprice) * itemCount

	--ZGV:Debug("&Appraiser returns "..(price or "error")	)

	return price, statusId, statusText, statusIcon
end