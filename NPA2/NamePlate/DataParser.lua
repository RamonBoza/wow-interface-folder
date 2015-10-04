-- Author      : Nogarder
-- Create Date : 2012/12/11 12:39:27
local pairs=pairs
local table_insert=table.insert
--
local FrameDataElements={}
NPA.NamePlateDataParser={}
--
NPA.NamePlateDataParser.AddElements=function(framedata,frame,event,func)
	if(not FrameDataElements[framedata])then
		FrameDataElements[framedata]={}
	end
	if(not FrameDataElements[framedata][event])then
		FrameDataElements[framedata][event]={}
	end
	FrameDataElements[framedata][event][frame]=func
end
NPA.NamePlateDataParser.RemoveElements=function(framedata,frame)
	if(FrameDataElements[framedata])then
		for event,framelist in pairs(FrameDataElements[framedata])do
			framelist[frame]=nil
		end
	end
end
--
NPA.EventHandler.RegisterEvent(8,"Any","NamePlate_DataParser",function(event,framedata,...)
	local list=FrameDataElements[framedata]
	if(list)then
		if(event=="Any")then
			--fire event event
			local unitdata=framedata.UnitData
			for _,framelist in pairs(FrameDataElements[framedata])do
				for _,func in pairs(framelist)do
					func(framedata,unitdata,...)
				end
			end
		else
			local unitdata=framedata.UnitData
			list=FrameDataElements[framedata][event]
			if(list)then
				for _,func in pairs(list)do
					func(framedata,unitdata,...)
				end
			end
		end
	end
end)
--
NPA.EventHandler.RegisterEvent(1,"NamePlate_ModuleMain_OnUpdate","NamePlate_DataParser",function(framedata)
	local list=FrameDataElements[framedata]
	if(list)then
		funclist=FrameDataElements[framedata]["ModuleMain_OnUpdate"]
		if(funclist)then
			local unitdata=framedata.UnitData
			for _,func in pairs(funclist)do
				func(framedata,unitdata)
			end
		end
	end
end)
--
