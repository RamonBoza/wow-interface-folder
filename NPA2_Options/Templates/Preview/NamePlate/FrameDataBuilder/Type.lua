-- Author      : Nogarder
-- Create Date : 2012/9/3 9:59:45
NPA_Options.RegisterPageFunc("NamePlatePreviewFrameDataType",function()

	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	local Tooltips=Localization.Tooltips
	--
	local FrameData
	local RefreshFunc
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["Type"],150,150,nil)
	main:SetPoint("CENTER",UIParent,"CENTER",0,0)
	main:Hide()
	--
	local page=main.Frame
	--
	--faction dropdown
	local GetFaction=function()
		local data=NPA_Options.GetBasicTypeFaction()
		local i=0
		local faction={}
		for value,text in pairs(data)do
			i=i+1
			faction[i]={
				Text=text,
				Value=value,
				Color=CopyTable(NPA_Setting.Color["Faction"][value])
			}
		end
		return faction
	end
	local factionselector=NPA_Options.Template.CreateDropDownEditor(page,140,Localization["Faction"],Tooltips["Faction"],GetFaction)
	factionselector:SetPoint("TOPLEFT",page,"TOPLEFT",5,-25)
	factionselector.OnValueUpdateFunc=function()
		FrameData.UnitData.Faction=factionselector.Value
		NPA.EventHandler.FireEvent(8,"Type_Updated",FrameData)
	end
	factionselector.Revers=true
	--class dropdown
	local GetClass=function()
		local data=NPA_Options.GetBasicTypeClass()
		local i=0
		local class={}
		for value,text in pairs(data)do
			i=i+1
			class[i]={
				Text=text,
				Value=value,
				Color=CopyTable(NPA_Setting.Class[value].Color)
			}
		end
		return class
	end
	local classselector=NPA_Options.Template.CreateDropDownEditor(page,140,Localization["Class"],Tooltips["Class"],GetClass)
	classselector:SetPoint("TOPLEFT",factionselector,"BOTTOMLEFT",0,-25)
	classselector.OnValueUpdateFunc=function()
		FrameData.UnitData.Class=classselector.Value
		FrameData.UnitData.Type=1
		NPA.EventHandler.FireEvent(8,"Type_Updated",FrameData)
	end
	classselector.Revers=true
	--threat dropdown
	local GetThreat=function()
		local data=NPA_Options.GetBasicTypeThreat()
		local i=0
		local threat={}
		for value,text in pairs(data)do
			i=i+1
			threat[i]={
				Text=text,
				Value=value,
				Color=CopyTable(NPA_Setting.Color["Threat"][value])
			}
		end
		return threat
	end
	local threatselector=NPA_Options.Template.CreateDropDownEditor(page,140,Localization["Threat"],Tooltips["Threat"],GetThreat)
	threatselector:SetPoint("TOPLEFT",classselector,"BOTTOMLEFT",0,-25)
	threatselector.OnValueUpdateFunc=function()
		FrameData.UnitData.ThreatStatus=threatselector.Value
		NPA.EventHandler.FireEvent(8,"Threat_Updated",FrameData)
	end
	threatselector.Revers=true
	--
	local OnLoad=function()
		NPA_Options.Template.SetDropDownEditor(factionselector,FrameData.UnitData.Faction)
		NPA_Options.Template.SetDropDownEditor(classselector,FrameData.UnitData.Class)
		NPA_Options.Template.SetDropDownEditor(threatselector,FrameData.UnitData.Threat)
	end
	--
	main.OnSetFunc=function(parentframe)
		FrameData=parentframe.FrameData
		OnLoad()
	end
	--
	NPA_Options.RegisterPage("NamePlatePreviewFrameDataType",main)

end)