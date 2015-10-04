-- Author      : Nogarder
-- Create Date : 2013/6/8 13:31:46
local table_getn=table.getn
--
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements
local NPA_ConditionChecker_BuildConditionList=NPA.ConditionChecker.BuildConditionList
--
NPA.NamePlateModuleManager.RegisterDataModule("MainFrame","Scale",function(framedata,modulemain,settings)
	local prioritylist={}
	--
	local EventRegister=function(event,func)
		NPA_NamePlateDataParser_AddElements(framedata,"Scale",event,function(framedata,unitdata)--,isloopback)
			func(prioritylist,framedata,unitdata)--,isloopback)
		end)
	end
	local count=table_getn(settings)
	--
	local UpdateFunc=function(_,prioritylist)
		for i=1,count do
			if(prioritylist[i])then
				if(prioritylist[i]==-1)then
					modulemain:SetScale(1)
				else
					modulemain:SetScale(settings[i].Scale)
				end
				return
			end
		end
		modulemain:SetScale(1)
	end

	
	NPA_ConditionChecker_BuildConditionList(settings,EventRegister,UpdateFunc)
	--
	UpdateFunc(modulemain,prioritylist)
end)
