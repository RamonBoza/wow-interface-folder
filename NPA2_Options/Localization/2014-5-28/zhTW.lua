-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:26
if(NPA_Options.Locale=="zhTW")then
	NPA_Options.Localization.PagesMainResourcesLib["UnitLib"]="單位"
	NPA_Options.Localization.PagesMainResourcesLib.Tooltips["UnitLib"]="設置單位顯示所使用的文本,例如'團隊1''競技場2'"
	NPA_Options.Localization.PagesUnitLib={
		UnitData={
			["target"]="目標",
			["focus"]="焦點",
			["mouseover"]="鼠標滑過",
			["party"]="小隊",
			["raid"]="團隊",
			["arena"]="競技場",
		},
		["Priority"]="優先級",
		Tooltips={
			["Priority"]="高優先級會優先顯示,設爲0則禁用",
		}
	}
end