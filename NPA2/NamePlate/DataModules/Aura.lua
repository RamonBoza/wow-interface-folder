-- Author      : Nogarder
-- Create Date : 2013/4/2 13:50:27
local table_getn=table.getn
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements

local NPA_IconGroupManager_ClearIconGroup=NPA.IconGroupManager.ClearIconGroup
local NPA_IconGroupManager_InsertIcon=NPA.IconGroupManager.InsertIcon
local NPA_IconGroupManager_UpdateGroup=NPA.IconGroupManager.UpdateGroup

local NPA_SpellInfo_GetSpellInfo=NPA.SpellInfo.GetSpellInfo

--filter cache
local NPA_IconGroup_FilterCache={}
--
NPA.NamePlateModuleManager.RegisterDataModule("IconGroup","Aura",function(framedata,icongroup,setting)
	--build filtercache
	if(not NPA_IconGroup_FilterCache[framedata])then
		NPA_IconGroup_FilterCache[framedata]={}
	end
	local filtercache=NPA_IconGroup_FilterCache[framedata]
	--add event elements
	--this should speed it up, or not?
	local FilterFunction={
		[1]=function(aura)
			return aura.Sort=="BUFF"--buff
		end,
		[2]=function(aura)
			return aura.Sort=="DEBUFF" --debuff
		end,
		[3]=function(aura,rule)
			return rule.SpellList[aura.SpellId]==true --spell list
		end,
		[4]=function(aura,rule)
			return rule.SchoolList[aura.SpellType]==true--school list
		end,
		[5]=function()
			return true --all
		end,
		[6]=function(aura)
			return aura.Stealable --stealable
		end
	}
 	--name update
	NPA_NamePlateDataParser_AddElements(framedata,icongroup,"Aura_Updated",function(framedata,unitdata)
		local auras=unitdata.Aura
		if(auras)then
			icongroup:Show()
			--clear
			NPA_IconGroupManager_ClearIconGroup(icongroup)
			local spelllist={}
			local playerguid=UnitGUID("player")
			for i=1,table_getn(auras)do
				local aura=auras[i]
				--filters
				if(aura.SpellId)then
					for _,rule in pairs(setting.DataRules)do
						--from type filter
						if(rule.FromType==1 or (rule.FromType==2 and aura.CasterGUID==playerguid))then
							--aura filter
							if(FilterFunction[rule.FilterType](aura,rule))then
								--same aura could match multiple rules, using the one which has higher priority
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
				local aura=auras[index]
				--NPA.IconGroupManager.InsertIcon=function(icongroup,starttime,endtime,spellid,maxstack,iconsetting)
				NPA_IconGroupManager_InsertIcon(icongroup,aura.AppliedTime,aura.ExpirationTime,aura.SpellId,aura.SpellType,aura.Count,NPA_SpellInfo_GetSpellInfo(aura.SpellId).MaxStack,rule)
			end
			--insert aura
			--force an update
			NPA_IconGroupManager_UpdateGroup(icongroup)
		else
			icongroup:Hide()
		end
	end)
end)
