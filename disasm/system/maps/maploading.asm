
; SCRIPT SECTION system\maps\maploading :
; Map loading functions

; =============== S U B R O U T I N E =======================================

; In: A0 = compressed map layout data (block indexes)
;     A1 = RAM address to put map layout data

LoadMapLayoutData:
										
										movem.l d0-a6,-(sp)
										lea     (byte_FF6000).l,a4
										moveq   #0,d3
										move.w  #$7F,d0 
loc_20F6:
										move.l  d3,(a4)+
										move.l  d3,(a4)+
										move.l  d3,(a4)+
										move.l  d3,(a4)+
										dbf     d0,loc_20F6
										movea.l a1,a3
										lea     $2000(a1),a6    ; set a6 as 0x2000 past beginning in RAM (to signify end)
										clr.w   d3
										moveq   #2,d7
										lea     (byte_FF6000).l,a4
										moveq   #0,d3
loc_2114:
										cmpa.l  a6,a1           ; loop point; compare a1 to a6 to see if we're done
										bcs.s   loc_211E
										movem.l (sp)+,d0-a6
										rts
loc_211E:
										dbf     d3,loc_2126
										moveq   #$F,d3
										move.w  (a0)+,d0
loc_2126:
										add.w   d0,d0
										bcs.w   loc_21A6        ; passes on barrel = 0
										dbf     d3,loc_2134
										moveq   #$F,d3
										move.w  (a0)+,d0
loc_2134:
										add.w   d0,d0
										bcs.w   loc_214E        ; passes on barrel = 00
										bsr.w   ReadMapLayoutBarrelForBlockFlags
										addq.w  #1,d7
										or.w    d7,d1           ; OR next block idx together with flags
										bsr.w   sub_2310
										bsr.w   sub_22F4
										move.w  d1,(a1)+
										bra.s   loc_2114        
loc_214E:
										moveq   #$FFFFFFFF,d4   ; barrel = 01
										clr.w   d1
										moveq   #2,d5
loc_2154:
										dbf     d3,loc_215C
										moveq   #$F,d3
										move.w  (a0)+,d0
loc_215C:
										add.w   d0,d0
										dbcs    d4,loc_2154
										negx.w  d4
										dbf     d4,loc_216A
										bra.s   loc_2180
loc_216A:
										lsl.w   d4,d5
loc_216C:
										dbf     d3,loc_2174
										moveq   #$F,d3
										move.w  (a0)+,d0
loc_2174:
										add.w   d0,d0
										addx.w  d1,d1
										dbf     d4,loc_216C
										add.w   d5,d1
										subq.w  #1,d1
loc_2180:
										dbf     d3,loc_2188
										moveq   #$F,d3
										move.w  (a0)+,d0
loc_2188:
										add.w   d0,d0
										bcs.w   loc_219A
loc_218E:
										move.w  -$80(a1),(a1)+
										dbf     d1,loc_218E
										bra.w   loc_2114        
loc_219A:
										move.w  -2(a1),(a1)+
										dbf     d1,loc_219A
										bra.w   loc_2114        
loc_21A6:
										lea     -2(a1),a2
										cmpa.l  a3,a2
										bcc.s   loc_21B4
										clr.w   d1
										bra.w   loc_21BA
loc_21B4:
										move.w  (a2),d1
										andi.w  #$3FF,d1
loc_21BA:
										move.w  d1,d4
										move.b  (a4,d1.w),d1
										ext.w   d1
										dbf     d1,loc_21C8
										bra.s   loc_2208
loc_21C8:
										dbf     d3,loc_21D0
										moveq   #$F,d3
										move.w  (a0)+,d0
loc_21D0:
										add.w   d0,d0
										bcs.w   loc_2208
										lea     (word_FF6800).l,a5
										bra.w   loc_21F0
loc_21E0:
										dbf     d3,loc_21E8
										moveq   #$F,d3
										move.w  (a0)+,d0
loc_21E8:
										add.w   d0,d0
										bcs.w   loc_21F4
										addq.w  #2,a5
loc_21F0:
										dbf     d1,loc_21E0
loc_21F4:
										lsl.w   #3,d4
										move.w  (a5,d4.w),d1
										bsr.w   sub_2310
										bsr.w   sub_22F4
										move.w  d1,(a1)+
										bra.w   loc_2114        
loc_2208:
										lea     -$80(a1),a2
										cmpa.l  a3,a2
										bcc.s   loc_2216
										clr.w   d1
										bra.w   loc_221C
loc_2216:
										move.w  (a2),d1
										andi.w  #$3FF,d1
loc_221C:
										move.w  d1,d4
										ori.w   #$400,d1
										move.b  (a4,d1.w),d1
										ext.w   d1
										dbf     d1,loc_222E
										bra.s   loc_226E
loc_222E:
										dbf     d3,loc_2236
										moveq   #$F,d3
										move.w  (a0)+,d0
loc_2236:
										add.w   d0,d0
										bcs.w   loc_226E
										lea     (dword_FF8800).l,a5
										bra.w   loc_2256
loc_2246:
										dbf     d3,loc_224E
										moveq   #$F,d3
										move.w  (a0)+,d0
loc_224E:
										add.w   d0,d0
										bcs.w   loc_225A
										addq.w  #2,a5
loc_2256:
										dbf     d1,loc_2246
loc_225A:
										lsl.w   #3,d4
										move.w  (a5,d4.w),d1
										bsr.w   sub_2310
										bsr.w   sub_22F4
										move.w  d1,(a1)+
										bra.w   loc_2114        
loc_226E:
										move.w  d7,d1
										clr.w   d4
loc_2272:
										dbf     d3,loc_227A
										moveq   #$F,d3
										move.w  (a0)+,d0
loc_227A:
										add.w   d0,d0
										addx.w  d4,d4
										lsr.w   #1,d1
										bne.s   loc_2272
										bsr.w   ReadMapLayoutBarrelForBlockFlags
										or.w    d4,d1
										bsr.w   sub_2310
										bsr.w   sub_22F4
										move.w  d1,(a1)+
										bra.w   loc_2114        

	; End of function LoadMapLayoutData


; =============== S U B R O U T I N E =======================================

; Reads next part of barrel to determine flags for next block
; barrel = 00
; 
; In: D0 = barrel
; Out: D1 = block flag word

ReadMapLayoutBarrelForBlockFlags:
										
										dbf     d3,loc_229E
										moveq   #$F,d3
										move.w  (a0)+,d0
loc_229E:
										add.w   d0,d0
										bcs.w   loc_22B6        ; passes on barrel = 000
										clr.w   d1
										dbf     d3,loc_22AE
										moveq   #$F,d3
										move.w  (a0)+,d0
loc_22AE:
										add.w   d0,d0
										roxr.w  #1,d1           ; barrel = 0001
										asr.w   #1,d1
										rts
loc_22B6:
										dbf     d3,loc_22BE     ; barrel = 001
										moveq   #$F,d3
										move.w  (a0)+,d0
loc_22BE:
										add.w   d0,d0
										bcs.w   loc_22D8        ; passes on barrel = 0010
										clr.w   d1
										dbf     d3,loc_22CE
										moveq   #$F,d3
										move.w  (a0)+,d0
loc_22CE:
										add.w   d0,d0
										addx.w  d1,d1
										addq.w  #1,d1
										ror.w   #2,d1
										rts
loc_22D8:
										move.l  d2,-(sp)        ; barrel = 0011
										moveq   #5,d2
										clr.w   d1
loc_22DE:
										dbf     d3,loc_22E6
										moveq   #$F,d3
										move.w  (a0)+,d0
loc_22E6:
										add.w   d0,d0
										addx.w  d1,d1
										dbf     d2,loc_22DE
										ror.w   #6,d1
										move.l  (sp)+,d2
										rts

	; End of function ReadMapLayoutBarrelForBlockFlags


; =============== S U B R O U T I N E =======================================

sub_22F4:
										lea     -$80(a1),a2
										cmpa.l  a3,a2
										bcc.s   loc_2302
										clr.w   d4
										bra.w   loc_2308
loc_2302:
										move.w  (a2),d4
										andi.w  #$3FF,d4
loc_2308:
										ori.w   #$400,d4
										bra.w   loc_2324

	; End of function sub_22F4


; =============== S U B R O U T I N E =======================================

sub_2310:
										lea     -2(a1),a2
										cmpa.l  a3,a2           ; check that a block-to-the-left exists (not left-most block)
										bcc.s   loc_231E        
										clr.w   d4              ; left-most block, so set block idx to 0
										bra.w   loc_2324
loc_231E:
										move.w  (a2),d4         ; copy last block idx (to the left of current block) to d4
										andi.w  #$3FF,d4
loc_2324:
										lea     (a4,d4.w),a5
										move.b  (a5),d2
										ext.w   d2
										move.w  d2,d5
										lsl.w   #3,d4
										lea     (word_FF6800).l,a2
										adda.w  d4,a2
										dbf     d5,loc_2344
										move.b  #1,(a5)
										move.w  d1,(a2)
										rts
loc_2344:
										move.w  d1,d4
loc_2346:
										move.w  (a2),d6
										move.w  d4,(a2)+
										cmp.w   d6,d1
										beq.s   return_2370
loc_234E:
										dbf     d5,loc_235C
										subq.w  #4,d2
										bcc.s   return_235A
										move.w  d6,(a2)
										addq.b  #1,(a5)
return_235A:
										
										rts
loc_235C:
										move.w  (a2),d4
										move.w  d6,(a2)+
										cmp.w   d4,d1
										beq.s   return_2370
										dbf     d5,loc_2346
										subq.w  #4,d2
										bcc.s   return_2370
										move.w  d4,(a2)
										addq.b  #1,(a5)
return_2370:
										
										rts

	; End of function sub_2310


; =============== S U B R O U T I N E =======================================

sub_2372:
										movem.l d0-a6,-(sp)
										lea     (word_FF6800).l,a2
										clr.w   d4
										move.w  #$100,d0
										move.w  d0,(a1)+
										move.w  d0,(a1)+
										move.w  d0,(a1)+
										move.w  d0,(a1)+
										move.w  d0,(a1)+
										move.w  d0,(a1)+
										move.w  d0,(a1)+
										move.w  d0,(a1)+
										move.w  d0,(a1)+
										move.w  #$32E,(a1)+
										move.w  #$32F,(a1)+
										move.w  #$B2E,(a1)+
loc_23A0:
										move.w  #$33E,(a1)+
										move.w  #$33F,(a1)+
										move.w  #$B3E,(a1)+
										move.w  #$34E,(a1)+
										move.w  #$34F,(a1)+
										move.w  #$B4E,(a1)+
loc_23B8:
										move.w  #$32C,(a1)+
										move.w  #$32D,(a1)+
										move.w  #$B2C,(a1)+
										move.w  #$33C,(a1)+
										move.w  #$33D,(a1)+
										move.w  #$B3C,(a1)+
loc_23D0:
										move.w  #$34E,(a1)+
										move.w  #$34F,(a1)+
										move.w  #$B4E,(a1)+
										subi.w  #$E,d4
										bcc.s   loc_2402
										addi.w  #$E,d4
										rol.l   d4,d0
										move.w  (a0)+,d0
										subi.w  #$E,d4
										neg.w   d4
										rol.l   d4,d0
										neg.w   d4
										addi.w  #$10,d4
										move.l  d0,d5
										swap    d5
										andi.w  #$3FFF,d5
										bra.s   loc_240A
loc_2402:
										move.w  #$3FFF,d5
										ror.w   #2,d0
										and.w   d0,d5
loc_240A:
										dbf     d5,loc_2414
										movem.l (sp)+,d0-a6
										rts
loc_2414:
										dbf     d4,loc_241C
										moveq   #$F,d4
										move.w  (a0)+,d0
loc_241C:
										add.w   d0,d0
										bcs.w   loc_244C
										dbf     d4,loc_242A
										moveq   #$F,d4
										move.w  (a0)+,d0
loc_242A:
										add.w   d0,d0
loc_242C:
										bcs.w   loc_2436
										move.w  -2(a1),(a1)+
										bra.s   loc_240A
loc_2436:
										move.w  -2(a1),d1
										btst    #$B,d1
										bne.s   loc_2446
										addq.w  #1,d1
										move.w  d1,(a1)+
										bra.s   loc_240A
loc_2446:
										subq.w  #1,d1
										move.w  d1,(a1)+
										bra.s   loc_240A
loc_244C:
										dbf     d4,loc_2454
										moveq   #$F,d4
										move.w  (a0)+,d0
loc_2454:
										add.w   d0,d0
										bcs.w   loc_249E
										dbf     d4,loc_2462
										moveq   #$F,d4
										move.w  (a0)+,d0
loc_2462:
										add.w   d0,d0
										bcs.w   loc_2480
										move.w  -2(a1),d1
										move.w  d1,d2
										andi.w  #$3FF,d1
										andi.w  #$800,d2
										add.w   d1,d1
										or.w    d2,d1
										move.w  (a2,d1.w),(a1)+
										bra.s   loc_240A
loc_2480:
										move.w  -6(a1),d1
										move.w  d1,d2
										andi.w  #$3FF,d1
										andi.w  #$800,d2
										ori.w   #$1000,d2
										add.w   d1,d1
										or.w    d2,d1
loc_2496:
										move.w  (a2,d1.w),(a1)+
										bra.w   loc_240A
loc_249E:
										dbf     d4,loc_24A6
										moveq   #$F,d4
										move.w  (a0)+,d0
loc_24A6:
										add.w   d0,d0
										bcs.w   loc_24B8
										move.w  -2(a1),d7
										andi.w  #$9800,d7
										bra.w   loc_24E0
loc_24B8:
										clr.w   d7
										dbf     d4,loc_24C2
										moveq   #$F,d4
										move.w  (a0)+,d0
loc_24C2:
										add.w   d0,d0
										roxl.w  #3,d7
										dbf     d4,loc_24CE
										moveq   #$F,d4
										move.w  (a0)+,d0
loc_24CE:
										add.w   d0,d0
										addx.w  d7,d7
										dbf     d4,loc_24DA
										moveq   #$F,d4
										move.w  (a0)+,d0
loc_24DA:
										add.w   d0,d0
										addx.w  d7,d7
										ror.w   #5,d7
loc_24E0:
										dbf     d4,loc_24E8
										moveq   #$F,d4
										move.w  (a0)+,d0
loc_24E8:
										add.w   d0,d0
										bcc.w   loc_253C
										subi.w  #9,d4
										bcc.s   loc_2514
										addi.w  #9,d4
										rol.l   d4,d0
										move.w  (a0)+,d0
										subi.w  #9,d4
										neg.w   d4
										rol.l   d4,d0
										neg.w   d4
										addi.w  #$10,d4
										move.l  d0,d3
										swap    d3
										andi.w  #$1FF,d3
										bra.s   loc_251C
loc_2514:
										move.w  #$1FF,d3
										ror.w   #7,d0
										and.w   d0,d3
loc_251C:
										cmpi.w  #$180,d3
										bcs.s   loc_2532
										dbf     d4,loc_252A
										moveq   #$F,d4
										move.w  (a0)+,d0
loc_252A:
										add.w   d0,d0
										addx.w  d3,d3
										subi.w  #$180,d3
loc_2532:
										addi.w  #$100,d3
										or.w    d7,d3
										bra.w   loc_257A
loc_253C:
										subq.w  #5,d4
										bcc.s   loc_255C
										addq.w  #5,d4
										rol.l   d4,d0
										move.w  (a0)+,d0
										subq.w  #5,d4
										neg.w   d4
										rol.l   d4,d0
										neg.w   d4
										addi.w  #$10,d4
										move.l  d0,d3
										swap    d3
										andi.w  #$1F,d3
										bra.s   loc_2562
loc_255C:
										moveq   #$1F,d3
										rol.w   #5,d0
										and.w   d0,d3
loc_2562:
										dbf     d4,loc_256A
										moveq   #$F,d4
										move.w  (a0)+,d0
loc_256A:
										add.w   d0,d0
										bcc.s   loc_2570
										neg.w   d3
loc_2570:
										add.w   -2(a1),d3
										andi.w  #$7FF,d3
										or.w    d7,d3
loc_257A:
										move.w  -2(a1),d1
										move.w  d1,d2
										andi.w  #$3FF,d1
										andi.w  #$800,d2
										add.w   d1,d1
										or.w    d2,d1
										move.w  d3,(a2,d1.w)
										move.w  -6(a1),d1
										move.w  d1,d2
										andi.w  #$3FF,d1
										andi.w  #$800,d2
										ori.w   #$1000,d2
										add.w   d1,d1
										or.w    d2,d1
										move.w  d3,(a2,d1.w)
										move.w  d3,(a1)+
										bra.w   loc_240A

	; End of function sub_2372


; =============== S U B R O U T I N E =======================================

sub_25B0:
										clr.w   d1
										move.b  ((CURRENT_MAP-$1000000)).w,d1
										movea.l (p_pt_MapData).l,a5
										lsl.w   #2,d1
										movea.l (a5,d1.w),a5
										addq.l  #1,a5
										movea.l (p_pt_MapTiles).l,a0
										clr.w   d0
										move.b  (a5)+,d0
										blt.s   loc_25E8
										lsl.w   #2,d0
										movea.l (a0,d0.w),a0
										lea     ($2000).w,a1
										move.w  #$800,d0
										moveq   #2,d1
										bsr.w   DmaTilesViaFF8804bis
										bsr.w   SetFFDE94b3andWait
loc_25E8:
										addq.l  #1,a5
										movea.l (p_pt_MapTiles).l,a0
										clr.w   d0
										move.b  (a5)+,d0
										blt.s   loc_260E
										lsl.w   #2,d0
										movea.l (a0,d0.w),a0
										lea     ($4000).w,a1
										move.w  #$800,d0
										moveq   #2,d1
										bsr.w   DmaTilesViaFF8804bis
										bsr.w   SetFFDE94b3andWait
loc_260E:
										movea.l (p_pt_MapTiles).l,a0
										clr.w   d0
										move.b  (a5)+,d0
										blt.s   loc_2632
										lsl.w   #2,d0
										movea.l (a0,d0.w),a0
										lea     ($5000).w,a1
										move.w  #$800,d0
										moveq   #2,d1
										bsr.w   DmaTilesViaFF8804bis
										bsr.w   SetFFDE94b3andWait
loc_2632:
										addq.l  #1,a5
										trap    #VINT_FUNCTIONS
										dc.w VINTS_DEACTIVATE
										dc.l 0
										trap    #VINT_FUNCTIONS
										dc.w VINTS_ACTIVATE
										dc.l VInt_3930          
										bsr.w   sub_2D58
										movea.l (a5)+,a4
										move.w  (a4)+,d0
										move.w  (a4)+,d1
										move.w  (a4)+,d2
										move.w  (a4)+,d3
										mulu.w  #$180,d0
										mulu.w  #$180,d1
										mulu.w  #$180,d2
										mulu.w  #$180,d3
										bsr.w   sub_2670        
										trap    #VINT_FUNCTIONS
										dc.w VINTS_ACTIVATE
										dc.l 0
										rts

	; End of function sub_25B0


; =============== S U B R O U T I N E =======================================

; related to 4 choices apparently

sub_2670:
										move.b  ((byte_FFA84C-$1000000)).w,d0
										andi.w  #3,d0
										add.w   d0,d0
										move.w  rjt_2682(pc,d0.w),d0
										jmp     rjt_2682(pc,d0.w)

	; End of function sub_2670

rjt_2682:           dc.w sub_268A-rjt_2682
										dc.w sub_2816-rjt_2682
										dc.w sub_2750-rjt_2682
										dc.w sub_28DC-rjt_2682

; =============== S U B R O U T I N E =======================================

sub_268A:
										move.w  #0,((word_FFA810-$1000000)).w
										move.w  #0,((word_FFA814-$1000000)).w
										move.w  #0,((word_FFA818-$1000000)).w
										move.w  #0,((word_FFA81C-$1000000)).w
										jsr     sub_43A4(pc)
										nop
										move.w  #$1D,d7
										lea     (byte_FFE000).l,a0
										lea     (byte_FFC000).l,a1
										move.w  #2,d0
										move.w  #$3E,d1 
loc_26C0:
										subq.w  #8,((word_FFA804-$1000000)).w
										cmpi.w  #$14,d7
										bge.s   loc_26D0
										move.w  #$F900,d2
										bra.s   loc_26D4
loc_26D0:
										move.w  #$F900,d2
loc_26D4:
										move.w  #$F800,d3
										bsr.w   sub_29A2
										bsr.w   WaitForVInt     
										move.w  #$1F,d6
										movem.l d0-d1,-(sp)
loc_26E8:
										move.w  (a0,d0.w),(a1,d1.w)
										addi.w  #$40,d0 
										addi.w  #$40,d1 
										dbf     d6,loc_26E8
										movem.l (sp)+,d0-d1
										addq.w  #2,d0
										andi.w  #$3E,d0 
										addq.w  #2,d1
										andi.w  #$3E,d1 
										movem.l d0-d1/a0-a1,-(sp)
										lea     (byte_FFC000).l,a0
										lea     ($C000).l,a1
										move.w  #$400,d0
										moveq   #2,d1
										bsr.w   sub_119E        
										bsr.w   Set_FFDE94_bit3 
										movem.l (sp)+,d0-d1/a0-a1
										dbf     d7,loc_26C0
										bsr.w   WaitForVInt     
										move.w  #0,((word_FFA804-$1000000)).w
										move.w  #0,((word_FFA806-$1000000)).w
										trap    #VINT_FUNCTIONS
										dc.w VINTS_DEACTIVATE
										dc.l VInt_3930          
										jsr     sub_4344(pc)
										nop
										rts

	; End of function sub_268A


; =============== S U B R O U T I N E =======================================

sub_2750:
										move.w  #$4F80,((word_FFA810-$1000000)).w
										move.w  #$4F80,((word_FFA814-$1000000)).w
										move.w  #$4F80,((word_FFA818-$1000000)).w
										move.w  #$4F80,((word_FFA81C-$1000000)).w
										jsr     sub_43A4(pc)
										nop
										move.w  #$1D,d7
loc_2772:
										lea     (byte_FFE000).l,a0
										lea     (byte_FFC000).l,a1
										move.w  #$3C,d0 
loc_2782:
										move.w  #0,d1
loc_2786:
										addq.w  #8,((word_FFA804-$1000000)).w
										cmpi.w  #$14,d7
										bge.s   loc_2796
										move.w  #$700,d2
										bra.s   loc_279A
loc_2796:
										move.w  #$700,d2
loc_279A:
										move.w  #$800,d3
										bsr.w   sub_29A2
loc_27A2:
										bsr.w   WaitForVInt     
										move.w  #$1F,d6
										movem.l d0-d1,-(sp)
loc_27AE:
										move.w  (a0,d0.w),(a1,d1.w)
										addi.w  #$40,d0 
										addi.w  #$40,d1 
										dbf     d6,loc_27AE
										movem.l (sp)+,d0-d1
										subq.w  #2,d0
										andi.w  #$3E,d0 
										subq.w  #2,d1
										andi.w  #$3E,d1 
										movem.l d0-d1/a0-a1,-(sp)
										lea     (byte_FFC000).l,a0
										lea     ($C000).l,a1
										move.w  #$400,d0
										moveq   #2,d1
										bsr.w   sub_119E        
										bsr.w   Set_FFDE94_bit3 
										movem.l (sp)+,d0-d1/a0-a1
										dbf     d7,loc_2786
loc_27F6:
										bsr.w   WaitForVInt     
										move.w  #8,((word_FFA804-$1000000)).w
loc_2800:
										move.w  #8,((word_FFA806-$1000000)).w
										trap    #VINT_FUNCTIONS
										dc.w VINTS_DEACTIVATE
off_280A:
										dc.l VInt_3930          
										jsr     sub_4344(pc)
										nop
										rts

	; End of function sub_2750


; =============== S U B R O U T I N E =======================================

sub_2816:
										move.w  #$5100,((word_FFA812-$1000000)).w
										move.w  #$5100,((word_FFA816-$1000000)).w
										move.w  #$5100,((word_FFA81A-$1000000)).w
										move.w  #$5100,((word_FFA81E-$1000000)).w
										jsr     sub_43A4(pc)
										nop
										move.w  #$1A,d7
										lea     (byte_FFE000).l,a0
										lea     (byte_FFC000).l,a1
										move.w  #$6C0,d0
										move.w  #0,d1
loc_284C:
										subq.w  #8,((word_FFA808-$1000000)).w
										cmpi.w  #$14,d7
										bge.s   loc_285C
										move.w  #7,d2
										bra.s   loc_2860
loc_285C:
										move.w  #7,d2
loc_2860:
										move.w  #8,d3
										bsr.w   sub_29A2
										bsr.w   WaitForVInt     
										move.w  #$1F,d6
										movem.l d0-d1,-(sp)
loc_2874:
										move.w  (a0,d0.w),(a1,d1.w)
										addq.w  #2,d0
										addq.w  #2,d1
										dbf     d6,loc_2874
										movem.l (sp)+,d0-d1
										subi.w  #$40,d0 
										andi.w  #$7FE,d0
										subi.w  #$40,d1 
										andi.w  #$7FE,d1
										movem.l d0-d1/a0-a1,-(sp)
										lea     (byte_FFC000).l,a0
										lea     ($C000).l,a1
										move.w  #$400,d0
										moveq   #2,d1
										bsr.w   sub_119E        
										bsr.w   Set_FFDE94_bit3 
										movem.l (sp)+,d0-d1/a0-a1
										dbf     d7,loc_284C
										bsr.w   WaitForVInt     
loc_28C0:
										move.w  #$18,((word_FFA808-$1000000)).w
										move.w  #$18,((word_FFA80A-$1000000)).w
										trap    #VINT_FUNCTIONS
										dc.w VINTS_DEACTIVATE
										dc.l VInt_3930          
										jsr     sub_4344(pc)
										nop
										rts

	; End of function sub_2816


; =============== S U B R O U T I N E =======================================

sub_28DC:
										move.w  #0,((word_FFA812-$1000000)).w
										move.w  #0,((word_FFA816-$1000000)).w
										move.w  #0,((word_FFA81A-$1000000)).w
										move.w  #0,((word_FFA81E-$1000000)).w
										jsr     sub_43A4(pc)
										nop
										move.w  #$1A,d7
										lea     (byte_FFE000).l,a0
										lea     (byte_FFC000).l,a1
										move.w  #$140,d0
										move.w  #0,d1
loc_2912:
										addq.w  #8,((word_FFA808-$1000000)).w
										cmpi.w  #$14,d7
										bge.s   loc_2922
										move.w  #$F9,d2 
										bra.s   loc_2926
loc_2922:
										move.w  #$F9,d2 
loc_2926:
										move.w  #$F8,d3 
										bsr.w   sub_29A2
										bsr.w   WaitForVInt     
										move.w  #$1F,d6
										movem.l d0-d1,-(sp)
loc_293A:
										move.w  (a0,d0.w),(a1,d1.w)
										addq.w  #2,d0
										addq.w  #2,d1
										dbf     d6,loc_293A
										movem.l (sp)+,d0-d1
										addi.w  #$40,d0 
										andi.w  #$7FE,d0
										addi.w  #$40,d1 
										andi.w  #$7FE,d1
										movem.l d0-d1/a0-a1,-(sp)
										lea     (byte_FFC000).l,a0
										lea     ($C000).l,a1
										move.w  #$400,d0
										moveq   #2,d1
										bsr.w   sub_119E        
										bsr.w   Set_FFDE94_bit3 
										movem.l (sp)+,d0-d1/a0-a1
										dbf     d7,loc_2912
										bsr.w   WaitForVInt     
										move.w  #8,((word_FFA808-$1000000)).w
										move.w  #8,((word_FFA80A-$1000000)).w
										trap    #VINT_FUNCTIONS
										dc.w VINTS_DEACTIVATE
										dc.l VInt_3930          
										jsr     sub_4344(pc)
										nop
										rts

	; End of function sub_28DC


; =============== S U B R O U T I N E =======================================

sub_29A2:
										movem.l d0-a0,-(sp)
										lea     (byte_FFDD00).l,a0
										moveq   #$1F,d7
										move.w  d2,d0
										move.w  d2,d1
										asr.w   #8,d0
										ext.w   d1
										move.w  d3,d2
										asr.w   #8,d2
										ext.w   d3
loc_29BC:
										cmpi.w  #$1F,d7
										bne.s   loc_29CA
										add.w   d1,(a0)
										add.w   d0,6(a0)
										bra.s   loc_29D6
loc_29CA:
										cmpi.w  #1,(a0)
										beq.s   loc_29D6
										add.w   d3,(a0)
										add.w   d2,6(a0)
loc_29D6:
										addq.l  #8,a0
										dbf     d7,loc_29BC
										movem.l (sp)+,d0-a0
										rts

	; End of function sub_29A2


; =============== S U B R O U T I N E =======================================

; In: D1 = map index

LoadMapTilesets:
										
										movem.l d0-d1/a0-a1/a5,-(sp)
										ext.w   d1
										blt.w   loc_2A86
										movea.l (p_pt_MapData).l,a5
										lsl.w   #2,d1
										movea.l (a5,d1.w),a5
										move.b  (a5)+,d0
										movea.l (p_pt_MapTiles).l,a0
										clr.w   d0
										move.b  (a5)+,d0
										blt.s   loc_2A16
										lsl.w   #2,d0
										movea.l (a0,d0.w),a0
										lea     (byte_FF3000).l,a1
										bsr.w   LoadTileData    
loc_2A16:
										movea.l (p_pt_MapTiles).l,a0
										clr.w   d0
										move.b  (a5)+,d0
										blt.s   loc_2A32
										lsl.w   #2,d0
										movea.l (a0,d0.w),a0
										lea     (FF6802_LOADING_SPACE).l,a1
										bsr.w   LoadTileData    
loc_2A32:
										movea.l (p_pt_MapTiles).l,a0
										clr.w   d0
										move.b  (a5)+,d0
										blt.s   loc_2A4E
										lsl.w   #2,d0
										movea.l (a0,d0.w),a0
										lea     (RAM_START).l,a1
										bsr.w   LoadTileData    
loc_2A4E:
										movea.l (p_pt_MapTiles).l,a0
										clr.w   d0
										move.b  (a5)+,d0
										blt.s   loc_2A6A
										lsl.w   #2,d0
										movea.l (a0,d0.w),a0
										lea     (byte_FF1000).l,a1
										bsr.w   LoadTileData    
loc_2A6A:
										movea.l (p_pt_MapTiles).l,a0
										clr.w   d0
										move.b  (a5)+,d0
										blt.s   loc_2A86
										lsl.w   #2,d0
										movea.l (a0,d0.w),a0
										lea     (FF2000_LOADING_SPACE).l,a1
										bsr.w   LoadTileData    
loc_2A86:
										movem.l (sp)+,d0-d1/a0-a1/a5
										rts

	; End of function LoadMapTilesets


; =============== S U B R O U T I N E =======================================

; loads all map properties (map coords, entities, etc.)

LoadMap:
										move.l  ((word_FFA818-$1000000)).w,((word_FFA810-$1000000)).w
										move.l  ((word_FFA81C-$1000000)).w,((word_FFA814-$1000000)).w
										clr.l   ((word_FFA820-$1000000)).w
										clr.l   ((word_FFA824-$1000000)).w
										clr.b   ((CAMERA_SCROLLING_MASK-$1000000)).w
										move.w  d0,-(sp)
										move.w  d1,-(sp)
										bsr.w   InitDisplay     
										move.w  (sp)+,d1
										ext.w   d1
										bpl.s   loc_2ACC
										clr.w   d1
										move.b  ((CURRENT_MAP-$1000000)).w,d1
										movea.l (p_pt_MapData).l,a5
										lsl.w   #2,d1
										movea.l (a5,d1.w),a5
										lea     $E(a5),a5       ; get address 02 - map properties
										bra.w   loc_2B80        
loc_2ACC:
										clr.w   ((word_FFAF42-$1000000)).w
										move.b  d1,((CURRENT_MAP-$1000000)).w
loc_2AD4:
										movea.l (p_pt_MapData).l,a5
										lsl.w   #2,d1
										movea.l (a5,d1.w),a5
										movea.l (p_pt_MapPalettes).l,a0
										clr.w   d0
										move.b  (a5)+,d0
										lsl.w   #2,d0
										movea.l (a0,d0.w),a0
										lea     (PALETTE_1_BIS).l,a1
										move.w  #$20,d7 
										bsr.w   CopyBytes       
										clr.w   (PALETTE_1_BIS).l
										tst.b   (a5)+
										blt.s   loc_2B1C
loc_2B08:
										lea     (byte_FF3000).l,a0
										lea     ($2000).w,a1
loc_2B12:
										move.w  #$800,d0
										moveq   #2,d1
										bsr.w   sub_10DC        
loc_2B1C:
										tst.b   (a5)+
										blt.s   loc_2B34
loc_2B20:
										lea     (FF6802_LOADING_SPACE).l,a0
										lea     ($3000).w,a1
										move.w  #$800,d0
										moveq   #2,d1
										bsr.w   sub_10DC        
loc_2B34:
										tst.b   (a5)+
										blt.s   loc_2B4C
										lea     (RAM_START).l,a0; something to do with tile pixel data
										lea     ($4000).w,a1
										move.w  #$800,d0
										moveq   #2,d1
loc_2B48:
										bsr.w   sub_10DC        
loc_2B4C:
										tst.b   (a5)+
										blt.s   loc_2B64
										lea     (byte_FF1000).l,a0
loc_2B56:
										lea     ($5000).w,a1
										move.w  #$800,d0
										moveq   #2,d1
loc_2B60:
										bsr.w   sub_10DC        
loc_2B64:
										tst.b   (a5)+
										blt.s   loc_2B7C
loc_2B68:
										lea     (FF2000_LOADING_SPACE).l,a0
										lea     ($6000).w,a1
										move.w  #$800,d0
										moveq   #2,d1
										bsr.w   sub_10DC        
loc_2B7C:
										bsr.w   sub_2D58
loc_2B80:
										movea.l (a5)+,a4        ; move map properties address to A4
loc_2B82:
										move.w  (a4)+,d0
										bpl.s   loc_2BA6
										movea.l -4(a5),a4
										move.w  (a4)+,d0
										move.w  (a4)+,d1
										move.w  (a4)+,d2
										move.w  (a4)+,d3
loc_2B92:
										mulu.w  #$180,d0
										mulu.w  #$180,d1
										mulu.w  #$180,d2
										mulu.w  #$180,d3
										bra.w   loc_2C14
loc_2BA6:
										move.w  (a4)+,d1
										move.w  (a4)+,d2
										move.w  (a4)+,d3
										mulu.w  #$180,d0
loc_2BB0:
										mulu.w  #$180,d1
										mulu.w  #$180,d2
										mulu.w  #$180,d3
										move.w  (sp)+,d4
										move.w  d4,-(sp)
loc_2BC0:
										cmpi.w  #$FFFF,d4
										bne.s   loc_2BE6
										move.l  a0,-(sp)
										move.b  ((BATTLE_CURRENT_ENTITY-$1000000)).w,d4
										bpl.s   loc_2BD0
										clr.w   d4
loc_2BD0:
										andi.w  #$3F,d4 
										lsl.w   #5,d4
										lea     ((ENTITY_DATA_STRUCT_X_AND_START-$1000000)).w,a0
										move.w  2(a0,d4.w),d5
										move.w  (a0,d4.w),d4
										movea.l (sp)+,a0
										bra.s   loc_2BF0
loc_2BE6:
										clr.w   d5
										move.b  d4,d5
										lsr.w   #8,d4
										lsl.w   #7,d4
										lsl.w   #7,d5
loc_2BF0:
										cmp.w   d0,d4
										blt.w   loc_2C0C
										cmp.w   d1,d5
										blt.w   loc_2C0C
										cmp.w   d2,d4
										bgt.w   loc_2C0C
										cmp.w   d3,d5
										bgt.w   loc_2C0C
										bra.w   loc_2C14
loc_2C0C:
										lea     $16(a4),a4
										bra.w   loc_2B82
loc_2C14:
										bsr.w   LoadMapArea
										move.w  (sp)+,d0
loc_2C1A:
										cmpi.w  #$FFFF,d0
										bne.s   loc_2C70
										move.w  d4,d0
										move.w  d5,d1
										move.w  d0,d2
										move.w  d1,d3
										subi.w  #$780,d0
loc_2C2C:
										subi.w  #$780,d1
										addi.w  #$780,d2
										addi.w  #$600,d3
										cmp.w   ((MAP_AREA_LAYER1_STARTX-$1000000)).w,d0
										bge.s   loc_2C42
										move.w  ((MAP_AREA_LAYER1_STARTX-$1000000)).w,d0
loc_2C42:
										cmp.w   ((MAP_AREA_LAYER1_ENDX-$1000000)).w,d2
										ble.s   loc_2C50
loc_2C48:
										move.w  ((MAP_AREA_LAYER1_ENDX-$1000000)).w,d0
										subi.w  #$F00,d0
loc_2C50:
										cmp.w   ((MAP_AREA_LAYER1_STARTY-$1000000)).w,d1
										bge.s   loc_2C5A
										move.w  ((MAP_AREA_LAYER1_STARTY-$1000000)).w,d1
loc_2C5A:
										cmp.w   ((MAP_AREA_LAYER1_ENDY-$1000000)).w,d3
										ble.s   loc_2C68
										move.w  ((MAP_AREA_LAYER1_ENDY-$1000000)).w,d1
loc_2C64:
										subi.w  #$D80,d1
loc_2C68:
										lsr.w   #7,d0
										lsr.w   #7,d1
										lsl.w   #8,d0
										or.w    d1,d0
loc_2C70:
										clr.w   d1
										move.b  d0,d1
										lsr.w   #8,d0
										move.w  d0,d2
										move.w  d1,d3
										move.w  ((MAP_AREA_LAYER2_STARTX-$1000000)).w,d4
										move.w  ((MAP_AREA_LAYER2_STARTY-$1000000)).w,d5
										move.w  ((MAP_AREA_BACKGROUND_STARTX-$1000000)).w,d6
										move.w  ((MAP_AREA_BACKGROUND_STARTY-$1000000)).w,d7
										lsl.w   #7,d0
										lsl.w   #7,d1
										lsl.w   #7,d2
										lsl.w   #7,d3
										lsl.w   #7,d4
										lsl.w   #7,d5
										lsl.w   #7,d6
										lsl.w   #7,d7
loc_2C9A:
										mulu.w  ((MAP_AREA_LAYER1_PARALLAX_X-$1000000)).w,d0
										lsr.l   #8,d0
										mulu.w  ((MAP_AREA_LAYER1_PARALLAX_Y-$1000000)).w,d1
										lsr.l   #8,d1
										mulu.w  ((MAP_AREA_LAYER2_PARALLAX_X-$1000000)).w,d2
										lsr.l   #8,d2
										mulu.w  ((MAP_AREA_LAYER2_PARALLAX_Y-$1000000)).w,d3
										lsr.l   #8,d3
										add.w   d4,d0
										move.w  d0,((word_FFA810-$1000000)).w
										add.w   d5,d1
										move.w  d1,((word_FFA812-$1000000)).w
										add.w   d6,d2
										move.w  d2,((word_FFA814-$1000000)).w
										add.w   d7,d3
										move.w  d3,((word_FFA816-$1000000)).w
										bsr.w   sub_38C0
										tst.b   ((MAP_AREA_LAYER1_AUTOSCROLL_X-$1000000)).w
										beq.s   loc_2CD8
										move.w  d0,((word_FFA810-$1000000)).w
loc_2CD8:
										tst.b   ((MAP_AREA_LAYER1_AUTOSCROLL_Y-$1000000)).w
										beq.s   loc_2CE2
										move.w  d1,((word_FFA812-$1000000)).w
loc_2CE2:
										tst.b   ((MAP_AREA_LAYER2_AUTOSCROLL_X-$1000000)).w
										beq.s   loc_2CEC
										move.w  d0,((word_FFA814-$1000000)).w
loc_2CEC:
										tst.b   ((MAP_AREA_LAYER2_AUTOSCROLL_Y-$1000000)).w
										beq.s   loc_2CF6
										move.w  d1,((word_FFA816-$1000000)).w
loc_2CF6:
										move.w  ((word_FFA810-$1000000)).w,d0
										lsr.w   #4,d0
										neg.w   d0
										andi.w  #$FF,d0
										move.w  d0,((word_FFA804-$1000000)).w
										move.w  ((word_FFA812-$1000000)).w,d1
										lsr.w   #4,d1
										addq.w  #8,d1
										andi.w  #$FF,d1
										move.w  d1,((word_FFA808-$1000000)).w
										move.w  ((word_FFA814-$1000000)).w,d2
										lsr.w   #4,d2
										neg.w   d2
										andi.w  #$FF,d2
										move.w  d2,((word_FFA806-$1000000)).w
										move.w  ((word_FFA816-$1000000)).w,d3
										lsr.w   #4,d3
										addq.w  #8,d3
										andi.w  #$FF,d3
										move.w  d3,((word_FFA80A-$1000000)).w
										bsr.w   EnableDisplayAndInterrupts
										bsr.w   StoreVdpCommands
										bsr.w   StoreVdpCommandsbis
										bsr.w   InitWindowProperties
										bsr.w   ToggleRoofOnMapLoad
										bsr.w   WaitForVInt     
										bsr.w   sub_4344
										bsr.w   sub_43A4
										rts

	; End of function LoadMap


; =============== S U B R O U T I N E =======================================

sub_2D58:
										movea.l (a5)+,a0
										lea     (FF2000_LOADING_SPACE).l,a1
										bsr.w   sub_2372
										movea.l (a5)+,a0
										lea     (RAM_START).l,a1
										bsr.w   LoadMapLayoutData
										movea.l 4(a5),a0
loc_2D74:
										move.w  (a0),d1
										cmpi.w  #$FFFF,d1
										beq.w   loc_2D9C
										jsr     j_CheckFlag
										beq.w   loc_2D98
										move.w  2(a0),d0
										move.w  4(a0),d1
										move.w  6(a0),d2
										bsr.w   sub_3DB0
loc_2D98:
										addq.l  #8,a0
										bra.s   loc_2D74
loc_2D9C:
										lea     (RAM_START).l,a1
										movea.l $14(a5),a0
loc_2DA6:
										cmpi.w  #$FFFF,(a0)
										beq.w   loc_2DD4
										clr.w   d1
										move.b  2(a0),d1
										jsr     j_CheckFlag
										beq.w   loc_2DD0
										clr.w   d0
										move.b  1(a0),d0
										lsl.w   #6,d0
										add.b   (a0),d0
										add.w   d0,d0
										move.w  #$D802,(a1,d0.w)
loc_2DD0:
										addq.l  #4,a0
										bra.s   loc_2DA6
loc_2DD4:
										cmpi.b  #$FF,((CURRENT_BATTLE-$1000000)).w
										beq.s   return_2DEA
loc_2DDC:
										move.w  ((byte_FFF706-$1000000)).w,d0
										move.w  ((byte_FFF708-$1000000)).w,d1
										clr.w   d2
										bsr.w   sub_3DB0
return_2DEA:
										
										rts

	; End of function sub_2D58


; =============== S U B R O U T I N E =======================================

LoadMapArea:
										
										cmpi.b  #$FF,((CURRENT_BATTLE-$1000000)).w
										bne.s   loc_2E06
										move.w  d0,((MAP_AREA_LAYER1_STARTX-$1000000)).w
										move.w  d1,((MAP_AREA_LAYER1_STARTY-$1000000)).w
										move.w  d2,((MAP_AREA_LAYER1_ENDX-$1000000)).w
										move.w  d3,((MAP_AREA_LAYER1_ENDY-$1000000)).w
										bra.s   loc_2E2C
loc_2E06:
										move.w  ((byte_FFF708-$1000000)).w,d0
										clr.w   d1
										move.b  d0,d1
										subq.w  #1,d1
										mulu.w  #$180,d1
										lsr.w   #8,d0
										subq.w  #1,d0
										mulu.w  #$180,d0
										clr.w   ((MAP_AREA_LAYER1_STARTX-$1000000)).w
										clr.w   ((MAP_AREA_LAYER1_STARTY-$1000000)).w
										move.w  d0,((MAP_AREA_LAYER1_ENDX-$1000000)).w
										move.w  d1,((MAP_AREA_LAYER1_ENDY-$1000000)).w
loc_2E2C:
										move.w  (a4)+,d0
										mulu.w  #3,d0
										move.w  d0,((MAP_AREA_LAYER2_STARTX-$1000000)).w
										move.w  (a4)+,d0
loc_2E38:
										mulu.w  #3,d0
										move.w  d0,((MAP_AREA_LAYER2_STARTY-$1000000)).w
										move.w  (a4)+,d0
										mulu.w  #3,d0
										move.w  d0,((MAP_AREA_BACKGROUND_STARTX-$1000000)).w
										move.w  (a4)+,d0
loc_2E4C:
										mulu.w  #3,d0
										move.w  d0,((MAP_AREA_BACKGROUND_STARTY-$1000000)).w
										move.w  (a4)+,((MAP_AREA_LAYER1_PARALLAX_X-$1000000)).w
										move.w  (a4)+,((MAP_AREA_LAYER1_PARALLAX_Y-$1000000)).w
										move.w  (a4)+,((MAP_AREA_LAYER2_PARALLAX_X-$1000000)).w
loc_2E60:
										move.w  (a4)+,((MAP_AREA_LAYER2_PARALLAX_Y-$1000000)).w
										move.l  (a4)+,((MAP_AREA_LAYER1_AUTOSCROLL_X-$1000000)).w
										move.b  (a4)+,((MAP_AREA_PROP_1C-$1000000)).w
loc_2E6C:
										move.b  (a4)+,((MAP_AREA_MUSIC_INDEX-$1000000)).w
										movea.l (a5),a4
										move.w  #1,((TILE_ANIM_COUNTER-$1000000)).w
										move.l  $18(a5),((TILE_ANIM_DATA_ADDR-$1000000)).w
										blt.s   return_2EBE
loc_2E80:
										movea.l ((TILE_ANIM_DATA_ADDR-$1000000)).w,a1
										move.w  (a1)+,d0
										movea.l (p_pt_MapTiles).l,a0
										lsl.w   #2,d0
										movea.l (a0,d0.w),a0
										move.l  a1,-(sp)
loc_2E94:
										lea     (FF6802_LOADING_SPACE).l,a1
										bsr.w   LoadTileData    
										movea.l (sp)+,a1
										move.w  (a1)+,d7
										lea     (FF6802_LOADING_SPACE).l,a0
loc_2EA8:
										lea     (byte_FF9B04).l,a1
										lsl.w   #5,d7
										bsr.w   CopyBytes       
										addq.l  #4,((TILE_ANIM_DATA_ADDR-$1000000)).w
										move.b  ((CURRENT_MAP-$1000000)).w,((TILE_ANIM_MAP_INDEX-$1000000)).w
return_2EBE:
										
										rts

	; End of function LoadMapArea


; =============== S U B R O U T I N E =======================================

sub_2EC0:
										move.w  #$20,d6 
										bsr.w   UpdateRandomSeed
										move.w  d7,d0
										move.w  #4,d6
										bsr.w   UpdateRandomSeed
										move.w  d7,d1
										addi.w  #$1C,d1
										move.w  #$10,d6
										bsr.w   UpdateRandomSeed
										move.w  d7,d2
										move.w  #4,d6
										bsr.w   UpdateRandomSeed
										move.w  d7,d3
										move.w  #4,d4
loc_2EF0:
										move.w  #4,d5
										move.w  #4,d6
										move.w  #4,d7
										bsr.w   sub_36B2
										bsr.w   WaitForVInt     
loc_2F04:
										move.w  #$8721,d0
loc_2F08:
										bsr.w   SetVdpReg       
										move.w  #$8700,d0
										bsr.w   SetVdpReg       
										bsr.w   WaitForVInt     
										bsr.w   sub_2F24
										tst.b   ((CAMERA_SCROLLING_MASK-$1000000)).w
										bne.s   loc_2F04
										rts

	; End of function sub_2EC0


; =============== S U B R O U T I N E =======================================

sub_2F24:
										move.w  d0,-(sp)
										move.w  ((word_FFA820-$1000000)).w,d0
										addq.w  #1,d0
										cmpi.w  #$80,d0 
										bgt.s   loc_2F36
										move.w  d0,((word_FFA820-$1000000)).w
loc_2F36:
										move.w  ((word_FFA822-$1000000)).w,d0
										addq.w  #1,d0
										cmpi.w  #$80,d0 
										bgt.s   loc_2F46
										move.w  d0,((word_FFA822-$1000000)).w
loc_2F46:
										move.w  ((word_FFA824-$1000000)).w,d0
										addq.w  #1,d0
										cmpi.w  #$80,d0 
										bgt.s   loc_2F56
										move.w  d0,((word_FFA824-$1000000)).w
loc_2F56:
										move.w  ((word_FFA826-$1000000)).w,d0
										addq.w  #1,d0
										cmpi.w  #$80,d0 
										bgt.s   loc_2F66
										move.w  d0,((word_FFA826-$1000000)).w
loc_2F66:
										move.w  (sp)+,d0
										rts

	; End of function sub_2F24

