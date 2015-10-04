-- Author      : Nogarder
-- Create Date : 2013/4/7 10:25:54

--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Target",
	function()
		local UnitGUID=UnitGUID
		--main --using local for speed
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		local NPA_GetTime=NPA.GetTime
		--on collect event
		--unit,unitdata
		NPA.EventHandler.RegisterEvent(2,"DataCollector_Collectable_OnUpdate","DataCollector_Target",function(unit,unitdata,nTime)
			--store a target link
			unitdata.TargetGUID=UnitGUID(unit.."-target")
			--also keep a time, as it won't update quite soon
			unitdata.TargetUpdated=nTime
			NPA_EventHandler_FireEvent(7,"Target_Updated",unitdata)
		end)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_ModuleMain_OnUpdate","DataCollector_Target",function(framedata)
			if(framedata.GUID)then
				local updated=framedata.UnitData.TargetUpdated
				if(updated and NPA_GetTime()-updated>1)then
					framedata.UnitData.TargetUpdated=nil
					NPA_EventHandler_FireEvent(7,"Target_Updated",framedata.UnitData)
				end
			end
		end)
	end,
	function()
		--unregister events
		NPA.EventHandler.RegisterEvent(2,"DataCollector_Collectable_OnUpdate","DataCollector_Target",nil)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_ModuleMain_OnUpdate","DataCollector_Target",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function(unitdata,frameunitdata)
		--do nothing now
		--unitdata.Target=nil
	end
	)
