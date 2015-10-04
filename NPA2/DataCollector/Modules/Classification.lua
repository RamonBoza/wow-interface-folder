-- Author      : Nogarder
-- Create Date : 2012/9/7 16:13:52
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Classification",
	function()
		--global 
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		--
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_Classification",function(unit,unitdata)
			-- only fire if name is different
			local classification=UnitClassification(unit)
			if(unitdata.Classification~=classification)then
				unitdata.Classification=classification
				NPA_EventHandler_FireEvent(7,"Classification_Updated",unitdata)
			end
		end)
		--update basic data
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnUpdate","DataCollector_Classification",function(framedata)
			local unitdata=framedata.UnitData
			local classification
			if(framedata.Default.BossIcon:IsShown())then
				classification="worldboss"
			elseif(framedata.Default.EliteIcon:IsShown())then
				--placeholder--check color to decide whether unic or elite
				classification="elite"
			else
				classification="normal"
			end
			if(classification~=unitdata.Classification)then
				unitdata.Classification=classification
				--fire event
				NPA_EventHandler_FireEvent(8,"Classification_Updated",framedata)
			end
		end)
	end,
	--------
	function()
		-------unregister all events
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnUpdate","DataCollector_Classification",nil)
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_Classification",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function(unitdata,frameunitdata)
		--use frame-based
		unitdata.Classification=frameunitdata.Classification
	end
	)
