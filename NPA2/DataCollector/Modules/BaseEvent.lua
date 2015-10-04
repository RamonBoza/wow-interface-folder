-- Author      : Nogarder
-- Create Date : 2014/2/20 15:33:19

--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("BaseEvent",
	function()
		--global 
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		--update basic data
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnShow","DataCollector_BaseEvent",function(framedata)
			NPA_EventHandler_FireEvent(8,"BaseEvent_PreOnShow",framedata)
		end)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnHide","DataCollector_BaseEvent",function(framedata)
			NPA_EventHandler_FireEvent(8,"BaseEvent_OnHide",framedata)
		end)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_ModuleMain_OnUpdate","DataCollector_BaseEvent",function(framedata)
			NPA_EventHandler_FireEvent(8,"BaseEvent_OnUpdate",framedata)
		end)
	end,
	--------
	function()
		-------unregister all events
		--NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_PreOnShow","DataCollector_BaseEvent",nil)
		--NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnHide","DataCollector_BaseEvent",nil)
		--NPA.EventHandler.RegisterEvent(1,"NamePlate_ModuleMain_OnUpdate","DataCollector_BaseEvent",nil)
	end,
	--data trans ferfunction
	function(unitdata,frameunitdata)
	end)
