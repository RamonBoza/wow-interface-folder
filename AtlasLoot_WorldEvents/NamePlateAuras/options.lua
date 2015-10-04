local addons, C = ...
local ACD		= C.ACD
local LDBI		= C.LDBI
local LDB		= C.LDB
local L			= C.L
local LSM		= C.LSM
local DB		= C.DB
local ADB		= C.ADB

local selected_spell = nil
local selected_custom_spell = nil
local selected_blacklist = nil

function C:DefaultOptions()

	local default = {
		profile =
		{
			minimap = {
				hide = true,
			},
			showdebug = false,
			
			showboth = true,
			
			showmyspell = true,
			
			showspellformlist = true,
			showpurgeblespells = false,
			showspellformblacklist = false,
			showspellformcustom = false,

			spells = self:GetSpells(),
			custom_spelllist = {},
			blacklist = {},
			showdurationtext = true,
			
			frame_offset = 0,
			frame_offset_x = 0,
			
			font_flag = "",
			font = "",
			
			font_size_icon = 14,
			font_flag_icon = "",
			font_icon = "",
			
			border_style = 1,
			
			aura_size = 18,
			font_size = 14,
			
			stealableSize = 1,
			
			statusbar = "",
			
			time_text_format = 1,
			
			cooldownoverlay_texture = false,
			cooldownoverlay_texture_onmove = true,
			
			border_vertex_color = { 1, 1, 1, 1 },
		
			spacing = 3,
			
			time_font_point = 'TOPLEFT',
			time_font_xpos = 2,
			time_font_ypos = 2,
			time_font_justify = 'CENTER',	
			
			stack_font_point = 'BOTTOMRIGHT',
			stack_font_xpos = 2,
			stack_font_ypos = -2,
			stack_font_justify = 'LEFT',		

	
			buffs = {
				numAuras = 6,
				stretchTexture = false,
				
			},
			debuffs = { 
				numAuras = 6,
				stretchTexture = false,
			},
			
			both = {
				numAuras = 4,
				stretchTexture = false,
				perrow = 2,
			},
			
			colorByType = true,
			
			time_color1 = { 1, 0, 0, 1},
			time_color2 = { 1, 1, 0, 1},
			time_color3 = { 1, 1, 1, 1},
			
			color1		= {0.80,0,0},
			color2		= {0.20,0.60,1.00},
			color3		= {0.60,0.00,1.00 },
			color4		= {0.60,0.40, 0 },
			color5		= {0.00,0.60,0 },
			color6		= {0.00,1.00,0 },
				
			purgeble	= { 1, 1, 1 },
			
		}
	}
	
	self.db = ADB:New(DB, default, true)
end

function C:UpdateHeaderTableOptions()
	local o = self.options
						
	o.args.general.args.header_options_overlay = {
		order = 3.1,name = "Header options",type = "group", guiInline = true, args = {					
			showboth = {
				order = 1,name = "Merge aura headers",type = "toggle", width = "full",
				set = function(info,val) self.db.profile.showboth = not self.db.profile.showboth; C:UpdateAllHeaders();C:UpdateHeaderTableOptions(); end,
				get = function(info) return self.db.profile.showboth end	
			},		
		}
	}
	
	if self.db.profile.showboth then
		o.args.general.args.header_options_overlay.args.NumAurasPerRow = {
			name = "Num Auras",
			type = "range",
			order	= 2,
			min		= 1,
			max		= 20,
			step	= 1,
			set = function(info,val) 
				C.db.profile.both.numAuras = val
				C:UpdateAllPlates()
			end,
			get =function(info)
				return C.db.profile.both.numAuras
			end,
		}
		
		o.args.general.args.header_options_overlay.args.NumRows = {
			name = "Num auras per row",
			type = "range",
			order	= 3,
			min		= 1,
			max		= 10,
			step	= 1,
			set = function(info,val) 
				C.db.profile.both.perrow = val
				C:UpdateAllPlates()
			end,
			get =function(info)
				return C.db.profile.both.perrow
			end,
		}
			
	else
			o.args.general.args.header_options_overlay.args.BuffnumAuras = {
				name = "Max Buff Auras",
				type = "range",
				order	= 2,
				min		= 1,
				max		= 10,
				step	= 1,
				set = function(info,val) 
					C.db.profile.buffs.numAuras = val
					C:UpdateAllPlates()
				end,
				get =function(info)
					return C.db.profile.buffs.numAuras
				end,
			}
			
			o.args.general.args.header_options_overlay.args.DebuffnumAuras = {
				name = "Max Debuff Auras",
				type = "range",
				order	= 3,
				min		= 1,
				max		= 10,
				step	= 1,
				set = function(info,val) 
					C.db.profile.debuffs.numAuras = val
					C:UpdateAllPlates()
				end,
				get =function(info)
					return C.db.profile.debuffs.numAuras
				end,
			}
	end
	
end



function C:OptionsTable()
	local o = {
		type = "group",name = addons.." ( moving there )",
		args = {
		
			general={
				order = 1,name = "General",type = "group",
				args={
					minimap = {
						order = 1,name = "Show minimap",type = "toggle",
						set = function(info,val) self.db.profile.minimap.hide = not self.db.profile.minimap.hide; C:UpdateMinimap() end,
						get = function(info) return self.db.profile.minimap.hide end
					},
					showdebug = {
						order = 1,name = "Show Debug",type = "toggle", width = "full",
						set = function(info,val) self.db.profile.showdebug = not self.db.profile.showdebug end,
						get = function(info) return self.db.profile.showdebug end	
					},
					
					spellist_group = {
						order = 2,name = "Spell filters",type = "group", guiInline = true,
						args={
							showmyspell = {
								order = 2,name = "Show my spells",type = "toggle",
								set = function(info,val) self.db.profile.showmyspell = not self.db.profile.showmyspell end,
								get = function(info) return self.db.profile.showmyspell end	
							},
							showpurgeblespells = {
								order = 2.1,name = "Show stealable spells",type = "toggle",
								set = function(info,val) self.db.profile.showpurgeblespells = not self.db.profile.showpurgeblespells end,
								get = function(info) return self.db.profile.showpurgeblespells end	
							},
							showspellformlist = {
								order = 3,name = "Show spells form Default Spell List",type = "toggle",
								set = function(info,val) self.db.profile.showspellformlist = not self.db.profile.showspellformlist end,
								get = function(info) return self.db.profile.showspellformlist end	
							},		
							showspellformblacklist = {
								order = 3.1,name = "Hide spells from Blacklist",type = "toggle",
								set = function(info,val) self.db.profile.showspellformblacklist = not self.db.profile.showspellformblacklist end,
								get = function(info) return self.db.profile.showspellformblacklist end	
							},
							showspellformcustom = {
								order = 3.2,name = "Show spells form Custom Spell List",type = "toggle",
								set = function(info,val) self.db.profile.showspellformcustom = not self.db.profile.showspellformcustom end,
								get = function(info) return self.db.profile.showspellformcustom end	
							},
						},
					},

					cooldown_overlay = {
						order = 3.2,name = "Cooldown overlay",type = "group", guiInline = true,
						args={
							show = {
								order = 1,name = "Show",type = "toggle", width = "full",
								set = function(info,val) self.db.profile.cooldownoverlay = not self.db.profile.cooldownoverlay; C:UpdateAllPlates() end,
								get = function(info) return self.db.profile.cooldownoverlay end	
							},
							hidetexture = {
								order = 2,name = "Hide texture",type = "toggle",
								set = function(info,val) self.db.profile.cooldownoverlay_texture = not self.db.profile.cooldownoverlay_texture; C:UpdateAllPlates() end,
								get = function(info) return self.db.profile.cooldownoverlay_texture end	
							},
							--[[
							hidetexture_onmoving = {
								order = 3,name = "Hide texture on moving",type = "toggle",
								set = function(info,val) self.db.profile.cooldownoverlay_texture_onmove = not self.db.profile.cooldownoverlay_texture_onmove; C:UpdateAllPlates() end,
								get = function(info) return self.db.profile.cooldownoverlay_texture_onmove end	
							},
							]]
						},					
					},
					showdurationtext = {
						order = 3.3,name = "Show duration text",type = "toggle", width = "full",
						set = function(info,val) self.db.profile.showdurationtext = not self.db.profile.showdurationtext; C:UpdateAllPlates() end,
						get = function(info) return self.db.profile.showdurationtext end	
					},
					
					iconSize = {
						name = "Icon Size",
						type = "range",
						order	= 4,
						min		= 1,
						max		= 32,
						step	= 1,
						set = function(info,val) 
							self.db.profile.aura_size = val
							C:UpdateAllPlates()
						end,
						get =function(info)
							return self.db.profile.aura_size
						end,
					},
					stealableSize = {
						name = "Stealable Icon Scale",
						type = "range",
						order	= 4.1,
						min		= 1,
						max		= 3,
						step	= 1,
						set = function(info,val) 
							self.db.profile.stealableSize = val
						--	C:UpdateAllPlates()
						end,
						get =function(info)
							return self.db.profile.stealableSize
						end,
					},
					
					iconspacing = {
						name = "Icon Spacing",
						type = "range",
						order	= 4.2,
						min		= 0,
						max		= 60,
						step	= 1,
						set = function(info,val) 
							self.db.profile.spacing = val
							C:UpdateAllPlates()
						end,
						get =function(info)
							return self.db.profile.spacing
						end,
					},

					frame_offset = {
						name = "Y Offset",
						type = "range",
						order	= 5,
						min		= -200,
						max		= 200,
						step	= 1,
						set = function(info,val) 
							self.db.profile.frame_offset = val
							C:UpdateAllPlates()
						end,
						get =function(info)
							return self.db.profile.frame_offset
						end,
					},
					frame_offset_x = {
						name = "X Offset",
						type = "range",
						order	= 5,
						min		= -200,
						max		= 200,
						step	= 1,
						set = function(info,val) 
							self.db.profile.frame_offset_x = val
							C:UpdateAllPlates()
						end,
						get =function(info)
							return self.db.profile.frame_offset_x
						end,
					},
					nameplate_icons = {
						order = 6,name = "Icons",type = "group", guiInline = true,
						args={
							font_flag = {
								name = "Font Flags",
								order = 6,
								type = "select",
								values = {
									
									[""] = NO,
									["OUTLINE"] = "OUTLINE",
									["THICKOUTLINE"] = "THICKOUTLINE",
								},
								set = function(info,val)
									self.db.profile.font_flag_icon = val 
									C:UpdateAllPlates()
								end,
								get = function(info, val)
									return self.db.profile.font_flag_icon
								end
								
							},
							
							background = {
								order = 6.1,name = "Text background",type = "toggle",
								set = function(info,val) self.db.profile.show_text_background = not self.db.profile.show_text_background; C:UpdateAllPlates(); end,
								get = function(info) return self.db.profile.show_text_background end	
							},
							
							timeColor = {
								order = 6.2,name = "Time Color",type = "group", guiInline = true,
								args={
									
									color1 = {
										order = 1,name = " < 3sec",type = "color", hasAlpha = false,
										set = function(info,r,g,b,a) self.db.profile.time_color1={r,g,b,1}; C:UpdateAllPlates(); end,
										get = function(info) return self.db.profile.time_color1[1],self.db.profile.time_color1[2],self.db.profile.time_color1[3],1; end
									},
									color2 = {
										order = 1,name = " > 3 sec",type = "color", hasAlpha = true,
										set = function(info,r,g,b,a) self.db.profile.time_color2={r,g,b,1}; C:UpdateAllPlates(); end,
										get = function(info) return self.db.profile.time_color2[1],self.db.profile.time_color2[2],self.db.profile.time_color2[3],1; end
									},
									color3 = {
										order = 1,name = " > 1 min ",type = "color", hasAlpha = true,
										set = function(info,r,g,b,a) self.db.profile.time_color3={r,g,b,a}; C:UpdateAllPlates(); end,
										get = function(info) return self.db.profile.time_color3[1],self.db.profile.time_color3[2],self.db.profile.time_color3[3],1; end
									},
									
								}
							},
							font = {
								order = 7,name = "Font",type = 'select',
								dialogControl = 'LSM30_Font',
								values = LSM:HashTable("font"),
								set = function(info,key) 
									self.db.profile.font_icon = key;
									C:UpdateAllPlates(); 
								end,
								get = function(info) 
									return self.db.profile.font_icon 
								end,
							},
							font_size = {
								name = "Font Size",
								type = "range",
								order	= 8,
								min		= 1,
								max		= 32,
								step	= 1,
								set = function(info,val) 
									self.db.profile.font_size_icon = val
									C:UpdateAllPlates()
								end,
								get =function(info)
									return self.db.profile.font_size_icon
								end,
							},
							
							border_style = {
								name = "Border Style",
								order = 9,
								type = "select",
								values = {
									'Default',
									'Blizzard',
								},
								set = function(info,val)
									self.db.profile.border_style = val 
								--	C:UpdateAllPlates()
								end,
								get = function(info, val)
									return self.db.profile.border_style
								end
								
							},
							
							timetext = {
								order = 10,name = "Time Text",type = "group", guiInline = true,
								args={
									formats = {
										name = "Format",
										type = "select",
										values = {
											"0s 1s 3s 1m 1h",
											"0 1 3 1m 1h",
											"0.1 1.1 3.1 1m 1h",
											"0.1 10 1m 1h",
										},
										set = function(info, val)
											self.db.profile.time_text_format = val
										end,
										get = function(info)
											return self.db.profile.time_text_format
										end,
									},
									xpos = {
										name = "Xpos",
										type = "range",
										order	= 1,
										min		= -50,
										max		= 50,
										step	= 1,
										set = function(info,val) 
											self.db.profile.time_font_xpos = val
											C:UpdateAllPlates()
										end,
										get =function(info)
											return self.db.profile.time_font_xpos
										end,
									
									},
									ypos = {
										name = "Ypos",
										type = "range",
										order	= 1,
										min		= -50,
										max		= 50,
										step	= 1,
										set = function(info,val) 
											self.db.profile.time_font_ypos = val
											C:UpdateAllPlates()
										end,
										get =function(info)
											return self.db.profile.time_font_ypos
										end,						
									},
									justifu = {
										name = "Justify",
										order = 3,
										type = "select",
										values = {
											["TOP"] = "Top",
											["LEFT"] = "Left",
											["RIGHT"] = "Right",
											["BOTTOM"] = "Bottom",
											["CENTER"] = "Center",
										},
										set = function(info,val)
											self.db.profile.time_font_justify = val 
											C:UpdateAllPlates()
										end,
										get = function(info, val)
											return self.db.profile.time_font_justify
										end							
									},
									position = {
										name = "Point",
										order = 3,
										type = "select",
										values = {
											["TOP"] = "Top",
											["TOPLEFT"] = "Top Left",
											["TOPRIGHT"] = "Top Right",
											["BOTTOMLEFT"] = "Bottom Left",
											["BOTTOMRIGHT"] = "Bottom Right",
											["BOTTOM"] = "Bottom",
										},
										set = function(info,val)
											self.db.profile.time_font_point = val 
											C:UpdateAllPlates()
										end,
										get = function(info, val)
											return self.db.profile.time_font_point
										end								
									},
								},
							},
							stacktext = {
								order = 11,name = "Stack Text",type = "group", guiInline = true,
								args={
									xpos = {
										name = "Xpos",
										type = "range",
										order	= 1,
										min		= -50,
										max		= 50,
										step	= 1,
										set = function(info,val) 
											self.db.profile.stack_font_xpos = val
											C:UpdateAllPlates()
										end,
										get =function(info)
											return self.db.profile.stack_font_xpos
										end,							
									},
									ypos = {
										name = "Ypos",
										type = "range",
										order	= 1,
										min		= -50,
										max		= 50,
										step	= 1,
										set = function(info,val) 
											self.db.profile.stack_font_ypos = val
											C:UpdateAllPlates()
										end,
										get =function(info)
											return self.db.profile.stack_font_ypos
										end,									
									},
									justify = {
										name = "Justify",
										order = 3,
										type = "select",
										values = {
											["TOP"] = "Top",
											["LEFT"] = "Left",
											["RIGHT"] = "Right",
											["BOTTOM"] = "Bottom",
											["CENTER"] = "Center",
										},
										set = function(info,val)
											self.db.profile.stack_font_justify = val 
											C:UpdateAllPlates()
										end,
										get = function(info, val)
											return self.db.profile.stack_font_justify
										end							
									},
									position = {
										name = "Point",
										order = 3,
										type = "select",
										values = {
											["TOP"] = "Top",
											["TOPLEFT"] = "Top Left",
											["TOPRIGHT"] = "Top Right",
											["BOTTOMLEFT"] = "Bottom Left",
											["BOTTOMRIGHT"] = "Bottom Right",
											["BOTTOM"] = "Bottom",
										},
										set = function(info,val)
											self.db.profile.stack_font_point = val 
											C:UpdateAllPlates()
										end,
										get = function(info, val)
											return self.db.profile.stack_font_point
										end		
									},
								},
							},
						},
					},
					def_nameplate = {
						order = 7,name = "Blizzard Nameplates",type = "group", guiInline = true,
						args={
					
							font_flag = {
								name = "Font Flags",
								order = 6,
								type = "select",
								values = {
									
									[""] = NO,
									["OUTLINE"] = "OUTLINE",
									["THICKOUTLINE"] = "THICKOUTLINE",
								},
								set = function(info,val)
									self.db.profile.font_flag = val 
									C:UpdateAllPlates()
								end,
								get = function(info, val)
									return self.db.profile.font_flag
								end
								
							},
							
							font = {
								order = 7,name = "Font",type = 'select',
								dialogControl = 'LSM30_Font',
								values = LSM:HashTable("font"),
								set = function(info,key) 
									self.db.profile.font = key;
									C:UpdateAllPlates(); 
								end,
								get = function(info) 
									return self.db.profile.font 
								end,
							},
							font_size = {
								name = "Font Size",
								type = "range",
								order	= 8,
								min		= 1,
								max		= 32,
								step	= 1,
								set = function(info,val) 
									self.db.profile.font_size = val
									C:UpdateAllPlates()
								end,
								get =function(info)
									return self.db.profile.font_size
								end,
							},
							
							statusbar = {
								order = 9,name = "Statusbar",type = 'select',
								dialogControl = 'LSM30_Statusbar',
								values = LSM:HashTable("statusbar"),
								set = function(info,key) 
									self.db.profile.statusbar = key;
									C:UpdateAllPlates(); 
								end,
								get = function(info) 
									return self.db.profile.statusbar 
								end,
							},
							border_color = {
								order = 10,name = "Border Color",type = "color", hasAlpha = true,
								set = function(info,r,g,b,a) self.db.profile.border_vertex_color={r,g,b,a}; C:UpdateAllPlates(); end,
								get = function(info) return self.db.profile.border_vertex_color[1],self.db.profile.border_vertex_color[2],self.db.profile.border_vertex_color[3],self.db.profile.border_vertex_color[4] end
							},
						},
					},
					border_color_type = {
						order = 10,name = "Aura Border Color",type = "group", guiInline = true,
						args={
							colorbyType = {
									type = "toggle", order	= 20,
									name = "Color by type",
									desc = "If not set Physical color used for all debuffs",

									set = function(info,val) 
										self.db.profile.colorByType = val
									end,
									get = function(info) return self.db.profile.colorByType end
								},
							color1 = {
									order = 21,name = "Physical",type = "color",
									set = function(info,r,g,b) self.db.profile.color1={r,g,b} end,
									get = function(info) return self.db.profile.color1[1],self.db.profile.color1[2],self.db.profile.color1[3],1 end
								},
							color2 = {
									order = 22,name = "Magic",type = "color",
									set = function(info,r,g,b) self.db.profile.color2={r,g,b} end,
									get = function(info) return self.db.profile.color2[1],self.db.profile.color2[2],self.db.profile.color2[3],1 end
								},
							color3 = {
									order = 23, name = "Curse",type = "color",
									set = function(info,r,g,b) self.db.profile.color3={r,g,b} end,
									get = function(info) return self.db.profile.color3[1],self.db.profile.color3[2],self.db.profile.color3[3],1 end
								},
							color4 = {
									order = 24,name = "Disease",type = "color",
									set = function(info,r,g,b) self.db.profile.color4={r,g,b} end,
									get = function(info) return self.db.profile.color4[1],self.db.profile.color4[2],self.db.profile.color4[3],1 end
								},
							color5 = {
									order = 25,name = "Poison",type = "color",
									set = function(info,r,g,b) self.db.profile.color5={r,g,b} end,
									get = function(info) return self.db.profile.color5[1],self.db.profile.color5[2],self.db.profile.color5[3],1 end
								},
							color6 = {
									order = 26,name = "Buff",type = "color",
									set = function(info,r,g,b) self.db.profile.color6={r,g,b} end,
									get = function(info) return self.db.profile.color6[1],self.db.profile.color6[2],self.db.profile.color6[3],1 end
								},
							purgeble = {
									order = 27,name = "Purge",type = "color",
									set = function(info,r,g,b) self.db.profile.purgeble={r,g,b} end,
									get = function(info) return self.db.profile.purgeble[1],self.db.profile.purgeble[2],self.db.profile.purgeble[3],1 end
								},
						},
					},
				},
			},
			spelllist = {
				order = 2,name = "Default Spell List",type = "group",
				args={
				
				},
			},
			custom_spelllist = {
				order = 3,name = "Custom Spell List",type = "group",
				args={
				
				},
			},
			blacklist_spelllist = {
				order = 4,name = "Blacklist",type = "group",
				args={
				
				},
			},
			about = {
				order = -1,name = "About",type = "group",
				args={					
				},
			},
			profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db),
		},
	}
	
--	o.args.general.args
--	o.args.spelllist.args
	
	o.args.spelllist.args.list = {
		name = "Select Spell",
		order = 2,
		desc = "Select Spell",
		width = "full",
		type = "select",
		values = function()
			local t = {}												
			for name,data in pairs(self.db.profile.spells) do				
				if not data.deleted then
					if data[2] and tonumber(data[2]) then
						t[name] = self:SpellString(data[2])
					else
						t[name] = name
					end
				end
			end									
			return t
		end,
		set = function(info,val)
			C:ChooseSpell(val)
		end,
		get = function(info, val)
			return selected_spell
		end
	}
	o.args.spelllist.args.AddNew = {
		type = "input",	order	= 1,
		name = "Spell Name or ID",
		desc = "Change spellID",
		set = function(info,val)			
			local num = tonumber(val)
			if num then
				local spellname = GetSpellInfo(num)										
				if spellname then										
					
					if not self.db.profile.spells[spellname] then					
						self.db.profile.spells[spellname] = { 1.5, num }
					end
					
					self.db.profile.spells[spellname][2] = num
					self.db.profile.spells[spellname].showing = 1
					self.db.profile.spells[spellname].deleted = nil
					self.db.profile.spells[spellname].auratype = 1
					
					C:ChooseSpell(spellname)
				end
			else
			
				if not self.db.profile.spells[val] then					
					self.db.profile.spells[val] = { 1.5, nil }
				end
				self.db.profile.spells[val].showing = 1
				self.db.profile.spells[val].deleted = nil
					
				C:ChooseSpell(val)
			end
		end,
		get = function(info) end
	}
	
	o.args.custom_spelllist.args.separator = {
		name	= "",
		order	= 3,
		type = "header",
	
	}
	
	o.args.custom_spelllist.args.list = {
		name = "Select Spell",
		order = 2,
		desc = "Select Spell",
		width = "full",
		type = "select",
		values = function()
			local t = {}												
			for name,data in pairs(self.db.profile.custom_spelllist) do				
				if not data.deleted then
					if data[2] and tonumber(data[2]) then
						t[name] = self:SpellString(data[2])
					else
						t[name] = name
					end
				end
			end									
			return t
		end,
		set = function(info,val)
			C:ChooseSpell_Custom(val)
		end,
		get = function(info, val)
			return selected_custom_spell
		end
	}
	o.args.custom_spelllist.args.AddNew = {
		type = "input",	order	= 1,
		name = "Spell Name or ID",
		desc = "Change spellID",
		set = function(info,val)			
			local num = tonumber(val)
			if num then
				local spellname = GetSpellInfo(num)										
				if spellname then										
					
					if not self.db.profile.custom_spelllist[spellname] then					
						self.db.profile.custom_spelllist[spellname] = { 1.5, num }
					end
					
					self.db.profile.custom_spelllist[spellname][2] = num
					self.db.profile.custom_spelllist[spellname].showing = 1
					self.db.profile.custom_spelllist[spellname].deleted = nil
					self.db.profile.custom_spelllist[spellname].auratype = 1
					
					C:ChooseSpell_Custom(spellname)
				end
			else
			
				if not self.db.profile.custom_spelllist[val] then					
					self.db.profile.custom_spelllist[val] = { 1.5, nil }
				end
				self.db.profile.custom_spelllist[val].showing = 1
				self.db.profile.custom_spelllist[val].deleted = nil
					
				C:ChooseSpell_Custom(spellname)
			end
		end,
		get = function(info) end
	}
	
	o.args.custom_spelllist.args.separator = {
		name	= "",
		order	= 3,
		type = "header",
	
	}
	
	
	o.args.blacklist_spelllist.args.separator = {
		name	= "",
		order	= 3,
		type = "header",
	
	}
	
	o.args.blacklist_spelllist.args.list = {
		name = "Select Spell",
		order = 2,
		desc = "Select Spell",
		width = "full",
		type = "select",
		values = function()
			local t = {}												
			for name,data in pairs(self.db.profile.blacklist) do				
				if not data.deleted then
					if data[2] and tonumber(data[2]) then
						t[name] = self:SpellString(data[2])
					else
						t[name] = name
					end
				end
			end									
			return t
		end,
		set = function(info,val)
			C:ChooseSpell_Blacklist(val)
		end,
		get = function(info, val)
			return selected_blacklist
		end
	}
	o.args.blacklist_spelllist.args.AddNew = {
		type = "input",	order	= 1,
		name = "Spell Name or ID",
		desc = "Change spellID",
		set = function(info,val)			
			local num = tonumber(val)
			if num then
				local spellname = GetSpellInfo(num)										
				if spellname then										
					
					if not self.db.profile.blacklist[spellname] then					
						self.db.profile.blacklist[spellname] = { 1.5, num }
					end
					
					self.db.profile.blacklist[spellname][2] = num
					self.db.profile.blacklist[spellname].showing = 1
					self.db.profile.blacklist[spellname].deleted = nil
					self.db.profile.blacklist[spellname].auratype = 1
					
					C:ChooseSpell_Blacklist(spellname)
				end
			else
			
				if not self.db.profile.blacklist[val] then					
					self.db.profile.blacklist[val] = { 1.5, nil }
				end
				self.db.profile.blacklist[val].showing = 1
				self.db.profile.blacklist[val].deleted = nil
					
				C:ChooseSpell_Blacklist(val)
			end
		end,
		get = function(info) end
	}
	
	o.args.blacklist_spelllist.args.separator = {
		name	= "",
		order	= 3,
		type = "header",
	
	}
	
	return o	
end

do
	local donation = { 
		"Je*** Hui*****(jfd**iz@xs4***.nl) @Curse.com",
		"Mary Jo*** @PayPal",
		"A**et***ve A**e @PayPal",
	}

	local sites = {
	--	["curse_com"] = { "Curse.com", "http://www.curse.com/addons/wow/sptimers", false, "full" },
		["twitter"]	  = { "Twitter", "TimoshN", false, nil },
		["website"]	  = { "URL", "http://aleaaddons.ru", false, nil },
		["anyhelp"]	  = { "Help", "http://www.aleaaddons.ru/p/support.html" , true, "full"},
	}
		
	function C:InitSupports()
		local order_1 = 1
		for k,v in pairs(sites) do
		
			self.options.args.about.args[k] =  {
				type = "input",	order	= order_1,multiline = v[3],
				name = v[1],
				width = v[4],
				set = function(info,val) end,						
				get = function(info) return v[2] end
			}
			order_1 = order_1 + 1
		
		end
		
		local don_text = "Donations:\n"
		
		for k,v in ipairs(donation) do
			don_text = don_text..format("%d. %s\n", k, v)	
		end
		
		self.options.args.about.args.donations  = {
				order = order_1,
				type = "description",
				name = don_text,
			}

	end
end


function C:ChooseSpell(name)
	selected_spell = name
	
	self.options.args.spelllist.args.affilation = {
		name = "Show",
		order = 5,
		type = "select",
		values = {		
			"Always",
			"Never",
			"Only mine",
			"Only on enemy",
			"Only on friendly",
		},
		set = function(info,val)
			self.db.profile.spells[selected_spell].showing = val
		end,
		get = function(info, val)
			return self.db.profile.spells[selected_spell].showing or 1
		end
	}
	
	self.options.args.spelllist.args.auratype = {
		name = "Aura Type",
		order = 5.1,
		type = "select",
		values = {		
			"Buff and Debuff",
			"Only Buff",
			"Only Debuff",
		},
		set = function(info,val)
			self.db.profile.spells[selected_spell].auratype = val
		end,
		get = function(info, val)
			return self.db.profile.spells[selected_spell].auratype or 1
		end
	}
	
	self.options.args.spelllist.args.separator1 = {
		name	= "",
		order	= 5.2,
		type = "header",	
	}
	
	
	self.options.args.spelllist.args.spellid = {

		type = "input",	order	= 8,
		name = "SpellID",
		desc = "SpellID",
		set = function(info,val) 
			local num = tonumber(val)				
			if num then 
				local name = GetSpellInfo(num)			
				if name == selected_spell then
					self.db.profile.spells[selected_spell][2] = num
				else
					self.db.profile.spells[selected_spell][2] = "Invalid SpellID"
				end
			end
		end,
		get = function(info) 
			return self.db.profile.spells[selected_spell][2] and tostring(self.db.profile.spells[selected_spell][2]) or "No spellID"		
		end
	}
	
	self.options.args.spelllist.args.size = {
		name = "Size",
		type = "range",
		order	= 6,
		min		= 1,
		max		= 3,
		step	= 0.1,
		set = function(info,val) 
			self.db.profile.spells[selected_spell][1] = val
		end,
		get = function(info)
			return self.db.profile.spells[selected_spell][1]
		end,	
	}
	
	self.options.args.spelllist.args.separator2 = {
		name	= "",
		order	= 6.1,
		type = "header",	
	}
	
	self.options.args.spelllist.args.checkid = {
		order = 8.1,name = "Check SpellID",type = "toggle",
		set = function(info,val) self.db.profile.spells[selected_spell].checkid = not self.db.profile.spells[selected_spell].checkid end,
		get = function(info) return self.db.profile.spells[selected_spell].checkid end	
	}
	
	self.options.args.spelllist.args.separator3 = {
		name	= "",
		order	= 8.2,
		type = "header",	
	}
	
	self.options.args.spelllist.args.duration = {
		type = "input",	order	= 9,
		name = "Duration",
		desc = "Set default aura duration",
		set = function(info,val)			
			local num = tonumber(val)
			if num then
				self.db.profile.spells[selected_spell].duration = num
			end
		end,
		get = function(info) 
			if self.db.profile.spells[selected_spell].duration then
				return tostring(self.db.profile.spells[selected_spell].duration)
			end
		end
	}
	
	self.options.args.spelllist.args.pvpduration = {
		type = "input",	order	= 9.1,
		name = "PvP Duration",
		desc = "Set default PvP aura duration",
		set = function(info,val)			
			local num = tonumber(val)
			if num then
				self.db.profile.spells[selected_spell].pvpduration = num
			end
		end,
		get = function(info)
		
			if self.db.profile.spells[selected_spell].pvpduration then
				return tostring(self.db.profile.spells[selected_spell].pvpduration)
			end
			
		end
	}
	
	self.options.args.spelllist.args.separator4 = {
		name	= "",
		order	= 9.2,
		type = "header",	
	}
	
	self.options.args.spelllist.args.delete = {
		type = 'execute',
		order = -1,
		name = 'Delete',
		func = function(info, value)
			self.db.profile.spells[selected_spell].deleted = true
			selected_spell = nil
			self.options.args.spelllist.args.affilation = nil
			self.options.args.spelllist.args.spellid = nil
			self.options.args.spelllist.args.size = nil
			self.options.args.spelllist.args.checkid = nil
			self.options.args.spelllist.args.delete = nil
			self.options.args.spelllist.args.auratype = nil
			
			self.options.args.spelllist.args.separator1 = nil
			self.options.args.spelllist.args.separator2 = nil
			self.options.args.spelllist.args.separator3 = nil
			self.options.args.spelllist.args.separator4 = nil
			
			self.options.args.spelllist.args.pvpduration = nil
			self.options.args.spelllist.args.duration = nil
		end,
	}
	
end


function C:ChooseSpell_Custom(name)
	selected_custom_spell = name
	
	self.options.args.custom_spelllist.args.affilation = {
		name = "Show",
		order = 5,
		type = "select",
		values = {		
			"Always",
			"Never",
			"Only mine",
			"Only on enemy",
			"Only on friendly",
		},
		set = function(info,val)
			self.db.profile.custom_spelllist[selected_custom_spell].showing = val
		end,
		get = function(info, val)
		
		--	print('T', selected_custom_spell)
		--	print('T1', self.db.profile.custom_spelllist, self.db.profile.custom_spelllist[selected_custom_spell])
			
			return self.db.profile.custom_spelllist[selected_custom_spell].showing or 1
		end
	}
	
	self.options.args.custom_spelllist.args.auratype = {
		name = "Aura Type",
		order = 5.1,
		type = "select",
		values = {		
			"Buff and Debuff",
			"Only Buff",
			"Only Debuff",
		},
		set = function(info,val)
			self.db.profile.custom_spelllist[selected_custom_spell].auratype = val
		end,
		get = function(info, val)
			return self.db.profile.custom_spelllist[selected_custom_spell].auratype or 1
		end
	}
	
	self.options.args.custom_spelllist.args.separator1 = {
		name	= "",
		order	= 5.2,
		type = "header",	
	}
	
	
	self.options.args.custom_spelllist.args.spellid = {

		type = "input",	order	= 8,
		name = "SpellID",
		desc = "SpellID",
		set = function(info,val) 
			local num = tonumber(val)				
			if num then 
				local name = GetSpellInfo(num)			
				if name == selected_custom_spell then
					self.db.profile.custom_spelllist[selected_custom_spell][2] = num
				else
					self.db.profile.custom_spelllist[selected_custom_spell][2] = "Invalid SpellID"
				end
			end
		end,
		get = function(info) 
			return self.db.profile.custom_spelllist[selected_custom_spell][2] and tostring(self.db.profile.custom_spelllist[selected_custom_spell][2]) or "No spellID"		
		end
	}
	
	self.options.args.custom_spelllist.args.size = {
		name = "Size",
		type = "range",
		order	= 6,
		min		= 1,
		max		= 3,
		step	= 0.1,
		set = function(info,val) 
			self.db.profile.custom_spelllist[selected_custom_spell][1] = val
		end,
		get = function(info)
			return self.db.profile.custom_spelllist[selected_custom_spell][1]
		end,	
	}
	
	self.options.args.custom_spelllist.args.separator2 = {
		name	= "",
		order	= 6.1,
		type = "header",	
	}
	
	self.options.args.custom_spelllist.args.checkid = {
		order = 8.1,name = "Check SpellID",type = "toggle",
		set = function(info,val) self.db.profile.custom_spelllist[selected_custom_spell].checkid = not self.db.profile.custom_spelllist[selected_custom_spell].checkid end,
		get = function(info) return self.db.profile.custom_spelllist[selected_custom_spell].checkid end	
	}
	
	self.options.args.custom_spelllist.args.separator3 = {
		name	= "",
		order	= 8.2,
		type = "header",	
	}
	
	self.options.args.custom_spelllist.args.duration = {
		type = "input",	order	= 9,
		name = "Duration",
		desc = "Set default aura duration",
		set = function(info,val)			
			local num = tonumber(val)
			if num then
				self.db.profile.custom_spelllist[selected_custom_spell].duration = num
			end
		end,
		get = function(info) 
			if self.db.profile.custom_spelllist[selected_custom_spell].duration then
				return tostring(self.db.profile.custom_spelllist[selected_custom_spell].duration)
			end
		end
	}
	
	self.options.args.custom_spelllist.args.pvpduration = {
		type = "input",	order	= 9.1,
		name = "PvP Duration",
		desc = "Set default PvP aura duration",
		set = function(info,val)			
			local num = tonumber(val)
			if num then
				self.db.profile.custom_spelllist[selected_custom_spell].pvpduration = num
			end
		end,
		get = function(info)
		
			if self.db.profile.custom_spelllist[selected_custom_spell].pvpduration then
				return tostring(self.db.profile.custom_spelllist[selected_custom_spell].pvpduration)
			end
			
		end
	}
	
	self.options.args.custom_spelllist.args.separator4 = {
		name	= "",
		order	= 9.2,
		type = "header",	
	}
	
	self.options.args.custom_spelllist.args.delete = {
		type = 'execute',
		order = -1,
		name = 'Delete',
		func = function(info, value)
			self.db.profile.custom_spelllist[selected_custom_spell].deleted = true
			selected_custom_spell = nil
			self.options.args.custom_spelllist.args.affilation = nil
			self.options.args.custom_spelllist.args.spellid = nil
			self.options.args.custom_spelllist.args.size = nil
			self.options.args.custom_spelllist.args.checkid = nil
			self.options.args.custom_spelllist.args.delete = nil
			self.options.args.custom_spelllist.args.auratype = nil
			
			self.options.args.custom_spelllist.args.separator1 = nil
			self.options.args.custom_spelllist.args.separator2 = nil
			self.options.args.custom_spelllist.args.separator3 = nil
			self.options.args.custom_spelllist.args.separator4 = nil
			
			self.options.args.custom_spelllist.args.pvpduration = nil
			self.options.args.custom_spelllist.args.duration = nil
		end,
	}
	
end


function C:ChooseSpell_Blacklist(name)
	selected_blacklist = name
	
	self.options.args.blacklist_spelllist.args.affilation = {
		name = "Hide",
		order = 5,
		type = "select",
		values = {		
			"Always",
			"Never",
			"Only mine",
			"Only on enemy",
			"Only on friendly",
		},
		set = function(info,val)
			self.db.profile.blacklist[selected_blacklist].showing = val
		end,
		get = function(info, val)
			return self.db.profile.blacklist[selected_blacklist].showing or 1
		end
	}
	
	self.options.args.blacklist_spelllist.args.auratype = {
		name = "Aura Type",
		order = 5.1,
		type = "select",
		values = {		
			"Buff and Debuff",
			"Only Buff",
			"Only Debuff",
		},
		set = function(info,val)
			self.db.profile.blacklist[selected_blacklist].auratype = val
		end,
		get = function(info, val)
			return self.db.profile.blacklist[selected_blacklist].auratype or 1
		end
	}
	
	self.options.args.blacklist_spelllist.args.separator1 = {
		name	= "",
		order	= 5.2,
		type = "header",	
	}
	
	
	self.options.args.blacklist_spelllist.args.spellid = {

		type = "input",	order	= 8,
		name = "SpellID",
		desc = "SpellID",
		set = function(info,val) 
			local num = tonumber(val)				
			if num then 
				local name = GetSpellInfo(num)			
				if name == selected_blacklist then
					self.db.profile.blacklist[selected_blacklist][2] = num
				else
					self.db.profile.blacklist[selected_blacklist][2] = "Invalid SpellID"
				end
			end
		end,
		get = function(info) 
			return self.db.profile.blacklist[selected_blacklist][2] and tostring(self.db.profile.blacklist[selected_blacklist][2]) or "No spellID"		
		end
	}
	
	self.options.args.blacklist_spelllist.args.checkid = {
		order = 8.1,name = "Check SpellID",type = "toggle",
		set = function(info,val) self.db.profile.blacklist[selected_blacklist].checkid = not self.db.profile.blacklist[selected_blacklist].checkid end,
		get = function(info) return self.db.profile.blacklist[selected_blacklist].checkid end	
	}
	
	self.options.args.blacklist_spelllist.args.separator3 = {
		name	= "",
		order	= 8.2,
		type = "header",	
	}

	
	self.options.args.blacklist_spelllist.args.delete = {
		type = 'execute',
		order = -1,
		name = 'Delete',
		func = function(info, value)
			self.db.profile.blacklist[selected_blacklist].deleted = true
			selected_blacklist = nil
			self.options.args.blacklist_spelllist.args.affilation = nil
			self.options.args.blacklist_spelllist.args.spellid = nil
			self.options.args.blacklist_spelllist.args.size = nil
			self.options.args.blacklist_spelllist.args.checkid = nil
			self.options.args.blacklist_spelllist.args.delete = nil
			self.options.args.blacklist_spelllist.args.auratype = nil
			
			self.options.args.blacklist_spelllist.args.separator1 = nil
			self.options.args.blacklist_spelllist.args.separator2 = nil
			self.options.args.blacklist_spelllist.args.separator3 = nil
			self.options.args.blacklist_spelllist.args.separator4 = nil
			
			self.options.args.blacklist_spelllist.args.pvpduration = nil
			self.options.args.blacklist_spelllist.args.duration = nil
		end,
	}
	
end