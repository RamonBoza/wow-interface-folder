-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:26
if(NPA_Options.Locale=="zhTW")then
	NPA_Options.Localization.TemplatesWindowFontEditor["ColorChange"]="顏色變化"
	NPA_Options.Localization.TemplatesWindowFontEditor.Tooltips["ColorChange"]="用不同的顏色著色每壹個字,所用的顏色根據字所在的位置計算(警告:這個功能可能會吃掉大量cpu資源"
	NPA_Options.Localization.TemplatesWindowFontEditor["ColorChangeRevers"]="反轉"
	NPA_Options.Localization.TemplatesWindowFontEditor.Tooltips["ColorChangeRevers"]="反轉著色方向;不勾選為從右至左,勾選為從左至右"
	NPA_Options.Localization.TemplatesWindowFontEditor["ColorChangeEnd"]="結束顏色"
	NPA_Options.Localization.TemplatesWindowFontEditor.Tooltips["ColorChangeEnd"]="用於按字上色的最後壹個顏色"
	NPA_Options.Localization.TemplatesWindowFontEditor["ColorChangeStep"]="著色步長"
	NPA_Options.Localization.TemplatesWindowFontEditor.Tooltips["ColorChangeStep"]="用來按字著色的總字長,位於超出此長度的字全部都會按結束顏色來著色"

	NPA_Options.Localization.PagesCombatText["Value"]="原始"
	NPA_Options.Localization.PagesCombatText["Short"]="縮寫"
	NPA_Options.Localization.PagesCombatText["Break"]="分段"
	NPA_Options.Localization.PagesCombatText["ShortAndDecimal"]="帶有小數的縮寫"

	NPA_Options.Localization.PagesCombatText["NumberType"]="數字類型"
	NPA_Options.Localization.PagesCombatText.Tooltips["NumberType"]="數字值的顯示方式"
	NPA_Options.Localization.PagesCombatText["DetailWidth"]="細節文本寬度"
	NPA_Options.Localization.PagesCombatText.Tooltips["DetailWidth"]="細節文本的寬度,如果設為0,則會根據所顯示文本的長度自動計算"
	NPA_Options.Localization.PagesCombatText["DetailHeight"]="細節文本高度"
	NPA_Options.Localization.PagesCombatText.Tooltips["DetailHeight"]="細節文本的高度,實際尺寸會根據不同的字體有所區別"
end