-- Author      : Nogarder
-- Create Date : 2013/7/16 13:01:06
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Speed",
	function()
		local GetUnitSpeed=GetUnitSpeed
		local NPA_GetTime=NPA.GetTime
		--main --using local for speed
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		--on collect event
		--unit,unitdata
		NPA.EventHandler.RegisterEvent(2,"DataCollector_Collectable_OnUpdate","DataCollector_Speed",function(unit,unitdata,nTime)
			--store a target link
			unitdata.Speed=floor(GetUnitSpeed(unit)*10)/10
			--also keep a time, as it won't update quite soon
			unitdata.SpeedUpdated=nTime
			NPA_EventHandler_FireEvent(7,"Speed_Updated",unitdata)
		end)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_ModuleMain_OnUpdate","DataCollector_Speed",function(framedata)
			if(framedata.GUID)then
				local updated=framedata.UnitData.SpeedUpdated
				if(updated and NPA_GetTime()-updated>1)then
					framedata.UnitData.SpeedUpdated=nil
					NPA_EventHandler_FireEvent(7,"Speed_Updated",framedata.UnitData)
				end
			end
		end)
	end,
	function()
		--unregister events
		NPA.EventHandler.RegisterEvent(2,"DataCollector_Collectable_OnUpdate","DataCollector_Speed",nil)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_ModuleMain_OnUpdate","DataCollector_Speed",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function(unitdata,frameunitdata)
		--do nothing now
		--unitdata.Speed=nil
	end
	)
