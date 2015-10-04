-- Author      : Nogarder
-- Create Date : 2012/3/16 20:05:11
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Name",
	function()
		--global 
		local UnitName=UnitName
		local UnitPVPName=UnitPVPName
		--main --using local for speed
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		-------on collector collect_unit event
		--unit,unitdata
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_Name",function(unit,unitdata)
			-- only fire if name is different
			local name,server=UnitName(unit)
			if(unitdata.Name~=name)then-- or unitdata.Server~=server)then what the odds name is same but server is not on same nameplate?
				unitdata.Name=name
				unitdata.Server=server
				unitdata.PVPName=UnitPVPName(unit)
				NPA_EventHandler_FireEvent(7,"Name_Updated",unitdata)
			end
		end)
		--update basic data
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnUpdate","DataCollector_Name",function(framedata)
			local unitdata=framedata.UnitData
			local name=framedata.Name
			if(name~=unitdata.Name)then
				unitdata.Name=name
				unitdata.Server=nil
				if(not unitdata.PVPName)then
					unitdata.PVPName=name
				end
				NPA_EventHandler_FireEvent(8,"Name_Updated",framedata)
			end
		end)
	end,
	--------
	function()
		-------unregister all events
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_Name",nil)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnShow","DataCollector_Name",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function(unitdata,frameunitdata)
		--either of them would do (they're the same)
		unitdata.Name=frameunitdata.Name or unitdata.Name
		--using guid data first
		unitdata.PVPName=unitdata.PVPName or frameunitdata.PVPName
	end,
	--data clear function
	function(unitdata)
		unitdata.Name=nil
		unitdata.PVPName=nil
	end
	)

