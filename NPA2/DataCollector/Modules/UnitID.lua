-- Author      : Nogarder
-- Create Date : 2012/12/18 12:14:33
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("UnitID",
	function()
		--global 
		--main --using local for speed
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		-------on collector collect_unit event
		--unit,unitdata
		--update realtime just in case
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_UnitID",function(unit,unitdata)
			local unitid=unitdata.GUID
			--tonumber(string.sub(unitdata.GUID,7,10),16)
			--if(unitid==0)then
			--	unitid=nil
			--end
			if(unitdata.UnitID~=unitid)then
				unitdata.UnitID=unitid
				NPA_EventHandler_FireEvent(7,"UnitID_Updated",unitdata)
			end
		end)
	end,
	--------
	function()
		-------unregister all events
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_UnitID",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function()
		--it's updated real time, so don't have to do nothing
	end
	)

