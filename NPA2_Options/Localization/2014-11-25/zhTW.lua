-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:26
if(NPA_Options.Locale=="zhTW")then
	NPA_Options.Localization.PagesCombatText["MultiStrike"]="多重打擊"
	NPA_Options.Localization.PagesCombatText.Tooltips["MultiStrike"]="根據是否是多重打擊來決定是否顯示戰鬥文本"

	NPA_Options.Localization.PagesCombatText.Tooltips["From"]=NPA_Options.Localization.PagesCombatText.Tooltips["From"].."(注意,陣營選項是排斥性的,例如:'敵對'實際上是指'不是目標也不是鼠標划過等等...的敵對)"
	NPA_Options.Localization.PagesCombatText.Tooltips["To"]=NPA_Options.Localization.PagesCombatText.Tooltips["To"].."(注意,陣營選項是排斥性的,例如:'敵對'實際上是指'不是目標也不是鼠標划過等等...的敵對)"
	
	NPA_Options.Localization.PagesCombatText["EventLocalization"]["SPELL_CAST_FAILED"]="施法失敗"
	NPA_Options.Localization.PagesCombatText["EventLocalization"]["SPELL_ABSORBED"]="護盾吸收"

	NPA_Options.Localization.PagesCombatText.MultiStrikeList={
		[1]={
			Text="都有",
			Value=0,
			Tooltips="既顯示多重打擊,也顯示非多重打擊",
		},
		[2]={
			Text="非多重打擊",
			Value=2,
			Tooltips="只顯示非多重打擊"
		},
		[3]={
			Text="多重打擊",
			Value=1,
			Tooltips="只顯示多重打擊"
		},
	}

	NPA_Options.Localization.PagesCombatText["Name"]="名稱"
	NPA_Options.Localization.PagesCombatText.Tooltips["Name"]="名稱過濾,留空為任意"
	NPA_Options.Localization.PagesCombatText["Exact"]="嚴格"
	NPA_Options.Localization.PagesCombatText.Tooltips["Exact"]="嚴格匹配相同的名稱,不嚴格則會啓用所有包含關鍵字的名稱"
end