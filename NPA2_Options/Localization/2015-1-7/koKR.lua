-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:10
if(NPA_Options.Locale=="koKR")then
	NPA_Options.Localization.PagesTargetArrowEditor.FromToList[9]={
		Text="Party",
		Value=8,
		Tooltips="Unit is party member",
	}
	NPA_Options.Localization.InfoLibDataType["Range"]="Range"

	NPA_Options.Localization.PagesMainCore["Shield"]="Shield"
	NPA_Options.Localization.PagesMainCore["Range"]="Range"

	NPA_Options.Localization.TemplatesPreview["Range"]="Range"
	NPA_Options.Localization.TemplatesPreview["RangeMin"]="Range minimum"
	NPA_Options.Localization.TemplatesPreview["RangeMax"]="Range maximum"

	NPA_Options.Localization.PagesModuleList.NamePlateConditionType[31]={
		Text="ShieldMore",
		Value="ShieldMore",
		Tooltips="Unit has more shield than (by percent)",
	}
	NPA_Options.Localization.PagesModuleList.NamePlateConditionType[32]={
		Text="ShieldLess",
		Value="ShieldLess",
		Tooltips="Unit has less shield than (by percent)",
	}
	NPA_Options.Localization.PagesModuleList.NamePlateConditionType[33]={
		Text="RangeMore",
		Value="RangeMore",
		Tooltips="Unit is further than",
	}
	NPA_Options.Localization.PagesModuleList.NamePlateConditionType[34]={
		Text="RangeLess",
		Value="RangeLess",
		Tooltips="Unit is closer than",
	}
end
