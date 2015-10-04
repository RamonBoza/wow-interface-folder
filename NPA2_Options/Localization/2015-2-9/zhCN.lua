-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:18
if(NPA_Options.Locale=="zhCN")then
	NPA_Options.Localization.PagesTargetArrowEditor["FadeAlpha"]="渐隐透明度"
	NPA_Options.Localization.PagesTargetArrowEditor.Tooltips["FadeAlpha"]="渐隐结束时的透明度值"
	NPA_Options.Localization.PagesTargetArrowEditor["LifeTime"]="生存时间"
	NPA_Options.Localization.PagesTargetArrowEditor.Tooltips["LifeTime"]="渐隐开始后持续的时间"
	NPA_Options.Localization.PagesTargetArrowEditor["AlphaWithParent"]="父框体透明度"
	NPA_Options.Localization.PagesTargetArrowEditor.Tooltips["AlphaWithParent"]="随着父框体改变透明度"

	NPA_Options.Localization.PagesTargetArrowEditor.FromToList[10]={
		Text="团队",
		Value=9,
		Tooltips="单位在团队中",
	}

	NPA_Options.Localization.PagesTargetArrowEditor.FromToList[11]={
		Text="公会",
		Value=10,
		Tooltips="单位是玩家的公会成员",
	}
	NPA_Options.Localization.PagesTargetArrowEditor.FromToList[12]={
		Text="好友",
		Value=11,
		Tooltips="单位在玩家的好友列表內",
	}
	NPA_Options.Localization.PagesTargetArrowEditor.FromToList[13]={
		Text="竞技场",
		Value=12,
		Tooltips="单位是玩家当前的竞技场对手",
	}
end
