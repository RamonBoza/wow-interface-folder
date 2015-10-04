-- Author      : Nogarder
-- Create Date : 2012/6/23 10:29:00
local table_getn=table.getn
local table_sort=table.sort
local string_gsub=string.gsub
local pairs=pairs
local CopyTable=CopyTable
--
local NPA_Options_Template_SelectList_SelectedColor="|cff00ff00"
local NPA_Options_Template_SelectList_UnSelectedColor="|cffffffff"
--
--create
local dropdownmenu=NPA_Options.Template.CreateScrollFrame(NPA_Options.MainFrame,1,1,true,true)
local scroll=dropdownmenu.Scroll
scroll:Hide()
scroll:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT",0,-2)
scroll:SetWidth(1)
scroll:SetHeight(1)
dropdownmenu:EnableMouse(1)
--background--black
dropdownmenu.Background=NPA_Options.Template.CreateBackground(dropdownmenu,nil,0,1)
--border
scroll.Border=NPA_Options.Template.CreateBorder(scroll,nil,nil,nil,nil,6)

--buttonlist
dropdownmenu.Buttons={}
--closer
local closer=NPA_Options.Template.SetCloser(scroll,scroll,tooltipsdirection)
closer:SetPoint("TOPLEFT",scroll,"TOPRIGHT")
--change slidery
scroll.SliderY:SetPoint("TOPLEFT",scroll,"TOPRIGHT",0,-20)
---
local NPA_Options_Template_DropDownMenu_CreateButton=function(dropdownmenu)
	local button=NPA_Options.Template.CreateButton(dropdownmenu,dropdownmenu:GetWidth()-8,15,nil)
	button:HookScript("OnMouseUp",function(self,mousebutton)
		if(not self.Disabled)then
			NPA_Options.RunFunc(scroll.OnClickFunc,self,mousebutton)
			scroll:Hide()
		end
	end)
	return button
end
--
local NPA_Options_Template_DropDownMenu_SetButton=function(button,unit,height,parent,offsetx,offsety)
	button:SetHeight(height-2)
	button:SetPoint("BOTTOMLEFT",parent,"TOPLEFT",offsetx,offsety)
	--button:SetPoint("BOTTOMRIGHT",parent,"TOPRIGHT",-offsetx,offsety)
	button.Label:SetText(unit.Text)
	button.Text=unit.Text
	button.Value=unit.Value
	button.Disabled=unit.Disabled

	if(unit.Disabled)then
		NPA_Options.Template.DisableButton(button)
	else
		NPA_Options.Template.EnableButton(button)
	end
	NPA_Options.Template.SetTooltips(unit.Tooltips,button,nil,nil,scroll)
	--preview
	--NPA_Options.Template.SetButtonPreview(button,unit)
end
--list
local NPA_Options_Template_DropDownMenu_UpdateDropDownList=function(data)
	local data=CopyTable(data)
	--data={
	--	[index]={
	--		Text=<button text>,
	--		Func=<button on click func>,
	--		Tooltips=<>,
	--		Disabled=<>}
	--sort by alphabet
	table_sort(data,function(a,b)
		return (a.Text or "")<(b.Text or "")
	end)
	--set display
	local maxwidth=scroll:GetWidth() -10
	local buttonheight=dropdownmenu.ButtonHeight-1
	local step=dropdownmenu.ButtonHeight
	local buttons=dropdownmenu.Buttons
	local max=table_getn(data)
	for i=1,max do
		local unit=data[i]
		if(not buttons[i])then
			buttons[i]=NPA_Options_Template_DropDownMenu_CreateButton(dropdownmenu)
		end
		--
		local button=buttons[i]
		--
		NPA_Options_Template_DropDownMenu_SetButton(button,unit,buttonheight,dropdownmenu,3,-i*step)
		--preview
		NPA_Options.Template.SetButtonPreview(button,unit)
		--
		button:Show()
		
		local width=button.Label:GetWidth()
		if(maxwidth<width)then
			maxwidth=width
		end
	end
	for i=max+1,table_getn(buttons)do
		buttons[i]:Hide()
	end
	--set all button to max width
	for i=1,max do
		buttons[i]:SetWidth(maxwidth)
	end
	--
	maxwidth=maxwidth+7
	--set frame width and height
	dropdownmenu:SetWidth(maxwidth)
	--
	if(maxwidth<500)then
		scroll:SetWidth(maxwidth)
	else
		scroll:SetWidth(500)
	end
	--
	local height=step*max+5
	dropdownmenu:SetHeight(height)
	if(height>300)then
		scroll:SetHeight(300)
	else
		scroll:SetHeight(height)
	end
	--
	scroll.SliderX.Value=1
	scroll.SliderY.Value=1
	--update scrollframe
	NPA_Options.Template.UpdateScrollFrame(dropdownmenu)

end

--
NPA_Options.Template.UpdateDropDownMenuKeyWord=function(keyword)
	if(keyword==nil or keyword=="")then
		return
	end
	local value
	for _,button in pairs(dropdownmenu.Buttons)do
		if(button:IsShown())then
			if(button.Text==keyword)then
				value=button.Value
				button.Label:SetText(NPA_Options_Template_SelectList_SelectedColor..keyword)
			else
				button.Label:SetText(string_gsub(button.Text,keyword,NPA_Options_Template_SelectList_SelectedColor..keyword..NPA_Options_Template_SelectList_UnSelectedColor))
			end
		end
	end
	return value
end
--
NPA_Options.Template.CheckDropDownMenu=function(parent)
	if(scroll:IsShown() and scroll.Parent==parent)then
		return true
	end
end
--
NPA_Options.Template.SetDropDownMenu=function(parent,width,data,onclickfunc,mainframe,buttonheight)
	scroll:Hide()
	if(not next(data))then
		return scroll
	end
	--data={
	--	[index]={
	--		Text=<button text>,
	--		Func=<button on click func>,
	--		Tooltips=<>,
	--		Disabled=<>}
	scroll.OnClickFunc=onclickfunc
	scroll:ClearAllPoints()
	scroll.Parent=parent
	scroll:SetParent(NPA_Options.MainFrame) --mainframe or NPA_Options.MainFrame)
	scroll:SetFrameLevel(parent:GetFrameLevel()+6)
	--
	NPA_Options.Template.SetSlider(scroll.SliderX,0)
	NPA_Options.Template.SetSlider(scroll.SliderY,0)
	--width
	if(not width)then
		scroll:SetWidth(1)
	else
		scroll:SetWidth(width)
	end
	--init
	dropdownmenu.ButtonHeight=buttonheight or 20
	NPA_Options_Template_DropDownMenu_UpdateDropDownList(data)
	--
	NPA_Options.Animation.ShowFrame(scroll)
	--
	return scroll
end
--
NPA_Options.Template.HideDropDownMenu=function()
	NPA_Options.Animation.HideFrame(scroll)
end
--
NPA_Options.RegisterTemplate(scroll,NPA_Options.Template.HideDropDownMenu)
