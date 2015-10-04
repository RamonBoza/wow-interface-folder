-- Author      : Nogarder
-- Create Date : 2012/8/1 13:24:51
NPA_Options.RegisterPageFunc("NamePlatePreviewFrameDataHealth",function()

	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	--
	local FrameData
	local RefreshFunc
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["Health"],310,110,nil)
	main:SetPoint("CENTER",UIParent,"CENTER",0,0)
	main:Hide()
	--
	local page=main.Frame
	--
	--healthslider
	local healthslider=NPA_Options.Template.CreateSliderEdit(page,240,60,20,1,1234567890,1,0,Localization["Health"])
	healthslider:SetPoint("TOPLEFT",page,"TOPLEFT",5,-25)
	--maxhealthslider
	local maxhealthslider=NPA_Options.Template.CreateSliderEdit(page,240,60,20,10,1234567890,1,0,Localization["HealthMax"])
	maxhealthslider:SetPoint("TOPLEFT",healthslider,"BOTTOMLEFT",0,-25)
	--
	healthslider.OnValueUpdateFunc=function()
		FrameData.UnitData.Health=healthslider.Value
		NPA.EventHandler.FireEvent(8,"Health_Updated",FrameData)
	end
	--
	maxhealthslider.OnValueUpdateFunc=function()
		NPA_Options.Template.SetSliderEdit(healthslider,nil,nil,maxhealthslider.Value)
		FrameData.UnitData.HealthMax=maxhealthslider.Value
		FrameData.UnitData.Health=healthslider.Value
		NPA.EventHandler.FireEvent(8,"Health_Updated",FrameData)
	end
	--
	local OnLoad=function()
		NPA_Options.Template.SetSliderEdit(healthslider,123456789)
		NPA_Options.Template.SetSliderEdit(maxhealthslider,1234567890)
	end
	--
	main.OnSetFunc=function(parentframe)
		FrameData=parentframe.FrameData
		OnLoad()
	end
	--
	NPA_Options.RegisterPage("NamePlatePreviewFrameDataHealth",main)

end)