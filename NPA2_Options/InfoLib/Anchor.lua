-- Author      : Nogarder
-- Create Date : 2012/4/11 14:37:42
local table_insert=table.insert
--anchor point lib
local Localization=NPA_Options.Localization.InfoLibAnchor
local Tooltips=Localization.Tooltips
NPA_Options.InfoLib.GetAnchor=function()
	--convert into new formation
	local anchor={}
	local i=0
	for name,value in pairs(Localization["AnchorList"])do
		i=i+1
		anchor[i]={
			Text=name,
			Value=value,
		}
	end
	return anchor
end

NPA_Options.InfoLib.GetAnchorFrameList=function(framegroup)
	--anchorframelist
	local list={}
	for name,_ in pairs(framegroup)do
		table_insert(list,{
			Text=name,
			Value=name
		})
	end
	table_insert(list,{
		Text=Localization["MainFrame"],
		Value="MainFrame",
		Tooltips=Tooltips["MainFrame"],
	})
	return list
end