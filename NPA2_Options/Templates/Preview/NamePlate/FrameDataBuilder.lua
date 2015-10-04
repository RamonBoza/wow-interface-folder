-- Author      : Nogarder
-- Create Date : 2012/9/3 10:01:42
NPA_Options.RegisterPageFunc("NamePlatePreviewFrameDataBuilder",function()

	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	local Tooltips=Localization.Tooltips
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["FrameDataBuilder"],100,370,nil)
	main:SetPoint("CENTER",UIParent,"CENTER",0,0)
	main:Hide()
	--
	main.LinkType="BOTTOMLEFT"
	--
	local width=90
	local step=-5
	--
	local page=main.Frame
	--name button
	local namebutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Name"])
	namebutton:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Name"],namebutton,nil,2)
	NPA_Options.SetPageButton(namebutton,"NamePlatePreviewFrameDataName",main,main)
	--health button
	local healthbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Health"])
	NPA_Options.Template.SetTooltips(Tooltips["Health"],healthbutton,nil,2)
	healthbutton:SetPoint("TOP",namebutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(healthbutton,"NamePlatePreviewFrameDataHealth",main,main)
	--level button
	local levelbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Level"])
	NPA_Options.Template.SetTooltips(Tooltips["Level"],levelbutton,nil,2)
	levelbutton:SetPoint("TOP",healthbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(levelbutton,"NamePlatePreviewFrameDataLevel",main,main)
	--Type button
	local typebutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Type"])
	NPA_Options.Template.SetTooltips(Tooltips["Type"],typebutton,nil,2)
	typebutton:SetPoint("TOP",levelbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(typebutton,"NamePlatePreviewFrameDataType",main,main)
	--casting button
	local castingbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Casting"])
	NPA_Options.Template.SetTooltips(Tooltips["Casting"],castingbutton,nil,2)
	castingbutton:SetPoint("TOP",typebutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(castingbutton,"NamePlatePreviewFrameDataCasting",main,main)
	--aura button
	local aurabutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Aura"])
	NPA_Options.Template.SetTooltips(Tooltips["Aura"],aurabutton,nil,2)
	aurabutton:SetPoint("TOP",castingbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(aurabutton,"NamePlatePreviewFrameDataAura",main,main)
	--target button
	local targetbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Target"])
	--NPA_Options.Template.SetTooltips(Tooltips["Target"],targetbutton,nil,2)
	targetbutton:SetPoint("TOP",aurabutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(targetbutton,"NamePlatePreviewFrameDataTarget",main,main)
	--spelllock button
	local spelllockbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["SpellLock"])
	spelllockbutton:SetPoint("TOP",targetbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(spelllockbutton,"NamePlatePreviewFrameDataSpellLock",main,main)
	--summoned button
	local summonedbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Summoned"])
	summonedbutton:SetPoint("TOP",spelllockbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(summonedbutton,"NamePlatePreviewFrameDataSummoned",main,main)
	--quest button
	local questbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Quest"])
	questbutton:SetPoint("TOP",summonedbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(questbutton,"NamePlatePreviewFrameDataQuest",main,main)
	--raidtarget button
	local raidtargetbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["RaidTarget"])
	raidtargetbutton:SetPoint("TOP",questbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(raidtargetbutton,"NamePlatePreviewFrameDataRaidTarget",main,main)
	--cooldown button
	local cooldownbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["CoolDown"])
	cooldownbutton:SetPoint("TOP",raidtargetbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(cooldownbutton,"NamePlatePreviewFrameDataCoolDown",main,main)
	--cc_dr button
	local ccdrbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["CC_DR"])
	ccdrbutton:SetPoint("TOP",cooldownbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(ccdrbutton,"NamePlatePreviewFrameDataCC_DR",main,main)
	--guild button
	local guildbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Guild"])
	guildbutton:SetPoint("TOP",ccdrbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(guildbutton,"NamePlatePreviewFrameDataGuild",main,main)
	--classification button
	local classificationbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Classification"])
	classificationbutton:SetPoint("TOP",guildbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(classificationbutton,"NamePlatePreviewFrameDataClassification",main,main)
	--role button
	local rolebutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Role"])
	rolebutton:SetPoint("TOP",classificationbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(rolebutton,"NamePlatePreviewFrameDataRole",main,main)
	--shield button
	local shieldbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Shield"])
	shieldbutton:SetPoint("TOP",rolebutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(shieldbutton,"NamePlatePreviewFrameDataShield",main,main)
	--range button
	local rangebutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Range"])
	rangebutton:SetPoint("TOP",shieldbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(rangebutton,"NamePlatePreviewFrameDataRange",main,main)

	--
	local Refresh=function()
		local framedata=main.FrameData
		--fire events
		--these would be not necessary
		--NPA.EventHandler.FireEvent(8,"Name_Updated",framedata)
		--NPA.EventHandler.FireEvent(8,"Health_Updated",framedata)
		--NPA.EventHandler.FireEvent(8,"Type_Updated",framedata)
		--NPA.EventHandler.FireEvent(8,"Casting_Updated",framedata)
		--NPA.EventHandler.FireEvent(8,"Level_Updated",framedata)
		--NPA.EventHandler.FireEvent(8,"Aura_Updated",framedata)
		--NPA.EventHandler.FireEvent(8,"Target_Updated",framedata)
		--
		NPA.EventHandler.FireEvent(6,"Resources_ProfileRefresh",true)
		--quest
		framedata.QuestData={
			Name="Test Quest",
			Current=8,
			Max=10,
			Level=UnitLevel("player"),
		}
		--
		NPA.EventHandler.FireEvent(8,"Quest_Updated",framedata)
		--
	end
	--
	local Reset=function()
		local framedata=main.FrameData
		framedata.QuestData={
			Name="Test Quest",
			Current=8,
			Max=10,
			Level=UnitLevel("player"),
		}

		local unitdata=framedata.UnitData
		--name
		unitdata.Name="Test frame name"
		unitdata.PVPName="Full Test frame name"
		unitdata.Server="Test server name"
		--faction
		unitdata.Faction=1
		--type
		unitdata.Type=1
		--class
		unitdata.Class="WARRIOR"
		--level
		unitdata.Level=90
		--threat
		unitdata.Threat=4
		--health
		unitdata.Health=1234567890
		unitdata.HealthMax=1234567890
		--using new table could be slow but it should be ok
		local ntime=NPA.GetTime()
		--cast
		unitdata.CastInfo={
			Name="Test spell one",
			Icon="Interface\\Icons\\Trade_Engineering",
			StartTime=ntime,
			EndTime=ntime+120,
			Channeling=false,
			--place holder
			School=1,
			Spellid=nil,
			NotInterrupt=false
		}
		--aura
		local nTime=NPA.GetTime()
		unitdata.Aura={
			[1]={
				SpellId=172,
				CasterGUID=UnitGUID("player"),
				Count=0,
				AppliedTime=nTime,
				ExpirationTime=nTime+50,
				Sort="Debuff",
				SpellType="Magic",
			}
		}
		--cooldown
		--basicly same as aura
		unitdata.CoolDown={
			[1]={
				SpellId=172,
				CasterGUID=UnitGUID("player"),
				Count=0,
				AppliedTime=nTime,
				EndTime=nTime+50,
				Sort="Debuff",
				SpellType="Magic",
			}
		}
		--ccdr
		unitdata.CC_DR={
			[1]={
				SpellId=172,
				CasterGUID=UnitGUID("player"),
				Count=2,
				AppliedTime=nTime,
				EndTime=nTime+16,
				PVPDRType="Root",
				Sort="Debuff",
				SpellType="Magic",
			}
		}
		--target
		unitdata.TargetGUID=UnitGUID("player")
		unitdata.TargetUpdated=nTime+10000
		--spelllock
		unitdata.SpellLock={}
		--raidtarget
		unitdata.RaidTarget=1
		--guild and npc guild
		unitdata.Guild="Guild name"
		unitdata.NPCGuild="(NPC)Guild name"
		
		--classification
		unitdata.Classification="normal"
		--role
		unitdata.Role="NONE"
		--
		--shield
		unitdata.Shield=unitdata.HealthMax/2
		unitdata.ShieldMax=unitdata.HealthMax
		--range
		unitdata.RangeMin=5
		unitdata.RangeMax=10
		unitdata.RangeExact=0
		unitdata.RangeUpdated=nTime+10000
		--
		unitdata.PowerUpdated=nTime+10000
		unitdata.SpeedUpdated=nTime+10000
		--
		Refresh()
	end
	--
	main.OnSetFunc=function(framedata)
		main.FrameData=framedata
		Reset()
	end
	--
	NPA_Options.RegisterPage("NamePlatePreviewFrameDataBuilder",main)

end)