-- Author      : Nogarder
-- Create Date : 2013/4/12 11:49:52
--mainframe redirector
local pairs=pairs
local table_getn=table.getn
--
local NPA_BarManager_ManageBarGroup=NPA.BarManager.ManageBarGroup
local NPA_NamePlateDataParser_RemoveElements=NPA.NamePlateDataParser.RemoveElements
local NPA_BarManager_CreateBarGroup=NPA.BarManager.CreateBarGroup

local NPA_FrameMacro_ResetFrameTimer=NPA.FrameMacro.ResetFrameTimer
--
NPA.NamePlateModuleManager.RegisterModule("MainFrame",function(framedata,profile,modulemain,funclist)
	--reset
	modulemain:SetAlpha(1)
	NPA_NamePlateDataParser_RemoveElements(framedata,"Alpha")
	NPA_NamePlateDataParser_RemoveElements(framedata,"Scale")
	NPA_NamePlateDataParser_RemoveElements(framedata,"Offset")
	NPA_NamePlateDataParser_RemoveElements(framedata,"FrameLevel")
	if(profile)then
		--register alpha module
		local funclist2=funclist["Alpha"]
		if(funclist2)then
			funclist2(framedata,modulemain,profile.AlphaSetting)
		end
		--register scale module
		local funclist2=funclist["Scale"]
		if(funclist2)then
			funclist2(framedata,modulemain,profile.ScaleSetting)
		end
		--register offset module
		local funclist2=funclist["Offset"]
		if(funclist2)then
			funclist2(framedata,modulemain,profile.OffsetSetting)
		end
		--frame level
		local funclist2=funclist["FrameLevel"]
		if(modulemain.RenderMain and funclist2)then
			funclist2(framedata,modulemain,profile.FrameLevelSetting)
		end
	end
end)