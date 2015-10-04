-- Author      : Nogarder
-- Create Date : 2012/8/28 9:00:00
NPA_Options.RegisterPageFunc("BarGroupPreview",function()

	local pairs=pairs
	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	--
	local preview=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["Preview"],320,240,false,true,nil)
	preview:Hide()
	preview.LinkType="BOTTOMLEFT"
	preview.DontHideOther=true
	--
	local title=preview.Scroll.Title
	title:ClearAllPoints()
	title:SetPoint("BOTTOMRIGHT",preview,"TOPRIGHT",-20,0)
	--
	local scroll=preview.Scroll
	--
	local BarData={}
	--
	local page=preview.Frame
	page:SetWidth(640)
	page:SetHeight(480)
	--
	--NPA_Options.Template.CreateBackground(page,nil,0,0.8)
	--
	local scroll=preview.Scroll
	scroll.SliderX.Value=160
	scroll.SliderY.Value=120
	NPA_Options.Template.UpdateScrollFrame(page)
	--percentslider
	local percentslider=NPA_Options.Template.CreateSliderEdit(page,60,40,20,1,100,1,0,Localization["Percent"])
	percentslider:SetPoint("BOTTOMLEFT",scroll,"BOTTOMLEFT",5,5)
	NPA_Options.Template.SetSliderEdit(percentslider,100)
	--smooth time slider
	local smoothtimeslider=NPA_Options.Template.CreateSliderEdit(page,60,40,20,0,1,0.01,0,Localization["SmoothTime"])
	smoothtimeslider:SetPoint("LEFT",percentslider,"RIGHT",5,0)
	NPA_Options.Template.SetSliderEdit(smoothtimeslider,0.5)
	--shadow alpha slider
	local shadowalphaslider=NPA_Options.Template.CreateSliderEdit(page,60,40,20,0.1,1,0.01,0,Localization["ShadowAlpha"])
	shadowalphaslider:SetPoint("LEFT",smoothtimeslider,"RIGHT",5,0)
	NPA_Options.Template.SetSliderEdit(shadowalphaslider,0.5)
	--anchorpreview
	local anchorpreview=NPA_Options.Template.CreateAnchorPreview(page)
	anchorpreview:SetPoint("TOPLEFT",page,"TOPLEFT")
	anchorpreview:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT")
	anchorpreview.Background:Hide()
	anchorpreview.Scaling:Hide()
	--bar
	local bargroup=NPA.BarManager.CreateBarGroup(page)
	bargroup:SetPoint("CENTER",anchorpreview.Preview2,"CENTER")
	bargroup:Show()
	--
	local NPA_BarManager_SetBarGroup=NPA.BarManager.SetBarGroup
	percentslider.OnValueUpdateFunc=function()
		NPA_BarManager_SetBarGroup(bargroup,percentslider.Value/100)
	end
	--
	local NPA_BarManager_ManageBarGroup=NPA.BarManager.ManageBarGroup
	local Update=function(entry)
		if(entry)then
			bargroup:SetWidth(entry.Width or 120)
			bargroup:SetHeight(entry.Height or 20)
			bargroup:SetAlpha(entry.Alpha or 1)
			bargroup:SetScale(entry.Scale or 1)
			--
			local anchordata=entry.AnchorData or {
				From="CENTER",
				To="CENTER",
				OffsetX=0,
				OffsetY=0
			}
			NPA_Options.Template.SetAnchorPreview(anchorpreview,anchordata.From,anchordata.To,anchordata.OffsetX,anchordata.OffsetY,bargroup)
			anchorpreview:Show()
			--
			smoothtimeslider:Hide()
			shadowalphaslider:Hide()
			--
			BarData.Width=entry.Width or 120
			BarData.Height=entry.Height or 20
			BarData.SmoothTime=entry.SmoothTime or 1
			BarData.ShadowAlpha=entry.ShadowAlpha or 1
		else
			bargroup:SetWidth(120)
			bargroup:SetHeight(20)
			--
			NPA_Options.Template.SetAnchorPreview(anchorpreview,"CENTER","CENTER",0,0,bargroup)
			anchorpreview:Hide()
			--
			smoothtimeslider:Show()
			shadowalphaslider:Show()
			--
			BarData.Width=120 
			BarData.Height=20
			BarData.SmoothTime=smoothtimeslider.Value or 1
			BarData.ShadowAlpha=shadowalphaslider.Value or 1
		end
		BarData.ColorMode=0
		--
		NPA_BarManager_ManageBarGroup(bargroup,BarData)
		--
		NPA_BarManager_SetBarGroup(bargroup,percentslider.Value/100)
	end
	preview.Update=Update
	--
	local BarUpdate=function()
		Update()
	end
	smoothtimeslider.OnValueUpdateFunc=BarUpdate
	shadowalphaslider.OnValueUpdateFunc=BarUpdate
	--
	NPA.EventHandler.RegisterEvent(6,"Resources_ProfileRefresh","BarGroupPreview",function()
		if(preview:IsShown())then
			Update()
		end
	end)
	--
	preview.OnSetFunc=function(name,entry)
		title:SetText(Localization["Preview"].." "..Localization["Profile"]..":  ["..name.."]")
		if(title:GetWidth()>320)then
			title:ClearAllPoints()
			title:SetPoint("BOTTOMRIGHT",preview.Scroll,"TOPRIGHT",-5,0)
		else
			title:ClearAllPoints()
			title:SetPoint("BOTTOM",preview.Scroll,"TOP",0,0)
		end
		--set data by entry
		BarData.ProfileName=name
		--
		Update(entry)
	end
	NPA_Options.RegisterPage("BarGroupPreview",preview)

end)