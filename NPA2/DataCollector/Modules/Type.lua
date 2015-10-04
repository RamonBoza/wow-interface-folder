-- Author      : Nogarder
-- Create Date : 2012/9/7 15:38:35
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Type",
	function()
		--main --using local for speed
		local floor=floor
		local abs=abs
		local tonumber=tonumber
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		--class by collect unit
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_Type",function(unit,unitdata)
			-- only fire if class is different
			--data. nil=don't change, 1=player,2=npc, 3=pet, 4=guardian
			local faction,atype,class
			if(UnitIsPlayer(unit))then
				atype=1
			else
				atype=nil
			end
			--local classname,classmark=UnitClass(unit)
			_,class=UnitClass(unit)
			--faction, 1=friendly,2=neutral,3=hostile
			if(UnitIsFriend(unit,"player"))then
				faction=1
			elseif(UnitIsEnemy(unit,"player"))then
				faction=3
			else
				faction=2
			end
			--
			if(unitdata.Class~=class or (unitdata.Type==nil and atype~=nil) or unitdata.Faction~=faction)then
				unitdata.Type=unitdata.Type or atype
				unitdata.Class=class
				unitdata.Faction=faction
				--placeholder, don't use it now
				--fire class change event
				NPA_EventHandler_FireEvent(7,"Type_Updated",unitdata)
			end
		end)
		--class by frame default
		--check type
		local NPA_Type_ColorToClass={}
		--generate color table from blizzard default color table
		for class,color in pairs(RAID_CLASS_COLORS) do
			NPA_Type_ColorToClass[class]={
				R=color.r*100,
				G=color.g*100,
				B=color.b*100
			}
		end
		--check nameplate type with healthbar color
		-- type, classname, istotem
		--local faction,class,type=NPA_Type_GetInfoByFrameData(framedata)
		--faction, 1=friendly,2=neutral,3=hostile
		--class, the class name or totem name , nil=unknow
		--type, nil=don't change, 1=player,2=npc, 3=pet, 4=guardian

		local NPA_Type_GetInfoByFrameColor=function(r,g,b,framedata)
			--check with color
			---green, blue, yellow are non-hostile
			if(r<0.1 and g>0.9 and b<0.1)then -- green is friendly npc
				return 1,nil,nil
			elseif(r<0.1 and g<0.1 and b>0.9)then --- blue is friendly player 
				return 1,nil,1-- can't get their class without unitdata, handle it after aquired GUID
			elseif(r>0.9 and g>0.9 and b<0.1)then --- yellow is netural npc or player -- handle it after aquired GUID
				return 2,nil,nil --check if totem
			elseif(r>0.9 and g<0.1 and b<0.1)then -- red is hostile npc
				return 3,nil,nil
			--r>0.5 and g>0.5 and b>0.5 -- grey is tapped hostile/neutral
			else
				-- hostile players, try to get class with color,+1 to prevent divide zero
				local r=floor(r*100)+1
				local g=floor(g*100)+1
				local b=floor(b*100)+1
				for class,color in pairs(NPA_Type_ColorToClass)do
					-- it's always a little bit off, so allow 10% miss
					if(abs(r-color.R)<10 and abs(g-color.G)<10 and abs(b-color.B)<10)then
						return 3,class,1
					end
				end
				--unknow unit
				return 3,nil,nil
			end
		end
		--update basic data
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnUpdate","DataCollector_Type",function(framedata)
			local unitdata=framedata.DefaultUnitData
			local r,g,b=framedata.Default.HealthBar:GetStatusBarColor()
			if(r~=unitdata.R or g~=unitdata.G or b~=unitdata.B)then
				unitdata.R=r
				unitdata.G=g
				unitdata.B=b
				--get type data
				local faction,class,atype=NPA_Type_GetInfoByFrameColor(r,g,b,framedata)
				unitdata.Faction=faction or unitdata.Faction
				unitdata.Class=class or unitdata.Class
				unitdata.Type=unitdata.Type or atype
				--fire type change event
				NPA_EventHandler_FireEvent(8,"Type_Updated",framedata)
			end
		end)
		--advanced type
		--dont use it 
		--cost resources
		if(NPA_Setting.Core.AdvancedType)then
			local NPA_InfoFromFlag_GetType=NPA.InfoFromFlag.GetType
			local CheckFlag=function(unitdata,flag)
				if(not flag)then
					return
				end

				local faction,atype=NPA_InfoFromFlag_GetType(flag)

				if(unitdata.Faction~=faction or unitdata.Type~=atype)then
					unitdata.Faction=faction
					unitdata.Type=atype
					NPA_EventHandler_FireEvent(7,"Type_Updated",unitdata,name)
				end
			end
			
			NPA.DataCollector.RegisterCombatLogEvent("Any","DataCollector_Type",function(arg,sourceunitdata,destunitdata)
				--[1]=timestamp
				--[2]=event
				--[3]=hidecaster
				--[4]=sourceGUID
				--[5]=srouceName
				--[6]=sourceFlags
				--[7]=sourceFlags2 raidflag
				--[8]=destGUID
				--[9]=destName
				--[10]=destFlags
				--[11]=destFlags2 raidflag
				--[12]=spellid
				--[13]=spellname
				--[14]=spellschool
				--[15]=auratype (Buff/Debuff)
				--[16]=amount
				CheckFlag(sourceunitdata,arg[6])
				CheckFlag(destunitdata,arg[10])
			end)
		else
			NPA.DataCollector.RegisterCombatLogEvent("Any","DataCollector_Type",nil)
		end
	end,
	--------
	function()
		-------unregister all events
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectUnit","DataCollector_Type",nil)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnUpdate","DataCollector_Type",nil)
		NPA.DataCollector.RegisterCombatLogEvent("Any","DataCollector_Type",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function(unitdata,frameunitdata)
		--use frame-based first as faction may change (like Mind-Controll)
		--this may cause some problem and i don't know why
		unitdata.Faction=unitdata.Faction or frameunitdata.Faction
		--use guid-based before frame-based ,as type and class won't change
		unitdata.Type=unitdata.Type or frameunitdata.Type
		unitdata.Class=unitdata.Class or frameunitdata.Class
	end,
	--data clear function
	function(unitdata)
		unitdata.R=nil
		unitdata.G=nil
		unitdata.B=nil
		unitdata.Class=nil
		unitdata.Type=nil
		unitdata.Faction=nil
	end
	)
