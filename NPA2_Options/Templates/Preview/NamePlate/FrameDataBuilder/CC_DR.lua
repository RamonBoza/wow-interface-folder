-- Author      : Nogarder
-- Create Date : 2013/5/29 17:04:51
NPA_Options.RegisterPageFunc("NamePlatePreviewFrameDataCC_DR",function()

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
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["CC_DR"],210,265,nil)
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
	--sort dropdown
	local GetSort=function()
		return Localization.SortTable
	end
	local sortselector=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["Sort"],Tooltips["Sort"],GetSort)
	sortselector:SetPoint("TOPLEFT",timelengthslider,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetDropDownEditor(sortselector,"Debuff")
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
	--drtype
	--pvp dr type edit
	local drtypeedit=NPA_Options.Template.CreateDropDownEditor(page,200,Localization["DRType"],Tooltips["DRType"],NPA_Options.InfoLib.Spell.GetPVPDRType,20)
	drtypeedit.Label:SetPoint("BOTTOMLEFT",drtypeedit,"TOPLEFT",0,0)
	drtypeedit:SetPoint("TOPLEFT",typeselector,"BOTTOMLEFT",0,-20)
	drtypeedit.FreeEdit=true
	drtypeedit.Value="None"
	drtypeedit:SetText("None")
	--add button
	local addbutton=NPA_Options.Template.CreateButton(page,width,20,Localization["Add"])
	addbutton:SetPoint("TOPLEFT",drtypeedit,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetTooltips(Tooltips["Add"],addbutton,nil,2)
	--
	addbutton:HookScript("OnMouseUp",function()
		local ccdrlist=FrameData.UnitData.CC_DR
		--try to reuse old ones first
		local nTime=NPA.GetTime()
		local max=table_getn(ccdrlist)
		for i=1,max do
			local ccdr=ccdrlist[i]
			if(ccdr.PVPDRType==drtypeedit.Value)then
				--caculate count
				if((not ccdr.EndTime) or (ccdr.EndTime<nTime))then
					ccdr.Count=2
				elseif(ccdr.Count>4)then
					ccdr.Count=2
				else
					ccdr.Count=ccdr.Count*2
				end
				--
				ccdr.SpellId=spellidslider.Value
				ccdr.AppliedTime=nTime
				ccdr.EndTime=nTime+timelengthslider.Value
				ccdr.Sort=sortselector.Value
				ccdr.SpellType=typeselector.Value
				ccdr.PVPDRType=drtypeedit.Value
				--fire event
				NPA.EventHandler.FireEvent(8,"CC_DR_Updated",FrameData)
				return
			end
		end
		--no availiable old ones, add a new one
		ccdrlist[max+1]={
			CasterGUID=UnitGUID("player"),
			SpellId=spellidslider.Value,
			Count=2,
			AppliedTime=nTime,
			EndTime=nTime+timelengthslider.Value,
			Sort=sortselector.Value,
			SpellType=typeselector.Value,
			PVPDRType=drtypeedit.Value
		}
		--fire event
		NPA.EventHandler.FireEvent(8,"CC_DR_Updated",FrameData)
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
	NPA_Options.RegisterPage("NamePlatePreviewFrameDataCC_DR",main)

end)