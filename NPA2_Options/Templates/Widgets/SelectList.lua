-- Author      : Nogarder
-- Create Date : 2012/4/28 17:59:53
--global
local table_insert=table.insert
local table_sort=table.sort
local table_getn=table.getn
local pairs=pairs
local string_gsub=string.gsub
local string_len=string.len
local string_find=string.find
local CopyTable=CopyTable
--
local NPA_Options_Template_SelectList_SelectedColor="|cff00ff00"
local NPA_Options_Template_SelectList_UnSelectedColor="|cffffffff"
--
local NPA_Options_Template_SelectList_SetFocusBox=function(focusbox,button)
	focusbox.Name=button.Text
	focusbox:ClearAllPoints()
	focusbox:SetPoint("TOPLEFT",button,"TOPLEFT",-2,2)
	focusbox:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",2,-2)
	focusbox:Show()
end
--main
local NPA_Options_Template_SelectList_CreateButton=function(selectlist)
	local button=NPA_Options.Template.CreateButton(selectlist,selectlist:GetWidth()-8,15,nil)
	if(selectlist.WithAddButton)then
		--delete button
		button.DeleteButton=NPA_Options.Template.CreateButton(button,nil,nil,"x")
		button.DeleteButton:SetPoint("TOPLEFT",button,"TOPLEFT",0,0)
		button.DeleteButton:SetPoint("BOTTOMLEFT",button,"BOTTOMLEFT",0,0)
		button.DeleteButton:SetWidth(10)
		button.DeleteButton:HookScript("OnMouseUp",function()
			NPA_Options.RunFunc(selectlist.OnDeleteFunc,button.Value)
		end)
		--copy button
		button.CopyButton=NPA_Options.Template.CreateButton(button,nil,nil,"+")
		button.CopyButton:SetPoint("TOPRIGHT",button,"TOPRIGHT",0,0)
		button.CopyButton:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",0,0)
		button.CopyButton:SetWidth(10)
		button.CopyButton:HookScript("OnMouseUp",function()
			NPA_Options.RunFunc(selectlist.OnCopyFunc,button.Value)
		end)
	end
	button:HookScript("OnMouseUp",function(self,button)
		local parent=self:GetParent().Scroll
		parent.Value=self.Value
		--run clickfunc
		NPA_Options.RunFunc(parent.ButtonClickFunc,self,button)
		--
		if(selectlist.EditBox)then
			--set editbox (if exists
			parent.EditBox:SetText(self.Text)
			parent.EditBox:ClearFocus()
			--reset button text
			for _,button in pairs(parent.Buttons)do
				if(button.Text~=self.Text)then
					button.Label:SetText(NPA_Options_Template_SelectList_UnSelectedColor..button.Text)
				else
					button.Label:SetText(NPA_Options_Template_SelectList_SelectedColor..button.Text)
				end
			end
		else
			--set focusbox
			NPA_Options_Template_SelectList_SetFocusBox(parent.Frame.FocusBox,self)
			--run update if no editbox, otherelse it's ran by editbox
			NPA_Options.RunFunc(selectlist.UpdateFunc,parent)
		end
	end)
	button:HookScript("OnEnter",function(self)
		local parent=self:GetParent().Scroll
		NPA_Options.RunFunc(parent.ButtonOnEnterFunc,self)
	end)
	button:HookScript("OnLeave",function(self)
		local parent=self:GetParent().Scroll
		NPA_Options.RunFunc(parent.ButtonOnLeaveFunc,self)
	end)
	--
	NPA_Options.RunFunc(selectlist.ButtonCreateFunc,button)
	return button
end
--
NPA_Options.Template.SetSelectListFocus=function(scroll,name)
	if(not name)then
		scroll.Frame.FocusBox:Hide()
		return
	end
	local selectlist=scroll.Frame
	for i,button in pairs(selectlist.Buttons)do
		if(button:IsShown() and button.Text==name)then
			--focus box
			NPA_Options_Template_SelectList_SetFocusBox(selectlist.FocusBox,button)
			--set slider
			local slider=button:GetParent().Scroll.SliderY
			if(slider:IsShown())then
				NPA_Options.Template.SetSlider(slider,(selectlist.ButtonHeight*(i-1)))
			end
			--
			return
		end
	end
	selectlist.FocusBox:Hide()
end
--list
NPA_Options.Template.UpdateSelectList=function(scroll,data,leftsided)
	local selectlist=scroll.Frame
	--data={
	--	[index]={
	--		Name=<button name>,
	--		Value=<button value>}}
	--sort by alphabet
	local data=CopyTable(data)
	table_sort(data,function(a,b)
		if(a.Priority and b.Priority)then
			return a.Priority>b.Priority
		else
			return a.Text<b.Text
		end
	end)
	--hide all
	local buttons=selectlist.Buttons
	--set display
	local i=1
	local maxwidth=NPA_Options.Animation.GetScrollWidth(scroll)-10
	local max=table_getn(data)
	--set frame height
	local height=selectlist.ButtonHeight*max+5
	if(selectlist.WithAddButton)then
		height=height+selectlist.ButtonHeight
	end
	if(height<scroll:GetHeight())then
		height=scroll:GetHeight()
	end
	selectlist:SetHeight(height)
	----caculate height
	--local dcount=(scroll:GetHeight()-5)/selectlist.ButtonHeight -1
	--if(max>dcount)then
	--	max=dcount
	--end
	--
	for j=1,max do
		local unit=data[j]
		if(not buttons[i])then
			buttons[i]=NPA_Options_Template_SelectList_CreateButton(selectlist,scroll)
			--border + height x index
		end
		local button=buttons[i]
		NPA_Options.Template.SetTooltips(unit.Tooltips or selectlist.Tooltips,button,nil,nil,scroll)
		button:ClearAllPoints()
		button:SetPoint("BOTTOMLEFT",selectlist,"TOPLEFT",5,-(selectlist.ButtonHeight*i))
		--button:SetPoint("BOTTOMRIGHT",selectlist,"TOPRIGHT",-5,-(selectlist.ButtonHeight*i))
		button:SetHeight(selectlist.ButtonHeight-5)
		button.Label:SetText(unit.Text)
		--
		button.Text=unit.Text
		button.Value=unit.Value
		if(selectlist.WithAddButton)then
			if(scroll.NoDefault==nil and unit.Value=="Default")then
				button.DeleteButton:Hide()
			else
				button.DeleteButton:Show()
			end
		end
		--
		if(unit.Disabled)then
			NPA_Options.Template.DisableButton(button)
		else
			NPA_Options.Template.EnableButton(button)
		end
		--preview
		NPA_Options.Template.SetButtonPreview(button,unit)
		--forced set point
		if(leftsided)then
			button.Label:ClearAllPoints()
			button.Label:SetPoint("LEFT",button,"LEFT",5,0)
		end
		--
		NPA_Options.RunFunc(selectlist.ButtonUpdateFunc,button)
		--
		button:Show()

		local width=button:GetWidth()
		if(maxwidth<width)then
			maxwidth=width
		end
		i=i+1
	end
	--
	if(selectlist.WithAddButton)then
		selectlist.AddButton:SetPoint("BOTTOMLEFT",selectlist,"TOPLEFT",10,-(selectlist.ButtonHeight*i))
	end
	--
	for j=i,table_getn(buttons)do
		buttons[j]:Hide()
	end
	--set all button to max width
	for j=1,i-1 do
		buttons[j]:SetWidth(maxwidth)
	end
	--
	maxwidth=maxwidth+8
	--
	selectlist:SetWidth(maxwidth)
	--update scrollframe
	NPA_Options.Template.UpdateScrollFrame(selectlist)
	--set focusbox
	NPA_Options.Template.SetSelectListFocus(scroll,selectlist.FocusBox.Name)
	--
	scroll:Show()
end
--uses scroll and liner
NPA_Options.Template.CreateSelectList=function(parent,width,height,text,tooltips,frame,buttonheight,withaddbutton)
	--create
	local frame=frame
	if(not frame)then
		frame=NPA_Options.Template.CreateScrollFrame(parent,width,height)
		frame:HookScript("OnMouseDown",function()
			parent:GetScript("OnMouseDown")()
		end)
		frame:HookScript("OnMouseUp",function()
			parent:GetScript("OnMouseUp")()
		end)
	else
		frame.Scroll:SetWidth(width)
		frame:SetWidth(width)
		frame.Scroll:SetHeight(height)
		frame:SetHeight(height)
	end
	frame.Scroll:Hide()
	--
	frame.ButtonHeight=buttonheight or 20
	--focusbox
	frame.FocusBox=CreateFrame("Frame",nil,frame)
	frame.FocusBox:SetFrameLevel(frame:GetFrameLevel()+3)
	frame.FocusBox:Hide()
	NPA_Options.Template.CreateLinerBorder(frame.FocusBox,2)
	NPA_Options.Template.SetLinerBorderFocus(frame.FocusBox,1)
	--button list
	frame.Buttons={}
	--value
	frame.Value=nil
	--label
	if(text)then
		local label=NPA_Options.Template.CreateText(frame.Scroll,text)
		label:SetPoint("BOTTOM",frame.Scroll,"TOP",0,3)
		label:Show()
	end
	--set tooltips
	NPA_Options.Template.SetTooltips(tooltips,frame.Scroll)
	NPA_Options.Template.SetTooltips(tooltips,frame,nil,nil,frame.Scroll)
	--
	if(withaddbutton)then
		frame.AddButton=NPA_Options.Template.CreateButton(frame,frame:GetWidth()-18,frame.ButtonHeight-5,"+")
		frame.AddButton:HookScript("OnMouseUp",function()
			NPA_Options.RunFunc(frame.OnAddFunc)
		end)
	end
	--
	frame.WithAddButton=withaddbutton
	frame.Tooltips=tooltips
	--return pointer
	return frame.Scroll
end
