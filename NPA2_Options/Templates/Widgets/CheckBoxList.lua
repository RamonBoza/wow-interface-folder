-- Author      : Nogarder
-- Create Date : 2012/4/28 17:59:53
--global
local table_insert=table.insert
local table_getn=table.getn
local table_sort=table.sort
local pairs=pairs
local NPA_SpellInfo_GetSpellInfo=NPA.SpellInfo.GetSpellInfo
--create list
NPA_Options.Template.CreateCheckBoxList=function(parent,width,height,checkboxheight)
	local checkboxlist=NPA_Options.Template.CreateScrollFrame(parent,width,height,true,true)
	local scroll=checkboxlist.Scroll
	scroll:SetWidth(width)
	scroll:SetHeight(height)
	scroll:EnableMouse(false)
	checkboxlist:EnableMouse(false)
	--border
	scroll.Border=NPA_Options.Template.CreateBorder(scroll,nil,nil,nil,nil,6)
	--checklist
	checkboxlist.Checkers={}
	--init
	NPA_Options.Template.SetSlider(scroll.SliderX,0)
	NPA_Options.Template.SetSlider(scroll.SliderY,0)
	checkboxlist.ButtonHeight=checkboxheight or 20
	--
	return checkboxlist
end
--
NPA_Options.Template.SetCheckBoxListFocus=function(checkboxlist,name)
	for i,checker in pairs(checkboxlist.Checkers)do
		if(checker:IsShown() and checker.Name==name)then
			--set slider
			local slider=checkboxlist.Scroll.SliderY
			if(slider:IsShown())then
				NPA_Options.Template.SetSlider(slider,(checkboxlist.ButtonHeight*(i-1)))
			end
			--
			return
		end
	end
	NPA_Options.Template.SetSlider(checkboxlist.Scroll.SliderY,1)
end
---
local NPA_Options_Template_CheckBoxList_CreateCheckBox=function(checkboxlist)
	local checkbox=NPA_Options.Template.CreateCheckBox(checkboxlist,checkboxlist:GetWidth()-8,15,nil,true)
	--
	NPA_Options.RunFunc(checkboxlist.OnCheckBoxCreateFunc,checkbox)
	--
	checkbox.OnValueUpdateFunc=function(self)
		if(checkboxlist.Value)then
			checkboxlist.Value[self.Name]=self.Checked
		end
		NPA_Options.RunFunc(checkboxlist.OnValueUpdateFunc,self.Name,self.Checked,self)
	end
	checkbox:HookScript("OnEnter",function(self)
		NPA_Options.RunFunc(checkboxlist.OnEnterFunc,self.Name)
	end)
	checkbox:HookScript("OnLeave",function(self)
		NPA_Options.RunFunc(checkboxlist.OnLeaveFunc,self.Name)
	end)
	return checkbox
end
--list
NPA_Options.Template.UpdateCheckBoxListByData=function(checkboxlist,data,dontsort)
	local scroll=checkboxlist.Scroll
	local data=CopyTable(data)
	--data={
	--	[index]={
	--		Text=<checkbox text>,
	--		Name
	--		Value
	--		Func=<checkbox on click func>,
	--		Tooltips=<>,
	--		Disabled=<>
	--		Offset=
	--}
	--sort by alphabet
	if(not dontsort)then
		table_sort(data,function(a,b)
			if(a.Offset)then
				return a.Name<b.Name
			else
				return a.Text<b.Text
			end
		end)
	end
	--set display
	local i=1
	local maxwidth=scroll:GetWidth()
	local checkboxheight=checkboxlist.ButtonHeight-5
	local step=checkboxlist.ButtonHeight
	local checkboxs=checkboxlist.Checkers
	local max=table_getn(data)
	--set frame height
	local height=step*max+10
	if(height<scroll:GetHeight())then
		height=scroll:GetHeight()
	end
	checkboxlist:SetHeight(height)
	----
	--local dcount=(scroll:GetHeight() -10)/step -1
	--if(max>dcount)then
	--	max=dcount
	--end
	--
	for i=1,max do
		local unit=data[i]
		if(not checkboxs[i])then
			checkboxs[i]=NPA_Options_Template_CheckBoxList_CreateCheckBox(checkboxlist)
		end
		--
		local offset=unit.Offset or 0
		--
		local checkbox=checkboxs[i]
		checkbox:SetPoint("BOTTOMLEFT",checkboxlist,"TOPLEFT",5+offset,-(step*i))
		checkbox:SetPoint("BOTTOMRIGHT",checkboxlist,"TOPRIGHT",-5,-(step*i))
		checkbox.Label:SetText(unit.Text)
		checkbox.Text=unit.Text
		--
		if(unit.Disabled)then
			NPA_Options.Template.DisableButton(checkbox)
		else
			NPA_Options.Template.EnableButton(checkbox)
		end
		NPA_Options.Template.SetTooltips(unit.Tooltips,checkbox,nil,nil,scroll)
		--preview
		NPA_Options.Template.SetCheckBoxPreview(checkbox,unit)
		--value
		checkbox.Name=unit.Name
		NPA_Options.Template.SetCheckBox(checkbox,unit.Value)
		--
		NPA_Options.RunFunc(checkboxlist.OnCheckBoxUpdateFunc,checkbox,unit)
		--
		checkbox:Show()
		--
		local width=checkbox.Label:GetStringWidth()+40+checkboxheight+offset
		if(maxwidth<width)then
			maxwidth=width
		end
	end
	for i=max+1,table_getn(checkboxs)do
		checkboxs[i]:Hide()
	end
	--set frame width and height
	checkboxlist:SetWidth(maxwidth)
	--
	--set button width
	for i=1,max do
		checkboxs[i]:SetWidth(maxwidth)
		NPA_Options.Template.SetCheckBoxSize(checkboxs[i],maxwidth,checkboxheight,1)
	end
	--
	scroll.SliderX.Value=1
	scroll.SliderY.Value=1
	--update scrollframe
	NPA_Options.Template.UpdateScrollFrame(checkboxlist)
end

--on set
NPA_Options.Template.SetCheckBoxList=function(checkboxlist,checkboxheight,onvalueupdatefunc,onenterfunc,onleavefunc)
	local scroll=checkboxlist.Scroll
	--data={
	--	[index]={
	--		Text=<checkbox text>,
	--		Func=<checkbox on click func>,
	--		Tooltips=<>,
	--		Disabled=<>}
	checkboxlist.OnValueUpdateFunc=onvalueupdatefunc
	checkboxlist.OnEnterFunc=onenterfunc
	checkboxlist.OnLeaveFunc=onleavefunc
	--
	NPA_Options.Template.SetSlider(scroll.SliderX,0)
	NPA_Options.Template.SetSlider(scroll.SliderY,0)
	--init
	checkboxlist.ButtonHeight=checkboxheight or 20
end

--macro for update a spell checkbox list
NPA_Options.Template.UpdateSpellCheckBoxList=function(spellcheckboxlist,list)
	local data={}
	local spelllist
	if(list)then
		spellcheckboxlist.Value=CopyTable(list)
	end
	spelllist=spellcheckboxlist.Value
	--
	for spellid,enable in pairs(spelllist)do
		local spelldata=NPA_SpellInfo_GetSpellInfo(spellid)
		table_insert(data,{
			Name=spellid,
			Text=(spelldata.Name or "").." ("..spellid..")",
			TextureFile=spelldata.Icon,
			Spellid=spellid,
			Value=enable,
		})
	end
	NPA_Options.Template.UpdateCheckBoxListByData(spellcheckboxlist,data)
end
--
--macro for update usual checkbox list
NPA_Options.Template.UpdateCheckBoxList=function(checkboxlist,list,Localization,tooltips)
	local localization=Localization or {}
	local data={}
	local spelllist
	if(list)then
		spelllist=list
		checkboxlist.Value=list
	else
		spelllist=checkboxlist.Value
	end
	for name,enable in pairs(spelllist)do
		table_insert(data,{
			Name=name,
			Text=localization[name] or name,
			Tooltips=(tooltips or {})[name] or (localization.Tooltips or {})[name],
			Value=enable,
		})
	end
	NPA_Options.Template.UpdateCheckBoxListByData(checkboxlist,data)
end
--macro for create a spell checkbox list
NPA_Options.Template.CreateSpellCheckBoxList=function(parent,width,height,main,withlookup)
	local spellcheckboxlist=NPA_Options.Template.CreateCheckBoxList(parent,width,height)
	spellcheckboxlist.Value={}
	--
	local buttonwidth
	if(withlookup)then
		buttonwidth=width/3-5
	else
		buttonwidth=width/2-5
	end

	--add button
	local addbutton=NPA_Options.Template.CreateSpecialButton(spellcheckboxlist.Scroll,buttonwidth,20,"Add")
	addbutton:SetPoint("BOTTOMLEFT",spellcheckboxlist.Scroll,"TOPLEFT",0,5)
	addbutton:HookScript("OnMouseUp",function()
		--set up spell picker
		NPA_Options.SetPage("SpellPicker",main,spellcheckboxlist.Value,function(name,checked)
			--callback function
			if(checked)then
				spellcheckboxlist.Value[name]=checked
			else
				spellcheckboxlist.Value[name]=nil
			end
			NPA_Options.Template.UpdateSpellCheckBoxList(spellcheckboxlist)
			NPA_Options.RunFunc(spellcheckboxlist.OnValueUpdateFunc,name,checked)
		end)
	end)
	--remove button
	local removebutton=NPA_Options.Template.CreateSpecialButton(spellcheckboxlist.Scroll,buttonwidth,20,"Remove")
	removebutton:SetPoint("BOTTOMRIGHT",spellcheckboxlist.Scroll,"TOPRIGHT",0,5)
	removebutton:HookScript("OnMouseUp",function()
		--remove checker
		for name,value in pairs(spellcheckboxlist.Value)do
			if(value==false)then
				spellcheckboxlist.Value[name]=nil
				NPA_Options.RunFunc(spellcheckboxlist.OnValueUpdateFunc,name,nil)
			end
		end
		NPA_Options.Template.UpdateSpellCheckBoxList(spellcheckboxlist)
	end)
	if(withlookup)then
		--lookup button
		local lookupbutton=NPA_Options.Template.CreateSpecialButton(spellcheckboxlist.Scroll,buttonwidth,20,"LookUp")
		lookupbutton:SetPoint("BOTTOM",spellcheckboxlist.Scroll,"TOP",0,5)
		lookupbutton:HookScript("OnMouseUp",function()
			--set up spell lookup
			NPA_Options.SetPage("SpellLookUp",main,"",function(name)
				spellcheckboxlist.Value[name]=true
				NPA_Options.Template.UpdateSpellCheckBoxList(spellcheckboxlist)
				NPA_Options.RunFunc(spellcheckboxlist.OnValueUpdateFunc,name,true)
			end)
		end)
	end
	--
	return spellcheckboxlist
end
--
