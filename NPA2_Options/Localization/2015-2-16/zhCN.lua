-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:18
if(NPA_Options.Locale=="zhCN")then
	NPA_Options.Localization.TemplatesWindowFontEditor["ColorChange"]="颜色变化"
	NPA_Options.Localization.TemplatesWindowFontEditor.Tooltips["ColorChange"]="用不同的颜色着色每一个字,所用的颜色根据字所在的位置计算(警告:这项功能可能会吃掉大量cpu资源)"
	NPA_Options.Localization.TemplatesWindowFontEditor["ColorChangeRevers"]="反转"
	NPA_Options.Localization.TemplatesWindowFontEditor.Tooltips["ColorChangeRevers"]="反转着色方向;不勾选为从右至左,勾选为从左至右"
	NPA_Options.Localization.TemplatesWindowFontEditor["ColorChangeEnd"]="结束颜色"
	NPA_Options.Localization.TemplatesWindowFontEditor.Tooltips["ColorChangeEnd"]="用于按字上色的最后一个颜色"
	NPA_Options.Localization.TemplatesWindowFontEditor["ColorChangeStep"]="着色步长"
	NPA_Options.Localization.TemplatesWindowFontEditor.Tooltips["ColorChangeStep"]="用来按字着色的总字长,位于超出此长度的字全部都会按结束颜色来着色"

	NPA_Options.Localization.PagesCombatText["Value"]="原始"
	NPA_Options.Localization.PagesCombatText["Short"]="缩写"
	NPA_Options.Localization.PagesCombatText["Break"]="分段"
	NPA_Options.Localization.PagesCombatText["ShortAndDecimal"]="带有小数的缩写"

	NPA_Options.Localization.PagesCombatText["NumberType"]="数字类型"
	NPA_Options.Localization.PagesCombatText.Tooltips["NumberType"]="数字值的显示方式"
	NPA_Options.Localization.PagesCombatText["DetailWidth"]="细节文本宽度"
	NPA_Options.Localization.PagesCombatText.Tooltips["DetailWidth"]="细节文本的宽度,如果设为0,则会根据所显示文本的长度自动计算"
	NPA_Options.Localization.PagesCombatText["DetailHeight"]="细节文本高度"
	NPA_Options.Localization.PagesCombatText.Tooltips["DetailHeight"]="细节文本的高度,实际尺寸会根据不同的字体有所区别"
end
