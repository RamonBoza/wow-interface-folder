-- Author      : Nogarder
-- Create Date : 2013/4/19 12:13:01
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("RaidTarget",
	function()
		--global 
		--main --using local for speed
		local pairs=pairs
		--
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		local UnitExists=UnitExists
		local GetRaidTargetIndex=GetRaidTargetIndex
		--
		local TexCoordToIndex={
			[1]={0,0,0,0.25,0.25,0,0.25,0.25},
			[2]={0.25,0,0.25,0.25,0.5,0,0.5,0.25},
			[3]={0.5,0,0.5,0.25,0.75,0,0.75,0.25},
			[4]={0.75,0,0.75,0.25,1,0,1,0.25},
			[5]={0,0.25,0,0.5,0.25,0.25,0.25,0.5},
			[6]={0.25,0.25,0.25,0.5,0.5,0.25,0.5,0.5},
			[7]={0.5,0.25,0.5,0.5,0.75,0.25,0.75,0.5},
			[8]={0.75,0.25,0.75,0.5,1,0.25,1,0.5},
		}
		-------on collector collect_unit event
		--unit,unitdata
		--this is not necessary as checking with default
		--NPA.EventHandler.RegisterEvent(2,"DataCollector_Collectable_OnUpdate","DataCollector_RaidTarget",function(unit,unitdata)
		--	--must check exists or it would go strange
		--	if(not UnitExists(unit))then
		--		return
		--	end
		--	-- only fire if different
		--	local raidtarget=GetRaidTargetIndex(unit)
		--	if(unitdata.RaidTarget~=raidtarget)then
		--		unitdata.RaidTarget=raidtarget
		--		NPA_EventHandler_FireEvent(7,"RaidTarget_Updated",unitdata)
		--	end
		--end)
		--extract with default
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnUpdate","DataCollector_RaidTarget",function(framedata)
			--in case it has no default
			--should not happen, don't use it yet
			--if(not framedata.Default)then
			--	return
			--end
			--extract index from texcoord--maybe heavy to do it every update but is there another way?
			local defaulticon=framedata.Default.RaidIcon
			local raidtarget
			if(defaulticon:IsShown())then
				local texcoord={defaulticon:GetTexCoord()}
				for index,data in pairs(TexCoordToIndex)do
					if(data[1]==texcoord[1] and
						data[2]==texcoord[2] and
						data[3]==texcoord[3] and
						data[4]==texcoord[4] and
						data[5]==texcoord[5] and
						data[6]==texcoord[6] and
						data[7]==texcoord[7] and
						data[8]==texcoord[8])then

						raidtarget=index
						break
					end
				end
			end
			--
			local unitdata=framedata.UnitData
			if(unitdata.RaidTarget~=raidtarget)then
				unitdata.RaidTarget=raidtarget
				NPA_EventHandler_FireEvent(8,"RaidTarget_Updated",framedata)
			end
		end)
	end,
	--------
	function()
		-------unregister all events
		NPA.EventHandler.RegisterEvent(2,"DataCollector_Collectable_OnUpdate","DataCollector_RaidTarget",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function(unitdata,frameunitdata)
		--copy raid icon from frame based unitdata
		unitdata.RaidTarget=frameunitdata.RaidTarget --or unitdata.RaidTarget
	end
	)

