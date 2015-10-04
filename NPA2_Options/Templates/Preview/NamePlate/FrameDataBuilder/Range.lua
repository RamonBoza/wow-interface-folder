-- Author      : Nogarder
-- Create Date : 2015/1/7 23:02:24
NPA_Options.RegisterPageFunc("NamePlatePreviewFrameDataRange",function()

	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	--
	local FrameData
	local RefreshFunc
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["Range"],310,110,nil)
	main:SetPoint("CENTER",UIParent,"CENTER",0,0)
	main:Hide()
	--
	local page=main.Frame
	--
	--rangeminslider
	local rangeminslider=NPA_Options.Template.CreateSliderEdit(page,240,60,20,0,100,1,0,Localization["RangeMin"])
	rangeminslider:SetPoint("TOPLEFT",page,"TOPLEFT",5,-25)
	--rangemaxslider
	local rangemaxslider=NPA_Options.Template.CreateSliderEdit(page,240,60,20,0,100,1,0,Localization["RangeMax"])
	rangemaxslider:SetPoint("TOPLEFT",rangeminslider,"BOTTOMLEFT",0,-25)
	--
	healthslider.OnValueUpdateFunc=function()
		FrameData.UnitData.RangeMin=rangeminslider.Value
		FrameData.UnitData.RangeMax=rangemaxslider.Value
		FrameData.UnitData.RangeExact=0
		NPA.EventHandler.FireEvent(8,"Range_Updated",FrameData)
	end
	--
	maxhealthslider.OnValueUpdateFunc=function()
		NPA_Options.Template.SetSliderEdit(rangeminslider,nil,nil,rangemaxslider.Value)
		FrameData.UnitData.RangeMin=rangeminslider.Value
		FrameData.UnitData.RangeMax=rangemaxslider.Value
		FrameData.UnitData.RangeExact=0
		NPA.EventHandler.FireEvent(8,"Range_Updated",FrameData)
	end
	--
	local OnLoad=function()
		NPA_Options.Template.SetSliderEdit(rangeminslider,5)
		NPA_Options.Template.SetSliderEdit(rangemaxslider,30)
	end
	--
	main.OnSetFunc=function(parentframe)
		FrameData=parentframe.FrameData
		OnLoad()
	end
	--
	NPA_Options.RegisterPage("NamePlatePreviewFrameDataRange",main)

end)