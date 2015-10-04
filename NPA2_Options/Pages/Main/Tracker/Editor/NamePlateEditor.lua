-- Author      : Nogarder
-- Create Date : 2013/6/6 17:00:06
NPA_Options.RegisterPageFunc("TrackerNameplatesEditor",function()

	local pairs=pairs
	local CopyTable=CopyTable
	local table_insert=table.insert
	local table_getn=table.getn
	--
	local Localization=NPA_Options.Localization.PagesTracker
	local Tooltips=Localization.Tooltips
	--
	local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["Nameplates"],210,385,nil,nil,nil)
	main:Hide()
	local page=main.Frame
	--
	--elements
	local step=-20
	local Entry
	local NameplateList={}
	--save
	local savebutton=NPA_Options.Template.CreateSpecialButton(page,66,15,"Save")
	savebutton:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	--reset
	local resetbutton=NPA_Options.Template.CreateSpecialButton(page,66,15,"Reset")
	resetbutton:SetPoint("TOPRIGHT",page,"TOPRIGHT",-5,-5)
	--cancel
	local cancelbutton=NPA_Options.Template.CreateSpecialButton(page,66,15,"Cancel")
	cancelbutton:SetPoint("LEFT",savebutton,"RIGHT",5,0)
	cancelbutton:SetPoint("RIGHT",resetbutton,"LEFT",-5,0)
	--posx slider
	local posxslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,-100,100,1,1,Localization["PosX"],Tooltips["PosX"])
	posxslider:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,step)
	--posy slider
	local posyslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,-100,100,1,1,Localization["PosY"],Tooltips["PosY"])
	posyslider:SetPoint("TOPLEFT",posxslider,"BOTTOMLEFT",0,step)
	--framelevel
	local framelevelslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,255,1,0,"Layer","Layer",true)
	framelevelslider:SetPoint("TOPLEFT",posyslider,"BOTTOMLEFT",0,step)
	--alpha slider
	local alphaslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,1,0.01,1,"Alpha",true)
	alphaslider:SetPoint("TOPLEFT",framelevelslider,"BOTTOMLEFT",0,step)
	--scale slider
	local scaleslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0.01,2,0.01,1,"Scale")
	scaleslider:SetPoint("TOPLEFT",alphaslider,"BOTTOMLEFT",0,step)
	---group slider
	local groupslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,100,1,1,Localization["NGroup"],Tooltips["NGroup"])
	groupslider:SetPoint("TOPLEFT",scaleslider,"BOTTOMLEFT",0,step)
	--index slider
	local indexslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,100,1,1,Localization["Index"],Tooltips["Index"])
	indexslider:SetPoint("TOPLEFT",groupslider,"BOTTOMLEFT",0,step)
	--time slider
	local timeslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,100,1,1,Localization["MaxTime"],Tooltips["MaxTime"])
	timeslider:SetPoint("TOPLEFT",indexslider,"BOTTOMLEFT",0,step)
	--test button
	local testbutton=NPA_Options.Template.CreateSpecialButton(page,200,20,"Test")
	NPA_Options.Template.SetTooltips(Tooltips["Test"],testbutton,nil,2)
	testbutton:SetPoint("TOPLEFT",timeslider,"BOTTOMLEFT",0,step)
	--
	local LoadData=function(default)
		local entry
		if(default)then
			--get default directly from setting manager
			entry=NPA.SettingManager.GetDefault("TrackerNameplates")
		else
			entry=Entry
		end
		--posx slider
		local value=entry.PosX
		NPA_Options.Template.SetSliderEdit(posxslider,value)
		--posy slider
		local value=entry.PosY
		NPA_Options.Template.SetSliderEdit(posyslider,value)
		--framelevel slider
		local value=entry.FrameLevel
		NPA_Options.Template.SetSliderEdit(framelevelslider,value)
		--alpha slider
		local value=entry.Alpha
		NPA_Options.Template.SetSliderEdit(alphaslider,value)
		--scale slider
		local value=entry.Scale
		NPA_Options.Template.SetSliderEdit(scaleslider,value)
		--group slider
		local value=entry.Group
		NPA_Options.Template.SetSliderEdit(groupslider,value)
		--index slider
		local value=entry.Index
		NPA_Options.Template.SetSliderEdit(indexslider,value)
		--time slider
		local value=entry.TrackTime
		NPA_Options.Template.SetSliderEdit(timeslider,value)
	end
	--
	local SaveData=function()
		--posx slider
		Entry.PosX=posxslider.Value
		--posy slider
		Entry.PosY=posyslider.Value
		--framelevel slider
		Entry.FrameLevel=framelevelslider.Value
		--alpha slider
		Entry.Alpha=alphaslider.Value
		--scale slider
		Entry.Scale=scaleslider.Value
		--group slider
		Entry.Group=groupslider.Value
		--index slider
		Entry.Index=indexslider.Value
		--time slider
		Entry.TrackTime=timeslider.Value
		--fire event
		NPA.EventHandler.FireEvent(6,"Tracker_SettingUpdated")
	end
	--
	savebutton:HookScript("OnMouseUp",function()
		NPA_Options.Animation.ShowFrame(main)
		SaveData()
	end)
	cancelbutton:HookScript("OnMouseUp",function()
		SetPreview()
		NPA_Options.Animation.ShowFrame(main)
		LoadData()
	end)
	resetbutton:HookScript("OnMouseUp",function()
		NPA_Options.Animation.ShowFrame(main)
		LoadData(true)
	end)
	----create a fake nameplate to test it out
	local TestNameplate=NPA.Tracker.CreateTracker()
	TestNameplate:Hide()
	--
	testbutton:HookScript("OnMouseUp",function()
		if(not TestNameplate:IsShown())then
			local framedata=TestNameplate.FrameData
			--
			TestNameplate:ClearAllPoints()
			TestNameplate:SetPoint("CENTER",UIParent,"CENTER",posxslider.Value,posyslider.Value)
			TestNameplate:SetScale(scaleslider.Value)
			TestNameplate:SetAlpha(alphaslider.Value)
			TestNameplate:SetFrameLevel(framelevelslider.Value)
			TestNameplate.Group=groupslider.Value
			TestNameplate.Index=indexslider.Value
			TestNameplate.TimeLimit=timeslider.Value
			--fake unitdata
			local unitdata={}
			--name
			unitdata.Name="Test frame name"
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
					Count=1,
					AppliedTime=nTime,
					EndTime=nTime+16,
					DRType="Root",
					Sort="Debuff",
					SpellType="Magic",
				}
			}
			--target
			unitdata.TargetGUID=UnitGUID("player")
			unitdata.TargetUpdated=nTime+60
			--spelllock
			unitdata.SpellLock={}
			--raidtarget
			unitdata.RaidTarget=1
			--setup
			framedata.UnitData=unitdata
			framedata.Profile=NPA_Setting.NamePlate["Default"]
			--set timer
			local nTime=NPA.GetTime()
			NPA.FrameMacro.SetFrameTimer(TestNameplate,nTime,nTime+TestNameplate.TimeLimit,
				function(nTime,data,frame)
					frame:SetAlpha((data.EndTime-nTime)/data.Length)
				end,
				function(frame)
					frame:Hide()
				end)
			--show it and fire event
			TestNameplate:Show()
			NPA.EventHandler.FireEvent(1,"NamePlate_ProfileChange",framedata,framedata.Profile)
		else
			TestNameplate:Hide()
		end
	end)
	--
	main.OnSetFunc=function(entryname)
		Entry=NPA_Setting.Tracker.Nameplates[entryname]
		TestNameplate:Hide()
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("TrackerNameplatesEditor",main)
end)