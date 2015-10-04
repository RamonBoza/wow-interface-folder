-- Author      : Nogarder
-- Create Date : 2013/4/7 12:57:04
--register initialize function
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.DataCollector.RegisterModule("Quest",
	function()
		local getglobal=getglobal
		local string_gmatch=string.gmatch
		local tonumber=tonumber
		local string_find=string.find
		local pairs=pairs
		local string_split=string.split
		local table_getn=table.getn
		local UnitName=UnitName
		local next=next
		--global 
		--main --using local for speed
		local NPA_EventHandler_FireEvent=NPA.EventHandler.FireEvent
		local NPA_NamePlate_GetFrameData=NPA.NamePlate.GetFrameData
		--
		local NPA_DataCollector_QuestData={}
		local NPA_DataCollector_QuestDataCount=0
		local NPA_DataCollector_NameToQuest={}

		--swap=NPA_DataCollector_QuestData
		--swap2=NPA_DataCollector_NameToQuest

		local FireUpdateEvent=function(framedata)
			local name=framedata.Name
			if(name==nil)then
				return
			end
			--using name to quest list
			framedata.QuestData=NPA_DataCollector_NameToQuest[name]
			NPA_EventHandler_FireEvent(8,"Quest_Updated",framedata)
		end
		local CheckEveryFrame=function()
			for frame,framedata in pairs(NPA_NamePlate_GetFrameData())do
				if(frame:IsShown())then
					FireUpdateEvent(framedata)
				end
			end
		end
		--
		--build data when quest log updated
		NPA.EventHandler.RegisterEvent(0,"QUEST_LOG_UPDATE","DataCollector_Quest",function()
			--build quest data from quest log
			NPA_DataCollector_QuestDataCount=0
			local numQuests=GetNumQuestLogEntries()
			--
			for index=1,numQuests do 
				--local questLogTitleText, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily = GetQuestLogTitle(questID)
				local title,level,_,_,isHeader,_,isComplete=GetQuestLogTitle(index)
				if((not isHeader) and title)then--is quest entry
					local numobj=GetNumQuestLeaderBoards(index)
					if(numobj>0)then
						--split quest id, it's unique
						local _,questid=string_split(":",GetQuestLink(index),3)
						--
						for objid=1,numobj do
							local text=GetQuestLogLeaderBoard(objid,index) or ""
							for current,max in string_gmatch(text,"(%d+)/(%d+)") do
								if(tonumber(current)<tonumber(max))then
									NPA_DataCollector_QuestDataCount=NPA_DataCollector_QuestDataCount+1
									if(not NPA_DataCollector_QuestData[NPA_DataCollector_QuestDataCount])then
										NPA_DataCollector_QuestData[NPA_DataCollector_QuestDataCount]={}
									end
									local questdata=NPA_DataCollector_QuestData[NPA_DataCollector_QuestDataCount]
									questdata.Item=text or ""
									questdata.Current=tonumber(current)
									questdata.Max=tonumber(max)
									questdata.Name=title or ""
									questdata.Level=level
									questdata.QuestID=questid
								end
							end
						end
					end
				end
			end
			--clear unused name-to-quest data
			--build a quest id list
			local questidlist={}
			for i=1,NPA_DataCollector_QuestDataCount do
				questidlist[NPA_DataCollector_QuestData[i].QuestID]=true
			end
			
			for name,quest in pairs(NPA_DataCollector_NameToQuest)do
				if(questidlist[quest.QuestID]~=true or quest.Current==quest.Max or (not quest.Current) or (not quest.Max))then
					NPA_DataCollector_NameToQuest[name]=nil
				end
			end

--			print("debug quest count")
--			print(NPA_DataCollector_QuestDataCount)

			--fire event
			CheckEveryFrame()
		end)
		NPA.EventHandler.RegisterEvent(2,"DataCollector_TooltipsUpdated","DataCollector_Quest",function(unit,lines)
			--detect quest entry changes
			local name=UnitName(unit)
			if(not name)then
				return
			end
			--find or create name-to-quest match
			local nametoquest
			local list
			--
			local updated
			--search every line
			local currentcount
			local currentquest

			for _,line in pairs(lines)do
				if(line:IsShown())then
					local text=line:GetText()
					if(text)then
						_,_,text1,text2=string_split(" ",text,5)
						if(text1 and text2)then
							local checktext
							if(string_find(text1,"/"))then
								checktext=text2
							elseif(string_find(text2,"/"))then
								checktext=text1
							end
							if(checktext)then
								---check name to quest
								--find out the best quest to show
								for i=1,NPA_DataCollector_QuestDataCount do
									local questdata=NPA_DataCollector_QuestData[i]
									if(string_find(questdata.Item,checktext))then
										local count=questdata.Max-questdata.Current
										if(count>0 and (currentcount==nil or count<currentcount))then
											currentquest=questdata
											currentcount=count
										end
									end
								end
							end
						end
					end
				end
			end

			if(NPA_DataCollector_NameToQuest[name]~=currentquest)then
				updated=true
				NPA_DataCollector_NameToQuest[name]=currentquest
			end

			--fire event when data changes
			if(updated)then
				CheckEveryFrame()
			end
		end)
		--fire update when name changes
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnShow","DataCollector_Quest",FireUpdateEvent)
		--NPA.EventHandler.RegisterEvent(8,"Name_Updated","DataCollector_Quest",FireUpdateEvent)
	end,
	--------
	function()
		-------unregister all events
		NPA.EventHandler.RegisterEvent(0,"QUEST_LOG_UPDATE","DataCollector_Quest",nil)
		NPA.EventHandler.RegisterEvent(2,"DataCollector_TooltipsUpdated","DataCollector_Quest",nil)
		NPA.EventHandler.RegisterEvent(1,"NamePlate_DefaultMain_OnShow","DataCollector_Quest",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function(unitdata,frameunitdata)
		--do nothing
	end
	)
