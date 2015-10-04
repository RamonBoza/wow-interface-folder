-- Author      : Nogarder
-- Create Date : 2012/6/19 10:23:46
local Localization=NPA_Options.Localization.TemplatesWidgetsDropDownEditor
local Tooltips=NPA_Options.Localization.TemplatesWidgetsDropDownEditor.Tooltips
--
local Refresh=function(editbox,libfunc,forcematch)
	if(not libfunc)then
		editbox:SetText(editbox.Value)
		return
	end
	editbox.SetByMenu=true
	local value=editbox.Value
	local unit=NPA_Options.CheckLib(value,libfunc)
	--preview
	if(unit)then
		NPA_Options.SetTextFont(editbox,unit.Font,unit.FontProfileName)
		NPA_Options.SetTexture(editbox.Texture,unit.TextureProfileName)
		if(unit.Color)then
			local color=unit.Color
			editbox:SetTextColor(color.R,color.G,color.B,color.A)
			editbox.Texture:SetVertexColor(color.R,color.G,color.B,color.A)
		end
		--
		editbox:SetText(unit.Text or "")
	elseif(forcematch)then
		--force it to match one of the options
		_,unit=next(libfunc())
		NPA_Options.SetTextFont(editbox,unit.Font,unit.FontProfileName)
		NPA_Options.SetTexture(editbox.Texture,unit.TextureProfileName)
		if(unit.Color)then
			local color=unit.Color
			editbox:SetTextColor(color.R,color.G,color.B,color.A)
			editbox.Texture:SetVertexColor(color.R,color.G,color.B,color.A)
		end
		--
		editbox:SetText(unit.Text or "")
		editbox.Value=unit.Value
		NPA_Options.RunFunc(editbox.OnValueUpdateFunc)
	else
		NPA_Options.SetTextFont(editbox)
		editbox.Texture:Hide()
		editbox:SetText(value or "")
	end
end
--
NPA_Options.Template.CreateDropDownEditor=function(parent,width,label,tooltip,datafunc,buttonheight)
	local width=width-20
	--main
	local editbox=NPA_Options.Template.CreateEditBox(parent,width,20)
	editbox.Label=NPA_Options.Template.CreateText(editbox,label,true)
	editbox.Label:SetPoint("BOTTOM",editbox,"TOP",0,0)
	--
	editbox.Value=""
	editbox.DataFunc=datafunc
	editbox.SetByMenu=true
	--
	local dropdownmenu_onclickfunc=function(self)
		editbox:ClearFocus()
		editbox.SetByMenu=true
		editbox.Value=self.Value
		Refresh(editbox,editbox.DataFunc)
		NPA_Options.RunFunc(editbox.OnValueUpdateFunc,editbox)
	end
	editbox:HookScript("OnCursorChanged",function(self)
		--update dropdownmenu
		if(self.FreeEdit)then
			if(self.SetByMenu)then
				self.SetByMenu=nil
			else
				local text=self:GetText()
				self.Value=NPA_Options.Template.UpdateDropDownMenuKeyWord(text) or text
				NPA_Options.RunFunc(editbox.OnValueUpdateFunc,editbox)
			end
		end
	end)
	--
	local setdropdownmenu=function()
		local dropdownmenu=NPA_Options.Template.SetDropDownMenu(editbox,width,editbox.DataFunc(),dropdownmenu_onclickfunc,parent:GetParent(),buttonheight)
		if(editbox.Revers)then
			dropdownmenu:SetPoint("BOTTOMLEFT",editbox,"TOPLEFT",0,0)
		else
			dropdownmenu:SetPoint("TOPLEFT",editbox,"BOTTOMLEFT",0,0)
		end
	end
	--
	local SetSpellPicker=function()
		if(editbox.IsSpellPicker)then
			NPA_Options.SetPage("SpellLookUp",editbox.ParentPage,editbox.Value,function(value)
				editbox.Value=value
				editbox:SetText(value)
				NPA_Options.RunFunc(editbox.OnValueUpdateFunc,editbox)
			end)
		else
			--editbox:ClearFocus()
			if(NPA_Options.Template.CheckDropDownMenu(editbox))then
				NPA_Options.Template.HideDropDownMenu()
			elseif(editbox.DataFunc)then
				setdropdownmenu()
			end
		end
	end
	--
	editbox:HookScript("OnEditFocusGained",function()
		if(editbox.DataFunc)then
			if(not NPA_Options.Template.CheckDropDownMenu(editbox))then
				setdropdownmenu()
			end
		else
			NPA_Options.Template.HideDropDownMenu()
		end
		if(not editbox.FreeEdit)then
			editbox:ClearFocus()
		end
		SetSpellPicker()
	end)
	editbox:HookScript("OnEditFocusLost",function()
		Refresh(editbox,editbox.DataFunc)
		NPA_Options.Template.HideDropDownMenu()
		SetSpellPicker()
	end)
	editbox:HookScript("OnHide",function()
		NPA_Options.Template.HideDropDownMenu()
	end)

	NPA_Options.Template.SetTooltips(tooltip or Localization["InputValue"],editbox)
	--dropdown button
	editbox.Button=NPA_Options.Template.CreateButton(editbox,20,20,"+")
	editbox.Button:SetScript("OnMouseUp",SetSpellPicker)
	editbox.Button:SetPoint("LEFT",editbox,"RIGHT",0,0)
	NPA_Options.Template.SetTooltips(Localization["ClickForMenu"],editbox.Button)
	editbox.Button:Show()
	--
	editbox.Texture=editbox:CreateTexture(nil,"BACKGROUND")
	editbox.Texture:SetPoint("TOPLEFT",editbox,"TOPLEFT")
	editbox.Texture:SetPoint("BOTTOMRIGHT",editbox,"BOTTOMRIGHT")
	--show
	editbox:Show()
	--
	return editbox
end
--set
NPA_Options.Template.SetDropDownEditor=function(editbox,value,libfunc,forcematch)
	editbox.Value=value

	if(libfunc)then
		editbox.DataFunc=libfunc
		Refresh(editbox,libfunc,forcematch)
	else
		Refresh(editbox,editbox.DataFunc,forcematch)
	end
end
--
NPA_Options.Template.DisableDropDownEditor=function(editor)
	if(not editor.DisableLiner)then
		local texture=editor:CreateTexture(nil,"OVERLAY")
		texture:SetPoint("LEFT",editor,"LEFT",0,0)
		texture:SetPoint("RIGHT",editor,"RIGHT",0,0)
		texture:SetHeight(editor:GetHeight()/5)
		texture:SetTexture("Interface\\Addons\\NPA2_Options\\texture\\Liner")
		texture:Show()
		editor.DisableLiner=texture
	else
		editor.DisableLiner:Show()
	end
	editor:SetAlpha(0.5)
	editor:EnableMouse(false)
end
--macro for enable button
NPA_Options.Template.EnableDropDownEditor=function(editor)
	if(editor.DisableLiner)then
		editor.DisableLiner:Hide()
	end
	editor:SetAlpha(1)
	editor:EnableMouse(true)
end
--
--macro for creating color mode list
NPA_Options.Template.CreateColorModeList=function(parent,width,groupname,dataselector,buttonheight)
	local datafunc=function()
		return NPA_Options.InfoLib.GetColorModeList(groupname,dataselector.Value)
	end
	return NPA_Options.Template.CreateDropDownEditor(parent,width,Localization["ColorMode"],nil,datafunc,buttonheight)
end
--macro for creating data type list
NPA_Options.Template.CreateDataTypeList=function(parent,width,groupname,buttonheight)
	local datafunc=function()
		return NPA_Options.InfoLib.GetDataType(groupname)
	end
	return NPA_Options.Template.CreateDropDownEditor(parent,width,Localization["DataType"],Tooltips["DataType"][groupname],datafunc,buttonheight)
end
--macro for creating anchor frame list
NPA_Options.Template.CreateAnchorFrameList=function(parent,width,framegroup,buttonheight)
	local datafunc=function()
		return NPA_Options.InfoLib.GetAnchorFrameList(NPA_Options.GetPage("NamePlatePreview").FrameData.ModuleMain.FrameGroup)
	end
	return NPA_Options.Template.CreateDropDownEditor(parent,width,Localization["AnchorFrame"],Tooltips["AnchorFrame"],datafunc,buttonheight)
end
