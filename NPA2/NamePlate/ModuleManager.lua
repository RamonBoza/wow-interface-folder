-- Author      : Nogarder
-- Create Date : 2012/12/11 10:26:44
local pairs=pairs
local NPA_RunFunc=NPA.RunFunc
--
local NPA_EventHandler_RegisterEvent=NPA.EventHandler.RegisterEvent
local NPA_EventHandler_UnRegisterEventByName=NPA.EventHandler.UnRegisterEventByName
local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
--
NPA.NamePlateModuleManager={}
local NPA_NamePlateModules_ModuleFunc={}
local NPA_NamePlateModules_DataModuleFunc={}
--
NPA.NamePlateModuleManager.RegisterModule=function(type,func)
	NPA_NamePlateModules_ModuleFunc[type]=func
	NPA_NamePlateModules_DataModuleFunc[type]={}
end
--
NPA.NamePlateModuleManager.RegisterDataModule=function(type,datatype,func)
	NPA_NamePlateModules_DataModuleFunc[type][datatype]=func
end
--

NPA.NamePlateModuleManager.GetDataType=function(type)
	return NPA_NamePlateModules_DataModuleFunc[type]
end
--
local CheckFrameAnchorSelf=function(name,framegroup)
	local parent=framegroup[name].AnchorFrame
	local i=0
	while(parent~="MainFrame" and i<20)do --end while parent is modulemain
		if(parent==name or framegroup[parent]==nil)then --return true when  parent not exists or parent is it self
			return true
		end
		parent=framegroup[parent].AnchorFrame --parent=parentparent
		i=i+1
	end
	return false
end
--
NPA.EventHandler.RegisterEvent(1,"NamePlate_ProfileChange","NamePlate_ModuleManager",function(framedata,profile)
	local modulemain=framedata.ModuleMain
	--framegroup
	local framegroup={}
	--handle module
	local modulelist=NPA_Setting.Core.NamePlateModules
	--
	for dtype,func in pairs(NPA_NamePlateModules_ModuleFunc)do
		if(modulelist[dtype]==true)then
			if(not modulemain[dtype])then
				modulemain[dtype]={}
			end
			--alpha and framelevel is handled in module
			func(framedata,profile,modulemain,NPA_NamePlateModules_DataModuleFunc[dtype],framegroup)
		elseif(modulemain[dtype] and dtype~="Default")then
			for _,frame in pairs(modulemain[dtype])do
				frame:Hide()
			end
		end
	end
	--handle anchor
	for name,data in pairs(framegroup)do
		--clear points first
		data.Frame:ClearAllPoints()
	end
	--then set anchors
	for name,data in pairs(framegroup)do
		--set anchor
		local anchorframe
		if(data.AnchorFrame=="MainFrame" or framegroup[data.AnchorFrame]==nil or CheckFrameAnchorSelf(name,framegroup))then --anchor to self or parent not exists
			anchorframe=modulemain
		else
			anchorframe=framegroup[data.AnchorFrame].Frame
		end
		local frame=data.Frame
		local anchordata=data.AnchorData
		frame:SetPoint(anchordata.From,anchorframe,anchordata.To,anchordata.OffsetX,anchordata.OffsetY)
	end
	--save it for options 
	modulemain.FrameGroup=framegroup
	--fire a data update event to it self to update changes
	--set ture to prevent loopback
	NPA_EventHandler_FireEvent(8,"Any",framedata,true)
end)
--macro for zip and unzip a module size
NPA.NamePlateModuleManager.ModuleOnHide=function(moduleframe)
	if(moduleframe.Ziped~=true)then
		--store original width and height
		moduleframe.Ziped=true
		moduleframe.OriginWidth=moduleframe:GetWidth()
		moduleframe.OriginHeight=moduleframe:GetHeight()
		moduleframe:SetWidth(1)
		moduleframe:SetHeight(1)
	end
end
NPA.NamePlateModuleManager.ModuleOnShow=function(moduleframe)
	if(moduleframe.Ziped)then
		moduleframe:SetWidth(moduleframe.OriginWidth)
		moduleframe:SetHeight(moduleframe.OriginHeight)
	end
end
