-- Author      : Nogarder
-- Create Date : 2013/4/27 15:19:13
NPA_Options.RegisterPageFunc("Core",function()
	--localization
	local Localization=NPA_Options.Localization.PagesMainCore
	local Tooltips=Localization.Tooltips
	--
	local parent=NPA_Options.MainFrame
	--main page
	local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,nil,820,430,nil,nil,nil,nil,NPA_Options.MainFrame)
	main:Hide()
	--
	local page=main.Frame
	--
	local ModuleList={}
	local CollectorList={}
	--
	--save
	local savebutton=NPA_Options.Template.CreateSpecialButton(page,133,15,"Save")
	savebutton:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	--reset
	local resetbutton=NPA_Options.Template.CreateSpecialButton(page,133,15,"Reset")
	resetbutton:SetPoint("TOPLEFT",savebutton,"TOPRIGHT",5,0)
	--cancel
	local cancelbutton=NPA_Options.Template.CreateSpecialButton(page,133,15,"Cancel")
	cancelbutton:SetPoint("TOPLEFT",resetbutton,"TOPRIGHT",5,0)
	--
	local nameplatemodulelist=NPA_Options.Template.CreateCheckBoxList(page,170,360)
	nameplatemodulelist.Scroll:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,-25)
	NPA_Options.Template.SetCheckBoxList(nameplatemodulelist)
	--
	local modulelistlabel=page:CreateFontString()
	modulelistlabel:SetFont(GameFontNormal:GetFont())
	modulelistlabel:SetText(Localization["NamePlateModule"])
	modulelistlabel:SetPoint("BOTTOM",nameplatemodulelist.Scroll,"TOP",0,5)
	--
	local datacollectorlist=NPA_Options.Template.CreateCheckBoxList(page,170,340)
	datacollectorlist.Scroll:SetPoint("TOPLEFT",nameplatemodulelist.Scroll,"TOPRIGHT",30,0)
	NPA_Options.Template.SetCheckBoxList(datacollectorlist)
	--
	local datacollectorlabel=page:CreateFontString()
	datacollectorlabel:SetFont(GameFontNormal:GetFont())
	datacollectorlabel:SetText(Localization["DataCollector"])
	datacollectorlabel:SetPoint("BOTTOM",datacollectorlist.Scroll,"TOP",0,5)
	--
	nameplatemodulelist.OnValueUpdateFunc=function(name,checked)
		ModuleList[name]=checked
	end
	--
	datacollectorlist.OnValueUpdateFunc=function(name,checked)
		CollectorList[name]=checked
	end
	--ScrollFrameRender checkbox
	local scrollframerendercheckbox=NPA_Options.Template.CreateCheckBox(page,400,20,Localization["ScrollFrameRender"])
	NPA_Options.Template.SetTooltips(Tooltips["ScrollFrameRender"],scrollframerendercheckbox)
	scrollframerendercheckbox:SetPoint("TOPLEFT",datacollectorlist.Scroll,"TOPRIGHT",30,0)
	--combie pet cooldown checkbox
	local combiepetcooldowncheckbox=NPA_Options.Template.CreateCheckBox(page,195,20,Localization["CombiePetCoolDown"])
	NPA_Options.Template.SetTooltips(Tooltips["CombiePetCoolDown"],combiepetcooldowncheckbox)
	combiepetcooldowncheckbox:SetPoint("TOPLEFT",scrollframerendercheckbox,"BOTTOMLEFT",0,-10)
	local combiemastercooldowncheckbox=NPA_Options.Template.CreateCheckBox(page,195,20,Localization["CombieMasterCoolDown"])
	NPA_Options.Template.SetTooltips(Tooltips["CombieMasterCoolDown"],combiemastercooldowncheckbox)
	combiemastercooldowncheckbox:SetPoint("TOPLEFT",combiepetcooldowncheckbox,"TOPRIGHT",10,0)
	--instant as one second cast
	local instantasonesecondcastcheckbox=NPA_Options.Template.CreateCheckBox(page,400,20,Localization["InstantAsOneSecondCast"])
	NPA_Options.Template.SetTooltips(Tooltips["InstantAsOneSecondCast"],instantasonesecondcastcheckbox)
	instantasonesecondcastcheckbox:SetPoint("TOPLEFT",combiepetcooldowncheckbox,"BOTTOMLEFT",0,-10)
	--icon to school
	local icontoschoolcheckbox=NPA_Options.Template.CreateCheckBox(page,400,20,Localization["IconToSchool"])
	NPA_Options.Template.SetTooltips(Tooltips["IconToSchool"],icontoschoolcheckbox)
	icontoschoolcheckbox:SetPoint("TOPLEFT",instantasonesecondcastcheckbox,"BOTTOMLEFT",0,-10)
	--enable aura cache
	local enableauracachecheckbox=NPA_Options.Template.CreateCheckBox(page,400,20,Localization["EnableAuraCache"])
	NPA_Options.Template.SetTooltips(Tooltips["EnableAuraCache"],enableauracachecheckbox)
	enableauracachecheckbox:SetPoint("TOPLEFT",icontoschoolcheckbox,"BOTTOMLEFT",0,-10)
	--enable advanced type
	local advancedtypecheckbox=NPA_Options.Template.CreateCheckBox(page,400,20,Localization["AdvancdedType"])
	NPA_Options.Template.SetTooltips(Tooltips["AdvancdedType"],advancedtypecheckbox)
	advancedtypecheckbox:SetPoint("TOPLEFT",enableauracachecheckbox,"BOTTOMLEFT",0,-10)
	--enable power match
	local powermatchcheckbox=NPA_Options.Template.CreateCheckBox(page,400,20,Localization["PowerMatch"])
	NPA_Options.Template.SetTooltips(Tooltips["PowerMatch"],powermatchcheckbox)
	powermatchcheckbox:SetPoint("TOPLEFT",advancedtypecheckbox,"BOTTOMLEFT",0,-10)
	--fast party collect
	local fastpartycollectcheckbox=NPA_Options.Template.CreateCheckBox(page,400,20,Localization["FastCollectParty"])
	NPA_Options.Template.SetTooltips(Tooltips["FastCollectParty"],fastpartycollectcheckbox)
	fastpartycollectcheckbox:SetPoint("TOPLEFT",powermatchcheckbox,"BOTTOMLEFT",0,-10)
	--fast raid collect
	local fastraidcollectcheckbox=NPA_Options.Template.CreateCheckBox(page,400,20,Localization["FastCollectRaid"])
	NPA_Options.Template.SetTooltips(Tooltips["FastCollectRaid"],fastraidcollectcheckbox)
	fastraidcollectcheckbox:SetPoint("TOPLEFT",fastpartycollectcheckbox,"BOTTOMLEFT",0,-10)
	--fast arena collect
	local fastarenacollectcheckbox=NPA_Options.Template.CreateCheckBox(page,400,20,Localization["FastCollectArena"])
	NPA_Options.Template.SetTooltips(Tooltips["FastCollectArena"],fastarenacollectcheckbox)
	fastarenacollectcheckbox:SetPoint("TOPLEFT",fastraidcollectcheckbox,"BOTTOMLEFT",0,-10)
	--fast boss collect
	local fastbosscollectcheckbox=NPA_Options.Template.CreateCheckBox(page,400,20,Localization["FastCollectBoss"])
	NPA_Options.Template.SetTooltips(Tooltips["FastCollectBoss"],fastbosscollectcheckbox)
	fastbosscollectcheckbox:SetPoint("TOPLEFT",fastarenacollectcheckbox,"BOTTOMLEFT",0,-10)
	--local petnamematcheckbox=NPA_Options.Template.CreateCheckBox(page,400,20,Localization["PetNameMatch"])
	--NPA_Options.Template.SetTooltips(Tooltips["PetNameMatch"],petnamematcheckbox)
	--petnamematcheckbox:SetPoint("TOPLEFT",advancedtypecheckbox,"BOTTOMLEFT",0,-10)
	--powermatchcheckbox:Hide()
	--spellidintooltips
	local spellcooldowncachecheckbox=NPA_Options.Template.CreateCheckBox(page,400,20,Localization["SpellCoolDownCache"])
	NPA_Options.Template.SetTooltips(Tooltips["SpellCoolDownCache"],spellcooldowncachecheckbox)
	spellcooldowncachecheckbox:SetPoint("TOPLEFT",fastbosscollectcheckbox,"BOTTOMLEFT",0,-10)

	local spellidintooltipscheckbox=NPA_Options.Template.CreateCheckBox(page,400,20,Localization["SpellIDInTooltips"])
	NPA_Options.Template.SetTooltips(Tooltips["SpellIDInTooltips"],spellidintooltipscheckbox)
	spellidintooltipscheckbox:SetPoint("TOPLEFT",spellcooldowncachecheckbox,"BOTTOMLEFT",0,-10)

	--
	local Load=function(default)
		local entry
		if(default)then
			entry=NPA.SettingManager.GetDefault("Core")
		else
			entry=NPA_Setting.Core
		end
		ModuleList=CopyTable(entry.NamePlateModules)
		CollectorList=CopyTable(entry.DataCollectors)
		NPA_Options.Template.UpdateCheckBoxList(nameplatemodulelist,ModuleList,Localization)
		NPA_Options.Template.UpdateCheckBoxList(datacollectorlist,CollectorList,Localization)
		NPA_Options.Template.SetCheckBox(scrollframerendercheckbox,entry.UsingScrollFrameRender)
		NPA_Options.Template.SetCheckBox(combiepetcooldowncheckbox,entry.CombiePetCoolDown)
		NPA_Options.Template.SetCheckBox(combiemastercooldowncheckbox,entry.CombieMasterCoolDown)
		NPA_Options.Template.SetCheckBox(instantasonesecondcastcheckbox,entry.InstantAsOneSecondCast)
		NPA_Options.Template.SetCheckBox(icontoschoolcheckbox,entry.IconToSchool)
		NPA_Options.Template.SetCheckBox(enableauracachecheckbox,entry.EnableAuraCache)
		NPA_Options.Template.SetCheckBox(advancedtypecheckbox,entry.AdvancedType)
		NPA_Options.Template.SetCheckBox(powermatchcheckbox,entry.PowerMatch)
		NPA_Options.Template.SetCheckBox(fastpartycollectcheckbox,entry.FastCollectParty)
		NPA_Options.Template.SetCheckBox(fastraidcollectcheckbox,entry.FastCollectRaid)
		NPA_Options.Template.SetCheckBox(fastarenacollectcheckbox,entry.FastCollectArena)
		NPA_Options.Template.SetCheckBox(fastbosscollectcheckbox,entry.FastCollectBoss)
		--NPA_Options.Template.SetCheckBox(petnamematcheckbox,entry.PetNameMatch)
		NPA_Options.Template.SetCheckBox(spellcooldowncachecheckbox,entry.EnableCoolDownCache)
		NPA_Options.Template.SetCheckBox(spellidintooltipscheckbox,entry.SpellIDInTooltips)
	end
	--
	local Save=function()
		NPA_Setting.Core.NamePlateModules=CopyTable(ModuleList)
		NPA_Setting.Core.DataCollectors=CopyTable(CollectorList)
		NPA_Setting.Core.UsingScrollFrameRender=scrollframerendercheckbox.Checked
		NPA_Setting.Core.CombiePetCoolDown=combiepetcooldowncheckbox.Checked
		NPA_Setting.Core.CombieMasterCoolDown=combiemastercooldowncheckbox.Checked
		NPA_Setting.Core.InstantAsOneSecondCast=instantasonesecondcastcheckbox.Checked
		NPA_Setting.Core.IconToSchool=icontoschoolcheckbox.Checked
		NPA_Setting.Core.EnableAuraCache=enableauracachecheckbox.Checked
		NPA_Setting.Core.AdvancedType=advancedtypecheckbox.Checked
		NPA_Setting.Core.PowerMatch=powermatchcheckbox.Checked
		NPA_Setting.Core.FastCollectParty=fastpartycollectcheckbox.Checked
		NPA_Setting.Core.FastCollectRaid=fastraidcollectcheckbox.Checked
		NPA_Setting.Core.FastCollectArena=fastarenacollectcheckbox.Checked
		NPA_Setting.Core.FastCollectBoss=fastbosscollectcheckbox.Checked
		--NPA_Setting.Core.PetNameMatch=petnamematcheckbox.Checked
		NPA_Setting.Core.EnableCoolDownCache=spellcooldowncachecheckbox.Checked
		NPA_Setting.Core.SpellIDInTooltips=spellidintooltipscheckbox.Checked
		--fire event
		NPA.EventHandler.FireEvent(6,"ProfileManager_ProfileLoaded")
		Load()
	end
	--
	savebutton:HookScript("OnMouseUp",Save)
	resetbutton:HookScript("OnMouseUp",function()
		Load(true)
	end)
	--
	main.OnSetFunc=function()
		Load()
	end
	--
	NPA_Options.RegisterPage("Core",main)
end)
