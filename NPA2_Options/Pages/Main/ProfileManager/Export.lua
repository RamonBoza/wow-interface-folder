-- Author      : Nogarder
-- Create Date : 2013/4/29 17:01:54
NPA_Options.RegisterPageFunc("ProfileExporter",function()
	local pairs=pairs
	--localization
	local Localization=NPA_Options.Localization.PagesMainProfileManager
	local Tooltips={}--Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	local EntryName
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["Export"],840,300,nil,nil,nil)
	main:Hide()
	--
	local page=main.Frame
	local scroll=main.Scroll
	local OutPut=""
	--
	local ListData
	local ShowList
	local ExtendedList
	--
	local selectlist=NPA_Options.Template.CreateSelectList(page,180,270)
	selectlist:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	selectlist.Frame:EnableMouse(false)
	selectlist:EnableMouse(false)
	--
	local checkboxlist=NPA_Options.Template.CreateCheckBoxList(page,180,270)
	checkboxlist.Scroll:SetPoint("TOPLEFT",selectlist,"TOPRIGHT",30,0)
	--
	local checkboxlist2=NPA_Options.Template.CreateCheckBoxList(page,180,270)
	checkboxlist2.Scroll:SetPoint("TOPLEFT",checkboxlist.Scroll,"TOPRIGHT",30,0)

	--export button
	local exportbutton=NPA_Options.Template.CreateButton(page,200,15,Localization["Export"])
	exportbutton:SetPoint("TOPLEFT",checkboxlist2.Scroll,"TOPRIGHT",30,0)
	--
	local editbox=NPA_Options.Template.CreateMultiLineEditBox(page,180,260)
	editbox.Scroll:SetPoint("TOPLEFT",exportbutton,"BOTTOMLEFT",0,-5)
	--editbox.Scroll:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT",-25,20)
	--editbox:SetMaxLetters(65535)

	NPA_Options.Template.SetTooltips(Localization["CopyTheseText"],editbox,nil,nil,editbox)
	--
	local GetEntryLevel=function(entry)
		return table.getn({string.split("\\",entry)})
	end
	--extended checkbox list
	local CompareEntryName=function(entryA,entryB)
		local stringa={string.split("\\",entryA)}
		local stringb={string.split("\\",entryB)}
		for i=1,table.getn(stringa)do
			if(stringa[i]~=stringb[i])then
				return false
			end
		end
		return true
	end
	--
	local CompareSubEntry=function(entryA,entryB)
		return (GetEntryLevel(entryA)+1==GetEntryLevel(entryB) and CompareEntryName(entryA,entryB))
	end
	--
	local HasSubEntry=function(name,ListData)
		for dname,_ in pairs(ListData)do
			if(CompareSubEntry(name,dname))then
				return true
			end
		end
		return false
	end
	--
	local UpdateCheckList=function()
		local data=CopyTable(checkboxlist.Value)
		for name,value in pairs(data)do
			for dname,dvalue in pairs(checkboxlist.Value)do
				if((not dvalue) or (value==true and name~=dname and CompareEntryName(name,dname)==true))then
					data[dname]=nil
				end
			end
		end
		NPA_Options.Template.UpdateCheckBoxList(checkboxlist2,data)
	end
	--
	local UpdateExtendedCheckBoxList=function(checkboxlist,list,Localization)
		--build a huge list with all sub entry in it
		ListData={}
		local parent=nil
		--
		local tablelist={[1]={Entry=list,Name=""}}
		while(next(tablelist))do
			for index,ddata in pairs(tablelist)do
				for name,subentry in pairs(ddata.Entry)do
					if(type(subentry)=="table")then
						table.insert(tablelist,{Entry=subentry,Name=ddata.Name.."\\"..name})
					end
					ListData[ddata.Name.."\\"..name]={Text=tostring(name),Value=false,Parent=entry}
				end
				tablelist[index]=nil
			end
		end
		--
		ShowList={}
		ExtendedList={}
		for name,_ in pairs(list)do
			ShowList["\\"..name]=true
		end
		--
		checkboxlist.Value={}
		--
		local UpdateList=function(checkboxname)
			local localization=Localization or {}
			local data={}
			for i=0,10 do
				local insertdata={}
				for name,value in pairs(ShowList)do
					if(value==true and GetEntryLevel(name)==i)then
						table.insert(insertdata,{Name=name,Data=ListData[name],SubEntry=HasSubEntry(name,ListData)})
					end
				end
				table.sort(insertdata,function(a,b)
					local subentrya=a.SubEntry
					local subentryb=b.SubEntry
					if(subentrya and not subentryb)then
						return true
					elseif(not subentrya and subentryb)then
						return fasle
					elseif((not subentry and not subentryb) or 
						(subentrya and subentryb))then
						return a.Data.Text<b.Data.Text
					else
						return false
					end
				end)
				for index,idata in pairs(insertdata)do
					local insertpos=1
					for j=1,table.getn(data)do
						if(GetEntryLevel(data[j].Name)==GetEntryLevel(idata.Name)-1 and CompareEntryName(data[j].Name,idata.Name))then
							insertpos=j+1
							break
						end
					end
					local dentry=idata.Data
					table.insert(data,insertpos,{
						Name=idata.Name,
						Text=localization[dentry.Text] or dentry.Text,
						Tooltips=nil,
						Value=checkboxlist.Value[idata.Name],
						Level=GetEntryLevel(idata.Name),
						InsertPos=insertpos,
						Offset=(GetEntryLevel(idata.Name)-2)*20
					})
					--updated=true
				end
			end

			NPA_Options.Template.UpdateCheckBoxListByData(checkboxlist,data,true)
			NPA_Options.Template.SetCheckBoxListFocus(checkboxlist,checkboxname)
		end
		--
		checkboxlist.OnCheckBoxCreateFunc=function(checkbox)
			local button=NPA_Options.Template.CreateButton(checkbox,13,13,"+")
			button:SetPoint("LEFT",checkbox,"LEFT",17,0)
			button:HookScript("OnMouseUp",function()
				if(ExtendedList[checkbox.Name]==true)then
					for name,_ in pairs(ListData)do
						if(name~=checkbox.Name and CompareEntryName(checkbox.Name,name) )then
							ShowList[name]=false
						end
					end
					ExtendedList[checkbox.Name]=false
				else
					for name,_ in pairs(ListData)do
						if(CompareSubEntry(checkbox.Name,name))then
							ShowList[name]=true
						end
					end
					ExtendedList[checkbox.Name]=true
				end
				UpdateList(checkbox.Name)
			end)
			checkbox.Button=button
		end
		checkboxlist.OnValueUpdateFunc=function(name,checked)
			for dname,_ in pairs(ListData)do
				if(CompareEntryName(name,dname))then
					checkboxlist.Value[dname]=checked
				end
			end
			UpdateList(name)
			UpdateCheckList()
		end
		checkboxlist.OnCheckBoxUpdateFunc=function(checkbox)
			if(HasSubEntry(checkbox.Name,ListData))then
				checkbox.Button:Show()
			else
				checkbox.Button:Hide()
			end
		end

		UpdateList()
	end
	--
	selectlist.ButtonClickFunc=function(button)
		local setting
		if(button.Value=="TheCurrentProfile")then
			setting=NPA_Setting
		else
			setting=NPA_Profile[button.Value]
		end
		UpdateExtendedCheckBoxList(checkboxlist,setting,Localization)
		NPA_Options.Template.UpdateCheckBoxList(checkboxlist2,{})
	end
	--
	exportbutton:HookScript("OnMouseUp",function()
		--
		OutPut=""
		local outputcount=0
		for name,checked in pairs(checkboxlist2.Value)do
			if(checked==true)then
				OutPut=OutPut.."@"..NPA_Options.SettingTranslator.ExportProfile(selectlist.Value,name)
				outputcount=outputcount+1
			end
		end
		print(outputcount..Localization["Exported"])
		editbox:SetText(OutPut)
		editbox:HighlightText()
	end)
	--
	editbox:HookScript("OnCursorChanged",function()
		if(editbox:GetText()~=OutPut)then
			editbox:SetText(OutPut)
			--
		end
		editbox:HighlightText()
	end)
	--
	main.OnSetFunc=function()
		local data={}
		for name,_ in pairs(NPA_Profile)do
			table.insert(data,{Text=name,Value=name})
		end
		table.insert(data,{Text=Localization["Current"],Value="TheCurrentProfile"})
		--
		NPA_Options.Template.UpdateSelectList(selectlist,data)
		--
		NPA_Options.Template.SetSelectListFocus(selectlist,nil)
		--
		NPA_Options.Template.UpdateCheckBoxList(checkboxlist,{})
		NPA_Options.Template.UpdateCheckBoxList(checkboxlist2,{})
	end
	--
	NPA_Options.RegisterPage("ProfileExporter",main)
end)