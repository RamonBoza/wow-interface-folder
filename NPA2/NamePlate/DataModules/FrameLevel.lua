-- Author      : Nogarder
-- Create Date : 2013/6/9 21:55:30
local table_getn=table.getn
--
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements
local NPA_ConditionChecker_BuildConditionList=NPA.ConditionChecker.BuildConditionList
--
NPA.NamePlateModuleManager.RegisterDataModule("MainFrame","FrameLevel",function(framedata,modulemain,settings)
	local prioritylist={}
	--
	local EventRegister=function(event,func)
		NPA_NamePlateDataParser_AddElements(framedata,"FrameLevel",event,function(framedata,unitdata)--,isloopback)
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
					modulemain.RenderMain:SetFrameLevel(1)
				else
					modulemain.RenderMain:SetFrameLevel(settings[i].FrameLevel)
				end
				return
			end
		end
		modulemain.RenderMain:SetFrameLevel(1)
	end
	--	
	NPA_ConditionChecker_BuildConditionList(settings,EventRegister,UpdateFunc)
	--update once
	UpdateFunc(modulemain,prioritylist)
end)
