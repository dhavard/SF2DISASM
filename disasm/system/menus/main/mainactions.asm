
; SCRIPT SECTION system\menus\main\mainactions :
; Main menu functions

; =============== S U B R O U T I N E =======================================

MainMenuActions:
										
										movem.l d0-a5,-(sp)
										link    a6,#-$20
loc_21286:
										
										moveq   #0,d0
										moveq   #0,d1
										moveq   #0,d2
										lea     (InitStack).w,a0
										jsr     j_ExecuteMenu
										cmpi.w  #$FFFF,d0
										beq.s   loc_212A0
										bra.w   loc_212A8
loc_212A0:
										
										unlk    a6
										movem.l (sp)+,d0-a5
										rts
loc_212A8:
										
										cmpi.w  #0,d0
										bne.w   loc_212D8
										bsr.w   sub_219EC       
										trap    #TEXTBOX
										dc.w $FFFF
loc_212B8:
										
										move.b  #0,((byte_FFB13C-$1000000)).w
										jsr     sub_10040
										cmpi.w  #$FFFF,d0
										beq.w   loc_212D4
										jsr     j_MemberStatsScreen
										bra.s   loc_212B8
loc_212D4:
										
										bra.w   loc_219E8
loc_212D8:
										
										cmpi.w  #1,d0
										bne.w   loc_2147C
loc_212E0:
										
										bsr.w   sub_219EC       
										move.b  #0,((byte_FFB13C-$1000000)).w
										jsr     sub_10048
										cmpi.w  #$FFFF,d0
										beq.w   loc_21478
										move.w  d0,-4(a6)
										move.w  d1,-$1A(a6)
										move.w  d1,-$1C(a6)
										andi.w  #$3F,-$1C(a6) 
										clr.l   -$20(a6)
										lsr.l   #6,d1
										addq.l  #1,d1
										move.l  d1,-$20(a6)
										cmpi.w  #2,-$1C(a6)
										beq.w   loc_213A8
										move.w  -4(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  -$1C(a6),((TEXT_NAME_INDEX_2-$1000000)).w
										move.l  -$20(a6),((TEXT_NUMBER-$1000000)).w
										trap    #TEXTBOX
										dc.w $F3                ; "{NAME} cast{N}{SPELL} level {#}!"
										trap    #SOUND_COMMAND
										dc.w SFX_SPELL_CAST
										trap    #TEXTBOX
										dc.w $FFFF
										cmpi.w  #$A,-$1C(a6)
										beq.w   loc_21354
loc_21348:
										
										trap    #TEXTBOX
										dc.w $138               ; "But nothing happened."
										trap    #TEXTBOX
										dc.w $FFFF
										bra.w   loc_21478
loc_21354:
										
										clr.w   d0
										move.b  ((CURRENT_MAP-$1000000)).w,d0
										cmpi.w  #$42,d0 
										blt.s   loc_21348
										cmpi.w  #$4E,d0 
										bgt.s   loc_21348
loc_21366:
										
										move.b  -$1A(a6),d1
										jsr     j_GetSpellDefAddress
										move.b  1(a0),d1
										move.w  -4(a6),d0
										jsr     j_DecreaseCurrentMP
										jsr     j_ExecuteFlashScreenScript
										move.b  ((EGRESS_MAP_INDEX-$1000000)).w,d0
										jsr     (GetEgressPositionForMap).w
										lea     ((MAP_EVENT_TYPE-$1000000)).w,a0
										move.w  #1,(a0)+
										move.b  #0,(a0)+
										move.b  d0,(a0)+
										move.b  d1,(a0)+
										move.b  d2,(a0)+
										move.b  d3,(a0)+
										clr.b   ((PLAYER_TYPE-$1000000)).w
										bra.w   loc_212A0
loc_213A8:
										
										trap    #TEXTBOX
										dc.w $6C                ; "Use magic on whom?{D1}"
										trap    #TEXTBOX
										dc.w $FFFF
										move.b  #0,((byte_FFB13C-$1000000)).w
										move.w  #$7F,((word_FFB13A-$1000000)).w 
										jsr     sub_10044
										move.w  d0,-6(a6)
										cmpi.w  #$FFFF,d0
										beq.w   loc_212E0
										move.w  -4(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  -$1C(a6),((TEXT_NAME_INDEX_2-$1000000)).w
										move.l  -$20(a6),((TEXT_NUMBER-$1000000)).w
										trap    #TEXTBOX        ; {NAME} cast{N}{SPELL} level {#}!
										dc.w $F3                ; "{NAME} cast{N}{SPELL} level {#}!"
										trap    #TEXTBOX
										dc.w $FFFF
										move.b  -$1A(a6),d1
										jsr     j_GetSpellDefAddress
										move.b  1(a0),d1
										move.w  -4(a6),d0
										jsr     j_DecreaseCurrentMP
										move.w  -6(a6),d0
										jsr     j_GetStatus
										moveq   #0,d2
										cmpi.l  #1,-$20(a6)
										beq.w   loc_2144E
										cmpi.l  #2,-$20(a6)
										beq.w   loc_2143C
										bclr    #2,d1
										beq.s   loc_2143C
										move.w  -6(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										trap    #TEXTBOX
										dc.w $12F               ; "{NAME} is no longer{N}cursed."
										moveq   #$FFFFFFFF,d2
										jsr     j_UnequipAllItemsIfNotCursed
loc_2143C:
										
										bclr    #0,d1
										beq.s   loc_2144E
										move.w  -6(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										trap    #TEXTBOX
										dc.w $12E               ; "{NAME} is no longer{N}stunned."
										moveq   #$FFFFFFFF,d2
loc_2144E:
										
										bclr    #1,d1
										beq.s   loc_21460
										move.w  -6(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										trap    #TEXTBOX
										dc.w $12D               ; "{NAME} is no longer{N}poisoned."
										moveq   #$FFFFFFFF,d2
loc_21460:
										
										tst.w   d2
										bne.s   loc_21468
										trap    #TEXTBOX
										dc.w $1A6               ; "But nothing happened.{D1}"
loc_21468:
										
										trap    #TEXTBOX
										dc.w $FFFF
										jsr     j_SetStatus
										jsr     j_ApplyStatusAndItemsOnStats
loc_21478:
										
										bra.w   loc_219E8
loc_2147C:
										
										cmpi.w  #2,d0
										bne.w   loc_219DC
loc_21484:
										
										moveq   #0,d0
										moveq   #0,d1
										moveq   #3,d2
										lea     (InitStack).w,a0
										jsr     j_ExecuteMenu
										cmpi.w  #$FFFF,d0
										beq.w   loc_21286
										cmpi.w  #0,d0
										bne.w   loc_21596
loc_214A4:
										
										bsr.w   sub_219EC       
										move.b  #1,((byte_FFB13C-$1000000)).w
										move.w  #$7F,((word_FFB13A-$1000000)).w 
										jsr     sub_10044
										move.w  d0,-4(a6)
										move.w  d1,-$C(a6)
										move.w  d2,-8(a6)
										cmpi.w  #$FFFF,d0
										beq.w   loc_2158E
										cmpi.w  #4,d2
										bne.w   loc_2150E
										clr.w   d0
										move.b  ((CURRENT_MAP-$1000000)).w,d0
										cmpi.w  #$42,d0 
										blt.w   loc_2150E
										cmpi.w  #$4E,d0 
										bgt.w   loc_2150E
										move.w  -4(a6),d0
										move.w  -$C(a6),d1
										jsr     j_RemoveItemBySlot
										move.w  -4(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  -8(a6),((TEXT_NAME_INDEX_2-$1000000)).w
										trap    #TEXTBOX
										dc.w $49                ; "{NAME} used the{N}{ITEM}.{W2}"
										bra.w   loc_21366
loc_2150E:
										
										move.w  -8(a6),d1
										jsr     sub_229CA
										tst.w   d2
										beq.w   loc_21558
										bsr.w   sub_22C60       
										move.w  -8(a6),d4
										move.w  -$C(a6),d5
										jsr     sub_44088       
										tst.w   d6
										bne.w   loc_212A0
										move.w  -4(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  -8(a6),((TEXT_NAME_INDEX_2-$1000000)).w
										trap    #TEXTBOX
										dc.w $49                ; "{NAME} used the{N}{ITEM}.{W2}"
										move.w  -8(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										trap    #TEXTBOX
										dc.w $1A6               ; "But nothing happened.{D1}"
										trap    #TEXTBOX
										dc.w $FFFF
										bra.w   loc_2158E
loc_21558:
										
										move.w  -8(a6),d1
										move.w  #$32,d1 
										trap    #TEXTBOX
										dc.w $FFFF
										move.b  #0,((byte_FFB13C-$1000000)).w
										jsr     sub_10040
										cmpi.w  #$FFFF,d0
										beq.w   loc_214A4
										move.w  -8(a6),d1
										bsr.w   UseFieldItem    
										move.w  -4(a6),d0
										move.w  -$C(a6),d1
										jsr     j_RemoveItemBySlot
loc_2158E:
										
										trap    #TEXTBOX
										dc.w $FFFF
										bra.w   loc_219D8
loc_21596:
										
										cmpi.w  #1,d0
										bne.w   loc_21856
loc_2159E:
										
										bsr.w   sub_219EC       
										move.b  #1,((byte_FFB13C-$1000000)).w
										move.w  #$7F,((word_FFB13A-$1000000)).w 
										jsr     sub_10044
										cmpi.w  #$FFFF,d0
										bne.w   loc_215C0
										bra.w   loc_2184E
loc_215C0:
										
										move.w  d0,-4(a6)
										move.w  d1,-$C(a6)
										move.w  d2,-8(a6)
										move.w  -8(a6),d1
										jsr     j_GetItemType
										cmpi.w  #1,d2
										bne.s   loc_21618
										move.w  -4(a6),d0
										jsr     j_GetEquippedWeapon
										cmpi.w  #$FFFF,d1
										beq.w   loc_21662
										cmp.w   -$C(a6),d2
										bne.w   loc_21662
										move.w  -8(a6),d1
										jsr     j_IsItemCursed
										bcc.w   loc_21662
										move.w  -8(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										trap    #SOUND_COMMAND
										dc.w MUSIC_CURSED_ITEM
										trap    #TEXTBOX
										dc.w $37                ; "{LEADER}!  You can't{N}unequip the {ITEM}.{N}It's cursed!{W2}"
										bsr.w   WaitForMusicResumeAndPlayerInput
										bra.s   loc_2159E
loc_21618:
										
										cmpi.w  #0,d2
										beq.w   loc_21662
										move.w  -4(a6),d0
										jsr     j_GetEquippedRing
										cmpi.w  #$FFFF,d1
										beq.w   loc_21662
										cmp.w   -$C(a6),d2
										bne.w   loc_21662
										move.w  -8(a6),d1
										jsr     j_IsItemCursed
										bcc.w   loc_21662
										move.w  -8(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										trap    #SOUND_COMMAND
										dc.w MUSIC_CURSED_ITEM
										trap    #TEXTBOX
										dc.w $37                ; "{LEADER}!  You can't{N}unequip the {ITEM}.{N}It's cursed!{W2}"
										bsr.w   WaitForMusicResumeAndPlayerInput
										trap    #TEXTBOX
										dc.w $FFFF
										bra.w   loc_2159E
loc_21662:
										
										move.w  -8(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										trap    #TEXTBOX
										dc.w $36                ; "Pass the {ITEM}{N}to whom?{D1}"
										trap    #TEXTBOX
										dc.w $FFFF
										move.b  #2,((byte_FFB13C-$1000000)).w
										move.w  -8(a6),((word_FFB13A-$1000000)).w
										jsr     sub_10044
										cmpi.w  #$FFFF,d0
										bne.w   loc_2168E
										bra.w   loc_2159E
loc_2168E:
										
										move.w  d0,-6(a6)
										move.w  d1,-$E(a6)
										clr.w   d1
										jsr     j_GetItemAndNumberOfItems
										cmpi.w  #4,d2
										beq.w   loc_216F8
										move.w  -4(a6),d0
										move.w  -$C(a6),d1
										jsr     j_RemoveItemBySlot
										move.w  -6(a6),d0
										move.w  -8(a6),d1
										andi.b  #ITEM_MASK_IDX,d1
										jsr     j_AddItem
										move.w  -4(a6),d0
										move.w  -6(a6),d1
										cmp.w   d0,d1
										bne.s   loc_216E4
										move.w  -4(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  -8(a6),((TEXT_NAME_INDEX_2-$1000000)).w
										trap    #TEXTBOX
										dc.w $4A                ; "{NAME} changed hands{N}to hold the {ITEM}.{W2}"
										bra.s   loc_216F4
loc_216E4:
										
										move.w  -8(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  -6(a6),((TEXT_NAME_INDEX_2-$1000000)).w
										trap    #TEXTBOX
										dc.w $41                ; "The {ITEM} now{N}belongs to {NAME}.{W2}"
loc_216F4:
										
										bra.w   loc_2184E
loc_216F8:
										
										move.w  -6(a6),d0
										move.w  -$E(a6),d1
										jsr     j_GetItemAndNumberOfItems
										move.w  d1,-$A(a6)
										jsr     j_GetItemType
										cmpi.w  #1,d2
										bne.s   loc_21758
										move.w  -6(a6),d0
										jsr     j_GetEquippedWeapon
										cmpi.w  #$FFFF,d1
										beq.w   loc_2179E
										cmp.w   -$E(a6),d2
										bne.w   loc_2179E
										move.w  -$A(a6),d1
										jsr     j_IsItemCursed
										bcc.w   loc_2179E
										move.w  -$A(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										trap    #SOUND_COMMAND
										dc.w MUSIC_CURSED_ITEM
										trap    #TEXTBOX
										dc.w $37                ; "{LEADER}!  You can't{N}unequip the {ITEM}.{N}It's cursed!{W2}"
										bsr.w   WaitForMusicResumeAndPlayerInput
										trap    #TEXTBOX
										dc.w $FFFF
										bra.w   loc_21662
loc_21758:
										
										cmpi.w  #0,d2
										beq.w   loc_2179E
										move.w  -6(a6),d0
										jsr     j_GetEquippedRing
										cmpi.w  #$FFFF,d1
										beq.w   loc_2179E
										cmp.w   -$E(a6),d2
										bne.w   loc_2179E
										move.w  -$A(a6),d1
										jsr     j_IsItemCursed
										bcc.w   loc_2179E
										move.w  -$A(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										trap    #SOUND_COMMAND
										dc.w MUSIC_CURSED_ITEM
										trap    #TEXTBOX
										dc.w $37                ; "{LEADER}!  You can't{N}unequip the {ITEM}.{N}It's cursed!{W2}"
										bsr.w   WaitForMusicResumeAndPlayerInput
										bra.w   loc_21662
loc_2179E:
										
										move.w  -4(a6),d0
										move.w  -$C(a6),d1
										jsr     j_UnequipItemIfNotCursed
										move.w  -6(a6),d2
										cmp.w   -4(a6),d2
										bne.w   loc_217C4
										move.w  -$E(a6),d3
										cmp.w   -$C(a6),d3
										beq.w   loc_2181A
loc_217C4:
										
										move.w  -4(a6),d0
										move.w  -$C(a6),d1
										jsr     j_DropItemBySlot
										move.w  -$A(a6),d1
										andi.b  #ITEM_MASK_IDX,d1
										jsr     j_AddItem
										move.w  -6(a6),d2
										cmp.w   -4(a6),d2
										bne.w   loc_217FE
										move.w  -$E(a6),d3
										cmp.w   -$C(a6),d3
										bcs.w   loc_217FE
										subi.w  #1,-$E(a6)
loc_217FE:
										
										move.w  -6(a6),d0
										move.w  -$E(a6),d1
										jsr     j_RemoveItemBySlot
										move.w  -8(a6),d1
										andi.b  #ITEM_MASK_IDX,d1
										jsr     j_AddItem
loc_2181A:
										
										move.w  -4(a6),d0
										move.w  -6(a6),d1
										cmp.w   d0,d1
										bne.s   loc_21838
										move.w  -4(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  -8(a6),((TEXT_NAME_INDEX_2-$1000000)).w
										trap    #TEXTBOX
										dc.w $4A                ; "{NAME} changed hands{N}to hold the {ITEM}.{W2}"
										bra.s   loc_2184E
loc_21838:
										
										move.w  -8(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  -6(a6),((TEXT_NAME_INDEX_2-$1000000)).w
										move.w  -$A(a6),((TEXT_NAME_INDEX_3-$1000000)).w
										trap    #TEXTBOX
										dc.w $42                ; "The {ITEM} was{N}exchanged for {NAME}'s{N}{ITEM}.{W2}"
loc_2184E:
										
										trap    #TEXTBOX
										dc.w $FFFF
										bra.w   loc_219D8
loc_21856:
										
										cmpi.w  #2,d0
										bne.w   loc_21898
										bsr.w   sub_219EC       
										move.b  #3,((byte_FFB13C-$1000000)).w
										move.w  #ITEMIDX_NOTHING,((word_FFB13A-$1000000)).w
										jsr     sub_10044
										cmpi.w  #$FFFF,d0
										beq.w   loc_21880
										bra.w   loc_21894
loc_21880:
										
										bra.w   loc_21894
										move.w  -4(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										move.w  -8(a6),((TEXT_NAME_INDEX_2-$1000000)).w
										trap    #TEXTBOX
										dc.w $46                ; "{NAME} is already{N}equipped with the{N}{ITEM}.{W2}"
loc_21894:
										
										bra.w   loc_219D8
loc_21898:
										
										bsr.w   sub_219EC       
										move.b  #1,((byte_FFB13C-$1000000)).w
										move.w  #ITEMIDX_NOTHING,((word_FFB13A-$1000000)).w
										jsr     sub_10044
										cmpi.w  #$FFFF,d0
										bne.w   loc_218BA
										bra.w   loc_219D0
loc_218BA:
										
										move.w  d0,-4(a6)
										move.w  d1,-$C(a6)
										move.w  d2,-8(a6)
										move.w  -8(a6),d1
										jsr     j_GetItemDefAddress
										move.l  8(a0),-$14(a6)
										move.b  -$14(a6),d1
										andi.b  #$10,d1
										cmpi.b  #0,d1
										beq.s   loc_218F2
										move.w  -8(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										trap    #TEXTBOX
										dc.w $3E                ; "{LEADER}!  You can't{N}discard the {ITEM}!{W2}"
										bra.w   loc_219D0
loc_218F2:
										
										move.w  -8(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										trap    #TEXTBOX
										dc.w $45                ; "The {ITEM} will be{N}discarded.  OK?"
										jsr     j_YesNoChoiceBox
										trap    #TEXTBOX
										dc.w $FFFF
										cmpi.w  #0,d0
										beq.w   loc_21910
										bra.s   loc_21898
loc_21910:
										
										move.w  -8(a6),d1
										jsr     j_GetItemType
										cmpi.w  #1,d2
										bne.s   loc_21962
										move.w  -4(a6),d0
										jsr     j_GetEquippedWeapon
										cmpi.w  #$FFFF,d1
										beq.w   loc_219A0
										cmp.w   -$C(a6),d2
										bne.w   loc_219A0
										move.w  -8(a6),d1
										jsr     j_IsItemCursed
										bcc.w   loc_219A0
										move.w  -8(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										trap    #SOUND_COMMAND
										dc.w MUSIC_CURSED_ITEM
										trap    #TEXTBOX
										dc.w $37                ; "{LEADER}!  You can't{N}unequip the {ITEM}.{N}It's cursed!{W2}"
										bsr.w   WaitForMusicResumeAndPlayerInput
										trap    #TEXTBOX
										dc.w $FFFF
										bra.w   loc_219D0
loc_21962:
										
										cmpi.w  #0,d2
										beq.w   loc_219A0
										move.w  -4(a6),d0
										jsr     j_GetEquippedRing
										cmpi.w  #$FFFF,d1
										beq.w   loc_219A0
										cmp.w   -$C(a6),d2
										bne.w   loc_219A0
										move.w  -8(a6),d1
										jsr     j_IsItemCursed
										bcc.w   loc_219A0
										move.w  -8(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										trap    #TEXTBOX
										dc.w $37                ; "{LEADER}!  You can't{N}unequip the {ITEM}.{N}It's cursed!{W2}"
										bra.w   loc_219D0
loc_219A0:
										
										move.w  -4(a6),d0
										move.w  -$C(a6),d1
										jsr     j_RemoveItemBySlot
										move.w  -8(a6),((TEXT_NAME_INDEX_1-$1000000)).w
										trap    #TEXTBOX
										dc.w $43                ; "The {ITEM} is discarded.{W2}"
										move.b  -$14(a6),d1
										andi.b  #8,d1
										cmpi.b  #0,d1
										beq.s   loc_219D0
										move.w  -8(a6),d1
										jsr     j_AddItemToDeals
loc_219D0:
										
										trap    #TEXTBOX
										dc.w $FFFF
										bra.w   *+4
loc_219D8:
										
										bra.w   loc_21484
loc_219DC:
										
										clr.w   d6
										jsr     sub_2004C
										bra.w   loc_212A0
loc_219E8:
										
										bra.w   loc_21286

	; End of function MainMenuActions


; =============== S U B R O U T I N E =======================================

; copy available targets list ?

sub_219EC:
										
										movem.l d7-a1,-(sp)
										jsr     j_UpdateForce
										lea     ((TARGET_CHARACTERS_INDEX_LIST-$1000000)).w,a0
										lea     ((byte_FFB0AE-$1000000)).w,a1
										move.w  ((TARGET_CHARACTERS_INDEX_LIST_SIZE-$1000000)).w,((word_FFB12E-$1000000)).w
										move.w  ((TARGET_CHARACTERS_INDEX_LIST_SIZE-$1000000)).w,d7
										subq.w  #1,d7
loc_21A0A:
										
										move.b  (a0)+,(a1)+
										dbf     d7,loc_21A0A
										movem.l (sp)+,d7-a1
										rts

	; End of function sub_219EC

byte_21A16:         dc.b 0
										dc.b 2
										dc.b 0
										dc.b 2
										dc.b 0
										dc.b $A

; =============== S U B R O U T I N E =======================================

sub_21A1C:
										
										movem.l d7-a0,-(sp)
										lea     byte_21A16(pc), a0
										clr.w   d7
										move.w  (a0)+,d7
										subq.w  #1,d7
loc_21A2A:
										
										cmp.w   (a0)+,d1
										beq.w   loc_21A34
										dbf     d7,loc_21A2A
loc_21A34:
										
										movem.l (sp)+,d7-a0
										rts

	; End of function sub_21A1C

