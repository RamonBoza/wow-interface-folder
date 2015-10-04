-- Author      : Nogarder
-- Create Date : 2012/6/17 16:10:18
--macro for get coordinates
local string_gsub=string.gsub
local string_find=string.find
--
NPA_Options.Anchor={}
--macro for point coordinates
NPA_Options.Anchor.GetPointCoordinates=function(point)
	--struct point={
	--		Frame=<frame>,
	--		Anchor=<Anchor>,
	--		OffsetX=<offsetx>,
	--		OffsetY=<offsety>,
	--	}
	local x,y
	if(strfind(point.Anchor,"TOP"))then
		y=point.Frame:GetTop()
	elseif(strfind(point.Anchor,"BOTTOM"))then
		y=point.Frame:GetBottom()
	else
		_,y=point.Frame:GetCenter()
	end
	if(strfind(point.Anchor,"LEFT"))then
		x=point.Frame:GetLeft()
	elseif(strfind(point.Anchor,"RIGHT"))then
		x=point.Frame:GetRight()
	else
		x=point.Frame:GetCenter()
	end
	if(x)then
		x=x+point.OffsetX
	end
	if(y)then
		y=y+point.OffsetY
	end
	return x,y
end
--macor for get revers anchor
NPA_Options.Anchor.GetReversAnchor=function(anchor)
	if(anchor=="CENTER")then
		return "CENTER"
	end

	local prefix,suffix
	if(string_find(anchor,"TOP"))then
		prefix="BOTTOM"
	elseif(string_find(anchor,"BOTTOM"))then
		prefix="TOP"
	end
	if(string_find(anchor,"LEFT"))then
		suffix="RIGHT"
	elseif(string_find(anchor,"RIGHT"))then
		suffix="LEFT"
	end

	return (prefix or "")..(suffix or "")
end