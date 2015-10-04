-- Author      : Nogarder
-- Create Date : 2013/12/11 17:57:57
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Role",
	function()
		local string_split=string.split
		--cache up talent to role
		local TalentToRole={}
		for i=1,11 do
			for j=1,4 do --1-3 for other class and 1-4 for druid
				--id, localized spec name, description, icon, ??, unlocalized role = GetSpecializationInfoForClassID(classindex,specindex)
				local _,name,_,_,_,role= GetSpecializationInfoForClassID(i,j)
				if(name)then
					TalentToRole[name]=role
				end
			end
		end
		--global 
		local UnitGroupRolesAssigned=UnitGroupRolesAssigned
		local NPA_DataCollector_GetUnitDataByGUID=NPA.DataCollector.GetUnitDataByGUID
		local NPA_FrameToGUID_GetPlayerNameToGUID=NPA.FrameToGUID.GetPlayerNameToGUID
		--main --using local for speed
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		-------on collector collect_unit event
		--unit,unitdata
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectGroup","DataCollector_Role",function()
			for i=1,40 do
				local unit="raid"..i
				local role=UnitGroupRolesAssigned(unit)
				local unitdata=NPA_DataCollector_GetUnitDataByGUID(UnitGUID(unit))
				if(unitdata and unitdata.Role~=role)then
					unitdata.Role=role
					NPA_EventHandler_FireEvent(7,"Role_Updated",unitdata)
				end
			end
		end)
		NPA.EventHandler.RegisterEvent(0,"UPDATE_BATTLEFIELD_SCORE","DataCollector_Role",function()
			for i=1, GetNumBattlefieldScores() do
				--name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, healingDone, bgRating, ratingChange, preMatchMMR, mmrChange, talentSpec = GetBattlefieldScore(index)
				--local name, _, _, _, _, _, _, _, classToken, damageDone, healingDone,_,_,_,_,spec= GetBattlefieldScore(i)
				local name, _, _, _, _, _, _, _, _, _, _,_,_,_,_,spec= GetBattlefieldScore(i)
				if(name)then
					name=string_split("-",name)
					local guid=NPA_FrameToGUID_GetPlayerNameToGUID(name)
					local unitdata=NPA_DataCollector_GetUnitDataByGUID(guid)
					if(unitdata)then
						local role=TalentToRole[spec] or "NONE"
						if(role~=unitdata.Role)then
							unitdata.Role=role
							NPA_EventHandler_FireEvent(7,"Role_Updated",unitdata)
						end
					end
				end
			end
		end)
		local updateTimer=0
		local updateInterval=10 --update, by seconds		
		NPA.EventHandler.RegisterEvent(2,"DataCollector_PlayerEnteringWorld","DataCollector_Role",function(instance)
			if(instance==2 or instance==3)then
				NPA.EventHandler.RegisterEvent(3,"NPA_MainFrame_OnUpdate","DataCollector_Role",function(elapse)
					updateTimer=updateTimer+elapse
					if(updateTimer>updateInterval)then
						updateTimer=0
						RequestBattlefieldScoreData()
					end
				end)
			else
				NPA.EventHandler.RegisterEvent(3,"NPA_MainFrame_OnUpdate","DataCollector_Role",nil)
			end
		end)
	end,
	--------
	function()
		-------unregister all events
		NPA.EventHandler.RegisterEvent(2,"DataCollector_CollectGroup","DataCollector_Role",nil)
		NPA.EventHandler.RegisterEvent(0,"UPDATE_BATTLEFIELD_SCORE","DataCollector_Role",nil)
		NPA.EventHandler.RegisterEvent(3,"NPA_MainFrame_OnUpdate","DataCollector_Role",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function(unitdata,frameunitdata)
		--do nothing
	end
	)

