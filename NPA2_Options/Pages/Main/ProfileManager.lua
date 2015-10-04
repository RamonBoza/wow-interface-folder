-- Author      : Nogarder
-- Create Date : 2013/4/25 16:16:23
NPA_Options.RegisterPageFunc("ProfileManager",function()
	local pairs=pairs
	local table_insert=table.insert
	--localization
	local Localization=NPA_Options.Localization.PagesMainProfileManager
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	local EntryName
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,nil,410,320,nil,nil,nil)
	main:Hide()
	--
	local page=main.Frame
	local scroll=main.Scroll
	local Selected
	--
	--save
	local savebutton=NPA_Options.Template.CreateButton(page,76,15,Localization["Save"])
	savebutton:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Save"],savebutton)
	--inport
	local inportbutton=NPA_Options.Template.CreateButton(page,76,15,Localization["Inport"])
	inportbutton:SetPoint("LEFT",savebutton,"RIGHT",5,0)
	NPA_Options.Template.SetTooltips(Tooltips["Inport"],inportbutton)
	NPA_Options.SetPageButton(inportbutton,"ProfileInporter",main)
	--export
	local exportbutton=NPA_Options.Template.CreateButton(page,76,15,Localization["Export"])
	exportbutton:SetPoint("LEFT",inportbutton,"RIGHT",5,0)
	NPA_Options.Template.SetTooltips(Tooltips["Export"],exportbutton)
	NPA_Options.SetPageButton(exportbutton,"ProfileExporter",main)
	--load
	local loadbutton=NPA_Options.Template.CreateButton(page,76,15,Localization["Load"])
	loadbutton:SetPoint("LEFT",exportbutton,"RIGHT",5,0)
	NPA_Options.Template.SetTooltips(Tooltips["Load"],loadbutton)
	--premade
	local premadebutton=NPA_Options.Template.CreateButton(page,76,15,Localization["Premade"])
	premadebutton:SetPoint("LEFT",loadbutton,"RIGHT",5,0)
	NPA_Options.Template.SetTooltips(Tooltips["Premade"],premadebutton)
	NPA_Options.SetPageButton(premadebutton,"ProfilePremade",main)
	--
	local listeditor=NPA_Options.Template.CreateListEditor(nil,nil,380,270,page)
	listeditor:SetPoint("TOPLEFT",savebutton,"BOTTOMLEFT",0,-5)
	listeditor.NoDefault=true
	--
	local UpdateList=function()
		local profiledata={}
		--build data here
		local i=1
		for name,_ in pairs(NPA_Profile)do
			profiledata[i]={
				Text=name,
				Value=name
			}
			i=i+1
		end
		NPA_Options.Template.UpdateListEditor(listeditor,profiledata)
		--editor
		NPA_Options.ClosePages(main,true)
		--
		Selected=nil
		NPA_Options.Template.SetSelectListFocus(listeditor,nil)
		NPA_Options.Template.DisableButton(loadbutton)
	end
	--
	listeditor.RefreshFunc=UpdateList
	--
	listeditor.OnCopyFunc=function(oldname,newname)
		NPA_Profile[newname]=CopyTable(NPA_Profile[oldname])
		UpdateList()
	end
	listeditor.OnDeleteFunc=function(oldname)
		NPA_Profile[oldname]=nil
		UpdateList()
	end
	listeditor.OnRenameFunc=function(oldname,newname)
		NPA_Profile[newname]=CopyTable(NPA_Profile[oldname])
		NPA_Profile[oldname]=nil
		UpdateList()
	end
	listeditor.OnCreateFunc=function(newname)
		NPA_Profile[newname]={}
		NPA.SettingManager.CheckSettingEntry(NPA_Profile[newname])
		UpdateList()
	end
	--
	listeditor.OnClickFunc=function(value)
		Selected=value
		NPA_Options.Template.EnableButton(loadbutton)
	end
	--
	local FindName=function(list,name)
		for _,button in pairs(list.Buttons)do
			if(button:IsShown() and button.Text==name)then
				return true
			end
		end
	end
	--
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
	savebutton:HookScript("OnMouseUp",function()
		local inputbox=NPA_Options.Template.SetInputBox(main,Localization["InputName"],UnitName("player").."("..date()..")")
		inputbox.CallBackFunc=function(name)
			local name=CheckName(listeditor.Frame,(name or ""))
			NPA_Profile[name]=CopyTable(NPA_Setting)
			print("["..name.."]"..Localization["Saved"])
			UpdateList()
		end
		inputbox:SetPoint("BOTTOM",savebutton,"TOP",10,0)
	end)
	loadbutton:HookScript("OnMouseUp",function()
		if(Selected)then
			local msgbox=NPA_Options.Template.SetMsgBox(main,Localization["SettingWillLose"],function()
				NPA_Setting=CopyTable(NPA_Profile[Selected])
				print("["..Selected.."]"..Localization["Loaded"])
				UpdateList()
				--fire event
				NPA.EventHandler.FireEvent(6,"ProfileManager_ProfileLoaded")
			end)
			msgbox:SetPoint("BOTTOM",loadbutton,"TOP",10,0)
		end
	end)
	--
	main.OnSetFunc=function()
		UpdateList()
	end
	--
	NPA_Options.RegisterPage("ProfileManager",main)

end)