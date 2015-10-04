-- Author      : Nogarder
-- Create Date : 2012/3/16 22:45:41

--function NPA_Core:SetModuleLayer(frame)
--	if(not frame)then
--		return
--	end

--	local modulemain=frame.ModuleMain
--	if(not modulemain)then
--		return
--	end

--	local rendermain=modulemain.RenderMain

--	if(not rendermain)then
--		return
--	end

--	if(not frame.ModuleLayer)then
--		frame.ModuleLayer={}
--	end
--	local layercache=frame.ModuleLayer
--	for _,layer in pairs(layercache) do
--		layer:Hide()
--	end

--	for key,value in pairs(NPA_Core_Config["ModuleLayer"]) do
--		local main=modulemain[key]
--		if(key~="DeepCheck" and main)then
--			if(value~=0)then
--				if(not layercache[value])then
--					layercache[value]=CreateFrame("Frame","NPA_ModuleLayerFrame",modulemain)
--					layercache[value]:SetHeight(3)
--					layercache[value]:SetWidth(3)
--					layercache[value]:SetPoint("CENTER",modulemain,"CENTER")

--					local layerrender=CreateFrame("ScrollFrame","NPA_ModuleLayerFrame",rendermain)
--					layerrender:SetHeight(2048)
--					layerrender:SetWidth(2048)
--					layerrender:SetPoint("CENTER",modulemain,"CENTER")
--					layerrender:SetScrollChild(layercache[value])

--					layercache[value].Render=layerrender
--				end
--				main:SetParent(layercache[value])
--				layercache[value]:Show()
--			else
--				if(key=="NameText" or key=="RaidIcon")then
--					main:SetParent(modulemain:GetParent())
--				else
--					main:SetParent(modulemain)
--				end
--			end
--		end
--	end

--	local level=rendermain:GetFrameLevel() or 1
--	for i=1,24 do
--		local j=25-i
--		if(layercache[j] and layercache[j]:IsShown())then
--			layercache[j].Render:SetFrameLevel(level)
--			level=level+1
--		end
--	end
--end
