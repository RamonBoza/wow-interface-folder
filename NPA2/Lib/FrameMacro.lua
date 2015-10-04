-- Author      : Nogarder
-- Create Date : 2012/4/7 15:25:27
NPA.FrameMacro={}
--
local NPA_GetTime=NPA.GetTime
local NPA_RunFunc=NPA.RunFunc
local NPA_FrameMacro_FrameTimer={}
--timer
--clear up timer data for reuse of other purpose
NPA.FrameMacro.ResetFrameTimer=function(frame)
	frame:SetScript("OnUpdate",nil)
	if(NPA_FrameMacro_FrameTimer[frame])then
		NPA_RunFunc(NPA_FrameMacro_FrameTimer[frame].TimerEndFunc,frame)
	end
	NPA_FrameMacro_FrameTimer[frame]=nil
	--local data=NPA_FrameMacro_FrameTimer[frame]
	--if(data)then
	--	data.StartTime=nil
	--	data.EndTime=nil
	--	data.Length=nil
	--	data.TimerEndFunc=nil
	--	data.OnUpdateFunc=nil
	--end
end
--timer on update
local NPA_FrameMacro_TimerOnUpdate=function(frame)
	local data=NPA_FrameMacro_FrameTimer[frame]
	--if(not data)then
	--	frame:Hide()
	--	return
	--end
	local nTime=NPA_GetTime()
	if(nTime>data.EndTime)then
		NPA_RunFunc(data.TimerEndFunc,frame)
		--hidding or unhooking should be done in endfunc
		--frame:Hide()
	else
		NPA_RunFunc(data.OnUpdateFunc,nTime,data,frame)
	end
end
--
NPA.FrameMacro.SetFrameTimer=function(frame,starttime,endtime,onupdatefunc,timerendfunc)
	--create new table when not exists
	if(not NPA_FrameMacro_FrameTimer[frame])then
		frame:SetScript("OnUpdate",NPA_FrameMacro_TimerOnUpdate)
		NPA_FrameMacro_FrameTimer[frame]={
			StartTime=starttime or 0,
			EndTime=endtime,
			Length=endtime-(starttime or 0),
			TimerEndFunc=timerendfunc,
			OnUpdateFunc=onupdatefunc
		}
	else
		--update old data
		local data=NPA_FrameMacro_FrameTimer[frame]
		data.StartTime=starttime or data.StartTime or 0
		data.EndTime=endtime or data.EndTime
		data.Length=(data.EndTime-data.StartTime) or data.Length
		data.TimerEndFunc=timerendfunc or data.TimerEndFunc
		data.OnUpdateFunc=onupdatefunc or data.OnUpdateFunc
	end
end
