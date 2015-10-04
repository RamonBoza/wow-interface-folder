-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:18
if(NPA_Options.Locale=="zhCN")then
	NPA_Options.Localization.PagesMain["ExtraArrow"]="额外箭头"
	NPA_Options.Localization.PagesMain.Tooltips["ExtraArrow"]="指向小队,团队,焦点,鼠标划过,首领,竞技场目标的额外箭头"
	--
	NPA_Options.Localization.PagesTargetArrowEditor["ToUnit"]="名称或单位id"
	NPA_Options.Localization.PagesTargetArrowEditor.Tooltips["ToUnit"]="箭头指向目标的名称或者单位id,. 名称即为单位的显示名称(不含服务器名称); 单位id可以是:focus(焦点),mouseover(鼠标划过),party1(小队中的第一个成员), arena2(竞技场中的第二个对手), raid3(团队中的第三个成员), boss4(首领框体內的第四个单位)"
end
