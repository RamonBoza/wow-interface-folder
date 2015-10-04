-- Author      : Nogarder
-- Create Date : 2013/6/10 12:45:45
--this still require mouseover /target to be accurate

--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("ComboPoints",
	function()
		local UnitGUID=UnitGUID
		local GetComboPoints=GetComboPoints
		local NPA_NamePlate_GetFrameData=NPA.NamePlate.GetFrameData
		local NPA_DataCollector_GetUnitDataByGUID=NPA.DataCollector.GetUnitDataByGUID
		--main --using local for speed
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		--on collect event
		--unit,unitdata
		local ComboTarget=nil
		local CheckTarget=function(unit,points)
			local targetGUID=UnitGUID(unit)
			if(not targetGUID)then
				if(ComboTarget)then
					targetGUID=ComboTarget
				else
					return
				end
			end
			local curunitdata=NPA_DataCollector_GetUnitDataByGUID(targetGUID)
			if(curunitdata.ComboPoints~=points)then --when combopoints not fit record
				if(points==0)then
					curunitdata.ComboPoints=nil
				else
					curunitdata.ComboPoints=points
				end
				NPA_EventHandler_FireEvent(7,"ComboPoints_Updated",curunitdata)
				--if the previous target is not current target
				if(ComboTarget)then
					if(ComboTarget~=targetGUID)then
						--remove the combopoints on previous target
						local preunitdata=NPA_DataCollector_GetUnitDataByGUID(ComboTarget)
						preunitdata.ComboPoints=nil
						--fire event for both unit
						NPA_EventHandler_FireEvent(7,"ComboPoints_Updated",preunitdata)
						--record target
						ComboTarget=targetGUID
					end
				else
					ComboTarget=targetGUID
				end
			end
		end
		local CheckUnit=function(unit)
			local points=GetComboPoints("player",unit)
			if(points>0)then
				CheckTarget(unit,points)
				return true
			end
		end
		NPA.EventHandler.RegisterEvent(0,"UNIT_COMBO_POINTS","DataCollector_ComboPoints",function(unit)
			if(unit=="player" and --check for sure, may not always be "player"
				(CheckUnit("target") or CheckUnit("mouseover") or CheckUnit("focus") or CheckUnit("player")))then
				return
			else
				CheckTarget("target",GetComboPoints("player"))
			end
		end)
		--also do a check when target changed in case missing something
		NPA.EventHandler.RegisterEvent(0,"PLAYER_TARGET_CHANGED","DataCollector_ComboPoints",function()
			CheckUnit("target")
		end)
		NPA.EventHandler.RegisterEvent(0,"UPDATE_MOUSEOVER_UNIT","DataCollector_ComboPoints",function()
			CheckUnit("mouseover")
		end)
	end,
	function()
		--unregister events
		NPA.EventHandler.RegisterEvent(0,"UNIT_COMBO_POINTS","DataCollector_ComboPoints",nil)
		NPA.EventHandler.RegisterEvent(0,"PLAYER_TARGET_CHANGED","DataCollector_ComboPoints",nil)
		NPA.EventHandler.RegisterEvent(0,"UPDATE_MOUSEOVER_UNIT","DataCollector_ComboPoints",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function(unitdata,frameunitdata)
		--do nothing now
		--unitdata.Target=nil
	end
	)
