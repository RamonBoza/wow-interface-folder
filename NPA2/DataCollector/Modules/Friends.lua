-- Author      : Nogarder
-- Create Date : 2013/11/3 10:08:53
--NPA.DataCollector.RegisterModule( datatype, initfunc, uninitfunc )
NPA.FriendsList={
	FriendList={},
	GuildList={},
	PartyList={},
	RaidList={},
	ArenaList={}
}
NPA.DataCollector.RegisterModule("Friends",
	function()
		--friendlist
		local FriendList=NPA.FriendsList.FriendList
		local GuildList=NPA.FriendsList.GuildList
		local PartyList=NPA.FriendsList.PartyList
		local RaidList=NPA.FriendsList.RaidList
		local ArenaList=NPA.FriendsList.ArenaList
		NPA.ClearTable(FriendList)
		NPA.ClearTable(GuildList)
		NPA.ClearTable(PartyList)
		NPA.ClearTable(RaidList)
		NPA.ClearTable(ArenaList)
		--
		local OnFriendListUpdate=function()
			NPA.ClearTable(FriendList)
			--numberOfFriends, onlineFriends = GetNumFriends()
			local num = GetNumFriends() or 0
			local myname=UnitName("player")
			for i=1,num do
				--name, level, class, area, connected, status, note = GetFriendInfo(friendIndex);
				local name,_,_,_,connected=GetFriendInfo(i)
				if(connected and name and name~=myname)then --only online friends
					FriendList[name]=true
				end
			end
		end
		NPA.EventHandler.RegisterEvent(0,"FRIENDLIST_UPDATE","DataCollector_Friends",OnFriendListUpdate)
		--
		local OnGuildListUpdate=function()
			NPA.ClearTable(GuildList)
			--numTotalMembers, numOnlineMembers = GetNumGuildMembers();
			local num = GetNumGuildMembers() or 0
			local myname=UnitName("player")
			for i=1,num do
				--name, rank, rankIndex, level, class, zone, note, 
				--officernote, online, status, classFileName, 
				--achievementPoints, achievementRank, isMobile = GetGuildRosterInfo(index);
				local name,_,_,_,_,_,_,_,online = GetGuildRosterInfo(i)
				if(online and name~=myname)then
					GuildList[name]=true
				end
			end
		end
		--
		NPA.EventHandler.RegisterEvent(0,"GUILD_ROSTER_UPDATE","DataCollector_Friends",OnGuildListUpdate)

		local OnPartyRaidUpdate=function()
			NPA.ClearTable(PartyList)
			NPA.ClearTable(RaidList)
			local playername=UnitName("player")
			for i=1,40 do
				local name=UnitName("raid"..i)
				if(name and name~=playername)then
					RaidList[name]=true
				end
			end
			for i=1,4 do	--player is not in this list
				local name=UnitName("party"..i)
				if(name)then
					PartyList[name]=true
				end
			end
		end
		
		NPA.EventHandler.RegisterEvent(0,"GROUP_ROSTER_UPDATE","DataCollector_Friends",OnPartyRaidUpdate)

		local OnArenaOpponentUpdate=function()
			OnPartyRaidUpdate() --also update party and raid

			NPA.ClearTable(ArenaList)

			for i=1,5 do
				local name=UnitName("arena"..i)
				if(name)then
					ArenaList[name]=true
				end
			end
		end

		NPA.EventHandler.RegisterEvent(0,"ARENA_OPPONENT_UPDATE","DataCollector_Friends",OnArenaOpponentUpdate)
		NPA.EventHandler.RegisterEvent(0,"PLAYER_ENTERING_WORLD","DataCollector_Friends",OnArenaOpponentUpdate)
		NPA.EventHandler.RegisterEvent(6,"SettingManager_SettingLoaded","DataCollector_Friends",function()
			OnFriendListUpdate()
			OnGuildListUpdate()
			OnPartyRaidUpdate()
			OnArenaOpponentUpdate()
		end)
	end,
	--------
	function()
		--clear up table
		NPA.FriendsList.FriendList={}
		NPA.FriendsList.GuildList={}
		NPA.FriendsList.PartyList={}
		NPA.FriendsList.RaidList={}
		-------unregister all events
		NPA.EventHandler.RegisterEvent(0,"FRIENDLIST_UPDATE","DataCollector_Friends",nil)
		NPA.EventHandler.RegisterEvent(0,"GUILD_ROSTER_UPDATE","DataCollector_Friends",nil)
		NPA.EventHandler.RegisterEvent(0,"GROUP_ROSTER_UPDATE","DataCollector_Friends",nil)
		NPA.EventHandler.RegisterEvent(0,"ARENA_OPPONENT_UPDATE","DataCollector_Friends",nil)
		NPA.EventHandler.RegisterEvent(0,"PLAYER_ENTERING_WORLD","DataCollector_Friends",nil)
		NPA.EventHandler.RegisterEvent(6,"SettingManager_SettingLoaded","DataCollector_Friends",nil)
	end,
	--data transfer function,transfer frame-based unitdata to guid-based unitdata
	function()
	end,
	--data clear function
	function()
	end
	)

