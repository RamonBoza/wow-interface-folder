-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:18
if(NPA_Options.Locale=="zhCN")then
	NPA_Options.Localization.PagesTargetArrowEditor.FromToList[9]={
		Text="小队",
		Value=8,
		Tooltips="单位是小队成员",
	}
	NPA_Options.Localization.InfoLibDataType["Range"]="距离"

	NPA_Options.Localization.PagesMainCore["Shield"]="护盾"
	NPA_Options.Localization.PagesMainCore["Range"]="距离"

	NPA_Options.Localization.TemplatesPreview["Range"]="距离"
	NPA_Options.Localization.TemplatesPreview["RangeMin"]="最小距离"
	NPA_Options.Localization.TemplatesPreview["RangeMax"]="最大距离"

	NPA_Options.Localization.PagesModuleList.NamePlateConditionType[31]={
		Text="护盾多于",
		Value="ShieldMore",
		Tooltips="单位拥有的护盾多于(按百分比)",
	}
	NPA_Options.Localization.PagesModuleList.NamePlateConditionType[32]={
		Text="护盾少于",
		Value="ShieldLess",
		Tooltips="单位拥有的护盾少于(按百分比)",
	}
	NPA_Options.Localization.PagesModuleList.NamePlateConditionType[33]={
		Text="距离更远",
		Value="RangeMore",
		Tooltips="与单位的距离超过",
	}
	NPA_Options.Localization.PagesModuleList.NamePlateConditionType[34]={
		Text="距离更近",
		Value="RangeLess",
		Tooltips="与单位的距离近过",
	}
end
