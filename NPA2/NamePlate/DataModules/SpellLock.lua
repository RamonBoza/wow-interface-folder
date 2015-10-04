-- Author      : Nogarder
-- Create Date : 2013/4/17 13:33:30
local floor=floor
local NPA_GetTime=NPA.GetTime

local NPA_FrameMacro_SetFrameTimer=NPA.FrameMacro.SetFrameTimer

local NPA_SpellLock_SpellTypeColor={
	[1]="|cffffff00",
	[2]="|cffffff88",
	[4]="|cffff4800",
	[8]="|cff40ff40",
	[16]="|cff88ffff",
	[32]="|cff8888ff",
	[64]="|cffff88ff"
}


local NPA_TextManager_SetText=NPA.TextManager.SetText

local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements
NPA.NamePlateModuleManager.RegisterDataModule("Text","SpellLock",function(framedata,textframe,setting)
	--add event elements
 	--hook name update
	NPA_NamePlateDataParser_AddElements(framedata,textframe,"SpellLock_Updated",function(framedata,unitdata)
		local spelllock=unitdata.SpellLock
		if(spelllock)then
			local nTime=NPA_GetTime()
			local endtime=0
			local text=""
			for school,time in pairs(spelllock)do
				local length=time-nTime
				if(length>0)then
					text=text..(NPA_SpellLock_SpellTypeColor[school] or "|cffffffff").."["..floor(length).."]"
					if(time>endtime)then
						endtime=time
					end
				end
			end
			--
			if(endtime>0)then
				textframe:Show()
				--set timer
				--set frame timer,  function(frame,starttime,endtime,revers,onupdatefunc,timerendfunc)
				NPA_FrameMacro_SetFrameTimer(textframe,nTime,endtime,
					--onupdate func
					function(nTime)
						local text=""
						for school,time in pairs(spelllock)do
							local length=time-nTime
							if(length>0)then
								text=text..(NPA_SpellLock_SpellTypeColor[school] or "|cffffffff").."["..floor(length).."]"
							end
						end
						NPA_TextManager_SetText(textframe,text)
					end,
					--on timer end func, hide it
					function(data)
						textframe:Hide()
					end)
				--show text
				NPA_TextManager_SetText(textframe,text)
			else
				textframe:Hide()
			end
		else
			textframe:Hide()
		end
	end)
end)