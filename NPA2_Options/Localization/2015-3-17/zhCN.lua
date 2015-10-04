-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:18
if(NPA_Options.Locale=="zhCN")then
	NPA_Options.Localization.PagesTargetArrowEditor["StartColor"]="起始顏色"
	NPA_Options.Localization.PagesTargetArrowEditor["EndColor"]="結束顏色"
	NPA_Options.Localization.PagesTargetArrowEditor["RangeStartColor"]="測距起始顏色"
	NPA_Options.Localization.PagesTargetArrowEditor["RangeEndColor"]="測距結束顏色"
	NPA_Options.Localization.PagesTargetArrowEditor["RangeCheck"]="測距距離"

	NPA_Options.Localization.PagesTargetArrowEditor.Tooltips["RangeCheck"]="改變顏色的距離,設為0禁用"

	NPA_Options.Localization.PagesTargetArrowEditor["ToUnit"]="名稱或單位id或距離"
	NPA_Options.Localization.PagesTargetArrowEditor.Tooltips["ToUnit"]="箭頭指向的目標的名稱,或單位id,或距離.名稱為單位顯示的名稱(不含服務器名);單位id可以為:focus(焦點), mouseover(鼠標劃過), party1(小隊中第壹個成員), arena2(競技場中第二個對手), raid3(團隊中第三個成員), boss4(boss框體的第四個單位) ; 距離是壹個數字(單位是碼),箭頭會在目標距離小於這個數字時顯示"
end
