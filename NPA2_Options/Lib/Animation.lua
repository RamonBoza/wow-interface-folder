-- Author      : Nogarder
-- Create Date : 2012/4/17 15:10:58
--global 
local sqrt=sqrt
local abs=abs
local mod=mod
local sin=sin
--speed
local speed=10
--main
NPA_Options.Animation={}
--
local DefaultTime=0.2
--list
local NPA_Options_Animation_Alpha_List={}
local NPA_Options_Animation_Minimize_List={}
local NPA_Options_Animation_Blink_List={}
--macro for init alpha
local NPA_Options_Animation_InitAlpha=function(frame,time,endalpha)
	local time=time or DefaultTime
	local endalpha=endalpha or 1
	NPA_Options_Animation_Alpha_List[frame]={
		Count=time,
		Step=(endalpha-frame:GetAlpha())/time,
		EndAlpha=endalpha}
	frame:Show()
end
--
local NPA_Options_Animation_RestoreScroll=function(frame)
	local scroll=frame.Scroll
	local data=NPA_Options_Animation_Minimize_List[scroll]
	if(NPA_Options_Animation_Minimize_List[scroll])then
		scroll:SetWidth(data.Width)
		scroll.Frame:SetAlpha(1)
		scroll.Title:SetAlpha(1)
		NPA_Options_Animation_Minimize_List[scroll]=nil
		scroll.Minimized=nil
	end
end
--macro for show/hide frame
NPA_Options.Animation.ShowFrame=function(frame,time)
	if(frame)then
		NPA_Options_Animation_RestoreScroll(frame)
		frame:SetAlpha(0)
		frame:Show()
		NPA_Options_Animation_InitAlpha(frame,time,1)
	end
end
NPA_Options.Animation.HideFrame=function(frame,time)
	if(frame)then
		if(frame:IsShown() and (not NPA_Options_Animation_Alpha_List[frame]))then
			frame:SetAlpha(1)
			NPA_Options_Animation_InitAlpha(frame,time,0)
		end
	end
end
--macro for blink frame
NPA_Options.Animation.SetBlink=function(frame,enable)
	if(not enable)then
		if(NPA_Options_Animation_Blink_List[frame])then
			frame:SetAlpha(NPA_Options_Animation_Blink_List[frame])
		end
		NPA_Options_Animation_Blink_List[frame]=nil
	else
		if(not NPA_Options_Animation_Blink_List[frame])then
			NPA_Options_Animation_Blink_List[frame]=frame:GetAlpha()
		end
	end
end
--animation control
NPA_Options.MainFrame:HookScript("OnUpdate",function(_,elapse)
	--alpha
	for frame,data in pairs(NPA_Options_Animation_Alpha_List)do
		data.Count=data.Count-elapse
		if(data.Count<0)then
			frame:SetAlpha(data.EndAlpha)
			if(data.EndAlpha==0)then
				frame:Hide()
				NPA_Options_Animation_RestoreScroll(frame)
			end
			NPA_Options_Animation_Alpha_List[frame]=nil
		else
			frame:SetAlpha(data.EndAlpha-data.Step*data.Count)
		end
	end
	--size
	for scroll,data in pairs(NPA_Options_Animation_Minimize_List)do
		data.Count=data.Count-elapse
		if(data.State==1)then
			--minimizing
			if(data.Count<0)then
				scroll:SetWidth(1)
				scroll.Frame:SetAlpha(0)
				scroll.Title:SetAlpha(0)
				data.State=3
				scroll.Minimized=true
				NPA_Options.RunFunc(scroll.OnMinimizedFunc)
			else
				scroll:SetWidth(1+data.Count*data.Step)
				local alpha=data.Count*data.AlphaStep
				scroll.Frame:SetAlpha(alpha)
				scroll.Title:SetAlpha(alpha)
			end
		elseif(data.State==2)then
			--restoring
			if(data.Count<0)then
				scroll:SetWidth(data.Width)
				scroll.Frame:SetAlpha(1)
				scroll.Title:SetAlpha(1)
				NPA_Options_Animation_Minimize_List[scroll]=nil
				scroll.Minimized=nil
				NPA_Options.Template.UpdateScrollFrame(scroll.Frame)
				--
				NPA_Options.RunFunc(scroll.OnRestoredFunc)
			else
				scroll:SetWidth(1+data.Width-data.Count*data.Step)
				local alpha=1-data.Count*data.AlphaStep
				scroll.Frame:SetAlpha(alpha)
				scroll.Title:SetAlpha(alpha)
			end
		end
	end
	for frame,alpha in pairs(NPA_Options_Animation_Blink_List)do
		if(frame:IsShown())then
			local value=mod(GetTime(),1)*360
			frame:SetAlpha((0.75+sin(value)/4)*alpha)
		end
	end
end)
--clear
NPA_Options.Animation.ClearPosition=function(frame)
	if(NPA_Options_Animation_Position_List[frame])then
		data=NPA_Options_Animation_Position_List[frame]
		frame:SetPoint("CENTER",frame:GetParent(),"CENTER",data.PosX,data.PosY)
		frame:SetAlpha(1)
		NPA_Options_Animation_Position_List[frame]=nil
	end
end
--
NPA_Options.Animation.ClearAlpha=function(frame)
	if(NPA_Options_Animation_Alpha_List[frame])then
		frame:SetAlpha(NPA_Options_Animation_Alpha_List[frame].EndAlpha)
		NPA_Options_Animation_Alpha_List[frame]=nil
	end
end
--
NPA_Options.Animation.IsWorking=function(scroll)
	if(NPA_Options_Animation_Minimize_List[scroll] and NPA_Options_Animation_Minimize_List[scroll].State~=3)then
		return true
	end
end
--
NPA_Options.Animation.NotHide=function(scroll)
	if(scroll:IsShown() and ((not NPA_Options_Animation_Alpha_List[scroll]) or NPA_Options_Animation_Alpha_List[scroll].EndAlpha~=0))then
		return true
	end
end
--
NPA_Options.Animation.IsMinimized=function(scroll)
	--not restoreing
	if(NPA_Options_Animation_Minimize_List[scroll] and NPA_Options_Animation_Minimize_List[scroll].State~=2)then
		return true
	end
end
---
--minimize
--1=minimizing
--2=restoring
--3=hang up
NPA_Options.Animation.RestoreScroll=function(scroll,time)
	if(not scroll)then
		return
	end
	if(NPA_Options_Animation_Minimize_List[scroll] and NPA_Options_Animation_Minimize_List[scroll].State==3)then
		NPA_Options.HideTemplates()
		local time=time or DefaultTime
		NPA_Options_Animation_Minimize_List[scroll].State=2
		NPA_Options_Animation_Minimize_List[scroll].Count=time
	end
end
NPA_Options.Animation.MinimizeScroll=function(scroll,time)
	if(not scroll)then
		return
	end
	local time=time or DefaultTime
	NPA_Options.HideTemplates()
	if(not NPA_Options_Animation_Minimize_List[scroll])then
		NPA_Options_Animation_Minimize_List[scroll]={
			State=1,
			Width=scroll:GetWidth(),
			Count=time,
			Step=scroll:GetWidth()/time,
			AlphaStep=1/time
		}
	else
		NPA_Options_Animation_Minimize_List[scroll].State=1
		NPA_Options_Animation_Minimize_List[scroll].Count=0
	end
end
NPA_Options.Animation.GetScrollWidth=function(scroll)
	if(NPA_Options_Animation_Minimize_List[scroll])then
		return NPA_Options_Animation_Minimize_List[scroll].Width
	else
		return scroll:GetWidth()
	end
end
--macro for clear all
NPA_Options.Animation.ClearAll=function()
	for frame,data in pairs(NPA_Options_Animation_Alpha_List)do
		frame:SetAlpha(data.EndAlpha)
		if(data.EndAlpha==0)then
			frame:Hide()
		end
		NPA_Options_Animation_Alpha_List[frame]=nil
	end
	for scroll,data in pairs(NPA_Options_Animation_Minimize_List)do
		scroll:SetWidth(data.Width)
		scroll.Frame:SetAlpha(1)
		scroll.Title:SetAlpha(1)
		NPA_Options_Animation_Minimize_List[scroll]=nil
		scroll.Minimized=nil
	end
	for frame,alpha in pairs(NPA_Options_Animation_Blink_List)do
		frame:SetAlpha(alpha)
		NPA_Options_Animation_Blink_List[frame]=nil
	end
end
