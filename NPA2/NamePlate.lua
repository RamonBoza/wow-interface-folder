-- Author      : Nogarder
-- Create Date : 2012/3/17 18:03:33
-- global function
local select=select
local floor=floor
local pairs=pairs
local string_find=string.find
local string_gsub=string.gsub 
--main --using local for speed
local GetDefaultName=function(framedata)
	local text=framedata.Default.NameText:GetText()
	framedata.OriginalName=text
	framedata.Name=string.gsub(text,"%s%(.+","")
	if(framedata.Name==text)then
		framedata.Name=string.gsub(text,"%(.+","")
	end
end
local GetName=function(framedata)
	return framedata.Default.NameText:GetText()
end

NPA.NamePlate={}
local NPA_MainFrame=NPA.MainFrame
local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
--children count -for detect default nameplate
local NPA_NamePlate_NumChildren=0
--frame data stack
local NPA_NamePlate_FrameData={}
local NPA_NamePlate_ChatBubbleData={}
--lookup
local NPA_NamePlate_ModuleMainToFrameData={}
local NPA_NamePlate_ChatBubbleMainToFrameData={}
-- fire event
----healthbar on update, also fired when shown --this doesn't work all the time, blame blizzard!
local NPA_NamePlate_Hook_HealthBar_OnValueChanged=function(self)
	NPA_EventHandler_FireEvent(1,"NamePlate_HealthBar_OnValueChanged",NPA_NamePlate_FrameData[self:GetParent():GetParent()],self:GetValue(),self:GetMinMaxValues())
end
--castbar
local NPA_NamePlate_Hook_Default_CastBar_OnShow=function(self)
	NPA_EventHandler_FireEvent(1,"NamePlate_CastBar_OnShow",NPA_NamePlate_FrameData[self:GetParent():GetParent()],self:GetValue(),self:GetMinMaxValues())
end
--due to strange region protection these can't work properly
local NPA_NamePlate_Hook_Default_CastBar_OnHide=function(self)
	NPA_EventHandler_FireEvent(1,"NamePlate_CastBar_OnHide",NPA_NamePlate_FrameData[self:GetParent():GetParent()],self:GetValue(),self:GetMinMaxValues())
end
local NPA_NamePlate_Hook_Default_CastBar_OnUpdate=function(self)
	NPA_EventHandler_FireEvent(1,"NamePlate_CastBar_OnUpdate",NPA_NamePlate_FrameData[self:GetParent():GetParent()],self:GetValue(),self:GetMinMaxValues())
end
--default nameplate
--init data, this should speed it up
local NPA_NamePlate_ClearData=function(framedata)
	--clear guid and name
	framedata.GUID=nil
	framedata.Name=nil
	framedata.OriginalName=nil
	--set back unitdata
	local unitdata=framedata.DefaultUnitData
	framedata.UnitData=unitdata
	unitdata.GUID=nil --maybe this should be in frametoguid?
	--fire clear up event to data collector
	NPA_EventHandler_FireEvent(2,"NamePlate_ClearData",unitdata)
	--clear up profile
	framedata.Profile=nil
end
--
local NPA_NamePlate_Hook_Default_OnShow=function(self)
	local framedata=NPA_NamePlate_FrameData[self]
	--clear up data again before fire event, in case onhide didn't fire up for some unknown reason
	--it's rare but happens
	NPA_NamePlate_ClearData(framedata)
	--some function must happen before reset
	NPA_EventHandler_FireEvent(1,"NamePlate_DefaultMain_PreOnShow",framedata)
	--show
	framedata.ModuleMain:Show()
	--store name, for change detection
	GetDefaultName(framedata)
	--also fire healthbar update event
	local healthbar=framedata.Default.HealthBar
	NPA_EventHandler_FireEvent(1,"NamePlate_HealthBar_OnValueChanged",framedata,healthbar:GetValue(),healthbar:GetMinMaxValues())
	--also check castbar and fire event
	local castbar=framedata.Default.CastBar
	if(castbar:IsShown())then
		NPA_NamePlate_Hook_Default_CastBar_OnShow(castbar)
	else
		NPA_NamePlate_Hook_Default_CastBar_OnHide(castbar)
	end
	--fire onshow event
	NPA_EventHandler_FireEvent(1,"NamePlate_DefaultMain_OnShow",framedata)
end
--
NPA.EventHandler.RegisterEvent(1,"NamePlate_RequireDefaultMain_OnShow","NamePlate",function(framedata)
	--clear up data again before fire event, in case onhide didn't fire up for some unknown reason
	--it's rare but happens
	NPA_NamePlate_ClearData(framedata)
	--some function must happen before reset
	NPA_EventHandler_FireEvent(1,"NamePlate_DefaultMain_PreOnShow",framedata)
	--show
	framedata.ModuleMain:Show()
	--store name, for change detection
	GetDefaultName(framedata)
	--also fire healthbar update event
	local healthbar=framedata.Default.HealthBar
	NPA_EventHandler_FireEvent(1,"NamePlate_HealthBar_OnValueChanged",framedata,healthbar:GetValue(),healthbar:GetMinMaxValues())
	--also check castbar and fire event
	local castbar=framedata.Default.CastBar
	if(castbar:IsShown())then
		NPA_NamePlate_Hook_Default_CastBar_OnShow(castbar)
	else
		NPA_NamePlate_Hook_Default_CastBar_OnHide(castbar)
	end
	--fire onshow event
	NPA_EventHandler_FireEvent(1,"NamePlate_DefaultMain_OnShow",framedata)
end)
--
local NPA_NamePlate_Hook_Default_OnHide=function(self)
	local framedata=NPA_NamePlate_FrameData[self]
	--fire event before clear data
	NPA_EventHandler_FireEvent(1,"NamePlate_DefaultMain_OnHide",framedata)
	--hide and clearup data
	framedata.ModuleMain:Hide()
	--clear data on hide
	NPA_NamePlate_ClearData(framedata)
end
--fire a event when updated (used by data collector modules)
local NPA_NamePlate_Hook_Default_OnUpdate=function(self)
	local framedata=NPA_NamePlate_FrameData[self]
	if(not framedata.ModuleMain:IsShown())then
		framedata.ModuleMain:Show()
	end
	--detect name change
	local name=GetName(framedata)
	if(name~=framedata.OriginalName)then
		--reinit at name change
		NPA_NamePlate_Hook_Default_OnShow(self)
	else
		--fire on update event
		NPA_EventHandler_FireEvent(1,"NamePlate_DefaultMain_OnUpdate",framedata)
	end
end
--module main
local NPA_NamePlate_Hook_ModuleMain_OnShow=function(self)
	NPA_EventHandler_FireEvent(1,"NamePlate_ModuleMain_OnShow",NPA_NamePlate_ModuleMainToFrameData[self])
end
local NPA_NamePlate_Hook_ModuleMain_OnHide=function(self)
	NPA_EventHandler_FireEvent(1,"NamePlate_ModuleMain_OnHide",NPA_NamePlate_ModuleMainToFrameData[self])
end
local NPA_NamePlate_Hook_ModuleMain_OnUpdate=function(self)
	--check hidden, sometime the onhide function could go wrong
	if(not self.Parent:IsShown())then
		self:Hide()
	else
		NPA_EventHandler_FireEvent(1,"NamePlate_ModuleMain_OnUpdate",NPA_NamePlate_ModuleMainToFrameData[self])
	end
end
----debug function
--local DumpNamePlateRegionInfo=function(region,name)
--	print("name")
--	print(name)
--	print("texture")
--	local objtype=region:GetObjectType()
--	if(objtype=="StatusBar")then
--		--for statusbar
--		print(region:GetStatusBarTexture():GetTexture())
--	elseif(objtype=="Texture")then
--		--for texture
--		print(region:GetTexture())
--	elseif(objtype=="FontString")then
--		--for font string
--		print(region:GetFont())
--	end
--	print("width")
--	print(region:GetWidth())
--	print("height")
--	print(region:GetHeight())
--	print("anchor")
--	local point, anchorframe, topoint, offsetx, offsety =region:GetPoint(n)
--	print(point)
--	print(anchorframe)
--	print(anchorframe:GetName())
--	print(anchorframe:GetObjectType())
--	print(topoint)
--	print(offsetx)
--	print(offsety)
--	print("-----")
--end

-- get default nameplate regions ,2 versions
local NPA_NamePlate_GetDefaultFrameRegion=function(frame)
	local maingroup,nametextgroup=frame:GetChildren()
	local healthBar,castBar=maingroup:GetChildren()
	local threatGlowRegion, overlayRegion, highlightRegion, levelTextRegion, bossIconRegion, raidIconRegion, eliteIconRegion = maingroup:GetRegions()
	local nameTextRegion=nametextgroup:GetRegions()

	--hook functions
	--frame
	frame:HookScript("OnUpdate",NPA_NamePlate_Hook_Default_OnUpdate)
	frame:HookScript("OnShow",NPA_NamePlate_Hook_Default_OnShow)
	frame:HookScript("OnHide",NPA_NamePlate_Hook_Default_OnHide)
	--healthbar
	--onshow doesn't work currectly here, so put it in default main's on show
	healthBar:HookScript("OnValueChanged",NPA_NamePlate_Hook_HealthBar_OnValueChanged)
	--castbar
	local _,castBarOverlayRegion, castBarShieldRegion, spellIconRegion=castBar:GetRegions()
	castBar:HookScript("OnShow",NPA_NamePlate_Hook_Default_CastBar_OnShow) --hook up onshow for hidding purpose only
	castBar:HookScript("OnHide",NPA_NamePlate_Hook_Default_CastBar_OnHide)
	castBar:HookScript("OnUpdate",NPA_NamePlate_Hook_Default_CastBar_OnUpdate)
	--
	--print(frame:GetWidth())
	--print(frame:GetHeight())
	--print(castBarOverlayRegion)
	--DumpNamePlateRegionInfo(spellIconRegion)

	--return data
	return {
	ThreatGlow = threatGlowRegion, --texture --threat glow
	Overlay = overlayRegion, --texture
	Highlight = highlightRegion, --texture
	NameText = nameTextRegion, --fontstring
	LevelText = levelTextRegion, --fontstring
	BossIcon = bossIconRegion, --texture -- raid boss icon
	RaidIcon = raidIconRegion, --texture
	EliteIcon= eliteIconRegion, --texture --elite icon

	HealthBar = healthBar, --statusbar
	--
	CastBar = castBar, -- statusbar
	CastBarOverlay = castBarOverlayRegion, --texture
	CastBarShield = castBarShieldRegion, --texture
	SpellIcon= spellIconRegion,--texture -- castbar spell icon
	}
end

--hook default frame
local NPA_NamePlate_HookFrame=function(frame)
	--get default frame data
	local default=NPA_NamePlate_GetDefaultFrameRegion(frame)
	--scroll frame rendering
	local modulemain
	if(NPA_Setting.Core.UsingScrollFrameRender==true)then
		--main rendering  frame
		--scroll frame rendering would mess up with framelevel
		local scrollframe=CreateFrame("ScrollFrame","NPA_LayerFrame",NPA_MainFrame)
		scrollframe:SetHeight(2048)
		scrollframe:SetWidth(2048)
		scrollframe:SetPoint("CENTER",modulemain,"CENTER")
		scrollframe:SetFrameStrata("BACKGROUND")
		scrollframe:Show()
		local rendermain=CreateFrame("Frame","NPA_NamePlateRenderMainFrame",scrollframe)
		rendermain:SetHeight(1)
		rendermain:SetWidth(1)
		rendermain:Show()
		rendermain:SetFrameStrata("BACKGROUND")
		scrollframe:SetScrollChild(rendermain)
		--module mainframe
		modulemain=CreateFrame("Frame","NPA_NamePlateMainFrame",rendermain)
		modulemain.RenderMain=scrollframe
	else
		--using standard frame
		modulemain=CreateFrame("Frame","NPA_NamePlateMainFrame",NPA_MainFrame)
	end
	--
	modulemain:Hide() --hide it until initializing is over
	modulemain:SetHeight(1)
	modulemain:SetWidth(1)
	modulemain:SetPoint("CENTER",frame,"CENTER")
	modulemain:SetFrameStrata("BACKGROUND")
	modulemain.Parent=frame
	--
	NPA_NamePlate_FrameData[frame]={
		Parent=frame,
		Default=default,
		ModuleMain=modulemain,
		Name=nil,
		GUID=nil,
		UnitData=nil,
		DefaultUnitData={},
		Profile=nil
	}
	local framedata=NPA_NamePlate_FrameData[frame]
	NPA_NamePlate_ModuleMainToFrameData[modulemain]=framedata
	--fire event for modules to hook on modulemain
	NPA_EventHandler_FireEvent(1,"NamePlate_DefaultMain_OnHook",framedata)
	--also run on show function
	NPA_NamePlate_Hook_Default_OnShow(frame)
	--module mainframe functions
	--put these after onhook event
	modulemain:SetScript("OnShow",NPA_NamePlate_Hook_ModuleMain_OnShow)
	modulemain:SetScript("OnHide",NPA_NamePlate_Hook_ModuleMain_OnHide)
	modulemain:SetScript("OnUpdate",NPA_NamePlate_Hook_ModuleMain_OnUpdate)
	--show modulemain
	modulemain:Show()
end
--hook default chat bubble
local NPA_NamePlate_HookChatBubble=function(frame)
	local bubbleframe=CreateFrame("Frame","NPA_ChatBubbleMainFrame",NPA_MainFrame)
	bubbleframe:Hide() --hide it until initializing is over
	bubbleframe:SetHeight(1)
	bubbleframe:SetWidth(1)
	bubbleframe:SetPoint("CENTER",frame,"CENTER")
	bubbleframe:SetFrameStrata("BACKGROUND")
	bubbleframe.Parent=frame
	NPA_NamePlate_ChatBubbleData[frame]=bubbleframe
	NPA_NamePlate_ChatBubbleMainToFrameData[bubbleframe]=frame
	--event
	NPA_EventHandler_FireEvent(1,"NamePlate_DefaultChatBubble_OnHook",bubbleframe)
	--and show it
	bubbleframe:Show()
end
--check if frame is default nameplate
local NPA_NamePlate_IsDefaultNamePlateFrame=function(frame)
	--detect with name
	--after 4.x the nameplates will have name like "NamePlate128"
	local name=frame:GetName()
	if(name and string_find(name,"NamePlate"))then
		return true
	end
end
local NPA_NamePlate_IsDefaultChatBubble=function(frame)
	--detect with backdrop
	local backdrop = frame:GetBackdrop()
	--it doesn't have name, check with background, it's not so through but will have to do
	if(backdrop and backdrop.bgFile == "Interface\\Tooltips\\ChatBubble-Background") then
		
		local point, relativeTo, relativePoint, xofs, yofs=frame:GetPoint(0)
		print(relativeTo:GetWidth())
		print(relativeTo:GetHeight())
		
		if(not frame.Label)then
			local label=UIParent:CreateFontString(nil,"OVERLAY")
			label:SetFont(GameFontNormal:GetFont())
			label:SetText("test12345678789")
			label:SetPoint("CENTER",relativeTo,"CENTER",0,0)
			label:Show()
			frame.Label=label
		end
	end
end
--check for new default namepalte
local NPA_NamePlate_CheckDefaultFrame=function()
	local frames={WorldFrame:GetChildren()}
	for _,frame in pairs(frames) do
		--check for nameplate
		if (NPA_NamePlate_IsDefaultNamePlateFrame(frame))then
			--setup frame data
			if(not NPA_NamePlate_FrameData[frame])then
				NPA_NamePlate_HookFrame(frame)
			end
		end
		--check for chat bubbles
		--if(NPA_NamePlate_IsDefaultChatBubble(frame))then
		--	if(not NPA_NamePlate_ChatBubbleData[frame])then
		--		NPA_NamePlate_HookChatBubble(frame)
		--	end
		--end
	end 
end

--register mainframe on update for default nameplate detection
NPA.EventHandler.RegisterEvent(3,"NPA_MainFrame_OnUpdate","NamePlate",function()
	--detect default nameplate frame	
	local num=WorldFrame:GetNumChildren()
	if(num~=NPA_NamePlate_NumChildren)then
		NPA_NamePlate_NumChildren=num
		NPA_NamePlate_CheckDefaultFrame()
	end
end)
--refresh profile when setting changes
NPA.EventHandler.RegisterEvent(6,"NamePlate_ProfileRefresh","NamePlate",function()
	for frame,framedata in pairs(NPA_NamePlate_FrameData)do
		if(frame:IsShown() and framedata.Profile)then
			NPA_EventHandler_FireEvent(1,"NamePlate_ProfileChange",framedata,framedata.Profile)
		end
	end
end)
--when profile refreshs by NPA_Options
--fire profilechange event with every visible frame
--to refresh the display
NPA.EventHandler.RegisterEvent(6,"Resources_ProfileRefresh","NamePlate",function()
	for frame,framedata in pairs(NPA_NamePlate_FrameData)do
		if(frame:IsShown() and framedata.Profile)then
			NPA_EventHandler_FireEvent(1,"NamePlate_ProfileChange",framedata,framedata.Profile)
		end
	end
end)
--when profile key changes, only fire with the frame which using them
NPA.EventHandler.RegisterEvent(6,"NamePlate_ProfileKeyChange","NamePlate",function(profilename)
	local profile=NPA_Setting.NamePlate[profilename]
	for frame,framedata in pairs(NPA_NamePlate_FrameData)do
		if(frame:IsShown() and framedata.Profile==profile)then
			NPA_EventHandler_FireEvent(1,"NamePlate_ProfileChange",framedata,profile)
		end
	end
end)
--get frame data
NPA.NamePlate.GetFrameData=function()
	return NPA_NamePlate_FrameData
end