-- Author      : Nogarder
-- Create Date : 2013/8/14 14:00:33
NPA_Options.RegisterPageFunc("NamePlatePreviewFrameDataGuild",function()

	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	local Tooltips=Localization.Tooltips
	--
	local FrameData
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["Guild"],140,50,nil)
	main:SetPoint("CENTER",UIParent,"CENTER",0,0)
	main:Hide()
	--
	local page=main.Frame
	--
	local width=130
	local step=-5
	--name button
	local text=NPA_Options.Template.CreateText(page,"")
	text:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	--
	local namebutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Change"])
	namebutton:SetPoint("TOPLEFT",text,"BOTTOMLEFT",0,step)
	NPA_Options.Template.SetTooltips(Tooltips["Change"],namebutton,nil,2)
	--
	local OnLoad=function()
		text:SetText(FrameData.UnitData.Guild)
	end
	--
	local Refresh=function()
		NPA.EventHandler.FireEvent(8,"Guild_Updated",FrameData)
		NPA.EventHandler.FireEvent(8,"NPCGuild_Updated",FrameData)
	end
	--
	namebutton:HookScript("OnMouseUp",function()
		local inputbox=NPA_Options.Template.SetInputBox(main,Localization["InputANewName"],FrameData.UnitData.Guild)
		inputbox:SetPoint("TOPLEFT",page,"BOTTOMLEFT",0,-5)
		inputbox.CallBackFunc=function(name)
			FrameData.UnitData.Guild=name
			FrameData.UnitData.NPCGuild="(NPC)"..name
			Refresh()
			OnLoad()
		end
	end)
	--
	main.OnSetFunc=function(parentframe)
		FrameData=parentframe.FrameData
		OnLoad()
	end
	--
	NPA_Options.RegisterPage("NamePlatePreviewFrameDataGuild",main)

end)