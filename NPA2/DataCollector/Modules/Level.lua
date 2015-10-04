-- Author      : Nogarder
-- Create Date : 2012/3/16 20:07:32
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Level",
	function()
		local UnitLevel=UnitLevel
		--main --using local for speed
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		--on collect event
		--unit,unitdata
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_Level",function(unit,unitdata)
			--level may change when unit level up
			local level=UnitLevel(unit)
			if(level ~= unitdata.Level)then
				unitdata.Level=level
				--fire a event about it
				NPA_EventHandler_FireEvent(7,"Level_Updated",unitdata)
			end
		end)
		--update basic data
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnUpdate","DataCollector_Level",function(framedata)
			local unitdata=framedata.UnitData
			local level
			if(framedata.Default.BossIcon:IsShown())then
				level=nil
			else
				level=framedata.Default.LevelText:GetText()
			end
			if(level~=unitdata.Level)then
				unitdata.Level=level
				--fire event
				NPA_EventHandler_FireEvent(8,"Level_Updated",framedata)
			end
		end)
	end,
	function()
		--unregister events
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_Level",nil)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnUpdate","DataCollector_Level",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function(unitdata,frameunitdata)
		--either of them would do (they're the same)
		unitdata.Level=frameunitdata.Level or unitdata.Level
	end
	)
