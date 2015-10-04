-- Author      : Nogarder
-- Create Date : 2013/4/5 9:57:44
NPA_Options.RegisterPageFunc("NamePlateIconGroupRulesEditor",function()

	local pairs=pairs
	local CopyTable=CopyTable
	local table_insert=table.insert
	local table_getn=table.getn
	--
	local Localization=NPA_Options.Localization.PagesModuleListIconGroupRulesEditor
	local Tooltips=Localization.Tooltips
	--
	local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["IconGroupRulesEdit"],340,500,nil,nil,nil)
	main:Hide()
	local page=main.Frame
	--
	--elements
	local step=-20
	local Rule
	local SpellList
	local SchoolList
	local ModuleList
	--save
	local savebutton=NPA_Options.Template.CreateSpecialButton(page,110,15,"Save")
	savebutton:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	--reset
	local resetbutton=NPA_Options.Template.CreateSpecialButton(page,110,15,"Reset")
	resetbutton:SetPoint("TOPRIGHT",page,"TOPRIGHT",-5,-5)
	--cancel
	local cancelbutton=NPA_Options.Template.CreateSpecialButton(page,110,15,"Cancel")
	cancelbutton:SetPoint("LEFT",savebutton,"RIGHT",5,0)
	cancelbutton:SetPoint("RIGHT",resetbutton,"LEFT",-5,0)
	--filtertype
	local GetFilterType=function()
		return Localization.FilterTypeList
	end
	local filtertypeselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["FilterType"],Tooltips["FilterType"],GetFilterType)
	filtertypeselector:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,step)
	--editlistbutton
	local editlistbutton=NPA_Options.Template.CreateButton(page,200,20,Localization["EditList"])
	editlistbutton:SetPoint("TOPLEFT",filtertypeselector,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["EditList"],editlistbutton)
	--from type
	local GetFromType=function()
		return Localization.FromTypeList
	end
	local fromtypeselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["FromType"],Tooltips["FromType"],GetFromType)
	fromtypeselector:SetPoint("TOPLEFT",editlistbutton,"BOTTOMLEFT",0,step)
	--priority slider
	local priorityslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,8,1,1,Localization["Priority"],Tooltips["Priority"])
	priorityslider:SetPoint("TOPLEFT",fromtypeselector,"BOTTOMLEFT",0,step)
	--width slider
	local widthslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,40,1,20,Localization["Width"],Tooltips["Width"])
	widthslider:SetPoint("TOPLEFT",priorityslider,"BOTTOMLEFT",0,step)
	--height slider
	local heightslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,40,1,20,Localization["Height"],Tooltips["Height"])
	heightslider:SetPoint("TOPLEFT",widthslider,"BOTTOMLEFT",0,step)
	--framelevel
	local framelevelslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,255,1,0,"Layer",true)
	framelevelslider:SetPoint("TOPLEFT",heightslider,"BOTTOMLEFT",0,step)
	--alpha slider
	local alphaslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,1,0.01,1,"Alpha",true)
	alphaslider:SetPoint("TOPLEFT",framelevelslider,"BOTTOMLEFT",0,step)
	--scale slider
	local scaleslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,1,0.01,1,"Scale")
	scaleslider:SetPoint("TOPLEFT",alphaslider,"BOTTOMLEFT",0,step)
	--preview
	local previewframe=NPA_Options.Template.CreateAnchorPreview(page)
	previewframe:SetPoint("TOPLEFT",scaleslider,"BOTTOMLEFT",0,-5)
	previewframe:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT",-5,5)
	--previewtexture
	local previewicongroup=NPA.IconGroupManager.CreateIconGroup(previewframe)
	previewicongroup:SetPoint("CENTER",previewframe,"CENTER",0,0)
	local groupsetting={
		Direction=1,
		PerRow=1,
		Max=1,
		StackMax=100,
		StackMin=0,
		TimeLimit=0,
		GapX=0,
		GapY=0,
	}
	NPA.IconGroupManager.ManageIconGroup(previewicongroup,groupsetting)
	previewicongroup:Show()
	--listeditor
	--modules editor
	local listeditor=NPA_Options.Template.CreateListEditor(nil,nil,120,400,page,nil,nil,main.Scroll)
	listeditor.NoDefault=true
	listeditor:SetPoint("TOPRIGHT",resetbutton,"BOTTOMRIGHT",0,-5)
	listeditor:SetPoint("BOTTOMRIGHT",previewframe,"TOPRIGHT",0,5)
	listeditor:SetWidth(120)
	listeditor.Frame:HookScript("OnMouseDown",page:GetScript("OnMouseDown"))
	listeditor.Frame:HookScript("OnMouseUp",page:GetScript("OnMouseUp"))
	--refresh listeditor
	local RefreshList=function()
		local profiledata={}
		--build data here
		local i=1
		for name,entry in pairs(ModuleList)do
			profiledata[i]={
				Text=name,
				Value=name,
			}
			i=i+1
		end
		NPA_Options.Template.UpdateListEditor(listeditor,profiledata)
	end
	--script
	local SetPreview=function()
		local entry={}
		--filtertype
		entry.FilterType=2
		--priority
		entry.Priority=1
		--from type
		entry.FromType=1
		--width
		entry.Width=widthslider.Value
		--height
		entry.Height=heightslider.Value
		--frame level
		entry.FrameLevel=1
		--alpha
		entry.Alpha=alphaslider.Value
		--scale
		entry.Scale=scaleslider.Value
		--spelllist
		entry.Modules=ModuleList
		--
		NPA.IconGroupManager.ClearIconGroup(previewicongroup)
		NPA.IconGroupManager.InsertIcon(previewicongroup,NPA.GetTime(),NPA.GetTime()+1000,172,"Magic",floor(random(10)),floor(random(10)),entry)
		NPA.IconGroupManager.UpdateGroup(previewicongroup)
		--
		previewicongroup:SetAlpha(alphaslider.Value)
		--
		NPA_Options.Template.SetAnchorPreview(previewframe,"CENTER","CENTER",0,0,previewicongroup.Icons[1])
	end
	--
	local LoadData=function(default)
		local entry
		if(default)then
			--get default directly from setting manager
			entry=NPA.SettingManager.GetDefault("NamePlateIconGroup").DataRules["Debuff"]
		else
			entry=Rule
		end
		--filtertype
		local value=entry.FilterType
		NPA_Options.Template.SetDropDownEditor(filtertypeselector,value)
		--priority
		local value=entry.Priority
		NPA_Options.Template.SetSliderEdit(priorityslider,value)
		--from
		local value=entry.FromType
		NPA_Options.Template.SetDropDownEditor(fromtypeselector,value)
		--width
		local value=entry.Width
		NPA_Options.Template.SetSliderEdit(widthslider,value)
		--height
		local value=entry.Height
		NPA_Options.Template.SetSliderEdit(heightslider,value)
		--framelevel
		local value=entry.FrameLevel
		NPA_Options.Template.SetSliderEdit(framelevelslider,value)
		--alpha
		local value=entry.Alpha
		NPA_Options.Template.SetSliderEdit(alphaslider,value)
		--scale
		local value=entry.Scale
		NPA_Options.Template.SetSliderEdit(scaleslider,value)
		--spelllist
		SpellList=CopyTable(entry.SpellList)
		--schoollist
		SchoolList=CopyTable(entry.SchoolList)
		--modulelist
		ModuleList=CopyTable(entry.Modules)
		--update 
		NPA_Options.RunFunc(filtertypeselector.OnValueUpdateFunc())
		--
		RefreshList()
		--
		SetPreview()
	end
	local SaveData=function()
		local entry=Rule
		--filtertype
		entry.FilterType=filtertypeselector.Value
		--priority
		entry.Priority=priorityslider.Value
		--from type
		entry.FromType=fromtypeselector.Value
		--width
		entry.Width=widthslider.Value
		--height
		entry.Height=heightslider.Value
		--frame level
		entry.FrameLevel=framelevelslider.Value
		--alpha
		entry.Alpha=alphaslider.Value
		--scale
		entry.Scale=scaleslider.Value
		--spelllist
		entry.SpellList=CopyTable(SpellList)
		entry.SchoolList=CopyTable(SchoolList)
		entry.Modules=CopyTable(ModuleList)
		--fire event
		NPA_Options.RunFunc(main.OnValueUpdateFunc)
	end
	--
	savebutton:HookScript("OnMouseUp",function()
		NPA_Options.Animation.ShowFrame(main)
		SaveData()
		SetPreview()
	end)
	cancelbutton:HookScript("OnMouseUp",function()
		SetPreview()
		NPA_Options.Animation.ShowFrame(main)
		LoadData()
		SetPreview()
	end)
	resetbutton:HookScript("OnMouseUp",function()
		NPA_Options.Animation.ShowFrame(main)
		LoadData(true)
		SetPreview()
	end)
	--
	widthslider.OnValueUpdateFunc=SetPreview
	heightslider.OnValueUpdateFunc=SetPreview
	alphaslider.OnValueUpdateFunc=SetPreview
	scaleslider.OnValueUpdateFunc=SetPreview
	--
	filtertypeselector.OnValueUpdateFunc=function()
		NPA_Options.ClosePages(main,true)
		if(filtertypeselector.Value==3)then
			NPA_Options.SetPage("NamePlateIconGroupRulesFilterEditor",main,SpellList,1)
			NPA_Options.Template.EnableButton(editlistbutton)
		elseif(filtertypeselector.Value==4)then
			NPA_Options.SetPage("NamePlateIconGroupRulesFilterEditor",main,SchoolList,2)
			NPA_Options.Template.EnableButton(editlistbutton)
		else
			NPA_Options.Template.DisableButton(editlistbutton)
		end
	end
	editlistbutton:HookScript("OnMouseUp",function()
		if(filtertypeselector.Value==3)then
			NPA_Options.SetPage("NamePlateIconGroupRulesFilterEditor",main,SpellList,1)
		elseif(filtertypeselector.Value==4)then
			NPA_Options.SetPage("NamePlateIconGroupRulesFilterEditor",main,SchoolList,2)
		end
	end)
	--
	--rules list editor
	listeditor.OnCopyFunc=function(oldname,newname)
		ModuleList[newname]=CopyTable(ModuleList[oldname])
		RefreshList()
	end
	listeditor.OnDeleteFunc=function(oldname)
		NPA_Options.ClosePages(main,true)
		ModuleList[oldname]=nil
		RefreshList()
	end
	listeditor.OnRenameFunc=function(oldname,newname)
		ModuleList[newname]=CopyTable(ModuleList[oldname])
		NPA_Options.ClosePages(main,true)
		ModuleList[oldname]=nil
		RefreshList()
	end
	listeditor.OnCreateFunc=function(newname)
		--the default value
		ModuleList[newname]=NPA.SettingManager.GetDefault("NamePlateIconGroup").DataRules["Debuff"].Modules["Icon"]
		RefreshList()
	end
	listeditor.OnClickFunc=function(name,button)
		if(button=="LeftButton")then
			local entry=ModuleList[name]
			NPA_Options.SetPage("NamePlateIconGroupRulesModulesEditor",main,entry,SetPreview)
		end
	end
	--
	listeditor.RefreshFunc=RefreshList
	--
	main.OnSetFunc=function(rule)
		Rule=rule
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("NamePlateIconGroupRulesEditor",main)

end)
