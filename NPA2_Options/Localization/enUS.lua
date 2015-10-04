-- Author      : Nogarder
-- Create Date : 2012/12/9 5:48:03
NPA_Options.AviliableLocalization["English(enUS)"]={
	ID="enUS",
	Translator="Translator:Nogarder",
}
if(NPA_Options.Locale=="enUS" or (not NPA_Options.Localization))then  --using enUS as default
	NPA_Options.Localization={
		---media lib---
		InfoLibAnchor={
			["AnchorList"]={
				["TOP"]="TOP",
				["TOPRIGHT"]="TOPRIGHT",
				["TOPLEFT"]="TOPLEFT",
				["CENTER"]="CENTER",
				["RIGHT"]="RIGHT",
				["LEFT"]="LEFT",
				["BOTTOM"]="BOTTOM",
				["BOTTOMRIGHT"]="BOTTOMRIGHT",
				["BOTTOMLEFT"]="BOTTOMLEFT"
			},
			["MainFrame"]="Mainframe",
			Tooltips={
				["MainFrame"]="Parent frame for all modules, always shown"
			},
		},
		--
		InfoLibBasicType={
			Threat={
				[0]="Low threat",
				[1]="High threat",
				[2]="Losing threat",
				[3]="Tanking",
				[4]="No threat",
			},
			Faction={
				[1]="Friendly",
				[2]="Neutral",
				[3]="Hostile",
			},
			Class={
				["HUNTER"]="Hunter",
				["WARRIOR"]="Warrior",
				["PALADIN"]="Paladin",
				["MAGE"]="Mage",
				["PRIEST"]="Priest",
				["WARLOCK"]="Warlock",
				["DEATHKNIGHT"]="Deathknight",
				["DRUID"]="Druid",
				["SHAMAN"]="Shaman",
				["ROGUE"]="Rogue",
				["MONK"]="Monk",
			},
			Role={
				["TANK"]="Tank",
				["DAMAGER"]="Damager",
				["HEALER"]="Healer",
				["NONE"]="None",
			},
			Type={
				[1]="Player",
				[2]="Totem",
				[3]="Creature",
				[4]="Vendor",
			},
			RaidTarget={
				[1]="Raid target 1: YellowStar",
				[2]="Raid target 2: OrangeCircle",
				[3]="Raid target 3: PurpleDiamond",
				[4]="Raid target 4: GreenTriangle",
				[5]="Raid target 5: SilverMoon",
				[6]="Raid target 6: BlueSquare",
				[7]="Raid target 7: RedCross",
				[8]="Raid target 8: WhiteSkull",
			},
			Power={
				[0]="Mana",
				[1]="Rage",
				[2]="Focus",
				[3]="Energy",
				[6]="Runic Power",
			}
		},
		--
		InfoLibColorMode={
			["ColorModeList"]={
				[1]="By faction",
				[2]="By class",
				[3]="By threat",
				[4]="By default",
				[5]="By school",
				[6]="By percent",
				[7]="By aura type",
				[8]="By level different",
				[9]="By power type",
			},
			["ByFrameSetting"]={
				["BarGroup"]="By bar group setting",
				["Text"]="By font setting",
				["Number"]="By number setting",
			},
		},
		--
		InfoLibDataType={
			["Name"]="Name",
			["Level"]="Level",
			["Health"]="Health",
			["Class"]="Class",
			["Casting"]="Casting",
			["CastingShield"]="Casting interrupt shield",
			["None"]="None(Always Shown)",
			["Aura"]="Aura",
			["Target"]="Target",
			["Focus"]="Focus",
			["Mouseover"]="Mouseover",
			["Threat_High"]="Threat:High",
			["Threat_None"]="Threat:None",
			["Threat_Low"]="Threat:Low",
			["Threat_Tanking"]="Threat:Tanking",
			["Threat_Losing"]="Threat:Losing",
			["SpellLock"]="Spell lock",
			["Summoned"]="Summoned",
			["UnitID"]="Unit ID",
			["Unit"]="Unit",
			["GUID"]="GUID",
			["RaidTarget"]="Raid target",
			["Classification_Elite"]="Elite",
			["Classification_WorldBoss"]="World boss",
			["Quest"]="Quest",
			["CoolDown"]="Cooldown",
			["CrowdControl"]="CrowdControl",
			["CC_DR"]="CC_DR",
			["Power"]="Power",
			["ComboPoints"]="Combo points",
			["Speed"]="Speed",
			["Tapped"]="Tapped",
			["FullName"]="Full name (PVP name)",
			["Guild"]="Guild",
			["NPCGuild"]="NPC Guild",
			["Server"]="Player server name",
			["Role"]="Player role",
			["BaseEvent"]="Frame based Events",
		},
		--
		InfoLibFont={
			["System:Unit"] = UNIT_NAME_FONT,
			["System:Damage"] = DAMAGE_TEXT_FONT,
			["System:Chat"] = ChatFontNormal:GetFont(),
			["System:Default"] = NAMEPLATE_FONT,
		},
		InfoLibFontMode={
			["None"]="",
			["Outline"]="OUTLINE",
			["Thick"]="THICKOUTLINE",
			--["Mono"]="MONOCHROME",  --this would crash client for unknow reason
			["Outline+Thick"]="OUTLINE,THICKOUTLINE",
			["Outline+Mono"]="OUTLINE,MONOCHROME",
			["Thick+Mono"]="THICKOUTLINE,MONOCHROME",
			["Outline+Thick+Mono"]="OUTLINE,THICKOUTLINE,MONOCHROME",
		},
		InfoLibLayer={
			["0:Background"]="BACKGROUND",
			["1:Border"]="BORDER",
			["2:Artwork"]="ARTWORK",
			["3:Overlay"]="OVERLAY",
		},
		InfoLibModule={
			["Default"]="Default",
			["Text"]="Text",
			["BarGroup"]="BarGroup",
			["IconGroup"]="IconGroup",
			["TextureGroup"]="TextureGroup",
			["Number"]="Number",
			["Icon"]="Icon",
			["Alpha"]="Alpha",
			["Scale"]="Scale",
			["Offset"]="Offset",
			["FrameLevel"]="Frame level",
			Tooltips={
				["Default"]="Content of default nameplate",
				["Text"]="Text content (such as Name, Spell Name, unit level, casting timer)",
				["BarGroup"]="BarGroup content (such as castbar, healthbar, manabar)",
				["IconGroup"]="IconGroup content (such as buff, debuff, crowdcontrol timer)",
				["TextureGroup"]="TextureGroup content (such as background ,border,overlay)",
				["Number"]="Full number content(such as health value,mana value,threat percent)",
				["Icon"]="Single icons (such as casting icon, class icon, totem icon)",
				["Alpha"]="The alpha value of whole nameplate (Doesn't affect blizzard default nameplate)",
				["Scale"]="The scale of whole nameplate (Doesn't affatc blizzard default nameplate)",
				["Offset"]="The offset of whole nameplate (Doesn't affatc blizzard default nameplate)",
				["FrameLevel"]="The frame level of nameplate mainframe, it rules how nameplate overlapping each other, only works when 'ScrollFrame Rendering' is turned on in 'Core' page",
			},
			MainModule={
				Text="Mainframe",
				Value="MainFrame",
				Tooltips="Parent frame for all modules, always shown"
			}
		},
		--
		InfoLibSpell={
			School={
				[1]="Physic",
				[2]="Holy",
				[4]="Fire",
				[8]="Nature",
				[16]="Frost",
				[32]="Shadow",
				[64]="Arcane",
			},
			Class={
				["None"]="None(Physic)",
				["Bleed"]="Bleed",
				["Enrage"]="Enrage",
				["Magic"]="Magic",
				["Poison"]="Poison",
				["Curse"]="Curse",
				["Disease"]="Disease",
			},
			Catalog={
				["Unsorted"]="Unsorted",
				["NPC"]="NPC",
				["Player common"]="Player common",
				["Boss"]="Boss",
				["Warrior"]="Warrior",
				["Mage"]="Mage",
				["Warlock"]="Warlock",
				["Hunter"]="Hunter",
				["Shaman"]="Shaman",
				["Druid"]="Druid",
				["Paladin"]="Paladin",
				["Priest"]="Priest",
				["Monk"]="Monk",
				["DeathKnight"]="DeathKnight",
				["Rogue"]="Rogue",
			},
			DrType={
				["None"]="None",
				["Roots"]="Roots",
				["Roots(short)"]="Roots(short)",
				["Stuns"]="Stuns",
				["Stuns(short)"]="Stuns(short)",
				["Mesmerizes"]="Mesmerizes",
				["Mesmerizes(short)"]="Mesmerizes(short)",
				["Fears"]="Fears",
				["Horrors"]="Horrors",
				["Silences"]="Silences",
				["Disarms"]="Disarms",
				["Knockbacks"]="Knockbacks",
				["Cyclone"]="Cyclone(Druid)",
				["Charm"]="Charm(Priest)",
				["CounterSpell"]="CounterSpell",
				["Polymorph"]="Polymorph",
			},
			CDType={
				[1]={
					Text="Cooldown when used",
					Value=0,
					Tooltips="Cooldown starts when spell is used",
				},
				[2]={
					Text="Cooldown when lost",
					Value=1,
					Tooltips="Cooldown starts after the spell'effect is lost",
				}
			},
			AffectType={
				[1]={
					Text="Reduce cooldown",
					Value=0,
					Tooltips="The cast of main spell will reduce this spell's cooldown by a certain amount",
				},
				[2]={
					Text="Extend cooldown",
					Value=1,
					Tooltips="The cast of main spell will extend this spell's cooldown by a certain amount",
				},
				[3]={
					Text="Suppress showing",
					Value=4,
					Tooltips="When showing the main spell, don't show suppressed spell",
				},
				[4]={
					Text="Related showing",
					Value=5,
					Tooltips="Show the main spell only when all related spells is also showing",
				},
			},
		},
		--
		InfoLibTextureMode={
			["DISABLE"]="DISABLE",
			["BLEND"]="BLEND",
			["ALPHAKEY"]="ALPHAKEY",
			["ADD"]="ADD",
			["MOD"]="MOD"
		},
		InfoLibUnit={
			[COMBATLOG_OBJECT_TYPE_OBJECT]="Object",
			[COMBATLOG_OBJECT_TYPE_GUARDIAN]="Guardian",
			[COMBATLOG_OBJECT_TYPE_PET]="Pet",
			[COMBATLOG_OBJECT_TYPE_NPC]="NPC",
			[COMBATLOG_OBJECT_TYPE_PLAYER]="Player",
		},
		---Templates---
		TemplatesElementsScrollFrame={
			["DragThisToScroll"]="Drag this to scroll",
		},
		TemplatesFramesButton={
			["Save"]="Save",
			["Cancel"]="Cancel",
			["Reset"]="Reset",
			--
			["AnchorList"]="Anchors",
			["Texture"]="Texture",
			["Icon"]="Icon",
			["Font"]="Font",
			--
			["Edit"]="Edit",
			--
			["Change"]="Change",
			["Add"]="Add",
			["Remove"]="Remove",
			--
			["EditAnchor"]="Edit anchor",
			--
			["Number"]="Number",
			["BarGroup"]="BarGroup",
			["CountDown"]="CountDown",
			--
			["LookUp"]="Add+",
			--
			["Test"]="Test",
			--
			["Profile"]=" profile",
			TipText={
				["Save"]="Changes saved",
				["Cancel"]="Changes cancelled",
				["Reset"]="Page reseted",
			},
			Tooltips={
				["Save"]="Save the changes done to current page",
				["Cancel"]="Cancel the changes done to current page",
				["Reset"]="Reset this page to default setting",
				--
				["Edit"]="Edit selected setting, changes will apply to all modules using this setting",
				--
				["Add"]="Add item to the list",
				["Remove"]="Remove unchosen items from the list",
				--
				["AnchorList"]="Set the mainframe anchors of this module; Can set different position based on whether other modules are shown",
				["Texture"]="Texture for decoration",
				--
				["LookUp"]="Add by looking up",
			}
		},
		--
		TemplatesFramesCheckBox={
			["Enable"]="Enable",
			Tooltips={
				["Enable"]="Enable this module in current profile",
			},
			TipText={
				["Enable"]={
					Checked="Enabled",
					UnChecked="Disabled",
				},
			}
		},
		--
		TemplatesFramesCloser={
			["ClickThisToClose"] = "Click this to close"
		},
		TemplatesFramesDragger={
			["DragThis"] = "Drag this to move"
		},
		--
		TemplatesPreview={
			["Preview"]="Preview",
			["Profile"]="Profile",
			--
			["Percent"]="Percent",
			["Name"]="Name",
			["Level"]="Level",
			["Health"]="Health",
			["HealthMax"]="Health max",
			["FrameDataBuilder"]="Frame data builder",
			["Type"]="Type",
			["School"]="School",
			--
			["Casting"]="Casting",
			["Aura"]="Aura",
			["Target"]="Target",
			["Quest"]="Quest",
			["SpellLock"]="Spell lock",
			["Summoned"]="Summoned",
			["RaidTarget"]="Raid target",
			["CoolDown"]="Cooldown",
			["CC_DR"]="CC DR",
			["Guild"]="Guild",
			--
			Tooltips={
				["Type"]="Including faction, class, threat",
				["Aura"]="Including buff and debuff",
				["Target"]="Set target to self (lasts 60s)",
				["School"]="Spell school",
				["CC_DR"]="CrowdControl Diminishing Return",
			},
			--casting
			["Casting"]="Casting",
			["CastingMax"]="Casting time",
			["Set"]="Set",
			["Channeling"]="Channeling",
			["NotInterruptable"]="Not interrupt-able",
			--name
			["Change"]="Change",
			["InputANewName"]="Input a new name",
			--type
			["Type"]="Type",
			["Faction"]="Faction",
			["Class"]="Class",
			["Threat"]="Threat status",
			--value
			["Value"]="Value",
			["Max"]="Max value",
			--aura
			["SpellId"]="Spell id",
			["TimeLength"]="Time length",
			["StackCount"]="Stack",
			["Sort"]="Sort",
			["Add"]="Add",
			["SortTable"]={
				[1]={
					Text="Debuff",
					Value="DEBUFF",
				},
				[2]={
					Text="Buff",
					Value="BUFF",
				},
			},
			--cc_dr
			["DRType"]="Diminishing return type",
			--classification
			["Classification"]="Elite",
			["ClassificationList"]={
				[1]={
					Text="Normal",
					Value="normal",
				},
				[2]={
					Text="World Boss",
					Value="worldboss",
				},
				[3]={
					Text="Elite",
					Value="elite",
				},
			},
			--role
			["Role"]="Player Role",
			["NONE"]="None"
		},
		------------
		TemplatesWidgetsMsgBox={
			["Yes"]="Yes",
			["No"]="No",
		},
		------------
		TemplatesWidgetsAnchorPreview={
			["Scaling"]="Scale:",
		},
		TemplatesWidgetsDropDownEditor={
			["DataType"]="Data type",
			["ColorMode"]="Coloring method",
			["InputValue"]="Set a value here",
			["ClickForMenu"]="Click here to open/close menu",
			["AnchorFrame"]="Anchor frame",
			Tooltips={
				["DataType"]={
					["Text"]="The data this text would show (such as name, class)",
					["BarGroup"]="The data this bargoup would show (such as health, casting)",
					["Icon"]="The data this icon would show (such as class, totem)",
				},
				["AnchorFrame"]="The frame to which this frame anchors",
			}
		},
		--
		TemplatesWidgetsFrameWithBar={
			["DragToMove"]="Drag to move",
			["DragToScale"]="Drag this to scale",
			["ClickThisToReset"] = "Click this to reset",
			["ClickToMinimize"]="Click this to minimize/restore",
		},
		TemplatesWidgetsInputBox={
			["EscToCancel"]="Press Enter to confirm ; Press Escape to cancel",
			["+"]="Extra options"
		},
		-----------
		TemplatesWidgetsListEditor={
			["InputNewName"]="Input a new name",
			--for dropdown menu
			["Create"]="Create",
			["Created"]="Created",
			["Copied"]="copied as",
			["sCopy"]=" 's copy",
			["Copy"]="Copy",
			["Delete"]="Delete",
			["Deleted"]="Deleted",
			["Rename"]="Rename",
			["RenamedTo"]="Renamed to",
			Tooltips={
				["SelectSetting"]="select a setting to edit ; right click for menu",
				--for dropdown menu
				["Create"]="Create a new setting",
				["Copy"]="Create a setting with same content of this setting",
				["Delete"]="Delete this setting",
				["Rename"]="Rename this setting",
				["CantDeleteDefault"]="Can't delete Default setting",
				["CantRenameDefault"]="Can't rename Default setting",
			}
		},
		-----------
		TemplatesWidgetsPriorityEdit={
			["Create"]="Create",
			["Created"]="Condition created",
			["Copied"]="Copied",
			["Copy"]="Copy",
			["Delete"]="Delete",
			["Deleted"]="Deleted",
			["MoveUp"]="Move Up",
			["MoveDown"]="Move Down",
			Tooltips={
				["Priority"]="Condition near top has higher priority; Drag to change position; Right click for menu",
				--
				["Create"]="Create a new condition",
				["Copy"]="Create a condition with same content as this one",
				["Delete"]="Delete this condition",
				["CantDelete"]="There must be at least one condition",
				["MoveUp"]="Move this condition one block up",
				["MoveDown"]="Move this condition one block down",
			}
		},
		----------------------
		TemplatesWidgetsSliderEdit={
			["Width"]="Width",
			["Height"]="Height",
			["Layer"]="Layer",
			["Alpha"]="Alpha",
			["Scale"]="Scale",
			Tooltips={
				["Layer"]="Layer this module is in; frame in higher layer would overlap on frame in lower layer",
			},
		},
		----------------------
		TemplatesWindowAnchorEditor={
			["AnchorEdit"]="Anchor edit",
			--
			["SelfAnchor"]="Anchor self's point",
			["ToAnchor"]="To target's point",
			--
			["OffsetX"]="Offset X",
			["OffsetY"]="Offset Y",
			Tooltips={
				["SelfAnchor"]="Self's anchor point used for positioning",
				["ToAnchor"]="Target's anchor point used for positioning",
				--
				["OffsetX"]="Offset on the axis X",
				["OffsetY"]="Offset on the axis Y",
			}
		},
		----------------------
		TemplatesWindowBarEditor={
			["BarEdit"]="Bar edit",
			--
			["Width"]="Width",
			["Height"]="Height",
			--
			["Layer"]="Layer",
			--
			["ColorMode"]="Coloring mode",
			["ByPercent"]="By percent",
			["ByTextureSetting"]="By texture setting",
			["MinColor"]="Color of minimum value",
			["MaxColor"]="Color of maximum value",
			--
			["EditAnchor"]="Change anchor and offsets",
			--
			["Percent"]="Percent",
			["PercentFrom"]="Starting percent",
			["PercentTo"]="End percent",
			--
			["Direction"]="Direction",
			--
			["HideWhenMax"]="Hide when maximum",
			["EnableSizeChange"]="Change size",
			["EnableTextureChange"]="Change texture",
			Tooltips={
				["Width"]="Bar width",
				["Height"]="Bar height",
				--
				["Layer"]="The layer it's in, layer with higher value would overlap which with lower value",
				--
				["MinColor"]="The color when percent is minimum; when coloring by percent, the color will be caculated based on this value",
				["MaxColor"]="The color when percent is minimum; when coloring by percent, the color will be caculated based on this value",
				--
				["PercentFrom"]="When the percent of bargroup reach this value, this bar will be shown",
				["PercentTo"]="When the percent of bargruop reach this value, the valu of this bar would reach its max",
				--
				["Direction"]="The direction of bar indentation (by degree), set to 360 for no indentation",
				--
				["EnableSizeChange"]="Change bar size based on percent",
				["EnableTextureChange"]="Change texture based on percent",
				["HideWhenMax"]="Hide this bar when it's at maximum",
			}
		},
		----------------------
		TemplatesWindowBarGroupEditor={
			["SelectBar"]="Select a status bar",
			Tooltips={
				["SelectBar"]="select a status bar to edit ; right click for menu",
			}
		},
		----------------------
		TemplatesWindowColorPicker={
			["ColorPicker"]="Color",
			["ColorR"]="Red",
			["ColorG"]="Green",
			["ColorB"]="Blue",
			["ColorA"]="Alpha",
			["Done"]="Done",
			["Reset"]="Reset",
			["UseBlizzard"]="Use Blizzard's frame",
			Tooltips={
				["ColorR"]="Red value of the color",
				["ColorG"]="Green value of the color",
				["ColorB"]="Blue value of the color",
				["ColorA"]="Alpha value of the color",
				["Done"]="Confirm current setting",
				["Reset"]="Reset current page",
				["UseBlizzard"]="Use Blizzard's color picker frame",
			}
		},
		----------------------
		TemplatesWindowCountDownEditor={
			Tooltips={}
		},
		----------------------
		TemplatesWindowFontEditor={
			["FontEdit"]="Font profile:  ",
			--
			["NameOrPath"]="Font name or file path",
			["RenderMode"]="Render mode",
			["ShadowOffsetX"]="Shadow offset X",
			["ShadowOffsetY"]="Shadow offset Y",
			["Color"]="Color",
			--
			["PreviewText"]="Test text ABC",
			Tooltips={
				["MustExistWhenLoad"]="To load a file it must exists when game started",
				["RenderMode"]="How the font is rendered",
				["ShadowOffsetX"]="offset of font shadow on axis X",
				["ShadowOffsetY"]="offset of font shadow on axis Y",
				--
				["Color"]="Font's default color",
			}
		},
		----------------------
		TemplatesWindowNumberEditor={
			["Number edit"]="Number edit",
			--
			["Value"]="Value",
			["Short"]="Short",
			["Break"]="Break",
			["Max"]="Max",
			["Percent"]="Percent",
			["Brackets"]="Brackets",
			["PercentMark"]="Sign",
			["Edit"]="Edit",
			["Font"]="Font",
			["DontShow"]="Don't show",
			["ByPercent"]="By percent",
			["MinColor"]="Color of minimum value",
			["MaxColor"]="Color of maximum value",
			--
			["PreviewValue"]="Preview value",
			["PreviewMax"]="Preview maximum value",
			Tooltips={
				["MinColor"]="The color when percent is minimum; when coloring by percent, the color will be caculated based on this value",
				["MaxColor"]="The color when percent is minimum; when coloring by percent, the color will be caculated based on this value",
			}
		},
		----------------------
		TemplatesWindowNumberTextEditor={
			["TextEdit"]="Text edit",
			--
			["ColorMode"]="Coloring method",
			["ByFontSetting"]="By font setting",
			["Custom"]="Custom",
			--
			["CustomColor"]="Custom color",
			--
			["Size"]="Size",
			--
			["Layer"]="Layer",
			--
			["Width"]="Width",
			--
			["Decimal"]="Don't show Decimal",
			--
			["EditAnchor"]="Change anchor and offsets",
			["TestText"]="1234567890",
			Tooltips={
				["CustomColor"]="Set custom color",
				--
				["Size"]="Size of displayed font",
				--
				["Layer"]="The layer it's in, layer with higher value would overlap which with lower value",
				--
				["Width"]="Text width, set to 0 for auto",
			}
		},
		----------------------
		TemplatesWindowSpellEditor={
			["SpellId"]="Spell id",
			["SpellName"]="Spell name",
			["SpellSchool"]="Spell school",
			["SpellIcon"]="Spell Icon",
			["SpellClass"]="Spell type",
			--
			["CastTime"]="Cast time (by second)",
			["MinRange"]="Minimum range (by yard)",
			["MaxRange"]="Maximum range (by yard)",
			["CoolDown"]="Cooldown time (by second)",
			["CoolDownStack"]="Cooldown stack",
			["Length"]="Length (by second)",
			["MaxStack"]="Max stack",
			["Catalog"]="Catalog",
			["CounterSpellLength"]="Counter spell length (by second)",
			["PVPLength"]="PvP length (by second)",
			["PVPDRType"]="PvP CC type",
			["NoDR"]="No DR",
			--
			["CoolDownType"]="Cooldown type",
			["AffectSpellList"]="Affect spell list",
			--
			["AffectType"]="Affect type",
			["AffectAmount"]="Affect amount",
			["SpellAlreadyExists"]="Spell already exists, moved to current type",
			Tooltips={
				["CastTime"]="How long the spell needed to cast",
				["MinRange"]="Minimum casting range",
				["MaxRange"]="Maximum casting range",
				["CoolDown"]="Time to cooldown",
				["CoolDownStack"]="For spell of new 'stack-cooldown-type', set to 0 for normal spell",
				["Length"]="Time the aura would last",
				["MaxStack"]="Maximum stack of the aura",
				["Catalog"]="This affects only where the spell displays in Options' spell-selector, changes won't be refreshed immediately",
				["CounterSpellLength"]="This affects only spell-counter spell, set to 0 for normal spell",
				["PVPLength"]="Set the time the aura would last in PvP, by second",
				["PVPDRType"]="Set the diminishing-return-type in PvP, lasting-time would reduce for same type, set 'None' for no DR",
				["NoDR"]="This spell doesn't trigger diminishing return (i.e. slowing effect)",
				--
				["CoolDownType"]="Set when the cooldown of this spell starts",
				["AffectSpellList"]="Set how this spell affect other spells",
				--
				["AffectType"]="How this spell is affected",
				["AffectAmount"]="How much this spell is affected; set to 0 for all",
			}
		},
		----------------------
		TemplatesWindowSpellLookUp={
			["LookFor"]="Look for",
			["ById"]="By id",
			["ByName"]="By name",
			["Change"]="Change"
		},
		----------------------
		TemplatesWindowTextureEditor={
			["TextureEdit"]="Texture edit",
			--
			["Width"]="Width",
			["Height"]="Height",
			--
			["Layer"]="Layer",
			--
			["EditAnchor"]="Change anchor and offsets",
			Tooltips={
				["Width"]="Texture width",
				["Height"]="Texture height",
				--
				["Layer"]="The layer it's in, layer with higher value would overlap which with lower value",
			}
		},
		----------------------
		TemplatesWindowTextureFileEditor={
			["TextureEdit"]="Texture profile:  ",
			--
			["NameOrPath"]="Texture name or file path",
			["BlendMode"]="Blend mode",
			["Color"]="Color",
			["Angle"]="Rotation angle",
			["Left"]="Left coordinate",
			["Right"]="Right coordinate",
			["Top"]="Top coordinate",
			["Bottom"]="Bottom coordinate",
			Tooltips={
				["MustExistWhenLoad"]="To load a file it must exists when game started",
				["BlendMode"]="How the texture is blended",
				["Angle"]="The rotation angle when texture is displayed",
				["Left"]="Left-side offset related to the original texture ;0 for left-end, 1 for right-end",
				["Right"]="Right-side offset related to the original texture ;0 for left-end, 1 for right-end",
				["Top"]="Top-side offset related to the original texture ;0 for top-end, 1 for bottom-end",
				["Bottom"]="Bottom-side offset related to the original texture ;0 for top-end, 1 for bottom-end",
				["Color"]="Texture displayed color",
			}
		},
		----------------------
		TemplatesWindowTextureGroupEditor={
			["SelectTexture"]="Select a texture profile",
			--editor
			["CurrentTexture"]="Current texture profile",
		},
		----------------------
		PagesMain={
			["Core"]="Core",
			["NamePlate"]="Nameplates",
			["ResourcesLib"]="Resources Lib",
			["TargetArrow"]="Target Arrow",
			["CombatText"]="Combat text",
			["Tracker"]="Tracker",
			["ProfileManager"]="Manage profile",
			["ProfilePorter"]="Inport/Export",
			["Help"]="Help",
			--
			["ReloadUI"]="Reload UI",
			["About"]="About",
			Tooltips={
				["Core"]="Core Options",
				["NamePlate"]="Nameplates setting",
				["ResourcesLib"]="The resources this addon uses, including font,texture,number display,color,spell,etc.",
				["TargetArrow"]="An arrow points to the unit's target",
				["CombatText"]="Floating text of combat information",
				["Tracker"]="Fake nameplates to track units which don't have namepaltes",
				["ProfileManager"]="Save ,load and delete different profile, these profiles are shared between characters on this server",
				--
				["RequireReload"]="Change on this option will take effect after UI reload",
				["ReloadUI"]="Reload all UI",
				["About"]="About this addon",
				["ProfilePorter"]="Inport/Export profiles",
			}
		},
		----------------------
		PagesNamePlate={
			["Appearance"]="Appearance",
			["Condition"]="Condition",
			Tooltips={
				["Appearance"]="Nameplate Appearance Setting ; Using this to change what the nameplate would look",
				["Condition"]="Nameplate Condition setting ; Using this to change in what condition a certain nameplate appearance should be used",
			}
		},
		----------------------
		PagesMainCore={
			["NamePlateModule"]="Nameplate modules",
			["DataCollector"]="Data collectors",
			--
			["Alpha"]="Alpha",
			["Aura"]="Aura",
			["Casting"]="Casting",
			["Classification"]="Classification",
			["Health"]="Health",
			["Level"]="Level",
			["Name"]="Name",
			["Quest"]="Quest",
			["RaidTarget"]="Raid target",
			["SpellLock"]="Spell lock",
			["Summoned"]="Summon",
			["Target"]="Target",
			["Threat"]="Threat",
			["Type"]="Type",
			["UnitID"]="Unit ID",
			["CoolDown"]="Cooldown",
			["CC_DR"]="CC Diminishing Return",
			["Power"]="Power",
			["ComboPoints"]="Combo points",
			["Speed"]="Speed",
			["Tapped"]="Tapped",
			["Guild"]="Guild",
			["NPCGuild"]="NPC Guild",
			["FullName"]="Full name",
			["Friends"]="Friends/Guild/Party/Raid list",
			["Role"]="Player Role",
			["Unit"]="Unit",
			["BaseEvent"]="Frame based event",
			--
			["BarGroup"]="Bar group",
			["Icon"]="Icon",
			["IconGroup"]="Icon group",
			["Number"]="Number",
			["Text"]="Text",
			["TextureGroup"]="Texture group",
			["Default"]="Default",
			["MainFrame"]="Main frame",
			--
			["ScrollFrameRender"]="Using ScrollFrame render",
			["CombiePetCoolDown"]="Combie pet's cooldown",
			["CombieMasterCoolDown"]="Combie master's cooldown",
			["InstantAsOneSecondCast"]="Instant spell counts as one second cast",
			["EnableAuraCache"]="Enable aura cache",
			["AdvancdedType"]="Enable advanced type tracking",
			["PowerMatch"]="Enable advanced nameplate tracking",
			--
			Tooltips={
				["Default"]="Change of this option (Default) requires UI reload to take effect",
				["MainFrame"]="Alpha needs this to work",
				--
				["ScrollFrameRender"]="Render each nameplate into a single layer, will solve nameplate overlapping but will affact module layer order (Require UI Reload to take effect)",
				["CombiePetCoolDown"]="Consider pet's ability cooldown as master's too",
				["CombieMasterCoolDown"]="Consider master's ability cooldown as pet's too",
				--
				["EnableAuraCache"]="Cache every encountered aura to make aura data aviliable without mouseover, at a cost of some resources",
				["AdvancdedType"]="Using combatlog to track unit type, for detecting pets and guradians more accurately, at a cost of resources",
				["PowerMatch"]="Using combatlog to track unit guid, for detecting NPC nameplates more accurately, at a cost of resources",
			}
		},
		----------------------
		PagesMainProfileManager={
			["Save"]="Save",
			["Load"]="Load",
			["InputName"]="Input a new name for the profile",
			["SettingWillLose"]="If continue,current settings will be lost",
			["ConfirmRemove"]="Confirm to remove this profile",
			["Saved"]=" saved",
			["Loaded"]=" loaded, some options may require ui reload to take effect",
			--
			["Current"]="Current profile",
			--
			["Export"]="Export",
			["CopyTheseText"]="Copy (ctrl+c) these text",
			["Exported"]=" setting string exported",
			--
			["Inport"]="Inport",
			["SaveTo"]="Save to",
			["PasteTextHere"]="Paste (ctrl+v) copied text code here",
			["ConfirmOverwritten"]="Some settings may be overwritten, confirm to continue",
			["Inported"]=" setting string inported",
			--
			["Premade"]="Premade",
			--
			Tooltips={
				["Save"]="Save current profile",
				["Load"]="Load selected profile",
				--
				["Export"]="Export profiles",
				["Inport"]="Inport profiles",
				--
				["Premade"]="Inport premade setting",
			},
		},
		----------------------
		PagesMainNamePlateAppearance={
			["SelectProfile"]="Select a profile",
			Tooltips={
				["SelectProfile"]="select a profile to edit ; right click for menu",
			}
		},
		----------------------
		PagesMainResourcesLib={
			["FontLib"]="Font lib",
			["TextureLib"]="Texture lib",
			["Color"]="Color",
			["Number"]="Number",
			["BarGroup"]="Bar group",
			["Class"]="Class",
			["Spell"]="Spell",
			["CountDown"]="Countdown",
			["RaidTarget"]="Raid target",
			["SelfLib"]="'Self'",
			["RoleLib"]="Role",
			--
			["ResourcesLib"]="Resources Lib",
			Tooltips={
				["FontLib"]="Font lib setting",
				["TextureLib"]="Texture lib setting",
				["Color"]="Change the basic color table used in modules",
				["Number"]="Change the look of number used in modules",
				["BarGroup"]="Change the look of status bar group used in modules",
				["Class"]="Change PC and NPC related data,icon,spell,color,etc",
				["Spell"]="Change spell related data",
				["CountDown"]="Change the look of countdown used in modules",
				["RaidTarget"]="The icon setting of raid target",
				["SelfLib"]="Display of player 'self'",
			}
		},
		----------------------
		PagesTargetArrowEditor={
			["TargetArrowEdit"]="Edit target arrow",
			["From"]="From",
			["To"]="To",
			["MaxPerLine"]="Max per line",
			["Gap"]="Gap",
			["SpeedPerSecond"]="Speed",
			["StartSize"]="Start size",
			["EndSize"]="End size",
			["StartOffsetX"]="Start offset x",
			["StartOffsetY"]="Start offset y",
			["EndOffsetX"]="End offset x",
			["EndOffsetY"]="End offset y",
			Tooltips={
				["From"]="Unit the arrows point from",
				["To"]="Unit the arrows point to",
				["MaxPerLine"]="Maximum count of arrows on the line",
				["Gap"]="The gap between arrows",
				["SpeedPerSecond"]="Speed the arrows moving in, set to 0 for still",
				["StartSize"]="Size of the arrow at the start point",
				["EndSize"]="Size of the arrow at the end point",
				["StartOffsetX"]="Offset x of the arrow at the start point",
				["StartOffsetY"]="Offset y of the arrow at the start point",
				["EndOffsetX"]="Offset x of the arrow at the end point",
				["EndOffsetY"]="Offset y of the arrow at the end point",
			},
			--0=any, 1=friendly,2=neutral,3=hostile,4=self
			FromToList={
				[1]={
					Text="Any",
					Value=0,
					Tooltips="Any unit",
				},
				[2]={
					Text="Self",
					Value=4,
					Tooltips="The player self",
				},
				[3]={
					Text="Friendly",
					Value=1,
					Tooltips="Friendly unit",
				},
				[4]={
					Text="Hostile",
					Value=3,
					Tooltips="Hostile unit",
				},
				[5]={
					Text="Neutral",
					Value=2,
					Tooltips="Neutral unit",
				},
				[6]={
					Text="Target",
					Value=5,
					Tooltips="Unit is target",
				},
				[7]={
					Text="Focus",
					Value=6,
					Tooltips="Unit is focus",
				},
				[8]={
					Text="Mouseover",
					Value=7,
					Tooltips="Unit is mouseover",
				},
			}
		},
		----------------------
		PagesCombatText={
			["CombatText"]="Combat text",
			["Condition"]="Condition",
			["Animation"]="Animation",
			--
			["From"]="From",
			["To"]="To",
			["Critical"]="Critical",
			["TextWidth"]="Text width",
			["TextHeight"]="Text height",
			["DetailedType"]="Detailed type",
			["IconSize"]="Icon size",
			["BGWidth"]="Background width offset",
			["BGHeight"]="Background height offset",
			["SpellListType"]="Spell list usage",
			["EditSpellList"]="Edit spell list",
			["IgnoreOverkill"]="Don't show full over kill",
			--
			["SpeedType"]="Speed behavior type",
			["SpeedX"]="Speed, X",
			["SpeedY"]="Speed, Y",
			["AccType"]="Accelerator behavior type",
			["AccX"]="Accelerator X",
			["AccY"]="Accelerator Y",
			["StartSize"]="Start size",
			["EndSize"]="End size",
			["StartAlpha"]="Start alpha",
			["EndAlpha"]="End alpha",
			["ShakeRange"]="Shake range",
			["FrameLevel"]="Frame level",
			["Lasts"]="Lasts time",
			--
			Tooltips={
				["Condition"]="Condition of when to show witch text animation",
				["Animation"]="Floating text animation list",
				--
				["From"]="Unit the combatlog information is from",
				["To"]="Unit the floating text is on",
				["Critical"]="Is this one critical",
				["TextWidth"]="Width of the text (set to 0 for automatic)",
				["TextHeight"]="Height of the text",
				["DetailedType"]="Display method of the text",
				["IconSize"]="Size of the icon",
				["BGWidth"]="Offset of the background, width",
				["BGHeight"]="Offset of the background, height",
				["SpellListType"]="Decide how the spell list works",
				["IgnoreOverkill"]="Don't show full over kill",
				--
				["SpeedType"]="Decide how the speed generated",
				["SpeedX"]="The x part of speed",
				["SpeedY"]="The y part of speed",
				["AccType"]="Decide how the accelerator generated",
				["AccX"]="The x part of accelerator",
				["AccY"]="The y part of accelerator",
				["StartSize"]="The size at the beginning",
				["EndSize"]="The size at the end",
				["StartAlpha"]="The alpha at the beginning",
				["EndAlpha"]="The alpha at the end",
				["ShakeRange"]="The range it will be shaked, set to 0 for no shaking",
				["FrameLevel"]="Frame level, frame with higher framelevel will overlap the frame with lower one",
				["Lasts"]="How long this part of animation lasts",
			},
			--0=any 1=player 2=target 3=focus 4=mouseover ,64=hostile 32=neutral, 16=friendly
			FromToList={
				[1]={
					Text="Any",
					Value=0,
					Tooltips="Any unit",
				},
				[2]={
					Text="Self",
					Value=1,
					Tooltips="The player self",
				},
				[3]={
					Text="Friendly",
					Value=16,
					Tooltips="Friendly unit",
				},
				[4]={
					Text="Hostile",
					Value=64,
					Tooltips="Hostile unit",
				},
				[5]={
					Text="Neutral",
					Value=32,
					Tooltips="Neutral unit",
				},
				[6]={
					Text="Target",
					Value=2,
					Tooltips="Unit is target",
				},
				[7]={
					Text="Focus",
					Value=3,
					Tooltips="Unit is focus",
				},
				[8]={
					Text="Mouseover",
					Value=4,
					Tooltips="Unit is mouseover",
				},
				[9]={
					Text="Pets",
					Value=5,
					Tooltips="Self's pets and minions",
				},
			},
			CritList={
				[1]={
					Text="Both",
					Value=0,
					Tooltips="Both critical and non-critical",
				},
				[2]={
					Text="Non-critical",
					Value=2,
					Tooltips="Only for non-critical"
				},
				[3]={
					Text="Critical",
					Value=1,
					Tooltips="Only for critical"
				},
			},
			TextType={
				[1]={
					Text="No detail",
					Value=1,
					Tooltips="Show standard text",
				},
				[2]={
					Text="Detailed",
					Value=2,
					Tooltips="Show detailed text"
				},
			},
			--combatlog event
			["EventLocalization"]={
				["SWING_DAMAGE"]="Melee swing damage",
				["SWING_MISSED"]="Melee swing missed",
				["SWING_EXTRA_ATTACKS"]="Melee swing extra attack",
				--range type
				["RANGE_DAMAGE"]="Range auto-attack damage",
				["RANGE_MISSED"]="Range auto-attack missed",
				["RANGE_EXTRA_ATTACKS"]="Range auto-attack extra attack",
				--spell damage type
				["SPELL_DAMAGE"]="Spell direct damage",
				["SPELL_PERIODIC_DAMAGE"]="Spell periodic damage",
				["SPELL_MISSED"]="Spell missed",
				["SPELL_DISPEL_FAILED"]="Spell dispel failed",
				----damage shield type --don't use these yet
				--["SPELL_DAMAGE_SHIELD_DAMAGE"]=true,
				--["SPELL_DAMAGE_SPLIT_DAMAGE"]=true,
				--["SPELL_DAMAGE_SHIELD_MISSED"]=true,
				--aura apply type
				["SPELL_AURA_APPLIED"]="Aura applied",
				["SPELL_AURA_APPLIED_DOSE"]="Aura dose applied",
				--aura remove type
				["SPELL_AURA_REMOVED"]="Aura removed",
				["SPELL_AURA_REMOVED_DOSE"]="Aura dose removed",
				["SPELL_AURA_BROKEN"]="Aura broken by auto-attack",
				["SPELL_AURA_BROKEN_SPELL"]="Aura broken by spell",
				["SPELL_STOLEN"]="Aura stolen",
				["SPELL_DISPEL"]="Aura dispeled",
				--energy type
				["SPELL_ENERGIZE"]="Unit energized",
				["SPELL_DRAIN"]="Energy drained",
				["SPELL_LEECH"]="Energy leeched",
				--inturrpt type
				["SPELL_INTERRUPT"]="Spell interrupted",
				--summon type
				["SPELL_CREATE"]="Created",
				["SPELL_SUMMON"]="Summoned",
				["SPELL_RESURRECT"]="Resurrected",
				--special type
				["UNIT_DIED"]="Died",
				["UNIT_DESTROYED"]="Destroyed",
				["ENVIRONMENTAL_DAMAGE"]="Environmental damage",
				--heal type
				["SPELL_HEAL"]="Direct heal",
				["SPELL_PERIODIC_HEAL"]="Periodic heal",
				--cast type
				["SPELL_CAST_START"]="Start casting",
				["SPELL_CAST_SUCCESS"]="Casting success",
			},
			--
			SpeedTypeList={
				[1]={
					Text="Fixed",
					Value=0,
					Tooltips="Fixed x and y",
				},
				[2]={
					Text="Top left",
					Value=1,
					Tooltips="Random at the top-left part, x and y works as range limit"
				},
				[3]={
					Text="Top right",
					Value=2,
					Tooltips="Random at the top-right part, x and y works as range limit"
				},
				[4]={
					Text="Bottom left",
					Value=3,
					Tooltips="Random at the bottom-left part, x and y works as range limit"
				},
				[5]={
					Text="Bottom right",
					Value=4,
					Tooltips="Random at the bottom-right part, x and y works as range limit"
				},
				[6]={
					Text="Top",
					Value=5,
					Tooltips="Random at the top part, x and y works as range limit"
				},
				[7]={
					Text="Bottom",
					Value=6,
					Tooltips="Random at the bottom part, x and y works as range limit"
				},
				[8]={
					Text="Left",
					Value=7,
					Tooltips="Random at the left part, x and y works as range limit"
				},
				[9]={
					Text="Right",
					Value=8,
					Tooltips="Random at the right part, x and y works as range limit"
				},
			},
			["SpellListTypeList"]={
				[1]={
					Text="Disable",
					Value=0,
					Tooltips="Don't use spell-list filter",
				},
				[2]={
					Text="Include",
					Value=1,
					Tooltips="Take effect when spell is in the spell-list"
				},
				[3]={
					Text="Exclude",
					Value=2,
					Tooltips="Take effect when spell is not in the spell-list"
				},
			},
		},
		----------------------
		PagesTracker={
			["Condition"]="Condition",
			["HideWhenConflict"]="Don't show when there's a true nameplate",
			["Friendly"]="Friendly unit",
			["Neutral"]="Neutral unit",
			["Hostile"]="Hostile unit",
			["ConditionType"]="Condition type",
			["Arg"]="Condition argument",
			["Group"]="Nameplate group",
			["Profile"]="Profile",
			--
			["Nameplates"]="Nameplates",
			["PosX"]="Offset X",
			["PosY"]="Offset Y",
			["NGroup"]="Nameplates group",
			["Index"]="Group index",
			["MaxTime"]="Max time",
			--
			["ExtraModule"]="Enable extra modules",
			--
			Tooltips={
				["HideWhenConflict"]="When a true nameplate is showing,hide this fake nameplate",
				["Friendly"]="Include friendly unit",
				["Neutral"]="Include neutral unit",
				["Hostile"]="Include hostile unit",
				["Profile"]="Profile this tracker nameplate is using",
				["Group"]="The nameplate group this condition is using,fitting unit will be shown on nameplates in this group",
				["NGroup"]="The group this nameplate is in, using for condition",
				["Index"]="The index of this nameplate in the group, when multiple unit fits condition, they will be shown on nameplates with lower index first",
				["MaxTime"]="Maximum time of each tracking",
				--
				["ExtraModule"]="Enable extra modules ('TargetArrow' and 'CombatText') on this track",
			},
			ConditionTypeList={
				[1]={
					Text="Unit is",
					Value="1",
					Tooltips="Unit is special unit",
				},
				[2]={
					Text="Unit's target is",
					Value="2",
					Tooltips="Unit's target is special unit",
				},
				[3]={
					Text="With aura",
					Value="3",
					Tooltips="Unit is with special aura",
				},
				[4]={
					Text="With cooldown",
					Value="6",
					Tooltips="Unit is with special cooldown",
				},
				[5]={
					Text="Without cooldown",
					Value="7",
					Tooltips="Unit is without special cooldown",
				},
			},
			UnitArgumentList={
				[1]={
					Text="Self",
					Value="Player",
					Tooltips="Player self",
				},
				[2]={
					Text="Target",
					Value="Target",
					Tooltips="Self's target",
				},
				[3]={
					Text="Focus",
					Value="Focus",
					Tooltips="The focus",
				},
				[4]={
					Text="Mouseover",
					Value="Mouseover",
					Tooltips="The mouseover",
				},
				[5]={
					Text="Pet",
					Value="Pet",
					Tooltips="Self's pet",
				},
			}
		},
		----------------------
		PagesNamePlateAppearanceModuleList={
			["CurrentProfile"]="Current profile",
			["SelectModule"]="Select a module to edit"
		},
		----------------------
		PagesModuleList={
			["SelectProfile"]="Select a profile",
			--datatype
			["Name"]="Name",
			["Level"]="Level",
			["Health"]="Health",
			--condition
			["ConditionType"]="Condition type",
			["ConditionArgument"]="Argument",
			--
			Tooltips={
				["SelectProfile"]="select a profile to edit ; right click for menu",
				["ConditionType"]="The type of this condition",
				["ConditionArgument"]="The argument of this condition",
			},
			NamePlateConditionType={
				[1]={
					Text="As default",
					Value="Default",
					Tooltips="Using same alpha as default nameplate",
				},
				[2]={
					Text="Target",
					Value="Target",
					Tooltips="When the unit is target/mouseover/focus",
				},
				[3]={
					Text="Quest",
					Value="Quest",
					Tooltips="When unit is required in a quest"
				},
				[4]={
					Text="Any",
					Value="Any",
					Tooltips="Any kind of situation ,or always"
				},
				[5]={
					Text="Name",
					Value="Name",
					Tooltips="Unit with certain name",
				},
				[6]={
					Text="Name(part)",
					Value="PartName",
					Tooltips="Unit with certain name chich has those words",
				},
				[7]={
					Text="UnitID",
					Value="UnitID",
					Tooltips="Unit with certain unitid (Unit ID can be found on site like WoWHead",
				},
				[8]={
					Text="Summoned",
					Value="Summoned",
					Tooltips="Unit witch is summoned by other unit"
				},
				[9]={
					Text="Player",
					Value="Player",
					Tooltips="Unit is player",
				},
				[10]={
					Text="Non-Player",
					Value="NonPlayer",
					Tooltips="Unit is not a player",
				},
				[11]={
					Text="With aura",
					Value="WithAura",
					Tooltips="Unit is with specific aura",
				},
				[12]={
					Text="With out aura",
					Value="WithoutAura",
					Tooltips="Unit is without specific aura",
				},
				[13]={
					Text="With more health than",
					Value="HealthMore",
					Tooltips="Unit with more health than (number as percent)",
				},
				[14]={
					Text="With less health than",
					Value="HealthLess",
					Tooltips="Unit with less health than (number as percent)",
				},
				[15]={
					Text="With cooldown",
					Value="WithCoolDown",
					Tooltips="Unit with certain spell on cooldown",
				},
				[16]={
					Text="Without cooldown",
					Value="WithoutCoolDown",
					Tooltips="Unit without certain spell on cooldown",
				},
				[17]={
					Text="Tapped",
					Value="Tapped",
					Tooltips="Unit is tapped by other player (not your loot)",
				},
				[18]={
					Text="Guild",
					Value="Guild",
					Tooltips="The name of the guild the unit is in",
				},
				[19]={
					Text="NPC Guild",
					Value="NPCGuild",
					Tooltips="The name of the guild the NPC is in",
				},
				[20]={
					Text="Pet",
					Value="Pet",
					Tooltips="Unit is someone's pet (assist and can be controlled)",
				},
				[21]={
					Text="Guardian",
					Value="Guardian",
					Tooltips="Unit is someone's guardian (assist but can't be controlled)",
				},
				[22]={
					Text="Is in friend list",
					Value="FriendList",
					Tooltips="Unit is in player's friend list",
				},
				[23]={
					Text="Is guild member",
					Value="GuildList",
					Tooltips="Unit is player's guild member",
				},
				[24]={
					Text="Is in party",
					Value="PartyList",
					Tooltips="Unit is in player's party",
				},
				[25]={
					Text="Is in raid",
					Value="RaidList",
					Tooltips="Unit is in player's raid group",
				},
				[26]={
					Text="Role",
					Value="Role",
					Tooltips="Unit is certain role",
				},
				[27]={
					Text="Classification",
					Value="Classification",
					Tooltips="Unit is elite/boss/normal",
				},
				[28]={
					Text="Threat",
					Value="Threat",
					Tooltips="Unit threat status",
				},
				[29]={
					Text="Casting",
					Value="Casting",
					Tooltips="Unit is casting",
				},
				[30]={
					Text="NotCasting",
					Value="NotCasting",
					Tooltips="Unit is not casting",
				},
			},
			TargetArgumentList={
				[1]={
					Text="Target",
					Value="Target",
					Tooltips="Unit is target",
				},
				[2]={
					Text="Focus",
					Value="Focus",
					Tooltips="Unit is focus",
				},
				[3]={
					Text="Mouseover",
					Value="Mouseover",
					Tooltips="Unit is mouseover",
				},
				[4]={
					Text="Self",
					Value="player",
					Tooltips="Unit is self",
				},
				[5]={
					Text="Pet",
					Value="pet",
					Tooltips="Unit is self's pet",
				},
				[6]={
					Text="Any",
					Value="Any",
					Tooltips="Unit is any unit",
				},
			},
			--faction, 1=friendly,2=neutral,3=hostile
			FactionArgumentList={
				[1]={
					Text="Hostile",
					Value="3",
					Tooltips="Unit is hostile",
				},
				[2]={
					Text="Friendly",
					Value="1",
					Tooltips="Unit is friendly",
				},
				[3]={
					Text="Neutral",
					Value="2",
					Tooltips="Unit is neutral",
				},
			},
			--role
			RoleArgumentList={
				[1]={
					Text="Healer",
					Value="HEALER",
					Tooltips="Unit act as healer in group",
				},
				[2]={
					Text="Tank",
					Value="TANK",
					Tooltips="Unit act as tank in group",
				},
				[3]={
					Text="Damager",
					Value="DAMAGER",
					Tooltips="Unit act as damager in group",
				},
				[4]={
					Text="None",
					Value="NONE",
					Tooltips="Unit has no role in group",
				},
			},
			--classification
			ClassificationArgumentList={
				[1]={
					Text="World Boss",
					Value="worldboss",
					Tooltips="Unit is a world boss unit",
				},
				[2]={
					Text="Elite",
					Value="elite",
					Tooltips="Unit is elite unit",
				},
				[3]={
					Text="Normal",
					Value="normal",
					Tooltips="Unit is normal unit",
				},
			}
		},
		----------------------
		PagesModuleListDefault={
			["SelectRegion"]="Select a region",
			["ThreatGlow"]="Threat glow",
			["Overlay"]="Overlay",
			["Highlight"]="Highlight glow",
			["NameText"]="Name text",
			["LevelText"]="Level text",
			["BossIcon"]="Boss icon",
			["RaidIcon"]="Raid icon",
			["EliteIcon"]="Elite icon",
			["HealthBar"]="Health bar",
			["CastBar"]="Cast bar",
			["CastBarOverlay"]="Cast bar overlay",
			["CastBarShield"]="Cast bar shield",
			["SpellIcon"]="Cast bar spell icon",
			Tooltips={
				["ThreatGlow"]="Texture shows when threat changes",
				["Overlay"]="Texture shows as border",
				["Highlight"]="Texture shows when mouseover",
				["NameText"]="Text shows unit's name",
				["LevelText"]="Text shows unit's level",
				["BossIcon"]="The skull icon shows when unit is a boss",
				["RaidIcon"]="The raid icon (square, triangle,etc.)",
				["EliteIcon"]="The glod/silver dragon icon shows when unit is elite",
				["HealthBar"]="The health bar",
				["CastBar"]="The cast bar",
				["CastBarOverlay"]="Texture shows as cast bar border",
				["CastBarShield"]="Texture shows when unit is casting a spell which is not interrupt-able",
				["SpellIcon"]="Texture shows the spell which unit is casting",
			}
		},
		----------------------
		PagesModueListTextEditor={
			["TextEdit"]="Text edit",
			--
			["AnchorFrame"]="Anchor frame",
			["FrameLevel"]="Frame level",
			["ByFontSetting"]="By font setting",
			["Size"]="Size",
			["Layer"]="Layer",
			["Width"]="Width",
			["EditAnchor"]="Edit anchor",
			["TestText"]="This is a test text",
			["MainFrame"]="Main frame",
			Tooltips={
				["Size"]="Size of this text",
				["Layer"]="The layer this text is in, text with bigger number would overlay on top of text with smaller number",
				["Width"]="Width of this text ,set to 0 for automatic",
				["DataType"]="The data this text would show (such as name, class)",
				["AnchorFrame"]="The frame which this text anchors to",
				["FrameLevel"]="The framelevel this text is in, text with bigger number would overlay on top of text with smaller number",
				["MainFrame"]="Parent frame of all modules, always shown",
			}
		},
		----------------------
		PagesModueListTextureGroupEditor={
			["SelectProfile"]="TextureGroup edit",
		},
		----------------------
		PagesModueListDefaultEditor={
			["Enable"]="Enable",
			["NameOrPath"]="Name or file path",
			["Width"]="Width",
			["Height"]="Height",
			["SelfAnchor"]="Anchor on self",
			["ToAnchor"]="Anchor on target",
			["OffsetX"]="Offset X",
			["OffsetY"]="Offset Y",
			["TestText"]="Test name",
			Tooltips={
				["MustExistWhenLoad"]="File must already exist when wow is started"
			}
		},
		----------------------
		PagesModuleListBarGroupEditor={
			["BarGroupEdit"]="Bar group edit",
			["DataType"]="Data type",
			["FrameLevel"]="Frame level",
			["AnchorFrame"]="Anchor to frame",
			["Width"]="Width",
			["Height"]="Height",
			["EditAnchor"]="Change anchor and offsets",
			["SmoothTime"]="Smooth time",
			["ShadowAlpha"]="Shadow bar alpha",
			["MainFrame"]="Main frame",
			Tooltips={
				["FrameLevel"]="The framelevel it's in, frame with higher value would overlap which with lower value",
				--
				["SmoothTime"]="Smooth bar change in certain time (by second) with a shadow bar, set to 0 to disable smoothing",
				["ShadowAlpha"]="The alpha value of the shadow bar used in smoothing",
				["MainFrame"]="Parent frame of all modules, always shown",
			}
		},
		----------------------
		PagesModuleListIconEditor={
			["IconEdit"]="Icon edit",
			Tooltips={
			}
		},
		----------------------
		PagesModuleListIconGroupEditor={
			["IconGroupEdit"]="Icon group edit",
			["PerRow"]="Icon per row",
			["Max"]="Maximum icons",
			["Direction"]="Grow direction",
			["TimeLimit"]="Time limit",
			["GapX"]="Gap x",
			["GapY"]="Gap y",
			Tooltips={
				["PerRow"]="The number of icons of each row",
				["Max"]="Maximum number of icons of total",
				["Direction"]="Growing direction of icon position",
				["Time limit"]="By second ;If an icon has remaining time more than this it won't be shown; Set to 0 for no limit",
				["GapX"]="The gap between icons, x",
				["GapY"]="The gap between icons, y",
			},
			DirectionList={
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
		},
		----------------------
		PagesModuleListIconGroupRulesEditor={
			["FilterType"]="Filter type",
			["EditList"]="Edit list",
			["FromType"]="From",
			["Priority"]="Priority level",
			["Width"]="Width",
			["Height"]="Height",
			Tooltips={
				["FilterType"]="The aura filter this rule is using",
				["EditList"]="Edit the filter list",
				["FromType"]="Unit type of which the aura from",
				["Priority"]="The priority of auras added from this rule; Aura with higher priority will be put in front; also ,if one aura is added by different rules, the setting with higher priority will be used",
				["Width"]="The width of aura which fits this rule",
				["Height"]="The height of aura which fits this rule",
			},
			FilterTypeList={
				[1]={
					Text="Buff",
					Value=1,
					Tooltips="All buff"
				},
				[2]={
					Text="Debuff",
					Value=2,
					Tooltips="All debuff"
				},
				[3]={
					Text="Spell list",
					Value=3,
					Tooltips="Use spellid list"
				},
				[4]={
					Text="Spell type list",
					Value=4,
					Tooltips="Use spell type list"
				},
				[5]={
					Text="All",
					Value=5,
					Tooltips="All spells"
				},
				[6]={
					Text="Stealable",
					Value=6,
					Tooltips="Spells which are stealable"
				},
			},
			FromTypeList={
				[1]={
					Text="Everyone",
					Value=1,
					Tooltips="Come from everyone"
				},
				[2]={
					Text="Me",
					Value=2,
					Tooltips="Come from me"
				},
			}
		},
		PagesModuleListIconGroupRulesModulesEditor={
			["EditModule"]="Edit module",
			["ModuleType"]="Module type",
			["DataType"]="Data type",
			["ColorMode"]="Color mode",
			["TestText"]="Test text",
			Tooltips={
				["ModuleType"]="The type of this module",
				["DataType"]="The type of data this module shows",
			},
			ModuleTypeList={
				[1]={
					Text="BarGroup",
					Value="BarGroup",
				},
				[2]={
					Text="Icon",
					Value="Icon",
				},
				[3]={
					Text="Texture",
					Value="Texture",
				},
				[4]={
					Text="Text",
					Value="Text",
				},
				[5]={
					Text="Number",
					Value="Number",
				},
				[6]={
					Text="Extra info",
					Value="ExtraInfo",
					Tooltips="The extra info of certain datatype (i.e. CC_DR info)",
				}
			},
			DataTypeList={
				[1]={
					Text="Time",
					Value="Time",
				},
				[2]={
					Text="Stack",
					Value="Stack",
				}
			},
			ColorModeList={
				[1]={
					Text="By default",
					Value=0,
				},
				[2]={
					Text="By school",
					Value=1,
				}
			}
		},
		----------------------
		PagesModuleListNumberEditor={
			["NumberEdit"]="Number edit",
			Tooltips={
			}
		},
		----------------------
		PagesResourcesLibBarGroup={
			["SelectProfile"]="Select a profile",
			Tooltips={
				["SelectProfile"]="select a profile to edit ; right click for menu",
			}
		},
		----------------------
		PagesResourcesLibClassLib={
			["Class"]="Class",
			--
			["Player"]="Player",
			["Totem"]="Totem",
			["Creature"]="Creature",
			["Vendor"]="Vendor",
			Tooltips={
				["Player"]="Player class setting",
				["Totem"]="Totem class setting",
				["Creature"]="Creature class setting",
				["Vendor"]="Vendor class setting",
			}
		},
		----------------------
		PagesResourcesLibColorLib={
			["Color"]="Color",
			["Faction"]="Faction",
			["SpellSchool"]="Spell school",
			["Threat"]="Threat",
			["Class"]="Class",
			["SpellType"]="Spell type",
			["Power"]="Power",
			Tooltips={
				["Faction"]="Change faction color table",
				["SpellSchool"]="Change spell school color table",
				["Threat"]="Change threat status color table",
				["Class"]="Change class color table",
				["SpellType"]="Change spell type color table",
				["Power"]="Change power type color table (range,mana, etc.)",
			}
		},
		----------------------
		PagesResourcesLibCountDownLib={
			["SelectProfile"]="Select a profile",
			Tooltips={
				["SelectProfile"]="select a profile to edit ; right click for menu",
			}
		},
		----------------------
		PagesResourcesLibFontLib={
			["SelectProfile"]="Select a profile",
			["Generate"]="Generate",
			Tooltips={
				["SelectProfile"]="select a profile to edit ; right click for menu",
				["Generate"]="Generate font profile based on lib",
			}
		},
		----------------------
		PagesResourcesLibNumberLib={
			["SelectProfile"]="Select a profile",
			Tooltips={
				["SelectProfile"]="select a profile to edit ; right click for menu",
			}
		},
		----------------------
		PagesResourcesLibSpellLib={
			["SpellLib"]="Spelldata lib",
			--
			["AutoDetector"]="Auto detector",
			["LibEditor"]="Lib editor",
			["Catalog"]="Catalog",
			--
			["SelectSpell"]="Select a spell",
			["SpellAlreadyExists"]="Spell already exists",
			["SpellCreated"]="Spell created",
			--
			["SelectType"]="Select a type",
			--
			["SortBy"]="Sort by",
			["SortData"]={
				[1]={
					Text="By Class",
					Value=0,
				},
				[2]={
					Text="By CC-DR type",
					Value=1,
				},
				--[3]={
				--	Text="By Spell type",
				--	Value=2,
				--},
				--[4]={
				--	Text="By School",
				--	Value=3,
				--}
			},
			--
			Tooltips={
				["AutoDetector"]="Automatically generate spelldata based on combatlog (high resources cost, won't start on load)",
				["LibEditor"]="Edit spelldata lib manually",
				["Catalog"]="Delete spell in batch,and manage the catalog display in options menu",
				["SelectSpell"]="Select a spell to edit",
				["SelectType"]="Select a spell type to edit",
				["SortBy"]="How the spells are sorted",
			},
		},
		----------------------
		PagesResourcesLibTextureLib={
			["SelectProfile"]="Select a profile",
			["Generate"]="Generate",
			Tooltips={
				["SelectProfile"]="select a profile to edit ; right click for menu",
				["Generate"]="Generate texture profile based on lib",
			}
		},
		----------------------
		PagesClassLibPlayer={
			["PlayerClass"]="Player class",
			["Color"]="Color",
			["Icon"]="Icon"
		},
		----------------------
		PagesSelfLib={
			["Color"]="Color",
			["Text"]="Text",
			Tooltips={
				["Text"]="Text to show, leaving it empty will show original name, and will not force color",
			}
		},
		----------------------
		PagesRoleLib={
			["Role"]="Player Role",
			["Icon"]="Icon"
		},
		----------------------
		PagesColorLibFaction={
			["Faction"]="Faction color table",
			["Friendly"]="Friendly",
			["Neutral"]="Neutral",
			["Hostile"]="Hostile",
			Tooltips={
				["Friendly"]="Color of friendly unit",
				["Neutral"]="Color of neutral unit",
				["Hostile"]="Color of hostile unit",
			}
		},
		----------------------
		PagesColorLibThreat={
			["Threat"]="Threat color table",
			["sColor"]="] color",
			["Change"]="Change [",
		},
		----------------------
		PagesColorLibSpellSchool={
			["SpellSchool"]="Spell school color table",
			["sColor"]="] color",
			["Change"]="Change [",
		},
		----------------------
		PagesColorLibSpellType={
			["SpellType"]="Spell type color table",
			["sColor"]="] color",
			["Change"]="Change [",
		},
		----------------------
		PagesColorLibPower={
			["SpellType"]="Power color table",
			["sColor"]="] color",
			["Change"]="Change [",
		},
		----------------------
		PagesSpellLibAutoDetector={
			["AutoDetector"]="Auto detector",
			--
			["Enable"]="Enable",
			["From"]="From",
			["CastOn"]="Cast on",
			--
			["Catalog"]="Catalog",
			["Object"]="Object",
			["Guardian"]="Guardian",
			["Pet"]="Pet",
			["NPC"]="NPC",
			["Player"]="Player",
			["Target"]="Target",
			["Focus"]="Focus",
			["Self"]="Self",
			["NoOne"]="No one",
			--
			["Caster"]="Caster",
			["Name"]="Name",
			["Spellid"]="Spell id",
			["School"]="School",
			["Icon"]="Icon file",
			["CastTime"]="Cast time",
			["MinRange"]="Minimum range",
			["MaxRange"]="Maximum range",
			["CastElapse"]="Mimimum cast interval",
			["Length"]="Lasts time",
			["CastArea"]="Cast area",
			["CastOn"]="Cast upon",
			["MaxStack"]="Max stack",
			["InterruptSpell"]="Interrupt spell",
			["SummonSpell"]="Summon spell",
			["DispelSpell"]="Dispel spell",
			["HealSpell"]="Heal spell",
			["ResurrectSpell"]="Resurrect spell",
			["EnegrizeSpell"]="Enegrize spell",
			["DispelAble"]="Can be dispel",
			--
			["Save"]="Save choosen spell",
			["Saved"]="Saved",
			["Reset"]="Clear spell list",
			["Overwrote"]="Overwote",
			["Total"]="Total",
			["Unsorted"]="Unsorted",
			Tooltips={
				["Object"]="Not a unit or character, like environment ",
				["Guardian"]="Unit that fights for player but can't be controlled by player",
				["Pet"]="Unit that fights for player and can be controlled by player",
				["NPC"]="Individual character which is not controlled by player",
				["Player"]="Player controlled character",
				--
				["Save"]="Save information of choosen spell into spell lib (will overwrite exists data)",
				["Reset"]="Clear the spell list list",
			}
		},
		----------------------
		PagesSpellLibCatalog={
			["SelectSpell"]="Select spells to edit",
			--
			["MoveTo"]="Move to",
			["Catalog"]="Catalog",
			["Delete"]="Delete",
			--
			["Moved"]="Moved",
			["Deleted"]="Deleted",
			["Unsorted"]="Unsorted",
			Tooltips={
				["MoveTo"]="Move selected spells into a chosen catalog",
				["Catalog"]="This affects only where the spell displays in Options' spell-selector, changes won't be refreshed immediately",
				["Delete"]="Delete selected spells in the Spell Lib",
			}
		},
		----------------------
		Help={
			Index={
				[1]={
					Text="(A.1.0)Options UI",
					Value=1
				},
				[2]={
					Text="(A.2.0)Core",
					Value=2
				},
				[3]={
					Text="(A.3.0)Resource Lib",
					Value=3
				},
				[4]={
					Text="(A.4)Nameplate->Appearance->Offset,Scale,FrameLevel,Alpha",
					Value=4
				},
				[5]={
					Text="(A.5)Nameplate->Appearance->DataType",
					Value=5
				},
				[6]={
					Text="(A.6)CombatText",
					Value=6
				},
				[7]={
					Text="(A.7)TargetArrow",
					Value=7
				},
				[8]={
					Text="(A.8)Tracker",
					Value=8
				},
				[9]={
					Text="(A.9)ProfileManager",
					Value=9
				},
				[10]={
					Text="(B.1)Working with other Nameplate Addon",
					Value=10
				},
				[11]={
					Text="(B.2.1)Spell Cooldown/CC/Lasts/Stack doesn't work?",
					Value=11
				},
				[12]={
					Text="(B.2.2)Add spell data",
					Value=12
				},
				[13]={
					Text="(B.3)Why changes not applied",
					Value=13
				},
				[14]={
					Text="(B.4)How to change Bar/How to invers Bar",
					Value=14
				},
				[15]={
					Text="(B.5)Icongroup(Aura/Cooldown/CCDR",
					Value=15
				},
				[16]={
					Text="(B.6)Background/Border",
					Value=16
				},
				[17]={
					Text="(B.7)Nameplates overlapping",
					Value=17
				},
				[18]={
					Text="(B.8)Hide pets' nameplates/Set different style for different unit",
					Value=18
				},
				[19]={
					Text="(B.9)How to : add/delete/edit Name/HealthBar/Icon",
					Value=19
				},
				[20]={
					Text="(B.10)How to :Disable TargetArrow/CombatText/Tracker",
					Value=20
				},
			},
			Text={
				[1]="Drag blank part of a window to move whole Options UI\n\nDrag circle on top of sidebar to unlock the window, then drag would move this window separately\n\nDrag scrollbar on sidebar to scale the window\n\nClick the [-] on sidebar to minimize/maximize the window\n\nClick [O] to reset scale and position of the window\n\nClick [X] to close the window",
				[2]="Turn off [Default] in [Nameplate modules] on [Core] page would stop NPA from modifying default nameplate, so be compatiable with other nameplate addons\n\nDisable unused data collector to reduce resouce costs\n\nScrollFrame rendering will increase resources cost and break the order of modules on same nameplate",
				[3]="Settings in [ResourceLib] would be used in other functions of NPA\n\nTexture and Font must be added into list with corresponding filename and setting before used\n\nThe [Generate] button will add all files inside [LibShareMedia] lib with default setting\n\nCooldown and DiminishingReturn will only work after certain spell is set in [SpellLib]\nAura can work without [SpellLib] but setting would make it more accurate",
				[4]="These settings will affact all modules on this nameplate\n\nThese settings are used to show different nameplate for different units\n\nThese settings only work after[Nameplate-Condition] fits",
				[5]="The datatype of a module decides what the module shows, different type of module can show different datatype\nI.e.[Text] module can show [Target] datatype\n\nDatatype of a texturegroup decides when the texturegroup is shown\nI.e. texturegroup with [Energy] type will only show when the unit's energy is shown",
				[6]="[Condition] decides the style of different combattext\n\n[Animation] decides how it's changing when shown\nI.e. [go right then go up]\n\nIn [Condition] ,only damage and healing can crit ,other type would always be [non-crit]",
				[7]="Each [TargetArrow] setting generates an arrow on certain nameplate\nIf needs only [TargetArrow], can disable all other data collectors but [Target] in [Core] page , can also disable all nameplate modules",
				[8]="[Condition] of [Tracker] is used to filter units wanted to track, [Nameplate] will show tracked units\nEach [Condition] has a [Nameplate Group], to decides which nameplate group would the fitted unit be shown in\n\nEach [Nameplate] has an [Group], to decides which nameplate group this nameplate is in\nEach [Nameplate] also has an [Index] ,to decide the position it's at insde the nameplate group, a nameplate with smaller index would be used first",
				[9]="By Blizzard's design, characters at same server under Same account can share profile in [ProfileManager] between each other\nProfile saved under one character,can be loaded under other character\n \nUse [Export] to output text which can be published\nPaste published text into [inport] inputbox ,can aquire other's profile",
				[10]="Disable [Default] at [Nameplate modules] in [Core] page, will stop NPA change any part of default nameplate, to avoid conflict with other nameplate addons\nThis change requires UI-Reload",
				[11]="Those require corresponding spell data in [ResourceLib]->[Spell] to work\nNPA doesn't contain them by default due to massive and difficult works of organizing data",
				[12]="Add spell manually with [ResourceLib]->[Spell]->[LibEditor]\n\nRight-click at sorted list can change catalog name\n\nUsing [Catalog] to change spells catalog fast\n\nEnable [Auto detector] to collect spell information of certain units automaticlly, then the chosen spell can be added into spell lib\nNote:[Auto detector] will consume a lot of resource so it won't be enabled automatically after UI-Reload",
				[13]="Each page with [Save] button would only save after this button is pressed\n\nChanges would be saved correctly only when child page is saved before parent page is saved",
				[14]="[ResourceLib]->[BarGroup]->choose setting->Add some bar(least one) -> edit bar setting\n\nI.e. could add 2 bars, set one of it shows when 0%-50%, the other 50%-100%, with different style\n\nInvers bar's anchor point and direction can invers the bar\n\n[Change size] will let the bar reduce size based on percent and direction\n\n[Change texture] will reduce texture display based on percent and direction\n\nChanges on setting will affact all modules using this setting",
				[15]="Create a frame with [Nameplate]->[Appearance]->[IconGroup]\n\nSelect a datatype (Aura/Cooldown/CC_DR)\n\nCreate a few filters ,to decide what would show in this frame \nWhitlist/Blacklist is here\n\nThe icon frame can be changed in filters\nI.e. size,gap,layer\n\nWanted contents can be added inside filters ,including Icon,Name,Time,etc",
				[16]="Background/Border/Highlight are considered as [TextureGroup]\n[Nameplate]->[Appearance]->select a profile->[TextureGroup]->Add an new setting\n\nThe datatype of a texturegroup decides when the texturegroup is shown\nI.e.[Target] means show the texturegroup when unit is target\n\nEdit textures under [texturegroup] to get different style",
				[17]="There're two ways to show nameplates\n\nThe default one can adjust display order of modules on same nameplate, but modules on different nameplate would overlap each other\n\nThe other one is ScrollFrame rendering, it will prevent overlapping of modules on different nameplates, but also prevent the order adjusting\n\nDisplay method can be changed on [Core] page, this change requires UI-Reload",
				[18]="[Nameplate]->[Appearance]->Create a new setting, name it [Empty], delete all module settings inside it, disable all [default] module inside it too, this will make an empty nameplate setting\n\n[Nameplate]->[Condition]->Create a new condition->change the condition type to [Summoned], and the argument [Hostile] ,the profile [Empty]\n\nMake sure the new conditon is above default one\n\nAfter saving, summoned hostile unit (including pet and mirror) will be shown as empty nameplates\n\nNote: hide a nameplate separately is not allowed by Blizzard, this will stop it from showing but the Click-zone would still be there",
				[19]="[Nameplate]->[Appearance]->find according setting->find according module\nI.e. [Name] and [Level] are belong to [Text] module\n->Find according setting->Modify or delete it\n\nAdd a new setting->Modify it , select according datatype\nI.e. [Bargroup] can use [Health]/[Mana]/[Casting]",
				[20]="Delete all settings under [CombatText]/[Tracker]->[Condition] will disable [CombatText]/[Tracker]\n\nDelete all settings under [TargetArrow] will disable [TargetArrow]",
			},
		},
		PremadeProfile={
			["nfrog's CC_DR lib"]='@SpellLib\\#{[115752]={["Catalog"]="Paladin",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=100,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[102795]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[113792]={["Catalog"]="Priest",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=30,["CastTime"]=1900,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[80483]={["Catalog"]="Player common",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[116709]={["Catalog"]="Monk",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=2,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=2,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=4,["School"]=1,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[118000]={["Catalog"]="Warrior",["MinRange"]=0,["PVPDRType"]="Stuns(short)",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=1.5,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=1.5,["MaxStack"]=0,["School"]=1,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[118271]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=40,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=4,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[25046]={["Catalog"]="Player common",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[31935]={["Catalog"]="Paladin",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=15,},[56626]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=2,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=2,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=90,},[119403]={["Catalog"]="Hunter",["MinRange"]=0,["PVPDRType"]="Knockbacks",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=0,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[108199]={["Catalog"]="DeathKnight",["MinRange"]=0,["PVPDRType"]="Knockbacks",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=0,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[9005]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=5,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[61025]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=50,["CastTime"]=1700,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[118]={["Catalog"]="Mage",["MinRange"]=0,["PVPDRType"]="Mesmerizes",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=50,["CastTime"]=1700,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=64,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[113953]={["Catalog"]="Rogue",["MinRange"]=0,["PVPDRType"]="Stuns(short)",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=4,["MaxStack"]=0,["School"]=9,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=20,},[87194]={["Catalog"]="Priest",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[91800]={["Catalog"]="DeathKnight",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[54706]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=40,},[20066]={["Catalog"]="Paladin",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=60,["CastTime"]=1700,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=15,},[10326]={["Catalog"]="Paladin",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=40,["CastTime"]=1500,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=2,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=15,},[118895]={["Catalog"]="Warrior",["MinRange"]=0,["PVPDRType"]="Stuns(short)",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=1.5,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=1.5,["MaxStack"]=0,["School"]=1,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[122242]={["Catalog"]="Monk",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[4167]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=40,},[34490]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=40,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=24,},[408]={["Catalog"]="Rogue",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=6,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=6,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=20,},[2094]={["Catalog"]="Rogue",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=15,["CoolDownType"]=0,["Length"]=60,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[61305]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=50,["CastTime"]=1613,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[7744]={["Catalog"]="Player common",["MinRange"]=0,["PVPDRType"]="PvP 拌鞭厘",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["NewName"]="",["CastTime"]=0,["NewIcon"]="",["Length"]=0,["SpellType"]="None",["MaxStack"]=0,["School"]=1,["DispelAble"]=false,["CounterSpellLength"]=0,["PVPLength"]=0,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[96201]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=53,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=90,},[126355]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=2,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=2,["NewName"]="",["MaxStack"]=0,["SpellType"]="Poison",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[31661]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=4,["PVPDRType"]="Mesmerizes(short)",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=20,},[42292]={["Catalog"]="Player common",["MinRange"]=0,["PVPDRType"]="PvP 拌鞭厘",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["NewName"]="",["CastTime"]=0,["NewIcon"]="",["Length"]=0,["SpellType"]="None",["MaxStack"]=0,["School"]=1,["DispelAble"]=false,["CounterSpellLength"]=0,["PVPLength"]=0,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[117526]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=100,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[145067]={["Catalog"]="Paladin",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=40,["CastTime"]=1500,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=2,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=15,},[50245]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=40,},[102051]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=8,["CastTime"]=1500,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=16,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=20,},[90337]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=4,["CastTime"]=500,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[19975]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=27,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[91644]={["Catalog"]="Hunter",["MinRange"]=0,["PVPDRType"]="Disarms",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[99]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Mesmerizes(short)",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[59752]={["Catalog"]="Player common",["MinRange"]=0,["PVPDRType"]="PvP 拌鞭厘",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["NewName"]="",["CastTime"]=0,["NewIcon"]="",["Length"]=0,["SpellType"]="None",["MaxStack"]=0,["School"]=1,["DispelAble"]=false,["CounterSpellLength"]=0,["PVPLength"]=0,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[107566]={["Catalog"]="Warrior",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=40,},[5484]={["Catalog"]="Warlock",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=20,["CastTime"]=0,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=40,},[119392]={["Catalog"]="Monk",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[117368]={["Catalog"]="Monk",["MinRange"]=0,["PVPDRType"]="Disarms",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=40,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[20549]={["Catalog"]="Player common",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=2,["CastTime"]=500,["NewIcon"]="",["PVPLength"]=2,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[44572]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=35,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=16,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[114404]={["Catalog"]="Priest",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=100,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[6770]={["Catalog"]="Rogue",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=10,["CoolDownType"]=0,["Length"]=60,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[30283]={["Catalog"]="Warlock",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[61721]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=50,["CastTime"]=1700,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[5246]={["Catalog"]="Warrior",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=8,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=90,},[50541]={["Catalog"]="Hunter",["MinRange"]=0,["PVPDRType"]="Disarms",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[28271]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=50,["CastTime"]=1700,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[1513]={["Catalog"]="Hunter",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=20,["CastTime"]=1423,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=8,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[2637]={["Catalog"]="Druid",["MinRange"]=0,["PVPDRType"]="Mesmerizes",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=40,["CastTime"]=1500,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=5,["School"]=8,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[50613]={["Catalog"]="Player common",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[89766]={["Catalog"]="Warlock",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[19386]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=40,["CoolDownType"]=0,["Length"]=30,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["School"]=8,["SpellType"]="Poison",["CounterSpellLength"]=0,["MaxStack"]=0,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=45,},[24259]={["Catalog"]="Warlock",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=40,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[5782]={["Catalog"]="Warlock",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=20,["CastTime"]=1700,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[51490]={["Catalog"]="Shaman",["MinRange"]=0,["PVPDRType"]="Knockbacks",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=0,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=8,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=45,},[51514]={["Catalog"]="Shaman",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=60,["CastTime"]=1423,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Curse",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=45,},[110693]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=16,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=25,},[113004]={["Catalog"]="Druid",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=8,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=90,},[113275]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=35,["CoolDownType"]=0,["Length"]=30,["CastTime"]=1700,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[82691]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=100,["CoolDownType"]=0,["Length"]=10,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=16,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=20,},[100]={["Catalog"]="Warrior",["MinRange"]=8,["PVPDRType"]="Stuns(short)",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=25,["CoolDownType"]=0,["Length"]=1,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=1,["MaxStack"]=0,["School"]=1,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=20,},[1776]={["Catalog"]="Rogue",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=5,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=10,},[1330]={["Catalog"]="Rogue",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[53148]={["Catalog"]="Hunter",["MinRange"]=8,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=25,["CoolDownType"]=0,["Length"]=1,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=1,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[22570]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=10,},[132168]={["Catalog"]="Warrior",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[102359]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=20,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[55021]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[605]={["Catalog"]="Priest",["MinRange"]=0,["PVPDRType"]="Charm",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=30,["CastTime"]=1800,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[137461]={["Catalog"]="Monk",["MinRange"]=0,["PVPDRType"]="Disarms",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=4,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[118345]={["Catalog"]="Shaman",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=5,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=40,},[119381]={["Catalog"]="Monk",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=45,},[90327]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=40,},[115078]={["Catalog"]="Monk",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=60,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=15,},[64058]={["Catalog"]="Priest",["MinRange"]=0,["PVPDRType"]="Disarms",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=100,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[28272]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=50,["CastTime"]=1700,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[8122]={["Catalog"]="Priest",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[111397]={["Catalog"]="Warlock",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=60,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Horrors",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[126458]={["Catalog"]="Monk",["MinRange"]=0,["PVPDRType"]="Disarms",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=40,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[96294]={["Catalog"]="DeathKnight",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=100,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=16,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[51722]={["Catalog"]="Rogue",["MinRange"]=0,["PVPDRType"]="Disarms",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[64695]={["Catalog"]="Shaman",["MinRange"]=0,["PVPDRType"]="Roots(short)",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=5,["School"]=8,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[77505]={["Catalog"]="Shaman",["MinRange"]=0,["PVPDRType"]="Stuns(short)",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=100,["CoolDownType"]=0,["Length"]=2,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=2,["MaxStack"]=0,["School"]=1,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[115073]={["Catalog"]="Monk",["MinRange"]=0,["PVPDRType"]="Roots(short)",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50,["CoolDownType"]=0,["Length"]=2,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=2,["School"]=4,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[69179]={["Catalog"]="Player common",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[64803]={["Catalog"]="Hunter",["MinRange"]=0,["PVPDRType"]="Roots(short)",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=4,["School"]=8,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[105421]={["Catalog"]="Paladin",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=6,["CastTime"]=0,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=6,["School"]=2,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[22703]={["Catalog"]="Warlock",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=2,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=2,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=4,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[113801]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=5,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[115770]={["Catalog"]="Warlock",["MinRange"]=0,["PVPDRType"]="Knockbacks",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=0,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=25,},[110698]={["Catalog"]="Paladin",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=10,["CoolDownType"]=0,["Length"]=6,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=6,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[119072]={["Catalog"]="Paladin",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=9,},[107079]={["Catalog"]="Player common",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=5,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[15487]={["Catalog"]="Priest",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=45,},[6358]={["Catalog"]="Warlock",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=30,["CastTime"]=1700,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[132469]={["Catalog"]="Druid",["MinRange"]=0,["PVPDRType"]="Knockbacks",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=0,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=8,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[6360]={["Catalog"]="Warlock",["MinRange"]=0,["PVPDRType"]="Knockbacks",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=0,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=25,},[105593]={["Catalog"]="Paladin",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=6,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=6,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[33395]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=45,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=16,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=25,},[114237]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=15,},[118905]={["Catalog"]="Shaman",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=5,["CastTime"]=5000,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[113056]={["Catalog"]="Druid",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=15,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[24394]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=5,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[111264]={["Catalog"]="Mage",["MinRange"]=0,["PVPDRType"]="Roots(short)",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=40,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=5,["School"]=16,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=20,},[61780]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=50,["CastTime"]=1700,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[113506]={["Catalog"]="Druid",["MinRange"]=0,["PVPDRType"]="Cyclone",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=6,["CastTime"]=1700,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=6,["School"]=8,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[116706]={["Catalog"]="Monk",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=100,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[20511]={["Catalog"]="Warrior",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=15,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[47476]={["Catalog"]="DeathKnight",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[115001]={["Catalog"]="DeathKnight",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=6,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=6,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=16,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[19503]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Mesmerizes(short)",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[33786]={["Catalog"]="Druid",["MinRange"]=0,["PVPDRType"]="Cyclone",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=6,["CastTime"]=1700,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=6,["School"]=8,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[115782]={["Catalog"]="Warlock",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=40,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[118093]={["Catalog"]="Warlock",["MinRange"]=0,["PVPDRType"]="Disarms",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[339]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=35,["CoolDownType"]=0,["Length"]=30,["CastTime"]=1700,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[128405]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=8,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[676]={["Catalog"]="Warrior",["MinRange"]=0,["PVPDRType"]="Disarms",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[63685]={["Catalog"]="Shaman",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=16,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[122]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=16,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=25,},[118699]={["Catalog"]="Warlock",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=20,["CastTime"]=0,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[88625]={["Catalog"]="Priest",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Mesmerizes(short)",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[115268]={["Catalog"]="Warlock",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=30,["CastTime"]=1700,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[137460]={["Catalog"]="Monk",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[107570]={["Catalog"]="Warrior",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[853]={["Catalog"]="Paladin",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=10,["CoolDownType"]=0,["Length"]=6,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=6,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[126246]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[120086]={["Catalog"]="Monk",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[91797]={["Catalog"]="DeathKnight",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[3355]={["Catalog"]="Hunter",["MinRange"]=0,["PVPDRType"]="Mesmerizes",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=10,["CoolDownType"]=0,["Length"]=60,["CastTime"]=0,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[113952]={["Catalog"]="Rogue",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=10,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=20,},[9484]={["Catalog"]="Priest",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=50,["CastTime"]=1500,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[102793]={["Catalog"]="Druid",["MinRange"]=0,["PVPDRType"]="Knockbacks",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=0,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=8,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[64044]={["Catalog"]="Priest",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=1,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=1,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Horrors",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=45,},[710]={["Catalog"]="Warlock",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=30,["CastTime"]=1500,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[126423]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[6789]={["Catalog"]="Warlock",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Horrors",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=45,},[123394]={["Catalog"]="Unsorted",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=4,["PVPDRType"]="Mesmerizes(short)",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[76780]={["Catalog"]="Shaman",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=50,["CastTime"]=1500,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[108194]={["Catalog"]="DeathKnight",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[1833]={["Catalog"]="Rogue",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=5,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[5211]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=5,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=50,},[28730]={["Catalog"]="Player common",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[50519]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=2,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=2,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},}',
			["nfrog's Blizzard Default nameplate"]='@Texture\\Blizzard ComboPoint Bg\\#{["Top"]=0,["RAngle"]=0,["Right"]=0.36,["Bottom"]=0.77,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["Mode"]="BLEND",["Left"]=0,["Texture"]="Interface\\ComboFrame\\combopoint.blp",}@NamePlateCondition\\#{[1]={["Profile"]="Blizzard",["Arg"]="",["ConditionType"]="Any",},}@Texture\\Blizzard Elite Icon\\#{["Top"]=0,["RAngle"]=0,["Right"]=1,["Bottom"]=1,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["Mode"]="BLEND",["Left"]=0,["Texture"]="Interface\\Tooltips\\EliteNameplateIcon",}@SpellLib\\42292\\#{["Catalog"]="Player common",["MinRange"]=0,["PVPDRType"]="PvP trinket",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["NewName"]="",["CastTime"]=0,["CoolDown"]=120,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=1,["MaxStack"]=0,["Length"]=0,["SpellType"]="None",["NewIcon"]="",}@BarGroup\\Blizzard Dafult CP\\#{["1"]={["EnableTextureChange"]=false,["PercentFrom"]=0.01,["ColorMode"]=0,["Layer"]="ARTWORK",["PercentTo"]=0.2,["Width"]=20,["MinColor"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["HideWhenMax"]=false,["Height"]=20,["MaxColor"]={["A"]=1,["B"]=1,["G"]=0.9921568627451,["R"]=1,},["AnchorData"]={["OffsetX"]=-120,["OffsetY"]=0,["To"]="CENTER",["From"]="LEFT",},["EnableSizeChange"]=false,["Direction"]=0,["ProfileName"]="Blizzard ComboPoint",},["3"]={["EnableTextureChange"]=false,["PercentFrom"]=0.41,["ColorMode"]=0,["Layer"]="ARTWORK",["PercentTo"]=0.6,["Width"]=20,["MinColor"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["HideWhenMax"]=false,["Height"]=20,["MaxColor"]={["A"]=1,["B"]=1,["G"]=0.9921568627451,["R"]=1,},["AnchorData"]={["OffsetX"]=-70,["OffsetY"]=0,["To"]="CENTER",["From"]="LEFT",},["EnableSizeChange"]=false,["Direction"]=0,["ProfileName"]="Blizzard ComboPoint",},["2"]={["Direction"]=0,["PercentFrom"]=0.21,["ColorMode"]=0,["Layer"]="ARTWORK",["PercentTo"]=0.4,["Width"]=20,["MaxColor"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["HideWhenMax"]=false,["Height"]=20,["MinColor"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["AnchorData"]={["OffsetX"]=-95,["OffsetY"]=0,["To"]="CENTER",["From"]="LEFT",},["EnableSizeChange"]=false,["EnableTextureChange"]=false,["ProfileName"]="Blizzard ComboPoint",},["5"]={["EnableTextureChange"]=false,["PercentFrom"]=0.81,["ColorMode"]=0,["Layer"]="ARTWORK",["PercentTo"]=1,["Width"]=20,["MinColor"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["HideWhenMax"]=false,["Height"]=20,["MaxColor"]={["A"]=1,["B"]=1,["G"]=0.9921568627451,["R"]=1,},["AnchorData"]={["OffsetX"]=-20,["OffsetY"]=0,["To"]="CENTER",["From"]="LEFT",},["EnableSizeChange"]=false,["Direction"]=0,["ProfileName"]="Blizzard ComboPoint",},["4"]={["Direction"]=0,["PercentFrom"]=0.61,["ColorMode"]=0,["Layer"]="ARTWORK",["PercentTo"]=0.8,["Width"]=20,["MaxColor"]={["A"]=1,["B"]=1,["G"]=0.9921568627451,["R"]=1,},["HideWhenMax"]=false,["Height"]=20,["MinColor"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["AnchorData"]={["OffsetX"]=-45,["OffsetY"]=0,["To"]="CENTER",["From"]="LEFT",},["EnableSizeChange"]=false,["EnableTextureChange"]=false,["ProfileName"]="Blizzard ComboPoint",},["3 Background"]={["Direction"]=0,["PercentFrom"]=0.01,["Layer"]="BORDER",["ColorMode"]=0,["PercentTo"]=1,["Width"]=20,["EnableTextureChange"]=false,["HideWhenMax"]=false,["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=-70,["From"]="LEFT",},["MinColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["Height"]=20,["EnableSizeChange"]=false,["MaxColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=0.96470588235294,},["ProfileName"]="Blizzard ComboPoint Bg",},["4 Background"]={["Direction"]=0,["PercentFrom"]=0.01,["Layer"]="BORDER",["ColorMode"]=0,["PercentTo"]=1,["Width"]=20,["EnableTextureChange"]=false,["HideWhenMax"]=false,["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=-45,["From"]="LEFT",},["MinColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["Height"]=20,["EnableSizeChange"]=false,["MaxColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=0.96470588235294,},["ProfileName"]="Blizzard ComboPoint Bg",},["1 Background"]={["Direction"]=0,["PercentFrom"]=0.01,["Layer"]="BORDER",["ColorMode"]=0,["PercentTo"]=1,["Width"]=20,["EnableTextureChange"]=false,["HideWhenMax"]=false,["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=-120,["From"]="LEFT",},["MinColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["Height"]=20,["EnableSizeChange"]=false,["MaxColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=0.96470588235294,},["ProfileName"]="Blizzard ComboPoint Bg",},["2 Background"]={["Direction"]=0,["PercentFrom"]=0.01,["Layer"]="BORDER",["ColorMode"]=0,["PercentTo"]=1,["Width"]=20,["EnableTextureChange"]=false,["HideWhenMax"]=false,["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=-95,["From"]="LEFT",},["MinColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["Height"]=20,["EnableSizeChange"]=false,["MaxColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=0.96470588235294,},["ProfileName"]="Blizzard ComboPoint Bg",},["5 Background"]={["EnableTextureChange"]=false,["PercentFrom"]=0.01,["Layer"]="BORDER",["ColorMode"]=0,["PercentTo"]=1,["Width"]=20,["Direction"]=0,["HideWhenMax"]=false,["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=-20,["From"]="LEFT",},["MaxColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=0.96470588235294,},["Height"]=20,["EnableSizeChange"]=false,["MinColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["ProfileName"]="Blizzard ComboPoint Bg",},}@Core\\AdvancedType\\#true@Texture\\QuestNunberBgCircle outer\\#{["Top"]=0,["RAngle"]=0,["Mode"]="BLEND",["Bottom"]=0.25,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Right"]=0.25,["Left"]=0,["Texture"]="Interface\\LFGFrame\\UI-LFG-ICON-ROLES",}@Number\\integer\\#{["ValueType"]=1,["MaxTextData"]={["Width"]=0,["Decimal"]=false,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["ColorMode"]=0,["Height"]=11,["ProfileName"]="Default",},["ValueTextData"]={["Width"]=0,["Decimal"]=true,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["ColorMode"]=1,["Height"]=11,["ProfileName"]="Default",},["MinColor"]={["A"]=1,["R"]=1,["G"]=0,["B"]=0,},["MaxType"]=0,["PercentTextData"]={["Width"]=0,["Decimal"]=true,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["ColorMode"]=0,["Height"]=11,["ProfileName"]="Default",},["MaxColor"]={["A"]=1,["R"]=0,["G"]=1,["B"]=0,},["PercentType"]=0,}@Core\\NamePlateModules\\#{["Number"]=true,["TextureGroup"]=true,["Default"]=true,["IconGroup"]=true,["Icon"]=true,["Text"]=true,["BarGroup"]=true,["MainFrame"]=true,}@Number\\persent\\#{["ValueType"]=0,["MaxTextData"]={["Width"]=0,["Decimal"]=false,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["ColorMode"]=0,["Height"]=11,["ProfileName"]="Default",},["ValueTextData"]={["Width"]=0,["Decimal"]=false,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["ColorMode"]=0,["Height"]=11,["ProfileName"]="Default",},["MinColor"]={["A"]=1,["R"]=1,["G"]=0,["B"]=0,},["MaxType"]=0,["PercentTextData"]={["Width"]=0,["Decimal"]=false,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["ColorMode"]=0,["Height"]=11,["ProfileName"]="Default",},["MaxColor"]={["A"]=1,["R"]=0,["G"]=1,["B"]=0,},["PercentType"]=3,}@SpellLib\\7744\\#{["Catalog"]="Player common",["MinRange"]=0,["PVPDRType"]="PvP trinket",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["NewName"]="",["CastTime"]=0,["CoolDown"]=120,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=1,["MaxStack"]=0,["Length"]=0,["SpellType"]="None",["NewIcon"]="",}@SpellLib\\59752\\#{["Catalog"]="Player common",["MinRange"]=0,["PVPDRType"]="PvP trinket",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["NewName"]="",["CastTime"]=0,["CoolDown"]=120,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=1,["MaxStack"]=0,["Length"]=0,["SpellType"]="None",["NewIcon"]="",}@NamePlate\\Blizzard\\#{["ScaleSetting"]={[1]={["Scale"]=0.8,["Arg"]="3",["ConditionType"]="NonPlayer",},[2]={["Scale"]=0.8,["Arg"]="1",["ConditionType"]="NonPlayer",},},["IconGroupSetting"]={["Diminish Return"]={["PerRow"]=3,["Direction"]=1,["FrameLevel"]=1,["GapX"]=2,["Scale"]=2,["Alpha"]=1,["DataType"]="CC_DR",["GapY"]=2,["DataRules"]={["Debuff"]={["FrameLevel"]=1,["SpellList"]={[113275]=true,[132469]=true,[113004]=true,[113506]=true,[99]=true,[9005]=true,[2637]=true,[113801]=true,[114237]=true,[22570]=true,[33786]=true,[113056]=true,[102793]=true,[5211]=true,[102795]=true,[102359]=true,[339]=true,[19975]=true,},["Alpha"]=1,["FilterType"]=2,["Modules"]={["Icon"]={["ModuleType"]="Icon",["Scale"]=1,["ColorMode"]=0,["Alpha"]=1,["DataType"]="Stack",["Width"]=10,["Height"]=10,["FrameLevel"]=1,["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=0,["From"]="CENTER",},["ProfileName"]=" ",},["Time"]={["ModuleType"]="Number",["Scale"]=0.5,["ColorMode"]=0,["Alpha"]=1,["DataType"]="Time",["Width"]=10,["Height"]=10,["FrameLevel"]=1,["AnchorData"]={["To"]="TOP",["OffsetY"]=0,["OffsetX"]=0,["From"]="TOP",},["ProfileName"]="integer",},},["FromType"]=1,["SchoolList"]={["Enrage"]=true,["Bleed"]=true,["Poison"]=true,["Curse"]=true,["Magic"]=true,["None"]=true,},["Height"]=10,["Priority"]=1,["Width"]=10,["Scale"]=1,},},["TimeLimit"]=60,["Max"]=6,["FrameAnchorData"]={["To"]="TOP",["OffsetY"]=0,["OffsetX"]=-8,["From"]="BOTTOMLEFT",},["AnchorFrame"]="LevelText",},["Debuff"]={["PerRow"]=4,["Direction"]=1,["FrameLevel"]=1,["GapX"]=2,["Scale"]=1,["Alpha"]=1,["DataType"]="Aura",["GapY"]=2,["DataRules"]={["Debuff(self)"]={["FrameLevel"]=1,["Scale"]=1,["Alpha"]=1,["FilterType"]=2,["Modules"]={["Icon"]={["ModuleType"]="Icon",["Scale"]=1,["ColorMode"]=0,["Alpha"]=1,["DataType"]="Stack",["Width"]=20,["Height"]=20,["FrameLevel"]=1,["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=0,["From"]="CENTER",},["ProfileName"]=" ",},["Text"]={["ModuleType"]="Number",["Scale"]=1,["ColorMode"]=0,["Alpha"]=1,["DataType"]="Time",["Width"]=10,["Height"]=10,["FrameLevel"]=10,["AnchorData"]={["To"]="BOTTOM",["OffsetY"]=0,["OffsetX"]=0,["From"]="BOTTOM",},["ProfileName"]="integer",},},["FromType"]=2,["SchoolList"]={["Enrage"]=true,["Bleed"]=true,["Poison"]=true,["Curse"]=true,["Magic"]=true,["None"]=true,},["Height"]=20,["Priority"]=1,["Width"]=20,["SpellList"]={},},},["TimeLimit"]=60,["Max"]=8,["FrameAnchorData"]={["OffsetX"]=0,["OffsetY"]=5,["To"]="TOP",["From"]="BOTTOM",},["AnchorFrame"]="NameText",},["PvP Trinket"]={["PerRow"]=1,["Direction"]=1,["FrameLevel"]=1,["GapX"]=2,["Scale"]=1.2,["Alpha"]=1,["DataType"]="CoolDown",["GapY"]=2,["DataRules"]={["PvP Trinket"]={["FrameLevel"]=1,["SpellList"]={[7744]=true,[42292]=true,[59752]=true,},["Alpha"]=1,["FilterType"]=3,["Modules"]={["Cooldown"]={["ModuleType"]="Number",["Scale"]=1,["ColorMode"]=0,["Alpha"]=1,["DataType"]="Time",["Width"]=10,["Height"]=10,["AnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["FrameLevel"]=2,["ProfileName"]="integer",},["PvP Trinket Texture"]={["ModuleType"]="Texture",["Scale"]=1,["ColorMode"]=0,["Alpha"]=1,["DataType"]="Stack",["Width"]=20,["Height"]=20,["AnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["FrameLevel"]=1,["ProfileName"]="PvP Trinket Texture",},},["Scale"]=1,["SchoolList"]={["Enrage"]=true,["Bleed"]=true,["Curse"]=true,["Poison"]=true,["Magic"]=true,["None"]=true,},["Height"]=10,["Priority"]=1,["Width"]=10,["FromType"]=1,},},["TimeLimit"]=120,["Max"]=1,["FrameAnchorData"]={["OffsetX"]=4,["OffsetY"]=-4,["To"]="RIGHT",["From"]="LEFT",},["AnchorFrame"]="LevelText",},},["NumberSetting"]={["Casting"]={["AnchorFrame"]="CastingBarGroup",["FrameAnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["FrameLevel"]=6,["ProfileName"]="integer",["Scale"]=1,["ColorMode"]=0,["Alpha"]=1,["DataType"]="Casting",},["Health"]={["AnchorFrame"]="HealthBarGroup",["FrameAnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["FrameLevel"]=2,["ProfileName"]="persent",["Scale"]=1,["ColorMode"]=0,["Alpha"]=1,["DataType"]="Health",},["Quest"]={["AnchorFrame"]="Quest Bg CircleTextureGroup",["FrameAnchorData"]={["OffsetX"]=2,["OffsetY"]=1,["To"]="CENTER",["From"]="CENTER",},["FrameLevel"]=3,["ProfileName"]="integer",["Scale"]=1,["ColorMode"]=0,["Alpha"]=1,["DataType"]="Quest",},},["TextSetting"]={["SpellLock"]={["FrameLevel"]=1,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Layer"]="BACKGROUND",["Alpha"]=1,["Width"]=0,["AnchorFrame"]="HealthBarGroup",["DataType"]="SpellLock",["Scale"]=1,["Height"]=11,["ColorMode"]=0,["FrameAnchorData"]={["OffsetX"]=0,["OffsetY"]=-35,["To"]="BOTTOM",["From"]="TOP",},["ProfileName"]="Default",},["Casting"]={["FrameLevel"]=1,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Layer"]="BACKGROUND",["Alpha"]=1,["Width"]=0,["AnchorFrame"]="CastingBarGroup",["DataType"]="Casting",["Scale"]=1,["Height"]=11,["ColorMode"]=0,["FrameAnchorData"]={["OffsetX"]=0,["OffsetY"]=-12,["To"]="CENTER",["From"]="CENTER",},["ProfileName"]="Default",},["Name"]={["FrameLevel"]=1,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Layer"]="BACKGROUND",["Alpha"]=1,["Width"]=0,["AnchorFrame"]="HealthBarGroup",["DataType"]="Name",["Scale"]=1,["Height"]=12,["ColorMode"]=0,["FrameAnchorData"]={["OffsetX"]=0,["OffsetY"]=6,["To"]="TOP",["From"]="BOTTOM",},["ProfileName"]="Default",},["Level"]={["FrameLevel"]=1,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Layer"]="BACKGROUND",["Alpha"]=1,["Width"]=0,["AnchorFrame"]="HealthBarGroup",["DataType"]="Level",["Scale"]=1,["Height"]=12,["ColorMode"]=8,["FrameAnchorData"]={["OffsetX"]=3,["OffsetY"]=1,["To"]="RIGHT",["From"]="LEFT",},["ProfileName"]="Default",},},["AlphaSetting"]={[1]={["Arg"]="Target",["Alpha"]=1,["ConditionType"]="Target",},[2]={["Arg"]="Mouseover",["Alpha"]=0.8,["ConditionType"]="Target",},[3]={["Arg"]="1",["Alpha"]=0.2,["ConditionType"]="Any",},},["IconSetting"]={["Casting"]={["FrameLevel"]=2,["Scale"]=1,["Layer"]="BACKGROUND",["Alpha"]=1,["Width"]=20,["Height"]=20,["DataType"]="Casting",["FrameAnchorData"]={["OffsetX"]=-1,["OffsetY"]=0,["To"]="LEFT",["From"]="RIGHT",},["AnchorFrame"]="CastingBarGroup",},["RaidIcon"]={["FrameLevel"]=1,["Scale"]=1.4,["Layer"]="BACKGROUND",["Alpha"]=1,["Width"]=20,["Height"]=20,["DataType"]="RaidTarget",["FrameAnchorData"]={["To"]="TOPLEFT",["OffsetY"]=0,["OffsetX"]=0,["From"]="BOTTOMRIGHT",},["AnchorFrame"]="HealthBarGroup",},},["BarGroupSetting"]={["Casting"]={["FrameLevel"]=1,["Scale"]=1,["ColorMode"]=5,["SmoothTime"]=0,["Width"]=122,["AnchorFrame"]="矫傈官 抛滴府TextureGroup",["DataType"]="Casting",["Alpha"]=1,["Height"]=11,["ShadowAlpha"]=0.5,["FrameAnchorData"]={["OffsetX"]=11,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["ProfileName"]="Default",},["Health"]={["FrameLevel"]=0,["Scale"]=1,["ColorMode"]=2,["SmoothTime"]=0,["Width"]=120,["AnchorFrame"]="MainFrame",["DataType"]="Health",["Alpha"]=0.9,["Height"]=11,["ShadowAlpha"]=0,["FrameAnchorData"]={["OffsetX"]=-10,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["ProfileName"]="Default",},["ComboPoints"]={["FrameLevel"]=1,["Scale"]=1,["ColorMode"]=0,["SmoothTime"]=0,["Width"]=70,["AnchorFrame"]="HealthBarGroup",["DataType"]="ComboPoints",["Alpha"]=1,["Height"]=12,["ShadowAlpha"]=1,["FrameAnchorData"]={["OffsetX"]=0,["OffsetY"]=2,["To"]="BOTTOM",["From"]="TOP",},["ProfileName"]="Blizzard Dafult CP",},},["FrameLevelSetting"]={["1"]={["Arg"]=" ",["FrameLevel"]=1,["ConditionType"]="Default",},},["OffsetSetting"]={},["DefaultSetting"]={["LevelText"]={["Anchor"]="CENTER",["Font"]="Fonts\\2002.TTF",["OffsetX"]=-12,["AnchorTo"]="BOTTOMRIGHT",["Enable"]=false,["OffsetY"]=10,["Height"]=13,["Width"]=0,},["HealthBar"]={["Texture"]="Interface\\TargetingFrame\\UI-TargetingFrame-BarFill",["Enable"]=false,["OffsetX"]=4,["AnchorTo"]="BOTTOMLEFT",["Anchor"]="BOTTOMLEFT",["OffsetY"]=5,["Height"]=10,["Width"]=105,},["SpellIcon"]={["Height"]=15,["OffsetX"]=-52,["AnchorTo"]="CENTER",["Anchor"]="CENTER",["OffsetY"]=10,["Enable"]=false,["Width"]=15,},["NameText"]={["Anchor"]="BOTTOM",["Font"]="Fonts\\2002.TTF",["OffsetX"]=0,["AnchorTo"]="CENTER",["Enable"]=false,["OffsetY"]=0,["Height"]=13,["Width"]=0,},["BossIcon"]={["Texture"]="Interface\\TargetingFrame\\UI-TargetingFrame-Skull",["Enable"]=false,["OffsetX"]=-12,["AnchorTo"]="BOTTOMRIGHT",["Anchor"]="CENTER",["OffsetY"]=10,["Height"]=14,["Width"]=14,},["EliteIcon"]={["Texture"]="Interface\\Tooltips\\EliteNameplateicon",["Enable"]=false,["OffsetX"]=-8,["AnchorTo"]="BOTTOMRIGHT",["Anchor"]="CENTER",["OffsetY"]=9,["Height"]=31,["Width"]=43,},["ThreatGlow"]={["Texture"]="Interface\\TargetingFrame\\UI-TargetingFrame-Flash",["Enable"]=false,["OffsetX"]=-8,["AnchorTo"]="BOTTOMLEFT",["Anchor"]="BOTTOMLEFT",["OffsetY"]=-13,["Height"]=40,["Width"]=143,},["CastBarShield"]={["Texture"]="Interface\\Tooltips\\Nameplate-CastBar-Shiled",["Enable"]=false,["OffsetX"]=60,["AnchorTo"]="CENTER",["Anchor"]="CENTER",["OffsetY"]=-36,["Height"]=36,["Width"]=130,},["Highlight"]={["Texture"]="",["Enable"]=false,["OffsetX"]=0,["AnchorTo"]="TOPLEFT",["Anchor"]="TOPLEFT",["OffsetY"]=0,["Height"]=36,["Width"]=130,},["CastBarOverlay"]={["Texture"]="Interface\\Tooltips\\Nameplate-Border",["Enable"]=false,["OffsetX"]=0,["AnchorTo"]="CENTER",["Anchor"]="CENTER",["OffsetY"]=-18,["Height"]=36,["Width"]=130,},["RaidIcon"]={["Texture"]="Interface\\TargetingFrame\\UI-RaidTargetingIcons",["Enable"]=false,["OffsetX"]=0,["AnchorTo"]="TOPLEFT",["Anchor"]="RIGHT",["OffsetY"]=-18,["Height"]=29,["Width"]=29,},["CastBar"]={["Texture"]="Interface\\TargetingFrame\\UI-TargetingFrame-BarFill",["Enable"]=false,["OffsetX"]=60,["AnchorTo"]="CENTER",["Anchor"]="BOTTOMRIGHT",["OffsetY"]=-5,["Height"]=10,["Width"]=105,},["Overlay"]={["Texture"]="Interface\\Tooltips\\Nameplate-Border",["Enable"]=false,["OffsetX"]=0,["AnchorTo"]="TOPLEFT",["Anchor"]="TOPLEFT",["OffsetY"]=0,["Height"]=36,["Width"]=130,},},["TextureGroupSetting"]={["沥抗 钎矫"]={["FrameLevel"]=0,["Scale"]=2,["Alpha"]=1,["DataType"]="Classification_Elite",["TextureGroup"]={["1"]={["ProfileName"]="Blizzard Elite Icon",["AnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["Layer"]="BACKGROUND",["Height"]=20,["Width"]=35,},},["Height"]=20,["Width"]=20,["FrameAnchorData"]={["OffsetX"]=15,["OffsetY"]=-2,["To"]="RIGHT",["From"]="LEFT",},["AnchorFrame"]="HealthBarGroup",},["Quest Bg Circle"]={["FrameLevel"]=2,["Scale"]=1,["Alpha"]=1,["DataType"]="Quest",["TextureGroup"]={["Outer circl"]={["ProfileName"]="QuestNunberBgCircle outer",["AnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["Layer"]="BACKGROUND",["Height"]=24,["Width"]=24,},["Inner circle"]={["Width"]=18,["Height"]=18,["Layer"]="BORDER",["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=0,["From"]="CENTER",},["ProfileName"]="QuestNunberBgCircle Inner",},},["Height"]=22,["Width"]=22,["FrameAnchorData"]={["OffsetX"]=11,["OffsetY"]=-1,["To"]="RIGHT",["From"]="LEFT",},["AnchorFrame"]="LevelText",},["Healthbar"]={["FrameLevel"]=0,["Scale"]=1,["Alpha"]=1,["DataType"]="None",["TextureGroup"]={["1"]={["ProfileName"]="Blizzard Border",["Height"]=20,["Layer"]="BACKGROUND",["AnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["Width"]=150,},},["Height"]=16,["Width"]=146,["FrameAnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["AnchorFrame"]="MainFrame",},["CasingShield"]={["FrameLevel"]=0,["Scale"]=1,["Alpha"]=1,["DataType"]="CastingShield",["TextureGroup"]={["1"]={["ProfileName"]="Blizzard Spell Interrupt Shield",["Height"]=36,["Layer"]="BORDER",["AnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["Width"]=150,},},["Height"]=20,["Width"]=20,["FrameAnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["AnchorFrame"]="矫傈官 抛滴府TextureGroup",},["快滴赣府 沥抗钎矫"]={["FrameLevel"]=0,["Scale"]=2,["Alpha"]=1,["DataType"]="Classification_WorldBoss",["TextureGroup"]={["秦榜"]={["Width"]=9,["Height"]=9,["Layer"]="ARTWORK",["AnchorData"]={["To"]="CENTER",["OffsetY"]=2,["OffsetX"]=-9,["From"]="CENTER",},["ProfileName"]="Blizzard Skull Icon",},["沥抗 抛滴府"]={["Width"]=35,["Height"]=20,["Layer"]="BACKGROUND",["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=0,["From"]="CENTER",},["ProfileName"]="Blizzard Elite Icon",},},["Height"]=20,["Width"]=20,["FrameAnchorData"]={["OffsetX"]=15,["OffsetY"]=-2,["To"]="RIGHT",["From"]="LEFT",},["AnchorFrame"]="HealthBarGroup",},["矫傈官 抛滴府"]={["FrameLevel"]=0,["Scale"]=1,["Alpha"]=0.7,["DataType"]="Casting",["TextureGroup"]={["1"]={["Width"]=150,["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=0,["From"]="CENTER",},["Layer"]="BACKGROUND",["Height"]=20,["ProfileName"]="Blizzard Border Invert",},},["Height"]=14,["Width"]=144,["FrameAnchorData"]={["To"]="CENTER",["OffsetY"]=-22,["OffsetX"]=0,["From"]="CENTER",},["AnchorFrame"]="HealthbarTextureGroup",},},}@Core\\PowerMatch\\#true@Texture\\Blizzard Border\\#{["Top"]=0,["RAngle"]=0,["Mode"]="BLEND",["Bottom"]=1,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Right"]=1,["Left"]=0,["Texture"]="Interface\\Addons\\NPA2\\texture\\defaultborder",}@Texture\\Blizzard ComboPoint\\#{["Top"]=0.09,["RAngle"]=0,["Right"]=0.59,["Bottom"]=0.56,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["Mode"]="BLEND",["Left"]=0.36,["Texture"]="Interface\\ComboFrame\\combopoint.blp",}@Texture\\Blizzard Bar Interrupt Shield\\#{["Top"]=0,["RAngle"]=0,["Mode"]="BLEND",["Bottom"]=1,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Right"]=1,["Left"]=0,["Texture"]="Interface\\Addons\\NPA2\\texture\\barshield",}@Texture\\Blizzard Skull Icon\\#{["Top"]=0,["RAngle"]=0,["Right"]=1,["Bottom"]=1,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["Mode"]="BLEND",["Left"]=0,["Texture"]="Interface\\TargetingFrame\\UI-TargetingFrame-Skull",}@Core\\DataCollectors\\#{["Guild"]=true,["UnitID"]=true,["CC_DR"]=true,["Aura"]=true,["Target"]=false,["Level"]=true,["ComboPoints"]=true,["Quest"]=true,["NPCGuild"]=true,["Classification"]=true,["Threat"]=true,["Power"]=true,["SpellLock"]=true,["RaidTarget"]=true,["Alpha"]=true,["Summoned"]=true,["Friends"]=true,["Tapped"]=true,["Health"]=true,["Speed"]=true,["Name"]=true,["Casting"]=true,["Type"]=true,["CoolDown"]=false,}@Texture\\QuestNunberBgCircle Inner\\#{["Top"]=0.52,["RAngle"]=0,["Mode"]="BLEND",["Bottom"]=0.76,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Right"]=0.25,["Left"]=0,["Texture"]="Interface\\LFGFrame\\UI-LFG-ICON-ROLES",}@Texture\\Blizzard Role Icons\\#{["Top"]=0,["RAngle"]=0,["Mode"]="BLEND",["Bottom"]=1,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Right"]=1,["Left"]=0,["Texture"]="Interface\\LFGFrame\\UI-LFG-ICON-ROLES",}@Texture\\Blizzard Border Invert\\#{["Top"]=0,["RAngle"]=0,["Mode"]="BLEND",["Bottom"]=1,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Right"]=0,["Left"]=1,["Texture"]="Interface\\Addons\\NPA2\\texture\\defaultborder",}@Texture\\PvP Trinket Texture\\#{["Top"]=0,["RAngle"]=359,["Right"]=1,["Bottom"]=1,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["Mode"]="BLEND",["Left"]=0,["Texture"]="Interface\\Icons\\INV_Jewelry_TrinketPVP_02",}@Core\\EnableAuraCache\\#true',
		}
	}
end