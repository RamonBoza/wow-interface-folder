-- Author      : Nogarder
-- Create Date : 2012/7/24 10:33:24
NPA_Options.InfoLib.GetTexture=function()
	local NPA_Options_TextureLib={
		["Blizzard Spell Interrupt Shield"]="Interface\\Tooltips\\Nameplate-CastBar-Shield",
		["Blizzard Border"]="Interface\\Addons\\NPA2\\texture\\defaultborder",
		["Blizzard Glow"]="Interface\\Addons\\NPA2\\texture\\glow",
		["Blizzard Stausbar Border"] = "Interface\\Tooltips\\UI-StatusBar-Border",
		["Blizzard Bar"] = "Interface\\TargetingFrame\\UI-StatusBar",
		["Blizzard Character Skills Bar"] = "Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar",
		["NPA Animated Fire"]="Interface\\Addons\\NPA2\\texture\\animated\\fire@7@7@100",
		["NPA Animated Snow"]="Interface\\Addons\\NPA2\\texture\\animated\\snow@10@10@100",
		["NPA Animated Star"]="Interface\\Addons\\NPA2\\texture\\animated\\star-white@11@11@50",
		["NPA Animated Burning Star"]="Interface\\Addons\\NPA2\\texture\\animated\\star@11@11@50",
		["NPA Star"]="Interface\\Addons\\NPA2\\texture\\star-white",
		["NPA Burning Star"]="Interface\\Addons\\NPA2\\texture\\star",
		["Blizzard Bar Interrupt Shield"]="Interface\\Addons\\NPA2\\texture\\barshield",
		["NPA Mono Bar"]="Interface\\Addons\\NPA2\\texture\\mono\\bar",
		["NPA Mono Border"]="Interface\\Addons\\NPA2\\texture\\mono\\border",
		["NPA Mono glow"]="Interface\\Addons\\NPA2\\texture\\mono\\glow",
		["NPA Rune"]="Interface\\Addons\\NPA2\\texture\\runes",
		["NPA Arrow"]="Interface\\Addons\\NPA2\\texture\\arrow",
		["NPA Test1 Bar"]="Interface\\Addons\\NPA2\\texture\\Test1\\bar",
		["NPA Test1 Bar Background"]="Interface\\Addons\\NPA2\\texture\\Test1\\barbackground",
		["NPA Test1 Bar Border"]="Interface\\Addons\\NPA2\\texture\\Test1\\border",
		["NPA Test1 Highlight"]="Interface\\Addons\\NPA2\\texture\\Test1\\highlight",
		["NPA Sphere"]="Interface\\Addons\\NPA2\\texture\\Sphere\\sphere",
		["NPA Sphere Overlay"]="Interface\\Addons\\NPA2\\texture\\Sphere\\overlay",
		["NPA Thinking Cloud Left"]="Interface\\Addons\\NPA2\\texture\\ThinkingCloud\\left",
		["NPA Thinking Cloud Right"]="Interface\\Addons\\NPA2\\texture\\ThinkingCloud\\right",
		["NPA Thinking Cloud Center"]="Interface\\Addons\\NPA2\\texture\\ThinkingCloud\\center",
		["NPA White"]="Interface\\Addons\\NPA2\\texture\\Test2\\whitebar",
		["NPA Black"]="Interface\\Addons\\NPA2\\texture\\\Test2\\blackbar",
		["NPA Blend"]="Interface\\Addons\\NPA2\\texture\\\Test2\\blendbar",
		["NPA Rune"]="Interface\\Addons\\NPA2\\texture\\runes",
		["NPA Arrow"]="Interface\\Addons\\NPA2\\texture\\arrow",
		["NPA Animated Fire"]="Interface\\Addons\\NPA2\\texture\\animated\\fire@7@7@100",
		["NPA Animated Snow"]="Interface\\Addons\\NPA2\\texture\\animated\\snow@10@10@100",
		["NPA Animated Burning Star"]="Interface\\Addons\\NPA2\\texture\\animated\\star@11@11@50",
		["NPA Animated Star"]="Interface\\Addons\\NPA2\\texture\\animated\\star-white@11@11@50",
		["NPA Star"]="Interface\\Addons\\NPA2\\texture\\star-white",
		["NPA Burning Star"]="Interface\\Addons\\NPA2\\texture\\star",
		["Blizzard Icon Interrupt Shield"]="Interface\\Addons\\NPA2\\texture\\iconshield",
		["NPA Mono Arrow"]="Interface\\Addons\\NPA2\\texture\\mono\\arrow",
		["Blank"]="Interface\\Addons\\NPA2\\texture\\blank",
		["Blizzard Elite Icon"]="Interface\\Tooltips\\EliteNameplateIcon",
		["Blizzard Skull Icon"]="Interface\\TargetingFrame\\UI-TargetingFrame-Skull",
		["Blizzard Raid Icon"]="Interface\\TargetingFrame\\UI-RaidTargetingIcons",
		["Blizzard Class Icon"]="Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",
		["Blizzard Elite Icon"]="Interface\\Tooltips\\EliteNameplateIcon",
		["NPA Test1 Target"]="Interface\\Addons\\NPA2\\texture\\Test1\\target@4@4@15",
		["NPA Test1 Icon Background"]="Interface\\Addons\\NPA2\\texture\\Test1\\iconbg",
		["NPA Combat Icon"]="Interface\\Addons\\NPA2\\texture\\combaticon",
		["NPA Combat Icon Background"]="Interface\\Addons\\NPA2\\combaticonbg",
		["Blizzard Spark Icon"]="Interface\\CastingBar\\UI-CastingBar-Spark",
		["NPA Thinking Cloud Left"]="Interface\\Addons\\NPA2\\texture\\ThinkingCloud\\left",
		["NPA Thinking Cloud Right"]="Interface\\Addons\\NPA2\\texture\\ThinkingCloud\\right",
		["NPA Thinking Cloud Center"]="Interface\\Addons\\NPA2\\texture\\ThinkingCloud\\center",
		["Blizzard Role Icons"]="Interface\\LFGFrame\\UI-LFG-ICON-ROLES",
		["NPA QuestMark"]="Interface\\Addons\\NPA2\\texture\\questmark",
		["NPA ExclamationMark"]="Interface\\Addons\\NPA2\\texture\\test2\\exclamation",
	}
	--SharedMedia-3.0 support
	if(LibStub)then
		local sharemedia=LibStub:GetLibrary("LibSharedMedia-3.0",true)
		if(sharemedia)then
			--print("Including SharedMedia")
			for name,value in pairs(sharemedia.MediaTable.statusbar) do
				NPA_Options_TextureLib[name]=value
			end
			for name,value in pairs(sharemedia.MediaTable.background) do
				NPA_Options_TextureLib[name]=value
			end
			for name,value in pairs(sharemedia.MediaTable.border) do
				NPA_Options_TextureLib[name]=value
			end
		end
	elseif(CWDGMediaPack)then
		--print("Including CWDGMediaPack")
		for _, v in ipairs(CWDGMediaPack.registry) do
			local mediatype, key, data = unpack(v);
			if(mediatype=="statusbar" or mediatype=="background" or mediatype=="border")then
				NPA_Options_TextureLib[key]=data
			end
		end
	end
	--convert into new format
	local texturelib={}
	local i=0
	for name,value in pairs(NPA_Options_TextureLib)do
		i=i+1
		texturelib[i]={
			Text=name,
			Value=value,
			TextureFile=value
			}
	end
	return texturelib
end
