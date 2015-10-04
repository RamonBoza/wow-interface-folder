-- Author      : Nogarder
-- Create Date : 2012/12/17 10:15:59
local ValueList={}
NPA_Options.RegisterConditionValueList=function(name,valuelist)
	ValueList[name]=valuelist
end
NPA_Options.GetConditonValueList=function(name)
	return ValueList[name]
end