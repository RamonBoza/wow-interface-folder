-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:02
if(NPA_Options.Locale=="enUS")then
	NPA_Options.Localization.PagesMainResourcesLib["AnimatedTextureLib"]="A-Texture Lib"
	NPA_Options.Localization.PagesMainResourcesLib.Tooltips["AnimatedTextureLib"]="Animated-Texture Lib"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["Time"]="Lasting time"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["Time"]="The time this frame should last (by second)"


	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameTime"]="Frame time"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameTime"]="The time each frame should last (by second)"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameCount"]="Frame count"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameCount"]="Total count of the frames to generate"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["PerRow"]="Frame per row"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["PerRow"]="The frames to generate per row"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["Direction"]="Grow direction"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["Direction"]="The direction in witch frames to generate grow"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameRotation"]="Frame rotation"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameRotation"]="The angle each frame should rotate based on previous frame"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameWidth"]="Frame width"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameWidth"]="The width of each generated frame"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameHeight"]="Frame height"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameHeight"]="The height of each generated frame"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameGapX"]="Frame gap X"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameGapX"]="The X gap between each generated frame"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["FrameGapY"]="Frame gap Y"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["FrameGapY"]="The Y gap between each generated frame"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["Generate"]="Generate"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["Generate"]="Generate frames , insert them into current list"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["InsertAt"]="Insert at"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["InsertAt"]="The position generated frames should be insert to, frame in this position will be push behind"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["ColorStart"]="Color start"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["ColorStart"]="The color generated frames start with, frames in between will be calculated based on start and end"

	NPA_Options.Localization.TemplatesWindowTextureFileEditor["ColorEnd"]="Color end"
	NPA_Options.Localization.TemplatesWindowTextureFileEditor.Tooltips["ColorEnd"]="The color generated frames end with, frames in between will be calculated based on start and end"


	NPA_Options.Localization.TemplatesWindowTextureFileEditor.DirectionList={
		[1]={
			Text="Right then up",
			Tooltips="Grow right then up",
			Value=1,
		},
		[2]={
			Text="Left then up",
			Tooltips="Grow left then up",
			Value=2,
		},
		[3]={
			Text="Right then down",
			Tooltips="Grow right then down",
			Value=3,
		},
		[4]={
			Text="Left then down",
			Tooltips="Grow left then down",
			Value=4,
		},
		[5]={
			Text="Up then right",
			Tooltips="Grow up then right",
			Value=5,
		},
		[6]={
			Text="Up then left",
			Tooltips="Grow up then left",
			Value=6,
		},
		[7]={
			Text="Down then right",
			Tooltips="Grow down then right",
			Value=7,
		},
		[8]={
			Text="Down then left",
			Tooltips="Grow down then left",
			Value=8,
		},
	}

end
