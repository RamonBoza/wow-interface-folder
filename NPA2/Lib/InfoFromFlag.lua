-- Author      : Nogarder
-- Create Date : 2014/11/24 17:09:58

NPA.InfoFromFlag={}

local bit_band=bit.band

local COMBATLOG_OBJECT_REACTION_MASK=COMBATLOG_OBJECT_REACTION_MASK
local COMBATLOG_OBJECT_TYPE_PLAYER=COMBATLOG_OBJECT_TYPE_PLAYER
local COMBATLOG_OBJECT_TYPE_PET=COMBATLOG_OBJECT_TYPE_PET
local COMBATLOG_OBJECT_TYPE_GUARDIAN=COMBATLOG_OBJECT_TYPE_GUARDIAN
local COMBATLOG_OBJECT_REACTION_HOSTILE=COMBATLOG_OBJECT_REACTION_HOSTILE
local COMBATLOG_OBJECT_REACTION_FRIENDLY=COMBATLOG_OBJECT_REACTION_FRIENDLY


NPA.InfoFromFlag.GetReaction=function(flag)
	return bit_band(flag,COMBATLOG_OBJECT_REACTION_MASK) -- hostile=64, neutral=32, friendly=16
end

NPA.InfoFromFlag.GetPlayer=function(flag)
	return bit_band(flag,COMBATLOG_OBJECT_TYPE_PLAYER) -->0=player
end
NPA.InfoFromFlag.GetType=function(flag)
	local faction,atype
	if(bit_band(flag,COMBATLOG_OBJECT_TYPE_PLAYER)>0)then
		atype=1 --1=player
	elseif(bit_band(flag,COMBATLOG_OBJECT_TYPE_PET)>0)then
		atype=3 --3=pet
	elseif(bit_band(flag,COMBATLOG_OBJECT_TYPE_GUARDIAN)>0)then
		atype=4 --4=guardian
	else
		atype=2 --2=npc
	end
	--faction, 1=friendly,2=neutral,3=hostile
	if(bit_band(flag,COMBATLOG_OBJECT_REACTION_HOSTILE)>0)then
		faction=3
	elseif(bit_band(flag,COMBATLOG_OBJECT_REACTION_FRIENDLY)>0)then
		faction=1
	else
		faction=2
	end
	return faction,atype
end

NPA.InfoFromFlag.GetPlayerPet=function(flag)
	if(bit_band(flag,COMBATLOG_OBJECT_AFFILIATION_MINE)~=0)then
		return true
	end
end