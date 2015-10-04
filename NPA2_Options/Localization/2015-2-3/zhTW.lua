-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:26
if(NPA_Options.Locale=="zhTW")then
	NPA_Options.Localization.PagesMain["ExtraArrow"]="額外箭頭"
	NPA_Options.Localization.PagesMain.Tooltips["ExtraArrow"]="指向小隊,團隊,焦點,鼠標划過,首領,競技場目標的額外箭頭"
	--
	NPA_Options.Localization.PagesTargetArrowEditor["ToUnit"]="名稱或單位id"
	NPA_Options.Localization.PagesTargetArrowEditor.Tooltips["ToUnit"]="箭頭指向目標的名稱或者單位id. 名稱即為單位的顯示名稱(不含服務器名稱); 單位id可以是:focus(焦點),mouseover(鼠標划過),party1(小隊中的第一個成員), arena2(競技場中的第二個對手), raid3(團隊中的第三個成員), boss4(首領框體內的第四個單位)"
end