-- Author      : Nogarder
-- Create Date : 2012/11/13 14:30:55
NPA_Options.RegisterPageFunc("SpellPicker",function()

	local pairs=pairs
	local table_getn=table.getn
	local table_insert=table.insert
	--
	local Localization=NPA_Options.Localization.PagesResourcesLibSpellLib
	local Tooltips=Localization.Tooltips
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,nil,360,340,nil,nil)
	main:SetPoint("CENTER",UIParent,"CENTER",0,0)
	main:Hide()
	--
	local page=main.Frame
	page:SetWidth(360)
	page:SetHeight(340)
	--
	local SortBy=0
	--
	local listeditor=NPA_Options.Template.CreateListEditor(nil,nil,170,330,page,nil,true)
	listeditor:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	listeditor:EnableMouse(false)
	listeditor.Frame:EnableMouse(false)
	--
	local GetSortData=function()
		return Localization["SortData"]
	end
	--
	local sortbydropdown=NPA_Options.Template.CreateDropDownEditor(main.Scroll,170,Localization["SortBy"],Tooltips["SortBy"],GetSortData)
	sortbydropdown:SetPoint("BOTTOM",main.Scroll,"TOP",0,5)
	NPA_Options.Template.SetDropDownEditor(sortbydropdown,0)
	--spellcheckboxlist
	local spellcheckboxlist=NPA_Options.Template.CreateCheckBoxList(page,170,330)
	spellcheckboxlist.Scroll:SetPoint("TOPRIGHT",page,"TOPRIGHT",-5,-5)
	--script
	local SpellList
	--
	local Refresh=function()
		local typelist={}
		--build data
		if(sortbydropdown.Value==0)then
			--sort by catalog
			for _,spelldata in pairs(NPA_Setting.SpellLib)do
				typelist[spelldata.Catalog]=true
			end
		elseif(sortbydropdown.Value==1)then
			--sort by dr type
			for _,spelldata in pairs(NPA_Setting.SpellLib)do
				typelist[spelldata.PVPDRType]=true
			end
		elseif(sortbydropdown.Value==2)then
			--sort by dr type
			for _,spelldata in pairs(NPA_Setting.SpellLib)do
				typelist[spelldata.SpellType]=true
			end
		elseif(sortbydropdown.Value==3)then
			--sort by dr type
			for _,spelldata in pairs(NPA_Setting.SpellLib)do
				typelist[spelldata.School]=true
			end
		end
		local data={}
		for name,_ in pairs(typelist)do
			if(sortbydropdown.Value==0)then
				table_insert(data,{
					Text=NPA_Options.Localization.InfoLibSpell.Catalog[name] or name,
					Value=name,
				})
			elseif(sortbydropdown.Value==1)then
				table_insert(data,{
					Text=NPA_Options.Localization.InfoLibSpell.DrType[name] or name,
					Value=name,
				})
			end
		end
		NPA_Options.Template.UpdateListEditor(listeditor,data)
	end
	--
	sortbydropdown.OnValueUpdateFunc=Refresh
	--
	listeditor.RefreshFunc=Refresh
	listeditor.OnClickFunc=function(value,button)
		if(button=="LeftButton")then
			--setup checkboxlist
			--build data
			local list={}
			--
			if(sortbydropdown.Value==0)then
				for spellid,data in pairs(NPA_Setting.SpellLib)do
					if(data.Catalog==value)then
						if(SpellList[spellid]~=nil)then
							list[spellid]=true
						else
							list[spellid]=false
						end
					end
				end
			elseif(sortbydropdown.Value==1)then
				for spellid,data in pairs(NPA_Setting.SpellLib)do
					if(data.PVPDRType==value)then
						if(SpellList[spellid]~=nil)then
							list[spellid]=true
						else
							list[spellid]=false
						end
					end
				end
			elseif(sortbydropdown.Value==2)then
				for spellid,data in pairs(NPA_Setting.SpellLib)do
					if(data.SpellType==value)then
						if(SpellList[spellid]~=nil)then
							list[spellid]=true
						else
							list[spellid]=false
						end
					end
				end
			elseif(sortbydropdown.Value==3)then
				for spellid,data in pairs(NPA_Setting.SpellLib)do
					if(data.School==value)then
						if(SpellList[spellid]~=nil)then
							list[spellid]=true
						else
							list[spellid]=false
						end
					end
				end
			end
			NPA_Options.Template.UpdateSpellCheckBoxList(spellcheckboxlist,list)
		end
	end
	--
	NPA_Options.Template.SetCheckBoxList(spellcheckboxlist,nil,function(name,checked)
		--set onclick func
		NPA_Options.RunFunc(main.CallBackFunc,name,checked)
	end,
		nil,nil)
	--on zip and unzip
	main.Scroll.OnMinimizedFunc=function()
		sortbydropdown:Hide()
	end
	main.Scroll.OnRestoredFunc=function()
		sortbydropdown:Show()
	end
	--
	main.OnSetFunc=function(spelllist,callbackfunc)
		SpellList=spelllist
		--
		main.CallBackFunc=callbackfunc
		NPA_Options.Template.UpdateCheckBoxList(spellcheckboxlist,{})
	end
	--
	NPA_Options.RegisterPage("SpellPicker",main)

end)