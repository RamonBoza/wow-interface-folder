-- Author      : Nogarder
-- Create Date : 2014/5/26 14:23:26
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Unit",
	function()
		--global 
		--main --using local for speed
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		-------on collector collect_unit event
		--unit,unitdata
		local UnitGUID=UnitGUID
		local localization=NPA_Setting.Unit.Name
		local prioritylist=NPA_Setting.Unit.Priority
		--update realtime just in case
		NPA.EventHandler.RegisterEvent(1,"NamePlate_ModuleMain_OnUpdate","DataCollector_UnitID",function(framedata)
			local guid=framedata.GUID
			if(guid==nil)then
				return
			end
			----------
			local unitdata=framedata.UnitData
			local id=""
			local priority=0
			if(prioritylist["target"]>priority and UnitGUID("target")==guid)then
				id=localization["target"]
				priority=prioritylist["target"]
			end
			if(prioritylist["mouseover"]>priority and UnitGUID("mouseover")==guid)then
				id=localization["mouseover"]
				priority=prioritylist["mouseover"]
			end
			if(prioritylist["focus"]>priority and UnitGUID("focus")==guid)then
				id=localization["focus"]
				priority=prioritylist["focus"]
			end
			
			if(prioritylist["party"]>priority)then
				for i=1,5 do
					local unitid="party"..i
					if(UnitGUID(unitid)==guid)then
						id=localization["party"]..i
						priority=prioritylist["party"]
						break
					end
					--unitid=unitid.."-pet"
					--if(UnitGUID(unitid)==guid)then
					--	id=unitid
					--	break
					--end
				end
			end
			if(prioritylist["raid"]>priority)then
				for i=1,40 do
					local unitid="raid"..i
					if(UnitGUID(unitid)==guid)then
						id=localization["raid"]..i
						priority=prioritylist["raid"]
						break
					end
					--unitid=unitid.."-pet"
					--if(UnitGUID(unitid)==guid)then
					--	id=unitid
					--	break
					--end
				end
			end
			if(prioritylist["arena"]>priority)then
				for i=1,5 do
					local unitid="arena"..i
					if(UnitGUID(unitid)==guid)then
						id=localization["arena"]..i
						priority=prioritylist["arena"]
						break
					end
					--unitid=unitid.."-pet"
					--if(UnitGUID(unitid)==guid)then
					--	id=unitid
					--	break
					--end
				end
			end
			--NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_UnitID",function(unit,unitdata)
			--local unitid=tonumber(string.sub(unitdata.GUID,7,10),16)
			--if(unitid==0)then
			--	unitid=nil
			--end
			if(unitdata.Unit~=id)then
				unitdata.Unit=id
				NPA_EventHandler_FireEvent(7,"Unit_Updated",unitdata)
			end
		end)
	end,
	--------
	function()
		-------unregister all events
		NPA.EventHandler.RegisterEvent(1,"NamePlate_ModuleMain_OnUpdate","DataCollector_Unit",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function()
		--it's updated real time, so don't have to do nothing
	end
	)

