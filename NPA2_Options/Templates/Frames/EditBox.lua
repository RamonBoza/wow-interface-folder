-- Author      : Nogarder
-- Create Date : 2012/6/16 7:59:32
NPA_Options.Template.CreateEditBox=function(parent,width,height,nofocus)
	local editbox=CreateFrame("EditBox",nil,parent)
	editbox:SetWidth(width)
	editbox:SetHeight(height)
	editbox:SetAutoFocus(nil)
	editbox:EnableMouse(true)
	editbox:SetFontObject("GameFontHighlight")
	editbox:SetScript("OnEnterPressed",function(self)
			self:ClearFocus()
		end)
	editbox:SetScript("OnEscapePressed",function(self)
			self:ClearFocus()
	end)

	NPA_Options.Template.CreateBorder(editbox)
	local background=NPA_Options.Template.CreateBackground(editbox)
	
	editbox:SetScript("OnEditFocusGained",function(self)
			self.Focused=1
			NPA_Options.Template.SetFocusBox(self,0)
			background:SetVertexColor(0.25,0.25,0.25,1)
		end)
	editbox:SetScript("OnEditFocusLost",function(self)
			self.Focused=nil
			NPA_Options.Template.HideFocusBox(self)
			background:SetVertexColor(1,1,1,0.2)
		end)

	if(not nofocus)then
		NPA_Options.Template.SetAutoFocus(editbox)
	end

	editbox:Show()

	return editbox
end
--
NPA_Options.Template.CreateMultiLineEditBox=function(parent,width,height)
	local scrollframe=NPA_Options.Template.CreateScrollFrame(parent,width,height,nil,true)

	local editbox=CreateFrame("EditBox",nil,scrollframe)
	--editbox:SetWidth(width)
	--editbox:SetHeight(height)
	editbox:SetAutoFocus(nil)
	editbox:EnableMouse(true)
	editbox:SetMultiLine(true)
	editbox:SetFontObject("GameFontHighlight")
	editbox:SetScript("OnEnterPressed",function(self)
			self:ClearFocus()
		end)
	editbox:SetScript("OnEscapePressed",function(self)
			self:ClearFocus()
	end)

	NPA_Options.Template.CreateBorder(editbox,nil,nil,nil,2)
	local background=NPA_Options.Template.CreateBackground(editbox,nil,nil,nil,2)
	
	editbox:SetScript("OnEditFocusGained",function(self)
			self.Focused=1
			NPA_Options.Template.SetFocusBox(self,0)
			background:SetVertexColor(0.25,0.25,0.25,1)
		end)
	editbox:SetScript("OnEditFocusLost",function(self)
			self.Focused=nil
			NPA_Options.Template.HideFocusBox(self)
			background:SetVertexColor(1,1,1,0.2)
		end)

	NPA_Options.Template.SetAutoFocus(editbox)
	--update scroll frame when cursor changed
	editbox:HookScript("OnCursorChanged",function()
		scrollframe:SetHeight(editbox:GetHeight()+10)
		NPA_Options.Template.UpdateScrollFrame(scrollframe)
	end)
	--

	scrollframe:SetWidth(width)
	scrollframe:SetHeight(height)
	
	editbox:SetPoint("TOPLEFT",scrollframe,"TOPLEFT",5,-5)
	editbox:SetPoint("TOPRIGHT",scrollframe,"TOPRIGHT",-5,-5)
	
	editbox.Scroll=scrollframe.Scroll

	editbox:Show()
	return editbox
end
