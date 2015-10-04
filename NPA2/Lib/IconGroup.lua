-- Author      : Nogarder
-- Create Date : 2012/11/22 14:48:27
local pairs=pairs
local table_insert=table.insert
local table_getn=table.getn
local table_sort=table.sort
local mod=mod
local NPA_GetTime=NPA.GetTime
local NPA_RunFunc=NPA.RunFunc
local floor=floor
--
local NPA_SpellInfo_GetSpellInfo=NPA.SpellInfo.GetSpellInfo

local NPA_FontManager_ManageFont2=NPA.FontManager.ManageFont2

local NPA_NumberManager_CreateNumber=NPA.NumberManager.CreateNumber
local NPA_NumberManager_ManageNumber=NPA.NumberManager.ManageNumber
local NPA_NumberManager_SetNumber=NPA.NumberManager.SetNumber
local NPA_NumberManager_SetNumberColor=NPA.NumberManager.SetNumberColor

local NPA_BarManager_CreateBarGroup=NPA.BarManager.CreateBarGroup
local NPA_BarManager_ManageBarGroup=NPA.BarManager.ManageBarGroup
local NPA_BarManager_SetBarGroup=NPA.BarManager.SetBarGroup
local NPA_BarManager_SetBarGroupColor=NPA.BarManager.SetBarGroupColor

local NPA_TextureManager_ManageTexture2=NPA.TextureManager.ManageTexture2
local NPA_FontManager_SetText=NPA.FontManager.SetText


local NPA_Color_GetColorBySpellType=NPA.Color.GetColorBySpellType
--
NPA.IconGroupManager={}
--
local NPA_IconGroupManager_DirectionList={
	[1]={ --grow right then up
		Anchor="BOTTOMLEFT",
		TAnchor="BOTTOMRIGHT",
		DirX=1,
		DirY=1,
	},
	[2]={ -- grow left then up
		Anchor="BOTTOMRIGHT",
		TAnchor="BOTTOMLEFT",
		DirX=-1,
		DirY=1,
	},
	[3]={ -- grow right then down
		Anchor="TOPLEFT",
		TAnchor="TOPRIGHT",
		DirX=1,
		DirY=-1,
	},
	[4]={ --grow left then down
		Anchor="TOPRIGHT",
		TAnchor="TOPLEFT",
		DirX=-1,
		DirY=-1,
	},
	[5]={ -- grow up then right
		Anchor="BOTTOMLEFT",
		TAnchor="TOPLEFT",
		DirX=1,
		DirY=1,
	},
	[6]={ --grow up then left
		Anchor="BOTTOMRIGHT",
		TAnchor="TOPRIGHT",
		DirX=-1,
		DirY=1,
	},
	[7]={ -- grow down then right
		Anchor="TOPLEFT",
		TAnchor="BOTTOMLEFT",
		DirX=1,
		DirY=-1,
	},
	[8]={ -- grow down then left
		Anchor="TOPRIGHT",
		TAnchor="BOTTOMRIGHT",
		DirX=-1,
		DirY=-1,
	},
}
--
local NPA_IconGroupManager_CreateIconFrame=function(mainframe)
	local iconframe=CreateFrame("Frame",nil,mainframe)
	iconframe:SetPoint("CENTER",mainframe,"CENTER",0,0)
	iconframe:EnableMouse(false)
	--
	return iconframe
end
--
local NPA_IconGroupManager_BarGroupUpdateFunc=function(module,length,dlength)
	NPA_BarManager_SetBarGroup(module,length/dlength)
end
--
local NPA_IconGroupManager_NumberUpdateFunc=function(module,length,dlength)
	NPA_NumberManager_SetNumber(module,length,dlength,true)
end
--
local NPA_IconGroupManager_CountUpdateFunc=function(module,length,dlength,count,spellid,maxstack)
	if(not maxstack or maxstack<count)then
		maxstack=count
	end
	if(count<2)then
		--hide when <2
		module:Hide()
	else
		NPA_NumberManager_SetNumber(module,count,maxstack)
		module:Show()
	end
end
local NPA_IconGroupManager_BarCountUpdateFunc=function(module,length,dlength,count,spellid,maxstack)
	if(not maxstack or maxstack<count)then
		maxstack=count
	end
	if(count<2)then
		--hide when <2
		module:Hide()
	else
		NPA_BarManager_SetBarGroup(module,count/maxstack)
		module:Show()
	end
end
--
local NPA_IconGroupManager_CreateModule=function(moduletype,icongroup)
	local moduleframe
	if(moduletype=="Icon" or moduletype=="Texture")then
		--create icon
		moduleframe=CreateFrame("Frame",nil,icongroup)
		moduleframe:EnableMouse(false)
		local texture=moduleframe:CreateTexture()
		texture:SetPoint("TOPLEFT",moduleframe,"TOPLEFT",0,0)
		texture:SetPoint("BOTTOMRIGHT",moduleframe,"BOTTOMRIGHT",0,0)
		moduleframe.Texture=texture
	elseif(moduletype=="Text" or moduletype=="ExtraInfo")then
		--create text
		moduleframe=CreateFrame("Frame",nil,icongroup)
		moduleframe:EnableMouse(false)
		local text=moduleframe:CreateFontString()
		text:SetPoint("CENTER",moduleframe,"CENTER",0,0)
		moduleframe.Text=text
	elseif(moduletype=="Number")then
		moduleframe=NPA_NumberManager_CreateNumber(icongroup)
	elseif(moduletype=="BarGroup")then
		moduleframe=NPA_BarManager_CreateBarGroup(icongroup)
	end
	--
	moduleframe.ModuleType=moduletype
	return moduleframe
end
--
local NPA_IconGroupManager_AddModule=function(icon,modulesbase,setting,data,icongroup)
	--get a unused one fom icongroup
	local max=table_getn(modulesbase)
	local module
	local moduletype=setting.ModuleType
	--
	for i=1,max do
		local modulesbasei=modulesbase[i]
		if(modulesbasei.ModuleType==moduletype and not modulesbasei:IsShown())then
			module=modulesbasei
			break
		end
	end
	if(not module)then
		--create a new one
		modulesbase[max+1]=NPA_IconGroupManager_CreateModule(moduletype,icongroup)
		module=modulesbase[max+1]
	end
	--
	module:SetParent(icon)
	--
	module:ClearAllPoints()
	local anchordata=setting.AnchorData
	module:SetPoint(anchordata.From,icon,anchordata.To,anchordata.OffsetX,anchordata.OffsetY)
	--
	if(moduletype=="Icon")then
		module:SetWidth(setting.Width)
		module:SetHeight(setting.Height)
		module.Texture:SetTexture(NPA_SpellInfo_GetSpellInfo(data.Spellid).Icon)
		module.UpdateFunc=nil
	elseif(moduletype=="Texture")then
		module:SetWidth(setting.Width)
		module:SetHeight(setting.Height)
		NPA_TextureManager_ManageTexture2(module.Texture,setting.ProfileName)
		if(setting.ColorMode==1)then
			local color=NPA_Color_GetColorBySpellType(data.SpellType)
			module.Texture:SetVertexColor(color.R,color.G,color.B,color.A)
		end
		module.UpdateFunc=nil
	elseif(moduletype=="Text")then
		NPA_FontManager_ManageFont2(module.Text,setting)
		NPA_FontManager_SetText(module.Text,NPA_SpellInfo_GetSpellInfo(data.Spellid).Name)
		module:SetWidth(module.Text:GetWidth())
		module:SetHeight(module.Text:GetHeight())
		if(setting.ColorMode==1)then
			local color=NPA_Color_GetColorBySpellType(data.SpellType)
			module.Text:SetTextColor(color.R,color.G,color.B,color.A)
		end
		module.UpdateFunc=nil
	elseif(moduletype=="Number")then
		NPA_NumberManager_ManageNumber(module,setting)
		NPA_NumberManager_SetNumber(module,0,0)
		--check data type
		if(setting.DataType=="Time")then
			module.UpdateFunc=NPA_IconGroupManager_NumberUpdateFunc
		elseif(setting.DataType=="Stack")then
			if(icongroup.DivideCount)then
				--real time update
				module.UpdateFunc=NPA_IconGroupManager_CountUpdateFunc
			elseif(data.Count and data.Count>1)then
			--set stack
				local count=data.Count
				local maxstack=data.MaxStack
				if(not maxstack or maxstack<count)then
					maxstack=count
				end
				NPA_NumberManager_SetNumber(module,count,maxstack)
				module.UpdateFunc=nil
			else
				--hidden
				module.UpdateFunc=nil
				module:Hide()
				return module
			end
		else
			module.UpdateFunc=nil
		end
		if(setting.ColorMode==1)then
			local color=NPA_Color_GetColorBySpellType(data.SpellType)
			NPA_NumberManager_SetNumberColor(module,color)
		end
	elseif(moduletype=="BarGroup")then
		NPA_BarManager_ManageBarGroup(module,setting)
		--check data type
		if(setting.DataType=="Time")then
			module.UpdateFunc=NPA_IconGroupManager_BarGroupUpdateFunc
		elseif(setting.DataType=="Stack")then
			if(icongroup.DivideCount)then
				--real time update
				module.UpdateFunc=NPA_IconGroupManager_BarCountUpdateFunc
			elseif(data.Count and data.Count>1)then
				--set stack
				local count=data.Count
				local maxstack=data.MaxStack
				if(not maxstack or maxstack<count)then
					maxstack=count
				end
				NPA_BarManager_SetBarGroup(module,count/maxstack)
				module.UpdateFunc=nil
			else
				--hidden
				module.UpdateFunc=nil
				module:Hide()
				return module
			end
		else
			module.UpdateFunc=nil
		end
		if(setting.ColorMode==1)then
			local color=NPA_Color_GetColorBySpellType(data.SpellType)
			NPA_BarManager_SetBarGroupColor(module,color)
		end
	elseif(moduletype=="ExtraInfo")then
		NPA_FontManager_ManageFont2(module.Text,setting)
		NPA_FontManager_SetText(module.Text,data.ExtraInfo)
		module:SetWidth(module.Text:GetWidth())
		module:SetHeight(module.Text:GetHeight())
		if(setting.ColorMode==1)then
			local color=NPA_Color_GetColorBySpellType(data.SpellType)
			module.Text:SetTextColor(color.R,color.G,color.B,color.A)
		end
		module.UpdateFunc=nil
	end
	--set module
	module:SetScale(setting.Scale)
	module:SetAlpha(setting.Alpha)
	module:SetFrameLevel(setting.FrameLevel+module:GetParent():GetFrameLevel())
	--
	module:Show()
	--
	return module
end
--
local NPA_IconGroupManager_SetIcon=function(icon,icongroup,settings,data)
	icon:SetWidth(settings.Width)
	icon:SetHeight(settings.Height)
	icon:SetScale(settings.Scale)
	icon:SetAlpha(settings.Alpha)
	icon:SetFrameLevel(settings.FrameLevel+icon:GetParent():GetFrameLevel())
	--
	local modules
	if(not icon.Modules)then
		--create new
		icon.Modules={}
		modules=icon.Modules
	else
		--clear old
		modules=icon.Modules
		for index,_ in pairs(modules)do
			modules[index]=nil
		end
	end
	--set module
	local modulesbase=icongroup.Modules
	local i=1
	for _,setting in pairs(settings.Modules)do
		modules[i]=NPA_IconGroupManager_AddModule(icon,modulesbase,setting,data,icongroup)
		i=i+1
	end
end
--
local CheckRelatedSpell = function(spellrelateddata,spellidlist)
	--if no related data return true directly
	if(not spellrelateddata)then
		return true
	end
	--check all spell in related list, make sure they're all in spell id list
	for spellid,_ in pairs(spellrelateddata)do
		if(spellidlist[spellid]~=true)then
			return false
		end
	end
	return true
end
--update group display
NPA.IconGroupManager.UpdateGroup=function(icongroup)
	--sort priority
	local nTime=NPA_GetTime()
	local iconlist={}
	--spell id check list
	local spellidlist={}
	local spellcheckiconlist={}
	local updatelist=icongroup.UpdateList
	--build up checklist
	local i=1
	for index,data in pairs(icongroup.DataList)do
		if(data.Spellid)then
			spellcheckiconlist[i]=data
			spellidlist[data.Spellid]=true	--save in check list
			i=i+1
		else
			updatelist[index]=nil	--be sure to remove old update data
		end
	end
	--build stopped/related data
	local spellstopeddata={}
	local spellrelateddata={}
	for index,data in pairs(spellcheckiconlist)do
		local affactlist=NPA_SpellInfo_GetSpellInfo(data.Spellid).AffectSpellList
		if(affactlist)then
			for aspellid,aspellinfo in pairs(affactlist)do
				if(aspellinfo.AffectType==4)then
					spellstopeddata[aspellid]=true
				elseif(aspellinfo.AffectType==5)then
					if(not spellrelateddata[index])then
						spellrelateddata[index]={}
					end
					spellrelateddata[index][aspellid]=true
				end
			end
		end
	end
	--
	i=1
	--build up showing data
	for index, data in pairs(spellcheckiconlist)do
		--when not stopped, or not in related spelllist, or related spell exists
		if(spellstopeddata[data.Spellid]~=true and CheckRelatedSpell(spellrelateddata[index], spellidlist) ==true)then
			updatelist[index]=data
			local thestack=data.Count or 0
			if((icongroup.TimeLimit==0 or (data.EndTime-nTime)<icongroup.TimeLimit) and
				(icongroup.StackMin<=thestack and icongroup.StackMax>=thestack)
				)then	--time in range, add to iconlist

				iconlist[i]=data
				i=i+1
			end
		else --it's either suppressed or related, remove it from the list
			updatelist[index]=nil
		end
	end
	--
	table_sort(iconlist,function(a,b)
		--sort by priority and end time
		if(a.Priority~=b.Priority)then
			--priority from large to small
			return a.Priority>b.Priority
		else
			--tme from small to large
			return a.EndTime<b.EndTime
		end
	end)
	--set icons
	local max=icongroup.Max
	local count=table_getn(iconlist)
	local icons=icongroup.Icons
	--
	if(count<1)then
		--nothing to show
		--hide all icon and set width and height to 1
		--hide unused icons
		for i=1,table_getn(icons)do
			icons[i]:Hide()
		end
		icongroup:SetWidth(1)
		icongroup:SetHeight(1)
		--still show it because there may be something waitting to be shown
		icongroup:Show()
		return
	end
	--
	if(max>count)then
		max=count
	end
	icongroup.CurrentIconCount=count
	--hide modules
	for _,module in pairs(icongroup.Modules)do
		module:Hide()
	end
	--
	local offsety=0
	local offsetx=0
	local rowheight=0
	local rowwidth=0
	local perrow=icongroup.PerRow
	--anchor and direction
	local directioninfo=NPA_IconGroupManager_DirectionList[icongroup.Direction]
	local anchor=directioninfo.Anchor
	local tanchor=directioninfo.TAnchor
	local dirx=directioninfo.DirX
	local diry=directioninfo.DirY
	local gapx=icongroup.GapX
	local gapy=icongroup.GapY
	--
	--grow left/right then up/down
	if(icongroup.Direction<5)then
		for i=1,max do
			if(not icons[i])then
				icons[i]=NPA_IconGroupManager_CreateIconFrame(icongroup)
			end
			local icon=icons[i]
			local data=iconlist[i]
			local setting=data.Setting
			--set data
			data.Showing=icon
			icon.Data=data
			--
			local height=setting.Height*setting.Scale+gapy
			local width=setting.Width*setting.Scale+gapx
			--clear points
			icon:ClearAllPoints()
			--
			if(perrow==1 or mod(i,perrow)==1)then --the first one of every row
				--caculate row width and height
				if(rowwidth>offsetx)then
					offsetx=rowwidth
				end
				offsety=offsety+rowheight
				rowwidth=width
				rowheight=height
				--set point
				icon:SetPoint(anchor,icongroup,anchor,gapx*dirx,(offsety+gapy)*diry)
			else
				--caculate row width and height
				if(height>rowheight)then
					rowheight=height
				end
				rowwidth=rowwidth+width
				--set point
				icon:SetPoint(anchor,icons[i-1],tanchor,gapx*dirx,0)
			end
			--set icon
			NPA_IconGroupManager_SetIcon(icon,icongroup,setting,data)
			icon:Show()
		end
		--add the current row
		offsety=offsety+rowheight
	else
		--grow up/down then left/right
		for i=1,max do
			if(not icons[i])then
				icons[i]=NPA_IconGroupManager_CreateIconFrame(icongroup)
			end
			local icon=icons[i]
			local data=iconlist[i]
			local setting=data.Setting
			--
			data.Showing=icon
			icon.Data=data
			--
			local height=setting.Height*setting.Scale+gapy
			local width=setting.Width*setting.Scale+gapx
			--clear points
			icon:ClearAllPoints()
			--
			if(mod(i,perrow)==1)then --the first one of every row
				--caculate row width and height
				if(rowheight>offsety)then
					offsety=rowheight
				end
				offsetx=offsetx+rowwidth
				rowwidth=width
				rowheight=height
				--set point
				icon:SetPoint(anchor,icongroup,anchor,(offsetx+gapx)*dirx,gapy*diry)
			else
				--caculate row width and height
				if(width>rowwidth)then
					rowwidth=width
				end
				rowheight=rowheight+height
				--set point
				icon:SetPoint(anchor,icons[i-1],tanchor,0,gapy)
			end
			--set icon
			NPA_IconGroupManager_SetIcon(icon,icongroup,setting,data)
			icon:Show()
			--
		end
		--add the current row
		offsetx=offsetx+rowwidth
	end
	--hide unused icons
	for i=max+1,table_getn(icons)do
		icons[i]:Hide()
	end
	--
	if(offsetx<rowwidth)then
		offsetx=rowwidth
	end
	if(offsety<rowheight)then
		offsety=rowheight
	end
	--
	icongroup:SetWidth(offsetx)
	icongroup:SetHeight(offsety)
	icongroup.Ziped=nil
	icongroup:Show()
end
--add a new icon
NPA.IconGroupManager.InsertIcon=function(icongroup,starttime,endtime,spellid,spelltype,count,maxstack,iconsetting,extrainfo)
	--
	local datalist=icongroup.DataList
	--
	local max=table_getn(datalist)
	for i=1,max do
		local data=datalist[i]
		--reuse old one to save resources
		--check spellid
		if(data.Spellid==nil)then
			data.Spellid=spellid
			data.StartTime=starttime
			data.EndTime=endtime
			data.Setting=iconsetting
			data.Showing=nil
			data.SpellType=spelltype
			data.Count=count
			data.MaxStack=maxstack or 1
			--also caculate length 
			data.Length=endtime-starttime
			--extra info
			data.ExtraInfo=extrainfo
			return
		elseif(data.StartTime==starttime and data.EndTime==endtime and data.Spellid==spellid)then
			--if these match then it's the same one, do nothing then return
			return
		end
	end
	--all used up ,add a new one
	datalist[max+1]={
		Spellid=spellid,
		StartTime=starttime,
		EndTime=endtime,
		Setting=iconsetting,
		Showing=nil,
		SpellType=spelltype,
		Count=count,
		MaxStack=maxstack or 1,
		Length=endtime-starttime,
		ExtraInfo=extrainfo
	}
end
--
local NPA_IconGroupManager_UpdateGroup=NPA.IconGroupManager.UpdateGroup
--
NPA.IconGroupManager.ManageIconGroup=function(icongroup,groupsetting)
	icongroup.Direction=groupsetting.Direction
	icongroup.PerRow=groupsetting.PerRow
	icongroup.Max=groupsetting.Max
	icongroup.CurrentIconCount=0
	icongroup.TimeLimit=groupsetting.TimeLimit
	icongroup.StackMin=groupsetting.StackMin
	icongroup.StackMax=groupsetting.StackMax
	icongroup.GapX=groupsetting.GapX
	icongroup.GapY=groupsetting.GapY
	NPA_IconGroupManager_UpdateGroup(icongroup)
end
--
NPA.IconGroupManager.ClearIconGroup=function(icongroup)
	--reuse old ones
	local datalist=icongroup.DataList
	for i=1,table_getn(datalist)do
		datalist[i].Spellid=nil --remove spellid to set it unused
	end
	local icons=icongroup.Icons
	for i=1,table_getn(icongroup.Icons)do
		icons[i]:Hide()
	end
	--clear modules
	local modules=icongroup.Modules
	for i=1,table_getn(modules)do
		modules[i]:Hide()
	end
end
--on hide,set width and height to 1
local NPA_IconGroupManager_GroupOnHide=function(icongroup)
	icongroup:SetWidth(1)
	icongroup:SetHeight(1)
end
--onupdate check icon timer
local NPA_IconGroupManager_GroupOnUpdate=function(icongroup)
	local nTime=NPA_GetTime()
	local update=false
	local datalist=icongroup.UpdateList
	local limit=icongroup.TimeLimit
	for _,data in pairs(datalist)do
		if(data.Spellid)then --if no spellid then not used
			local length=data.EndTime-nTime
			if(length<0)then
				data.Spellid=nil
				update=true
			elseif(data.Showing==nil)then
				if(length<limit and icongroup.CurrentIconCount<icongroup.Max)then
					--check not showing but in time limit
					update=true
				end
			else
				--update number/bar
				if(icongroup.DivideCount==true and data.Count and data.Count>1)then
					--recaculate count
					local spellinfo=NPA_SpellInfo_GetSpellInfo(data.Spellid)
					local cdlength=spellinfo.CoolDown
					local alength=length%cdlength
					local count=floor(length/cdlength)+1
					--
					--update timer text
					for _,module in pairs(data.Showing.Modules)do
						NPA_RunFunc(module.UpdateFunc,module,alength,cdlength,count,data.Spellid,data.MaxStack)
					end
				else
					local dlength=data.Length
					--update timer text
					for _,module in pairs(data.Showing.Modules)do
						NPA_RunFunc(module.UpdateFunc,module,length,dlength,1,data.Spellid)
					end
				end
			end
		end
	end
	--only update once,this should save some resources
	if(update==true)then
		NPA_IconGroupManager_UpdateGroup(icongroup)
	end
end
--
NPA.IconGroupManager.CreateIconGroup=function(mainframe)
	local icongroup=CreateFrame("Frame",nil,mainframe)
	--icongroup:SetPoint("CENTER",mainframe,"CENTER",0,0)
	icongroup:EnableMouse(false)
	--
	icongroup.DataList={}
	icongroup.UpdateList={}
	icongroup.Icons={}
	icongroup.Modules={}
	--
	icongroup:SetScript("OnUpdate",NPA_IconGroupManager_GroupOnUpdate)
	icongroup:SetScript("OnHide",NPA_IconGroupManager_GroupOnHide)
	--
	return icongroup
end
