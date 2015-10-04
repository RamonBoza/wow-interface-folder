-- Author      : Nogarder
-- Create Date : 2012/4/11 14:54:21
local Localization=NPA_Options.Localization.TemplatesFramesButton
local TipText=Localization.TipText
local Tooltips=Localization.Tooltips
--
NPA_Options.Template.CreateSystemButton=function(parent,width,height,text)
	local button=CreateFrame("Button",nil,parent)
	button:SetHeight(15)
	button:SetWidth(width)
	--label
	button.Label=button:CreateFontString(nil,"OVERLAY")
	button.Label:SetFont(GameFontNormal:GetFont())
	button.Label:SetPoint("CENTER",button,"CENTER",0,0)
	button.Label:SetText(text)
	button:EnableMouse(true)
	--background
	NPA_Options.Template.CreateBackground(button)
	--script
	NPA_Options.Template.SetAutoFocus(button)
	--
	return button
end
--create
NPA_Options.Template.CreateButton=function(parent,width,height,text)
	local button=CreateFrame("Frame",nil,parent)
	--background
	NPA_Options.Template.CreateBackground(button)
	--script
	NPA_Options.Template.SetAutoFocus(button)
	--label
	button.Label=button:CreateFontString(nil,"OVERLAY")
	button.Label:SetFont(GameFontNormal:GetFont())
	button.Label:SetPoint("CENTER",button,"CENTER",0,0)
	button.Label:SetText(text)
	button:EnableMouse(true)
	button.Texture=button:CreateTexture(nil,"ARTWORK")
	button.Texture:SetPoint("TOPLEFT",button,"TOPLEFT")
	button.Texture:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT")
	--
	height=height or 10
	if(not height)then
		height=button.Label:GetHeight()+2
	end
	button:SetHeight(height)

	if(not text)then
		text=" "
	end
	if(not width)then
		if(text)then
			width=button.Label:GetWidth()+4
		else
			width=10
		end
	end
	button:SetWidth(width)
	--show
	button:Show()
	--return pointer
	return button
end
--macro for disable button
NPA_Options.Template.DisableButton=function(button)
	if(not button.DisableLiner)then
		local texture=button:CreateTexture(nil,"OVERLAY")
		texture:SetPoint("LEFT",button,"LEFT",0,0)
		texture:SetPoint("RIGHT",button,"RIGHT",0,0)
		texture:SetHeight(button:GetHeight()/5)
		texture:SetTexture("Interface\\Addons\\NPA2_Options\\texture\\Liner")
		texture:Show()
		button.DisableLiner=texture
	else
		button.DisableLiner:Show()
	end
	button.Disabled=true
	button:EnableMouse(false)
end
--macro for enable button
NPA_Options.Template.EnableButton=function(button)
	if(button.DisableLiner)then
		button.DisableLiner:Hide()
	end
	button.Disabled=nil
	button:EnableMouse(true)
end
--macro for set preview
NPA_Options.Template.SetButtonPreview=function(button,unit)
	if(not unit)then
		NPA_Options.SetTextFont(button.Label)
		NPA_Options.SetTexture(button.Texture)
		button:SetWidth(button.Label:GetWidth()+10)
	else
		if(unit.Disabled)then
			NPA_Options.Template.DisableButton(button)
		else
			NPA_Options.Template.EnableButton(button)
		end
		--preview
		NPA_Options.SetTextFont(button.Label,unit.Font,unit.FontProfileName)
		NPA_Options.SetTexture(button.Texture,unit.TextureProfileName,unit.TextureFile,"BLEND",{R=1,G=1,B=1,A=1},0,0,1,0,1)
		if(unit.SquareTexture)then
			button.Texture:ClearAllPoints()
			button.Texture:SetPoint("TOPLEFT",button,"TOPLEFT")
			button.Texture:SetPoint("BOTTOMLEFT",button,"BOTTOMLEFT")
			button.Texture:SetWidth(button:GetHeight())
			button.Label:ClearAllPoints()
			button.Label:SetPoint("LEFT",button.Texture,"RIGHT",0,0)
			button:SetWidth(button:GetHeight()+button.Label:GetWidth()+10)
		else
			button.Texture:ClearAllPoints()
			button.Texture:SetPoint("TOPLEFT",button,"TOPLEFT")
			button.Texture:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT")
			button.Label:ClearAllPoints()
			button.Label:SetPoint("CENTER",button,"CENTER",0,0)
			button:SetWidth(button.Label:GetWidth()+10)
		end
		if(unit.Color)then
			local color=unit.Color
			button.Label:SetTextColor(color.R,color.G,color.B,color.A)
			button.Texture:SetVertexColor(color.R,color.G,color.B,color.A)
		end
	end
end
--macro for special button
NPA_Options.Template.CreateSpecialButton=function(parent,width,height,btype)
	local button=NPA_Options.Template.CreateButton(parent,width,height,Localization[btype])
	NPA_Options.Template.SetTooltips(Tooltips[btype],button)
	button:HookScript("OnMouseUp",function()
		if(TipText[btype])then
			print(TipText[btype])
		end
	end)
	return button
end
-----------------
--colorbutton--
-----------------
do
	NPA_Options.Template.SetColorButton=function(button,color)
		button.Value=CopyTable(color)
		button.Texture:SetTexture(color.R,color.G,color.B,color.A)
	end
	--
	local ColorButtonOnClick=function(self)
		NPA_Options.SetPage("ColorPicker",self.LinkTo,self.Value.R,self.Value.G,self.Value.B,self.Value.A,function(r,g,b,a)
			self.Value.R=r
			self.Value.G=g
			self.Value.B=b
			self.Value.A=a
			self.Texture:SetTexture(r,g,b,a)
			NPA_Options.RunFunc(self.OnValueUpdateFunc,self)
		end)
	end
	--
	local ColorChangeButtonOnClick=function(self)
		ColorButtonOnClick(self:GetParent())
	end
	--
	NPA_Options.Template.CreateColorButton=function(parent,width,height,label,linkto,tooltip,callbackfunc)
		local frame=CreateFrame("Frame",nil,parent)
		frame:SetWidth(width)
		frame:SetHeight(height)
		frame:EnableMouse(true)
		NPA_Options.Template.SetAutoFocus(frame)
		--
		frame.LinkTo=linkto
		--
		frame:HookScript("OnMouseUp",ColorButtonOnClick)
		--
		local button=NPA_Options.Template.CreateButton(frame,40,20,Localization["Change"])
		button:SetPoint("RIGHT",frame,"RIGHT",0,0)
		button:HookScript("OnMouseUp",ColorChangeButtonOnClick)
		button:HookScript("OnHide",function()
			NPA.TextureManager.RemoveAnimatedTexture(button.Texture)--just in case, release resources
		end)
		--
		frame.Button=button
		--
		local texture=frame:CreateTexture(nil,"ARTWORK")
		texture:SetPoint("LEFT",frame,"LEFT",0,0)
		texture:SetPoint("RIGHT",button,"LEFT",-2,0)
		texture:SetHeight(height)
		frame.Texture=texture
		--
		local texturebg=frame:CreateTexture(nil,"BACKGROUND")
		texturebg:SetPoint("TOPLEFT",texture,"TOPLEFT")
		texturebg:SetPoint("BOTTOMRIGHT",texture,"BOTTOMRIGHT")
		texturebg:SetTexture(0,0,0,1)
		--
		local label=NPA_Options.Template.CreateText(frame,label,true)
		label:SetPoint("BOTTOM",texture,"TOP",0,2)
		--
		NPA_Options.Template.SetTooltips(tooltip,frame)
		--
		return frame
	end
	--
	NPA_Options.Template.DisableColorButton=function(frame)
		frame:EnableMouse(false)
		frame.Button:EnableMouse(false)
	end
	NPA_Options.Template.EnableColorButton=function(frame)
		frame:EnableMouse(true)
		frame.Button:EnableMouse(true)
	end
end
--------------------
------------------------
--font editor button--
------------------------
do
	local GetFontList=function()
		local list={}
		local i=0
		for name,_ in pairs(NPA_Setting.Font)do
			i=i+1
			list[i]={
				Text=name,
				Value=name,
				FontProfileName=name,
			}
		end
		return list
	end
	--
	NPA_Options.Template.CreateFontEditorButton=function(page,main,width)
		local fontselector=NPA_Options.Template.CreateDropDownEditor(page,width,Localization["Font"]..Localization["Profile"],nil,GetFontList)
		--edit button
		local fonteditbutton=NPA_Options.Template.CreateButton(fontselector,40,20,Localization["Edit"])
		fonteditbutton:SetPoint("LEFT",fontselector,"RIGHT",20,0)
		NPA_Options.Template.SetTooltips(Tooltips["Edit"],fonteditbutton)

		fonteditbutton:HookScript("OnMouseUp",function()
			NPA_Options.SetPage("FontLib",main,fontselector.Value)
		end)

		return fontselector
	end
end
-------------------------------
-------------------------------
--texture file editor button--
-------------------------------
do
	local GetTextureList=function()
		local list={}
		local i=0
		for name,_ in pairs(NPA_Setting.Texture)do
			i=i+1
			list[i]={
				Text=name,
				Value=name,
				TextureProfileName=name,
			}
		end
		for name,_ in pairs(NPA_Setting.AnimatedTexture)do
			i=i+1
			list[i]={
				Text="@"..name,
				Value="@"..name,
				TextureProfileName="@"..name
			}
		end
		return list
	end
	NPA_Options.Template.CreateTextureSelectorButton=function(page,main,width)
		local textureselector=NPA_Options.Template.CreateDropDownEditor(page,width,Localization["Texture"]..Localization["Profile"],nil,GetTextureList)
		--edit button
		local textureeditbutton=NPA_Options.Template.CreateButton(textureselector,40,20,Localization["Edit"])
		textureeditbutton:SetPoint("LEFT",textureselector,"RIGHT",20,0)
		NPA_Options.Template.SetTooltips(Tooltips["Edit"],textureeditbutton)

		textureeditbutton:HookScript("OnMouseUp",function()
			local _,name2=string.split("@",textureselector.Value)
			if(name2)then
				NPA_Options.SetPage("AnimatedTextureLib",main,name2)
			else
				NPA_Options.SetPage("TextureLib",main,textureselector.Value)
			end
		end)
		return textureselector
	end
end
-------------------------------
--texture file path list button--
-------------------------------
do
	NPA_Options.Template.CreateTextureFileSelectorButton=function(page,main,width,localization,tooltip)
		local textureselector=NPA_Options.Template.CreateDropDownEditor(page,width-40,localization,tooltip,NPA_Options.InfoLib.GetTexture,50)
		textureselector.FreeEdit=true
		--from spell button
		local textureeditbutton=NPA_Options.Template.CreateButton(textureselector,40,20,Localization["LookUp"])
		textureeditbutton:SetPoint("LEFT",textureselector,"RIGHT",22,0)
		NPA_Options.Template.SetTooltips(Tooltips["LookUp"],textureeditbutton)

		textureeditbutton:HookScript("OnMouseUp",function()
			NPA_Options.SetPage("SpellLookUp",main,"",function(spellid)
					local _, _,icon=GetSpellInfo(spellid)
					NPA_Options.Template.SetDropDownEditor(textureselector,icon)
					textureselector.OnValueUpdateFunc()
				end)
		end)
		return textureselector
	end
end
--------------------------------
--------------------------------
--numbertext editor button--
--------------------------------
do
	NPA_Options.Template.CreateNumberTextEditorButton=function(parent,width,height,title,main,colortable)
		local button=NPA_Options.Template.CreateButton(parent,width,height,title)
		button:HookScript("OnMouseUp",function()
			NPA_Options.SetPage("NumberTextEditor",main,button.Value,button.OnValueUpdateFunc,colortable)
		end)
		return button
	end
end
--------------------------------
--------------------------------
--number selector button--
--------------------------------
do
	local GetNumberList=function()
		local list={}
		local i=0
		for name,_ in pairs(NPA_Setting.Number)do
			i=i+1
			list[i]={
				Text=name,
				Value=name,
			}
		end
		return list
	end
	NPA_Options.Template.CreateNumberSelectorButton=function(page,main,width)
		local numberselector=NPA_Options.Template.CreateDropDownEditor(page,width,Localization["Number"]..Localization["Profile"],nil,GetNumberList)
		--edit button
		local editbutton=NPA_Options.Template.CreateButton(numberselector,40,20,Localization["Edit"])
		editbutton:SetPoint("LEFT",numberselector,"RIGHT",20,0)
		NPA_Options.Template.SetTooltips(Tooltips["Edit"],editbutton)

		editbutton:HookScript("OnMouseUp",function()
			NPA_Options.SetPage("NumberLib",main,numberselector.Value,numberselector.OnValueUpdateFunc)
		end)
		return numberselector
	end
end
--bar btype selector button
-------------------------------
do
	local GetBarGroupList=function()
		local list={}
		local i=0
		for name,_ in pairs(NPA_Setting.BarGroup)do
			i=i+1
			list[i]={
				Text=name,
				Value=name,
			}
		end
		return list
	end
	NPA_Options.Template.CreateBarGroupSelectorButton=function(page,main,width)
		local bargroupselector=NPA_Options.Template.CreateDropDownEditor(page,width,Localization["BarGroup"]..Localization["Profile"],nil,GetBarGroupList)
		--edit button
		local editbutton=NPA_Options.Template.CreateButton(bargroupselector,40,20,Localization["Edit"])
		editbutton:SetPoint("LEFT",bargroupselector,"RIGHT",20,0)
		NPA_Options.Template.SetTooltips(Tooltips["Edit"],editbutton)

		editbutton:HookScript("OnMouseUp",function()
			NPA_Options.SetPage("BarGroupLib",main,bargroupselector.Value,nil,nil,nil,nil,function()
				--only set preview when not on hiding or hidden
				if(NPA_Options.Animation.NotHide(main))then
					NPA_Options.SetPage("BarGroupPreview",main,bargroupselector.Value)
					page.SetPreview()
				end
			end)
		end)
		return bargroupselector
	end
end
