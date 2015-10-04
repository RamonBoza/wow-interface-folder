-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:02
if(NPA_Options.Locale=="enUS")then
	NPA_Options.Localization.PagesTargetArrowEditor["FadeAlpha"]="Fade alpha"
	NPA_Options.Localization.PagesTargetArrowEditor.Tooltips["FadeAlpha"]="Alpha value when fading is over"
	NPA_Options.Localization.PagesTargetArrowEditor["LifeTime"]="Life time"
	NPA_Options.Localization.PagesTargetArrowEditor.Tooltips["LifeTime"]="How long will it take to fade, when fading started"
	NPA_Options.Localization.PagesTargetArrowEditor["AlphaWithParent"]="Alpha with parent"
	NPA_Options.Localization.PagesTargetArrowEditor.Tooltips["AlphaWithParent"]="Change alpha with parent frame"

	NPA_Options.Localization.PagesTargetArrowEditor.FromToList[10]={
		Text="Raid",
		Value=9,
		Tooltips="Unit is in raid group",
	}

	NPA_Options.Localization.PagesTargetArrowEditor.FromToList[11]={
		Text="Guild",
		Value=10,
		Tooltips="Unit is player's guild member",
	}
	NPA_Options.Localization.PagesTargetArrowEditor.FromToList[12]={
		Text="Friend",
		Value=11,
		Tooltips="Unit is in player's friend list",
	}
	NPA_Options.Localization.PagesTargetArrowEditor.FromToList[13]={
		Text="Arena",
		Value=12,
		Tooltips="Unit is player's current arena opponent",
	}
end
