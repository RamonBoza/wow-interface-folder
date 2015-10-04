-- Author      : Nogarder
-- Create Date : 2012/11/6 16:23:01
local pairs=pairs
local table_getn=table.getn
--create
local textlist=NPA_Options.Template.CreateFrame(NPA_Options.MainFrame,1,1,nil,true)
textlist:EnableMouse(false)
--background--black
textlist.Background=NPA_Options.Template.CreateBackground(textlist,nil,0,1)
--buttonlist
textlist.Texts={}
--
local NPA_Options_Template_TextList_UpdateTextList=function(data)
	--set display
	local maxwidth=10
	local step=textlist.TextHeight
	local texts=textlist.Texts
	local max=table_getn(data)
	for i=1,max do
		local unit=data[i]
		if(not texts[i])then
			texts[i]=NPA_Options.Template.CreateText(textlist," ")
		end
		--
		texts[i]:SetPoint("BOTTOMLEFT",textlist,"TOPLEFT",3+(unit.Offset or 0),-i*step)
		--
		texts[i]:SetText(unit.Text)
		--
		texts[i]:Show()

		local width=texts[i]:GetWidth()+6+unit.Offset
		if(maxwidth<width)then
			maxwidth=width
		end
	end
	for i=max+1,table_getn(texts)do
		texts[i]:Hide()
	end
	--set frame width and height
	textlist:SetWidth(maxwidth)
	--
	local height=step*max+3
	textlist:SetHeight(height)
	--show
	textlist:Show()
end
--
NPA_Options.Template.SetTextList=function(parent,width,data,mainframe,textheight)
	textlist:Hide()
	--data={
	--	[index]={
	--		Text=<text>,
	--		Offset=<offset>
	--		}
	textlist:ClearAllPoints()
	textlist.Parent=parent
	textlist:SetParent(mainframe or NPA_Options.MainFrame)
	textlist:SetFrameLevel(parent:GetFrameLevel()+3)
	--init
	textlist.TextHeight=buttonheight or 15
	NPA_Options_Template_TextList_UpdateTextList(data)
	--
	NPA_Options.Animation.ShowFrame(textlist)
	--
	return textlist
end


NPA_Options.Template.HideTextList=function()
	NPA_Options.Animation.HideFrame(textlist)
end
NPA_Options.RegisterTemplate(textlist,function()
	textlist:Hide()
end)

--
NPA_Options.RegisterTemplate(textlist,NPA_Options.Template.HideTextList)
