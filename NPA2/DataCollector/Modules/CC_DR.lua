-- Author      : Nogarder
-- Create Date : 2013/5/4 15:05:06
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
local CC_DRTimer
NPA.DataCollector.RegisterModule("CC_DR",
	function()
		--global
		local UnitGUID=UnitGUID
		local table_insert=table.insert
		local table_getn=table.getn
		local floor=floor
		local NPA_Timer_AddTimer=NPA.Timer.AddTimer
		local NPA_Timer_RemoveTimer=NPA.Timer.RemoveTimer
		--main --using local for speed
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		local NPA_SpellInfo_GetSpellInfo=NPA.SpellInfo.GetSpellInfo
		local NPA_DataCollector_GetUnitDataByGUID=NPA.DataCollector.GetUnitDataByGUID
		local NPA_GetTime=NPA.GetTime
		local NPA_CC_DR_Length=18
		--

		local NPA_CC_DR_Check=function(unitdata)
			local nTime=NPA_GetTime()
			local cclist=unitdata.CC_DR
			for i=1,table_getn(cclist) do
				local cc=cclist[i]
				if(cc.EndTime<nTime)then
					--fire fake combat log event
					NPA_EventHandler_FireEvent(9,"CC_DR_ENDED",unitdata,cc.SpellId,cc.PVPDRType)
					--
					cc.SpellId=nil
				end
			end
		end
		--create or show timer
		if(not CC_DRTimer)then
			CC_DRTimer=NPA.Timer.CreateTimer(function(unitdata)
				NPA_CC_DR_Check(unitdata)
				NPA_EventHandler_FireEvent(7,"CC_DR_Updated",unitdata)
			end)
		else
			CC_DRTimer:Show()
		end
		--macro for insert cc to data base on unitbuff/unitdebuff
		
		--local index=NPA_CC_DR_SortCC_DR(destunitdata.CC_DR, spellid, casterguid, appliedtime,endtime,spelldata.PVPDRType,sort,spelldata.SpellType)
		local NPA_CC_DR_SortCC_DR=function(cclist, spellid, casterguid, appliedtime,endtime,drtype,sort,spelltype)
			local max=table_getn(cclist)
			--check data
			for i=1,max do
				local cc=cclist[i]
				--check with applied time
				if(cc.PVPDRType==drtype)then
					--already exists ,check time
					if(cc.EndTime<appliedtime)then
						--out of time, new one
						cc.SpellId=spellid
						cc.CasterGUID=casterguid
						cc.EndTime=endtime
						cc.AppliedTime=appliedtime
						cc.Count=1
						cc.Sort=sort
						cc.SpellType=spelltype
						return i
					else
						--add it to the old one
						--1=1/2, 2=1/4, 3=immune
						cc.Count=cc.Count+1
						cc.CasterGUID=casterguid
						cc.EndTime=endtime
						cc.AppliedTime=appliedtime
						cc.Sort=sort
						cc.SpellType=spelltype
						return i
					end
				end
			end
			--not exists, try use a unused data slot
			for i=1,max do
				local cc=cclist[i]
				if(cc.SpellId==nil)then
					cc.SpellId=spellid
					cc.CasterGUID=casterguid
					cc.EndTime=endtime
					cc.AppliedTime=appliedtime
					cc.Count=1
					cc.PVPDRType=drtype
					cc.Sort=sort
					cc.SpellType=spelltype
					return i
				end
			end
			--all used ,insert a new one
			local i=max+1
			cclist[i]={
				SpellId=spellid,
				CasterGUID=casterguid,
				EndTime=endtime,
				AppliedTime=appliedtime,
				Count=1,
				PVPDRType=drtype,
				Sort=sort,
				SpellType=spelltype
			}
			return i
		end
		--combatlog event filter
		local NPA_CC_DR_CombatLogEventFilter={
			["SPELL_AURA_REMOVED"]=true, 
			--it turns out that broken would also trigger remove, so dont need these 2
			--["SPELL_AURA_BROKEN"]=true, --count as remove
			--["SPELL_AURA_BROKEN_SPELL"]=true, --count as remove
			["SPELL_STOLEN"]=true, --count as remove
			["SPELL_DISPEL"]=true, --count as remove
		}
		--
		--combatlog event functions
		local NPA_CC_DR_CombatLogEventFunc=function(destunitdata,appliedtime,casterguid,spellid,sort)
			--create a data set if there isn't one
			if(not destunitdata.CC_DR)then
				destunitdata.CC_DR={}
			end
			--
			local spelldata=NPA_SpellInfo_GetSpellInfo(spellid)
			if(spelldata.PVPDRType and spelldata.PVPDRType~="None" and spelldata.NoDR==false)then
				local endtime=appliedtime+NPA_CC_DR_Length
				--sort it
				local index=NPA_CC_DR_SortCC_DR(destunitdata.CC_DR, spellid, casterguid, appliedtime,endtime,spelldata.PVPDRType,sort,spelldata.SpellType)
				NPA_Timer_AddTimer(CC_DRTimer,destunitdata,index,endtime)
				--fake combat  log event
				NPA_EventHandler_FireEvent(9,"CC_DR_STARTED",destunitdata,spellid,spelldata.PVPDRType,destunitdata.CC_DR[index].Count)
			end
		end
		--get 'any' event then filter it locally
		NPA.DataCollector.RegisterCombatLogEvent("Any","DataCollector_CC_DR",function(arg,_,destunitdata)
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
			if(NPA_CC_DR_CombatLogEventFilter[arg[2]] and arg[12] and destunitdata)then
				--run event function
				NPA_CC_DR_CombatLogEventFunc(destunitdata,arg[1],arg[4],arg[12],arg[15])
				--fire event
				NPA_EventHandler_FireEvent(7,"CC_DR_Updated",destunitdata)
			end
		end)
	end,
	function()
		--hide timer
		if(CC_DRTimer)then
			CC_DRTimer:Hide()
		end
		--unregister events
		NPA.DataCollector.RegisterCombatLogEvent("Any","DataCollector_CC_DR",nil)
	end
	--no data transfer as frame-based won't get any cc
	)
