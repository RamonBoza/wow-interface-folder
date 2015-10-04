-- Author      : Nogarder
-- Create Date : 2013/5/29 16:28:40
local pairs=pairs
local table_getn=table.getn
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements

local NPA_IconGroupManager_ClearIconGroup=NPA.IconGroupManager.ClearIconGroup
local NPA_IconGroupManager_InsertIcon=NPA.IconGroupManager.InsertIcon
local NPA_IconGroupManager_UpdateGroup=NPA.IconGroupManager.UpdateGroup

--filter cache
local NPA_IconGroup_FilterCache={}
--
NPA.NamePlateModuleManager.RegisterDataModule("IconGroup","CC_DR",function(framedata,icongroup,setting)
	--build filtercache
	if(not NPA_IconGroup_FilterCache[framedata])then
		NPA_IconGroup_FilterCache[framedata]={}
	end
	local filtercache=NPA_IconGroup_FilterCache[framedata]
	--add event elements
 	--name update
	NPA_NamePlateDataParser_AddElements(framedata,icongroup,"CC_DR_Updated",function(framedata,unitdata)
		local ccdrs=unitdata.CC_DR
		if(ccdrs)then
			icongroup:Show()
			--clear
			NPA_IconGroupManager_ClearIconGroup(icongroup)
			local spelllist={}
			local playerguid=UnitGUID("player")
			for i=1,table_getn(ccdrs) do
				local ccdr=ccdrs[i]
				--filters
				if(ccdr.SpellId)then
					for _,rule in pairs(setting.DataRules) do
						--from type filter
						if(rule.FromType==1 or (rule.FromType==2 and ccdr.CasterGUID==playerguid))then
							--ccdr filter
							if((rule.FilterType==1 and ccdr.Sort=="BUFF") or --buff
								(rule.FilterType==2 and ccdr.Sort=="DEBUFF") or --debuff
								(rule.FilterType==3 and rule.SpellList[ccdr.SpellId]==true) or --spell list
								(rule.FilterType==4 and rule.SchoolList[ccdr.SpellType]==true) or --school list
								(rule.FilterType==5)--all
							)then
								--same ccdr could match multiple rules, using the one which has higher priority
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
				local ccdr=ccdrs[index]
				--NPA.IconGroupManager.InsertIcon=function(icongroup,starttime,endtime,spellid,maxstack,iconsetting)
				local extrainfo
				if(ccdr.Count==1)then
					extrainfo="1/2"
				elseif(ccdr.Count==2)then
					extrainfo="1/4"
				else
					extrainfo="X"
				end
				NPA_IconGroupManager_InsertIcon(icongroup,ccdr.AppliedTime,ccdr.EndTime,ccdr.SpellId,ccdr.SpellType,ccdr.Count,4,rule,extrainfo)
			end
			--insert ccdr
			--force an update
			NPA_IconGroupManager_UpdateGroup(icongroup)
		else
			icongroup:Hide()
		end
	end)
end)
