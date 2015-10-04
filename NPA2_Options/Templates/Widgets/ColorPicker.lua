-- Author      : Nogarder
-- Create Date : 2012/7/13 15:50:07
NPA_Options.RegisterPageFunc("ColorPicker",function()

	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesWindowColorPicker
	local Tooltips=Localization.Tooltips
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["ColorPicker"],210,250,nil)
	main:SetPoint("CENTER",UIParent,"CENTER",0,0)
	main:Hide()
	local page=main.Frame
	--colorslider
	local colorsliderR=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,255,1,0,Localization["ColorR"],Tooltips["ColorR"],true)
	colorsliderR:SetPoint("TOPLEFT",page,"TOPLEFT",5,-20)
	local colorsliderG=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,255,1,0,Localization["ColorG"],Tooltips["ColorG"],true)
	colorsliderG:SetPoint("TOPLEFT",colorsliderR,"BOTTOMLEFT",0,-15)
	local colorsliderB=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,255,1,0,Localization["ColorB"],Tooltips["ColorB"],true)
	colorsliderB:SetPoint("TOPLEFT",colorsliderG,"BOTTOMLEFT",0,-15)
	local colorsliderA=NPA_Options.Template.CreateSliderEdit(page,150,50,20,0,255,1,0,Localization["ColorA"],Tooltips["ColorA"],true)
	colorsliderA:SetPoint("TOPLEFT",colorsliderB,"BOTTOMLEFT",0,-15)
	--colorbackground
	local colorbackground=page:CreateTexture(nil,"BACKGROUND")
	colorbackground:SetPoint("TOPLEFT",colorsliderA,"BOTTOMLEFT",0,-15)
	colorbackground:SetWidth(200)
	colorbackground:SetHeight(30)
	colorbackground:SetTexture(0,0,0,1)
	--old color
	local oldcolor=page:CreateTexture(nil,"ARTWORK")
	oldcolor:SetPoint("TOPLEFT",colorsliderA,"BOTTOMLEFT",0,-15)
	oldcolor:SetWidth(180)
	oldcolor:SetHeight(20)
	--new color
	local newcolor=page:CreateTexture(nil,"OVERLAY")
	newcolor:SetPoint("TOPLEFT",oldcolor,"BOTTOMLEFT",20,10)
	newcolor:SetWidth(180)
	newcolor:SetHeight(20)
	--done button
	local donebutton=NPA_Options.Template.CreateButton(page,98,20,Localization["Done"])
	NPA_Options.Template.SetTooltips(Tooltips["Done"],donebutton)
	donebutton:SetPoint("BOTTOMLEFT",page,"BOTTOMLEFT",5,5)
	--reset button
	local resetbutton=NPA_Options.Template.CreateButton(page,98,20,Localization["Reset"])
	NPA_Options.Template.SetTooltips(Tooltips["Reset"],resetbutton)
	resetbutton:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT",-5,5)
	--use blizzard
	local useblizzardbutton=NPA_Options.Template.CreateButton(page,200,20,Localization["UseBlizzard"])
	NPA_Options.Template.SetTooltips(Tooltips["UseBlizzard"],useblizzardbutton)
	useblizzardbutton:SetPoint("BOTTOMLEFT",donebutton,"TOPLEFT",0,5)
	--script
	local Refresh=function()
		newcolor:SetTexture(colorsliderR.Value/255,colorsliderG.Value/255,colorsliderB.Value/255,colorsliderA.Value/255)
	end
	colorsliderR.OnValueUpdateFunc=Refresh
	colorsliderG.OnValueUpdateFunc=Refresh
	colorsliderB.OnValueUpdateFunc=Refresh
	colorsliderA.OnValueUpdateFunc=Refresh
	--
	donebutton:HookScript("OnMouseUp",function()
		NPA_Options.RunFunc(main.CallBackFunc,colorsliderR.Value/255,colorsliderG.Value/255,colorsliderB.Value/255,colorsliderA.Value/255)
		main:Hide()
	end)
	resetbutton:HookScript("OnMouseUp",function()
		NPA_Options.Template.SetSliderEdit(colorsliderR,main.R)
		NPA_Options.Template.SetSliderEdit(colorsliderG,main.G)
		NPA_Options.Template.SetSliderEdit(colorsliderB,main.B)
		NPA_Options.Template.SetSliderEdit(colorsliderA,main.A)
		Refresh()
	end)
	useblizzardbutton:HookScript("OnMouseUp",function()
		ColorPickerFrame:Hide()
		ColorPickerFrame:SetColorRGB(colorsliderR.Value/255,colorsliderG.Value/255,colorsliderB.Value/255)
		ColorPickerFrame.opacity=1-colorsliderA.Value/255
		ColorPickerFrame.hasOpacity=true
		ColorPickerFrame.previousValues={
			r=colorsliderR.Value/255,
			g=colorsliderG.Value/255,
			b=colorsliderB.Value/255,
			a=1-colorsliderA.Value/255
		}

		ColorPickerFrame.func=function()
			local r,g,b=ColorPickerFrame:GetColorRGB()
			NPA_Options.Template.SetSliderEdit(colorsliderR,r*255)
			NPA_Options.Template.SetSliderEdit(colorsliderG,g*255)
			NPA_Options.Template.SetSliderEdit(colorsliderB,b*255)
			Refresh()
		end
		ColorPickerFrame.opacityFunc=function()
			local a=1-OpacitySliderFrame:GetValue()
			NPA_Options.Template.SetSliderEdit(colorsliderA,a*255)
			Refresh()
		end
		ColorPickerFrame.cancelFunc=function(color)
			NPA_Options.Template.SetSliderEdit(colorsliderR,color.r*255)
			NPA_Options.Template.SetSliderEdit(colorsliderG,color.g*255)
			NPA_Options.Template.SetSliderEdit(colorsliderB,color.b*255)
			NPA_Options.Template.SetSliderEdit(colorsliderA,(1-color.a)*255)
			Refresh()
		end
		ColorPickerFrame:Show()
	end)
	--
	main.OnSetFunc=function(r,g,b,a,callbackfunc)
		newcolor:SetTexture(r,g,b,a)
		oldcolor:SetTexture(r,g,b,a)
		--
		local r=r*255
		local g=g*255
		local b=b*255
		local a=a*255
		NPA_Options.Template.SetSliderEdit(colorsliderR,r)
		NPA_Options.Template.SetSliderEdit(colorsliderG,g)
		NPA_Options.Template.SetSliderEdit(colorsliderB,b)
		NPA_Options.Template.SetSliderEdit(colorsliderA,a)
		--
		main.R=r
		main.G=g
		main.B=b
		main.A=a
		--
		main.CallBackFunc=callbackfunc
	end
	--
	NPA_Options.RegisterPage("ColorPicker",main)
end)