-- Author      : Nogarder
-- Create Date : 2012/11/8 17:44:43
NPA_Options.RegisterPageFunc("SpellEditor",function()

	local pairs=pairs
	local CopyTable=CopyTable
	local table_insert=table.insert
	local bit_band=bit.band
	--localization
	local Localization=NPA_Options.Localization.TemplatesWindowSpellEditor
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,nil,420,460)
	main:Hide()
	local page=main.Frame
	--
	--page:SetWidth(420)
	--page:SetHeight(430)
	--
	local RefreshFunc
	local Spellid
	local AffectSpellList={}
	--save
	local savebutton=NPA_Options.Template.CreateSpecialButton(page,200,15,"Save")
	savebutton:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	--cancel
	local cancelbutton=NPA_Options.Template.CreateSpecialButton(page,200,15,"Cancel")
	cancelbutton:SetPoint("TOPRIGHT",page,"TOPRIGHT",-5,-5)
	--spellid
	local spellidlabel=NPA_Options.Template.CreateText(page,Localization["SpellId"])
	spellidlabel:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,-5)
	local spellidlabel2=NPA_Options.Template.CreateText(page," ")
	spellidlabel2:SetPoint("LEFT",spellidlabel,"RIGHT",15,0)
	--spell name
	local spellnamelabel=NPA_Options.Template.CreateText(page,Localization["SpellName"])
	spellnamelabel:SetPoint("TOPLEFT",spellidlabel,"BOTTOMLEFT",0,-5)
	local spellnameedit=NPA_Options.Template.CreateEditBox(page,200,15)
	spellnameedit:SetPoint("LEFT",spellnamelabel,"RIGHT",5,0)
	spellnameedit:SetPoint("RIGHT",page,"RIGHT",-5,0)
	--
	--spell icon
	--spell icon
	local icontexture=page:CreateTexture(nil,OVERLAY)
	icontexture:SetPoint("TOPLEFT",spellnamelabel,"BOTTOMLEFT",0,-15)
	icontexture:SetHeight(30)
	icontexture:SetWidth(30)
	--
	local spelliconedit=NPA_Options.Template.CreateTextureFileSelectorButton(page,main,365,Localization["SpellIcon"])
	spelliconedit.Label:SetPoint("BOTTOMLEFT",spelliconedit,"TOPLEFT",0,0)
	spelliconedit:SetPoint("TOPLEFT",icontexture,"TOPRIGHT",5,-10)
	spelliconedit.OnValueUpdateFunc=function()
		icontexture:SetTexture(spelliconedit.Value)
	end
	spelliconedit.FreeEdit=true
	--
	--spell class dropdown
	local spellclassedit=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["SpellClass"],nil,NPA_Options.InfoLib.Spell.GetClassList,20)
	spellclassedit:SetPoint("TOPLEFT",icontexture,"BOTTOMLEFT",0,-15)
	spellclassedit.Label:SetPoint("BOTTOMLEFT",spellclassedit,"TOPLEFT",0,0)
	--
	--spell school checklist
	local spellschoolchecklist=NPA_Options.Template.CreateFrame(page,200,121,nil,true,Localization["SpellSchool"],1)
	spellschoolchecklist:SetPoint("TOPLEFT",spellclassedit,"BOTTOMLEFT",0,-15)
	spellschoolchecklist:EnableMouse(false)
	--physic checker
	local physicchecker=NPA_Options.Template.CreateCheckBox(spellschoolchecklist,90,15,NPA_Options.InfoLib.Spell.GetSchoolName(1))
	physicchecker:SetPoint("TOPLEFT",spellschoolchecklist,"TOPLEFT",5,-2)
	physicchecker:SetPoint("RIGHT",spellschoolchecklist,"RIGHT",-5,0)
	--holy checker
	local holychecker=NPA_Options.Template.CreateCheckBox(spellschoolchecklist,190,15,NPA_Options.InfoLib.Spell.GetSchoolName(2))
	holychecker:SetPoint("TOPLEFT",physicchecker,"BOTTOMLEFT",0,-2)
	holychecker:SetPoint("RIGHT",spellschoolchecklist,"RIGHT",-5,0)
	--fire checker
	local firechecker=NPA_Options.Template.CreateCheckBox(spellschoolchecklist,190,15,NPA_Options.InfoLib.Spell.GetSchoolName(4))
	firechecker:SetPoint("TOPLEFT",holychecker,"BOTTOMLEFT",0,-2)
	firechecker:SetPoint("RIGHT",spellschoolchecklist,"RIGHT",-5,0)
	--nature checker
	local naturechecker=NPA_Options.Template.CreateCheckBox(spellschoolchecklist,190,15,NPA_Options.InfoLib.Spell.GetSchoolName(8))
	naturechecker:SetPoint("TOPLEFT",firechecker,"BOTTOMLEFT",0,-2)
	naturechecker:SetPoint("RIGHT",spellschoolchecklist,"RIGHT",-5,0)
	--frost checker
	local frostchecker=NPA_Options.Template.CreateCheckBox(spellschoolchecklist,190,15,NPA_Options.InfoLib.Spell.GetSchoolName(16))
	frostchecker:SetPoint("TOPLEFT",naturechecker,"BOTTOMLEFT",0,-2)
	frostchecker:SetPoint("RIGHT",spellschoolchecklist,"RIGHT",-5,0)
	--shadow checker
	local shadowchecker=NPA_Options.Template.CreateCheckBox(spellschoolchecklist,190,15,NPA_Options.InfoLib.Spell.GetSchoolName(32))
	shadowchecker:SetPoint("TOPLEFT",frostchecker,"BOTTOMLEFT",0,-2)
	shadowchecker:SetPoint("RIGHT",spellschoolchecklist,"RIGHT",-5,0)
	--arcane checker
	local arcanechecker=NPA_Options.Template.CreateCheckBox(spellschoolchecklist,190,15,NPA_Options.InfoLib.Spell.GetSchoolName(64))
	arcanechecker:SetPoint("TOPLEFT",shadowchecker,"BOTTOMLEFT",0,-2)
	arcanechecker:SetPoint("RIGHT",spellschoolchecklist,"RIGHT",-5,0)
	--catalog editor
	local catalogedit=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["Catalog"],Tooltips["Catalog"],NPA_Options.InfoLib.Spell.GetCatalogList,20)
	catalogedit.Label:SetPoint("BOTTOMLEFT",catalogedit,"TOPLEFT",0,0)
	catalogedit:SetPoint("TOPLEFT",spellschoolchecklist,"BOTTOMLEFT",0,-20)
	catalogedit.FreeEdit=true
	--pvp dr type edit
	local drtypeedit=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["PVPDRType"],Tooltips["PVPDRType"],NPA_Options.InfoLib.Spell.GetPVPDRType,20)
	drtypeedit.Label:SetPoint("BOTTOMLEFT",drtypeedit,"TOPLEFT",0,0)
	drtypeedit:SetPoint("TOPLEFT",catalogedit,"BOTTOMLEFT",0,-20)
	drtypeedit.FreeEdit=true
	--casttime slider
	local casttimeslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,10,0.01,0,Localization["CastTime"],Tooltips["CastTime"])
	casttimeslider:SetPoint("TOPLEFT",drtypeedit,"BOTTOMLEFT",0,-15)
	--cooldown type
	local cooldowntypeselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["CoolDownType"],Tooltips["CoolDownType"],NPA_Options.InfoLib.Spell.GetCoolDownType,20)
	cooldowntypeselector:SetPoint("TOPLEFT",casttimeslider,"BOTTOMLEFT",0,-15)
	cooldowntypeselector.Label:SetPoint("BOTTOMLEFT",cooldowntypeselector,"TOPLEFT",0,0)
	--no dr checkbox
	local nodrcheckbox=NPA_Options.Template.CreateCheckBox(page,195,20,Localization["NoDR"])
	NPA_Options.Template.SetTooltips(Tooltips["NoDR"],nodrcheckbox)
	nodrcheckbox:SetPoint("TOPLEFT",cooldowntypeselector,"BOTTOMLEFT",0,-10)
	--is shield checkbox
	local isshieldcheckbox=NPA_Options.Template.CreateCheckBox(page,195,20,Localization["IsShield"])
	NPA_Options.Template.SetTooltips(Tooltips["IsShield"],isshieldcheckbox)
	isshieldcheckbox:SetPoint("TOPLEFT",nodrcheckbox,"TOPRIGHT",10,0)
	--
	--right half of the page
	--minrange slider
	local minrangeslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,100,0.01,0,Localization["MinRange"],Tooltips["MinRange"])
	minrangeslider:SetPoint("TOPLEFT",spellclassedit,"TOPRIGHT",25,0)
	--maxrange slider
	local maxrangeslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,100,0.01,0,Localization["MaxRange"],Tooltips["MaxRange"])
	maxrangeslider:SetPoint("TOPLEFT",minrangeslider,"BOTTOMLEFT",0,-15)
	--cooldown
	local cooldownslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,600,0.01,0,Localization["CoolDown"],Tooltips["CoolDown"])
	cooldownslider:SetPoint("TOPLEFT",maxrangeslider,"BOTTOMLEFT",0,-15)
	--cooldown stack
	local cooldownstackslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,9,1,0,Localization["CoolDownStack"],Tooltips["CoolDownStack"])
	cooldownstackslider:SetPoint("TOPLEFT",cooldownslider,"BOTTOMLEFT",0,-15)
	--length
	local lengthslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,300,0.01,0,Localization["Length"],Tooltips["Length"])
	lengthslider:SetPoint("TOPLEFT",cooldownstackslider,"BOTTOMLEFT",0,-15)
	--max stack
	local maxstackslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,9,1,0,Localization["MaxStack"],Tooltips["MaxStack"])
	maxstackslider:SetPoint("TOPLEFT",lengthslider,"BOTTOMLEFT",0,-15)
	--pvplength
	local pvplengthslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,300,0.01,0,Localization["PVPLength"],Tooltips["PVPLength"])
	pvplengthslider:SetPoint("TOPLEFT",maxstackslider,"BOTTOMLEFT",0,-15)
	--counter spell length
	local counterspelllengthslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,300,0.01,0,Localization["CounterSpellLength"],Tooltips["CounterSpellLength"])
	counterspelllengthslider:SetPoint("TOPLEFT",pvplengthslider,"BOTTOMLEFT",0,-15)
	--affect spelllist button
	local affectspelllistbutton=NPA_Options.Template.CreateButton(page,200,20,Localization["AffectSpellList"])
	affectspelllistbutton:SetPoint("TOPLEFT",counterspelllengthslider,"BOTTOMLEFT",0,-15)
	NPA_Options.Template.SetTooltips(Tooltips["AffectSpellList"],affectspelllistbutton)

	--
	local LoadData=function()
		--	Name=name,
		--School=0,
		--Icon=icon,
		--Class=
		--CastTime=casttime,
		--MinRange=minrange,
		--MaxRange=maxrange,
		--CoolDown=0,
		--CoolDownStack=0,
		--CoolDownType=0
		--Length=0,
		--MaxStack=0,
		--Catalog=SpellCatalog,
		--PVPLength
		--PVPDRType
		--CounterSpellLength
		--AffectSpellList={}
		local spelldata=NPA_Setting.SpellLib[Spellid]
		--
		spellidlabel2:SetText(Spellid)
		local spellname,_,spellicon=GetSpellInfo(Spellid)
		if(spelldata.NewName=="")then
			spellnameedit:SetText(spellname or "N/A")
		else 
			spellnameedit:SetText(spelldata.NewName)
		end
		if(spelldata.NewIcon=="")then
			icontexture:SetTexture(spellicon)
		else 
			icontexture:SetTexture(spelldata.NewIcon)
		end
		--
		NPA_Options.Template.SetSliderEdit(casttimeslider,spelldata.CastTime)
		NPA_Options.Template.SetSliderEdit(minrangeslider,spelldata.MinRange)
		NPA_Options.Template.SetSliderEdit(maxrangeslider,spelldata.MaxRange)
		NPA_Options.Template.SetSliderEdit(cooldownslider,spelldata.CoolDown)
		NPA_Options.Template.SetSliderEdit(cooldownstackslider,spelldata.CoolDownStack)
		NPA_Options.Template.SetSliderEdit(lengthslider,spelldata.Length)
		NPA_Options.Template.SetSliderEdit(maxstackslider,spelldata.MaxStack)
		NPA_Options.Template.SetSliderEdit(pvplengthslider,spelldata.PVPLength)
		NPA_Options.Template.SetSliderEdit(counterspelllengthslider,spelldata.CounterSpellLength)
		--
		NPA_Options.Template.SetDropDownEditor(spelliconedit,spelldata.NewIcon)
		NPA_Options.Template.SetDropDownEditor(spellclassedit,spelldata.SpellType)
		NPA_Options.Template.SetDropDownEditor(catalogedit,spelldata.Catalog)
		NPA_Options.Template.SetDropDownEditor(drtypeedit,spelldata.PVPDRType)
		NPA_Options.Template.SetDropDownEditor(cooldowntypeselector,spelldata.CoolDownType)
		--
		NPA_Options.Template.SetCheckBox(nodrcheckbox,spelldata.NoDR)
		NPA_Options.Template.SetCheckBox(isshieldcheckbox,spelldata.IsShield)
		--school checker
		local school=spelldata.School
		--local SpellSchoolMask={
		--	["Physic"]=1,
		--	["Holy"]=2,
		--	["Fire"]=4,
		--	["Nature"]=8,
		--	["Frost"]=16,
		--	["Shadow"]=32,
		--	["Arcane"]=64,
		--}
		if(bit_band(school,1)>0)then
			NPA_Options.Template.SetCheckBox(physicchecker,true)
		else
			NPA_Options.Template.SetCheckBox(physicchecker,false)
		end
		if(bit_band(school,2)>0)then
			NPA_Options.Template.SetCheckBox(holychecker,true)
		else
			NPA_Options.Template.SetCheckBox(holychecker,false)
		end
		if(bit_band(school,4)>0)then
			NPA_Options.Template.SetCheckBox(firechecker,true)
		else
			NPA_Options.Template.SetCheckBox(firechecker,false)
		end
		if(bit_band(school,8)>0)then
			NPA_Options.Template.SetCheckBox(naturechecker,true)
		else
			NPA_Options.Template.SetCheckBox(naturechecker,false)
		end
		if(bit_band(school,16)>0)then
			NPA_Options.Template.SetCheckBox(frostchecker,true)
		else
			NPA_Options.Template.SetCheckBox(frostchecker,false)
		end
		if(bit_band(school,32)>0)then
			NPA_Options.Template.SetCheckBox(shadowchecker,true)
		else
			NPA_Options.Template.SetCheckBox(shadowchecker,false)
		end
		if(bit_band(school,64)>0)then
			NPA_Options.Template.SetCheckBox(arcanechecker,true)
		else
			NPA_Options.Template.SetCheckBox(arcanechecker,false)
		end
		--
		AffectSpellList=CopyTable(spelldata.AffectSpellList)
	end
	local SaveData=function()
		local spelldata=NPA_Setting.SpellLib[Spellid]
		--
		local spellname,_,spellicon=GetSpellInfo(Spellid)
		spelldata.NewName=spellnameedit:GetText()
		if(spelldata.NewName=="" or spelldata.NewName==spellname)then
			spelldata.NewName=""
			spellnameedit:SetText(spellname)
		end
		spelldata.NewIcon=spelliconedit.Value
		if(spelldata.NewIcon=="" or spelldata.NewIcon==spellicon)then
			spelldata.NewIcon=""
			spelliconedit:SetText(spellicon)
		end
		--
		spelldata.CastTime=casttimeslider.Value
		spelldata.MinRange=minrangeslider.Value
		spelldata.MaxRange=maxrangeslider.Value
		spelldata.CoolDown=cooldownslider.Value
		spelldata.CoolDownStack=cooldownstackslider.Value
		spelldata.Length=lengthslider.Value
		spelldata.MaxStack=maxstackslider.Value
		spelldata.PVPLength=pvplengthslider.Value
		spelldata.CounterSpellLength=counterspelllengthslider.Value
		--
		spelldata.SpellType=spellclassedit.Value
		spelldata.Catalog=catalogedit.Value
		spelldata.PVPDRType=drtypeedit.Value
		spelldata.CoolDownType=cooldowntypeselector.Value
		--
		spelldata.NoDR=nodrcheckbox.Checked
		spelldata.IsShield=isshieldcheckbox.Checked

		--school checker
		local school=0
		--local SpellSchoolMask={
		--	["Physic"]=1,
		--	["Holy"]=2,
		--	["Fire"]=4,
		--	["Nature"]=8,
		--	["Frost"]=16,
		--	["Shadow"]=32,
		--	["Arcane"]=64,
		--}
		if(physicchecker.Checked==true)then
			school=school+1
		end
		if(holychecker.Checked==true)then
			school=school+2
		end
		if(firechecker.Checked==true)then
			school=school+4
		end
		if(naturechecker.Checked==true)then
			school=school+8
		end
		if(frostchecker.Checked==true)then
			school=school+16
		end
		if(shadowchecker.Checked==true)then
			school=school+32
		end
		if(arcanechecker.Checked==true)then
			school=school+64
		end
		--
		spelldata.School=school
		spelldata.AffectSpellList=CopyTable(AffectSpellList)

		--fire event
		NPA.EventHandler.FireEvent(6,"SettingManager_RefreshSpellInfo")

		NPA_Options.RunFunc(RefreshFunc,Spellid)
	end
	--
	savebutton:HookScript("OnMouseUp",SaveData)
	cancelbutton:HookScript("OnMouseUp",LoadData)
	affectspelllistbutton:HookScript("OnMouseUp",function()
		NPA_Options.SetPage("SpellEditorAffectList",main,AffectSpellList)
	end)

	main.OnSetFunc=function(spellid,refreshfunc)
		Spellid=spellid
		RefreshFunc=refreshfunc
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("SpellEditor",main)

end)