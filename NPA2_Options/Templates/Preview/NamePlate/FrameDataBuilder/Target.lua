-- Author      : Nogarder
-- Create Date : 2013/4/7 11:45:44
NPA_Options.RegisterPageFunc("NamePlatePreviewFrameDataTarget",function()

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
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["Target"],140,30,nil)
	main:SetPoint("CENTER",UIParent,"CENTER",0,0)
	main:Hide()
	--
	local page=main.Frame
	--
	local width=130
	local step=-5
	--setbutton
	local setbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Set"])
	setbutton:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Target"],setbutton,nil,2)
	--
	local Set=function()
		FrameData.UnitData.TargetGUID=UnitGUID("player")
		FrameData.UnitData.TargetUpdated=NPA.GetTime()+60
		NPA.EventHandler.FireEvent(8,"Target_Updated",FrameData)
	end
	--
	setbutton:HookScript("OnMouseUp",Set)
	--
	main.OnSetFunc=function(parentframe)
		FrameData=parentframe.FrameData
	end
	--
	NPA_Options.RegisterPage("NamePlatePreviewFrameDataTarget",main)

end)