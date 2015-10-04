-- Author      : Nogarder
-- Create Date : 2012/4/28 16:53:12
--text uses liner
NPA_Options.Template.CreateText=function(parent,text,background,point)
	--create
	local label=parent:CreateFontString(nil,"OVERLAY")
	local font,size=GameFontNormal:GetFont()
	label:SetFont(font,size,"OUTLINED")
	label:SetText(text)
	if(background)then
		label.Background=NPA_Options.Template.CreateBackground(parent,label,nil,nil,nil)
	end
	--set liner if exists
	if(point)then
		--liner
		if(point==1)then
			--left to right
			label.UnderLiner=NPA_Options.Template.CreateLiner(
				parent,
				{
					Frame=label,
					Anchor="BOTTOMLEFT",
					OffsetX=-5,
					OffsetY=-2,
					},
				{
					Frame=label,
					Anchor="BOTTOMRIGHT",
					OffsetX=5,
					OffsetY=-2,
					},
				scale)
			label.Liner=NPA_Options.Template.CreateLiner(
				parent,
				{
					Frame=label,
					Anchor="BOTTOMLEFT",
					OffsetX=-5,
					OffsetY=-5,
					},
				point,
				scale)
		elseif(point==2)then
			--right to left
			label.UnderLiner=NPA_Options.Template.CreateLiner(
				parent,
				{
					Frame=label,
					Anchor="BOTTOMRIGHT",
					OffsetX=5,
					OffsetY=-2,
					},
				{
					Frame=label,
					Anchor="BOTTOMLEFT",
					OffsetX=-5,
					OffsetY=-2,
					},
				scale)
			label.Liner=NPA_Options.Template.CreateLiner(
				parent,
				point,
				{
					Frame=label,
					Anchor="BOTTOMRIGHT",
					OffsetX=5,
					OffsetY=-5,
					},
				scale)
		end
		--hook script
		parent:HookScript("OnEnter",function()
				NPA_Options.Template.SetLinerFocus(label.Liner,1)
				NPA_Options.Template.SetLinerFocus(label.UnderLiner,1)
			end)
		parent:HookScript("OnLeave",function()
				NPA_Options.Template.SetLinerFocus(label.Liner,nil)
				NPA_Options.Template.SetLinerFocus(label.UnderLiner,nil)
			end)
	end
	--show it
	label:Show()
	--return pointer
	return label
end