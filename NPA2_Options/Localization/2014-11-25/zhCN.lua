-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:18
if(NPA_Options.Locale=="zhCN")then
	NPA_Options.Localization.PagesCombatText["MultiStrike"]="溅射(多重)"
	NPA_Options.Localization.PagesCombatText.Tooltips["MultiStrike"]="根据是否是溅射(多重打击)来决定是否显示战斗文本"

	NPA_Options.Localization.PagesCombatText.Tooltips["From"]=NPA_Options.Localization.PagesCombatText.Tooltips["From"].."(注意,阵营选项是排斥性的,例如:'敌对'实际上是指'不是目标也不是鼠标划过等等...的敌对)"
	NPA_Options.Localization.PagesCombatText.Tooltips["To"]=NPA_Options.Localization.PagesCombatText.Tooltips["To"].."(注意,阵营选项是排斥性的,例如:'敌对'实际上是'不是目标也不是鼠标划过等等...的敌对)"

	NPA_Options.Localization.PagesCombatText["EventLocalization"]["SPELL_CAST_FAILED"]="施法失败"
	NPA_Options.Localization.PagesCombatText["EventLocalization"]["SPELL_ABSORBED"]="护盾吸收"
	
	NPA_Options.Localization.PagesCombatText.MultiStrikeList={
		[1]={
			Text="都有",
			Value=0,
			Tooltips="既显示溅射(多重打击),也显示非溅射(多重打击)",
		},
		[2]={
			Text="非溅射(多重)",
			Value=2,
			Tooltips="只显示非溅射(多重打击)"
		},
		[3]={
			Text="溅射(多重)",
			Value=1,
			Tooltips="只显示溅射(多重打击)"
		},
	}

	NPA_Options.Localization.PagesCombatText["Name"]="名称"
	NPA_Options.Localization.PagesCombatText.Tooltips["Name"]="按照单位名称过滤,留空则为任意"
	NPA_Options.Localization.PagesCombatText["Exact"]="严格"
	NPA_Options.Localization.PagesCombatText.Tooltips["Exact"]="严格相同的名称过滤,不严格时则所有包含关键字的名称都有效"
end
