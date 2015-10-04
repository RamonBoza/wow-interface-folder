local ZGV = ZygorGuidesViewer
if not ZGV then return end

local FONT=ZGV.Font
local FONTBOLD=ZGV.FontBold
local FONTSTATUS="Fonts\\ARIALN.TTF"
local L = ZGV.L
local CHAIN = ZGV.ChainCall
local cachedGetItemInfo = ZGV.cachedGetItemInfo

local DROPDOWN_STYLE=2

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

local APPRAISER_FRAME_SIZE={405,423}
local APPRAISER_FRAME_ROW_WIDTH=400

local HEADER_HEIGHT = 30		-- exported to GoldHelp.lua
local FOOTER_HEIGHT = 25
local ICON_SIZE = 17
local SCROLL_WIDTH=15		-- TODO This does not actual change the width, copied value from ScrollBar.lua. Need to change up scrollbar for it to actually change the width.
local TOGGLE_BUT_SIZE=10	-- TODO This does not actual change the size, 10 is the default size
local ROWCOUNT=14
local ROW_HEADER = 20
local ROW_FOOTER = 30
local COLHEADER_FONTSIZE = 13
local COLFOOTER_FONTSIZE = 12
local ZA_COL_PADDING= 10
local ROW_FONTSIZE=12
local ROW_ICONSIZE=20

local INV_COLUMNSIZES = { 20, 170, 125, 45 }
local BUY_COLUMNSIZES = { 20, 250, 70 }
local ZA_FRAME_ROW_HEIGHT=(APPRAISER_FRAME_SIZE[2] - HEADER_HEIGHT - FOOTER_HEIGHT - ROW_HEADER - ROW_FOOTER) / ROWCOUNT	


local dealIcon = {}

function Appraiser:CreateMainFrame()
	self.MainFrame = CHAIN(ui:Create("Frame",UIParent,"ZygorAppraiser"))
		:SetSize(unpack(APPRAISER_FRAME_SIZE))
		:SetFrameStrata("HIGH")
		:SetScript("OnMouseWheel", function(self,delta)
			ZGV.Gold.Appraiser.MainFrame.offset=ZGV.Gold.Appraiser.MainFrame.offset-delta
			ZGV.Gold.Appraiser.needToUpdate=true
			ZGV.Gold.Appraiser.MainFrame.hideTooltip=true

		end)
		.__END


	MF = self.MainFrame 
	MF:ClearAllPoints()
	MF:SetPoint("TOPLEFT",AuctionFrame,"TOPRIGHT", 0, -13)
	MF:SetPoint("BOTTOMLEFT",AuctionFrame,"BOTTOMRIGHT",0,11)

	-- Header
	MF.Tabs = {}
	MF.MenuInventoryButton = CHAIN(CreateFrame("Button", "ZA_Menu_Inventory", MF)) 
		:SetPoint("TOPLEFT",MF,"TOPLEFT",5,5) 
		:SetSize(80,40)
		:SetScript("OnClick",function(tab) Appraiser:SetCurrentTab("Inventory") end)
	.__END

	MF.MenuInventoryButton.label = CHAIN(MF.MenuInventoryButton:CreateFontString())
		:SetFont(FONT,14) :SetTextColor(unpack(SkinData("TabDefaultColor")))
		:SetText("Inventory")
	 .__END

	MF.MenuInventoryButton:SetFontString(MF.MenuInventoryButton.label)
	MF.Tabs[1] = MF.MenuInventoryButton

	MF.MenuBuyButton = CHAIN(CreateFrame("Button", "ZA_Menu_Buy", MF))
		:SetPoint("LEFT",MF.MenuInventoryButton,"RIGHT",5,0)
		:SetSize(120,40)
		:SetScript("OnClick",function(tab) Appraiser:SetCurrentTab("Buy") end)
	.__END

	MF.MenuBuyButton.label = CHAIN(MF.MenuBuyButton:CreateFontString())
		:SetFont(FONT,14) :SetTextColor(unpack(SkinData("TabDefaultColor")))
		:SetText("Shopping")
	 .__END
	MF.MenuBuyButton:SetFontString(MF.MenuBuyButton.label)
	MF.Tabs[2] = MF.MenuBuyButton

	MF.MenuGoldGuideButton = CHAIN(CreateFrame("Button", "ZA_Menu_GoldGuide" , MF))
		:SetSize(25,25)
		:SetPoint("CENTER", MF, "TOPRIGHT", -14, -12)
		:SetNormalTexture(ZGV.DIR.."\\Skins\\guideicons-big")
		:SetScript("OnClick", function() ZGV.Gold:Show() end)
		:SetScript("OnEnter",function()
			GameTooltip:SetOwner(MF.MenuGoldGuideButton, "ANCHOR_CURSOR")
			GameTooltip:AddLine("Open Gold Guide")
			GameTooltip:Show()
		end)
		:SetScript("OnLeave",function()
			GameTooltip:FadeOut()
		end)
		:Show()
	.__END
	MF.MenuGoldGuideButton:GetNormalTexture():SetTexCoord(0/4,1/4,1/4,2/4)

	-- Footer
	MF.FooterUpdated = CHAIN(MF:CreateFontString())
		:SetPoint("BOTTOMLEFT",5,5)
		:SetFont(FONTBOLD,12)
		:SetText("LAST UPDATED:")
	.__END

	MF.FooterUpdatedTime = CHAIN(MF:CreateFontString())
		:SetPoint("LEFT",MF.FooterUpdated ,"RIGHT",5,0)
		:SetFont(FONT,12)
		:SetText("no time")
	.__END

	MF.FooterSettingsButton = CHAIN(CreateFrame("Button",nil,MF))
		:SetPoint("BOTTOMRIGHT",-5,5)
		:SetSize(15,15)
		:SetScript("OnClick",function() ZGV:OpenOptions() end)
	.__END
	ZGV.AssignButtonTexture(MF.FooterSettingsButton,(SkinData("TitleButtons")),5,32)


	MF.scrollbar = CHAIN(ui:Create("ScrollItems",self.MainFrame,"ZGGoldScroll"))
		:SetPoint("TOPLEFT",self.MainFrame,"TOPRIGHT",-SCROLL_WIDTH-1,-HEADER_HEIGHT - ROW_HEADER)
		:SetPoint("BOTTOMRIGHT",self.MainFrame,"BOTTOMRIGHT",-SCROLL_WIDTH-1,FOOTER_HEIGHT + ROW_FOOTER)
		:MaxValueAtOnce(ROWCOUNT)
		:SetScript("OnVerticalScroll",function(me,offset)
			self.MainFrame.offset=math.round(offset)
			self.needToUpdate=true
		end)
		:SetHideWhenUnless(1)
	.__END

	self.toggleVisibility = CHAIN(ui:Create("Button",UIParent, "ZGA_Toggle"))
		:SetSize(25,20)
		:SetPoint("RIGHT",self.MainFrame,"RIGHT",25,5)
		:SetFont(FONT,12)
		:SetText("Z")
		:SetFrameStrata("HIGH")
		:SetScript("OnClick",function() Appraiser:ToggleVisibility() end)
		:Show()
	.__END

	MF.progressFrame = CHAIN(CreateFrame("Frame","progressFrame",MF))
		:SetBackdrop(SkinData("ProgressBarBackdrop"))
		:SetBackdropColor(unpack(SkinData("ProgressBarBackdropColor")))
		:SetBackdropBorderColor(unpack(SkinData("ProgressBarBackdropBorderColor")))
		:SetSize(MF:GetWidth(),7)
		:SetHeight(SkinData("ProgressBarHeight"))
		:SetFrameStrata("HIGH")
		:SetFrameLevel(3)
		:SetPoint("TOP",MF,"BOTTOM",0,0)
		:Hide()
	.__END
	
	MF.progressFrame.tex = CHAIN(MF.progressFrame:CreateTexture())
		:SetHeight(SkinData("ProgressBarHeight")-2)
		:SetPoint("TOPLEFT",MF.progressFrame,"TOPLEFT",1,-1)
		:SetTexture(unpack(SkinData("ProgressBarTexture")))
		:SetVertexColor(unpack(ZGV.CurrentSkinStyle:SkinData("ProgressBarColor") or {0,1,0,1}))
	.__END 
	
	MF.progressFrame.SetPercent = function(self, percent)
		self.tex:SetWidth((percent / 100)*(self:GetWidth()-2))
	end

	MF.Inventory_Frame = self:MakeInventoryTable()
	MF.Buy_Frame = self:MakeBuyTable()
end

function Appraiser:ToggleVisibility()
	ZGV.db.profile.IsWidgetCollapsed = ZGV.db.profile.IsWidgetCollapsed or {}
	if ZGV.db.profile.IsWidgetCollapsed["Appraiser"] == true then
		ZGV.db.profile.IsWidgetCollapsed["Appraiser"] = false
		self.MainFrame:Show()
		self.toggleVisibility:SetPoint("RIGHT",self.MainFrame,"RIGHT",25,5)
	else 
		ZGV.db.profile.IsWidgetCollapsed["Appraiser"] = true
		self.MainFrame:Hide()
		self.toggleVisibility:SetPoint("RIGHT",AuctionFrame,"RIGHT",25,5)
	end
end

function Appraiser:MakeInventoryTable()	
	local frame = CHAIN(ui:Create("SecFrame",self.MainFrame,"ZA_Inventory_Frame"))
		:SetPoint("TOPLEFT",1,-HEADER_HEIGHT)
		:SetPoint("BOTTOMRIGHT",-1,FOOTER_HEIGHT)
		:CanDrag("parent")
	.__END

	-- Header
	frame.col_icon = CHAIN(frame:CreateFontString())
		:SetPoint("TOPLEFT",frame,"TOPLEFT",0,0)
		:SetSize(INV_COLUMNSIZES[1],ROW_HEADER)
		:SetJustifyV("CENTER")
		:SetJustifyH("LEFT")
		:SetFont(FONT,COLHEADER_FONTSIZE)
		:SetText("")
	.__END

	frame.col_name = CHAIN(frame:CreateFontString())
		:SetPoint("LEFT",frame.col_icon,"RIGHT",ZA_COL_PADDING,0) 
		:SetSize(INV_COLUMNSIZES[2],ROW_HEADER)
		:SetJustifyV("CENTER")
		:SetJustifyH("LEFT")
		:SetFont(FONT,COLHEADER_FONTSIZE)
		:SetText("Items")
	.__END

	frame.col_price = CHAIN(frame:CreateFontString())
		:SetPoint("LEFT",frame.col_name,"RIGHT",ZA_COL_PADDING,0) 
		:SetSize(INV_COLUMNSIZES[3],ROW_HEADER)
		:SetJustifyV("CENTER")
		:SetJustifyH("CENTER")
		:SetFont(FONT,COLHEADER_FONTSIZE)
		:SetText("Price")
	.__END

	frame.col_status = CHAIN(frame:CreateFontString())
		:SetPoint("LEFT",frame.col_price,"RIGHT",ZA_COL_PADDING,0) 
		:SetSize(INV_COLUMNSIZES[4],ROW_HEADER)
		:SetJustifyV("CENTER")
		:SetJustifyH("CENTER")
		:SetFont(FONT,COLHEADER_FONTSIZE)
		:SetText("Status")
	.__END

	-- Middle
	frame.rows={}
	for n=1,ROWCOUNT do
		frame.rows[n] = CHAIN(ui:Create("Button",frame,"ZA_INV_ROW"..n))
			-- Tricky tricky setting width. Set the height then set right point so that if the scrollbar is hidden that it expands the whole frame. If scrollbar is shown, then only expands to the scrollbar.
			:SetSize(APPRAISER_FRAME_ROW_WIDTH,ZA_FRAME_ROW_HEIGHT)
			:SetPoint("RIGHT",self.MainFrame.scrollbar.barframe,"LEFT")
			:SetFrameStrata("HIGH")
			:SetNormalBackdropColor(0,0,0,0)
			:SetBackdropBorderColor(0,0,0,0)
			:CanDrag("parent")
		.__END

		frame.rows[n]:SetScript("OnDragStart",function()
			Appraiser:InventoryDragStart(frame.rows[n])
		end)
		frame.rows[n]:SetScript("OnDragStop",function()
			Appraiser:InventoryDragStop(frame.rows[n])
		end)

		if n==1 then
			frame.rows[n]:SetPoint("TOPLEFT",frame,"TOPLEFT",0,-ROW_HEADER)
		else
			frame.rows[n]:SetPoint("TOPLEFT",frame.rows[n-1],"BOTTOMLEFT",0,0)
		end

		local row = frame.rows[n]

		row.icon = CHAIN(row:CreateTexture())
			:SetPoint("CENTER",row,"LEFT",frame.col_icon:GetWidth()/2+3,0) 
			:SetSize(ROW_ICONSIZE,ROW_ICONSIZE)
		.__END

		row.iconOverlay = CHAIN(ui:Create("Button",row,"ZA_INV_ROW"..n.."OVERLAY"))
			:SetPoint("CENTER",row,"LEFT",20,0) 
			:SetSize(ROW_ICONSIZE,ROW_ICONSIZE)
			:SetFrameLevel(13)
			:SetBackdropColor(0,0,0,0)
			:SetBackdropBorderColor(0,0,0,0)
			:SetScript("OnEnter",function()
				GameTooltip:SetOwner(row.iconOverlay ,"ANCHOR_RIGHT")
				GameTooltip:SetItemByID(row.item.itemid)
				GameTooltip:Show()
			end)
			:SetScript("OnLeave",function()
				GameTooltip:Hide()
			end)
		.__END

		row.name = CHAIN(row:CreateFontString())
			:SetPoint("LEFT",row,"LEFT",frame.col_icon:GetWidth() + ZA_COL_PADDING,0) 
			:SetSize(INV_COLUMNSIZES[2],ROW_FONTSIZE)
			:SetJustifyH("LEFT")
			:SetFont(FONT,ROW_FONTSIZE)
			:SetText("name")
		.__END

		row.price = CHAIN(row:CreateFontString())
			:SetPoint("LEFT",row.name,"RIGHT",ZA_COL_PADDING,0)
			:SetSize(INV_COLUMNSIZES[3],ROW_FONTSIZE)
			:SetJustifyH("RIGHT")
			:SetFont(FONT,ROW_FONTSIZE)
			:SetText("price")
		.__END

		row.status = CHAIN(row:CreateFontString())
			:SetPoint("LEFT",row.price,"RIGHT",ZA_COL_PADDING,0)
			:SetSize(INV_COLUMNSIZES[4],ROW_FONTSIZE)
			:SetJustifyH("CENTER")
			:SetFont(FONTSTATUS,ROW_FONTSIZE)
			:SetText("status")
		.__END

		row.statusContainer = CHAIN(ui:Create("Frame",row,"ZA_INV_ROW"..n.."_CONTAINER"))
			:SetBackdropColor(1,1,1,0)
			:SetBackdropBorderColor(1,1,1,0)
			:SetPoint("LEFT",row.price,"RIGHT",ZA_COL_PADDING,0)
			:SetSize(INV_COLUMNSIZES[4],ROW_FONTSIZE)
			:SetScript("OnEnter",function() Appraiser:ShowStatusTooltip(row) end)
			:SetScript("OnLeave",function() Appraiser:HideStatusTooltip(row) end)
		.__END

		row.hilite = CHAIN(row:CreateTexture(row:GetName().."Back","HIGHLIGHT")) :SetAllPoints() :SetTexture(1,1,0,0) .__END
		row.back = CHAIN(row:CreateTexture(row:GetName().."Back","ARTWORK")) :SetAllPoints() :SetTexture(1,1,1,0) .__END


	end
	
	frame.footer = CHAIN(CreateFrame("FRAME",nil,frame))
		:SetPoint("BOTTOMLEFT",frame,"BOTTOMLEFT",0,0)
		:SetPoint("TOPRIGHT",frame,"BOTTOMRIGHT",0,ROW_FOOTER)
	.__END

	--Footer

	frame.FooterAppraiseButton = CHAIN(ui:Create("Button",frame))
		:SetSize(75,20)
		:SetPoint("BOTTOMLEFT",frame.footer,"BOTTOMLEFT", 5, 5)
		:SetFont(FONT,12)
		:SetText("Appraise")
		:SetScript("OnClick", function() if not self.soft_disabled then Appraiser:StartManualScan() end end)
		:SetScript("OnEnter",function(self) 
			CHAIN(GameTooltip):SetOwner(self, "ANCHOR_BOTTOM") 
			:SetText(type(self.tooltip)=="function" and self:tooltip() or tostring(self.tooltip)) 
			:Show() 
			end)
		:SetScript("OnLeave",function(self) GameTooltip:Hide() end)
	.__END


	frame.FooterScanButton = CHAIN(ui:Create("Button",frame))
		:SetSize(75,20)
		:SetPoint("BOTTOMRIGHT",frame.footer,"BOTTOMRIGHT", -5, 5)
		:SetFont(FONT,12)
		:SetText("Scan")
		:SetScript("OnClick", function() if not self.soft_disabled then Appraiser:Scan() end end)
		:SetScript("OnEnter",function(self) 
			CHAIN(GameTooltip):SetOwner(self, "ANCHOR_BOTTOM") 
			:SetText(type(self.tooltip)=="function" and self:tooltip() or tostring(self.tooltip)) 
			:Show() 
			end)
		:SetScript("OnLeave",function(self) GameTooltip:Hide() end)
	.__END

	self.AHUpdateButton = CHAIN(ui:Create("Button",AuctionFrameAuctions))
		:SetSize(75,17)
		:SetPoint("BOTTOMLEFT",AuctionFrameAuctions,"BOTTOMLEFT", 185, 17)
		:SetFont(FONT,12)
		:SetText("Update")
		:SetScript("OnClick", function() Appraiser:Reappraise() end)
		:SetScript("OnEnter",function(self) 
			CHAIN(GameTooltip):SetOwner(self, "ANCHOR_BOTTOM") 
			:SetText(type(self.tooltip)=="function" and self:tooltip() or tostring(self.tooltip)) 
			:Show() 
			end)
		:SetScript("OnLeave",function(self) GameTooltip:Hide() end)
	.__END

	self.AHUndercutDropDownLabel = CHAIN(AuctionFrameAuctions:CreateFontString())
		:SetPoint("BOTTOMLEFT",self.AHUpdateButton,"BOTTOMRIGHT",10,0)
		:SetFont(FONT,12)
		:SetText("Undercut:")
	.__END

	self.AHUndercutDropDown = CHAIN(ui:Create("DropDown",AuctionFrameAuctions,DROPDOWN_STYLE))
		:SetPoint("BOTTOMLEFT",self.AHUndercutDropDownLabel,"BOTTOMRIGHT",10,0)
		:SetSize(75,17)
		:SetText("Undercut")
		:AddTooltip("ANCHOR_TOPLEFT","Filter what sort of runs are shown.")    -- TODO Change text of the tooltip
	.__END

	local AH_UNDERCUT_OPTIONS = {
		{L['opt_gold_appraiser_undercut_none'],	0	},
		{L['opt_gold_appraiser_undercut_1p'],	1	},
		{L['opt_gold_appraiser_undercut_2p'],	2	},
		{L['opt_gold_appraiser_undercut_5p'],	5	},
		{L['opt_gold_appraiser_undercut_10p'],	10	},
		{L['opt_gold_appraiser_undercut_20p'],	20	},
		{L['opt_gold_appraiser_undercut_1c'],	10001	},
	}

	for optnum,opt in ipairs(AH_UNDERCUT_OPTIONS) do
		local item = self.AHUndercutDropDown:AddItem(opt[1],opt[2],function(item)
			ZGV.Gold.Appraiser:Reappraise()
			ZGV.db.profile.appraiser_undercut = item.userdata.value
			ZGV.Gold.Appraiser.needToUpdate = true
		end)
	end
	self.AHUndercutDropDown:SetCurrentSelectedByValue(ZGV.db.profile.appraiser_undercut or 0)

	--frame:Hide()
	return frame
end

function Appraiser:MakeBuyTable()	
	local frame = CHAIN(ui:Create("SecFrame",self.MainFrame,"ZA_Buy_Frame"))
		:SetPoint("TOPLEFT",1,-HEADER_HEIGHT)
		:SetPoint("BOTTOMRIGHT",-1,FOOTER_HEIGHT)
		:CanDrag("parent")
	.__END

	-- Header
	frame.col_icon = CHAIN(frame:CreateFontString())
		:SetPoint("TOPLEFT",frame,"TOPLEFT",0,0)
		:SetSize(BUY_COLUMNSIZES[1],ROW_HEADER)
		:SetJustifyV("CENTER")
		:SetJustifyH("LEFT")
		:SetFont(FONT,COLHEADER_FONTSIZE)
		:SetText("")
	.__END

	frame.col_name = CHAIN(frame:CreateFontString())
		:SetPoint("LEFT",frame.col_icon,"RIGHT",ZA_COL_PADDING,0) 
		:SetSize(BUY_COLUMNSIZES[2],ROW_HEADER)
		:SetJustifyV("CENTER")
		:SetJustifyH("LEFT")
		:SetFont(FONT,COLHEADER_FONTSIZE)
		:SetText("Items")
	.__END

	frame.col_remove = CHAIN(frame:CreateFontString())
		:SetPoint("LEFT",frame.col_name,"RIGHT",20,0) 
		:SetSize(BUY_COLUMNSIZES[3],ROW_HEADER)
		:SetJustifyV("CENTER")
		:SetJustifyH("RIGHT")
		:SetFont(FONT,COLHEADER_FONTSIZE)
		:SetText("Remove")
	.__END

	-- Middle
	frame.rows={}
	for n=1,ROWCOUNT do
		frame.rows[n] = CHAIN(ui:Create("Button",frame,"ZA_INV_ROW"..n))
			-- Tricky tricky setting width. Set the height then set right point so that if the scrollbar is hidden that it expands the whole frame. If scrollbar is shown, then only expands to the scrollbar.
			:SetSize(APPRAISER_FRAME_ROW_WIDTH,ZA_FRAME_ROW_HEIGHT)
			:SetPoint("RIGHT",self.MainFrame.scrollbar.barframe,"LEFT")
			:SetFrameStrata("HIGH")
			:SetNormalBackdropColor(0,0,0,0)
			:SetBackdropBorderColor(0,0,0,0)
			:CanDrag("parent")
		.__END

		if n==1 then
			frame.rows[n]:SetPoint("TOPLEFT",frame,"TOPLEFT",0,-ROW_HEADER)
		else
			frame.rows[n]:SetPoint("TOPLEFT",frame.rows[n-1],"BOTTOMLEFT",0,0)
		end

		local row = frame.rows[n]
		row:SetScript("OnClick",function() Appraiser:SearchForItem(row.item) end)

		row.icon = CHAIN(row:CreateTexture())
			:SetPoint("CENTER",row,"LEFT",frame.col_icon:GetWidth()/2+3,0) 
			:SetSize(ROW_ICONSIZE,ROW_ICONSIZE)
		.__END

		row.iconOverlay = CHAIN(ui:Create("Button",row,"ZA_INV_ROW"..n.."OVERLAY"))
			:SetPoint("CENTER",row,"LEFT",20,0) 
			:SetSize(ROW_ICONSIZE,ROW_ICONSIZE)
			:SetFrameLevel(13)
			:SetBackdropColor(0,0,0,0)
			:SetBackdropBorderColor(0,0,0,0)
			:SetScript("OnEnter",function()
				GameTooltip:SetOwner(row.iconOverlay ,"ANCHOR_RIGHT")
				GameTooltip:SetItemByID(row.item.id)
				GameTooltip:Show()
			end)
			:SetScript("OnLeave",function()
				GameTooltip:Hide()
			end)
		.__END

		row.name = CHAIN(row:CreateFontString())
			:SetPoint("LEFT",row,"LEFT",frame.col_icon:GetWidth() + ZA_COL_PADDING,0) 
			:SetSize(BUY_COLUMNSIZES[2],ROW_FONTSIZE)
			:SetJustifyH("LEFT")
			:SetFont(FONT,ROW_FONTSIZE)
			:SetText("name")
		.__END

		--[[
		row.toggle = CHAIN(ui:Create("ToggleButton",row))
			:SetPoint("RIGHT",-10,0)
			:SetText("") -- no text
			:SetScript("OnClick",function() Appraiser:RemoveItemFromBuy(row) end)
		.__END
		--]]

		row.delete = CHAIN(row:CreateFontString())
			:SetPoint("RIGHT",-10,0)
			:SetSize(BUY_COLUMNSIZES[3],ROW_FONTSIZE)
			:SetJustifyH("RIGHT")
			:SetFont(FONT,ROW_FONTSIZE)
			:SetText("X")
			:SetTextColor(1,0,0,1)
		.__END

		row.deleteOverlay = CHAIN(ui:Create("Button",row,"ZA_INV_ROW"..n.."DELETE"))
			:SetPoint("RIGHT",-10,0)
			:SetSize(20,ROW_FONTSIZE)
			:SetFrameLevel(13)
			:SetBackdropColor(0,0,0,0)
			:SetBackdropBorderColor(0,0,0,0)
			:SetNormalBackdropColor(0,0,0,0)
			:SetHighlightBackdropColor(0,0,0,0)
			:SetScript("OnClick",function() Appraiser:RemoveItemFromBuy(row) end)
		.__END

		row.hilite = CHAIN(row:CreateTexture(row:GetName().."Back","HIGHLIGHT")) :SetAllPoints() :SetTexture(1,1,0,0) .__END
		row.back = CHAIN(row:CreateTexture(row:GetName().."Back","ARTWORK")) :SetAllPoints() :SetTexture(1,1,1,0) .__END


	end
	
	frame.footer = CHAIN(CreateFrame("FRAME",nil,frame))
		:SetPoint("BOTTOMLEFT",frame,"BOTTOMLEFT",0,0)
		:SetPoint("TOPRIGHT",frame,"BOTTOMRIGHT",0,ROW_FOOTER)
	.__END

	--Footer

	--[[
	frame.FooterScanButton = CHAIN(ui:Create("Button",frame))
		:SetSize(75,20)
		:SetPoint("BOTTOMRIGHT",frame.footer,"BOTTOMRIGHT", -5, 5)
		:SetFont(FONT,12)
		:SetText("Scan")
		:SetScript("OnClick", function() Appraiser:Scan() end)
	.__END
	--]]

	--frame:Hide()
	return frame
end

function Appraiser:ShowStatusTooltip(row)
	GameTooltip:SetOwner( row.statusContainer, "ANCHOR_CURSOR")
	GameTooltip:AddLine( row.item.statusText )
	GameTooltip:Show()
end

function Appraiser:HideStatusTooltip(row)
	GameTooltip:FadeOut()
end

function Appraiser:SetCurrentTab(tabname)
	for i,object in pairs(self.MainFrame.Tabs) do
		if object:GetName() == "ZA_Menu_"..tabname then
			object.label:SetTextColor(unpack(SkinData("TabSelectedColor")))
		else
			object.label:SetTextColor(unpack(SkinData("TabDefaultColor")))
		end
	end

	local windows = {"Buy","Inventory"}
	for i,framename in pairs(windows) do
		self.MainFrame[framename.."_Frame"]:Hide()
	end
	self.MainFrame[tabname.."_Frame"]:Show()

	self.ActiveTab = tabname
	Appraiser.itemForHighlights = nil
	Appraiser:Update()
end

function Appraiser:ShowWindow()
	if not ZGV.db.profile.auction_enable then return end

	if not self.MainFrame then self:CreateMainFrame() end

	if not ZGV.db.profile.IsWidgetCollapsed then
		ZGV.db.profile.IsWidgetCollapsed = {}
		ZGV.db.profile.IsWidgetCollapsed["Appraiser"] = false
	end
	
	if ZGV.db.profile.IsWidgetCollapsed["Appraiser"] == false then
		self.MainFrame:Show()
		self.toggleVisibility:SetPoint("RIGHT",self.MainFrame,"RIGHT",25,5)
	else 
		self.MainFrame:Hide()
		self.toggleVisibility:SetPoint("RIGHT",AuctionFrame,"RIGHT",25,5)
	end
	self.toggleVisibility:Show()

	ZGV.Gold.Appraiser.MainFrame.offset=0
	self:SetCurrentTab("Inventory")

	if ZGV.db.profile.autoscan then
		Appraiser:Scan()
	end
end

function Appraiser:HideWindow()
	if self.MainFrame then
		self.MainFrame:Hide()
		self.toggleVisibility:Hide()
	end
end

function Appraiser:UpdateTimeStamp()
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

	if not self.MainFrame then return end
	if not self.lastScanTime then self.lastScanTime = time() end

	local timestamptext,updateTitletext,lastScanStr

	if ZGVG.Scan.db.realm.LastScan then
		updateTitletext = "LAST UPDATED:"
		timestamptext = ("|c%s%s|r"):format(OldColor(ZGV.Gold.Scan.db.realm.LastScan,3600*2,60*10), ui.GetTimeStamp(ZGV.Gold.Scan.db.realm.LastScan))
	else
		updateTitletext = "|cffff0000ALERT:|r"
		timestamptext = L["app_gold_no_scan_data"]
	end

	if not (ZGV.Gold.servertrends and ZGV.Gold.servertrends.date) then
		updateTitletext = "|cffff0000ALERT:|r"
		timestamptext = L["app_gold_no_servertrends"]
	elseif ZGV.Gold.servertrends.date then
		local timeSinceLast = time() -  ZGV.Gold.servertrends.date

		if timeSinceLast > 86400*31 then	-- Data is > 14 days old
			updateTitletext = "|cffff0000ALERT:|r"
			timestamptext = L["app_gold_old_servertrends"]
		end
	end

	local local_time = debugprofilestop()
	local progress_dots = ""

	if (math.floor(local_time%1500) < 500) then
		progress_dots = "."
	elseif local_time%1500 < 1000 then
		progress_dots = ".."
	else
		progress_dots = "..."
	end

	if ZGV.Gold.Scan.state == "SS_QUERYING" then
		updateTitletext = "|cffff0000SCANNING:|r"
		timestamptext = "Querying auctions data" .. progress_dots
	elseif ZGV.Gold.Scan.state =="SS_RECEIVING" then
		updateTitletext = "|cffff0000SCANNING:|r"
		timestamptext = "Receiving auction data" .. progress_dots
	elseif ZGV.Gold.Scan.state =="SS_SCANNING" then
		updateTitletext = "|cffff0000SCANNING:|r"
		timestamptext = "Scanning auction data" .. progress_dots
	elseif ZGV.Gold.Scan.state =="SS_ANALYZING" then
		updateTitletext = "|cffff0000SCANNING:|r"
		timestamptext = "Analyzing auction data" .. progress_dots
	end



	self.MainFrame.FooterUpdated:SetText(updateTitletext)
	self.MainFrame.FooterUpdatedTime:SetText(timestamptext)
end

function Appraiser:CreateDealIcons()
	local NUMICONS = 8
	for x=1, NUM_BROWSE_TO_DISPLAY do
		if not dealIcon[x] then
		selectedBrowseButton = _G["BrowseButton"..x]
			dealIcon[x] = CHAIN(CreateFrame("Button","dealIconButton",selectedBrowseButton))--,ZGV.DIR.."\\Skins\\goldguideicons",1,NUMICONS,1,2,nil))
				:SetFrameStrata("MEDIUM")
				:SetPoint("TOPLEFT", selectedBrowseButton, "TOPLEFT", 3, -2)
				:SetSize(16,16)
				:Show()
			.__END
			
			dealIcon[x].texture = CHAIN(dealIcon[x]:CreateTexture("dealIconTexture","ARTWORK"))
				:SetSize(16,16)
				:SetTexture(ZGV.DIR.."\\Skins\\goldguideicons")
				:SetPoint("TOPLEFT", dealIcon[x], "TOPLEFT")
			.__END
			BetterTexCoord(dealIcon[x].texture,1,NUMICONS,1,2)
		end
	end
end

function Appraiser:HighlightDeals()
	itemid = Appraiser.itemForHighlights 
	priceMax = Appraiser.itemForHighlightsPrice 

	if not itemid then return end
			
	local offset = FauxScrollFrame_GetOffset(BrowseScrollFrame)
		
	if not dealIcon[1] then
		Appraiser:CreateDealIcons()
	end

	for x=1, NUM_BROWSE_TO_DISPLAY do
		dealIcon[x]:Hide()

		local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, AucItemId, hasAllInfo =  GetAuctionItemInfo("list",x+offset);
		if itemid==AucItemId then
			if priceMax and priceMax>=buyoutPrice/count then -- mark auctions to buy from goldguide ah
				dealIcon[x]:Show()
			elseif not priceMax and self:IsDeal(itemid, buyoutPrice/count) then -- mark deals for guide buy steps
				dealIcon[x]:Show()
			end
		end
	end
end
