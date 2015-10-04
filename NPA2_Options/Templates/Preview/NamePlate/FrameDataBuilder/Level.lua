-- Author      : Nogarder
-- Create Date : 2012/12/28 17:39:57
NPA_Options.RegisterPageFunc("NamePlatePreviewFrameDataLevel",function()

	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	--
	local FrameData
	local RefreshFunc
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["Level"],310,110,nil)
	main:SetPoint("CENTER",UIParent,"CENTER",0,0)
	main:Hide()
	--
	local page=main.Frame
	--
	--levelslider
	local levelslider=NPA_Options.Template.CreateSliderEdit(page,240,60,20,1,99,1,0,Localization["Level"])
	levelslider:SetPoint("TOPLEFT",page,"TOPLEFT",5,-25)
	--
	levelslider.OnValueUpdateFunc=function()
		FrameData.UnitData.Level=levelslider.Value
		NPA.EventHandler.FireEvent(8,"Level_Updated",FrameData)
	end
	--
	local OnLoad=function()
		NPA_Options.Template.SetSliderEdit(levelslider,90)
	end
	--
	main.OnSetFunc=function(parentframe)
		FrameData=parentframe.FrameData
		OnLoad()
	end
	--
	NPA_Options.RegisterPage("NamePlatePreviewFrameDataLevel",main)

end)