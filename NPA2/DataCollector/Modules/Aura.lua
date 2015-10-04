-- Author      : Nogarder
-- Create Date : 2012/3/24 6:44:50
--note
--sychonize combatlog and unitbuff really eat up resources, blame blizzard
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Aura",
	function()
		--global
		local UnitGUID=UnitGUID
		local UnitBuff=UnitBuff
		local UnitDebuff=UnitDebuff
		local table_insert=table.insert
		local table_getn=table.getn
		local NPA_GetTime=NPA.GetTime
		local NPA_Forever=NPA.Forever
		local NPA_EndTime=NPA.EndTime
		local floor=floor
		--main --using local for speed
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		local NPA_SpellInfo_GetSpellInfo=NPA.SpellInfo.GetSpellInfo
		--macro for insert aura to data base on unitbuff/unitdebuff
		local NPA_Aura_SortAura=function(auralist, spellid, casterguid, count , appliedtime,expirationtime,sort,spelltype,stealable)
			local max=table_getn(auralist)
			--check data
			for i=1,max do
				local aura=auralist[i]
				--check with applied time, it's accurate
				if(aura.SpellId==spellid and aura.AppliedTime==appliedtime)then
					--already exists ,check refresh
					--check expiration time and spelltype
					--ignore type check if spelltype==nil
					if(floor(aura.ExpirationTime)==floor(expirationtime) and (spelltype==nil or aura.SpellType==spelltype))then			
						local name=GetSpellInfo(aura.SpellId)
						--same spell, still update count and type
						aura.Sort=sort or aura.Sort
						aura.SpellType=spelltype or aura.SpellType
						aura.Stealable=stealable or aura.Stealable
						aura.Count=count or aura.Count
						return i,false
					else
						aura.CasterGUID=aura.CasterGUID or casterguid
						aura.Count=count
						aura.ExpirationTime=expirationtime or aura.ExpirationTime
						aura.Sort=sort
						aura.SpellType=spelltype
						aura.Stealable=stealable
						return i,true
					end
				--in case of refreshing, there's only one spellid per caster on same unit
				elseif(aura.SpellId==spellid and aura.CasterGUID==casterguid)then
					--update time and count
					aura.AppliedTime=appliedtime or aura.AppliedTime
					--aura.CasterGUID=aura.CasterGUID or casterguid
					aura.Count=count
					aura.ExpirationTime=expirationtime or aura.ExpirationTime
					--use old sort and type if there is one
					aura.Sort=aura.Sort or sort
					aura.SpellType=aura.SpellType or spelltype
					aura.Stealable=stealable
					return i,true
				end
			end
			--not exists, try use a unused data slot
			for i=1,max do
				local aura=auralist[i]
				if(aura.SpellId==nil)then
					aura.SpellId=spellid
					aura.CasterGUID=casterguid
					aura.Count=count
					aura.ExpirationTime=expirationtime
					aura.AppliedTime=appliedtime
					aura.Sort=sort
					aura.SpellType=spelltype
					aura.Stealable=stealable
					return i,true
				end
			end
			--all used ,insert a new one
			local i=max+1
			auralist[i]={
				SpellId=spellid,
				CasterGUID=casterguid,
				Count=count,
				ExpirationTime=expirationtime,
				AppliedTime=appliedtime,
				Sort=sort,
				SpellType=spelltype,
				Stealable=stealable
			}
			return i,true
		end

		--combatlog event filter
		local NPA_Aura_CombatLogEventFilter={
			["SPELL_AURA_APPLIED"]=1,
			["SPELL_AURA_REFRESH"]=1, --same as apply
			["SPELL_AURA_APPLIED_DOSE"]=1,
			["SPELL_AURA_REMOVED"]=2, 
			["SPELL_AURA_REMOVED_DOSE"]=3,
			--["SPELL_AURA_BROKEN"]=2, --count as remove
			--["SPELL_AURA_BROKEN_SPELL"]=2, --count as remove
			["SPELL_STOLEN"]=2, --count as remove
			["SPELL_DISPEL"]=2, --count as remove
		}
		--
		local NPA_InfoFromFlag_GetPlayer=NPA.InfoFromFlag.GetPlayer
		--combatlog event functions
		local NPA_Aura_CombatLogEventFunc={
			-- [1] for adding/refreshing aura
			--destunitdata,arg[1],arg[4],arg[12],arg[16],arg[6],arg[10],arg[15],)
			[1]=function(destunitdata,appliedtime,casterguid,spellid,amount,auratype,arg)
				--create a data set if there isn't one
				if(not destunitdata.Aura)then
					destunitdata.Aura={}
				end
				--
				local endtime
				local spelldata=NPA_SpellInfo_GetSpellInfo(spellid)
				--if there's no length then delay 1s for unit update to kick in
				if(arg[10] and NPA_InfoFromFlag_GetPlayer(arg[10])>0)then
					endtime=appliedtime+(spelldata.PVPLength or 1)
				else
					endtime=appliedtime+(spelldata.Length or 1)
				end
				--sort it
				--NPA_Aura_SortAura(auralist, spellid, casterguid, count , appliedtime,expirationtime,sort ,spelltype)
				NPA_Aura_SortAura(destunitdata.Aura, spellid, casterguid, amount or 0, appliedtime,endtime,auratype,spelldata.SpellType)
			end,
			--[2] for remove aura
			[2]=function(destunitdata,_,casterguid,spellid)
				--return if there isn't data
				if(not destunitdata.Aura)then
					return
				else
					for _,aura in pairs(destunitdata.Aura)do
						--check with spellid and casterguid , the same buff from same unit won't apply twice
						if(aura.SpellId==spellid and aura.CasterGUID==casterguid)then
							--set the id to nil would mark it unused
							aura.SpellId=nil
							return
						end
					end
				end
			end,
			--[3] for remove doses ,remove dose won't change other thing but 'count'
			[3]=function(destunitdata,_,casterguid,spellid,amount)
				--return if there isn't data
				if(not destunitdata.Aura)then
					return
				else
					--there's data, check if it's a refresh
					for _,aura in pairs(destunitdata.Aura)do
						if(aura.SpellId==spellid and aura.CasterGUID==casterguid)then
							--refresh dose data
							aura.Count=amount or aura.Count or 0
							return
						end
					end
					--there's not a aura in record to remove dose from, just leave it
				end
			end,
		}
		--on collect event
		--unit,unitdata
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_Aura",function(unit,unitdata)			
			--create data set if not exists
			if(not unitdata.Aura)then
				unitdata.Aura={}
			end
			--
			local updatelist={}
			--
			local doupdate=false
			local auralist=unitdata.Aura
			local nTime=NPA_GetTime()
			local i=1
			--seek every buff on unit
			repeat
				--name,rank,  icon , count , bufftype , duration , expirationtime , unitcaster , isstealable , shouldconsolidate , spellid = UnitBuff(unit,i)
				--name, rank, icon, count, debuffType, duration, expirationTime, caster, canStealOrPurge, _ , spellId = UnitBuff(self.unit, i, filter);
		
				local _, _,_,  count , spelltype , duration , expirationtime , unitcaster , stealable ,_ , spellid = UnitBuff(unit,i)
				--applied time is critical for cooprating with combatlog
				local appliedtime
				if(spellid)then
					if(expirationtime and duration)then
						--get a applied time with 2 decimal, should be the same as the 'NPA-time stamp' of combatlog event 'add aura'
						appliedtime=floor((expirationtime-duration)*100)/100
					else
						appliedtime=nil
					end
					if(duration==0 and expirationtime==0)then
						duration=NPA_Forever
						expirationtime=NPA_EndTime
					end
					local index,updated=NPA_Aura_SortAura(auralist, spellid, UnitGUID(unitcaster or ""), count , appliedtime,expirationtime,"BUFF",spelltype,stealable)
					updatelist[index]=true
					if(updated)then
						doupdate=true
					end
				end
				i=i+1
			until(not spellid)
			--seek every debuff on unit
			local i=1
			repeat
				--name, rank, icon , count , bufftype , duration , expirationtime , unitcaster , isstealable , shouldconsolidate , spellid = UnitBuff(unit,i)
				local name, _,_,  count , spelltype , duration , expirationtime , unitcaster , stealable ,_ , spellid = UnitDebuff(unit,i)
				local appliedtime
				if(spellid)then
					if(expirationtime and duration)then
						--get a applied time with 2 decimal, should be the same as the 'NPA-time stamp' of combatlog event 'add aura'
						--turns out they're different slightly, awkward...
						appliedtime=floor((expirationtime-duration)*100)/100
					else
						appliedtime=nil
					end
					if(duration==0 and expirationtime==0)then
						duration=NPA_Forever
						expirationtime=NPA_EndTime
					end
					local index,updated=NPA_Aura_SortAura(auralist, spellid, UnitGUID(unitcaster or ""), count , appliedtime,expirationtime,"DEBUFF",spelltype,stealable)
					updatelist[index]=true
					if(updated)then
						doupdate=true
					end
				end
				i=i+1
			until(not spellid)
			--disable which are not updated
			for i=1,table_getn(auralist)do
				if(auralist[i].SpellId and (not updatelist[i]))then
					auralist[i].SpellId=nil
					--removing which not updated is also an update
					doupdate=true
				end
			end
			if(doupdate==true)then
				--when there is an update
				--fire a event
				NPA_EventHandler_FireEvent(7,"Aura_Updated",unitdata)
			end
		end)
		--get 'any' event then filter it locally
		NPA.DataCollector.RegisterCombatLogEvent("Any","DataCollector_Aura",function(arg,_,destunitdata)
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
			if(NPA_Aura_CombatLogEventFilter[arg[2]] and arg[4] and arg[8] and arg[12])then
				--run the pointed function
				NPA_Aura_CombatLogEventFunc[NPA_Aura_CombatLogEventFilter[arg[2]]](destunitdata,arg[1],arg[4],arg[12],arg[16],arg[15],arg)
				--fire event
				NPA_EventHandler_FireEvent(7,"Aura_Updated",destunitdata)
			end
		end)
	end,
	function()
		--unregister events
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_Aura",nil)
		NPA.DataCollector.RegisterCombatLogEvent("Any","DataCollector_Aura",nil)
	end
	--no data transfer as frame-based won't get any aura
	)
