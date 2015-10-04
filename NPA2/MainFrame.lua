-- Author      : Nogarder
-- Create Date : 2012/3/16 18:11:02
-- core
local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
--create mainframe
local NPA_MainFrame=CreateFrame("Frame","NPA_MainFrame",UIParent)
NPA.MainFrame=NPA_MainFrame
NPA_MainFrame:SetFrameStrata("BACKGROUND")
--set main frame script
NPA_MainFrame:SetScript("OnEvent",function(_,event,...)
	NPA_EventHandler_FireEvent(0,event,...)
end)
--register variables onload event
NPA.EventHandler.RegisterEvent(0,"VARIABLES_LOADED","NPA_MainFrame",function()
	--fire mainframe on load event
	NPA_EventHandler_FireEvent(3,"NPA_MainFrame_OnLoad")
	--unregister onload event
	NPA.EventHandler.RegisterEvent(0,"VARIABLES_LOADED","NPA_MainFrame",nil)
	--start up onupdate function
	NPA_MainFrame:SetScript("OnUpdate",function(_,elapse)
		NPA_EventHandler_FireEvent(3,"NPA_MainFrame_OnUpdate",elapse)
	end)
	--print version info
	print("NamePlateAdvance2 Build "..(NPA.Version).." Loaded")
	--print("Detected Interface Version:"..(NPA.InterfaceVersion or "unknow"))
	print("/npa for options")
	print("'/npa reset' for reset all settings and reload ui")
	--set slash command handler
	_G["SLASH_NPA1"]="/NPA"
	SlashCmdList["NPA"]=function(cmd)
		if(cmd=="reset")then
			NPA_Setting=nil
			ReloadUI()
			return
		end
		local loaded, reason=LoadAddOn("NPA2_Options")
		if(loaded)then
			if(NPA_Options.Start)then
				NPA_Options.Start()
			end
		else
			print("Options Load Error:"..reason)
		end
	end
end)


