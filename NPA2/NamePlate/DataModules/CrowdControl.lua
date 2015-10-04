-- Author      : Nogarder
-- Create Date : 2013/5/29 16:46:47
local pairs=pairs
local table_getn=table.getn
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements

local NPA_IconGroupManager_ClearIconGroup=NPA.IconGroupManager.ClearIconGroup
local NPA_IconGroupManager_InsertIcon=NPA.IconGroupManager.InsertIcon
local NPA_IconGroupManager_UpdateGroup=NPA.IconGroupManager.UpdateGroup
local NPA_SpellInfo_GetSpellInfo=NPA.SpellInfo.GetSpellInfo
--filter cache
local NPA_IconGroup_FilterCache={}
--
NPA.NamePlateModuleManager.RegisterDataModule("IconGroup","CrowdControl",function(framedata,icongroup,setting)
	--build filtercache
	if(not NPA_IconGroup_FilterCache[framedata])then
		NPA_IconGroup_FilterCache[framedata]={}
	end
	local filtercache=NPA_IconGroup_FilterCache[framedata]
	--add event elements
 	--name update
	NPA_NamePlateDataParser_AddElements(framedata,icongroup,"Aura_Updated",function(framedata,unitdata)
		local auras=unitdata.Aura
		if(auras)then
			icongroup:Show()
			--clear
			NPA_IconGroupManager_ClearIconGroup(icongroup)
			local spelllist={}
			local playerguid=UnitGUID("player")
			local j=0
			for i=1,table_getn(auras)do
				local aura=auras[i]
				--filters
				if(aura.SpellId)then
					local spellinfo=NPA_SpellInfo_GetSpellInfo(aura.SpellId)
					if(spellinfo.PVPDRType and spellinfo.PVPDRType~="None")then
						for _,rule in pairs(setting.DataRules)do
							--from type filter
							if(rule.FromType==1 or (rule.FromType==2 and aura.CasterGUID==playerguid))then
								--aura filter
								if((rule.FilterType==1 and aura.Sort=="Buff") or --buff
									(rule.FilterType==2 and aura.Sort=="Debuff") or --debuff
										(rule.FilterType==3 and rule.SpellList[aura.SpellId]==true) or --spell list
											(rule.FilterType==4 and rule.SchoolList[aura.SpellType]==true) or	--school list
												(rule.FilterType==5) --everything
									)then
										--same aura could match multiple rules, using the one which has higher priority
										--not exist or has lower priority
										if(not spelllist[i] or spelllist[i].Priority<rule.Priority)then
											--check exists
											local matched
											for index=1,j do
												local cc=spelllist[index].Aura
												local spellinfo2=NPA_SpellInfo_GetSpellInfo(cc.SpellId)
												if(spellinfo.PVPDRType==spellinfo2.PVPDRType)then
													if(cc.ExpirationTime<aura.ExpirationTime)then --only overwritten when lasts longer
														spelllist[index].Aura=aura
														spelllist[index].Rule=rule
													end
													matched=true
													break
												end
											end
											if(matched~=true)then
												j=j+1
												spelllist[j]={Aura=aura,Rule=rule}
											end
										end
									end
							end
						end
					end
				end
			end
			--insert icons
			for index,spelldata in pairs(spelllist)do
				local aura=spelldata.Aura
				local rule=spelldata.Rule
				--NPA.IconGroupManager.InsertIcon=function(icongroup,starttime,endtime,spellid,maxstack,iconsetting)
				NPA_IconGroupManager_InsertIcon(icongroup,aura.AppliedTime,aura.ExpirationTime,aura.SpellId,aura.SpellType,aura.Count,0,rule)
			end
			--insert aura
			--force an update
			NPA_IconGroupManager_UpdateGroup(icongroup)
		else
			icongroup:Hide()
		end
	end)
end)
