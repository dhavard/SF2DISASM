
; SCRIPT SECTION system\scripting\map\mapscriptengine_1 :
; Mapscript engine, part 1

; =============== S U B R O U T I N E =======================================

csc32_setCameraDestInTiles:
										
										move.b  #$FF,((BATTLE_CURRENT_ENTITY-$1000000)).w
										nop
										move.w  (a6)+,d2
										move.w  (a6)+,d3
										jsr     j_SetCameraDestInTiles
										jsr     (WaitForCameraToCatchUp).w
										rts

	; End of function csc32_setCameraDestInTiles


; =============== S U B R O U T I N E =======================================

csc33_setQuakeAmount:
										
										move.w  (a6)+,d0
										move.w  d0,d3
										andi.w  #$3FFF,d0
										move.w  d0,d7
										subq.w  #1,d7
										btst    #$F,d3
										beq.s   loc_46538
										moveq   #0,d1
										move.w  #1,d2
										bra.s   loc_46550
loc_46538:
										
										btst    #$E,d3
										beq.s   loc_46546
										move.w  d0,d1
										move.w  #$FFFF,d2
										bra.s   loc_46550
loc_46546:
										
										move.w  d0,(word_FFA80C).l
										bra.w   return_46564
loc_46550:
										
										move.w  #$28,d0 
loc_46554:
										
										add.w   d2,d1
										move.w  d1,(word_FFA80C).l
										jsr     (Sleep).w       
										dbf     d7,loc_46554
return_46564:
										
										rts

	; End of function csc33_setQuakeAmount


; =============== S U B R O U T I N E =======================================

csc34_setBlocks:
										
										move.w  (a6)+,d0
										move.w  (a6)+,d1
										move.w  (a6)+,d2
										jsr     (sub_3DB0).w
										bset    #0,(byte_FFA82D).l
										bset    #1,(byte_FFA82D).l
										rts

	; End of function csc34_setBlocks


; =============== S U B R O U T I N E =======================================

; similar to setBlocks

csc35_:
										move.w  (a6)+,d0
										move.w  (a6)+,d1
										move.w  (a6)+,d2
										jsr     (sub_3DB0).w
										rts

	; End of function csc35_


; =============== S U B R O U T I N E =======================================

; related to loading a map

csc36_:
										move.l  a6,-(sp)
										jsr     (sub_3E06).l
										movea.l (sp)+,a6
										rts

	; End of function csc36_


; =============== S U B R O U T I N E =======================================

csc37_loadMapAndFadeIn:
										
										move.b  #OUT_TO_BLACK,((FADING_SETTING-$1000000)).w
										clr.w   (word_FFDFAA).l 
										clr.b   ((FADING_POINTER-$1000000)).w
										move.b  ((FADING_COUNTER_MAX-$1000000)).w,((FADING_COUNTER-$1000000)).w
										move.b  #$F,((FADING_PALETTE_FLAGS-$1000000)).w

	; End of function csc37_loadMapAndFadeIn


; =============== S U B R O U T I N E =======================================

csc48_loadMap:
										
										move.b  #$FF,((BATTLE_CURRENT_ENTITY-$1000000)).w
										nop
										move.w  (a6),d1
										jsr     (LoadMapTilesets).w
loc_465C4:
										
										jsr     (WaitForVInt).w 
										tst.b   ((FADING_SETTING-$1000000)).w
										bne.s   loc_465C4
										trap    #VINT_FUNCTIONS
										dc.w VINTS_DEACTIVATE
										dc.l 0
										clr.l   d0
										move.w  (a6)+,d1
										move.w  (a6)+,d0
										lsl.w   #8,d0
										move.w  (a6)+,d2
										andi.w  #$FF,d2
										or.w    d2,d0
										mulu.w  #3,d0
										move.l  a6,-(sp)
										jsr     (LoadMap).w     
										movea.l (sp)+,a6
										jsr     (EnableDisplayAndInterrupts).w
										trap    #VINT_FUNCTIONS
										dc.w VINTS_ACTIVATE
										dc.l 0
										jsr     (WaitForVInt).w 
										rts

	; End of function csc48_loadMap


; =============== S U B R O U T I N E =======================================

csc39_fadeInFromBlack:
										
										jsr     (FadeInFromBlack).w
										rts

	; End of function csc39_fadeInFromBlack


; =============== S U B R O U T I N E =======================================

csc3A_fadeOutToBlack:
										
										jsr     (FadeOutToBlack).w
										rts

	; End of function csc3A_fadeOutToBlack


; =============== S U B R O U T I N E =======================================

csc3B_slowFadeInFromBlack:
										
										move.b  ((FADING_COUNTER_MAX-$1000000)).w,d0
										move.b  #6,((FADING_COUNTER_MAX-$1000000)).w
										jsr     (FadeInFromBlack).w
										move.b  d0,((FADING_COUNTER_MAX-$1000000)).w
										rts

	; End of function csc3B_slowFadeInFromBlack


; =============== S U B R O U T I N E =======================================

csc3C_slowFadeOutToBlack:
										
										move.b  ((FADING_COUNTER_MAX-$1000000)).w,d0
										move.b  #6,((FADING_COUNTER_MAX-$1000000)).w
										jsr     (FadeOutToBlack).w
										move.b  d0,((FADING_COUNTER_MAX-$1000000)).w
										rts

	; End of function csc3C_slowFadeOutToBlack


; =============== S U B R O U T I N E =======================================

csc3D_tintMap:
										
										moveq   #1,d0
										moveq   #6,d1
										moveq   #HALF_OUT_TO_BLACK,d2
										jsr     LaunchFading(pc)
										nop
										rts

	; End of function csc3D_tintMap


; =============== S U B R O U T I N E =======================================

csc3E_FlickerOnce:
										
										moveq   #1,d0
										moveq   #6,d1
										moveq   #FLICKER_ONCE,d2
										jsr     LaunchFading(pc)
										nop
										rts

	; End of function csc3E_FlickerOnce


; =============== S U B R O U T I N E =======================================

csc3F_fadeMapOutToWhite:
										
										moveq   #1,d0
										moveq   #1,d1
										moveq   #OUT_TO_WHITE,d2
										jsr     LaunchFading(pc)
										nop
										rts

	; End of function csc3F_fadeMapOutToWhite


; =============== S U B R O U T I N E =======================================

csc40_fadeMapInFromWhite:
										
										moveq   #1,d0
										moveq   #1,d1
										moveq   #IN_FROM_WHITE,d2
										jsr     LaunchFading(pc)
										nop
										rts

	; End of function csc40_fadeMapInFromWhite


; =============== S U B R O U T I N E =======================================

csc41_flashScreenWhite:
										
										move.w  (a6)+,d7
										lsr.w   #3,d7
										moveq   #$F,d0
										moveq   #1,d1
										moveq   #FLASH_QUICKLY_2,d2
loc_4667A:
										
										jsr     LaunchFading(pc)
										nop
										dbf     d7,loc_4667A
										jsr     (DuplicatePalettes).w
										rts

	; End of function csc41_flashScreenWhite


; =============== S U B R O U T I N E =======================================

csc42_:
										trap    #VINT_FUNCTIONS
										dc.w VINTS_DEACTIVATE
										dc.l 0
										jsr     (DisableDisplayAndVInt).w
										movea.l (a6)+,a0
										move.w  (a0)+,d1
										move.w  (a0)+,d2
										move.w  (a0)+,d3
										jsr     InitMapEntities
										jsr     (LoadMapEntitySprites).w
										jsr     (EnableDisplayAndInterrupts).w
										trap    #VINT_FUNCTIONS
										dc.w VINTS_ACTIVATE
										dc.l 0
										rts

	; End of function csc42_


; =============== S U B R O U T I N E =======================================

csc43_:
										move.w  (a6)+,d0
										move.w  (a6)+,d1
										mulu.w  #$180,d0
										mulu.w  #$180,d1
										jsr     (PerformMapBlockCopyScript).w
										rts

	; End of function csc43_


; =============== S U B R O U T I N E =======================================

csc44_:
										trap    #VINT_FUNCTIONS
										dc.w VINTS_DEACTIVATE
										dc.l 0
										moveq   #0,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										moveq   #0,d1
										move.w  (a5),d1
										divu.w  #$180,d1
										moveq   #0,d2
										move.w  ENTITYDEF_OFFSET_Y(a5),d2
										divu.w  #$180,d2
										clr.w   d3
										move.b  ENTITYDEF_OFFSET_FACING(a5),d3
										movea.l (a6)+,a0
										jsr     InitMapEntities
										trap    #VINT_FUNCTIONS
										dc.w VINTS_ACTIVATE
										dc.l 0
										rts

	; End of function csc44_


; =============== S U B R O U T I N E =======================================

; related to camera adjust to lpayer

csc45_:
										move.w  (a6)+,((word_FFB194-$1000000)).w
										nop
										rts

	; End of function csc45_


; =============== S U B R O U T I N E =======================================

csc46_:
										move.b  #$FF,((BATTLE_CURRENT_ENTITY-$1000000)).w
										nop
										trap    #VINT_FUNCTIONS
										dc.w VINTS_DEACTIVATE
										dc.l 0
										clr.l   d0
										moveq   #$FFFFFFFF,d1
										move.w  (a6)+,d0
										lsl.w   #8,d0
										move.w  (a6)+,d2
										andi.w  #$FF,d2
										or.w    d2,d0
										mulu.w  #3,d0
										move.l  a6,-(sp)
										jsr     (LoadMap).w     
										movea.l (sp)+,a6
										jsr     (EnableDisplayAndInterrupts).w
										trap    #VINT_FUNCTIONS
										dc.w VINTS_ACTIVATE
										dc.l 0
										jsr     (WaitForVInt).w 
										rts

	; End of function csc46_


; =============== S U B R O U T I N E =======================================

csc47_:
										move.w  (a6)+,d0
										move.w  (a6)+,d1
										mulu.w  #$180,d0
										mulu.w  #$180,d1
										jsr     (sub_3E40).w    
										rts

	; End of function csc47_


; =============== S U B R O U T I N E =======================================

csc49_:
										trap    #VINT_FUNCTIONS
										dc.w VINTS_DEACTIVATE
										dc.l 0
										jsr     (DisableDisplayAndVInt).w
										jsr     GetMapSetupEntityList
										move.w  (a6)+,d1
										move.w  (a6)+,d2
										move.w  (a6)+,d3
										jsr     j_InitMapEntities
										jsr     (LoadMapEntitySprites).w
										jsr     (EnableDisplayAndInterrupts).w
										trap    #VINT_FUNCTIONS
										dc.w VINTS_ACTIVATE
										dc.l 0
										rts

	; End of function csc49_


; =============== S U B R O U T I N E =======================================

csc4A_fadeInFromBlackHalf:
										
										moveq   #$F,d0
										moveq   #6,d1
										moveq   #HALF_IN_FROM_BLACK,d2
										jsr     LaunchFading(pc)
										nop
										rts

	; End of function csc4A_fadeInFromBlackHalf


; =============== S U B R O U T I N E =======================================

csc4B_fadeOutToBlackHalf:
										
										moveq   #$F,d0
										moveq   #6,d1
										moveq   #OUT_TO_BLACK_2,d2
										jsr     LaunchFading(pc)
										nop
										rts

	; End of function csc4B_fadeOutToBlackHalf


; =============== S U B R O U T I N E =======================================

LaunchFading:
										
										move.b  d3,-(sp)
										move.b  ((FADING_COUNTER_MAX-$1000000)).w,d3
										clr.w   (word_FFDFAA).l 
										clr.b   ((FADING_POINTER-$1000000)).w
										move.b  d0,((FADING_PALETTE_FLAGS-$1000000)).w
										move.b  d1,((FADING_COUNTER_MAX-$1000000)).w
										move.b  d2,((FADING_SETTING-$1000000)).w
										move.b  ((FADING_COUNTER_MAX-$1000000)).w,((FADING_COUNTER-$1000000)).w
loc_467C6:
										
										jsr     (WaitForVInt).w 
										tst.b   ((FADING_SETTING-$1000000)).w
										bne.s   loc_467C6
										jsr     (WaitForVInt).w 
										move.b  d3,((FADING_COUNTER_MAX-$1000000)).w
										move.b  #$F,((FADING_PALETTE_FLAGS-$1000000)).w
										move.b  (sp)+,d3
										rts

	; End of function LaunchFading


; =============== S U B R O U T I N E =======================================

csc2D_moveEntity:
										
										move.b  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.b  d0,ENTITYDEF_OFFSET_ACTSCRIPTWAITTIMER(a5)
										andi.b  #$9F,ENTITYDEF_OFFSET_FLAGS_A(a5)
										move.b  (a6)+,d4
										move.l  (dword_FFB1A4).l,d0
										movea.l d0,a0
loc_467FC:
										
										move.b  (a6)+,d1
										bmi.w   loc_46928
										move.b  (a6)+,d2
										ext.w   d2
										move.w  d2,d3
										neg.w   d3
										andi.w  #$F,d1
										add.w   d1,d1
										move.w  rjt_EntityMoveCommands(pc,d1.w),d1
										jsr     rjt_EntityMoveCommands(pc,d1.w)
										bra.s   loc_467FC

	; End of function csc2D_moveEntity

rjt_EntityMoveCommands:
										dc.w csc2D_0_moveRight-rjt_EntityMoveCommands
										dc.w csc2D_1_moveUp-rjt_EntityMoveCommands
										dc.w csc2D_2_moveLeft-rjt_EntityMoveCommands
										dc.w csc2D_3_moveDown-rjt_EntityMoveCommands
										dc.w csc2D_4_moveUpRight-rjt_EntityMoveCommands
										dc.w csc2D_5_moveUpLeft-rjt_EntityMoveCommands
										dc.w csc2D_6_moveDownLeft-rjt_EntityMoveCommands
										dc.w csc2D_7_moveDownRight-rjt_EntityMoveCommands
										dc.w csc2D_8_faceRight-rjt_EntityMoveCommands
										dc.w csc2D_9_faceUp-rjt_EntityMoveCommands
										dc.w csc2D_A_faceLeft-rjt_EntityMoveCommands
										dc.w csc2D_B_faceDown-rjt_EntityMoveCommands
										dc.w loc_468F2-rjt_EntityMoveCommands
																						; related to face down
										dc.w csc2D_D_jump-rjt_EntityMoveCommands
										dc.w csc2D_E_jumpRight-rjt_EntityMoveCommands
										dc.w csc2D_F_jumpLeft-rjt_EntityMoveCommands

; =============== S U B R O U T I N E =======================================

csc2D_0_moveRight:
										
										move.w  #4,(a0)+
										move.w  d2,(a0)+
										clr.w   (a0)+
										move.w  #1,(a0)+
										rts

	; End of function csc2D_0_moveRight


; =============== S U B R O U T I N E =======================================

csc2D_1_moveUp:
										
										move.w  #4,(a0)+
										clr.w   (a0)+
										move.w  d3,(a0)+
										move.w  #1,(a0)+
										rts

	; End of function csc2D_1_moveUp


; =============== S U B R O U T I N E =======================================

csc2D_2_moveLeft:
										
										move.w  #4,(a0)+
										move.w  d3,(a0)+
										clr.w   (a0)+
										move.w  #1,(a0)+
										rts

	; End of function csc2D_2_moveLeft


; =============== S U B R O U T I N E =======================================

csc2D_3_moveDown:
										
										move.w  #4,(a0)+
										clr.w   (a0)+
										move.w  d2,(a0)+
										move.w  #1,(a0)+
										rts

	; End of function csc2D_3_moveDown


; =============== S U B R O U T I N E =======================================

csc2D_4_moveUpRight:
										
										move.w  #4,(a0)+
										move.w  d2,(a0)+
										move.w  d3,(a0)+
										move.w  #1,(a0)+
										rts

	; End of function csc2D_4_moveUpRight


; =============== S U B R O U T I N E =======================================

csc2D_5_moveUpLeft:
										
										move.w  #4,(a0)+
										move.w  d3,(a0)+
										move.w  d3,(a0)+
										move.w  #1,(a0)+
										rts

	; End of function csc2D_5_moveUpLeft


; =============== S U B R O U T I N E =======================================

csc2D_6_moveDownLeft:
										
										move.w  #4,(a0)+
										move.w  d3,(a0)+
										move.w  d2,(a0)+
										move.w  #1,(a0)+
										rts

	; End of function csc2D_6_moveDownLeft


; =============== S U B R O U T I N E =======================================

csc2D_7_moveDownRight:
										
										move.w  #4,(a0)+
										move.w  d2,(a0)+
										move.w  d2,(a0)+
										move.w  #1,(a0)+
										rts

	; End of function csc2D_7_moveDownRight


; =============== S U B R O U T I N E =======================================

csc2D_8_faceRight:
										
										move.w  #$22,(a0)+ 
										move.w  #0,(a0)+
										move.w  #$A,(a0)+
										move.w  #0,(a0)+
										move.w  d2,(a0)+
										rts

	; End of function csc2D_8_faceRight


; =============== S U B R O U T I N E =======================================

csc2D_9_faceUp:
										
										move.w  #$22,(a0)+ 
										move.w  #1,(a0)+
										move.w  #$A,(a0)+
										move.w  #0,(a0)+
										move.w  d2,(a0)+
										rts

	; End of function csc2D_9_faceUp


; =============== S U B R O U T I N E =======================================

csc2D_A_faceLeft:
										
										move.w  #$22,(a0)+ 
										move.w  #2,(a0)+
										move.w  #$A,(a0)+
										move.w  #0,(a0)+
										move.w  d2,(a0)+
										rts

	; End of function csc2D_A_faceLeft


; =============== S U B R O U T I N E =======================================

csc2D_B_faceDown:
										
										move.w  #$22,(a0)+ 
										move.w  #3,(a0)+
										move.w  #$A,(a0)+
loc_468F2:
										
										move.w  #0,(a0)+
										move.w  d2,(a0)+
										rts

	; End of function csc2D_B_faceDown


; =============== S U B R O U T I N E =======================================

csc2D_D_jump:
										
										lea     (eas_Jump).l,a1 
										bra.w   loc_46914
csc2D_E_jumpRight:
										
										lea     (eas_JumpRight).l,a1
										bra.w   loc_46914
csc2D_F_jumpLeft:
										
										lea     (eas_JumpLeft).l,a1
loc_46914:
										
										move.l  (a1)+,(a0)+
										move.l  (a1)+,(a0)+
										move.l  (a1)+,(a0)+
										move.l  (a1)+,(a0)+
										move.l  (a1)+,(a0)+
										move.l  (a1)+,(a0)+
										move.l  (a1)+,(a0)+
										move.l  (a1)+,(a0)+
										move.w  (a1)+,(a0)+
										rts

	; End of function csc2D_D_jump


; START OF FUNCTION CHUNK FOR csc2D_moveEntity

loc_46928:
										
										move.w  #$34,(a0)+ 
										move.l  #eas_Idle,(a0)+ 
										addq.l  #1,a6
										move.l  a0,(dword_FFB1A4).l
										move.l  d0,$14(a5)
										tst.b   d4
										beq.w   return_4694E
loc_46944:
										
										cmpi.l  #eas_Idle,$14(a5)
										bne.s   loc_46944
return_4694E:
										
										rts

; END OF FUNCTION CHUNK FOR csc2D_moveEntity


; =============== S U B R O U T I N E =======================================

csc14_setEntityActscriptManual:
										
										move.b  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.b  d0,ENTITYDEF_OFFSET_ACTSCRIPTWAITTIMER(a5)
																						; timer for next actscript read
										move.b  (a6)+,d0
										move.l  a6,ENTITYDEF_OFFSET_ACTSCRIPTADDR(a5)
																						; address of new actscript
										tst.b   d0
										beq.w   loc_46970
loc_46966:
										
										cmpi.l  #eas_Idle,ENTITYDEF_OFFSET_ACTSCRIPTADDR(a5)
										bne.s   loc_46966
loc_46970:
										
										cmpi.w  #$8080,(a6)+
										bne.s   loc_46970
										rts

	; End of function csc14_setEntityActscriptManual


; =============== S U B R O U T I N E =======================================

; x y zzzz : actscript read timer, wait for entity idle or not, actscript

csc15_setEntityActscript:
										
										move.b  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.b  d0,ENTITYDEF_OFFSET_ACTSCRIPTWAITTIMER(a5)
										move.b  (a6)+,d0
										move.l  (a6)+,ENTITYDEF_OFFSET_ACTSCRIPTADDR(a5)
										tst.b   d0
										beq.w   return_46998
loc_4698E:
										
										cmpi.l  #eas_Idle,ENTITYDEF_OFFSET_ACTSCRIPTADDR(a5)
										bne.s   loc_4698E
return_46998:
										
										rts

	; End of function csc15_setEntityActscript


; =============== S U B R O U T I N E =======================================

; xxxx

csc16_waitUntilEntityIdle:
										
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
loc_469A0:
										
										cmpi.l  #eas_Idle,ENTITYDEF_OFFSET_ACTSCRIPTADDR(a5)
										bne.s   loc_469A0
										rts

	; End of function csc16_waitUntilEntityIdle


; =============== S U B R O U T I N E =======================================

; make entity flash progressively faster, and set new pos-dest-facing

csc17_setEntityPosAndFacingWithFlash:
										
										move.b  (a6),d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.w  (a5),d1
										move.w  #$FE80,d2
										moveq   #$1E,d7
loc_469BA:
										
										move.w  d2,(a5)
										jsr     (WaitForVInt).w 
										jsr     (WaitForVInt).w 
										move.w  d1,(a5)
										move.w  d7,d0
										subi.w  #$F,d0
										bhi.s   loc_469D0
										moveq   #1,d0
loc_469D0:
										
										add.w   d0,d0
										jsr     (Sleep).w       
										dbf     d7,loc_469BA
										bra.w   csc19_setEntityPosAndFacing

	; End of function csc17_setEntityPosAndFacingWithFlash


; =============== S U B R O U T I N E =======================================

csc18_flashEntityWhite:
										
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.w  (a6)+,d7
										lsr.w   #2,d7
loc_469E8:
										
										ori.b   #4,ENTITYDEF_OFFSET_FLAGS_B(a5)
										bsr.w   UpdateEntitySprite_0
										jsr     (WaitForVInt).w 
										jsr     (WaitForVInt).w 
										andi.b  #$FB,ENTITYDEF_OFFSET_FLAGS_B(a5)
										bsr.w   UpdateEntitySprite_0
										jsr     (WaitForVInt).w 
										jsr     (WaitForVInt).w 
										dbf     d7,loc_469E8
										rts

	; End of function csc18_flashEntityWhite


; =============== S U B R O U T I N E =======================================

; use xxxxxxxx if alive or yyyyyyyy if dead

csc19_setEntityPosAndFacing:
										
										move.b  (a6),d0
										moveq   #4,d7
										bsr.w   AdjustScriptPointerByCharAliveStatus
										move.b  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										moveq   #0,d0           ; set new pos-dest, and facing
										move.b  (a6)+,d0
										mulu.w  #$180,d0
										move.w  d0,(a5)
										move.w  d0,ENTITYDEF_OFFSET_XDEST(a5)
										moveq   #0,d0
										move.b  (a6)+,d0
										mulu.w  #$180,d0
										move.w  d0,ENTITYDEF_OFFSET_Y(a5)
										move.w  d0,ENTITYDEF_OFFSET_YDEST(a5)
										move.b  (a6)+,ENTITYDEF_OFFSET_FACING(a5)
										bsr.w   UpdateEntitySprite_0
										rts

	; End of function csc19_setEntityPosAndFacing


; =============== S U B R O U T I N E =======================================

csc1A_setEntitySprite:
										
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.w  (a6)+,d0
										cmpi.w  #$1E,d0
										bcc.s   loc_46A5E
										jsr     GetCharacterSpriteIdx
										move.w  d4,d0
loc_46A5E:
										
										move.b  d0,$13(a5)
										jsr     (WaitForVInt).w 
										bsr.w   UpdateEntitySprite_0
										rts

	; End of function csc1A_setEntitySprite


; =============== S U B R O U T I N E =======================================

; if character xxxx dead, then do it to entity yyyy ?!

csc1B_startEntityAnim:
										
										move.w  (a6),d0
										moveq   #2,d7
										bsr.w   AdjustScriptPointerByCharAliveStatus
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.b  #0,ENTITYDEF_OFFSET_ANIMCOUNTER(a5)
										rts

	; End of function csc1B_startEntityAnim


; =============== S U B R O U T I N E =======================================

; if character xxxx dead, then do it to entity yyyy ?!

csc1C_stopEntityAnim:
										
										move.w  (a6),d0
										moveq   #2,d7
										bsr.w   AdjustScriptPointerByCharAliveStatus
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.b  #$FF,ENTITYDEF_OFFSET_ANIMCOUNTER(a5)
										rts

	; End of function csc1C_stopEntityAnim


; =============== S U B R O U T I N E =======================================

csc1D_showPortrait:
										
										move.w  (a6)+,d0
										tst.w   ((PORTRAIT_WINDOW_INDEX-$1000000)).w
										bne.w   return_46AD0    ; do nothing if ther's already a portrait ?
										moveq   #0,d3
										btst    #$F,d0
										beq.s   loc_46AAC
										moveq   #$FFFFFFFF,d3
loc_46AAC:
										
										moveq   #0,d4
										btst    #$E,d0
										beq.s   loc_46AB6
										moveq   #$FFFFFFFF,d4
loc_46AB6:
										
										jsr     (WaitForCameraToCatchUp).w
										bsr.w   GetEntityPortraitAndSpeechSfx
										cmpi.w  #$FFFF,d1
										beq.s   return_46AD0
										move.w  d1,d0
										move.w  d3,d1
										move.w  d4,d2
										jsr     j_InitPortraitWindow
return_46AD0:
										
										rts

	; End of function csc1D_showPortrait


; =============== S U B R O U T I N E =======================================

csc1E_hidePortrait:
										
										jsr     (WaitForCameraToCatchUp).w
										jsr     j_HidePortraitWindow
										rts

	; End of function csc1E_hidePortrait


; =============== S U B R O U T I N E =======================================

csc1F_declareForceMemberDead:
										
										lea     ((DEAD_COMBATANTS_LIST-$1000000)).w,a1
										adda.w  ((DEAD_COMBATANTS_LIST_LENGTH-$1000000)).w,a1
										move.w  (a6)+,d0
										move.b  d0,(a1)
										addq.w  #1,((DEAD_COMBATANTS_LIST_LENGTH-$1000000)).w
										rts

	; End of function csc1F_declareForceMemberDead


; =============== S U B R O U T I N E =======================================

csc20_addForceMembersOnMapToList:
										
										lea     ((DEAD_COMBATANTS_LIST-$1000000)).w,a1
										move.w  ((DEAD_COMBATANTS_LIST_LENGTH-$1000000)).w,d2
										adda.w  d2,a1
										moveq   #$FFFFFF80,d0
										moveq   #$1F,d7
loc_46AFE:
										
										jsr     j_GetXPos
										cmpi.w  #$FFFF,d1
										beq.s   loc_46B0E
										move.b  d0,(a1)+
										addq.w  #1,d2
loc_46B0E:
										
										addq.b  #1,d0
										dbf     d7,loc_46AFE
										move.w  d2,((DEAD_COMBATANTS_LIST_LENGTH-$1000000)).w
										rts

	; End of function csc20_addForceMembersOnMapToList


; =============== S U B R O U T I N E =======================================

csc21_removeForceMemberFromList:
										
										move.w  (a6)+,d0
										lea     ((DEAD_COMBATANTS_LIST-$1000000)).w,a1
										lea     ((DEAD_COMBATANTS_LIST-$1000000)).w,a2
										move.w  ((DEAD_COMBATANTS_LIST_LENGTH-$1000000)).w,d7
										subq.w  #1,d7
										bcs.w   return_46B40
loc_46B2E:
										
										cmp.b   (a1),d0
										bne.s   loc_46B3A
										addq.l  #1,a1
										subq.w  #1,((DEAD_COMBATANTS_LIST_LENGTH-$1000000)).w
										bra.s   loc_46B3C
loc_46B3A:
										
										move.b  (a1)+,(a2)+
loc_46B3C:
										
										dbf     d7,loc_46B2E
return_46B40:
										
										rts

	; End of function csc21_removeForceMemberFromList


; =============== S U B R O U T I N E =======================================

; 0/1 = scan down/up, 2/3 = wipe out/in, 4/5 = slide out/in, 6/7 = mosaic out/in

csc22_animateEntityFadeInOrOut:
										
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										lea     (FF6802_LOADING_SPACE).l,a0
										move.w  (a6)+,d0
										moveq   #0,d1
										cmpi.w  #6,d0
										beq.w   loc_46BE2
										moveq   #$FFFFFFFF,d1
										cmpi.w  #7,d0
										beq.w   loc_46BE2
										move.w  d0,d2
										lsl.w   #3,d0
										lea     byte_46BB2(pc,d0.w),a1
										move.w  (a1),d0
										move.w  2(a1),d1
										moveq   #$16,d7
loc_46B74:
										
										bsr.w   sub_470CA
										jsr     sub_45CA6
										bsr.w   sub_4709E
										jsr     (WaitForVInt).w 
										jsr     (WaitForVInt).w 
										add.w   4(a1),d0
										add.w   6(a1),d1
										dbf     d7,loc_46B74
										cmpi.w  #4,d2
										bne.s   return_46BB0
										bsr.w   sub_470CA
										move.l  #$FFFF,d0
										jsr     sub_45E10
										bsr.w   sub_4709E
return_46BB0:
										
										rts

	; End of function csc22_animateEntityFadeInOrOut

byte_46BB2:         dc.b 0
										dc.b   1
										dc.b   0
										dc.b   0
										dc.b   0
										dc.b   0
										dc.b   0
										dc.b   1
										dc.b   0
										dc.b   1
										dc.b   0
										dc.b $15
										dc.b   0
										dc.b   0
										dc.b $FF
										dc.b $FF
										dc.b   0
										dc.b   1
										dc.b   0
										dc.b   0
										dc.b   0
										dc.b   1
										dc.b   0
										dc.b   0
										dc.b   0
										dc.b $16
										dc.b   0
										dc.b   0
										dc.b $FF
										dc.b $FF
										dc.b   0
										dc.b   0
										dc.b   0
										dc.b   1
										dc.b   0
										dc.b $16
										dc.b   0
										dc.b   1
										dc.b $FF
										dc.b $FF
										dc.b   0
										dc.b $16
										dc.b   0
										dc.b   1
										dc.b $FF
										dc.b $FF
										dc.b   0
										dc.b   1

; START OF FUNCTION CHUNK FOR csc22_animateEntityFadeInOrOut

loc_46BE2:
										
										tst.w   d1
										beq.s   loc_46BEE
										move.l  #$7FFF,d0
										bra.s   loc_46BF0
loc_46BEE:
										
										moveq   #1,d0
loc_46BF0:
										
										moveq   #$F,d7
loc_46BF2:
										
										bsr.w   sub_470CA
										jsr     sub_45E10
										bsr.w   sub_4709E
										jsr     (WaitForVInt).w 
										jsr     (WaitForVInt).w 
										jsr     (WaitForVInt).w 
										btst    #$F,d1
										beq.s   loc_46C16
										lsr.l   #1,d0
										bra.s   loc_46C1A
loc_46C16:
										
										add.l   d0,d0
										addq.w  #1,d0
loc_46C1A:
										
										dbf     d7,loc_46BF2
										rts

; END OF FUNCTION CHUNK FOR csc22_animateEntityFadeInOrOut


; =============== S U B R O U T I N E =======================================

; set entity yyyy facing zzzz according to character's xxxx alive status ?!

csc23_setEntityFacing:
										
										move.b  (a6),d0
										moveq   #2,d7
										bsr.w   AdjustScriptPointerByCharAliveStatus
										move.b  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.b  (a6)+,ENTITYDEF_OFFSET_FACING(a5)
										bsr.w   UpdateEntitySprite_0
										rts

	; End of function csc23_setEntityFacing


; =============== S U B R O U T I N E =======================================

; set playable entity 00xx or something like that

csc24_setCameraTargetEntity:
										
										lea     ((ENTITY_EVENT_IDX_LIST-$1000000)).w,a5
										move.w  (a6)+,d0
										bmi.w   loc_46C52
										tst.b   d0
										bpl.s   loc_46C4A
										subi.b  #$60,d0 
loc_46C4A:
										
										andi.w  #$FF,d0
										move.b  (a5,d0.w),d0
loc_46C52:
										
										move.b  d0,((BATTLE_CURRENT_ENTITY-$1000000)).w
										nop
										rts

	; End of function csc24_setCameraTargetEntity


; =============== S U B R O U T I N E =======================================

; wtf, copy entity number of entity 00xx into entity number of entity 00yy ?!

csc25_cloneEntity:
										
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.b  ENTITYDEF_OFFSET_ENTNUM(a5),d1
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.b  d1,ENTITYDEF_OFFSET_ENTNUM(a5)
										rts

	; End of function csc25_cloneEntity


; =============== S U B R O U T I N E =======================================

csc26_entityNodHead:
										
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.b  #$FF,$1E(a5)
										lea     (FF6802_LOADING_SPACE).l,a0
										moveq   #0,d7
										moveq   #$A,d0
										jsr     (Sleep).w       
loc_46C8A:
										
										bsr.w   sub_470CA
										jsr     sub_45D70
										bsr.w   sub_4709E
										moveq   #$14,d0
										jsr     (Sleep).w       
										bsr.w   UpdateEntitySprite_0
										moveq   #$A,d0
										jsr     (Sleep).w       
										dbf     d7,loc_46C8A
										move.b  #0,$1E(a5)
										rts

	; End of function csc26_entityNodHead


; =============== S U B R O U T I N E =======================================

csc27_entityShakeHead:
										
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.b  #$FF,$1E(a5)
										lea     (FF6802_LOADING_SPACE).l,a0
										moveq   #6,d7
loc_46CC8:
										
										bsr.w   sub_470CA
										jsr     sub_45D1C
										bsr.w   sub_4709E
										jsr     (WaitForVInt).w 
										jsr     (WaitForVInt).w 
										bsr.w   UpdateEntitySprite_0
										jsr     (WaitForVInt).w 
										bsr.w   sub_470CA
										jsr     sub_45D46
										bsr.w   sub_4709E
										jsr     (WaitForVInt).w 
										jsr     (WaitForVInt).w 
										bsr.w   UpdateEntitySprite_0
										jsr     (WaitForVInt).w 
										dbf     d7,loc_46CC8
										move.b  #0,$1E(a5)
										rts

	; End of function csc27_entityShakeHead


; =============== S U B R O U T I N E =======================================

csc28_moveEntityNextToPlayer:
										
										moveq   #0,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.w  ENTITYDEF_OFFSET_XDEST(a5),d1
										move.w  ENTITYDEF_OFFSET_YDEST(a5),d2
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.w  (a6)+,d3
										tst.b   d3
										bne.s   loc_46D30
										addi.w  #$180,d1
										bra.s   loc_46D4C
loc_46D30:
										
										cmpi.b  #1,d3
										bne.s   loc_46D3C
										subi.w  #$180,d2
										bra.s   loc_46D4C
loc_46D3C:
										
										cmpi.b  #2,d3
										bne.s   loc_46D48
										subi.w  #$180,d1
										bra.s   loc_46D4C
loc_46D48:
										
										addi.w  #$180,d2
loc_46D4C:
										
										move.w  d1,ENTITYDEF_OFFSET_XDEST(a5)
										move.w  #$30,d4 
										sub.w   (a5),d1
										bpl.s   loc_46D5C
										neg.w   d1
										neg.w   d4
loc_46D5C:
										
										move.w  d1,8(a5)
										move.w  d4,4(a5)
										move.w  d2,ENTITYDEF_OFFSET_YDEST(a5)
										move.w  #$30,d5 
										sub.w   2(a5),d2
										bpl.s   loc_46D76
										neg.w   d2
										neg.w   d5
loc_46D76:
										
										move.w  d2,$A(a5)
										move.w  d5,6(a5)
										bsr.w   WaitForEntityToStopMoving
										addq.w  #2,d3
										andi.b  #3,d3
										move.b  d3,ENTITYDEF_OFFSET_FACING(a5)
										bsr.w   UpdateEntitySprite_0
										moveq   #0,d0
										bsr.w   WaitForEntityToStopMoving
										rts

	; End of function csc28_moveEntityNextToPlayer


; =============== S U B R O U T I N E =======================================

csc29_setEntityDest:
										
										move.w  (a6)+,d0
										move.w  d0,d6
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										moveq   #0,d1
										moveq   #0,d2
										move.w  (a6)+,d1
										move.w  (a6)+,d2
										mulu.w  #$180,d1
										mulu.w  #$180,d2
										move.w  d1,ENTITYDEF_OFFSET_XDEST(a5)
										move.w  d2,ENTITYDEF_OFFSET_YDEST(a5)
										move.w  #$20,d3 
										sub.w   (a5),d1
										bpl.s   loc_46DC4
										neg.w   d1
										neg.w   d3
loc_46DC4:
										
										move.w  d1,8(a5)
										move.w  d3,4(a5)
										move.w  #$20,d3 
										sub.w   2(a5),d2
										bpl.s   loc_46DDA
										neg.w   d2
										neg.w   d3
loc_46DDA:
										
										move.w  d2,$A(a5)
										move.w  d3,6(a5)
										btst    #$F,d6
										bne.s   return_46DEC
										bsr.w   WaitForEntityToStopMoving
return_46DEC:
										
										rts

	; End of function csc29_setEntityDest


; =============== S U B R O U T I N E =======================================

csc2A_entityShiver:
										
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.w  ((SPRITE_SIZE-$1000000)).w,d6
										move.w  #$15,((SPRITE_SIZE-$1000000)).w
										move.b  ENTITYDEF_OFFSET_ANIMCOUNTER(a5),d5
										move.b  #$FF,ENTITYDEF_OFFSET_ANIMCOUNTER(a5)
										moveq   #2,d7
loc_46E0A:
										
										ori.b   #8,ENTITYDEF_OFFSET_FLAGS_B(a5)
										bsr.w   UpdateEntitySprite_0
										moveq   #5,d0
										jsr     (Sleep).w       
										andi.b  #$F7,ENTITYDEF_OFFSET_FLAGS_B(a5)
										bsr.w   UpdateEntitySprite_0
										moveq   #5,d0
										jsr     (Sleep).w       
										dbf     d7,loc_46E0A
										move.b  d5,ENTITYDEF_OFFSET_ANIMCOUNTER(a5)
										move.w  d6,((SPRITE_SIZE-$1000000)).w
										rts

	; End of function csc2A_entityShiver


; =============== S U B R O U T I N E =======================================

csc2B_:
										move.w  (a6)+,d0
										clr.w   d1
										clr.w   d2
										clr.w   d3
										clr.w   d4
										move.b  (a6)+,d1
										move.b  (a6)+,d2
										move.b  (a6)+,d3
										move.b  (a6)+,d4
										move.l  #eas_Init,d5    
										jsr     sub_44570
										rts

	; End of function csc2B_


; =============== S U B R O U T I N E =======================================

csc2C_followEntity:
										
										move.b  (a6),d0
										moveq   #6,d7
										bsr.w   AdjustScriptPointerByCharAliveStatus
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.w  d0,d3
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.w  d0,d1
										move.w  d3,d0
										move.w  (a6)+,d2
										add.w   d2,d2
										lea     unk_46E8A(pc,d2.w),a0
										move.b  (a0)+,d2
										move.b  (a0)+,d3
										ext.w   d2
										ext.w   d3
										jsr     sub_44C2E
										rts

	; End of function csc2C_followEntity

unk_46E8A:          dc.b $18
										dc.b   0
										dc.b   0
										dc.b $E8 
										dc.b $E8 
										dc.b   0
										dc.b   0
										dc.b $18
										dc.b $18
										dc.b $E8 
										dc.b $E8 
										dc.b $E8 
										dc.b $E8 
										dc.b $18

; =============== S U B R O U T I N E =======================================

sub_46E98:
										
										move.b  (a0)+,d4
csc2E_hideEntity:
										
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										jsr     sub_44C84
										rts

	; End of function sub_46E98


; =============== S U B R O U T I N E =======================================

csc2F_:
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.w  (a6)+,d0
										bne.s   loc_46EB8
										clr.b   $11(a5)
										bra.s   return_46EBE
loc_46EB8:
										
										move.b  #$10,$11(a5)
return_46EBE:
										
										rts

	; End of function csc2F_


; =============== S U B R O U T I N E =======================================

csc30_removeEntityShadow:
										
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										lea     (FF6802_LOADING_SPACE).l,a0
										bsr.w   sub_470CA
										jsr     sub_45A8C
										bsr.w   sub_4709E
										jsr     (WaitForVInt).w 
										rts

	; End of function csc30_removeEntityShadow


; =============== S U B R O U T I N E =======================================

csc50_setEntitySize:
										
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.w  ((SPRITE_SIZE-$1000000)).w,d6
										move.w  (a6)+,((SPRITE_SIZE-$1000000)).w
										ori.b   #8,ENTITYDEF_OFFSET_FLAGS_B(a5)
										bsr.w   UpdateEntitySprite_0
										jsr     (WaitForVInt).w 
										move.w  d6,((SPRITE_SIZE-$1000000)).w
										rts

	; End of function csc50_setEntitySize


; =============== S U B R O U T I N E =======================================

csc51_:
										move.w  #$FFFF,((TEXT_NAME_INDEX_1-$1000000)).w
										nop
										move.w  (a6)+,d0
										jsr     j_IsInBattleParty
										bne.w   return_46F56
										move.w  d0,d6
										jsr     j_UpdateForce
										lea     ((BATTLE_PARTY_MEMBERS-$1000000)).w,a0
										nop
										move.w  ((NUMBER_OF_BATTLE_PARTY_MEMBERS-$1000000)).w,d7
										nop
										subq.w  #2,d7
loc_46F2C:
										
										move.b  (a0),d0
										jsr     j_GetCurrentHP
										tst.w   d1
										beq.w   loc_46F40
										addq.l  #1,a0
										dbf     d7,loc_46F2C
loc_46F40:
										
										move.b  (a0),d0
										move.w  d0,((TEXT_NAME_INDEX_1-$1000000)).w
										nop
										jsr     j_LeaveBattleParty
										move.b  d6,d0
										jsr     j_JoinBattleParty
return_46F56:
										
										rts

	; End of function csc51_


; =============== S U B R O U T I N E =======================================

; related to 2 entities

csc52_:
										move.w  (a6)+,d7
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.w  ENTITYDEF_OFFSET_XDEST(a5),d1
										move.w  ENTITYDEF_OFFSET_YDEST(a5),d2
										move.w  d7,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.w  d1,d3
										sub.w   ENTITYDEF_OFFSET_XDEST(a5),d3
										or.w    d3,d3
										bge.s   loc_46F7A
										neg.w   d3
loc_46F7A:
										
										move.w  d2,d4
										sub.w   ENTITYDEF_OFFSET_YDEST(a5),d4
										or.w    d4,d4
										bge.s   loc_46F86
										neg.w   d4
loc_46F86:
										
										cmp.w   d3,d4
										bcc.s   loc_46FA0
										cmp.w   ENTITYDEF_OFFSET_XDEST(a5),d1
										bcs.s   loc_46F98
										move.b  #0,ENTITYDEF_OFFSET_FACING(a5)
										bra.s   loc_46F9E
loc_46F98:
										
										move.b  #2,ENTITYDEF_OFFSET_FACING(a5)
loc_46F9E:
										
										bra.s   loc_46FB4
loc_46FA0:
										
										cmp.w   ENTITYDEF_OFFSET_YDEST(a5),d2
										bcs.s   loc_46FAE
										move.b  #3,ENTITYDEF_OFFSET_FACING(a5)
										bra.s   loc_46FB4
loc_46FAE:
										
										move.b  #1,ENTITYDEF_OFFSET_FACING(a5)
loc_46FB4:
										
										bsr.w   UpdateEntitySprite_0
										jsr     (WaitForVInt).w 
										rts

	; End of function csc52_


; =============== S U B R O U T I N E =======================================

csc53_:
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										lea     ((byte_FFAFB0-$1000000)).w,a0
										nop
										move.w  (a6)+,d1
										bne.s   loc_46FD4
										clr.b   (a0,d0.w)
										bra.s   return_46FDA
loc_46FD4:
										
										move.b  #1,(a0,d0.w)
return_46FDA:
										
										rts

	; End of function csc53_


; =============== S U B R O U T I N E =======================================

csc54_:
										move.w  (a6)+,d0
										jsr     j_GetCharacterWord34
										move.w  (a6)+,d2
										bne.s   loc_46FEE
										andi.w  #$FFFB,d1
										bra.s   loc_46FF8
loc_46FEE:
										
										ori.w   #4,d1
										jsr     j_JoinForce
loc_46FF8:
										
										jsr     j_SetCharacterWord34
										rts

	; End of function csc54_


; =============== S U B R O U T I N E =======================================

csc55_resetCharacterBattleStats:
										
										jsr     ResetAlliesBattleStats
										rts

	; End of function csc55_resetCharacterBattleStats


; =============== S U B R O U T I N E =======================================

; xx character

csc56_:
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										moveq   #0,d1
										lea     ((FOLLOWERS_LIST-$1000000)).w,a0
loc_47014:
										
										cmpi.b  #$FF,(a0)
										beq.w   loc_47020       ; gets last value before an FF
										move.b  (a0)+,d1        ; get last follower ?
										bra.s   loc_47014
loc_47020:
										
										move.w  #$FFE8,d2
										move.w  #0,d3
										jsr     sub_44C2E
										rts

	; End of function csc56_


; =============== S U B R O U T I N E =======================================

csc31_moveEntityAboveEntity:
										
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										move.w  d0,d1
										move.w  (a6)+,d0
										bsr.w   GetEntityAddressFromPlayableCharacterIdx
										moveq   #$FFFFFFE8,d2
										moveq   #0,d3
										jsr     sub_44C2E
										rts

	; End of function csc31_moveEntityAboveEntity


; =============== S U B R O U T I N E =======================================

;     Get address of entity information. Could be a force member or an opponent
;     In: D0 = playable character from FFB140
;     Out: A5 = entity info address in RAM

GetEntityAddressFromPlayableCharacterIdx:
										
										lea     ((ENTITY_EVENT_IDX_LIST-$1000000)).w,a5
										andi.w  #$FF,d0
										tst.b   d0
										bpl.s   loc_4705A
										subi.b  #$60,d0 
loc_4705A:
										
										move.b  (a5,d0.w),d0
										move.l  d0,-(sp)
										lsl.w   #5,d0
										lea     ((ENTITY_DATA_STRUCT_X_AND_START-$1000000)).w,a5
										adda.w  d0,a5
										move.l  (sp)+,d0
										rts

	; End of function GetEntityAddressFromPlayableCharacterIdx


; =============== S U B R O U T I N E =======================================

UpdateEntitySprite_0:
										
										movem.l d6/a0,-(sp)
										move.b  ENTITYDEF_OFFSET_FACING(a5),d6
										movea.l a5,a0
										jsr     (ChangeEntitySprite).w
										movem.l (sp)+,d6/a0
										rts

	; End of function UpdateEntitySprite_0


; =============== S U B R O U T I N E =======================================

; move script pointer d7 forward if character dead

AdjustScriptPointerByCharAliveStatus:
										
										btst    #7,d0
										bne.s   return_4709C
										cmpi.b  #$1E,d0
										bge.s   return_4709C    ; it must be a force member
										jsr     j_GetCurrentHP
										tst.w   d1
										bne.s   return_4709C
										adda.w  d7,a6
										movem.l (sp)+,d7
return_4709C:
										
										rts

	; End of function AdjustScriptPointerByCharAliveStatus


; =============== S U B R O U T I N E =======================================

sub_4709E:
										
										movem.l d0-d1/a0-a1,-(sp)
										clr.w   d1
										move.b  $12(a5),d1
										move.w  d1,d0
										lsl.w   #3,d1
										add.w   d0,d1
										lsl.w   #6,d1
										lea     ($7000).w,a1
										adda.w  d1,a1
										move.w  #$120,d0
										moveq   #2,d1
										jsr     (sub_119E).w    
										jsr     (Set_FFDE94_bit3).w
										movem.l (sp)+,d0-d1/a0-a1
										rts

	; End of function sub_4709E


; =============== S U B R O U T I N E =======================================

sub_470CA:
										
										movem.l d0-d1/d6/a1,-(sp)
										movea.l a0,a1
										clr.w   d6
										move.b  $10(a5),d6
										bne.s   loc_470DA
										moveq   #2,d6
loc_470DA:
										
										clr.w   d1
										move.b  $13(a5),d1
										move.w  d1,d0
										add.w   d1,d1
										add.w   d0,d1
										add.w   d6,d1
										subq.w  #1,d1
										lsl.w   #2,d1
										lea     (pt_MapSprites).l,a0
										movea.l (a0,d1.w),a0
										jsr     (LoadSpriteData).w
										movea.l a1,a0
										movem.l (sp)+,d0-d1/d6/a1
										rts

	; End of function sub_470CA

