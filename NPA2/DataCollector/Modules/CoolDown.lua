-- Author      : Nogarder
-- Create Date : 2013/5/4 15:04:07
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
local CoolDownTimer
NPA.DataCollector.RegisterModule("CoolDown",
	function()
		--global
		local UnitGUID=UnitGUID
		local table_insert=table.insert
		local table_getn=table.getn
		local next=next
		local floor=floor
		local NPA_Timer_AddTimer=NPA.Timer.AddTimer
		local NPA_Timer_RemoveTimer=NPA.Timer.RemoveTimer
		--main --using local for speed
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		local NPA_SpellInfo_GetSpellInfo=NPA.SpellInfo.GetSpellInfo
		local NPA_DataCollector_GetUnitDataByGUID=NPA.DataCollector.GetUnitDataByGUID
		--
		local NPA_CompareTime=NPA.CompareTime
		local NPA_GetTime=NPA.GetTime
		--
		local PetCoolDownFunc
		local MasterCoolDownFunc
		--
		local NPA_CoolDown_Check=function(unitdata)
			local nTime=NPA_GetTime()
			local cdlist=unitdata.CoolDown
			for i=1,table_getn(cdlist) do
				local cd=cdlist[i]
				if(cd.SpellId and cd.EndTime<nTime)then
					--fire fake combat log event
					NPA_EventHandler_FireEvent(9,"COOLDOWN_ENDED",unitdata,cd.SpellId,cd.Count)
					--
					cd.SpellId=nil
				end
			end
		end
		--create or show timer
		--create or show timer
		if(not CoolDownTimer)then
			CoolDownTimer=NPA.Timer.CreateTimer(function(unitdata)
				NPA_CoolDown_Check(unitdata)
				NPA_EventHandler_FireEvent(7,"CoolDown_Updated",unitdata)
			end)
		end
		CoolDownTimer:Show()
		--
		--NPA_CoolDown_UpdateCoolDown(sourceunitdata,cooldowns,spelldata.AffectSpellList,appliedtime)
		local NPA_CoolDown_UpdateCoolDown=function(sourceunitdata,cooldownlist,affectlist,nTime)
			local max=table_getn(cooldownlist)
			for spellid,affect in pairs(affectlist)do
				for i=1,max do
					local cooldown=cooldownlist[i]
					if(cooldown.SpellId==spellid and cooldown.EndTime>nTime)then
						--0=reduce cooldown 1=extend cooldown , -- 2=master/pet reduce,3=master/pet extend
						if(affect.AffectType==0)then
							if(affect.AffectAmount==0)then
								--remove timer
								NPA_Timer_RemoveTimer(CoolDownTimer,sourceunitdata,i)
								--remove data
								cooldown.SpellId=nil
							else
								--reduce duration
								cooldown.EndTime=cooldown.EndTime-affect.AffectAmount
								if(cooldown.EndTime<nTime)then
									--remove timer
									NPA_Timer_RemoveTimer(CoolDownTimer,sourceunitdata,i)
									--remove data
									cooldown.SpellId=nil
								else
									--refresh timer
									NPA_Timer_AddTimer(CoolDownTimer,sourceunitdata,i,cooldown.EndTime)
								end
							end
						elseif(affect.AffectType==1 and affect.AffectAmount~=0)then
							cooldown.EndTime=cooldown.EndTime+affect.AffectAmount
							--refresh timer
							NPA_Timer_AddTimer(CoolDownTimer,sourceunitdata,i,cooldown.EndTime)
						end
					end
				end
			end
		end
		--macro for insert cooldown to data base on unitbuff/unitdebuff
		--																		cooldowns, spellid, casterguid, appliedtime,spelltype,spelldata.CoolDownStack,spelldata.CoolDown)
		local NPA_CoolDown_SortCoolDown=function(cooldownlist, spellid, casterguid, appliedtime,pelltype,cooldownstack,cooldownlength,unitdata,affectlist)
			--check affect list
			if(affectlist)then
				NPA_CoolDown_UpdateCoolDown(unitdata,cooldownlist,affectlist,appliedtime)
			end
			--
			local endtime=appliedtime+cooldownlength
			local max=table_getn(cooldownlist)
			--check data
			for i=1,max do
				local cooldown=cooldownlist[i]
				--in case spell from same unit already exists
				if(cooldown.SpellId==spellid and cooldown.CasterGUID==casterguid)then
					--caculate with applied time to prevent repeating
					--compare range 1s,given or taken
					if(NPA_CompareTime(cooldown.UpdatedTime,appliedtime,1))then
						--applied time or end time is same means it triggered twice by combatlog ,i.e Cast_Success and Aura_Applied
						--using either data will do
						cooldown.Sort=cooldown.Sort or spelltype 
						cooldown.EndTime=cooldown.EndTime or endtime
						cooldown.AppliedTime=cooldown.AppliedTime or appliedtime
					else
						--check if adding stack
						if(cooldown.EndTime>appliedtime and cooldownstack and cooldownstack>0)then
							--recaculate count
							local dendtime=cooldown.EndTime+cooldownlength
							local count=floor((dendtime-appliedtime)/cooldownlength)+1
							--add a stack
							if(count<=cooldownstack)then
								--set data
								cooldown.EndTime=dendtime
								cooldown.Count=count
							else
								--pass over max stack,must be something wrong ,recaculate new applied time
								cooldown.Count=cooldownstack
								cooldown.EndTime=appliedtime+cooldownlength*cooldownstack
								cooldown.AppliedTime=appliedtime
							end
						else
							--not adding stack,refresh it
							cooldown.Sort=spelltype or cooldown.Sort
							cooldown.AppliedTime=appliedtime or cooldown.AppliedTime
							cooldown.EndTime=endtime or cooldown.EndTime
							cooldown.Count=1
						end
					end
					cooldown.UpdatedTime=appliedtime
					NPA_Timer_AddTimer(CoolDownTimer,unitdata,i,cooldown.EndTime)
					return i
				end
			end
			--not exists, try use a unused data slot
			for i=1,max do
				local cooldown=cooldownlist[i]
				if(cooldown.SpellId==nil)then
					cooldown.SpellId=spellid
					cooldown.CasterGUID=casterguid
					cooldown.EndTime=endtime
					cooldown.AppliedTime=appliedtime
					cooldown.Sort=spelltype
					cooldown.Count=1
					cooldown.UpdatedTime=appliedtime
					NPA_Timer_AddTimer(CoolDownTimer,unitdata,i,endtime)
					return i
				end
			end
			--all used ,insert a new one
			local i=max+1
			cooldownlist[i]={
				SpellId=spellid,
				CasterGUID=casterguid,
				EndTime=endtime,
				AppliedTime=appliedtime,
				SpellType=spelltype,
				Count=1,
				UpdatedTime=appliedtime
			}
			NPA_Timer_AddTimer(CoolDownTimer,unitdata,i,endtime)
			return i
		end
		--
		
		---handle pet cooldown
		local SetPetCoolDownFunc=function()
			if(NPA_Setting.Core.CombiePetCoolDown==true)then
				PetCoolDownFunc=function(unitdata, spellid, casterguid , appliedtime, spelltype, cooldownstack,cooldownlength,affectlist)
					if(unitdata.SummonedByUnitData)then
						local masterunitdata=unitdata.SummonedByUnitData
						if(not masterunitdata.CoolDown)then
							masterunitdata.CoolDown={}
						end
						local index=NPA_CoolDown_SortCoolDown(masterunitdata.CoolDown, spellid, casterguid, appliedtime,spelltype,cooldownstack,cooldownlength,masterunitdata,affectlist)
						NPA_EventHandler_FireEvent(7,"CoolDown_Updated",masterunitdata)
						--fake combat  log event
						NPA_EventHandler_FireEvent(9,"COOLDOWN_STARTED",masterunitdata,spellid,cooldownlength,masterunitdata.CoolDown[index].Count)
					end
				end
			else
				PetCoolDownFunc=function()
					--do nothing
				end
			end
			if(NPA_Setting.Core.CombieMasterCoolDown==true)then
				MasterCoolDownFunc=function(unitdata, spellid, casterguid , appliedtime, spelltype, cooldownstack,cooldownlength,affectlist)
					if(unitdata.Summon)then
						for guid,_ in pairs (unitdata.Summon)do
							local petunitdata=NPA_DataCollector_GetUnitDataByGUID(guid)
							if(petunitdata)then
								if(not petunitdata.CoolDown)then
									petunitdata.CoolDown={}
								end
								local index=NPA_CoolDown_SortCoolDown(petunitdata.CoolDown, spellid, casterguid, appliedtime,spelltype,cooldownstack,cooldownlength,petunitdata,affectlist)
								NPA_EventHandler_FireEvent(7,"CoolDown_Updated",petunitdata)
								--fake combat  log event
								NPA_EventHandler_FireEvent(9,"COOLDOWN_STARTED",petunitdata,spellid,cooldownlength,petunitdata.CoolDown[index].Count)
							end
						end
					end
				end
			else
				MasterCoolDownFunc=function()
					--do nothing
				end
			end
		end
		--run once
		SetPetCoolDownFunc()
		--
		NPA.EventHandler.RegisterEvent(6,"SettingManager_SettingLoaded","DataCollector_CoolDown",SetPetCoolDownFunc)
		--combatlog event filter
		local NPA_CoolDown_CombatLogEventFilter={
			--cd count on caster
			--["SPELL_DAMAGE"]=1,
			--["SPELL_MISSED"]=1,
			["SPELL_CAST_SUCCESS"]=1,
			--["SPELL_CAST_START"]=1, --start should count?
			--["SPELL_AURA_APPLIED"]=1,
			--["SPELL_AURA_REFRESH"]=1,  don't use these two
			--cd count on target
			["SPELL_AURA_REMOVED"]=2, 
			--["SPELL_AURA_BROKEN"]=2, --count as remove
			--["SPELL_AURA_BROKEN_SPELL"]=2, --count as remove
			["SPELL_STOLEN"]=2, --count as remove
			["SPELL_DISPEL"]=2, --count as remove
		}
		--
		--combatlog event functions
		local NPA_CoolDown_CombatLogEventFunc={
			-- [1] for cooldown on used
			--destunitdata,arg[1],arg[4],arg[12]
			[1]=function(appliedtime,casterguid,sourceunitdata,_,_,spellid,spelltype)
				if(not sourceunitdata)then
					return
				end
				--create a data set if there isn't one
				if(not sourceunitdata.CoolDown)then
					sourceunitdata.CoolDown={}
				end
				--
				local spelldata=NPA_SpellInfo_GetSpellInfo(spellid)
				if(spelldata.CoolDown)then
					local cooldowns=sourceunitdata.CoolDown
					if(spelldata.CoolDown>0 and spelldata.CoolDownType==0)then -- type=0 is cd on used
						--sort it
						local affectlist=spelldata.AffectSpellList
						local index=NPA_CoolDown_SortCoolDown(cooldowns, spellid, casterguid, appliedtime,spelltype,spelldata.CoolDownStack,spelldata.CoolDown,sourceunitdata,affectlist)
						PetCoolDownFunc(sourceunitdata, spellid, casterguid, appliedtime,spelltype,spelldata.CoolDownStack,spelldata.CoolDown,affectlist)
						MasterCoolDownFunc(sourceunitdata, spellid, casterguid, appliedtime,spelltype,spelldata.CoolDownStack,spelldata.CoolDown,affectlist)
						--fake combat  log event
						NPA_EventHandler_FireEvent(9,"COOLDOWN_STARTED",sourceunitdata,spellid,spelldata.CoolDown,cooldowns[index].Count)
					end
					--
					NPA_EventHandler_FireEvent(7,"CoolDown_Updated",sourceunitdata)
				end
			end,
			--[2] for cooldown on aura removed
			[2]=function(appliedtime,_,_,destguid,destunitdata,spellid,spelltype)
				if(not destunitdata)then
					return
				end
				--create a data set if there isn't one
				if(not destunitdata.CoolDown)then
					destunitdata.CoolDown={}
				end
				--
				local spelldata=NPA_SpellInfo_GetSpellInfo(spellid)
				if(spelldata.CoolDown)then
					local cooldowns=destunitdata.CoolDown
					if(spelldata.CoolDown>0 and spelldata.CoolDownType==1)then -- type=1 is cd on removed
						--sort it
						local affectlist=spelldata.AffectSpellList
						local index=NPA_CoolDown_SortCoolDown(cooldowns, spellid, destguid, appliedtime,spelltype,spelldata.CoolDownStack,spelldata.CoolDown,destunitdata,affectlist)
						PetCoolDownFunc(destunitdata, spellid, casterguid, appliedtime,spelltype,spelldata.CoolDownStack,spelldata.CoolDown,affectlist)
						MasterCoolDownFunc(destunitdata, spellid, casterguid, appliedtime,spelltype,spelldata.CoolDownStack,spelldata.CoolDown,affectlist)
						--fake combat  log event
						NPA_EventHandler_FireEvent(9,"COOLDOWN_STARTED",destunitdata,spellid,spelldata.CoolDown,cooldowns[index].Count)
					end
					--
					NPA_EventHandler_FireEvent(7,"CoolDown_Updated",destunitdata)
				end
			end,
		}
		--get 'any' event then filter it locally
		NPA.DataCollector.RegisterCombatLogEvent("Any","DataCollector_CoolDown",function(arg,sourceunitdata,destunitdata)
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
			--[15]=spelltype (Buff/Debuff)
			--[16]=amount
			--check with the filter			--return if destGUID not exists or spellid is nil
			local filter=NPA_CoolDown_CombatLogEventFilter[arg[2]]
			if(filter and arg[12])then
				--run the pointed function
				--unknow type count as buff
				NPA_CoolDown_CombatLogEventFunc[filter](arg[1],arg[4],sourceunitdata,arg[8],destunitdata,arg[12],arg[15] or "BUFF")
			end
		end)
	end,
	function()
		--hide timer
		if(CoolDownTimer)then
			CoolDownTimer:Hide()
		end
		--unregister events
		NPA.DataCollector.RegisterCombatLogEvent("Any","DataCollector_CoolDown",nil)
		NPA.EventHandler.RegisterEvent(6,"SettingManager_SettingLoaded","DataCollector_CoolDown",nil)
	end
	--no data transfer as frame-based won't get any cooldown
	)
