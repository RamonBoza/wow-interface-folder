-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:26
if(NPA_Options.Locale=="zhTW")then
	NPA_Options.Localization.PagesMainResourcesLib["AnimatedTextureLib"]="動畫材質庫"
	NPA_Options.Localization.PagesMainResourcesLib.Tooltips["AnimatedTextureLib"]="動畫材質庫"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["Time"]="持續時間"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["Time"]="這壹幀應當持續的時間(按秒)"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameTime"]="幀時間"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameTime"]="每壹幀應當持續的時間(按秒)"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameCount"]="幀數量"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameCount"]="生成的總幀數量"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["PerRow"]="每行幀數"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["PerRow"]="每行應該生成的幀數量"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["Direction"]="增長方向"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["Direction"]="幀應當增長的方向"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameRotation"]="幀旋轉"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameRotation"]="每壹幀基於前壹幀應當旋轉的角度"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameWidth"]="幀寬"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameWidth"]="生成幀的寬度"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameHeight"]="幀高"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameHeight"]="生成幀的高度"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameGapX"]="幀間距X"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameGapX"]="生成每壹幀之間的X距離"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameGapY"]="幀間距Y"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameGapY"]="生成每壹幀之間的Y距離"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["Generate"]="生成"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["Generate"]="生成幀,並插入到列表中"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["InsertAt"]="插入至"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["InsertAt"]="生成的幀應當被插入的位置,此位置的幀將會被推後"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["ColorStart"]="起始顏色"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["ColorStart"]="生成的幀起始的顏色,中間的幀會根據起始和結束計算顏色"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["ColorEnd"]="結束顏色"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["ColorEnd"]="生成的幀結束的顏色,中間的幀會根據起始和結束計算顏色"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor.DirectionList={
		[1]={
			Text="向右然後向上",
			Tooltips="先向右增長然後向上",
			Value=1,
		},
		[2]={
			Text="向左然後向上",
			Tooltips="先向左增長然後向上",
			Value=2,
		},
		[3]={
			Text="向右然後向下",
			Tooltips="向右增長然後向下",
			Value=3,
		},
		[4]={
			Text="向左然後向下",
			Tooltips="向左增長然後向下",
			Value=4,
		},
		[5]={
			Text="向上然後向右",
			Tooltips="向上增長然後向右",
			Value=5,
		},
		[6]={
			Text="向上然後向左",
			Tooltips="向上增長然後向左",
			Value=6,
		},
		[7]={
			Text="向下然後向右",
			Tooltips="向下增長然後向右",
			Value=7,
		},
		[8]={
			Text="向下然後向左",
			Tooltips="向下增長然後向左",
			Value=8,
		},
	}
end