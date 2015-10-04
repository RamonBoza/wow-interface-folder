-- Author      : Nogarder
-- Create Date : 2014/11/22 23:56:54
NPA_Options.RegisterPageFunc("NamePlatePreviewFrameDataShield",function()

	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	--
	local FrameData
	local RefreshFunc
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["Shield"],310,110,nil)
	main:SetPoint("CENTER",UIParent,"CENTER",0,0)
	main:Hide()
	--
	local page=main.Frame
	--
	--shieldslider
	local shieldslider=NPA_Options.Template.CreateSliderEdit(page,240,60,20,1,1234567890,1,0,Localization["Shield"])
	shieldslider:SetPoint("TOPLEFT",page,"TOPLEFT",5,-25)
	--
	shieldslider.OnValueUpdateFunc=function()
		NPA_Options.Template.SetSliderEdit(shieldslider,nil,nil,FrameData.UnitData.HealthMax)
		FrameData.UnitData.Shield=shieldslider.Value
		FrameData.UnitData.ShieldMax=FrameData.UnitData.HealthMax
		NPA.EventHandler.FireEvent(8,"Shield_Updated",FrameData)
	end
	--
	local OnLoad=function()
		NPA_Options.Template.SetSliderEdit(shieldslider,567890123)
	end
	--
	main.OnSetFunc=function(parentframe)
		FrameData=parentframe.FrameData
		OnLoad()
	end
	--
	NPA_Options.RegisterPage("NamePlatePreviewFrameDataShield",main)
end)