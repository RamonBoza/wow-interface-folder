-- Author      : Nogarder
-- Create Date : 2013/5/4 17:02:26
NPA_Options.RegisterPageFunc("SpellEditorAffectList",function()

	local pairs=pairs
	local CopyTable=CopyTable
	local table_insert=table.insert
	--localization
	local Localization=NPA_Options.Localization.TemplatesWindowSpellEditor
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["SelectSpell"],350,240,nil,nil)
	main:Hide()
	--
	local page=main.Frame
	--
	local listeditor=NPA_Options.Template.CreateListEditor(nil,nil,200,220,page,nil)
	listeditor:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	listeditor.NoRename=true
	listeditor.NoCopy=true
	listeditor.NoTip=true
	--
	--affect type
	local affecttypeselector=NPA_Options.Template.CreateDropDownEditor(page,100,Localization["AffectType"],Tooltips["AffectType"],NPA_Options.InfoLib.Spell.GetAffectType,20)
	affecttypeselector:SetPoint("TOPLEFT",listeditor,"TOPRIGHT",30,-15)
	affecttypeselector.Label:SetPoint("BOTTOMLEFT",affecttypeselector,"TOPLEFT",0,0)
	--affacamout slider
	local affectamoutslider=NPA_Options.Template.CreateSliderEdit(page,60,40,20,0,100,1,0,Localization["AffectAmount"],Tooltips["AffectAmount"])
	affectamoutslider:SetPoint("TOPLEFT",affecttypeselector,"BOTTOMLEFT",0,-15)
	--
	local SpellList
	local Selected=nil
	---
	local Update=function()
		if(Selected)then
			local data=SpellList[Selected]
			NPA_Options.Template.EnableDropDownEditor(affecttypeselector)
			NPA_Options.Template.EnableSliderEdit(affectamoutslider)
			NPA_Options.Template.SetDropDownEditor(affecttypeselector,data.AffectType)
			NPA_Options.Template.SetSliderEdit(affectamoutslider,data.AffectAmount)
		else
			NPA_Options.Template.DisableDropDownEditor(affecttypeselector)
			NPA_Options.Template.DisableSliderEdit(affectamoutslider)
		end
	end
	--script
	local Refresh=function()
		local data={}
		for spellid,_ in pairs(SpellList)do
			local name,_,icon=GetSpellInfo(spellid)
			if(name)then
				table_insert(data,{
					Text=name.."("..spellid..")",
					Value=spellid,
					TextureFile=icon,
					SquareTexture=true
				})
			end
		end
		NPA_Options.Template.UpdateListEditor(listeditor,data)
		Selected=nil
		Update()
	end
	--
	local Save=function()
		if(Selected)then
			local data=SpellList[Selected]
			data.AffectType=affecttypeselector.Value
			data.AffectAmount=affectamoutslider.Value
		end
	end
	--
	listeditor.RefreshFunc=Refresh
	listeditor.OnDeleteFunc=function(oldname)
		SpellList[oldname]=nil
		Refresh()
	end
	listeditor.OnCreateFunc=function(newname)
		NPA_Options.SetPage("SpellLookUp",main,newname,function(spellid)
			if(SpellList[spellid])then
				print(Localization["SpellAlreadyExists"])
			else
				SpellList[spellid]={
					AffectType=0,
					AffectAmount=0,
				}
				print(Localization["SpellCreated"])
				Refresh()
			end
		end)
	end
	listeditor.ButtonOnEnterFunc=function(self)
		GameTooltip:SetOwner(self,"ANCHOR_RIGHT")
		GameTooltip:AddSpellByID(self.Value)
		GameTooltip:AddLine("Spell id"..": |cff00ff00"..self.Value)
		GameTooltip:Show()
	end
	listeditor.ButtonOnLeaveFunc=function()
		GameTooltip:Hide()
	end
	listeditor.OnClickFunc=function(value,key)
		if(key=="LeftButton")then
			Selected=value
			Update()
		end
	end
	--
	affectamoutslider.OnValueUpdateFunc=Save
	affecttypeselector.OnValueUpdateFunc=Save
	--
	main.OnSetFunc=function(spelllist)
		SpellList=spelllist
		Selected=nil
		Refresh()
		Update()
	end
	----
	NPA_Options.RegisterPage("SpellEditorAffectList",main)

end)

