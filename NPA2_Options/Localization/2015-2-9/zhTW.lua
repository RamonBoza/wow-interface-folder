-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:26
if(NPA_Options.Locale=="zhTW")then
	NPA_Options.Localization.PagesTargetArrowEditor["FadeAlpha"]="漸隱透明度"
	NPA_Options.Localization.PagesTargetArrowEditor.Tooltips["FadeAlpha"]="漸隱結束時的透明度值"
	NPA_Options.Localization.PagesTargetArrowEditor["LifeTime"]="生存時間"
	NPA_Options.Localization.PagesTargetArrowEditor.Tooltips["LifeTime"]="漸隱開始後持續的時間"
	NPA_Options.Localization.PagesTargetArrowEditor["AlphaWithParent"]="父框體透明度"
	NPA_Options.Localization.PagesTargetArrowEditor.Tooltips["AlphaWithParent"]="隨著父框體改變透明度"

	NPA_Options.Localization.PagesTargetArrowEditor.FromToList[10]={
		Text="團隊",
		Value=9,
		Tooltips="單位在團隊中",
	}

	NPA_Options.Localization.PagesTargetArrowEditor.FromToList[11]={
		Text="公會",
		Value=10,
		Tooltips="單位是玩家的公會成員",
	}
	NPA_Options.Localization.PagesTargetArrowEditor.FromToList[12]={
		Text="好友",
		Value=11,
		Tooltips="單位在玩家的好友列表內",
	}
	NPA_Options.Localization.PagesTargetArrowEditor.FromToList[13]={
		Text="競技場",
		Value=12,
		Tooltips="單位是玩家當前的競技場對手",
	}
end