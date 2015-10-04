-- Author      : Nogarder
-- Create Date : 2013/4/1 7:56:18
NPA_Options.RegisterPageFunc("NumberPreview",function()

	local pairs=pairs
	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	--
	local EntryName
	--
	local preview=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["Preview"],320,240,nil,true,nil)
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
	--valueslider
	local valueslider=NPA_Options.Template.CreateSliderEdit(page,100,40,20,1,123456,1,0,Localization["Value"])
	valueslider:SetPoint("BOTTOMLEFT",scroll,"BOTTOMLEFT",5,5)
	NPA_Options.Template.SetSliderEdit(valueslider,100)
	--max slider
	local maxslider=NPA_Options.Template.CreateSliderEdit(page,100,40,20,100,234567,1,0,Localization["Max"])
	maxslider:SetPoint("LEFT",valueslider,"RIGHT",5,0)
	NPA_Options.Template.SetSliderEdit(maxslider,123456)
	--anchorpreview
	local anchorpreview=NPA_Options.Template.CreateAnchorPreview(page)
	anchorpreview:SetPoint("TOPLEFT",page,"TOPLEFT")
	anchorpreview:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT")
	anchorpreview.Background:Hide()
	anchorpreview.Scaling:Hide()
	--bar
	local number=NPA.NumberManager.CreateNumber(page)
	number:SetPoint("CENTER",anchorpreview.Preview2,"CENTER")
	number:Show()
	--
	local NPA_NumberManager_SetNumber=NPA.NumberManager.SetNumber
	valueslider.OnValueUpdateFunc=function()
		NPA_NumberManager_SetNumber(number,valueslider.Value,maxslider.Value)
	end
	maxslider.OnValueUpdateFunc=function()
		NPA_Options.Template.SetSliderEdit(valueslider,nil,nil,maxslider.Value)
		NPA_NumberManager_SetNumber(number,valueslider.Value,maxslider.Value)
	end

	--
	local NPA_NumberManager_ManageNumber=NPA.NumberManager.ManageNumber
	local Update=function(entry)
		local data={}
		data.ProfileName=EntryName
		data.ColorMode=0
		if(entry)then
			local anchordata=entry.AnchorData or {
				From="CENTER",
				To="CENTER",
				OffsetX=0,
				OffsetY=0
			}
			NPA_Options.Template.SetAnchorPreview(anchorpreview,anchordata.From,anchordata.To,anchordata.OffsetX,anchordata.OffsetY,number)
			anchorpreview:Show()
		else
			NPA_Options.Template.SetAnchorPreview(anchorpreview,"CENTER","CENTER",0,0,number)
			anchorpreview:Hide()
		end
		--
		valueslider:Show()
		maxslider:Show()
		--
		NPA_NumberManager_ManageNumber(number,data)
		--
		NPA_NumberManager_SetNumber(number,valueslider.Value,maxslider.Value)
	end
	preview.Update=Update
	--
	NPA.EventHandler.RegisterEvent(6,"Resources_ProfileRefresh","NumberPreview",function()
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
		EntryName=name
		--
		Update(entry)
	end
	NPA_Options.RegisterPage("NumberPreview",preview)

end)