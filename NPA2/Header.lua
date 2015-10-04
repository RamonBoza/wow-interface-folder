-- Author      : Nogarder
-- Create Date : 2012/4/11 14:40:32
--core version number
NPA={}
--NPA core version
NPA.Version="2015.3.18"
--store interface version
local _,_,_,interfaceversion=GetBuildInfo()
NPA.InterfaceVersion=interfaceversion
interfaceversion=nil
--modules
NPA.NamePlateTemplate={}
NPA.NamePlateModules={}
--settingmanager
NPA.SettingManager={}
--
NPA.RunFunc=function(func,...)
	if(func)then
		func(...)
	end
end
--
NPA.GetTime=function()
	return floor(GetTime()*100)/100
end
--a really big number to mean the end of world
--this is used for aura that lasts forever (until cancelled)
NPA.Forever=1000000
NPA.EndTime=floor(GetTime()*100)/100+NPA.Forever

NPA.CompareTime=function(timea,timeb,range)
	return (timeb>(timea-range) and timeb<(timea+range))
end

--debug function
--NPA.DumpTable=function(data)
--	if(type(data)=="table")then
--		print("===========Dumping starts===========")
--		print("time:"..GetTime())
--		for name,value in pairs(data)do
--			print("name:")
--			print(name)
--			if(type(value)=="table")then
--				print("{")
--				for name2,value2 in pairs(value)do
--					print("name2:")
--					print(name2)
--					print("value2:")
--					print(value2)
--				end
--				print("}")
--			else
--				print("value:")
--				print(value)
--			end
--			print("--")
--		end
--		print("===========Dumping ends===========")
--	end
--end

--clear table
NPA.ClearTable=function(tab)
	if(type(tab)=="table")then
		for name,_ in pairs(tab)do
			tab[name]=nil
		end
	end
end