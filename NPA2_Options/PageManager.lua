-- Author      : Nogarder
-- Create Date : 2012/4/14 16:51:38
local pairs=pairs
local type=type
local CopyTable=CopyTable
local table_insert=table.insert
local next=next
--
local NPA_Options_PageManager_PageList={}
local NPA_Options_PageManager_ButtonList={}
local NPA_Options_PageManager_LinkList={}
--
local NPA_Options_PageManager_TemplateList={}
local NPA_Options_PageManager_WindowList={}
--
local NPA_Options_PageManager_MinimizeList={}
--
local NPA_Options_PageManager_PageFunc={}
--macro for minimize all sub pages
NPA_Options.MinimizePages=function(page)
	local closelist={[page]=true}
	while(next(closelist))do
		for opage,_ in pairs(closelist)do
			--insert all pages linked to it
			for apage,parent in pairs(NPA_Options_PageManager_LinkList)do
				if(parent==opage)then
					closelist[apage]=true
				end
			end
			--hide it and remove it from the list,(unless switch is true)
			if(opage~=page)then
				NPA_Options.Animation.MinimizeScroll(opage.Scroll)
			end
			closelist[opage]=nil
		end
	end
end
--unminimize
NPA_Options.RestorePages=function(page)
	local closelist={[page]=true}
	while(next(closelist))do
		for opage,_ in pairs(closelist)do
			--insert all pages linked to it
			for apage,parent in pairs(NPA_Options_PageManager_LinkList)do
				if(parent==opage)then
					closelist[apage]=true
				end
			end
			--hide it and remove it from the list,(unless switch is true)
			if(opage~=page)then
				NPA_Options.Animation.RestoreScroll(opage.Scroll)
			end
			closelist[opage]=nil
		end
	end
end
--macro for close pages
NPA_Options.ClosePages=function(page,nothide)
	local closelist={[page]=true}
	while(next(closelist))do
		for opage,_ in pairs(closelist)do
			--insert all pages linked to it
			for apage,parent in pairs(NPA_Options_PageManager_LinkList)do
				if(parent==opage)then
					closelist[apage]=true
				end
			end
			--hide it and remove it from the list,(unless switch is true)
			if((not nothide) or opage~=page)then
				NPA_Options.Animation.HideFrame(opage)
			end
			closelist[opage]=nil
		end
	end
end
--
NPA_Options.GetPage=function(name)
	return NPA_Options_PageManager_PageList[name]
end
--
NPA_Options.PageIsShown=function(name)
	return NPA_Options_PageManager_PageList[name] and NPA_Options_PageManager_PageList[name]:IsShown()
end
--
NPA_Options.RegisterPage=function(name,page)
	NPA_Options_PageManager_PageList[name]=page
end
--
local NPA_Options_AutoMinimize=function(page)
	local apage=NPA_Options_PageManager_LinkList[page]
	while(apage)do
		local parent=NPA_Options_PageManager_LinkList[apage]
		if(parent and (not NPA_Options.Animation.IsMinimized(parent.Scroll)))then
			apage=parent
		else
			if(apage==page)then
				return true --true means no more aviliable parent
			else
				NPA_Options.RegisterMinimize(page,apage)
				return apage.Scroll:GetWidth()--return the width
			end
		end
	end
end
NPA_Options.SetPage=function(name,parent,arg1,arg2,arg3,arg4,arg5,onhidefunc)
	--check visible
	NPA_Options.HideTemplates()
	local page=NPA_Options_PageManager_PageList[name]
	--if not inited yet ,do it
	if(not page)then
		NPA_Options.RunFunc(NPA_Options_PageManager_PageFunc[name])
		page=NPA_Options_PageManager_PageList[name]
	end
	if(not page.DontHideOther)then
		NPA_Options.ClosePages(parent,true)
	end
	page.LinkTo=parent
	page:Hide()
	page.OnHideFunc=onhidefunc
	NPA_Options_PageManager_LinkList[page]=parent
	NPA_Options.RunFunc(page.OnSetFunc,arg1,arg2,arg3,arg4,arg5)
	NPA_Options.Animation.ShowFrame(page)
	--auto minimize --don't use it for now
	--local uiright=UIParent:GetWidth()
	--local pageright=page.Scroll:GetRight()
	--local result=0
	--while(result~=true and pageright>uiright)do
	--	pageright=pageright-result
	--	result=NPA_Options_AutoMinimize(page)
	--end
end
NPA_Options.SetPageButton=function(button,name,parent,arg1,arg2,arg3,arg4,arg5)
	if(not NPA_Options_PageManager_ButtonList[button])then
		button:HookScript("OnMouseUp",function()
			local data=NPA_Options_PageManager_ButtonList[button]
			NPA_Options.ClosePages(data.Parent,true)
			NPA_Options.SetPage(data.Name,data.Parent,data.Arg1,data.Arg2,data.Arg3,data.Arg4,data.Arg5)
		end)
	end
	NPA_Options_PageManager_ButtonList[button]={
		Name=name,
		Parent=parent,
		Arg1=arg1,
		Arg2=arg2,
		Arg3=arg3,
		Arg4=arg4,
		Arg5=arg5
		}		
end
--

--template
NPA_Options.RegisterTemplate=function(frame,hidefunc)
	NPA_Options_PageManager_TemplateList[frame]=hidefunc
end
--
NPA_Options.HideTemplates=function(oframe)
	for frame,func in pairs(NPA_Options_PageManager_TemplateList)do
		if(frame~=oframe)then
			func()
		end
	end
end
--
NPA_Options.RegisterWindow=function(frame,hidefunc)
	NPA_Options_PageManager_WindowList[frame]=hidefunc
end
--
NPA_Options.RegisterMinimize=function(frame,minimize)
	if(minimize)then
		NPA_Options.Animation.MinimizeScroll(minimize.Scroll)
		if(not NPA_Options_PageManager_MinimizeList[minimize])then
			NPA_Options_PageManager_MinimizeList[minimize]={}
		end
		NPA_Options_PageManager_MinimizeList[minimize][frame]=true
	end
end
NPA_Options.UnregisterMinimize=function(frame,minimize)
	if(minimize)then
		if(NPA_Options_PageManager_MinimizeList[minimize])then
			NPA_Options_PageManager_MinimizeList[minimize][frame]=nil
			if(next(NPA_Options_PageManager_MinimizeList[minimize])==nil)then
				NPA_Options_PageManager_MinimizeList[minimize]=nil
				NPA_Options.Animation.RestoreScroll(minimize.Scroll)
			end
		else
			NPA_Options.Animation.RestoreScroll(minimize.Scroll)
		end
	else
		for minimize,data in pairs(NPA_Options_PageManager_MinimizeList)do
			data[frame]=nil
			if(next(data)==nil)then
				NPA_Options_PageManager_MinimizeList[minimize]=nil
				NPA_Options.Animation.RestoreScroll(minimize.Scroll)
			end
		end
	end
end
--
NPA_Options.RegisterPageFunc=function(name,func)
	NPA_Options_PageManager_PageFunc[name]=func
end