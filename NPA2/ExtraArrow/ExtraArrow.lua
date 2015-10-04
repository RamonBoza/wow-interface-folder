-- Author      : Nogarder
-- Create Date : 2015/2/3 15:30:37
local FrameToArrow={}

NPA.EventHandler.RegisterEvent(6,"ExtraArrow_SettingUpdated","ExtraArrow_Main",function()
	local pairs=pairs
	local UnitGUID=UnitGUID
	local next=next
	local tonumber=tonumber
	local tostring=tostring
	local table_insert=table.insert
	--
	local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent

	local NPA_DataCollector_GetUnitDataByGUID=NPA.DataCollector.GetUnitDataByGUID

	local NPA_ArrowManager_CreateArrow=NPA.ArrowManager.CreateArrow
	local NPA_ArrowManager_ManageArrow=NPA.ArrowManager.ManageArrow
	--
	local NPA_FrameToGUID_GetFrameByGUID=NPA.FrameToGUID.GetFrameByGUID
	--
	--if setting is empty, unregister event
	if(next(NPA_Setting.ExtraArrow))then
		local RangeList={}
		local NameList={}
		local settings=NPA_Setting.ExtraArrow
		for index,setting in pairs(settings)do
			if(tostring(tonumber(setting.ToUnit))==setting.ToUnit)then
				RangeList[index]=setting
			else
				NameList[index]=setting
			end
		end
		--
		local GetArrowByFrame=function(framedata,index)
			local arrow
			if(not FrameToArrow[framedata])then
				arrow=NPA_ArrowManager_CreateArrow(UIParent)
				FrameToArrow[framedata]={[index]=arrow}
				return arrow
			end
			local arrow=FrameToArrow[framedata][index]
			if(arrow)then
				return arrow
			end
			arrow=NPA_ArrowManager_CreateArrow(UIParent)
			FrameToArrow[framedata][index]=arrow
			return arrow
		end
		--do checks in real-time, hopefully not to costy
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnUpdate","ExtraArrow_Main",function(framedata)
			local guid=framedata.GUID or "none"
			local name=framedata.Name or "none"
			--
			for index,setting in pairs(NameList)do
				local arrow=GetArrowByFrame(framedata,index)
				if(guid==UnitGUID(setting.ToUnit) or name==setting.ToUnit)then
					if(arrow:IsShown())then
						--extend life if already shown
						arrow.LifeTime=0.1
					else
						--startpoint
						arrow:SetPoint("CENTER",UIParent,"CENTER",setting.StartOffsetX,setting.StartOffsetY)
						NPA_ArrowManager_ManageArrow(arrow,setting,0.1) --set life time=nil make it always show until hide manually
					end
					--endpoint reset
					arrow.EndPoint:SetPoint("CENTER",framedata.ModuleMain,"CENTER",setting.EndOffsetX,setting.EndOffsetY)
				end
			end
		end)
		--
		if(next(RangeList))then
			NPA.EventHandler.RegisterEvent(8,"Range_Updated","ExtraArrow_Main",function(framedata)
				if(framedata.UnitData.RangeUpdated)then
					local range=framedata.UnitData.RangeClose
					for index,setting in pairs(RangeList)do
						local arrow=GetArrowByFrame(framedata,index)
						if(range and range<tonumber(setting.ToUnit))then
							if(arrow:IsShown())then
								--extend life if already shown
								arrow.LifeTime=0.1
							else
								--startpoint
								arrow:SetPoint("CENTER",UIParent,"CENTER",setting.StartOffsetX,setting.StartOffsetY)
								NPA_ArrowManager_ManageArrow(arrow,setting,0.1) --set life time=nil make it always show until hide manually
							end
							--endpoint reset
							arrow.EndPoint:SetPoint("CENTER",framedata.ModuleMain,"CENTER",setting.EndOffsetX,setting.EndOffsetY)
						end
					end
				end
			end)
		end
	else
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnUpdate","ExtraArrow_Main",nil)
		NPA.EventHandler.RegisterEvent(8,"Range_Updated","ExtraArrow_Main",nil)
	end
	--all arrow should hide automaticly
end)
--

