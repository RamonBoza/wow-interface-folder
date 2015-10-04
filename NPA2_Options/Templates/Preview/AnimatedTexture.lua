-- Author      : Nogarder
-- Create Date : 2015/2/8 19:13:43
NPA_Options.RegisterPageFunc("AnimatedTexturePreview",function()
	local pairs=pairs
	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	--NPA_Options.Template.CreateFrameWithBar=function(parent,title,width,height,noborder,nobackground,revers,dragframe)

	local preview=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["Preview"],240,240,false,true,true)
	preview:Hide()
	preview.LinkType="BOTTOMRIGHT"
	preview.DontHideOther=true
	--
	--local title=preview.Scroll.Title
	--title:ClearAllPoints()
	--title:SetPoint("BOTTOMRIGHT",preview,"TOPRIGHT",-20,0)
	--
	local scroll=preview.Scroll
	--
	local BarData={}
	--
	local page=preview.Frame
	--
	local Entry
	--
	local texture=page:CreateTexture()
	texture:SetPoint("TOPLEFT",page,"TOPLEFT",1,-1)
	texture:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT",-1,1)
	texture:SetTexture(1,1,1)
	--
	local Update=function(entry)
		NPA.TextureManager.SetAnimatedTextureByEntry(texture,Entry)
	end
	preview.Update=Update
	--
	page:HookScript("OnHide",function()
		NPA.TextureManager.RemoveAnimatedTexture(texture)
	end)
	--
	preview.OnSetFunc=function(entry)
		Entry=entry
		Update()
	end
	NPA_Options.RegisterPage("AnimatedTexturePreview",preview)

end)