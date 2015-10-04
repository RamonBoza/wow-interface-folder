-- Author      : Nogarder
-- Create Date : 2012/3/20 4:16:40
local GetSpellInfo=GetSpellInfo
local floor=floor
local strfind=string.find
local tonumber=tonumber
local UnitIsplayer=UnitIsPlayer
--main
local NPA_GetTime=NPA.GetTime
local SpellLib={}
--spell lib structure
--NPA.SpellLib[spellid]={
--name
--icon
--casttime
--school
--minrange
--maxrange
--cooldown type : 2=stack(new in 5.0) or 1=old school
--cooldown length
--stack count (for stack type only)
--max stack
NPA.SpellInfo={}
--functions
local SpellCache={}
local SpellAuraCache={}
local AbsorbSpellCache={}
local SpellCoolDownCache={}

local NPA_SpellScanTooltip = CreateFrame( "GameTooltip", "NPA_SpellScanTooltip", UIParent, "GameTooltipTemplate") 
NPA_SpellScanTooltip:SetOwner( WorldFrame, "ANCHOR_NONE")

local TimeLocalization
local locale,locale2=GetLocale()
local ldot="(%d+)%."
if(locale=="zhCN")then
	locale="(%d+)分钟"
	locale2="(%d+)秒"
elseif(locale=="enUS")then
	locale="(%d+) minute"
	locale2="(%d+) second"
elseif(locale=="zhTW")then
	locale="(%d+) 分鐘"
	locale2="(%d+) 秒"
else
	locale="Not supported"
	locale2=locale
end

NPA.SpellInfo.GetSpellCoolDown=function(spellid)
	NPA_SpellScanTooltip:ClearLines()
	NPA_SpellScanTooltip:SetSpellByID(spellid)
	--local i=1
	--local name="NPA_SpellScanTooltipTextLeft"..i
	--local frame=_G[name]
	--print("debug")
	--print("left")
	--while(frame)do
	--	print(frame:GetText())
	--	i=i+1
	--	name="NPA_SpellScanTooltipTextLeft"..i
	--	frame=_G[name]
	--end
	local i=1
	name="NPA_SpellScanTooltipTextRight"..i
	frame=_G[name]
	while(frame)do
		local text=frame:GetText()
		if(text)then
			for dtime in string.gmatch(text,locale) do
				for ddot in string.gmatch(text,ldot) do
					return tonumber(ddot.."."..dtime)*60
				end
				return floor(tonumber(dtime)*60)
			end
			for dtime in string.gmatch(text,locale2) do
				for ddot in string.gmatch(text,ldot) do
					return tonumber(ddot.."."..dtime)
				end
				return floor(tonumber(dtime))
			end
		end
		--
		i=i+1
		name="NPA_SpellScanTooltipTextRight"..i
		frame=_G[name]
	end

	return 0
end

local NPA_SpellInfo_GetSpellCoolDown=NPA.SpellInfo.GetSpellCoolDown

NPA.SpellInfo.GetSpellInfo=function(spellid)
	--check lib
	local data=SpellLib[spellid]
	if(not data)then
		data=SpellAuraCache[spellid]
		if(not data)then
			data =SpellCache[spellid]
			if(not data)then
				--name,icon,casttime,school,minrange,maxrange,cooldown,cooldownstack,length,maxstack
				--no match in lib, using system function
				--name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo()
				local name, _,icon,casttime,minrange,maxrange=GetSpellInfo(spellid)
				if(casttime==nil) then
					casttime=0
				else
					casttime=casttime/1000
				end
				--cache up spell data, this prevent frequent table generation, should increase speed
				SpellCache[spellid]={
					Name=name,
					Icon=icon,
					CastTime=casttime,
					MinRange=minrange,
					MaxRange=maxrange
				}
				
				if(NPA_Setting.Core.EnableCoolDownCache)then
					SpellCache[spellid].CoolDown=NPA_SpellInfo_GetSpellCoolDown(spellid)
					SpellCache[spellid].CoolDownType=0
				end

				data=SpellCache[spellid]
			end
		end
	end
	return data
end
--
--return castinfo
NPA.SpellInfo.GetCastInfo=function(unit)
	-- spellname, rank, displayName, icon, startTime, endTime, isTradeSkill, castID, notinterrupt=UnitCastingInfo(unit)
	local _, _, name, icon, starttime, endtime, _, _, nointerrupt=UnitCastingInfo(unit)
	local channeling
	if((not name) or name=="Channeling")then
		-- spellname, rank, displayName, icon, startTime, endTime, isTradeSkill,  notinterrupt =UnitChannelInfo(unit)
		--revers endtime and starttime
		_,_,name,icon,starttime,endtime, _,nointerrupt = UnitChannelInfo(unit)
		if(not name)then
			return nil
		end
		channeling=true
	end
	if(not endtime)then
		--delay 1s
		endtime=NPA_GetTime()+1
	else
		--UnitCasting info returns strange timestamp, it can translate this way , don't know why
		endtime=floor(endtime/10)/100
		--in case the casting is already ended
		if(endtime<NPA_GetTime())then
			return nil
		end
	end
	--
	if(not starttime)then
		starttime=NPA_GetTime()
	else
		--blizzard time is exactly 1000xGetTime , don't know why
		starttime=floor(starttime/10)/100
	end
	--
	return name,icon,starttime,endtime,nointerrupt,channeling
end
--spellinfo auto cache, costy
--placeholder

local CacheAura=function(name,spelltype,duration,spellid,isplayer)
	if(spellid)then
		if(not SpellAuraCache[spellid])then
			local _, _,icon, casttime,minrange,maxrange=GetSpellInfo(spellid)
			if(casttime==nil) then
				casttime=0
			else
				casttime=casttime/1000
			end
			--cache up spell data, this prevent frequent table generation, should increase speed
			SpellAuraCache[spellid]={
				Name=name,
				Icon=icon,
				CastTime=casttime,
				MinRange=minrange,
				MaxRange=maxrange,
				SpellType = spelltype
			}

			if(NPA_Setting.Core.EnableCoolDownCache)then
				SpellAuraCache[spellid].CoolDown=NPA_SpellInfo_GetSpellCoolDown(spellid)
				SpellAuraCache[spellid].CoolDownType=0
			end
		end
		if(isplayer)then
			SpellAuraCache[spellid].PVPLength = duration
		else
			SpellAuraCache[spellid].Length = duration
		end
	end
end

local CacheAuraInfo=function(unit,unitdata)
	local isplayer = UnitIsplayer(unit)
	local i=1
	--seek every debuff on unit
	repeat
		--name, rank,icon , count , bufftype , duration , expirationtime , unitcaster , isstealable , shouldconsolidate , spellid = UnitBuff(unit,i)
		--15 = absorbamount
		local name,_,_, _ , bufftype , duration , _ , _ , _ ,_ , spellid = UnitDebuff(unit,i)
		CacheAura(name,bufftype,duration,spellid,isplayer)
		--
		i=i+1
	until(not name)
	--and buff
	local i=1
	repeat
		--name,  rank,icon , count , bufftype , duration , expirationtime , unitcaster , isstealable , shouldconsolidate , spellid = UnitBuff(unit,i)
		local name,_, _ , bufftype , duration , _ , _ , _ ,_ , spellid = UnitBuff(unit,i)
		--
		CacheAura(name,bufftype,duration,spellid,isplayer)
		i=i+1
	until(not name)
end

local RefreshSpellInfo=function()
	SpellLib=NPA_Setting.SpellLib
	for id,spelldata in pairs(SpellLib) do
		if(spelldata.NewName=="")then
			spelldata.Name=GetSpellInfo(id)
		else
			spelldata.Name=spelldata.NewName
		end
		if(spelldata.NewIcon=="")then
			_,_,spelldata.Icon=GetSpellInfo(id)
		else
			spelldata.Icon=spelldata.NewIcon
		end
	end
end
----
local SpellIconToSchool={}

NPA.SpellInfo.SpellIconToSchool=function(icon)
	if(icon)then
		return SpellIconToSchool[icon]
	end
	return nil
end
--
local NPA_SpellInfo_GetSpellInfo=NPA.SpellInfo.GetSpellInfo

local PowerSpellSchool=function(arg)
	if(arg[12])then
		local _, _,icon=GetSpellInfo(arg[12])
		SpellIconToSchool[icon]=arg[14]
	end
end
----
local CacheSpellCoolDown=function(arg)
	local spellid=arg[12]
	if(spellid and not SpellCache[spellid])then
		local cooldown=NPA_SpellInfo_GetSpellCoolDown(spellid)
		if(cooldown~=0)then
			local name, _,icon, casttime,minrange,maxrange=GetSpellInfo(spellid)
			if(casttime==nil) then
				casttime=0
			else
				casttime=casttime/1000
			end
			--cache up spell data, this prevent frequent table generation, should increase speed
			SpellCache[spellid]={
				Name=name,
				Icon=icon,
				CastTime=casttime,
				MinRange=minrange,
				MaxRange=maxrange,
				CoolDown=cooldown,
				CoolDownType=0,
			}
		end
	end
end


NPA.EventHandler.RegisterEvent(6,"SettingManager_RefreshSpellInfo","SpellManager",RefreshSpellInfo)

NPA.EventHandler.RegisterEvent(6,"SettingManager_SettingLoaded","SpellManager",function()
	RefreshSpellInfo()

	if(NPA_Setting.Core.EnableAuraCache==true)then
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","Spell_Manager",CacheAuraInfo)
	else
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","Spell_Manager",nil)
	end
	----
	SpellIconToSchool={}
	if(NPA_Setting.Core.IconToSchool==true)then
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_CAST_START","SpellInfo_PowerSchool",PowerSpellSchool)
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_CAST_SUCCESS","SpellInfo_PowerSchool",PowerSpellSchool)
	else
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_CAST_START","SpellInfo_PowerSchool",nil)
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_CAST_SUCCESS","SpellInfo_PowerSchool",nil)
	end
	--
	if(NPA_Setting.Core.EnableCoolDownCache==true)then
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_AURA_APPLIED","SpellInfo_CacheCoolDown",CacheSpellCoolDown)
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_CAST_START","SpellInfo_CacheCoolDown",CacheSpellCoolDown)
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_CAST_SUCCESS","SpellInfo_CacheCoolDown",CacheSpellCoolDown)
		for spellid,data in pairs(SpellAuraCache) do
			data.CoolDown=NPA_SpellInfo_GetSpellCoolDown(spellid)
		end

		for spellid,data in pairs(SpellCache)do
			data.CoolDown=NPA_SpellInfo_GetSpellCoolDown(spellid)
		end
		
	else
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_AURA_APPLIED","SpellInfo_CacheCoolDown",nil)
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_CAST_START","SpellInfo_CacheCoolDown",nil)
		NPA.DataCollector.RegisterCombatLogEvent("SPELL_CAST_SUCCESS","SpellInfo_CacheCoolDown",nil)
		for spellid,data in pairs(SpellAuraCache) do
			data.CoolDown=nil
		end

		for spellid,data in pairs(SpellCache)do
			data.CoolDown=nil
		end
	end

end)


