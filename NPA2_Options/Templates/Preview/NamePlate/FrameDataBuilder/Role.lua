-- Author      : Nogarder
-- Create Date : 2013/12/11 19:48:47

NPA_Options.RegisterPageFunc("NamePlatePreviewFrameDataRole",function()

	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	local Tooltips=Localization.Tooltips
	--
	local FrameData
	local RefreshFunc
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["Role"],150,50,nil)
	main:SetPoint("CENTER",UIParent,"CENTER",0,0)
	main:Hide()
	--
	local page=main.Frame
	--
	--faction dropdown
	local GetRole=function()
		local role=NPA_Options.GetBasicTypeRole()
		local data={}
		for name,value in pairs(role)do
			table.insert(data,{
				Text=value,
				Value=name,
			})
		end
		return data
	end
	local classificationselector=NPA_Options.Template.CreateDropDownEditor(page,140,Localization["Role"],Tooltips["Role"],GetRole)
	classificationselector:SetPoint("TOPLEFT",page,"TOPLEFT",5,-25)
	classificationselector.OnValueUpdateFunc=function()
		FrameData.UnitData.Role=classificationselector.Value
		NPA.EventHandler.FireEvent(8,"Role_Updated",FrameData)
	end
	classificationselector.Revers=true
	--
	local OnLoad=function()
		NPA_Options.Template.SetDropDownEditor(classificationselector,FrameData.UnitData.Role)
	end
	--
	main.OnSetFunc=function(parentframe)
		FrameData=parentframe.FrameData
		OnLoad()
	end
	--
	NPA_Options.RegisterPage("NamePlatePreviewFrameDataRole",main)

end)