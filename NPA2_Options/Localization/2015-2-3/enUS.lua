-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:02
if(NPA_Options.Locale=="enUS")then
	NPA_Options.Localization.PagesMain["ExtraArrow"]="ExtraArrow"
	NPA_Options.Localization.PagesMain.Tooltips["ExtraArrow"]="Extra arrows for party, raid, focus, mouseover, boss, arena"
	--
	NPA_Options.Localization.PagesTargetArrowEditor["ToUnit"]="Name or unit id"
	NPA_Options.Localization.PagesTargetArrowEditor.Tooltips["ToUnit"]="The name or unit id of the target arrows point to. name is the unit's displayed name (without server name); unit id could be: focus, mouseover, party1(for 1st member of party), arena2(2nd opponent in arena), raid3(3rd member in raid), boss4(4th unit of boss frame)"
end
