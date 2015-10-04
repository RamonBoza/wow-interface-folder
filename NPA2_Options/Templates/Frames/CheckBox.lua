-- Author      : Nogarder
-- Create Date : 2012/4/11 14:54:21
local Localization=NPA_Options.Localization.TemplatesFramesCheckBox
local Tooltips=Localization.Tooltips
local TipText=Localization.TipText
--create
local NPA_Options_Template_CheckBox_CheckChecked=function(checkbox,nocenter)
	if(checkbox.Checked)then
		checkbox.CheckerA:Show()
		if(checkbox.Liner)then
			checkbox.Liner:Show()
		end
	else
		checkbox.CheckerA:Hide()
		if(checkbox.Liner)then
			checkbox.Liner:Hide()
		end
	end
end
NPA_Options.Template.CreateCheckBox=function(parent,width,height,text,tooltips,nocenter)
	local checkbox=CreateFrame("Frame",nil,parent)
	--background
	NPA_Options.Template.CreateBackground(checkbox)
	--script
	checkbox:SetScript("OnEnter",function(checkbox)
		NPA_Options.Template.SetFocusBox(checkbox)
		if(checkbox.Spellid)then
			GameTooltip:SetOwner(checkbox,"ANCHOR_RIGHT")
			GameTooltip:AddSpellByID(checkbox.Spellid)
			GameTooltip:SetFrameLevel(checkbox:GetFrameLevel()+3)
			GameTooltip:AddLine("Spell id"..": |cff00ff00"..checkbox.Spellid)
			GameTooltip:Show()
		end
	end)
	checkbox:SetScript("OnLeave",function(checkbox)
		NPA_Options.Template.HideFocusBox()
		if(checkbox.Spellid)then
			GameTooltip:Hide()
		end
	end)
	checkbox:SetScript("OnMouseDown",function(checkbox)
		NPA_Options.Template.FocusFocusBox(nil)
	end)
	checkbox:SetScript("OnMouseUp",function(checkbox)
		NPA_Options.Template.FocusFocusBox(1)
		if(checkbox.Checked)then
			checkbox.Checked=false
		else
			checkbox.Checked=true
		end
		NPA_Options_Template_CheckBox_CheckChecked(checkbox)
		--
		NPA_Options.RunFunc(checkbox.ShowTipText)
		NPA_Options.RunFunc(checkbox.OnValueUpdateFunc,checkbox)
	end)
	--label
	checkbox.Label=NPA_Options.Template.CreateText(checkbox,text)
	--
	if(not height)then
		height=checkbox.Label:GetHeight()+2
	end
	checkbox:SetHeight(height)
	if(nocenter)then
		checkbox.Label:SetPoint("LEFT",checkbox,"LEFT",height+2,0)
	else
		checkbox.Label:SetPoint("CENTER",checkbox,"CENTER",0,0)
	end

	if(not width)then
		if(text)then
			width=checkbox.Label:GetWidth()+4+height
		else
			width=10
		end
	end
	
	checkbox:SetWidth(width)
	--texture
	checkbox.Texture=checkbox:CreateTexture(nil,"ARTWORK")
	checkbox.Texture:SetPoint("TOPLEFT",checkbox,"TOPLEFT")
	checkbox.Texture:SetPoint("BOTTOMRIGHT",checkbox,"BOTTOMRIGHT")
	--
	local circle=NPA_Options.Template.CreateCircle(checkbox,height/3,2)
	circle:SetPoint("LEFT",checkbox,"LEFT",height/2,0)
	circle:Hide()
	checkbox.CheckerA=circle
	--show
	checkbox:Show()
	--
	NPA_Options.Template.SetTooltips(tooltips,checkbox)
	--return pointer
	return checkbox
end
--macro for disable checkbox
NPA_Options.Template.DisableCheckBox=function(checkbox)
	if(not checkbox.DisableLiner)then
		local texture=checkbox:CreateTexture(nil,"OVERLAY")
		texture:SetPoint("LEFT",checkbox,"LEFT",0,0)
		texture:SetPoint("RIGHT",checkbox,"RIGHT",0,0)
		texture:SetHeight(checkbox:GetHeight()/5)
		texture:SetTexture("Interface\\Addons\\NPA2_Options\\texture\\Liner")
		texture:Show()
		checkbox.DisableLiner=texture
	else
		checkbox.DisableLiner:Show()
	end
	checkbox.Disabled=true
end
--macro for enable checkbox
NPA_Options.Template.EnableCheckBox=function(checkbox)
	if(checkbox.DisableLiner)then
		checkbox.DisableLiner:Hide()
	end
	checkbox.Disabled=nil
end
--
NPA_Options.Template.SetCheckBox=function(checkbox,value)
	checkbox.Checked=value
	NPA_Options_Template_CheckBox_CheckChecked(checkbox)
end
--
NPA_Options.Template.SetCheckBoxSize=function(checkbox,width,height,atype)
	checkbox:SetWidth(width)
	checkbox:SetHeight(height)
	checkbox.CheckerA:SetPoint("LEFT",checkbox,"LEFT",height/2,0)
	NPA_Options.Template.SetCircleSize(checkbox.CheckerA,height*0.4)
	if(atype==1)then
		checkbox.Texture:ClearAllPoints()
		checkbox.Texture:SetPoint("LEFT",checkbox,"LEFT",height,0)
		checkbox.Texture:SetWidth(height)
		checkbox.Texture:SetHeight(height)
		--
		checkbox.Label:ClearAllPoints()
		checkbox.Label:SetPoint("LEFT",checkbox.Texture,"RIGHT",2,0)
	end
end
--macro for set preview
NPA_Options.Template.SetCheckBoxPreview=function(checkbox,unit)
	if(not unit)then
		checkbox.Spellid = nil
		NPA_Options.SetTextFont(checkbox.Label)
		NPA_Options.SetTexture(checkbox.Texture)
	else
		checkbox.Spellid = unit.Spellid
		if(unit.Disabled)then
			NPA_Options.Template.DisableCheckBox(checkbox)
		else
			NPA_Options.Template.EnableCheckBox(checkbox)
		end
		--preview
		NPA_Options.SetTextFont(checkbox.Label,unit.Font,unit.ProfileName)
		NPA_Options.SetTexture(checkbox.Texture,unit.ProfileName,unit.TextureFile,"BLEND",{R=1,G=1,B=1,A=1},0,0,1,0,1)
		if(unit.Color)then
			local color=unit.Color
			checkbox.Label:SetTextColor(color.R,color.G,color.B,color.A)
			checkbox.Texture:SetVertexColor(color.R,color.G,color.B,color.A)
		end
	end
end
--special checkbox
NPA_Options.Template.CreateSpecialCheckBox=function(parent,width,height,type)
	local checkbox=NPA_Options.Template.CreateCheckBox(parent,width,height,Localization[type])
	NPA_Options.Template.SetTooltips(Tooltips[type],checkbox)
	if(TipText[type])then
		checkbox.ShowTipText=function()
			if(checkbox.Checked)then
				print(TipText[type].Checked)
			else
				print(TipText[type].UnChecked)
			end
		end
	end
	return checkbox
end