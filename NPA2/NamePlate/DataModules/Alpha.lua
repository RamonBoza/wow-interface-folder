-- Author      : Nogarder
-- Create Date : 2013/4/12 11:43:41
local table_getn=table.getn
--
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements
local NPA_ConditionChecker_BuildConditionList=NPA.ConditionChecker.BuildConditionList
--
NPA.NamePlateModuleManager.RegisterDataModule("MainFrame","Alpha",function(framedata,modulemain,settings)
	local prioritylist={}
	--
	local EventRegister=function(event,func)
		NPA_NamePlateDataParser_AddElements(framedata,"Alpha",event,function(framedata,unitdata)--,isloopback)
			--if(isloopback)then
			--	return
			--end
			func(prioritylist,framedata,unitdata)
		end)
	end
	local count=table_getn(settings)
	--
	local UpdateFunc=function(_,prioritylist)
		for i=1,count do
			if(prioritylist[i])then
				if(prioritylist[i]==-1)then
					modulemain:SetAlpha(framedata.Parent:GetAlpha())
				else
					modulemain:SetAlpha(settings[i].Alpha)
				end
				return
			end
		end
		modulemain:SetAlpha(1)
	end
	----default
	for i=1,count do
		local setting=settings[i]
		if(setting.ConditionType=="Default")then
			--using default alpha
			NPA_NamePlateDataParser_AddElements(framedata,modulemain,"Alpha_Updated",function(framedata,unitdata)
				--prioritylist[i]=-1
				UpdateFunc(_,prioritylist)
			end)
			break
		end
	end
	--
	NPA_ConditionChecker_BuildConditionList(settings,EventRegister,UpdateFunc)
	--update once
	UpdateFunc(modulemain,prioritylist)
end)
