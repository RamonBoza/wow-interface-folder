-- Author      : Nogarder
-- Create Date : 2012/12/14 12:14:03
--color mode list used for nameplate module
local table_insert=table.insert
--0=custom
--1=by faction
--2=by class
--3=by threat
--4=by default
--5=by school --for casting
--6=by percent --for bar
--7=by auratype (i.e. poison physical) -- for icon
--8=by level different
local Localization=NPA_Options.Localization.InfoLibColorMode
local NPA_Options_InfoLib_DataTypeColorMode={
	["Text"]={
		["Name"]={
			[1]=true, 
			[2]=true,
			[3]=true,
			[4]=true,
		},
		["FullName"]={
			[1]=true, 
			[2]=true,
			[3]=true,
			[4]=true,
		},
		["Level"]={
			[4]=true,
			[8]=true,
		},
		["Casting"]={
			[5]=true,
		},
		["Target"]={
			[1]=true, 
			[2]=true,
			[3]=true,
		},
		["Quest"]={
			[8]=true,
		},
	},
	["BarGroup"]={
		["Health"]={
			[1]=true, 
			[2]=true,
			[3]=true,
			[4]=true,
		},
		["Casting"]={
			[5]=true,
		},
		["Quest"]={
			[8]=true,
		},
		["Power"]={
			[9]=true,
		}
	},
	["Number"]={
		["Health"]={
			[1]=true,
			[2]=true,
			[3]=true,
		},
		["Casting"]={
			[5]=true,
		},
		["Quest"]={
			[8]=true,
		},
		["Power"]={
			[9]=true,
		}
	},
	["IconGroup"]={
		["Aura"]={
			[7]=true,
		}
	},
}

NPA_Options.InfoLib.GetColorModeList=function(groupname,ttype)
	local colormode=CopyTable(NPA_Options_InfoLib_DataTypeColorMode[groupname][ttype] or {})
	local colormodelist={}
	for index,_ in pairs(colormode)do
		table_insert(colormodelist,{
			Text=Localization["ColorModeList"][index],
			Value=index
		})
	end
	table_insert(colormodelist,{
		Text=Localization["ByFrameSetting"][groupname],
		Value=0
	})
	return colormodelist
end