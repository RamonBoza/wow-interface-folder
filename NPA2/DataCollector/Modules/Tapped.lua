-- Author      : Nogarder
-- Create Date : 2013/4/27 15:35:10
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Tapped",
	function()
		local UnitIsTapped=UnitIsTapped
		local UnitIsTappedByPlayer=UnitIsTappedByPlayer
		--main --using local for speed
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		local GetTappedByColor=function(r,g,b)
			if(floor(r*10)==5 and floor(g*10)==5 and floor(b*10)==5)then
				return true
			else
				return false
			end
		end
		--
		NPA.EventHandler.RegisterEvent(8,"Type_Updated","DataCollector_Tapped",function(framedata)
			if(framedata.Default)then
				local unitdata=framedata.DefaultUnitData
				local r,g,b,a=framedata.Default.HealthBar:GetStatusBarColor()
				--get type data
				local tapped=GetTappedByColor(r,g,b)
				if(unitdata.Tapped~=tapped)then
					unitdata.Tapped=tapped
					--fire type change event
					NPA_EventHandler_FireEvent(8,"Tapped_Updated",framedata)
				end
			end
		end)
		--unit,unitdata
		NPA.EventHandler.RegisterEvent(2,"DataCollector_Collectable_OnUpdate","DataCollector_Tapped",function(unit,unitdata,nTime)
			local tapped=(UnitIsTapped(unit)) and (not UnitIsTappedByPlayer(unit))
			if(unitdata.Tapped~=tapped)then
				unitdata.Tapped=tapped
				NPA_EventHandler_FireEvent(7,"Tapped_Updated",unitdata)
			end
		end)
	end,
	function()
		--unregister events
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnUpdate","DataCollector_Type",nil)
		NPA.EventHandler.RegisterEvent(2,"DataCollector_Collectable_OnUpdate","DataCollector_Tapped",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function(unitdata,frameunitdata)
		--do nothing now
		unitdata.Tapped=frameunitdata.Tapped
	end,
	--data clear function
	function(unitdata)
		unitdata.Tapped=nil
	end
	)
