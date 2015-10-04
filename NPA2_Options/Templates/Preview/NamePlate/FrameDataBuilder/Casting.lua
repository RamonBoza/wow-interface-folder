-- Author      : Nogarder
-- Create Date : 2012/9/3 9:59:00
NPA_Options.RegisterPageFunc("NamePlatePreviewFrameDataCasting",function()

	local CopyTable=CopyTable
	local random=random
	local floor=floor
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	local Tooltips=Localization.Tooltips
	--
	local FrameData
	local RefreshFunc
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["Casting"],160,170,nil)
	main:SetPoint("CENTER",UIParent,"CENTER",0,0)
	main:Hide()
	--
	local page=main.Frame
	--
	local width=150
	local step=-10
	--castingtimeslider
	local castingslider=NPA_Options.Template.CreateSliderEdit(page,120,30,20,1,120,1,0,Localization["CastingMax"])
	castingslider:SetPoint("TOPLEFT",page,"TOPLEFT",5,-20)
	NPA_Options.Template.SetSliderEdit(castingslider,120)
	--channeling checkbox
	local channelingbox=NPA_Options.Template.CreateCheckBox(page,width,20,Localization["Channeling"])
	channelingbox:SetPoint("TOPLEFT",castingslider,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetTooltips(Tooltips["Channeling"],channelingbox)
	--interruptable checkbox
	local interruptablebox=NPA_Options.Template.CreateCheckBox(page,width,20,Localization["NotInterruptable"])
	interruptablebox:SetPoint("TOPLEFT",channelingbox,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetTooltips(Tooltips["Interruptable"],interruptablebox)
	--school dropdown
	local GetSchool=function()
		local data=NPA_Options.Localization.InfoLibSpell.School
		local i=0
		local school={}
		for value,text in pairs(data)do
			i=i+1
			school[i]={
				Text=text,
				Value=value,
				Color=NPA.Color.GetColorBySpellSchool(value)
			}
		end
		return school
	end
	local schooldropdown=NPA_Options.Template.CreateDropDownEditor(page,140,Localization["School"],Tooltips["School"],GetSchool)
	schooldropdown:SetPoint("TOPLEFT",interruptablebox,"BOTTOMLEFT",0,step)
	--placeholder
	--set button
	local setbutton=NPA_Options.Template.CreateButton(page,width,20,Localization["Set"])
	setbutton:SetPoint("TOPLEFT",schooldropdown,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetTooltips(Tooltips["Set"],setbutton,nil,2)
	--
	local SpellSchoolData={
		[0]=1,
		[1]=2,
		[2]=4,
		[3]=8,
		[4]=16,
		[5]=32,
		[6]=64,
	}
	local Refresh=function()
		local castinfo=FrameData.UnitData.CastInfo
		local time=NPA.GetTime()
		castinfo.Name="Test spell one"
		castinfo.Icon="Interface\\Icons\\Trade_Engineering"
		castinfo.StartTime=time
		castinfo.EndTime=time+castingslider.Value
		castinfo.Channeling=channelingbox.Checked
		--place holder
		castinfo.Target=nil
		castinfo.School=schooldropdown.Value
		castinfo.Spellid=nil
		castinfo.NoInterrupt=interruptablebox.Checked
		--debug
		NPA.EventHandler.FireEvent(8,"Casting_Updated",FrameData)
	end
	--
	setbutton:HookScript("OnMouseUp",function()
		Refresh()
	end)
	--
	castingslider.OnValueUpdateFunc=Refresh
	interruptablebox.OnValueUpdateFunc=Refresh
	channelingbox.OnValueUpdateFunc=Refresh
	schooldropdown.OnValueUpdateFunc=Refresh

	--
	main.OnSetFunc=function(parentframe)
		FrameData=parentframe.FrameData
		NPA_Options.Template.SetDropDownEditor(schooldropdown,FrameData.UnitData.CastInfo.School)
	end
	--
	NPA_Options.RegisterPage("NamePlatePreviewFrameDataCasting",main)

end)