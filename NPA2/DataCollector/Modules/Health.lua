-- Author      : Nogarder
-- Create Date : 2012/3/20 1:45:33
--main --using local for speed

local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Health",
	function()
		--global
		local UnitHealth=UnitHealth
		local UnitHealthMax=UnitHealthMax
		--on collect event
		--unit,unitdata
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_Health",function(unit,unitdata)
			local health=UnitHealth(unit)
			local healthmax=UnitHealthMax(unit)
			--only fire event when health changes
			if(health~=unitdata.Health or healthmax~=unitdata.HealthMax)then
				unitdata.Health=health
				unitdata.HealthMax=healthmax
				NPA_EventHandler_FireEvent(7,"Health_Updated",unitdata)
			end
		end)
		--update basic data
		NPA.EventHandler.RegisterEvent(1,"NamePlate_HealthBar_OnValueChanged","DataCollector_Health",function(framedata,value,_,max) --min should be 0
			local unitdata=framedata.UnitData
			unitdata.Health=value
			unitdata.HealthMax=max
			--fire event
			NPA_EventHandler_FireEvent(8,"Health_Updated",framedata,unitdata)
		end)
	end,
	function()
		--unregister events
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_Health",nil)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_HealthBar_OnValueChanged","DataCollector_Health",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function(unitdata,frameunitdata)
		--use frame based first as it would be more accruate
		unitdata.Health=frameunitdata.Health or unitdata.Health
		unitdata.HealthMax=frameunitdata.HealthMax or unitdata.HealthMax
	end
	)