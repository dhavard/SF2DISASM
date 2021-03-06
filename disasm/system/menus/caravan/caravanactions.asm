
; SCRIPT SECTION system\menus\caravan\caravanactions :
; Caravan functions

; =============== S U B R O U T I N E =======================================

CaravanMenuActions:
										
										movem.l d0-a5,-(sp)
										link    a6,#-$C
										move.w  #2,d1
										bsr.w   ChooseCaravanPortrait
										moveq   #0,d1
										bra.w   loc_21FEA
loc_21FE8:
										
										moveq   #$FFFFFFFF,d1
loc_21FEA:
										
										moveq   #0,d0
										moveq   #7,d2
										lea     (InitStack).w,a0
										jsr     j_ExecuteMenu
										cmpi.w  #$FFFF,d0
										beq.w   loc_22014
										add.w   d0,d0
										move.w  rjt_CaravanActions(pc,d0.w),d0
										jsr     rjt_CaravanActions(pc,d0.w)
										bra.s   loc_21FE8
rjt_CaravanActions:
										
										dc.w sub_22028-rjt_CaravanActions
										dc.w CaravanDepotActions-rjt_CaravanActions
										dc.w CaravanItemMenuActions-rjt_CaravanActions
										dc.w sub_22102-rjt_CaravanActions
loc_22014:
										
										moveq   #0,d0
										moveq   #0,d1
										move.w  #$A,d1
										bsr.w   ChooseCaravanPortrait
										unlk    a6
										movem.l (sp)+,d0-a5
										rts

	; End of function CaravanMenuActions


; =============== S U B R O U T I N E =======================================

sub_22028:
										
										moveq   #2,d1
										bsr.w   sub_228D8
										tst.w   ((word_FFB12E-$1000000)).w
										beq.w   loc_220F4
										move.w  #$F,d1
										bsr.w   ChooseCaravanPortrait
										jsr     sub_10040
										move.w  d0,-2(a6)
										cmpi.w  #$FFFF,d0
										beq.w   loc_220E8
										jsr     j_GetCurrentHP
										tst.w   d1
										bne.s   loc_22070
										move.w  -2(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										trap    #TEXTBOX
										dc.w $13                ; "{NAME} is dead.{N}Are you sure?"
										jsr     j_YesNoChoiceBox
										tst.w   d0
										bne.w   loc_220FE
loc_22070:
										
										moveq   #1,d1
										bsr.w   sub_228D8
										cmpi.w  #$C,((word_FFB12E-$1000000)).w
										bcc.s   loc_22098
										move.w  -2(a6),d0
										jsr     j_JoinBattleParty
										move.w  -2(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  #$15,d1
										bsr.w   ChooseCaravanPortrait
										bra.s   loc_220E6
loc_22098:
										
										move.w  #$17,d1
										bsr.w   ChooseCaravanPortrait
										jsr     sub_10040
										cmpi.w  #$FFFF,d0
										beq.s   loc_220DE
										tst.w   d0
										beq.s   loc_220D4
										move.w  d0,((TEXT_NAME_INDEX_1-$1000000)).w
										jsr     j_LeaveBattleParty
										move.w  -2(a6),d0
										jsr     j_JoinBattleParty
										move.w  -2(a6),((TEXT_NAME_INDEX_2-$1000000)).w
										move.w  #$11,d1
										bsr.w   ChooseCaravanPortrait
										bra.s   loc_220DC
loc_220D4:
										
										move.w  #$14,d1
										bsr.w   ChooseCaravanPortrait
loc_220DC:
										
										bra.s   loc_220E6
loc_220DE:
										
										trap    #TEXTBOX
										dc.w 4                  ; "Did you change your mind?{W2}"
										trap    #TEXTBOX
										dc.w $FFFF
loc_220E6:
										
										bra.s   loc_220F2
loc_220E8:
										
										trap    #TEXTBOX
										dc.w 4                  ; "Did you change your mind?{W2}"
										trap    #TEXTBOX
										dc.w $FFFF
										rts

	; End of function sub_22028


; START OF FUNCTION CHUNK FOR sub_22028

loc_220F2:
										
										bra.s   loc_220FE
loc_220F4:
										
										move.w  #$12,d1
										bsr.w   ChooseCaravanPortrait
										rts
loc_220FE:
										
										bra.w   sub_22028

; END OF FUNCTION CHUNK FOR sub_22028


; =============== S U B R O U T I N E =======================================

sub_22102:
										
										moveq   #1,d1
										bsr.w   sub_228D8
										tst.w   ((word_FFB12E-$1000000)).w
										beq.s   return_22150
										move.w  #$10,d1
										bsr.w   ChooseCaravanPortrait
										jsr     sub_10040
										cmpi.w  #$FFFF,d0
										beq.s   loc_22144
										tst.w   d0
										beq.s   loc_2213A
										jsr     j_LeaveBattleParty
										move.w  d0,((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  #$16,d1
										bsr.w   ChooseCaravanPortrait
										bra.s   loc_22142
loc_2213A:
										
										move.w  #$14,d1
										bsr.w   ChooseCaravanPortrait
loc_22142:
										
										bra.s   loc_2214E
loc_22144:
										
										trap    #TEXTBOX
										dc.w 4                  ; "Did you change your mind?{W2}"
										trap    #TEXTBOX
										dc.w $FFFF
										rts

	; End of function sub_22102


; START OF FUNCTION CHUNK FOR sub_22102

loc_2214E:
										
										bra.s   loc_22152
return_22150:
										
										rts
loc_22152:
										
										bra.s   sub_22102

; END OF FUNCTION CHUNK FOR sub_22102


; =============== S U B R O U T I N E =======================================

CaravanDepotActions:
										
										moveq   #0,d1
										bra.w   loc_2215C
loc_2215A:
										
										moveq   #$FFFFFFFF,d1
loc_2215C:
										
										moveq   #0,d0
										moveq   #8,d2
										lea     (InitStack).w,a0
										jsr     j_ExecuteMenu
										cmpi.w  #$FFFF,d0
										beq.w   return_22186
										add.w   d0,d0
										move.w  rjt_CaravanItemActions(pc,d0.w),d0
										jsr     rjt_CaravanItemActions(pc,d0.w)
										bra.s   loc_2215A

	; End of function CaravanDepotActions

rjt_CaravanItemActions:
										dc.w Caravan_DescribeItem-rjt_CaravanItemActions
										dc.w sub_222FA-rjt_CaravanItemActions
										dc.w sub_22384-rjt_CaravanItemActions
										dc.w sub_22498-rjt_CaravanItemActions

; START OF FUNCTION CHUNK FOR CaravanDepotActions

return_22186:
										
										rts

; END OF FUNCTION CHUNK FOR CaravanDepotActions


; =============== S U B R O U T I N E =======================================

Caravan_DescribeItem:
										
										bsr.w   sub_22926       
										tst.w   ((word_FFB12E-$1000000)).w
										beq.w   loc_222EC
										move.w  #$59,d1 
										bsr.w   ChooseCaravanPortrait
										jsr     sub_1004C
										move.w  d0,d2
										move.w  d1,-6(a6)
										move.w  d2,-4(a6)
										cmpi.w  #$FFFF,d0
										beq.w   loc_222E0
										trap    #CHECK_FLAG
										dc.w $46                ; Astral is a follower
										bne.s   loc_221BE
										moveq   #$B,d0
										bra.s   loc_221C0
loc_221BE:
										
										moveq   #$1F,d0
loc_221C0:
										
										moveq   #0,d1
										jsr     j_InitPortraitWindow
										move.w  -4(a6),d1
										bsr.w   DisplaySpecialCaravanDescription
										bne.w   loc_222A8
										move.w  -4(a6),d1
										jsr     j_GetItemType
										tst.w   d2
										bne.s   loc_221E8
										trap    #TEXTBOX
										dc.w $5C                ; "It's a tool.{W2}"
										bra.s   loc_221F8
loc_221E8:
										
										cmpi.w  #1,d2
										bne.s   loc_221F4
										trap    #TEXTBOX
										dc.w $5A                ; "It's a weapon.{W2}"
										bra.s   loc_221F8
loc_221F4:
										
										trap    #TEXTBOX
										dc.w $5B                ; "It's a ring.{W2}"
loc_221F8:
										
										move.w  -4(a6),d1
										jsr     j_GetItemDefAddress
										cmpi.b  #SPELLIDX_NOTHING,ITEMDEF_OFFSET_SPELL(a0)
										beq.s   loc_22210
										trap    #TEXTBOX
										dc.w $5D                ; "It has a special effect when{N}used in battle.{W2}"
										bra.s   loc_22214
loc_22210:
										
										trap    #TEXTBOX
										dc.w $5E                ; "It has no effect in battle.{W2}"
loc_22214:
										
										move.w  -4(a6),d1
										jsr     j_GetItemType
										tst.w   d2
										beq.w   loc_222A8
										cmpi.w  #ITEMIDX_POWER_RING,d1
										beq.w   loc_222A4
										cmpi.w  #ITEMIDX_PROTECT_RING,d1
										beq.w   loc_222A4
										cmpi.w  #ITEMIDX_QUICK_RING,d1
										beq.w   loc_222A4
										cmpi.w  #ITEMIDX_RUNNING_RING,d1
										beq.w   loc_222A4
										move.w  -4(a6),d1
										move.w  d1,((TEXT_NAME_INDEX_1-$1000000)).w
										trap    #TEXTBOX
										dc.w $60                ; "The {ITEM} is for{N}"
										jsr     j_UpdateForce
										move.w  ((TARGET_CHARACTERS_INDEX_LIST_SIZE-$1000000)).w,d7
										subq.w  #1,d7
										bcs.w   loc_222A8
										lea     ((TARGET_CHARACTERS_INDEX_LIST-$1000000)).w,a0
										clr.w   d6
loc_22266:
										
										move.b  (a0)+,d0
										jsr     j_IsWeaponOrRingEquippable
										bcc.s   loc_2228E
										move.w  d0,((TEXT_NAME_INDEX_1-$1000000)).w
																						; argument (char idx) for trap #5 using a {NAME} command
										trap    #TEXTBOX
										dc.w $62                ; "{DICT}{NAME},"
										addq.w  #1,d6
										cmpi.w  #1,d6
										bne.s   loc_22284
										trap    #TEXTBOX
										dc.w $63                ; "{N}"
loc_22284:
										
										cmpi.w  #4,d6
										bne.s   loc_2228E
										trap    #TEXTBOX
										dc.w $63                ; "{N}"
loc_2228E:
										
										dbf     d7,loc_22266
										tst.w   d6
										bne.s   loc_2229C
										trap    #TEXTBOX
										dc.w $61                ; "nobody so far.{W2}"
										bra.s   loc_222A0
loc_2229C:
										
										trap    #TEXTBOX
										dc.w $64                ; "to equip.{W2}"
loc_222A0:
										
										bra.w   loc_222A8
loc_222A4:
										
										trap    #TEXTBOX
										dc.w $5F                ; "Everybody can equip it.{W2}"
loc_222A8:
										
										move.w  -4(a6),d1
										jsr     j_GetItemDefAddress
										btst    #ITEMTYPE_BIT_UNSELLABLE,ITEMDEF_OFFSET_TYPE(a0)
										beq.s   loc_222C0
										trap    #TEXTBOX
										dc.w $66                ; "You can't sell it at a shop.{W2}"
										bra.s   loc_222D4
loc_222C0:
										
										clr.l   d1
										move.w  ITEMDEF_OFFSET_PRICE(a0),d1
										mulu.w  #ITEM_SELLPRICE_MULTIPLIER,d1
										lsr.l   #ITEM_SELLPRICE_BITSHIFTRIGHT,d1
										move.l  d1,((TEXT_NUMBER-$1000000)).w
										trap    #TEXTBOX
										dc.w $65                ; "It brings {#} gold coins{N}at a shop.{W2}"
loc_222D4:
										
										trap    #TEXTBOX
										dc.w $FFFF
										jsr     j_HidePortraitWindow
										bra.s   loc_222EA
loc_222E0:
										
										trap    #TEXTBOX
										dc.w 4                  ; "Did you change your mind?{W2}"
										trap    #TEXTBOX
										dc.w $FFFF
										rts

	; End of function Caravan_DescribeItem


; START OF FUNCTION CHUNK FOR Caravan_DescribeItem

loc_222EA:
										
										bra.s   loc_222F6
loc_222EC:
										
										move.w  #$52,d1 
										bsr.w   ChooseCaravanPortrait
										rts
loc_222F6:
										
										bra.w   Caravan_DescribeItem

; END OF FUNCTION CHUNK FOR Caravan_DescribeItem


; =============== S U B R O U T I N E =======================================

sub_222FA:
										
										bsr.w   sub_22926       
										cmpi.w  #$40,((word_FFB12E-$1000000)).w 
										bcc.s   loc_22376
										moveq   #0,d1
										bsr.w   sub_228D8
										move.w  #$53,d1 
										bsr.w   ChooseCaravanPortrait
										move.b  #1,((byte_FFB13C-$1000000)).w
										move.w  #ITEMIDX_NOTHING,((word_FFB13A-$1000000)).w
										jsr     sub_10044
										move.w  d0,-2(a6)
										move.w  d1,-6(a6)
										move.w  d2,-4(a6)
										cmpi.w  #$FFFF,d0
										beq.s   loc_2236A
										bsr.w   sub_2294C       
										bcs.w   loc_22380
										move.w  -4(a6),d1
										jsr     j_AddItemToCaravan
										move.w  -6(a6),d1
										jsr     j_DropItemBySlot
										move.w  -2(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  -4(a6),((TEXT_NAME_INDEX_2-$1000000)).w
										move.w  #$57,d1 
										bsr.w   ChooseCaravanPortrait
										bra.s   loc_22374
loc_2236A:
										
										trap    #TEXTBOX
										dc.w 4                  ; "Did you change your mind?{W2}"
										trap    #TEXTBOX
										dc.w $FFFF
										rts
loc_22374:
										
										bra.s   loc_22380
loc_22376:
										
										move.w  #$51,d1 
										bsr.w   ChooseCaravanPortrait
										rts

	; End of function sub_222FA


; START OF FUNCTION CHUNK FOR sub_222FA

loc_22380:
										
										bra.w   sub_222FA

; END OF FUNCTION CHUNK FOR sub_222FA


; =============== S U B R O U T I N E =======================================

sub_22384:
										
										bsr.w   sub_22926       
										tst.w   ((word_FFB12E-$1000000)).w
										beq.w   loc_2248A
										move.w  #$56,d1 
										bsr.w   ChooseCaravanPortrait
										jsr     sub_1004C
										move.w  d0,d2
										move.w  d1,-6(a6)
										move.w  d2,-4(a6)
										cmpi.w  #$FFFF,d2
										beq.w   loc_2247E
										moveq   #0,d1
										bsr.w   sub_228D8
										move.w  -4(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  #$54,d1 
										bsr.w   ChooseCaravanPortrait
										move.b  #2,((byte_FFB13C-$1000000)).w
										move.w  -4(a6),((word_FFB13A-$1000000)).w
										jsr     sub_10044
										move.w  d0,-8(a6)
										move.w  d1,-$C(a6)
										move.w  d2,-$A(a6)
										cmpi.w  #$FFFF,d0
										beq.w   loc_2247C
										clr.w   d1
										jsr     j_GetItemAndNumberOfItems
										cmpi.w  #4,d2
										beq.s   loc_22422
										move.w  -4(a6),d1
										jsr     j_AddItem
										move.w  -6(a6),d1
										jsr     j_RemoveItemFromCaravan
										move.w  -8(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  -4(a6),((TEXT_NAME_INDEX_2-$1000000)).w
										move.w  #$58,d1 
										bsr.w   ChooseCaravanPortrait
										bra.s   loc_2247C
loc_22422:
										
										move.w  -8(a6),d1
										move.w  -$C(a6),d1
										bsr.w   sub_2294C       
										bcs.w   loc_22494
										move.w  -8(a6),d0
										move.w  -$C(a6),d1
										jsr     j_RemoveItemBySlot
										move.w  -6(a6),d1
										jsr     j_RemoveItemFromCaravan
										move.w  -8(a6),d0
										move.w  -4(a6),d1
										jsr     j_AddItem
										move.w  -$A(a6),d1
										jsr     j_AddItemToCaravan
										move.w  -4(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  -8(a6),((TEXT_NAME_INDEX_2-$1000000)).w
										move.w  -$A(a6),((TEXT_NAME_INDEX_3-$1000000)).w
										move.w  #$29,d1 
										bsr.w   ChooseCaravanPortrait
loc_2247C:
										
										bra.s   loc_22488
loc_2247E:
										
										trap    #TEXTBOX
										dc.w 4                  ; "Did you change your mind?{W2}"
										trap    #TEXTBOX
										dc.w $FFFF
										rts

	; End of function sub_22384


; START OF FUNCTION CHUNK FOR sub_22384

loc_22488:
										
										bra.s   loc_22494
loc_2248A:
										
										move.w  #$52,d1 
										bsr.w   ChooseCaravanPortrait
										rts
loc_22494:
										
										bra.w   sub_22384

; END OF FUNCTION CHUNK FOR sub_22384


; =============== S U B R O U T I N E =======================================

sub_22498:
										
										bsr.w   sub_22926       
										tst.w   ((word_FFB12E-$1000000)).w
										beq.w   loc_2252A
										move.w  #$55,d1 
										bsr.w   ChooseCaravanPortrait
										jsr     sub_1004C
										move.w  d0,d2
										move.w  d1,-6(a6)
										move.w  d2,-4(a6)
										move.w  -4(a6),d1
										jsr     sub_2299E
										bcs.w   loc_22534
										cmpi.w  #$FFFF,-4(a6)
										beq.s   loc_2251E
										move.w  -4(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										trap    #TEXTBOX
										dc.w $2C                ; "The {ITEM} will be{N}discarded.  Are you sure?"
										jsr     j_YesNoChoiceBox
										tst.w   d0
										bne.s   loc_22518
										move.w  -6(a6),d1
										jsr     j_RemoveItemFromCaravan
										move.w  -4(a6),d1
										jsr     j_GetItemDefAddress
										btst    #3,8(a0)
										beq.s   loc_22508
										jsr     j_AddItemToDeals
loc_22508:
										
										move.w  -4(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  #$2A,d1 
										bsr.w   ChooseCaravanPortrait
										bra.s   loc_2251C
loc_22518:
										
										trap    #TEXTBOX
										dc.w 4                  ; "Did you change your mind?{W2}"
loc_2251C:
										
										bra.s   loc_22528
loc_2251E:
										
										trap    #TEXTBOX
										dc.w 4                  ; "Did you change your mind?{W2}"
										trap    #TEXTBOX
										dc.w $FFFF
										rts

	; End of function sub_22498


; START OF FUNCTION CHUNK FOR sub_22498

loc_22528:
										
										bra.s   loc_22534
loc_2252A:
										
										move.w  #$52,d1 
										bsr.w   ChooseCaravanPortrait
										rts
loc_22534:
										
										bra.w   sub_22498

; END OF FUNCTION CHUNK FOR sub_22498


; =============== S U B R O U T I N E =======================================

CaravanItemMenuActions:
										
										moveq   #0,d1
										bra.w   loc_22540
loc_2253E:
										
										moveq   #$FFFFFFFF,d1
loc_22540:
										
										moveq   #0,d0
										moveq   #3,d2
										lea     (InitStack).w,a0
										jsr     j_ExecuteMenu
										cmpi.w  #$FFFF,d0
										beq.w   return_2256A
										add.w   d0,d0
										move.w  rjt_CaravanItemMenuActions(pc,d0.w),d0
										jsr     rjt_CaravanItemMenuActions(pc,d0.w)
										bra.s   loc_2253E

	; End of function CaravanItemMenuActions

rjt_CaravanItemMenuActions:
										dc.w sub_2256C-rjt_CaravanItemMenuActions
										dc.w sub_22610-rjt_CaravanItemMenuActions
										dc.w sub_22776-rjt_CaravanItemMenuActions
										dc.w sub_227B0-rjt_CaravanItemMenuActions

; START OF FUNCTION CHUNK FOR CaravanItemMenuActions

return_2256A:
										
										rts

; END OF FUNCTION CHUNK FOR CaravanItemMenuActions


; =============== S U B R O U T I N E =======================================

sub_2256C:
										
										move.w  #$18,d1
										bsr.w   ChooseCaravanPortrait
loc_22574:
										
										moveq   #0,d1
										bsr.w   sub_228D8
										move.b  #1,((byte_FFB13C-$1000000)).w
										move.w  #ITEMIDX_NOTHING,((word_FFB13A-$1000000)).w
										jsr     sub_10044
										move.w  d0,-2(a6)
										move.w  d1,-6(a6)
										move.w  d2,-4(a6)
										cmpi.w  #$FFFF,d0
										beq.s   loc_225FA
										move.w  -4(a6),d1
										jsr     sub_229CA
										tst.w   d2
										bne.s   loc_225EA
										move.w  -4(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  #$19,d1
										bsr.w   ChooseCaravanPortrait
										move.b  #0,((byte_FFB13C-$1000000)).w
										jsr     sub_10040
										cmpi.w  #$FFFF,d0
										beq.s   loc_225E4
										move.w  -4(a6),d1
										bsr.w   UseFieldItem    
										move.w  -2(a6),d0
										move.w  -6(a6),d1
										jsr     j_RemoveItemBySlot
										bra.s   loc_225E8
loc_225E4:
										
										trap    #TEXTBOX
										dc.w 4                  ; "Did you change your mind?{W2}"
loc_225E8:
										
										bra.s   loc_225F8
loc_225EA:
										
										move.w  -4(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  #$1A,d1
										bsr.w   ChooseCaravanPortrait
loc_225F8:
										
										bra.s   loc_22604
loc_225FA:
										
										trap    #TEXTBOX
										dc.w 4                  ; "Did you change your mind?{W2}"
										trap    #TEXTBOX
										dc.w $FFFF
										rts

	; End of function sub_2256C


; START OF FUNCTION CHUNK FOR sub_2256C

loc_22604:
										
										move.w  #$1B,d1
										bsr.w   ChooseCaravanPortrait
										bra.w   loc_22574

; END OF FUNCTION CHUNK FOR sub_2256C


; =============== S U B R O U T I N E =======================================

sub_22610:
										
										move.w  #$1C,d1
										bsr.w   ChooseCaravanPortrait
loc_22618:
										
										moveq   #0,d1
										bsr.w   sub_228D8
										move.b  #1,((byte_FFB13C-$1000000)).w
										move.w  #ITEMIDX_NOTHING,((word_FFB13A-$1000000)).w
										jsr     sub_10044
										move.w  d0,-2(a6)
										move.w  d1,-6(a6)
										move.w  d2,-4(a6)
										cmpi.w  #$FFFF,d0
										beq.w   loc_22760
										bsr.w   sub_2294C       
										bcs.w   loc_2276A
										move.w  -4(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  #$1D,d1
										bsr.w   ChooseCaravanPortrait
										move.b  #2,((byte_FFB13C-$1000000)).w
										move.w  -4(a6),((word_FFB13A-$1000000)).w
										jsr     sub_10044
										move.w  d0,-8(a6)
										move.w  d1,-$C(a6)
										move.w  d2,-$A(a6)
										cmpi.w  #$FFFF,d0
										beq.w   loc_2275A
										cmp.w   -2(a6),d0
										bne.s   loc_226B6
										move.w  -2(a6),d0
										move.w  -6(a6),d1
										jsr     j_RemoveItemBySlot
										move.w  -4(a6),d1
										jsr     j_AddItem
										move.w  -2(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  -4(a6),((TEXT_NAME_INDEX_2-$1000000)).w
										move.w  #$30,d1 
										bsr.w   ChooseCaravanPortrait
										bra.w   loc_22758
loc_226B6:
										
										moveq   #0,d1
										jsr     j_GetItemAndNumberOfItems
										cmpi.w  #4,d2
										beq.s   loc_226F6
										move.w  -8(a6),d0
										move.w  -4(a6),d1
										jsr     j_AddItem
										move.w  -2(a6),d0
										move.w  -6(a6),d1
										jsr     j_RemoveItemBySlot
										move.w  -4(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  -8(a6),((TEXT_NAME_INDEX_2-$1000000)).w
										move.w  #$28,d1 
										bsr.w   ChooseCaravanPortrait
										bra.s   loc_22758
loc_226F6:
										
										move.w  -8(a6),d1
										move.w  -$C(a6),d1
										bsr.w   sub_2294C       
										bcs.w   loc_2276A
										move.w  -8(a6),d0
										move.w  -$C(a6),d1
										jsr     j_RemoveItemBySlot
										move.w  -2(a6),d0
										move.w  -6(a6),d1
										jsr     j_RemoveItemBySlot
										move.w  -8(a6),d0
										move.w  -4(a6),d1
										jsr     j_AddItem
										move.w  -2(a6),d0
										move.w  -$A(a6),d1
										jsr     j_AddItem
										move.w  -4(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  -8(a6),((TEXT_NAME_INDEX_2-$1000000)).w
										move.w  -$A(a6),((TEXT_NAME_INDEX_3-$1000000)).w
										move.w  #$29,d1 
										bsr.w   ChooseCaravanPortrait
loc_22758:
										
										bra.s   loc_2275E
loc_2275A:
										
										trap    #TEXTBOX
										dc.w 4                  ; "Did you change your mind?{W2}"
loc_2275E:
										
										bra.s   loc_2276A
loc_22760:
										
										trap    #TEXTBOX
										dc.w 4                  ; "Did you change your mind?{W2}"
										trap    #TEXTBOX
										dc.w $FFFF
										rts

	; End of function sub_22610


; START OF FUNCTION CHUNK FOR sub_22610

loc_2276A:
										
										move.w  #$20,d1 
										bsr.w   ChooseCaravanPortrait
										bra.w   loc_22618

; END OF FUNCTION CHUNK FOR sub_22610


; =============== S U B R O U T I N E =======================================

sub_22776:
										
										move.w  #$21,d1 
										bsr.w   ChooseCaravanPortrait
loc_2277E:
										
										moveq   #0,d1
										bsr.w   sub_228D8
										move.b  #3,((byte_FFB13C-$1000000)).w
										move.w  #ITEMIDX_NOTHING,((word_FFB13A-$1000000)).w
										jsr     sub_10044
										cmpi.w  #$FFFF,d0
										bne.s   loc_227A6
										trap    #TEXTBOX
										dc.w 4                  ; "Did you change your mind?{W2}"
										trap    #TEXTBOX
										dc.w $FFFF
										rts

	; End of function sub_22776


; START OF FUNCTION CHUNK FOR sub_22776

loc_227A6:
										
										move.w  #$23,d1 
										bsr.w   ChooseCaravanPortrait
										bra.s   loc_2277E

; END OF FUNCTION CHUNK FOR sub_22776


; =============== S U B R O U T I N E =======================================

sub_227B0:
										
										move.w  #$24,d1 
										bsr.w   ChooseCaravanPortrait
loc_227B8:
										
										moveq   #0,d1
										bsr.w   sub_228D8
										move.b  #1,((byte_FFB13C-$1000000)).w
										move.w  #ITEMIDX_NOTHING,((word_FFB13A-$1000000)).w
										jsr     sub_10044
										move.w  d0,-2(a6)
										move.w  d1,-6(a6)
										move.w  d2,-4(a6)
										cmpi.w  #$FFFF,-2(a6)
										beq.s   loc_2284E
										bsr.w   sub_2294C       
										bcs.w   loc_22858
										move.w  -4(a6),d1
										jsr     sub_2299E
										bcs.w   loc_22858
										move.w  -4(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										trap    #TEXTBOX
										dc.w $2C                ; "The {ITEM} will be{N}discarded.  Are you sure?"
										jsr     j_YesNoChoiceBox
										tst.w   d0
										bne.s   loc_22844
										move.w  -2(a6),d0
										move.w  -6(a6),d1
										jsr     j_DropItemBySlot
										move.w  -4(a6),d1
										jsr     j_GetItemDefAddress
										btst    #ITEMTYPE_BIT_RARE,ITEMDEF_OFFSET_TYPE(a0)
										beq.s   loc_22834
										jsr     j_AddItemToDeals
loc_22834:
										
										move.w  -4(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  #$2A,d1 
										bsr.w   ChooseCaravanPortrait
										bra.s   loc_2284C
loc_22844:
										
										trap    #TEXTBOX
										dc.w 4                  ; "Did you change your mind?{W2}"
										trap    #TEXTBOX
										dc.w $FFFF
loc_2284C:
										
										bra.s   loc_22858
loc_2284E:
										
										trap    #TEXTBOX
										dc.w 4                  ; "Did you change your mind?{W2}"
										trap    #TEXTBOX
										dc.w $FFFF
										rts

	; End of function sub_227B0


; START OF FUNCTION CHUNK FOR sub_227B0

loc_22858:
										
										move.w  #$26,d1 
										bsr.w   ChooseCaravanPortrait
										bra.w   loc_227B8

; END OF FUNCTION CHUNK FOR sub_227B0


; =============== S U B R O U T I N E =======================================

; only used for chirrup sandals

DisplaySpecialCaravanDescription:
										
										movem.l d0-d1/a0,-(sp)
										andi.w  #ITEM_MASK_IDX,d1
										lea     SpecialCaravanDescriptions(pc), a0
loc_22870:
										
										cmpi.w  #$FFFF,(a0)
										beq.w   loc_2289C
										cmp.b   (a0),d1
										bne.s   loc_22896
										move.b  1(a0),d1
										subq.w  #1,d1
										move.w  2(a0),d0
loc_22886:
										
										jsr     (DisplayText).w 
										addq.w  #1,d0
										dbf     d1,loc_22886
										moveq   #$FFFFFFFF,d0
										bra.w   loc_2289C
loc_22896:
										
										adda.w  #4,a0
										bra.s   loc_22870
loc_2289C:
										
										movem.l (sp)+,d0-d1/a0
										rts

	; End of function DisplaySpecialCaravanDescription

SpecialCaravanDescriptions:
										incbin "data/items/specialcaravandescriptions.bin"

; =============== S U B R O U T I N E =======================================

ChooseCaravanPortrait:
										
										movem.l d0-d1,-(sp)
										move.l  d1,-(sp)
										trap    #CHECK_FLAG
										dc.w $46                ; Astral is a follower
										bne.s   loc_228B8       
										moveq   #$B,d0          ; ROHDE portrait idx
										bra.s   loc_228BA
loc_228B8:
										
										moveq   #$1F,d0         ; Astral portrait idx
loc_228BA:
										
										moveq   #0,d1
										jsr     j_InitPortraitWindow
										move.l  (sp)+,d0
										jsr     (DisplayText).w 
										trap    #TEXTBOX
										dc.w $FFFF
										jsr     j_HidePortraitWindow
										movem.l (sp)+,d0-d1
										rts

	; End of function ChooseCaravanPortrait


; =============== S U B R O U T I N E =======================================

sub_228D8:
										
										movem.l d7-a1,-(sp)
										jsr     j_UpdateForce
										tst.w   d1
										bne.s   loc_228F0
										lea     ((TARGET_CHARACTERS_INDEX_LIST-$1000000)).w,a0
										move.w  ((TARGET_CHARACTERS_INDEX_LIST_SIZE-$1000000)).w,d7
										bra.s   loc_22908
loc_228F0:
										
										cmpi.w  #1,d1
										bne.s   loc_22900
										lea     ((BATTLE_PARTY_MEMBERS-$1000000)).w,a0
										move.w  ((NUMBER_OF_BATTLE_PARTY_MEMBERS-$1000000)).w,d7
										bra.s   loc_22908
loc_22900:
										
										lea     ((RESERVE_MEMBERS-$1000000)).w,a0
										move.w  ((NUMBER_OF_OTHER_PARTY_MEMBERS-$1000000)).w,d7
loc_22908:
										
										lea     ((byte_FFB0AE-$1000000)).w,a1
										move.w  d7,((word_FFB12E-$1000000)).w
										move.w  ((TARGET_CHARACTERS_INDEX_LIST_SIZE-$1000000)).w,d7
										subq.w  #1,d7
										bcs.w   loc_22920
loc_2291A:
										
										move.b  (a0)+,(a1)+
										dbf     d7,loc_2291A
loc_22920:
										
										movem.l (sp)+,d7-a1
										rts

	; End of function sub_228D8


; =============== S U B R O U T I N E =======================================

; copy item idxes of caravan items to index list

sub_22926:
										
										movem.l d7-a1,-(sp)
										move.w  ((NUM_ITEMS_IN_CARAVAN-$1000000)).w,d7
										move.w  d7,((word_FFB12E-$1000000)).w
										subq.w  #1,d7
										bcs.w   loc_22946
										lea     ((CARAVAN_ITEMS-$1000000)).w,a0
										lea     ((byte_FFB0AE-$1000000)).w,a1
loc_22940:
										
										move.b  (a0)+,(a1)+
										dbf     d7,loc_22940
loc_22946:
										
										movem.l (sp)+,d7-a1
										rts

	; End of function sub_22926


; =============== S U B R O U T I N E =======================================

; get whether character D0's item at slot D1 is cursed -> carry

sub_2294C:
										
										movem.l d1,-(sp)
										jsr     j_GetItemAndNumberOfItems
										bclr    #7,d1
										beq.s   loc_22988
										jsr     j_IsItemCursed
										bcc.w   loc_22986
										trap    #SOUND_COMMAND
										dc.w MUSIC_CURSED_ITEM
										move.w  #$3C,d0 
										jsr     (Sleep).w       
										move.w  d1,((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  #$1E,d1
										bsr.w   ChooseCaravanPortrait
										bsr.w   PlayPreviousMusicAfterCurrentOne
										ori     #1,ccr
loc_22986:
										
										bra.s   loc_2298A
loc_22988:
										
										tst.b   d0
loc_2298A:
										
										movem.l (sp)+,d1
										rts

	; End of function sub_2294C


; =============== S U B R O U T I N E =======================================

PlayPreviousMusicAfterCurrentOne:
										
										move.w  d0,-(sp)
										move.w  #$FB,d0 
										jsr     (PlayMusicAfterCurrentOne).w
										move.w  (sp)+,d0
										rts

	; End of function PlayPreviousMusicAfterCurrentOne


; =============== S U B R O U T I N E =======================================

sub_2299E:
										
										movem.l d1/a0,-(sp)
										jsr     j_GetItemDefAddress
										btst    #4,8(a0)
										beq.s   loc_229C2
										move.w  d1,((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  #$25,d1 
										bsr.w   ChooseCaravanPortrait
										ori     #1,ccr
										bra.s   loc_229C4
loc_229C2:
										
										tst.b   d0
loc_229C4:
										
										movem.l (sp)+,d1/a0
										rts

	; End of function sub_2299E

