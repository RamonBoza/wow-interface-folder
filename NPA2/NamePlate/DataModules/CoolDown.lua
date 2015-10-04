-- Author      : Nogarder
-- Create Date : 2013/5/6 17:19:17
local table_getn=table.getn
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements

local NPA_IconGroupManager_ClearIconGroup=NPA.IconGroupManager.ClearIconGroup
local NPA_IconGroupManager_InsertIcon=NPA.IconGroupManager.InsertIcon
local NPA_IconGroupManager_UpdateGroup=NPA.IconGroupManager.UpdateGroup
local NPA_SpellInfo_GetSpellInfo=NPA.SpellInfo.GetSpellInfo
--filter cache
local NPA_IconGroup_FilterCache={}

--
NPA.NamePlateModuleManager.RegisterDataModule("IconGroup","CoolDown",function(framedata,icongroup,setting)
	icongroup.DivideCount=true
	--build filtercache
	if(not NPA_IconGroup_FilterCache[framedata])then
		NPA_IconGroup_FilterCache[framedata]={}
	end
	local filtercache=NPA_IconGroup_FilterCache[framedata]
	--
	local FilterFunction={
		[1]=function(cooldown)
			return cooldown.Sort=="BUFF"--buff
		end,
		[2]=function(cooldown)
			return cooldown.Sort=="DEBUFF" --debuff
		end,
		[3]=function(cooldown,rule)
			return rule.SpellList[cooldown.SpellId]==true --spell list
		end,
		[4]=function(cooldown,rule)
			return rule.SchoolList[cooldown.SpellType]==true--school list
		end,
		[5]=function()
			return true --all
		end,
		[6]=function(cooldown)
			return cooldown.Stealable --stealable
		end
	}
	--add event elements
 	--name update
	NPA_NamePlateDataParser_AddElements(framedata,icongroup,"CoolDown_Updated",function(framedata,unitdata)
		local cooldowns=unitdata.CoolDown
		if(cooldowns)then
			icongroup:Show()
			--clear
			NPA_IconGroupManager_ClearIconGroup(icongroup)
			local spelllist={}
			local playerguid=UnitGUID("player")
			for i=1,table_getn(cooldowns)do
				local cooldown=cooldowns[i]
				--filters
				if(cooldown.SpellId)then
					for _,rule in pairs(setting.DataRules)do
						--from type filter
						if(rule.FromType==1 or (rule.FromType==2 and cooldown.CasterGUID==playerguid))then
							--cooldown filter
							if(FilterFunction[rule.FilterType](cooldown,rule))then
								--same cooldown could match multiple rules, using the one which has higher priority
								--not exist or has lower priority
								if(not spelllist[i] or spelllist[i].Priority<rule.Priority)then
									spelllist[i]=rule
								end
							end
						end
					end
				end
			end
			--insert icons
			for index,rule in pairs(spelllist)do
				local cooldown=cooldowns[index]
				--NPA.IconGroupManager.InsertIcon=function(icongroup,starttime,endtime,spellid,maxstack,iconsetting)
				NPA_IconGroupManager_InsertIcon(icongroup,cooldown.AppliedTime,cooldown.EndTime,cooldown.SpellId,cooldown.SpellType,cooldown.Count,NPA_SpellInfo_GetSpellInfo(cooldown.SpellId).CoolDownStack,rule)
			end
			--insert cooldown
			--force an update
			NPA_IconGroupManager_UpdateGroup(icongroup)
		else
			icongroup:Hide()
		end
	end)
end)
