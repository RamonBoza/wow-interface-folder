-- Author      : Nogarder
-- Create Date : 2013/4/2 11:41:24
NPA_Options.RegisterPageFunc("NamePlateIconGroupEditor",function()

	local pairs=pairs
	local CopyTable=CopyTable
	local table_insert=table.insert
	local table_getn=table.getn
	--
	local Localization=NPA_Options.Localization.PagesModuleListIconGroupEditor
	local Tooltips=Localization.Tooltips
	--
	local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["IconGroupEdit"],340,720,nil,nil,nil)
	main:Hide()
	local page=main.Frame
	--
	--elements
	local step=-20
	local Entry
	local Rules
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
	--datatype
	local datatypeselector=NPA_Options.Template.CreateDataTypeList(page,200,"IconGroup")
	datatypeselector:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,step)
	--rules button
	local rulesbutton=NPA_Options.Template.CreateButton(page,width,20,Localization["EditRules"])
	rulesbutton:SetPoint("TOPLEFT",datatypeselector,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetTooltips(Tooltips["EditRules"],rulesbutton,nil,2)
	--perrow slider
	local perrowslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,8,1,1,Localization["PerRow"],Tooltips["PerRow"])
	perrowslider:SetPoint("TOPLEFT",datatypeselector,"BOTTOMLEFT",0,step)
	--max slider
	local maxslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,16,1,1,Localization["Max"],Tooltips["Max"])
	maxslider:SetPoint("TOPLEFT",perrowslider,"BOTTOMLEFT",0,step)
	--direction dropdown
	local GetDirection=function()
		return Localization.DirectionList
	end
	local directionselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["Direction"],Tooltips["Direction"],GetDirection)
	directionselector:SetPoint("TOPLEFT",maxslider,"BOTTOMLEFT",0,-25)
	--time limit slider
	local timelimitslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,60,1,0,Localization["TimeLimit"],Tooltips["TimeLimit"])
	timelimitslider:SetPoint("TOPLEFT",directionselector,"BOTTOMLEFT",0,step)
	--min stack
	local minstackslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,10,1,0,Localization["MinStack"],Tooltips["MinStack"])
	minstackslider:SetPoint("TOPLEFT",timelimitslider,"BOTTOMLEFT",0,step)
	--max stack
	local maxstackslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,10,1,0,Localization["MaxStack"],Tooltips["MaxStack"])
	maxstackslider:SetPoint("TOPLEFT",minstackslider,"BOTTOMLEFT",0,step)
	--gapx slider
	local gapxslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,40,1,2,Localization["GapX"],Tooltips["GapX"])
	gapxslider:SetPoint("TOPLEFT",maxstackslider,"BOTTOMLEFT",0,step)
	--gapy slider
	local gapyslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,40,1,2,Localization["GapY"],Tooltips["GapY"])
	gapyslider:SetPoint("TOPLEFT",gapxslider,"BOTTOMLEFT",0,step)
	--
	--anchor frame
	local anchorframeselector=NPA_Options.Template.CreateAnchorFrameList(page,200)
	anchorframeselector:SetPoint("TOPLEFT",gapyslider,"BOTTOMLEFT",0,step)
	--framelevel
	local framelevelslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,255,1,0,"Layer",true)
	framelevelslider:SetPoint("TOPLEFT",anchorframeselector,"BOTTOMLEFT",0,step)
	--alpha slider
	local alphaslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0,1,0.01,1,"Alpha",true)
	alphaslider:SetPoint("TOPLEFT",framelevelslider,"BOTTOMLEFT",0,step)
	--scale slider
	local scaleslider=NPA_Options.Template.CreateSpecialSliderEdit(page,150,50,20,0.01,2,0.01,1,"Scale")
	scaleslider:SetPoint("TOPLEFT",alphaslider,"BOTTOMLEFT",0,step)
	--anchor editor
	local anchoreditbutton=NPA_Options.Template.CreateSpecialButton(page,200,20,"EditAnchor")
	anchoreditbutton.Value={}
	anchoreditbutton:SetPoint("TOPLEFT",scaleslider,"BOTTOMLEFT",0,step)
	--preview
	local previewframe=NPA_Options.Template.CreateAnchorPreview(page)
	previewframe:SetPoint("TOPLEFT",anchoreditbutton,"BOTTOMLEFT",0,-5)
	previewframe:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT",-5,5)
	--listeditor
	--icon group rules editor
	local listeditor=NPA_Options.Template.CreateListEditor(nil,nil,120,640,page,nil,nil,main.Scroll)
	listeditor.NoDefault=true
	listeditor:SetPoint("TOPRIGHT",resetbutton,"BOTTOMRIGHT",0,-5)
	listeditor:SetPoint("BOTTOMRIGHT",previewframe,"TOPRIGHT",0,5)
	listeditor:SetWidth(120)
	listeditor.Frame:HookScript("OnMouseDown",page:GetScript("OnMouseDown"))
	listeditor.Frame:HookScript("OnMouseUp",page:GetScript("OnMouseUp"))
	--script
	local SetPreview=function()
		local anchordata=anchoreditbutton.Value
		NPA_Options.Template.SetAnchorPreview(previewframe,anchordata.From,anchordata.To,anchordata.OffsetX,anchordata.OffsetY,previewtext)
	end
	local RefreshPreview=function()
		NPA_Options.HideTemplates()
		--close anchor editor
		NPA_Options.ClosePages(main,true)
	end
	--
	local EntryName=""
	local LoadData=function(default)
		--
		local entry
		if(default)then
			--get default directly from setting manager
			entry=NPA.SettingManager.GetDefaultProfile("Default")["Default"]["NamePlate"]["Default"]["IconGroupSetting"][EntryName] or NPA.SettingManager.GetDefault("NamePlateIconGroup")
		else
			entry=Entry
		end
		--
		local value=entry.DataType
		NPA_Options.Template.SetDropDownEditor(datatypeselector,value)
		--anchorframe
		local value=entry.AnchorFrame
		NPA_Options.Template.SetDropDownEditor(anchorframeselector,value)
		--frame level
		local value=entry.FrameLevel
		NPA_Options.Template.SetSliderEdit(framelevelslider,value)
		--anchor
		local value=entry.FrameAnchorData
		anchoreditbutton.Value=CopyTable(value)
		--alpha
		local value=entry.Alpha
		NPA_Options.Template.SetSliderEdit(alphaslider,value)
		--scale
		local value=entry.Scale
		NPA_Options.Template.SetSliderEdit(scaleslider,value)
		--perrow
		local value=entry.PerRow
		NPA_Options.Template.SetSliderEdit(perrowslider,value)
		--max
		local value=entry.Max
		NPA_Options.Template.SetSliderEdit(maxslider,value)
		--direction
		local value=entry.Direction
		NPA_Options.Template.SetDropDownEditor(directionselector,value)
		--timelimit
		local value=entry.TimeLimit
		NPA_Options.Template.SetSliderEdit(timelimitslider,value)
		--minstack
		local value=entry.StackMin
		NPA_Options.Template.SetSliderEdit(minstackslider,value)
		--maxstack
		local value=entry.StackMax
		NPA_Options.Template.SetSliderEdit(maxstackslider,value)
		--gapx
		local value=entry.GapX
		NPA_Options.Template.SetSliderEdit(gapxslider,value)
		--gapy
		local value=entry.GapY
		NPA_Options.Template.SetSliderEdit(gapyslider,value)
		--rules
		Rules=CopyTable(entry.DataRules)
		--
		RefreshPreview()
		SetPreview()
	end
	local SaveData=function()
		local entry=Entry
		--datatype
		entry.DataType=datatypeselector.Value
		--anchorframe
		entry.AnchorFrame=anchorframeselector.Value
		--frame level
		entry.FrameLevel=framelevelslider.Value
		--anchor
		entry.FrameAnchorData=CopyTable(anchoreditbutton.Value)
		--alpha
		entry.Alpha=alphaslider.Value
		--scale
		entry.Scale=scaleslider.Value
		--perrow
		entry.PerRow=perrowslider.Value
		--max
		entry.Max=maxslider.Value
		--direction
		entry.Direction=directionselector.Value
		--timelimit
		entry.TimeLimit=timelimitslider.Value
		--min stack
		entry.StackMin=minstackslider.Value
		--max stack
		entry.StackMax=maxstackslider.Value
		--gapx
		entry.GapX=gapxslider.Value
		--gapy
		entry.GapY=gapyslider.Value
		--rules
		entry.DataRules=CopyTable(Rules)
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
	anchoreditbutton:HookScript("OnMouseUp",function()
		local entry=anchoreditbutton.Value
		NPA_Options.SetPage("AnchorEditor",main,entry,SetPreview)
	end)
	--
	rulesbutton:HookScript("OnMouseUp",function()
		--set rules editor
		NPA_Options.SetPage("NamePlateIconGroupRulesEditor",main,Rules)
	end)
	--rules list editor
	listeditor.OnCopyFunc=function(oldname,newname)
		Rules[newname]=CopyTable(Rules[oldname])
	end
	listeditor.OnDeleteFunc=function(oldname)
		NPA_Options.ClosePages(main,true)
		Rules[oldname]=nil
	end
	listeditor.OnRenameFunc=function(oldname,newname)
		Rules[newname]=CopyTable(Rules[oldname])
		NPA_Options.ClosePages(main,true)
		Rules[oldname]=nil
	end
	listeditor.OnCreateFunc=function(newname)
		--the default value
		Rules[newname]=NPA.SettingManager.GetDefault("NamePlateIconGroup").DataRules["Debuff"]
	end
	listeditor.OnClickFunc=function(name,button)
		if(button=="LeftButton")then
			local entry=Rules[name]
			NPA_Options.SetPage("NamePlateIconGroupRulesEditor",main,entry)
		end
	end
	listeditor.RefreshFunc=function()
		local rulesdata={}
		--build data here
		local i=1
		for name,entry in pairs(Rules)do
			rulesdata[i]={
				Text=name,
				Value=name,
			}
			i=i+1
		end
		NPA_Options.Template.UpdateListEditor(listeditor,rulesdata)
	end
	--
	main.OnSetFunc=function(entry,onvalueupdatefunc,entryname)
		Entry=entry
		EntryName=entryname or ""
		main.OnValueUpdateFunc=onvalueupdatefunc
		--
		LoadData()
	end
	--
	NPA_Options.RegisterPage("NamePlateIconGroupEditor",main)

end)