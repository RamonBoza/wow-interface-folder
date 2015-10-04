-- Author      : Nogarder
-- Create Date : 2013/4/3 11:09:30
NPA_Options.RegisterPageFunc("NamePlatePreviewFrameDataAura",function()

	local CopyTable=CopyTable
	local random=random
	local floor=floor
	local table_getn=table.getn
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	local Tooltips=Localization.Tooltips
	--
	local FrameData
	local RefreshFunc
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["Aura"],210,250,nil)
	main:SetPoint("CENTER",UIParent,"CENTER",0,0)
	main:Hide()
	--
	local page=main.Frame
	--
	local width=200
	local step=-10
	--spellid slider
	local spellidslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,100000,1,0,Localization["SpellId"])
	spellidslider:SetPoint("TOPLEFT",page,"TOPLEFT",5,-20)
	NPA_Options.Template.SetSliderEdit(spellidslider,172)
	--icon preview
	local previewtexture=page:CreateTexture()
	previewtexture:SetWidth(40)
	previewtexture:SetHeight(40)
	previewtexture:SetPoint("TOPLEFT",spellidslider,"BOTTOMLEFT",0,step)
	previewtexture:SetTexture(NPA.SpellInfo.GetSpellInfo(172).Icon)
	--time length slider
	local timelengthslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,1000,1,0,Localization["TimeLength"])
	timelengthslider:SetPoint("TOPLEFT",previewtexture,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetSliderEdit(timelengthslider,50)
	--count slider
	local countslider=NPA_Options.Template.CreateSliderEdit(page,150,50,20,1,20,1,0,Localization["StackCount"])
	countslider:SetPoint("TOPLEFT",timelengthslider,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetSliderEdit(countslider,0)
	--sort dropdown
	local GetSort=function()
		return Localization.SortTable
	end
	local sortselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["Sort"],Tooltips["Sort"],GetSort)
	sortselector:SetPoint("TOPLEFT",countslider,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetDropDownEditor(sortselector,"DEBUFF")
	--type dropdown
	local GetSort=function()
		local datalist={}
		for value,name in pairs(NPA_Options.Localization.InfoLibSpell.Class)do
			table.insert(datalist,{
				Text=name,
				Value=value,
			})
		end
		return datalist
	end
	local typeselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["Type"],Tooltips["Type"],GetSort)
	typeselector:SetPoint("TOPLEFT",sortselector,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetDropDownEditor(typeselector,"Magic")
	--add button
	local addbutton=NPA_Options.Template.CreateButton(page,width,20,Localization["Add"])
	addbutton:SetPoint("TOPLEFT",typeselector,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetTooltips(Tooltips["Add"],addbutton,nil,2)
	--
	addbutton:HookScript("OnMouseUp",function()
		local auralist=FrameData.UnitData.Aura
		--try to reuse old ones first
		local nTime=NPA.GetTime()
		local max=table_getn(auralist)
		for i=1,max do
			local aura=auralist[i]
			if(aura.ExpirationTime<nTime)then
				aura.SpellId=spellidslider.Value
				aura.CasterGUID=UnitGUID("player")
				aura.Count=countslider.Value
				aura.AppliedTime=nTime
				aura.ExpirationTime=nTime+timelengthslider.Value
				aura.Sort=sortselector.Value
				aura.SpellType=typeselector.Value
				--fire event
				NPA.EventHandler.FireEvent(8,"Aura_Updated",FrameData)
				return
			end
		end
		--no availiable old ones, add a new one
		auralist[max+1]={
			CasterGUID=UnitGUID("player"),
			SpellId=spellidslider.Value,
			Count=countslider.Value,
			AppliedTime=nTime,
			ExpirationTime=nTime+timelengthslider.Value,
			Sort=sortselector.Value,
			SpellType=typeselector.Value,
		}
		--fire event
		NPA.EventHandler.FireEvent(8,"Aura_Updated",FrameData)
	end)
	--
	spellidslider.OnValueUpdateFunc=function()
		previewtexture:SetTexture(NPA.SpellInfo.GetSpellInfo(spellidslider.Value).Icon)
	end
	--
	main.OnSetFunc=function(parentframe)
		FrameData=parentframe.FrameData
	end
	--
	NPA_Options.RegisterPage("NamePlatePreviewFrameDataAura",main)

end)