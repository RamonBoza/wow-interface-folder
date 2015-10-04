-- Author      : Nogarder
-- Create Date : 2014/11/22 17:01:41
--note
--SPELL_ABSORBED
--absorb melee
--arg[12]=casterguid?
--arg[13]=castername?
--arg[14]=casterflag?
--arg[15]=casterflag2?
--arg[16]=spellid
--arg[17]=spellname
--arg[18]=spellschool
--arg[19]=absorbamount
--absorb spell
--arg[12]=damage spell id
--arg[13]=damage caster name
--arg[14]=damage spell school
--arg[15]=casterguid?
--arg[16]=castername?
--arg[17]=casterflag?
--arg[18]=casterflag2?
--arg[19]=spellid
--arg[20]=spellname
--arg[21]=spellschool
--arg[22]=absorbamount
--SPELL_AURA_REMOVED
--arg[16]=absorbamount
--sychonize combatlog and unitbuff really eat up resources, blame blizzard
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Shield",
	function()
		--global
		local UnitGUID=UnitGUID
		local UnitBuff=UnitBuff
		local table_insert=table.insert
		local table_getn=table.getn
		local NPA_GetTime=NPA.GetTime
		local NPA_Forever=NPA.Forever
		local NPA_EndTime=NPA.EndTime
		local floor=floor
		--
		local NPA_ShieldSpellList={}
		--main --using local for speed
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		--on collect event
		NPA.EventHandler.RegisterEvent(7,"Health_Updated","DataCollector_Shield",function(unitdata)
			--shield max always = max health
			if(unitdata.ShieldMax~=unitdata.HealthMax)then
				unitdata.ShieldMax=unitdata.HealthMax
				NPA_EventHandler_FireEvent(7,"Shield_Updated",unitdata)
			end
		end)
		--advanced shield track

		local NPA_SpellInfo_GetSpellInfo=NPA.SpellInfo.GetSpellInfo
		--combatlog event filter
		local NPA_Shield_CombatLogEventFilter={
			["SPELL_AURA_APPLIED"]=1,
			["SPELL_AURA_REFRESH"]=1, --same as apply
			["SPELL_AURA_REMOVED"]=2, --should be 1 or 2?
			--["SPELL_STOLEN"]=2, --count as remove
			--["SPELL_DISPEL"]=2, --count as remove
			--melee type
			["SPELL_ABSORBED"]=3,
		}
		--
		--combatlog event functions
		local NPA_Shield_CombatLogEventFunc={
			-- [1] for adding/refreshing aura
			--destunitdata, amount
			[1]=function(unitdata,arg)
				--check if it's a shield spell
				if((not arg[16]) or (not NPA_ShieldSpellList[arg[12]]))then
					return
				end
				--add it to shield
				unitdata.Shield=(unitdata.Shield or 0)+floor(arg[16])
				--fire event
				NPA_EventHandler_FireEvent(7,"Shield_Updated",unitdata)
			end,
			--[2] for remove aura
			[2]=function(unitdata,arg)
				--check if it's a shield spell
				if((not arg[16]) or (not NPA_ShieldSpellList[arg[12]]))then
					return
				end
				--
				unitdata.Shield=(unitdata.Shield or 0)-floor(arg[16])
				if(unitdata.Shield<0)then
					unitdata.Shield=0
				end
				--fire event
				NPA_EventHandler_FireEvent(7,"Shield_Updated",unitdata)
			end,
			--[3] for absorb,
			[3]=function(unitdata,arg)
				--absorbed spell damage
				local newamount=0
				if(arg[22])then
					NPA_ShieldSpellList[arg[19]]=true
					newamount=(unitdata.Shield or 0)-floor(arg[22])
				else
					if(arg[19])then
						NPA_ShieldSpellList[arg[16]]=true
						newamount=(unitdata.Shield or 0)-floor(arg[19])
					else
						return
					end
				end
				
				if(newamount<0)then
					newamount=0
				end
				--only fire event when amount change
				if(unitdata.Shield~=newamount)then
					unitdata.Shield=newamount
					NPA_EventHandler_FireEvent(7,"Shield_Updated",unitdata)
				end
			end,
		}
		--unit,unitdata
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_Shield",function(unit,unitdata)			
			--create data set if not exists
			local shieldamount=UnitGetTotalAbsorbs(unit)
			----
			--local i=1
			----seek every buff on unit
			--repeat
			--	--name, rank,icon , count , bufftype , duration , expirationtime , unitcaster , isstealable , shouldconsolidate , spellid = UnitBuff(unit,i)
			--	--15=absorbamount
			--	local _, _, _ , _,_,_,_,_,_,_,spellid,_,_,_,absorbamount = UnitBuff(unit,i)
			--	--applied time is critical for cooprating with combatlog
			--	if(spellid and NPA_ShieldSpellList[spellid] and absorbamount)then
			--		shieldamount=shieldamount+absorbamount
			--	end
			--	i=i+1
			--until(not spellid)
			if(unitdata.Shield~=shieldamount)then
				unitdata.Shield=shieldamount
				--fire a event
				NPA_EventHandler_FireEvent(7,"Shield_Updated",unitdata)
			end
		end)
		--get 'any' event then filter it locally
		NPA.DataCollector.RegisterCombatLogEvent("Any","DataCollector_Shield",function(arg,_,destunitdata)
			--[1]=timestamp
			--[2]=event
			--[3]=hidecaster
			--[4]=sourceGUID
			--[5]=srouceName
			--[6]=sourceFlags
			--[7]=sourceFlags2 raidflag
			--[8]=destGUID
			--[9]=destName
			--[10]=destFlags
			--[11]=destFlags2 raidflag
			--[12]=spellid
			--[13]=spellname
			--[14]=spellschool
			--[15]=auratype (Buff/Debuff)
			--[16]=amount
			--check with the filter			--check if sourceGUID and destGUID and spellid exist
			if(NPA_Shield_CombatLogEventFilter[arg[2]] and arg[8] and arg[12])then
				--run the pointed function
				NPA_Shield_CombatLogEventFunc[NPA_Shield_CombatLogEventFilter[arg[2]]](destunitdata,arg)
			end
		end)
	end,
	function()
		--unregister events
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_Shield",nil)
		NPA.DataCollector.RegisterCombatLogEvent("Any","DataCollector_Shield",nil)
		NPA.EventHandler.RegisterEvent(7,"Health_Updated","DataCollector_Shield",nil)
	end
	--no data transfer as frame-based won't get any aura
	)
