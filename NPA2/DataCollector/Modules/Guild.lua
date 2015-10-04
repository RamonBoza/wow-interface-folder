-- Author      : Nogarder
-- Create Date : 2012/3/16 20:05:11
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Guild",
	function()
		--global 
		local GetGuildInfo=GetGuildInfo
		--main --using local for speed
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		-------on collector collect_unit event
		--unit,unitdata
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_Guild",function(unit,unitdata)
			-- only fire if name is different
			local guild=GetGuildInfo(unit)
			if(unitdata.Guild~=guild)then
				unitdata.Guild=guild
				NPA_EventHandler_FireEvent(7,"Guild_Updated",unitdata)
			end
		end)
	end,
	--------
	function()
		-------unregister all events
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_Guild",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function(unitdata,frameunitdata)
		--do nothing
	end
	)

