-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:02
if(NPA_Options.Locale=="enUS")then
	NPA_Options.Localization.TemplatesWindowFontEditor["ColorChange"]="Color change"
	NPA_Options.Localization.TemplatesWindowFontEditor.Tooltips["ColorChange"]="Color each word with different color, the color used is caculated by word position (Warning:this may cost a lot of cpu power)"
	NPA_Options.Localization.TemplatesWindowFontEditor["ColorChangeRevers"]="Revers"
	NPA_Options.Localization.TemplatesWindowFontEditor.Tooltips["ColorChangeRevers"]="Revers the coloring direction; unchecked is from right to left, checked is from left to right"
	NPA_Options.Localization.TemplatesWindowFontEditor["ColorChangeEnd"]="Color end"
	NPA_Options.Localization.TemplatesWindowFontEditor.Tooltips["ColorChangeEnd"]="The last color which is used to color word by position"
	NPA_Options.Localization.TemplatesWindowFontEditor["ColorChangeStep"]="Color step"
	NPA_Options.Localization.TemplatesWindowFontEditor.Tooltips["ColorChangeStep"]="The total word count used to color word by position, word in position more than this value will all be colored with end color"

	NPA_Options.Localization.PagesCombatText["Value"]="Original"
	NPA_Options.Localization.PagesCombatText["Short"]="Short"
	NPA_Options.Localization.PagesCombatText["Break"]="Break"
	NPA_Options.Localization.PagesCombatText["ShortAndDecimal"]="Short with decimal"

	NPA_Options.Localization.PagesCombatText["NumberType"]="Number type"
	NPA_Options.Localization.PagesCombatText.Tooltips["NumberType"]="How to display number value"
	NPA_Options.Localization.PagesCombatText["DetailWidth"]="Detail text width"
	NPA_Options.Localization.PagesCombatText.Tooltips["DetailWidth"]="The width of detail text, if set to 0, it will be caculated automatically with the displayed text"
	NPA_Options.Localization.PagesCombatText["DetailHeight"]="Detail text height"
	NPA_Options.Localization.PagesCombatText.Tooltips["DetailHeight"]="The height of detail text, the exact size would be different with different font setting"
end
