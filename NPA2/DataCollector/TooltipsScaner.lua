-- Author      : Nogarder
-- Create Date : 2013/4/7 13:33:57
--note
--	RecountTempTooltip:SetHyperlink("unit:" .. guid)  <==maybe useful
--local UnitExists=UnitExists --using unitname
local UnitName=UnitName
local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
local string_find=string.find
local table_insert=table.insert
local type=type
local pairs=pairs
--tooltips scaner
--create a invisiable tooltip to get system information
local NPA_ScanTooltip = CreateFrame( "GameTooltip", "NPAScanTooltip", UIParent, "GameTooltipTemplate") 
NPA_ScanTooltip:SetOwner( WorldFrame, "ANCHOR_NONE")

--register event
--
NPA.EventHandler.RegisterEvent(2,"DataCollector_UnitUpdated","DataCollector_TooltipsScaner",function(unit)
	if(UnitExists(unit))then
		NPA_ScanTooltip:ClearLines()
		NPA_ScanTooltip:SetUnit(unit)
		--fire a event
		local i=1
		local NPA_ScanTooltipLines={}
		local name="NPAScanTooltipTextLeft"..i
		local frame=_G[name]
		while(frame)do
			table_insert(NPA_ScanTooltipLines,frame)
			i=i+1
			name="NPAScanTooltipTextLeft"..i
			frame=_G[name]
		end
		--
		NPA_EventHandler_FireEvent(2,"DataCollector_TooltipsUpdated",unit,NPA_ScanTooltipLines,i-1)
	end
end)
