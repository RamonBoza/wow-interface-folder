-- Author      : Nogarder
-- Create Date : 2015/2/8 19:59:59
NPA_Options.RegisterPageFunc("AnimatedTextureGenerator",function()
	local pairs=pairs
	local CopyTable=CopyTable
	local table_getn=table.getn
	local table_insert=table.insert
	--
	local Localization=NPA_Options.Localization.TemplatesWindowTextureFileEditor
	local Tooltips=Localization.Tooltips
	--
	local Entry
	--
	local parent=NPA_Options.MainFrame
	--
	local main=NPA_Options.Template.CreateFrameWithBar(parent,Localization["TextureEdit"],680,445,nil,nil,nil)
	main:Hide()
	local title=main.Scroll.Title
	local page=main.Frame
	--
	--elements
	local step=-20
	--texture file
	local textureselector=NPA_Options.Template.CreateTextureFileSelectorButton(page,main,240,Localization["NameOrPath"],Tooltips["MustExistWhenLoad"])
	textureselector:SetPoint("TOPLEFT",page,"TOPLEFT",5,step)
	--font mode
	local modeselector=NPA_Options.Template.CreateDropDownEditor(page,120,Localization["BlendMode"],Tooltips["BlendMode"],NPA_Options.InfoLib.GetTextureMode)
	modeselector:SetPoint("TOPLEFT",textureselector,"BOTTOMLEFT",0,step)
	--time
	local timeslider=NPA_Options.Template.CreateSliderEdit(page,85,35,20,0,2,0.01,0,Localization["FrameTime"],Tooltips["FrameTime"])
	timeslider:SetPoint("LEFT",modeselector,"RIGHT",25,0)
	--left
	local leftslider=NPA_Options.Template.CreateSliderEdit(page,85,35,20,0,1,0.01,0,Localization["Left"],Tooltips["Left"])
	leftslider:SetPoint("TOPLEFT",modeselector,"BOTTOMLEFT",0,step)
	--right
	local rightslider=NPA_Options.Template.CreateSliderEdit(page,85,35,20,0,1,0.01,0,Localization["Right"],Tooltips["Right"])
	rightslider:SetPoint("LEFT",leftslider,"RIGHT",5,0)
	--top
	local topslider=NPA_Options.Template.CreateSliderEdit(page,85,35,20,0,1,0.01,0,Localization["Top"],Tooltips["Top"])
	topslider:SetPoint("TOPLEFT",leftslider,"BOTTOMLEFT",0,step)
	--bottom
	local bottomslider=NPA_Options.Template.CreateSliderEdit(page,85,35,20,0,1,0.01,0,Localization["Bottom"],Tooltips["Bottom"])
	bottomslider:SetPoint("LEFT",topslider,"RIGHT",5,0)
	--total frame
	local totalframeslider=NPA_Options.Template.CreateSliderEdit(page,85,35,20,0,10,1,0,Localization["FrameCount"],Tooltips["FrameCount"])
	totalframeslider:SetPoint("TOPLEFT",topslider,"BOTTOMLEFT",0,step)
	--perrow slider
	local perrowslider=NPA_Options.Template.CreateSliderEdit(page,85,35,20,1,8,1,1,Localization["PerRow"],Tooltips["PerRow"])
	perrowslider:SetPoint("LEFT",totalframeslider,"RIGHT",5,0)
	--direction dropdown
	local GetDirection=function()
		return Localization.DirectionList
	end
	local directionselector=NPA_Options.Template.CreateDropDownEditor(page,240,Localization["Direction"],Tooltips["Direction"],GetDirection)
	directionselector:SetPoint("TOPLEFT",totalframeslider,"BOTTOMLEFT",0,step)
	--angle
	local angleslider=NPA_Options.Template.CreateSliderEdit(page,85,35,20,0,359,1,0,Localization["Angle"],Tooltips["Angle"])
	angleslider:SetPoint("TOPLEFT",directionselector,"BOTTOMLEFT",0,step)
	--rotation slider
	local rotationslider=NPA_Options.Template.CreateSliderEdit(page,85,35,20,0,360,1,1,Localization["FrameRotation"],Tooltips["FrameRotation"])
	rotationslider:SetPoint("LEFT",angleslider,"RIGHT",5,0)
	--color
	local colorstartbutton=NPA_Options.Template.CreateColorButton(page,120,20,Localization["ColorStart"],main,Tooltips["ColorStart"])
	colorstartbutton:SetPoint("TOPLEFT",angleslider,"BOTTOMLEFT",0,step)
	--color
	local colorendbutton=NPA_Options.Template.CreateColorButton(page,120,20,Localization["ColorEnd"],main,Tooltips["ColorEnd"])
	colorendbutton:SetPoint("LEFT",colorstartbutton,"RIGHT",5,0)
	--width
	local widthslider=NPA_Options.Template.CreateSliderEdit(page,85,35,20,0,1,0.01,1,Localization["FrameWidth"],Tooltips["FrameWidth"])
	widthslider:SetPoint("TOPLEFT",colorstartbutton,"BOTTOMLEFT",0,step)
	--height
	local heightslider=NPA_Options.Template.CreateSliderEdit(page,85,35,20,0,1,0.01,1,Localization["FrameHeight"],Tooltips["FrameHeight"])
	heightslider:SetPoint("LEFT",widthslider,"RIGHT",5,0)
	--gap x
	local gapxslider=NPA_Options.Template.CreateSliderEdit(page,85,35,20,0,1,0.01,1,Localization["FrameGapX"],Tooltips["FrameGapX"])
	gapxslider:SetPoint("TOPLEFT",widthslider,"BOTTOMLEFT",0,step)
	--gap y
	local gapyslider=NPA_Options.Template.CreateSliderEdit(page,85,35,20,0,1,0.01,1,Localization["FrameGapY"],Tooltips["FrameGapY"])
	gapyslider:SetPoint("LEFT",gapxslider,"RIGHT",5,0)
	--insert at
	local insertslider=NPA_Options.Template.CreateSliderEdit(page,85,35,20,1,20,1,1,Localization["InsertAt"],Tooltips["InsertAt"])
	insertslider:SetPoint("TOPLEFT",gapxslider,"BOTTOMLEFT",0,step)
	--generate button
	local generatebutton=NPA_Options.Template.CreateButton(page,120,20,Localization["Generate"])
	generatebutton:SetPoint("LEFT",insertslider,"RIGHT",5,0)
	NPA_Options.Template.SetTooltips(Tooltips["Generate"],generatebutton)
	--preview
	local preview2=page:CreateTexture(nil,"OVERLAY")
	preview2:SetPoint("LEFT",timeslider,"RIGHT",5,0)
	preview2:SetPoint("TOP",page,"TOP",0,-5)
	preview2:SetPoint("BOTTOMRIGHT",page,"BOTTOMRIGHT",-5,5)

	local preview2bg=CreateFrame("Frame",nil,page)
	preview2bg:SetPoint("TOPLEFT",preview2,"TOPLEFT",-1,1)
	preview2bg:SetPoint("BOTTOMRIGHT",preview2,"BOTTOMRIGHT",1,-1)
	NPA_Options.Template.CreateLinerBorder(preview2bg)
	--function
	local NPA_IconGroupManager_DirectionList={
		[1]={ --grow right then up
			Anchor="BOTTOMLEFT",
			TAnchor="BOTTOMRIGHT",
			DirX=1,
			DirY=1,
		},
		[2]={ -- grow left then up
			Anchor="BOTTOMRIGHT",
			TAnchor="BOTTOMLEFT",
			DirX=-1,
			DirY=1,
		},
		[3]={ -- grow right then down
			Anchor="TOPLEFT",
			TAnchor="TOPRIGHT",
			DirX=1,
			DirY=-1,
		},
		[4]={ --grow left then down
			Anchor="TOPRIGHT",
			TAnchor="TOPLEFT",
			DirX=-1,
			DirY=-1,
		},
		[5]={ -- grow up then right
			Anchor="BOTTOMLEFT",
			TAnchor="TOPLEFT",
			DirX=1,
			DirY=1,
		},
		[6]={ --grow up then left
			Anchor="BOTTOMRIGHT",
			TAnchor="TOPRIGHT",
			DirX=-1,
			DirY=1,
		},
		[7]={ -- grow down then right
			Anchor="TOPLEFT",
			TAnchor="BOTTOMLEFT",
			DirX=1,
			DirY=-1,
		},
		[8]={ -- grow down then left
			Anchor="TOPRIGHT",
			TAnchor="BOTTOMRIGHT",
			DirX=-1,
			DirY=-1,
		},
	}

	local FrameList={}
	local CreateFrameTemp=function(index)
		local frame=CreateFrame("Frame",nil,page)
		NPA_Options.Template.CreateLinerBorder(frame,nil,0.3)
		frame.Texture=frame:CreateTexture()
		frame.Texture:SetPoint("TOPLEFT",frame,"TOPLEFT")
		frame.Texture:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT")
		--
		frame.Text=NPA_Options.Template.CreateText(frame,"|cff000000"..index,true)
		frame.Text:SetPoint("CENTER",frame,"CENTER")
		
		
		return frame
	end

	local scalex=preview2bg:GetWidth()
	local scaley=preview2bg:GetHeight()
	local RefreshFrame=function()
		NPA_Options.SetTexture(preview2,nil,textureselector.Value,modeselector.Value,{R=1,G=1,B=1,A=1},
			angleslider.Value,leftslider.Value,rightslider.Value,topslider.Value,bottomslider.Value)

		local width=widthslider.Value*scalex
		local height=heightslider.Value*scaley
		local perrow=perrowslider.Value
		local max=totalframeslider.Value
		local gapx=gapxslider.Value*scalex
		local gapy=gapyslider.Value*scaley

		local direction=directionselector.Value
		local directioninfo=NPA_IconGroupManager_DirectionList[direction]
		local anchor=directioninfo.Anchor
		local tanchor=directioninfo.TAnchor
		local dirx=directioninfo.DirX
		local diry=directioninfo.DirY

		local offsetx=0
		local offsety=0

		gapx=gapx*dirx
		gapy=gapy*diry

		local scale=page:GetEffectiveScale()
		local owidth=preview2:GetWidth()
		local oheight=preview2:GetHeight()
		local pleft=preview2:GetLeft()
		local ptop=preview2:GetTop()
		local rotation=rotationslider.Value

		local dleft=leftslider.Value
		local dtop=topslider.Value
		local dwidth=rightslider.Value-dleft
		local dheight=bottomslider.Value-dtop

		local rangle=angleslider.Value

		local data={
			Texture=textureselector.Value,
			Color={},
			Mode=modeselector.Value,
			Time=timeslider.Value,
		}

		local colorstart=colorstartbutton.Value
		local colorend=colorendbutton.Value
		local stepcolor=max-1
		local colorstepr=(colorend.R-colorstart.R)/stepcolor
		local colorstepg=(colorend.G-colorstart.G)/stepcolor
		local colorstepb=(colorend.B-colorstart.B)/stepcolor
		local colorstepa=(colorend.A-colorstart.A)/stepcolor

		if(direction<5)then
			--left /right then up /down
			for i=1,max do
				if(not FrameList[i])then
					FrameList[i]=CreateFrameTemp(i)
				end
				local frame=FrameList[i]
				frame:SetWidth(width)
				frame:SetHeight(height)
				--
				frame:ClearAllPoints()
				if(i~=1 and mod(i,perrow)==1)then --the first one of every row
					--caculate row width and height
					offsety=offsety+gapy
					offsetx=0
				elseif(i~=1)then
					offsetx=offsetx+gapx
				end
				frame:SetPoint(anchor,preview2,anchor,offsetx,offsety)
				frame:Show()
				
				local fleft=(frame:GetLeft()-pleft)/owidth*dwidth+dleft
				local fright=(frame:GetRight()-pleft)/owidth*dwidth+dleft
				local ftop=(ptop-frame:GetTop())/oheight*dheight+dtop
				local fbottom=(ptop-frame:GetBottom())/oheight*dheight+dtop

				data.Left=fleft
				data.Right=fright
				data.Top=ftop
				data.Bottom=fbottom
				local dindex=i-1
				data.RAngle=rangle+dindex*rotation
				data.Color.R=colorstart.R+colorstepr*dindex
				data.Color.G=colorstart.G+colorstepg*dindex
				data.Color.B=colorstart.B+colorstepb*dindex
				data.Color.A=colorstart.A+colorstepa*dindex

				NPA.TextureManager.SetTextureWithData(frame.Texture,data)
			end
		else
			--grow up/down then left/right
			for i=1,max do
				if(not FrameList[i])then
					FrameList[i]=CreateFrameTemp(i)
				end
				local frame=FrameList[i]
				frame:SetWidth(width)
				frame:SetHeight(height)
				--
				frame:ClearAllPoints()
				--clear points
				if(i~=1 and mod(i,perrow)==1)then --the first one of every row
					--caculate row width and height
					offsetx=offsetx+gapx
					offsety=0
				elseif(i~=1)then
					offsety=offsety+gapy
				end
				frame:SetPoint(anchor,preview2,anchor,offsetx,offsety)
				frame:Show()

				local fleft=(frame:GetLeft()-pleft)/owidth*dwidth+dleft
				local fright=(frame:GetRight()-pleft)/owidth*dwidth+dleft
				local ftop=(ptop-frame:GetTop())/oheight*dheight+dtop
				local fbottom=(ptop-frame:GetBottom())/oheight*dheight+dtop

				data.Left=fleft
				data.Right=fright
				data.Top=ftop
				data.Bottom=fbottom
				local dindex=i-1
				data.RAngle=rangle+dindex*rotation
				data.Color.R=colorstart.R+colorstepr*dindex
				data.Color.G=colorstart.G+colorstepg*dindex
				data.Color.B=colorstart.B+colorstepb*dindex
				data.Color.A=colorstart.A+colorstepa*dindex

				NPA.TextureManager.SetTextureWithData(frame.Texture,data)
			end
		end
		--hide unused
		for i=max+1,table_getn(FrameList)do
			if(FrameList[i])then
				FrameList[i]:Hide()
			end
		end
	end
	--
	local Seted
	local SetUp=function()
		if(Seted)then
			return
		end
		Seted=true
		--page
		entry=NPA.SettingManager.GetDefault("AnimatedTexture")
		--font
		local value=entry.Texture
		NPA_Options.Template.SetDropDownEditor(textureselector,value)
		--mode
		local value=entry.Mode
		NPA_Options.Template.SetDropDownEditor(modeselector,value)
		--angle
		local value=entry.RAngle
		NPA_Options.Template.SetSliderEdit(angleslider,value)
		--left
		local value=entry.Left
		NPA_Options.Template.SetSliderEdit(leftslider,value)
		--right
		local value=entry.Right
		NPA_Options.Template.SetSliderEdit(rightslider,value)
		--top
		local value=entry.Top
		NPA_Options.Template.SetSliderEdit(topslider,value)
		--bottom
		local value=entry.Bottom
		NPA_Options.Template.SetSliderEdit(bottomslider,value)
		--time
		local value=entry.Time
		NPA_Options.Template.SetSliderEdit(timeslider,value)
		--color
		NPA_Options.Template.SetColorButton(colorstartbutton,entry.Color)
		NPA_Options.Template.SetColorButton(colorendbutton,entry.Color)
		--then set up frame generator values
		--total frames
		NPA_Options.Template.SetSliderEdit(totalframeslider,8)
		--max per row
		NPA_Options.Template.SetSliderEdit(perrowslider,4)
		--direction
		NPA_Options.Template.SetDropDownEditor(directionselector,3)
		--rotation slider
		NPA_Options.Template.SetSliderEdit(rotationslider,0)
		--width
		NPA_Options.Template.SetSliderEdit(widthslider,0.25)
		--height
		NPA_Options.Template.SetSliderEdit(heightslider,0.25)
		--gap x
		NPA_Options.Template.SetSliderEdit(gapxslider,0.25)
		--gap y
		NPA_Options.Template.SetSliderEdit(gapyslider,0.25)
		--insert slider
		NPA_Options.Template.SetSliderEdit(insertslider,1)
	end
	--
	textureselector.OnValueUpdateFunc=RefreshFrame
	modeselector.OnValueUpdateFunc=RefreshFrame
	angleslider.OnValueUpdateFunc=RefreshFrame
	leftslider.OnValueUpdateFunc=RefreshFrame
	rightslider.OnValueUpdateFunc=RefreshFrame
	topslider.OnValueUpdateFunc=RefreshFrame
	bottomslider.OnValueUpdateFunc=RefreshFrame
	colorstartbutton.OnValueUpdateFunc=RefreshFrame
	colorendbutton.OnValueUpdateFunc=RefreshFrame
	--
	totalframeslider.OnValueUpdateFunc=RefreshFrame
	perrowslider.OnValueUpdateFunc=RefreshFrame
	directionselector.OnValueUpdateFunc=RefreshFrame
	rotationslider.OnValueUpdateFunc=RefreshFrame
	widthslider.OnValueUpdateFunc=RefreshFrame
	heightslider.OnValueUpdateFunc=RefreshFrame
	gapxslider.OnValueUpdateFunc=RefreshFrame
	gapyslider.OnValueUpdateFunc=RefreshFrame
	--
	local UpdateFunc
	local Entry
	generatebutton:HookScript("OnMouseUp",function()
		local insertpoint=insertslider.Value
		local entrymax=table_getn(Entry)
		if(entrymax<insertpoint)then
			insertpoint=entrymax+1
		end
		local data={
			Texture=textureselector.Value,
			Color={},
			Mode=modeselector.Value,
			Time=timeslider.Value,
		}
		--
		local max=totalframeslider.Value
		local scale=page:GetEffectiveScale()
		local width=preview2:GetWidth()
		local height=preview2:GetHeight()
		local pleft=preview2:GetLeft()
		local ptop=preview2:GetTop()
		local rotation=rotationslider.Value

		local dleft=leftslider.Value
		local dtop=topslider.Value
		local dwidth=rightslider.Value-dleft
		local dheight=bottomslider.Value-dtop

		local rangle=angleslider.Value
		--
		local colorstart=colorstartbutton.Value
		local colorend=colorendbutton.Value
		local stepcolor=max-1
		local colorstepr=(colorend.R-colorstart.R)/stepcolor
		local colorstepg=(colorend.G-colorstart.G)/stepcolor
		local colorstepb=(colorend.B-colorstart.B)/stepcolor
		local colorstepa=(colorend.A-colorstart.A)/stepcolor
		--
		for i=1,max do
			local frame=FrameList[i]
			--
			local fleft=(frame:GetLeft()-pleft)/width*dwidth+dleft
			local fright=(frame:GetRight()-pleft)/width*dwidth+dleft
			local ftop=(ptop-frame:GetTop())/height*dheight+dtop
			local fbottom=(ptop-frame:GetBottom())/height*dheight+dtop

			data.Left=fleft
			data.Right=fright
			data.Top=ftop
			data.Bottom=fbottom
			
			local dindex=i-1
			data.RAngle=rangle+dindex*rotation
			data.Color.R=colorstart.R+colorstepr*dindex
			data.Color.G=colorstart.G+colorstepg*dindex
			data.Color.B=colorstart.B+colorstepb*dindex
			data.Color.A=colorstart.A+colorstepa*dindex

			table_insert(Entry,insertpoint,CopyTable(data))
			insertpoint=insertpoint+1
		end

		--update it
		UpdateFunc()
	end)

	--
	main.OnSetFunc=function(entry,updatefunc)
		--
		Entry=entry
		UpdateFunc=updatefunc
		--
		SetUp()
		RefreshFrame()
	end
	--
	NPA_Options.RegisterPage("AnimatedTextureGenerator",main)

end)