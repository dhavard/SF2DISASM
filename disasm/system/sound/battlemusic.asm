
; SCRIPT SECTION system\sound\battlemusic :
; Battle music function

; =============== S U B R O U T I N E =======================================

; overrides music index if we're in a battle

LoadBattleMusic:
										
										move.w  d0,-(sp)
										clr.w   d0
										move.b  ((MAP_AREA_MUSIC_INDEX-$1000000)).w,d0
loc_454C:
										cmpi.b  #$FF,((CURRENT_BATTLE-$1000000)).w
										beq.s   loc_4586
loc_4554:
										cmpi.b  #0,d0
										bne.s   loc_455E
loc_455A:
										move.w  #MUSIC_BATTLE_THEME_3,d0
																						; HARDCODED music indexes here
loc_455E:
										cmpi.b  #MUSIC_TOWN,d0
										bne.s   loc_4568
										move.w  #MUSIC_BATTLE_THEME_3,d0
loc_4568:
										cmpi.b  #MUSIC_MITULA,d0
										bne.s   loc_4572
										move.w  #MUSIC_BATTLE_THEME_3,d0
loc_4572:
										cmpi.b  #MUSIC_MITULA_SHRINE,d0
										bne.s   loc_457C
										move.w  #MUSIC_BATTLE_THEME_1,d0
loc_457C:
										cmpi.b  #MUSIC_CASTLE,d0
										bne.s   loc_4586
										move.w  #MUSIC_BATTLE_THEME_1,d0
loc_4586:
										trap    #SOUND_COMMAND
										dc.w SOUND_COMMAND_GET_D0_PARAMETER
										move.w  (sp)+,d0
										rts

	; End of function LoadBattleMusic

