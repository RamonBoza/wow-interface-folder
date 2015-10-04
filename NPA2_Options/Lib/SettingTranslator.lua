-- Author      : Nogarder
-- Create Date : 2013/4/29 17:02:05
local next=next

NPA_Options.SettingTranslator={}
--
local function TableToString(data)
    if(type(data) == "table") then
        local out = "{"
        for key,value in pairs(data) do
	        out = out .."["..TableToString(key).."]="..TableToString(value) ..","
        end
        return out .. '}'
	elseif(type(data)=="string")then
		return '"'..tostring(data)..'"'
    elseif(type(data)=="number")then
        return tostring(data)
	elseif(type(data)=="boolean")then
		if(data==true)then
			return "true"
		else
			return "false"
		end
	else
		return tostring(data)
    end
end
--
NPA_Options.SettingTranslator.ExportProfile=function(profilename,entryname)
	local indexpart={string.split("\\",entryname)}
	local profile
	if(profilename=="TheCurrentProfile")then
		profile=CopyTable(NPA_Setting)
	else
		profile=CopyTable(NPA_Profile[profilename])
	end
	--check profile first
	NPA.SettingManager.CheckSettingEntry(profile)
	--
	local output=""
	local indexlength=table.getn(indexpart)
	for i=2,indexlength do
		output=output..(indexpart[i]).."\\"
		profile=profile[tonumber(indexpart[i])] or profile[indexpart[i]]
	end
	output=output.."#"
	output=output..TableToString(profile)
	--
	return output
end
--
NPA_Options.SettingTranslator.InportProfile=function(settingstring)
	local settinglist={string.split("@",settingstring)}
	local namelist={}
	local settings={}
	for i=2,table.getn(settinglist) do
		local setting={}
		settings[i-1]=setting
		local index,data=string.split("#",settinglist[i])
		local indexlist={string.split("\\",index)}
		local count=table.getn(indexlist)-1
		for i=1,count-1 do
			setting[indexlist[i]]={}
			setting=setting[indexlist[i]]
		end
		data=string.gsub(data,"\\","\\\\")
		setting[indexlist[count]]=loadstring("return "..data)()
		namelist[i-1]=index
	end
	return namelist,settings
end