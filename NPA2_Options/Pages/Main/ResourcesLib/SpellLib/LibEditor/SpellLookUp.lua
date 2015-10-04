-- Author      : Nogarder
-- Create Date : 2012/11/8 16:34:04
NPA_Options.RegisterPageFunc("SpellLookUp",function()

	local pairs=pairs
	local tostring=tostring
	local tonumber=tonumber
	local strfind=string.find
	local table_insert=table.insert
	local table_getn=table.getn
	local LookUpMax=200000
	local CurrentPos=0
	local DataSet={}
	local SetBy=0 --0=id, 1=name
	--
	local Localization=NPA_Options.Localization.TemplatesWindowSpellLookUp
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["LookFor"],430,340,nil,true)
	main:SetPoint("CENTER",UIParent,"CENTER",0,0)
	main:Hide()
	local page=main.Frame
	page:SetWidth(430)
	page:SetHeight(340)
	--
	local changebutton=NPA_Options.Template.CreateButton(main.Scroll,40,20,Localization["Change"])
	changebutton:SetPoint("LEFT",main.Scroll.Title,"RIGHT",5,0)
	local byidbutton=NPA_Options.Template.CreateButton(page,170,20,Localization["ById"])
	byidbutton:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	local bynamebutton=NPA_Options.Template.CreateButton(page,170,20,Localization["ByName"])
	bynamebutton:SetPoint("LEFT",byidbutton,"RIGHT",10,0)
	--
	local percenttext=page:CreateFontString()
	percenttext:SetFont(GameFontNormal:GetFont())
	percenttext:SetText(0)
	percenttext:SetPoint("LEFT",bynamebutton,"RIGHT",5,0)
	--
	local Text
	local Buttons={}
	for i=1,48 do
		Buttons[i]=NPA_Options.Template.CreateButton(page,30,30)
		Buttons[i]:HookScript("OnMouseUp",function(self)
			NPA_Options.RunFunc(main.CallBackFunc,self.Value)
		end)
		Buttons[i].Label:ClearAllPoints()
		Buttons[i].Label:SetPoint("TOPLEFT",Buttons[i],"BOTTOMLEFT",-10,0)
		Buttons[i].Label:SetPoint("TOPRIGHT",Buttons[i],"BOTTOMRIGHT",10,0)
		Buttons[i]:HookScript("OnEnter",function(self)
			GameTooltip:SetOwner(self,"ANCHOR_RIGHT")
			GameTooltip:AddSpellByID(self.Value)
			GameTooltip:AddLine("Spell id"..": |cff00ff00"..self.Value)
			GameTooltip:Show()
		end)
		local text=Buttons[i]:CreateFontString()
		text:SetFont(Buttons[i].Label:GetFont())
		text:SetPoint("TOPLEFT",Buttons[i],"BOTTOMLEFT",-10,-10)
		text:SetPoint("TOPRIGHT",Buttons[i],"BOTTOMRIGHT",10,-10)
		Buttons[i].NameText=text
		Buttons[i]:HookScript("OnLeave",function()
			GameTooltip:Hide()
		end)
	end
	local index=0
	for j=0,5 do
		for i=0,7 do
			index=index+1
			Buttons[index]:SetPoint("TOPLEFT",page,"TOPLEFT",15+i*50,-30-j*50)
		end
	end
	index=nil
	--
	local DataSet={}
	local SetButtons=function(offset)
		for i=1 ,48 do
			local index=offset+i
			if(DataSet[index])then
				local name, _,icon=GetSpellInfo(DataSet[index])
				Buttons[i].Texture:SetTexture(icon)
				Buttons[i].Label:SetText(DataSet[index])
				Buttons[i].NameText:SetText(name)
				Buttons[i].Value=DataSet[index]
				Buttons[i]:Show()
			else
				Buttons[i]:Hide()
			end
		end
	end
	--
	local slider=NPA_Options.Template.CreateSlider(page,0,1,1,0,3,function(slider)
		SetButtons(slider.Value)
	end,
		true)
	slider:SetPoint("TOPRIGHT",page,"TOPRIGHT",-5,-30)
	slider:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT",-5,5)
	slider:SetWidth(20)
	--
	main.Slider=slider
	local updateslider=function()
		local max=table_getn(DataSet)-48
		if(max<0)then
			max=0
		end
		NPA_Options.Template.SetSlider(slider,0,0,max,1,nil,true)
	end
	--
	main.Scroll:HookScript("OnMouseWheel",function(_,value)
		local value=slider.Value-floor(value*20)
		NPA_Options.Template.SetSlider(slider,value)
	end)
	--
	page:HookScript("OnUpdate",function()
		if(CurrentPos<LookUpMax)then
			for i=1,1000 do
				if(CurrentPos<LookUpMax)then
					if(SetBy==0)then
						local name=GetSpellInfo(CurrentPos)
						if(name and strfind(name,Text))then
							table_insert(DataSet,CurrentPos)
						end
					elseif(SetBy==1)then
						id=tostring(CurrentPos)
						if(strfind(id,Text) and GetSpellInfo(CurrentPos))then
							table_insert(DataSet,CurrentPos)
						end
					end
					CurrentPos=CurrentPos+1
				end
			end
			updateslider()
			SetButtons(0)
			percenttext:SetText(table_getn(DataSet).."("..floor(CurrentPos/LookUpMax*100).."%)")
		end
	end)
	--
	local setbyid=function()
		SetBy=1
		DataSet={}
		CurrentPos=0
	end
	local setbyname=function()
		SetBy=0
		DataSet={}
		CurrentPos=0
	end
	byidbutton:HookScript("OnMouseUp",setbyid)
	bynamebutton:HookScript("OnMouseUp",setbyname)
	--
	local CheckText=function(text)
		Text=text
		if(tostring(tonumber(Text))==Text)then
			setbyid()
		else
			setbyname()
		end
		page.Scroll.Title:SetText(Localization["LookFor"]..": "..text)
	end

	changebutton:HookScript("OnMouseUp",function()
		local inputbox=NPA_Options.Template.SetInputBox(changebutton,Localization["LookFor"],Text,nil)
		inputbox.CallBackFunc=CheckText
		inputbox:SetPoint("BOTTOM",changebutton,"TOP",0,5)
	end)
	--
	main.OnSetFunc=function(text,callbackfunc)
		CheckText(text)
		--
		main.CallBackFunc=callbackfunc
	end

	--
	NPA_Options.RegisterPage("SpellLookUp",main)

end)