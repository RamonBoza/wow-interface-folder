-- Author      : Nogarder
-- Create Date : 2012/9/7 15:14:33
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Alpha",
	function()
		--global 
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		--update basic data
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnUpdate","DataCollector_Alpha",function(framedata)
			local unitdata=framedata.UnitData
			local alpha=framedata.Parent:GetAlpha()
			if(alpha~=unitdata.Alpha)then
				unitdata.Alpha=alpha
				--fire alpha change event
				NPA_EventHandler_FireEvent(8,"Alpha_Updated",framedata)
			end
		end)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnShow","DataCollector_Alpha",function(framedata)
			local unitdata=framedata.UnitData
			local alpha=framedata.Parent:GetAlpha()
			unitdata.Alpha=alpha
			--fire alpha change event
			NPA_EventHandler_FireEvent(8,"Alpha_Updated",framedata)
		end)
	end,
	--------
	function()
		-------unregister all events
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnUpdate","DataCollector_Alpha",nil)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnShow","DataCollector_Alpha",nil)
	end,
	--data trans ferfunction
	function(unitdata,frameunitdata)
		--using frame-based , guid-based won't get anything about alpha
		unitdata.Alpha=frameunitdata.Alpha
	end)
