-- Author      : Nogarder
-- Create Date : 2013/8/14 13:13:58
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("NPCGuild",
	function()
		--global 
		--main --using local for speed
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		local NPA_DataCollector_GetUnitDataByGUID=NPA.DataCollector.GetUnitDataByGUID
		-------on collector collect_unit event
		local	UnitGUID=UnitGUID
		local UnitPlayerControlled=UnitPlayerControlled
		local UnitName=UnitName
		local strsplit=strsplit
		local tonumber=tonumber
		local NPA_NPCGuildCache={}
		--unit,unitdata

		NPA.EventHandler.RegisterEvent(2,"DataCollector_TooltipsUpdated","DataCollector_NPCGuild",function(unit,lines)
			if(lines[3])then
				local name=UnitName(unit)
				if((not UnitPlayerControlled(unit)) and name)then	--rule out player and pets
					local text=lines[3]:GetText()
					if(text)then
						_,text=strsplit(" ",text)
						if(text=="??" or tonumber(text))then
							local guild=lines[2]:GetText()
							NPA_NPCGuildCache[name]=guild
							local unitdata=NPA_DataCollector_GetUnitDataByGUID(UnitGUID(unit))
							if(unitdata.NPCGuild~=guild)then
								unitdata.NPCGuild=guild
								NPA_EventHandler_FireEvent(7,"NPCGuild_Updated",unitdata)
							end
						end
					end
				end
			end
		end)
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_NPCGuild",function(unit,unitdata)
			-- only fire if name is different
			local name=UnitName(unit)
			if(name)then
				local npcguild=NPA_NPCGuildCache[name]
				-- only fire if name is different
				if(unitdata.NPCGuild~=npcguild)then
					unitdata.NPCGuild=npcguild
					NPA_EventHandler_FireEvent(7,"NPCGuild_Updated",unitdata)
				end
			else
				unitdata.NPCGuild=nil
			end
		end)

		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnShow","DataCollector_NPCGuild",function(framedata)
			local name=framedata.Default.NameText:GetText()
			if(name)then
				local unitdata=framedata.UnitData
				local npcguild=NPA_NPCGuildCache[name]
				-- only fire if name is different
				if(unitdata.NPCGuild~=npcguild)then
					unitdata.NPCGuild=npcguild
					NPA_EventHandler_FireEvent(8,"NPCGuild_Updated",framedata)
				end
			else
				framedata.UnitData.NPCGuild=nil
			end
		end)
	end,
	--------
	function()
		-------unregister all events
		NPA.EventHandler.RegisterEvent(2,"DataCollector_TooltipsUpdated","DataCollector_NPCGuild",nil)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnShow","DataCollector_NPCGuild",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function(unitdata,frameunitdata)
		unitdata.NPCGuild=frameunitdata.NPCGuild or unitdata.NPCGuild
	end
	)

