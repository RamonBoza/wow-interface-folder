-- Author      : Nogarder
-- Create Date : 2014/2/20 15:01:45
local table_getn=table.getn
local table_insert=table.insert
local next=next
local UnitGUID=UnitGUID
local UnitExists=UnitExists
local string_find=string.find
local string_sub=string.sub
local tonumber=tonumber
local NPA_GetTime=NPA.GetTime
--
NPA.ConditionChecker={}
---
local ConditionCheckerAnyDefault=function(ConditionList,EventRegister,updatefunc,settings)
	if(next(ConditionList["Any"]) or next(ConditionList["Default"]))then
		EventRegister("BaseEvent_PreOnShow",function(prioritylist,framedata)
			--reset everything
			for index,_ in pairs(prioritylist) do
				prioritylist[index]=false
			end
			--set any
			local dlist=ConditionList["Any"]
			for i=1,table_getn(dlist)do
				local index=dlist[i]
				prioritylist[index]=true
			end
			--set default
			local dlist=ConditionList["Default"]
			for i=1,table_getn(dlist) do
				local index=dlist[i]
				prioritylist[index]=-1
			end
			--
			--update
			updatefunc(framedata,prioritylist)
		end)
	else
		EventRegister("BaseEvent_PreOnShow",function(prioritylist,framedata)
			--just reset everything
			for index,_ in pairs(prioritylist) do
				prioritylist[index]=false
			end
		end)
	end
end
--
local ConditionCheckerQuest=function(ConditionList,EventRegister,updatefunc,settings)
	local list=ConditionList["Quest"]
	if(next(list))then
		EventRegister("Quest_Updated",function(prioritylist,framedata)
			--
			local data=framedata.QuestData
			local updated
			if(data)then
				for i=1,table_getn(list)do
					local index=list[i]
					if(not prioritylist[index])then
						prioritylist[index]=true
						updated=true
					end
				end
			else
				for i=1,table_getn(list)do
					local index=list[i]
					if(prioritylist[index])then
						prioritylist[index]=false
						updated=true
					end
				end
			end
			if(updated)then
				updatefunc(framedata,prioritylist)
			end
		end)
	end
end
--
local ConditionCheckerName=function(ConditionList,EventRegister,updatefunc,settings)
	if(next(ConditionList["Name"]) or next(ConditionList["PartName"]))then
		EventRegister("Name_Updated",function(prioritylist,framedata)
			--
			local name=framedata.UnitData.Name
			if(not name)then
				return
			end
			--
			local update
			--name check
			local dlist=ConditionList["Name"]
			for i=1,table_getn(dlist)do
				local index=dlist[i]
				--check priority
				local setting=settings[index]
				if(not prioritylist[index] and name==setting.Arg)then
					prioritylist[index]=true
					update=true
				elseif(prioritylist[index] and name~=setting.Arg)then
					prioritylist[index]=false
					update=true
				end
			end
			--part name check
			local dlist=ConditionList["PartName"]
			for i=1,table_getn(dlist)do
				local index=dlist[i]
				--check priority
				local setting=settings[index]
				local found=string_find(name,setting.Arg)
				if(not prioritylist[index] and found)then
					prioritylist[index]=true
					update=true
				elseif(prioritylist[index] and not found)then
					prioritylist[index]=false
					update=true
				end
			end
			--
			if(update)then
				updatefunc(framedata,prioritylist)
			end
		end)
	end
end
--
local ConditionCheckerUnitID=function(ConditionList,EventRegister,updatefunc,settings)
	local list=ConditionList["UnitID"]
	if(next(list))then
		EventRegister("UnitID_Updated",function(prioritylist,framedata)
			--
			local unitid=framedata.UnitData.UnitID
			if(not unitid)then
				return
			end
			--
			local update
			--check
			for i=1,table_getn(list)do
				local index=list[i]
				--check priority
				local setting=settings[index]
				if(not prioritylist[index] and name==setting.Arg)then
					prioritylist[index]=true
					update=true
				elseif(prioritylist[index] and name~=setting.Arg)then
					prioritylist[index]=false
					update=true
				end
			end
			--
			if(update)then
				updatefunc(framedata,prioritylist)
			end
		end)
	end
end
--
local ConditionCheckerSummoned=function(ConditionList,EventRegister,updatefunc,settings)
	local list=ConditionList["Summoned"]
	if(next(list))then
		EventRegister("Summoned_Updated",function(prioritylist,framedata)
			--filter out sometime the sourceunitdata is not avaliable
			if(not framedata.UnitData.SummonedByUnitData)then
				return
			end
			--
			local update
			--check summoned
			local sourcefaction=framedata.UnitData.SummonedByUnitData.Faction
			for i=1,table_getn(list)do
				local index=list[i]
				--check priority
				local setting=settings[index]
				if(prioritylist[index]==nil and tonumber(setting.Arg)==sourcefaction)then
					prioritylist[index]=true
					update=true
				elseif(prioritylist[index]~=nil and tonumber(setting.Arg)~=sourcefaction)then
					prioritylist[index]=false
					update=true
				end
			end
			--
			if(update)then
				updatefunc(framedata,prioritylist)
			end
		end)
	end
end
local ConditionCheckerType=function(ConditionList,EventRegister,updatefunc,settings)
	if(next(ConditionList["Player"]) or next(ConditionList["NonPlayer"]) or next(ConditionList["RaidList"]) or next(ConditionList["Pet"])
		or next(ConditionList["PartyList"]) or next(ConditionList["GuildList"]) or next(ConditionList["RaidList"]) or next(ConditionList["Guardian"]))then
			EventRegister("Type_Updated",function(prioritylist,framedata)
				--
				local update
				--check faction
				local faction=framedata.UnitData.Faction
				local atype=framedata.UnitData.Type
				--data.Type nil=unknow, 1=player,2=npc, 3=pet, 4=guardian
				if(atype==1)then --1=player
					local dlist=ConditionList["Player"]
					for i=1,table_getn(dlist)do
						local index=dlist[i]
						--check priority
						local setting=settings[index]
						--faction, 1=friendly,2=neutral,3=hostile
						if(not prioritylist[index] and tonumber(setting.Arg)==faction)then
							prioritylist[index]=true
							update=true
						elseif(prioritylist[index] and tonumber(setting.Arg)~=faction)then
							prioritylist[index]=false
							update=true
						end
					end
				elseif(atype==3)then --3=pet
					local dlist=ConditionList["Pet"]
					for i=1,table_getn(dlist)do
						local index=dlist[i]
						--check priority
						local setting=settings[index]
						--faction, 1=friendly,2=neutral,3=hostile
						if(not prioritylist[index] and tonumber(setting.Arg)==faction)then
							prioritylist[index]=true
							update=true
						elseif(prioritylist[index] and tonumber(setting.Arg)~=faction)then
							prioritylist[index]=false
							update=true
						end
					end
				elseif(atype==4)then --4=guardian
					local dlist=ConditionList["Guardian"]
					for i=1,table_getn(dlist)do
						local index=dlist[i]
						--check priority
						local setting=settings[index]
						--faction, 1=friendly,2=neutral,3=hostile
						if(not prioritylist[index] and tonumber(setting.Arg)==faction)then
							prioritylist[index]=true
							update=true
						elseif(prioritylist[index] and tonumber(setting.Arg)~=faction)then
							prioritylist[index]=nil
							update=true
						end
					end
				else --other non-player
					local dlist=ConditionList["NonPlayer"]
					for i=1,table_getn(dlist)do
						local index=dlist[i]
						--check priority
						local setting=settings[index]
						--faction, 1=friendly,2=neutral,3=hostile
						if(not prioritylist[index] and tonumber(setting.Arg)==faction)then
							prioritylist[index]=true
							update=true
						elseif(prioritylist[index] and tonumber(setting.Arg)~=faction)then
							prioritylist[index]=false
							update=true
						end
					end
				end

				--check friendlist
				--data.Type nil=unknow, 1=player,2=npc, 3=pet, 4=guardian
				--faction, 1=friendly,2=neutral,3=hostile
				if(faction==1 and atype==1)then
					local name=framedata.Name
					--
					local lists=NPA.FriendsList
					--friend list
					if(lists.FriendList[name]==true)then --same faction and is player and in friendlist
						local dlist=ConditionList["FriendList"]
						for i=1,table_getn(dlist)do
							local index=dlist[i]
							--check priority
							if(not prioritylist[index])then
								prioritylist[index]=true
								update=true
							elseif(prioritylist[index])then
								prioritylist[index]=false
								update=true
							end
						end
					end
					--guildlist
					if(lists.GuildList[name]==true)then --same faction and is player and in friendlist
						local dlist=ConditionList["GuildList"]
						for i=1,table_getn(dlist)do
							local index=dlist[i]
							--check priority
							if(not prioritylist[index])then
								prioritylist[index]=true
								update=true
							elseif(prioritylist[index])then
								prioritylist[index]=false
								update=true
							end
						end
					end
					--partylist
					if(lists.PartyList[name]==true)then --same faction and is player and in friendlist
						local dlist=ConditionList["PartyList"]
						for i=1,table_getn(dlist)do
							local index=dlist[i]
							if(not prioritylist[index])then
								prioritylist[index]=true
								update=true
							elseif(prioritylist[index])then
								prioritylist[index]=false
								update=true
							end
						end
					end
					--raid list
					if(lists.RaidList[name]==true)then --same faction and is player and in friendlist
						local dlist=ConditionList["RaidList"]
						for i=1,table_getn(dlist)do
							local index=dlist[i]
							--check priority
							if(not prioritylist[index])then
								prioritylist[index]=true
								update=true
							elseif(prioritylist[index])then
								prioritylist[index]=nil
								update=true
							end
						end
					end
				end
				--
				if(update)then
					updatefunc(framedata,prioritylist)
				end
			end)
		end
end
--
local ConditionCheckerTargeting=function(ConditionList,EventRegister,updatefunc,settings)
	local list=ConditionList["Target"]
	if(next(list))then
		EventRegister("BaseEvent_OnUpdate",function(prioritylist,framedata)
			--
			local guid=framedata.GUID
			if(not guid)then
				return
			end
			--
			local update
			for i=1,table_getn(list)do
				local index=list[i]
				--check priority
				local setting=settings[index]
				local check=UnitExists(setting.Arg) and (setting.Arg=="Any" or guid==UnitGUID(setting.Arg))
				if(not prioritylist[index] and check)then
					prioritylist[index]=true
					update=true
				elseif(prioritylist[index] and not check)then
					prioritylist[index]=false
					update=true
				end
			end
			--
			if(update)then
				updatefunc(framedata,prioritylist)
			end
		end)
	end
end
--
local ConditionCheckerAura=function(ConditionList,EventRegister,updatefunc,settings)
	if(next(ConditionList["WithAura"]) or next(ConditionList["WithoutAura"]))then
		EventRegister("BaseEvent_OnUpdate",function(prioritylist,framedata)
			--
			local auralist=framedata.UnitData.Aura
			if(not auralist)then
				return
			end
			--
			local update
			local nTime=NPA_GetTime()
			--check with list
			local dlist=ConditionList["WithAura"]
			for i=1,table_getn(dlist)do
				local index=dlist[i]
				local setting=settings[index]
				local spellid=tonumber(setting.Arg)
				local checked
				for i=1,table_getn(auralist)do
					--check with list
					if(auralist[i].SpellId==spellid and auralist[i].ExpirationTime>nTime)then
						checked=true
						break
					end
				end
				if(checked and not prioritylist[index])then
					prioritylist[index]=true
					update=true
				elseif(not checked and prioritylist[index])then
					prioritylist[index]=false
					update=true
				end
			end
			--check without list , just the revers version of with
			local dlist=ConditionList["WithoutAura"]
			for i=1,table_getn(dlist)do
				local index=dlist[i]
				local setting=settings[index]
				local checked
				local spellid=tonumber(setting.Arg)
				for i=1,table_getn(auralist)do
					--check with list
					if(auralist[i].SpellId==spellid and auralist[i].ExpirationTime>nTime)then
						checked=true
						break
					end
				end
				if(not checked and not prioritylist[index])then
					prioritylist[index]=true
					update=true
				elseif(checked and prioritylist[index])then
					prioritylist[index]=false
					update=true
				end
			end
			--
			if(update)then
				updatefunc(framedata,prioritylist)
			end
		end)
	end
end
--
local ConditionCheckerHealth=function(ConditionList,EventRegister,updatefunc,settings)
	if(next(ConditionList["HealthMore"]) or next(ConditionList["HealthLess"]))then
		EventRegister("Health_Updated",function(prioritylist,framedata)
			--
			local unitdata=framedata.UnitData
			if(not unitdata.HealthMax or not unitdata.Health)then
				return
			end
			--
			local healthpercent=unitdata.Health/unitdata.HealthMax
			--check "more" condition
			local dlist=ConditionList["HealthMore"]
			for i=1,table_getn(dlist)do
				local index=dlist[i]
				local setting=settings[index]
				local checked
				--check with list
				if(healthpercent>=tonumber(setting.Arg)/100)then
					checked=true
				end
				if(checked and not prioritylist[index])then
					prioritylist[index]=true
					update=true
				elseif(not checked and prioritylist[index])then
					prioritylist[index]=false
					update=true
				end
			end
			--check "less" condition
			local dlist=ConditionList["HealthLess"]
			for i=1,table_getn(dlist)do
				local index=dlist[i]
				local setting=settings[index]
				local checked
				--check with list
				if(healthpercent<=tonumber(setting.Arg)/100)then
					checked=true
				end
				if(checked and not prioritylist[index])then
					prioritylist[index]=true
					update=true
				elseif(not checked and prioritylist[index])then
					prioritylist[index]=false
					update=true
				end
			end
			--
			if(update)then
				updatefunc(framedata,prioritylist)
			end
		end)
	end
end
--
local ConditionCheckerCoolDown=function(ConditionList,EventRegister,updatefunc,settings)
	if(next(ConditionList["WithCoolDown"]) or next(ConditionList["WithoutCoolDown"]))then
		EventRegister("CoolDown_Updated",function(prioritylist,framedata)
			--
			local auralist=framedata.UnitData.CoolDown
			if(not auralist)then
				return
			end
			--
			local nTime=NPA_GetTime()
			--check with list
			local dlist=ConditionList["WithCoolDown"]
			for i=1,table_getn(dlist)do
				local index=dlist[i]
				local setting=settings[index]
				local checked
				local spellid=tonumber(setting.Arg)
				for i=1,table_getn(auralist)do
					--check with list
					if(auralist[i].SpellId==spellid and auralist[i].ExpirationTime>nTime)then
						checked=true
						break
					end
				end
				if(checked and not prioritylist[index])then
					prioritylist[index]=true
					update=true
				elseif(not checked and prioritylist[index])then
					prioritylist[index]=false
					update=true
				end
			end
			--check without list , just the revers version of with
			local dlist=ConditionList["WithoutCoolDown"]
			for i=1,table_getn(dlist)do
				local index=dlist[i]
				local setting=settings[index]
				local spellid=tonumber(setting.Arg)
				local checked
				for i=1,table_getn(auralist)do
					--check without list
					if(auralist[i].SpellId==spellid and auralist[i].ExpirationTime>nTime)then
						checked=true
						break
					end
				end
				if(not checked and prioritylist[index])then
					prioritylist[index]=true
					update=true
				elseif(checked and not prioritylist[index])then
					prioritylist[index]=false
					update=true
				end
			end
			--
			if(update)then
				updatefunc(framedata,prioritylist)
			end
		end)
	end
end
---
local ConditionCheckerTapped=function(ConditionList,EventRegister,updatefunc,settings)
	local list=ConditionList["Tapped"]
	if(next(list))then
		EventRegister("Tapped_Updated",function(prioritylist,framedata)
			--
			local update
			--check
			local tapped=framedata.UnitData.Tapped
			for i=1,table_getn(list)do
				local index=list[i]
				--check priority
				local setting=settings[index]
				if(not prioritylist[index] and tapped)then
					prioritylist[index]=true
					update=true
				elseif(prioritylist[index] and not tapped)then
					prioritylist[index]=false
					update=true
				end
			end
			--
			if(update)then
				updatefunc(framedata,prioritylist)
			end
		end)
	end
end
--
local ConditionCheckerGuild=function(ConditionList,EventRegister,updatefunc,settings)
	local list=ConditionList["Guild"]
	if(next(list))then
		EventRegister("Guild_Updated",function(prioritylist,framedata)
			--
			local guild=framedata.UnitData.Guild
			if(not guild)then
				return
			end
			--
			local update
			--name check
			for i=1,table_getn(list)do
				local index=list[i]
				--check priority
				local setting=settings[index]
				local checked=(guild==setting.Arg)
				if(not prioritylist[index] and checked)then
					prioritylist[index]=true
					update=true
				elseif(prioritylist[index] and not checked)then
					prioritylist[index]=false
					update=true
				end
			end
			--
			if(update)then
				updatefunc(framedata,prioritylist)
			end
		end)
	end
end
--
local ConditionCheckerNPCGuild=function(ConditionList,EventRegister,updatefunc,settings)
	local list=ConditionList["NPCGuild"]
	if(next(list))then
		EventRegister("NPCGuild_Updated",function(prioritylist,framedata)
			--
			local guild=framedata.UnitData.NPCGuild
			if(not guild)then
				return
			end
			--
			local update
			--name check
			for i=1,table_getn(list)do
				local index=list[i]
				--check priority
				local setting=settings[index]
				local checked=(guild==setting.Arg)
				if(not prioritylist[index] and checked)then
					prioritylist[index]=true
					update=true
				elseif(prioritylist[index] and not checked)then
					prioritylist[index]=false
					update=true
				end
			end
			--
			if(update)then
				updatefunc(framedata,prioritylist)
			end
		end)
	end
end
--
local ConditionCheckerRole=function(ConditionList,EventRegister,updatefunc,settings)
	local list=ConditionList["Role"]
	if(next(list))then
		EventRegister("Role_Updated",function(prioritylist,framedata)
			--
			local role=framedata.UnitData.Role
			if(not role)then
				return
			end
			--
			local update
			--name check
			for i=1,table_getn(list)do
				local index=list[i]
				--check priority
				local setting=settings[index]
				local checked=(role==setting.Arg)
				if(not prioritylist[index] and checked)then
					prioritylist[index]=true
					update=true
				elseif(prioritylist[index] and not checked)then
					prioritylist[index]=false
					update=true
				end
			end
			--
			if(update)then
				updatefunc(framedata,prioritylist)
			end
		end)
	end
end
--
local ConditionCheckerClassification=function(ConditionList,EventRegister,updatefunc,settings)
	local list=ConditionList["Classification"]
	if(next(list))then
		EventRegister("Classification_Updated",function(prioritylist,framedata)
			--
			local classification=framedata.UnitData.Classification
			if(not classification)then
				return
			end
			--
			local update
			--name check
			for i=1,table_getn(list)do
				local index=list[i]
				--check priority
				local setting=settings[index]
				local checked=(classification==setting.Arg)
				if(not prioritylist[index] and checked)then
					prioritylist[index]=true
					update=true
				elseif(prioritylist[index] and not checked)then
					prioritylist[index]=false
					update=true
				end
			end
			--
			if(update)then
				updatefunc(framedata,prioritylist)
			end
		end)
	end
end
--
local ConditionCheckerThreat=function(ConditionList,EventRegister,updatefunc,settings)
	local list=ConditionList["Threat"]
	if(next(list))then
		EventRegister("Threat_Updated",function(prioritylist,framedata)
			--
			local threat=framedata.UnitData.ThreatStatus
			if(not threat)then
				return
			end
			--
			local update
			--name check
			for i=1,table_getn(list)do
				local index=list[i]
				--check priority
				local setting=settings[index]
				local checked=(threat==setting.Arg)
				if(not prioritylist[index] and checked)then
					prioritylist[index]=true
					update=true
				elseif(prioritylist[index] and not checked)then
					prioritylist[index]=false
					update=true
				end
			end
			--
			if(update)then
				updatefunc(framedata,prioritylist)
			end
		end)
	end
end
--
local ConditionCheckerCasting=function(ConditionList,EventRegister,updatefunc,settings)
	if(next(ConditionList["Casting"]) or next(ConditionList["NotCasting"]))then
		EventRegister("Casting_Updated",function(prioritylist,framedata)
			--
			local update
			--not casting
			local castinfo=framedata.UnitData.CastInfo
			if(not castinfo or not castinfo.EndTime)then
				--not casting =true
				local dlist=ConditionList["NotCasting"]
				for i=1,table_getn(dlist)do
					local index=dlist[i]
					if(not prioritylist[index])then
						prioritylist[index]=true
						update=true
					end
				end
				--casting = false
				local dlist=ConditionList["Casting"]
				for i=1,table_getn(dlist)do
					local index=dlist[i]
					if(prioritylist[index] )then
						prioritylist[index]=false
						update=true
					end
				end
			else
				--casting
				--not casting =false
				local dlist=ConditionList["NotCasting"]
				for i=1,table_getn(dlist)do
					local index=dlist[i]
					if(prioritylist[index])then
						prioritylist[index]=false
						update=true
					end
				end
				--check casting with target
				local targetguid=framedata.UnitData.TargetGUID
				local dlist=ConditionList["Casting"]
				for i=1,table_getn(dlist)do
					local index=dlist[i]
					--check priority
					local setting=settings[index]
					local checked=(setting.Arg=="Any" or (UnitExists(setting.Arg) and (targetguid==nil or targetguid==UnitGUID(setting.Arg))))
					if(not prioritylist[index] and checked)then
						prioritylist[index]=true
						update=true
					elseif(prioritylist[index] and not checked)then
						prioritylist[index]=false
						update=true
					end
				end
				--
			end
			if(update)then
				updatefunc(framedata,prioritylist)
			end
		end)
	end
end
--shield
local ConditionCheckerShield=function(ConditionList,EventRegister,updatefunc,settings)
	if(next(ConditionList["ShieldMore"]) or next(ConditionList["ShieldLess"]))then
		EventRegister("Shield_Updated",function(prioritylist,framedata)
			local unitdata=framedata.UnitData
			local shieldpercent=(unitdata.Shield or 0)/unitdata.HealthMax
			--check "more" condition
			local dlist=ConditionList["ShieldMore"]
			for i=1,table_getn(dlist)do
				local index=dlist[i]
				local setting=settings[index]
				local checked
				--check with list
				if(shieldpercent>=tonumber(setting.Arg)/100)then
					checked=true
				end
				if(checked and not prioritylist[index])then
					prioritylist[index]=true
					update=true
				elseif(not checked and prioritylist[index])then
					prioritylist[index]=false
					update=true
				end
			end
			--check "less" condition
			local dlist=ConditionList["ShieldLess"]
			for i=1,table_getn(dlist)do
				local index=dlist[i]
				local setting=settings[index]
				local checked
				--check with list
				if(shieldpercent<=tonumber(setting.Arg)/100)then
					checked=true
				end
				if(checked and not prioritylist[index])then
					prioritylist[index]=true
					update=true
				elseif(not checked and prioritylist[index])then
					prioritylist[index]=false
					update=true
				end
			end
			--
			if(update)then
				updatefunc(framedata,prioritylist)
			end
		end)
	end
end
--range
local ConditionCheckerRange=function(ConditionList,EventRegister,updatefunc,settings)
	if(next(ConditionList["RangeMore"]) or next(ConditionList["RangeLess"]))then
		EventRegister("Range_Updated",function(prioritylist,framedata)
			local unitdata=framedata.UnitData
			local updated=unitdata.RangeUpdated
			local far
			local close
			if(not updated or NPA_GetTime()-updated>1)then
				far=100
				close=0
			else
				far=unitdata.RangeFar or 100
				close=unitdata.RangeClose or 0
			end
			--check "more" condition
			local dlist=ConditionList["RangeMore"]
			for i=1,table_getn(dlist)do
				local index=dlist[i]
				local setting=settings[index]
				local checked
				--check with list
				if(close>=tonumber(setting.Arg))then
					checked=true
				end
				if(checked and not prioritylist[index])then
					prioritylist[index]=true
					update=true
				elseif(not checked and prioritylist[index])then
					prioritylist[index]=false
					update=true
				end
			end
			--check "less" condition
			local dlist=ConditionList["RangeLess"]
			for i=1,table_getn(dlist)do
				local index=dlist[i]
				local setting=settings[index]
				local checked
				--check with list
				if(far<=tonumber(setting.Arg))then
					checked=true
				end
				if(checked and not prioritylist[index])then
					prioritylist[index]=true
					update=true
				elseif(not checked and prioritylist[index])then
					prioritylist[index]=false
					update=true
				end
			end
			--
			if(update)then
				updatefunc(framedata,prioritylist)
			end
		end)
	end
end
--
local ConditionCheckerFunc={
	["Any"]=ConditionCheckerAnyDefault,
	["Default"]=ConditionCheckerAnyDefault,
	--
	["Quest"]=ConditionCheckerQuest,
	--
	["Name"]=ConditionCheckerName,
	["PartName"]=ConditionCheckerName,
	--
	["UnitID"]=ConditionCheckerUnitID,
	--
	["Summoned"]=ConditionCheckerSummoned,
	--
	["Player"]=ConditionCheckerType,
	["NonPlayer"]=ConditionCheckerType,
	["Pet"]=ConditionCheckerType,
	["Guardian"]=ConditionCheckerType,
	["FriendList"]=ConditionCheckerType,
	["GuildList"]=ConditionCheckerType,
	["PartyList"]=ConditionCheckerType,
	["RaidList"]=ConditionCheckerType,
	--
	["Target"]=ConditionCheckerTargeting,
	--
	["WithAura"]=ConditionCheckerAura,
	["WithoutAura"]=ConditionCheckerAura,
	--
	["HealthMore"]=ConditionCheckerHealth,
	["HealthLess"]=ConditionCheckerHealth,
	--
	["WithCoolDown"]=ConditionCheckerCoolDown,
	["WithoutCoolDown"]=ConditionCheckerCoolDown,
	--
	["Tapped"]=ConditionCheckerTapped,
	--
	["Guild"]=ConditionCheckerGuild,
	--
	["NPCGuild"]=ConditionCheckerNPCGuild,
	--
	["Role"]=ConditionCheckerRole,
	--
	["Classification"]=ConditionCheckerClassification,
	["Threat"]=ConditionCheckerThreat,
	["Casting"]=ConditionCheckerCasting,
	["NotCasting"]=ConditionCheckerCasting,
	--
	["ShieldMore"]=ConditionCheckerShield,
	["ShieldLess"]=ConditionCheckerShield,
	--
	["RangeMore"]=ConditionCheckerRange,
	["RangeLess"]=ConditionCheckerRange,
}

NPA.ConditionChecker.BuildConditionList=function(settings,EventRegister,updatefunc,noreset)
	local ConditionList={}
	ConditionList["Any"]={}
	ConditionList["Default"]={}
	ConditionList["Quest"]={}
	ConditionList["Name"]={}
	ConditionList["PartName"]={}
	ConditionList["UnitID"]={}
	ConditionList["Summoned"]={}
	ConditionList["Player"]={}
	ConditionList["NonPlayer"]={}
	ConditionList["Target"]={}
	ConditionList["WithAura"]={}
	ConditionList["WithoutAura"]={}
	ConditionList["HealthMore"]={}
	ConditionList["HealthLess"]={}
	ConditionList["WithCoolDown"]={}
	ConditionList["WithoutCoolDown"]={}
	ConditionList["Tapped"]={}
	ConditionList["Guild"]={}
	ConditionList["NPCGuild"]={}
	ConditionList["Pet"]={}
	ConditionList["Guardian"]={}
	ConditionList["FriendList"]={}
	ConditionList["GuildList"]={}
	ConditionList["PartyList"]={}
	ConditionList["RaidList"]={}
	ConditionList["Role"]={}
	ConditionList["Classification"]={}
	ConditionList["Casting"]={}
	ConditionList["NotCasting"]={}
	ConditionList["ShieldMore"]={}
	ConditionList["ShieldLess"]={}
	ConditionList["RangeMore"]={}
	ConditionList["RangeLess"]={}
	
	local count=table_getn(settings)
	--add event elements
 	for i=1,count do
		local setting=settings[i]
		if(not ConditionList[setting.ConditionType])then
			ConditionList[setting.ConditionType]={}
		end
		local list=ConditionList[setting.ConditionType]
		table_insert(list,i)
	end

	for name,list in pairs(ConditionList)do
		local	func=ConditionCheckerFunc[name]
		if(func)then
			func(ConditionList,EventRegister,updatefunc,settings)
		end
	end
end
