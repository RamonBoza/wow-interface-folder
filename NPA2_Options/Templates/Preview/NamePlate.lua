-- Author      : Nogarder
-- Create Date : 2012/4/28 16:06:38
NPA_Options.RegisterPageFunc("NamePlatePreview",function()

	local pairs=pairs
	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	local Tooltips=Localization.Tooltips
	--list
	local NPA_Options_Template_Preview_List={}
	--module list
	local NPA_Options_Template_Preview_ModuleList={}
	--add module
	NPA_Options.Template.AddPreviewModule=function(name,initfunc)
		NPA_Options_Template_Preview_ModuleList[name]=initfunc
	end
	--
	local preview=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["Preview"],400,300,nil,true,true)
	preview:Hide()
	--
	preview.LinkType="BOTTOMRIGHT"
	preview.DontHideOther=true
	--
	local ProfileName
	--
	local title=preview.Scroll.Title
	title:ClearAllPoints()
	title:SetPoint("BOTTOMRIGHT",preview,"TOPRIGHT",-20,0)
	--
	local page=preview.Frame
	page:SetWidth(640)
	page:SetHeight(480)
	--
	--NPA_Options.Template.CreateBackground(page,nil,0,0.8)
	--
	local scroll=preview.Scroll
	scroll.SliderX.Value=110
	scroll.SliderY.Value=90
	NPA_Options.Template.UpdateScrollFrame(page)
	--
	local modulemain=CreateFrame("Frame",nil,NPA_Options.MainFrame)
	modulemain:SetPoint("CENTER",page,"CENTER")
	modulemain:SetWidth(1)
	modulemain:SetHeight(1)
	modulemain.Parent=page
	--
	preview.FrameData={
		Parent=scroll,
		ModuleMain=modulemain,
		UnitData={}

	}

	preview.OnScaleFunc=function(scale)
		modulemain:SetScale(scale)
	end

	page:HookScript("OnShow",function()
		modulemain:Show()
	end)
	page:HookScript("OnHide",function()
		modulemain:Hide()
	end)
	--clickzone border
	local clickzoneborderframe=CreateFrame("Frame",nil,scroll)
	clickzoneborderframe:SetPoint("CENTER",modulemain,"CENTER")
	clickzoneborderframe:SetWidth(136)
	clickzoneborderframe:SetHeight(36)
	clickzoneborderframe:Show()

	local clickzoneborder=NPA_Options.Template.CreateLinerBorder(clickzoneborderframe,1)
	NPA_Options.Template.HideLinerBorder(clickzoneborderframe)
	NPA_Options.Template.SetLinerBorderFocus(clickzoneborderframe,true)
	
	local clickzonecheckbox=NPA_Options.Template.CreateCheckBox(page,120,20,Localization["ClickZone"])
	NPA_Options.Template.SetTooltips(Tooltips["ClickZone"],clickzonecheckbox)
	clickzonecheckbox:SetPoint("TOPLEFT",scroll,"TOPLEFT",10,-10)
	clickzonecheckbox.OnValueUpdateFunc=function(checkbox)
		if(checkbox.Checked)then
			NPA_Options.Template.ShowLinerBorder(clickzoneborderframe)
		else
			NPA_Options.Template.HideLinerBorder(clickzoneborderframe)
		end
	end

	--preview.FrameData.ModuleMain["Default"]=modulemain
	--preview doesn't fire onhook
	--NPA.EventHandler.FireEvent(1,"NamePlate_DefaultMain_OnHook",preview.FrameData)
	--elements
	local framedata=preview.FrameData
	--
	local UpdatePreview=function()
		--get profile and fire a event
		framedata.Profile=NPA.SettingManager.GetNamePlateProfileByName(ProfileName)
		NPA.EventHandler.FireEvent(1,"NamePlate_ProfileChange",framedata,framedata.Profile)
		NPA.EventHandler.FireEvent(8,"Quest_Updated",framedata,_,framedata.QuestData)
		--override alpha
		framedata.ModuleMain:SetAlpha(1)
	end
	--init
	NPA.EventHandler.RegisterEvent(6,"Resources_ProfileRefresh","NamePlatePreview",UpdatePreview)
	NPA.EventHandler.RegisterEvent(6,"NamePlate_ProfileKeyChange","NamePlatePreview",UpdatePreview)
	--
	preview.OnSetFunc=function(name)
		ProfileName=name
		UpdatePreview()
		--set title
		title:SetText(Localization["Preview"].." "..Localization["Profile"]..":  ["..name.."]")
		if(title:GetWidth()>320)then
			title:ClearAllPoints()
			title:SetPoint("BOTTOMRIGHT",preview.Scroll,"TOPRIGHT",-5,0)
		else
			title:ClearAllPoints()
			title:SetPoint("BOTTOM",preview.Scroll,"TOP",0,0)
		end
		--set preview framedata builder
		NPA_Options.SetPage("NamePlatePreviewFrameDataBuilder",preview,framedata)
	end
	--on zip and unzip
	preview.Scroll.OnMinimizedFunc=function()
		modulemain:Hide()
	end
	preview.Scroll.OnRestoredFunc=function()
		modulemain:Show()
	end
	--
	NPA_Options.RegisterPage("NamePlatePreview",preview)

end)