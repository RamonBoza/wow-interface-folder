-- Author      : Nogarder
-- Create Date : 2012/12/29 13:01:07
local NPA_GetTime=NPA.GetTime
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements
local NPA_TextureManager_ManageTexture2=NPA.TextureManager.ManageTexture2

local NPA_BarManager_SetBarGroupColor=NPA.BarManager.SetBarGroupColor
local NPA_BarManager_SetBarGroup=NPA.BarManager.SetBarGroup

local NPA_Color_GetColorBySpellSchool=NPA.Color.GetColorBySpellSchool

local NPA_NumberManager_SetNumber=NPA.NumberManager.SetNumber
local NPA_NumberManager_SetNumberColor=NPA.NumberManager.SetNumberColor

local NPA_FrameMacro_SetFrameTimer=NPA.FrameMacro.SetFrameTimer

local NPA_NumberManager_SetTimerNumber=NPA.NumberManager.SetTimerNumber

local NPA_TextManager_SetText=NPA.TextManager.SetText
local NPA_TextManager_SetTextColor=NPA.TextManager.SetTextColor


--the icon
NPA.NamePlateModuleManager.RegisterDataModule("Icon","Casting",function(framedata,textureframe,setting)
	--add event elements
 	--name update
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"Casting_Updated",function(framedata)
		local castinfo=framedata.UnitData.CastInfo
		local nTime=NPA_GetTime()
		--endtime==nil means casting is ended
		if(castinfo and castinfo.EndTime and castinfo.EndTime>nTime)then
			textureframe:Show()
			--set frame timer,  function(frame,starttime,endtime,revers,onupdatefunc,timerendfunc)
			NPA_FrameMacro_SetFrameTimer(textureframe,castinfo.StartTime,castinfo.EndTime,
				--onupdate func
				nil, --do nothing
				--on timer end func, hide it
				function(data)
					textureframe:Hide()
				end)
			--reset texcoord
			textureframe.Icon:SetTexCoord(0,1,0,1)
			textureframe.Icon:SetTexture(castinfo.Icon)
		else
			textureframe:Hide()
		end
	end)
end)
--the bar
NPA.NamePlateModuleManager.RegisterDataModule("BarGroup","Casting",function(framedata,bargroupframe,setting)
	--add event elements
 	--name update
	local colormode=setting.ColorMode
	NPA_NamePlateDataParser_AddElements(framedata,bargroupframe,"Casting_Updated",function(framedata)
		local castinfo=framedata.UnitData.CastInfo
		local nTime=NPA_GetTime()
		--check endtime>ntime to prevent combatlog miss
		if(castinfo and castinfo.EndTime and castinfo.EndTime>nTime)then
			--show it
			bargroupframe:Show()
			--set frame timer,  function(frame,starttime,endtime,revers,onupdatefunc,timerendfunc)
			NPA_FrameMacro_SetFrameTimer(bargroupframe,castinfo.StartTime,castinfo.EndTime,
				--onupdate func
				function(nTime,data)
					local current=data.EndTime-nTime
					--don't have to check it , it's done in timer
					if(castinfo.Channeling)then --revers channeling
						NPA_BarManager_SetBarGroup(bargroupframe,current/data.Length)
					else
						NPA_BarManager_SetBarGroup(bargroupframe,1-(current/data.Length))
					end
				end,
				--on timer end func, hide it
				function()
					bargroupframe:Hide()
				end)
			-- color mode
			--color by school
			if(colormode==5)then 
				local color=NPA_Color_GetColorBySpellSchool(castinfo.School)
				NPA_BarManager_SetBarGroupColor(bargroupframe,color)
			end
		else
			bargroupframe:Hide()
		end
	end)
end)
--the timer number
NPA.NamePlateModuleManager.RegisterDataModule("Number","Casting",function(framedata,numberframe,setting)
	--add event elements
 	--name update
	local colormode=setting.ColorMode
	NPA_NamePlateDataParser_AddElements(framedata,numberframe,"Casting_Updated",function(framedata)
		local castinfo=framedata.UnitData.CastInfo
		local nTime=NPA_GetTime()
		--check endtime>ntime to prevent combatlog miss
		if(castinfo and castinfo.EndTime and castinfo.EndTime>nTime)then
			--show it
			numberframe:Show()
			--set frame timer,  function(frame,starttime,endtime,revers,onupdatefunc,timerendfunc)
			NPA_FrameMacro_SetFrameTimer(numberframe,castinfo.StartTime or 0,castinfo.EndTime,
				--onupdate func
				function(nTime,data)
					local current=data.EndTime-nTime
					NPA_NumberManager_SetNumber(numberframe,current,data.Length,true)
				end,
				--on timer end func, hide it
				function()
					numberframe:Hide()
				end)
			-- color mode
			--color by school
			if(colormode==5)then 
				local color=NPA_Color_GetColorBySpellSchool(castinfo.School)
				NPA_NumberManager_SetNumberColor(numberframe,color)
			end
		else
			numberframe:Hide()
		end
	end)
end)

--the name
NPA.NamePlateModuleManager.RegisterDataModule("Text","Casting",function(framedata,textframe,setting)
	--add event elements
	local colormode=setting.ColorMode
 	--hook name update
	NPA_NamePlateDataParser_AddElements(framedata,textframe,"Casting_Updated",function(framedata)
		local castinfo=framedata.UnitData.CastInfo
		local nTime=NPA_GetTime()
		--endtime==nil means casting is ended
		if(castinfo and castinfo.EndTime and castinfo.EndTime>nTime)then
			--
			textframe:Show()
			--set frame timer,  function(frame,starttime,endtime,revers,onupdatefunc,timerendfunc)
			NPA_FrameMacro_SetFrameTimer(textframe,castinfo.StartTime,castinfo.EndTime,
				--onupdate func
				nil, -- does nothing when updating
				--on timer end func, hide it
				function()
					textframe:Hide()
				end)
			--set text
			NPA_TextManager_SetText(textframe,castinfo.Name)
			--color mode
			if(colormode==5)then --color by school
				local color=NPA_Color_GetColorBySpellSchool(castinfo.School)
				NPA_TextManager_SetTextColor(textframe,color)
			end
		else
			textframe:Hide()
		end
	end)
end)
--casting texture
NPA.NamePlateModuleManager.RegisterDataModule("TextureGroup","Casting",function(framedata,textureframe,setting)
	--add event elements
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"Casting_Updated",function(framedata)
		local castinfo=framedata.UnitData.CastInfo
		local nTime=NPA_GetTime()
		--endtime==nil means casting is ended
		if(castinfo and castinfo.EndTime and castinfo.EndTime>nTime)then
			--show it
			textureframe:Show()
			--set frame timer,  function(frame,starttime,endtime,revers,onupdatefunc,timerendfunc)
			NPA_FrameMacro_SetFrameTimer(textureframe,castinfo.StartTime,castinfo.EndTime,
				--onupdate func
				nil, -- does nothing when updating
				--on timer end func, hide it
				function()
					textureframe:Hide()
				end)
		else
			textureframe:Hide()
		end
	end)
end)
--inturrept shield
NPA.NamePlateModuleManager.RegisterDataModule("TextureGroup","CastingShield",function(framedata,textureframe,setting)
	--add event elements
	NPA_NamePlateDataParser_AddElements(framedata,textureframe,"Casting_Updated",function(framedata)
		local castinfo=framedata.UnitData.CastInfo
		local nTime=NPA_GetTime()
		--endtime==nil means casting is ended
		if(castinfo and castinfo.EndTime and castinfo.EndTime>nTime and castinfo.NoInterrupt)then
			textureframe:Show()
			--set frame timer,  function(frame,starttime,endtime,revers,onupdatefunc,timerendfunc)
			NPA_FrameMacro_SetFrameTimer(textureframe,castinfo.StartTime,castinfo.EndTime,
				--onupdate func
				nil, -- does nothing when updating
				--on timer end func, hide it
				function()
					textureframe:Hide()
				end)
		else
			textureframe:Hide()
		end
	end)
end)