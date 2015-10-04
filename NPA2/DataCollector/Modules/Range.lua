-- Author      : Nogarder
-- Create Date : 2015/1/7 20:43:37
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Range",
	function()
		local HarmfulCheckList={}
		local HelpfulCheckList={}
		--
		local wipe=wipe
		local MapScale=0
		local UnitPosition=UnitPosition
		local table_insert=table.insert
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		local NPA_GetTime=NPA.GetTime
		--
		local IsSpellInRange=IsSpellInRange
		local IsHarmfulSpell=IsHarmfulSpell
		local IsHelpfulSpell=IsHelpfulSpell
		local SpellHasRange=SpellHasRange
		local IsSpellKnown=IsSpellKnown
		local CheckInteractDistance=CheckInteractDistance
		local floor=floor
		--on collect event
		--
		NPA.EventHandler.RegisterEvent(0,"SPELLS_CHANGED","DataCollector_Range",function()
			wipe(HarmfulCheckList)
			wipe(HelpfulCheckList)
			local _,_,startindex,count=GetSpellTabInfo(2)
			local maxindex=count+startindex+1
			local index=startindex
			local _,spellid=GetSpellBookItemInfo(index, "player")
			while(spellid and index<maxindex)do
				local name, _, _, _, minRange, maxRange = GetSpellInfo(spellid)
				local name2=GetSpellInfo(name)
				if(name~=name2)then
					name, _, _, _, minRange, maxRange = GetSpellInfo(name)
				end
				if(name and SpellHasRange(name) and  IsSpellKnown(spellid))then
					local isharmful=IsHarmfulSpell(name)
					if(isharmful and maxRange==0)then
						maxRange=5 --melee
					end
					if(minRange and maxRange and maxRange>0)then
						local list
						if(isharmful)then
							list=HarmfulCheckList
						else
							list=HelpfulCheckList
						end
						table_insert(list,{
							Name=name,
							Min=minRange,
							Max=maxRange
						})
					end
				end
				index=index+1
				_,spellid=GetSpellBookItemInfo(index, "player")
			end
		end)
		local HardCheck=function(unit)
			local far=100
			local close=0
			local list
			if(UnitCanAttack("player", unit))then
				list=HarmfulCheckList
			else
				list=HelpfulCheckList
			end
			--
			for _,spell in pairs(list)do
				if(IsSpellInRange(spell.Name,unit)==1)then
					if(close<spell.Min)then
						close=spell.Min
					end
					if(far>spell.Max)then
						far=spell.Max
					end
				end
			end

			for _,spell in pairs(list) do
				if(IsSpellInRange(spell.Name,unit)==0)then
					if(close>=spell.Min and far>=spell.Max and close<=spell.Max)then
						close=spell.Max
					elseif(close<=spell.Min and far>=spell.Max)then
						close=spell.Max
					elseif(close<=spell.Min and far<=spell.Max and far>=spell.Min)then
						far=spell.Min
					end
				end
			end
			--also use range check
			--CheckInteractDistance
			--Number - A value from 1 to 4:
			--1 = Inspect, 28 yards
			--2 = Trade, 11.11 yards
			--3 = Duel, 9.9 yards
			--4 = Follow, 28 yards
			if(CheckInteractDistance(unit,3))then
				if(far>10)then
					far=10
				end
				if(close>10)then
					close=10
				end
			else
				if(close<10)then
					close=10
				end
				if(far<10)then
					far=10
				end
			end
			if(CheckInteractDistance(unit,2))then
				if(far>11)then
					far=11
				end
				if(close>11)then
					close=11
				end
			else
				if(close<11)then
					close=11
				end
				if(far<11)then
					far=11
				end
			end
			if(CheckInteractDistance(unit,4))then
				if(far>28)then
					far=28
				end
				if(close>28)then
					close=28
				end
			else
				if(close<28)then
					close=28
				end
				if(far<28)then
					far=28
				end
			end
			--
			return far,close
		end
		--
		NPA.EventHandler.RegisterEvent(2,"DataCollector_Collectable_OnUpdate","DataCollector_Range",function(unit,unitdata,nTime)
			local exact,close,far
			local x,y=UnitPosition(unit)
			if(x and y and (x~=0 or y~=0))then
				local px,py=UnitPosition("player")
				exact=floor(((px-x)^2+(py-y)^2)^0.5)
				close=exact
				far=exact
			else
				exact=0
				far,close=HardCheck(unit)
			end
			--
			unitdata.RangeClose=close
			unitdata.RangeFar=far
			unitdata.RangeExact=exact
			unitdata.RangeUpdated=nTime
			NPA_EventHandler_FireEvent(7,"Range_Updated",unitdata)
		end)
		--
		NPA.EventHandler.RegisterEvent(1,"NamePlate_ModuleMain_OnUpdate","DataCollector_Range",function(framedata)
			if(framedata.GUID)then
				local updated=framedata.UnitData.RangeUpdated
				if(updated and NPA_GetTime()-updated>1)then
					framedata.UnitData.RangeUpdated=nil
					NPA_EventHandler_FireEvent(7,"Range_Updated",framedata.UnitData)
				end
			end
		end)
	end,
	function()
		--unregister events
		NPA.EventHandler.RegisterEvent(0,"SPELLS_CHANGED","DataCollector_Range",nil)
		NPA.EventHandler.RegisterEvent(2,"DataCollector_Collectable_OnUpdate","DataCollector_Range",nil)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_ModuleMain_OnUpdate","DataCollector_Range",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function(unitdata,frameunitdata)
		--do nothing now
		--unitdata.Speed=nil
	end
	)
