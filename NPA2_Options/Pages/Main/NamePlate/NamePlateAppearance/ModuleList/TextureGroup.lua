-- Author      : Nogarder
-- Create Date : 2012/12/11 10:27:38
NPA_Options.RegisterPageFunc("NamePlateAppearanceTextureGroup",function()

	local pairs=pairs
	local table_insert=table.insert
	--localization
	local Localization=NPA_Options.Localization.PagesModuleList
	---
	local parent=NPA_Options.MainFrame
	local EntryName
	local Preview=NPA_Options.GetPage("NamePlatePreview")
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["SelectProfile"],400,320,nil,nil,nil)
	main:Hide()
	--
	local page=main.Frame
	local scroll=main.Scroll
	--
	local Liner,Liner2
	--
	local listeditor=NPA_Options.Template.CreateListEditor(main.Frame,nil,120,240,main)
	--
	local HideLiner=function()
		--hide liner
		Liner:Hide()
		Liner2:Hide()
		--disable blinking
		local framegroup=Preview.FrameData.ModuleMain.FrameGroup
		for name,_ in pairs(framegroup)do
			NPA_Options.Animation.SetBlink(framegroup[name].Frame,nil)
		end
	end
	--
	listeditor.RefreshFunc=function(list)
		HideLiner()
		--update editor content
		local listdata={}
		for name,_ in pairs(NPA_Setting.NamePlate[EntryName].TextureGroupSetting)do
			table_insert(listdata,{
				Text=name,
				Value=name
			})
		end
		--
		NPA_Options.Template.UpdateListEditor(listeditor,listdata)
		--editor
		NPA_Options.ClosePages(main,true)
	end
	--
	listeditor.ButtonOnEnterFunc=function(self)
		local name=self.Value.."TextureGroup"
		local framegroup=Preview.FrameData.ModuleMain.FrameGroup
		if(framegroup[name] and framegroup[name].Frame:IsShown())then
			--set liner
			local liner=Liner2
			liner:ClearAllPoints()
			liner:SetPoint("CENTER",self,"LEFT",0,0)
			liner.EndPoint:SetPoint("CENTER",framegroup[name].Frame,"CENTER",0,0)
			liner:Show()
			--set blink
			for aname,_ in pairs(framegroup)do
				if(aname==name)then
					NPA_Options.Animation.SetBlink(framegroup[aname].Frame,1)
				else
					NPA_Options.Animation.SetBlink(framegroup[aname].Frame,nil)
				end
			end
		else
			Liner2:Hide()
		end
	end
	listeditor.ButtonOnLeaveFunc=function(self)
		local name=self.Value.."TextureGroup"
		local framegroup=Preview.FrameData.ModuleMain.FrameGroup
		if(framegroup[name] and framegroup[name].Frame:IsShown())then
			--set liner
			Liner2:Hide()
			--set blink
			local modulelist=NPA_Options.InfoLib.GetModules()
			for aname,_ in pairs(framegroup)do
				if(aname==name)then
					NPA_Options.Animation.SetBlink(framegroup[aname].Frame,nil)
				end
			end
		end
	end
	--
	local FireEvent=function()
		NPA.EventHandler.FireEvent(6,"NamePlate_ProfileKeyChange",EntryName)
	end
	--
	listeditor.OnCopyFunc=function(oldname,newname)
		NPA_Setting.NamePlate[EntryName].TextureGroupSetting[newname]=CopyTable(NPA_Setting.NamePlate[EntryName].TextureGroupSetting[oldname])
		FireEvent()
	end
	listeditor.OnDeleteFunc=function(oldname)
		NPA_Setting.NamePlate[EntryName].TextureGroupSetting[oldname]=nil
		FireEvent()
	end
	listeditor.OnRenameFunc=function(oldname,newname)
		NPA_Setting.NamePlate[EntryName].TextureGroupSetting[newname]=CopyTable(NPA_Setting.NamePlate[EntryName].TextureGroupSetting[oldname])
		NPA_Setting.NamePlate[EntryName].TextureGroupSetting[oldname]=nil
		FireEvent()
	end
	listeditor.OnCreateFunc=function(newname)
		local default=NPA.SettingManager.GetDefault("NamePlateTextureGroup")
		NPA_Setting.NamePlate[EntryName].TextureGroupSetting[newname]=CopyTable(default)
		FireEvent()
	end
	listeditor.OnClickFunc=function(name,button,self)
		local aname=name.."TextureGroup"
		local framegroup=Preview.FrameData.ModuleMain.FrameGroup
		if(framegroup[aname] and framegroup[aname].Frame:IsShown())then
			--set liner
			local liner=Liner
			liner:ClearAllPoints()
			liner:SetPoint("CENTER",self,"LEFT",0,0)
			liner.EndPoint:SetPoint("CENTER",framegroup[aname].Frame,"CENTER",0,0)
			liner:Show()
		else
			Liner:Hide()
		end
		--set edit page
		NPA_Options.SetPage("NamePlateTextureGroupEditor",main,NPA_Setting.NamePlate[EntryName].TextureGroupSetting[name],
			--on value update
			FireEvent,
			name)
	end
	--
	main:HookScript("OnHide",HideLiner)
	--
	main.OnSetFunc=function(entryname,liner,liner2)
		Liner=liner
		Liner2=liner2
		--set liner
		Liner:Hide()
		Liner2:Hide()
		--
		local level=main:GetFrameLevel()+3
		Liner:SetFrameLevel(level)
		Liner2:SetFrameLevel(level)
		--
		EntryName=entryname
	end
	--
	NPA_Options.RegisterPage("NamePlateAppearanceTextureGroup",main)

end)