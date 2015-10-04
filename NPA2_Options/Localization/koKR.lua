-- Author      : Nogarder
-- Create Date : 2012/12/9 5:48:03
NPA_Options.AviliableLocalization["한국어(koKR)"]={
	ID="koKR",
	Translator="Translator: nfrog (from Curse)",
}
if(NPA_Options.Locale=="koKR") then
	NPA_Options.Localization={
		---media lib---
		InfoLibAnchor={
			["AnchorList"]={
				["상단"]="TOP",
				["오른쪽 상단"]="TOPRIGHT",
				["왼쪽 상단"]="TOPLEFT",
				["중앙"]="CENTER",
				["오른쪽"]="RIGHT",
				["왼쪽"]="LEFT",
				["하단"]="BOTTOM",
				["오른쪽 하단"]="BOTTOMRIGHT",
				["왼쪽 하단"]="BOTTOMLEFT"
			},
			["MainFrame"]="메인 프레임",
			Tooltips={
				["MainFrame"]="모든 모듈의 모체가 되는 프레임, 항상 표시됨"
			},
		},
		--
		InfoLibBasicType={
			Threat={
				[0]="낮은 위협수준",
				[1]="높은 위협수준",
				[2]="위협수준 사라짐",
				[3]="탱킹중",
				[4]="위협수준 없음",
			},
			Faction={
				[1]="우호적",
				[2]="중립적",
				[3]="적대적",
			},
			Class={
				["HUNTER"]="사냥꾼",
				["WARRIOR"]="전사",
				["PALADIN"]="성기사",
				["MAGE"]="마법사",
				["PRIEST"]="사제",
				["WARLOCK"]="흑마법사",
				["DEATHKNIGHT"]="죽음의기사",
				["DRUID"]="드루이드",
				["SHAMAN"]="주술사",
				["ROGUE"]="도적",
				["MONK"]="수도사",
			},
			Role={
				["TANK"]="방어 전담",
				["DAMAGER"]="공격 전담",
				["HEALER"]="치유 전담",
				["NONE"]="없음",
			},
			Type={
				[1]="플레이어",
				[2]="토템",
				[3]="Creature",
				[4]="상인",
			},
			RaidTarget={	
				[1]="Raid target 1: YellowStar",
				[2]="Raid target 2: OrangeCircle",
				[3]="Raid target 3: PurpleDiamond",
				[4]="Raid target 4: GreenTriangle",
				[5]="Raid target 5: SilverMoon",
				[6]="Raid target 6: BlueSquare",
				[7]="Raid target 7: RedCross",
				[8]="Raid target 8: WhiteSkull",
			},
			Power={
				[0]="마나",
				[1]="분노",
				[2]="집중",
				[3]="기력",
				[6]="룬마력",
			}
		},
		--
		InfoLibColorMode={
			["ColorModeList"]={
				[1]="진영에 따라",
				[2]="직업에 따라",
				[3]="위협수준에 따라",
				[4]="기본값",
				[5]="계열에 따라",
				[6]="비율에 따라",
				[7]="버프/디버프 유형에 따라",
				[8]="레벨차이에 따라",
				[9]="자원 종류에 따라",
			},
			["ByFrameSetting"]={
				["BarGroup"]="바 그룹 설정에 따라",
				["Text"]="글꼴 설정에 따라",
				["Number"]="숫자 설정에 따라",
			},
		},
		--
		InfoLibDataType={
			["Name"]="이름",
			["Level"]="레벨",
			["Health"]="체력",
			["Class"]="직업",
			["Casting"]="주문시전중",
			["CastingShield"]="주문시전중-차단불가",
			["None"]="없음(항상 표시)",
			["Aura"]="버프/디버프",
			["Target"]="대상",
			["Focus"]="주시대상",
			["Mouseover"]="마우스오버대상",
			["Threat_High"]="위협수준:높음",
			["Threat_None"]="위협수준:없음",
			["Threat_Low"]="위협수준:낮음",
			["Threat_Tanking"]="위협수준:탱킹",
			["Threat_Losing"]="위협수준:사라짐",
			["SpellLock"]="계열 차단",
			["Summoned"]="소환수",
			["UnitID"]="개체ID",
			["Unit"]="개체",
			["GUID"]="GUID",
			["RaidTarget"]="전술목표",
			["Classification_Elite"]="정예",
			["Classification_WorldBoss"]="우두머리",
			["Quest"]="퀘스트",
			["CoolDown"]="재사용대기시간",
			["CrowdControl"]="군중제어",
			["CC_DR"]="군중제어 점감",
			["Power"]="자원",
			["ComboPoints"]="연계점수",
			["Speed"]="속도",
			["Tapped"]="선점됨",
			["FullName"]="전체 이름(칭호 포함)",
			["Guild"]="길드",
			["NPCGuild"]="NPC 길드",
			["Server"]="플레이어 서버명",
			["Role"]="플레이어 역할",
			["BaseEvent"]="Frame based Events",
		},
		--
		InfoLibFont={
			["시스템:개체"] = UNIT_NAME_FONT,
			["시스템:데미지"] = DAMAGE_TEXT_FONT,
			["시스템:대화"] = ChatFontNormal:GetFont(),
			["시스템:기본"] = NAMEPLATE_FONT,
		},
		InfoLibFontMode={
			["없음"]="",
			["외곽선"]="OUTLINE",
			["두껍게"]="THICKOUTLINE",
			--["단색 (※경고:선택시 와우강제종료-bug)"]="MONOCHROME",	-- if selected this in koKR client, wow crash down. --also crash in other language, must be Blizzard's fault
			["외곽선+두껍게"]="OUTLINE,THICKOUTLINE",
			["외곽선+단색"]="OUTLINE,MONOCHROME",
			["두껍게+단색"]="THICKOUTLINE,MONOCHROME",
			["외곽선+두껍게+단색"]="OUTLINE,THICKOUTLINE,MONOCHROME",
		},
		InfoLibLayer={
			["0:BACKGROUND"]="BACKGROUND",
			["1:BORDER"]="BORDER",
			["2:ARTWORK"]="ARTWORK",
			["3:OVERLAY"]="OVERLAY",
		},
		InfoLibModule={
			["Default"]="기본값",
			["Text"]="글자",
			["BarGroup"]="바 그룹",
			["IconGroup"]="아이콘 그룹",
			["TextureGroup"]="텍스처 그룹",
			["Number"]="숫자",
			["Icon"]="아이콘",
			["Alpha"]="투명도",
			["Scale"]="크기",
			["Offset"]="위치",
			["FrameLevel"]="프레임 레벨",
			Tooltips={
				["Default"]="블리자드 기본 이름표 항목",
				["Text"]="글자 항목 (이름, 주문명, 레벨, 시전시간 등)",
				["BarGroup"]="바 항목(시전바, 체력바, 마나바 등)",
				["IconGroup"]="아이콘 그룹 항목(버프, 디버프, 군중제어 타이머 등)",
				["TextureGroup"]="텍스처 그룹 항목(배경, 외곽선, overlay 등)",
				["Number"]="숫자표기 항목(체력 수치, 마나수치, 위협수준 등)",
				["Icon"]="단일 아이콘(시전 아이콘, 직업아이콘, 토템 아이콘 등)",
				["Alpha"]="이름표 전체의 투명도(블리자드 기본이름표에는 영향을 주지 않습니다)",
				["Scale"]="이름표 전체의 크기(블리자드 기본이름표에는 영향을 주지 않습니다)",
				["Offset"]="이름표 전체의 위치 (블리자드 기본이름표에는 영향을 주지 않습니다)",
				["FrameLevel"]="이름표 메인프레임의 레벨, 어떻게 이름표를 겹치게할지에 영향을 미치며, 이는 'Core' 페이지에서 'ScrollFrame Rendering'이 켜져있을 때 작동합니다.",
			},
			MainModule={
				Text="메인프레임",
				Value="MainFrame",
				Tooltips="모든 모듈의 모체가 되는 프레임, 항상 표시됨"
			}
		},
		--
		InfoLibSpell={
			School={
				[1]="물리",
				[2]="신성",
				[4]="화염",
				[8]="자연",
				[16]="냉기",
				[32]="암흑",
				[64]="비전",
			},
			Class={
				["None"]="없음(물리)",
				["Bleed"]="출혈",
				["Enrage"]="격노류",
				["Magic"]="마법",
				["Poison"]="독",
				["Curse"]="저주",
				["Disease"]="질병",
			},
			Catalog={
				["Unsorted"]="미분류",
				["NPC"]="NPC",
				["Player common"]="Player common",
				["Boss"]="우두머리",
				["Warrior"]="전사",
				["Mage"]="마법사",
				["Warlock"]="흑마법사",
				["Hunter"]="사냥꾼",
				["Shaman"]="주술사",
				["Druid"]="드루이드",
				["Paladin"]="성기사",
				["Priest"]="사제",
				["Monk"]="수도사",
				["DeathKnight"]="죽음의기사",
				["Rogue"]="도적",
			},
			DrType={
				["None"]="없음",
				["Roots"]="이동불가",
				["Roots(short)"]="이동불가(짧음)",
				["Stuns"]="기절",
				["Stuns(short)"]="기절(짧음)",
				["Mesmerizes"]="행동불가",
				["Mesmerizes(short)"]="행동불가(짧음)",
				["Fears"]="공포",
				["Horrors"]="극심한 공포",
				["Silences"]="침묵",
				["Disarms"]="무장 해제",
				["Knockbacks"]="밀치기",
				["Cyclone"]="회오리(드루이드)",
				["Charm"]="정신 지배(사제)",
				["CounterSpell"]="CounterSpell",
				["Polymorph"]="Polymorph",
			},
			CDType={
				[1]={
					Text="사용후 재사용대기시간",
					Value=0,
					Tooltips="주문을 사용한 즉시 재사용대기시간이 시작됩니다",
				},
				[2]={
					Text="효과 소멸후 재사용대기시간",
					Value=1,
					Tooltips="주문의 효과가 사라진 이후에 재사용대기시간이 시작됩니다",
				}
			},
			AffectType={
				[1]={
					Text="재사용대기시간 감소",
					Value=0,
					Tooltips="주 스킬을 시전하면 이 주문의 재사용대기시간이 일정량 감소합니다",
				},
				[2]={
					Text="재사용대기시간 증가",
					Value=1,
					Tooltips="주 스킬을 시전하면 이 주문의 재사용대기시간이 일정량 증가합니다",
				},
				[3]={
					Text="Suppress showing",
					Value=4,
					Tooltips="When showing the main spell, don't show suppressed spell",
				},
				[4]={
					Text="Related showing",
					Value=5,
					Tooltips=" Show the main spell only when all related spells is also showing",
				},
			},
		},
		--
		InfoLibTextureMode={
			["사용하지 않음"]="DISABLE",
			["BLEND"]="BLEND",
			["ALPHAKEY"]="ALPHAKEY",
			["ADD"]="ADD",
			["MOD"]="MOD"
		},
		InfoLibUnit={
			[COMBATLOG_OBJECT_TYPE_OBJECT]="사물",
			[COMBATLOG_OBJECT_TYPE_GUARDIAN]="소환물",
			[COMBATLOG_OBJECT_TYPE_PET]="소환수",
			[COMBATLOG_OBJECT_TYPE_NPC]="NPC",
			[COMBATLOG_OBJECT_TYPE_PLAYER]="플레이어",
		},
		---Templates---
		TemplatesElementsScrollFrame={
			["DragThisToScroll"]="드래그하면 창을 이동합니다.",
		},
		TemplatesFramesButton={
			["Save"]="저장",
			["Cancel"]="취소",
			["Reset"]="초기화",
			--
			["AnchorList"]="위치의 기준점",
			["Texture"]="텍스처",
			["Icon"]="아이콘",
			["Font"]="글꼴",
			--
			["Edit"]="편집",
			--
			["Change"]="변경",
			["Add"]="추가",
			["Remove"]="제거",
			--
			["EditAnchor"]="위치의 기준점 편집",
			--
			["Number"]="숫자",
			["BarGroup"]="바 그룹",	
			["CountDown"]="재사용대기시간",
			--
			["LookUp"]="추가+",
			--
			["Test"]="테스트",
			--
			["Profile"]=" 프로필",
			TipText={
				["Save"]="변경사항이 저장되었습니다.",
				["Cancel"]="변경이 취소되었습니다",
				["Reset"]="페이지가 초기화되었습니다",
			},
			Tooltips={
				["Save"]="현재 페이지의 변경내용을 저장합니다",
				["Cancel"]="현재 페이지의 변경내용을 취소합니다",
				["Reset"]="이 페이지를 기본 설정으로 초기화합니다",
				--
				["Edit"]="선택한 설정을 편집합니다. 이 설정을 사용하는 모든 모듈에 변경사항이 적용됩니다.",
				--
				["Add"]="저장된 주문목록에서 주문을 추가합니다",
				["Remove"]="목록에서 선택되지 않은 항목을 제거합니다",
				--
				["AnchorList"]="Set the mainframe anchors of this module; Can set different position based on whether other modules are shown",
				["Texture"]="텍스처 꾸미기",
				--
				["LookUp"]="조회 결과에서 추가",
			}
		},
		--
		TemplatesFramesCheckBox={
			["Enable"]="Enable",
			Tooltips={
				["Enable"]="Enable this module in current profile",
			},
			TipText={
				["Enable"]={
					Checked="Enabled",
					UnChecked="Disabled",
				},
			}
		},
		--
		TemplatesFramesCloser={
			["ClickThisToClose"] = "클릭하면 창을 닫습니다."
		},
		TemplatesFramesDragger={
			["DragThis"] = "드래그하면 이동합니다."
		},
		--
		TemplatesPreview={
			["Preview"]="미리보기",
			["Profile"]="프로필",
			--
			["Percent"]="백분률",
			["Name"]="이름",
			["Level"]="레벨",
			["Health"]="현재 체력",
			["HealthMax"]="체력 최대값",
			["FrameDataBuilder"]="프레임 데이터 생성기",
			["Type"]="버프/디버프 속성",
			["School"]="주문의 마법계열",
			--
			["Casting"]="주문시전",
			["Aura"]="버프/디버프",
			["Target"]="대상",
			["Quest"]="퀘스트",
			["SpellLock"]="계열 차단",
			["Summoned"]="Summoned",
			["RaidTarget"]="전술목표",
			["CoolDown"]="재사용대기시간",
			["CC_DR"]="군중제어 점감",
			["Guild"]="길드",
			--
			Tooltips={
				["Type"]="진영, 직업, 위협 포함",
				["Aura"]="버프와 디버프 포함",
				["Target"]="Set target to self (lasts 60s)",
				["School"]="주문의 마법계열",
				["CC_DR"]="군중제어 점감",
			},
			--casting
			["Casting"]="주문시전",
			["CastingMax"]="시전 시간",
			["Set"]="설정",
			["Channeling"]="정신 집중",
			["NotInterruptable"]="차단 불가",
			--name
			["Change"]="변경",
			["InputANewName"]="새로운 이름을 입력하세요",
			--type
			["Type"]="유형",
			["Faction"]="진영",
			["Class"]="직업",
			["Threat"]="위협수준 상태",
			--value
			["Value"]="값",
			["Max"]="최대값",
			--aura
			["SpellId"]="주문ID",
			["TimeLength"]="지속 시간",
			["StackCount"]="중첩",
			["Sort"]="종류",
			["Add"]="추가",
			["SortTable"]={
				[1]={
					Text="디버프",
					Value="DEBUFF",
				},
				[2]={
					Text="버프",
					Value="BUFF",
				},
			},
			--cc_dr
			["DRType"]="점감 유형",
			--classification
			["Classification"]="정예",
			["ClassificationList"]={
				[1]={
					Text="일반몹",
					Value="normal",
				},
				[2]={
					Text="우두머리",
					Value="worldboss",
				},
				[3]={
					Text="정예",
					Value="elite",
				},
			},
			--role
			["Role"]="플레이어 역할",
			["NONE"]="없음"
		},
		------------
		TemplatesWidgetsMsgBox={
			["Yes"]="예",
			["No"]="아니오",
		},
		------------
		TemplatesWidgetsAnchorPreview={
			["Scaling"]="비율:",
		},
		TemplatesWidgetsDropDownEditor={
			["DataType"]="데이터 유형",
			["ColorMode"]="채색 방법",
			["InputValue"]="여기 값을 설정하세요",
			["ClickForMenu"]="메뉴를 열거나 닫으려면 클릭하세요",
			["AnchorFrame"]="위치의 기준점이 될 프레임",
			Tooltips={
				["DataType"]={
					["Text"]="문자열로 보여줄 데이터(예. 이름, 직업)",
					["BarGroup"]="현재의 바 그룹에서 표시할 데이터(체력, 주문시전 등)",
					["Icon"]="아이콘으로 보여줄 데이터(예. 직업, 토템)",
				},
				["AnchorFrame"]="The frame to which this frame anchors",
			}
		},
		--
		TemplatesWidgetsFrameWithBar={
			["DragToMove"]="드래그로 이동",
			["DragToScale"]="드래그하면 창의 크기를 변경합니다.",
			["ClickThisToReset"] = "클릭하면 초기화합니다.",
			["ClickToMinimize"]="클릭하면 창을 최소화하거나 복원합니다.",
		},
		TemplatesWidgetsInputBox={
			["EscToCancel"]="엔터를 누르면 확인 ; 취소하려면 ESC",
			["+"]="Extra options"
		},
		-----------
		TemplatesWidgetsListEditor={
			["InputNewName"]="새로운 이름을 입력하세요",
			--for dropdown menu
			["Create"]="새로 만들기",
			["Created"]="생성됨",
			["Copied"]="를 다음과 같이 복사했습니다 :",
			["sCopy"]="의 사본",
			["Copy"]="복사",
			["Delete"]="삭제",
			["Deleted"]="삭제됨",
			["Rename"]="이름 바꾸기",
			["RenamedTo"]="이름이 변경되었습니다 : ",
			Tooltips={
				["SelectSetting"]="편집하려면 선택 ; 오른쪽 마우스는 메뉴",
				--for dropdown menu
				["Create"]="새로운 설정 만들기",
				["Copy"]="이와 동일한 설정 만들기",
				["Delete"]="이 설정을 삭제",
				["Rename"]="이 설정의 이름을 변경",
				["CantDeleteDefault"]="기본설정은 삭제할 수 없습니다",
				["CantRenameDefault"]="기본 설정의 이름은 변경할 수 없습니다",
			}
		},
		-----------
		TemplatesWidgetsPriorityEdit={
			["Create"]="새로 만들기",
			["Created"]="조건이 생성되었습니다.",
			["Copied"]="복사됨",
			["Copy"]="복사",
			["Delete"]="삭제",
			["Deleted"]="삭제됨",
			["MoveUp"]="위로 이동",
			["MoveDown"]="아래로 이동",
			Tooltips={
				["Priority"]="위쪽에 있을수록 우선순위가 높습니다 ; 드래그로 위치를 변경하세요 ; 오른쪽마우스는 메뉴",
				--
				["Create"]="새로운 조건 만듭니다",
				["Copy"]="이와 동일한 내용으로 조건을 만듭니다",
				["Delete"]="현재 조건을 삭제합니다",
				["CantDelete"]="적어도 한개의 조건은 있어야 합니다",
				["MoveUp"]="이 조건을 한단계 위로 이동합니다",
				["MoveDown"]="이 조건을 한단계 아래로 이동합니다",
			}
		},
		----------------------
		TemplatesWidgetsSliderEdit={
			["Width"]="넓이",
			["Height"]="높이",
			["Layer"]="계층",
			["Alpha"]="투명도",
			["Scale"]="크기",
			Tooltips={
				["Layer"]="현재 모듈이 포함된 계층; 상위 계층은 하위 계층을 덮어씌웁니다",			
			},
		},
		----------------------
		TemplatesWindowAnchorEditor={
			["AnchorEdit"]="위치의 기준점 편집",
			--
			["SelfAnchor"]="기준점으로 삼을 위치",
			["ToAnchor"]="기준점을 프레임의 ~에 기준점을 위치함",
			--
			["OffsetX"]="가로위치 X",
			["OffsetY"]="세로위치 Y",
			Tooltips={
				["SelfAnchor"]="위치 변경을 위해 기준점으로 사용할 곳",
				["ToAnchor"]="위치 변경을 위해 기준점을 위치시킬 대상이 되는 좌표",
				--
				["OffsetX"]="X축 거리",
				["OffsetY"]="Y축 거리",
			}
		},
		----------------------
		TemplatesWindowBarEditor={
			["BarEdit"]="바 편집",
			--
			["Width"]="넓이",
			["Height"]="높이",
			--
			["Layer"]="레이어",
			--
			["ColorMode"]="색 변경 방법",
			["ByPercent"]="백분률에 따라",
			["ByTextureSetting"]="텍스처 설정에 따라",
			["MinColor"]="최소값 색",
			["MaxColor"]="최대값 색",
			--
			["EditAnchor"]="위치의 기준점 편집",
			--
			["Percent"]="백분률",
			["PercentFrom"]="시작 백분률",
			["PercentTo"]="종료 백분률",
			--
			["Direction"]="방향",
			--
			["HideWhenMax"]="최대값일 때 숨기기",
			["EnableSizeChange"]="크기 변경",
			["EnableTextureChange"]="텍스처 변경",
			Tooltips={
				["Width"]="바 넓이",
				["Height"]="바 높이",
				--
				["Layer"]="해당 레이어의 위치, 상위 레이어는 하위 레이어를 덮어씌웁니다",
				--
				["MinColor"]="백분률이 최소값일 때 색; 백분율에 따른 색상을 적용할 때, 이 값을 이용해 색상을 계산합니다.",
				["MaxColor"]="백분률이 최대값일 때 색; 백분율에 따른 색상을 적용할 때, 이 값을 이용해 색상을 계산합니다.",
				--
				["PercentFrom"]="설정한 백분률 수치가 되면 바를 표시합니다.",				
				["PercentTo"]="설정한 백분율 수치가 되면, 바의 값은 최대치가 됩니다.",						
				--
				["Direction"]="The direction of bar indentation (by degree), set to 360 for no indentation",
				--
				["EnableSizeChange"]="백분률에 따라 바의 크기를 변경합니다",
				["EnableTextureChange"]="백분률에 따라 텍스처를 변경합니다",
				["HideWhenMax"]="최대값이 되면 바를 숨깁니다.",
			}
		},
		----------------------
		TemplatesWindowBarGroupEditor={
			["SelectBar"]="상태바를 선택하세요",
			Tooltips={
				["SelectBar"]="상태바를 선택하면 편집; 메뉴는 오른쪽 마우스",
			}
		},
		----------------------
		TemplatesWindowColorPicker={
			["ColorPicker"]="색",
			["ColorR"]="빨강(R)",
			["ColorG"]="녹색(G)",
			["ColorB"]="파랑(B)",
			["ColorA"]="투명도(A)",
			["Done"]="완료",
			["Reset"]="초기화",
			["UseBlizzard"]="블리자드 프레임 사용",
			Tooltips={
				["ColorR"]="빨강(Red) 색상값",
				["ColorG"]="녹색(Green) 색상값",
				["ColorB"]="파랑(Blue) 색상값",
				["ColorA"]="투명도(Alpha) 색상값",
				["Done"]="현재 설정 확인",
				["Reset"]="현재 페이지 초기화",
				["UseBlizzard"]="블리자드 색지정 툴을 사용합니다",
			}
		},
		----------------------
		TemplatesWindowCountDownEditor={
			Tooltips={}
		},
		----------------------
		TemplatesWindowFontEditor={
			["FontEdit"]="글꼴 프로필:  ",
			--
			["NameOrPath"]="글꼴 이름 또는 파일 경로",
			["RenderMode"]="꾸밈 방식",
			["ShadowOffsetX"]="그림자 가로위치 X",
			["ShadowOffsetY"]="그림자 가로위치 Y",
			["Color"]="색",
			--
			["PreviewText"]="테스트 문자열 가나다",
			Tooltips={
				["MustExistWhenLoad"]="게임을 시작할 때 해당 파일이 존재해야 합니다",
				["RenderMode"]="글꼴에 사용할 효과",
				["ShadowOffsetX"]="글꼴 그림자의 X축 거리",
				["ShadowOffsetY"]="글꼴 그림자의 Y축 거리",
				--
				["Color"]="글꼴의 기본 색",
			}
		},
		----------------------
		TemplatesWindowNumberEditor={
			["Number edit"]="숫자 편집",
			--
			["Value"]="현재값",
			["Short"]="짧게",
			["Break"]="자릿수",
			["Max"]="최대값",
			["Percent"]="백분률 수치",
			["Brackets"]="괄호",
			["PercentMark"]="기호",
			["Edit"]="편집-",
			["Font"]=" 글꼴",
			["DontShow"]="표시하지 않음",
			["ByPercent"]="비율에 따라",
			["MinColor"]="최소값의 색",
			["MaxColor"]="최대값의 색",
			--
			["PreviewValue"]="미리보기 현재값",
			["PreviewMax"]="미리보기 최대값",
			Tooltips={
				["MinColor"]="백분율이 최소일 때 색 ; 이 값을 기준으로 체력에 따라 색상이 변합니다",
				["MaxColor"]="백분율이 최대일 때 색 ; 이 값을 기준으로 체력에 따라 색상이 변합니다",
			}
		},
		----------------------
		TemplatesWindowNumberTextEditor={
			["TextEdit"]="글자 편집",
			--
			["ColorMode"]="채색 방법",
			["ByFontSetting"]="글꼴 설정에 따라",
			["Custom"]="사용자",
			--
			["CustomColor"]="사용자 색",
			--
			["Size"]="크기",
			--
			["Layer"]="레이어",
			--
			["Width"]="넓이",
			--
			["Decimal"]="소수점 표시하지 않음",
			--
			["EditAnchor"]="위치의 기준점와 오프셋을 변경합니다",
			["TestText"]="1234567890",
			Tooltips={
				["CustomColor"]="사용자 색 설정",
				--
				["Size"]="표시된 글자 크기",
				--
				["Layer"]="현재의 레이어, 상위 레이어는 하위레이어에 겹쳐집니다",
				--
				["Width"]="글자 넓이, 0이면 자동설정",
			}
		},
		----------------------
		TemplatesWindowSpellEditor={
			["SpellId"]="주문ID",
			["SpellName"]="주문 이름",
			["SpellSchool"]="주문의 마법계열",
			["SpellIcon"]="주문 아이콘",
			["SpellClass"]="주문 분류(해제와 연관됨)",
			--
			["CastTime"]="시전 시간 (단위: 초)",
			["MinRange"]="최소 거리 (단위: 미터)",
			["MaxRange"]="최대 거리 (단위: 미터)",
			["CoolDown"]="재사용대기시간 (단위: 초)",
			["CoolDownStack"]="재사용대기 중첩",
			["Length"]="길이 (단위: 초)",
			["MaxStack"]="최대 중첩",
			["Catalog"]="목록",
			["CounterSpellLength"]="계열차단 시간(단위: 초)",
			["PVPLength"]="PvP시 길이(단위: 초)",
			["PVPDRType"]="PvP 점감 유형",
			["NoDR"]="점감 없음",
			--
			["CoolDownType"]="재사용대기 유형",
			["AffectSpellList"]="영향을 미치는 주문 목록",
			--
			["AffectType"]="영향 유형",
			["AffectAmount"]="영향 수치",
			["SpellAlreadyExists"]="주문이 이미 존재합니다., 현재 유형으로 이동합니다",
			Tooltips={
				["CastTime"]="주문을 시전하는데 걸리는 시간",
				["MinRange"]="최소 유효시전 거리",
				["MaxRange"]="최대 유효시전 거리",
				["CoolDown"]="재사용대기시간",
				["CoolDownStack"]="'중첩 재사용대기사간'을 가진 새로운 주문, 0이면 일반 주문",
				["Length"]="지속 시간",
				["MaxStack"]="버프/디버프의 최대 중첩",
				["Catalog"]="해당 주문이 라이브러리 편집기의 항목분류에 영향을 미칩니다. 변경사항이 해당 목록을 즉시 갱신하지는 않습니다",
				["CounterSpellLength"]="이것은 계열차단에만 영향을 미칩니다. 0으로 설정하면 일반주문",
				["PVPLength"]="PvP에서 지속 시간, 단위 초",
				["PVPDRType"]="PvP에서 점감 유형, 점감 시간 중 동일 유형 효과 감소, '없음'이면 점감 없음",				
				["NoDR"]="이 주문은 점감을 발생시키지 않습니다.(예. 감속)",
				--
				["CoolDownType"]="주문의 재사용대기시간이 시작되는 때를 지정",
				["AffectSpellList"]="해당 주문이 다른 주문에 어떻게 영향을 미치는지 지정",
				--
				["AffectType"]="영향을 주는 방법",
				["AffectAmount"]="현재 주문이 영향을 주는 양; 0이면 모두",
			}
		},
		----------------------
		TemplatesWindowSpellLookUp={
			["LookFor"]="검색어",
			["ById"]="ID순",
			["ByName"]="이름순",
			["Change"]="변경"
		},
		----------------------
		TemplatesWindowTextureEditor={
			["TextureEdit"]="텍스처 편집",
			--
			["Width"]="넓이",
			["Height"]="높이",
			--
			["Layer"]="레이어",
			--
			["EditAnchor"]="위치의 기준점 편집",
			Tooltips={
				["Width"]="텍스처 넓이",
				["Height"]="텍스처 높이",
				--
				["Layer"]="이 레이어 계층, 상위 계층은 하위 계층을 덮어씌웁니다",
			}
		},
		----------------------
		TemplatesWindowTextureFileEditor={
			["TextureEdit"]="텍스처 프로필:  ",
			--
			["NameOrPath"]="텍스처 이름 또는 파일 경로",
			["BlendMode"]="혼합 방식",
			["Color"]="색",
			["Angle"]="회전 각도",
			["Left"]="왼쪽 좌표",
			["Right"]="오른쪽 좌표",
			["Top"]="상단 좌표",
			["Bottom"]="하단 좌표",
			Tooltips={
				["MustExistWhenLoad"]="게임을 시작할 때 해당 파일이 존재해야 합니다",
				["BlendMode"]="텍스처 혼합 방법",
				["Angle"]="텍스처를 표시할 때 회전할 각도",
				["Left"]="원본 텍스처의 왼편에서 떨어진 거리; 0이면 왼쪽 끝, 1이면 오른쪽 끝",
				["Right"]="원본 텍스처의 오른편에서 떨어진 거리; 0이면 왼쪽 끝, 1이면 오른쪽 끝",
				["Top"]="원본 텍스처의 위쪽에서부터 떨어진 거리; 0이면 위쪽 끝, 1이면 아래쪽 끝",
				["Bottom"]="원본 텍스처의 아래쪽에서부터 떨어진 거리; 0이면 위쪽 끝, 1이면 아래쪽 끝",
				["Color"]="텍스처 색",
			}
		},
		----------------------
		TemplatesWindowTextureGroupEditor={
			["SelectTexture"]="Select a texture profile",
			--editor
			["CurrentTexture"]="Current texture profile",
		},
		----------------------
		PagesMain={
			["Core"]="Core",
			["NamePlate"]="이름표",
			["ResourcesLib"]="자원 라이브러리",
			["TargetArrow"]="표적화살표",
			["CombatText"]="전투상황 알림",
			["Tracker"]="추적기",
			["ProfileManager"]="프로필 관리",
			["ProfilePorter"]="가져오기/내보내기",
			["Help"]="도움말",
			--
			["ReloadUI"]="UI 재시작",
			["About"]="About",
			Tooltips={
				["Core"]="Core 설정",
				["NamePlate"]="이름표 설정",
				["ResourcesLib"]="글꼴, 텍스처, 숫자 표기, 색 주문 등 이 애드온이 사용하는 자원",
				["TargetArrow"]="개체의 목표를 가르키는 화살표",
				["CombatText"]="전투상황 알림",
				["Tracker"]="화면에 이름표가 보이지 않는 개체들을 추적하기 위한 가상의 이름표",
				["ProfileManager"]="프로필을 저장하거나 불러오거나 삭제할 수 있으며, 같은 서버의 프로필은 공유됩니다.",
				--
				["RequireReload"]="이 설정은 UI를 재시작해야 변경된 내용이 적용됩니다",
				["ReloadUI"]="모든 UI 재시작",
				["About"]="이 애드온은...",
				["ProfilePorter"]="프로필 가져오기/내보내기",
			}
		},
		----------------------
		PagesNamePlate={
			["Appearance"]="외형",
			["Condition"]="조건",
			Tooltips={
				["Appearance"]="이름표 외형 설정 ; 이름표의 외관을 변경합니다",
				["Condition"]="이름표 조건 설정 ; 이름표의 외형을 나타낼 조건을 변경합니다",			
			}
		},
		----------------------
		PagesMainCore={
			["NamePlateModule"]="이름표 모듈",
			["DataCollector"]="데이터 수집기",
			--
			["Alpha"]="투명도",
			["Aura"]="버프/디버프",
			["Casting"]="시전중",
			["Classification"]="전문화",
			["Health"]="체력",
			["Level"]="레벨",
			["Name"]="이름",
			["Quest"]="퀘스트",
			["RaidTarget"]="전술목표",
			["SpellLock"]="계열 차단",
			["Summoned"]="소환수",
			["Target"]="대상",
			["Threat"]="위협수준",
			["Type"]="Type",
			["UnitID"]="개체ID",
			["CoolDown"]="재사용대기시간",
			["CC_DR"]="군중제어 점감",
			["Power"]="자원",
			["ComboPoints"]="연계점수",
			["Speed"]="속도",
			["Tapped"]="선점됨",
			["Guild"]="길드",
			["NPCGuild"]="NPC 길드",
			["FullName"]="이름(칭호 포함)",
			["Friends"]="친구/길드/파티/공격대",
			["Role"]="플레이어 역할",
			["Unit"]="Unit",
			["BaseEvent"]="Frame based event",
			--
			["BarGroup"]="바 그룹",
			["Icon"]="아이콘",
			["IconGroup"]="아이콘 그룹",
			["Number"]="숫자",
			["Text"]="글자",
			["TextureGroup"]="텍스처 그룹",
			["Default"]="기본값",
			["MainFrame"]="메인 프레임",
			--
			["ScrollFrameRender"]="ScrollFrame render 사용",
			["CombiePetCoolDown"]="소환수 재사용대기시간 결합",
			["CombieMasterCoolDown"]="Combie master's cooldown",
			["InstantAsOneSecondCast"]="즉시 시전 주문의 시전시간 1초로 간주함",
			["EnableAuraCache"]="버프/디버프 캐쉬 사용",
			["AdvancdedType"]="향상된 유형 추적 사용",
			["PowerMatch"]="향상된 이름표 추적 사용",
			--
			Tooltips={
				["Default"]="(기본값)의 변경사항은, UI 재시작을 통해 적용됩니다.",
				["MainFrame"]="Alpha needs this to work",
				--
				["ScrollFrameRender"]="각 이름표를 하나의 레이어로 만듭니다. 이는 이름표가 겹치는 문제를 해결할 수 있지만, 모듈 레이어의 순서에 영항을 미칠 수 있습니다 (효과를 적용하기 위해서는 UI재시작이 필요합니다)",
				["CombiePetCoolDown"]="Consider pet's ability cooldown as master's too",
				["CombieMasterCoolDown"]="Consider master's ability cooldown as pet's too",
				--
				["EnableAuraCache"]="마우스오버 없이도 버프와 디버프를 나타낼 수 있도록 발생한 버프/디버프를 임시공간에 저장합니다. 일부 자원이 소비됩니다.",
				["AdvancdedType"]="소환수와 소환물을 보다 정확하게 감지하기 위해 전투 메시지를 이용해 개체의 유형을 추적합니다. 일부 자원이 소비됩니다.",				
				["PowerMatch"]="NPC의 이름표를 보다 정확하게 감지하기 위해 전투메시지를 사용하여 개체의 GUID를 추적합니다. 일부 자원이 소비됩니다.",
				--
			}
		},
		----------------------
		PagesMainProfileManager={
			["Save"]="저장",
			["Load"]="불러오기",
			["InputName"]="새로운 프로필이름을 입력하세요",
			["SettingWillLose"]="계속하면 현재 설정은 사라집니다",
			["ConfirmRemove"]="이 설정을 제거하려면 확인을 누르세요",
			["Saved"]=" 저장했습니다.",
			["Loaded"]=" 설정을 불러왔습니다. 몇몇 설정은 UI를 재시작해야 적용됩니다.",
			--
			["Current"]="현재 프로필",
			--
			["Export"]="내보내기",
			["CopyTheseText"]="Ctrl+C를 이용해 다음 텍스트를 복사하세요",
			["Exported"]=" 개의 설정 내보내기 완료",
			--
			["Inport"]="가져오기",
			["SaveTo"]="다음 프로필에 저장",
			["PasteTextHere"]="Ctrl+v를 이용해 가져오기 할 텍스트코드를 이곳에 붙여넣습니다.",
			["ConfirmOverwritten"]="몇몇 설정은 덮어쓰기가 될 수 있습니다. 계속하시겠습니까?",
			["Inported"]=" 개의 설정 가져오기 완료",
			--
			["Premade"]="Premade",
			--
			Tooltips={
				["Save"]="현재 프로필 저장",
				["Load"]="선택한 프로필 불러오기",
				--
				["Export"]="프로필 내보내기",
				["Inport"]="프로필 가져오기",
				--
				["Premade"]="Inport premade setting",
			},
		},
		----------------------
		PagesMainNamePlateAppearance={
			["SelectProfile"]="프로필을 선택하세요.",
			Tooltips={
				["SelectProfile"]="편집하려면 선택 ; 오른쪽 마우스는 메뉴",
			}
		},
		----------------------
		PagesMainResourcesLib={
			["FontLib"]="글꼴 라이브러리",
			["TextureLib"]="텍스처 라이브러리",
			["Color"]="색",
			["Number"]="숫자",
			["BarGroup"]="바 그룹",
			["Class"]="직업",
			["Spell"]="주문",
			["CountDown"]="재사용대기",
			["RaidTarget"]="전술목표",
			["SelfLib"]="'자신'",
			["RoleLib"]="역할",
			--
			["ResourcesLib"]="자원 라이브러리",
			Tooltips={
				["FontLib"]="글꼴 라이브러리 설정",
				["TextureLib"]="텍스처 라이브러리 설정",
				["Color"]="각 모듈에서 사용할 기본색상표 변경",
				["Number"]="각 모듈에서 사용할 숫자 외형 변경",
				["BarGroup"]="각 모듈에서 사용할 상태바그룹의 외형 변경",
				["Class"]="플레이어와 NPC에 대한 데이터, 아이콘, 주문, 색 등 변경",
				["Spell"]="주문 데이터 변경",
				["CountDown"]="각 모듈에서 사용될 재사용대기시간의 외형 변경",
				["RaidTarget"]="전술목표아이콘 설정",
				["SelfLib"]="플레이어 자신 표시",
			}
		},
		----------------------
		PagesTargetArrowEditor={
			["TargetArrowEdit"]="표적화살표 편집",
			["From"]="~에서",
			["To"]="~으로",
			["MaxPerLine"]="라인당 최대",
			["Gap"]="간격",
			["SpeedPerSecond"]="속도",
			["StartSize"]="시작 크기",
			["EndSize"]="종료 크기",
			["StartOffsetX"]="시작 가로위치 x",
			["StartOffsetY"]="시작 세로위치 y",
			["EndOffsetX"]="종료 가로위치 x",
			["EndOffsetY"]="종료 가로위치 y",
			Tooltips={
				["From"]="화살표가 시작되는 개체",
				["To"]="화살표가 가르키는 개체",
				["MaxPerLine"]="한 줄에 표시할 화살표의 최대 갯수",
				["Gap"]="화살표 사이의 간격",
				["SpeedPerSecond"]="화살표가 이동하는 속도, 0이면 정지",
				["StartSize"]="시작지점의 화살표 크기",
				["EndSize"]="종료지점의 화살표 크기",
				["StartOffsetX"]="시작지점으로부터 화살표의 x 오프셋",
				["StartOffsetY"]="시작지점으로부터 화살표의 y 오프셋",
				["EndOffsetX"]="종료지점으로부터 화살표의 x 오프셋",
				["EndOffsetY"]="종료지점으로부터 화살표의 y 오프셋",
			},
			--0=any, 1=friendly,2=neutral,3=hostile,4=self
			FromToList={
				[1]={
					Text="Any",
					Value=0,
					Tooltips="Any unit",
				},
				[2]={
					Text="자신",
					Value=4,
					Tooltips="플레이어 자기 자신",
				},
				[3]={
					Text="우호적 대상",
					Value=1,
					Tooltips="우호적인 개체",
				},
				[4]={
					Text="적대적 대상",
					Value=3,
					Tooltips="적대적인 개체",
				},
				[5]={
					Text="중립적 대상",
					Value=2,
					Tooltips="중립적인 개체",
				},
				[6]={
					Text="대상",
					Value=5,
					Tooltips="Unit is target",
				},
				[7]={
					Text="주시",
					Value=6,
					Tooltips="Unit is focus",
				},
				[8]={
					Text="마우스오버",
					Value=7,
					Tooltips="Unit is mouseover",
				},
			}
		},
		----------------------
		PagesCombatText={
			["CombatText"]="전투 메시지",
			["Condition"]="조건",
			["Animation"]="애니메이션",
			--
			["From"]="행위자",
			["To"]="대상",
			["Critical"]="극대화",
			["TextWidth"]="텍스트 넓이",
			["TextHeight"]="텍스트 높이",
			["DetailedType"]="세부방식",
			["IconSize"]="아이콘 크기",
			["BGWidth"]="배경 넓이",
			["BGHeight"]="배경 높이",
			["SpellListType"]="주문목록 사용",
			["EditSpellList"]="주문목록 편집",
			["IgnoreOverkill"]="초과데미지/치유는 표시하지 않음",
			--
			["SpeedType"]="속도 작동 방향",
			["SpeedX"]="속도, X",
			["SpeedY"]="속도, Y",
			["AccType"]="가속도 작동 방향",
			["AccX"]="가속도 X",
			["AccY"]="가속도 Y",
			["StartSize"]="시작 크기",
			["EndSize"]="종료 크기",
			["StartAlpha"]="시작 투명도",
			["EndAlpha"]="종료 투명도",
			["ShakeRange"]="흔들림 폭",
			["FrameLevel"]="프레임 계층",
			["Lasts"]="지속 시간",
			--
			Tooltips={
				["Condition"]="텍스트 애니메이션이 나타날 조건",
				["Animation"]="텍스트 애니메이션 목록",
				--
				["From"]="전투메시지 정보가 시작되는 개체",
				["To"]="전투상황 알림이 표시될 개체",
				["Critical"]="극대화 여부",
				["TextWidth"]="텍스트 간격(값이 0이면 자동설정)",
				["TextHeight"]="텍스트 높이",
				["DetailedType"]="텍스트 표기 방식",
				["IconSize"]="아이콘 크기",
				["BGWidth"]="배경의 위치, 폭",
				["BGHeight"]="배경의 위치, 높이",
				["SpellListType"]="주문목록의 작동방법을 선택하세요",
				["IgnoreOverkill"]="Don't show full over kill",
				--
				["SpeedType"]="텍스트를 이동할 방향을 결정합니다",
				["SpeedX"]="x 방향 속도",
				["SpeedY"]="y 방향 속도",
				["AccType"]="가속도를 만들어내는 방향을 결정합니다",
				["AccX"]="x 방향 가속도",
				["AccY"]="y 방향 가속도",
				["StartSize"]="시작시 크기",
				["EndSize"]="종료시 크기",
				["StartAlpha"]="시작시 투명도",
				["EndAlpha"]="종료시 투명도",
				["ShakeRange"]="텍스트가 흔들리는 범위를 설정합니다, 0으로 설정하면 흔들림이 사라집니다",
				["FrameLevel"]="프레임 계층, 높은 프레임계층은 낮은 프레임계층을 덮어씌웁니다",
				["Lasts"]="이 항목의 애니메이션 지속시간",
			},
			--0=any 1=player 2=target 3=focus 4=mouseover ,64=hostile 32=neutral, 16=friendly
			FromToList={
				[1]={
					Text="모두",
					Value=0,
					Tooltips="Any unit",
				},
				[2]={
					Text="자신",
					Value=1,
					Tooltips="플레이어 자신",
				},
				[3]={
					Text="우호적",
					Value=16,
					Tooltips="우호적인 대상",
				},
				[4]={
					Text="적대적",
					Value=64,
					Tooltips="적대적인 대상",
				},
				[5]={
					Text="중립적",
					Value=32,
					Tooltips="중립적인 대상",
				},
				[6]={
					Text="대상",
					Value=2,
					Tooltips="선택중인 대상",
				},
				[7]={
					Text="주시",
					Value=3,
					Tooltips="주시중인 대상",
				},
				[8]={
					Text="마우스오버",
					Value=4,
					Tooltips="마우스오버중인 대상",
				},
				[9]={
					Text="펫",
					Value=5,
					Tooltips="자신의 펫이나 소환물",
				},
			},
			CritList={
				[1]={
					Text="모두",
					Value=0,
					Tooltips="극대화와 일반 모두",
				},
				[2]={
					Text="일반",
					Value=2,
					Tooltips="일반만"
				},
				[3]={
					Text="극대화",
					Value=1,
					Tooltips="극대화만"
				},
			},
			TextType={
				[1]={
					Text="상세표시 없음",
					Value=1,
					Tooltips="기본 텍스트 표시",
				},
				[2]={
					Text="상세표시",
					Value=2,
					Tooltips="상세 텍스트 표시"
				},
			},
			--combatlog event
			["EventLocalization"]={
				["SWING_DAMAGE"]="근접 공격 피해",
				["SWING_MISSED"]="근접 공격 적중하지 않음",
				["SWING_EXTRA_ATTACKS"]="근접 공격 추가 공격",
				--range type
				["RANGE_DAMAGE"]="원거리 공격 피해",
				["RANGE_MISSED"]="원거리 공격 적중하지 않음",
				["RANGE_EXTRA_ATTACKS"]="원거리 공격 추가 공격",
				--spell damage type
				["SPELL_DAMAGE"]="주문 피해",
				["SPELL_PERIODIC_DAMAGE"]="주문 피해 주기적",
				["SPELL_MISSED"]="주문 적중하지 않음",
				["SPELL_DISPEL_FAILED"]="주문 무효화 실패",
				----damage shield type --don't use these yet
				--["SPELL_DAMAGE_SHIELD_DAMAGE"]=true,
				--["SPELL_DAMAGE_SPLIT_DAMAGE"]=true,
				--["SPELL_DAMAGE_SHIELD_MISSED"]=true,
				--aura apply type
				["SPELL_AURA_APPLIED"]="버프/디버프 효과 적용",
				["SPELL_AURA_APPLIED_DOSE"]="버프/디버프 효과 적용 중첩",
				--aura remove type
				["SPELL_AURA_REMOVED"]="버프/디버프 효과 사라짐",
				["SPELL_AURA_REMOVED_DOSE"]="버프/디버프 효과 중첩 감소",
				["SPELL_AURA_BROKEN"]="버프/디버프 효과 제거 자동공격으로",
				["SPELL_AURA_BROKEN_SPELL"]="버프/디버프 효과 제거 주문으로",
				["SPELL_STOLEN"]="버프/디버프 효과 훔치기",
				["SPELL_DISPEL"]="버프/디버프 효과 무효화",
				--energy type
				["SPELL_ENERGIZE"]="자원 획득",
				["SPELL_DRAIN"]="자원 소진",
				["SPELL_LEECH"]="자원 전환",
				--inturrpt type
				["SPELL_INTERRUPT"]="주문 차단",
				--summon type
				["SPELL_CREATE"]="주문으로 생성",
				["SPELL_SUMMON"]="주문으로 소환",
				["SPELL_RESURRECT"]="주문으로 부활",
				--special type
				["UNIT_DIED"]="죽음",
				["UNIT_DESTROYED"]="파괴됨",
				["ENVIRONMENTAL_DAMAGE"]="환경피해",
				--heal type
				["SPELL_HEAL"]="치유 즉시",
				["SPELL_PERIODIC_HEAL"]="치유 주기적",
				--cast type
				["SPELL_CAST_START"]="주문시전 시작",
				["SPELL_CAST_SUCCESS"]="주문시전 성공",
			},
			--
			SpeedTypeList={
				[1]={
					Text="고정",
					Value=0,
					Tooltips="x,y 고정",
				},
				[2]={
					Text="왼쪽 상단",
					Value=1,
					Tooltips="상단 왼쪽에 무작위로, 범위의 한계는 x, y값입니다"
				},
				[3]={
					Text="오른쪽 상단",
					Value=2,
					Tooltips="오른쪽 상단에 무작위로, 범위의 한계는 x, y값입니다"
				},
				[4]={
					Text="왼쪽 하단",
					Value=3,
					Tooltips="왼쪽 하단에 무작위로, 범위의 한계는 x, y값입니다"
				},
				[5]={
					Text="오른쪽 하단",
					Value=4,
					Tooltips="오른쪽 하단에 무작위로, 범위의 한계는 x, y값입니다"
				},
				[6]={
					Text="상단",
					Value=5,
					Tooltips="상단에 무작위로, 범위의 한계는 x, y값입니다"
				},
				[7]={
					Text="하단",
					Value=6,
					Tooltips="하단에 무작위로, 범위의 한계는 x, y값입니다"
				},
				[8]={
					Text="왼쪽",
					Value=7,
					Tooltips="왼쪽에 무작위로, 범위의 한계는 x, y값입니다"
				},
				[9]={
					Text="오른쪽",
					Value=8,
					Tooltips="오른쪽에 무작위로, 범위의 한계는 x, y값입니다"
				},
			},
			["SpellListTypeList"]={
				[1]={
					Text="사용중지",
					Value=0,
					Tooltips="주문목록 필터를 사용하지 않습니다",
				},
				[2]={
					Text="포함",
					Value=1,
					Tooltips="주문목록에 주문이 있으면 효과를 사용합니다"
				},
				[3]={
					Text="제외",
					Value=2,
					Tooltips="주문목록에 주문이 없으면 효과를 사용합니다"
				},
			},
		},
		----------------------
		PagesTracker={
			["Condition"]="조건",
			["HideWhenConflict"]="실제이름표가 보이면 숨김",
			["Friendly"]="우호적 개체",
			["Neutral"]="중립적 개체",
			["Hostile"]="적대적 개체",
			["ConditionType"]="조건 유형",
			["Arg"]="조건 인자",
			["Group"]="이름표 그룹",
			["Profile"]="프로필",
			--
			["Nameplates"]="이름표",
			["PosX"]="가로위치 X",
			["PosY"]="세로위치 Y",
			["NGroup"]="이름표 그룹",
			["Index"]="그룹 색인",
			["MaxTime"]="최대 시간",
			--
			["ExtraModule"]="추가 모듈 사용",
			--
			Tooltips={
				["HideWhenConflict"]="실제 이름표가 나타나면, 가상의 이름표를 숨깁니다",
				["Friendly"]="우호적 개체 포함",
				["Neutral"]="중립적 개체 포함",
				["Hostile"]="적대적 개체 포함",
				["Profile"]="이 추적기에 사용할 이름표 프로필",
				["Group"]="The nameplate group this condition is using,fitting unit will be shown on nameplates in this group",
				["NGroup"]="이 이름표가 속해있는 그룹, using for condition",
				["Index"]="The index of this nameplate in the group, when multiple unit fits condition, they will be shown on nameplates with lower index first",
				["MaxTime"]="추적기별 최대 시간",
				--
				["ExtraModule"]="추가모듈 가능(현재 추적기에 '표적화살표'와 '전투상황 알림' 모듈 사용)",
			},
			ConditionTypeList={
				[1]={
					Text="개체가",
					Value="1",
					Tooltips="개체가 특정 개체이면",
				},
				[2]={
					Text="개체의 대상이",
					Value="2",
					Tooltips="특정 개체를 대상으로하는 개체",
				},
				[3]={
					Text="버프/디버프를 가진",
					Value="3",
					Tooltips="특정한 버프/디버프를 가지고 있는 개체",
				},
				[4]={
					Text="주문이 재사용 대기중인",
					Value="6",
					Tooltips="특정 주문이 재사용대기중인 개체",
				},
				[5]={
					Text="주문을 사용가능한",
					Value="7",
					Tooltips="특정주문이 사용가능한 개체",
				},
			},
			UnitArgumentList={
				[1]={
					Text="자신",
					Value="Player",
					Tooltips="플레이어 자신",
				},
				[2]={
					Text="대상",
					Value="Target",
					Tooltips="자신의 대상",
				},
				[3]={
					Text="주시",
					Value="Focus",
					Tooltips="주시대상",
				},
				[4]={
					Text="마우스오버",
					Value="Mouseover",
					Tooltips="마우스오버대상",
				},
				[5]={
					Text="펫",
					Value="Pet",
					Tooltips="소환물",
				},
			}
		},
		----------------------
		PagesNamePlateAppearanceModuleList={
			["CurrentProfile"]="현재 프로필",
			["SelectModule"]="편집할 모듈을 선택하세요"
		},
		----------------------
		PagesModuleList={
			["SelectProfile"]="프로필을 선택하세요",
			--datatype
			["Name"]="이름",
			["Level"]="레벨",
			["Health"]="체력",
			--condition
			["ConditionType"]="조건 유형",
			["ConditionArgument"]="조건 인자",
			--
			Tooltips={
				["SelectProfile"]="편집하려면 선택 ; 오른쪽 마우스는 메뉴",
				["ConditionType"]="이 조건의 유형",
				["ConditionArgument"]="이 조건의 인자",
			},
			NamePlateConditionType={
				[1]={
					Text="기본값으로",
					Value="Default",
					Tooltips="블리자드 기본 이름표와 동일한 투명도 사용",
				},
				[2]={
					Text="대상",
					Value="Target",
					Tooltips="개체가 대상/마우스오버/주시대상일 경우",
				},
				[3]={
					Text="퀘스트",
					Value="Quest",
					Tooltips="개체가 퀘스트에 필요한 경우"
				},
				[4]={
					Text="모두",
					Value="Any",
					Tooltips="모든 상황, 또는 항상"
				},
				[5]={
					Text="이름",
					Value="Name",
					Tooltips="개체의 특정한 이름",
				},
				[6]={
					Text="이름(일부)",
					Value="PartName",
					Tooltips="개체의 이름에 특정 단어가 있을 경우",
				},
				[7]={
					Text="개체ID",
					Value="UnitID",
					Tooltips="특정 개체의 UnitID(개체의 아이디는 WoWHead 같은 사이트에서 찾을 수 있습니다)",
				},
				[8]={
					Text="소환물",
					Value="Summoned",
					Tooltips="다른 개체에 의해서 소환된 소환물"
				},
				[9]={
					Text="플레이어",
					Value="Player",
					Tooltips="개체가 플레이어",
				},
				[10]={
					Text="플레이어 아님",
					Value="NonPlayer",
					Tooltips="플레이어가 아닌 개체",
				},
				[11]={
					Text="버프/디버프를 가진",
					Value="WithAura",
					Tooltips="특정 버프/디버프를 가진 개체",
				},
				[12]={
					Text="버프/디버프가 없는",
					Value="WithoutAura",
					Tooltips="특정 버프/디버프가 없는 개체",
				},
				[13]={
					Text="체력이 높은",
					Value="HealthMore",
					Tooltips="설정한 체력%보다 높은 개체",
				},
				[14]={
					Text="체력이 낮은",
					Value="HealthLess",
					Tooltips="설정한 체력%보다 낮은 개체",
				},
				[15]={
					Text="재사용대기중 ",
					Value="WithCoolDown",
					Tooltips="특정주문이 재사용 대기중인 개체",
				},
				[16]={
					Text="재사용대기중 아님",
					Value="WithoutCoolDown",
					Tooltips="특정주문이 재사용 대기중이 아닌 개체",
				},
				[17]={
					Text="선점됨",
					Value="Tapped",
					Tooltips="다른 플레이어에 의해 선점된 개체(전리품 획득 불가)",
				},
				[18]={
					Text="길드",
					Value="Guild",
					Tooltips="개체가 소속된 길드의 이름",
				},
				[19]={
					Text="NPC 길드",
					Value="NPCGuild",
					Tooltips="NPC가 소속된 길드의 이름",
				},
				[20]={
					Text="펫",
					Value="Pet",
					Tooltips="개체가 누군가의 펫(대상지원과 제어 가능)",
				},
				[21]={
					Text="소환수",
					Value="Guardian",
					Tooltips="개체가 누군가의 소환물(대상지원은 가능하나 제어 불가능)",
				},
				[22]={
					Text="친구 목록에 있는",
					Value="FriendList",
					Tooltips="플레이어의 친구목록에 있는개체",
				},
				[23]={
					Text="길드원",
					Value="GuildList",
					Tooltips="개체가 플레이어의 길드원",
				},
				[24]={
					Text="파티원",
					Value="PartyList",
					Tooltips="개체가 플레이어의 파티원",
				},
				[25]={
					Text="공격대원",
					Value="RaidList",
					Tooltips="개체가 플레이어와 같은 공격대원",
				},
				[26]={
					Text="역할",
					Value="Role",
					Tooltips="개체의 특정 역할",
				},
				[27]={
					Text="등급",
					Value="Classification",
					Tooltips="개체가 정예/우두머리/일반몹일 경우",
				},
				[28]={
					Text="위협수준",
					Value="Threat",
					Tooltips="개체에 대한 위협수준 상태",
				},
				[29]={
					Text="Casting",
					Value="Casting",
					Tooltips="Unit is casting",
				},
				[30]={
					Text="NotCasting",
					Value="NotCasting",
					Tooltips="Unit is not casting",
				},
			},
			TargetArgumentList={
				[1]={
					Text="대상",
					Value="Target",
					Tooltips="현재 선택중인 개체",
				},
				[2]={
					Text="주시대상",
					Value="Focus",
					Tooltips="현재 주시중인 개체",
				},
				[3]={
					Text="마우스오버",
					Value="Mouseover",
					Tooltips="현재 마우스오버중인 개체",
				},
				[4]={
					Text="Self",
					Value="player",
					Tooltips="Unit is self",
				},
				[5]={
					Text="Pet",
					Value="pet",
					Tooltips="Unit is self's pet",
				},
				[6]={
					Text="Any",
					Value="Any",
					Tooltips="Unit is any unit",
				},
			},
			--faction, 1=friendly,2=neutral,3=hostile
			FactionArgumentList={
				[1]={
					Text="적대적",
					Value="3",
					Tooltips="개체가 적대적",
				},
				[2]={
					Text="우호적",
					Value="1",
					Tooltips="개체가 우호적",
				},
				[3]={
					Text="중립적",
					Value="2",
					Tooltips="개체가 중립적",
				},
			},
			--role
			RoleArgumentList={
				[1]={
					Text="치유 전담",
					Value="HEALER",
					Tooltips="그룹내 역할이 치유 전담",
				},
				[2]={
					Text="방어 전담",
					Value="TANK",
					Tooltips="그륩내 역할이 방어 전담",
				},
				[3]={
					Text="공격 전담",
					Value="DAMAGER",
					Tooltips="그룹내 역할이 공격 전담",
				},
				[4]={
					Text="없음",
					Value="NONE",
					Tooltips="그룹내 역할이 없음",
				},
			},
			--classification
			ClassificationArgumentList={
				[1]={
					Text="우두머리",
					Value="worldboss",
					Tooltips="개체가 우두머리",
				},
				[2]={
					Text="정예",
					Value="elite",
					Tooltips="개체가 정예몹",
				},
				[3]={
					Text="일반",
					Value="normal",
					Tooltips="개체가 일반몹",
				},
			}
		},
		----------------------
		PagesModuleListDefault={
			["SelectRegion"]="항목을 선택하세요",
			["ThreatGlow"]="위협수준 표시",
			["Overlay"]="체력바 테두리",
			["Highlight"]="강조 표시",
			["NameText"]="이름",
			["LevelText"]="레벨",
			["BossIcon"]="보스 아이콘",
			["RaidIcon"]="전술목표",
			["EliteIcon"]="정예 아이콘",
			["HealthBar"]="체력바",
			["CastBar"]="시전바",
			["CastBarOverlay"]="시전바 테두리",
			["CastBarShield"]="시전바-차단불가",
			["SpellIcon"]="시전바 주문아이콘",
			Tooltips={
				["ThreatGlow"]="위협수준의 변화를 나타내는 텍스처",
				["Overlay"]="이름표의 테두리에 해당하는 텍스처",
				["Highlight"]="마우스오버 대상일 경우의 텍스처",
				["NameText"]="개체의 이름을 보여주는 글자",
				["LevelText"]="개체의 레벨을 보여주는 글자",
				["BossIcon"]="보스몹일때 해골 아이콘 표시",
				["RaidIcon"]="전술목표 아이콘(네모, 삼각형 등등)",
				["EliteIcon"]="희귀나 정예몹을 표시하는 금테/은테 용아이콘",
				["HealthBar"]="체력바",
				["CastBar"]="시전바",
				["CastBarOverlay"]="시전바의 테두리에 해당하는 텍스처",
				["CastBarShield"]="차단이 불가능한 주문을 시전하는 경우를 보여주는 텍스처",
				["SpellIcon"]="개체가 시전중인 주문의 아이콘",
			}
		},
		----------------------
		PagesModueListTextEditor={
			["TextEdit"]="글자 편집",
			--
			["AnchorFrame"]="위치의 기준점이 될 프레임",
			["FrameLevel"]="프레임 레벨",
			["ByFontSetting"]="글꼴 설정에 따라",
			["Size"]="크기",
			["Layer"]="계층",
			["Width"]="넓이",
			["EditAnchor"]="위치의 기준점 편집",
			["TestText"]="테스트용 문자열입니다",
			["MainFrame"]="메인 프레임",
			Tooltips={
				["Size"]="이 글자의 크기",
				["Layer"]="이 글자가 포함된 레이어, 상위 계층은 하위 계층을 덮어 씌웁니다.",
				["Width"]="글자의 넓이, 0이면 자동 설정",
				["DataType"]="문자열로 보여줄 데이터(예. 이름, 직업)",
				["AnchorFrame"]="The frame which this text anchors to",
				["FrameLevel"]="글자의 프레임 레벨, text with bigger number would overlay on top of text with smaller number",
				["MainFrame"]="모든 모듈의 모체가 되는 프레임, 항상 표시됨",
			}
		},
		----------------------
		PagesModueListTextureGroupEditor={
			["SelectProfile"]="텍스처그룹 편집",
		},
		----------------------
		PagesModueListDefaultEditor={
			["Enable"]="사용",
			["NameOrPath"]="이름 또는 파일 경로",
			["Width"]="넓이",
			["Height"]="높이",
			["SelfAnchor"]="Anchor on self",
			["ToAnchor"]="Anchor on target",
			["OffsetX"]="가로위치 X",
			["OffsetY"]="세로위치 Y",
			["TestText"]="테스트 이름",
			Tooltips={
				["MustExistWhenLoad"]="게임을 시작할 때 해당 파일이 존재해야 합니다"
			}
		},
		----------------------
		PagesModuleListBarGroupEditor={
			["BarGroupEdit"]="바 그룹 편집",
			["DataType"]="데이터 유형",
			["FrameLevel"]="프레임 레벨",
			["AnchorFrame"]="Anchor to frame",
			["Width"]="넓이",
			["Height"]="높이",
			["EditAnchor"]="위치의 기준점와 위치 변경",
			["SmoothTime"]="부드러운 변경",
			["ShadowAlpha"]="그림자 바 투명도",
			["MainFrame"]="메인 프레임",
			Tooltips={
				["FrameLevel"]="The framelevel it's in, 상위 계층은 하위 계층을 덮어씌웁니다",
				--
				["SmoothTime"]="어두운 막대를 이용해 바의 변화를 시간에 따라 매끄럽게 변경합니다, 0이면 사용중지",
				["ShadowAlpha"]="부드러운 변경에 사용할 배경 바의 투명도",
				["MainFrame"]="모든 모듈의 모체가 되는 프레임, 항상 표시됨",
			}
		},
		----------------------
		PagesModuleListIconEditor={
			["IconEdit"]="아이콘 편집",
			Tooltips={
			}
		},
		----------------------
		PagesModuleListIconGroupEditor={
			["IconGroupEdit"]="아이콘 그룹 편집",
			["PerRow"]="한줄당 아이콘",
			["Max"]="최대 아이콘",
			["Direction"]="생성 방향",
			["TimeLimit"]="시간 제한",
			["GapX"]="가로간격 x",
			["GapY"]="세로간격 y",
			Tooltips={
				["PerRow"]="각 줄에 표시된 아이콘의 갯수",
				["Max"]="표시할 아이콘은 총갯수",
				["Direction"]="아이콘 생성시 위치할 방향",
				["Time limit"]="단위: 초, 설정한 시간이하면 되면 아이콘을 숨깁니다; 0은 제한 없음",
				["GapX"]="아이콘간 가로 간격, x",
				["GapY"]="아이콘간 세로 간격, y",
			},
			DirectionList={
				[1]={
					Text="오른쪽 후 위로",
					Tooltips="아이콘을 오른쪽으로 생성하며 새로운 줄은 위쪽으로",
					Value=1,
				},
				[2]={
					Text="왼쪽 후 위로",
					Tooltips="아이콘을 왼쪽으로 생성하며 새로운 줄은 위쪽으로",
					Value=2,
				},
				[3]={
					Text="오른쪽 후 아래로",
					Tooltips="아이콘을 오른쪽으로 생성하며 새로운 줄은 아래쪽으로",
					Value=3,
				},
				[4]={
					Text="왼쪽 후 아래로",
					Tooltips="아이콘을 왼쪽으로 생성하며 새로운 줄은 아래쪽으로",
					Value=4,
				},
				[5]={
					Text="위쪽 후 오른쪽",
					Tooltips="아이콘을 위로 생성하며 새로운 줄은 오른쪽으로",
					Value=5,
				},
				[6]={
					Text="위쪽 후 왼쪽",
					Tooltips="아이콘을 위쪽으로 생성하며 새로운 줄은 왼쪽으로",
					Value=6,
				},
				[7]={
					Text="아래쪽 후 오른쪽",
					Tooltips="아이콘을 아래쪽으로 생성하며 새로운 줄은 오른쪽으로",
					Value=7,
				},
				[8]={
					Text="아래쪽 후 왼족",
					Tooltips="아이콘을 아래쪽으로 생성하며 새로운 줄은 왼쪽으로",
					Value=8,
				},
			}
		},
		----------------------
		PagesModuleListIconGroupRulesEditor={
			["FilterType"]="필터 유형",
			["EditList"]="목록 편집",
			["FromType"]="출처",
			["Priority"]="우선순위",
			["Width"]="넓이",
			["Height"]="높이",
			Tooltips={
				["FilterType"]="필터링 중인 버프/디버프입니다",
				["EditList"]="필터 목록을 편집합니다",
				["FromType"]="버프/디버프를 생성한 개체의 유형",
				["Priority"]="The priority of auras added from this rule; Aura with higher priority will be put in front; also ,if one aura is added by different rules, the setting with higher priority will be used",
				["Width"]="The width of aura which fits this rule",
				["Height"]="The height of aura which fits this rule",
			},
			FilterTypeList={
				[1]={
					Text="버프",
					Value=1,
					Tooltips="모든 버프"
				},
				[2]={
					Text="디버프",
					Value=2,
					Tooltips="모든 디버프"
				},
				[3]={
					Text="주문 목록",
					Value=3,
					Tooltips="주문ID 목록을 사용"
				},
				[4]={
					Text="버프/디버프 속성 목록",
					Value=4,
					Tooltips="버프/디버프의 속성 목록을 사용"
				},
				[5]={
					Text="모두",
					Value=5,
					Tooltips="모든 주문"
				},
				[6]={
					Text="훔치기 가능",
					Value=6,
					Tooltips="훔치기 가능한 주문들"
				},
			},
			FromTypeList={
				[1]={
					Text="모두",
					Value=1,
					Tooltips="누군가가 시전한 모든 주문"
				},
				[2]={
					Text="자신",
					Value=2,
					Tooltips="자신이 시전한 주문"
				},
			}
		},
		PagesModuleListIconGroupRulesModulesEditor={
			["EditModule"]="모듈 편집",
			["ModuleType"]="모듈 유형",
			["DataType"]="데이터 유형",
			["ColorMode"]="색 모드",
			["TestText"]="테스트용 글자",
			Tooltips={
				["ModuleType"]="이 모듈의 유형",
				["DataType"]="모듈이 보여줄 데이터 타입The type of data this module shows",
			},
			ModuleTypeList={
				[1]={
					Text="바 그룹",
					Value="BarGroup",
				},
				[2]={
					Text="아이콘",
					Value="Icon",
				},
				[3]={
					Text="텍스처",
					Value="Texture",
				},
				[4]={
					Text="글자",
					Value="Text",
				},
				[5]={
					Text="숫자",
					Value="Number",
				},
				[6]={
					Text="추가 정보",
					Value="ExtraInfo",
					Tooltips="특정 데이터 유형에 대한 추가 정보(예.군중제어 점감 정보)",
				}
			},
			DataTypeList={
				[1]={
					Text="시간",
					Value="Time",
				},
				[2]={
					Text="중첩",
					Value="Stack",
				}
			},
			ColorModeList={
				[1]={
					Text="기본설정에 따라",
					Value=0,
				},
				[2]={
					Text="계열에 따라",
					Value=1,
				}
			}
		},
		----------------------
		PagesModuleListNumberEditor={
			["NumberEdit"]="숫자 편집",
			Tooltips={
			}
		},
		----------------------
		PagesResourcesLibBarGroup={
			["SelectProfile"]="프로필을 선택하세요",
			Tooltips={
				["SelectProfile"]="편집하려면 선택 ; 오른쪽 마우스는 메뉴",
			}
		},
		----------------------
		PagesResourcesLibClassLib={
			["Class"]="직업",
			--
			["Player"]="플레이어",
			["Totem"]="토템",
			["Creature"]="Creature",
			["Vendor"]="상인",
			Tooltips={
				["Player"]="Player class setting",
				["Totem"]="Totem class setting",
				["Creature"]="Creature class setting",
				["Vendor"]="Vendor class setting",
			}
		},
		----------------------
		PagesResourcesLibColorLib={
			["Color"]="색",
			["Faction"]="우호도",
			["SpellSchool"]="주문의 마법계열",
			["Threat"]="위협수준",
			["Class"]="위협수준",
			["SpellType"]="버프/디버프 속성",
			["Power"]="자원",
			Tooltips={
				["Faction"]="각 우호도에 따라 색상을 변경합니다.",
				["SpellSchool"]="주문의 마법계열에 따라 색상을 변경합니다",
				["Threat"]="위협수준에 따라 색상을 변경합니다.",
				["Class"]="위협수준에 따라 색상을 변경합니다.",
				["SpellType"]="버프/디버프의 속성에 따라 색상을 변경합니다",
				["Power"]="플레이어의 자원에 대한 색상을 변경합니다(분노, 마나 등)",
			}
		},
		----------------------
		PagesResourcesLibCountDownLib={
			["SelectProfile"]="프로필을 선택하세요",
			Tooltips={
				["SelectProfile"]="편집하려면 선택 ; 오른쪽 마우스는 메뉴",
			}
		},
		----------------------
		PagesResourcesLibFontLib={
			["SelectProfile"]="프로필을 선택하세요",
			["Generate"]="생성",
			Tooltips={
				["SelectProfile"]="편집하려면 선택 ; 오른쪽 마우스는 메뉴",
				["Generate"]="라이브러리를 기반으로 글꼴 프로필을 만듭니다",
			}
		},
		----------------------
		PagesResourcesLibNumberLib={
			["SelectProfile"]="프로필을 선택하세요",
			Tooltips={
				["SelectProfile"]="편집하려면 선택 ; 오른쪽 마우스는 메뉴",
			}
		},
		----------------------
		PagesResourcesLibSpellLib={
			["SpellLib"]="주문데이터 라이브러리",
			--
			["AutoDetector"]="자동 감지기",
			["LibEditor"]="라이브러리 편집기",
			["Catalog"]="목록",
			--
			["SelectSpell"]="주문을 선택하세요",
			["SpellAlreadyExists"]="주문이 이미 존재합니다",
			["SpellCreated"]="주문이 생성되었습니다",
			--
			["SelectType"]="유형을 선택하세요",
			--
			["SortBy"]="정렬 방법",
			["SortData"]={
				[1]={
					Text="직업에 따라",
					Value=0,
				},
				[2]={
					Text="군중제어-점감형태에 따라",
					Value=1,
				},
				--[3]={
				--	Text="By Spell type",
				--	Value=2,
				--},
				--[4]={
				--	Text="By School",
				--	Value=3,
				--}
			},
			--
			Tooltips={
				["AutoDetector"]="전투 메시지를 기반으로 주문데이터를 자동으로 생성합니다(많은 자원이 소비되며, 애드온 로드시 자동으로 시작되는 것은 아닙니다)",
				["LibEditor"]="주문 라이브러리를 직접 편집합니다.",
				["Catalog"]="주문을 삭제하거나, 주문데이터의 분류를 관리합니다.",
				["SelectSpell"]="편집하려는 주문을 선택하세요",
				["SelectType"]="편집하려는 주문의 유형을 선택하세요",
				["SortBy"]="주문 정렬 방법",
			},
		},
		----------------------
		PagesResourcesLibTextureLib={
			["SelectProfile"]="프로필을 선택하세요",
			["Generate"]="생성",
			Tooltips={
				["SelectProfile"]="편집하려면 선택 ; 오른쪽 마우스는 메뉴",
				["Generate"]="라이브러리를 기반으로 텍스처 프로필을 만듭니다",
			}
		},
		----------------------
		PagesClassLibPlayer={
			["PlayerClass"]="플레이어 직업",
			["Color"]="색",
			["Icon"]="아이콘"
		},
		----------------------
		PagesSelfLib={
			["Color"]="색",
			["Text"]="글자",
			Tooltips={
				["Text"]="사용할 글자를 입력하세요. 비어있으면 색상은 적용되지 않으며 실제이름이 나타납니다.",
			}
		},
		----------------------
		PagesRoleLib={
			["Role"]="플레이어 역할",
			["Icon"]="아이콘"
		},
		----------------------
		PagesColorLibFaction={
			["Faction"]="우호도 색상표",
			["Friendly"]="우호적",
			["Neutral"]="중립적",
			["Hostile"]="적대적",
			Tooltips={
				["Friendly"]="우호적 개체 색",
				["Neutral"]="중립적 개체 색",
				["Hostile"]="적대적 개체 색",
			}
		},
		----------------------
		PagesColorLibThreat={
			["Threat"]="위협수준 색상표",
			["sColor"]="] 색",
			["Change"]="변경 [",
		},
		----------------------
		PagesColorLibSpellSchool={
			["SpellSchool"]="주문 마법계열 색",
			["sColor"]="] 색",
			["Change"]="변경 [",
		},
		----------------------
		PagesColorLibSpellType={
			["SpellType"]="버프/디버프 속성 색",
			["sColor"]="] 색",
			["Change"]="변경 [",
		},
		----------------------
		PagesColorLibPower={
			["SpellType"]="자원 색상표",
			["sColor"]="] 색",
			["Change"]="변경 [",
		},
		----------------------
		PagesSpellLibAutoDetector={
			["AutoDetector"]="자동 감지",
			--
			["Enable"]="사용",
			["From"]="행위자",
			["CastOn"]="Cast on",
			--
			["Catalog"]="Catalog",
			["Object"]="사물",
			["Guardian"]="소환물",
			["Pet"]="소환수",
			["NPC"]="NPC",
			["Player"]="플레이어",
			["Target"]="대상",
			["Focus"]="주시",
			["Self"]="자신",
			["NoOne"]="알 수 없음",
			--
			["Caster"]="시전자",
			["Name"]="주문명",
			["Spellid"]="주문ID",
			["School"]="주문의 마법계열",
			["Icon"]="아이콘파일",
			["CastTime"]="시전 시간",
			["MinRange"]="최소 거리",
			["MaxRange"]="최대 거리",
			["CastElapse"]="최소 시전 주기",
			["Length"]="지속 시간",
			["CastArea"]="시전 장소",
			["CastOn"]="대상",
			["MaxStack"]="최대 중첩",
			["InterruptSpell"]="차단 주문",
			["SummonSpell"]="소환 주문",
			["DispelSpell"]="해제 주문",
			["HealSpell"]="치유 주문",
			["ResurrectSpell"]="부활 주문",
			["EnegrizeSpell"]="자원생성 주문",
			["DispelAble"]="해제 가능",
			--
			["Save"]="선택한 주문 저장",
			["Saved"]="저장되었습니다",
			["Reset"]="주문 목록 초기화",
			["Overwrote"]="덮어쓰기",
			["Total"]="총",
			["Unsorted"]="미분류",
			Tooltips={
				["Object"]="개체나 캐릭터가 아님, 예) 환경-낙하피해, 독, 용암",
				["Guardian"]="제어가 불가능하지만 플레이어를 위해 싸우는 개체",
				["Pet"]="플레이어가 제어할 수 있는 개체",
				["NPC"]="플레이어가 제어할 수 없는 NPC",
				["Player"]="플레이어가 제어하는 캐릭터",
				--
				["Save"]="선택한 주문의 정보를 주문 라이브러리에 저장합니다(이미 존재한다면 덮어씌웁니다)",
				["Reset"]="주문 목록을 초기화합니다",
			}
		},
		----------------------
		PagesSpellLibCatalog={
			["SelectSpell"]="편집하려는 주문을 선택하세요",
			--
			["MoveTo"]="이동",
			["Catalog"]="목록",
			["Delete"]="삭제",
			--
			["Moved"]="이동되었습니다",
			["Deleted"]="삭제되었습니다",
			["Unsorted"]="미분류",
			Tooltips={
				["MoveTo"]="위의 선택된 주문들을 오른편의 선택한 목록으로 이동시킵니다",
				["Catalog"]="This affects only where the spell displays in Options' spell-selector, changes won't be refreshed immediately",
				["Delete"]="선택한 주문을 주문 라이브러리에서 삭제합니다",
			}
		},
		----------------------
		Help={
			Index={
				[1]={
					Text="(A.1.0) UI 사용법",
					Value=1
				},
				[2]={
					Text="(A.2.0) Core",
					Value=2
				},
				[3]={
					Text="(A.3.0) 자원 라이브러리",
					Value=3
				},
				[4]={
					Text="(A.4) 이름표->외형->위치,크기,프레임레벨,투명도",
					Value=4
				},
				[5]={
					Text="(A.5) 이름표->외형->데이터 유형",
					Value=5
				},
				[6]={
					Text="(A.6) 전투상황 알림",
					Value=6
				},
				[7]={
					Text="(A.7) 표적화살표",
					Value=7
				},
				[8]={
					Text="(A.8) 추적기",
					Value=8
				},
				[9]={
					Text="(A.9) 프로필 관리자",
					Value=9
				},
				[10]={
					Text="(B.1) 다른 이름표 애드온과의 작동",
					Value=10
				},
				[11]={
					Text="(B.2.1) 재사용대기/군중제어/지속시간/중첩이 제대로 동작하지 않는다면?",
					Value=11
				},
				[12]={
					Text="(B.2.2) 주문 데이터 추가",
					Value=12
				},
				[13]={
					Text="(B.3) 왜 변경사항이 적용되지 않을까요?",
					Value=13
				},
				[14]={
					Text="(B.4) 바 변경 방법 / 바 반전 방법",
					Value=14
				},
				[15]={
					Text="(B.5) 아이콘그룹(버프/디버프/재사용대기시간/군중제거 점감)",
					Value=15
				},
				[16]={
					Text="(B.6) 배경/테두리",
					Value=16
				},
				[17]={
					Text="(B.7) 이름표 겹치기",
					Value=17
				},
				[18]={
					Text="(B.8) 소환수 이름표 숨기기/다른 개체에 다른 스타일 설정하기",
					Value=18
				},
				[19]={
					Text="(B.9) 이름/체력바/아이콘을 추가/삭제/수정하는 방법",
					Value=19
				},
				[20]={
					Text="(B.10) 표적화살표/전투상황 알림/추적기를 사용하지 않는 방법",
					Value=20
				},
			},
			Text={
				[1]="모든 설정창의 빈 곳을 드래그하면 설정창 전체를 이동합니다.\n\n사이드바 상단의 동그라미를 드래그하면 창의 잠금을 해제하고 현재창과 분리해 이동할 수 있습니다.\n\n사이드바의 스크롤바를 드래그하면 창의 크기를 변경합니다.\n\n사이드바의 [-]를 클릭하면 창을 최소화 또는 최대화 합니다.\n\n[O]를 클릭하면 창의 위치와 크기를 초기화합니다.\n\n[X]를 클릭하면 창을 닫습니다.",								
				[2]="NPA에 의한 기본이름표의 변경을 멈추려면 [Core] 페이지의 [이름표 모듈]항목에서 [기본값]을 꺼두면 됩니다. 이를 통해 다른 이름표 애드온과 호환될 수 있습니다.\n\n[데이터 수집기]를 중지하면 자원의 소비를 줄일 수 있습니다.\n\nScrollFrame render는 자원 소비를 증가시키며, 동일한 이름표상의 모듈 순서를 무시합니다.",
				[3]="[자원 라이브러리] 에 설정된 항목들을 NPA의 다른 기능에 사용됩니다.[글꼴 라이브러리]와 [텍스처 라이브러리]를 사용하기 위해서는 목록에 나열된 파일이 반드시 추가되어 있어야  합니다.\n\n[생성] 버튼은 [LibShareMedia]라이브러리에 있는 기본설정을 기반으로 모든 파일을 추가합니다.\n\n재사용대기시간과 점감은 [주문 라이브러리]에 주문 목록이 있을때 작동됩니다.\n버프/디버프는 [주문 라이브러리]에 잆어도 동작하지만, 있으면 더 정확해집니다.",
				[4]="이 설정은 이 이름표과 관련된 모든 모듈에 영향을 미칩니다.\n\n또한 이 설정은 서로 다른 개체들을 다른 모양의 이름표로 표시할 때 사용됩니다.\n\n그리고 [이름표-조건]에 설정한 조건에 만족할 때만 작동됩니다.",
				[5]="각 모듈의 데이터 유형은 해당 모듈이 표시할 내용을 결정하며, 서로 다른 모듈은 다른 데이터 유형을 표시합니다.\n　예) [글자] 모듈에 있는 데이터 유형은 대상의 종류를 나타냅니다.\n\n[텍스처 그룹] 모듈의 데이터 유형은 텍스처 그룹에 해당하는 내용이 언제 나타날지를 결정합니다.\\n　예) [텍스처 그룹]의 [자원]항목은 개체의 자원이 있을때만 나타납니다.\n\n",
				[6]="[조건] 전투메시지의 다양한 표현방법을 설정합니다.\n\n[애니메이션] 텍스트의 변화 방법을 결정합니다.\n　예) [오른쪽으로 이동 후 위로]\n\n[조건]에서 극대화는 피해와 치유만 가능하며, 나머지는 항상 일반입니다.",
				[7]="[표적화살표]는 특정 이름표로 향하는 화살표를 생성합니다.\n\n[표적화살표]만 사용하려면, [Core]페이지에 있는 데이터 수집기 항목 중 [대상]만 체크하면, [표적화살표]만 사용할 수 있습니다.",				
				[8]="[추적기]의 [조건]은 추적하고자 하는 개체를 분류할 때 사용되며, 추적된 개체의 [이름표]를 화면에 나타냅니다.\n개별 [조건]은 조건에 의해 나타난 개체의 이름표를 묶을 '이름표그룹'을 가지고 있습니다.\n\n각각의 [이름표]는 이 이름표가 속한 '이름표그룹'을 결정하기 위한 [그룹]을 가지고 있습니다.\n또한 각각의 [이름표]는 이름표와 '이름표그룹' 내의 위치를 결정하기 위한 [색인]을 가지고 있으며, 유사한 [색인]을 가진 이름표가 먼저 표시됩니다.(Each [Nameplate] also has an [Index] ,to decide the position it's at insde the nameplate group, a nameplate with smaller index would be used first)",
				[9]="프로필관리자를 통해 동일한 서버내의 같은 계정간 캐릭터의 프로필을 공유할 수 있습니다.\n\n또한 저장한 프로필을 다른 캐릭터에서 불러올 수도 있습니다.\n이를 위해서는 [내보내기]를 이용해 데이터문자열을 만들고 [가져오기]의 입력창에 생성된 데이터 문자열을 붙여넣으면 됩니다.",
				[10]="[Core] 탭의 [이름표 모듈]에서 [기본값]을 비활성화하면, NPA가 기본이름표를 변경하지 않습니다. 이를 통해 다른 이름표 애드온과의 충돌을 피할 수 있습니다.\n이 변경사항은 UI를 재시작해야 적용됩니다",
				[11]="[자원 라이브러리]->[주문]에 의해 생성된 것과 일치하는 주문이 필요합니다.\nNPA는 주문 데이터의 양이 방대하고 이를 구성하는데 어려움이 있어 모든 주문들의 데이터를 기본값으로 가지고 있진 않습니다.",
				[12]="[자원 라이브러리]->[주문]->[라이브러리 편집기]에서 주문을 직접 추가할 수 있습니다.\n\n정렬된 목록을 오른마우스로 클릭하면 목록의 이름을 변경할 수 있습니다.\n\n[목록]을 사용해 해당 주문의 분류를 빠르게 변경할 수 있습니다.\n\n[자동 감지기]를 활성화하면 특정 개체의 주문 정보를 자동으로 수집할 수 있으며, 선택한 주문을 주문 라이브러리에 추가할 수 있습니다.\n참고 : [자동 탐지기]는 많은 자원을 소비하기 때문에 UI가 재시작되면 자동으로 비활성화 됩니다.",
				[13]="각 페이지에 있는 [저장] 버튼을 눌러야만 변경사항이 적용됩니다.\n\n또한 하위페이지를 먼저 저장해야 상위 페이지를 정상적으로 저장할 수 있습니다.",
				[14]="[자원 라이브러리]->[바 그룹]-> 설정 선택 -> 바 추가(적어도 1개) -> 바 설정 편집\n\n　예) 0%-50%일때 나타나는 바와 50%-100%일때 나타날 서로 다른 바 2개를 추가하려고 할 때\n\n바의 위치의 기준점와 방향을 반대로 하면 바를 반대로 할 수 있습니다.\n\n[크기 변경]은 백분율과 방향에 따라 바의 크기를 줄어들게 합니다\n\n[텍스처 변경]은 백분율과 방향에 따라 텍스처의 표현을 줄어들게 합니다.\n\n변경사항은 이 설정을 사용하는 모든 설정에 반영됩니다.",
				[15]="[이름표]->[외형]->[아이콘그룹]에서 프레임을 만듭니다.\n\n데이터 유형을 선택합니다 (버프/디버프/재사용대기시간/군중제어 점감)\n\n이 프레임 안에 표시할 아이콘을 위한 필터를 생성합니다.\n블랙리스트와 화이트리스트도 있습니다\n\n필터에서 아이콘프레임을 변경할 수 있습니다.\n　예.크기, 간격, 레이어\n\n아이콘, 이름, 시간을 포함한 원하는 항목을 필터내에서 추가할 수 있습니다.",
				[16]="배경/테투리/하이라이트는 [텍스처 그룹]에서 조정됩니다.\n[이름표]->[외형]-> 프로필 선택->[텍스처 그룹]->새로운 설정 추가\n\n텍스처그룹의 데이타 유형은 텍스처그룹이 보여질 때를 지정합니다.\n　예.[대상]은 개체가 대상일때 텍스처그룹을 표시합니다.\n\n 서로 다른 모양의 텍스처를 원한다면 [텍스처 그룹] 하위에 있는 텍스처를 수정하세요",
				[17]="이름표를 표현하는데는 두가지 방법이 있습니다.\n\n기본적인 방법은 동일한 이름표에 모듈의 표기 순서를 조정하는 것입니다. 하지만 이는 다른 이름표의 모듈은 서로 겹치게 될 것입니다.\n\n다른 하나의 방법은 ScrollFrame render방식입니다. 이는 서로 다른 이름표에 모듈이 겹치는 것을 막을 수 있지만, 모듈의 표기순서 또한 무시합니다.\n\n표현방식은 [Core] 페이지에서 변경할 수 있으며, UI재시작이 필요합니다.",
				[18]="[Nameplate]->[Appearance]->Create a new setting, name it [Empty], delete all module settings inside it, disable all [default] module inside it too, this will make an empty nameplate setting\n\n[Nameplate]->[Condition]->Create a new condition->change the condition type to [Summoned], and the argument [Hostile] ,the profile [Empty]\n\nMake sure the new conditon is above default one\n\nAfter saving, summoned hostile unit (including pet and mirror) will be shown as empty nameplates\n\nNote: hide a nameplate separately is not allowed by Blizzard, this will stop it from showing but the Click-zone would still be there",
				[19]="[이름표]->[외형]->일치하는 프로필을 찾고->일치하는 모듈을 찾습니다\n예) [이름]과 [레벨]은 [글자] 모듈의 하위에 있습니다.\n->일치하는 설정을 찾은 후->수정하거나 삭제합니다\n\n새로운 설정을 추가->수정, 일치하는 데이터유형을 선택합니다\n예) [바 그룹]에는 [체력]/[마나]/[시전중]을 사용할 수 있습니다.",
				[20]="[전투상황 알림]과 [추적기] 항목의 모든 [조건]을 삭제하면 사용을 중지할 수 있습니다. \n\n[표적화살표] 아래의 모든 설정을 삭제하면 [표적화살표]가 중지됩니다.",
			},
		},
		PremadeProfile={
			["nfrog's CC_DR lib"]='@SpellLib\\#{[115752]={["Catalog"]="Paladin",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=100,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[102795]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[113792]={["Catalog"]="Priest",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=30,["CastTime"]=1900,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[80483]={["Catalog"]="Player common",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[116709]={["Catalog"]="Monk",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=2,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=2,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=4,["School"]=1,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[118000]={["Catalog"]="Warrior",["MinRange"]=0,["PVPDRType"]="Stuns(short)",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=1.5,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=1.5,["MaxStack"]=0,["School"]=1,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[118271]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=40,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=4,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[25046]={["Catalog"]="Player common",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[31935]={["Catalog"]="Paladin",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=15,},[56626]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=2,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=2,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=90,},[119403]={["Catalog"]="Hunter",["MinRange"]=0,["PVPDRType"]="Knockbacks",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=0,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[108199]={["Catalog"]="DeathKnight",["MinRange"]=0,["PVPDRType"]="Knockbacks",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=0,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[9005]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=5,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[61025]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=50,["CastTime"]=1700,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[118]={["Catalog"]="Mage",["MinRange"]=0,["PVPDRType"]="Mesmerizes",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=50,["CastTime"]=1700,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=64,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[113953]={["Catalog"]="Rogue",["MinRange"]=0,["PVPDRType"]="Stuns(short)",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=4,["MaxStack"]=0,["School"]=9,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=20,},[87194]={["Catalog"]="Priest",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[91800]={["Catalog"]="DeathKnight",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[54706]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=40,},[20066]={["Catalog"]="Paladin",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=60,["CastTime"]=1700,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=15,},[10326]={["Catalog"]="Paladin",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=40,["CastTime"]=1500,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=2,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=15,},[118895]={["Catalog"]="Warrior",["MinRange"]=0,["PVPDRType"]="Stuns(short)",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=1.5,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=1.5,["MaxStack"]=0,["School"]=1,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[122242]={["Catalog"]="Monk",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[4167]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=40,},[34490]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=40,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=24,},[408]={["Catalog"]="Rogue",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=6,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=6,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=20,},[2094]={["Catalog"]="Rogue",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=15,["CoolDownType"]=0,["Length"]=60,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[61305]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=50,["CastTime"]=1613,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[7744]={["Catalog"]="Player common",["MinRange"]=0,["PVPDRType"]="PvP 拌鞭厘",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["NewName"]="",["CastTime"]=0,["NewIcon"]="",["Length"]=0,["SpellType"]="None",["MaxStack"]=0,["School"]=1,["DispelAble"]=false,["CounterSpellLength"]=0,["PVPLength"]=0,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[96201]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=53,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=90,},[126355]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=2,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=2,["NewName"]="",["MaxStack"]=0,["SpellType"]="Poison",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[31661]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=4,["PVPDRType"]="Mesmerizes(short)",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=20,},[42292]={["Catalog"]="Player common",["MinRange"]=0,["PVPDRType"]="PvP 拌鞭厘",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["NewName"]="",["CastTime"]=0,["NewIcon"]="",["Length"]=0,["SpellType"]="None",["MaxStack"]=0,["School"]=1,["DispelAble"]=false,["CounterSpellLength"]=0,["PVPLength"]=0,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[117526]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=100,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[145067]={["Catalog"]="Paladin",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=40,["CastTime"]=1500,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=2,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=15,},[50245]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=40,},[102051]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=8,["CastTime"]=1500,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=16,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=20,},[90337]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=4,["CastTime"]=500,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[19975]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=27,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[91644]={["Catalog"]="Hunter",["MinRange"]=0,["PVPDRType"]="Disarms",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[99]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Mesmerizes(short)",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[59752]={["Catalog"]="Player common",["MinRange"]=0,["PVPDRType"]="PvP 拌鞭厘",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["NewName"]="",["CastTime"]=0,["NewIcon"]="",["Length"]=0,["SpellType"]="None",["MaxStack"]=0,["School"]=1,["DispelAble"]=false,["CounterSpellLength"]=0,["PVPLength"]=0,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[107566]={["Catalog"]="Warrior",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=40,},[5484]={["Catalog"]="Warlock",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=20,["CastTime"]=0,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=40,},[119392]={["Catalog"]="Monk",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[117368]={["Catalog"]="Monk",["MinRange"]=0,["PVPDRType"]="Disarms",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=40,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[20549]={["Catalog"]="Player common",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=2,["CastTime"]=500,["NewIcon"]="",["PVPLength"]=2,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[44572]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=35,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=16,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[114404]={["Catalog"]="Priest",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=100,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[6770]={["Catalog"]="Rogue",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=10,["CoolDownType"]=0,["Length"]=60,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[30283]={["Catalog"]="Warlock",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[61721]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=50,["CastTime"]=1700,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[5246]={["Catalog"]="Warrior",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=8,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=90,},[50541]={["Catalog"]="Hunter",["MinRange"]=0,["PVPDRType"]="Disarms",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[28271]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=50,["CastTime"]=1700,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[1513]={["Catalog"]="Hunter",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=20,["CastTime"]=1423,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=8,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[2637]={["Catalog"]="Druid",["MinRange"]=0,["PVPDRType"]="Mesmerizes",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=40,["CastTime"]=1500,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=5,["School"]=8,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[50613]={["Catalog"]="Player common",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[89766]={["Catalog"]="Warlock",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[19386]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=40,["CoolDownType"]=0,["Length"]=30,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["School"]=8,["SpellType"]="Poison",["CounterSpellLength"]=0,["MaxStack"]=0,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=45,},[24259]={["Catalog"]="Warlock",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=40,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[5782]={["Catalog"]="Warlock",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=20,["CastTime"]=1700,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[51490]={["Catalog"]="Shaman",["MinRange"]=0,["PVPDRType"]="Knockbacks",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=0,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=8,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=45,},[51514]={["Catalog"]="Shaman",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=60,["CastTime"]=1423,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Curse",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=45,},[110693]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=16,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=25,},[113004]={["Catalog"]="Druid",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=8,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=90,},[113275]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=35,["CoolDownType"]=0,["Length"]=30,["CastTime"]=1700,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[82691]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=100,["CoolDownType"]=0,["Length"]=10,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=16,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=20,},[100]={["Catalog"]="Warrior",["MinRange"]=8,["PVPDRType"]="Stuns(short)",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=25,["CoolDownType"]=0,["Length"]=1,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=1,["MaxStack"]=0,["School"]=1,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=20,},[1776]={["Catalog"]="Rogue",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=5,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=10,},[1330]={["Catalog"]="Rogue",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[53148]={["Catalog"]="Hunter",["MinRange"]=8,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=25,["CoolDownType"]=0,["Length"]=1,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=1,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[22570]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=10,},[132168]={["Catalog"]="Warrior",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[102359]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=20,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[55021]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[605]={["Catalog"]="Priest",["MinRange"]=0,["PVPDRType"]="Charm",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=30,["CastTime"]=1800,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[137461]={["Catalog"]="Monk",["MinRange"]=0,["PVPDRType"]="Disarms",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=4,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[118345]={["Catalog"]="Shaman",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=5,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=40,},[119381]={["Catalog"]="Monk",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=45,},[90327]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=40,},[115078]={["Catalog"]="Monk",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=60,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=15,},[64058]={["Catalog"]="Priest",["MinRange"]=0,["PVPDRType"]="Disarms",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=100,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[28272]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=50,["CastTime"]=1700,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[8122]={["Catalog"]="Priest",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[111397]={["Catalog"]="Warlock",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=60,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Horrors",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[126458]={["Catalog"]="Monk",["MinRange"]=0,["PVPDRType"]="Disarms",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=40,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[96294]={["Catalog"]="DeathKnight",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=100,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=16,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[51722]={["Catalog"]="Rogue",["MinRange"]=0,["PVPDRType"]="Disarms",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[64695]={["Catalog"]="Shaman",["MinRange"]=0,["PVPDRType"]="Roots(short)",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=5,["School"]=8,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[77505]={["Catalog"]="Shaman",["MinRange"]=0,["PVPDRType"]="Stuns(short)",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=100,["CoolDownType"]=0,["Length"]=2,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=2,["MaxStack"]=0,["School"]=1,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[115073]={["Catalog"]="Monk",["MinRange"]=0,["PVPDRType"]="Roots(short)",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50,["CoolDownType"]=0,["Length"]=2,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=2,["School"]=4,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[69179]={["Catalog"]="Player common",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[64803]={["Catalog"]="Hunter",["MinRange"]=0,["PVPDRType"]="Roots(short)",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=4,["School"]=8,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[105421]={["Catalog"]="Paladin",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=6,["CastTime"]=0,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=6,["School"]=2,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[22703]={["Catalog"]="Warlock",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=2,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=2,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=4,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[113801]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=5,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[115770]={["Catalog"]="Warlock",["MinRange"]=0,["PVPDRType"]="Knockbacks",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=0,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=25,},[110698]={["Catalog"]="Paladin",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=10,["CoolDownType"]=0,["Length"]=6,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=6,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[119072]={["Catalog"]="Paladin",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=9,},[107079]={["Catalog"]="Player common",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=5,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[15487]={["Catalog"]="Priest",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=45,},[6358]={["Catalog"]="Warlock",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=30,["CastTime"]=1700,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[132469]={["Catalog"]="Druid",["MinRange"]=0,["PVPDRType"]="Knockbacks",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=0,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=8,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[6360]={["Catalog"]="Warlock",["MinRange"]=0,["PVPDRType"]="Knockbacks",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=0,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=25,},[105593]={["Catalog"]="Paladin",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=6,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=6,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[33395]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=45,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=16,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=25,},[114237]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=15,},[118905]={["Catalog"]="Shaman",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=5,["CastTime"]=5000,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[113056]={["Catalog"]="Druid",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=15,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[24394]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=5,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[111264]={["Catalog"]="Mage",["MinRange"]=0,["PVPDRType"]="Roots(short)",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=40,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=5,["School"]=16,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=20,},[61780]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=50,["CastTime"]=1700,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[113506]={["Catalog"]="Druid",["MinRange"]=0,["PVPDRType"]="Cyclone",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=6,["CastTime"]=1700,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=6,["School"]=8,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[116706]={["Catalog"]="Monk",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=100,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[20511]={["Catalog"]="Warrior",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=15,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[47476]={["Catalog"]="DeathKnight",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[115001]={["Catalog"]="DeathKnight",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=6,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=6,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=16,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[19503]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Mesmerizes(short)",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[33786]={["Catalog"]="Druid",["MinRange"]=0,["PVPDRType"]="Cyclone",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=6,["CastTime"]=1700,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=6,["School"]=8,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[115782]={["Catalog"]="Warlock",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=40,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[118093]={["Catalog"]="Warlock",["MinRange"]=0,["PVPDRType"]="Disarms",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[339]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=35,["CoolDownType"]=0,["Length"]=30,["CastTime"]=1700,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[128405]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=8,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[676]={["Catalog"]="Warrior",["MinRange"]=0,["PVPDRType"]="Disarms",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[63685]={["Catalog"]="Shaman",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=16,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[122]={["Catalog"]="Mage",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=8,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=16,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=25,},[118699]={["Catalog"]="Warlock",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=20,["CastTime"]=0,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[88625]={["Catalog"]="Priest",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Mesmerizes(short)",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[115268]={["Catalog"]="Warlock",["MinRange"]=0,["PVPDRType"]="Fears",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=30,["CastTime"]=1700,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=32,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[137460]={["Catalog"]="Monk",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[107570]={["Catalog"]="Warrior",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[853]={["Catalog"]="Paladin",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=10,["CoolDownType"]=0,["Length"]=6,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=6,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[126246]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[120086]={["Catalog"]="Monk",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[91797]={["Catalog"]="DeathKnight",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[3355]={["Catalog"]="Hunter",["MinRange"]=0,["PVPDRType"]="Mesmerizes",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=10,["CoolDownType"]=0,["Length"]=60,["CastTime"]=0,["NewIcon"]="",["SpellType"]="Magic",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=8,["School"]=1,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[113952]={["Catalog"]="Rogue",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=50000,["CoolDownType"]=0,["Length"]=10,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Roots",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=20,},[9484]={["Catalog"]="Priest",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=50,["CastTime"]=1500,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=2,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[102793]={["Catalog"]="Druid",["MinRange"]=0,["PVPDRType"]="Knockbacks",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=0,["CastTime"]=0,["NewIcon"]="",["SpellType"]="None",["NewName"]="",["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=8,["MaxStack"]=0,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=60,},[64044]={["Catalog"]="Priest",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=1,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=1,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Horrors",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=45,},[710]={["Catalog"]="Warlock",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=30,["CastTime"]=1500,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[126423]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[6789]={["Catalog"]="Warlock",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=32,["PVPDRType"]="Horrors",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=45,},[123394]={["Catalog"]="Unsorted",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=4,["PVPDRType"]="Mesmerizes(short)",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[76780]={["Catalog"]="Shaman",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=50,["CastTime"]=1500,["NewIcon"]="",["PVPLength"]=8,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Mesmerizes",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[108194]={["Catalog"]="DeathKnight",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=30,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=30,},[1833]={["Catalog"]="Rogue",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=5,["CoolDownType"]=0,["Length"]=4,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=4,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=0,},[5211]={["Catalog"]="Druid",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=5,["CoolDownType"]=0,["Length"]=5,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=5,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=1,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=50,},[28730]={["Catalog"]="Player common",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["Length"]=3,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=3,["NewName"]="",["MaxStack"]=0,["SpellType"]="Magic",["CounterSpellLength"]=0,["School"]=64,["PVPDRType"]="Silences",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},[50519]={["Catalog"]="Hunter",["MinRange"]=0,["DispelAble"]=false,["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=20,["CoolDownType"]=0,["Length"]=2,["CastTime"]=0,["NewIcon"]="",["PVPLength"]=2,["NewName"]="",["MaxStack"]=0,["SpellType"]="None",["CounterSpellLength"]=0,["School"]=8,["PVPDRType"]="Stuns",["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CoolDown"]=120,},}',
			["nfrog's Blizzard Default nameplate"]='@Texture\\Blizzard ComboPoint Bg\\#{["Top"]=0,["RAngle"]=0,["Right"]=0.36,["Bottom"]=0.77,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["Mode"]="BLEND",["Left"]=0,["Texture"]="Interface\\ComboFrame\\combopoint.blp",}@NamePlateCondition\\#{[1]={["Profile"]="Blizzard",["Arg"]="",["ConditionType"]="Any",},}@Texture\\Blizzard Elite Icon\\#{["Top"]=0,["RAngle"]=0,["Right"]=1,["Bottom"]=1,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["Mode"]="BLEND",["Left"]=0,["Texture"]="Interface\\Tooltips\\EliteNameplateIcon",}@SpellLib\\42292\\#{["Catalog"]="Player common",["MinRange"]=0,["PVPDRType"]="PvP trinket",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["NewName"]="",["CastTime"]=0,["CoolDown"]=120,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=1,["MaxStack"]=0,["Length"]=0,["SpellType"]="None",["NewIcon"]="",}@BarGroup\\Blizzard Dafult CP\\#{["1"]={["EnableTextureChange"]=false,["PercentFrom"]=0.01,["ColorMode"]=0,["Layer"]="ARTWORK",["PercentTo"]=0.2,["Width"]=20,["MinColor"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["HideWhenMax"]=false,["Height"]=20,["MaxColor"]={["A"]=1,["B"]=1,["G"]=0.9921568627451,["R"]=1,},["AnchorData"]={["OffsetX"]=-120,["OffsetY"]=0,["To"]="CENTER",["From"]="LEFT",},["EnableSizeChange"]=false,["Direction"]=0,["ProfileName"]="Blizzard ComboPoint",},["3"]={["EnableTextureChange"]=false,["PercentFrom"]=0.41,["ColorMode"]=0,["Layer"]="ARTWORK",["PercentTo"]=0.6,["Width"]=20,["MinColor"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["HideWhenMax"]=false,["Height"]=20,["MaxColor"]={["A"]=1,["B"]=1,["G"]=0.9921568627451,["R"]=1,},["AnchorData"]={["OffsetX"]=-70,["OffsetY"]=0,["To"]="CENTER",["From"]="LEFT",},["EnableSizeChange"]=false,["Direction"]=0,["ProfileName"]="Blizzard ComboPoint",},["2"]={["Direction"]=0,["PercentFrom"]=0.21,["ColorMode"]=0,["Layer"]="ARTWORK",["PercentTo"]=0.4,["Width"]=20,["MaxColor"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["HideWhenMax"]=false,["Height"]=20,["MinColor"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["AnchorData"]={["OffsetX"]=-95,["OffsetY"]=0,["To"]="CENTER",["From"]="LEFT",},["EnableSizeChange"]=false,["EnableTextureChange"]=false,["ProfileName"]="Blizzard ComboPoint",},["5"]={["EnableTextureChange"]=false,["PercentFrom"]=0.81,["ColorMode"]=0,["Layer"]="ARTWORK",["PercentTo"]=1,["Width"]=20,["MinColor"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["HideWhenMax"]=false,["Height"]=20,["MaxColor"]={["A"]=1,["B"]=1,["G"]=0.9921568627451,["R"]=1,},["AnchorData"]={["OffsetX"]=-20,["OffsetY"]=0,["To"]="CENTER",["From"]="LEFT",},["EnableSizeChange"]=false,["Direction"]=0,["ProfileName"]="Blizzard ComboPoint",},["4"]={["Direction"]=0,["PercentFrom"]=0.61,["ColorMode"]=0,["Layer"]="ARTWORK",["PercentTo"]=0.8,["Width"]=20,["MaxColor"]={["A"]=1,["B"]=1,["G"]=0.9921568627451,["R"]=1,},["HideWhenMax"]=false,["Height"]=20,["MinColor"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["AnchorData"]={["OffsetX"]=-45,["OffsetY"]=0,["To"]="CENTER",["From"]="LEFT",},["EnableSizeChange"]=false,["EnableTextureChange"]=false,["ProfileName"]="Blizzard ComboPoint",},["3 Background"]={["Direction"]=0,["PercentFrom"]=0.01,["Layer"]="BORDER",["ColorMode"]=0,["PercentTo"]=1,["Width"]=20,["EnableTextureChange"]=false,["HideWhenMax"]=false,["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=-70,["From"]="LEFT",},["MinColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["Height"]=20,["EnableSizeChange"]=false,["MaxColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=0.96470588235294,},["ProfileName"]="Blizzard ComboPoint Bg",},["4 Background"]={["Direction"]=0,["PercentFrom"]=0.01,["Layer"]="BORDER",["ColorMode"]=0,["PercentTo"]=1,["Width"]=20,["EnableTextureChange"]=false,["HideWhenMax"]=false,["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=-45,["From"]="LEFT",},["MinColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["Height"]=20,["EnableSizeChange"]=false,["MaxColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=0.96470588235294,},["ProfileName"]="Blizzard ComboPoint Bg",},["1 Background"]={["Direction"]=0,["PercentFrom"]=0.01,["Layer"]="BORDER",["ColorMode"]=0,["PercentTo"]=1,["Width"]=20,["EnableTextureChange"]=false,["HideWhenMax"]=false,["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=-120,["From"]="LEFT",},["MinColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["Height"]=20,["EnableSizeChange"]=false,["MaxColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=0.96470588235294,},["ProfileName"]="Blizzard ComboPoint Bg",},["2 Background"]={["Direction"]=0,["PercentFrom"]=0.01,["Layer"]="BORDER",["ColorMode"]=0,["PercentTo"]=1,["Width"]=20,["EnableTextureChange"]=false,["HideWhenMax"]=false,["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=-95,["From"]="LEFT",},["MinColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["Height"]=20,["EnableSizeChange"]=false,["MaxColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=0.96470588235294,},["ProfileName"]="Blizzard ComboPoint Bg",},["5 Background"]={["EnableTextureChange"]=false,["PercentFrom"]=0.01,["Layer"]="BORDER",["ColorMode"]=0,["PercentTo"]=1,["Width"]=20,["Direction"]=0,["HideWhenMax"]=false,["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=-20,["From"]="LEFT",},["MaxColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=0.96470588235294,},["Height"]=20,["EnableSizeChange"]=false,["MinColor"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["ProfileName"]="Blizzard ComboPoint Bg",},}@Core\\AdvancedType\\#true@Texture\\QuestNunberBgCircle outer\\#{["Top"]=0,["RAngle"]=0,["Mode"]="BLEND",["Bottom"]=0.25,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Right"]=0.25,["Left"]=0,["Texture"]="Interface\\LFGFrame\\UI-LFG-ICON-ROLES",}@Number\\integer\\#{["ValueType"]=1,["MaxTextData"]={["Width"]=0,["Decimal"]=false,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["ColorMode"]=0,["Height"]=11,["ProfileName"]="Default",},["ValueTextData"]={["Width"]=0,["Decimal"]=true,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["ColorMode"]=1,["Height"]=11,["ProfileName"]="Default",},["MinColor"]={["A"]=1,["R"]=1,["G"]=0,["B"]=0,},["MaxType"]=0,["PercentTextData"]={["Width"]=0,["Decimal"]=true,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["ColorMode"]=0,["Height"]=11,["ProfileName"]="Default",},["MaxColor"]={["A"]=1,["R"]=0,["G"]=1,["B"]=0,},["PercentType"]=0,}@Core\\NamePlateModules\\#{["Number"]=true,["TextureGroup"]=true,["Default"]=true,["IconGroup"]=true,["Icon"]=true,["Text"]=true,["BarGroup"]=true,["MainFrame"]=true,}@Number\\persent\\#{["ValueType"]=0,["MaxTextData"]={["Width"]=0,["Decimal"]=false,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["ColorMode"]=0,["Height"]=11,["ProfileName"]="Default",},["ValueTextData"]={["Width"]=0,["Decimal"]=false,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["ColorMode"]=0,["Height"]=11,["ProfileName"]="Default",},["MinColor"]={["A"]=1,["R"]=1,["G"]=0,["B"]=0,},["MaxType"]=0,["PercentTextData"]={["Width"]=0,["Decimal"]=false,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["ColorMode"]=0,["Height"]=11,["ProfileName"]="Default",},["MaxColor"]={["A"]=1,["R"]=0,["G"]=1,["B"]=0,},["PercentType"]=3,}@SpellLib\\7744\\#{["Catalog"]="Player common",["MinRange"]=0,["PVPDRType"]="PvP trinket",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["NewName"]="",["CastTime"]=0,["CoolDown"]=120,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=1,["MaxStack"]=0,["Length"]=0,["SpellType"]="None",["NewIcon"]="",}@SpellLib\\59752\\#{["Catalog"]="Player common",["MinRange"]=0,["PVPDRType"]="PvP trinket",["CoolDownStack"]=0,["NoDR"]=false,["MaxRange"]=0,["CoolDownType"]=0,["NewName"]="",["CastTime"]=0,["CoolDown"]=120,["DispelAble"]=false,["AffectSpellList"]={[1]={["AffectAmount"]=0,["AffectType"]=0,},},["CounterSpellLength"]=0,["PVPLength"]=0,["School"]=1,["MaxStack"]=0,["Length"]=0,["SpellType"]="None",["NewIcon"]="",}@NamePlate\\Blizzard\\#{["ScaleSetting"]={[1]={["Scale"]=0.8,["Arg"]="3",["ConditionType"]="NonPlayer",},[2]={["Scale"]=0.8,["Arg"]="1",["ConditionType"]="NonPlayer",},},["IconGroupSetting"]={["Diminish Return"]={["PerRow"]=3,["Direction"]=1,["FrameLevel"]=1,["GapX"]=2,["Scale"]=2,["Alpha"]=1,["DataType"]="CC_DR",["GapY"]=2,["DataRules"]={["Debuff"]={["FrameLevel"]=1,["SpellList"]={[113275]=true,[132469]=true,[113004]=true,[113506]=true,[99]=true,[9005]=true,[2637]=true,[113801]=true,[114237]=true,[22570]=true,[33786]=true,[113056]=true,[102793]=true,[5211]=true,[102795]=true,[102359]=true,[339]=true,[19975]=true,},["Alpha"]=1,["FilterType"]=2,["Modules"]={["Icon"]={["ModuleType"]="Icon",["Scale"]=1,["ColorMode"]=0,["Alpha"]=1,["DataType"]="Stack",["Width"]=10,["Height"]=10,["FrameLevel"]=1,["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=0,["From"]="CENTER",},["ProfileName"]=" ",},["Time"]={["ModuleType"]="Number",["Scale"]=0.5,["ColorMode"]=0,["Alpha"]=1,["DataType"]="Time",["Width"]=10,["Height"]=10,["FrameLevel"]=1,["AnchorData"]={["To"]="TOP",["OffsetY"]=0,["OffsetX"]=0,["From"]="TOP",},["ProfileName"]="integer",},},["FromType"]=1,["SchoolList"]={["Enrage"]=true,["Bleed"]=true,["Poison"]=true,["Curse"]=true,["Magic"]=true,["None"]=true,},["Height"]=10,["Priority"]=1,["Width"]=10,["Scale"]=1,},},["TimeLimit"]=60,["Max"]=6,["FrameAnchorData"]={["To"]="TOP",["OffsetY"]=0,["OffsetX"]=-8,["From"]="BOTTOMLEFT",},["AnchorFrame"]="LevelText",},["Debuff"]={["PerRow"]=4,["Direction"]=1,["FrameLevel"]=1,["GapX"]=2,["Scale"]=1,["Alpha"]=1,["DataType"]="Aura",["GapY"]=2,["DataRules"]={["Debuff(self)"]={["FrameLevel"]=1,["Scale"]=1,["Alpha"]=1,["FilterType"]=2,["Modules"]={["Icon"]={["ModuleType"]="Icon",["Scale"]=1,["ColorMode"]=0,["Alpha"]=1,["DataType"]="Stack",["Width"]=20,["Height"]=20,["FrameLevel"]=1,["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=0,["From"]="CENTER",},["ProfileName"]=" ",},["Text"]={["ModuleType"]="Number",["Scale"]=1,["ColorMode"]=0,["Alpha"]=1,["DataType"]="Time",["Width"]=10,["Height"]=10,["FrameLevel"]=10,["AnchorData"]={["To"]="BOTTOM",["OffsetY"]=0,["OffsetX"]=0,["From"]="BOTTOM",},["ProfileName"]="integer",},},["FromType"]=2,["SchoolList"]={["Enrage"]=true,["Bleed"]=true,["Poison"]=true,["Curse"]=true,["Magic"]=true,["None"]=true,},["Height"]=20,["Priority"]=1,["Width"]=20,["SpellList"]={},},},["TimeLimit"]=60,["Max"]=8,["FrameAnchorData"]={["OffsetX"]=0,["OffsetY"]=5,["To"]="TOP",["From"]="BOTTOM",},["AnchorFrame"]="NameText",},["PvP Trinket"]={["PerRow"]=1,["Direction"]=1,["FrameLevel"]=1,["GapX"]=2,["Scale"]=1.2,["Alpha"]=1,["DataType"]="CoolDown",["GapY"]=2,["DataRules"]={["PvP Trinket"]={["FrameLevel"]=1,["SpellList"]={[7744]=true,[42292]=true,[59752]=true,},["Alpha"]=1,["FilterType"]=3,["Modules"]={["Cooldown"]={["ModuleType"]="Number",["Scale"]=1,["ColorMode"]=0,["Alpha"]=1,["DataType"]="Time",["Width"]=10,["Height"]=10,["AnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["FrameLevel"]=2,["ProfileName"]="integer",},["PvP Trinket Texture"]={["ModuleType"]="Texture",["Scale"]=1,["ColorMode"]=0,["Alpha"]=1,["DataType"]="Stack",["Width"]=20,["Height"]=20,["AnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["FrameLevel"]=1,["ProfileName"]="PvP Trinket Texture",},},["Scale"]=1,["SchoolList"]={["Enrage"]=true,["Bleed"]=true,["Curse"]=true,["Poison"]=true,["Magic"]=true,["None"]=true,},["Height"]=10,["Priority"]=1,["Width"]=10,["FromType"]=1,},},["TimeLimit"]=120,["Max"]=1,["FrameAnchorData"]={["OffsetX"]=4,["OffsetY"]=-4,["To"]="RIGHT",["From"]="LEFT",},["AnchorFrame"]="LevelText",},},["NumberSetting"]={["Casting"]={["AnchorFrame"]="CastingBarGroup",["FrameAnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["FrameLevel"]=6,["ProfileName"]="integer",["Scale"]=1,["ColorMode"]=0,["Alpha"]=1,["DataType"]="Casting",},["Health"]={["AnchorFrame"]="HealthBarGroup",["FrameAnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["FrameLevel"]=2,["ProfileName"]="persent",["Scale"]=1,["ColorMode"]=0,["Alpha"]=1,["DataType"]="Health",},["Quest"]={["AnchorFrame"]="Quest Bg CircleTextureGroup",["FrameAnchorData"]={["OffsetX"]=2,["OffsetY"]=1,["To"]="CENTER",["From"]="CENTER",},["FrameLevel"]=3,["ProfileName"]="integer",["Scale"]=1,["ColorMode"]=0,["Alpha"]=1,["DataType"]="Quest",},},["TextSetting"]={["SpellLock"]={["FrameLevel"]=1,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Layer"]="BACKGROUND",["Alpha"]=1,["Width"]=0,["AnchorFrame"]="HealthBarGroup",["DataType"]="SpellLock",["Scale"]=1,["Height"]=11,["ColorMode"]=0,["FrameAnchorData"]={["OffsetX"]=0,["OffsetY"]=-35,["To"]="BOTTOM",["From"]="TOP",},["ProfileName"]="Default",},["Casting"]={["FrameLevel"]=1,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Layer"]="BACKGROUND",["Alpha"]=1,["Width"]=0,["AnchorFrame"]="CastingBarGroup",["DataType"]="Casting",["Scale"]=1,["Height"]=11,["ColorMode"]=0,["FrameAnchorData"]={["OffsetX"]=0,["OffsetY"]=-12,["To"]="CENTER",["From"]="CENTER",},["ProfileName"]="Default",},["Name"]={["FrameLevel"]=1,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Layer"]="BACKGROUND",["Alpha"]=1,["Width"]=0,["AnchorFrame"]="HealthBarGroup",["DataType"]="Name",["Scale"]=1,["Height"]=12,["ColorMode"]=0,["FrameAnchorData"]={["OffsetX"]=0,["OffsetY"]=6,["To"]="TOP",["From"]="BOTTOM",},["ProfileName"]="Default",},["Level"]={["FrameLevel"]=1,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Layer"]="BACKGROUND",["Alpha"]=1,["Width"]=0,["AnchorFrame"]="HealthBarGroup",["DataType"]="Level",["Scale"]=1,["Height"]=12,["ColorMode"]=8,["FrameAnchorData"]={["OffsetX"]=3,["OffsetY"]=1,["To"]="RIGHT",["From"]="LEFT",},["ProfileName"]="Default",},},["AlphaSetting"]={[1]={["Arg"]="Target",["Alpha"]=1,["ConditionType"]="Target",},[2]={["Arg"]="Mouseover",["Alpha"]=0.8,["ConditionType"]="Target",},[3]={["Arg"]="1",["Alpha"]=0.2,["ConditionType"]="Any",},},["IconSetting"]={["Casting"]={["FrameLevel"]=2,["Scale"]=1,["Layer"]="BACKGROUND",["Alpha"]=1,["Width"]=20,["Height"]=20,["DataType"]="Casting",["FrameAnchorData"]={["OffsetX"]=-1,["OffsetY"]=0,["To"]="LEFT",["From"]="RIGHT",},["AnchorFrame"]="CastingBarGroup",},["RaidIcon"]={["FrameLevel"]=1,["Scale"]=1.4,["Layer"]="BACKGROUND",["Alpha"]=1,["Width"]=20,["Height"]=20,["DataType"]="RaidTarget",["FrameAnchorData"]={["To"]="TOPLEFT",["OffsetY"]=0,["OffsetX"]=0,["From"]="BOTTOMRIGHT",},["AnchorFrame"]="HealthBarGroup",},},["BarGroupSetting"]={["Casting"]={["FrameLevel"]=1,["Scale"]=1,["ColorMode"]=5,["SmoothTime"]=0,["Width"]=122,["AnchorFrame"]="矫傈官 抛滴府TextureGroup",["DataType"]="Casting",["Alpha"]=1,["Height"]=11,["ShadowAlpha"]=0.5,["FrameAnchorData"]={["OffsetX"]=11,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["ProfileName"]="Default",},["Health"]={["FrameLevel"]=0,["Scale"]=1,["ColorMode"]=2,["SmoothTime"]=0,["Width"]=120,["AnchorFrame"]="MainFrame",["DataType"]="Health",["Alpha"]=0.9,["Height"]=11,["ShadowAlpha"]=0,["FrameAnchorData"]={["OffsetX"]=-10,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["ProfileName"]="Default",},["ComboPoints"]={["FrameLevel"]=1,["Scale"]=1,["ColorMode"]=0,["SmoothTime"]=0,["Width"]=70,["AnchorFrame"]="HealthBarGroup",["DataType"]="ComboPoints",["Alpha"]=1,["Height"]=12,["ShadowAlpha"]=1,["FrameAnchorData"]={["OffsetX"]=0,["OffsetY"]=2,["To"]="BOTTOM",["From"]="TOP",},["ProfileName"]="Blizzard Dafult CP",},},["FrameLevelSetting"]={["1"]={["Arg"]=" ",["FrameLevel"]=1,["ConditionType"]="Default",},},["OffsetSetting"]={},["DefaultSetting"]={["LevelText"]={["Anchor"]="CENTER",["Font"]="Fonts\\2002.TTF",["OffsetX"]=-12,["AnchorTo"]="BOTTOMRIGHT",["Enable"]=false,["OffsetY"]=10,["Height"]=13,["Width"]=0,},["HealthBar"]={["Texture"]="Interface\\TargetingFrame\\UI-TargetingFrame-BarFill",["Enable"]=false,["OffsetX"]=4,["AnchorTo"]="BOTTOMLEFT",["Anchor"]="BOTTOMLEFT",["OffsetY"]=5,["Height"]=10,["Width"]=105,},["SpellIcon"]={["Height"]=15,["OffsetX"]=-52,["AnchorTo"]="CENTER",["Anchor"]="CENTER",["OffsetY"]=10,["Enable"]=false,["Width"]=15,},["NameText"]={["Anchor"]="BOTTOM",["Font"]="Fonts\\2002.TTF",["OffsetX"]=0,["AnchorTo"]="CENTER",["Enable"]=false,["OffsetY"]=0,["Height"]=13,["Width"]=0,},["BossIcon"]={["Texture"]="Interface\\TargetingFrame\\UI-TargetingFrame-Skull",["Enable"]=false,["OffsetX"]=-12,["AnchorTo"]="BOTTOMRIGHT",["Anchor"]="CENTER",["OffsetY"]=10,["Height"]=14,["Width"]=14,},["EliteIcon"]={["Texture"]="Interface\\Tooltips\\EliteNameplateicon",["Enable"]=false,["OffsetX"]=-8,["AnchorTo"]="BOTTOMRIGHT",["Anchor"]="CENTER",["OffsetY"]=9,["Height"]=31,["Width"]=43,},["ThreatGlow"]={["Texture"]="Interface\\TargetingFrame\\UI-TargetingFrame-Flash",["Enable"]=false,["OffsetX"]=-8,["AnchorTo"]="BOTTOMLEFT",["Anchor"]="BOTTOMLEFT",["OffsetY"]=-13,["Height"]=40,["Width"]=143,},["CastBarShield"]={["Texture"]="Interface\\Tooltips\\Nameplate-CastBar-Shiled",["Enable"]=false,["OffsetX"]=60,["AnchorTo"]="CENTER",["Anchor"]="CENTER",["OffsetY"]=-36,["Height"]=36,["Width"]=130,},["Highlight"]={["Texture"]="",["Enable"]=false,["OffsetX"]=0,["AnchorTo"]="TOPLEFT",["Anchor"]="TOPLEFT",["OffsetY"]=0,["Height"]=36,["Width"]=130,},["CastBarOverlay"]={["Texture"]="Interface\\Tooltips\\Nameplate-Border",["Enable"]=false,["OffsetX"]=0,["AnchorTo"]="CENTER",["Anchor"]="CENTER",["OffsetY"]=-18,["Height"]=36,["Width"]=130,},["RaidIcon"]={["Texture"]="Interface\\TargetingFrame\\UI-RaidTargetingIcons",["Enable"]=false,["OffsetX"]=0,["AnchorTo"]="TOPLEFT",["Anchor"]="RIGHT",["OffsetY"]=-18,["Height"]=29,["Width"]=29,},["CastBar"]={["Texture"]="Interface\\TargetingFrame\\UI-TargetingFrame-BarFill",["Enable"]=false,["OffsetX"]=60,["AnchorTo"]="CENTER",["Anchor"]="BOTTOMRIGHT",["OffsetY"]=-5,["Height"]=10,["Width"]=105,},["Overlay"]={["Texture"]="Interface\\Tooltips\\Nameplate-Border",["Enable"]=false,["OffsetX"]=0,["AnchorTo"]="TOPLEFT",["Anchor"]="TOPLEFT",["OffsetY"]=0,["Height"]=36,["Width"]=130,},},["TextureGroupSetting"]={["沥抗 钎矫"]={["FrameLevel"]=0,["Scale"]=2,["Alpha"]=1,["DataType"]="Classification_Elite",["TextureGroup"]={["1"]={["ProfileName"]="Blizzard Elite Icon",["AnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["Layer"]="BACKGROUND",["Height"]=20,["Width"]=35,},},["Height"]=20,["Width"]=20,["FrameAnchorData"]={["OffsetX"]=15,["OffsetY"]=-2,["To"]="RIGHT",["From"]="LEFT",},["AnchorFrame"]="HealthBarGroup",},["Quest Bg Circle"]={["FrameLevel"]=2,["Scale"]=1,["Alpha"]=1,["DataType"]="Quest",["TextureGroup"]={["Outer circl"]={["ProfileName"]="QuestNunberBgCircle outer",["AnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["Layer"]="BACKGROUND",["Height"]=24,["Width"]=24,},["Inner circle"]={["Width"]=18,["Height"]=18,["Layer"]="BORDER",["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=0,["From"]="CENTER",},["ProfileName"]="QuestNunberBgCircle Inner",},},["Height"]=22,["Width"]=22,["FrameAnchorData"]={["OffsetX"]=11,["OffsetY"]=-1,["To"]="RIGHT",["From"]="LEFT",},["AnchorFrame"]="LevelText",},["Healthbar"]={["FrameLevel"]=0,["Scale"]=1,["Alpha"]=1,["DataType"]="None",["TextureGroup"]={["1"]={["ProfileName"]="Blizzard Border",["Height"]=20,["Layer"]="BACKGROUND",["AnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["Width"]=150,},},["Height"]=16,["Width"]=146,["FrameAnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["AnchorFrame"]="MainFrame",},["CasingShield"]={["FrameLevel"]=0,["Scale"]=1,["Alpha"]=1,["DataType"]="CastingShield",["TextureGroup"]={["1"]={["ProfileName"]="Blizzard Spell Interrupt Shield",["Height"]=36,["Layer"]="BORDER",["AnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["Width"]=150,},},["Height"]=20,["Width"]=20,["FrameAnchorData"]={["OffsetX"]=0,["OffsetY"]=0,["To"]="CENTER",["From"]="CENTER",},["AnchorFrame"]="矫傈官 抛滴府TextureGroup",},["快滴赣府 沥抗钎矫"]={["FrameLevel"]=0,["Scale"]=2,["Alpha"]=1,["DataType"]="Classification_WorldBoss",["TextureGroup"]={["秦榜"]={["Width"]=9,["Height"]=9,["Layer"]="ARTWORK",["AnchorData"]={["To"]="CENTER",["OffsetY"]=2,["OffsetX"]=-9,["From"]="CENTER",},["ProfileName"]="Blizzard Skull Icon",},["沥抗 抛滴府"]={["Width"]=35,["Height"]=20,["Layer"]="BACKGROUND",["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=0,["From"]="CENTER",},["ProfileName"]="Blizzard Elite Icon",},},["Height"]=20,["Width"]=20,["FrameAnchorData"]={["OffsetX"]=15,["OffsetY"]=-2,["To"]="RIGHT",["From"]="LEFT",},["AnchorFrame"]="HealthBarGroup",},["矫傈官 抛滴府"]={["FrameLevel"]=0,["Scale"]=1,["Alpha"]=0.7,["DataType"]="Casting",["TextureGroup"]={["1"]={["Width"]=150,["AnchorData"]={["To"]="CENTER",["OffsetY"]=0,["OffsetX"]=0,["From"]="CENTER",},["Layer"]="BACKGROUND",["Height"]=20,["ProfileName"]="Blizzard Border Invert",},},["Height"]=14,["Width"]=144,["FrameAnchorData"]={["To"]="CENTER",["OffsetY"]=-22,["OffsetX"]=0,["From"]="CENTER",},["AnchorFrame"]="HealthbarTextureGroup",},},}@Core\\PowerMatch\\#true@Texture\\Blizzard Border\\#{["Top"]=0,["RAngle"]=0,["Mode"]="BLEND",["Bottom"]=1,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Right"]=1,["Left"]=0,["Texture"]="Interface\\Addons\\NPA2\\texture\\defaultborder",}@Texture\\Blizzard ComboPoint\\#{["Top"]=0.09,["RAngle"]=0,["Right"]=0.59,["Bottom"]=0.56,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["Mode"]="BLEND",["Left"]=0.36,["Texture"]="Interface\\ComboFrame\\combopoint.blp",}@Texture\\Blizzard Bar Interrupt Shield\\#{["Top"]=0,["RAngle"]=0,["Mode"]="BLEND",["Bottom"]=1,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Right"]=1,["Left"]=0,["Texture"]="Interface\\Addons\\NPA2\\texture\\barshield",}@Texture\\Blizzard Skull Icon\\#{["Top"]=0,["RAngle"]=0,["Right"]=1,["Bottom"]=1,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["Mode"]="BLEND",["Left"]=0,["Texture"]="Interface\\TargetingFrame\\UI-TargetingFrame-Skull",}@Core\\DataCollectors\\#{["Guild"]=true,["UnitID"]=true,["CC_DR"]=true,["Aura"]=true,["Target"]=false,["Level"]=true,["ComboPoints"]=true,["Quest"]=true,["NPCGuild"]=true,["Classification"]=true,["Threat"]=true,["Power"]=true,["SpellLock"]=true,["RaidTarget"]=true,["Alpha"]=true,["Summoned"]=true,["Friends"]=true,["Tapped"]=true,["Health"]=true,["Speed"]=true,["Name"]=true,["Casting"]=true,["Type"]=true,["CoolDown"]=false,}@Texture\\QuestNunberBgCircle Inner\\#{["Top"]=0.52,["RAngle"]=0,["Mode"]="BLEND",["Bottom"]=0.76,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Right"]=0.25,["Left"]=0,["Texture"]="Interface\\LFGFrame\\UI-LFG-ICON-ROLES",}@Texture\\Blizzard Role Icons\\#{["Top"]=0,["RAngle"]=0,["Mode"]="BLEND",["Bottom"]=1,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Right"]=1,["Left"]=0,["Texture"]="Interface\\LFGFrame\\UI-LFG-ICON-ROLES",}@Texture\\Blizzard Border Invert\\#{["Top"]=0,["RAngle"]=0,["Mode"]="BLEND",["Bottom"]=1,["Color"]={["A"]=1,["B"]=1,["G"]=1,["R"]=1,},["Right"]=0,["Left"]=1,["Texture"]="Interface\\Addons\\NPA2\\texture\\defaultborder",}@Texture\\PvP Trinket Texture\\#{["Top"]=0,["RAngle"]=359,["Right"]=1,["Bottom"]=1,["Color"]={["A"]=1,["R"]=1,["G"]=1,["B"]=1,},["Mode"]="BLEND",["Left"]=0,["Texture"]="Interface\\Icons\\INV_Jewelry_TrinketPVP_02",}@Core\\EnableAuraCache\\#true',
		}
	}
end