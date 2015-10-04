-- Author      : Nogarder
-- Create Date : 2013/6/9 16:33:02

--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Power",
	function()
		local UnitPower=UnitPower
		local UnitPowerType=UnitPowerType
		local NPA_GetTime=NPA.GetTime
		--main --using local for speed
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		--on collect event
		--unit,unitdata
		NPA.EventHandler.RegisterEvent(2,"DataCollector_Collectable_OnUpdate","DataCollector_Power",function(unit,unitdata,nTime)
			--store a target link
			unitdata.Power=UnitPower(unit)
			unitdata.PowerMax=UnitPowerMax(unit)
			unitdata.PowerType=UnitPowerType(unit)
			--also keep a time, as it won't update quite soon
			unitdata.PowerUpdated=nTime
			NPA_EventHandler_FireEvent(7,"Power_Updated",unitdata)
		end)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_ModuleMain_OnUpdate","DataCollector_Power",function(framedata)
			if(framedata.GUID)then
				local updated=framedata.UnitData.PowerUpdated
				if(updated and NPA_GetTime()-updated>1)then
					framedata.UnitData.PowerUpdated=nil
					NPA_EventHandler_FireEvent(7,"Power_Updated",framedata.UnitData)
				end
			end
		end)
	end,
	function()
		--unregister events
		NPA.EventHandler.RegisterEvent(2,"DataCollector_Collectable_OnUpdate","DataCollector_Power",nil)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_ModuleMain_OnUpdate","DataCollector_Power",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function(unitdata,frameunitdata)
		--do nothing now
		--unitdata.Power=nil
	end
	)
