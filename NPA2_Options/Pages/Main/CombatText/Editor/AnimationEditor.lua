-- Author      : Nogarder
-- Create Date : 2013/4/24 17:41:20
NPA_Options.RegisterPageFunc("CombatTextAnimationEditor",function()

	local pairs=pairs
	local CopyTable=CopyTable
	local table_insert=table.insert
	local table_getn=table.getn
	--
	local Localization=NPA_Options.Localization.PagesCombatText
	local Tooltips=Localization.Tooltips
	--
	local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["Animation"],210,560,nil,nil,nil)
	main:Hide()
	local page=main.Frame
	--
	--elements
	local step=-20
	local Entry
	local CheckList={}
	local UpdateFunc
	--save
	local savebutton=NPA_Options.Template.CreateSpecialButton(page,65,15,"Save")
	savebutton:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	--reset
	local resetbutton=NPA_Options.Template.CreateSpecialButton(page,65,15,"Reset")
	resetbutton:SetPoint("TOPRIGHT",page,"TOPRIGHT",-5,-5)
	--cancel
	local cancelbutton=NPA_Options.Template.CreateSpecialButton(page,65,15,"Cancel")
	cancelbutton:SetPoint("LEFT",savebutton,"RIGHT",5,0)
	cancelbutton:SetPoint("RIGHT",resetbutton,"LEFT",-5,0)
	--
	local GetTypeList=function()
		return Localization.SpeedTypeList
	end
	--speed type
	local speedtypeselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["SpeedType"],Tooltips["SpeedType"],GetTypeList)
	speedtypeselector:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,step)
	--speedx slider
	local speedxslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,-100,100,1,0,Localization["SpeedX"],Tooltips["SpeedX"])
	speedxslider:SetPoint("TOPLEFT",speedtypeselector,"BOTTOMLEFT",0,step)
	--speedy slider
	local speedyslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,-100,100,1,0,Localization["SpeedY"],Tooltips["SpeedY"])
	speedyslider:SetPoint("TOPLEFT",speedxslider,"BOTTOMLEFT",0,step)
	--acc type
	local acctypeselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["AccType"],Tooltips["AccType"],GetTypeList)
	acctypeselector:SetPoint("TOPLEFT",speedyslider,"BOTTOMLEFT",0,step)
	--accx slider
	local accxslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,-100,100,1,0,Localization["AccX"],Tooltips["AccX"])
	accxslider:SetPoint("TOPLEFT",acctypeselector,"BOTTOMLEFT",0,step)
	--accy slider
	local accyslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,-100,100,1,0,Localization["AccY"],Tooltips["AccY"])
	accyslider:SetPoint("TOPLEFT",accxslider,"BOTTOMLEFT",0,step)
	--startsize slider
	local startsizeslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0.1,4,0.1,1,Localization["StartSize"],Tooltips["StartSize"])
	startsizeslider:SetPoint("TOPLEFT",accyslider,"BOTTOMLEFT",0,step)
	--endsize slider
	local endsizeslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0.1,4,0.1,1,Localization["EndSize"],Tooltips["EndSize"])
	endsizeslider:SetPoint("TOPLEFT",startsizeslider,"BOTTOMLEFT",0,step)
	--startalpha slider
	local startalphaslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,1,0.1,1,Localization["StartAlpha"],Tooltips["StartAlpha"])
	startalphaslider:SetPoint("TOPLEFT",endsizeslider,"BOTTOMLEFT",0,step)
	--endalpha slider
	local endalphaslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,1,0.1,1,Localization["EndAlpha"],Tooltips["EndAlpha"])
	endalphaslider:SetPoint("TOPLEFT",startalphaslider,"BOTTOMLEFT",0,step)
	--shakerange slider
	local shakerangeslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,10,1,1,Localization["ShakeRange"],Tooltips["ShakeRange"])
	shakerangeslider:SetPoint("TOPLEFT",endalphaslider,"BOTTOMLEFT",0,step)
	--framelevel slider
	local framelevelslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,10,0.1,1,Localization["FrameLevel"],Tooltips["FrameLevel"])
	framelevelslider:SetPoint("TOPLEFT",shakerangeslider,"BOTTOMLEFT",0,step)
	--lasts slider
	local lastsslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,10,0.1,1,Localization["Lasts"],Tooltips["Lasts"])
	lastsslider:SetPoint("TOPLEFT",framelevelslider,"BOTTOMLEFT",0,step)
	--
	local LoadData=function(default)
		--
		local entry
		if(default)then
			--get default directly from setting manager
			entry=NPA.SettingManager.GetDefault("CombatTextAnimation")
		else
			entry=Entry
		end
		--speedtype
		local value=entry.SpeedType
		NPA_Options.Template.SetDropDownEditor(speedtypeselector,value)
		--speedx
		local value=entry.SpeedX
		NPA_Options.Template.SetSliderEdit(speedxslider,value)
		--speedy
		local value=entry.SpeedY
		NPA_Options.Template.SetSliderEdit(speedyslider,value)
		--acctype
		local value=entry.AccType
		NPA_Options.Template.SetDropDownEditor(acctypeselector,value)
		--accx
		local value=entry.AccX
		NPA_Options.Template.SetSliderEdit(accxslider,value)
		--speedy
		local value=entry.AccY
		NPA_Options.Template.SetSliderEdit(accyslider,value)
		--startsize
		local value=entry.StartSize
		NPA_Options.Template.SetSliderEdit(startsizeslider,value)
		--endsize
		local value=entry.EndSize
		NPA_Options.Template.SetSliderEdit(endsizeslider,value)
		--startalpha
		local value=entry.StartAlpha
		NPA_Options.Template.SetSliderEdit(startalphaslider,value)
		--endalpha
		local value=entry.EndAlpha
		NPA_Options.Template.SetSliderEdit(endalphaslider,value)
		--shakerange
		local value=entry.ShakeRange
		NPA_Options.Template.SetSliderEdit(shakerangeslider,value)
		--framelevel
		local value=entry.FrameLevel
		NPA_Options.Template.SetSliderEdit(framelevelslider,value)
		--lasts
		local value=entry.Lasts
		NPA_Options.Template.SetSliderEdit(lastsslider,value)
	end
	--
	local SaveData=function()
		--speedtype
		Entry.SpeedType=speedtypeselector.Value
		--speedx
		Entry.SpeedX=speedxslider.Value
		--speedy
		Entry.SpeedY=speedyslider.Value
		--acctype
		Entry.AccType=acctypeselector.Value
		--accx
		Entry.AccX=accxslider.Value
		--speedy
		Entry.AccY=accyslider.Value
		--startsize
		Entry.StartSize=startsizeslider.Value
		--endsize
		Entry.EndSize=endsizeslider.Value
		--startalpha
		Entry.StartAlpha=startalphaslider.Value
		--endalpha
		Entry.EndAlpha=endalphaslider.Value
		--shakerange
		Entry.ShakeRange=shakerangeslider.Value
		--framelevel
		Entry.FrameLevel=framelevelslider.Value
		--lasts
		Entry.Lasts=lastsslider.Value
		--update
		NPA_Options.RunFunc(UpdateFunc)
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
	--
	main.OnSetFunc=function(entry,updatefunc,index)
		Entry=entry
		UpdateFunc=updatefunc
		main.Scroll.Title:SetText(index)
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("CombatTextAnimationEditor",main)
end)