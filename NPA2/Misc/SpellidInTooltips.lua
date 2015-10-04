-- Author      : Nogarder
-- Create Date : 2012/3/16 20:42:08
--------spellid in tip
local hooksecurefunc=hooksecurefunc
local	idtip_addLine=function(self,id,isItem)
	self:AddLine("SpellID: |cffffff00"..id)
end
NPA.EventHandler.RegisterEvent(6,"SettingManager_SettingLoaded","Misc_SpellIDInTooltips",function()
	if(NPA_Setting.Core.SpellIDInTooltips)then
		idtip_addLine=function(self,id,isItem)
			self:AddLine("SpellID: |cffffff00"..id)
		end
	else
		idtip_addLine=function()
		end
	end
end)
-- Spell Hooks ----------------------------------------------------------------
hooksecurefunc(GameTooltip, "SetUnitBuff", function(self,...)
	local id = select(11,UnitBuff(...))
	if id then idtip_addLine(self,id) end
end)

hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self,...)
	local id = select(11,UnitDebuff(...))
	if id then idtip_addLine(self,id) end
end)

hooksecurefunc(GameTooltip, "SetUnitAura", function(self,...)
	local id = select(11,UnitAura(...))
	if id then idtip_addLine(self,id) end
end)

GameTooltip:HookScript("OnTooltipSetSpell", function(self)
	local id = select(3,self:GetSpell())
	if id then idtip_addLine(self,id) end
end)