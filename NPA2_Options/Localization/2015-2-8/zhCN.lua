-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:18
if(NPA_Options.Locale=="zhCN")then
	NPA_Options.Localization.PagesMainResourcesLib["AnimatedTextureLib"]="动画材质库"
	NPA_Options.Localization.PagesMainResourcesLib.Tooltips["AnimatedTextureLib"]="动画材质库"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["Time"]="持续时间"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["Time"]="这一帧应当持续的时间(按秒)"


	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameTime"]="帧时间"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameTime"]="每一帧应当持续的时间(按秒)"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameCount"]="帧数量"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameCount"]="生成的总帧数量"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["PerRow"]="每行帧数"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["PerRow"]="每行应该生成的帧数量"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["Direction"]="增长方向"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["Direction"]="帧应当增长的方向"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameRotation"]="帧旋转"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameRotation"]="每一帧基于前一帧应当旋转的角度"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameWidth"]="帧宽"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameWidth"]="生成帧的宽度"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameHeight"]="帧高"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameHeight"]="生成帧的高度"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameGapX"]="帧间距X"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameGapX"]="生成每一帧之间的X距离"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameGapY"]="帧间距Y"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameGapY"]="生成每一帧之间的Y距离"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["Generate"]="生成"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["Generate"]="生成帧,并插入到列表中"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["InsertAt"]="插入至"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["InsertAt"]="生成的帧应当被插入的位置,此位置的帧将会被推后"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["ColorStart"]="起始颜色"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["ColorStart"]="生成的帧起始的颜色,中间的帧会根据起始和结束计算颜色"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["ColorEnd"]="结束颜色"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["ColorEnd"]="生成的帧结束的颜色,中间的帧会根据起始和结束计算颜色"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor.DirectionList={
		[1]={
			Text="向右然后向上",
			Tooltips="先向右增长然后向上",
			Value=1,
		},
		[2]={
			Text="向左然后向上",
			Tooltips="先向左增长然后向上",
			Value=2,
		},
		[3]={
			Text="向右然后向下",
			Tooltips="向右增长然后向下",
			Value=3,
		},
		[4]={
			Text="向左然后向下",
			Tooltips="向左增长然后向下",
			Value=4,
		},
		[5]={
			Text="向上然后向右",
			Tooltips="向上增长然后向右",
			Value=5,
		},
		[6]={
			Text="向上然后向左",
			Tooltips="向上增长然后向左",
			Value=6,
		},
		[7]={
			Text="向下然后向右",
			Tooltips="向下增长然后向右",
			Value=7,
		},
		[8]={
			Text="向下然后向左",
			Tooltips="向下增长然后向左",
			Value=8,
		},
	}

end
