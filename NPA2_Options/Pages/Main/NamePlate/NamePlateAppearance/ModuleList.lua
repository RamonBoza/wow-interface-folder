-- Author      : Nogarder
-- Create Date : 2012/8/22 7:16:52
NPA_Options.RegisterPageFunc("NamePlateAppearanceModuleList",function()

	local pairs=pairs
	--localization
	local Localization=NPA_Options.Localization.PagesNamePlateAppearanceModuleList
	---
	local parent=NPA_Options.MainFrame
	local EntryName
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["SelectModule"],400,320,nil,nil,nil)
	main:Hide()
	--
	local page=main.Frame
	local scroll=main.Scroll
	--
	local modulelistframe=NPA_Options.Template.CreateSelectList(nil,120,240,nil,nil,page)
	--
	local Liner=NPA_Options.Template.CreateLiner(main,
		{
			Frame=main,
			Anchor="TOPLEFT",
			OffsetX=0,
			OffsetY=0,
		},
		{
			Frame=main,
			Anchor="TOPRIGHT",
			OffsetX=0,
			OffsetY=0,
		},
		2)
	NPA_Options.Template.SetLinerFocus(Liner,1)
	Liner:Hide()
	--
	local Liner2=NPA_Options.Template.CreateLiner(main,
		{
			Frame=main,
			Anchor="TOPLEFT",
			OffsetX=0,
			OffsetY=0,
		},
		{
			Frame=main,
			Anchor="TOPRIGHT",
			OffsetX=0,
			OffsetY=0,
		},
		2)
	NPA_Options.Template.SetLinerFocus(Liner2,1)
	Liner2:Hide()
	--
	--local profilename=NPA_Options.Template.CreateText(scroll," ")
	--profilename:SetPoint("BOTTOMLEFT",scroll,"TOPLEFT",0,20)
	--
	modulelistframe.ButtonClickFunc=function(button)
		NPA_Options.SetPage("NamePlateAppearance"..button.Value,main,EntryName,Liner,Liner2)
	end
	--
	main.OnSetFunc=function(entryname,preview)
		EntryName=entryname
		--set Preview value don't need this
		--profilename:SetText(Localization["CurrentProfile"]..":  ["..entryname.."]")
		--update editor content
		local moduledata=NPA_Options.InfoLib.GetModulesButtonData()
		NPA_Options.Template.UpdateSelectList(modulelistframe,moduledata)
	end
	--
	NPA_Options.RegisterPage("NamePlateAppearanceModuleList",main)

end)