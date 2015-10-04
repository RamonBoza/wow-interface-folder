local ZGV = ZygorGuidesViewer
if not ZGV then return end

local FONT=ZGV.Font
local FONTBOLD=ZGV.FontBold
local L = ZGV.L
local CHAIN = ZGV.ChainCall

local Frame = {}

local ui = ZGV.UI
local SkinData = ui.SkinData

ui:RegisterWidget("GoldFrameBaseWidget",Frame) -- IDK what to name it... FrameWithHeaderAndFooterThatYouCanAddItemsTo seemed too long....

local DEFAULT_FRAME_WIDTH = 395
local DEFAULT_FRAME_HEIGHT = 400
local DEFAULT_ITEM_HEIGHT = 20
local DEFAULT_ITEM_SPACING = 5
local DEFAULT_HEADER_FOOTER_HEIGHT = 25
local DEFAULT_ITEM_WIDTH = 125

--[[
	Frame with a header and footer that can easily have items added to them with toggle buttons.
	Inherits Frame

	Sample Use:
		local frame = CHAIN(ui:Create("IMFrameBase",parent,name))
			:SetAllPoints()
			:CanDrag(true)
		.__END

		-- Add stuff to frame

	Known Issues:

--]]

function Frame:New(parent,name)
	local F = CHAIN(ui:Create("Frame",parent,name))
		:SetSize(DEFAULT_FRAME_WIDTH,DEFAULT_FRAME_HEIGHT)
		:CanDrag(1) -- TODO probably not
	.__END

	F.items = {}
	F.itemIdList = {} -- Quick reference table so we can instantly find itemid - item pairs. Could be optimized to only use 1 table I am sure.. But meh 1 table
	F.shownItems = 0
	F.tabNames = {}
	--local tabLists = {}

	-- Header
	F.title = CHAIN(F:CreateFontString())
		:SetPoint("TOPLEFT",5,-5)
		:SetFont(FONTBOLD,16)
		:SetText("Title")
	.__END

	F.close = CHAIN(CreateFrame("Button",nil,F))
		:SetPoint("TOPRIGHT",-5,-5)
		:SetSize(15,15)
		:SetScript("OnClick",function() F:Hide() end)
	.__END
	ZGV.AssignButtonTexture(F.close,(SkinData("TitleButtons")),6,32)

	-- Middle
	F.frame = CHAIN(ui:Create("SecFrame",F))
		:SetPoint("TOPLEFT",1,-DEFAULT_HEADER_FOOTER_HEIGHT)
		:SetPoint("BOTTOMRIGHT",-1,DEFAULT_HEADER_FOOTER_HEIGHT)
	.__END

	F.itemsText = CHAIN(F.frame:CreateFontString())
		:SetPoint("TOPLEFT",5,-5)
		:SetFont(FONT,12)
		:SetText("Items Column")
	.__END

	-- For now, we have no second column
	F.secondColText = CHAIN(F.frame:CreateFontString())
		--:SetPoint("LEFT",F.itemsText, DEFAULT_ITEM_HEIGHT + DEFAULT_ITEM_WIDTH + 10,0)
		:SetPoint("TOPRIGHT",-110,-5)
		:SetFont(FONT,12)
		:SetText("")
	.__END
		
	F.togButColText = CHAIN(F.frame:CreateFontString())
		--:SetPoint("TOPRIGHT",-15,-5) -- Based on the scroll frame.
		:SetFont(FONT,12)
		:SetText("But")
	.__END

	-- Status column in appraiser
	F.iconColText = CHAIN(F.frame:CreateFontString())
		--:SetPoint("TOPRIGHT",-66,-5) -- Based on the scroll frame.
		:SetPoint("RIGHT",F.togButColText,"LEFT")
		:SetPoint("LEFT",F.secondColText,"RIGHT")
		:SetJustifyH("CENTER")
		:SetFont(FONT,12)
		:SetText("")
	.__END

	F.toggleCol = CHAIN(ui:Create("ToggleButton",F.frame))
		:SetPoint("BOTTOMRIGHT",-150,9.5)
		:SetText("Select All") -- no text
	.__END
	
	F.toggleCol:RegisterToggleCallback(function()
		--error("checkstack")
		-- Select / Deselect all
		if F.toggleCol:IsChecked() then
			for i,item in ipairs(F.items) do
				-- Second argument: Don't recurse callbacks
				item.toggle:SetToggle(true, true)
			end
		else
			for i,item in ipairs(F.items) do
				-- Second argument: Don't recurse callbacks
				item.toggle:SetToggle(false, true)
			end
		end
	end)

	F.mainBut = CHAIN(ui:Create("Button",F.frame))
		:SetSize(75,20)
		:SetPoint("BOTTOMRIGHT",-5,5)
		:SetFont(FONT,12)
		:SetText("Main But")
		:RegisterForClicks("AnyUp")
	.__END

	F.scrollframe = CHAIN(ui:Create("ScrollItems",F.frame,name.."_Scrollie"))
		:SetPoint("TOPLEFT",F.itemsText,"BOTTOMLEFT",0,-DEFAULT_ITEM_SPACING)
		:MySetPoint("RIGHT",F.frame,"RIGHT",0,0)
		:SetPoint("BOTTOM",F.mainBut,"TOP",0,DEFAULT_ITEM_SPACING)
		:SetItemYOffset(-2)
		:AddButtons()
		:SetHideWhenUnless(1)
	.__END

	F.togButColText:SetPoint("BOTTOMRIGHT",F.scrollframe, "TOPRIGHT", -5 ,5)

	-- Footer

	F.settings = CHAIN(CreateFrame("Button",nil,F))
		:SetPoint("BOTTOMRIGHT",-5,5)
		:SetSize(15,15)
		:SetScript("OnClick",function() ZGV:OpenOptions() end)
	.__END
	ZGV.AssignButtonTexture(F.settings,(SkinData("TitleButtons")),5,32)

	for f,fun in pairs(self) do
		F[f]=fun
	end

	return F
end

-- Enable collapsing/expanding of the frame
-- "parent" is the frame the widget uses when the primary frame is hidden.
function Frame:EnableCollapse(parent, name)
	name = name or self:GetName()
	if not parent then error("No parent!") end
	if not ZGV.db.profile.IsWidgetCollapsed then ZGV.db.profile.IsWidgetCollapsed = {} end
	
	self.myParent = parent
	local oldHide
	
	local oldShow = self.Show
	self.Show = function(self)
		if self.collapseWidget then
			self.collapseWidget:SetPoint("RIGHT",self,"RIGHT",25,5)
		end
		
		oldShow(self)
		if self:IsShown() then
			self.collapseWidget:Show()
		end

		-- Keep the collapsed state when re-shown
		if ZGV.db.profile.IsWidgetCollapsed[name] then
			if not parent then error("No parent!") end
			self.collapseWidget:SetPoint("RIGHT",parent,"RIGHT",25,5)
			self.collapseWidget:SetFrameLevel(self:GetParent():GetFrameLevel()+1)
			if oldHide then oldHide(self) end
			self.collapseWidget:Show()
		end

		--if not self:IsShown() and self.collapseWidget then -- Only show collapse widget if self is shown.
		--	self.collapseWidget:Hide()
		--else
		--	self.collapseWidget:Show()
		--end
	end

	oldHide = self.Hide
	self.Hide = function(self)
		if self.collapseWidget then
			self.collapseWidget:SetPoint("RIGHT",parent,"RIGHT",25,5)
			self.collapseWidget:Hide()
		end
		oldHide(self)
	end
	
	self.collapseWidget = CHAIN(ui:Create("Button",parent, name))
		:SetSize(25,20)
		:SetPoint("RIGHT",self,"RIGHT",25,5)
		:SetFont(FONT,12)
		:SetText("Z")
		:SetScript("OnClick",function()
			if self:IsShown() then
				if not parent then error("No parent!") end
				self.collapseWidget:SetPoint("RIGHT",parent,"RIGHT",25,5)
				self.collapseWidget:SetFrameLevel(self:GetParent():GetFrameLevel()+1)
				ZGV.db.profile.IsWidgetCollapsed[name] = true
				oldHide(self)
			else
				self.collapseWidget:SetPoint("RIGHT",self,"RIGHT",25,5)
				ZGV.db.profile.IsWidgetCollapsed[name] = false
				oldShow(self)
			end
		end)
		:Show() -- TODO: Working on other stuff first
	.__END
	self.close:Hide();
	
	-- Keep the collapsed state on reload
	if ZGV.db.profile.IsWidgetCollapsed[name] then
		if not parent then error("No parent!") end
		self.collapseWidget:SetPoint("RIGHT",parent,"RIGHT",25,5)
		self.collapseWidget:SetFrameLevel(self:GetParent():GetFrameLevel()+1)
		oldHide(self)
	end
end


-- Add a generic frame to be scrolled to the list.
function Frame:AddItemFrame(frame)
	self.scrollframe:AddItem(item.frame, false)
end

function Frame:AddToTopOfItemFrame(frame)
	self.scrollframe:AddItem(item.frame, true)
end

-- Reduces the # of an item - removes it if it gets reduced to 0.
function Frame:ReduceItemCount(itemid, count)
	if not self.itemIdList[itemid] then return end
	
	self.itemIdList[itemid].count = self.itemIdList[itemid].count - count
	name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(itemid)
	self.itemIdList[itemid].descText:SetText(("%s %s"):format(self.itemIdList[itemid].count,name))

	if self.itemIdList[itemid].count <= 0 then
		self:RemoveItem(itemid)
	end

	
end

function Frame:RemoveItem(itemid)
	if itemid == nil then error("itemid cannot be nil") end
	self.itemIdList[itemid]=nil

	for i,item in ipairs(self.items) do
		if item.itemid==itemid then
			item.frame:ClearAllPoints()
			item.frame:Hide()
			self.scrollframe:RemoveItem(item.frame)
		end
	end
	
--	if self.scrollframe.scroller:IsShown() then
--		self.toggleCol:SetPoint("BOTTOMRIGHT",-150,9)
--	else
--		self.toggleCol:SetPoint("BOTTOMRIGHT",-150,9)
--	end

	--self.scrollframe:UpdateList()
	--self.items[itemid].frame:Hide()
end

function Frame:RemoveItems(itemList)
	for _, itemid in pairs(itemList) do
		self:RemoveItem(itemid)
	end
end

-- Reduces count of items, removing them if they get to 0.
-- itemList is a table of tables, with each row containing {itemid, count}
function Frame:ReduceItemsCount(itemList)
	for _, itemTable in pairs(itemList) do
		self:ReduceItemCount(itemTable[1], itemTable[2])
	end
	
	--if self.scrollframe.scroller:IsShown() then
	--	self.toggleCol:SetPoint("TOPRIGHT",-25,-5)
	--else
	--	self.toggleCol:SetPoint("TOPRIGHT",-10,-5)
	--end

end

-- TODO: Add tab name as an actual way to refer to an item in addition to itemid.

-- Add itemid to the appraisers. Attempts to reuse frames if possible. Otherwise creates a new one.
function Frame:AddItem(itemid,count,hideSecCol,iconColText, battlePetID, battlePetName, tab)
	local name ,link, quality ,iLevel,reqLevel,class,subclass,maxStack, equipslot , texture ,vendorPrice

	-- 0	normal item
	-- 1	successful auction
	-- 2	Expired auction
	-- 3	Cancelled auction
	-- 4	successful auction (by text instead of by itemid)
	-- 5	won auction
	-- 6	Buy item
	local itemType = 0
	local itemSoldTextString
	if type(itemid) == "number" or type(itemid) == "string" then
	
		local _, _, itemSoldString = string.find(itemid, "sold:(%d+)")
		_, _, itemSoldTextString = string.find(itemid, "sold:(.+)")
		local _, _, itemExpiredString = string.find(itemid, "expired:(%d+)")
		local _, _, itemCancelledString = string.find(itemid, "cancelled:(%d+)")
		local _, _, itemWonString = string.find(itemid, "won:(%d+)")

		if itemSoldString then
			itemType = 1
			name ,link, quality ,iLevel,reqLevel,class,subclass,maxStack, equipslot , texture ,vendorPrice = GetItemInfo(tonumber(itemSoldString))
			-- Yeah, it's weird, but it works . . .
			itemid = "sold:"..name
		elseif itemSoldTextString then
			name=itemid
			itemType = 4
		elseif itemExpiredString then
			itemType = 2
			name ,link, quality ,iLevel,reqLevel,class,subclass,maxStack, equipslot , texture ,vendorPrice = GetItemInfo(tonumber(itemExpiredString))
		elseif itemCancelledString then
			itemType = 3
			name ,link, quality ,iLevel,reqLevel,class,subclass,maxStack, equipslot , texture ,vendorPrice = GetItemInfo(tonumber(itemCancelledString))
		elseif itemWonString then
			itemType = 5
			name ,link, quality ,iLevel,reqLevel,class,subclass,maxStack, equipslot , texture ,vendorPrice = GetItemInfo(tonumber(itemWonString))
		else
			name ,link, quality ,iLevel,reqLevel,class,subclass,maxStack, equipslot , texture ,vendorPrice = GetItemInfo(itemid)
		end
		
	elseif type(itemid)=="table" then
		name ,link, quality ,iLevel,reqLevel,class,subclass,maxStack, equipslot , texture ,vendorPrice = GetItemInfo(itemid.itemid)
	else
		error("type "..type(itemid).." is invalid.")
	end


	if battlePetName then 
		name = battlePetName
	end
	
	if not iconColText then
		iconColText = ""
	end

	local texCoord

	-- Allow adding already existing items.
	if type(itemid) == "table" then
		local item = itemid
		itemid = itemid.itemid
		if battlePetID then item.battlePetID = battlePetID end
		if not self.itemIdList[itemid] then
			self.itemIdList[itemid] = item
			self.scrollframe:AddItem(item.frame,item.itemid == "money")
		end
		
		--if self.scrollframe.scroller:IsShown() then
		--	self.toggleCol:SetPoint("BOTTOMRIGHT",-150,9)
		--else
		--	self.toggleCol:SetPoint("BOTTOMRIGHT",-150,9)
		--end
		return item
	end

	-- "money" is a special case we have to handle.
	if itemid == "money" then
		name,texture, texCoord = "Money", ZGV.DIR.."\\Skins\\guideicons-big", {0,.25,.25,.5}
	end

	-- TODO handle better maybe? Shouldn't they already have all these items in their bag so maybe not?
	if not name then ZGV:Debug("&gold Info for "..itemid.." not available.") return end

	local item = self.itemIdList[itemid]
	local itemCount = 0

	if item then
		-- This item is already somewhere on our list!! Update it instead of adding a new one.
		if battlePetID then item.battlePetID = battlePetID end

		-- If we passed a count, then lets assume we found another stack / partial stack of the item not in our inventory. So add the values
		if count then
			itemCount = count + item.count
		else
			-- No count passed so assume just look at all the ones in our bags.
			itemCount = GetItemCount(itemid)
		end
		
		item.frame:SetParent(self.frame)
		item.frame:SetFrameStrata("TOOLTIP")
		item.frame:SetFrameLevel(item.frame:GetParent():GetFrameLevel()+999) -- Ensure we are on top.
		item.frame:SetSize(DEFAULT_FRAME_WIDTH,DEFAULT_ITEM_HEIGHT)
		item.frame:Show()
		--item.icon:SetTexture(texture)
		--item.icon:SetPoint("TOPLEFT")
		--item.icon:Show()
		--if texCoord then item.icon:SetTexCoord(unpack(texCoord)) end
		item.toggle:SetToggle(false, true)

		self.itemIdList[itemid] = item
		if self.MyAddItem then self:MyAddItem(item) end
		
		--self.shownItems = itemCount
		item.frame:Show()
		--return item ~~ I forget why this is put here, it messes up item counts . . . ~~Jeremiah 
	else
		-- If no count is given then lets assume we use the number in our bags.
		itemCount = count or GetItemCount(itemid)

		self.shownItems = self.shownItems + 1
		local itemnum = self.shownItems
		item = self.items[itemnum]

		-- If we don't have an old item we can reuse :( Make a new one.
		if not item then
			item = {}
			self.items[itemnum] = item
			local name = "Zygor_Appraiser_Item_"..itemnum

			item.frame = CHAIN(CreateFrame("Frame",name,self.frame))
				:SetSize(DEFAULT_FRAME_WIDTH,DEFAULT_ITEM_HEIGHT)
				:EnableMouse(true)
				:RegisterForDrag("LeftButton")


				:SetScript("OnDragStart",function()
					--Spoo(nil,nil,self.items[itemnum])
					if self.items[itemnum].dragStartCallbacks then
						for _, callback in pairs(self.items[itemnum].dragStartCallbacks) do
							callback(self)
						end
					end
				end)
				:SetScript("OnDragStop",function()
					if self.items[itemnum].dragStopCallbacks then
						for _, callback in pairs(self.items[itemnum].dragStopCallbacks) do
							callback(self)
						end
					end
				end)
				:SetScript("OnMouseUp",function()
					local itemid = self.items[itemnum].itemid
					if self.itemIdList[itemid].onClickCallbacks then
						for _, callback in pairs(self.itemIdList[itemid].onClickCallbacks) do
							callback(self)
						end
					end
				end)
			.__END

			-- Icon for each time.
			item.icon = CHAIN(item.frame:CreateTexture(nil,"ARTWORK"))
				:SetPoint("TOPLEFT")
				:SetSize(DEFAULT_ITEM_HEIGHT,DEFAULT_ITEM_HEIGHT)
			.__END
			
			-- I don't know why or how a print statement fixes bugs.
			-- But in this case, it does - having this print statement
			-- fixes the problem with icons not displaying properly
			-- in the Collector. ~~ Jeremiah
			-- TODO: Find the actual problem and implement a proper fix.
			print("")

			-- count and name go in here
			item.descText = CHAIN(item.frame:CreateFontString())
				:SetPoint("LEFT",item.icon,"RIGHT",5,0)
				:SetWidth(DEFAULT_ITEM_WIDTH)
				:SetJustifyH("LEFT")
				:SetWordWrap(false)
				:SetFont(FONT,12)
			.__END

			item.toggle = CHAIN(ui:Create("ToggleButton",item.frame,name.."_Toggle"))
				:SetPoint("RIGHT",-10,0)
				:SetText("") -- no text
			.__END

			-- Price column
			item.secText = CHAIN(item.frame:CreateFontString())
				:SetPoint("LEFT",item.descText,"RIGHT",5,0)
				:SetWidth(120)		-- Magic number that allows for up to 999999 gold. 
				:SetJustifyH("RIGHT")
				:SetFont(FONT,12)
				:SetText("")
			.__END

			-- Status column in the appraiser
			item.iconText = CHAIN(item.frame:CreateFontString())
				:SetPoint("TOPRIGHT",item.toggle,"TOPLEFT")
				:SetPoint("BOTTOMLEFT",item.secText,"BOTTOMRIGHT")
				:SetFont("Fonts\\ARIALN.TTF",12)
				:SetJustifyH("CENTER")
				:SetText(iconColText)
			.__END
			
			-- Invis column somewhere
			item.iconCol = CHAIN(ui:Create("Frame",item.frame,name.."_InvisCol"))
				:SetBackdropColor(1,1,1,0)
				:SetBackdropBorderColor(1,1,1,0)
				:SetPoint("TOPRIGHT",item.toggle,"TOPLEFT",-5,2)		-- Similar points to the iconText, just a little stouter
				:SetPoint("BOTTOMLEFT",item.secText,"BOTTOMRIGHT",5,-2)
			.__END
			
			
			item.toggle:RegisterToggleCallback(function(self)
				item.toggled = self:IsChecked()
			end)
			
			-- Performs SetScript on all UI elements of the item.
			-- Useful for OnEnter and OnLeave (ie, tooltips)
			function item:SetScript(name, script)
				item.frame:SetScript(name, script)
				item.toggle:SetScript(name, script)
			end

		end

		if battlePetID then
			item.battlePetID = battlePetID
		end


		-- We don't have the icon available; this only happens when no information is in the cache used for GetItemInfo
		if itemType == 4 then
			texture, texCoord = ZGV.DIR.."\\Skins\\guideicons-big", {0,.25,.25,.5}
			item.icon:Show()
		end

		item.itemid = itemid
		item.icon:SetTexture(texture)
		if texCoord then item.icon:SetTexCoord(unpack(texCoord)) end
		item.toggle:SetToggle(false, true)

		self.itemIdList[itemid] = item
		-- if it is money it goes first in the list.
		self.scrollframe:AddItem(item.frame,itemid == "money")
	end

	item.count = itemCount

	if quality then
		local r, g, b, hex = GetItemQualityColor(quality);
		name="|c"..hex..name
		item.name=name
	end

	if itemid ~= "money" then
		-- Normal items
		item.descText:SetText(("%s %s"):format(itemCount,name))
	else
		-- Money
		item.descText:SetText(("%s"):format(name))
	end
	
	item.itemType = itemType
	
	if itemType == 1 then
		item.descText:SetText(("Sold: %s %s"):format(itemCount,name))
	elseif itemType == 2 then
		item.secText:SetText("Expired")
	elseif itemType == 3 then
		item.secText:SetText("Cancelled")
	elseif itemType == 4 then
		item.descText:SetText(("Sold: %s %s"):format(itemCount,itemSoldTextString))
	elseif itemType == 5 then
		item.secText:SetText("Purchased")
	end
	
	--if self.scrollframe.scroller:IsShown() then
	--	self.toggleCol:SetPoint("BOTTOMRIGHT",-150,9)
	--else
	--	self.toggleCol:SetPoint("BOTTOMRIGHT",-150,9)
	--end

	if hideSecCol then item.secText:Hide() else item.secText:Show() end

	-- If we need to do extra work do it here rather than hooking.
	if self.MyAddItem then self:MyAddItem(item) end

	-- Return it incase that is easier to work with.
	return item
end

-- Sets the item count for a particular itemid.
-- count is optional; if nil, then resets the count to default.
-- There is also an alternate count that can be used (Right now, used in Appraiser for having inventory & post count be two different things)
function Frame:SetItemCount(itemid, count, alternateCount)
	if itemid==nil then error("itemid cannot be nil") end
	if self.itemIdList[itemid]==nil then
		-- Item was actually removed, complete the removal rather than setting the number.
		self:RemoveItem(itemid)
		return "item removed"
	end
	
	local totalItemCount = 0
	local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice
	local texture, itemCount, locked, quality, readable
	for bag=0, NUM_BAG_SLOTS do
		for slot=1, GetContainerNumSlots(bag) do
			local currentItemid=GetContainerItemID(bag,slot)
			if currentItemid==itemid then
				name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(itemid)
				texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag, slot);
				totalItemCount = totalItemCount + itemCount
			end
		end
	end
	
	
	if self.itemIdList[itemid].name and type(self.itemIdList[itemid].name)=="string" then name = self.itemIdList[itemid].name end
	
	--Spoo(nil, nil, name)
	
	if name then
		local r, g, b, hex = GetItemQualityColor(quality);
		name="|c"..hex..name

		if not count then
			self.itemIdList[itemid].descText:SetText(("%s %s"):format(totalItemCount,name))
			self.itemIdList[itemid].itemCount = totalItemCount
		else
			--Spoo(nil, nil,self.itemIdList[itemid])
			
			self.itemIdList[itemid].descText:SetText(("%s %s"):format(count,name))
			self.itemIdList[itemid].itemCount = count
			if alternateCount then
				self.itemIdList[itemid].alternateItemCount = alternateCount
			end
		end
	else
		--Spoo(nil, nil, self)
		--Spoo(nil, nil,self.itemIdList[itemid])
		-- Is there another way to get the name?
		if not count then
			self.itemIdList[itemid].descText:SetText(("%s %s"):format(totalItemCount,self.itemIdList[itemid].name))
			self.itemIdList[itemid].itemCount = totalItemCount
		else
			--Spoo(nil, nil,self.itemIdList[itemid])
			
			self.itemIdList[itemid].descText:SetText(("%s %s"):format(count,self.itemIdList[itemid].name))
			self.itemIdList[itemid].itemCount = count
			if alternateCount then
				self.itemIdList[itemid].alternateItemCount = alternateCount
			end
		end

	end
	if not self.itemIdList[itemid].alternateItemCount then self.itemIdList[itemid].alternateItemCount=self.itemIdList[itemid].itemCount end
end

function Frame:UseAlternateItemCount(itemid, value)
	local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(itemid)
	self.itemIdList[itemid].usingAlternateItemCount = value
	self:UpdateText(itemid)
	
	--if value == true and self.itemIdList[itemid].alternateItemCount then
	--	self.itemIdList[itemid].descText:SetText(("%s %s"):format(self.itemIdList[itemid].alternateItemCount,name))
	--elseif value == false and self.itemIdList[itemid].itemCount then
	--	self.itemIdList[itemid].descText:SetText(("%s %s"):format(self.itemIdList[itemid].itemCount,name))
	--end
end

-- Sets what happens when somebody clicks on the orange toggle.
function Frame:SetCallbackOnItem(itemID, myFunction)
	if not itemID then error("Usage: SetCallbackOnItem(itemID, myFunction) (missing itemID)") end
	if not myFunction then error("Usage: SetCallbackOnItem(itemID, myFunction) (missing myFunction)") end
	if not self.itemIdList[itemID] then return end
	--if not self.itemIdList[itemID] then error("Can't find itemid "..itemID.." in itemIdList") end
	
	self.itemIdList[itemID].toggle:RemoveToggleCallbacks(myFunction)
	self.itemIdList[itemID].toggle:RegisterToggleCallback(myFunction)
end

-- Sets what happens when somebody clicks on the item itself, not on the orange toggle.
function Frame:SetClickCallbackOnItem(itemID, myFunction)
	if not itemID then error("Usage: SetCallbackOnItem(itemID, myFunction) (missing itemID)") end
	if not myFunction then error("Usage: SetCallbackOnItem(itemID, myFunction) (missing myFunction)") end

	if not self.itemIdList[itemID] then
		return
		--error("self.itemIdList[itemID] cannot be nil")
	end
	--self.itemIdList[itemID].toggle:RemoveToggleCallbacks(myFunction)
	--self.itemIdList[itemID].toggle:RegisterToggleCallback(myFunction)
	if not self.itemIdList[itemID].onClickCallbacks then
		self.itemIdList[itemID].onClickCallbacks = {}
	end
	tinsert(self.itemIdList[itemID].onClickCallbacks, myFunction)
end


function Frame:addDragStartCallbackToItem(itemid, myFunction)
	if not self.itemIdList[itemid].dragStartCallbacks then
		self.itemIdList[itemid].dragStartCallbacks = {}
	end
	tinsert(self.itemIdList[itemid].dragStartCallbacks, myFunction)
end

function Frame:addDragStopCallbackToItem(itemid, myFunction)
	if not self.itemIdList[itemid].dragStopCallbacks then
		self.itemIdList[itemid].dragStopCallbacks = {}
	end
	tinsert(self.itemIdList[itemid].dragStopCallbacks, myFunction)
end

-- TODO: Finish
function Frame:SortItems(compareFunction)
	
end

-- Updates SecText and DescText
function Frame:UpdateText(itemid)
	local item = self.itemIdList[itemid]
	
	item.descText:SetText(("%s %s"):format(item.itemCount,item.name))
	
	if item.itemType == 1 then
		item.descText:SetText(("Sold: %s %s"):format(itemCount,name))
	elseif item.itemType == 2 then
		item.secText:SetText("Expired")
	elseif item.itemType == 3 then
		item.secText:SetText("Cancelled")
	elseif item.itemType == 4 then
		item.descText:SetText(("Sold: %s %s"):format(itemCount,itemSoldTextString))
	elseif item.itemType == 5 then
		item.secText:SetText("Purchased")
	end
	
	local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(itemid)
	if self.itemIdList[itemid].alternateItemCount and self.itemIdList[itemid].usingAlternateItemCount then
		self.itemIdList[itemid].descText:SetText(("%s %s"):format(self.itemIdList[itemid].alternateItemCount,item.name))
	end

end

-- Price should be in copper
function Frame:UpdateSecText(itemid,text, battlePetID, spoo)
	--if spoo then Spoo(nil, nil, self) end
	if not itemid then error("itemid required") end
	
	if self.itemIdList and self.itemIdList[itemid] then
		self.itemIdList[itemid].secText:SetText(text)
		return
	else
		--if itemid==82280 then print("Should be here 1") end
		for i,item in ipairs(self.items) do
			--if itemid==82280 then print(itemid.." y "..item.itemid) end
			
			if item.itemid == itemid and battlePetID then
				item.secText:SetText(text)
				return
			elseif item.itemid == itemid then
				item.secText:SetText(text)
				return
			end
		end
	end
	--if itemid==82280 then print("Shouldn't be here")
	--Spoo(nil, nil, self.items)
	--end
end

-- The "Icon text" . . .
function Frame:UpdateIconText(itemid,text)
	--print(itemid)
	--Spoo(nil, nil, self.items)
	if not (itemid and (#self.items > 0)) then return end

	for i,item in ipairs(self.items) do
		if item.itemid == itemid then
			item.iconText:SetText(text)
			--break
		end
	end
end

-- Hides all the items so they have to be readded later to be displayed again
function Frame:ClearItems()
	if not (#self.items > 0) then return end

	self.shownItems = 0
	wipe(self.itemIdList)

	for i,item in ipairs(self.items) do
		item.frame:Hide()
	end

	self.scrollframe:ClearList()
	
--	self.toggleCol:SetPoint("BOTTOMRIGHT",-150,9)
end

function Frame:SetTitle(title)
	self.title:SetText(title)
end

function Frame:ItemsColumnTitle(title)
	self.itemsText:SetText(title)
end

function Frame:SecondColumnTitle(title)
	self.secondColText:SetText(title)
end

function Frame:IconColumnTitle(title)
	self.iconColText:SetText(title)
end

function Frame:ButtonColumnTitle(title)
	self.togButColText:SetText(title)
end

function Frame:ItemButtonTooltip(itemid, text)
	assert(type(itemid)=="number")
	assert(self.itemIdList[itemid]~=nil)
--[[
		newItem:SetScript("OnEnter",function()
			GameTooltip:SetOwner( self.frame, "ANCHOR_RIGHT")
			GameTooltip:SetBagItem(bag, slot)
			GameTooltip:Show()
		end)
		newItem:SetScript("OnLeave",function()
			GameTooltip:FadeOut()
		end)
]]--
	self.itemIdList[itemid].toggle:SetScript("OnEnter",function()
		GameTooltip:SetOwner(self.itemIdList[itemid].toggle, "ANCHOR_CURSOR")
		GameTooltip:AddLine(text)
		GameTooltip:Show()
	end)
	self.itemIdList[itemid].toggle:SetScript("OnLeave",function()
		GameTooltip:FadeOut()
	end)
end

function Frame:IconTooltip(itemid, text)
	assert(type(itemid)=="number")
	if not self.itemIdList[itemid] then return end
	
	self.itemIdList[itemid].iconCol:SetScript("OnEnter",function()
		GameTooltip:SetOwner( self.itemIdList[itemid].iconCol, "ANCHOR_CURSOR")
		GameTooltip:AddLine(text)
		GameTooltip:Show()
	end)
	self.itemIdList[itemid].iconCol:SetScript("OnLeave",function()
		GameTooltip:FadeOut()
	end)
end