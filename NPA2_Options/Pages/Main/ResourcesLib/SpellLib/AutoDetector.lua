-- Author      : Nogarder
-- Create Date : 2012/11/4 7:53:14
NPA_Options.RegisterPageFunc("SpellLibAutoDetector",function()

	local pairs=pairs
	local table_insert=table.insert
	local bit_band=bit.band
	local next=next
	local floor=floor
	--
	local Localization=NPA_Options.Localization.PagesSpellLibAutoDetector
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["AutoDetector"],235,525,nil,nil)
	main:Hide()
	local page=main.Frame
	--
	page:SetWidth(235)
	page:SetHeight(525)
	--
	local width=90
	local step=-5
	--enablebox
	local enablebox=NPA_Options.Template.CreateCheckBox(page,225,20,Localization["Enable"])
	enablebox:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Enable"],enablebox)
	--from filter frame
	local fromframe=NPA_Options.Template.CreateFrame(page,110,230,nil,true,Localization["From"],1)
	fromframe:SetPoint("TOPLEFT",enablebox,"BOTTOMLEFT",0,-15)
	fromframe:EnableMouse(false)
	--from checker
	--object
	local fromobjectchecker=NPA_Options.Template.CreateCheckBox(fromframe,100,20,Localization["Object"])
	fromobjectchecker:SetPoint("TOPLEFT",fromframe,"TOPLEFT",5,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Object"],fromobjectchecker)
	NPA_Options.Template.SetCheckBox(fromobjectchecker,true)
	--guardian
	local fromguardianchecker=NPA_Options.Template.CreateCheckBox(fromframe,100,20,Localization["Guardian"])
	fromguardianchecker:SetPoint("TOPLEFT",fromobjectchecker,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Guardian"],fromguardianchecker)
	NPA_Options.Template.SetCheckBox(fromguardianchecker,true)
	--pet
	local frompetchecker=NPA_Options.Template.CreateCheckBox(fromframe,100,20,Localization["Pet"])
	frompetchecker:SetPoint("TOPLEFT",fromguardianchecker,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Pet"],frompetchecker)
	NPA_Options.Template.SetCheckBox(frompetchecker,true)
	--NPC
	local fromnpcchecker=NPA_Options.Template.CreateCheckBox(fromframe,100,20,Localization["NPC"])
	fromnpcchecker:SetPoint("TOPLEFT",frompetchecker,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["NPC"],fromnpcchecker)
	NPA_Options.Template.SetCheckBox(fromnpcchecker,true)
	--player
	local fromplayerchecker=NPA_Options.Template.CreateCheckBox(fromframe,100,20,Localization["Player"])
	fromplayerchecker:SetPoint("TOPLEFT",fromnpcchecker,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Player"],fromplayerchecker)
	NPA_Options.Template.SetCheckBox(fromplayerchecker,true)
	--target
	local fromtargetchecker=NPA_Options.Template.CreateCheckBox(fromframe,100,20,Localization["Target"])
	fromtargetchecker:SetPoint("TOPLEFT",fromplayerchecker,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Target"],fromtargetchecker)
	NPA_Options.Template.SetCheckBox(fromtargetchecker,true)
	--focus
	local fromfocuschecker=NPA_Options.Template.CreateCheckBox(fromframe,100,20,Localization["Focus"])
	fromfocuschecker:SetPoint("TOPLEFT",fromtargetchecker,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Focus"],fromfocuschecker)
	NPA_Options.Template.SetCheckBox(fromfocuschecker,true)
	--self
	local fromselfchecker=NPA_Options.Template.CreateCheckBox(fromframe,100,20,Localization["Self"])
	fromselfchecker:SetPoint("TOPLEFT",fromfocuschecker,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Self"],fromselfchecker)
	NPA_Options.Template.SetCheckBox(fromselfchecker,true)
	--noone
	local fromnoonechecker=NPA_Options.Template.CreateCheckBox(fromframe,100,20,Localization["NoOne"])
	fromnoonechecker:SetPoint("TOPLEFT",fromselfchecker,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["NoOne"],fromnoonechecker)
	NPA_Options.Template.SetCheckBox(fromnoonechecker,true)
	--
	--to filter frame
	local toframe=NPA_Options.Template.CreateFrame(page,110,230,nil,true,Localization["CastOn"],1)
	toframe:SetPoint("TOPLEFT",fromframe,"TOPRIGHT",5,0)
	toframe:EnableMouse(false)
	--to checker
	--object
	local toobjectchecker=NPA_Options.Template.CreateCheckBox(toframe,100,20,Localization["Object"])
	toobjectchecker:SetPoint("TOPLEFT",toframe,"TOPLEFT",5,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Object"],toobjectchecker)
	NPA_Options.Template.SetCheckBox(toobjectchecker,true)
	--guardian
	local toguardianchecker=NPA_Options.Template.CreateCheckBox(toframe,100,20,Localization["Guardian"])
	toguardianchecker:SetPoint("TOPLEFT",toobjectchecker,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Guardian"],toguardianchecker)
	NPA_Options.Template.SetCheckBox(toguardianchecker,true)
	--pet
	local topetchecker=NPA_Options.Template.CreateCheckBox(toframe,100,20,Localization["Pet"])
	topetchecker:SetPoint("TOPLEFT",toguardianchecker,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Pet"],topetchecker)
	NPA_Options.Template.SetCheckBox(topetchecker,true)
	--NPC
	local tonpcchecker=NPA_Options.Template.CreateCheckBox(toframe,100,20,Localization["NPC"])
	tonpcchecker:SetPoint("TOPLEFT",topetchecker,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["NPC"],tonpcchecker)
	NPA_Options.Template.SetCheckBox(tonpcchecker,true)
	--player
	local toplayerchecker=NPA_Options.Template.CreateCheckBox(toframe,100,20,Localization["Player"])
	toplayerchecker:SetPoint("TOPLEFT",tonpcchecker,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Player"],toplayerchecker)
	NPA_Options.Template.SetCheckBox(toplayerchecker,true)
	--target
	local totargetchecker=NPA_Options.Template.CreateCheckBox(toframe,100,20,Localization["Target"])
	totargetchecker:SetPoint("TOPLEFT",toplayerchecker,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Target"],totargetchecker)
	NPA_Options.Template.SetCheckBox(totargetchecker,true)
	--focus
	local tofocuschecker=NPA_Options.Template.CreateCheckBox(toframe,100,20,Localization["Focus"])
	tofocuschecker:SetPoint("TOPLEFT",totargetchecker,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Focus"],tofocuschecker)
	NPA_Options.Template.SetCheckBox(tofocuschecker,true)
	--self
	local toselfchecker=NPA_Options.Template.CreateCheckBox(toframe,100,20,Localization["Self"])
	toselfchecker:SetPoint("TOPLEFT",tofocuschecker,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Self"],toselfchecker)
	NPA_Options.Template.SetCheckBox(toselfchecker,true)
	--noone
	local tonoonechecker=NPA_Options.Template.CreateCheckBox(toframe,100,20,Localization["NoOne"])
	tonoonechecker:SetPoint("TOPLEFT",toselfchecker,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["NoOne"],tonoonechecker)
	NPA_Options.Template.SetCheckBox(tonoonechecker,true)
	--
	--spell list frame
	local spelllist=NPA_Options.Template.CreateCheckBoxList(page,205,180)
	spelllist.Scroll:SetPoint("TOPLEFT",fromframe,"BOTTOMLEFT",0,-5)
	--
	--save button
	local savebutton=NPA_Options.Template.CreateButton(page,225,15,Localization["Save"])
	NPA_Options.Template.SetTooltips(Tooltips["Save"],savebutton,nil,2)
	savebutton:SetPoint("TOPLEFT",spelllist.Scroll,"BOTTOMLEFT",0,-25)
	--reset button
	local resetbutton=NPA_Options.Template.CreateButton(page,225,15,Localization["Reset"])
	NPA_Options.Template.SetTooltips(Tooltips["Reset"],resetbutton,nil,2)
	resetbutton:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,-5)
	--detector
	local spelldata={}
	--
	local spellhandlertable={
		["SPELL_AURA_APPLIED"]=1, --1=apply aura
		["SPELL_AURA_APPLIED_DOSE"]=1,
		["SPELL_AURA_REMOVED"]=2,--2=remove aura
		["SPELL_AURA_REMOVED_DOSE"]=2,
		["SPELL_AURA_INTERRUPT"]=3,--3=interrupt spell
		["SPELL_CAST_START"]=4,--4=casting spell
		["SPELL_CAST_SUCCESS"]=4,
		["SPELL_SUMMON"]=5,--5=summon spell
		["SPELL_RESURRECT"]=6,--6=resurrect spell
		["SPELL_AURA_REFRESH"]=7,--7=refresh spell
		["SPELL_AURA_DISPEL"]=8,--stolen counts as dispel
		["SPELL_AURA_STOLEN"]=8,--8=dispel
		["SPELL_DAMAGE"]=9,--9=attack spell
		["SPELL_PERIODIC_DAMAGE"]=9,
		--["SPELL_MISSED"]=9,
		["SPELL_HEAL"]=10,--10=heal spell
		["SPELL_PERIODIC_HEAL"]=10,
		["SPELL_ENERGIZE"]=11,--11=enegrize spell
		["SPELL_PERIODIC_ENERGIZE"]=11,
		--["SPELL_DRAIN"]=12,--12=drain spell
		--["SPELL_PERIODIC_DRAIN"]=12,
	}
	local filterfrom=0
	local fiterto=0
	local areaname=GetInstanceInfo()
	--
	local selectedspell={}
	--
	NPA_Options.Template.SetCheckBoxList(spelllist,nil,
		function(name,value) --on value update, check selectlist
			selectedspell[name]=value
		end,
		function(name) --on enter ,show text list for info
			local textdata={}
			local data=spelldata[name]
			table_insert(textdata,{Text=Localization["Name"]..": "..data.Name,Offset=0})
			table_insert(textdata,{Text=Localization["Spellid"]..": "..name,Offset=0})
			table_insert(textdata,{Text=Localization["School"]..": "..data.School.." ("..NPA_Options.InfoLib.Spell.GetSchoolName(data.School)..")",Offset=0})
			table_insert(textdata,{Text=Localization["Icon"]..": "..(data.Icon or ""),Offset=0})
			table_insert(textdata,{Text=Localization["CastTime"]..": "..data.CastTime,Offset=0})
			table_insert(textdata,{Text=Localization["MinRange"]..": "..data.MinRange,Offset=0})
			table_insert(textdata,{Text=Localization["MaxRange"]..": "..data.MaxRange,Offset=0})
			if(data.CastElapse)then
				table_insert(textdata,{Text=Localization["CastElapse"]..": "..(floor(data.CastElapse*100)/100),Offset=0})
			end
			if(data.Length)then
				table_insert(textdata,{Text=Localization["Length"]..": "..(floor(data.Length*100)/100),Offset=0})
			end
			--
			if(data.IsInterruptSpell)then
				table_insert(textdata,{Text=Localization["InterruptSpell"],Offset=3})
			end
			if(data.IsSummonSpell)then
				table_insert(textdata,{Text=Localization["SummonSpell"],Offset=3})
			end
			if(data.IsDispelSpell)then
				table_insert(textdata,{Text=Localization["DispelSpell"],Offset=3})
			end
			if(data.IsHealSpell)then
				table_insert(textdata,{Text=Localization["HealSpell"],Offset=3})
			end
			if(data.IsResurrectSpell)then
				table_insert(textdata,{Text=Localization["ResurrectSpell"],Offset=3})
			end
			if(data.IsEnegrizeSpell)then
				table_insert(textdata,{Text=Localization["EnegrizeSpell"],Offset=3})
			end
			if(data.IsDispelAble)then
				table_insert(textdata,{Text=Localization["DispelAble"],Offset=3})
			end
			if(data.IsShiled)then
				table_insert(textdata,{Text=Localization["IsShield"],Offset=3})
			end
			--
			if(next(data.CastArea))then
				table_insert(textdata,{Text=Localization["CastArea"]..": ",Offset=0})
				for name,_ in pairs(data.CastArea)do
					table_insert(textdata,{Text=name,Offset=5})
				end
			end
			if(next(data.CasterName))then
				table_insert(textdata,{Text=Localization["Caster"]..": ",Offset=0})
				for name,flag in pairs(data.CasterName)do
					table_insert(textdata,{Text=name.." ("..NPA_Options.InfoLib.Unit.GetUnitType(flag)..")",Offset=5})
				end
			end
			if(next(data.CastOn))then
				table_insert(textdata,{Text=Localization["CastOn"]..": ",Offset=0})
				for name,flag in pairs(data.CastOn)do
					table_insert(textdata,{Text=name.." ("..NPA_Options.InfoLib.Unit.GetUnitType(flag)..")",Offset=5})
				end
			end
			--
			local textlist=NPA_Options.Template.SetTextList(page,1,textdata)
			textlist:SetPoint("TOPLEFT",spelllist.Scroll,"TOPRIGHT",30,0)
		end
		,function() --on leave, hide text list
			NPA_Options.Template.HideTextList()
		end)
	--
	local updatespelllist=function()
		local dataset={}
		for spellid,data in pairs(spelldata)do
			table_insert(dataset,{
				Name=spellid,
				Text=data.Name.." ("..spellid..")",
				TextureFile=data.Icon
			})
		end
		NPA_Options.Template.UpdateCheckBoxListByData(spelllist,dataset)
	end
	--
	local CheckSpecial=function(guid,checker1,checker2,checker3)
		local passfrom
		if(guid)then
			if(
				(guid==UnitGUID("target") and checker1.Checked==true) or
				(guid==UnitGUID("focus") and checker2.Checked==true) or
				(guid==UnitGUID("player") and checker3.Checked==true)		
				)
				then
					return true
				end
		end
	end
	--
	local NPA_Options_SpellAutoDetector_OnEvent=function(arg)
		--special for shield spell
		if(arg[2]=="SPELL_ABSORBED")then
			if(arg[22])then
				if(not spelldata[arg[19]])then
					spelldata[arg[19]]={
						CasterName={},
						LastCast={},
						CastArea={},
						CastOn={},
						CastOnTimer={},
						IsShield=true}
					return
				end
				spelldata[arg[19]].IsShield=true
			elseif(arg[16])then
				if(not spelldata[arg[16]])then
					spelldata[arg[16]]={
						CasterName={},
						LastCast={},
						CastArea={},
						CastOn={},
						CastOnTimer={},
						IsShield=true}
					return
				end
				spelldata[arg[16]].IsShield=true
				return
			end
		end
		--
		if(arg[2] and arg[12])then
			local updated
			local index=spellhandlertable[arg[2]]
			--must have a caster name and fit in filters
			if(index and (
				((arg[5] and bit_band(arg[6],filterfrom)>0) or
				 (arg[5]==nil and fromnoonechecker.Checked==true) or
				 (arg[5] and CheckSpecial(arg[4],fromtargetchecker,fromfocuschecker,fromselfchecker))
				 ) and
				(
				 (arg[9] and bit_band(arg[10],filterto)>0) or 
				 (arg[9]==nil and tonoonechecker.Checked==true) or
				 (arg[9] and CheckSpecial(arg[8],totargetchecker,tofocuschecker,toselfchecker))
				)
				))then
					if(not spelldata[arg[12]])then
						spelldata[arg[12]]={
							CasterName={},
							LastCast={},
							CastArea={},
							CastOn={},
							CastOnTimer={}}
					end
					local data=spelldata[arg[12]]
					--basic info
					if(data.Name~=arg[13])then
						data.Name=arg[13]
						data.School=arg[14]
						--extra info
						local _, _,icon, casttime,minrange,maxrange=GetSpellInfo(arg[12])
						data.Icon=icon
						data.CastTime=floor((casttime or 0)/10)/100
						data.MinRange=minrange
						data.MaxRange=maxrange
						--update mark
						updated=true
					end
					--caster
					data.CasterName[arg[5] or "None"]=arg[6]
					--cast area
					data.CastArea[areaname]=true
					--cast upon
					data.CastOn[arg[9] or "None"]=arg[10]
					if(index~=2)then
						if(arg[9])then --check name rather than guid, as blizzard would give a 0x000 guid on unit not exists
							data.CastOnTimer[arg[8]]=arg[1]
						end
					elseif(data.CastOnTimer[arg[8]])then
						local length=arg[1]-data.CastOnTimer[arg[8]]
						if((not data.Length) or data.Length<length)then
							data.Length=length
						end
					end
					--special handler
					--stack
					if(index==1)then
						if((not data.MaxStack) or data.MaxStack<(arg[16] or 1))then
							data.MaxStack=arg[16] or 1
						end
					elseif(index==3)then
						--set interrupt spell
						data.IsInterruptSpell=true
					elseif(index==4)then
						--time between casts
						if(data.LastCast[arg[4]])then
							local elapse=arg[1]-data.LastCast[arg[4]]
							if((not data.CastElapse)or data.CastElapse>elapse)then
								data.CastElapse=elapse
							end
						end
						data.LastCast[arg[4]]=arg[1]
					elseif(index==5)then
						data.IsSummonSpell=true
					elseif(index==6)then
						data.IsResurrectSpell=true
					elseif(index==8)then
						data.IsDispelSpell=true
						if(spelldata[arg[15]])then
							spelldata[arg[15]].DispelAble=true
						end
					elseif(index==9)then
						data.IsDamageSpell=true
					elseif(index==10)then
						data.IsHealSpell=true
					elseif(index==11)then
						data.IsEnegrizeSpell=true
					end
					--update list display
					if(updated)then
						updatespelllist()
					end
				end
		end
	end

	enablebox.OnValueUpdateFunc=function()
		if(enablebox.Checked)then
			NPA.DataCollector.RegisterCombatLogEvent("Any","NPA_Options_SpellAutoDetector",NPA_Options_SpellAutoDetector_OnEvent)
			NPA.EventHandler.RegisterEvent(2,"DataCollector_PlayerEnteringWorld","NPA_Options_SpellAutoDetector",function(_,instancename)
				areaname=instancename
			end)
			--check collectable list for detailed info like spell type
			NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","NPA_Options_SpellAutoDetector",function(unit)			
				local i=1
				--seek every debuff on unit
				repeat
					--name,rank  icon , count , bufftype , duration , expirationtime , unitcaster , isstealable , shouldconsolidate , spellid = UnitBuff(unit,i)
					local name,_ ,_, _ , bufftype , duration , _ , _ , _ ,_ , spellid = UnitDebuff(unit,i)
					--
					if(spellid and spelldata[spellid])then
						spelldata[spellid].SpellType=bufftype or "None"
						spelldata[spellid].Length=spelldata[spellid].Length or duration
						
					end
					i=i+1
				until(not name)
				--and buff
				local i=1
				repeat
					--name,rank, icon , count , bufftype , duration , expirationtime , unitcaster , isstealable , shouldconsolidate , spellid = UnitBuff(unit,i)
					--15=absorbamount
					local name,_,_, _ , bufftype , duration , _ , _ , _ ,_ , spellid = UnitBuff(unit,i)
					--
					if(spellid and spelldata[spellid])then
						spelldata[spellid].SpellType=bufftype or "None"
						spelldata[spellid].Length=spelldata[spellid].Length or duration

					end
					i=i+1
				until(not name)
			end)
		else
			--unregister events
			NPA.DataCollector.RegisterCombatLogEvent("Any","NPA_Options_SpellAutoDetector",nil)
			NPA.EventHandler.RegisterEvent(2,"DataCollector_PlayerEnteringWorld","NPA_Options_SpellAutoDetector",nil)
			NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","NPA_Options_SpellAutoDetector",nil)
		end

	end
	local buildfilter=function()
		--generate filter flag
		filterfrom=0
		if(fromobjectchecker.Checked)then
			filterfrom=filterfrom+COMBATLOG_OBJECT_TYPE_OBJECT
		end
		if(fromguardianchecker.Checked)then
			filterfrom=filterfrom+COMBATLOG_OBJECT_TYPE_GUARDIAN
		end
		if(frompetchecker.Checked)then
			filterfrom=filterfrom+COMBATLOG_OBJECT_TYPE_PET
		end
		if(fromnpcchecker.Checked)then
			filterfrom=filterfrom+COMBATLOG_OBJECT_TYPE_NPC
		end
		if(fromplayerchecker.Checked)then
			filterfrom=filterfrom+COMBATLOG_OBJECT_TYPE_PLAYER
		end
		--
		filterto=0
		if(toobjectchecker.Checked)then
			filterto=filterto+COMBATLOG_OBJECT_TYPE_OBJECT
		end
		if(toguardianchecker.Checked)then
			filterto=filterto+COMBATLOG_OBJECT_TYPE_GUARDIAN
		end
		if(topetchecker.Checked)then
			filterto=filterto+COMBATLOG_OBJECT_TYPE_PET
		end
		if(tonpcchecker.Checked)then
			filterto=filterto+COMBATLOG_OBJECT_TYPE_NPC
		end
		if(toplayerchecker.Checked)then
			filterto=filterto+COMBATLOG_OBJECT_TYPE_PLAYER
		end
	end
	--
	fromobjectchecker.OnValueUpdateFunc=buildfilter
	fromguardianchecker.OnValueUpdateFunc=buildfilter
	frompetchecker.OnValueUpdateFunc=buildfilter
	fromnpcchecker.OnValueUpdateFunc=buildfilter
	fromplayerchecker.OnValueUpdateFunc=buildfilter
	fromtargetchecker.OnValueUpdateFunc=buildfilter
	fromfocuschecker.OnValueUpdateFunc=buildfilter
	fromselfchecker.OnValueUpdateFunc=buildfilter
	fromnoonechecker.OnValueUpdateFunc=buildfilter
	--
	toobjectchecker.OnValueUpdateFunc=buildfilter
	toguardianchecker.OnValueUpdateFunc=buildfilter
	topetchecker.OnValueUpdateFunc=buildfilter
	tonpcchecker.OnValueUpdateFunc=buildfilter
	toplayerchecker.OnValueUpdateFunc=buildfilter
	totargetchecker.OnValueUpdateFunc=buildfilter
	tofocuschecker.OnValueUpdateFunc=buildfilter
	toselfchecker.OnValueUpdateFunc=buildfilter
	tonoonechecker.OnValueUpdateFunc=buildfilter
	--
	--save function
	savebutton:HookScript("OnMouseUp",function()
		local spellcount=0
		local savedcount=0
		local overwrotecount=0
		local spelllib=NPA_Setting.SpellLib
		for spellid,_ in pairs(selectedspell) do
			if(spelllib[spellid])then
				overwrotecount=overwrotecount+1
			else
				spelllib[spellid]={Catalog=Localization["Unsorted"]}
				savedcount=savedcount+1
			end
			local lib=spelllib[spellid]
			local data=spelldata[spellid]
			lib.NewName=""
			lib.School=data.School or 1
			lib.NewIcon=""
			lib.CastTime=floor((data.CastTime or 0)/10)/100
			lib.MinRange=data.MinRange or 1
			lib.MaxRange=data.MaxRange or 1
			lib.CoolDown=data.CastElapse or 1
			lib.CoolDownStack=0
			lib.CoolDownType=0
			lib.Length=data.Length or 1
			lib.MaxStack=data.MaxStack or 1
			lib.SpellType=data.SpellType or "None"
			lib.DispelAble=data.DispelAble or false
			lib.PVPLength=data.Length or 1
			lib.PVPDRType="None"
			lib.AffectSpellList={}
			if(data.IsInterruptSpell)then
				lib.CounterSpellLength=4
			else
				lib.CounterSpellLength=0
			end
			--these are not used yet
			--lib.IsSummonSpell=data.IsSummonSpell
			--lib.IsResurrectSpell=data.IsResurrectSpell
			--lib.IsDispelSpell=data.IsDispelSpell
			--lib.IsDamageSpell=data.IsDamageSpell
			--lib.IsHealSpell=data.IsHealSpell
			--lib.IsEnegrizeSpell=data.IsEnegrizeSpell
			--
			spellcount=spellcount+1
		end
		print(Localization["Saved"]..": "..savedcount)
		print(Localization["Overwrote"]..": "..overwrotecount)
		print(Localization["Total"]..": "..spellcount)
	end)
	--
	resetbutton:HookScript("OnMouseUp",function()
		spelldata={}
		updatespelllist()
	end)
	--
	main.OnSetFunc=buildfilter
	--
	NPA_Options.RegisterPage("SpellLibAutoDetector",main)

end)
