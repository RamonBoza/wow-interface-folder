-- Author      : Nogarder
-- Create Date : 2012/9/2 9:28:15
NPA_Options.RegisterPageFunc("TextureGroupPreview",function()

	local pairs=pairs
	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	--
	local Entry
	--
	local preview=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["Preview"],320,240,nil,true,nil)
	preview:Hide()
	preview.LinkType="BOTTOMLEFT"
	preview.DontHideOther=true
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
	--texture
	local texturegroup=NPA.TextureManager.CreateTextureGroup(page)
	--
	local NPA_TextureManager_ManageTextureGroup=NPA.TextureManager.ManageTextureGroup
	--
	local Update=function()
		NPA_TextureManager_ManageTextureGroup(texturegroup,Entry)
	end
	preview.Update=Update
	--
	NPA.EventHandler.RegisterEvent(6,"Resources_ProfileRefresh","TextureGroupPreview",function()
		if(preview:IsShown())then
			Update()
		end
	end)
	--
	preview.OnSetFunc=function(entry)
		Entry=entry
		Update()
	end
	NPA_Options.RegisterPage("TextureGroupPreview",preview)

end)