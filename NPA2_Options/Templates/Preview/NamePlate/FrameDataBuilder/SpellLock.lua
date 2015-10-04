-- Author      : Nogarder
-- Create Date : 2013/4/17 13:55:00
NPA_Options.RegisterPageFunc("NamePlatePreviewFrameDataSpellLock",function()

	local CopyTable=CopyTable
	local random=random
	local floor=floor
	local table_getn=table.getn
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	local Tooltips=Localization.Tooltips
	--
	local FrameData
	local RefreshFunc
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["SpellLock"],210,110,nil)
	main:SetPoint("CENTER",UIParent,"CENTER",0,0)
	main:Hide()
	--
	local page=main.Frame
	--
	local width=200
	local step=-10
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
	schooldropdown:SetPoint("TOPLEFT",page,"TOPLEFT",5,-15)
	--time length slider
	local timelengthslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,100,1,0,Localization["TimeLength"])
	timelengthslider:SetPoint("TOPLEFT",schooldropdown,"BOTTOMLEFT",0,-20)
	NPA_Options.Template.SetSliderEdit(timelengthslider,50)
	--set button
	local setbutton=NPA_Options.Template.CreateButton(page,width,20,Localization["Set"])
	setbutton:SetPoint("TOPLEFT",timelengthslider,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetTooltips(Tooltips["Set"],setbutton,nil,2)
	--
	setbutton:HookScript("OnMouseUp",function()
		--add data
		local spelllock=FrameData.UnitData.SpellLock
		spelllock[schooldropdown.Value]=NPA.GetTime()+timelengthslider.Value
		--fire event
		NPA.EventHandler.FireEvent(8,"SpellLock_Updated",FrameData)
	end)
	--
	main.OnSetFunc=function(parentframe)
		FrameData=parentframe.FrameData
		NPA_Options.Template.SetDropDownEditor(schooldropdown,1)
	end
	--
	NPA_Options.RegisterPage("NamePlatePreviewFrameDataSpellLock",main)
end)