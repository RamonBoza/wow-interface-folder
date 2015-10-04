-- Author      : Nogarder
-- Create Date : 2012/3/16 18:32:11
-- get global functions for speed
local pairs = pairs
local table_getn=table.getn
local table_insert=table.insert
local type=type
local next=next
local tonumber=tonumber
--
local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
--version control
local NPA_SettingManager_Version="A2"
---main
--module list
local NPA_SettingManager_DefaultFunc={}
--frame to key list
local NPA_SettingManager_ElementList={}
--framedata to profile list
local NPA_SettingManager_FrameDataToProfile={}
--resource type list
local ResourcesList={}
--
local NPA_SettingManager_DefaultProfileFunc={}
--
--function for registering profile
NPA.SettingManager.RegisterDefault=function(name,func)
	NPA_SettingManager_DefaultFunc[name]=func
end
--macro for get default setting
NPA.SettingManager.GetDefault=function(name)
	local entry=NPA_SettingManager_DefaultFunc[name]()
	--remove placeholder strings for non-compare function
	local checklist={
		[1]=entry
	}
	while(next(checklist))do
		for index,data in pairs(checklist)do
			if(type(data)=="table")then
				data.CheckWithSubString=nil
				data.DontCheck=nil
				data.IndexIsNumber=nil
				for _,data2 in pairs(data)do
					if(type(data2)=="table")then
						table_insert(checklist,data2)
					end
				end
			end
			checklist[index]=nil
		end
	end
	--
	return entry
end
NPA.SettingManager.GetCompareDefault=function(name)
	return NPA_SettingManager_DefaultFunc[name]()
end
--macro, using for setting compression
NPA.SettingManager.GetAllCompareDefault=function()
	local out={}
	for name,func in pairs(NPA_SettingManager_DefaultFunc)do
		out[name]=func()
	end
	return out
end
--macro for setting entry
local NPA_SettingManager_CompareSettingEntry=function(entry1,entry2)
	local checklist={
		[1]={
			EntryA=entry1,
			EntryB=entry2}
	}
	while(next(checklist))do
		for index,data in pairs(checklist)do
			local entryA=data.EntryA
			local entryB=data.EntryB
			---check with substring
			if(entryB.CheckWithSubString)then
				--check group with one default
				for dname,dkey in pairs(entryA)do
					if(type(dkey)~="table")then
						entryA[dname]=nil
					else
						if(entryB.IndexIsNumber and type(dname)~="number")then
							entryA[tonumber(dname)]=dkey
							entryA[dname]=nil
						end
						table_insert(checklist,{EntryA=dkey,EntryB=entryB[entryB.CheckWithSubString]})
					end
				end
			elseif(entryB.DontCheck==true)then
				--don't check
				--do nothing
			else
				--for everyone in entry2, make sure there's on in entry1
				for name,key in pairs(entryB) do
					--
					if(entryA[name]==nil)then
						if(type(key)=="table")then
							entryA[name]=CopyTable(key)
						else
							entryA[name]=key
						end
					elseif(type(entryA[name])~=type(key))then
						if(type(key)=="table")then
							entryA[name]=CopyTable(key)
						elseif(type(key)=="number")then
							entryA[name]=tonumber(entryA[name])
						elseif(type(key)=="boolean")then
							local value=tonumber(entryA[name])
							if(value==0)then
								entryA[name]=false
							elseif(value==1)then
								entryA[name]=true
							end
						end
					elseif(type(key)=="table")then --table deep check
						table_insert(checklist,{EntryA=entryA[name],EntryB=key})
					end
				end
				--if there's not one in entry2, clear it from entry1
				for name,_ in pairs(entryA) do
					if(entryB[name]==nil)then
						entryA[name]=nil
					end
				end
			end
			--remove it from list after check
			checklist[index]=nil
		end
	end
end
--macro for check setting parts
--core
local NPA_SettingManager_CheckCoreSetting=function(npa_setting)
	if(not npa_setting.Core)then
		npa_setting.Core={}
	end
	local defaultcoresetting=NPA.SettingManager.GetCompareDefault("Core")
	NPA_SettingManager_CompareSettingEntry(npa_setting.Core,defaultcoresetting)
	return
end
--nameplate
local NPA_SettingManager_CheckNamePlateSetting=function(npa_setting)
	--main entry
	if(not npa_setting.NamePlate)then
		npa_setting.NamePlate={
			["Default"]={
				TextSetting={},
				IconSetting={},
				IconGroupSetting={},
				BarGroupSetting={},
				TextureGroupSetting={},
				NumberSetting={},
				AlphaSetting={},
				ScaleSetting={},
				OffsetSetting={},
				FrameLevelSetting={},
				DefaultSetting=NPA.SettingManager.GetDefault("NamePlateDefault")
			}
		}
		return
	end
	--build check list
	local nameplatechecklist=	{
		CheckWithSubString="1",
		["1"]={
			TextSetting={
				CheckWithSubString="1",
				["1"]=NPA.SettingManager.GetCompareDefault("NamePlateText"),
			},
			IconSetting={
				CheckWithSubString="1",
				["1"]=NPA.SettingManager.GetCompareDefault("NamePlateIcon"),
			},
			IconGroupSetting={
				CheckWithSubString="1",
				["1"]=NPA.SettingManager.GetCompareDefault("NamePlateIconGroup"),
			},
			BarGroupSetting={
				CheckWithSubString="1",
				["1"]=NPA.SettingManager.GetCompareDefault("NamePlateBarGroup"),
			},
			TextureGroupSetting={
				CheckWithSubString="1",
				["1"]=NPA.SettingManager.GetCompareDefault("NamePlateTextureGroup"),
			},
			NumberSetting={
				CheckWithSubString="1",
				["1"]=NPA.SettingManager.GetCompareDefault("NamePlateNumber"),
			},
			AlphaSetting={
				CheckWithSubString="1",
				["1"]=NPA.SettingManager.GetCompareDefault("NamePlateAlpha"),
			},
			ScaleSetting={
				CheckWithSubString="1",
				["1"]=NPA.SettingManager.GetCompareDefault("NamePlateScale"),
			},
			OffsetSetting={
				CheckWithSubString="1",
				["1"]=NPA.SettingManager.GetCompareDefault("NamePlateOffset"),
			},
			FrameLevelSetting={
				CheckWithSubString="1",
				["1"]=NPA.SettingManager.GetCompareDefault("NamePlateFrameLevel"),
			},
			DefaultSetting=NPA.SettingManager.GetCompareDefault("NamePlateDefault")
		}
	}
	--
	NPA_SettingManager_CompareSettingEntry(npa_setting.NamePlate,nameplatechecklist)
	--must be a default
	if(not npa_setting.NamePlate["Default"])then
		npa_setting.NamePlate["Default"]={
			TextSetting={},
			IconSetting={},
			IconGroupSetting={},
			BarGroupSetting={},
			TextureGroupSetting={},
			NumberSetting={},
			AlphaSetting={},
			ScaleSetting={},
			OffsetSetting={},
			DefaultSetting=NPA.SettingManager.GetDefault("NamePlateDefault")
		}
	end
end
--target arrow
local NPA_SettingManager_CheckTargetArrowSetting=function(npa_setting)
	if(not npa_setting.TargetArrow)then
		npa_setting.TargetArrow={}
		return
	end
	--
	local checklist={
		CheckWithSubString="1",
		["1"]=NPA.SettingManager.GetCompareDefault("TargetArrow")
	}
	NPA_SettingManager_CompareSettingEntry(npa_setting.TargetArrow,checklist)
	--
	return
end
--extra arrow
local NPA_SettingManager_CheckExtraArrowSetting=function(npa_setting)
	if(not npa_setting.ExtraArrow)then
		npa_setting.ExtraArrow={}
		return
	end
	--
	local checklist={
		CheckWithSubString="1",
		["1"]=NPA.SettingManager.GetCompareDefault("ExtraArrow")
	}
	NPA_SettingManager_CompareSettingEntry(npa_setting.ExtraArrow,checklist)
	--
	return
end

--scrolltext
local NPA_SettingManager_CheckCombatTextSetting=function(npa_setting)
	if(not npa_setting.CombatText)then
		npa_setting.CombatText={Condition={},Animation={}}
		return
	end
	--checklist
	local checklist={
		Condition={
			CheckWithSubString="1",
			["1"]=NPA.SettingManager.GetCompareDefault("CombatTextCondition"),
		},
		Animation={
			CheckWithSubString="1",
			["1"]={
				CheckWithSubString="1",
				IndexIsNumber=true,
				["1"]=NPA.SettingManager.GetCompareDefault("CombatTextAnimation")
			}
		}
	}
	--
	NPA_SettingManager_CompareSettingEntry(npa_setting.CombatText,checklist)
	--
	return
end
--tracker
local NPA_SettingManager_CheckTrackerSetting=function(npa_setting)
	if(not npa_setting.Tracker)then
		npa_setting.Tracker={Condition={},Nameplates={}}
		return
	end
	--
	local checklist={
		Condition={
			CheckWithSubString="1",
			["1"]=NPA.SettingManager.GetCompareDefault("TrackerCondition")
		},
		Nameplates={
			CheckWithSubString="1",
			["1"]=NPA.SettingManager.GetCompareDefault("TrackerNameplates")
		}
	}
	NPA_SettingManager_CompareSettingEntry(npa_setting.Tracker,checklist)
	--
	return
end
--fonts
local NPA_SettingManager_CheckFontSetting=function(npa_setting)
	if(not npa_setting.Font)then
		npa_setting.Font={
			["Default"]=NPA.SettingManager.GetDefault("Font")
		}
		return
	end
	--checklist
	local checklist={
		CheckWithSubString="1",
		["1"]=NPA.SettingManager.GetCompareDefault("Font"),
	}
	--check
	NPA_SettingManager_CompareSettingEntry(npa_setting.Font,checklist)
	--there must be a default
	if(not npa_setting.Font["Default"])then
		npa_setting.Font["Default"]=NPA.SettingManager.GetDefault("Font")
	end
end
--textures
local NPA_SettingManager_CheckTextureSetting=function(npa_setting)
	if(not npa_setting.Texture)then
		npa_setting.Texture=NPA.SettingManager.GetDefault("Texture")
	else
		--checklist
		local checklist={
			CheckWithSubString="1",
			["1"]=NPA.SettingManager.GetCompareDefault("Texture")["Default"],
		}
		--check when exists
		NPA_SettingManager_CompareSettingEntry(npa_setting.Texture,checklist)
		--there must be those default values
		for name,texturesetting in pairs(NPA.SettingManager.GetCompareDefault("Texture"))do
			if(not npa_setting.Texture[name])then
				npa_setting.Texture[name]=texturesetting
			end
		end
	end
	--animated texture
	if(not npa_setting.AnimatedTexture)then
		npa_setting.AnimatedTexture={}
	else
		--checklist
		local checklist={
			CheckWithSubString="1",
			["1"]={
				CheckWithSubString="1",
				IndexIsNumber=true,
				["1"]=NPA.SettingManager.GetCompareDefault("AnimatedTexture")
			}
		}
		--check
		NPA_SettingManager_CompareSettingEntry(npa_setting.AnimatedTexture,checklist)
	end
end
	
--color
local NPA_SettingManager_CheckColorSetting=function(npa_setting)
	if(not npa_setting.Color)then
		npa_setting.Color=NPA.SettingManager.GetDefault("Color")
		return
	end
	--
	local defaultcolor=NPA.SettingManager.GetCompareDefault("Color")
	NPA_SettingManager_CompareSettingEntry(npa_setting.Color,defaultcolor)
end
--number
local NPA_SettingManager_CheckNumberSetting=function(npa_setting)
	if(not npa_setting.Number)then
		npa_setting.Number={["Default"]=NPA.SettingManager.GetDefault("Number")}
	end
	--
	local checklist={
		CheckWithSubString="1",
		["1"]=NPA.SettingManager.GetCompareDefault("Number"),
	}
	NPA_SettingManager_CompareSettingEntry(npa_setting.Number,checklist)
	--
	if(not npa_setting.Number["Default"])then
		npa_setting.Number["Default"]=NPA.SettingManager.GetDefault("Number")
	end
end
--bar group
local NPA_SettingManager_CheckBarGroupSetting=function(npa_setting)
	if(not npa_setting.BarGroup)then
		npa_setting.BarGroup={["Default"]=NPA.SettingManager.GetDefault("BarGroup")}
	end
	--
	local checklist={
		CheckWithSubString="1",
		["1"]=NPA.SettingManager.GetCompareDefault("BarGroup"),
	}
	NPA_SettingManager_CompareSettingEntry(npa_setting.BarGroup,checklist)
	--
	if(not npa_setting.BarGroup["Default"])then
		npa_setting.BarGroup["Default"]=NPA.SettingManager.GetDefault("BarGroup")
	end
end
--class group
local NPA_SettingManager_CheckClassSetting=function(npa_setting)
	if(not npa_setting.Class)then
		npa_setting.Class=NPA.SettingManager.GetDefault("Class")
		return
	end
	local defaultclass=NPA.SettingManager.GetCompareDefault("Class")
	NPA_SettingManager_CompareSettingEntry(npa_setting.Class,defaultclass)
end
--spell lib
local NPA_SettingManager_CheckSpellLibSetting=function(npa_setting)
	if(not npa_setting.SpellLib)then
		npa_setting.SpellLib={}
		return
	end
	--
	local checklist={
		CheckWithSubString="1",
		IndexIsNumber=true,
		["1"]=NPA.SettingManager.GetCompareDefault("Spell"),
	}
	NPA_SettingManager_CompareSettingEntry(npa_setting.SpellLib,checklist)
end
--raid target
local NPA_SettingManager_CheckRaidTargetSetting=function(npa_setting)
	if(not npa_setting.RaidTarget)then
		npa_setting.RaidTarget=NPA.SettingManager.GetDefault("RaidTarget")
		return
	end
	--
	local defaultraidtarget=NPA.SettingManager.GetCompareDefault("RaidTarget")
	NPA_SettingManager_CompareSettingEntry(npa_setting.RaidTarget,defaultraidtarget)
end
--role
local NPA_SettingManager_CheckRoleSetting=function(npa_setting)
	if(not npa_setting.Role)then
		npa_setting.Role=NPA.SettingManager.GetDefault("Role")
		return
	end
	--
	local defaultrole=NPA.SettingManager.GetCompareDefault("Role")
	NPA_SettingManager_CompareSettingEntry(npa_setting.Role,defaultrole)
end
--self lib
local NPA_SettingManager_CheckSelfLibSetting=function(npa_setting)
	if(not npa_setting.SelfLib)then
		npa_setting.SelfLib=NPA.SettingManager.GetDefault("SelfLib")
		return
	end
	--
	local defaultselflib=NPA.SettingManager.GetCompareDefault("SelfLib")
	NPA_SettingManager_CompareSettingEntry(npa_setting.SelfLib,defaultselflib)
end
--unit
local NPA_SettingManager_CheckUnitSetting=function(npa_setting)
	if(not npa_setting.Unit)then
		npa_setting.Unit=NPA.SettingManager.GetDefault("Unit")
		return
	end
	--
	local defaultunit=NPA.SettingManager.GetCompareDefault("Unit")
	NPA_SettingManager_CompareSettingEntry(npa_setting.Unit,defaultunit)
end
--
local NPA_SettingManager_CheckNamePlateCondition=function(npa_setting)
	if(not npa_setting.NamePlateCondition)then
		npa_setting.NamePlateCondition={
			[1]=	NPA.SettingManager.GetDefault("NamePlateCondition")
		}
		return
	end
	--
	local checklist={
		CheckWithSubString="1",
		IndexIsNumber=true,
		["1"]=NPA.SettingManager.GetCompareDefault("NamePlateCondition"),
	}
	NPA_SettingManager_CompareSettingEntry(npa_setting.NamePlateCondition,checklist)
	--
	--also turn all string condition into numeric
	for index,value in pairs(npa_setting.NamePlateCondition)do
		if(type(index)~="number")then
			npa_setting.NamePlateCondition[tonumber(index)]=value
			npa_setting.NamePlateCondition[index]=nil
		end
	end
end
--check existing profile with default
NPA.SettingManager.CheckSettingEntry=function(setting)
	--set it to default if not exists (or old
	if(not setting)then
		return
	end
	--
	local NPA_Setting_CheckList={
		["Number"]=true,
		["NamePlate"]=true,
		["SpellLib"]=true,
		["Color"]=true,
		["Class"]=true,
		["BarGroup"]=true,
		["TargetArrow"]=true,
		["ExtraArrow"]=true,
		["Core"]=true,
		["Font"]=true,
		["CombatText"]=true,
		["NamePlateCondition"]=true,
		["RaidTarget"]=true,
		["Texture"]=true,
		["AnimatedTexture"]=true,
		["Tracker"]=true,
		["SelfLib"]=true,
		["Role"]=true,
		["Unit"]=true,
	}
	for name,_ in pairs(setting)do
		if(NPA_Setting_CheckList[name]~=true)then
			setting[name]=nil
		end
	end
	--check settings parts with macro
	--core
	NPA_SettingManager_CheckCoreSetting(setting)
	--resources
	NPA_SettingManager_CheckFontSetting(setting)
	NPA_SettingManager_CheckTextureSetting(setting)
	NPA_SettingManager_CheckColorSetting(setting)
	NPA_SettingManager_CheckNumberSetting(setting)
	NPA_SettingManager_CheckBarGroupSetting(setting)
	NPA_SettingManager_CheckClassSetting(setting)
	NPA_SettingManager_CheckSpellLibSetting(setting)
	NPA_SettingManager_CheckRaidTargetSetting(setting)
	NPA_SettingManager_CheckRoleSetting(setting)
	NPA_SettingManager_CheckSelfLibSetting(setting)
	NPA_SettingManager_CheckUnitSetting(setting)
	--NamePlate apperance
	NPA_SettingManager_CheckNamePlateSetting(setting)
	--nameplate condition
	NPA_SettingManager_CheckNamePlateCondition(setting)
	--target arrow
	NPA_SettingManager_CheckTargetArrowSetting(setting)
	--extra arrow
	NPA_SettingManager_CheckExtraArrowSetting(setting)
	--combat text
	NPA_SettingManager_CheckCombatTextSetting(setting)
	--tracker text
	NPA_SettingManager_CheckTrackerSetting(setting)
end
--
local LoadDefaultProfiles=function()
	NPA_Profile=NPA_Profile or {}
	--
	for _,func in pairs(NPA_SettingManager_DefaultProfileFunc)do
		func(NPA_Profile)
	end
	--
	if(not NPA_Setting)then
		NPA_Setting=CopyTable(NPA_Profile["Default"] or {})
	end
end
--
local OnProfileLoaded=function()
	--check setting
	--load default profiles
	LoadDefaultProfiles()
	--check setting entry format ,for compatibility 
	NPA.SettingManager.CheckSettingEntry(NPA_Setting)
	--build resource list
	ResourcesList["BarGroup"]=NPA_Setting.BarGroup
	ResourcesList["Number"]=NPA_Setting.Number
	ResourcesList["Font"]=NPA_Setting.Font
	ResourcesList["Texture"]=NPA_Setting.Texture
	ResourcesList["AnimatedTexture"]=NPA_Setting.AnimatedTexture
	--fire on load event
	NPA.EventHandler.FireEvent(6,"SettingManager_SettingLoaded")
	--also fire a condition update event
	NPA.EventHandler.FireEvent(6,"NamePlate_ConditionUpdated")
	--also fire a targetarrow update event
	NPA.EventHandler.FireEvent(6,"TargetArrow_SettingUpdated")
	--also fire a extraarrow update event
	NPA.EventHandler.FireEvent(6,"ExtraArrow_SettingUpdated")
	--and combattext update event
	NPA.EventHandler.FireEvent(6,"CombatText_SettingUpdated")
	--and tracker update event
	NPA.EventHandler.FireEvent(6,"Tracker_SettingUpdated")
end
--profile on change event
NPA.EventHandler.RegisterEvent(6,"ProfileManager_ProfileLoaded","NPA_SettingManager",OnProfileLoaded)
--register variables onload event
NPA.EventHandler.RegisterEvent(0,"VARIABLES_LOADED","NPA_SettingManager",function()
	--unregister onload event
	NPA.EventHandler.RegisterEvent(0,"VARIABLES_LOADED","NPA_SettingManager",nil)
	--
	OnProfileLoaded()
end)
--macro for get resources data
NPA.SettingManager.GetResources=function(type,name)
	local entry=ResourcesList[type][name or "Default"]
	return entry or ResourcesList[type]["Default"]
end
--function for return profile
NPA.SettingManager.GetNamePlateProfileByName=function(name)
	return NPA_Setting.NamePlate[name or "Default"] or NPA_Setting.NamePlate["Default"]
end
--function for generating framegroup
NPA.SettingManager.GenerateFrameGroup=function(profilename)
	local profile=NPA.SettingManager.GetNamePlateProfileByName(profilename)
	local framegroup={}
	--text
	local textsetting=profile.TextSetting
	for name,_ in pairs(textsetting)do
		framegroup[name]=true
	end
	--texturegroup
	local texturegroupsetting=profile.TextureGroupSetting
	for name,entry in pairs(texturegroupsetting)do
		framegroup[name]=true
	end
	--icongroup
	--icon
	local iconsetting=profile.IconSetting
	for name,entry in pairs(iconsetting)do
		framegroup[name]=true
	end
	--bargroup
	local bargroupsetting=profile.BarGroupSetting
	for name,entry in pairs(bargroupsetting)do
		framegroup[name]=true
	end
	--number
	local numbersetting=profile.NumberSetting
	for name,entry in pairs(numbersetting)do
		framegroup[name]=true
	end
	return framegroup
end

NPA.SettingManager.RegisterDefaultProfileFunc=function(name,func)
	NPA_SettingManager_DefaultProfileFunc[name]=func
end
NPA.SettingManager.GetDefaultProfile=function(name)
	local profile={}
	NPA_SettingManager_DefaultProfileFunc[name](profile)
	return profile
end