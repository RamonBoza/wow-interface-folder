-- Author      : Nogarder
-- Create Date : 2014/5/28 8:24:10
if(NPA_Options.Locale=="koKR")then
	NPA_Options.Localization.PagesMainResourcesLib["UnitLib"]="Unit"
	NPA_Options.Localization.PagesMainResourcesLib.Tooltips["UnitLib"]="Set the text for unit display, i.e. 'raid1''arena2'"
	NPA_Options.Localization.PagesUnitLib={
		UnitData={
			["target"]="Target",
			["focus"]="Focus",
			["mouseover"]="Mouseover",
			["party"]="Party",
			["raid"]="Raid",
			["arena"]="Arena",
		},
		["Priority"]="Priority",
		Tooltips={
			["Priority"]="Higher priority will be shown fist, set to 0 to disable",
		}
	}
end
