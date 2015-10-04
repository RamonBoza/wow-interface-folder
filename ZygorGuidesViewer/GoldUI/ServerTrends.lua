local name,ZGV=...

local ZGVG=ZGV.Gold

ZGVG.ServerTrends={}

local Trends=ZGVG.ServerTrends

Trends.dumps={}

tinsert(ZGV.startups,function(self)
	for i,dump in ipairs(Trends.dumps) do
		Trends:DoImport(dump)
	end
	Trends.dumps=nil
end)

function Trends:ImportQuick() --DEPRECATED.
	ZGV:ShowDump("","Paste server scan data into the box:\n(DEPRECATED. Will break with full dumps. Use the files, Luke!)")
	local but=ZGV.dumpFrameBasic.OKButton
	but.oldtext = but:GetText()
	but.oldclick = but:GetScript("OnClick")
	but:SetText("IMPORT")
	but:SetScript("OnClick",function(self)
		local text = ZGV.dumpFrameBasic.editBox:GetText()
		Trends:DoImport(text,"loud")

		ZGV.dumpFrameBasic:Hide()

		-- restore old functionality
		but:SetText(but.oldtext)
		but:SetScript("OnClick",but.oldclick)
		but.oldtext,but.oldclick = nil,nil
	end)
end

function Trends:ImportServerPrices(text)
	tinsert(Trends.dumps,text)
end

function Trends:DoImport(text,loud)
	local data
	local fun,err = loadstring("return "..text)

	ZGV:Print("Server Prices import starting...")

	if fun then
		data = fun()
	else
		if loud then ZGV:Print("Old-style import failed! "..err.." ... let's try new style.") end

		text = text .. "\n"

		local linecount=0

		data = {}

		local index=1
		while (index<#text) do
			local st,en,line=string.find(text,"(.-)\n",index)
			if not en then break end
			index = en + 1

			linecount=linecount+1
			if linecount>100000 then
				ZGV:Print("More than 100000 lines!?")
				break
			end

			--[[
			line = line:gsub("^[%s	]+","")
			line = line:gsub("[%s	]+$","")
			line = line:gsub("//.*$","")
			line = line:gsub("||","|")
			--]]

			if not data.items then
				local cmd,params = line:match("([^%s]*)=(.*)")
				if cmd then data[cmd]=params end
				if cmd=="columns" then
					local columnstxt = data.columns
					data.columns={}
					for s in string.gmatch(columnstxt,"[^,]+") do
						tinsert(data.columns,s)
					end
				end
				if data.items then data.items={} end  -- end of header, if this is seen.
			else
				-- header is over, yay or nay?
				if data.realm~=GetRealmName() then
					if loud then ZGV:Print("Wrong realm! This data is for the "..data.realm.." realm, you're on "..GetRealmName().."!") end
					return
				end

				local id
				local n=1
				local itemdata={}
				for i in string.gmatch(line,"%d+") do
					if not id then id=tonumber(i)
					else itemdata[data.columns[n]]=tonumber(i)  n=n+1  end
					if id==82800 -- pet cage
					then break end
				end
				if id and next(itemdata) then data.items[id]=itemdata end
			end
		end

	end

	-- realm and faction were checked before, if we're here, then they're fine.

	if type(data)~="table" then
		ZGV:Print("Import didn't produce a table: ".. data)
	elseif data.items then
		ZGV.Gold.servertrends = data
		ZGV:Print("Data imported, " .. floor((time() - data.date)/3600) .. " hours old.")
		ZGVG:Update()
	else
		ZGV:Print("Import just failed..? No items found...")
	end
end