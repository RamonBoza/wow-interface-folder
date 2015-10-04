-- Author      : Nogarder
-- Create Date : 2013/4/17 13:42:52
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Summoned",
	function()
		local string_sub=string.sub
		local string_split=string.split
		local string_len=string.len
		local UnitPlayerControlled=UnitPlayerControlled
		local UnitIsPlayer=UnitIsPlayer
		--
		local NPA_SpellInfo_GetSpellInfo=NPA.SpellInfo.GetSpellInfo
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		local NPA_DataCollector_GetUnitDataByGUID=NPA.DataCollector.GetUnitDataByGUID
		local NPA_FrameToGUID_NameToGUID=NPA.FrameToGUID.NameToGUID
		--
		local OnSummoned=function(arg,sourceunitdata,destunitdata)
			if(not sourceunitdata.Summon)then
				sourceunitdata.Summon={
					[destunitdata.GUID]=true
				}
			else
				sourceunitdata.Summon[destunitdata.GUID]=true
			end

			destunitdata.SummonedBy=arg[12]
			destunitdata.SummonedByUnitData=sourceunitdata
			--fire event
			NPA_EventHandler_FireEvent(7,"Summoned_Updated",destunitdata)
			--fire event
			NPA_EventHandler_FireEvent(7,"Summoned_Updated",sourceunitdata)
		end
		--
		local OnDestroyed=function(_,_,destunitdata)
			--remove the summoned link
			local sourceunitdata=NPA_DataCollector_GetUnitDataByGUID(destunitdata.SummonedBy)
			if(sourceunitdata)then
				sourceunitdata.Summon[destunitdata.GUID]=nil
				--fire event
				NPA_EventHandler_FireEvent(7,"Summoned_Updated",sourceunitdata)
			end
			destunitdata.SummonedBy=nil
			--fire event
			NPA_EventHandler_FireEvent(7,"Summoned_Updated",destunitdata)
		end
		--combatlog event
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_SUMMON","DataCollector_Summoned",OnSummoned)
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_CREATE","DataCollector_Summoned",OnSummoned)
		---
		NPA.DataCollector.RegisterCombatLogEvent("UNIT_DESTROYED","DataCollector_Summoned",OnDestroyed)
		NPA.DataCollector.RegisterCombatLogEvent("UNIT_DIED","DataCollector_Summoned",OnDestroyed)
		--tooltips scaner
		NPA.EventHandler.RegisterEvent(2,"DataCollector_TooltipsUpdated","DataCollector_CoolDown",function(unit,NPA_ScanTooltipLines)
			if(NPA_ScanTooltipLines[2])then
				if(UnitPlayerControlled(unit) and (not UnitIsPlayer(unit)))then
					local text=NPA_ScanTooltipLines[2]:GetText()
					if(text)then
						local len=string_len(text)-6
						local name,check
						--print(text.."|"..len)
						if(len>0 and string_sub(text,len-2,len)=="的")then
							name=string_sub(text,0,len-3)
							check=1
						else
							name,check=string_split("'",text)
						end
						--print(name)
						--print(check)
						if(name and (check==1 or check=="s Minion" or check=="s Pet" or check=="s Guardian"))then
							local name,_=strsplit("-",name)
							local guid=NPA_FrameToGUID_NameToGUID(name)
							if(guid)then
								local petunitdata=NPA_DataCollector_GetUnitDataByGUID(UnitGUID(unit))
								local masterunitdata=NPA_DataCollector_GetUnitDataByGUID(guid)
								if(not(masterunitdata.Summon and masterunitdata.Summon[petunitdata.GUID]))then
									OnSummoned({},masterunitdata,petunitdata)
								end
							end
						end
					end
				end
			end
		end)
		--
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_CoolDown",function(unit,unitdata)
			if(UnitPlayerControlled(unit))then
				local unitpet=unit.."pet"
				if(UnitExists(unitpet))then
					local masterunitdata=NPA_DataCollector_GetUnitDataByGUID(UnitGUID(unit))
					local petunitdata=NPA_DataCollector_GetUnitDataByGUID(UnitGUID(unitpet))
					if(masterunitdata and petunitdata)then
						if(not masterunitdata.Summon or not masterunitdata.Summon[petunitdata.GUID])then
							OnSummoned({},masterunitdata,petunitdata)
						end
					end
				end
			end
		end)

	end,
	function()
		--unregister events
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_SUMMON","DataCollector_Summoned",nil)
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_CREATE","DataCollector_Summoned",nil)
		NPA.DataCollector.RegisterCombatLogEvent("UNIT_DESTROYED","DataCollector_Summoned",nil)
		NPA.DataCollector.RegisterCombatLogEvent("UNIT_DIED","DataCollector_Summoned",nil)
		NPA.EventHandler.RegisterEvent(2,"DataCollector_TooltipsUpdated","DataCollector_CoolDown",nil)
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_CoolDown",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	--frame-based won't get any data so dont do transfer
	function()
		--
		--do nothing
	end
	)

