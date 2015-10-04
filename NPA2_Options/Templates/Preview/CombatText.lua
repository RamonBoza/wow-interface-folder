-- Author      : Nogarder
-- Create Date : 2013/4/25 13:07:18

-- Author      : Nogarder
-- Create Date : 2013/4/1 7:56:18
NPA_Options.RegisterPageFunc("CombatTextPreview",function()

	local pairs=pairs
	local CopyTable=CopyTable
	--
	local Localization=NPA_Options.Localization.TemplatesPreview
	--
	local Entry
	local TimeCap=1
	--
	local preview=NPA_Options.Template.CreateFrameWithBar(NPA_Options.MainFrame,Localization["Preview"],320,240,nil,true,true)
	preview:Hide()
	preview.LinkType="BOTTOMRIGHT"
	preview.DontHideOther=true
	--
	local title=preview.Scroll.Title
	title:ClearAllPoints()
	title:SetPoint("BOTTOMRIGHT",preview,"TOPRIGHT",-20,0)
	--
	local scroll=preview.Scroll
	--
	local page=preview.Frame
	page:SetWidth(640)
	page:SetHeight(480)
	--
	--NPA_Options.Template.CreateBackground(page,nil,0,0.8)
	--
	local scroll=preview.Scroll
	scroll.SliderX.Value=160
	scroll.SliderY.Value=120
	NPA_Options.Template.UpdateScrollFrame(page)
	
	--NPA.CombatTextManager.AddText=function(parent,icon,text,school,setting,animation)
	local previewsetting={
		IconSize=20,
		TextWidth=0,
		TextHeight=20,
		TextFileName="Default",
		--NumberType=1,
		DetailFileName="Default",
		DetailWidth=0,
		DetailHeight=20,
		BGWidth=5,
		BGHeight=5,
		BGFileName="Default",
		BGColor={R=1,G=1,B=1,A=1}
	}
	--
	local timer=0
	page:HookScript("OnUpdate",function(_,elapse)
		timer=timer+elapse
		if(timer>TimeCap)then
			timer=0
			--
			local icon="Interface\\Icons\\Trade_Engineering"
			--
			local text=floor(random()*100000000)
			local detail="(Detailed text)"
			--
			local school=math.pow(2,floor(random()*7))
			--set it
			NPA.CombatTextManager.AddText(page,icon,text,detail,school,previewsetting,Entry)
		end
	end)
	--
	preview.OnSetFunc=function(entry)
		Entry=entry
		--
		local timecap=0
		for i=1,table.getn(entry)do
			timecap=timecap+entry[i].Lasts
		end
		TimeCap=timecap
		timer=timecap
	end
	NPA_Options.RegisterPage("CombatTextPreview",preview)
end)