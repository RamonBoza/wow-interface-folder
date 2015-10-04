-- Author      : Nogarder
-- Create Date : 2012/3/31 12:48:47

-----------------------------------------------------------------------------------------
--blizzard use 2 different type of timestamp (i've no idea why)
-----------------------------------------------------------------------------------------
--when use UnitCastingInfo(), the time (either start or end) it gives is 
--identical to gettime()*1000  (integer) ,which is 'the computer's OS's up time'
------------------------------------------------------------------------------------------
--and in combatlog event, the timestamp is comparable to time() with decimal places
--which is a form of the current time (like 3:15 PM)
-----------------------------------------------------------------------------------------
--and time() only return interger without decimal,
--thus there's no way to translate from one to another
--those times just ain't comparable
-----------------------------------------------------------------------------------------
--but there's another thing,
--for example ,when a event "SPELL_CAST_START" is fired,
--use GetTime() in COMBAT_LOG_EVENT_UNFILTERED would get a cast start time,
--at anytime later (long as the casting is not finished), use UnitCastingInfo on the unit, can get a casting start time,
--these two times are same up to 2 decimal places,
--which could mean there're no delay between system-built-in-events and addon-events,
---------
--i.e. if a spell is being casted
--in combatlog event may have GetTime()=10.12
--using UnitCastingInfo would have a StartTime=10121
--it can be translated by floor(time/10)/100, into 10.12
--then they match exactly, this is very usful to decide if the spell get from combatlog is the very same spell UnitCastingInfo returns
-----------------------------------------------------------------------------------------
--anyway, in combatlog, replace timestamp with GetTime(), it works surpresingly well XD
-------------------------------------------------------------------------------------------
--about healing changed in 6.0
--healing arg[18]=critical arg[19]=multistrike
--
--SpellDamage(timestamp, eventtype, srcGUID, srcName, srcFlags,srcFlags2 dstGUID, dstName, dstFlags,dstFlags2	-- 1-11
--	spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed 12-20
--critical, glancing, crushing, isOffHand, multistrike)
----combat event handler
--register a combat event handler into main event handler
local NPA_GetTime=NPA.GetTime
local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
--using one fixed table should speed it up
local arg={
	[1]=1,
	[2]=1,
	[3]=1,
	[4]=1,
	[5]=1,
	[6]=1,
	[7]=1,
	[8]=1,
	[9]=1,
	[10]=1,
	[11]=1,
	[12]=1,
	[13]=1,
	[14]=1,
	[15]=1,
	[16]=1,
	[17]=1,
	[18]=1,
	[19]=1,
	[20]=1,
	[21]=1,
	[22]=1,
	[23]=1,
	[24]=1,
	[25]=1,
}
NPA.EventHandler.RegisterEvent(0,"COMBAT_LOG_EVENT_UNFILTERED","EventHandler",function(_,event,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12,arg13,arg14,arg15,arg16,arg17,arg18,arg19,arg20,arg21,arg22,arg23,arg24,arg25)
	--wrapping data
	arg[1]=NPA_GetTime() --override timestamp with gettime
	arg[2]=event
	arg[3]=arg3
	arg[4]=arg4
	arg[5]=arg5
	arg[6]=arg6
	arg[7]=arg7
	arg[8]=arg8
	arg[9]=arg9
	arg[10]=arg10
	arg[11]=arg11
	arg[12]=arg12
	arg[13]=arg13
	arg[14]=arg14
	arg[15]=arg15
	arg[16]=arg16
	arg[17]=arg17
	arg[18]=arg18
	arg[19]=arg19
	arg[20]=arg20
	arg[21]=arg21
	arg[22]=arg22
	arg[23]=arg23
	arg[24]=arg24
	arg[25]=arg25
	--refire it with wrapped data
	NPA_EventHandler_FireEvent(5,event,arg)
end)

