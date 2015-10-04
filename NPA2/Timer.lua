-- Author      : Nogarder
-- Create Date : 2013/4/20 13:06:28
--using for timed event like cooldown
--
--using this to get a certain function delayed in time
local table_insert=table.insert
local table_remove=table.remove
local table_getn=table.getn
--
local NPA_GetTime=NPA.GetTime
--
NPA.Timer={}
--
local NPA_Timer_OnUpdate=function(self)
	local nTime=NPA_GetTime()
	local timer=self.Timers[1]
	--timer is sorted in endtime order so just check the fist one
	if(timer and timer.EndTime<nTime)then
		--run function
		self.EndFunc(timer.Name,timer.Name2)
		--remove it
		table_remove(self.Timers,1)
	end
end
--
NPA.Timer.CreateTimer=function(endfunc)
	local timerframe=CreateFrame("Frame",NPA.MainFrame,nil)
	timerframe:SetWidth(1)
	timerframe:SetHeight(1)
	timerframe.Timers={}
	timerframe:SetScript("OnUpdate",NPA_Timer_OnUpdate)
	timerframe.EndFunc=endfunc
	return timerframe
end
--
local NPA_Timer_InsertTimer=function(timers,data)
	--check time order
	for i=1,table_getn(timers)do
		if(timers[i].EndTime>data.EndTime)then
			table_insert(timers,i,data)
			return
		end
	end
	--
	table_insert(timers,data)
end

NPA.Timer.AddTimer=function(timergroup,name,name2,endtime)
	local timers=timergroup.Timers
	--check for old one
	for index,data in pairs(timers)do
		if(data.Name==name and data.Name2==name2)then
			--exists ,remove it
			table_remove(timers,index)
			break
		end
	end
	--insert it
	NPA_Timer_InsertTimer(timers,{Name=name,Name2=name2,EndTime=endtime})
end
--
NPA.Timer.RemoveTimer=function(timergroup,name,name2)
	local timers=timergroup.Timers
	--check for old one
	for index,data in pairs(timers)do
		if(data.Name==name and data.Name2==name2)then
			--exists ,remove it
			table_remove(timers,index)
			return
		end
	end
end