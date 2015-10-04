-- Author      : Nogarder
-- Create Date : 2013/4/20 11:28:24
--
local ArrowList={}
--
NPA.EventHandler.RegisterEvent(6,"TargetArrow_SettingUpdated","TargetArrow_Main",function()
	local pairs=pairs
	local UnitGUID=UnitGUID
	local next=next
	--
	local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent

	local NPA_DataCollector_GetUnitDataByGUID=NPA.DataCollector.GetUnitDataByGUID

	local NPA_ArrowManager_CreateArrow=NPA.ArrowManager.CreateArrow
	local NPA_ArrowManager_ManageArrow=NPA.ArrowManager.ManageArrow
	--
	local NPA_FrameToGUID_GetFrameByGUID=NPA.FrameToGUID.GetFrameByGUID
	local NPA_DataCollector_GetUnitFromGUID=NPA.DataCollector.GetUnitFromGUID
	local NPA_ArrowManager_SetColor=NPA.ArrowManager.SetColor
	--
	local GetArrow=function(index)
		--don't have to do recycle kind of thing
		--should be one arrow per frame
		--just return if already exists
		if(ArrowList[index])then
			return ArrowList[index]
		end
		--create new one
		ArrowList[index]=NPA_ArrowManager_CreateArrow(index)
		ArrowList[index]:Hide()
		return ArrowList[index]
	end
	--
	local PartyIDList={}
	for i=1,5 do
		PartyIDList[i]="party"..i
	end
	--
	local GetIndexByUnitData=function(unitdata)
		--faction and type check
		--type nil=unknow, 1=player,2=npc, 3=pet, 4=guardian
		--faction, 1=friendly,2=neutral,3=hostile
		if(unitdata.Type==1)then
			local name=unitdata.Name
			local lists=NPA.FriendsList
			if(unitdata.Faction==1)then
				if(lists.PartyList[name]==true)then
					return 8 --party
				elseif(lists.RaidList[name]==true)then
					return 9 --raid
				elseif(lists.GuildList[name]==true)then
					return 10--guild
				elseif(lists.FriendList[name]==true)then
					return 11--friend
				end
			elseif(unitdata.Faction==3)then
				if(lists.ArenaList[name]==true)then
					return 12 --arena opponent
				end
			end
		end
		if(unitdata.GUID==UnitGUID("player"))then
			return 4
		elseif(unitdata.GUID==UnitGUID("target"))then
			return 5
		elseif(unitdata.GUID==UnitGUID("focus"))then
			return 6
		elseif(unitdata.GUID==UnitGUID("mouseover"))then
			return 7
		else
			return "None"
		end
	end
	--if setting is empty, unregister event
	if(next(NPA_Setting.TargetArrow))then
		--build filter
		local Filter={
			--0=any, 1=friendly,2=neutral,3=hostile,4=self,5=target,6=focus,7=mouseover,8=party
			["None"]={},
			[0]={},
			[1]={},
			[2]={},
			[3]={},
			[4]={},
			[5]={},
			[6]={},
			[7]={},
			[8]={},
			[9]={},
			[10]={},
			[11]={},
			[12]={},
		}
		for _,setting in pairs(NPA_Setting.TargetArrow)do
			Filter[setting.From][setting.To]=setting
		end
		--
		NPA.EventHandler.RegisterEvent(7,"Target_Updated","TargetArrow_Main",function(unitdata)
			local startframe=NPA_FrameToGUID_GetFrameByGUID(unitdata.GUID)
			if(startframe)then
				local arrow=GetArrow(startframe)
				local targetunitdata=NPA_DataCollector_GetUnitDataByGUID(unitdata.TargetGUID)
				local endframe=NPA_FrameToGUID_GetFrameByGUID(unitdata.TargetGUID or 0)
				if(startframe:IsShown() and endframe and endframe:IsShown() and targetunitdata)then
					--check condition
					local factionfrom=unitdata.Faction or "None"
					local factionto=targetunitdata.Faction or "None"
					local from=GetIndexByUnitData(unitdata)
					local to=GetIndexByUnitData(targetunitdata)
					--get setting
					local setting=Filter[factionfrom][factionto] or Filter[factionfrom][0] or Filter[0][factionto] or 
										Filter[from][to] or Filter[from][0] or Filter[0][to] or
										Filter[factionfrom][to] or Filter[from][factionto] or
										Filter[0][0] 
					if(setting)then
						--all frame is visible
						if(arrow:IsShown())then --already shown, just extend its lifetime
							arrow.LifeTime=setting.LifeTime
						else
							--not shown, manage it
							--set startpoint
							arrow:SetPoint("CENTER",startframe,"CENTER",setting.StartOffsetX,setting.StartOffsetY)
							NPA_ArrowManager_ManageArrow(arrow,setting,setting.LifeTime,setting.FadeAlpha)
							--framelevel
							arrow:SetFrameLevel(setting.FrameLevel+arrow:GetParent():GetFrameLevel())
							arrow.Setting=setting
						end
						--set endpoint
						--arrow.EndPoint:SetParent(endframe) --don't set parent
						arrow.EndPoint:SetPoint("CENTER",endframe,"CENTER",setting.EndOffsetX,setting.EndOffsetY)
					--else
					--	arrow:Hide()
					end
				else--hide it 
					--arrow:Hide()
				end
			end
		end)
		--
		local GetRange=function(unit1,unit2)
			local x,y=UnitPosition(unit1)
			if(x and y and (x~=0 or y~=0))then
				local px,py=UnitPosition(unit2)
				if(px and py and (px~=0 or py~=0))then
					return floor(((px-x)^2+(py-y)^2)^0.5)
				end
			end
			return 0
		end
		--rangecheck
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectableNamePlate_OnUpdate","TargetArrow_Main",nil)
		NPA.EventHandler.RegisterEvent(8,"Range_Updated","TargetArrow_Main",nil)
		--
		for _,setting in pairs(NPA_Setting.TargetArrow)do
			if(setting.RangeCheck>0)then	
				NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectableNamePlate_OnUpdate","TargetArrow_Main",function(unit,unitdata)
					local startframe=NPA_FrameToGUID_GetFrameByGUID(unitdata.GUID)
					if(not startframe)then
						return
					end
					local arrow=GetArrow(startframe)
					if(arrow:IsShown() and arrow.Setting.RangeCheck>0)then
						if(unitdata.TargetGUID==UnitGUID("player"))then
							--use player range detect if aviliable
							if(unitdata.RangeUpdated)then
								local range=unitdata.RangeClose
								local setting=arrow.Setting
								if(range>setting.RangeCheck)then
										--set color
									NPA_ArrowManager_SetColor(arrow,setting.RangeColor,setting.RangeEndColor)
								else
									NPA_ArrowManager_SetColor(arrow,setting.Color,setting.EndColor)
								end
							else
								local targetunit="player"
								local range=GetRange(unit,targetunit)
								local setting=arrow.Setting
								if(range>setting.RangeCheck)then
									--set color
									NPA_ArrowManager_SetColor(arrow,setting.RangeColor,setting.RangeEndColor)
								else
									NPA_ArrowManager_SetColor(arrow,setting.Color,setting.EndColor)
								end
							end
						else
							local targetunit=NPA_DataCollector_GetUnitFromGUID(unitdata.TargetGUID)
							if(targetunit)then
								local range=GetRange(unit,targetunit)
								local setting=arrow.Setting
								if(range>setting.RangeCheck)then
									--set color
									NPA_ArrowManager_SetColor(arrow,setting.RangeColor,setting.RangeEndColor)
								else
									NPA_ArrowManager_SetColor(arrow,setting.Color,setting.EndColor)
								end
							end
						end
					end
				end)
				--
				NPA.EventHandler.RegisterEvent(8,"Range_Updated","TargetArrow_Main",function(framedata)
					if(framedata.UnitData.RangeUpdated and framedata.GUID==UnitGUID("target"))then
						local startframe=NPA_FrameToGUID_GetFrameByGUID(UnitGUID("player"))
						if(not startframe)then
							return
						end
						local arrow=GetArrow(startframe)
						if(arrow:IsShown() and arrow.Setting.RangeCheck>0)then
							local setting=arrow.Setting
							if(framedata.UnitData.RangeClose>setting.RangeCheck)then
								NPA_ArrowManager_SetColor(arrow,setting.RangeColor,setting.RangeEndColor)
							else
								NPA_ArrowManager_SetColor(arrow,setting.Color,setting.EndColor)
							end
						end
					end
				end)
				break
			end
		end
	else
		NPA.EventHandler.RegisterEvent(7,"Target_Updated","TargetArrow_Main",nil)
	end
	--hide all arrow ,force them to update
	for _,arrow in pairs(ArrowList)do
		arrow:Hide()
	end
end)
--

