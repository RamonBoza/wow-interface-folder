-- Author      : Nogarder
-- Create Date : 2012/3/16 20:02:29
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Threat",
	function()
		--global
		local UnitIsFriend=UnitIsFriend
		local UnitDetailedThreatSituation=UnitDetailedThreatSituation
		local UnitThreatSituation=UnitThreatSituation
		--main --using local for speed
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		--register on on_update event for a real time update
		NPA.EventHandler.RegisterEvent(2,"DataCollector_Collectable_OnUpdate","DataCollector_Threat",function(unit,unitdata)
			local percent
			local status
			--dont get percent now
			--check if friendly
			if(UnitIsFriend(unit,"player"))then
				--threat percent for its target
				--_,_,percent=UnitDetailedThreatSituation(unit,unit.."-target")
				--use system's "whole status" rather than of its target
				status=UnitThreatSituation(unit)
				--3 = securely tanking, 2 = insecurely tanking
				--1 = not tanking but higher threat than tank, 0 = not tanking and lower threat than tank
			else
				--not friendly ,get info directly
				--this may reports error for unknow reason...
				--_,status,percent=UnitDetailedThreatSituation("player",unit)
				_,status=UnitDetailedThreatSituation("player",unit)
			end
			--check for different
			--if(percent~=unitdata.ThreatPercent or status~=unitdata.ThreatStatus)then
			if(status~=unitdata.ThreatStatus)then
				unitdata.ThreatStatus=status
				--fire the event
				NPA_EventHandler_FireEvent(7,"Threat_Updated",unitdata)
			end
		end)
		--macro for get threat
		local floor=floor
		local NPA_NamePlate_ColorToThreat={}
		for i=0,3 do 
			local r, g, b = GetThreatStatusColor(i)
			r=floor(r*10)
			g=floor(g*10)
			b=floor(b*10)
			if(not(NPA_NamePlate_ColorToThreat[r]))then
				NPA_NamePlate_ColorToThreat[r]={}
			end
			if(not(NPA_NamePlate_ColorToThreat[r][g]))then
				NPA_NamePlate_ColorToThreat[r][g]={}
			end
			NPA_NamePlate_ColorToThreat[r][g][b]=i
		end
		--check nameplate threat status with threat glow color
		NPA_Threat_GetThreatByFrameData=function(framedata)
			if(framedata.Default)then
				local threatglow=framedata.Default.ThreatGlow
				if(threatglow:IsShown())then
					local r,g,b=threatglow:GetVertexColor()
					r=floor(r*10)
					g=floor(g*10)
					b=floor(b*10)
					if(NPA_NamePlate_ColorToThreat[r] and NPA_NamePlate_ColorToThreat[r][g] and NPA_NamePlate_ColorToThreat[r][g][b])then
						return NPA_NamePlate_ColorToThreat[r][g][b]
					end
				end
				return nil
			end
		end
		--
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnUpdate","DataCollector_Threat",function(framedata)
			local unitdata=framedata.UnitData
			local threat=NPA_Threat_GetThreatByFrameData(framedata)
			if(threat~=unitdata.ThreatStatus)then
				unitdata.ThreatStatus=threat
				unitdata.ThreatPercent=nil
				--3 = securely tanking, 2 = insecurely tanking
				--1 = not tanking but higher threat than tank, 0 = not tanking and lower threat than tank
				--4 or nil = no threat at all
				--fire threat change event
				NPA_EventHandler_FireEvent(8,"Threat_Updated",framedata)
			end
		end)
	end,
	function()
		--unregister events
		NPA.EventHandler.RegisterEvent(2,"DataCollector_Collectable_OnUpdate","DataCollector_Threat",nil)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnUpdate","DataCollector_Threat",nil)

	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function(unitdata,frameunitdata)
		--use frame-based first for status as it may change by time
		unitdata.ThreatStatus=frameunitdata.ThreatStatus or unitdata.ThreatStatus
		--don't bother threatpercent as frame-based won't get it
	end
	)
