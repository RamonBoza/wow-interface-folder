-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:26
if(NPA_Options.Locale=="zhTW")then
	NPA_Options.Localization.PagesTargetArrowEditor.FromToList[9]={
		Text="小隊",
		Value=8,
		Tooltips="單位是小隊成員",
	}
	NPA_Options.Localization.InfoLibDataType["Range"]="距離"

	NPA_Options.Localization.PagesMainCore["Shield"]="護盾"
	NPA_Options.Localization.PagesMainCore["Range"]="距離"

	NPA_Options.Localization.TemplatesPreview["Range"]="距離"
	NPA_Options.Localization.TemplatesPreview["RangeMin"]="最小距離"
	NPA_Options.Localization.TemplatesPreview["RangeMax"]="最大距離"

	NPA_Options.Localization.PagesModuleList.NamePlateConditionType[31]={
		Text="護盾多于",
		Value="ShieldMore",
		Tooltips="單位擁有的護盾多於(按百分比)",
	}
	NPA_Options.Localization.PagesModuleList.NamePlateConditionType[32]={
		Text="護盾少於",
		Value="ShieldLess",
		Tooltips="單位擁有的護盾少於(按百分比)",
	}
	NPA_Options.Localization.PagesModuleList.NamePlateConditionType[33]={
		Text="距離更遠",
		Value="RangeMore",
		Tooltips="与單位的距離超過",
	}
	NPA_Options.Localization.PagesModuleList.NamePlateConditionType[34]={
		Text="距離更近",
		Value="RangeLess",
		Tooltips="与單位的距離近過",
	}
end