-- Author      : Nogarder
-- Create Date : 2012/11/4 7:53:23
NPA_Options.RegisterPageFunc("SpellLibLibEditor",function()

	local pairs=pairs
	local CopyTable=CopyTable
	local table_insert=table.insert
	--localization
	local Localization=NPA_Options.Localization.PagesResourcesLibSpellLib
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["SelectType"],150,240,nil,nil,nil)
	main:Hide()
	local listeditor=NPA_Options.Template.CreateListEditor(main.Frame,nil,150,240,main)
	listeditor.NoCopy=true
	--
	local TypeList={}
	--
	local GetSortData=function()
		return Localization["SortData"]
	end
	--
	local sortbydropdown=NPA_Options.Template.CreateDropDownEditor(main.Scroll,170,Localization["SortBy"],Tooltips["SortBy"],GetSortData)
	sortbydropdown:SetPoint("BOTTOM",main.Scroll,"TOP",0,15)
	NPA_Options.Template.SetDropDownEditor(sortbydropdown,0)
	--script
	local RefreshList=function()
		local data={}
		for name,_ in pairs(TypeList)do
			if(sortbydropdown.Value==0)then
				local count=0
				for _,spelldata in pairs(NPA_Setting.SpellLib)do
					if(spelldata.Catalog==name)then
						count=count+1
					end
				end
				if(count>0)then
					count="(|cff00ff00"..tostring(count)..")"
				else
					count="(|cffff0000"..tostring(count)..")"
				end
				table_insert(data,{
					Text=(NPA_Options.Localization.InfoLibSpell.Catalog[name] or name)..count,
					Value=name,
				})
			elseif(sortbydropdown.Value==1)then
				local count=0
				for _,spelldata in pairs(NPA_Setting.SpellLib)do
					if(spelldata.PVPDRType==name)then
						count=count+1
					end
				end
				if(count>0)then
					count="(|cff00ff00"..tostring(count)..")"
				else
					count="(|cffff0000"..tostring(count)..")"
				end
				table_insert(data,{
					Text=(NPA_Options.Localization.InfoLibSpell.DrType[name] or name)..count,
					Value=name,
				})
			end
		end
		NPA_Options.Template.UpdateListEditor(listeditor,data)
	end
	--
	local Refresh=function(spellid,sortwith)
		TypeList={}
		--build data
		if(sortbydropdown.Value==0)then
			--sort by catalog
			for _,spelldata in pairs(NPA_Setting.SpellLib)do
				TypeList[spelldata.Catalog]=true
			end
		elseif(sortbydropdown.Value==1)then
			for name,_ in pairs(NPA_Options.Localization.InfoLibSpell.DrType)do
				TypeList[name]=true
			end
			--sort by dr type
			for _,spelldata in pairs(NPA_Setting.SpellLib)do
				TypeList[spelldata.PVPDRType]=true
			end
		elseif(sortbydropdown.Value==2)then
			--sort by dr type
			for _,spelldata in pairs(NPA_Setting.SpellLib)do
				TypeList[spelldata.SpellType]=true
			end
		elseif(sortbydropdown.Value==3)then
			--sort by dr type
			for _,spelldata in pairs(NPA_Setting.SpellLib)do
				TypeList[spelldata.School]=true
			end
		end
		RefreshList()
		--
		main.CallBackRefresh(spellid,sortwith)
	end
	--
	main.CallBackRefresh=function(spellid,sortwith)
		if(spellid and NPA_Setting.SpellLib[spellid])then
			if(sortbydropdown.Value==0)then
				local spelldata=NPA_Setting.SpellLib[spellid]
				NPA_Options.SetPage("SpellSelector",main,spelldata.Catalog,spellid,sortbydropdown.Value,Refresh)
			elseif(sortbydropdown.Value==1)then
				local spelldata=NPA_Setting.SpellLib[spellid]
				NPA_Options.SetPage("SpellSelector",main,spelldata.PVPDRType,spellid,sortbydropdown.Value,Refresh)
			end
		elseif(sortwith)then
				NPA_Options.SetPage("SpellSelector",main,sortwith,nil,sortbydropdown.Value,Refresh)
		end
	end

	sortbydropdown.OnValueUpdateFunc=Refresh
	--
	listeditor.RefreshFunc=RefreshList
	listeditor.OnClickFunc=function(value,button)
		if(button=="LeftButton")then
			--setup editor page
			NPA_Options.SetPage("SpellSelector",main,value,nil,sortbydropdown.Value,Refresh)
		end
	end
	--
	listeditor.OnCreateFunc=function(newname)
		TypeList[newname]=true
	end
	listeditor.OnDeleteFunc=function(oldname)
		TypeList[oldname]=nil
		TypeList["Unsorted"]=true
		--
		if(sortbydropdown.Value==0)then
			--sort by catalog
			for _,spelldata in pairs(NPA_Setting.SpellLib)do
				if(spelldata.Catalog==oldname)then
					spelldata.Catalog="Unsorted"
				end
			end
		elseif(sortbydropdown.Value==1)then
			--sort by dr type
			for _,spelldata in pairs(NPA_Setting.SpellLib)do
				if(spelldata.PVPDRType==oldname)then
					spelldata.PVPDRType="Unsorted"
				end
			end
		elseif(sortbydropdown.Value==2)then
			--sort by dr type
			for _,spelldata in pairs(NPA_Setting.SpellLib)do
				if(spelldata.SpellType==oldname)then
					spelldata.SpellType="Unsorted"
				end
			end
		elseif(sortbydropdown.Value==3)then
			--sort by dr type
			for _,spelldata in pairs(NPA_Setting.SpellLib)do
				if(spelldata.School==oldname)then
					spelldata.School="Unsorted"
				end
			end
		end
	end
	listeditor.OnRenameFunc=function(oldname,newname)
		TypeList[oldname]=nil
		TypeList[newname]=true
		--
		if(sortbydropdown.Value==0)then
			--sort by catalog
			for _,spelldata in pairs(NPA_Setting.SpellLib)do
				if(spelldata.Catalog==oldname)then
					spelldata.Catalog=newname
				end
			end
		elseif(sortbydropdown.Value==1)then
			--sort by dr type
			for _,spelldata in pairs(NPA_Setting.SpellLib)do
				if(spelldata.PVPDRType==oldname)then
					spelldata.PVPDRType=newname
				end
			end
		elseif(sortbydropdown.Value==2)then
			--sort by dr type
			for _,spelldata in pairs(NPA_Setting.SpellLib)do
				if(spelldata.SpellType==oldname)then
					spelldata.SpellType=newname
				end
			end
		elseif(sortbydropdown.Value==3)then
			--sort by dr type
			for _,spelldata in pairs(NPA_Setting.SpellLib)do
				if(spelldata.School==oldname)then
					spelldata.School=newname
				end
			end
		end
	end
	--on zip and unzip
	main.Scroll.OnMinimizedFunc=function()
		sortbydropdown:Hide()
	end
	main.Scroll.OnRestoredFunc=function()
		sortbydropdown:Show()
	end
	--
	main.OnSetFunc=function(name)
		Refresh()
		if(name)then
			local spell=NPA_Setting.SpellLib[name]
			if(spell)then
				local sortby
				if(sortbydropdown.Value==0)then
					sortby=spell.Catalog
				elseif(sortbydropdown.Value==1)then
					sortby=spell.PVPDRType
				end
			elseif(sortbydropdown.Value==2)then
				sortby=spell.SpellType
			elseif(sortbydropdown.Value==3)then
				sortby=spelldata.School
			end
			NPA_Options.Template.SetSelectListFocus(listeditor,sortby)
			NPA_Options.SetPage("SpellSelector",main,name,nil,0)
		end
	end
	----
	NPA_Options.RegisterPage("SpellLibLibEditor",main)

end)