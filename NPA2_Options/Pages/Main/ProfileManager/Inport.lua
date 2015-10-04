-- Author      : Nogarder
-- Create Date : 2013/4/29 17:04:26

NPA_Options.RegisterPageFunc("ProfileInporter",function()
	local pairs=pairs
	local table_insert=table.insert
	--localization
	local Localization=NPA_Options.Localization.PagesMainProfileManager
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	local SelectedEntry={}
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["Inport"],660,300,nil,nil,nil)
	main:Hide()
	--
	local page=main.Frame
	local scroll=main.Scroll
	local SettingList={}
	--
	local editbox=NPA_Options.Template.CreateMultiLineEditBox(page,180,290)
	editbox.Scroll:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	--editbox:SetMaxLetters(65535)
	NPA_Options.Template.SetTooltips(Localization["PasteTextHere"],editbox,nil,nil,editbox)
	--inport button
	local inportbutton=NPA_Options.Template.CreateButton(page,200,15,Localization["Inport"])
	inportbutton:SetPoint("TOPLEFT",editbox.Scroll,"TOPRIGHT",30,0)
	--
	local checkboxlist=NPA_Options.Template.CreateCheckBoxList(page,180,240)
	checkboxlist.Scroll:SetPoint("TOPLEFT",inportbutton,"BOTTOMLEFT",0,-5)
	--
	local savetobutton=NPA_Options.Template.CreateButton(page,200,15,Localization["SaveTo"])
	savetobutton:SetPoint("TOPLEFT",inportbutton,"TOPRIGHT",30,0)

	local selectlist=NPA_Options.Template.CreateSelectList(page,180,240)
	selectlist:SetPoint("TOPLEFT",savetobutton,"BOTTOMLEFT",0,-5)
	selectlist.Frame:EnableMouse(false)
	selectlist:EnableMouse(false)
	--
	inportbutton:HookScript("OnMouseUp",function()
		local namelist,settings=NPA_Options.SettingTranslator.InportProfile(editbox:GetText())
		--
		SettingList={}
		--
		local data={}
		for index,setting in pairs(settings)do
			data[namelist[index]]=true
			SettingList[namelist[index]]=settings[index]
		end
		NPA_Options.Template.UpdateCheckBoxList(checkboxlist,data)
	end)
	--
	selectlist.ButtonClickFunc=function()
		NPA_Options.Template.EnableButton(savetobutton)
	end
	--
	savetobutton:HookScript("OnMouseUp",function()
		local msgbox=NPA_Options.Template.SetMsgBox(scroll,Localization["ConfirmOverwritten"],function()
			local setting
			if(selectlist.Value=="TheCurrentProfile")then
				setting=NPA_Setting
			else
				setting=NPA_Profile[selectlist.Value]
			end
			--
			local comparelist={}
			--
			local saved=0
			--
			for dname,dsetting in pairs(SettingList)do
				if(checkboxlist.Value[dname]==true)then
					--import
					table.insert(comparelist,{EntryA=setting,EntryB=dsetting})
					saved=saved+1
				end
			end
			--insert setting
			while(next(comparelist))do
				for index,cdata in pairs(comparelist)do
					local EntryA=cdata.EntryA
					local EntryB=cdata.EntryB

					--for every thing in entry b, set it in entry a
					if(type(EntryA)~=type(EntryB))then
						if(type(EntryB)=="table")then
							EntryA=CopyTable(EntryB)
						else
							EntryA=EntryB
						end			
					elseif(type(EntryB)=="table")then
						for bname,bentry in pairs(EntryB)do
							if(EntryA[bname]==nil)then
								if(EntryA[tonumber(bname)]~=nil)then
									table.insert(comparelist,{EntryA=EntryA[tonumber(bname)],EntryB=bentry})
								else
									if(type(bentry)=="table")then
										EntryA[bname]=CopyTable(bentry)
									else
										EntryA[bname]=bentry
									end
								end
							else
								table.insert(comparelist,{EntryA=EntryA[bname],EntryB=bentry})
							end
						end
					else
						EntryA=EntryB
					end
					--
					comparelist[index]=nil
				end
			end

			print(saved..Localization["Inported"])
			NPA.SettingManager.CheckSettingEntry(setting)
			
			NPA.EventHandler.FireEvent(6,"ProfileManager_ProfileLoaded",EntryName)
		end)
		msgbox:SetPoint("BOTTOM",savetobutton,"TOP",0,0)
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
		--
		NPA_Options.Template.DisableButton(savetobutton)
		--
		editbox:SetText("")
	end
	--
	NPA_Options.RegisterPage("ProfileInporter",main)
end)