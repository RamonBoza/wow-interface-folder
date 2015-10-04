-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:10
if(NPA_Options.Locale=="koKR")then
	NPA_Options.Localization.PagesTargetArrowEditor["StartColor"]="Start color"
	NPA_Options.Localization.PagesTargetArrowEditor["EndColor"]="End color"
	NPA_Options.Localization.PagesTargetArrowEditor["RangeStartColor"]="Range start color"
	NPA_Options.Localization.PagesTargetArrowEditor["RangeEndColor"]="Range end color"
	NPA_Options.Localization.PagesTargetArrowEditor["RangeCheck"]="Range check range"

	NPA_Options.Localization.PagesTargetArrowEditor.Tooltips["RangeCheck"]="The range to change color, set to 0 to disable checking"

	NPA_Options.Localization.PagesTargetArrowEditor["ToUnit"]="Name or unit id or range"
	NPA_Options.Localization.PagesTargetArrowEditor.Tooltips["ToUnit"]="The name or unit id, or range, of the target the arrow points to. Name is the unit's displayed name (without server name); Unit id could be: focus, mouseover, party1(for 1st member of party), arena2(2nd opponent in arena), raid3(3rd member in raid), boss4(4th unit of boss frame) ; Range is a number (yard), the arrow would show when target range is less than this number"
end
