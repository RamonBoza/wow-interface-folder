-- Author      : Nogarder
-- Create Date : 2013/6/8 13:31:51
local table_getn=table.getn
--
local NPA_NamePlateDataParser_AddElements=NPA.NamePlateDataParser.AddElements
local NPA_ConditionChecker_BuildConditionList=NPA.ConditionChecker.BuildConditionList
--
NPA.NamePlateModuleManager.RegisterDataModule("MainFrame","Offset",function(framedata,modulemain,settings)
	local prioritylist={}
	--
	local EventRegister=function(event,func)
		NPA_NamePlateDataParser_AddElements(framedata,"Offset",event,function(framedata,unitdata)--,isloopback)
			--if(isloopback)then
			--	return
			--end
			func(prioritylist,framedata,unitdata)
		end)
	end
	local count=table_getn(settings)
	--
	local UpdateFunc=function(_,prioritylist)
		modulemain:ClearAllPoints()
		for i=1,count do
			if(prioritylist[i])then
				local anchor
				if(prioritylist[i]==-1)then
					anchor={
						From="CENTER",
						To="CENTER",
						OffsetX=0,
						OffsetY=0,
					}
				else
					anchor=settings[i].Offset			
				end
				modulemain:SetPoint(anchor.From,modulemain.Parent,anchor.To,anchor.OffsetX,anchor.OffsetY)
				return
			end
		end
		local anchor={
			From="CENTER",
			To="CENTER",
			OffsetX=0,
			OffsetY=0,
		}
		modulemain:SetPoint(anchor.From,modulemain.Parent,anchor.To,anchor.OffsetX,anchor.OffsetY)
	end
	
	NPA_ConditionChecker_BuildConditionList(settings,EventRegister,UpdateFunc)
	--update once
	UpdateFunc(modulemain,prioritylist)
end)
