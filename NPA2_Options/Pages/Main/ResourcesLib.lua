-- Author      : Nogarder
-- Create Date : 2012/8/25 7:29:54
NPA_Options.RegisterPageFunc("ResourcesLib",function()
	--localization
	local Localization=NPA_Options.Localization.PagesMainResourcesLib
	local Tooltips=Localization.Tooltips
	--
	local parent=NPA_Options.MainFrame
	--main page
	local main=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["ResourcesLib"],100,245,nil,nil,nil,NPA_Options.MainFrame)
	main:Hide()
	--
	local page=main.Frame
	--page:SetWidth(100)
	--page:SetHeight(290)
	--
	local width=90
	local step=-5
	--font button
	local fontbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["FontLib"])
	NPA_Options.Template.SetTooltips(Tooltips["FontLib"],fontbutton,nil,2)
	fontbutton:SetPoint("TOPLEFT",page,"TOPLEFT",5,-5)
	NPA_Options.SetPageButton(fontbutton,"FontLib",main)
	--texture button
	local texturebutton=NPA_Options.Template.CreateButton(page,width,15,Localization["TextureLib"])
	NPA_Options.Template.SetTooltips(Tooltips["TextureLib"],texturebutton,nil,2)
	texturebutton:SetPoint("TOP",fontbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(texturebutton,"TextureLib",main)
	--animated texture button
	local animatedtexturebutton=NPA_Options.Template.CreateButton(page,width,15,Localization["AnimatedTextureLib"])
	NPA_Options.Template.SetTooltips(Tooltips["AnimatedTextureLib"],animatedtexturebutton,nil,2)
	animatedtexturebutton:SetPoint("TOP",texturebutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(animatedtexturebutton,"AnimatedTextureLib",main)
	--color button
	local colorbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Color"])
	NPA_Options.Template.SetTooltips(Tooltips["Color"],colorbutton,nil,2)
	colorbutton:SetPoint("TOP",animatedtexturebutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(colorbutton,"ColorLib",main)
	--number button
	local numberbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Number"])
	NPA_Options.Template.SetTooltips(Tooltips["Number"],numberbutton,nil,2)
	numberbutton:SetPoint("TOP",colorbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(numberbutton,"NumberLib",main)
	--bar button
	local barbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["BarGroup"])
	NPA_Options.Template.SetTooltips(Tooltips["BarGroup"],barbutton,nil,2)
	barbutton:SetPoint("TOP",numberbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(barbutton,"BarGroupLib",main)
	--class button
	local classbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Class"])
	NPA_Options.Template.SetTooltips(Tooltips["Class"],classbutton,nil,2)
	classbutton:SetPoint("TOP",barbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(classbutton,"ClassLib",main)
	--spell button
	local spellbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["Spell"])
	NPA_Options.Template.SetTooltips(Tooltips["Spell"],spellbutton,nil,2)
	spellbutton:SetPoint("TOP",classbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(spellbutton,"SpellLib",main)
	--raidtarget button
	local raidtargetbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["RaidTarget"])
	NPA_Options.Template.SetTooltips(Tooltips["RaidTarget"],raidtargetbutton,nil,2)
	raidtargetbutton:SetPoint("TOP",spellbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(raidtargetbutton,"RaidTarget",main)
	--selflib button
	local selflibbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["SelfLib"])
	NPA_Options.Template.SetTooltips(Tooltips["SelfLib"],selflibbutton,nil,2)
	selflibbutton:SetPoint("TOP",raidtargetbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(selflibbutton,"SelfLib",main)
	--role button
	local rolelibbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["RoleLib"])
	NPA_Options.Template.SetTooltips(Tooltips["RoleLib"],rolelibbutton,nil,2)
	rolelibbutton:SetPoint("TOP",selflibbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(rolelibbutton,"RoleLib",main)
	--role button
	local unitlibbutton=NPA_Options.Template.CreateButton(page,width,15,Localization["UnitLib"])
	NPA_Options.Template.SetTooltips(Tooltips["UnitLib"],unitlibbutton,nil,2)
	unitlibbutton:SetPoint("TOP",rolelibbutton,"BOTTOM",0,step)
	NPA_Options.SetPageButton(unitlibbutton,"UnitLib",main)
	--
	NPA_Options.RegisterPage("ResourcesLib",main)
end)