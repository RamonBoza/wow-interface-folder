-- Author      : Nogarder
-- Create Date : 2013/4/17 13:19:01
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("SpellLock",
	function()
		--global 
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		local NPA_SpellInfo_GetSpellInfo=NPA.SpellInfo.GetSpellInfo
		--combatlog event
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_INTERRUPT","DataCollector_SpellLock",function(arg,sourceunitdata,destunitdata)
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
			--[15]=locked spellid
			--[16]=locked spell name
			--[17]=locked spell school

			--if no data using 4
			local locklength
			if(arg[12])then --sometime the caster is not known
				locklength=NPA_SpellInfo_GetSpellInfo(arg[12]).CounterSpellLength or 4
			else
				locklength=4
			end
			--
			if(not destunitdata.SpellLock)then
				destunitdata.SpellLock={}
			end

			destunitdata.SpellLock[17]=arg[1]+locklength
			--fire event
			NPA_EventHandler_FireEvent(7,"SpellLock_Updated",destunitdata)
		end)
	end,
	function()
		--unregister events
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_INTERRUPT","DataCollector_SpellLock",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	--frame-based won't get any data so dont do transfer
	function()
		--
		--do nothing
	end
	)

