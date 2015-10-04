local ZGV=ZygorGuidesViewer
local ZGVG=ZygorGuidesViewer.Gold

local Gratuity = LibStub("LibGratuity-3.0")

--local GOLD_FORMAT_TYPE = 3 
local GOLD_FORMAT_TYPE = nil -- use type set in options

local FONT=ZGV.Font
local FONTBOLD=ZGV.FontBold
local FONTSTATUS="Fonts\\ARIALN.TTF"
local L = ZGV.L
local CHAIN = ZGV.ChainCall
local ui = ZGV.UI
local SkinData = ui.SkinData

local GOLD_FRAME_SIZE={820,560}
local GOLD_FRAME_ROW_WIDTH=748


local HEADER_HEIGHT = 100		-- exported to GoldHelp.lua
local FOOTER_HEIGHT = 30
local ICON_SIZE = 17

local TAB_HEIGHT=50
local TAB_WIDTH=80
local TAB_TEX_SIZE=36
local TAB_FONT_SIZE=15
local TAB_HEIGHT_ABOVE_TABLES = 10
local NUM_TABS = 5
local DIST_BETW_TABS = (GOLD_FRAME_SIZE[1]-TAB_WIDTH*NUM_TABS)/NUM_TABS

local COLHEADER_FONTSIZE = 13
local COLFOOTER_FONTSIZE = 12

local SCROLL_WIDTH=15		-- TODO This does not actual change the width, copied value from ScrollBar.lua. Need to change up scrollbar for it to actually change the width.
local TOGGLE_BUT_SIZE=10	-- TODO This does not actual change the size, 10 is the default size

-- Common Table
local ROWCOUNT=15
local ROW_HEADER = 20
local ROW_FOOTER = 30
local ROW_HEIGHT=(GOLD_FRAME_SIZE[2] - HEADER_HEIGHT - FOOTER_HEIGHT - ROW_HEADER - ROW_FOOTER) / ROWCOUNT
local ROW_FONTSIZE=12
local ROW_LOAD_BUT_SIZE=18--SkinData("GuideButtonSize")--ROW_HEIGHT/2
local ROW_LOAD_RIGHT_PADDING=5
local DROPDOWN_STYLE=2
local DROPDOWN_WIDTH=100
local DROPDOWN_WIDTH_WIDE=120
local DROPDOWN_HEIGHT=18
local DROPDOWN_HORZ_PADDING=5
local DROPDOWN_LABEL_PADDING=3

-- Left Mode Dropdown. Same for all tables. Value is for ZGVG.lowdemand
local EXPERTMODE_DROPDOWN_MODES = {
	{L['gold_expertmode_easylabel'],false,L['gold_expertmode_easytooltip']},
	{L['gold_expertmode_expertlabel'],true,L['gold_expertmode_experttooltip']},
}

-- Route Table
local ROUTE_COLUMNSIZES = { 40, 230, 110, 130, 60, 110 }
local ROW_ITEM_ICON_SIZE=ROW_HEIGHT-10
local ROW_ROUTE_COL_PADDING=10				-- Padding between icon and title
local ROW_ROUTE_GOLD_PADDING=10				-- Padding between item name and gold
local ROW_ROUTE_DEMAND_PADDING=20			-- Padding between gold and demand
local ROW_ROUTE_LIM_PADDING=10				-- Padding between demand and limit

-- Farm Table
local FARM_TYPE_DROPDOWN_OPTIONS = {
	{"All","all"},
	{"Cloths","cloth"},
	{"Elementals","elemental"},
	{"Food","food"},
	{"Gems","gem"},
	{"Misc","misc"},
}
local FARM_INFO_SUMMARY = "Make gold by farming and selling valuable items that drop off mobs (cloth, elementals, food, ect.). This is the best method for beginners without any profession skills."
local FARM_INFO_PROS = {
	"No profession skills required.",
	"Low risk. Little to no gold required.",
	"Earn XP while making gold (up to level 90).",
}
local FARM_INFO_CONS = {
	"Can be slow, tedious and boring",
	"Profit limits (can only farm items so fast)",
}
local FARM_INFO_DIFF_PERCENT = 20

-- Gather Table
local GATHER_PROF_DROPDOWN_OPTIONS = {
	{"All","all"},
	{"Herbalism","herbalism"},
	{"Mining","mining"},
	{"Skinning","skinning"},
	{"Fishing","fishing"},
	{"Enchanting","enchanting"},
}
local GATHER_INFO_SUMMARY = "Use gathering professions to make money by farming and selling raw materials (herbs, ores, skins). This is the best method players who want to make the most gold without getting into the more complex methods."
local GATHER_INFO_PROS = {
	"Most profitable of the easy methods.",
	"Low risk. Little to no gold required.",
}
local GATHER_INFO_CONS = {
	"Can be slow, tedious and boring",
	"Requires profession skills (preferably maxed out)",
	"Profit limits (can only farm items so fast)",
}
local GATHER_INFO_DIFF_PERCENT = 40

-- Gold Run Table
local GOLDRUN_COLUMNSIZES = { 40, 470, 80, 120 }
local ROW_GOLDRUN_ICON_SIZE = 15
local ROW_GOLD_COL_PADDING=10							-- Padding between icon and title
local ROW_GOLD_TYPE_PADDING=10	-- Padding between type icon and title icon. 
local GOLD_RIGHT_DROPDOWN_OPTIONS = {
	{"All","all"},
	{"Dailies","daily"},
	{"Vendor","vendor"},
	{"Tilling","till"},
	{"Transmog","xmog"},
}
local GOLD_INFO_SUMMARY = "Make gold by completing dailies, selling limited supply recipes, and growing valuable items on a farm. These are some of the easiest ways to make gold because they require no professions or startup capital, but they are usually the least profitable of all the methods."
local GOLD_INFO_PROS = {
	"Fun, varied, dynamic",
	"No profession skills required",
	"Little to no gold required",
}
local GOLD_INFO_CONS = {
	"Low profit in comparison to other methods.",
}
local GOLD_INFO_DIFF_PERCENT = 20

local GOLDRUNDETAIL_COLUMNS = {
	{ title="", width=10, titlej="LEFT", textj="LEFT", name="icon", typ="icon"  },
	{ title="ITEM", width=520, titlej="LEFT", textj="LEFT", name="desc" },
	{ title="PROFIT", width=120, titlej="LEFT", textj="RIGHT", name="price" },
}
local GOLDRUNITEMROWCOUNT = 30

-- Auction Table
local AUCTION_COLUMNS = {
	{ title="", width=40, titlej="LEFT", textj="LEFT", name="icon", typ="icon", font=FONT },
	{ title="ITEM", width=310, titlej="LEFT", textj="LEFT", name="title", font=FONT },
	{ title="", width=20, titlej="CENTER", textj="CENTER", name="status", font=FONTSTATUS },
	{ title="AMT", width=50, titlej="CENTER", textj="CENTER", name="amt", font=FONT },
	{ title="COST", width=105, titlej="RIGHT", textj="RIGHT", name="cost", font=FONT },
	{ title="PROFIT", width=105, titlej="RIGHT", textj="RIGHT", name="profit", font=FONT },
	{ title="GAIN", width=60, titlej="RIGHT", textj="RIGHT", name="gain", font=FONT },
}
local ROW_AUCTION_ICON_SIZE = 17
local ROW_AUCTION_COL_PADDING=10	-- Padding between icon and title
local ROW_AUCTION_TYPE_PADDING=10	-- Padding between type icon and title icon. 
local AUCTION_RIGHT_DROPDOWN_OPTIONS = {
	{"All","all"},
	{"Dailies","daily"},
	{"Vendor","vendor"},
	{"Tilling","till"},
}
local AUCTION_INFO_SUMMARY = "Play the Auction House to make money. Buy low, sell high. The most profitable method to make gold but the hardest to master."
local AUCTION_INFO_PROS = {
	"Quick profit (except for long-term investments)",
	"Almost unlimited profits",
}
local AUCTION_INFO_CONS = {
	"Startup capital required",
	"High risk. Can (and often will) face losses.",
	"Easy to mess up, difficult to master",
}
local AUCTION_INFO_DIFF_PERCENT = 90


local AUCTIONDETAIL_COLUMNS = {
--[[
	{ title="ITEM", width=150, titlej="LEFT", textj="LEFT", name="title" },
	{ title="EST. VALUE", width=100, titlej="CENTER", textj="RIGHT", name="estval" },
	{ title="CUR. PRICE", width=100, titlej="CENTER", textj="RIGHT", name="curpri" },
	{ title="AMT", width=30, titlej="CENTER", textj="RIGHT", name="amt" },
	{ title="COST", width=120, titlej="CENTER", textj="RIGHT", name="cost" },
	{ title="SELL", width=120, titlej="CENTER", textj="RIGHT", name="sell" },
	{ title="PROFIT", width=120, titlej="CENTER", textj="RIGHT", name="profit" },
--]]
	{ title="", width=30, titlej="LEFT", textj="RIGHT", name="count" },
	{ title="ITEM", width=150, titlej="LEFT", textj="LEFT", name="title" },
	{ title="WORTH", width=100, titlej="RIGHT", textj="RIGHT", name="worth" },
	{ title="CUR PRICE", width=105, titlej="RIGHT", textj="RIGHT", name="curpri" },
	{ title="BUY (ALL)", width=110, titlej="RIGHT", textj="RIGHT", name="buyall" },
	{ title="SELL (ALL)", width=110, titlej="RIGHT", textj="RIGHT", name="sellall" },
	{ title="AH CUT", width=105, titlej="RIGHT", textj="RIGHT", name="ahcut" },
	{ title="PROFIT", width=110, titlej="RIGHT", textj="RIGHT", name="profit" },
}

local AUCTIONDETAIL_COMMENT_ROWS = {
	{ title="PRO", textj="LEFT", name="pro", color={0,1,0,1} },
	{ title="CONS", textj="LEFT", name="cons", color={1,0,0,1} },
}


-- Crafting Table
local CRAFTING_COLUMNSIZES = { 30, 377, 60, 120, 120, 15 }
local ROW_CRAFTING_ICON_SIZE = 15
local ROW_CRAFTING_COL_PADDING= 20							-- Padding between icon and title
local CRAFTING_RIGHT_DROPDOWN_OPTIONS = {
	{"All","all"},
	{"Dailies","daily"},
	{"Vendor","vendor"},
	{"Tilling","till"},
}
local CRAFTING_INFO_SUMMARY = "Make gold by crafting profitable items and selling them on the auction house."
local CRAFTING_INFO_PROS = {
	"Profit limited only by demand",
}
local CRAFTING_INFO_CONS = {
	"Medium risk.",
	"Only really profitable at max skill level.",
}
local CRAFTING_INFO_DIFF_PERCENT = 60
local CRAFTINGDETAIL_COLUMNS = {
	{ title="", width=50, titlej="LEFT", textj="RIGHT", name="count" },
	{ title="ITEM", width=520, titlej="LEFT", textj="LEFT", name="desc" },
	{ title="EACH", width=100, titlej="LEFT", textj="RIGHT", name="maxprice" },
	{ title="TOTAL", width=100, titlej="LEFT", textj="RIGHT", name="totalprice" },
}

--[[
local CRAFTINGDETAIL_TOOLTIP_W = 200
local CRAFTINGDETAIL_TOOLTIP_H = 200
local CRAFTINGDETAIL_TOOLTIP_FONT = 11
local TOOLTIP_ITEMROWCOUNT = 50
--]]

local ITEMROWCOUNT=20

local TIER_DEMAND_HIGH = 1.0
local TIER_DEMAND_MEDIUM = 0.5

local COLOR_VENDOR = "|cffaaaaaa"
local COLOR_DEMANDLOW = "|cffff0000"
local COLOR_DEMANDGOOD = "|cffffff00"
local COLOR_DEMANDGREAT = "|cff00ff00"

local AuctionsDisplayStatus = {
	[0] = {"|cffff0000","Bad investment"}, -- 0-4
	[1] = {"|cffff0000","Bad investment"}, -- 0-4
	[2] = {"|cffff0000","Risky investment"}, -- 0-4
	[3] = {"|cffff0000","Risky investment"}, -- 0-4
	[4] = {"|cffff0000","Risky investment"}, -- 0-4
	[5] = {"|cffffff00","Safe investment"}, -- 5-9
	[6] = {"|cffffff00","Safe investment"}, -- 5-9
	[7] = {"|cffffff00","Safe investment"}, -- 5-9
	[8] = {"|cffffff00","Safe investment"}, -- 5-9
	[9] = {"|cffffff00","Safe investment"}, -- 5-9
	[10] = {"|cff00ff00","Good investment"}, -- 10+
}


function ZGVG:MakeImgButton(name,texture,x,w,y,h,caption)
	texture = texture or {1,1,1,1}	-- Doing this in SetTexture doesn't work? Always made a red box

	local but = CHAIN(CreateFrame("Button",self.FUI:GetName().."_"..name,self.FUI))
		:SetSize(TAB_WIDTH,TAB_HEIGHT)
	.__END
	
	but.texture = CHAIN(but:CreateTexture(but:GetName().."_t","ARTWORK")) 
		:SetSize(TAB_TEX_SIZE,TAB_TEX_SIZE) 
		:SetPoint("TOP",but,"TOP") 
		:SetTexture(type(texture)=="string" and texture or unpack(texture))
	.__END
	BetterTexCoord(but.texture,x,w,y,h)
	
	but.caption = CHAIN(but:CreateFontString(but:GetName().."_c","ARTWORK")) 
		:SetSize(20,20) 
		:SetPoint("TOP",but.texture,"BOTTOM") 
		:SetPoint("LEFT",but,"LEFT") 
		:SetPoint("RIGHT",but,"RIGHT")
		:SetFont(FONT,TAB_FONT_SIZE) 
	.__END

	function but:SetText(text)	but.caption:SetText(text)	end
	
	return but
end

--[[
	General frame setup used for farming and gathering. 
	Since the footer is different for both those, this is just used as a template for creating the other two.
--]]


-- used in row "load button" handlers
local function load_chore(self)
	ZGVG:LoadChore(self.chore or self:GetParent().chore)
	if ZGVG.HelpPopup then ZGVG.HelpPopup:Next("guideload") end		-- Try to advance the popup if it is time.
	ZGVG.FUI:Hide()
end

local function generate_guide_wrapper(self)
	ZGVG:generate_guide(self)
end

function ZGVG:generate_guide(self)
	local data = ""
	local chore, recovered, guidename
	local includes = { ["buy"] = {}, ["farm"] = {}, ["vendor"] = {} }

	local function add_line(txt)
		data = data .. txt .. " \n"
		--print(txt)
	end

	local function add_line_learn(showLearnStep)
		if not next(showLearnStep) then return end
		add_line("step")
		add_line("'Use the recipe you've aquired")
		for recid,_ in pairs(showLearnStep) do
			local spellname = GetSpellInfo(tonumber(chore.recipe.spell)) or "[skill unknown]"
			local spellid = chore.recipe.spell
			add_line(".use "..recid)
			add_line(".learn "..spellname.."##"..spellid)
		end
		--add_line("only if _G.GetItemCount("..recipe..")>0")
	end

	local function whowhere_findnpc(typ)
		local m,f,x,y = Astrolabe:GetCurrentPlayerPosition()
		local parse=ZGV.NPCData.parseNPC
		local mindist,minid,minm,minf,minx,miny=999999
		local count=0
		for id,data in ZGV.NPCData:iterate(typ) do
			local npc=parse(data)
			if npc.m>0 then
				npc.x=npc.x*0.01
				npc.y=npc.y*0.01
				if npc.m==321 and npc.f == nil then npc.f = 1 end -- Orgrimmar fix
				-- Don't try to fix it by setting it to "npc.f or 1", that breaks Stormwind. ~~ Jeremiah
				local dist = Astrolabe:ComputeDistance(m,f,x,y,npc.m,npc.f or 0,npc.x,npc.y)
				if dist and dist<mindist then
					mindist=dist
					minid,minm,minf,minx,miny=tonumber(id),npc.m,npc.f,npc.x,npc.y
				end
			end
			count=count+1
			if count%100==0 then coroutine.yield() end
		end
		if minid then
			return minm,minf,minx*100,miny*100
		end
	end

	local function whowhere_findnpcset(dataset,overwrites)
		local parse=ZGV.NPCData.parseNPC
		local allnpcdata = ZGV.NPCData.raw
		local foundnpcs = {}
		local npcid, npcdata, npcrawdata

		local npccounter = 1
		for npcrawdata in allnpcdata:gmatch"[^\n]+" do
			for id,val in npcrawdata:gmatch('(%d+)=(.*)') do
				npcid = id
				npcdata = val
			end

			for datasetindex,datasetid in pairs(dataset) do
				if tonumber(npcid) == tonumber(datasetid) then
					temp = parse(npcdata)
					foundnpcs[npccounter] = {m=temp.m, x=temp.x/100, y=temp.y/100, id=tonumber(npcid)}
					npccounter = npccounter + 1
				end
			end
		end

		b = foundnpcs[1]
		if not b then return false end

		local more_points = {}
		for i=1,#foundnpcs do
			local w=foundnpcs[i]
			more_points[#more_points+1]={m=w.m,f=w.f,x=w.x,y=w.y,title=w.title}
		end

		ZGV:Debug("&gold Calling librover "..(#more_points))
		LibRover:FindPath(0,0,0,0, b.m,0,b.x,b.y, ZGV.Gold.Crafting.Callback, {overwrites=overwrites, foundnpcs=foundnpcs, direct=not ZGV.db.profile.pathfinding, multiple_ends=more_points })
		ZGV:Debug("&gold Forceing update")
		LibRover:UpdateNow(true)
	end

	local function find_farmguide(itemname)
		for i,group in pairs(ZGV.registered_groups.groups) do 
			if group.name == "GOLD" then
				for i,category in pairs(group.groups) do 
					if category.name == "Farming" then
						for i,guide in pairs(category.guides) do
							if string.match(guide.title_short, itemname) then
								return guide.title, guide.num
							end
						end
					end
				end
			end
		end
		return nil,nil
	end
	
	if not self and ZGV.db.profile.gold_crafting_guide then
		chore = ZGV.db.profile.gold_crafting_guide
		recovered = true
	else
		if self.chore then
			chore = self.chore
		else
			chore = self:GetParent().chore
		end
		ZGV.db.profile.gold_crafting_guide = chore
	end

	local product_id
	local name,link,quality,_,_,_,_,vendor,_,icon = GetItemInfo(chore.recipe.productid)

	if chore.prof == 333 then -- enchanting
		product_id = ZGV.Gold.Crafting.EnchantToScroll[chore.recipe.spell]
		if product_id then
			name,link,quality,_,_,_,_,vendor,_,icon = GetItemInfo(product_id)
		else
			name,_,icon = GetSpellInfo(chore.recipe.productid)
			product_id = chore.recipe.productid
		end
	end
	if not name then
		name,link,quality,_,_,_,_,vendor,_,icon = GetItemInfo(chore.recipe.productid)
		product_id = chore.recipe.productid
	end

	if recovered then name = ZGV.db.profile.gold_crafting_guide.savedname end
	local title = "GOLD\\Crafting\\"..name

	local included_guides = { ["buy"] = {}, ["farm"] = {}, ["vendor"] = {} }

	local function include_farmguide(guide,mode)
		if guide.alreadyIncluded then 
			--print(guide.guidenum,mode,"already included")
			return 
		end

		local badGoal = {
			["goldcollect"] = true,
			["goldtracker"] = true,
			["confirm"] = true,
		}

		local currentSteps = ZGV.CurrentGuide.steps
		local includeSteps = ZGV.registeredguides[guide.guidenum].steps
		local overrideParentGuide = currentSteps[1].parentGuide

		for stepnum,step in pairs(includeSteps) do
			if stepnum < #includeSteps then -- skip last step
				--print("Next step, setting")
				newstep = { goals = {} }
				setmetatable(newstep,ZGV.StepProto_mt)

				if stepnum == 1 then
					newstep.label = "included_"..guide.guidenum.."_"..mode
				end

				local goalCounter = 0
				local dataCounter = 0
				for k,v in pairs(step) do

					if k=="goals" then
						for gi,goal in ipairs(v) do
							if not badGoal[goal.action] then
								goalCounter = goalCounter + 1
								local newgoal = {}
								setmetatable(newgoal,ZGV.GoalProto_mt)
								for gk,gv in pairs(goal) do
									if type(gv)~="function"  then 
										newgoal[gk]=gv 
									end
								end
								newgoal.parentStep = newstep
								tinsert(newstep.goals,newgoal)
							end
						end
					elseif type(v)~="function" and k~="label" then 
						dataCounter = dataCounter + 1
						newstep[k]=v 
					end
				end

				--print("Leeched step",stepnum,"for",goalCounter,"goals and",dataCounter,"data")

				newstep.parentGuide = overrideParentGuide
				newstep.num = #ZGV.CurrentGuide.steps+1
				tinsert(ZGV.CurrentGuide.steps,newstep)
			end
		end

		-- Add farm lines
		local addedStepNum = newstep.num

		for i,foundguide in pairs(includes[mode]) do
			if foundguide.guidenum == guide.guidenum then
				local newgoal = {}
				setmetatable(newgoal,ZGV.GoalProto_mt)
				newgoal.action = "farm"
				newgoal.count = foundguide.count
				newgoal.target = foundguide.itemname
				newgoal.targetid = foundguide.itemid
				newgoal.parentStep = newstep
				tinsert(newstep.goals,newgoal)
				foundguide.alreadyIncluded = true
			end
		end

		local newgoal = {}
		setmetatable(newgoal,ZGV.GoalProto_mt)
		newgoal.action = "confirm"
		newgoal.text = "Return to "..mode.." list."
		newgoal.next = mode
		newgoal.parentStep = newstep
		tinsert(newstep.goals,newgoal)

		--add_line(".'Return to "..mode.." list |confirm |next \""..mode.."\"")


	end


	for i,guide in pairs(ZGV.registeredguides) do
		if guide.title == title then
			ZGV:Debug("&gold Found existing. Killing")
			ZGV:SetGuide(nil,0)
			ZGV.registeredguides[i] = nil
			break
		end
	end




	local group,tit = title:match("^(.*)\\+(.-)$")
	local maingroup = group and group:match("^(.-)\\") or group or "GUIDES"

	group = ZGV:FindGroup(ZGV.registered_groups,group)

	if recovered then -- during game startup, guide does not always find the name of item
		name = ZGV.db.profile.gold_crafting_guide.savedname -- use saved in such case
		recname = ZGV.db.profile.gold_crafting_guide.recname -- use saved in such case
	else
		ZGV.db.profile.gold_crafting_guide.savedname = name
	end

	local craft_prof = ZGV.skillIDsRev[chore.prof]
	local craft_level = chore.recipe.learnedat

	add_line('step')
	if recovered then
		add_line("'_This dynamic crafting guide may be out of date._")
	else
		add_line("'_This is a dynamic crafting guide._")
	end
	add_line("'We will make "..name)
	add_line("' ")
	add_line("'Overview of the process:")
	if next(chore.items_vendor) ~= nil then
		for i,item in pairs(chore.items_vendor) do
			add_line('buy '..item.count..' '..item.name.."##"..item.id..'|n')
		end
	end

	if next(chore.items_buy) ~= nil then
		for i,item in pairs(chore.items_buy) do
			add_line('buy '..item.count..' '..item.name.."##"..item.id..'|n')
		end
	end
	if next(chore.items_farm) ~= nil then
		for i,item in pairs(chore.items_farm) do
			add_line('farm '..item.count..' '..item.name.."##"..item.id..'|n')
		end
	end
	if next(chore.items_craft) ~= nil then
		for i,item in pairs(chore.items_craft) do
			add_line("create "..item.count.." "..item.name.."##"..item.id..'|n')
		end
	end
	--add_line("create 1 "..name.."##"..chore.recipe.productid..','..craft_prof..',1 total|n')
	--add_line("create 1 "..name.."##"..chore.recipe.productid..'|n')
	add_line("create 1 "..name.."##"..product_id..'|n')

	--[[	
	for i,line in ipairs(chore.comments) do
		local text = line[2].." "..line[3]..line[4]
		text = string.gsub(text,"(.*)|c(.*)|h%[(.*)]|h(.*)","%1 %3")
		add_line("..'"..text)
	end
	--]]
	add_line("confirm")

	if ZGV.Gold.Crafting.AllRecipesSources[chore.recipe.spell] and chore.unknown then
		local recsources = ZGV.Gold.Crafting.AllRecipesSources[chore.recipe.spell]
		local shownSingleInZone = false
		local showLearnStep = {}
		for sourcetype, sourcedata in pairs(recsources) do
			if sourcetype == "crafted" then
				recipe, source  = next(sourcedata)
				ZGV.db.profile.gold_crafting_guide.recname = recname
				add_line("step")
				add_line("This recipe is crafted using "..source)
				add_line(".get 1 "..recipe)
				showLearnStep[recipe] = true
				add_line("confirm")
			end
			if sourcetype == "singlemob" then
				if recsources["zonedrop"] then
					sindex, svalue = next(recsources["singlemob"])
					zindex, zvalue = next(recsources["zonedrop"])
					if tonumber(sindex) == tonumber(zvalue) then
						shownSingleInZone = true
					end
				end
						
				if not shownSingleInZone then
					add_line("step")
					for sindex, svalue in pairs(recsources["singlemob"]) do
						local zonename = GetMapNameByID(sindex) or "unknown zone"
						add_line("The recipe is avaible from following mobs in "..zonename..":")
						add_line("from "..svalue)
					end
					add_line("confirm")
				end
			end
			if sourcetype == "zonedrop" then
				add_line("step")
				for recid, zone in pairs(sourcedata) do
					local zonename = GetMapNameByID(zone) or "unknown zone"
					add_line("The recipe can be randomly drop from any mob in "..zonename)
					add_line(".get 1 "..recid)
					if recsources["singlemob"] then
						for sindex, svalue in pairs(recsources["singlemob"]) do
							if tonumber(sindex) == tonumber(zone) then
								add_line("It has a higher change to drop from:")
								add_line("from "..svalue)
								shownSingleInZone = true
							end
						end
					end
					showLearnStep[recid] = true
				end
				add_line("confirm")
			end
			if sourcetype == "drop" then
				for recid, zones in pairs(sourcedata) do
					for zone,mobsid in pairs(zones) do
						local zonename = GetMapNameByID(zone) or "unknown zone"
						add_line("step")
						add_line("The recipe is avaible from following mobs in "..zonename..":")
						add_line("from "..table.concat(mobsid, ","))
						add_line(".get 1 "..recid)
						add_line("confirm")
						add_line("only if _G.GetItemCount("..recid..")==0")
					end
					showLearnStep[recid] = true
				end
			end
			if sourcetype == "commondrop" then
				add_line("step")
				add_line("The recipe is a world drop. There is no reliable way of farming it as such.")
				showLearnStep[sourcedata] = true
				add_line(".get 1 "..sourcedata)
				add_line("confirm")
			end
			if sourcetype == "contained" then
				recipe, source  = next(sourcedata)
				add_line("step")
				add_line("This recipe can be found in container: "..source)
				showLearnStep[recipe] = true
				add_line(".get 1 "..recipe)
			end
			if sourcetype == "pvp" then
				add_line("step")
				for recid,npcids in pairs(sourcedata) do
					add_line("The recipe is avaible from various vendors for pvp earned currency.")
					add_line("talknpcs "..table.concat(npcids, ", "))
					showLearnStep[recid] = true
					add_line(".get 1 "..recid)
				end
				add_line("confirm")
			end
			if sourcetype == "quest" then
				add_line("step")
				add_line("You will learn this craft after completing quest: "..sourcedata)
				add_line("confirm")
			end
			if sourcetype == "vendor" then
				add_line("step")
				for recid,npcids in pairs(sourcedata) do
					if recsources["achievementitem"] then
						local _,temp = next(recsources["achievementitem"])
						local aid, achivename = next(temp)
						add_line("To unlock it, you will need to complete: "..achivename)
						add_line("After that, it is avaible from various vendors.")
						--Spoo(nil,nil,next(recsources["achievementitem"]))
					else
						add_line("The recipe is avaible from various vendors.")
					end
	
					add_line("talknpcs "..table.concat(npcids, ", "))
					showLearnStep[recid] = true
					add_line(".get 1 "..recid)
				end
				add_line("confirm")
			end
			if sourcetype == "trainer" then
				local spellname = GetSpellInfo(tonumber(chore.recipe.spell)) or "[skill unknown]"
				local spellid = chore.recipe.spell

				add_line("step")
				add_line("This skill is trained from various trainers.")
				add_line("talknpcs "..table.concat(sourcedata, ", "))
				add_line(".learn "..spellname.."##"..spellid)
				--for _,npcid in pairs(sourcedata) do
				--	add_line(".talk "..npcid)
				--end
				add_line("confirm")
			end
			if sourcetype == "discovery" then
				add_line("step")
				name = GetSpellInfo(sourcedata)
				add_line("This craft can be randomly discovered while creating "..name)
				add_line("confirm")
			end
			if sourcetype == "starter" then
				add_line("step")
				add_line("This is a starter recipe. You should already know it.")
				add_line("confirm")
			end
			if sourcetype == "achievement" then
				add_line("step")
				local aid, aname = next(sourcedata)
				add_line("This craft is a reward from achievement: "..aname)
				add_line("only if _G.GetItemCount("..recid..")==0")
				add_line("confirm")
			end
			if sourcetype == "bmah" then
				add_line("step")
				add_line("The recipe can sometimes be found on Black Market Auction House.")
				add_line("confirm")
			end
			if sourcetype == "fished" then
				add_line("step")
				local zonenames = {}
				for recid,zones in pairs(sourcedata) do
					for _,zoneid in pairs(zones) do
						table.insert(zonenames,GetMapNameByID(zoneid) or "unknown zone")
					end
					add_line("The recipe can be fished in: "..table.concat(zonenames, ", "))
					showLearnStep[recid] = true
					add_line(".get 1 "..recid)
				end
				add_line("confirm")
			end
			if sourcetype == "salvage" then
				add_line("step")
				local zonenames = {}
				for recid,mobs in pairs(sourcedata) do
					add_line("The recipe can be salvaged from following mobs:")
					add_line(".from "..table.concat(mobs, ", "))
					showLearnStep[recid] = true
					add_line(".get 1 "..recid)
				end
				add_line("confirm")
			end
			if sourcetype == "questitem" then
				add_line("step")
				local recid,questdata = next(sourcedata)
				local qid, qname = next(questdata)
				add_line("The recipe is a quest reward from:")
				add_line("q "..qname.."##"..qid)
				showLearnStep[recid] = true
				add_line(".get 1 "..recid)
			end		
		end

		if next(showLearnStep) then 
			local buyableRecs = {}
			for recid,_ in pairs(showLearnStep) do
				Gratuity:SetHyperlink("item:"..recid)
				local n = Gratuity:NumLines()
				local isbop = false

				for i=1,n do
					local line=Gratuity:GetLine(i)
					if line then
						isbop = isbop or strfind(line, ITEM_BIND_ON_PICKUP)
					end
				end
				if not isbop then
					buyableRecs[recid] = true
				end
			end

			if next(buyableRecs) then
				add_line("step")
				add_line("'This recipe is not bind on pickup, so it may be avaible on Auction House:")
				for recid,_ in pairs(buyableRecs) do
					add_line('buy 1 '..recid)
				end
			end
		end

	end


	if next(chore.items_vendor) ~= nil then
		add_line('step')
		add_line('label "vendor"')
		add_line(".'Buy following items from vendors:")

		for i,item in pairs(chore.items_vendor) do
			local vendors = ZGV.Gold.Crafting.ItemSources[item.id]["vendor"]
			add_line("talknpcs "..table.concat(vendors, ", "))
			add_line("buy "..item.count.." "..item.id)
			guidename,guidenum = find_farmguide(item.name)
			if guidename then
				table.insert(includes.vendor, {guidename=guidename,guidenum=guidenum,count=item.count,itemname=item.name,itemid=item.id})
				add_line(".'Open farming guide for "..item.name..".|confirm |next \"included_"..guidenum.."_vendor\"")
			end
		end
	end


	if next(chore.items_buy) ~= nil then
		add_line('step')
		add_line('label "buy"')
		local m,f,x,y = whowhere_findnpc("A")

		if m and x and y then
			if f then
				add_line(".'Buy following items on AH:|goto "..m.."/"..f.." "..x..","..y)
			else
				add_line(".'Buy following items on AH:|goto "..m.." "..x..","..y)
			end
		else
			add_line(".'Buy following items on AH:")
		end

		for i,item in pairs(chore.items_buy) do
			add_line('buy '..item.count..' '..item.name.."##"..item.id)
			guidename,guidenum = find_farmguide(item.name)
			if guidename then
				table.insert(includes.buy, {guidename=guidename,guidenum=guidenum,count=item.count,itemname=item.name,itemid=item.id})
				add_line(".'Open farming guide for "..item.name..".|confirm |next \"included_"..guidenum.."_buy\"")
			end
		end
	end

	if next(chore.items_farm) ~= nil then
		add_line('step')
		add_line('label "farm"')
		add_line(".'Farm following items:")

		for i,item in pairs(chore.items_farm) do
			add_line('farm '..item.count..' '..item.name.."##"..item.id)
			guidename,guidenum = find_farmguide(item.name)
			if guidename then
				table.insert(includes.farm, {guidename=guidename,guidenum=guidenum,count=item.count,itemname=item.name,itemid=item.id})
				add_line(".'You may want to use this guide.|confirm |next \"included_"..guidenum.."_farm\"")
			end
		end
	end

	if next(chore.items_craft) ~= nil then
		add_line('step')
		add_line(".'Craft following items:")

		for i,item in pairs(chore.items_craft) do
			add_line("create "..item.count.." "..item.name.."##"..item.id)
		end
	end

	add_line('step')
	add_line(".'Using gathered items:")
	--add_line("create 1 "..name.."##"..chore.recipe.productid..','..craft_prof..',1 total|n')
	--add_line("create 1 "..name.."##"..chore.recipe.productid..'|n')
	add_line("create 1 "..name.."##"..product_id..'|n')

	--[[
	for i,guide in pairs(includes.buy) do
		include_farmguideplaceholder(guide,"buy")
	end
	for i,guide in pairs(includes.farm) do
		include_farmguideplaceholder(guide,"farm")
	end
	for i,guide in pairs(includes.vendor) do
		include_farmguideplaceholder(guide,"vendor")
	end
	--]]


	local guide = ZGV.GuideProto:New(title,data,extra)

	tinsert(ZGV.registeredguides,guide)

	ZGV:SetGuide(title,1)

	for i,guide in pairs(includes.buy) do
		include_farmguide(guide,"buy")
	end
	for i,guide in pairs(includes.farm) do
		include_farmguide(guide,"farm")
	end
	for i,guide in pairs(includes.vendor) do
		include_farmguide(guide,"vendor")
	end

	-- refresh step labels
	ZGV.CurrentGuide.steplabels = {}
	for i,step in pairs(ZGV.CurrentGuide.steps) do
		if step.label then
			ZGV.CurrentGuide.steplabels[step.label] = {[1] = i}
		end
	end
	
	if ZGVG.FUI then ZGVG.FUI:Hide() end
	--ZGV:Debug(ZGV.CurrentGuide.rawdata)
end

local function tip_auction(self)
	local row = self:GetParent()
	if not row.chore then return end
	row:GetScript("OnEnter")(row)
	GameTooltip:SetOwner(self,"ANCHOR_RIGHT")
	GameTooltip:SetText("Add to Shopping List")
	GameTooltip:AddLine(row.chore.name)
	GameTooltip:Show()
end

local function tip_chore(self)
	local row = self:GetParent()
	if not row.chore or not row.chore.guide then return end
	row:GetScript("OnEnter")(row)
	GameTooltip:SetOwner(self,"ANCHOR_RIGHT")
	GameTooltip:SetText("Load guide")
	GameTooltip:AddLine(row.chore.display_name)
	GameTooltip:Show()
end

local function tip_craft(self)
	local row = self:GetParent()
	if not row.chore or not row.chore.recipe then return end
	row:GetScript("OnEnter")(row)
	GameTooltip:SetOwner(self,"ANCHOR_RIGHT")
	GameTooltip:SetText("Load guide")
	GameTooltip:AddLine(row.chore.recipe.name)
	GameTooltip:Show()
end

local function hide_tooltip(self)
	GameTooltip:Hide()
end

local function GetInfoFrame(parentFrame)
	local HEADER_FONTSIZE = 14
	local REG_TEXT_FONTSIZE = 13

	local HORT_PADDING = 10
	local SECTION_VERT_PADDING = 15
	local BELOW_HEADER_PADDING = 7
	local LABEL_HORT_PADDING = 5
	local LABEL_SPACING = 5
	
	-- Ok Button dis
	local BUTTON_VERT_DIS = 30

	-- Pro/Con
	local PRO_N_CON_SQUARE_SIZE = 10
	local PRO_N_CON_VERT_PADDING = 7
	local PRO_SQ_COLOR = {HTMLColor("#00a1fe")}
	local CON_SQ_COLOR = {HTMLColor("#ff0000")}
	
	local PROGRESS_BAR_HEIGHT = 12
	local PROGRESS_BAR_WIDTH = 300
	-- Progress Bar Colors
	local DIFF_COLOR_1 = {HTMLColor("#00ff00")}
	local DIFF_COLOR_2 = {HTMLColor("#ffff00")}
	local DIFF_COLOR_3 = {HTMLColor("#ff0000")}
	
	local name = parentFrame:GetName().."InfoFrame"
	local contentwidth

	local infoframe = CHAIN(ui:Create("SecFrame",parentFrame,name))
		:SetAllPoints(parentFrame)
		:SetFrameLevel(parentFrame:GetFrameLevel() + 10)	-- Gotta get over the rows and all the various buttons. TODO better way?!?
		:CanDrag("parent")
	.__END

	contentwidth = infoframe:GetWidth() - (HORT_PADDING*2)	-- full frame with the buffer on each side.

	infoframe.summaryheader = CHAIN(infoframe:CreateFontString())
		:SetPoint("TOPLEFT",infoframe,"TOPLEFT",HORT_PADDING,-SECTION_VERT_PADDING)
		:SetFont(FONTBOLD,HEADER_FONTSIZE)
		:SetText("SUMMARY:")
	.__END

	infoframe.summary = CHAIN(infoframe:CreateFontString())
		:SetPoint("TOPLEFT",infoframe.summaryheader,"BOTTOMLEFT",0,-BELOW_HEADER_PADDING)
		:SetWidth(contentwidth)	
		:SetFont(FONT,REG_TEXT_FONTSIZE)
		:SetJustifyH("LEFT")
		--:SetJustifyV("TOP")
		:SetWordWrap(true)
		:SetText("No Sum Text")
		:SetSpacing(LABEL_SPACING)
	.__END

	function infoframe:SetSummaryText(txt)
		self.summary:SetText(txt)
	end

	local function getSquareWithText(parent,sqname)
		local sq = CHAIN(ui:Create("SecFrame",parent,sqname))
			:SetSize(PRO_N_CON_SQUARE_SIZE,PRO_N_CON_SQUARE_SIZE)
			:CanDrag("parent")
		.__END

		sq.text = CHAIN(infoframe:CreateFontString())
			:SetPoint("LEFT",sq,"RIGHT",LABEL_HORT_PADDING,0)
			:SetFont(FONT,REG_TEXT_FONTSIZE)
			-- Assumed that this text will be short enough to not wrap.
			:SetText("No Text")
		.__END

		function sq:SetText(txt)
			self.text:SetText(txt)
		end

		return sq
	end

	infoframe.proheader = CHAIN(infoframe:CreateFontString())
		:SetPoint("TOPLEFT",infoframe.summary,"BOTTOMLEFT",0,-SECTION_VERT_PADDING)
		:SetFont(FONTBOLD,HEADER_FONTSIZE)
		:SetText("PROS")
	.__END

	infoframe.proframe = CHAIN(CreateFrame("Frame", name.."Pros", infoframe))
		:SetPoint("TOPLEFT",infoframe.proheader,"BOTTOMLEFT",0,-BELOW_HEADER_PADDING)
		:SetSize(contentwidth,1)	-- Height changes with pros. 1 so that you can point off of it.
	.__END

	infoframe.pros = {}

	function infoframe:AddPro(text)
		local num = #self.pros

		local pro = CHAIN(getSquareWithText(self.proframe,self:GetName().."Pro"..num))
			:SetBackdropColor(unpack(PRO_SQ_COLOR))
			:SetText(text)
		.__END

		if num == 0 then
			pro:SetPoint("TOPLEFT")
		else
			pro:SetPoint("TOPLEFT",self.pros[num],"BOTTOMLEFT",0,-PRO_N_CON_VERT_PADDING)
		end

		self.proframe:SetHeight(self.proframe:GetTop() - pro:GetBottom())	-- This frame's height is the top to the last pro.

		tinsert(self.pros,pro)
	end
	
	infoframe.conheader = CHAIN(infoframe:CreateFontString())
		:SetPoint("TOPLEFT",infoframe.proframe,"BOTTOMLEFT",0,-SECTION_VERT_PADDING)
		:SetFont(FONTBOLD,HEADER_FONTSIZE)
		:SetText("CONS")
	.__END

	infoframe.conframe = CHAIN(CreateFrame("Frame", name.."Cons", infoframe))
		:SetPoint("TOPLEFT",infoframe.conheader,"BOTTOMLEFT",0,-BELOW_HEADER_PADDING)
		:SetSize(contentwidth,1)	-- Height changes with cons.  1 so that you can point off of it.
	.__END

	infoframe.cons = {}

	function infoframe:AddCon(text)
		local num = #self.cons

		local con = CHAIN(getSquareWithText(self.conframe,self:GetName().."Con"..num))
			:SetBackdropColor(unpack(CON_SQ_COLOR))
			:SetText(text)
		.__END

		if num == 0 then
			con:SetPoint("TOPLEFT")
		else
			con:SetPoint("TOPLEFT",self.cons[num],"BOTTOMLEFT",0,-PRO_N_CON_VERT_PADDING)
		end

		self.conframe:SetHeight(self.conframe:GetTop() - con:GetBottom())	-- This frame's height is the top to the last pro.

		tinsert(self.cons,con)
	end

	infoframe.diffheader = CHAIN(infoframe:CreateFontString())
		:SetPoint("TOPLEFT",infoframe.conframe,"BOTTOMLEFT",0,-SECTION_VERT_PADDING)
		:SetFont(FONTBOLD,HEADER_FONTSIZE)
		:SetText("DIFFICULTY:")
	.__END

	infoframe.diffbg = CHAIN(ui:Create("Frame",infoframe,name.."DiffBarBG"))
		:SetPoint("LEFT",infoframe.diffheader,"RIGHT",LABEL_HORT_PADDING,0)
		:SetBackdropColor(unpack(SkinData("TriBackdropColor")))
		:SetBackdropBorderColor(unpack(SkinData("DarkBorder")))
		:SetSize(PROGRESS_BAR_WIDTH,PROGRESS_BAR_HEIGHT)
	.__END

	infoframe.difftex = CHAIN(infoframe.diffbg:CreateTexture())
		:SetPoint("TOPLEFT",infoframe.diffbg,"TOPLEFT",1,-1)
		:SetPoint("BOTTOMLEFT",infoframe.diffbg,"BOTTOMLEFT",1,1)
		:SetTexture(unpack(SkinData("ProgressBarTexture")))
		:SetWidth(50)
	.__END
	
	-- Takes integers 0-100
	function infoframe:SetDiffBarPercent(num)
		assert(num > -1 or num < 101, "Num 0-100 pls")
		local color
	
		infoframe.difftex:SetWidth((num/100) * PROGRESS_BAR_WIDTH)

		if num < 50 then
			color = DIFF_COLOR_1	-- Green
		elseif num < 70 then
			color = DIFF_COLOR_2	-- Yellow
		else
			color = DIFF_COLOR_3	-- Red
		end

		infoframe.difftex:SetTexture(unpack(color))
	end

	infoframe.okbutton = CHAIN(ui:Create("Button",infoframe,name.."OkBut",2))
		:SetPoint("BOTTOM",infoframe,"BOTTOM",0,BUTTON_VERT_DIS)
		:SetSize(100,30)
		:SetText("OK")
		:SetFont(FONTBOLD,14)
		:SetScript("OnClick",function(me)
			ZGV.db.global.gold_info_pages = false
			me:GetParent():Hide() 
		end)
	.__END

	return infoframe
end


function ZGVG:MakeRouteTable(name)
	-- The whole middle section of the Frame. Has its own header/footer

	local routeframe = CHAIN(ui:Create("SecFrame",self.FUI,"ZGGold"..name.."Frame"))
		:SetPoint("TOPLEFT",1,-HEADER_HEIGHT)
		:SetPoint("BOTTOMRIGHT",-1,FOOTER_HEIGHT)
		:CanDrag("parent")
		:SetScript("OnShow",function(me) me.easymodeDropdown:SetCurrentSelectedByValue(ZGV.db.profile.gold_lowdemand or EXPERTMODE_DROPDOWN_MODES[1][2]) end)
	.__END
	
	-- Header
	routeframe.col_no = CHAIN(routeframe:CreateFontString())
		:SetPoint("TOPLEFT",routeframe,"TOPLEFT",0,0) 
		:SetSize(ROUTE_COLUMNSIZES[1],ROW_HEADER)
		:SetJustifyV("CENTER"):SetJustifyH("CENTER")
		:SetFont(FONTBOLD,COLHEADER_FONTSIZE)
		:SetText("NO.")
	.__END

	routeframe.col_title = CHAIN(routeframe:CreateFontString())
		:SetPoint("LEFT",routeframe.col_no,"RIGHT",ROW_ITEM_ICON_SIZE + ROW_ROUTE_COL_PADDING,0) 
		:SetSize(ROUTE_COLUMNSIZES[2],ROW_HEADER)
		:SetJustifyV("CENTER")	:SetJustifyH("LEFT")
		:SetFont(FONTBOLD,COLHEADER_FONTSIZE)
		:SetText("ITEM")
	.__END

	routeframe.col_zone = CHAIN(routeframe:CreateFontString())
		:SetPoint("LEFT",routeframe.col_title,"RIGHT",ROW_ROUTE_COL_PADDING,0) 
		:SetSize(ROUTE_COLUMNSIZES[3],ROW_HEADER)
		:SetJustifyV("CENTER")	:SetJustifyH("LEFT")
		:SetFont(FONTBOLD,COLHEADER_FONTSIZE)
		:SetText("ZONE")
	.__END

	-- money
	routeframe.col_lab1 = CHAIN(routeframe:CreateFontString())
		:SetPoint("LEFT",routeframe.col_zone,"RIGHT",ROW_ROUTE_GOLD_PADDING,0) 
		:SetSize(ROUTE_COLUMNSIZES[4],ROW_HEADER)
		:SetJustifyV("CENTER")	:SetJustifyH("RIGHT")
		:SetFont(FONTBOLD,COLHEADER_FONTSIZE)
		:SetText("RATE")
	.__END

	-- time
	routeframe.col_lab2 = CHAIN(routeframe:CreateFontString())
		:SetPoint("LEFT",routeframe.col_lab1,"RIGHT",ROW_ROUTE_DEMAND_PADDING,0) 
		:SetSize(ROUTE_COLUMNSIZES[5],ROW_HEADER)
		:SetJustifyV("CENTER")	:SetJustifyH("RIGHT")
		:SetFont(FONTBOLD,COLHEADER_FONTSIZE)
		:SetText("TIME")
	.__END

	-- total
	routeframe.col_lab3 = CHAIN(routeframe:CreateFontString())
		:SetPoint("LEFT",routeframe.col_lab2,"RIGHT",ROW_ROUTE_LIM_PADDING,0) 
		:SetSize(ROUTE_COLUMNSIZES[6],ROW_HEADER)
		:SetJustifyV("CENTER")	:SetJustifyH("RIGHT")
		:SetFont(FONTBOLD,COLHEADER_FONTSIZE)
		:SetText("EST. GOLD")
	.__END

	-- Middle
	routeframe.rows={}
	for n=1,ROWCOUNT do
		routeframe.rows[n] = CHAIN(ui:Create("Button",routeframe,"ZGGold"..name.."Row"..n))
			-- Tricky tricky setting width. Set the height then set right point so that if the scrollbar is hidden that it expands the whole frame. If scrollbar is shown, then only expands to the scrollbar.
			:SetSize(GOLD_FRAME_ROW_WIDTH,ROW_HEIGHT)
			:SetPoint("RIGHT",self.FUI.scrollbar.barframe,"LEFT")
			:SetFrameStrata("HIGH")
			:SetBackdropBorderColor(0,0,0,0)
			:SetBackdropColor(unpack(ui.SkinData("SecBackdropColor")))
			:CanDrag("parent")
			:SetScript("OnDoubleClick",load_chore)
			:SetScript("OnEnter",function(self)
				self.chore:CalculateDetails()
				ZGVG.FItems:ShowItemsForChore(self.chore,self)
			end)
			:SetScript("OnLeave",function(self) ZGVG.FItems:Hide() end)
		.__END

		if n==1 then
			routeframe.rows[n]:SetPoint("TOPLEFT",routeframe,"TOPLEFT",0,-ROW_HEADER)
		else
			routeframe.rows[n]:SetPoint("TOPLEFT",routeframe.rows[n-1],"BOTTOMLEFT",0,0)
		end

		local row = routeframe.rows[n]

		row.no = CHAIN(row:CreateFontString())
			:SetPoint("LEFT",row,"LEFT",0,0) 
			:SetSize(routeframe.col_no:GetWidth(),ROW_FONTSIZE)
			:SetJustifyH("CENTER")
			:SetFont(FONTBOLD,ROW_FONTSIZE)
			:SetText("Num?")
		.__END

		row.icon = CHAIN(row:CreateTexture())
			:SetPoint("LEFT",row.no,"RIGHT",0,0)
			:SetSize(ROW_ITEM_ICON_SIZE,ROW_ITEM_ICON_SIZE)
		.__END

		row.title = CHAIN(row:CreateFontString())
			:SetPoint("LEFT",row.icon,"RIGHT",ROW_ROUTE_COL_PADDING,0) 
			:SetSize(routeframe.col_title:GetWidth(),ROW_FONTSIZE)
			:SetJustifyH("LEFT")
			:SetFont(FONT,ROW_FONTSIZE)
			:SetText("Item name pls?")
		.__END

		row.zone = CHAIN(row:CreateFontString())
			:SetPoint("LEFT",row.title,"RIGHT",ROW_ROUTE_COL_PADDING,0) 
			:SetSize(routeframe.col_zone:GetWidth(),ROW_FONTSIZE)
			:SetJustifyH("LEFT")
			:SetFont(FONT,ROW_FONTSIZE)
			:SetText("Unknown")
		.__END

		-- money
		row.lab1 = CHAIN(row:CreateFontString())
			:SetPoint("LEFT",row.zone,"RIGHT",ROW_ROUTE_GOLD_PADDING,0) 
			:SetSize(routeframe.col_lab1:GetWidth(),ROW_FONTSIZE)
			:SetJustifyH("RIGHT")		-- Right aligned because it makes the money line up nicely when there is no Gold/silver amounts
			:SetFont(FONT,ROW_FONTSIZE)
			:SetText("$$$$")
		.__END

		-- demand
		row.lab2 = CHAIN(row:CreateFontString())
			:SetPoint("LEFT",row.lab1,"RIGHT",ROW_ROUTE_DEMAND_PADDING,0) 
			:SetSize(routeframe.col_lab2:GetWidth(),ROW_FONTSIZE)
			:SetJustifyH("RIGHT")
			:SetFont(FONT,ROW_FONTSIZE)
			:SetText("Demand")
		.__END

		-- limit
		row.lab3 = CHAIN(row:CreateFontString())
			:SetPoint("LEFT",row.lab2,"RIGHT",ROW_ROUTE_COL_PADDING,0) 
			:SetSize(routeframe.col_lab3:GetWidth(),ROW_FONTSIZE)
			:SetJustifyH("RIGHT")
			:SetFont(FONT,ROW_FONTSIZE)
			:SetText("$$$$")
		.__END

		row.loadbutton = CHAIN(CreateFrame("BUTTON",row:GetName().."LoadButton",row))
			:SetPoint("RIGHT",row,"RIGHT",-ROW_LOAD_RIGHT_PADDING,0)
			:SetSize(ROW_LOAD_BUT_SIZE,ROW_LOAD_BUT_SIZE)
			:SetScript("OnClick",load_chore)
			:SetScript("OnEnter",tip_chore)
			:SetScript("OnLeave",hide_tooltip)
		.__END
		ZGV.AssignButtonTexture(row.loadbutton,(SkinData("TitleButtons")),19,32)
		CHAIN(row.loadbutton:CreateTexture(row.loadbutton:GetName().."Back","BACKGROUND")) :SetAllPoints() :SetTexture(unpack(SkinData("AccentColor")))

		row.hilite = CHAIN(row:CreateTexture(row:GetName().."Back","HIGHLIGHT")) :SetAllPoints() :SetTexture(1,1,1,0.15) .__END

		row.back = CHAIN(row:CreateTexture(row:GetName().."Back","ARTWORK")) :SetAllPoints() :SetTexture(1,1,1,1) .__END

	end
	
	-- FOOTER for routes

	routeframe.footer = CHAIN(CreateFrame("FRAME",nil,routeframe))
		:SetPoint("BOTTOMLEFT",routeframe,"BOTTOMLEFT",0,0)
		:SetPoint("TOPRIGHT",routeframe,"BOTTOMRIGHT",0,ROW_FOOTER)
	.__END

	routeframe.easymodeDropdownLabel = CHAIN(routeframe.footer:CreateFontString())
		:SetPoint("BOTTOMLEFT",routeframe.footer,"BOTTOMLEFT",DROPDOWN_HORZ_PADDING, (ROW_FOOTER-COLFOOTER_FONTSIZE)/2)
		:SetFont(FONTBOLD,COLFOOTER_FONTSIZE)
		:SetText("Mode:")
	.__END

	-- This dropdown is the same for all tables. So can set it up here.
	routeframe.easymodeDropdown = CHAIN(ui:Create("DropDown",routeframe.footer,DROPDOWN_STYLE,routeframe.footer:GetFrameLevel()+2))	-- Dropdown doesn't have a name. Need to set adjust the frame level because need it to appear above all of the other tables.
		:SetPoint("LEFT",routeframe.easymodeDropdownLabel,"RIGHT",DROPDOWN_LABEL_PADDING,0)														-- All tables have the same position, so just point off of farmframe. It appears over all other tables too.
		:SetSize(DROPDOWN_WIDTH,DROPDOWN_HEIGHT)
		:AddTooltip("ANCHOR_TOPLEFT",L["gold_expertmode_generictooltip"])	-- TODO Change text of the tooltip
	.__END
	
	for optnum,opt in ipairs(EXPERTMODE_DROPDOWN_MODES) do
		local item = routeframe.easymodeDropdown:AddItem(opt[1],opt[2],function(item)
			-- Only worry about the callback if the frame is visible. So code side calls of this will not change ZGVG.
			if not self.FUI:IsVisible() then return end

			ZGV.db.profile.gold_lowdemand = item.userdata.value

			ZGVG:Update()
		end, opt[3])
	end

	routeframe:Hide()
	return routeframe
end

function ZGVG:MakeFarmingTable()
	local farmframe = self:MakeRouteTable("Farm")

	farmframe.info = CHAIN(GetInfoFrame(farmframe))
		:SetSummaryText(FARM_INFO_SUMMARY)
		:SetDiffBarPercent(FARM_INFO_DIFF_PERCENT)
	.__END

	for i,pro in ipairs(FARM_INFO_PROS) do
		farmframe.info:AddPro(pro)
	end

	for i,con in ipairs(FARM_INFO_CONS) do
		farmframe.info:AddCon(con)
	end

	farmframe:HookScript("OnShow",function(me)
		me.itemtypeDropdown:SetCurrentSelectedByValue(ZGV.db.profile.gold_farm_itemfilter or FARM_TYPE_DROPDOWN_OPTIONS[1][2])
	end)

	farmframe.itemtypeDropdown = CHAIN(ui:Create("DropDown",farmframe.footer,DROPDOWN_STYLE))
		:SetPoint("BOTTOMRIGHT",farmframe.footer,"BOTTOMRIGHT",-DROPDOWN_HORZ_PADDING, (ROW_FOOTER-DROPDOWN_HEIGHT)/2)
		:SetSize(DROPDOWN_WIDTH,DROPDOWN_HEIGHT)
		:AddTooltip("ANCHOR_TOPLEFT","Filter what sort of items are shown.")	-- TODO Change text of the tooltip
	.__END

	farmframe.itemtypeDropdownLabel = CHAIN(farmframe.footer:CreateFontString())
		:SetPoint("RIGHT",farmframe.itemtypeDropdown.frame,"LEFT",-DROPDOWN_LABEL_PADDING,0)
		:SetFont(FONTBOLD,COLFOOTER_FONTSIZE)
		:SetText("Filter:")
	.__END

	for optnum,opt in ipairs(FARM_TYPE_DROPDOWN_OPTIONS) do
		local item = farmframe.itemtypeDropdown:AddItem(opt[1],opt[2],function(item)
			-- Only worry about the callback if the frame is visible. So code side calls of this will not change ZGVG.
			if not farmframe:IsVisible() then return end

			ZGV.db.profile.gold_farm_itemfilter = item.userdata.value

			ZGVG:Update()
		end)
	end

	return farmframe
end

function ZGVG:MakeGatheringTable()
	local gatherframe = self:MakeRouteTable("Gather")

	gatherframe.info = CHAIN(GetInfoFrame(gatherframe))
		:SetSummaryText(GATHER_INFO_SUMMARY)
		:SetDiffBarPercent(GATHER_INFO_DIFF_PERCENT)
	.__END

	for i,pro in ipairs(GATHER_INFO_PROS) do
		gatherframe.info:AddPro(pro)
	end

	for i,con in ipairs(GATHER_INFO_CONS) do
		gatherframe.info:AddCon(con)
	end

	gatherframe:HookScript("OnShow",function(me)
		me.professionDropdown:SetCurrentSelectedByValue(ZGV.db.profile.gold_gather_prof or GATHER_PROF_DROPDOWN_OPTIONS[1][2])
	end)

	gatherframe.professionDropdown = CHAIN(ui:Create("DropDown",gatherframe.footer,DROPDOWN_STYLE))
		:SetPoint("BOTTOMRIGHT",gatherframe.footer,"BOTTOMRIGHT",-DROPDOWN_HORZ_PADDING, (ROW_FOOTER-DROPDOWN_HEIGHT)/2)
		:SetSize(DROPDOWN_WIDTH,DROPDOWN_HEIGHT)
		:AddTooltip("ANCHOR_TOPLEFT","Filter gathering routes by profession.")	-- TODO Change text of the tooltip
	.__END

	gatherframe.professionDropdownLabel = CHAIN(gatherframe.footer:CreateFontString())
		:SetPoint("RIGHT",gatherframe.professionDropdown.frame,"LEFT",-DROPDOWN_LABEL_PADDING,0)
		:SetFont(FONTBOLD,COLFOOTER_FONTSIZE)
		:SetText("Filter:")
	.__END

	for optnum,opt in ipairs(GATHER_PROF_DROPDOWN_OPTIONS) do
		local item = gatherframe.professionDropdown:AddItem(opt[1],opt[2],function(item)
			-- Only worry about the callback if the frame is visible. So code side calls of this will not change ZGVG.
			if not gatherframe:IsVisible() then return end

			ZGV.db.profile.gold_gather_prof = item.userdata.value

			ZGVG:Update()
		end)
	end

	return gatherframe
end

function ZGVG:MakeGoldRunTable()	
	-- The whole middle section of the Frame. Has it's own header/footer

	local goldrunframe = CHAIN(ui:Create("SecFrame",self.FUI,"ZGGoldGoldRunFrame"))
		:SetPoint("TOPLEFT",1,-HEADER_HEIGHT)
		:SetPoint("BOTTOMRIGHT",-1,FOOTER_HEIGHT)
		:CanDrag("parent")
		:SetScript("OnShow",function(me)
			me.runtypeDropdown:SetCurrentSelectedByValue(ZGV.db.profile.gold_run_type or GOLD_RIGHT_DROPDOWN_OPTIONS[1][2])
		end)
	.__END

	goldrunframe.info = CHAIN(GetInfoFrame(goldrunframe))
		:SetSummaryText(GOLD_INFO_SUMMARY)
		:SetDiffBarPercent(GOLD_INFO_DIFF_PERCENT)
	.__END

	for i,pro in ipairs(GOLD_INFO_PROS) do
		goldrunframe.info:AddPro(pro)
	end

	for i,con in ipairs(GOLD_INFO_CONS) do
		goldrunframe.info:AddCon(con)
	end
	
	-- Header
	goldrunframe.col_no = CHAIN(goldrunframe:CreateFontString())
		:SetPoint("TOPLEFT",goldrunframe,"TOPLEFT",0,0)
		:SetSize(GOLDRUN_COLUMNSIZES[1],ROW_HEADER)	:SetJustifyV("CENTER")	:SetJustifyH("CENTER")	:SetFont(FONTBOLD,COLHEADER_FONTSIZE)
		:SetText("TYPE")
	.__END

	goldrunframe.col_title = CHAIN(goldrunframe:CreateFontString())
		:SetPoint("LEFT",goldrunframe.col_no,"RIGHT",ROW_ITEM_ICON_SIZE + ROW_GOLD_COL_PADDING,0) 
		:SetSize(GOLDRUN_COLUMNSIZES[2],ROW_HEADER)	:SetJustifyV("CENTER")	:SetJustifyH("LEFT")		:SetFont(FONTBOLD,COLHEADER_FONTSIZE)
		:SetText("NAME")
	.__END

	-- money
	goldrunframe.col_lab1 = CHAIN(goldrunframe:CreateFontString())
		:SetPoint("LEFT",goldrunframe.col_title,"RIGHT",ROW_GOLD_COL_PADDING,0) 
		:SetSize(GOLDRUN_COLUMNSIZES[3],ROW_HEADER)	:SetJustifyV("CENTER")	:SetJustifyH("LEFT")		:SetFont(FONTBOLD,COLHEADER_FONTSIZE)
		:SetText("TIME")
	.__END

	-- demand
	goldrunframe.col_lab2 = CHAIN(goldrunframe:CreateFontString())
		:SetPoint("LEFT",goldrunframe.col_lab1,"RIGHT",ROW_GOLD_COL_PADDING,0) 
		:SetSize(GOLDRUN_COLUMNSIZES[4],ROW_HEADER)	:SetJustifyV("CENTER")	:SetJustifyH("RIGHT")		:SetFont(FONTBOLD,COLHEADER_FONTSIZE)
		:SetText("GOLD")
	.__END

	-- Middle
	goldrunframe.rows={}
	for n=1,ROWCOUNT do
		goldrunframe.rows[n] = CHAIN(ui:Create("Button",goldrunframe,"ZGGoldRunRow"..n))
			-- Tricky tricky setting width. Set the height then set right point so that if the scrollbar is hidden that it expands the whole frame. If scrollbar is shown, then only expands to the scrollbar.
			:SetSize(GOLD_FRAME_ROW_WIDTH,ROW_HEIGHT)
			:SetPoint("RIGHT",self.FUI.scrollbar.barframe,"LEFT")
			:SetFrameStrata("HIGH")
			:SetBackdropColor(unpack(ui.SkinData("SecBackdropColor")))
			:SetBackdropBorderColor(0,0,0,0)
			:CanDrag("parent")
			:SetScript("OnDoubleClick",load_chore)
			:SetScript("OnEnter",function(self)
				self.chore:CalculateDetails()
				if self.chore.typ == "daily" or self.chore.typ == "vendor" then
					ZGVG.FGoldrun:ShowItemsForChore(self.chore,self)
				else
					ZGVG.FItems:ShowItemsForChore(self.chore,self)
				end
			end)
			:SetScript("OnLeave",function(self) 
				ZGVG.FItems:Hide()
				ZGVG.FGoldrun:Hide()
			end)
		.__END

		if n==1 then
			goldrunframe.rows[n]:SetPoint("TOPLEFT",goldrunframe,"TOPLEFT",0,-ROW_HEADER)
		else
			goldrunframe.rows[n]:SetPoint("TOPLEFT",goldrunframe.rows[n-1],"BOTTOMLEFT",0,0)
		end

		local row = goldrunframe.rows[n]

		row.typeIcon = CHAIN(row:CreateTexture())
			:SetPoint("CENTER",row,"LEFT",goldrunframe.col_no:GetWidth()/2,0) 
			:SetSize(ROW_GOLDRUN_ICON_SIZE,ROW_GOLDRUN_ICON_SIZE)
		.__END

		row.titleIcon = CHAIN(row:CreateTexture())
			:SetPoint("LEFT",row.typeIcon,"RIGHT",ROW_GOLD_TYPE_PADDING,0) 
			:SetSize(ROW_ITEM_ICON_SIZE,ROW_ITEM_ICON_SIZE)
		.__END

		row.title = CHAIN(row:CreateFontString())
			:SetPoint("LEFT",row.titleIcon,"RIGHT",ROW_GOLD_COL_PADDING,0) 
			:SetSize(goldrunframe.col_title:GetWidth(),ROW_FONTSIZE)
			:SetJustifyH("LEFT")
			:SetFont(FONT,ROW_FONTSIZE)
			:SetText("run type")
		.__END

		-- time
		row.lab1 = CHAIN(row:CreateFontString())
			:SetPoint("LEFT",row.title,"RIGHT",ROW_ROUTE_GOLD_PADDING,0) 
			:SetSize(goldrunframe.col_lab1:GetWidth(),ROW_FONTSIZE)
			:SetJustifyH("LEFT")
			:SetFont(FONT,ROW_FONTSIZE)
			:SetText("time")
		.__END

		-- money
		row.lab2 = CHAIN(row:CreateFontString())
			:SetPoint("LEFT",row.lab1,"RIGHT",ROW_GOLD_COL_PADDING,0) 
			:SetSize(goldrunframe.col_lab2:GetWidth(),ROW_FONTSIZE)
			:SetJustifyH("RIGHT")		-- Right aligned because it makes the money line up nicely when there is no Gold/silver amounts
			:SetFont(FONT,ROW_FONTSIZE)
			:SetText("$$$$")
		.__END

		row.loadbutton = CHAIN(CreateFrame("BUTTON",row:GetName().."LoadButton",row))
			:SetPoint("RIGHT",row,"RIGHT",-ROW_LOAD_RIGHT_PADDING,0)
			:SetSize(ROW_LOAD_BUT_SIZE,ROW_LOAD_BUT_SIZE)
			:SetScript("OnClick",load_chore)
			:SetScript("OnEnter",tip_chore)
			:SetScript("OnLeave",hide_tooltip)
		.__END
		ZGV.AssignButtonTexture(row.loadbutton,(SkinData("TitleButtons")),19,32)
		CHAIN(row.loadbutton:CreateTexture(row.loadbutton:GetName().."Back","BACKGROUND")) :SetAllPoints() :SetTexture(unpack(SkinData("AccentColor")))

		row.hilite = CHAIN(row:CreateTexture(row:GetName().."Back","HIGHLIGHT")) :SetAllPoints() :SetTexture(1,1,1,0.15) .__END

		row.back = CHAIN(row:CreateTexture(row:GetName().."Back","ARTWORK")) :SetAllPoints() :SetTexture(1,1,1,1) .__END

	end
	
	goldrunframe.footer = CHAIN(CreateFrame("FRAME",nil,goldrunframe))
		:SetPoint("BOTTOMLEFT",goldrunframe,"BOTTOMLEFT",0,0)
		:SetPoint("TOPRIGHT",goldrunframe,"BOTTOMRIGHT",0,ROW_FOOTER)
	.__END

	--Footer
	goldrunframe.runtypeDropdown = CHAIN(ui:Create("DropDown",goldrunframe.footer,DROPDOWN_STYLE))
		:SetPoint("BOTTOMRIGHT",goldrunframe.footer,"BOTTOMRIGHT",-DROPDOWN_HORZ_PADDING, (ROW_FOOTER-DROPDOWN_HEIGHT)/2)
		:SetSize(DROPDOWN_WIDTH,DROPDOWN_HEIGHT)
		:AddTooltip("ANCHOR_TOPLEFT","Filter what sort of runs are shown.")	-- TODO Change text of the tooltip
	.__END

	goldrunframe.runtypeDropdownLabel = CHAIN(goldrunframe.footer:CreateFontString())
		:SetPoint("RIGHT",goldrunframe.runtypeDropdown.frame,"LEFT",-DROPDOWN_LABEL_PADDING,0)
		:SetFont(FONTBOLD,COLFOOTER_FONTSIZE)
		:SetText("Filter:")
	.__END

	for optnum,opt in ipairs(GOLD_RIGHT_DROPDOWN_OPTIONS) do
		local item = goldrunframe.runtypeDropdown:AddItem(opt[1],opt[2],function(item)
			-- Only worry about the callback if the frame is visible. So code side calls of this will not change ZGVG.
			if not goldrunframe:IsVisible() then return end

			ZGV.db.profile.gold_run_type = item.userdata.value

			ZGVG:Update()
		end)
	end

	goldrunframe:Hide()
	return goldrunframe
end

function ZGVG:MakeCraftingTable()	
	-- The whole middle section of the Frame. Has it's own header/footer

	local frame = CHAIN(ui:Create("SecFrame",self.FUI,"ZGGoldCraftingFrame"))
		:SetPoint("TOPLEFT",1,-HEADER_HEIGHT)
		:SetPoint("BOTTOMRIGHT",-1,FOOTER_HEIGHT)
		:CanDrag("parent")
		:SetScript("OnShow",function(me)
			me.runtypeDropdown:SetCurrentSelectedByValue(ZGV.db.profile.gold_crafting_type or 0)
			me.runtypeModeDropdown:SetCurrentSelectedByValue(ZGV.db.profile.gold_crafting_mode or 0)
		end)
	.__END

	frame.info = CHAIN(GetInfoFrame(frame))
		:SetSummaryText(CRAFTING_INFO_SUMMARY)
		:SetDiffBarPercent(CRAFTING_INFO_DIFF_PERCENT)
	.__END

	for i,pro in ipairs(CRAFTING_INFO_PROS) do
		frame.info:AddPro(pro)
	end

	for i,con in ipairs(CRAFTING_INFO_CONS) do
		frame.info:AddCon(con)
	end
	
	-- Header
	frame.col_icon = CHAIN(frame:CreateFontString())
		:SetPoint("TOPLEFT",frame,"TOPLEFT",0,0)
		:SetSize(CRAFTING_COLUMNSIZES[1],ROW_HEADER)
		:SetJustifyV("CENTER")
		:SetJustifyH("LEFT")
		:SetFont(FONTBOLD,COLHEADER_FONTSIZE)
		:SetText("")
	.__END

	frame.col_title = CHAIN(frame:CreateFontString())
		:SetPoint("LEFT",frame.col_icon,"RIGHT",ROW_GOLD_COL_PADDING,0) 
		:SetSize(CRAFTING_COLUMNSIZES[2],ROW_HEADER)
		:SetJustifyV("CENTER")
		:SetJustifyH("LEFT")
		:SetFont(FONTBOLD,COLHEADER_FONTSIZE)
		:SetText("RECIPE")
	.__END

	frame.col_status = CHAIN(frame:CreateFontString())
		:SetPoint("LEFT",frame.col_title,"RIGHT",ROW_GOLD_COL_PADDING,0) 
		:SetSize(CRAFTING_COLUMNSIZES[3],ROW_HEADER)
		:SetJustifyV("CENTER")
		:SetJustifyH("RIGHT")
		:SetFont(FONTBOLD,COLHEADER_FONTSIZE)
		:SetText("STATUS")
	.__END

	frame.col_cost = CHAIN(frame:CreateFontString())
		:SetPoint("LEFT",frame.col_status,"RIGHT",ROW_GOLD_COL_PADDING,0) 
		:SetSize(CRAFTING_COLUMNSIZES[4],ROW_HEADER)
		:SetJustifyV("CENTER")
		:SetJustifyH("RIGHT")
		:SetFont(FONTBOLD,COLHEADER_FONTSIZE)
		:SetText("COST")
	.__END

	-- money
	frame.col_profit = CHAIN(frame:CreateFontString())
		:SetPoint("LEFT",frame.col_cost,"RIGHT",ROW_GOLD_COL_PADDING,0) 
		:SetSize(CRAFTING_COLUMNSIZES[5],ROW_HEADER)
		:SetJustifyV("CENTER")
		:SetJustifyH("RIGHT")
		:SetFont(FONTBOLD,COLHEADER_FONTSIZE)
		:SetText("PROFIT")
	.__END

	frame.col_buttons = CHAIN(frame:CreateFontString())
		:SetPoint("LEFT",frame.col_profit,"RIGHT",ROW_GOLD_COL_PADDING,0) 
		:SetSize(CRAFTING_COLUMNSIZES[6],ROW_HEADER)	
		:SetJustifyV("CENTER")	
		:SetJustifyH("RIGHT")		
		:SetFont(FONTBOLD,COLHEADER_FONTSIZE)
		:SetText("")
	.__END

	-- Middle
	frame.rows={}
	for n=1,ROWCOUNT do
		frame.rows[n] = CHAIN(ui:Create("Button",frame,"ZGGoldCraftingRow"..n))
			-- Tricky tricky setting width. Set the height then set right point so that if the scrollbar is hidden that it expands the whole frame. If scrollbar is shown, then only expands to the scrollbar.
			:SetSize(GOLD_FRAME_ROW_WIDTH,ROW_HEIGHT)
			:SetPoint("RIGHT",self.FUI.scrollbar.barframe,"LEFT")
			:SetFrameStrata("HIGH")
			:SetBackdropColor(unpack(ui.SkinData("SecBackdropColor")))
			:SetBackdropBorderColor(0,0,0,0)
			:CanDrag("parent")
			:SetScript("OnDoubleClick",generate_guide_wrapper)
			:SetScript("OnEnter",function(self)
				ZGVG.FCraftingDetail:ShowCraftDetails(self.chore,self)
				end)
			:SetScript("OnLeave",function(self) ZGVG.FCraftingDetail:Hide() end)
		.__END

		if n==1 then
			frame.rows[n]:SetPoint("TOPLEFT",frame,"TOPLEFT",0,-ROW_HEADER)
		else
			frame.rows[n]:SetPoint("TOPLEFT",frame.rows[n-1],"BOTTOMLEFT",0,0)
		end

		local row = frame.rows[n]

		row.icon = CHAIN(row:CreateTexture())
			:SetPoint("CENTER",row,"LEFT",frame.col_icon:GetWidth()/2,0) 
			:SetSize(ROW_CRAFTING_ICON_SIZE,ROW_CRAFTING_ICON_SIZE)
		.__END

		row.title = CHAIN(row:CreateFontString())
			:SetPoint("LEFT",row.icon,"RIGHT",16,0)
			:SetSize(frame.col_title:GetWidth(),ROW_FONTSIZE)
			:SetJustifyH("LEFT")
			:SetFont(FONT,ROW_FONTSIZE)
			:SetText("title")
		.__END

		-- cost
		row.status = CHAIN(row:CreateFontString())
			:SetPoint("LEFT",row.title,"RIGHT",ROW_GOLD_COL_PADDING,0)
			:SetSize(frame.col_status:GetWidth(),ROW_FONTSIZE)
			:SetJustifyH("CENTER")
			:SetFont(FONTSTATUS,ROW_FONTSIZE)
			:SetText("status")
		.__END

		-- cost
		row.lab1 = CHAIN(row:CreateFontString())
			:SetPoint("LEFT",row.status,"RIGHT",ROW_GOLD_COL_PADDING,0)
			:SetSize(frame.col_cost:GetWidth(),ROW_FONTSIZE)
			:SetJustifyH("RIGHT")
			:SetFont(FONT,ROW_FONTSIZE)
			:SetText("cost")
		.__END

		-- money
		row.lab2 = CHAIN(row:CreateFontString())
			:SetPoint("LEFT",row.lab1,"RIGHT",ROW_GOLD_COL_PADDING,0) 
			:SetSize(frame.col_profit:GetWidth(),ROW_FONTSIZE)
			:SetJustifyH("RIGHT")		-- Right aligned because it makes the money line up nicely when there is no Gold/silver amounts
			:SetFont(FONT,ROW_FONTSIZE)
			:SetText("profit")
		.__END

		row.amount = CHAIN(ui:Create("EditBox",row))
			:SetPoint("LEFT",row.lab2,"RIGHT",ROW_GOLD_COL_PADDING,0) 
			:SetSize(frame.col_buttons:GetWidth(),ROW_FONTSIZE)
			:SetText("1")
			:SetNumeric(true)
			:SetScript("OnTextChanged",update_row_amounts)
			:SetBackdrop(ZGV.CurrentSkinStyle:SkinData("DropDownBackdrop1"))
			:SetBackdropColor(unpack(ZGV.CurrentSkinStyle:SkinData("DropDownBackdrop1Color")))
			:SetTextColor(1,1,1)
		.__END

		-- Shooter
		row.amount:Hide()


		row.loadbutton = CHAIN(CreateFrame("BUTTON",row:GetName().."LoadButton",row))
			:SetPoint("LEFT",row.amount,"RIGHT",ROW_GOLD_COL_PADDING,0) 
			:SetSize(ROW_LOAD_BUT_SIZE,ROW_LOAD_BUT_SIZE)
			:SetScript("OnClick",generate_guide_wrapper)
			:SetScript("OnEnter",tip_craft)
			:SetScript("OnLeave",hide_tooltip)
		.__END
		ZGV.AssignButtonTexture(row.loadbutton,(SkinData("TitleButtons")),19,32)
		CHAIN(row.loadbutton:CreateTexture(row.loadbutton:GetName().."Back","BACKGROUND")) :SetAllPoints() :SetTexture(unpack(SkinData("AccentColor")))

		row.hilite = CHAIN(row:CreateTexture(row:GetName().."Back","HIGHLIGHT")) :SetAllPoints() :SetTexture(1,1,1,0.15) .__END

		row.back = CHAIN(row:CreateTexture(row:GetName().."Back","ARTWORK")) :SetAllPoints() :SetTexture(1,1,1,1) .__END

	end
	
	frame.footer = CHAIN(CreateFrame("FRAME",nil,frame))
		:SetPoint("BOTTOMLEFT",frame,"BOTTOMLEFT",0,0)
		:SetPoint("TOPRIGHT",frame,"BOTTOMRIGHT",0,ROW_FOOTER)
	.__END

	--Footer
	frame.runtypeDropdown = CHAIN(ui:Create("DropDown",frame.footer,DROPDOWN_STYLE))
		:SetPoint("BOTTOMRIGHT",frame.footer,"BOTTOMRIGHT",-DROPDOWN_HORZ_PADDING, (ROW_FOOTER-DROPDOWN_HEIGHT)/2)
		:SetSize(DROPDOWN_WIDTH,DROPDOWN_HEIGHT)
		:AddTooltip("ANCHOR_TOPLEFT","Filter which profession to show.")	-- TODO Change text of the tooltip
	.__END

	frame.runtypeModeDropdown = CHAIN(ui:Create("DropDown",frame.footer,DROPDOWN_STYLE))
		:SetPoint("BOTTOMLEFT",frame.footer,"BOTTOMLEFT", DROPDOWN_HORZ_PADDING, (ROW_FOOTER-DROPDOWN_HEIGHT)/2)
		:SetSize(DROPDOWN_WIDTH,DROPDOWN_HEIGHT)
		:AddTooltip("ANCHOR_TOPLEFT","Select mode.")	-- TODO Change text of the tooltip
	.__END

	frame.runtypeDropdownLabel = CHAIN(frame.footer:CreateFontString())
		:SetPoint("RIGHT",frame.runtypeDropdown.frame,"LEFT",-DROPDOWN_LABEL_PADDING,0)
		:SetFont(FONTBOLD,COLFOOTER_FONTSIZE)
		:SetText("Filter:")
	.__END



	local item = frame.runtypeDropdown:AddItem("All",0,function(item)
			-- Only worry about the callback if the frame is visible. So code side calls of this will not change ZGVG.
			if not frame:IsVisible() then return end
			ZGV.db.profile.gold_crafting_type = item.userdata.value
			ZGVG:Update()
		end)

	local item = frame.runtypeModeDropdown:AddItem("Easy",0,function(item)
			-- Only worry about the callback if the frame is visible. So code side calls of this will not change ZGVG.
			if not frame:IsVisible() then return end
			ZGV.db.profile.gold_crafting_mode = item.userdata.value
			ZGVG:Update()
		end)
	local item = frame.runtypeModeDropdown:AddItem("Expert",1,function(item)
			-- Only worry about the callback if the frame is visible. So code side calls of this will not change ZGVG.
			if not frame:IsVisible() then return end
			ZGV.db.profile.gold_crafting_mode = item.userdata.value
			ZGVG:Update()
		end)

	local craftingskills={"Mining","Jewelcrafting","Enchanting","Inscription","Blacksmithing","Engineering","Alchemy","Tailoring","Leatherworking"}
        	
	for _,skillname in ipairs(craftingskills) do
		if ZGV:GetSkill(skillname).level>0 then
			local skillid = ZGV.skillIDs[skillname]
			local item = frame.runtypeDropdown:AddItem(skillname,skillid,function(item)
				-- Only worry about the callback if the frame is visible. So code side calls of this will not change ZGVG.
				if not frame:IsVisible() then return end
				ZGV.db.profile.gold_crafting_type = item.userdata.value
				ZGVG:Update()
			end)
		end
	end


	frame:Hide()
	ZGVG:FillCraftingTable()

	return frame
end

local function FillCraftingTable_Threaded()
	ZGVG.craftchores = {}
	ZGVG.Crafting:GetCraftToRecipe()
	local index = 0
	local fill_start = debugprofilestop()

	for skillname,skillid in pairs(ZGV.skillIDs) do  if ZGV:GetSkill(skillname).level>0 then
	--for skillid,skills in pairs(ZGVG.Crafting.AllRecipes) do
		for spellid,recipe in pairs(ZGVG.Crafting.AllRecipes[skillid] or {}) do
			index = index + 1
			cost,profit,comments,items_buy,items_craft,items_farm,items_vendor,expert,unknown,skip = ZGVG.chore_protos.crafting.GetCraftingDetails(recipe,skillid)
			tinsert(ZGVG.craftchores,{
				typ="craft",
				recipe=recipe,
				profit=profit,
				cost=cost,
				comments=comments,
				items_buy = items_buy,
				items_craft = items_craft,
				items_farm = items_farm,
				items_vendor = items_vendor,
				expert = expert,
				unknown = unknown,
				skip = skip,
				prof = skillid
			})
			local fill_now = debugprofilestop()
			if fill_now-fill_start > 100 then
				fill_start = fill_now
				coroutine.yield(-1)
			end
		end
	end end
end

function ZGVG:FillCraftingTable()
	if ZGVG.craftchores and next(ZGVG.craftchores) and ZGVG.LastScanUsed and ZGVG.LastScanUsed == ZGVG.Scan.db.realm.LastScan then
		return 
	else
		ZGVG.LastScanUsed = ZGVG.Scan.db.realm.LastScan 
		ZGVG.doneloadingcrafting = false
		ZGVG.fillerthread = coroutine.create(FillCraftingTable_Threaded)
	end
end

function ZGVG:ContinueFillCraftingTable()
	if coroutine.status(ZGVG.fillerthread) ~= 'dead' then
		local errorfree, value = coroutine.resume(ZGVG.fillerthread)
	elseif not ZGVG.doneloadingcrafting then
		ZGVG.doneloadingcrafting = true
		ZGVG:Update()
	end
end

function ZGVG:MakeAuctionTable()	
	-- The whole middle section of the Frame. Has it's own header/footer

	local frame = CHAIN(ui:Create("SecFrame",self.FUI,"ZGGoldAuctionFrame"))
		:SetPoint("TOPLEFT",1,-HEADER_HEIGHT)
		:SetPoint("BOTTOMRIGHT",-1,FOOTER_HEIGHT)
		:CanDrag("parent")
		:SetScript("OnShow",function(me)
			if not ZGV.db.profile.gold_auction_type then ZGV.db.profile.gold_auction_type = 0 end
			if not ZGV.db.profile.gold_auction_mode then ZGV.db.profile.gold_auction_mode = 10 end
			me.AuctionTypeDropdown:SetCurrentSelectedByValue(ZGV.db.profile.gold_auction_type)
			me.AuctionModeDropdown:SetCurrentSelectedByValue(ZGV.db.profile.gold_auction_mode)
		end)
	.__END

	frame.info = CHAIN(GetInfoFrame(frame))
		:SetSummaryText(AUCTION_INFO_SUMMARY)
		:SetDiffBarPercent(AUCTION_INFO_DIFF_PERCENT)
	.__END

	for i,pro in ipairs(AUCTION_INFO_PROS) do
		frame.info:AddPro(pro)
	end

	for i,con in ipairs(AUCTION_INFO_CONS) do
		frame.info:AddCon(con)
	end
	

	local prev
	for k,col in ipairs(AUCTION_COLUMNS) do
		local widget = CHAIN(frame:CreateFontString())
		:SetSize(col.width,ROW_HEADER)
		:SetJustifyV("CENTER")
		:SetJustifyH(col.titlej)
		:SetFont(FONTBOLD,COLHEADER_FONTSIZE)
		:SetText(col.title)
		.__END
		if not prev 
			then widget:SetPoint("TOPLEFT",frame,"TOPLEFT",0,0)
		elseif k==2 then
			widget:SetPoint("LEFT",prev,"RIGHT",0,0)
		else
			widget:SetPoint("LEFT",prev,"RIGHT",ROW_AUCTION_COL_PADDING,0)
		end
		frame["col_"..col.name] = widget
		prev=widget
	end

	-- Middle
	frame.rows={}
	for n=1,ROWCOUNT do
		frame.rows[n] = CHAIN(ui:Create("Button",frame,"ZGAuctionRow"..n))
			-- Tricky tricky setting width. Set the height then set right point so that if the scrollbar is hidden that it expands the whole frame. If scrollbar is shown, then only expands to the scrollbar.
			:SetSize(GOLD_FRAME_ROW_WIDTH,ROW_HEIGHT)
			:SetPoint("RIGHT",self.FUI.scrollbar.barframe,"LEFT")
			:SetFrameStrata("HIGH")
			:SetBackdropColor(unpack(ui.SkinData("SecBackdropColor")))
			:SetBackdropBorderColor(0,0,0,0)
			:CanDrag("parent")
			:SetScript("OnDoubleClick",load_chore)
			:SetScript("OnEnter",function(self)

				if IsShiftKeyDown() then
					GameTooltip:SetOwner(self:GetParent(),"ANCHOR_RIGHT")
					GameTooltip:SetText("Details:")

					local ST=ZGV.Gold.servertrends
					ST=ST and ST.items and ST.items[self.chore.itemid]
					local AH=ZGV.db.realm.gold_scan_data
					AH=AH and AH[1] and AH[1][self.chore.itemid]

					self.chore.GetAuctionChoreData(nil,ST,AH,self.chore,GameTooltip)
					GameTooltip:Show()
					GameTooltip:ClearAllPoints()
					GameTooltip:SetPoint("TOPLEFT",self:GetParent(),"TOPRIGHT")
				end



				ZGVG.FAuctionDetail:ShowAuction(self.chore,self)

				--self.chore:CalculateDetails()
				--ZGVG.FItems:ShowItemsForChore(self.chore,self)
			end)
			:SetScript("OnClick",function(self,button)
				if IsShiftKeyDown() then
					ZGVG.Scan:DebugItem(self.chore.itemid)
				else
					ZGVG.Scan:ScanByName(self.chore.name)
				end
			end)
			:SetScript("OnLeave",function(self) GameTooltip:Hide() ZGVG.FAuctionDetail:Hide() end)
		.__END

		if n==1 then
			frame.rows[n]:SetPoint("TOPLEFT",frame,"TOPLEFT",0,-ROW_HEADER)
		else
			frame.rows[n]:SetPoint("TOPLEFT",frame.rows[n-1],"BOTTOMLEFT",0,0)
		end

		local row = frame.rows[n]


		
		local prev
		for k,col in ipairs(AUCTION_COLUMNS) do
			local widget
			if col.typ=="icon" then 
				widget = CHAIN(row:CreateTexture())
					:SetPoint("CENTER",row,"LEFT",col.width/2,0) 
					:SetSize(ROW_AUCTION_ICON_SIZE,ROW_AUCTION_ICON_SIZE)
				.__END
			else
				widget = CHAIN(row:CreateFontString())
				:SetSize(col.width,ROW_FONTSIZE)
				:SetJustifyV("TOP")
				:SetJustifyH(col.textj)
				:SetFont(col.font,ROW_FONTSIZE)
				:SetText(col.title)
				.__END
			end
			if not prev then -- already set; messy, I know. ~sinus
			else widget:SetPoint("LEFT",prev,"RIGHT",ROW_AUCTION_COL_PADDING,0) end
			row[col.name] = widget
			prev=widget
		end

		row.iconOverlay = CHAIN(ui:Create("Button",row,"ZGAuctionRow"..n.."Icon"))
			:SetPoint("CENTER",row,"LEFT",20,0) 
			:SetSize(ROW_AUCTION_ICON_SIZE,ROW_AUCTION_ICON_SIZE)
			:SetFrameLevel(13)
			:SetBackdropColor(0,0,0,0)
			:SetBackdropBorderColor(0,0,0,0)
			:SetScript("OnEnter",function()
				GameTooltip:SetOwner(row.iconOverlay ,"ANCHOR_RIGHT")
				GameTooltip:SetItemByID(row.chore.itemid)
				GameTooltip:Show()
			end)
			:SetScript("OnLeave",function()
				GameTooltip:Hide()
			end)
		.__END

		
		row.loadbutton = CHAIN(CreateFrame("BUTTON",row:GetName().."LoadButton",row))
			:SetPoint("RIGHT",row,"RIGHT",-ROW_LOAD_RIGHT_PADDING,0)
			:SetSize(ROW_LOAD_BUT_SIZE,ROW_LOAD_BUT_SIZE)
			:SetScript("OnClick",function()
				ZGV.Gold.Appraiser:AddItemToBuy(row.chore.itemid,row.chore.count,true,row.chore.price)
				if ZGVG.HelpPopup then 
					ZGVG.HelpPopup:Next("appraiseradd") 
				end
			end)
			--:SetScript("OnEnter",ZGV.Gold.FAuctionDetail:ShowAuction(self.chore,self))
			:SetScript("OnEnter",tip_auction)
			:SetScript("OnLeave",hide_tooltip)
		.__END
		ZGV.AssignButtonTexture(row.loadbutton,(SkinData("TitleButtons")),19,32)
		CHAIN(row.loadbutton:CreateTexture(row.loadbutton:GetName().."Back","BACKGROUND")) :SetAllPoints() :SetTexture(unpack(SkinData("AccentColor")))

		row.hilite = CHAIN(row:CreateTexture(row:GetName().."Back","HIGHLIGHT")) :SetAllPoints() :SetTexture(1,1,1,0.15) .__END

		row.back = CHAIN(row:CreateTexture(row:GetName().."Back","ARTWORK")) :SetAllPoints() :SetTexture(1,1,1,1) .__END

	end
	
	frame.footer = CHAIN(CreateFrame("FRAME",nil,frame))
		:SetPoint("BOTTOMLEFT",frame,"BOTTOMLEFT",0,0)
		:SetPoint("TOPRIGHT",frame,"BOTTOMRIGHT",0,ROW_FOOTER)
	.__END

	--Footer
	frame.AuctionTypeDropdown = CHAIN(ui:Create("DropDown",frame.footer,DROPDOWN_STYLE))
		:SetPoint("BOTTOMRIGHT",frame.footer,"BOTTOMRIGHT",-DROPDOWN_HORZ_PADDING, (ROW_FOOTER-DROPDOWN_HEIGHT)/2)
		:SetSize(DROPDOWN_WIDTH_WIDE,DROPDOWN_HEIGHT)
		:AddTooltip("ANCHOR_TOPLEFT","Filter which proffession to show.")	-- TODO Change text of the tooltip
	.__END

	frame.AuctionModeDropdown = CHAIN(ui:Create("DropDown",frame.footer,DROPDOWN_STYLE))
		:SetPoint("BOTTOMLEFT",frame.footer,"BOTTOMLEFT", DROPDOWN_HORZ_PADDING, (ROW_FOOTER-DROPDOWN_HEIGHT)/2)
		:SetSize(DROPDOWN_WIDTH,DROPDOWN_HEIGHT)
		:AddTooltip("ANCHOR_TOPLEFT","Select mode.")	-- TODO Change text of the tooltip
	.__END

	frame.AuctionTypeDropdownLabel = CHAIN(frame.footer:CreateFontString())
		:SetPoint("RIGHT",frame.AuctionTypeDropdown.frame,"LEFT",-DROPDOWN_LABEL_PADDING,0)
		:SetFont(FONTBOLD,COLFOOTER_FONTSIZE)
		:SetText("Filter:")
	.__END



	local item = frame.AuctionTypeDropdown:AddItem("All",0,function(item)
			-- Only worry about the callback if the frame is visible. So code side calls of this will not change ZGVG.
			if not frame:IsVisible() then return end
			ZGV.db.profile.gold_auction_type = item.userdata.value
			ZGVG:Update()
		end)
	local AuctionTypeFilter = {
		[1] = "Equipment",
		[2] = "Trade Goods",
		[3] = "Consumables",
		[4] = "Others",
	}

	for i,index in pairs(AuctionTypeFilter) do
		local item = frame.AuctionTypeDropdown:AddItem(AuctionTypeFilter[i],i,function(item)
			-- Only worry about the callback if the frame is visible. So code side calls of this will not change ZGVG.
			if not frame:IsVisible() then return end
			ZGV.db.profile.gold_auction_type = item.userdata.value
			ZGVG:Update()
		end)
	end

	local item = frame.AuctionModeDropdown:AddItem("Easy",10,function(item)
			if not frame:IsVisible() then return end
			ZGV.db.profile.gold_auction_mode = item.userdata.value
			ZGVG:Update()
		end,"Show best investments")

	local item = frame.AuctionModeDropdown:AddItem("Advanced",5,function(item)
			if not frame:IsVisible() then return end
			ZGV.db.profile.gold_auction_mode = item.userdata.value
			ZGVG:Update()
		end,"Show good investments")
	
	local item = frame.AuctionModeDropdown:AddItem("Expert",0,function(item)
			if not frame:IsVisible() then return end
			ZGV.db.profile.gold_auction_mode = item.userdata.value
			ZGVG:Update()
		end,"Show all investments")


	
	frame:Hide()
	return frame
end

function ZGVG:CreateFrame()
	self.FUI = CHAIN(ui:Create("Frame",UIParent,"ZGGoldMainFrame"))
		:SetPoint("TOPLEFT",UIParent,"TOPLEFT",20,-100)
		:SetSize(unpack(GOLD_FRAME_SIZE))
		:SetFrameStrata("HIGH")
		:SetFrameLevel(10)
		:SetUserPlaced(true)
		:CanDrag(1)
		:RegisterEvent("AUCTION_HOUSE_SHOW") --
		:RegisterEvent("AUCTION_HOUSE_CLOSED") --
		:RegisterEvent("GET_ITEM_INFO_RECEIVED") --
		:SetScript("OnMouseWheel", function(self,delta)
			ZGVG.FUI.offset=ZGVG.FUI.offset-delta
			self.is_dirty=true
		end)
		:SetScript("OnUpdate",function(self,elapsed)
			--TODO throttle this so it isn't updated constantly. Maybe only every few seconds
			if self.is_dirty then
				self.is_dirty=nil
				ZGVG:Update()
			end
			ZGVG:UpdateTimeStamp()
			ZGVG:ContinueFillCraftingTable()
		end)
		:SetScript("OnDragStop",function(self) self:StopMovingOrSizing() self:AlignFrame() end)
		:SetScript("OnEvent",ZGVG.Frame_OnEvent)
		:Hide()
		.__END
		--:RegisterEvent("PLAYER_ENTERING_WORLD")

	-- Header
		self.FUI.zygorlogo = CHAIN(self.FUI:CreateTexture(nil,"ARTWORK"))
			:SetTexture(SkinData("TitleLogo"))
			--:SetTexCoord(16/32,17/32,2/4,3/4)
			:SetSize(120,30)
			:SetPoint("TOP",self.FUI:GetName(),"TOP",0,-5)
		.__END


		self.FUI.close = CHAIN(CreateFrame("Button",self.FUI:GetName().."_Close",self.FUI))
			:SetPoint("TOPRIGHT",-5,-5)
			:SetSize(ICON_SIZE,ICON_SIZE)
			:SetScript("OnClick",function() self.FUI:Hide() end)
			.__END
		ZGV.AssignButtonTexture(self.FUI.close,(SkinData("TitleButtons")),6,32)

		self.FUI.help = CHAIN(CreateFrame("Button",self.FUI:GetName().."_Help",self.FUI))
			:SetPoint("TOPLEFT",25,-5)
			:SetSize(ICON_SIZE,ICON_SIZE)
			:SetScript("OnClick",function() 
				ZGVG.helppanel = not ZGVG.helppanel
				ZGV.db.global.gold_info_pages = false
				ZGVG:Update()
			end)	-- TODO Be helpful
			.__END
		ZGV.AssignButtonTexture(self.FUI.help,(SkinData("TitleButtons")),1,32)

		self.FUI.info = CHAIN(CreateFrame("Button",self.FUI:GetName().."_Info",self.FUI))
			:SetPoint("TOPLEFT",5,-5)
			:SetSize(ICON_SIZE,ICON_SIZE)
			:SetScript("OnClick",function() 
				ZGVG.helppanel = false
				ZGV.db.global.gold_info_pages = not ZGV.db.global.gold_info_pages	-- toggle is so if shown it disappears, if not shown it appears
				ZGVG:Update()	-- Refresh to show the info page.
			end)
			.__END
		ZGV.AssignButtonTexture(self.FUI.info,(SkinData("TitleButtons")),18,32)

		self.FUI.Tabs = {}

		local NUMICONS=8

		self.FUI.Tabs[1] = CHAIN(self:MakeImgButton("Tab1",ZGV.DIR.."\\Skins\\goldguideicons",1,NUMICONS,1,2,nil))
			:SetPoint("BOTTOMLEFT",self.FUI,"TOPLEFT",DIST_BETW_TABS/2,-HEADER_HEIGHT+TAB_HEIGHT_ABOVE_TABLES)
			:SetText("Gold Runs")
			:SetScript("OnClick",function(tab) ZGVG.FUI:SetCurrentTab("goldrun") end)
		.__END
		self.FUI.Tabs[1].tabname = "goldrun"

		self.FUI.Tabs[2] = CHAIN(self:MakeImgButton("Tab2",ZGV.DIR.."\\Skins\\goldguideicons",2,NUMICONS,1,2,nil))
			:SetPoint("LEFT",self.FUI.Tabs[1],"RIGHT",DIST_BETW_TABS,0)
			:SetText("Farming")
			:SetScript("OnClick",function(tab) ZGVG.FUI:SetCurrentTab("farming") end)
		.__END
		self.FUI.Tabs[2].tabname = "farming"

		self.FUI.Tabs[3] = CHAIN(self:MakeImgButton("Tab3",ZGV.DIR.."\\Skins\\goldguideicons",3,NUMICONS,1,2,nil))
			:SetPoint("LEFT",self.FUI.Tabs[2],"RIGHT",DIST_BETW_TABS,0)
			:SetText("Gathering")
			:SetScript("OnClick",function(tab) ZGVG.FUI:SetCurrentTab("gathering") end)
		.__END
		self.FUI.Tabs[3].tabname = "gathering"
		
		self.FUI.Tabs[4] = CHAIN(self:MakeImgButton("Tab4",ZGV.DIR.."\\Skins\\goldguideicons",4,NUMICONS,1,2,nil))
			:SetPoint("LEFT",self.FUI.Tabs[3],"RIGHT",DIST_BETW_TABS,0)
			:SetText("Crafting")
			:SetScript("OnClick",function(tab) ZGVG.FUI:SetCurrentTab("crafting") end)
		.__END
		self.FUI.Tabs[4].tabname = "crafting"

		self.FUI.Tabs[5] = CHAIN(self:MakeImgButton("Tab5",ZGV.DIR.."\\Skins\\goldguideicons",5,NUMICONS,1,2,nil))
			:SetPoint("LEFT",self.FUI.Tabs[4],"RIGHT",DIST_BETW_TABS,0)
			:SetText("Auctions")
			:SetScript("OnClick",function(tab) ZGVG.FUI:SetCurrentTab("auctions") end)	--TODO What tab?
		.__END
		self.FUI.Tabs[5].tabname = "auctions"

	-- Middle
		-- TODO scrollbar is kind of wonky right now... We don't actually use a scrollframe and just move the bar up and down visually along with ZGVG:Update and then adjust the scrolls to utilize Update properly
		self.FUI.scrollbar = CHAIN(ui:Create("ScrollItems",self.FUI,"ZGGoldScroll"))
			:SetPoint("TOPLEFT",self.FUI,"TOPRIGHT",-SCROLL_WIDTH-1,-HEADER_HEIGHT - ROW_HEADER)
			--:MySetPoint("RIGHT",self.FUI,"RIGHT",-1,0)
			:SetPoint("BOTTOMRIGHT",self.FUI,"BOTTOMRIGHT",-SCROLL_WIDTH-1,FOOTER_HEIGHT + ROW_FOOTER)
			:MaxValueAtOnce(ROWCOUNT)
			--:AddButtons()
			:SetScript("OnVerticalScroll",function(me,offset)
				ZGVG.FUI.offset=math.round(offset)	-- Can be a float sometimes which can cause errors
				ZGVG.FUI.is_dirty=true
			end)
			-- Piggy backs off of the mouse wheel from the self.FUI
			:SetHideWhenUnless(1)
		.__END
		
		--[[
		local oldUpMouseDown = self.FUI.scrollbar.upbut:GetScript("OnMouseDown")
		self.FUI.scrollbar.upbut:SetScript("OnMouseDown",function(me)
			self.FUI:GetScript("OnMouseWheel")(self.FUI,1)
			oldUpMouseDown(me)
		end)

		local oldDownMouseDown = self.FUI.scrollbar.downbut:GetScript("OnMouseDown")
		self.FUI.scrollbar.downbut:SetScript("OnMouseDown",function(me)
			self.FUI:GetScript("OnMouseWheel")(self.FUI,-1)
			oldDownMouseDown(me)
		end)
		--]]

		self.FUI.farmframe = self:MakeFarmingTable()
		self.FUI.gatherframe = self:MakeGatheringTable()
		self.FUI.goldrunframe = self:MakeGoldRunTable()
		self.FUI.auctionframe = self:MakeAuctionTable()
		self.FUI.craftframe = self:MakeCraftingTable()

	-- Footer
		self.FUI.updateTex = CHAIN(self.FUI:CreateTexture(nil,"ARTWORK"))
			:SetPoint("BOTTOMLEFT",5,5)
			:SetTexture(ZGV.DIR.."\\Skins\\Default\\Stealth\\titlebuttons")
			:SetTexCoord(16/32,17/32,2/4,3/4)
			:SetSize(ICON_SIZE,ICON_SIZE)
		.__END
		
		self.FUI.updateTitle = CHAIN(self.FUI:CreateFontString())
			:SetPoint("LEFT",self.FUI.updateTex,"RIGHT",5,0)
			:SetFont(FONTBOLD,COLFOOTER_FONTSIZE)
			:SetText("LAST UPDATED:")	-- Text changed in UpdateTimestamp
		.__END

		self.FUI.timestamp = CHAIN(self.FUI:CreateFontString())
			:SetPoint("LEFT",self.FUI.updateTitle,"RIGHT",5,0)
			:SetFont(FONT,COLFOOTER_FONTSIZE)
			:SetText("no time")
		.__END

		self.FUI.updateTooltip = CHAIN(CreateFrame("FRAME","FUIUpdateTooltip",self.FUI))
			:SetPoint("BOTTOMLEFT",self.FUI,"BOTTOMLEFT",0,0)
			:SetPoint("TOPRIGHT",self.FUI,"BOTTOMRIGHT",-30,ROW_FOOTER)
			:SetScript("OnEnter",function(self)
				GameTooltip:SetOwner(self,"ANCHOR_BOTTOM")
				GameTooltip:SetText("Speak with Auctioneer and run a scan to update.")
				GameTooltip:Show()
				GameTooltip:ClearAllPoints()
				--GameTooltip:SetPoint("TOPLEFT",self:GetParent(),"TOPRIGHT")
			end)
			:SetScript("OnLeave",function(self)
				GameTooltip:Hide()
			end)
		.__END
		
		--[[
		self.FUI.PriceModelButton = CHAIN(ui:Create("Button",self.FUI,self.FUI:GetName().."_ButtonPriceModel"))
			:SetPoint("BOTTOM",self.FUI,"BOTTOM",0,5)
			:SetPerfectSizing(1)
			:SetText("Price: xxx")
			:SetScript("OnClick",function()
				if ZGV.Gold.pricemodel=="example" then
					ZGV.Gold:SetPriceModel("zygor")
					return
				end
				if ZGV.Gold.pricemodel=="zygor" then
					ZGV.Gold:SetPriceModel("auctionator")
					if IsAddOnLoaded("Auctionator") then return end
				end
				if ZGV.Gold.pricemodel=="auctionator" then
					ZGV.Gold:SetPriceModel("auctioneer")
					if IsAddOnLoaded("Auc-Advanced") then return end
				end
				if ZGV.Gold.pricemodel=="auctioneer" then
					ZGV.Gold:SetPriceModel("example")
				end
			end)
			.__END
		
		self.FUI.ExpertModeButton = CHAIN(ui:Create("ToggleButton",self.FUI,self.FUI:GetName().."_ButtonExpertMode"))
			:SetPoint("BOTTOM",self.FUI,"BOTTOM",0,5)
			:SetPerfectSizing(1)
			:SetText("Show Low Demand")
			.__END

		self.FUI.ExpertModeButton:RegisterToggleCallback(function(self)
			ZGVG.lowdemand = self:IsChecked()
			ZGVG:Update()
		end)
		--]]

		self.FUI.settings = CHAIN(CreateFrame("Button",nil,self.FUI))
			:SetPoint("BOTTOMRIGHT",-5,5)
			:SetSize(ICON_SIZE,ICON_SIZE)
			:SetScript("OnClick",function() ZGV:OpenOptions("gold") end)
			.__END
		ZGV.AssignButtonTexture(self.FUI.settings,(SkinData("TitleButtons")),5,32)

	self.FUI.message = CHAIN(CreateFrame("FRAME",self.FUI:GetName().."Message",self.FUI))
		:SetPoint("TOPLEFT",1,-HEADER_HEIGHT)
		:SetPoint("BOTTOMRIGHT",-1,FOOTER_HEIGHT)
	.__END

	self.FUI.message.text = CHAIN(self.FUI.message:CreateFontString())
		:SetPoint("TOPLEFT",self.FUI.message,"TOPLEFT",0,-45)
		:SetPoint("TOPRIGHT",self.FUI.message,"TOPRIGHT",0,-45)
		:SetFont(FONTBOLD,COLFOOTER_FONTSIZE*1.2)
		:SetJustifyV("TOP"):SetJustifyH("CENTER")
	.__END




	self:CreateItemsFrame()
	self:CreateAuctionDetailFrame()
	self:CreateCraftingDetailFrame()
	self:CreateGoldrunDetailFrame()


	self.FUI:RegisterEvent("GET_ITEM_INFO_RECEIVED")
	
	function self.FUI:SetCurrentTab(title)
		for i,tabobj in ipairs(self.Tabs) do
			if tabobj.tabname == title then
				tabobj.caption:SetTextColor(unpack(SkinData("TabSelectedColor")))
				tabobj.texture:SetAlpha(1)
			else
				tabobj.caption:SetTextColor(unpack(SkinData("TabDefaultColor")))
				tabobj.texture:SetAlpha(.4)
			end
		end

		self.goldrunframe:SetShown(title=="goldrun")
		self.farmframe:SetShown(title=="farming")
		self.gatherframe:SetShown(title=="gathering")
		self.auctionframe:SetShown(title=="auctions")
		self.craftframe:SetShown(title=="crafting")
		
		self.tab=title
		self.offset=0
		
		ZGVG:Update()
	end

	function self.FUI:AlignFrame()
		ZGV.db.profile.gold_anchor = {ZGV.Gold.FUI:GetPoint()}
	end

	
	self.FUI.offset=0
	self.FUI:SetCurrentTab("goldrun")

end


function ZGVG.Frame_OnEvent(FUI,event,...)
	--print("FUI event",event)
	if event=="GET_ITEM_INFO_RECEIVED" and FUI:IsShown() then
		FUI.is_dirty=true
	end
end
--[[
	Tooltips for each item
--]]
function ZGVG:CreateItemsFrame()
	self.FItems = CHAIN(ui:Create("Frame",ZGVG.FUI,"ZGGoldItemsFrame"))
		:SetSize(ZGVG.FUI:GetWidth()-16,300)
		:SetFrameStrata("DIALOG")
		:SetFrameLevel(ZGVG.FUI:GetFrameLevel()+1)
		:SetUserPlaced(true)
		:SetClampedToScreen(true)
		:RegisterEvent("GET_ITEM_INFO_RECEIVED")
		:SetScript("OnUpdate",function(self,elapsed)
			--[[
			--TODO throttle this so it isn't updated constantly. Maybe only every few seconds
			if self.is_dirty then
				self.is_dirty=nil
				ZGVG:Update()
			end
			ZGVG:UpdateTimeStamp()
			--]]
		end)
		:SetScript("OnEvent",function(self,event)
			--if event=="GET_ITEM_INFO_RECEIVED" and self:IsShown() then self.is_dirty=true end
		end)			
		:Hide()
		.__END
		--:RegisterEvent("PLAYER_ENTERING_WORLD")

	self.FItems.col_title = CHAIN(self.FItems:CreateFontString())
		:SetPoint("TOPLEFT",self.FItems,"TOPLEFT",10,-10)		:SetSize(200,15)	:SetJustifyV("TOP") :SetJustifyH("LEFT")	:SetFont(FONT,13)
		:SetText("Item")
	.__END

	self.FItems.col_lab1 = CHAIN(self.FItems:CreateFontString())
		:SetPoint("TOPLEFT",self.FItems.col_title,"TOPRIGHT",10,0)	:SetSize(100,15)	:SetJustifyV("TOP") :SetJustifyH("RIGHT")	:SetFont(FONT,13)
		:SetText("Price")
	.__END

	self.FItems.col_lab2 = CHAIN(self.FItems:CreateFontString())
		:SetPoint("TOPLEFT",self.FItems.col_lab1,"TOPRIGHT",10,0)	:SetSize(50,15)		:SetJustifyV("TOP") :SetJustifyH("RIGHT")	:SetFont(FONT,13)
		:SetText("Drops")
	.__END

	self.FItems.col_lab3 = CHAIN(self.FItems:CreateFontString())
		:SetPoint("TOPLEFT",self.FItems.col_lab2,"TOPRIGHT",10,0)	:SetSize(100,15)	:SetJustifyV("TOP") :SetJustifyH("RIGHT")	:SetFont(FONT,13)
		:SetText("Profit")
	.__END

	self.FItems.col_lab4 = CHAIN(self.FItems:CreateFontString())
		:SetPoint("TOPLEFT",self.FItems.col_lab3,"TOPRIGHT",10,0)	:SetSize(60,15)		:SetJustifyV("TOP") :SetJustifyH("RIGHT")	:SetFont(FONT,13)
		:SetText("Demand")
	.__END

	self.FItems.col_lab5 = CHAIN(self.FItems:CreateFontString())
		:SetPoint("TOPLEFT",self.FItems.col_lab4,"TOPRIGHT",10,0)	:SetSize(200,15)	:SetJustifyV("TOP") :SetJustifyH("LEFT")	:SetFont(FONT,13)
		:SetText("Status")
	.__END


	self.FItems.rows = {}

	for n=1,ITEMROWCOUNT do
		local row = CHAIN(CreateFrame("FRAME","ZGGoldItemFrameRow"..n,self.FItems,nil,"HIGH"))
			:SetSize(self.FItems:GetWidth()-20,13)
			.__END
			--:RegisterEvent("PLAYER_ENTERING_WORLD")

		self.FItems.rows[n] = row
		
		if n==1 then
			row:SetPoint("TOPLEFT",self.FItems,"TOPLEFT",10,-30)
		else
			row:SetPoint("TOPLEFT",self.FItems.rows[n-1],"BOTTOMLEFT",0,0)
		end

		-- item name
		row.title = CHAIN(row:CreateFontString())
			:SetPoint("TOPLEFT",row,"TOPLEFT",0,0) :SetSize(self.FItems.col_title:GetWidth(),13)		:SetJustifyV("TOP") :SetJustifyH("LEFT")	:SetFont(FONT,11)
			:SetText("text")
		.__END

		-- money
		row.lab1 = CHAIN(row:CreateFontString())
			:SetPoint("TOPLEFT",row.title,"TOPRIGHT",10,0) :SetSize(self.FItems.col_lab1:GetWidth(),13)	:SetJustifyV("TOP") :SetJustifyH("RIGHT")	:SetFont(FONT,11)
			:SetText("text")
		.__END

		-- drops
		row.lab2 = CHAIN(row:CreateFontString())
			:SetPoint("TOPLEFT",row.lab1,"TOPRIGHT",10,0) :SetSize(self.FItems.col_lab2:GetWidth(),13)	:SetJustifyV("TOP") :SetJustifyH("RIGHT")	:SetFont(FONT,11)
			:SetText("text")
		.__END

		-- profit
		row.lab3 = CHAIN(row:CreateFontString())
			:SetPoint("TOPLEFT",row.lab2,"TOPRIGHT",10,0) :SetSize(self.FItems.col_lab3:GetWidth(),13)	:SetJustifyV("TOP") :SetJustifyH("RIGHT")	:SetFont(FONT,11)
			:SetText("text")
		.__END

		-- demand
		row.lab4 = CHAIN(row:CreateFontString())
			:SetPoint("TOPLEFT",row.lab3,"TOPRIGHT",10,0) :SetSize(self.FItems.col_lab4:GetWidth(),13)	:SetJustifyV("TOP") :SetJustifyH("RIGHT")	:SetFont(FONT,11)
			:SetText("text")
		.__END

		-- status
		row.lab5 = CHAIN(row:CreateFontString())
			:SetPoint("TOPLEFT",row.lab4,"TOPRIGHT",10,0) :SetSize(self.FItems.col_lab5:GetWidth(),13)	:SetJustifyV("TOP") :SetJustifyH("RIGHT")	:SetFont(FONT,11)
			:SetText("text")
		.__END

		--[[
		row.labelbottom = CHAIN(row:CreateFontString())
			:SetPoint("TOPLEFT",row.title,"BOTTOMLEFT",0,-2)
			:SetJustifyV("TOP") :SetJustifyH("LEFT")
			:SetFont(FONT,11)
			:SetText("text")
		.__END
		--]]

		--[[
		row.details = CHAIN(CreateFrame("FRAME","ZGGoldMainFrameRow"..n.."Details",row))
		:SetSize(20,20)
		:SetBackdrop(SkinData("Backdrop"))
		--:SetBackdropColor(unpack(SkinData("MoneyBackdropColor")))
		--:SetBackdropBorderColor(unpack(SkinData("MoneyBackdropBorderColor")))
		:SetScript("OnEnter",function(self) if not row.detailtext then return end GameTooltip:SetOwner(row,"ANCHOR_RIGHT") local s=row.detailtext  if type(s)=="function" then s=s(row.chore) end  GameTooltip:SetText(s)  GameTooltip:Show() row.back:Show() end)
		:SetScript("OnLeave",function(self) GameTooltip:Hide() row.back:Hide() end)
		--:SetScript("OnUpdate",Scan.UIFrameOnUpdate)
		--:SetScript("OnShow",Scan.UIFrameOnShow)
		:SetPoint("TOPRIGHT",row,"TOPRIGHT",0,0)
		.__END
		--:RegisterEvent("PLAYER_ENTERING_WORLD")
		--]]

		--row.hilite = CHAIN(row:CreateTexture(row:GetName().."Back","HIGHLIGHT")) :SetAllPoints() :SetTexture(1,1,1,0.15) .__END
		--row.back = CHAIN(row:CreateTexture(row:GetName().."Back","ARTWORK")) :SetAllPoints() :SetTexture(1,1,1,1) .__END

	end

	self.FItems.hr = CHAIN(self.FItems:CreateTexture(self.FItems:GetName().."Hr","OVERLAY")) :SetPoint("LEFT",self.FItems,"LEFT") :SetPoint("RIGHT",self.FItems,"RIGHT") :SetSize(1,1) :SetTexture(1,1,1,0.4) .__END

	function self.FItems:SetRow(n,title,lab1,lab2,lab3,lab4,lab5)
		local row = self.rows[n]
		row.title:SetText(title)
		row.lab1:SetText(lab1)
		row.lab2:SetText(lab2)
		row.lab3:SetText(lab3)
		row.lab4:SetText(lab4)
		row.lab5:SetText(lab5)
		row:Show()
	end

	function self.FItems:ShowItemsForChore(chore,parentframe)
		ZGV.Gold.FGoldrun:Hide()

		self.chore = chore

		self:SetParent(parentframe)
		self:SetFrameLevel(parentframe:GetFrameLevel()+5)

		local price_desc = " /ea"
		local drops_desc = " /hr"

		local h = floor(chore.scale)
		local m = (chore.scale-h)*60
		m=m-m%5 --trunc to 10
		if h>2 then m=nil end
		local hm = (h>0 and h.."h" or "") .. (h>0 and m and " " or "") .. (m and (m .. "m") or "")

		local rown=1

		for ii,item in ipairs(chore.good_items) do
			local itemname,itemlink = GetItemInfo(item.itemdata[1])

			local demand
			-- DEMAND TIERS
			if item.itemdata.scale>=TIER_DEMAND_HIGH then
				demand=COLOR_DEMANDGREAT ..math.floor(item.itemdata.demand).."|r"
			elseif item.itemdata.scale>=TIER_DEMAND_MEDIUM then
				demand=COLOR_DEMANDGOOD ..math.floor(item.itemdata.demand).."|r"
			else
				demand=COLOR_DEMANDLOW ..math.floor(item.itemdata.demand).."|r"
			end
			
			local comment
			if item.itemdata.gouged then
				comment="Gouged; price raised."
			elseif item.itemdata.empty then
				comment="Market empty; price raised."
			else
				comment=""
			end

			local scaled_profit = item.profit * chore.scale

			if not item.itemdata[3] and rown<ITEMROWCOUNT then
				self:SetRow(rown, itemlink, ZGV.GetMoneyString(item.price,GOLD_FORMAT_TYPE)..price_desc, item.count..drops_desc, ZGV.GetMoneyString(scaled_profit,GOLD_FORMAT_TYPE), demand, comment)
			end

			rown=rown+1
		end
		if chore.good_items and #chore.good_items>0 and #chore.bad_items>0 then 
			self.hr:Show() 
			self.hr:SetPoint("BOTTOM",self.rows[rown-1],"BOTTOM",0,0)
		else 
			self.hr:Hide()
		end
		if chore.bad_items then
			for ii,item in ipairs(chore.bad_items) do
				local row=self.rows[rown]
				local itemname,itemlink = GetItemInfo(item.itemdata[1])
				local comment=""
				if item.itemdata[3] then --crap
					comment="Vendor."
				elseif item.no_trend then
					comment="Not useful."
				elseif not item.stable then
					comment="Market unstable, vendor."
				else
					comment=""
				end
				if not item.itemdata[3] and rown<ITEMROWCOUNT then
					local scaled_profit = (item.profit or 0) * chore.scale
					self:SetRow(rown, itemlink, ZGV.GetMoneyString(item.price or 0 , GOLD_FORMAT_TYPE)..price_desc, item.count..drops_desc, ZGV.GetMoneyString(scaled_profit,GOLD_FORMAT_TYPE), demand, comment)
					rown=rown+1
				end
			end
		end

		--[[
		if chore.scale<1 then
			self:SetRow(rown, "Row")
			rown=rown+1
		end
		--]]

		if self.crap_rate then
			self:SetRow(rown, "LOW SKILL. CRAP RATES.")
			rown=rown+1
		end

		for n=rown,ITEMROWCOUNT do
			local row=self.rows[n]
			row:Hide()
		end

		local totalheight=0
		for n=1,ITEMROWCOUNT do
			if self.rows[n]:IsShown() then
				self.rows[n]:Show()
				totalheight = totalheight + self.rows[n]:GetHeight()
			end
		end
		self:SetHeight(20+totalheight+self.col_title:GetHeight())
		
		self:ClearAllPoints()
		self:SetPoint("TOPLEFT",parentframe,"BOTTOMLEFT")

		self:Show()
	end
end

function ZGVG:CreateAuctionDetailFrame()
	self.FAuctionDetail = CHAIN(ui:Create("Frame",ZGVG.FUI,"ZGAuctionDetailFrame"))
		:SetSize(920,300)
		:SetFrameStrata("DIALOG")
		:SetFrameLevel(ZGVG.FUI:GetFrameLevel()+1)
		:SetClampedToScreen(true)
		:Hide()
		.__END

	self.FAuctionDetail.Comments = CHAIN(ui:Create("Frame",ZGVG.FAuctionDetail,"ZGAuctionDetailFrameComments"))
		:SetSize(920,30)
		:SetFrameStrata("DIALOG")
		:SetFrameLevel(ZGVG.FUI:GetFrameLevel()+1)
		:SetPoint("TOPLEFT",self.FAuctionDetail,"TOPLEFT",0,0)
		.__END

	self.FAuctionDetail.Comments.Description = CHAIN(self.FAuctionDetail.Comments:CreateFontString())
		:SetSize(920,15)
		:SetJustifyV("TOP")
		:SetJustifyH("LEFT")
		:SetFont(FONT,11)
		:SetText("...")
		:SetPoint("TOPLEFT",self.FAuctionDetail.Comments,"TOPLEFT",5,-5)
		.__END

	for k,col in ipairs(AUCTIONDETAIL_COLUMNS) do
		local widget = CHAIN(self.FAuctionDetail:CreateFontString())
		:SetSize(col.width,15)
		:SetJustifyV("TOP")
		:SetJustifyH(col.titlej)
		:SetFont(FONT,13)
		:SetText(col.title)
		.__END
		if not prev then 
			widget:SetPoint("TOPLEFT",self.FAuctionDetail.Comments,"BOTTOMLEFT",0,-10)
		else 
			widget:SetPoint("TOPLEFT",prev,"TOPRIGHT",10,0) 
		end
		self.FAuctionDetail["col_"..col.name] = widget
		prev=widget
	end


	self.FAuctionDetail.rows = {}

	for n=1,ITEMROWCOUNT do
		local row = CHAIN(CreateFrame("FRAME","ZGAuctionDetailFrameRow"..n,self.FAuctionDetail,nil,"HIGH"))
			:SetSize(self.FAuctionDetail:GetWidth()-20,13)
			.__END
			--:RegisterEvent("PLAYER_ENTERING_WORLD")

		self.FAuctionDetail.rows[n] = row
		
		if n==1 then
			
			--row:SetPoint("TOPLEFT",self.FAuctionDetail,"TOPLEFT",10,-30)
			row:SetPoint("TOPLEFT",self.FAuctionDetail["col_"..AUCTIONDETAIL_COLUMNS[1].name],"BOTTOMLEFT",10,0)
		else
			row:SetPoint("TOPLEFT",self.FAuctionDetail.rows[n-1],"BOTTOMLEFT",0,0)
		end


		local prev
		for k,col in ipairs(AUCTIONDETAIL_COLUMNS) do
			local widget = CHAIN(row:CreateFontString())
			:SetSize(col.width,13)	:SetJustifyV("TOP") :SetJustifyH(col.textj)	:SetFont(FONT,11)
			:SetText(col.title)
			.__END
			if not prev then widget:SetPoint("TOPLEFT",row,"TOPLEFT",0,0)
			else widget:SetPoint("TOPLEFT",prev,"TOPRIGHT",10,0) end
			row[col.name] = widget
			prev=widget
		end

		--[[
		row.labelbottom = CHAIN(row:CreateFontString())
			:SetPoint("TOPLEFT",row.title,"BOTTOMLEFT",0,-2)
			:SetJustifyV("TOP") :SetJustifyH("LEFT")
			:SetFont(FONT,11)
			:SetText("text")
		.__END
		--]]

		--[[
		row.details = CHAIN(CreateFrame("FRAME","ZGGoldMainFrameRow"..n.."Details",row))
		:SetSize(20,20)
		:SetBackdrop(SkinData("Backdrop"))
		--:SetBackdropColor(unpack(SkinData("MoneyBackdropColor")))
		--:SetBackdropBorderColor(unpack(SkinData("MoneyBackdropBorderColor")))
		:SetScript("OnEnter",function(self) if not row.detailtext then return end GameTooltip:SetOwner(row,"ANCHOR_RIGHT") local s=row.detailtext  if type(s)=="function" then s=s(row.chore) end  GameTooltip:SetText(s)  GameTooltip:Show() row.back:Show() end)
		:SetScript("OnLeave",function(self) GameTooltip:Hide() row.back:Hide() end)
		--:SetScript("OnUpdate",Scan.UIFrameOnUpdate)
		--:SetScript("OnShow",Scan.UIFrameOnShow)
		:SetPoint("TOPRIGHT",row,"TOPRIGHT",0,0)
		.__END
		--:RegisterEvent("PLAYER_ENTERING_WORLD")
		--]]

		--row.hilite = CHAIN(row:CreateTexture(row:GetName().."Back","HIGHLIGHT")) :SetAllPoints() :SetTexture(1,1,1,0.15) .__END
		--row.back = CHAIN(row:CreateTexture(row:GetName().."Back","ARTWORK")) :SetAllPoints() :SetTexture(1,1,1,1) .__END
	end

	--self.FItems.hr = CHAIN(self.FItems:CreateTexture(self.FItems:GetName().."Hr","OVERLAY")) :SetPoint("LEFT",self.FItems,"LEFT") :SetPoint("RIGHT",self.FItems,"RIGHT") :SetSize(0,1) :SetTexture(1,1,1,0.4) .__END

	function self.FAuctionDetail:SetRow(n,cnt,title,lab1,lab2,lab3,lab4,lab5,lab6,lab7)
		local row = self.rows[n]
		row[AUCTIONDETAIL_COLUMNS[1].name]:SetText(cnt)
		row[AUCTIONDETAIL_COLUMNS[2].name]:SetText(title)
		row[AUCTIONDETAIL_COLUMNS[3].name]:SetText(lab1)
		row[AUCTIONDETAIL_COLUMNS[4].name]:SetText(lab2)
		row[AUCTIONDETAIL_COLUMNS[5].name]:SetText(lab3)
		row[AUCTIONDETAIL_COLUMNS[6].name]:SetText(lab4)
		row[AUCTIONDETAIL_COLUMNS[7].name]:SetText(lab5)
		row[AUCTIONDETAIL_COLUMNS[8].name]:SetText(lab6)
		row:Show()
	end

	function self.FAuctionDetail:ShowAuction(chore,parentframe)
		--Spoo(nil,nil,self)
		self.chore = chore

		self:SetParent(parentframe)
		self:SetFrameLevel(parentframe:GetFrameLevel()+5)


		local ST=ZGV.Gold.servertrends
		ST=ST and ST.items and ST.items[chore.itemid]
		local AH=ZGV.db.realm.gold_scan_data
		AH=AH and AH[1] and AH[1][chore.itemid]

		local arr={}
		self.chore.GetAuctionChoreData(nil,ST,AH,chore,nil,arr)

		local dobreak = #arr>ITEMROWCOUNT
		local broken

		local M=ZGV.GetMoneyString

		local rown=1
		--Spoo(nil,nil,arr)
		for ai,auc in ipairs(arr) do
			if dobreak and ai>ITEMROWCOUNT/2-1 and ai<#arr-ITEMROWCOUNT/2+3 then
				if not broken then
					self:SetRow(rown, "","...", "...","...","...","...","...","...","...")
					rown=rown+1
					broken=true
				else
					-- don't show anything, move on!
				end
			else
			--[[
			auc.cost
			auc.count
			auc.price
			auc.profit
			auc.sale
			auc.targetprice
	
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
			--]]
			
			if auc.price<=chore.price then --and not auc.blockade then
				self:SetRow(rown,
					auc.count, "|cff"..auc.color..auc.name,
					M(chore.targetprice,GOLD_FORMAT_TYPE),
					M(auc.price,GOLD_FORMAT_TYPE),
					M(auc.totalcost,GOLD_FORMAT_TYPE),
					M(auc.sale_v1,GOLD_FORMAT_TYPE),
					M(auc.sale_v1*0.05,GOLD_FORMAT_TYPE),
					M(auc.profit_v1,GOLD_FORMAT_TYPE)
					)
					rown=rown+1
				end
			end
			if rown>ITEMROWCOUNT then ZGV:Debug("&gold FAuctionDetail:ShowAuction - Too many rows, even with breaking!") break end
		end

		--[[
		if rown<=ITEMROWCOUNT-1 then
			local M=ZGV.GetMoneyString
			self:SetRow(rown, "")
			rown=rown+1
			self:SetRow(rown, "","       Total:","","",M(self.chore.cost),M(self.chore.profit+self.chore.cost),M(self.chore.profit))
			rown=rown+1
		end
		--]]

		for n=rown,ITEMROWCOUNT do
			local row=self.rows[n]
			row:Hide()
		end

		local flags_good,flags_bad = {}, {}
		local flags_string_good,flags_string_bad = "",""

		for i,v in pairs(chore.flags) do
			local flag = ZGV.Gold.Auctions.Flags[string.upper(v)]
			if flag.type=="Red" then
				table.insert(flags_bad,flag.name)
			else
				table.insert(flags_good,flag.name)
			end
		end

		flags_string_good = table.concat(flags_good,",")
		flags_string_bad = table.concat(flags_bad,",")

		local commentheight = 1

		local statusid = math.min(chore.itemstatus,10)

		local flags_description = "Status: "..AuctionsDisplayStatus[statusid][1]..AuctionsDisplayStatus[statusid][2]

		if flags_string_good~="" or flags_string_bad~="" then
			flags_description = flags_description.. "  |r( "
		end

		if flags_string_good~="" then
			flags_description = flags_description.. " |cff00ff00PROS: "..flags_string_good
		end

		if flags_string_bad~="" then
			flags_description = flags_description.. " |cffff0000CONS: "..flags_string_bad
		end

		if flags_string_good~="" or flags_string_bad~="" then
			flags_description = flags_description.. " |r)"
		end

		self.Comments.Description:SetText(flags_description)
		commentheight = self.Comments.Description:GetStringHeight() + 10

		self.Comments:SetHeight(commentheight)

		local totalheight=0
		for n=1,ITEMROWCOUNT do
			if self.rows[n]:IsShown() then
				totalheight = totalheight + self.rows[n]:GetHeight()
			end
		end
		self:SetHeight(20+totalheight+15+commentheight)

		
		self:ClearAllPoints()
		self:SetPoint("TOPLEFT",parentframe,"BOTTOMLEFT")

		self:Show()
	end
end

function ZGVG:CreateCraftingDetailFrame()
	self.FCraftingDetail = CHAIN(ui:Create("Frame",ZGVG.FUI,"ZGAuctionDetailFrame"))
		:SetSize(ZGVG.FUI:GetWidth()-16,300)
		:SetFrameStrata("DIALOG")
		:SetFrameLevel(ZGVG.FUI:GetFrameLevel()+1)
		--:SetUserPlaced(true)
		:SetClampedToScreen(true)
		--:RegisterEvent("GET_ITEM_INFO_RECEIVED")
			--[[
		:SetScript("OnUpdate",function(self,elapsed)
			--TODO throttle this so it isn't updated constantly. Maybe only every few seconds
			if self.is_dirty then
				self.is_dirty=nil
				ZGVG:Update()
			end
			ZGVG:UpdateTimeStamp()
		end)
		:SetScript("OnEvent",function(self,event)
			--if event=="GET_ITEM_INFO_RECEIVED" and self:IsShown() then self.is_dirty=true end
		end)			
			--]]
		:Hide()
		.__END
		--:RegisterEvent("PLAYER_ENTERING_WORLD")

	local prev
	for k,col in ipairs(CRAFTINGDETAIL_COLUMNS) do
		local widget = CHAIN(self.FCraftingDetail:CreateFontString())
		:SetSize(col.width,15)	:SetJustifyV("TOP") :SetJustifyH(col.titlej)	:SetFont(FONT,13)
		:SetText(col.title)
		.__END
		if not prev then widget:SetPoint("TOPLEFT",self.FCraftingDetail,"TOPLEFT",10,-10)
		else widget:SetPoint("TOPLEFT",prev,"TOPRIGHT",10,0) end
		self.FCraftingDetail["col_"..col.name] = widget
		prev=widget
	end


	self.FCraftingDetail.rows = {}

	for n=1,ITEMROWCOUNT do
		local row = CHAIN(CreateFrame("FRAME","ZGAuctionDetailFrameRow"..n,self.FCraftingDetail,nil,"HIGH"))
			:SetSize(self.FCraftingDetail:GetWidth()-20,13)
			.__END
			--:RegisterEvent("PLAYER_ENTERING_WORLD")

		self.FCraftingDetail.rows[n] = row
		
		--[[ Shooter: Advanced tooltip
		if n==1 then
			row:SetPoint("TOPLEFT",self.FCraftingDetailTooltip,"TOPLEFT",CRAFTINGDETAIL_TOOLTIP_W+10,-30)
		else
			row:SetPoint("TOPLEFT",self.FCraftingDetail.rows[n-1],"BOTTOMLEFT",0,0)
		end
		--]]
		if n==1 then
			row:SetPoint("TOPLEFT",self.FCraftingDetail,"TOPLEFT",10,-30)
		else
			row:SetPoint("TOPLEFT",self.FCraftingDetail.rows[n-1],"BOTTOMLEFT",0,0)
		end


		local prev
		for k,col in ipairs(CRAFTINGDETAIL_COLUMNS) do
			local widget = CHAIN(row:CreateFontString())
			:SetSize(col.width,13)	
			:SetJustifyV("TOP") 
			:SetJustifyH(col.textj)	
			:SetFont(FONT,11)
			:SetText(col.title)
			.__END
			if k == 1 then
				widget = CHAIN(row:CreateTexture()):SetSize(ROW_ITEM_ICON_SIZE-6,ROW_ITEM_ICON_SIZE-6).__END
			end

			if not prev then widget:SetPoint("TOPLEFT",row,"TOPLEFT",0,0)
			else widget:SetPoint("TOPLEFT",prev,"TOPRIGHT",10,0) end
			row[col.name] = widget
			prev=widget
		end
	end

	--self.FItems.hr = CHAIN(self.FItems:CreateTexture(self.FItems:GetName().."Hr","OVERLAY")) :SetPoint("LEFT",self.FItems,"LEFT") :SetPoint("RIGHT",self.FItems,"RIGHT") :SetSize(0,1) :SetTexture(1,1,1,0.4) .__END

	function self.FCraftingDetail:SetRow(n,icon,desc,maxprice,totalprice)
		local row = self.rows[n]
		row[CRAFTINGDETAIL_COLUMNS[1].name]:SetTexture(icon)
		row[CRAFTINGDETAIL_COLUMNS[2].name]:SetText(desc)
		row[CRAFTINGDETAIL_COLUMNS[3].name]:SetText(maxprice)
		row[CRAFTINGDETAIL_COLUMNS[4].name]:SetText(totalprice)
		row:Show()
	end

	--[[ Shooter: Advanced tooltip
	self.FCraftingDetailTooltip = CHAIN(ui:Create("Frame",ZGVG.FCraftingDetail,"FCraftingDetailTooltip"))
		:SetSize(CRAFTINGDETAIL_TOOLTIP_W,CRAFTINGDETAIL_TOOLTIP_H)
		:SetFrameStrata("DIALOG")
		:SetFrameLevel(ZGVG.FCraftingDetail:GetFrameLevel()+1)
		:SetPoint("TOPLEFT",self.FCraftingDetail,"TOPLEFT",0,0)
		.__END

	self.FCraftingDetailTooltip.rows = {}

	for n=1,TOOLTIP_ITEMROWCOUNT do
		local row = CHAIN(CreateFrame("FRAME","ZGAuctionDetailFrameTooltipRow"..n,self.FCraftingDetailTooltip,nil,"HIGH"))
			:SetSize(self.FCraftingDetailTooltip:GetWidth()-20,13)
			.__END
			--:RegisterEvent("PLAYER_ENTERING_WORLD")

		self.FCraftingDetailTooltip.rows[n] = row
		
		if n==1 then
			row:SetPoint("TOPLEFT",self.FCraftingDetailTooltip,"TOPLEFT")
		else
			row:SetPoint("TOPLEFT",self.FCraftingDetailTooltip.rows[n-1],"BOTTOMLEFT",0,0)
		end

		local widget = CHAIN(row:CreateFontString())
		:SetPoint("TOPLEFT",row,"TOPLEFT",10,-10)
		:SetWidth(CRAFTINGDETAIL_TOOLTIP_W-20)	
		--:SetSize(CRAFTINGDETAIL_TOOLTIP_W,13)	
		:SetJustifyV("TOP") 
		:SetJustifyH("LEFT") 
		:SetWordWrap(true)
		:SetFont(FONT,CRAFTINGDETAIL_TOOLTIP_FONT)
		:SetText("Bla")
		.__END
		row["Info"] = widget
		end

	function self.FCraftingDetailTooltip:SetTooltipRow(n,text)
		local row = self.rows[n]
		row["Info"]:SetText(text)
		row:Show()
		return row["Info"]:GetStringHeight()
	end
	--]]

	function self.FCraftingDetail:ShowCraftDetails(chore,parentframe)
		self.chore = chore
		self:SetParent(parentframe)
		self:SetFrameLevel(parentframe:GetFrameLevel()+5)
		--[[ Shooter: Advanced tooltip
		tooltip = ZGVG.FCraftingDetailTooltip
		--]]

		local rown=1
		if chore.expert then
			self:SetRow(rown, nil,"|cffff7777Not all of the needed items are available on AH. You may need to farm some of them.","","")
			rown=rown+1
		end
		if chore.unknown then
			if ZGV.Gold.Crafting.AllRecipesSources[chore.recipe.spell] then
				self:SetRow(rown, nil,"|cffffff77You do not know the recipe to make this item. Guide for it is available.","","")
			else
				self:SetRow(rown, nil,"|cffffff77You do not know the recipe to make this item.","","")
			end
			rown=rown+1
		end
		if not chore.expert and not chore.unknown then
			self:SetRow(rown, nil,"|cff77ff77All of needed items are avaible on AH. You can craft this item now.","","")
			rown=rown+1
		end

		--- Description
		for tindex,tvalues in pairs(chore.items_vendor) do
			--itemtable,itemid,itemname,number,link,totalprice,maxprice
			local totalprice = ZGV.GetMoneyString(tonumber(tvalues["totalprice"]),GOLD_FORMAT_TYPE)
			local maxprice = ZGV.GetMoneyString(tonumber(tvalues["maxprice"]),GOLD_FORMAT_TYPE)
			local comment = ""
			if tvalues["expert"] then
				comment = " |cffff7777*|cffffffff "
			end

			local compname, complink,_,_,_,_,_,_,_,compicon = GetItemInfo(tvalues["id"])
			local text = comment.."Buy "..tvalues["count"].." "..complink
			self:SetRow(rown, compicon ,text,maxprice,totalprice)
			rown=rown+1
		end
		for tindex,tvalues in pairs(chore.items_buy) do
			--itemtable,itemid,itemname,number,link,totalprice,maxprice
			local totalprice = ZGV.GetMoneyString(tonumber(tvalues["totalprice"]),GOLD_FORMAT_TYPE)
			local maxprice = ZGV.GetMoneyString(tonumber(tvalues["maxprice"]),GOLD_FORMAT_TYPE)
			local comment = ""
			if tvalues["expert"] then
				comment = " |cffff7777*|cffffffff "
			end

			local compname, complink,_,_,_,_,_,_,_,compicon = GetItemInfo(tvalues["id"])
			local text = comment.."Buy "..tvalues["count"].." "..(complink or "unknown")
			self:SetRow(rown, compicon ,text,maxprice,totalprice)
			rown=rown+1
		end
		for tindex,tvalues in pairs(chore.items_farm) do
			local comment = ""
			if tvalues["expert"] then
				comment = " |cffff7777*|cffffffff "
			end
			local compname, complink,_,_,_,_,_,_,_,compicon = GetItemInfo(tvalues["id"])
			local text = comment.."Farm "..tvalues["count"].." "..complink
			self:SetRow(rown, compicon ,text,"","")
			rown=rown+1
		end
		for tindex,tvalues in pairs(chore.items_craft) do
			local comment = ""
			if tvalues["expert"] then
				comment = " |cffffff77*|cffffffff "
			end
			local compname, complink,_,_,_,_,_,_,_,compicon = GetItemInfo(tvalues["id"])
			local text = comment.."Craft "..tvalues["count"].." "..complink
			self:SetRow(rown, compicon ,text,"","")
			rown=rown+1
		end

		for n=rown,ITEMROWCOUNT do
			local row=self.rows[n]
			row:Hide()
		end

		local desctotalheight=0
		for n=1,ITEMROWCOUNT do
			if self.rows[n]:IsShown() then
				desctotalheight = desctotalheight + self.rows[n]:GetHeight()
			end
		end

		--[[ Shooter: Advanced tooltip
		local trown=1
		Gratuity:SetHyperlink("item:"..chore.recipe.productid)

		if ZGV.db.profile.gold_crafting_type == 333 then -- enchanting
			Gratuity:SetHyperlink("spell:"..(chore.recipe.productid))
			name = GetSpellInfo(chore.recipe.productid)
			if not name then
				Gratuity:SetHyperlink("item:"..(chore.recipe.productid))
			end
		else
			Gratuity:SetHyperlink("item:"..(chore.recipe.productid))
		end


		local n = Gratuity:NumLines()
		local isbop = false

		for i=1,n do
			local line=Gratuity:GetLine(i)
			if line then
				local tooltipLineHeight = tooltip:SetTooltipRow(trown,line)
				trown=trown+1
				local tooltipRowLineCount = math.floor(tooltipLineHeight/CRAFTINGDETAIL_TOOLTIP_FONT)
				for n=1,tooltipRowLineCount-1 do
					tooltip:SetTooltipRow(trown,"") -- pad wrapped lines
					trown=trown+1
				end
			end
		end

		for n=trown,TOOLTIP_ITEMROWCOUNT do
			local trow=tooltip.rows[n]
			trow:Hide()
		end
		local tooltiptotalheight=0
		for n=1,TOOLTIP_ITEMROWCOUNT do
			if tooltip.rows[n]:IsShown() then
				tooltiptotalheight = tooltiptotalheight + tooltip.rows[n]:GetHeight()
				--tooltiptotalheight = tooltiptotalheight + tooltip.rows[n]["info"]:GetStringHeight()
			end
		end

		totalheight = math.max(tooltiptotalheight,desctotalheight)
		totalheight = math.max(tooltiptotalheight,desctotalheight)

		self:SetHeight(totalheight+35)
		tooltip:SetHeight(totalheight+35)
		--]]

		--- Window height
		totalheight = math.max(35,desctotalheight)

		self:SetHeight(totalheight+35)
		--tooltip:SetHeight(totalheight+35)

		self:ClearAllPoints()
		self:SetPoint("TOPLEFT",parentframe,"BOTTOMLEFT")

		self:Show()
	end
end

function ZGVG:CreateGoldrunDetailFrame()
	self.FGoldrun = CHAIN(ui:Create("Frame",ZGVG.FUI,"ZGGoldItemsFrame"))
		:SetSize(ZGVG.FUI:GetWidth()-16,300)
		:SetFrameStrata("DIALOG")
		:SetFrameLevel(ZGVG.FUI:GetFrameLevel()+1)
		:SetClampedToScreen(true)
		:Hide()
		.__END

	local prev
	for k,col in ipairs(GOLDRUNDETAIL_COLUMNS) do
		local widget = CHAIN(self.FGoldrun:CreateFontString())
		:SetSize(col.width,15)	:SetJustifyV("TOP") :SetJustifyH(col.titlej)	:SetFont(FONT,13)
		:SetText(col.title)
		.__END
		if not prev then widget:SetPoint("TOPLEFT",self.FGoldrun,"TOPLEFT",10,-10)
		else widget:SetPoint("TOPLEFT",prev,"TOPRIGHT",10,0) end
		self.FGoldrun["col_"..col.name] = widget
		prev=widget
	end


	self.FGoldrun.rows = {}

	for n=1,GOLDRUNITEMROWCOUNT do
		local row = CHAIN(CreateFrame("FRAME","ZGGoldrunDetailFrameRow"..n,self.FGoldrun,nil,"HIGH"))
			:SetSize(self.FGoldrun:GetWidth()-20,13)
			.__END

		self.FGoldrun.rows[n] = row
		
		if n==1 then
			row:SetPoint("TOPLEFT",self.FGoldrun,"TOPLEFT",10,-30)
		else
			row:SetPoint("TOPLEFT",self.FGoldrun.rows[n-1],"BOTTOMLEFT",0,0)
		end


		local prev
		for k,col in ipairs(GOLDRUNDETAIL_COLUMNS) do
			local widget = CHAIN(row:CreateFontString())
			:SetSize(col.width,13)	
			:SetJustifyV("TOP") 
			:SetJustifyH(col.textj)	
			:SetFont(FONT,11)
			:SetText(col.title)
			:SetHeight(0)
			:SetWordWrap(true)
			.__END
			if k == 1 then
				widget = CHAIN(row:CreateTexture()):SetSize(ROW_ITEM_ICON_SIZE-6,ROW_ITEM_ICON_SIZE-6).__END
			end

			if not prev then widget:SetPoint("TOPLEFT",row,"TOPLEFT",0,0)
			else widget:SetPoint("TOPLEFT",prev,"TOPRIGHT",10,0) end
			row[col.name] = widget
			prev=widget
		end
	end

	function self.FGoldrun:SetRow(n,desc,price)
		local row = self.rows[n]

		row.desc:SetText(desc)
		row.price:SetText(price)
		row:Show()

		local height = row.desc:GetStringHeight()
		row:SetHeight(height)
	end

	function self.FGoldrun:ShowItemsForChore(chore,parentframe)
		ZGV.Gold.FItems:Hide()

		local FGoldrun = self

		FGoldrun.chore = chore

		FGoldrun:SetParent(parentframe)
		FGoldrun:SetFrameLevel(parentframe:GetFrameLevel()+5)

		local price_desc = " /ea"
		local drops_desc = " /hr"

		local desc1, desc2

		local rown=1

		if chore.typ == "vendor" then
			local items = {}
			local counter = 0
			local types = 0
			FGoldrun["col_desc"]:SetText("ITEM")
			for _,good_item in pairs(chore.good_items) do
				if not items[good_item[1]] then 
					items[good_item[1]] = {count = 0, profit = 0}
					types = types + 1
				end
				items[good_item[1]].count = items[good_item[1]].count + good_item.count
				items[good_item[1]].profit = items[good_item[1]].profit + good_item.profit

				counter = counter + items[good_item[1]].count
			end

			for i,v in pairs(items) do
				if rown<GOLDRUNITEMROWCOUNT then
					FGoldrun:SetRow(rown, v.count .." * "..i, ZGV.GetMoneyString(v.profit,GOLD_FORMAT_TYPE))
					rown = rown +1
				end
			end
		elseif chore.typ == "daily" then
			FGoldrun["col_desc"]:SetText("DESCRIPTION")
			if chore.guide.description then
				desc1 = chore.guide.description
			else
				desc1 = "Daily quest run"
			end
			
			FGoldrun:SetRow(1, desc1, ZGV.GetMoneyString(chore.gold*10000,GOLD_FORMAT_TYPE))
			rown = 2
		end


		for n=rown,GOLDRUNITEMROWCOUNT do
			local row=FGoldrun.rows[n]
			row:Hide()
		end

		local totalheight=0
		for n=1,GOLDRUNITEMROWCOUNT do
			if FGoldrun.rows[n]:IsShown() then
				FGoldrun.rows[n]:Show()
				totalheight = totalheight + FGoldrun.rows[n]:GetHeight()
			end
		end
		FGoldrun:SetHeight(50+totalheight)
		
		FGoldrun:ClearAllPoints()
		FGoldrun:SetPoint("TOPLEFT",parentframe,"BOTTOMLEFT")

		FGoldrun:Show()
	end
end



local function OldColor(timestamp,red,yellow)
	local age=time()-timestamp
	if age>red then
		return "ffff0000"
	elseif age>yellow then
		return "ffffee00"
	else
		return "ffffffff"
	end
end

function ZGVG:UpdateTimeStamp()	-- TODO this should just update self.FUI.timestamp with the correct time. -- Over my dead body. ~sinus
	if not self.FUI then return end
	if not self.lastScanTime then self.lastScanTime = time() end

	if self.pricemodel=="zygor" then
		local timestamptext,updateTitletext,lastScanStr

		if ZGVG.Scan.db.realm.LastScan then
			updateTitletext = "LAST UPDATED:"
			timestamptext = ("|c%s%s|r"):format(OldColor(self.Scan.db.realm.LastScan,3600*2,60*10), ui.GetTimeStamp(self.Scan.db.realm.LastScan))
		else
			updateTitletext = "|cffff0000ALERT:|r"
			timestamptext = L["gold_no_scan_data"]
		end

		if not ZGV.Gold.guides_loaded then
			updateTitletext = "|cffff0000ALERT:|r"
			timestamptext = L["gold_no_goldguide"]
		elseif not (ZGV.Gold.servertrends and ZGV.Gold.servertrends.date) then
			updateTitletext = "|cffff0000ALERT:|r"
			timestamptext = L["gold_no_servertrends"]
		elseif ZGV.Gold.servertrends.date then
			local timeSinceLast = time() -  ZGV.Gold.servertrends.date

			if timeSinceLast > 86400*31 then	-- Data is > 31 days old
				updateTitletext = "|cffff0000ALERT:|r"
				timestamptext = L["gold_old_servertrends"]:format(ui.GetTimeStamp(self.Scan.db.realm.LastScan))
			end
		end

		self.FUI.updateTitle:SetText(updateTitletext)
		self.FUI.timestamp:SetText(timestamptext)
		--[[
			OldColor(ZGV.Gold.servertrends and ZGV.Gold.servertrends.date or 0, 86400*7, 86400*2),
			ZGV.Gold.servertrends and ZGV.Gold.servertrends.date and ui.GetTimeStamp(ZGV.Gold.servertrends.date)
			 or "none")
		--]]
	else
		self.FUI.updateTitle:SetText("|cffff0000ALERT:|r")
		self.FUI.timestamp:SetText(L["gold_no_scan_data"])
	end
end

function ZGVG:Show()
	ZGVG:FillCraftingTable()
	if not ZGV.db.profile.load_gold then ZGV:Debug("&gold Please /zgdev load_gold first.") return end
	if not self.FUI then  ZGVG:CreateFrame()  end

	if ZGV.db.profile.gold_anchor then
		self.FUI:ClearAllPoints()
		ZGV.db.profile.frame_anchor[2]=UIParent
		self.FUI:SetPoint(unpack(ZGV.db.profile.gold_anchor ))
	end
	
	self.FUI:Show()
	ZGVG:Update()
end

function ZGVG:Toggle()
	if not ZGV.db.profile.load_gold then ZGV:Debug("&gold Please /zgdev load_gold first.") return end
	if not self.FUI then  ZGVG:CreateFrame()  end
	if self.FUI:IsShown() then
		self.FUI:Hide()
	else
		ZGVG:FillCraftingTable()
		self.FUI:Show()
	end
	ZGVG:Update()
end


function ZGV:GOLD_SCANNED()
	if ZGVG.FUI and ZGVG.FUI:IsShown() then ZGVG:Update() end
end

function ZGVG:GetNumRowsShown()
	local num = 0
	if ZGVG.FUI.page then
		for i,row in ipairs(ZGVG.FUI.page.rows) do
			if row:IsShown() then
				num = num + 1
			end
		end
	end

	return num
end

local chore_type_good_in_tab={
	all={daily=1,vendor=1,till=1,route=1,craft=1},
	goldrun={daily=1,vendor=1,till=1,xmog=1},
	farming={route=1},
	gathering={route=1},
	crafting={craft=1},
	auctions={}
}

local gatheringprofs={herbalism="Herbalism",mining="Mining",skinning="Skinning",fishing="Fishing",enchanting="Enchanting"}  -- this is retarded :/

function ZGVG:Update()
	if not self.FUI then return end

	local tab = self.FUI.tab or "all"

	local chores = {}

	if tab=="gathering" or tab=="farming" or tab=="goldrun" then

		-- check chores' availability and all
		for ctype,carray in pairs(ZGVG.chores) do
			if chore_type_good_in_tab[tab][ctype] then
				if type(carray)=="table" then
					for ci,chore in ipairs(carray) do
						chore.profitperhour = nil  -- clear cache
						chore.calculated_details = nil  -- clear cache
						--if (chore.typ=="route" and (tab=="farming" or tab=="gathering"))
						--or ((chore.typ=="daily" or chore.typ=="vendor") and tab=="goldrun") then
							chore:CalculateDetails()
						--end
					end
				end
			end
		end

		ZGVG.last_failed_type = {}
		ZGVG.last_failed_req = {}
		ZGVG.last_failed_lowdemand = {}
		ZGVG.last_failed_filter = {}
		ZGVG.last_failed_skill = {}
		ZGVG.last_failed_level = {}

		local function passes_requirements(chore)
			if chore.AreRequirementsMet then
				local met,reason = chore:AreRequirementsMet(ZGVG.any_skill,ZGVG.any_level)
				if not met then
					tinsert(ZGVG.last_failed_req,chore)
					if reason=="level" then tinsert(ZGVG.last_failed_level,chore) end
					if reason=="skill" then tinsert(ZGVG.last_failed_skill,chore) end
					return false
				end  -- skip failed requirements, but make note of them.
			end
			return true
		end
		-- requirement check moved here, so that it can fire AFTER a chore is verified to even fit the current tab.


		for ctype,carray in pairs(ZGVG.chores) do repeat
			
			if not chore_type_good_in_tab[tab][ctype] then break end
			if type(carray)~="table" then break end

			for ci,chore in ipairs(carray) do repeat
				if not chore.calculated_details then break end -- skip! All should be calculated by now.
				
				--[[
				if chore.items then for i,pair in ipairs(chore.items) do
					local itemid,count,crap=unpack(pair)
					local useful=ZGVG.usefulness[itemid]
					if useful and (not chore.useful or (chore.useful<useful)) then
						chore.useful=useful
					end
				end end
				--]]


				if tab=="all" then -- do nothing, no All tab exists for now, anyway

				elseif tab=="goldrun" then
					if (chore.typ~="daily" and chore.typ~="vendor" and chore.typ~="till" and chore.typ~="xmog") then tinsert(ZGVG.last_failed_type,chore) break end
					if (ZGV.db.profile.gold_run_type~="all" and chore.typ~=ZGV.db.profile.gold_run_type) then break end  -- filtered out
					if not passes_requirements(chore) then break end

				elseif tab=="farming" then
					-- unskilled farming
					if chore.typ~="route" or (chore.meta and chore.meta.skillreq) then tinsert(ZGVG.last_failed_type,chore) break end

					if (ZGV.db.profile.gold_farm_itemfilter~="all" and chore.meta.itemtype~=ZGV.db.profile.gold_farm_itemfilter) then tinsert(ZGVG.last_failed_filter,chore) break end
					if not passes_requirements(chore) then break end
					if (not ZGV.db.profile.gold_lowdemand and (#chore.good_items<=0 or (chore.scale and chore.scale<TIER_DEMAND_MEDIUM))) then tinsert(ZGVG.last_failed_lowdemand,chore) break end

				elseif tab=="gathering" then
					-- skilled gathering
					if chore.typ~="route" or not (chore.meta and chore.meta.skillreq) then tinsert(ZGVG.last_failed_type,chore) break end

					if ZGV.db.profile.gold_gather_prof~="all" and not chore.meta.skillreq[ZGV.db.profile.gold_gather_prof] then tinsert(ZGVG.last_failed_filter,chore)  break  end
					if not passes_requirements(chore) then break end
					if (not ZGV.db.profile.gold_lowdemand and (#chore.good_items<=0 or (chore.scale and chore.scale<TIER_DEMAND_MEDIUM))) then tinsert(ZGVG.last_failed_lowdemand,chore)  break  end

				end

				-- ELSE... everything's good!
				tinsert(chores,chore) 

			until true end
		until true end

	elseif tab=="crafting" then -- Shooter: initialise crafting
		for index,chore in pairs(ZGVG.craftchores) do -- DEBUG TRAP
			--[[
			if chore.prof  == 171 then
				tinsert(chores,chore)
			end
			--]]
			if not ZGV.db.profile.gold_crafting_type or ZGV.db.profile.gold_crafting_type == 0 or ZGV.db.profile.gold_crafting_type == chore.prof then
				show = ZGVG.chore_protos.crafting.IsRelevant(chore.recipe,chore.cost,chore.profit,chore.expert,chore.unknown)
				if show then
					tinsert(chores,chore)
				end
			end
			--]]
		end


	elseif tab=="auctions" then

		local UNDERCUT=1 - 0.01
		local AHCUT=1 - 0.05

		local ST=ZGV.Gold.servertrends
		ST=ST and ST.items
		local AH=ZGV.db.realm.gold_scan_data
		AH=AH and AH[1]

		local temp={}

		if ST and AH then
			local total,noST,unhealthy,healthy=0,0,0,0
			for id,aucs in pairs(AH) do
				total=total+1
				if ST[id] and ST[id].health==1 then
					healthy=healthy+1
					-- if the item's server scan is all right...

					local chore = ZGVG.chore_protos.auction.GetAuctionChoreData(id,ST[id],aucs)
					if chore and 
						(chore.itemstatus >= ZGV.db.profile.gold_auction_mode) and -- mode
						(ZGV.db.profile.gold_auction_type == 0 or chore.category == ZGV.db.profile.gold_auction_type)
					then
						tinsert(chores,chore)

						--if not chore.at_target then print(chore.name,chore.profit) end
					end
				elseif not ST[id] then noST=noST+1
				elseif ST[id].health~=1 then unhealthy=unhealthy+1
				end
			end

			if #chores==0 then
				ZGV:Print(("Out of %s auctions, %s healthy, no profitable auctions found at all."):format(total,healthy))
				if unhealthy/total>0.99 then ZGV:Print("Over 99% items were marked as unstable in server scans, that's odd... Please re-check your server scan data.")
				elseif noST/total>0.90 then ZGV:Print("Over 90% items had no server scan data at all! Is your server scan data file empty..?")
				end
			end
		elseif not ST then
			ZGV:Debug("&gold No server trend data available!")
		elseif not AH then
			ZGV:Debug("&gold No auction data available!")
		end

	end

	ZGV:Debug("&gold chores shown: %d",#chores)


	-- now sort.
	if tab=="farming" or tab=="gathering" then -- Shooter: Sorting
		sort(chores,ZGVG.compare_chores_smart)
		--sort(chores,ZGVG.compare_chores_useful)
	elseif tab=="goldrun" then
		sort(chores,ZGVG.compare_chores_goldrun)
	elseif tab=="auctions" then
		sort(chores,ZGVG.compare_chores_auction)
	elseif tab=="crafting" then
		sort(chores,ZGVG.compare_chores_crafting)
	end

	ZGVG.last_chores_shown=chores


	local rownum
	local rowoff=0

	ZGVG.FUI.offset = max(0,min(ZGVG.FUI.offset,#chores-ROWCOUNT))
	rowoff=ZGVG.FUI.offset

	local page = tab=="farming" and self.FUI.farmframe
	or tab=="gathering" and self.FUI.gatherframe
	or tab=="goldrun" and self.FUI.goldrunframe
	or tab=="crafting" and self.FUI.craftframe
	or tab=="auctions" and self.FUI.auctionframe
	if not page then ZGV:Debug("&gold NO PAGE good for tab "..tab) return end

	ZGVG.FUI.page = page

	-- display!
	rownum = 0
	local goodrows=0
	for ci,chore in ipairs(chores) do repeat
		rownum = ci-rowoff
		if rownum<1 or rownum>ROWCOUNT then break end --continue
		local row = page.rows[rownum]

		row.chore = chore

		if chore.typ=="route" then
			chore:CalculateDetails() -- call once to detect any_gouges and any_unstable.

			row.no:SetText(("%d."):format(ci))

			local icon=""
			local iconitem
			if #chore.good_items>0 then iconitem=chore.good_items[1].itemdata[1]
			elseif #chore.bad_items>0 then iconitem=chore.bad_items[1].itemdata[1]
			end
			icon = iconitem and select(10,GetItemInfo(iconitem))
			if icon then
				row.icon:SetTexture(icon)
				--icon="|T"..icon..":0:0|t  " 
			else
				row.icon:SetTexture(1,1,1,1)
				ZGV:Debug("No icon?!!?") 
			end		-- TODO why no icon?  --~~ because GetItemInfo might not have data yet. 2014-01-13 22:01 sinus
			row.title:SetText(chore.display_name)


			--row.labelbottom:SetText(("   (\"|cffffeeaa%s|r\")"):format(chore.name))


			chore.scale = chore.scale or 1

			local isovertime
			if chore.scale>=10 then chore.scale=10 isovertime=true end

			local vendoronly
			if chore.good_items and #chore.good_items==0 then vendoronly=true end

			--local s = ("gain: %s/h, useful: |cffffee00%d|r"):format(GetMoneyString(chore:GetProfitPerHour()),chore.useful)
			local profit = chore:GetSmartProfitPerHour()
			--row.lab1:SetText(("%s"):format(ZGV.GetMoneyString(profit,0,"nocolor")).."/hr")
			
			--local profit_per_minute = profit/60
			row.lab1:SetText(("%s"):format(ZGV.GetMoneyString(profit,GOLD_FORMAT_TYPE)).."/hr")
			
			
			-- if false and chore.useful and chore.useful>0 then s=s..(", useful: |cffffee00%d|r"):format(chore.useful) end

			local h = floor(chore.scale)
			local m = (chore.scale-h)*60
			m=m-m%5 --trunc to 10
			if h>2 then m=nil end
			local hm = (isovertime and "> " or "") .. (h>0 and h.."h" or "") .. (h>0 and m and " " or "") .. (m and (m .. "m") or "")
			if vendoronly then hm="- " end
			--local gold = ZGV.GetMoneyString(profit*chore.scale,0,"nocolor")
			local gold = ZGV.GetMoneyString(profit*chore.scale,GOLD_FORMAT_TYPE)
			local demandstring
			local timestring
			if #chore.good_items==0 then
				demandstring = COLOR_VENDOR .. "None|r"
			elseif (chore.scale<TIER_DEMAND_MEDIUM) then
				demandstring = COLOR_DEMANDLOW .. "Low|r"
				timestring = gold .. " / " .. hm
			elseif chore.scale<=TIER_DEMAND_HIGH then
				demandstring = COLOR_DEMANDGOOD .. "Medium|r"
				timestring = gold .. " / " .. hm
			else
				demandstring = COLOR_DEMANDGREAT .. "High|r"
			end
			row.lab2:SetText(hm)
			--row.lab3:SetText(demandstring.." "..gold)
			row.lab3:SetText(vendoronly and "-" or ((isovertime and "> " or "") .. gold))

			--[[
			if timestring then
				local orgtext = ("%s"):format(ZGV.GetMoneyString(profit,3,"no color"))
				orgtext = string.gsub(orgtext,"|cffffffff","")
				orgtext = string.gsub(orgtext,"|r","")
				newtext = "|cffff0000"..orgtext
				
				row.lab1:SetText(newtext.."/hr")
			end
			--]]

			--[[
			local s=""
			if chore.has_unstable then s=s.." |cffff0000UNSTABLE|r" end
			if chore.has_gouged then s=s.." |cff88ff00GOUGED|r" end
			if chore.has_empty then s=s.." |cff00ff88EMPTY|r" end
			--if any_overscaled then s=s.." |cffff8800LOW DEMAND|r" end
			row.lab3:SetText(s)
			--]]

			--row.backalpha = ci%2==0 and 0.0 or 0.06	

			local chore_guide = row.chore.guide
			local chore_map_name = ""
			if chore_guide and chore_guide.steps and chore_guide.steps[1] then
				local chore_map = chore_guide.steps[1].map
				if chore_map then
					chore_map_name = GetMapNameByID(chore_map)
				end
			end
					

			row.zone:SetText(chore_map_name)



			row:Show()
	
		elseif (chore.typ=="vendor" or chore.typ=="daily" or chore.typ=="till" or chore.typ=="xmog") then

			row.typeIcon:SetTexture(ZGV.DIR.."\\Skins\\goldguideicons")
			BetterTexCoord(row.typeIcon,(chore.typ=="daily" and 6) or (chore.typ=="vendor" and 7) or (chore.typ=="till" and 8) or (chore.typ=="xmog" and 7),8,1,2)

			if chore.meta.icon then
				row.titleIcon:SetTexture(chore.meta.icon)
				BetterTexCoord(row.titleIcon,1,1,1,1)
				row.titleIcon:Show()
			else
				row.titleIcon:Hide()
			end

			row.title:SetText(chore.name)
			
			-- Time
			local time = chore.time
			if type(time)=="table" then
				row.lab1:SetText(("%s-%s min"):format(unpack(chore.time)))
			elseif time<2*60 then
				row.lab1:SetText(time.." min")
			elseif time<23*60 then
				row.lab1:SetText(math.floor(time/60).." hrs")
			elseif time==1440 then
				row.lab1:SetText("1 day")
			else
				row.lab1:SetText(math.floor(time/1440).." days")
			end

			-- money money money monnnney
			--row.lab2:SetText(ZGV.GetMoneyString((chore.gold and chore.gold*10000) or chore:GetProfit() or 0, 0,"nocolor"))
			row.lab2:SetText(ZGV.GetMoneyString((chore.gold and chore.gold*10000) or chore:GetProfit() or 0, GOLD_FORMAT_TYPE))
			
			row:Show()

		elseif chore.typ=="craft" then -- TODO SHOOTER - Display
			local name,icon,linik,quality,vendor,icon,_

			name,link,quality,_,_,_,_,vendor,_,icon = GetItemInfo(chore.recipe.productid)

			local product_id
			local name,link,quality,_,_,_,_,vendor,_,icon = GetItemInfo(chore.recipe.productid)

			if chore.prof == 333 then -- enchanting
				product_id = ZGV.Gold.Crafting.EnchantToScroll[chore.recipe.spell]
				if product_id then
					name,link,quality,_,_,_,_,vendor,_,icon = GetItemInfo(product_id)
				else
					name,_,icon = GetSpellInfo(chore.recipe.productid)
					product_id = chore.recipe.productid
				end
			end
			if not name then
				name,link,quality,_,_,_,_,vendor,_,icon = GetItemInfo(chore.recipe.productid)
				product_id = chore.recipe.productid
			end


			row.icon:SetTexture(icon)

			if quality then
				local _,_,_, hex = GetItemQualityColor(quality);
				name="|c"..hex..name	
			end

			--[[
			local sourcepack = ZGV.Gold.Crafting.AllRecipesSources[chore.recipe.spell]
			if sourcepack then
				for i,v in pairs(sourcepack) do
					name = i.." "..name
				end
			end
			--]]

			row.title:SetText(name)

			local chore_cost = ZGV.GetMoneyString(chore.cost or 0,GOLD_FORMAT_TYPE)
			local chore_profit = ZGV.GetMoneyString(chore.profit or 0,GOLD_FORMAT_TYPE)
			--[[
			if chore.comment.costinfo ~= "" then
				chore_cost = chore.comment.costinfo  .. chore_cost
			end

			if chore.comment.profitinfo  ~= "" then
				chore_profit = chore.comment.profitinfo  .. chore_profit
			end
			]]--

			statustext = ""
			if chore.unknown == true then
				statustext = "|cffffff00● " .. statustext
			end

			if chore.expert == true then
				statustext = "|cffff0000● " .. statustext
			end

			if statustext == "" then statustext = "|cff00ff00● " end

			row.status:SetText(statustext)

			row.lab1:SetText(chore_cost)
			row.lab2:SetText(chore_profit)

			row:Show()
		elseif chore.typ=="auction" then

			local AH = ZGV.db.realm.gold_scan_data[1]
			
			local dat=AH[chore.itemid]
			local price=next(dat)

			local name,link,quality,_,_,_,_,vendor,_,icon = GetItemInfo(chore.itemid)

			if quality then
				local r, g, b, hex = GetItemQualityColor(quality);
				name="|c"..hex..name	
			end

			row.icon:SetTexture(icon)

			local statusid = math.min(chore.itemstatus,10)
			local statustxt = AuctionsDisplayStatus[statusid][1].."●"

			row.status:SetText(statustxt)

			row.title:SetText(name)


			row.amt:SetText(chore.count)
			row.cost:SetText(ZGV.GetMoneyString(chore.cost,GOLD_FORMAT_TYPE))
			row.profit:SetText(ZGV.GetMoneyString(chore.profit,GOLD_FORMAT_TYPE))
			row.gain:SetText(("%d%%"):format(chore.perc))

			row:Show()

		else
		
			row.detailtext = ""
			row.lab1:SetText("")
			row.lab2:SetText("")
			--row.lab3:SetText("")

			row:Hide()
		end

		row.backalpha = rownum%2==0 and 0.0 or 0.06	-- Always want first and last row to be the same color?
		row.back:SetAlpha(row.backalpha)

		if row:IsShown() then goodrows=goodrows+1 end

		if row:IsMouseOver() then  row:GetScript("OnEnter")(row)  end

	until true end
	
	-- Hide stuff then show as needed.
	ZGVG.FUI.message:Hide()
	page.info:Hide()
	if ZGVG.FUI.helpPanel then ZGVG.FUI.helpPanel:Hide() end	-- Only hide if created

	if ZGVG.helppanel then
		if not ZGVG.FUI.helpPanel then ZGVG:CreateHelpContentPanel() end
		ZGVG.FUI.helpPanel:Show()
	elseif ZGV.db.global.gold_info_pages then
		page.info:Show()
	elseif goodrows==0 then
		
		local profstrings = ""  -- will come in handy
		for k,prof in pairs(gatheringprofs) do  local skill=ZGV:GetSkill(prof).level  if skill>0 then profstrings = profstrings .. "\n" .. L["gold_gathering_error_prof"]:format(prof,skill) end end

		local ifeasytext = ""
		
		ZGV:Debug("&gold last_failed_filter %d",#ZGVG.last_failed_filter)
		ZGV:Debug("&gold last_failed_lowdemand %d",#ZGVG.last_failed_lowdemand)
		ZGV:Debug("&gold last_failed_req %d:",#ZGVG.last_failed_req)
		ZGV:Debug("&gold - last_failed_skill %d",#ZGVG.last_failed_skill)
		ZGV:Debug("&gold - last_failed_level %d",#ZGVG.last_failed_level)

		if not ZGV.db.profile.gold_lowdemand and next(ZGVG.last_failed_lowdemand)  then ifeasytext = L['gold_gathering_error_easymode']:format(#ZGVG.last_failed_lowdemand) end

		if tab=="goldrun" then
			if ZGV.db.profile.gold_run_type == "all" then
				ZGVG.FUI.message.text:SetText(L["gold_goldrun_error_all_noresults"])
			else
				local Type = ""  for i,Tt in ipairs(GOLD_RIGHT_DROPDOWN_OPTIONS) do if Tt[2]==ZGV.db.profile.gold_run_type then Type=Tt[1] break end end
				ZGVG.FUI.message.text:SetText(L["gold_goldrun_error_one_noresults"]:format(Type))
			end
		elseif tab=="farming" then
			if ZGV.db.profile.gold_farm_itemfilter == "all" then
				ZGVG.FUI.message.text:SetText(L["gold_farming_error_noresults"] .. ifeasytext)
			else
				local Type = ""  for i,Tt in ipairs(FARM_TYPE_DROPDOWN_OPTIONS) do if Tt[2]==ZGV.db.profile.gold_farm_itemfilter then Type=Tt[1] break end end
				ZGVG.FUI.message.text:SetText(L["gold_farming_error_noitemtype"]:format(Type) .. ifeasytext)
			end
		elseif tab=="gathering" then
			if ZGV.db.profile.gold_gather_prof == "all" then
				if ZGV:GetSkill("Herbalism").level==0 and ZGV:GetSkill("Mining").level==0 and ZGV:GetSkill("Fishing").level==0 then
					-- no gathering professions at all, GTFO
					ZGVG.FUI.message.text:SetText(L["gold_gathering_error_all_noprofessions"])
				else
					ZGVG.FUI.message.text:SetText(L["gold_gathering_error_all_lowskill"]..profstrings .. ifeasytext)
				end
			else
				local Skill=gatheringprofs[ZGV.db.profile.gold_gather_prof]
				local level = ZGV:GetSkill(Skill).level
				if level==0 then
					ZGVG.FUI.message.text:SetText(L["gold_gathering_error_one_noskillin"]:format(Skill)..profstrings)
				elseif next(ZGVG.last_failed_skill) then
					ZGVG.FUI.message.text:SetText(L["gold_gathering_error_one_lowskill"]:format(Skill,level) .. ifeasytext)
				else
					ZGVG.FUI.message.text:SetText(L["gold_gathering_error_one_noresults"]:format(Skill) .. ifeasytext)
				end
			end
		elseif tab=="crafting" then
			if ZGV:GetSkill("Alchemy").level + ZGV:GetSkill("Blacksmithing").level + ZGV:GetSkill("Engineering").level + ZGV:GetSkill("Inscription").level + ZGV:GetSkill("Jewelcrafting").level + ZGV:GetSkill("Tailoring").level + ZGV:GetSkill("Leatherworking").level  == 0 then
				ZGVG.FUI.message.text:SetText(L["gold_crafting_error_noprofessions"])
			elseif not next(ZGV.db.char.RecipesKnown) then
				ZGVG.FUI.message.text:SetText(L["gold_crafting_error_recipesnotcached"])
			elseif not ZGVG.doneloadingcrafting then
				ZGVG.FUI.message.text:SetText(L["gold_crafting_error_stillloading"])
			else
				ZGVG.FUI.message.text:SetText(L["gold_crafting_error_noresults"] .. ifeasytext)
			end
			--if ZGV.db.profile.gold_crafting_type == 0 then  -- "all"
			--if next(ZGV.db.char.RecipesKnown) then
		elseif tab=="auctions" then
			local ST=ZGV.Gold.servertrends
			local AH=ZGV.db.realm.gold_scan_data
			if not ST then
				ZGVG.FUI.message.text:SetText(L["gold_auctions_error_fail"].."\n"..L["gold_no_servertrends"])
			elseif not AH then
				ZGVG.FUI.message.text:SetText(L["gold_auctions_error_fail"].."\n"..L["gold_no_scan_data"])
			elseif not AH then
				ZGVG.FUI.message.text:SetText(L["gold_auctions_error_noresults"])
			end
		end
		ZGVG.FUI.message:Show()
	end

	ZGVG.FUI.scrollbar:TotalValue(#chores)
	ZGVG.FUI.scrollbar:SetValue(rowoff)
	
	for r=rownum+1,ROWCOUNT do page.rows[r]:Hide() end
end




-- 2014-01-13 10:23:13 - usefulness is now changed to represent STACK SIZING. And moved to Appraiser.
