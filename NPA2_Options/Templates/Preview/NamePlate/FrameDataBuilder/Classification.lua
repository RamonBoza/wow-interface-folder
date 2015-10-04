-- Author      : Nogarder
-- Create Date : 2013/12/9 18:31:21

NPA_Options.RegisterPageFunc("NamePlatePreviewFrameDataClassification",function()

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
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["Classification"],150,50,nil)
	main:SetPoint("CENTER",UIParent,"CENTER",0,0)
	main:Hide()
	--
	local page=main.Frame
	--
	--faction dropdown
	local GetClassification=function()
		return Localization["ClassificationList"]
	end
	local classificationselector=NPA_Options.Template.CreateDropDownEditor(page,140,Localization["Classification"],Tooltips["Classification"],GetClassification)
	classificationselector:SetPoint("TOPLEFT",page,"TOPLEFT",5,-25)
	classificationselector.OnValueUpdateFunc=function()
		FrameData.UnitData.Classification=classificationselector.Value
		NPA.EventHandler.FireEvent(8,"Classification_Updated",FrameData)
	end
	classificationselector.Revers=true
	--
	local OnLoad=function()
		NPA_Options.Template.SetDropDownEditor(classificationselector,FrameData.UnitData.Classification)
	end
	--
	main.OnSetFunc=function(parentframe)
		FrameData=parentframe.FrameData
		OnLoad()
	end
	--
	NPA_Options.RegisterPage("NamePlatePreviewFrameDataClassification",main)

end)