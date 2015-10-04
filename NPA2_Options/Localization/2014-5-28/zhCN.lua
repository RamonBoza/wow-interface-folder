-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:18
if(NPA_Options.Locale=="zhCN")then
	NPA_Options.Localization.PagesMainResourcesLib["UnitLib"]="单位"
	NPA_Options.Localization.PagesMainResourcesLib.Tooltips["UnitLib"]="设置单位显示所使用的文本,例如'团队1''竞技场2'"
	NPA_Options.Localization.PagesUnitLib={
		UnitData={
			["target"]="目标",
			["focus"]="焦点",
			["mouseover"]="鼠标滑过",
			["party"]="小队",
			["raid"]="团队",
			["arena"]="竞技场",
		},
		["Priority"]="优先级",
		Tooltips={
			["Priority"]="高优先级会优先显示,设为0则禁用",
		}
	}
end
