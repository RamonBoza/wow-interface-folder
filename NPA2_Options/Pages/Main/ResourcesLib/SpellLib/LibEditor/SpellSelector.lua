-- Author      : Nogarder
-- Create Date : 2012/11/8 12:06:26
NPA_Options.RegisterPageFunc("SpellSelector",function()

	local pairs=pairs
	local CopyTable=CopyTable
	local table_insert=table.insert
	--localization
	local Localization=NPA_Options.Localization.PagesResourcesLibSpellLib
	local Tooltips=Localization.Tooltips
	---
	local parent=NPA_Options.MainFrame
	local RefreshFunc
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["SelectSpell"],200,240,nil,nil)
	main:Hide()
	local listeditor=NPA_Options.Template.CreateListEditor(main.Frame,nil,200,240,main,nil)
	listeditor.NoRename=true
	listeditor.NoCopy=true
	listeditor.NoTip=true
	--
	local SortWith
	local SortBy
	--script
	local Refresh=function()
		local data={}
		if(SortBy==0)then
			for spellid,spelldata in pairs(NPA_Setting.SpellLib)do
				if(spelldata.Catalog==SortWith)then
					local spellname
					if(spelldata.NewName==nil or spelldata.NewName=="")then
						spellname=GetSpellInfo(spellid)
					else
						spellname=spelldata.NewName
					end
					table_insert(data,{
						Text=(spellname or "N/A").."("..spellid..")",
						Value=spellid,
						TextureFile=spelldata.Icon,
						SquareTexture=true
					})
				end
			end
		elseif(SortBy==1)then
			for spellid,spelldata in pairs(NPA_Setting.SpellLib)do
				if(spelldata.PVPDRType==SortWith)then
					if(spelldata.NewName==nil or spelldata.NewName=="")then
						spellname=GetSpellInfo(spellid)
					else
						spellname=spelldata.NewName
					end
					table_insert(data,{
						Text=(spellname or "N/A").."("..spellid..")",
						Value=spellid,
						TextureFile=spelldata.Icon,
						SquareTexture=true
					})
				end
			end
		elseif(SortBy==2)then
			for spellid,spelldata in pairs(NPA_Setting.SpellLib)do
				if(spelldata.SpellType==SortWith)then
					if(spelldata.NewName==nil or spelldata.NewName=="")then
						spellname=GetSpellInfo(spellid)
					else
						spellname=spelldata.NewName
					end
					table_insert(data,{
						Text=(spellname or "N/A").."("..spellid..")",
						Value=spellid,
						TextureFile=spelldata.Icon,
						SquareTexture=true
					})
				end
			end
		elseif(SortBy==3)then
			for spellid,spelldata in pairs(NPA_Setting.SpellLib)do
				if(spelldata.School==SortWith)then
					local spellname=GetSpellInfo(Spellid)
					table_insert(data,{
						Text=(spelldata.NewName or spellname or "N/A").."("..spellid..")",
						Value=spellid,
						TextureFile=spelldata.Icon,
						SquareTexture=true
					})
				end
			end
		end
		NPA_Options.Template.UpdateListEditor(listeditor,data)
	end
	--
	listeditor.RefreshFunc=Refresh
	listeditor.OnDeleteFunc=function(oldname)
		NPA_Setting.SpellLib[oldname]=nil
		Refresh()
		NPA_Options.RunFunc(RefreshFunc,nil,SortWith)
	end
	listeditor.OnCreateFunc=function(newname)
		NPA_Options.SetPage("SpellLookUp",main,newname,function(spellid)
			if(NPA_Setting.SpellLib[spellid])then
				print(Localization["SpellAlreadyExists"])
				if(SortBy==0)then
					NPA_Setting.SpellLib[spellid].Catalog=SortWith
				elseif(SortBy==1)then
					NPA_Setting.SpellLib[spellid].PVPDRType=SortWith
				elseif(SortBy==2)then
					NPA_Setting.SpellLib[spellid].SpellType=SortWith
				elseif(SortBy==3)then
					NPA_Setting.SpellLib[spellid].School=SortWith
				end
			else
				local name, _,icon, casttime,minrange,maxrange=GetSpellInfo(spellid)
				--create from templates
				local thespell=NPA.SettingManager.GetDefault("Spell")
				--{
				thespell.Name=name
				--	School=0,
				--	Icon=icon,
				thespell.CastTime=(casttime or 0)/1000
				thespell.MinRange=minrange
				thespell.MaxRange=maxrange
				thespell.Icon=icon
				thespell.CoolDown=NPA.SpellInfo.GetSpellCoolDown(spellid)
				--	CoolDownStack=0,
				--	CoolDownType=0,
				--	Length=0,
				--	MaxStack=0,
				--	Catalog="None",
				--	Class="None",
				--	DispelAble=nil,
				--	PVPLength=0,
				--	PVPDRType="None",
				--	CounterSpellLength=0,
				--	SpellType="None",
				--	AffectSpellList={}
				--}
				--
				if(SortBy==0)then
					thespell.Catalog=SortWith
				elseif(SortBy==1)then
					thespell.PVPDRType=SortWith
				elseif(SortBy==2)then
					thespell.SpellType=SortWith
				elseif(SortBy==3)then
					thespell.School=SortWith
				end
				NPA_Setting.SpellLib[spellid]=thespell
				--
				print(Localization["SpellCreated"])
			end
			Refresh()
			NPA_Options.RunFunc(RefreshFunc,nil,SortWith)
			
			NPA_Options.SetPage("SpellEditor",main,spellid,RefreshFunc)
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
			NPA_Options.SetPage("SpellEditor",main,value,RefreshFunc)
		end
	end
	--
	main.OnSetFunc=function(sortwith,spellid,sortby,refreshfunc)
		SortWith=sortwith
		SortBy=sortby
		RefreshFunc=refreshfunc
		if(spellid)then
			Refresh()
			NPA_Options.Template.SetSelectListFocus(listeditor,spellid)
			NPA_Options.SetPage("SpellEditor",main,spellid,RefreshFunc)
		end
	end
	----
	NPA_Options.RegisterPage("SpellSelector",main)
end)

