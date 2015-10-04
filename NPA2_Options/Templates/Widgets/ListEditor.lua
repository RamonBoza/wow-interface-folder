-- Author      : Nogarder
-- Create Date : 2012/6/27 15:49:06
local pairs=pairs
local CopyTable=CopyTable
--
local KeyWordColor="|cffff0000"
local ValueColor="|cff00ff00"
local OtherColor="|cffffffff"
--localization
local Localization=NPA_Options.Localization.TemplatesWidgetsListEditor
local Tooltips=Localization.Tooltips
--macro for creating unused name
local FindName=function(list,name)
	for _,button in pairs(list.Buttons)do
		if(button:IsShown() and button.Text==name)then
			return true
		end
	end
end
local CheckName=function(list,name)
	local newname=name
	if(FindName(list,newname))then
		local i=1
		while(FindName(list,newname))do
			newname=name.." ("..i..")"
			i=i+1
		end
	end
	return newname
end
--
NPA_Options.Template.UpdateListEditor=function(list,data)
	NPA_Options.Template.UpdateSelectList(list,data)
	NPA_Options.ClosePages(list.Parent,true)
end

---
NPA_Options.Template.CreateListEditor=function(frame,title,width,height,parent,buttonheight,nomenu,menuparent)
	local selectlist=NPA_Options.Template.CreateSelectList(parent,width,height,title,tooltips,frame,buttonheight,true)
	--
	selectlist.Parent=parent
	--
	local OnCreateFunc=function()
		local inputbox=NPA_Options.Template.SetInputBox(menuparent or selectlist,Localization["InputNewName"],"")
		inputbox.CallBackFunc=function(newname)
			local newname=CheckName(selectlist.Frame,newname)
			NPA_Options.RunFunc(selectlist.OnCreateFunc,newname)
			NPA_Options.RunFunc(selectlist.RefreshFunc,selectlist)
			--set focus
			NPA_Options.Template.SetSelectListFocus(selectlist,newname)
			--
			if(not selectlist.NoTip)then
				print(OtherColor.."["..ValueColor..newname..OtherColor.."] "..KeyWordColor..Localization["Created"])
			end
		end
		inputbox:ClearAllPoints()
		inputbox:SetPoint("BOTTOMRIGHT",selectlist,"TOPRIGHT",0,13)
		inputbox:SetFocus()
	end
	local OnDeleteFunc=function(value)
		if(selectlist.NoDefault==nil and value=="Default")then
			return
		end
		NPA_Options.RunFunc(selectlist.OnDeleteFunc,value)
		NPA_Options.RunFunc(selectlist.RefreshFunc,selectlist)
		if(not selectlist.NoTip)then
			print(OtherColor.."["..ValueColor..value..OtherColor.."] "..KeyWordColor..Localization["Deleted"])
		end
	end
	local OnCopyFunc=function(value)
		local newname=CheckName(selectlist.Frame,value..Localization["sCopy"])
		NPA_Options.RunFunc(selectlist.OnCopyFunc,value,newname)
		NPA_Options.RunFunc(selectlist.RefreshFunc,selectlist)
		if(not selectlist.NoTip)then
			print(OtherColor.."["..ValueColor..value..OtherColor.."] "..KeyWordColor..Localization["Copied"]..OtherColor.." ["..ValueColor..newname..OtherColor.."]")
		end
	end
	--
	selectlist.Frame.OnCopyFunc=OnCopyFunc
	selectlist.Frame.OnDeleteFunc=OnDeleteFunc
	selectlist.Frame.OnAddFunc=OnCreateFunc
	--dropdownmenu
	if(nomenu)then
		selectlist.ButtonClickFunc=function(self,button)
			NPA_Options.RunFunc(selectlist.OnClickFunc,selectlist.Value,button,self)
		end
	else
		--
		local buttondata={
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
				Text=Localization["Rename"],
				Value="Rename"
			},
			[4]={
				Text=Localization["Create"],
				Value="Create",
				Tooltips=Tooltips["Create"],
			}
		}
		local NPA_Options_Template_ListEditor_DropDownMenu_OnClickFunc=function(self)
			local value=self.Value
			if(value=="Copy")then
				OnCopyFunc(selectlist.Value)
			elseif(value=="Delete")then
				OnDeleteFunc(selectlist.Value)
			elseif(value=="Rename")then
				local inputbox=NPA_Options.Template.SetInputBox(menuparent or selectlist,Localization["InputNewName"],selectlist.Value)
				inputbox.CallBackFunc=function(newname)
					local newname=CheckName(selectlist.Frame,newname)
					NPA_Options.RunFunc(selectlist.OnRenameFunc,selectlist.Value,newname)
					NPA_Options.RunFunc(selectlist.RefreshFunc,selectlist)
					if(not selectlist.NoTip)then
						print(OtherColor.."["..ValueColor..selectlist.Value..OtherColor.."] "..KeyWordColor..Localization["RenamedTo"]..OtherColor.." ["..ValueColor..newname..OtherColor.."]")
					end
				end
				inputbox:ClearAllPoints()
				inputbox:SetPoint("BOTTOM",selectlist,"TOP",0,13)
				inputbox:SetFocus()
			elseif(value=="Create")then
				OnCreateFunc()
			end
		end
		--
		selectlist.ButtonClickFunc=function(self,button)
			NPA_Options.Template.HideInputBox()
			if(button=="RightButton")then
				if(selectlist.NoRename==true)then
					buttondata[3].Tooltips=""
					buttondata[3].Disabled=true
				else
					buttondata[3].Tooltips=Tooltips["Rename"]
					buttondata[3].Disabled=nil
				end
				if(selectlist.NoDelete==true)then
					buttondata[2].Tooltips=""
					buttondata[2].Disabled=true
				else
					buttondata[2].Tooltips=Tooltips["Delete"]
					buttondata[2].Disabled=nil
				end
				if(selectlist.NoCopy==true)then
					buttondata[1].Tooltips=""
					buttondata[1].Disabled=true
				else
					buttondata[1].Tooltips=Tooltips["Copy"]
					buttondata[1].Disabled=nil
				end
				if(selectlist.NoDefault==nil and self.Value=="Default")then
					buttondata[2].Tooltips=Tooltips["CantDeleteDefault"]
					buttondata[2].Disabled=true
					buttondata[3].Tooltips=Tooltips["CantRenameDefault"]
					buttondata[3].Disabled=true
				end
				local dropdownmenu=NPA_Options.Template.SetDropDownMenu(self:GetParent().Scroll,nil,buttondata,NPA_Options_Template_ListEditor_DropDownMenu_OnClickFunc,menuparent or selectlist)
				dropdownmenu:ClearAllPoints()
				dropdownmenu:SetPoint("LEFT",self:GetParent().Scroll,"RIGHT",3,0)
				dropdownmenu:SetPoint("TOP",self,"TOP",3,0)
			else
				NPA_Options.Template.HideDropDownMenu()
			end
			NPA_Options.RunFunc(selectlist.OnClickFunc,selectlist.Value,button,self)
		end
		local frameonclick=function(_,button)
			if(button=="RightButton")then
				buttondata[1].Disabled=true
				buttondata[2].Disabled=true
				buttondata[2].Tooltips=Tooltips["Delete"]
				buttondata[3].Disabled=true
				buttondata[3].Tooltips=Tooltips["Rename"]
				local dropdownmenu=NPA_Options.Template.SetDropDownMenu(selectlist,nil,buttondata,NPA_Options_Template_ListEditor_DropDownMenu_OnClickFunc,menuparent or selectlist)
				dropdownmenu:ClearAllPoints()
				dropdownmenu:SetPoint("LEFT",selectlist,"RIGHT",3,0)
				dropdownmenu:SetPoint("TOP",selectlist,"TOP",3,0)
			else
				NPA_Options.Template.HideDropDownMenu()
			end
		end
		selectlist:HookScript("OnMouseUp",frameonclick)
		--
		NPA_Options.Template.SetTooltips(Tooltips["SelectSetting"],selectlist.Frame)	
		--
		selectlist.Frame:HookScript("OnMouseUp",frameonclick)
	end
	--
	parent:HookScript("OnShow",function()
			NPA_Options.RunFunc(selectlist.RefreshFunc,selectlist)
		end)

	return selectlist
end

