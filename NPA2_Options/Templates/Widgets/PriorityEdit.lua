-- Author      : Nogarder
-- Create Date : 2012/7/21 6:43:41
--global
local table_insert=table.insert
local table_getn=table.getn
local pairs=pairs
local floor=floor
--
local Localization=NPA_Options.Localization.TemplatesWidgetsPriorityEdit
local Tooltips=Localization.Tooltips

--
local NPA_Options_Template_PriorityEdit_SetFocusBox=function(focusbox,button)
	focusbox.Name=button.Text
	focusbox:ClearAllPoints()
	focusbox:SetPoint("TOPLEFT",button,"TOPLEFT",4,-4)
	focusbox:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",-4,4)
	focusbox:Show()
end
--
local SwapButton=function(frame,button,obutton)
	local index=obutton.Index
	obutton:SetPoint("BOTTOM",frame,"TOP",0,-(frame.ButtonHeight*button.Index))
	obutton.Index=button.Index
	button:SetPoint("BOTTOM",frame,"TOP",0,-(frame.ButtonHeight*index))
	button.Index=index
end
local SelectButton=function(frame,index)
	for i=1,frame.Max do
		if(frame.Buttons[i].Index==index)then
			return frame.Buttons[i]
		end
	end
end
--main
local NPA_Options_Template_PriorityEdit_FrameOnUpdate=function(frame)
	if(not frame.Moving)then
		return
	end
	--
	local button=frame.Moving
	--caculate related position
	--get ccursor position
	local x,y=GetCursorPosition()
	local scale=frame:GetEffectiveScale()
	local top=frame:GetTop()*scale
	local offset=top-y
	if(offset<0)then
		offset=0
	end
	local step=frame.ButtonHeight*scale
	local max=(frame.Max-1)*step
	if(offset>max)then
		offset=max
	end
	local index=floor(offset/step)+1
	if(index~=button.Index)then
		local obutton=SelectButton(frame,index)
		SwapButton(frame,button,obutton)
	end
end
--
local DropDownMenuData={
		[1]={
			Text=Localization["Copy"],
			Value="Copy",
			Tooltips=Tooltips["Copy"]
		},
		[2]={
			Text=Localization["Delete"],
			Value="Delete"
		},
		[3]={
			Text=Localization["Create"],
			Value="Create",
			Tooltips=Tooltips["Create"]
		},
		[4]={
			Text=Localization["MoveUp"],
			Value="MoveUp",
			Tooltips=Tooltips["MoveUp"]
		},
		[5]={
			Text=Localization["MoveDown"],
			Value="MoveDown",
			Tooltips=Tooltips["MoveDown"]
		},
}
local InitDropDownMenu=function(frame,button,main)
	if(main)then
		DropDownMenuData[1].Disabled=true
		DropDownMenuData[2].Disabled=true
		DropDownMenuData[4].Disabled=true
		DropDownMenuData[5].Disabled=true
	elseif(frame.Max==1 and frame.KeepDefault==true)then
		DropDownMenuData[1].Disabled=false
		DropDownMenuData[2].Disabled=true
		DropDownMenuData[2].Tooltips=Tooltips["CantDelete"]
		DropDownMenuData[4].Disabled=true
		DropDownMenuData[5].Disabled=true
	else
		DropDownMenuData[1].Disabled=false
		DropDownMenuData[2].Tooltips=Tooltips["Delete"]
		DropDownMenuData[2].Disabled=false
		if(button.Index==frame.Max)then
			DropDownMenuData[4].Disabled=false
			DropDownMenuData[5].Disabled=true
		elseif(button.Index==1)then
			DropDownMenuData[4].Disabled=true
			DropDownMenuData[5].Disabled=false
		end
	end
	local dropdownmenu=NPA_Options.Template.SetDropDownMenu(button,nil,DropDownMenuData,function(self)
			local value=self.Value
			if(value=="Copy")then
				NPA_Options.RunFunc(frame.OnCopyFunc,button.EntryIndex,frame.Max+1)
			elseif(value=="Delete")then
				NPA_Options.RunFunc(frame.OnDeleteFunc,button.EntryIndex)
			elseif(value=="Create")then
				NPA_Options.RunFunc(frame.OnCreateFunc,frame.Max+1)
			elseif(value=="MoveUp")then
				local obutton=SelectButton(frame,button.Index-1)
				SwapButton(frame,button,obutton)
				--
				NPA_Options.RunFunc(frame.OnUpdateFunc,button.Index,button.Index-1)
			elseif(value=="MoveDown")then
				local obutton=SelectButton(frame,button.Index+1)
				SwapButton(frame,button,obutton)
				--
				NPA_Options.RunFunc(frame.OnUpdateFunc,button.Index,button.Index+1)
			end
		end)
	dropdownmenu:ClearAllPoints()
	dropdownmenu:SetPoint("LEFT",frame.Scroll,"RIGHT",3,0)
	dropdownmenu:SetPoint("TOP",button,"TOP",3,0)
end
local NPA_Options_Template_PriorityEdit_CreateButton=function(frame,i)
	local button=NPA_Options.Template.CreateButton(frame,frame:GetWidth()-5,frame.ButtonHeight-5)
	button.Label:ClearAllPoints()
	button.Label:SetPoint("LEFT",button,"LEFT",0,0)
	button.Index=i
	button:HookScript("OnMouseDown",function(_,mousebutton)
		if(mousebutton=="LeftButton")then
			--start moving
			frame.Moving=button
			NPA_Options_Template_PriorityEdit_SetFocusBox(frame.FocusBox,button)
		end
	end)
	button:HookScript("OnMouseUp",function(_,mousebutton)
		if(mousebutton=="LeftButton")then
			--stop moving
			frame.Moving=nil
			frame.FocusBox:Hide()
		elseif(mousebutton=="RightButton")then
			--dropdownmenu
			InitDropDownMenu(frame,button)
		end
	end)
	--
	NPA_Options.RunFunc(frame.ButtonCreateFunc,button)
	--delete button
	button.DeleteButton=NPA_Options.Template.CreateButton(button,10,frame.ButtonHeight-5,"x")
	button.DeleteButton:SetPoint("LEFT",button,"LEFT",0,0)
	button.DeleteButton:HookScript("OnMouseUp",function()
		NPA_Options.RunFunc(frame.OnDeleteFunc,button.EntryIndex)
	end)
	--Copy button
	button.CopyButton=NPA_Options.Template.CreateButton(button,10,frame.ButtonHeight-5,"+")
	button.CopyButton:SetPoint("RIGHT",button,"RIGHT",0,0)
	button.CopyButton:HookScript("OnMouseUp",function()
		NPA_Options.RunFunc(frame.OnCopyFunc,button.EntryIndex,frame.Max+1)
	end)
	--
	NPA_Options.Template.SetTooltips(Tooltips["Priority"],button,nil,2,frame.Scroll)
	--
	return button
end
NPA_Options.Template.UpdatePriorityEdit=function(scroll,entry)
	local count=table_getn(entry)
	--
	local frame=scroll.Frame
	--
	for i=1,count do
		if(not frame.Buttons[i])then
			frame.Buttons[i]=NPA_Options_Template_PriorityEdit_CreateButton(frame,i)
		end
		local button=frame.Buttons[i]
		button:SetPoint("BOTTOM",frame,"TOP",0,-(frame.ButtonHeight*i))
		button.Index=i
		--tooltips should be set in update func
		--NPA_Options.Template.SetTooltips(tooltips[i],button,nil,nil,scroll)
		button.EntryIndex=i
		NPA_Options.RunFunc(frame.ButtonUpdateFunc,button,i)
		--
		button:Show()
	end
	--
	frame.AddButton:SetPoint("BOTTOM",frame,"TOP",0,-(frame.ButtonHeight*(count+1)))
	--
	frame.Max=count
	for i=count+1,table_getn(frame.Buttons)do
		frame.Buttons[i]:Hide()
	end
	local height=(count+1)*frame.ButtonHeight+20
	if(height<scroll:GetHeight())then
		frame:SetHeight(scroll:GetHeight())
	else
		frame:SetHeight(height)
	end
	NPA_Options.Template.UpdateScrollFrame(frame)
	--
	NPA_Options.ClosePages(scroll.Dragger,true)
end
NPA_Options.Template.CreatePriorityEdit=function(parent,title,width,height,buttonheight,linkto,tooltips)
	--create
	local main=NPA_Options.Template.CreateFrameWithBar(parent,nil,width,height,linkto)
	--button list
	local frame=main.Frame
	frame:HookScript("OnUpdate",NPA_Options_Template_PriorityEdit_FrameOnUpdate)
	frame.Buttons={}
	--set tooltips
	NPA_Options.Template.SetTooltips(tooltips,frame.Scroll)
	NPA_Options.Template.SetTooltips(tooltips,frame,nil,nil,frame.Scroll)
	frame.ButtonHeight=buttonheight
	frame.Tooltips=tooltips
	--title
	local text=NPA_Options.Template.CreateText(main.Scroll,title)
	text:SetPoint("BOTTOM",main.Scroll,"TOP",0,25)
	--save
	local buttonwidth=(width-25)/3
	--
	local savebutton=NPA_Options.Template.CreateSpecialButton(main.Scroll,buttonwidth,20,"Save")
	savebutton:SetPoint("BOTTOMLEFT",main.Scroll,"TOPLEFT",5,5)
	--reset
	local resetbutton=NPA_Options.Template.CreateSpecialButton(main.Scroll,buttonwidth,20,"Reset")
	resetbutton:SetPoint("BOTTOM",main.Scroll,"TOP",0,5)
	--cancel
	local cancelbutton=NPA_Options.Template.CreateSpecialButton(main.Scroll,buttonwidth,20,"Cancel")
	cancelbutton:SetPoint("BOTTOMRIGHT",main.Scroll,"TOPRIGHT",-5,5)
	--script
	savebutton:HookScript("OnMouseUp",function()
		NPA_Options.Animation.ShowFrame(main)
		local matchtable={}
		for i=1,frame.Max do
			local button=frame.Buttons[i]
			matchtable[button.Index]=button.EntryIndex
		end
		NPA_Options.RunFunc(frame.SaveFunc,matchtable)
	end)
	cancelbutton:HookScript("OnMouseUp",function()
		NPA_Options.Animation.ShowFrame(main)
		NPA_Options.RunFunc(frame.LoadFunc)
	end)
	resetbutton:HookScript("OnMouseUp",function()
		NPA_Options.Animation.ShowFrame(main)
		NPA_Options.RunFunc(frame.LoadFunc,true)
	end)
	--
	frame:HookScript("OnMouseUp",function(_,mousebutton)
		if(mousebutton=="RightButton")then
			--dropdownmenu
			InitDropDownMenu(frame,frame,true)
		end
	end)
	--on zip and unzip
	main.Scroll.OnMinimizedFunc=function()
		savebutton:Hide()
		resetbutton:Hide()
		cancelbutton:Hide()
		text:Hide()
	end
	main.Scroll.OnRestoredFunc=function()
		savebutton:Show()
		resetbutton:Show()
		cancelbutton:Show()
		text:Show()
	end
	--focus box
	frame.FocusBox=CreateFrame("Frame",nil,frame)
	frame.FocusBox:SetFrameLevel(frame:GetFrameLevel()+3)
	frame.FocusBox:Hide()
	NPA_Options.Template.CreateLinerBorder(frame.FocusBox,2)
	NPA_Options.Template.SetLinerBorderFocus(frame.FocusBox,1)
	--the "add" button
	frame.AddButton=NPA_Options.Template.CreateButton(frame,nil,nil,"+")
	frame.AddButton:SetWidth(frame:GetWidth()-15)
	frame.AddButton:SetHeight(frame.ButtonHeight-5)
	frame.AddButton:HookScript("OnMouseUp",function()
		NPA_Options.RunFunc(frame.OnCreateFunc,frame.Max+1)
	end)
	--return pointer
	return main
end