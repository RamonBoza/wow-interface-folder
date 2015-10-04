-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:10
if(NPA_Options.Locale=="koKR")then
	NPA_Options.Localization.PagesCombatText["MultiStrike"]="MultiStrike"
	NPA_Options.Localization.PagesCombatText.Tooltips["MultiStrike"]="Decide to show a CombatText with whether it's a MultiStrike"

	NPA_Options.Localization.PagesCombatText.Tooltips["From"]=NPA_Options.Localization.PagesCombatText.Tooltips["From"].."( note: reaction options are exclusive, for example: 'hostile' actually is 'hostile which is not Target ,nor Mouseover, and so on')"
	NPA_Options.Localization.PagesCombatText.Tooltips["To"]=NPA_Options.Localization.PagesCombatText.Tooltips["To"].."( note: reaction options are exclusive, for example: 'hostile' actually is 'hostile which is not Target ,nor Mouseover, and so on')"

	NPA_Options.Localization.PagesCombatText["EventLocalization"]["SPELL_CAST_FAILED"]="Cast failed"
	NPA_Options.Localization.PagesCombatText["EventLocalization"]["SPELL_ABSORBED"]="Shield absorb"
	
	NPA_Options.Localization.PagesCombatText.MultiStrikeList={
		[1]={
			Text="Both",
			Value=0,
			Tooltips="Both MultiStrike and non-MultiStrike",
		},
		[2]={
			Text="Non-MultiStrike",
			Value=2,
			Tooltips="Only for non-MultiStrike"
		},
		[3]={
			Text="MultiStrike",
			Value=1,
			Tooltips="Only for MultiStrike"
		},
	}

	NPA_Options.Localization.PagesCombatText["Name"]="Name"
	NPA_Options.Localization.PagesCombatText.Tooltips["Name"]="Name filter, leave empty to disable"
	NPA_Options.Localization.PagesCombatText["Exact"]="Exact"
	NPA_Options.Localization.PagesCombatText.Tooltips["Exact"]="Exact same name, not exact will enable all includes key word"
end
