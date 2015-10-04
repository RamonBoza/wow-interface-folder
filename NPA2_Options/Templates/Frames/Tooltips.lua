-- Author      : Nogarder
-- Create Date : 2012/4/11 14:54:54
--tooltips uses liner
--global
local Width=200
--list
local NPA_Options_Template_Tooltips_List={}
--create a tooltip
local tooltip=CreateFrame("EditBox",nil,UIParent)
tooltip:SetWidth(Width)
tooltip:SetHeight(20)
tooltip:SetAutoFocus(nil)
tooltip:SetFontObject("GameFontHighlight")
tooltip:SetFrameLevel(255)
tooltip:SetFrameStrata("TOOLTIP")
tooltip:SetClampedToScreen(true)
tooltip:EnableMouse(false)
tooltip:SetMultiLine(true)
tooltip:Hide()
NPA_Options.Template.CreateBorder(tooltip,nil,nil,nil,2)
NPA_Options.Template.CreateBackground(tooltip,tooltip,0.2,0.5)

--border
NPA_Options.Template.CreateLinerBorder(tooltip,nil,nil,3)
NPA_Options.Template.SetLinerBorderFocus(tooltip,1)

tooltip.Liner=NPA_Options.Template.CreateLiner(
		tooltip,
		{
			Frame=tooltip,
			Anchor="CENTER",
			OffsetX=0,
			OffsetY=0,
			},
		nil,
		scale)
NPA_Options.Template.SetLinerFocus(tooltip.Liner,1)
--struct point={
--		Frame=<frame>,
--		Anchor=<Anchor>,
--		OffsetX=<offsetx>,
--		OffsetY=<offsety>,
--	}
--macro for show tooltip
local NPA_Options_Template_Tooltips_Show=function(parent)
	local data=NPA_Options_Template_Tooltips_List[parent]
	--check text
	if(data.Text==nil)then
		return
	end
	--set text and size
	tooltip:SetText(data.Text)
	--set position
	--parent
	--tooltip:SetParent(data.Parent)
	--set anchor
	local danchor
	--direction=
	--1=topright
	--2=topleft
	--3=bottomright
	--4=bottomleft
	if(data.Direction==2)then
		danchor="BOTTOMRIGHT"
	elseif(data.Direction==3)then
		danchor="TOPLEFT"
	elseif(data.Direction==4)then
		danchor="TOPRIGHT"
	else
		danchor="BOTTOMLEFT"
	end
	tooltip:ClearAllPoints()
	tooltip:SetPoint(danchor,data.Parent,data.Point.Anchor,data.Point.OffsetX,data.Point.OffsetY)
	tooltip:SetFrameLevel(data.Parent:GetFrameLevel()+16)
	--set liner
	tooltip.Liner:SetPoint("CENTER",data.Parent,data.Point.Anchor,0,0)
	tooltip.Liner.EndPoint:SetPoint("CENTER",tooltip,danchor,0,0)
	tooltip.Liner:Show()
	--show
	tooltip:Show()
end
--set
NPA_Options.Template.SetTooltips=function(text,frame,point,direction,parent)
	--direction=
	--1=topright
	--2=topleft
	--3=bottomright
	--4=bottomleft
	--don't check the text anymore as sometime it's needed to be nil
	--if(text==nil or text=="")then
	--	return
	--end
	direction=direction or 1
	if(not point)then
		if(direction==1)then
			point={
					Anchor="TOPRIGHT",
					OffsetX=50,
					OffsetY=50,
				}
		elseif(direction==2)then
			point={
					Anchor="TOPLEFT",
					OffsetX=-50,
					OffsetY=50,
				}
		elseif(direction==3)then
			point={
					Anchor="BOTTOMRIGHT",
					OffsetX=50,
					OffsetY=-50,
				}
		elseif(direction==4)then
			point={
					Anchor="BOTTOMLEFT",
					OffsetX=-50,
					OffsetY=-50,
				}
		end
	end
	--hook script
	if(not NPA_Options_Template_Tooltips_List[frame])then
		frame:HookScript("OnEnter",function(frame)
				NPA_Options_Template_Tooltips_Show(frame)
			end)
		frame:HookScript("OnLeave",function(frame)
				tooltip:Hide()
			end)
	end
	--store tooltips into list
	NPA_Options_Template_Tooltips_List[frame]={
		Text=text,
		Point=point,
		Direction=direction,
		Parent=parent or frame
	}
end
