-- These are the main viewer's lines.
local addonName,ZGV = ...

local COLOR_TIP_MOUSE = "|cffddff00"
local COLOR_TIP_HINT = "|cff99ff00"
local COLOR_TIP = "|cff00ff00"
local COLOR_SUG_GUIDE = "|cffffcc40"
local DIR = "Interface\\AddOns\\"..addonName
local SHIFTCLICK = "<<Shift Click>>"

local ColorTalentName = "|cffffff88Z|cffffee66y|cffffdd44g|cffffcc22o|cffffbb00r |cffffaa00Talent A|cffffbb00d|cffffcc22v|cffffdd44i|cffffee66s|cffffff88o|cffffff88r|r"

ZygorGuidesViewer_L("Main", "enUS", function() local f = {
	MainFont=DIR.."\\Skins\\OpenSans.TTF",
	MainFontBold=DIR.."\\Skins\\OpenSansB.TTF",
	--MainFont=DIR.."\\Skins\\SegoeUI.TTF",
	--MainFontBold=DIR.."\\Skins\\SegoeUIB.TTF",
		opt_group_slidebar = "Slide Bar",			opt_group_slidebar_desc = "Manage Creature Detector, popups, and other features that can be completed as you need.",
		opt_sb_enabled = "Enable Slide Bar",		opt_sb_enabled_desc = nil,
		opt_sb_locked = "Lock Slide Bar",		opt_sb_locked_desc = "Lock the slide bar in place so it can not be moved",

	["about"] = "About|n|n",
	["name"] = "|cfffe6100Zygor Guides Viewer|r",
	["zgname"] = "|cfffe6100Zygor Guides|r",
	["name_plain"] = "Zygor Guides Viewer",
	["desc"] = "Zygor Guides Viewer|n© 2014 Zygor Guides|nAll Rights Reserved|nVersion %s.|n|n",
	["link"] = "www.zygorguides.com|n|n|n",
	["tech_support_header"] = "Technical Support",
	["tech_support"] = "For assistance please contact us via our Support Page or visit our Community Forums.",
	["opt_bug_button"] = "Enable Bug Reporting button on viewer",
	["quest_automation_header"] = "Quest Automation",
	["model_viewer_header"] = "Model Viewer",
	["model_viewer_no_model"] = "No model",
	["opt_guide_viewer_advanced"] = "Show Advanced Customization Options",
	["step_display_header"] = "Step Display",
	["opt_guide_step_other"] = "Other",
	
	
	['welcome_guides'] = "%d guides are loaded.",

	-- Item types and subtypes
	["type_armor"] = "Armor",
		["subtype_armor_miscellaneous"] = "Miscellaneous",
		["subtype_armor_cloth"] = "Cloth",
		["subtype_armor_leather"] = "Leather",
		["subtype_armor_mail"] = "Mail",
		["subtype_armor_plate"] = "Plate",
		["subtype_armor_shields"] = "Shields",
		["subtype_armor_librams"] = "Librams",
		["subtype_armor_idols"] = "Idols",
		["subtype_armor_totems"] = "Totems",
		["subtype_armor_sigils"] = "Sigils",
		
	["type_consumable"] = "Consumable",
		["subtype_consumable_food_drink"] = "Food & Drink",
		["subtype_consumable_potion"] = "Potion",
		["subtype_consumable_elixir"] = "Elixir",
		["subtype_consumable_flask"] = "Flask",
		["subtype_consumable_bandage"] = "Bandage",
		["subtype_consumable_item_enhancement"] = "Item Enhancement",
		["subtype_consumable_scroll"] = "Scroll",
		["subtype_consumable_other"] = "Other",
		["subtype_consumable_consumable"] = "Consumable",
	
	["type_container"] = "Container",
		["subtype_container_bag"] = "Bag",
		["subtype_container_enchanting"] = "Enchanting Bag",
		["subtype_container_engineering"] = "Engineering Bag",
		["subtype_container_gem"] = "Gem Bag",
		["subtype_container_herb"] = "Herb Bag",
		["subtype_container_mining"] = "Mining Bag",
		["subtype_container_soul"] = "Soul Bag",
		["subtype_container_leatherworking"] = "Leatherworking Bag",

	["type_gem"] = "Gem",
		["subtype_gem_blue"] = "Blue",
		["subtype_gem_green"] = "Green",
		["subtype_gem_orange"] = "Orange",
		["subtype_gem_meta"] = "Meta",
		["subtype_gem_prismatic"] = "Prismatic",
		["subtype_gem_purple"] = "Purple",
		["subtype_gem_red"] = "Red",
		["subtype_gem_simple"] = "Simple",
		["subtype_gem_yellow"] = "Yellow",

	["type_key"] = "Key",
		["subtype_key_key"] = "Key",

	["type_miscellaneous"] = "Miscellaneous",
		["subtype_miscellaneous_junk"] = "Junk",
		["subtype_miscellaneous_reagent"] = "Reagent",
		["subtype_miscellaneous_pet"] = "Pet",
		["subtype_miscellaneous_holiday"] = "Holiday",
		["subtype_miscellaneous_mount"] = "Mount",
		["subtype_miscellaneous_pther"] = "Other",

	["type_money"] = "Money",
		-- Wowpedia does not list any subtypes for this type.

	["type_reagent"] = "Reagent",
		["subtype_reagent_reagent"] = "Reagent", -- Wowpedia lists this as possibly defunct.

	["type_recipe"] = "Recipe",
		["subtype_recipe_alchemy"] = "Alchemy",
		["subtype_recipe_blacksmithing"] = "Blacksmithing",
		["subtype_recipe_book"] = "Book",
		["subtype_recipe_cooking"] = "Cooking",
		["subtype_recipe_enchanting"] = "Enchanting",
		["subtype_recipe_engineering"] = "Engineering",
		["subtype_recipe_first_aid"] = "First Aid",
		["subtype_recipe_leatherworking"] = "Leatherworking",
		["subtype_recipe_tailoring"] = "Tailoring",

	["type_projectile"] = "Projectile",
		["subtype_projectile_arrow"] = "Arrow",
		["subtype_projectile_bullet"] = "Bullet",

	["type_quest"] = "Quest",
		["subtype_quest_quest"] = "Quest",

	["type_trade_goods"] = "Trade Goods",
		["subtype_trade_goods_cloth"] = "Cloth",
		["subtype_trade_goods_cooking"] = "Cooking",
		["subtype_trade_goods_devices"] = "Devices",
		["subtype_trade_goods_elemental"] = "Elemental",
		["subtype_trade_goods_enchanting"] = "Enchanting",
		["subtype_trade_goods_explosives"] = "Explosives",
		["subtype_trade_goods_herb"] = "Herb",
		["subtype_trade_goods_item_enchantment"] = "Item Enchantment",
		["subtype_trade_goods_jewelcrafting"] = "Jewelcrafting",
		["subtype_trade_goods_leather"] = "Leather",
		["subtype_trade_goods_materials"] = "Materials",
		["subtype_trade_goods_meat"] = "Meat",
		["subtype_trade_goods_metal_stone"] = "Metal & Stone",
		["subtype_trade_goods_other"] = "Other",
		["subtype_trade_goods_parts"] = "Parts",
		["subtype_trade_goods_trade_goods"] = "Trade Goods",

	["type_weapon"] = "Weapon",
		["subtype_weapon_bows"] = "Bows",
		["subtype_weapon_crossbows"] = "Crossbows",
		["subtype_weapon_daggers"] = "Daggers",
		["subtype_weapon_guns"] = "Guns",
		["subtype_weapon_fishing_poles"] = "Fishing Poles",
		["subtype_weapon_fist_weapons"] = "Fist Weapons",
		["subtype_weapon_miscellaneous"] = "Miscellaneous",
		["subtype_weapon_one_handed_axes"] = "One-Handed Axes",
		["subtype_weapon_one_handed_maces"] = "One-Handed Maces",
		["subtype_weapon_one_handed_swords"] = "One-Handed Swords",
		["subtype_weapon_polearms"] = "Polearms",
		["subtype_weapon_staves"] = "Staves",
		["subtype_weapon_thrown"] = "Thrown",
		["subtype_weapon_two_handed_axes"] = "Two-Handed Axes",
		["subtype_weapon_two_handed_maces"] = "Two-Handed Maces",
		["subtype_weapon_two_handed_swords"] = "Two-Handed Swords",
		["subtype_weapon_wands"] = "Wands",
		
		-- Wowpedia: (for the purpose of [equipped: ] these can be used)
		["subtype_weapon_one_hand"] = "One-Hand",
		["subtype_weapon_two_hand"] = "Two-Hand",
		
	-- Not in Wowpedia, had to create this list.
	["type_glyph"]="Glyph",
		["subtype_glyph_death_knight"] = "Death Knight",
		["subtype_glyph_druid"] = "Druid",
		["subtype_glyph_hunter"] = "Hunter",
		["subtype_glyph_mage"] = "Mage",
		["subtype_glyph_monk"] = "Monk",
		["subtype_glyph_paladin"] = "Paladin",
		["subtype_glyph_priest"] = "Priest",
		["subtype_glyph_rogue"] = "Rogue",
		["subtype_glyph_shaman"] = "Shaman",
		["subtype_glyph_warlock"] = "Warlock",
		["subtype_glyph_warrior"] = "Warrior",
		
	-- Options	
	["opt_enable_viewer"] = "Enable Guide Viewer",
	["opt_guidepacks"] = "Available Guide Packs:",
	["opt_guide_steps"] = "Steps: %d",
	["opt_guide_author"] = "Author: %s",
	["opt_guide_next"] = "Next in series: %s",
	["opt_loadguide"] = "Load guide",

	["opt_profiler"] = "Profiler (caution!)",
	["opt_profiler_desc"] = "Activate built-in WoW CPU profiler that allows to investigate which Zygor function may be causing slowdowns. This option requires the restart of the game or manual interface reset (/reload command) to take effect due to game engine mechanics.",
	["opt_report"] = "Create a bug report",
	["opt_report_desc"] = "Create a bug report containing the details of the currently displayed step. Copy/paste it and email to the guide authors.",

	--["opt_group_main"] = "Main window settings",

	--["opt_minimapnotedesc"] = "Show waypoint caption",
	--["opt_minimapnotedesc_desc"] = "Show the relevant waypoint's caption not only on the waypoint's tooltip, but on the mini window as well.",
	--["opt_showgoals"] = "Show step goals",
	--["opt_showgoals_desc"] = "Show step completion goals in the mini window",
	--["opt_autosizemini"] = "Auto-size",
	--["opt_autosizemini_desc"] = "Automatically adjust the height of the mini window.",
	["opt_resizeup"] = "Flip viewer upside-down",
	["opt_resizeup_desc"] = "Flips the window upside-down, with the title bar at bottom and expanding upwards. Useful if you're placing it at the bottom of your screen.",
	--["opt_opacitymini"] = "Background opacity",
	--["opt_opacitymini_desc"] = "Opacity of step window background.",

	--["opt_showallsteps"] = "Collapsed mode",
	--["opt_showallsteps_desc"] = "Display only the current step and some next steps, instead of the whole guide",

	["opt_group_debug"] = "Debug",
	["opt_group_debug_desc"] = "Display debug info.",
	["opt_debugging"] = "Debugging",
	["opt_debugging_desc"] = "Debugging options.",
	--["opt_browse"] = "Toggle windows",
	 --["opt_browse_desc"] = "Toggle the visibility of either of Zygor's Guides windows.",

	--["opt_autoskip"] = "Advance automatically",
	--["opt_autoskip_desc"] = "Automatically skip to the next step, when all conditions are completed. You might still have to manually skip some steps that have completion conditions too complex for the guide to detect reliably.",

		["opt_visible"] = "Show the Zygor Guides Viewer window",
		["opt_visible_desc"] = "Show the Zygor Guides Viewer window",

		["opt_showmapbutton"] = "Enable minimap button",
		["opt_showmapbutton_desc"] = "Show the Zygor Guides Viewer button next to your minimap",

		["opt_debug"] = "Debug mode",
		["opt_debug_desc"] = "Enable Zygor debug mode.",

	["opt_group_talentsystem"] = "Talent Advisor",
	["opt_group_talentsystem_desc"] = "Suggests which talents you should invest your talent points in, for you to play optimally.",
		['opt_talenton'] = "Enable Talent Advisor",
		['opt_talenton_desc'] = "Turn the talent System on or off completely.",

		['opt_talent_explained'] = "Zygor Talent Advisor can be found at the right edge of the Talents window.",

		--[[
		['opt_talenticon'] = "Mark suggested talents with icons",
		['opt_talenticon_desc'] = "Show icon overlays on talent buttons to indicate Zygor's suggested talents and specializations.",

		['opt_talentpopup'] = "Do the following when new talent points are available:",
		['opt_talentpopup_desc'] = "Talent Advisor can pop up your talents frame or its own advice window, whenever new points are available for spending, or even automatically learn the suggested talents.",
		['opt_talentpopup_0'] = "Nothing",
		['opt_talentpopup_1'] = "Open the talents frame  |cffaaaaaa(for manual learning)|r",
		['opt_talentpopup_2'] = "Open the advice window  |cffaaaaaa(for one-click learning)|r",
		['opt_talentpopup_3'] = "Learn automatically  |cffffdd00(Advanced users)|r",
		--]]

	['opt_waypoints'] = "Waypointing AddOn",
	['opt_waypoints_desc'] = "Choose between default waypointing or another addon.\n|cff888888Must have other addons installed to choose other options.",
	['opt_waypoints_desc_carbonite'] = "Choose between default waypointing or another addon.\n|cff888888Must have other addons installed to choose other options.",
	['opt_minicons'] = "Show minimap icons",
	['opt_minicons_desc'] = "Show icons on the minimap",
	['opt_iconalpha'] = "Icon alpha",
	['opt_iconalpha_desc'] = "Alpha transparency of map note icons",
	['opt_iconscale'] = "Icon size",
	['opt_iconscale_desc'] = "Size of the icons on the map",



	['talentpopup_suggest'] = "Zygor Guides suggested talent.",
	['talentpopup_suggest_click'] = "|cffffff00Click|cff00ff00 to learn.",
	['talentpopup_notsuggest'] = "Zygor Guides did not suggest this talent.",

	['talentpopup_name'] = "|cffffff88Z|cffffee66y|cffffdd44g|cffffcc22o|cffffbb00r|r |cffffaa00Talent Advisor|r",
	['talentpopup_glyphsug_title'] = "Suggested glyphs:",
	['talentpopup_glyphtype_1'] = "Major",
	['talentpopup_glyphtype_2'] = "Minor",
	['talentpopup_popout_button_tip'] = "Select a target build and have the Advisor suggest talents for you to pick anytime you have talent points to spend.",
	['talentpopup_preview_button_tooltip'] = "Click to automatically select the advised choices.\n|cffff0000Warning!|r |cffffa500 This will sometimes cause an add-on conflict if you try to unlearn talents.\nTo fix this just reload your UI.",
	['talentpopup_learn_button_tooltip'] = "Click to accept the suggested talents.",
	['talentpopup_configure_button_tooltip'] = "Click to configure some Talent Advisor options. ",

	['talentpopup_start'] = "Please select a build to use Zygor Talent Advisor.",
	['talentpopup_build'] = "Choose A Build",
	['talentpopup_incorrecttalents'] = "Incorrect Talents:",
	['talentpopup_sugtalents'] = "Suggested Talents:",
	['talentpopup_sug_pet'] = "For the |cff88ff88%s|r build please pick |cff88ff88%s|r specialization for your pet.",
	['talentpopup_wrong_pet'] = "|cff8888ff%s|r is not the correct pet specialization for |cff88ff88%s|r. Switch to |cff8888ff%s|r to follow the build.",
	['talentpopup_green_pet'] = "This specialization fits your pet |cff88ff88correctly|r.",
	['talentpopup_no_pet'] = "Please summon a pet for suggestions.",

	['talentpopup_green'] = "This build fits your character |cff88ff88correctly|r.",
	['talentpopup_orange'] = "You have some |cffffbb00unlearned|r talents for the |cff88ff88%s|r build.",
	['talentpopup_red'] = "You have some |cffff0000incorrect|r talents for the |cff88ff88%s|r build.",
	['talentpopup_specred'] =  "|cffff0000Error:|r This build |cffff5555doesn't match|r your current talents. If you want to use this build, please reset your talents.",
	['talentpopup_black_badspec'] = "This is a build for a |cffffee55%s|r specialization, while you have chosen |cffffee55%s|r.\nYou'll have to reset your talents or dualspec to use this build.",
	['talentpopup_correcttalents'] = "These talents follow "..ColorTalentName.." suggested build for \n|cffffff88%s|r.\n Would you like to learn them now?",
	['talentpopup_no_spec'] = "For the |cff88ff88%s|r build please pick |cff88ff88%s|r specialization.",
	['talentpopup_wrongspec'] = "|cffff0000Warning!|r\n"..ColorTalentName.." suggests\n|cffffff88%s|r instead of |cffffff88%s|r.\nWould you like to learn |cffffff88%s|r specialization anyhow?",
	['talentpopup_goodspec'] = "This specialization follows "..ColorTalentName.."\nsuggested build for \n|cffffff88%s|r.\n Would you like to learn it now?",
	['talentpopup_wrongtalents'] = "|cffff0000Warning!|r\n"..ColorTalentName.." suggests a different set of talents for the|cffffff88 %s |rbuild.\n",
	['talentpopup_wrongtalentslearn']="Would you like to learn the selected talents anyhow?",
	['talentpopup_wrongtalentsbad'] = " instead of  ",

	['talentpopup_buildtext'] = "Current Build:",
	['talentpopup_accept'] = "Accept",
	['talentpopup_preview'] = "Preview",
	['talentpopup_configure'] = "Configure",
	['talentpopup_autolearn'] = ColorTalentName..": Learned %d talents for the %s Build.",

	["opt_group_display"] = "Guide Viewer",
	["opt_group_display_desc"] = "Main window display preferences and behaviour.",

		
		['opt_guidesinhistory'] = "Number of recent guides",
		['opt_guidesinhistory_desc'] = "Show this many recently used guides. Set to more especially if you're switching between reputation or daily guides often.",

		['opt_skin'] = "Window skin",
		['opt_skin_desc'] = "Choose a skin for the main window.",
		['opt_skinstyle'] = "Viewer skin:",
		['opt_skinstyle_desc'] = "Each skin may have multiple sub-styles.",

		["opt_opacitymain"] = "Opacity",
		["opt_opacitymain_desc"] = "Opacity of the main Viewer window.",
		["opt_framescale"] = "Scale",
		["opt_framescale_desc"] = "You can resize the window to match your preferences.",
		["opt_fontsize"] = "Primary text size",
		["opt_fontsize_desc"] = "Set your preferred text size. Note that the window scale affects this, too.",
		["opt_fontsecsize"] = "Secondary text size",
		["opt_fontsecsize_desc"] = "Set your preferred secondary text size, used to display additional descriptions and notes.",

		['opt_windowlocked'] = "Lock viewer in place",
		['opt_windowlocked_desc'] = "Prevents the window from being dragged with the mouse.",
		["opt_hideincombat"] = "Hide viewer while in combat",
		["opt_hideincombat_desc"] = "Hide all guide windows during combat, if your screen gets too cramped.",

		["opt_prisecmodes"] = "Display modes",
		["opt_modes_desc"] = "The addon features two display modes, for easy switching between them.\nUsually one is compact and used for gameplay, and the other is more verbose for browsing the guides.",
		["opt_modeactive"] = "Active",
		["opt_primary"] = "Primary mode:",
		["opt_secondary"] = "Secondary mode:",

		["opt_showcountsteps"] = "Number of steps shown:",
		["opt_showcountsteps_desc"] = "|cffffffaaAll|r displays all steps in a scrollable list.\n|cffffffaa1-5|r shows the current step at the top, and auto-resizes the window to show several future steps only.",
		["opt_showcountsteps_all"] = "All",
		["opt_showbriefsteps"] = "Brief steps",
		["opt_showbriefsteps_desc"] = "Display only completable objectives of steps for a compact, TourGuide-like format.",
		["opt_hidecompletedinbrief"] = "•  Hide completed",
		["opt_hidecompletedinbrief_desc"] = "When checked, goals in incomplete steps will become hidden once completed.\nCompleted goals in completed steps will still be visible.",
		['opt_hideborder'] = "Hide viewer controls",
		['opt_showborder'] = "Show viewer controls",
		['opt_hideborder_desc'] = "Automatically hide the window's border and buttons, when the mouse is away from it.\nHover for a moment over the window's title to bring it back.",
		['opt_nevershowborder'] = "•  Completely",
		['opt_nevershowborder_desc'] = "When the border is hidden, by default it will reappear after 2 seconds of hovering your mouse over it.\nWhen this option is checked, you'll have to right-click the step and use the 'Show Controls' option there to display them again.",

		['opt_briefopentime'] = "Brief expansion delay",
		['opt_briefopentime_desc'] = "How long you have to hover your mouse over a brief step for it to expand.",
		['opt_briefclosetime'] = "Brief collapse delay",
		['opt_briefclosetime_desc'] = "How long an expanded brief step stays expanded before collapsing again.",

		['opt_resetwindow'] = "Reset windows",
		['opt_resetwindow_desc'] = "If you accidentally move the guide window off-screen and can't move it back, this button resets it to the screen center.",

	["opt_group_step"] = "Guide step display",
	["opt_group_step_desc"] = "How guide steps are formatted and coloured.",

		['opt_showstepborders'] = "Step backgrounds",
		['opt_showstepborders_desc'] = "Show coloured backgrounds around whole steps.",
		['opt_stepbackalpha'] = "Background opacity",
		['opt_stepbackalpha_desc'] = "Opacity of the step's background.\nThe background's color matches the completion status.",
		['opt_stepnumbers'] = "Show step numbers",
		['opt_stepnumbers_desc'] = "Display step numbers and suggested levels for each step.\nTurn off to conserve screen space.",

		['opt_goaltotals'] = "Show goal totals",
		['opt_goaltotals_desc'] = "Show numeric goal completion:|n|cffff8888(5/10)|r",

		["opt_goalicons"] = "Objective icons",
		["opt_goalicons_desc"] = "Display icons for objective types and completion status.",
		["opt_goalcolorize"] = "Color completed objective text",
		["opt_goalcolorize_desc"] = "When completing step objectives, colorize them entirely green.",

		["opt_goalcolor_completion_desc"] = "Completion:",
		["opt_goalcolor_other_desc"] = "Status:",

		["opt_goalbackcolor_desc"] = "Completion colors:",
		["opt_goalbackgrounds"] = "Color backgrounds",
		["opt_goalbackprogress"] = "Color progressively",
		["opt_goalbackprogress_desc"] = "Show progress as intermediary colors, from 'incomplete' through 'halfway' to 'complete'.|nIf unchecked, objectives are displayed only using 'incomplete' or 'complete' colors.",

		["opt_goalbackgrounds_desc"] = "Color step line backgrounds to reflect completion status.",
		["opt_goalbackcomplete"] = "Complete",
		["opt_goalbackcomplete_desc"] = "This color will indicate completed objectives or steps.",
		["opt_goalbackincomplete"] = "Incomplete",
		["opt_goalbackincomplete_desc"] = "This color will indicate incomplete objectives, currently in progress.",
		["opt_goalbackprogressing"] = "Halfway",
		["opt_goalbackprogressing_desc"] = "This color will indicate objectives at 50% completion.",
		["opt_goalbackimpossible"] = "Impossible",
		["opt_goalbackimpossible_desc"] = "Use this color to indicate objectives impossible to complete at this time.",
		["opt_goalbackwarning"] = "Warning",
		["opt_goalbackwarning_desc"] = "Use this color to indicate an objective that should be possible at this point, but is not.\nThis happens if you fail a quest or skip some important step, and need to backtrack a few steps.",

		["opt_progressbackcolor_desc"] = "Step colors:",
		["opt_goalbackaux"] = "Travel",
		["opt_goalbackaux_desc"] = "Use this color to indicate travel steps.",
		["opt_goalbackobsolete"] = "Obsolete",
		["opt_goalbackobsolete_desc"] = "Use this color to indicate obsolete objectives or steps.",

		['opt_tooltipsbelow'] = "Show hints and tips",
		['opt_targetonclick'] = "Add raid marker to NPC when clicking on a step",

		['opt_tooltipsbelow_desc'] = "Extra information about certain step lines can be displayed either inline, or as tooltips shown on mouseover.",

	["opt_flash_desc"] = "Flash Animations",
	["opt_goalupdateflash"] = "On goal progress",
	["opt_goalupdateflash_desc"] = "Use a 'flash' indication when a single goal is progressed.",
	["opt_goalcompletionflash"] = "On goal completion",
	["opt_goalcompletionflash_desc"] = "Use a 'flash' indication when a single goal is completed.",
	["opt_flashborder"] = "Flash whole window",
	["opt_flashborder_desc"] = "Flash the whole window whenever a step is completed.",

	--[[	-- obsolete stuff

		['opt_backopacity'] = "Background opacity",
		['opt_backopacity_desc'] = "Opacity of the window's background.",

		['opt_trackchains'] = "Track chained quests",
		['opt_trackchains_desc'] = "Mark quest-accept steps as unavailable if a prerequisite quest wasn't completed.\n\nThe quest chain database includes \"loose chains\", quests that follow each other but don't actually need to be completed in proper order, so sometimes a quest-accept line might be displayed as unavailable even though the quest can be accepted. We'll appreciate your help in finding all quests that behave like that.",
		["opt_colorborder"] = "Color step window border",
		["opt_colorborder_desc"] = "Use the step window border's color to indicate completion of the whole step.",

		["opt_backcolor"] = "Background colour",
		["opt_backcolor_desc"] = "The background colour of the window.",

		["opt_group_window"] = "Window features",

		["opt_group_data"] = "Stored guides",
		["opt_group_data_desc"] = "Zygor Guides Viewer can internally store commercial guides that cannot (due to Blizz policy) be distributed as standalone addons.",
		["opt_group_data_guide"] = "Guides stored internally:",
		["opt_group_data_guide_desc"] = "Select a stored guide from this list to edit or delete it. This list does NOT show guides that are loaded as separate addons.",
		["opt_group_data_del"] = "Delete guide",
		["opt_group_data_del_desc"] = "Delete the selected guide from internal storage.",
		["opt_group_data_edit"] = "Edit guide",
		["opt_group_data_edit_desc"] = "Load the selected guide into the editor window below for hands-on fixes.",
		["opt_group_data_entry"] = "Guide data:",
		["opt_group_data_entry_desc"] = "Paste a new guide here (remember to wrap its steps in:|nguide Title Of Guide|nsteps...|nsteps...|nend\n); note that pasting and parsing of a large guide (>30kB) may take a few seconds.",
	--]]

	--["opt_group_waypointer"] = "Internal Waypointer",
	--["opt_group_waypointer_desc"] = function() return "The internal map node display and waypointing system." .. (ZGV.db.profile.waypointaddon~="internal" and "|n|cffff8888You're using an external waypointing addon. These settings are not used." or "") end,

	['opt_group_progress'] = "Step completion",
	--['opt_group_progress_desc'] = "To ensure optimal leveling progress, this addon will suggest moving to the next quest hub's section as soon as you outlevel your current area.",
	['opt_group_progress_desc'] = "This section governs how various types of guide steps are auto-completed.",

	['opt_skipnotify'] = "Obnoxious skipping pop-up",
	['opt_skipnotify_desc'] = "If checked, a pop-up window will appear each time a guide skip is available. If not, you'll just get a message and see the guide selection button flash.",
	['opt_skipnotify_none'] = "Message and .",
	['opt_skipauxsteps'] = "Skip travel steps",
	['opt_skipauxsteps_desc'] = "Automatically skip travel steps if they're followed by already completed or low-level steps.\nThis avoids sending you halfway across the world in vain.",
	['opt_skipflightsteps'] = "Assume flight paths known",
	['opt_skipflightsteps_desc'] = "Assume you are handling flight path discovery yourself, and automatically skip \"Learn flight path\" steps.\n\nUseful when trying to find a starting spot in the guides, but not very useful during normal gameplay.",
	['opt_skipimpossible'] = "Skip impossible steps",
	['opt_skipimpossible_desc'] = "Automatically skip impossible steps, if you don't want to be bothered with objectives belonging to quests you don't have.\n\nThis should only be turned off as an emergency measure if the guide skips steps it shouldn't be skipping, but such behaviour should be reported as a bug.",
	['opt_skipflysteps'] = "Hide flight path travel steps",
	['opt_skipflysteps_desc'] = "Skips steps instructing you to use a Flight Path to travel if you have a fast personal flying mount.",
	['opt_dontprogress'] = "Disable step progress (careful!)",
	['opt_dontprogress_desc'] = "Disable automatic step progress. Steps will complete, but you'll have to advance to the next step manually.\n\nThis can allow you to follow already completed guides, without the addon starting to run through subsequent completed steps.",

	['opt_levelsahead'] = "Allow |cffccffcc%s|r levels ahead",
	['opt_levelsahead_desc'] = "This setting controls how far ahead of the guide do you want to be able to play, before quests are marked too low level for you.\n\nIt's not really practical to set it to more than 5, you'll probably be better off disabling Dynamic Progress completely instead.",
	['opt_chainskip'] = "Complete started quest chains%s",
	['opt_chainskip_desc'] = "Some quest chains have valuable items awarded when entirely completed. This setting forces Dynamic Progress not to break off a quest chain if it only has a few more quests to complete.",
	['opt_chainskip_count'] = "|cffffeecc  (unless more than %s quests left)",
	['opt_chainskip_compl'] = "|cffccffcc  (always)",
	['opt_chainskipcount'] = "  - Break off:",
	['opt_chainskipcount_desc'] = "Less means break off early. More means stick with longer remaining chains.",

	--[[
	['opt_group_progress_bottomdesc'] = "Dynamic progress works by skipping quests (or whole quest chains) that are meant to be completed below your current level, so that you're pushed onto higher-level sections of the guide. Quest chains are only skipped if the whole chain is low-level, however, so if you're level 30, a quest for level 20 that chains up to level 33 is still considered valid for you.\
\
This helps new guide users to find a proper starting spot, and ensures that the guide will never slow you down by giving you low-level quests, if you gain levels faster than the guide expects (if you run some dungeons, use heirlooms, or have the rested exp bonus).\
\
You can set by how many levels ahead of the guide you want to be able to go, before the guide starts skipping quests and pushing you forward.\
\
If you're new to the guides, or have only started using them on this character, you can use the |cffddff00Smart Injection System|r to automatically find a proper starting spot for you. It might turn out to be far below your current level, if you skipped some useful quest chains or flight points, but the guide will catch up once you complete them.",
	--]]
	['opt_group_progress_bottomdesc'] = "",

	['opt_group_arrow'] = "Waypoint Arrow",
	['opt_group_arrow_desc'] = "These settings control the direction arrow and map markers.",

	["opt_group_map_waypointing"] = "Waypointing AddOn",
	["opt_group_map_waypointing_desc"] = "Select the addon that you'd like to handle the waypoints for Zygor Guides Viewer.",
	["opt_group_addons_internal"] = "Zygor Waypoint Arrow",
	["opt_group_addons_tomtom"] = "TomTom",
	["opt_group_addons_carbonite"] = "Carbonite",
	["opt_group_addons_cart2"] = "Cartographer 2",
	["opt_group_addons_cart3"] = "Cartographer 3",
	["opt_group_addons_metamap"] = "MetaMap",
	["opt_group_addons_none"] = "none",

	--['opt_group_mapinternal'] = "Internal waypointer",
		['opt_arrowshow'] = "Enable Waypoint Arrow",			['opt_arrowshow_desc'] = "Display a rotating arrow, indicating the direction towards the current waypoint.",

		['opt_hidearrowwithguide'] = "Hide Waypoint Arrow when viewer is closed",
		['opt_hidearrowwithguide_desc'] = "Select this to make the arrow follow the guide window's visibility.\nLeave unchecked if you want the arrow to stay visible when you hide the guides.",

		['opt_arrow_display'] = "Arrow look and feel:",
			['opt_arrowsmooth'] = "Smooth rotation",			['opt_arrowsmooth_desc'] = "Add a slight drag to the arrow's rotation. Purely cosmetic.",
			['opt_arrowfreeze'] = "Lock arrow in place",			['opt_arrowfreeze_desc'] = "Make the pointer arrow transparent to mouse clicks.",
			--['opt_arrowcam'] = "Arrow follows camera",	 		['opt_arrowcam_desc'] = "Show directions basing on the direction the camera is turned. If unchecked, the pointer arrow shows directions basing only on where your character is facing.\n\nNote: in camera mode, the arrow might point in weird directions when using click-to-move.",
			['opt_arrowcolordist'] = "Color by distance",		['opt_arrowcolordist_desc'] = "Color the arrow by distance, instead of by direction.",
			['opt_arrowscale'] = "Scale",					['opt_arrowscale_desc'] = "Set the size of the waypointing arrow.",
			['opt_arrowalpha'] = "Opacity",					['opt_arrowalpha_desc'] = "Set the opacity of the waypointing arrow.",
			['opt_arrowfontsize'] = "Arrow font size",			['opt_arrowfontsize_desc'] = "Set the size of the labels under the arrow.",
			['opt_mapcoords'] = "Show coordinates",			['opt_mapcoords_desc'] = "Display player and cursor coordinates on the world map.",
			--['opt_arrowmeters'] = "Use metric system",			['opt_arrowmeters_desc'] = "Use meters and kilometers instead of yards and miles.",
			['opt_arrowunit'] = "Units to use for waypoint arrow",		['opt_arrowunit_desc'] = "Select the unit system to use for the waypoint arrow.",
		['opt_arrow_extras'] = "Additional arrow functions:",
			['opt_corpsearrow'] = "Point to corpse upon death",
			['opt_corpsearrow_desc'] = "Use the waypointer arrow to point towards your corpse upon death - if your waypointer of choice doesn't by itself.",
			['opt_corpsearrowjokes'] = "Corpse humour",
			['opt_corpsearrowjokes_desc'] = "Having your demise mocked might teach you to be more careful next time. Or, it might strip you of your cares and make you accept death as a natural part of life. Your mileage may vary.",


	['opt_group_travelsystem'] = "Travel System",			['opt_group_travelsystem_desc'] = "Adjust your settings for the travel system.",
		['opt_pathfinding'] = "Enable Travel System",		['opt_pathfinding_desc'] = "Automatically find a route to destination.",
		['opt_pathfinding_mode'] = "Route preference",		['opt_pathfinding_mode_desc'] = "Find absolute fastest routes using every travel trick possible,\nor maximize travel comfort by prioritizing flight paths.",
		['opt_pathfinding_mode_1fastest'] = "Fastest, use every trick",		['opt_pathfinding_mode_1fastest_desc'] = "Use every trick in the bag to give you\na fast route, but requiring manual attention.",
		['opt_pathfinding_mode_2nocd'] = "Fast, without items",		['opt_pathfinding_mode_2nocd_desc'] = "Find fast routes, but don't use the Hearthstone\nor other cooling-down items.",
		['opt_pathfinding_mode_3lazy'] = "Comfortable, prefer flights",		['opt_pathfinding_mode_3lazy_desc'] = "Pick most comfortable routes,\nmaximizing the use of flights and portals.\nFire and forget.",

		['opt_ants'] = "Animated map dots (\"ant trails\")",
		['opt_customcolorants'] = "Customize ant colors",		['opt_customcolorants_desc'] = "Choose your own ant colors",
		['opt_singlecolorants'] = "Single custom color",		['opt_singlecolorants_desc'] = "Use a single color for all ants",
		['opt_singlecolorantscolor'] = "Set color",			['opt_singlecolorantscolor_desc'] = "Set this color to use for all ants",
		['opt_colorantstaxi'] = "Flight path",				['opt_colorantstaxi_desc'] = "Use this color to indicate a flight path",
		['opt_colorantsship'] = "Ship",					['opt_colorantsship_desc'] = "Use this color to show use of a ship",
		['opt_colorantsfly'] = "Flying Mount",				['opt_colorantsfly_desc'] = "This color will be used for a flying mount",
		['opt_colorantsportal'] = "Portal",					['opt_colorantsportal_desc'] = "Use this color to for portal, hearthstone, or teleport use",
		['opt_colorantsother'] = "Normal",				['opt_colorantsother_desc'] = "This color will be used for normal (ground) travel",

		["opt_travel_system_advanced"] = "Show Advanced Customization Options",

		['opt_antspacing'] = "Ant density",			['opt_antspacing_desc'] = "Sets how dense are 'ant trails' displayed on navigation paths.\n\nDense ant trails cause a heavier performance hit.",
		['opt_antspacing_0'] = "Ants off",
		['opt_antspacing_yd'] = "%d yd apart",
		['opt_antspacing_yd_def'] = "%d yd apart (default)",
		['opt_antspeed'] = "Animation smoothness",			['opt_antspeed_desc'] = "This sets how smooth the map dots animation is. Higher values cause a bigger performance hit.",
		['opt_antspeed_vslow'] = "Minimal",
		['opt_antspeed_slow'] = "Low",
		['opt_antspeed_normal'] = "Normal (default)",
		['opt_antspeed_fast'] = "Smooth",
		['opt_antspeed_full'] = "Very smooth",
		['opt_pathfinding_speed'] = "Route calculation speed", ['opt_pathfinding_speed_desc'] = "Set how intensive Travel calculations can get. Fast calculations can cause FPS drops or brief freezes (\"lag\").",
		['opt_pathfinding_subdesc'] = "Travel System automatically recalculates every 30 seconds in motion, and once after a second of standing still.",
		['opt_pathfinding_speed_slow'] = "Slow (less intensive)",
		['opt_pathfinding_speed_medium'] = "Medium",
		['opt_pathfinding_speed_fast'] = "Fast (more intensive)",

		['opt_foglight'] = "Reveal whole map",				['opt_foglight_desc'] = "Reveal unexplored areas on the map.",
		['opt_progress'] = "Show progress bar",				['opt_progress_desc'] = "Show the bar at the bottom of the Zygor Guide frame.",
		['opt_progresscolor'] = "Progress bar",				['opt_progresscolor_desc'] = "Change this color to modify the color of  your progress bar.",
		['opt_minimapzoom'] = "Automatic minimap zooming",	['opt_minimapzoom_desc'] = "Automatically zoom in your minimap when approaching the destination.",
		['opt_flashmapnodes'] = "Flash minimap resource nodes",	['opt_flashmapnodes_desc'] = "Continuously flash minimap nodes for herbs, ores and battle pets, making them stand out more.",
		['opt_autotrackquests'] = "Automatically track guide quests [DEBUG]",	['opt_autotrackquests_desc'] = "Automatically track guide quests to show their areas of interest on the minimap.\n\nNote: you can always click an objective to have it tracked and pointed to, regardless of this setting.",
		['opt_audiocues'] = "Audible direction cues",	 		['opt_audiocues_desc'] = "Provides audible navigation signals if you leave your character unattended.\n\nWith these, you can safely turn to precisely face the target waypoint, start flying forward, and Alt-Tab out or go make some coffee.\nWhen arriving at the destination, a 'boat bell' sound is played. When the destination is no longer straight ahead and you're going to fly past it, a 'warning zap' is played.",

		['opt_group_conv'] = "Extras",			['opt_group_conv_desc'] = "Various things that we thought might be useful.",

			['waypoint_mapping_header'] = "Waypoint Arrow and Mapping",
			['questing_enhancements_header'] = "Questing Enhancements",
			['creature_detector_header'] = "Creature Detector",
			['pet_battle_hud_header'] = "Pet Battle HUD",
			['other_header'] = "Other",
		
		['opt_inventorymanage'] = "Vendor Tools",
		['opt_inventorymanage_desc'] = "Vendor tools options",

		['opt_im_enable'] = "Enable inventory status bar",
		['opt_mail_enable'] = "Enable Mail Tools",
		['opt_auction_enable'] = "Enable Auction Tools",
		['opt_im_autohide_icons'] = "Automatically hide icons",
		['opt_im_prefer_repair'] = "Only find repair vendors",
		['opt_resetim'] = "Reset Inventory Manager",		['opt_resetim_desc'] = "(DEBUG) Reset Inventory Manager completely, wiping all settings!",

		['opt_mail_tools'] = "Mail Tools",
		['opt_mail_tools_desc'] = "Mail Tools",

		['opt_auction_tools'] = "Auction Tools",
		['opt_auction_tools_desc'] = "Auction Tools",

		['opt_autoscan'] = "Auto scan when auction panel is opened",			['opt_autoscan_desc'] = "Automatically scan the auction house when it opens.",
		['opt_smartstack'] = "Enable smart stacks",			['opt_smartstack_desc'] = "Automatically determines an optimal stack size to auction.",

		['opt_autoquest'] = "Quest automation",
		['opt_autoaccept'] = "Auto accept quests",					['opt_autoaccept_desc'] = "Automatically accept quests, if the current step instructs you to.\n|cffffaa88This makes questing very fast, but may be confusing.",
		['opt_autoturnin'] = "Auto turnin quests",					['opt_autoturnin_desc'] = "Automatically turn in quests, if the current step instructs you to.\nWorks only if there is no reward to choose.\n|cffffaa88This makes questing very fast, but may be confusing.",
		['opt_autoaccept_all'] = "Accept all quests",					['opt_autoaccept_desc'] = "Automatically accept all quests you come across.\n|cffffaa88This makes questing very fast, but may be confusing.",
		['opt_autoturnin_all'] = "Turn in all quests",					['opt_autoturnin_desc'] = "Automatically turn in all quests.\nWill only select item rewards if Auto-select quest reward is on.\n|cffffaa88This makes questing very fast, but may be confusing.",
		['opt_autoacceptturninall_'] = "Auto accept all quests",			['opt_autoacceptturninall__desc'] = "Auto-accept or turn in ANY quest, even if not following a guide.",
		['opt_autoacceptturninall_accept'] = "Accept any quest",			['opt_autoacceptturninall_accept_desc'] = "Auto-accept ANY quest, even if not following a guide.",
		['opt_autoacceptturninall_turnin'] = "Turn in any quest",			['opt_autoacceptturninall_turnin_desc'] = "Turn in ANY quest, even if not following a guide.",
		['opt_autoacceptturninall_acceptturnin'] = "Accept/turn in any quest",	['opt_autoacceptturninall_acceptturnin_desc'] = "Auto-accept or turn in ANY quest, even if not following a guide.",
		['opt_autoacceptshowobjective'] = "Announce auto-accepted quests",	['opt_autoacceptshowobjective_desc'] = "When auto-accepting all quests, display the quest objective.\nJust in case you didn't notice what quest was accepted.",
		['opt_fixblizzardautoaccept'] = "'Fix' low level accepting",	['opt_fixblizzardautoaccept_desc'] = "Since patch 3.2, quests for levels 1-3 get automatically accepted, but the quest window stays open, which confuses some players.\nThis option changes the 'Accept' button into 'Accepted' to make it feel more natural.",
		['opt_item'] = "Items",							['opt_item_desc'] = "Set the different features that deal with items.",
		
		['opt_enable_vendor_tools'] = "Enable Vendor Tools",
		['opt_autosell'] = "Automatically sell gray items",			['opt_autosell_desc'] = "Automatically sells gray items when a vendor window is opened.\n|cffffaa88Will sell all gray items in inventory.",
		['opt_autosellother'] = "Automatically sell unusable items that cannot be auctioned",			['opt_autosellother_desc'] = "Automatically sells items that are not considered upgrades when a vendor window is opened.",
		['opt_autobuy'] = "Automatically buy guide items",				['opt_autobuy_desc'] = "Automatically buy the items in the current step of your guide when the vendor is opened.\n|cffffaa88Will not buy any items if you don't have enough money for all of them.",
		['opt_autobuyframe'] = "Confirm before buying",				['opt_autobuyframe_desc'] = "Show the confirm window when current step is to purchase crafting materials and a vendor with the materials is opened.",
		['opt_showgreyvalue'] = "Show value of grays",				['opt_showgreyvalue_desc'] = "Show window to view value of current gray items.",
		['opt_showgreysellbutton'] = "Show vendor button",			['opt_showgreysellbutton_desc'] = "Show the button to automatically sell gray items in the vendor window.",
		['opt_confirm_selling'] = "Confirm before selling",
		
		['opt_analyzereps'] = "Detailed reputation gains",			['opt_analyzereps_desc'] = "Display verbose reputation gain messages in chat, showing percentage gained and next standing.",
		['opt_autotaxi'] = "Take flights automatically",			['opt_autotaxi_desc'] = "Automatically take taxi flights, when talking to a flightmaster, if the travel system suggests it.",
		['opt_detectcreatures']= "Enable Creature Detector",		['opt_detectcreatures_desc']= "Display a shortcut on the unitframe to open the guide corresponding to a selected mount or pet.",
		['opt_quiet'] = "Suppress chat messages",			['opt_quiet_desc'] = "Prevent Zygor messages from appearing in chat. Use this when Zygor spams your chat with error messages.",
		['opt_collapsecompleted'] = "Hide completed lines",		['opt_collapsecompleted_desc'] = "Hides completed goals together with their 'parent' lines.|n|n|cffff3300Experimental feature.|r",

		['opt_highlight'] = "Highlight current objective",


	['opt_group_petbattle'] = "Pet Battle",		['opt_group_petbattle_desc'] = "Features enhancing your Pet Battles experience.",
		['opt_petbattleframe'] = "Enable Pet Battle HUD",			['opt_petbattleframe_desc'] = "Shows the information frame that is visible when you enter a pet battle.",

	-- Gold Guide V2!

	-- Renamed to Inventory Management
	['opt_group_gold'] = "Inventory Management",							['opt_group_gold_desc'] = "Gold Guide Words",
		['opt_goldimport'] = "Import",				['opt_goldimport_desc'] = "Import desc",


	--['opt_group_gold'] = "Gold Guide",
	--['opt_group_gold_desc'] = "These options control the behaviour of Zygor Gold Guides.",
		['opt_gold_ahscanintensity'] = "Auction Fast Scan intensity",
		['opt_gold_ahscanintensity_desc'] = "Too intense Fast Scans can overload the game servers.\nIf you experience disconnections when performing a scan, lower this value.\nYour scans will be slower, but less likely to disconnect.",
		['opt_gold_ahscanintensity_low'] = "Low",
		['opt_gold_ahscanintensity_default'] = "Default",
		['opt_gold_ahscanintensity_high'] = "High",

		['opt_gold_appraiser_undercut'] = "Appraiser selling price undercut",
		['opt_gold_appraiser_undercut_desc'] = "Set by how much should undercut auctions when setting prices for posting.",
		['opt_gold_appraiser_undercut_none'] = "No undercut",
		['opt_gold_appraiser_undercut_1p'] = "1%",
		['opt_gold_appraiser_undercut_2p'] = "2%",
		['opt_gold_appraiser_undercut_5p'] = "5%",
		['opt_gold_appraiser_undercut_10p'] = "10%",
		['opt_gold_appraiser_undercut_20p'] = "20%",
		['opt_gold_appraiser_undercut_1c'] = "1 copper",

		['opt_golddisplay'] = "Gold display",
		['opt_gold_format'] = "Money strings format",
		['opt_gold_format_white'] = "Use only white color",


	--[[ Gold Guide options
		['opt_gold_detectiondist'] = "Detection distance",
		['opt_gold_detectiondist_desc'] = "Controls at what distance are the gold-making locations considered 'near'.",
		['opt_gold_reqmode'] = "Filter locations by profession",
		['opt_gold_reqmode_desc'] = "Decide whether to show all locations (mining areas, skinning, etc.) regardless of the character's professions, or only those that can really be used.",
		['opt_gold_reqmode_all'] = "Show all locations",
		['opt_gold_reqmode_future'] = "Current professions, but ignore level",
		['opt_gold_reqmode_current'] = "Current profession levels",
	--]]
	
	['opt_gold_profitlevel'] = "Profit balance",
	['opt_gold_profitlevel_desc'] = "Choose a balance between making a profit fast (but poor) and earning high (but slowly).",
	['opt_gold_profitlevel_fastest'] = "Fastest (but lowest)",
	['opt_gold_profitlevel_fast'] = "Fast (but low)",
	['opt_gold_profitlevel_medium'] = "Balanced",
	['opt_gold_profitlevel_slow'] = "High (but slow)",
	['opt_gold_profitlevel_slowest'] = "Highest (but slowest)",

	['opt_group_gear'] = "Gear System",	['opt_group_gear_desc'] = "Configure the system used for suggesting new armor and weapons, scoring them according to your spec.\nNote: Gear is optimized for PvE stats.",
		['opt_autogear'] = "Enable Gear System",				['opt_autogear_desc'] = "Reminds you to upgrade your gear as new items are acquired.\nNote: enabling this requires a reload.",
		['opt_autogearauto'] = "Auto-equip gear upgrades",			['opt_autogearauto_desc'] = "Upgrades are equipped without confirmation.",
		['opt_clearnotupgrades'] = "Clear declined items",			['opt_clearnotupgrades_desc'] = "All manually declined items are reset.\n\n|cffffaa88This might cause the suggestion pop-up to appear again on previously declined items, if you're still carrying them around.",
	['gear_quest_reward_advisor_header'] = "Quest Reward Advisor",
		['opt_questitemselector'] = "Highlight suggested quest rewards",				['opt_questitemselector_desc'] = "Highlight quest reward to quickly see the best selection. Process looks at class and spec and picks the biggest upgrade for you from the quest items. If no upgrades are available then picks the item that has the highest vendor value.\n|cffffaa88Does not take off specs into account.",
		['opt_autoselectitem'] = "Auto-select and collect quest rewards",				['opt_autoselectitem_desc'] = "Automatically choose the quest rewards that are selected.\n|cffffaa88No known issues, but item selection process may not be perfect.",


	opt_group_modelviewer = "Model Viewer",
	--opt_group_modelviewer_desc = "View mentioned NPCs, monsters and objects",
	opt_group_modelviewer_desc = "Display NPCs, monsters or clickable objects mentioned by the guide in a small window attached to the guides.",
		opt_mv_enabled = "Enable Model Viewer",
		opt_mv_enabled_desc = "Displays the Model Viewer window",
		opt_mv_rotation = "Rotate models",
		opt_mv_rotation_desc = "Slowly spin displayed models to present them from all angles.",
		opt_mv_slideshow = "Slide show",
		opt_mv_slideshow_desc = "On steps referring to multiple creatures, display them one after another in a slide show.",
		opt_mv_reset = "Reset windows",
		--opt_mv_slideshow_desc = "Reset the model viewer window, re-anchor it to the main viewer window.",

	opt_group_notification = "Notification Center",								opt_group_notification_desc = "Manage Creature Detector, pop-ups, and other features that can be completed as you need.",
		opt_n_nc = "Notification Center",
			opt_n_nc_enabled = "Enable Notification Center",				opt_n_nc_enabled_desc = nil,
			opt_n_nc_locked = "Lock Notification Center in place",					opt_n_nc_locked_desc = "Lock the notification center in place so it can not be moved",
			opt_n_nc_no_popups = "Send pop-ups to Notification Center",		opt_n_nc_no_popups_desc = "If a pop-up can be sent to the Notification Center then it will automatically appear there and not pop-up.",
			opt_n_nc_hide_text = "Hide Notification Text",					opt_n_nc_hide_text_desc = "Hide the text that appears next to the icons in the notification center.\nThis will also hide the title.",
			opt_n_nc_numpetguides = "Max Creature Detector Entries Stored",						opt_n_nc_numpetguides_desc = "Set the max number of pet and mount guides that can appear in the Notification Center.",
			opt_n_nc_alwaysshow = "Always show Notification Center",
		opt_n_popups = "Pop-up Notifications",
			opt_n_popup_hideall = "Hide all pop-ups when Guide Viewer is closed",			opt_n_popup_hideall_desc = "This will suppress all pop-ups when the Zygor Guide Viewer is closed.\nIf disabled, only pop-ups not guide related will show up.",
			opt_notify_following = "Notify me of the following:",
				opt_n_popup_guides = "Guide suggestions",						opt_n_popup_guides_desc = "Show pop-ups suggesting another guide, when proper requirements are met.",
				opt_n_popup_sis = "Smart Injection System suggestions",							opt_n_popup_sis_desc = "Display a pop-up window suggesting the next leveling guide.",
				opt_n_popup_dungeon = "Dungeon suggestions",					opt_n_popup_dungeon_desc = "Display a pop-up window suggesting the guide for a dungeon when you enter the dungeon.",
				opt_n_popup_monk = "Monk quests",								opt_n_popup_monk_desc = "Display a pop-up window for Monk class quests every 10 levels and for the daily.",

	opt_group_magickey = "Magic Key",
	opt_group_magickey_desc = "The 'Magic Key' is a dynamic do-it-all keybinding, doing its best to adapt itself to your current situation and provide the action you'll most likely want to perform.|n|cffff8888This is a 'beta' feature. It is still under development and may not work properly.|r",
		opt_magickey = "Magic Key keybinding",
		opt_magickey_desc = "Choose a convenient key binding, as you will likely use this one a lot.\n\nRemove the binding to disable this feature.",
		opt_magickey_actionsdesc = "Select the actions you want the Magic Key to perform for you:",
		opt_magickey_target = "Target NPCs and monsters",
		opt_magickey_target_desc = "Target quest NPCs mentioned in 'talk to' lines, or monsters mentioned in 'kill' objectives.",
		opt_magickey_talk = "Talk to quest NPCs",
		opt_magickey_talk_desc = "Run up to targeted quest NPCs and talk to them. This simulates a right-click on an NPC. You'll need to be within about 50 yards for the running to work.",
		opt_magickey_acceptturnin = "Accept / Turn in quests",
		opt_magickey_acceptturnin_desc = "Proceed through quest accept / turn in dialogue.",
		opt_magickey_attack = "Attack monsters",
		opt_magickey_attack_desc = "Start auto-attacking a targeted monster. This simulates a right-click on an NPC. Probably not very useful for casters...",
		opt_magickey_targetcorpse = "Target corpses",
		opt_magickey_targetcorpse_desc = "Quickly after killing a monster, target it again for looting.",
		opt_magickey_loot = "Loot corpses",
		opt_magickey_loot_desc = "Run and loot a targeted corpse.",
		opt_magickey_itemspell = "Use items/spells",
		opt_magickey_itemspell_desc = "Use the first item or spell mentioned in the current step.",
		opt_magickey_hint = "Show current function",
		opt_magickey_hint_desc = "Display the function the Magic Key is currently going to perform.",

	["opt_arrowskin"] = "Arrow style",
	["opt_arrowskin_desc"] = "Select a skin for your rotating arrow.\nDifferent skins might not only look, but behave differently, too.",
	["opt_arrowskinselect"] = "Arrow style",
	["opt_arrowskinselect_desc"] = "Select a skin for your rotating arrow.\nDifferent skins might not only look, but behave differently, too.",

	["opt_sticky_subgroup"] = "Sticky Steps",
	
	['opt_way'] = "Set a destination waypoint",

	opt_group_sticky = "Sticky steps",
	opt_group_sticky_desc = "Some quests take place in the same area, and you can complete several objectives at the same time, without wasting time. For this to work, guide steps featuring future objectives can be shown earlier, as \"stuck\" to your current step, giving you a heads-up and allowing you to quest even faster.",
	opt_stickyon = "Enable Sticky Steps",
	opt_stickyon_desc = "Sticky future steps under current steps when they can be completed simultaneously",
	opt_stickydisplay = "Add border around stickied steps",
	opt_stickydisplaybool = "Add border around stickied steps",
	opt_stickydisplay_0 = "Tight",
	opt_stickydisplay_0_desc = "Display stickies in additional lines in your current step. Compact, but slightly messy.",
	opt_stickydisplay_1 = "Split",
	opt_stickydisplay_1_desc = "Display stickies split off with a thin line under the current step.",
	opt_stickydisplay_2 = "Spaced",
	opt_stickydisplay_2_desc = "Show a wide spacer line between stickies and the current step.",
	opt_stickydisplay_3 = "Bordered",
	opt_stickydisplay_3_desc = "Display a border around each sticky step.",
	opt_stickydisplay_4 = "No border",
	opt_stickydisplay_4_desc = "Don't display any border around sticky steps.",
	opt_stickydisplay_multiwarning = "Note: you have multiple steps displayed. Sticky steps are not shown in this mode.",
	opt_stickycolored = "Color stickies",
	opt_stickycolored_desc = "Highlight sticky steps with a color, to make them stand out better.",
	opt_stickygoto = "Show coordinates on stickied steps",
	opt_stickygoto_desc = "Show 'go to' lines in sticky steps to make them more terse.",

	["macro_tooltip"] = COLOR_TIP_MOUSE.."Drag|r to put onto your action bar|n"..COLOR_TIP_MOUSE.."Click|r to test",
	["macro_error_combat"] = "You are in combat, cannot create a macro.",
	["macro_error_overflow"] = "Too much %smacros, remove some and retry please.",
	["macro_error_bars_full"] = "The action bars are full, please make some space.",
	["macro_status_no"] = "Macro is not installed.",
	["macro_status_yes"] = "Macro is installed under %s.",
	["macro_both"] = "both account and character tabs",
	["macro_acc"] = "account tab",
	["macro_char"] = "character tab",
	["macro_exists"] = "You already have this macro.",

	['opt_configuration'] = "Show configuration",
	['opt_configuration_desc'] = "Open the Zygor Guides Viewer configuration screen.",

	--['opt_tweaks_desc'] = "Tweaks for some of the addon's functions. Handle with care.",
	--['opt_tweaks_domacros'] = "Allow to create macros",
	--['opt_tweaks_domacros_desc'] = "The addon might create macros for some of its scripted buttons. Turn off if you don't want the addon to create any macros at all.",



	-- Guide Right-click menu

		['qmenu_step'] = "Step %s (level %s)",
		['qmenu_step_skip'] = "Skip this step",
		['qmenu_step_skip_desc'] = "Skip to the next step, assuming this step as complete.",
		['qmenu_goal_creature_data'] = "View creature: %s",
		['qmenu_goal_creature'] = "View creature",
		['qmenu_goal_creature_desc'] = "See how '%s' looks like.",
		['qmenu_goal'] = "Goal: %s",
		['qmenu_goal_complete'] = "Mark as Complete",
		['qmenu_goal_complete_desc'] = "Click to mark this goal as complete (or incomplete).|n|cff998800Use this if the addon cannot properly detect completion.",
		['qmenu_quest'] = "Quest: %s",
		['qmenu_quest_info'] = "Show quest chain",
		['qmenu_quest_info_desc'] = "Display quest chain information and the level to which this quest belongs.|n|cffaaaaaaShift-click|cff998800 to view in text-copy mode.",
		--['qmenu_quest_complete'] = "Complete",
		--['qmenu_quest_complete_tip'] = "This quest is complete.",
		--['qmenu_quest_complete_desc'] = "Click to mark this quest as incomplete. This will be remembered until you log off, or the server sends a newly updated completion list.",
		--['qmenu_quest_complete_in_tip'] = "This quest is incomplete.",
		--['qmenu_quest_complete_in_desc'] = "Manually mark this quest as complete. This will be remembered until you log off, or the server sends a newly updated completion list.",
		['qmenu_quest_openmap'] = "Show quest on map",
		['qmenu_quest_openmap_desc'] = "Display the quest's location on the map.",
		['qmenu_quest_openlog'] = "Open log with quest",
		['qmenu_quest_openlog_desc'] = "Open the quest's description in your log.",
		['qmenu_quest_watched'] = "Watch quest",
		['qmenu_quest_watched_desc'] = "Toggle watching this quest using the built-in quest objective tracker.",
		['qmenu_quest_lightheaded'] = "View quest in LightHeaded",
		['qmenu_quest_lightheaded_desc'] = "View detailed quest information in the LightHeaded addon.|n|cffaaaaaaShift-click|cff998800 to view in text-copy mode.",

		['qmenu_goal_waypoint'] = "Waypoint: %s, %.1f;%.1f",
		['qmenu_goal_waypoint_desc'] = "Click to set your waypoint to these coordinates.",

		['qmenu_border_restore'] = "Switch to full mode",
		['qmenu_border_restore_desc'] = "Switch to \"Full Mode\", showing guide window controls.",

	--["mainframe_guide"] = "Select a guide:",
	--["mainframe_notloaded"] = "No leveling guides are loaded.|n|nPlease go to http://zygorguides.com to purchase Zygor's 1-80 Leveling Guides, or load some third-party guides.|n|nIf you're sure you have installed some guides, ask their authors for installation troubleshooting.",
	--["mainframe_notselected"] = "%d guides are loaded.|nPlease select a guide from the list above.",


	["report_title"] = "Please describe what exactly caused the bug and any relevant circumstances.\nThen, press CTRL+A and CTRL+C to copy the report and e-mail it to |cffff7700support@zygorguides.com|r.",
	["report_title_2"] = "Please describe what exactly caused the bug and any relevant circumstances.\nThe Zygor Client will upload the report to Zygor Guides as soon as you exit the game.",
	["report_notitle"] = "|cffff8888(unnamed guide)|r",
	["report_noauthor"] = "|cffff8888(no address available)|r",
	["report_nomount_dialog"] = "|cffff8888Zygor Guides Mount Detector|r\n\nThat player is either unmounted, or we don't know the mount they are using.\n\nYou could help us improve the guides by performing a 'scan' of the player and reporting it to us.\n\nAre you positive the target is mounted?",
	["report_nopet_dialog"] = "|cffff8888Zygor Guides Pet Detector|r\n\nThe target is either not a pet or we don't know the pet you have targeted.\n\nYou could help us improve the guides by reporting this exact pet to us.\n\nAre you positive the target is a pet?",

	["minimap_tooltip"] = COLOR_TIP_MOUSE.."Click|r to toggle guide window|n"..COLOR_TIP_MOUSE.."Right-click|r to configure|n", --..COLOR_TIP_MOUSE.."Drag|r to move icon"
	["minimap_tooltip_ex1"] = COLOR_TIP_MOUSE.."Ctrl+Alt+Right-click|r to start profiling|n",
	["minimap_tooltip_ex2"] = COLOR_TIP_MOUSE.."Ctrl+Alt+Right-click|r to stop profiling|n",

	["detector_mount_tooltip"] = "A Zygor Guide to obtaining this player's mount is available.",
	["detector_pet_tooltip"] = "A Zygor Guide to obtaining this pet is available.",
	["detector_tooltip_click"] = "<<Click>> to open the corresponding guide.",

	["waypointaddon_set"] = "Waypointing addon selected: %s",
	["waypointaddon_detecting"] = "Attempting to auto-detect waypointing addon...",
	--["waypointaddon_connecting"] = "Connecting to waypointing addon: %s",
	["waypointaddon_connected"] = "Connected to |cffddeeff%s|r for waypointing.",
	--["waypointaddon_disconnecting"] = "Disconnecting from waypointing addon: %s",
	["waypointaddon_disconnected"] = "Disconnected from |cffddeeff%s|r.",
	["waypointaddon_fail"] = "|cffffddddFailed to connect|r to |cffddeeff%s|r.",
	['waypoint_step'] = "Step %s",

	-- Corpse label + jokes
	 ['pointer_corpselabel'] = "Corpse",
	 ['pointer_corpselabel#'] = 7,
	 ['pointer_corpselabel1'] = "Ex you",
	 ['pointer_corpselabel2'] = "He who learns to run away...",
	 ['pointer_corpselabel3'] = "Bitten off more than you could chew, eh.",
	 ['pointer_corpselabel4'] = "Bucket Kicker - this way",
	 ['pointer_corpselabel5'] = "Try not to think about the repair bill.",
	 ['pointer_corpselabel6'] = "Hurry, crows are already pecking at your eyeballs.",
	 ['pointer_corpselabel7'] = "Thy cadaver lieth o'er yonder.",

	-- Pointer arrow right-click menu
	 ['pointer_arrowmenu_arrowheader'] = "Arrow options",
	 ['pointer_arrowmenu_removeway'] = "Remove waypoint",
	 ['pointer_arrowmenu_hide'] = "Disable arrow",
	 ['pointer_arrowmenu_hide_desc'] = "You'll have to enable it again\nin the Zygor options screen,\nunder Waypoints/Internal waypointer.",
	 ['pointer_arrowmenu_freeze'] = "Make non-interactive",
	 ['pointer_arrowmenu_freeze_desc'] = "You'll have to make it interactive again\nin the Zygor options screen,\nunder Waypoints/Internal waypointer.",
	 ['pointer_arrowmenu_scale'] = "Scale",
	 ['pointer_arrowmenu_scale_desc'] = "You can also hold |cff33ff00Ctrl|r and use your |cff33ff00mousewheel|r to scale the arrow.",
	 ['pointer_arrowmenu_opacity'] = "Opacity",
	 ['pointer_arrowmenu_options'] = "More options...",
	 ['pointer_arrowmenu_route_enable'] = "Find shortest travel routes",
	 ['pointer_arrowmenu_route_enable_desc'] = "Automatically find the shortest possible route to destination.",
	 ['pointer_arrowmenu_route_disable'] = "Disable travel routes",
	 ['pointer_arrowmenu_route_disable_desc'] = "Use straight line waypointing.",
	 ['pointer_arrowmenu_route_destination'] = "Destination: |cffbbffaa%s|r (%s, %d;%d)",
	 ['pointer_arrowmenu_route_node1'] = "  |cff8899aa%d. |cfff8fdff%s",
	 ['pointer_arrowmenu_route_node'] = "  |cff8899aa%d. |cffaabbcc%s",
	 ['pointer_arrowmenu_route_est'] = "  |cffccddeeEstimated time: |r%d:%02d",
	 ['pointer_arrowmenu_route_retry'] = "Re-check route",
	 ['pointer_arrowmenu_route_retry_desc'] = "Make sure this is still the best possible route.",

	 ['pointer_close_map'] = "(close map)",

	 ['pointer_reequip_item'] = "Equipped %s for you.",

	 ['dist_km'] = "%.1f km",
	 ['dist_m'] = "%d m",
	 ['dist_mi'] = "%.1f miles",
	 ['dist_yd'] = "%d yd",

	['pointer_arrow_itemcooldown'] = "Wait |cffaaff00%s|r for |cffffaa00%s|r cooldown",
	['pointer_arrow_itemuse'] = "Use |cffffaa00%s|r",

	["checkmap"] = "Check your map.",

	["initialized"] = 'Initialized.',

	["miniframe_notloaded"] = "No leveling guides are loaded.|n|nPlease go to http://zygorguides.com to purchase Zygor's 1-80 Leveling Guides, or load some third-party guides.|n|nIf you're sure you have installed some guides, ask their authors for installation troubleshooting.",
	["miniframe_notselected"] = "No guide is currently selected.\nPlease click the blinking button above to select a guide.",
	["miniframe_loading"] = "Loading guides: %d%%",

	['guide_notselected'] = "- select a guide -",
	['guide_notloaded'] = "|cff0000ff- none loaded -",
	['loading_quests'] = "|c888888ff(loading quests: %d%%)",
	['loading_guides'] = "|c888888ff(loading guides: %d%%)",

	['frame_locked'] = "Window locked",
	['frame_unlock'] = "<<Click>>: unlock",
	['frame_unlocked'] = "Window unlocked",
	['frame_lock'] = "<<Click>>: lock",
	['frame_settings'] = "Options",
	['frame_settings1'] = "<<Click>>: set options",
	--['frame_settings2'] = "<<Right-click>> to enter configuration",
	['frame_vendor_search'] = "Find Vendor",
	['frame_vendor_search1'] = "<<Click>>: find closest vendor",
	['frame_dispprimary'] = "Full display mode", --"Showing |cffffffff%d|r step(s)",
	['frame_dispsecondary'] = "Mini display mode", --"Showing all steps",
	['frame_dispgoprimary'] = "<<Click>>: switch to Full mode", --"<<Click>> to show only |cffffffff%d|r",
	['frame_dispgosecondary'] = "<<Click>>: switch to Mini mode",
	--['frame_minright'] = "<<Right-click>> to set number of steps",
	['frame_stepnav_prev'] = "Previous step",
	['frame_stepnav_prev_click'] = "<<Click>>: backtrack one step",
	['frame_stepnav_prev_right'] = "<<Right-click>>: rewind to last incomplete step",
	['frame_stepnav_prev_ctrl'] = "<<Ctrl-click>>: return to start of guide",
	['frame_stepnav_next'] = "Next step",
	['frame_stepnav_next_click'] = "<<Click>>: skip one step",
	['frame_stepnav_next_right'] = "<<Right-click>>: fast-forward to next incomplete step",
	['frame_section'] = "Current guide",
	['frame_section_click'] = "<<Click>>: select",

	['frame_helpbutton'] = "Help",
	['frame_helpbutton_desc'] = "<<Click>> to run the tutorial.",
	['frame_reportbutton'] = "Bug Report",
	['frame_reportbutton_desc'] = "<<Click>> to generate a detailed error or suggestion report.",
	['frame_profilerbutton'] = "Profiler",
    ['frame_profilerbutton_desc'] = "Generate a CPU usage profile since last activation or startup.",
	--[[
	 ['frame_sisbutton_on'] = "Dynamic Progress is on",
	 ['frame_sisbutton_off'] = "Dynamic Progress is off",
	 ['frame_sisbutton_levelsahead'] = "(allowing %d levels ahead)",
	 ['frame_sisbutton_turnon'] = "<<Left-click>> to activate dynamic progress",
	 ['frame_sisbutton_turnoff'] = "<<Left-click>> to deactivate dynamic progress",
	 ['frame_sisbutton_wizard'] = COLOR_TIP_MOUSE.."Right-click|r to initiate |cffddff00Smart Injection System|r.",
	 ['frame_sisbutton_disabled'] = "Dynamic Progress not available",
	 ['frame_sisbutton_disabled_desc'] = "Only leveling guides support dynamic progress.\nIt wouldn't make sense to use it\nwith your currently selected guide.",
	--]]
	['frame_selectguide'] = "Select a guide",
	['frame_selectguide_left'] = "<<Left-click>>: open the guide selection window.",
	['frame_selectguide_right2'] = "<<Right-click>>: choose from %d guide suggestions.",
	['frame_selectguide_right1'] = "<<Right-click>>: load the suggested guide:\n|cffffffff%s.",
	['frame_guide_step'] = "Step: %d/%d",
	['frame_guide_stepscompleted'] = "Steps Completed: %d/%d",
	['frame_guide_switch_level'] = "|cffffff00Click|cff00ff00 to switch to level based.",
	['frame_guide_switch_step'] = "|cffffff00Click|cff00ff00 to switch to step based.",
	['frame_guide_switch_inventory'] = "|cffffff00Click|cff00ff00 to switch to inventory based.",
	['frame_guide_maxlevel'] = "Max level reached!",
	['frame_guide_complete'] = "Guide complete!",
	['frame_guide_progress'] = "Guide progress: %d%%",

	['tooltip_tip'] = COLOR_TIP_HINT.."%s|r",
	['tooltip_waypoint'] = "<<Click>> to set waypoint: |cffffaa00%s|r",
	['tooltip_waypoint_coords'] = "Location: |cffffaa00%s|r",

	['tooltip_modelviewer_unlocked']="Model Viewer is Unlocked",
	['tooltip_modelviewer_locked']="Model Viewer is Locked",
	['tooltip_modelviewer_lock_desc']="|cffffff00Click|cff00ff00 to lock viewer relatively to main frame",
	['tooltip_modelviewer_unlock_desc']="|cffffff00Click|cff00ff00 to move viewer",
	['tooltip_modelviewer_default_desc']="|cffffff00Right-Click|cff00ff00 to return the viewer to the default position",

	["message_errorloading_full"] = "|cffff4444Error|r loading guide |cffaaffaa%s|r\nline: %d   step: %s\ncode:|cffffeeaa%s |cffff0000<=====|cffff8800 %s|r",
	["message_errorloading_brief"] = "|cffff4444Error|r loading guide |cffaaffaa%s|r",
	["message_errorloading_critical"] = "|cffff4444CRITICAL Error|r loading guide |cffaaffaa%s|r\nError: %s\nLine: %d\nData: %s",
	["message_loadedguide"] = "Activated guide: |cffaaffaa%s|r",
	["message_missingguide"] = "|cffff4444Missing|r guide: |cffaaffaa%s|r",
	["title_noguide"] = "Zygor Guides Viewer (no guide loaded)",


	--["dialog_badnext_leveling"] = "You've reached the end of the current guide.\n\nThe next guide, |cffff8800%s|r, requires level %d and %d bars.\n\nFor some reason, you're missing %d levels and %d bars.\n\nYou should either go grind a bit, or restart the current guide (maybe you missed a step or two).",
	["dialog_endguide"] = "You've reached the end of the current guide.",
	["dialog_nextguide"] = "You've reached the end of the current guide.\n\nThe next guide is:\n|cffff8800%s|r\n\nWould you like to proceed?",


	-- Step formatting

	['step_num'] = "|cffaaaaaa%s|cff888888.|r ",
	['step_level'] = "|cffaaccaaLevel: |cffcceecc%s|cffaaccaa|r ",

	["questtitle"] = "`%s'",
	["questtitle_part"] = "`%s' (part %s)",
	["coords"] = "%d,%d",
	["map_coords"] = "%s %d,%d",

	["stepgoal_home"] = "Set home location to %s",
	["stepgoal_flightpath"] = "Get the %s flight path",

	["stepgoal_accept"] = "Accept %s",
	["stepgoal_accept_done"] = "Accepted %s",
	["stepgoal_turn in"] = "Turn in %s",
	["stepgoal_turn in_done"] = "Turned in %s",
	["stepgoal_talk to"] = "Talk to %s",
	["stepgoal_kill"] = "Kill %s",
	["stepgoal_kill #"] = "Kill %s %s",
	["stepgoal_kill_done"] = "Killed %s",
	["stepgoal_kill #_done"] = "Killed %s %s",
	["stepgoal_avoid"] = "Avoid %s",
	["stepgoal_goal"] = "%s",
	["stepgoal_goal #"] = "%s %s",
	["stepgoal_goal_done"] = "Done: %s",
	["stepgoal_goal #_done"] = "Done: %s %s",
	["stepgoal_get"] = "Get %s",
	["stepgoal_get #"] = "Get %s %s",
	["stepgoal_get_done"] = "Got %s",
	["stepgoal_get #_done"] = "Got %s %s",
	["stepgoal_ding"] = "You should now be level %s.|n    If not, grind a little until you are.",
	["stepgoal_ding_brief"] = "Reach level %s",
	["stepgoal_go to"] = "Go to %s",
	["stepgoal_gotonpc"] = "Find nearest %s",
	["stepgoal_go to_leave"] = "Leave %s",
	["stepgoal_also at"] = "Also at %s",
	["stepgoal_fly"] = "Fly to %s",
	["stepgoal_arrive"] = "Arrive at %s",
	["stepgoal_hearth to"] = "Hearth to %s",
	["stepgoal_collect"] = "Collect %s",
	["stepgoal_collect #"] = "Collect %s %s",
	["stepgoal_collect_done"] = "Collected %s",
	["stepgoal_collect #_done"] = "Collected %s %s",

	["stepgoal_farm"] = "Gather %s",
	["stepgoal_farm #"] = "Gather %s %s",
	["stepgoal_farm_done"] = "Gathered %s",
	["stepgoal_farm #_done"] = "Gathered %s %s",
	["stepgoal_craft"] = "Craft %s",
	["stepgoal_craft #"] = "Craft %s %s",
	["stepgoal_craft_done"] = "Crafted %s",
	["stepgoal_craft #_done"] = "Crafted %s %s",



	["stepgoal_goldcollect"] = "Collect %s",				-- no cap and 0
	["stepgoal_goldcollect #"] = "Collected %s %s",			-- no cap and > 0
	["stepgoal_goldcollect_done"] = "Collected %s",		-- cap and cap = 1 or 0
	["stepgoal_goldcollect #_done"] = "Collected %s %s",	-- cap > 0. 
	["stepgoal_goldtracker"] = "Estimated Gold Earned: %s",
	["stepgoal_buy #"] = "Buy %s %s",
	["stepgoal_buy #_done"] = "Bought %s %s",
	["stepgoal_buy"] = "Buy %s",
	["stepgoal_buy_done"] = "Bought %s",
	["stepgoal_fpath"] = "Get the %s Flight Path",
	["stepgoal_fpath_done"] = "Got the %s Flight Path",
	["stepgoal_use"] = "Use %s",
	["stepgoal_item"] = "%s",
	["stepgoal_home"] = "Make %s your home location",
	["stepgoal_rep"] = "Become %s with %s",
	["stepgoal_petaction"] = "Use pet action %s",
	["stepgoal_havebuff"] = "Gain buff/debuff '%s'",
	["stepgoal_nobuff"] = "Lose buff/debuff '%s'",
	["stepgoal_invehicle"] = "Enter vehicle",
	["stepgoal_outvehicle"] = "Leave vehicle",
	["stepgoal_equipped"] = "Equip %s",
	["stepgoal_at_suff"] = " (%s)",
	["stepgoal_at"] = "Also at %s",
	["stepgoal_achieve"] = "Earn the '%s' achievement",
	["stepgoal_achievetext"] = "For this achievement, you need to %s",
	["stepgoal_achievesub"] = "Complete '%s' for achievement '%s'",
	["stepgoal_skill"] = "Achieve %s level %s",
	["stepgoal_skillmax"] = "Raise %s to maximum level %s",
	["stepgoal_skillmax2"] = "Learn the %s skill",
	["stepgoal_learn"] = "Learn %s",
	["stepgoal_learnspell"] = "Learn %s",
	["stepgoal_learnpet"] = "Obtain pet %s",
	["stepgoal_learnmount"] = "Obtain mount %s",
	["stepgoal_confirm"] = "Click here to proceed",
	["stepgoal_create"] = "Create %s",
	["stepgoal_create #"] = "Create %d %s",
	["stepgoal_earn #"] = "Earn %s %s",
	["stepgoal_earn #_done"] = "Earned %s %s",
	["stepgoal_earn_done"] = "Earned %s %s",
	["stepgoal_click"] = "Click %s",
	["stepgoal_clicknpc"] = "Click %s",
	["stepgoal_click_done"] = "Click %s",
	["stepgoal_clicknpc_done"] = "Click %s",
	["stepgoal_complete"] = "Complete: %s",
	["stepgoal_scenariogoal_unknown"] = "Complete a scenario goal",
	["stepgoal_scenariogoal_unknown #"] = "Complete %d scenario goal(s)",
	["stepgoal_scenariogoal"] = "%s",
	["stepgoal_scenariogoal #"] = "%s: %s",
	["stepgoal_scenariogoal_done"] = "Done: %s",
	["stepgoal_scenariogoal #_done"] = "Done: %s %s",
	["stepgoal_scenariostage"] = "Complete scenario stage %d",
	["stepgoal_scenariostage_named"] = "Complete stage %d: %s",
	["stepgoal_scenariostage_done"] = "Scenario stage %d completed",
	["stepgoal_noquest"] = "Make sure %s offers no quests, or click here",

	["stepgoal_perform_alchemy"] = "Create %s %s",
	["stepgoal_perform_first aid"] = "Create %s %s",
	["stepgoal_perform_enchanting"] = "Cast %s %s",
	["stepgoal_perform_blacksmithing"] = "Forge %s %s",
	["stepgoal_perform_engineering"] = "Construct %s %s",
	["stepgoal_perform_tailoring"] = "Sew %s %s",
	["stepgoal_perform_leatherworking"] = "Sew %s %s",
	["stepgoal_perform_mining"] = "Perform %s %s",
	["stepgoal_perform_inscription"] = "Inscribe %s %s",
	["stepgoal_perform_cooking"] = "Cook %s %s",
	["stepgoal_perform_jewelcrafting"] = "Craft %s %s",

	["stepgoal_or"] = "  - or -",

	["completion_goal"] = "(%s/%s)",
	["completion_count"] = "(%s)",
	["completion_ding"] = "(%s%%)",
	["completion_done"] = "(done)",
	["completion_rep"] = "(%s)",

--[[
	["stepgoalshort_complete"] = "done",
	["stepgoalshort_incomplete"] = "pending",
	["stepgoalshort_questgoal"] = "(%d/%d)",
	["stepgoalshort_level"] = "(%d%%)",
--]]

	["step_req"] = "Step valid only for: %s",
	["players_garrison"] = "%s's Garrison",
	["players_garrison_1"] = "%s's Outpost",
	["players_garrison_2"] = "%s's Fort",
	["players_garrison_3"] = "%s's Garrison",


	["map_highlight"] = "Highlight",

	["stepreq"] = "Step class/race requirement: ",
	["stepreqor"] = " or ",

	["opt_do_searchforgoal"] = "Find a completeable goal",
	["searching_for_goal_success"] = "A completeable goal has been found for you: %s. This may be a good starting point in the guide for you.",
	["searching_for_goal_failed"] = "No completeable goal has been found. Try another guide or section, pick up some quests, or search again from the start of the section (the search only goes forward).",

	["binding_togglewindow"] = "Show Guide Window",
	["binding_prev"] = "Previous Step",
	["binding_next"] = "Next Step",
	["binding_waypoint_next"] = "Cycle multiple waypoints",
	["binding_waypoint_prev"] = "Cycle multiple waypoints backwards",

	["req_not"] = "not %s",

	["menu_last"] = "Last guides:",
	["menu_last_entry"] = "%s |cffaaaaaastep|r %d",

	['gold_missing_nospotsinrange'] = "No gold spots within range.",
	['gold_missing_noguidesloaded'] = "No gold guides are loaded!",

	['gold_header_drop'] = "Drops from |cffffdddd%s|r:",
	['gold_header_ore'] = "Ore deposits:",
	['gold_header_herb'] = "Herbs:",
	['gold_header_skin'] = "Skins:",
	['gold_header_vendor'] = "Buy:", -- from |cffddffdd%s|r:",

	['questsloading_tooltip'] = "Retrieving completed quests.",
	['questsloading_tooltip2'] = "This might take a minute or two.",

	['stepcollapsed'] = "(step collapsed)",


	['static_caption'] = "|TInterface\\Addons\\"..addonName.."\\Skins\\zygorlogo2:25:100|t\n \n",
	--['static_image'] = "\n\n|T%s:115:215|t",
	['static_help'] = "Help and tutorial system|ncoming soon.",
	--['static_sis'] = "|cffffff88Smart Injection System|r|n|nThis feature will attempt to find the best spot in the guides for you to start.|nIt will reset your dynamic progress settings, load the starting guide for level 1 of your race/class, and start skipping forward until it finds quests worth completing.|n|nIf your character is high-level, you'll mostly see the guide zip past |cff88ff88green|r (completed) or |cff88aaffblue|r (low-level) steps.|n|nIf it stops at a seemingly low-level quest, it's usually a good idea to trust the guide and complete the quest, as it might start a long chain reaching to your level.|n|nIt might stop at flight path pickups, it's up to you to verify if they're really unknown to your character.|n|nSo... Ready for the ride?",
	['static_abandonquests'] = "These quests are not continued in the current guide:\n\n%s\nYou're safe to abandon them in your Quest Log.",
	['static_abandonquests_none'] = "All your quests are dailies or valid for the current guide.\nThere is nothing to abandon.",
	--Do you want to:\n- Abandon them all now?\n- Return to the previous guide to complete them?\n- Ignore this warning?",
	['static_abandonquests_butabandon'] = "Abandon all",
	['static_abandonquests_butreturn'] = "Return",
	['static_abandonquests_butignore'] = "Ignore",
	['static_nextguide'] = "You're now ready to proceed to:\n\n%s",
	['static_nextguide2'] = "You're now ready to proceed to:\n",
	['static_nextguide_turnins'] = "Let me turn my quests in first",
	['static_error'] = "Oh no! ZygorGuides have crashed!\n\nIt's strongly recommended to generate a bug report now, and copy and paste it manually onto the zygorguides.com forum.\n\nWould you like to generate the report?",
	['static_badguide'] = "The selected guide:\n|cffffee00%s|r\n is |cffffbbaaimproper|r for your character.\n|cffff6644%s|r\n\nDo you really want to load it?",

	['static_pandareload'] = "Would you like to reload\nso that you may view all of your guides?",
	['static_loadguide'] = "Would you like to load the guide:\n\n%s",
	['guide_dungpop_tip'] = SHIFTCLICK.." to block this dungeon\nfrom being suggested again.",
	['guide_monkpop_tip'] = SHIFTCLICK.." to block monk dailies\nfrom being suggested again.",
	['static_dungeondontshow'] = "Don't ask again for this dungeon.",
	['static_dontshow'] = "Don't ask again.",
	['static_accept'] = "Accept",
	['static_decline'] = "Decline",
	['static_settings_tip'] = "Configure settings.",
	['static_minimize_tip'] = "Send to Notification Center.",

	['guidepicker_suggested'] = "Suggested guides",
	['guidepicker_recent'] = "RECENT:",
	['guidepicker_leveling'] = "Leveling",
	['guidepicker_events'] = "Events",
	['guidepicker_dalies'] = "Dailies",
	['guidepicker_loremaster'] = "Loremaster",
	['guidepicker_gold'] = "Gold",
	['guidepicker_professions'] = "Professions",
	['guidepicker_pets'] = "Pets & Mounts",
	['guidepicker_achievements'] = "Achievements",
	['guidepicker_titles'] = "Titles",
	['guidepicker_reps'] = "Reputations",
	['guidepicker_macros'] = "Macros",
	['guidepicker_dungeon'] = "Dungeons",
	['guidepicker_gear'] = "Gear",

	['guidepicker_button_accept'] = "Accept",
	['guidepicker_button_viewinfolder'] = "View in folder",
	['guidepicker_button_viewinfolder_desc'] = "Open the selected guide's parent folder",
	['guidepicker_button_guides'] = "Home",
	['guidepicker_button_guides_desc'] = "Choose from all available guides",
	['guidepicker_button_recent'] = "Recent",
	['guidepicker_button_recent_desc'] = "View recently loaded guides",
	['guidepicker_button_suggest'] = "Suggest",
	['guidepicker_button_suggest_desc'] = "See currently suggested guides, based on your progress.",
	['guidepicker_button_ok_desc'] = "Load the selected guide",
	['guidepicker_button_searchreset_desc'] = "Clear search",
	['guidepicker_button_searchlabel'] = "SEARCH",

	['guidepicker_searchresults'] = "Search results:",

	['guidepicker_selectaguide'] = "Select a guide type:",

	['guidepicker_status_SUGGESTED'] = "Suggested",
	['guidepicker_status_COMPLETE_lev'] = "Obsolete",
	['guidepicker_status_COMPLETE'] = "Complete",
	['guidepicker_status_INVALID'] = "Improper",
	['guidepicker_status_VALID'] = "Valid",
	['guidepicker_percentage'] = "Percentage Complete: ",

	['guidepicker_button_macro_add'] = "Install",
	['guidepicker_button_macro_add_desc'] = "Add the macro to your character's Macro Panel.",
	['guidepicker_button_macro_bar'] = "Place on Bars",
	['guidepicker_button_macro_bar_desc'] = "Place the macro on your character's action bar.",
	['guidepicker_button_macro_del'] = "Uninstall",
	['guidepicker_button_macro_del_desc'] = "Remove the macro from your character.",
	['guidepicker_macro_code']= "Macro code:",

	['guideconfig_maintitle'] = "Welcome to Zygor Guides|cffff7744 5.0",
	['guideconfig_mainbottom'] = "This configuration wizard will walk you through setting up Zygor Guides for the first time.",

	['guideconfig_exit'] = "Exit",
	['guideconfig_skip'] = "Skip",
	['guideconfig_cont'] = "Continue",
	['guideconfig_back'] = "Back",
	['guideconfig_newsetup'] = "New Setup",
	['guideconfig_load'] = "Load",
	['guideconfig_save'] = "Save",
	['guideconfig_final'] = "Let's Go!",

	['guideconfig_loadtext'] = "Zygor Guides has detected an existing saved profile. Would you like to load these settings?",
	['guideconfig_choosetext'] = "Choose profile:",
	['guideconfig_select'] = "Select",
	['guideconfig_fulltext'] = "Run the full configuration wizard for this character.",
	
	['opt_group_profile'] = "Profiles",
	['opt_profile_description'] = "You can change the active database profile, so you can have different settings for every character.|n|nReset the current profile back to its default values, in case your configuration is broken, or you simply want to start over.",

	['opt_resetprofile'] = "Reset Profile",
	['opt_current_profile'] = "Current profile: ",
	['opt_new_profile'] = "You can either create a new profile by entering a name in the editbox, or choose one of the already existing profiles.",
	['opt_copy_profile'] = "Copy the settings from one existing profile into the currently activce profile.",
	['opt_delete_profile'] = "Delete existing and unused profiles from the database to save space, and cleanup the SavedVariables file.",
	
	['opt_newprofile'] = "New",
	['opt_selectprofile'] = "Existing Profiles",
	['opt_copyfromprofile'] = "Copy From",
	['opt_deleteprofile'] = "Delete a Profile",
	
	['guideconfig_customize'] = "Customize your user settings",
	['guideconfig_automatetasks'] = "Zygor Guides can automate tasks for you in a number of ways. Choose which of these settings you would like enabled.",

	['guideconfig_newbmain'] = "New User",
		['guideconfig_newbsec'] = "This setting is recommended for players using Zygor Guides for the first time.",
		['guideconfig_gear'] = "Let me know when new gear upgrades are available",
		['guideconfig_taxi'] = "Select flight destinations when needed for a guide step",
		['guideconfig_gray'] = "Sell gray items when visiting a vendor",
	['guideconfig_advmain'] = "Advanced User",
		['guideconfig_advsec'] = "This setting is recommended for experienced Zygor users who would like their gameplay as automated as possible.",
		['guideconfig_quests'] = "Accept and turn in quests",
		['guideconfig_questitem'] = "Accept recommended quest rewards",
		['guideconfig_autogear'] = "Equip new gear upgrades",
		--['guideconfig_gear'] = ['guideconfig_gear'],
		--['guideconfig_taxi'] = ['guideconfig_taxi'],
	['guideconfig_manmain'] = "Manual Setup",
		['guideconfig_mansec'] = "Use the boxes to check which settings you would like to use.",
		-- All options the same as adv

	['guideconfig_savetitle'] = "Save these settings?",
	['guideconfig_savedesc'] = "Zygor Guides can keep your settings synced across multiple characters. Would you like to save these settings for future use?",
	['guideconfig_savename'] = "Give these settings a name:",
	['guideconfig_savedefault'] = "%s's settings",
	['guideconfig_saved'] = "Saved!",

	['guideconfig_lasttitle'] = "You're ready to go!",
	['guideconfig_spelltext'] = "Zygor will now cast a spell and the guide will magically appear on your screen!",
	['guideconfig_tutcheck'] = "Run the Zygor Guides tutorial after this window closes",

	--[[
	['guideconfig_leftalign'] = "ALIGN LEFT",
	['guideconfig_rightalign'] = "ALIGN RIGHT",
	['guideconfig_features'] = "Zygor Guides contains many features that make common tasks in the game faster and easier. Choose which of these features you would like to use.",
	['guideconfig_featurestitle'] = "EXTRA SETTINGS:",
	['guideconfig_check1'] = " Auto-Accept Quests",
		['guideconfig_checkoption1'] = "autoaccept",
		['guideconfig_checktooltip1'] = "Automatically accept quests, if the current step instructs you to.\n|cffffaa88This makes questing very fast, but may be confusing.",
	['guideconfig_check2'] = " Auto-Turn In Quests",
		['guideconfig_checkoption2'] = "autoturnin",
		['guideconfig_checktooltip2'] = "Automatically turn in quests, if the current step instructs you to.\nWorks only if there is no reward to choose.\n|cffffaa88This makes questing very fast, but may be confusing.",
	['guideconfig_check3'] = " Auto Accept Recommended Quest Rewards",
		['guideconfig_checkoption3'] = "autoselectitem",
		['guideconfig_checktooltip3'] = "Automatically turn in quests and select reward if available.\nReward selection process looks at class and spec and picks the biggest upgrade for you from the quest items. If no upgrades are available then picks the item that has the highest vendor value.\n|cffffaa88Item selection process may not be perfect.\nDoes not take secondary spec into account.",
	['guideconfig_check4'] = " Suggest Gear Upgrades",
		['guideconfig_checkoption4'] = "autogear",
		['guideconfig_checktooltip4'] = "Suggest gear upgrades based on your spec. Requires confirmation before each item is equipped.\n|cffffaa88Please report any issues.\nBest gear is based on player versus environment not player versus player.",
	['guideconfig_check5'] = " Equip Gear Automatically",
		['guideconfig_checkoption5'] = "autogearauto",
		['guideconfig_checktooltip5'] = "Automatically equip the best gear based on your spec.\nWill update gear as new gear is picked up.\nSuggest Gear Upgrades is required for this feature.\n|cffffaa88This is an experimental feature. There might still be a few quirks with it. Please report any issues.\nBest gear is based on player versus environment not player versus player.",
	['guideconfig_check6'] = " Take Flights Automatically",
		['guideconfig_checkoption6'] = "autotaxi",
		['guideconfig_checktooltip6'] = "Automatically take taxi flights, when talking to a flightmaster, if the travel system suggests it.",
	['guideconfig_check7'] = " Auto-Sell Grey Items",
		['guideconfig_checkoption7'] = "autosell",
		['guideconfig_checktooltip7'] = "Automatically sells grey items when a vendor window is opened.\n|cffffaa88Will sell all grey items in inventory.",
	['guideconfig_newpbutton'] = "New User",
	['guideconfig_expbutton'] = "Experienced User",
	['guideconfig_manualbutton'] = "Manual Setup",
	['guideconfig_newtooltip'] = "This setting is recommended for players using Zygor Guides for the first time.\n\n|cffff7744Automatically suggest equipment upgrades\nSell grey items automatically|r\n\nOther features can be enabled within Zygor Guides' settings menu.",
	['guideconfig_exptooltip'] = "This setting is recommended for players who are very familiar with Zygor Guides and wish to have their gameplay as |cffff0000automated|r as possible.\n\n|cffff7744Accepting and completing of quests\nSuggesting items\nEquipping suggested gear\nAccepting recommended quest rewards\nTaking flights automatically\nSelling grey items|r\n\nThese features can be modified within Zygor Guides' settings menu.",
	['guideconfig_manualtoolip'] = "Manually configure which Zygor features and settings you'd like to use.",
	['guideconfig_tutcheck'] = "Run the tutorial when this window closes",
	['guideconfig_finalbutton'] = "LET'S GO!",
	--]]

	['guidetutorial_next'] = "Next",
	['guidetutorial_backbutton'] = "Back",
	['guidetutorial_exit'] = "Exit",
	['guidetutorial_donebutton'] = "Done",
	['guidetutorial_guideviewer'] = "Zygor Guide Viewer",
		['guidetutorial_guideviewertip'] = "This is where the most important information will be displayed, such as what to do next, who to talk to, what quests to accept, and more.",
	['guidetutorial_options'] = "Options Button",
		['guidetutorial_optionstip'] = "Pressing this will let you configure the entire guide to your own personal preferences.",
	['guidetutorial_help'] = "Tutorial Button",
		['guidetutorial_helptip'] = "Press this if you would like to run this tutorial again at any time.",
	['guidetutorial_lock'] = "Lock/Unlock Button",
		['guidetutorial_locktip'] = "You can toggle this to lock the guide viewer in place, or untoggle it to move it freely again.",
	['guidetutorial_close'] = "Close Button",
		['guidetutorial_closetip'] = "Click this to hide the Guide Viewer. You can bring it back by hitting the \"Z\" icon on your mini map.",
	['guidetutorial_steps'] = "Step Controls",
		['guidetutorial_stepstip'] = "This will show you what step you are on in the current guide. You can use the arrows to look throught the steps. You can also hover over the number and scroll your mousewheel for faster browsing. Holding Ctrl+Alt while scanning will allow you to see any steps that get skipped automatically.",
	['guidetutorial_guides'] = "Guide Selector",
		['guidetutorial_guidestip'] = "This will display the title of the guide you are currently using. If you'd like to switch to another guide, click the down arrow to bring up the Guide Menu.",
	['guidetutorial_cleanup'] = "Quest Cleanup Button",
		['guidetutorial_cleanuptip'] = "Use this if you would like to clear any quests from your quest log that you no longer need to do. We recommend you run this anytime you jump to a new guide before finsihing the current one. |cffff7744Note: Quests cleared using this feature will be abandoned from your quest log.|r",
	['guidetutorial_mode'] = "View Mode Button",
		['guidetutorial_modetip'] = "This will allow you to switch between two modes of display: Full View, which shows the entire guide frame, or Mini-Mode, which only shows the step lines and fades the frame for a minimalist experience, and to conserve screen space.",
	['guidetutorial_progress'] = "Progress Indicator",
		['guidetutorial_progresstip'] = "This will show you a visual display of your progress through the current guide.\n\nIf you are working in a Leveling Guide, when you click the bar you can switch between two forms of tracking:",
		['guidetutorial_progresstipstep'] = "Track By Step",
		['guidetutorial_progresstiplevel'] = "Track By Level",
		['guidetutorial_progresstip2'] ="This will track your progress by how many steps there are in a guide.",
		['guidetutorial_progresstip3'] ="This will track your progress by how close you are to out-leveling the currently loaded guide and being told you can move on to the next guide.",
	['guidetutorial_model'] = "Model Viewer",
		['guidetutorial_modeltip'] = "You can see fully rendered 3D models of NPCs and other game objects mentioned in the current guide step here.",
	['guidetutorial_arrow'] = "Waypoint Arrow",
		['guidetutorial_arrowtip'] = "This will point you to the current objective seen in the Guide Viewer. It's a smart arrow, so it will dynamically calculate the fastest way to get to your destination from where you're currently standing. You can right click the arrow to see more options.",

	['autocomplete_turnin'] = "Turning in quest.",
	['autocomplete_turnin_fail'] = "Will not pick a reward automatically.",


	['itemscore_ae_button'] = "Equip best items",
	['itemscore_ae_clearednotupgrade'] = "Cleared the items that were not upgrades previously.",
	['itemscore_ae_equip'] = "Equipping %s",
	['itemscore_ae_over'] = " over %s",
	['itemscore_ae_accept'] = "Equip",
	['itemscore_ae_accept_tip'] = "Equip %s",
	['itemscore_ae_accept_tip2'] = nil,
	['itemscore_ae_decline'] = "Decline",
	['itemscore_ae_decline_tip'] = "Keep %s",
	['itemscore_ae_settings_tip'] = "Configure equipment suggestions",
	['itemscore_ae_report_tip'] = SHIFTCLICK.." to generate a report\nif you think this suggestion is wrong.",
	['itemscore_ae_queue_tip'] = "Postpone for later",
	['itemscore_ae_with'] = "with",
	['itemscore_ae_equip1'] = " would like to replace:",
	['itemscore_ae_equip2'] = " would like to equip:",
	['itemscore_questitem1'] = "Would you like to equip",
	['itemscore_questitem2'] = "for the current quest?",
	['itemscore_questitem3'] = "since the quest item is no longer needed?",
	['itemscore_ae_nospec'] = "To utilize the gear system,\nyou must first select a specialization.",

	['notifcenter_title'] = "Zygor Notifications",
	['notifcenter_no_buttons'] = "No notifications are available at this time.",

	['notifcenter_gen_popup_tooltip'] = "<<Click>> to open this pop-up again.",

	['notifcenter_pet_text']= "|c%s%s|r Detected.",
	['notifcenter_nextguide_text'] = "Next suggested guide: |c%s%s|r",
	['notifcenter_reload_text'] = "Pop-up to reload your guides",
	['notifcenter_dungeon_text'] = "Load Dungeon guide for: |c%s%s|r",
	['notifcenter_monk_text'] = "Load Monk guide for: |c%s%s|r",
	['notifcenter_loot_text'] = "Shopping List",
	['notifcenter_spec_text'] = "Specialization Reminder",
	['notifcenter_gear_text'] = "New Upgrade Available",
	['notifcenter_gear_equipped'] = "|c%s%s|r equipped to the |cffffff00%s|r slot",
	['notifcenter_gear_text_sl'] = "%d New Upgrade Available",
	['notifcenter_gear_text_pl'] = "%d New Upgrades Available",
	['notifcenter_quest_text'] = "Quest Item action required",
	['notifcenter_mount_text'] = "Mount Training Available",

	['notifcenter_pet_title']= "Creature Detector",
	['notifcenter_nextguide_title'] = "Smart Injection System",
	['notifcenter_dungeon_title'] = "Dungeons Guide",
	['notifcenter_monk_title'] = "Monk Daily",
	['notifcenter_gear_title'] = "Gear System",
	['notifcenter_inventory_manager_title'] = "Inventory Manager",
	['notifcenter_mount_title'] = "Riding Training",
	['notifcenter_generic_title'] = "Other",
	
	['notifcenter_sec'] = "Added %d second ago",
	['notifcenter_secs'] = "Added %d seconds ago",
	['notifcenter_min'] = "Added %d minute ago",
	['notifcenter_mins'] = "Added %d minutes ago",
	['notifcenter_hour'] = "Added %d hour ago",
	['notifcenter_hours'] = "Added %d hours ago",
	
	['gold_basic_1_header'] = "01) Always make sure your guide is up to date",
	['gold_basic_1_sum'] = "Every realm (server) in World of Warcraft has a unique and ever changing economy. In order for Zygor's Gold and Auctions guide to work properly it needs to see how your servers market changes over time.  This information is gathered by Zygor outside of the game and is delivered to you via the Zygor Guides Client. Make sure you've configured your servers in the client options under WoW Gold Guide.",
	['gold_basic_2_header'] = "02) Perform a fresh scan before using the guide",
	['gold_basic_2_sum'] = "In addition to keeping your guides updated via the Zygor Guides Client you will also need to perform a fresh scan of your servers auction house to make sure you have current pricing information. To do this, simply talk to any Auctioneer in the game and Zygor's auto-scan feature should start scanning your server. You can also manually scan the server by pressing the Scan button on the Auction Tools.",
	['gold_basic_3_header'] = "03) Select a gold making method",
	['gold_basic_3_sum'] = "Once your guides are up to date and you've performed a recent scan you're ready to go. To access the Gold Guide go to the Guide Selection Menu and select Gold. This will bring up the Gold Guide Menu which has 5 different ways you can make gold. Under each method there will be a list of guides available to you displayed along with important data to help you choose the best guide. Click the Load guide button once you've made your decision.",
	['gold_basic_4_header'] = "04) Complete the required gold making activities and profit!",
	['gold_basic_4_sum'] = "Once the guide has loaded simply follow the instructions displayed on the Guide Viewer to begin making gold. Every guide will require you to perform different tasks like completing quests, or buying/farming/crafting items to sell on the Auction House, but in the end, permitting you've followed these instructions, you should make a profit.|n|nNote: Although Zygor's Gold and Auctions guide is pretty reliable and should make you money most of the time the WoW marketplace is an unpredictable place which means occasionally some items might expire before selling (especially using Expert mode or the more advanced methods). It's important to remain patient and remember that you might just need to relist your items to get them to sell. Also, all estimated values shown are based on the rates of a level 90 character.",
	['gold_basic_5_header'] = "05) Go forth and build your wealth",
	['gold_basic_5_sum'] = "Congratulations! You now know enough to begin using Zygor's Gold and Auctions guide. Click exit to go back to the tutorial index and begin learning how to use the various gold making methods and tools found in Zygor's Gold and Auctions guide.",
	

	['gold_1_header'] = "01) Talk to an Auctioneer",
	['gold_1_sum'] = "The first thing you need to do is scan the auction house so you have the latest pricing data. We've just set a waypoint for you, so follow the arrow to be taken to the nearest Auctioneer, then speak with them to begin the scanning process.",
	['gold_scanbutton_header']	= "02) Scan the Auction House",
	['gold_scanbutton_sum'] = "If you disabled autoscanning, press Scan to update auction house data. When the scanning is complete click Next to continue.",
	['gold_scantime_header']	= "02) Scan the Auction House",
	['gold_scantime_sum'] = "This status of the scanning process will be shown at the bottom of the Auction Tools panel. Once the scan is complete it will show a timestamp allowing you to see when the last scan occured.",
	['gold_appraisebutton_header']	= "02) Scan the Auction House",
	['gold_appraisebutton_sum']	= "[PH] If Quick Scan is not available at the moment (Scan button is grayed out), you can use Appraise function to update prices of all items listed inn Inventory tab.",

	
	['gold_3_header']	= "03) Open the Gold Guide Menu",
	['gold_3_sum'] = "You can bring up the Gold Guide menu by clicking this gold button here. Go ahead and try it now!",
	['gold_4_header']	= "04 ) Browsing the guide list",
	['gold_4_sum'] = "This section will show you all the items you can farm with several columns of information to help you choose the best one. Lets take a look at how to read each column:",

	['gold_no_header']	= "4a) No.",
	['gold_no_sum'] = "The No. column shows you what number Zygor has ranked this item in terms of overall profitably. The items are listed in descending order with the most profitable items at the top.",
	['gold_item_header']	= "4b) Item",
	['gold_item_sum'] = "The Item column tells you the name of the item or items to be farmed in this guide.",
	['gold_zone_header']	= "4c) Zone",
	['gold_zone_sum'] = "[PH] The Zone column shows which area you will be visiting when using this guide.",
	['gold_rate_header']	= "4d) Rate",
	['gold_rate_sum'] = "The Gold column shows the estimated amount of gold that can be earned per hour when using this guide. This is determined by the multiplying the frequency of drops by the current market price of the items.\n\nNote: All values are based on the gathering rate of a level 90 character. ",
	['gold_time_header']	= "4e) Time",
	['gold_time_sum'] = "[PH} The Time column shows estimated time you will spend running this guide.",
	['gold_est_header']	= "4f) Estimated gold",
	['gold_est_sum'] = "The Limit column shows an adjusted estimate of the gold that can be earned farming this item when demand is lower than the hourly drop rate. Generally, this is the max amount of the item you can safely farm before you risk flooding the market.",
	['gold_mode_header']	= "4g) Mode",
	['gold_mode_sum'] = "You can switch between two different modes of display: Easy and Expert. In Easy Mode, all items with Low Demand will be hidden. Low Demand items can still be profitable, even most profitable, but might not sell as reliably or as quickly as higher Demand items. If you would like these items to be included you should use Expert Mode.",
	['gold_filter_header'] = "4h) Filter",
	['gold_filter_sum'] = "You can control what type of items are shown in the list using the Filter drop down.",

	['gold_12_header'] = "05 ) Browsing the guide list",
	['gold_12_sum'] = "You can also view more details by hovering over any of the item in the list. This will show you all the farmable items and calculations used to rank each guide. Try it now, then click the Next button when you're ready to proceed.",				
	['gold_13_header']	= "05-2) Select a guide",
	['gold_13_sum'] = "To select a guide you want to use click the orange guide picker button, or double click the entire row to load the guide. Go ahead and select a guide from the list now to continue.",
	['gold_14_header']	= "6) Follow the guide instructions",
	
	['gold_farming_14_sum'] = "Now follow the instructions displayed on the Guide Viewer below. This will lead you to the best location in the game to farm the desired item/s. As you collect items the guide will show you the estimated amount of gold you are earning in real time. When you're done farming click the link at the bottom of the step to be taken to the nearest Auctioneer where you can use the built in Auction Tools to post your items.\n\nThis completes the Farming walkthrough.\n\nClick here to view the Auction Tools walkthrough.",
	['gold_gathering_14_sum'] = "Now follow the instructions displayed on the Guide Viewer below. This will lead you to the best location in the game to farm the desired item/s. As you collect items the guide will show you the estimated amount of gold you are earning in real time. When you're done farming click the link at the bottom of the step to be taken to the nearest Auctioneer where you can use the built in Auction Tools to post your items.\n\nThis completes the Gathering walkthrough.\n\nClick here to view the Auction Tools walkthrough.",
	
	['gold_goldrun_4_sum'] = "The Gold Runs tab will display a list of guides that are available to you with several columns of information to help you choose the best one. Lets take a look at how to read each column.",
	['gold_goldrun_5_header']	= "4a) Type",
	['gold_goldrun_5_sum'] = "The Type column shows you what sort of Gold Run this is. There are three types:\nDailies Run (!) - Make gold by completing a set of daily quests.\nVendor Run (_) - Make gold by buying and selling limited supply items sold by vendors.\nTilling Run (_) - Make gold by harvesting valuable items and selling them on the Auction House.",
	['gold_goldrun_6_header']	= "4b) Name",
	['gold_goldrun_6_sum'] = "The Name column shows you the factions, locations, or items associated with each run.",
	['gold_goldrun_7_header']	= "4c) Time",
	['gold_goldrun_7_sum'] = "The Time column shows the approximate time it will take to complete each run. The guides are grouped in increments of 15 minutes (15, 30, 45, ect.) to help you make the best use of your time.",
	['gold_goldrun_8_header']	= "4d) Gold",
	['gold_goldrun_8_sum'] = "The Gold column shows the estimated amount of gold you can earn using each run.\n\nNote: Due to the unpredicatable nature of the game the actual amount of gold earned will vary.",
	['gold_goldrun_9_header']	= "04-2) Select a guide",
	['gold_goldrun_9_sum'] = "Once you've found the guide you'd like to use simply click the orange guide picker button, or double click the entire row to load the guide. For the purposes of this walkthrough a special Gold Runs Walkthrough Guide has been added to the top of the list, so go ahead and select that guide now.",
	['gold_goldrun_10_header'] = "5) Follow the guide instructions",
	['gold_goldrun_10_sum'] = "Now follow the instructions displayed on the Guide Viewer to complete the gold run.\n\nIf you chose a Dailies Run you will complete daily quests and earn gold by turning them in. If you chose a Vendors or Tilling run the guide will walk you through obtaining valuable items to sell on the Auction House using Zygor's built in Auction Tools. This completes the Gold Runs walkthrough.\n\nClick here to view the Auction Tools walkthrough.",
	
	['gold_auctiontools_1_header']	= "Welcome to the Auction Tools walkthrough!",
	['gold_auctiontools_1_sum']	= "Zygor's Gold and Auctions guide is designed to be an all-in-one solution for all of your gold making needs. In this tutorial we will take a look at how Zygor's Auction Tools simplify the process of pricing your items and posting them on the Auction House. Click Next when you're ready to begin.",
	['gold_auctiontools_2_header']	= "01) Open the Auction Tools",
	['gold_auctiontools_2_sum']	= "To access the Auction Tools you need to bring up the Auction House panel by speaking with an Auctioneer. Follow the arrow to be taken to the nearest Auctioneer.",
	['gold_auctiontools_3_header']	= "02) Auction Tools Overview",
	['gold_auctiontools_3_sum']	= "The Auction Tools will appear to the right of the Auction House panel. When not in use you can collapse or expand the Auction Tools panel by clicking the \"Z\" icon.",
	['gold_auctiontools_4_header']	= "03) Switching Views",
	['gold_auctiontools_4_sum']	= "The Auction Tools have two modes of operation: Inventory View and Shopping View. You can switch between views by clicking the title tabs at the top of the frame.",
	['gold_auctiontools_5_header']	= "04) Inventory View",
	['gold_auctiontools_5_sum']	= "In Inventory View a list of all of the items you have available to sell will be shown. As soon as the Auction Tools are opened the built in appraiser feature will automatically scan the auction house and price your items based on their current market value. Lets take a look at each of the columns in Inventory View.",
	['gold_auctiontools_6_header']	= "04a) Inventory View - Items",
	['gold_auctiontools_6_sum']	= "The Items column shows your items and how much you have to sell.",
	['gold_auctiontools_7_header']	= "04b) Inventory View - Price",
	['gold_auctiontools_7_sum']	= "The Price column shows the recommended price you should sell this item for. This value is based on current market prices.",
	['gold_auctiontools_8_header']	= "04c) Inventory View - Status",
	['gold_auctiontools_8_sum']	= "The Status column tells you how the current market price compares to the average price over time. \n|cff00ff00Green|r Arrow up - Prices are higher than usual, so you should sell soon. \n|cff00ff00Green|r Power symbol - Prices are above expected maximum, goot time to sell. \n|cff00ff00Green|r Circle - Market is empty, you can sell at top price. \n|cffffff00Yellow|r circle - Prices are normal and stable. It's safe to sell. \n|cffff0000Red|r down arrow - Prices are lower than usual, you may want to wait until they go back up again. \n|cffaaaaaaGray|r circle - This item hasn't been seen on the auction house for some time. Not likely to sell.",
	['gold_auctiontools_selling1_header']	= "05a) Inventory View - Selling",
	['gold_auctiontools_selling1_sum']	= "[PH] If you want to sell any of items, click on it, and start dragging. When you do so, Auction House will switch to Auctions tab. ",
	['gold_auctiontools_selling2_header']	= "05b) Inventory View - Selling",
	['gold_auctiontools_selling2_sum']	= "[PH] Drop your dragged item here. ",
	['gold_auctiontools_selling3_header']	= "05c) Inventory View - Selling",
	['gold_auctiontools_selling3_sum']	= "[PH] Zygor will automatically set the prices for the item, based on current Auction House data. If prices are grayed out, it means that Zygor is still updateing scan data for this item. When prices turn green, you can sell. ",
	['gold_auctiontools_buying1_header']	= "05) Switch to Shopping List",
	['gold_auctiontools_buying1_sum']	= "[PH] Click here to switch to Shopping list.",
	['gold_auctiontools_buying2_header']	= "05b) Shopping List",
	['gold_auctiontools_buying2_sum']	= "[PH] Shopping list displays all items you have added from Gold Guide Auction House section, as well as all items that your current guide tells you to buy.",
	['gold_auctiontools_buying3_header']	= "05c) Shopping List",
	['gold_auctiontools_buying3_sum']	= "[PH] Clicking on any of listed items will do a search on it on auction house. If you searched for item added from Gold Guide Auction House section, auctions that are suggested for you to buy out will be marked with Deal icon. \nIf your search was for an item added from current guide step, all auctions that are priced below current server trend price will be marked in the same way.",

	['gold_mailtools_1_header']	= "Welcome to the Mail Tools walkthrough!",
	['gold_mailtools_1_sum']	= "Zygor's Gold and Auctions guide is designed to be an all-in-one solution for all of your gold making needs. In this tutorial we will take a look at how Zygor's Mail Tools simplify the process of collecting your items and sending them to your alts. Click Next when you're ready to begin.",
	['gold_mailtools_2_header']	= "01) Open the Mail Tools",
	['gold_mailtools_2_sum']	= "To open the Mail Tools go to the nearest mailbox and access your mail.",
	['gold_mailtools_3_header']	= "02) Mail Tools Overview",
	['gold_mailtools_3_sum']	= "The Mail Tools will appear to the right of the Auction House panel. When not in use you can collapse or expand the Auction Tools panel by clicking the \"Z\" icon.",
	['gold_mailtools_4_header']	= "03) Switching Views",
	['gold_mailtools_4_sum']	= "The Mail Tools have two modes of operation: Collect and Send View. You can switch between views by clicking the title tabs at the top of the frame.",
	['gold_mailtools_5_header']	= "04) Collect View",
	['gold_mailtools_5_sum']	= "Collect View shows you all the items and gold you have waiting in your mailbox.",
	['gold_mailtools_6_header']	= "04) Earned",
	['gold_mailtools_6_sum']	= "You can see the total amount of gold",
	['gold_mailtools_7_header']	= "05) Send View",
	['gold_mailtools_7_sum']	= "[PH] Click here to switch to Send View",
	['gold_mailtools_8_header']	= "05) Send View",
	['gold_mailtools_8_sum']	= "[PH] Send view displays all items in your inventory that can be send to another player.",
	['gold_mailtools_9_header']	= "05) Send View",
	['gold_mailtools_9_sum']	= "[PH] Select the items you want to send by checking the box next to their names.",
	['gold_mailtools_9_header']	= "06) Sending items",
	['gold_mailtools_9_sum']	= "[PH] Select the items you want to send by checking the box next to their names.",
	['gold_mailtools_10_header']	= "06) Sending items",
	['gold_mailtools_10_sum']	= "[PH] Enter the name of character you want to send items to. Last name used is stored, so you can send many mail easily.",
	['gold_mailtools_11_header']	= "06) Sending items",
	['gold_mailtools_11_sum']	= "[PH] You can select the names of characters you have recently sent to, or received mails from using this dropdown.",
	['gold_mailtools_12_header']	= "06) Sending items",
	['gold_mailtools_12_sum']	= "[PH] After you have selected items and recivers name, press this button to send the mail.",

	['gold_crafting_title_header']	= "4a) Item name",
	['gold_crafting_title_sum']	= "[PH] The Item name column shows which item you will be making.",
	['gold_crafting_status_header']	= "4b) Status",
	['gold_crafting_status_sum']	= "[PH] The Status column shows the status of selected craft. \n |cffffff00Yellow dot|cffffffff - You do not know the recipe to craft this item.\n |cffff0000Red dot|cffffffff - Not all components for this item are available at AH at this time.\n |cff00ff00Green dot|cffffffff - You know the recipe, and can buy all components on AH right now.\n",
	['gold_crafting_cost_header']	= "4c) Crafting cost",
	['gold_crafting_cost_sum']	= "[PH] The Crafting cost column shows the lowest calculated cost of crafting this item using components bought on AH, and farmed when component is not buyable.",
	['gold_crafting_profit_header']	= "4d) Profit",
	['gold_crafting_profit_sum']	= "[PH] The Profit column displays estimated profit when created item is sold on AH.",
	['gold_crafting_mode_header']	= "4e) Mode",
	['gold_crafting_mode_sum']	= "[PH] You can switch between two different modes of display: Easy and Expert. In Easy Mode, only items that you can craft right now, using components bought on Auction House are shown. Crafts that you do not know the recipe for are hidden, as well as any items with components not available on auction house. If you would like these items to be included you should use Expert Mode.",
	['gold_crafting_rows_header']	= "05 ) Browsing the guide list",
	['gold_crafting_rows_sum']	= "[PH] You can also view more details by hovering over any of the item in the list. This will show you all the steps needed to craft the selected item. Try it now, then click the Next button when you're ready to proceed.",

	['gold_auc_title_header']	= "4a) Item",
	['gold_auc_title_sum']		= "[PH] The Item column shows which item you will be investing in.",
	['gold_auc_status_header']	= "4b) Status",
	['gold_auc_status_sum']		= "[PH] The Status column shows projected risk of this investment. \n |cff00ff00Green dot|cffffffff - Great investment.\n |cffffff00Yellow dot|cffffffff - Good investment.\n |cffff0000Red dot|cffffffff - Risky investment.\n",
	['gold_auc_amt_header']		= "4c) Amount",
	['gold_auc_amt_sum']		= "[PH] The Amount column shows how many items will you be buying.",
	['gold_auc_cost_header']	= "4d) Cost",
	['gold_auc_cost_sum']		= "[PH] The Cost column shows how much gold will you be spending to buy out needed auctions.",
	['gold_auc_profit_header']	= "4e) Profit",
	['gold_auc_profit_sum']		= "[PH] The Profit column shows how much profit will you make after selling bought out items using our suggested price.",
	['gold_auc_gain_header']	= "4f) Gain",
	['gold_auc_gain_sum']		= "[PH] The Gain column shows percentage of profit you will make on that investment.",
	['gold_auc_mode_header']	= "4g) Mode",
	['gold_auc_mode_sum']		= "[PH] You can switch between three different modes of display: Easy, Advanced and Expert. In Easy Mode, only best investments are shown. Advanced mode shows all good investments. In expert mode, all investments that have a chance to turn profitable are displayed.",
	['gold_auc_filter_header']	= "4h) Filter",
	['gold_auc_filter_sum']		= "You can control what type of items are shown in the list using the Filter drop down.",
	['gold_auc_browse_header']	= "05 ) Browsing the guide list",
	['gold_auc_browse_sum']		= "[PH] You can also view more details by hovering over any of the item in the list. This will show you the details of all auctions you will need to buy out, and the profit you can make after selling items after each buyout step.",
	['gold_auc_add_header']		= "05-2) Select the item",
	['gold_auc_add_sum']		= "[PH] To select the investment you want to use click the orange guide picker button, or double click the entire row to add the item to Auction Tools Shopping List. Go ahead and select an item from the list now to continue.",
	--[[
	['gold_auc_final1_header']	= "06) Talk to an Auctioneer",
	['gold_auc_final1_sum']		= "[PH] Follow the arrow to be taken to the nearest Auctioneer, then speak with them to open Auction House window.",
	['gold_auc_final2_header']	= "07) Open Shopping Tab",
	['gold_auc_final2_sum']		= "[PH] Click on Shopping tab to open it, then click on selected item to search for it on AH. Buy out marked auctions. Click Next when you are done.",
	['gold_auc_final3_header']	= "07) Open Inventory Tab",
	['gold_auc_final3_sum']		= "[PH] Click on Inventory tab to open it, then click on bought items, and drag them to Auction House window to sell them at price suggested by Zygor Gold Guide.",
	--]]


	['gold_xxxx_1_header']	= "",
	['gold_xxxx_1_sum']	= "",
	['gold_xxxx_2_header']	= "",
	['gold_xxxx_2_sum']	= "",
	['gold_xxxx_3_header']	= "",
	['gold_xxxx_3_sum']	= "",
	['gold_xxxx_4_header']	= "",
	['gold_xxxx_4_sum']	= "",
	['gold_xxxx_5_header']	= "",
	['gold_xxxx_5_sum']	= "",
	['gold_xxxx_6_header']	= "",
	['gold_xxxx_6_sum']	= "",
	['gold_xxxx_7_header']	= "",
	['gold_xxxx_7_sum']	= "",
	['gold_xxxx_8_header']	= "",
	['gold_xxxx_8_sum']	= "",
	['gold_xxxx_9_header']	= "",
	['gold_xxxx_9_sum']	= "",

	["gold_gathering_no_results"] = "You do not meet the requirements for this section.\nYou must have a Gathering profession: Skinning, Herbalism, and/or Mining.",
	["gold_farming_no_results"] = "You do not meet the requirements for this section.",
	["gold_goldrun_no_results"] = "You do not meet the requirements for any of the selected group of guides.",
	["gold_crafting_no_results"] = "There are no results to display in this section.",
	["gold_crafting_no_profession"] = "You do not meet the requirements for this section. You must have a Crafting profession:\nExamples: Alchemy, Blacksmithing, Engineering, Inscription, Jewelcrafting, Tailoring, or Leatherworking.",

	["gold_expertmode_generictooltip"] = "Set investment mode.",
	["gold_expertmode_easylabel"] = "Easy",
	["gold_expertmode_easytooltip"] = "Only show items which should sell fast.",
	["gold_expertmode_expertlabel"] = "Expert",
	["gold_expertmode_experttooltip"] = "Show both fast- and slow-selling items.\nYou may end up with merchandise selling for days.",

	["gold_gathering_error_easymode"] = "\n\nNOTE: %d guides for low-demand items were filtered out.\nSwitch to Expert mode to include long term investments.",

	["gold_goldrun_error_one_noresults"] = "Your level is too low for any of the %s gold run guides.",
	["gold_goldrun_error_all_noresults"] = "Your level is too low for any gold run guides.",

	["gold_gathering_error_all_noprofessions"] = "You have not learned any Gathering profession.\n\nYou need to learn Skinning, Herbalism, Fishing or Mining.",
	["gold_gathering_error_all_lowskill"] = "Your skill in Gathering professions is insufficient:",
	["gold_gathering_error_one_noskillin"] = "You have not learned %s.\n\nYour gathering professions are:",
	["gold_gathering_error_one_lowskill"] = "Your skill in %s (%d) is too low.\nThere are no profitable routes for that skill level.",
	["gold_gathering_error_one_noresults"] = "No gathering routes for %s were found to be profitable at this moment.",
	["gold_gathering_error_prof"] = "%s (%d)",

	["gold_farming_error_noresults"] = "No farmable items were found for your level.",
	["gold_farming_error_noitemtype"] = "No farmable %s items were found for your level.",

	["gold_crafting_error_stillloading"] = "Still calculating crafting guides, please wait.",
	["gold_crafting_error_noprofessions"] = "You don't have a crafting profession.\nYou need to learn Alchemy, Blacksmithing, Engineering, Inscription, \nJewelcrafting, Tailoring, or Leatherworking.",
	["gold_crafting_error_noresults"] = "No profitable crafted items were found for your selected professions.",
	["gold_crafting_error_recipesnotcached"] = "No recipes were found for your profession.\nPlease open tradeskills window, and then restart Gold Guide.",

	["gold_auctions_error_fail"] = "Cannot calculate profitable auctions.",
	["gold_auctions_error_noresults"] = "No profitable auctions found.",

	["gold_no_scan_data"] = "Current prices unknown. Please scan the Auction House to collect data.",
	["gold_no_goldguide"] = "You don't have the full Gold Guide installed. No historical market data is available.",
	["gold_no_servertrends"] = "No historical data for this realm found. Please update your guides via the Zygor Guides client.",
	["gold_old_servertrends"] = "Historical data for this realm is out of date (%s). Please update your guides via the Zygor Guides client.",

	["app_gold_no_scan_data"] = "Please scan the Auction House to collect data.",
	["app_gold_no_servertrends"] = "No historical data for this realm found.",
	["app_gold_old_servertrends"] = "Historical data for this realm is out of date.",

	['petframe_button'] = "|cffffff00Click|cff00ff00 to find the guide for the '|cffffff00%s|cff00ff00' pet.",
	['achieveframe_button'] = "|cffffff00Click|cff00ff00 to load the guide for the '|cffffff00%s|cff00ff00' achievement.",

	['frame_questcleanupbutton'] = "Quest Log cleanup",
	['frame_questcleanupbutton_desc'] = "<<Click>>: abandon irrelevant quests|r",

	['waypoint_tip_clearmanual'] = "<<Right-click>>: remove waypoint",
	['waypoint_tip_distance'] = "Distance: %s",

	-- pointer_floors_<map_id>_<from_floor>_<to_floor>
	pointer_floors_321_1_2 = "-Descend into Cleft of Shadow",
	pointer_floors_321_2_1 = "+Leave Cleft of Shadow",
	pointer_floors_504_1_2 = "-Enter sewers",
	pointer_floors_504_2_1 = "+Leave sewers",
	pointer_floors_688_2_3 = "-Dive",
	pointer_floors_688_3_2 = "+Swim out",
	pointer_floors_27_0_11 = "*incave",
	pointer_floors_27_11_0 = "*outcave",
	pointer_floors_27_0_7 = "*incave",
	pointer_floors_27_7_0 = "*outcave",
	pointer_floors_27_0_6 = "-Enter tunnel",
	pointer_floors_27_6_0 = "+Exit tunnel",
	pointer_floors_29_0_14 = "-Enter Blackrock Mountain",
	pointer_floors_29_14_0 = "+Exit Blackrock Mountain",
	pointer_floors_29_14_15 = "-Enter side passage",
	pointer_floors_29_15_14 = "+Return to main hall",
	pointer_floors_29_14_16 = "-Descend down chains",
	pointer_floors_29_16_14 = "+Climb up chains",
	pointer_floors_820 = "+(use Time Transit Device)",
	pointer_floors_811_0_3 = "+Enter City",
	pointer_floors_811_3_0 = "+Exit City",
	pointer_floors_811_3_4 = "+Go upstairs",
	pointer_floors_811_4_3 = "-Go downstairs",
	pointer_floors_up = "+Go upstairs",
	pointer_floors_down = "-Go downstairs",
	pointer_floors_incave = "-Enter cave",
	pointer_floors_outcave = "+Exit cave",
	pointer_floors_inmine = "-Enter mine",
	pointer_floors_outmine = "+Exit mine",


	itemfinder_openguide_dung = "Found in: |cffffffff%s|r",
	itemfinder_openguide_dung_h = "Found in: |cffffffff%s|r (heroic)",
	itemfinder_openguide_boss = "Dropped by: |cffffffff%s|r",
	itemfinder_openguide_quest = "Reward from: |cffffffff%s|r",
	itemfinder_openguide_special = "From Event: |cffffffff%s|r",
	itemfinder_openguide_open = "<<Click>>: open the dungeon guide.",
	itemfinder_header = "Zygor Gear Suggestions:",
	itemfinder_itemsindung = "Items found:",
	itemfinder_noupgrade = "No Upgrade Found",
	itemfinder_noupgrade_desc = {"No possible upgrades were found at this moment.","More items will probably become available when you gain in levels","or improve your average gear level."},
	itemfinder_noitems = "No Items Available",
	itemfinder_noitems_desc = {"No items were found to match your criteria.","It could mean your level is too low to use any dungeon gear yet."},
	itemfinder_soon = "Available at %s %d",
	itemfinder_refresh = "Update",
	itemfinder_refresh_desc = false,

	dungeon_normal = "%s (normal)",
	dungeon_heroic = "%s (heroic)",

	loot_sellgreys_sold = "Sold %s x |cffffdd00%d|r for |cffffdd00%s|r",
	loot_sellgreys_total = "Total income: %s",
	loot_greyframe_maintext = "Total value of gray items",
	loot_sellgreybutton = "Sell Grays",
	loot_autobuynotmoney = "%s does not use gold to buy. Please purchase it yourself.",
	loot_autobuynostock = "%s x |cffffdd00%d|r are not available at this time.",
	loot_autobuynotavail = "|cffffee66 not available at this vendor or is out of stock.",
	loot_autobuynoroom = "Not enough room for %d stacks.",
	loot_autobuypoor = "You do not have enough money to buy all items. |cffffdd00%s|r is needed.",
	loot_autobuyframetext = "Would you like to buy\n%sfor\n|cffffdd00%s|r",
	}
	for k,v in pairs(f) do
		if type(v)=="string" then  f[k]=v:gsub("<<(.-)>>",COLOR_TIP_MOUSE.."%1"..COLOR_TIP)  end
	end
	return f
end)

ZygorGuidesViewer_L("Faction", "enUS", function() return {
	["going"] = "%d%% to %s"
} end)


local plurals = {
	Ballista="Ballistae",
	Bark=1,
	Briarthorn=1,
	Blood=1,
	Bruiseweed=1,
	Cargo=1,
	Child="Children",
	--Citizen="Citizens",
	Chutney=1,
	Dirt=1,
	Down=1,
	Dreamfoil=1,
	drunk=1,
	Dust=1,
	Earth=1,
	Felsworn=1,
	Felweed=1,
	Ferocious=1,
	Flesh=1,
	Flour=1,
	Gizmo="Gizmos",
	Glory=1,
	Gromsblood=1,
	Grow=1,
	Harvest=1,
	Heartwood=1,
	Honey=1,
	Ichor=1,
	Infantry=1,
	Kingsblood=1,
	Leather=1,
	Lumber=1,
	Lotus="Lotuses",
	Mageroyal=1,
	Meat=1,
	Milk=1,
	Mogu=1,
	mogu=1,
	Mojo=1,
	Nitroglycerin=1,
	Nitrate=1,
	Oil=1,
	Ore=1,
	Port=1,
	Prey=1,
	Pulp=1,
	Rice=1,
	Sap=1,
	Silk=1,
	Snuff=1,
	Spawn=1,
	Stuff=1,
	Supplies=1,
	Talisman="Talismans",
	Tooth="Teeth",
	Topaz=1,
	Truegold=1,
	Venom=1,
	Vermin=1,
	Venison=1,
	Vrykul=1,
	Water=1,
	wildlife=1,
	Witchban=1,
	Worgen=1,
	Wood=1
	--Wolf="Wolves",
}

local specials = {
	{'in a duel',1},
	{'Scarlet Crusader slain',"Scarlet Crusaders"},
	{'Citizen of Havenshire slain',"Citizens of Havenshire"},
	{'Garm Invader slain',"Garm Invaders"},
	{'En\'kilah Casualty',"En'kilah mobs"},
	{'(.*) [sS]lain$',"%1"},
	{'(.*) Weed$',"%1 Weeds"},
	{'Smelt ',1},
	{'Miners\' Gear',1},
	{'Miracle%-Grow',1},
}

local wordspecials = {
	['haman$']="hamans",
	['(%a)man$']="%1men",
	['(%a)us$']="%1i",
	['%a*[fF]ish$']=1,
	['%a*[cC]loth$']=1,
}

local notverbs = { ['Seed']=1 }

ZygorGuidesViewer_L("Specials", "enUS", function() return {
	['plural'] = function (word)
			if not word then return end
			-- one-shot special cases
			for i,data in ipairs(specials) do
				if word:match(data[1]) then
					return data[2]==1 and word or word:gsub(data[1],data[2])
				end
			end

			-- breakdown.
			local rest=""
			local preof,postof = word:match("^(.-) of (.+)$")
			if preof then
				word=preof
				rest=" of "..postof
			else
				local obj,verb = word:match("^(.+)( %a-ed)$")
				if obj and not notverbs[verb:sub(2)] then
					word=obj
					rest=verb
				end
			end

			local notlastw,lastw = word:match("^(.+%s)(.-)$")
			if lastw then
				word=lastw
			else
				notlastw=""
			end

			-- got a proper exception for this word?
			if plurals[word] then
				return notlastw .. (plurals[word]==1 and word or plurals[word]) .. rest
			-- well, got a regexp for it?
			else
				for sing,plur in pairs(wordspecials) do
					if word:match(sing) then
						return notlastw .. (plur==1 and word or word:gsub(sing,plur)) .. rest
					end
				end

				--else...

				-- just use language defaults, I guess.
				local last = word:sub(-1)
				if (last=="y" and not word:sub(-2):match("[aeiou]y")) then
					return notlastw .. word:sub(1,-2).."ies" .. rest
				elseif word:sub(-2)=="ff" then
					return notlastw .. word:sub(1,-3).."ves" .. rest
				elseif last=="f" then
					return notlastw .. word:sub(1,-2).."ves" .. rest
				elseif word:sub(-2)=="fe" then
					return notlastw .. word:sub(1,-3).."ves" .. rest
				elseif word:sub(-3)=="ess" then
					return notlastw .. word.."es" .. rest
				elseif word:sub(-2)=="ch" or word:sub(-2)=="sh" then
					return notlastw .. word.."es" .. rest
				elseif last=="x" then
					return notlastw .. word.."es" .. rest
				elseif last=="s" then
					return notlastw .. word .. rest
				elseif last=="o" then
					return notlastw .. word .."es" .. rest
				-- the following is to prevent pluralization of goal items ending with a double-quote
				elseif last=="\"" then
					return notlastw .. word .. rest
					--print(notlastw.."..."..word.."..."..rest)
				else
					return notlastw .. word.."s" .. rest
				end
			end
		end,

	['contract_mobs'] = function(mobs)
			local start,ending

			if not mobs[1].name and type(mobs)=="table" then
				local l=mobs
				mobs={}
				for i=1,#l do mobs[i]={name=l[i]} end
			end

			if mobs[1].name:match("^Echo of") then return nil end

			local common,lastcommon,all
			for i=1,5 do
				common = mobs[1].name:match("^([%a']+" .. (" [%a']+"):rep(i-1) .. ")")
				if not common then break end
				all=true
				for m=2,#mobs do
					if mobs[m].name:find(common)~=1 then
						all=false
						break
					end
				end
				if all then
					lastcommon=common
				else
					break
				end
			end

			if lastcommon then
				return ZygorGuidesViewer_L("Specials")['contract_mobs_start'](lastcommon)
			end

			-- start failed? let's try end.
			lastcommon=nil
			for i=1,5 do
				common = mobs[1].name:match("([%a']+" .. (" [%a']+"):rep(i-1) .. ")$")
				if not common then break end
				all=true
				for m=2,#mobs do
					if mobs[m].name:sub(-#common)~=common then
						all=false
						break
					end
				end
				if all then
					lastcommon=common
				else
					break
				end
			end

			if lastcommon then
				return ZygorGuidesViewer_L("Specials")['contract_mobs_end'](lastcommon)
			end

			--else
			return nil
		end,

	['contract_mobs_start'] = function(s) return s.." mobs" end,
	['contract_mobs_end'] = function(s) return ZygorGuidesViewer_L("Specials")['plural'](s) end,

	['plural_unittest'] = function()
		function test(s,p)
			local sp = ZygorGuidesViewer_L("Specials").plural(s)
			if sp~=p then print("Pluralization failed: '"..s.."' -> '"..sp.."', should be '"..p.."'") end
		end

		-- specials
		test("Meat","Meat")
		test("Oil of Olaz","Oil of Olaz")
		test("Big Crappers slain","Big Crappers")

		-- word specials
		test("Dead Shaman of Crap","Dead Shamans of Crap")
		test("Eric Cartman","Eric Cartmen")

		-- tails
		test("Knife","Knives")
		test("Flesh","Flesh")
		test("Staff of Doom","Staves of Doom")
		test("Ally of Crap","Allies of Crap")
		test("Dead Priestess","Dead Priestesses")
		test("Bitch","Bitches")
		test("Sex","Sexes")
		test("Kris","Kris")
		test("Jello","Jelloes")
		test("Dog","Dogs")

	end
} end)

ZGVLPL = ZygorGuidesViewer_L("Plurals")

ZygorGuidesViewer_L("Specials").plural_unittest()

-- Add lines for any translations needed for:

-- MISC STRINGS

ZygorGuidesViewer_L("G_string", "enUS", function() return {
--	["blabla"] = TRUE,
} end)

do return end
--[[
	local overlay =

/run f=ZGV.ChainCall(CreateFrame("FRAME","ZygorGuidesViewerDrawingOverlay",ZygorGuidesViewerPointerOverlay)) :SetSize(1,1) :SetPoint("CENTER") .__END   t=ZGV.ChainCall(f:CreateTexture("ZGVline01", "ARTWORK")) :SetTexture(0) :SetSize(100,5) :SetPoint("center") .__END
/run ag=f:CreateAnimationGroup() a=ZGV.ChainCall(ag:CreateAnimation("Rotation")) :SetDegrees(30) :SetDuration(0.01) .__END
--]]