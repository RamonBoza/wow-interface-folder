-- Author      : Nogarder
-- Create Date : 2012/3/16 19:50:16
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Casting",
	function()
		local NPA_GetTime=NPA.GetTime
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		local InstantAsOneSecondCast=NPA_Setting.Core.InstantAsOneSecondCast
		--
		local UnitGUID=UnitGUID
		local UnitExists=UnitExists
		local floor=floor
		local NPA_Forever=NPA.Forever
		--main --using local for speed
		local NPA_SpellInfo_GetSpellInfo=NPA.SpellInfo.GetSpellInfo
		local NPA_SpellInfo_GetCastInfo=NPA.SpellInfo.GetCastInfo
		local NPA_SpellInfo_SpellIconToSchool=NPA.SpellInfo.SpellIconToSchool
		--hook default
		--blizzard castbar now shows even if not current target
		--using this with combatlog may cause some sychnorizition problem but that's ok
		--on default show
		NPA.EventHandler.RegisterEvent(1,"NamePlate_CastBar_OnShow","DataCollector_Casting",function(framedata,value,_,max)
			local unitdata=framedata.UnitData
			if(not unitdata.CastInfo)then
				unitdata.CastInfo={}
			end
			local castinfo=unitdata.CastInfo
			local time=NPA_GetTime()
			--
			castinfo.EndTime=time+max
			castinfo.StartTime=time
			castinfo.InstantAsOneSecondCast=false
			--check channeling
			if(value==0)then
				castinfo.Channeling=nil
			else
				castinfo.Channeling=true
			end
			--check shield
			if(framedata.Default.CastBarShield:IsShown())then
				castinfo.NoInterrupt=true
			else
				castinfo.NoInterrupt=nil
			end
			--using default icon
			castinfo.Icon=framedata.Default.SpellIcon:GetTexture()
			castinfo.School=castinfo.School or NPA_SpellInfo_SpellIconToSchool(castinfo.Icon)
			--fire a event for casting update
			NPA_EventHandler_FireEvent(8,"Casting_Updated",framedata)
		end)
		--on default hide
		NPA.EventHandler.RegisterEvent(1,"NamePlate_CastBar_OnHide","DataCollector_Casting",function(framedata,value,min,max)
			--check exists
			if(not framedata.UnitData.CastInfo)then
				return
			end
			--clear end time only if value reaches limit, or else it's not finished
			if(value==min or value==max)then
				framedata.UnitData.CastInfo.EndTime=nil
				framedata.UnitData.CastInfo.InstantAsOneSecondCast=false
				--fire event
				NPA_EventHandler_FireEvent(8,"Casting_Updated",framedata)
			end
		end)
		--on update, check shield
		NPA.EventHandler.RegisterEvent(1,"NamePlate_CastBar_OnUpdate","DataCollector_Casting",function(framedata,value,min,max)
			local unitdata=framedata.UnitData
			--check exists
			if(not unitdata.CastInfo)then
				unitdata.CastInfo={}
			end
			--
			if(framedata.Default.CastBarShield:IsShown() and (not unitdata.CastInfo.NoInterrupt))then
				unitdata.CastInfo.NoInterrupt=true
				--only fire event when status changes
				NPA_EventHandler_FireEvent(8,"Casting_Updated",framedata)
			elseif((not framedata.Default.CastBarShield:IsShown()) and unitdata.CastInfo.NoInterrupt)then
				unitdata.CastInfo.NoInterrupt=nil
				--only fire event when status changes
				NPA_EventHandler_FireEvent(8,"Casting_Updated",framedata)
			end
			--update cast time
			if((value==min or value==max) and framedata.UnitData.CastInfo.EndTime)then
				framedata.UnitData.CastInfo.EndTime=nil
				framedata.UnitData.CastInfo.InstantAsOneSecondCast=false
				--fire event
				NPA_EventHandler_FireEvent(8,"Casting_Updated",framedata)
			elseif(framedata.UnitData.CastInfo.EndTime==nil)then
				local time=NPA_GetTime()
				unitdata.CastInfo.EndTime=time+max-value
				unitdata.CastInfo.StartTime=time+min-value
				unitdata.CastInfo.InstantAsOneSecondCast=false
				NPA_EventHandler_FireEvent(8,"Casting_Updated",framedata)
			end
			--it's not instant as one second
			if(unitdata.CastInfo.InstantAsOneSecondCast)then
				unitdata.CastInfo.InstantAsOneSecondCast=false
				NPA_EventHandler_FireEvent(8,"Casting_Updated",framedata)
			end
			--check school
			local school=NPA_SpellInfo_SpellIconToSchool(unitdata.CastInfo.Icon)
			if(school and unitdata.CastInfo.School~=school)then
				unitdata.CastInfo.School=school
				NPA_EventHandler_FireEvent(8,"Casting_Updated",framedata)
			end
		end)
		--macro for check spell effect
		--don't use these now
		--local NPA_Casting_CheckCastStop=function(arg,sourceunitdata)
		--	--[1]=timestamp
		--	--[2]=event
		--	--[3]=hidecaster
		--	--[4]=sourceGUID
		--	--[5]=srouceName
		--	--[6]=sourceFlags
		--	--[7]=sourceFlags2
		--	--[8]=destGUID
		--	--[9]=destName
		--	--[10]=destFlags
		--	--[11]=destFlags2
		--	--[12]=spellid
		--	--[13]=spellname
		--	--[14]=spellschool
		--	--sometime without a casterguid, just ignore it
		--	--also ignore if unitdata not exists
		--	if((not arg[4]) or (not sourceunitdata))then
		--		return
		--	end
		--	--get castinfo
		--	local castinfo=sourceunitdata.CastInfo
		--	--check cast info
		--	--check it a little loosy for haste effect or flying projectile
		--	if(info and info.Spellid==arg[12] and info.EndTime==arg[1])then
		--		--it's logged spell finished casting, end it
		--		info.EndTime=nil
		--		info.InstantAsOneSecondCast=false
		--		--fire the event
		--		NPA_EventHandler_FireEvent(7,"Casting_Updated",sourceunitdata)
		--	end
		--	--anything else, just ignore it	
		--end
		-------on update event
		--unit,unitdata
		--this have to be check every updates, because stun/moving effect doesn't fire any event about casting
		--so rely on only events would miss some interrupt ,which is critical in pvp
		NPA.EventHandler.RegisterEvent(2,"DataCollector_Collectable_OnUpdate","DataCollector_Casting",function(unit,unitdata)
			-- name,icon,starttime,endtime,nointerrupt,channeling = NPA_SpellInfo_GetCastInfo(unit)
			local name,icon,starttime,endtime ,nointerrupt,channeling = NPA_SpellInfo_GetCastInfo(unit)
			--check data
			if(not unitdata.CastInfo)then
				unitdata.CastInfo={}
			end
			local info=unitdata.CastInfo
			--check for changes
			if(not name and not info.EndTime)then
				--no casting in both data, do nothing
				return
			elseif(not name and info.EndTime)then
				if(not info.InstantAsOneSecondCast)then
					--instant as one second cast
					--no spell is casting, but has data, change data to nothing
					info.EndTime=nil
				end
				--fire event
				NPA_EventHandler_FireEvent(7,"Casting_Updated",unitdata)
			elseif(info.StartTime~=starttime)then
				--start time not match means whole new spell is casting
				--casting status changes
				info.Name=name
				info.Icon=icon
				info.StartTime=starttime or 0
				info.EndTime=endtime or NPA_Forever
				info.Channeling=channeling
				info.NoInterrupt=nointerrupt
				info.School=nil
				info.InstantAsOneSecondCast=false
				--fire event
				NPA_EventHandler_FireEvent(7,"Casting_Updated",unitdata)
			elseif(info.StartTime~=starttime or info.EndTime~=endtime or info.Name~=name or info.Channeling~=channeling or info.NoInterrupt~=nointerrupt)then
				--times match but details not, update them
				--also update endtime , info from combatlog don't have actual endtime
				info.Name=name
				info.Icon=icon
				info.StartTime=starttime or 0
				info.EndTime=endtime or NPA_Forever
				info.Channeling=channeling
				info.NoInterrupt=nointerrupt
				info.InstantAsOneSecondCast=false
				--info.School= school is aquired in combat log event
				--also fire event
				NPA_EventHandler_FireEvent(7,"Casting_Updated",unitdata)
			end
		end)

		--still have to use this to get spell color
		--using combatlog event
		--start casting
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_CAST_START","DataCollector_Casting",function(arg,sourceunitdata,destunitdata)
			--[1]=timestamp
			--[2]=event
			--[3]=hidecaster
			--[4]=sourceGUID
			--[5]=srouceName
			--[6]=sourceFlags
			--[7]=sourceFlags2
			--[8]=destGUID
			--[9]=destName
			--[10]=destFlags
			--[11]=destFlags2
			--[12]=spellid
			--[13]=spellname
			--[14]=spellschool
			--sometime without a casterguid, just ignore it
			--also ignore if unitdata not exists
			if((not arg[4]) or (not sourceunitdata))then
				return
			end
			--get cast info
			if(not sourceunitdata.CastInfo)then
				sourceunitdata.CastInfo={}
			end
			local info=sourceunitdata.CastInfo
			--check cast info
			if(info.StartTime==arg[1])then
				--unit event get to it first ( it may not be possible but just in case )
				--make up what it doesn't have
				info.Spellid=arg[12]
				info.School=arg[14]
				info.TargetGUID=arg[8] --sometime this is nil, but it's ok
			else
				--name,icon,cost,powertype,casttime,school,minrange,maxrange=SpellInfo(spellid)
				--unit event didn't get it yet, or may never get to it, write it over
				--still use combatlog school in case spellinfo collection is turned off for performance
				local spelldata=NPA_SpellInfo_GetSpellInfo(arg[12])
				info.Name=spelldata.Name
				info.Icon=spelldata.Icon
				info.StartTime=arg[1]
				info.Channeling=nil
				info.NoInterrupt=nil
				info.Target=destunitdata
				info.School=arg[14]
				info.Spellid=arg[12]
				--instant as one second cast
				if(InstantAsOneSecondCast and spelldata.CastTime==0)then
					info.InstantAsOneSecondCast=true
					info.EndTime=arg[1]+1 --instant as one second cast
				else
					info.InstantAsOneSecondCast=false
					info.EndTime=arg[1]+spelldata.CastTime	 --assume its endtime
				end
			end
			--fire a event anyway
			NPA_EventHandler_FireEvent(7,"Casting_Updated",sourceunitdata)
		end)
		--cast success, mostly for instant cast
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_CAST_SUCCESS","DataCollector_Casting",function(arg,sourceunitdata,destunitdata)
			--[1]=timestamp
			--[2]=event
			--[3]=hidecaster
			--[4]=sourceGUID
			--[5]=srouceName
			--[6]=sourceFlags
			--[7]=sourceFlags2
			--[8]=destGUID
			--[9]=destName
			--[10]=destFlags
			--[11]=destFlags2
			--[12]=spellid
			--[13]=spellname
			--[14]=spellschool
			--sometime without a casterguid, just ignore it
			--also ignore if unitdata not exists
			if((not arg[4]) or (not sourceunitdata))then
				return
			end
			--get cast info
			if(not sourceunitdata.CastInfo)then
				sourceunitdata.CastInfo={}
			end
			local info=sourceunitdata.CastInfo
			--check cast info
			if(info.EndTime and info.EndTime>=arg[1])then
				--it's logged spell finished casting , fill in the blanks
				info.Spellid=arg[12]
				info.School=arg[14]
				info.TargetGUID=arg[8] --sometime this is nil, but it's ok
			else
				--name,icon,cost,powertype,casttime,school,minrange,maxrange=NPA_SpellInfo_GetSpellInfo(spellid)
				--it's new, probablly instant cast
				--still use combatlog school in case spellinfo collection is turned off for performance
				local spelldata=NPA_SpellInfo_GetSpellInfo(arg[12])
				info.Name=spelldata.Name
				info.Icon=spelldata.Icon
				info.StartTime=arg[1]-spelldata.CastTime -- guess it's started before and ended now
				info.EndTime=arg[1]-- end at current time
				info.Channeling=nil
				info.NoInterrupt=nil
				info.Target=destunitdata
				info.School=arg[14]
				info.Spellid=arg[12]
				--instant as one second cast
				if(InstantAsOneSecondCast and spelldata.CastTime==0)then
					info.InstantAsOneSecondCast=true
				else
					info.InstantAsOneSecondCast=false
				end
			end
			--fire a event anyway
			NPA_EventHandler_FireEvent(7,"Casting_Updated",sourceunitdata)
		end)
		--cast fail, stop casting
		--only happen to player, don't use it
--		NPA.DataCollector.RegisterCombatLogEvent("SPELL_CAST_FAILED","DataCollector_Casting",function(arg,sourceunitdata)
--			--[1]=timestamp
--			--[2]=event
--			--[3]=hidecaster
--			--[4]=sourceGUID
--			--[5]=srouceName
--			--[6]=sourceFlags
--			--[7]=sourceFlags2
--			--[8]=destGUID
--			--[9]=destName
--			--[10]=destFlags
--			--[11]=destFlags2
--			--[12]=spellid
--			--[13]=spellname
--			--[14]=spellschool

--			--sometime without a casterguid, just ignore it
--			--also ignore if unitdata not exists
--			if((not arg[4]) or (not sourceunitdata))then
--				return
--			end
--			--get cast info
--			local info=sourceunitdata.CastInfo
--			--check cast info
--			if(info and info.EndTime and info.EndTime>=arg[1])then
--				--it's logged spell failed casting ,set end time to nil
--				sourceunitdata.CastInfo.EndTime=nil
--				sourceunitdata.CastInfo.InstantAsOneSecondCast=false
--				--fire a event,also return fail reason
--				NPA_EventHandler_FireEvent(7,"Casting_Updated",sourceunitdata)
--			end
--			--anything else, just ignore
--		end)

		--interrupt, it always stop casting
		--NPA.DataCollector.RegisterCombatLogEvent("SPELL_INTERRUPT","DataCollector_Casting",function(arg,sourceunitdata)
		--	--[1]=timestamp
		--	--[2]=event
		--	--[3]=hidecaster
		--	--[4]=sourceGUID
		--	--[5]=srouceName
		--	--[6]=sourceFlags
		--	--[7]=sourceFlags2
		--	--[8]=destGUID
		--	--[9]=destName
		--	--[10]=destFlags
		--	--[11]=destFlags2
		--	--[12]=spellid
		--	--[13]=spellname
		--	--[14]=spellschool
		--	--sometime without a casterguid, just ignore it
		--	--also ignore if unitdata not exists
		--	if((not arg[4]) or (not sourceunitdata))then
		--		return
		--	end
		--	--just clear castinfo, interrupting is handled by certain module directly
		--	if(sourceunitdata.CastInfo)then
		--		sourceunitdata.CastInfo.EndTime=nil
		--		sourceunitdata.CastInfo.InstantAsOneSecondCast=false
		--	end
		--	--this event won't misfire, so always fire a event for it
		--	NPA_EventHandler_FireEvent(7,"Casting_Updated",sourceunitdata)
		--end)
		--miss,damage, and heal, check it with current castinfo ,to stop casting which should be stoped
		--check it with macro
		--don't use these now
		--NPA.DataCollector.RegisterCombatLogEvent("SPELL_MISS","DataCollector_Casting",NPA_Casting_CheckCastStop)
		--NPA.DataCollector.RegisterCombatLogEvent("SPELL_DAMAGE","DataCollector_Casting",NPA_Casting_CheckCastStop)
		--NPA.DataCollector.RegisterCombatLogEvent("SPELL_HEAL","DataCollector_Casting",NPA_Casting_CheckCastStop)
	end,
	function()
		--unregister events
		NPA.EventHandler.RegisterEvent(1,"NamePlate_CastBar_OnShow","DataCollector_Casting",nil)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_CastBar_OnUpdate","DataCollector_Casting",nil)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_CastBar_OnHide","DataCollector_Casting",nil)
		----
		NPA.EventHandler.RegisterEvent(2,"DataCollector_Collectable_OnUpdate","DataCollector_Casting",nil)
		--datacollector combatlog event
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_CAST_START","DataCollector_Casting",nil)
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_CAST_SUCCESS","DataCollector_Casting",nil)
		--NPA.DataCollector.RegisterCombatLogEvent("SPELL_INTERRUPT","DataCollector_Casting",nil)
		--NPA.DataCollector.RegisterCombatLogEvent("SPELL_MISS","DataCollector_Casting",nil)
		--NPA.DataCollector.RegisterCombatLogEvent("SPELL_DAMAGE","DataCollector_Casting",nil)
		--NPA.DataCollector.RegisterCombatLogEvent("SPELL_HEAL","DataCollector_Casting",nil)
		--these are not used , their range should be covered in combatlog event
		--NPA.EventHandler.RegisterEvent(0,"UNIT_SPELLCAST_CHANNEL_START","DataCollector_Casting",nil)
		--NPA.EventHandler.RegisterEvent(0,"UNIT_SPELLCAST_CHANNEL_STOP","DataCollector_Casting",nil)
		--NPA.EventHandler.RegisterEvent(0,"UNIT_SPELLCAST_CHANNEL_UPDATE","DataCollector_Casting",nil)
		--NPA.EventHandler.RegisterEvent(0,"UNIT_SPELLCAST_DELAYED","DataCollector_Casting",nil)
		--NPA.EventHandler.RegisterEvent(0,"UNIT_SPELLCAST_INTERRUPTED","DataCollector_Casting",nil)
		--NPA.EventHandler.RegisterEvent(0,"UNIT_SPELLCAST_INTERRUPTIBLE","DataCollector_Casting",nil)
		--NPA.EventHandler.RegisterEvent(0,"UNIT_SPELLCAST_NOT_INTERRUPTIBLE","DataCollector_Casting",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	--don't transfer data now , it's handled realtime in update functions
	function(unitdata,frameunitdata)
		if(frameunitdata.CastInfo and frameunitdata.CastInfo.EndTime)then
			if(not unitdata.CastInfo)then
				unitdata.CastInfo={}
			end

			unitdata.CastInfo.EndTime=frameunitdata.CastInfo.EndTime
			unitdata.CastInfo.InstantAsOneSecondCast=false
			unitdata.CastInfo.Channeling=frameunitdata.CastInfo.Channeling
			unitdata.CastInfo.NoInterrupt=frameunitdata.CastInfo.NoInterrupt
			unitdata.CastInfo.Icon=frameunitdata.CastInfo.Icon
		end
	end
	)

