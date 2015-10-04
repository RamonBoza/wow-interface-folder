-- Author      : Nogarder
-- Create Date : 2013/4/7 19:51:57
NPA_Options.RegisterPageFunc("NamePlatePreviewFrameDataQuest",function()

	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	local Tooltips=Localization.Tooltips
	--
	local FrameData
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["Name"],210,180,nil)
	main:SetPoint("CENTER",UIParent,"CENTER",0,0)
	main:Hide()
	--
	local page=main.Frame
	--
	local width=200
	local step=-15
	--name button
	local text=NPA_Options.Template.CreateText(page,"")
	text:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	--
	local namebutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Change"])
	namebutton:SetPoint("TOPLEFT",text,"BOTTOMLEFT",0,-5)
	NPA_Options.Template.SetTooltips(Tooltips["Change"],namebutton,nil,2)
	--current slider
	--healthslider
	local currentslider=NPA_Options.Template.CreateSliderEdit(page,140,60,20,0,10,1,0,Localization["Value"])
	currentslider:SetPoint("TOPLEFT",namebutton,"BOTTOMLEFT",0,step)
	--max slider
	local maxslider=NPA_Options.Template.CreateSliderEdit(page,140,60,20,1,15,1,0,Localization["Max"])
	maxslider:SetPoint("TOPLEFT",currentslider,"BOTTOMLEFT",0,step)
	--level slider
	local levelslider=NPA_Options.Template.CreateSliderEdit(page,140,60,20,1,100,1,90,Localization["Level"])
	levelslider:SetPoint("TOPLEFT",maxslider,"BOTTOMLEFT",0,step)
	--
	--setbutton
	local setbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Set"])
	setbutton:SetPoint("TOPLEFT",levelslider,"BOTTOMLEFT",0,step)
	--
	local OnLoad=function()
		text:SetText(FrameData.QuestData.Name)
	end
	--
	local Refresh=function()
		NPA.EventHandler.FireEvent(8,"Quest_Updated",FrameData)
	end
	--
	currentslider.OnValueUpdateFunc=function()
		FrameData.QuestData.Current=currentslider.Value
		Refresh()
	end
	--
	maxslider.OnValueUpdateFunc=function()
		NPA_Options.Template.SetSliderEdit(currentslider,nil,nil,maxslider.Value)
		FrameData.QuestData.Max=maxslider.Value
		Refresh()
	end
	--
	levelslider.OnValueUpdateFunc=function()
		FrameData.QuestData.Level=levelslider.Value
		Refresh()
	end
	--
	setbutton:HookScript("OnMouseUp",Refresh)
	--
	namebutton:HookScript("OnMouseUp",function()
		local inputbox=NPA_Options.Template.SetInputBox(main,Localization["InputANewName"],FrameData.QuestData.Name)
		inputbox:SetPoint("TOPLEFT",page,"BOTTOMLEFT",0,-5)
		inputbox.CallBackFunc=function(name)
			FrameData.QuestData.Name=name
			Refresh()
			OnLoad()
		end
	end)
	--
	main.OnSetFunc=function(parentframe)
		FrameData=parentframe.FrameData
		if(not FrameData.QuestData)then
			frameData.QuestData={
				Name="Test Quest",
				Current=8,
				Max=10,
				Level=UnitLevel("player"),
			}
		end
		OnLoad()
	end
	--
	NPA_Options.RegisterPage("NamePlatePreviewFrameDataQuest",main)

end)