
; SCRIPT SECTION maps\entries\map04\mapsetups\s6 :
; 

; =============== S U B R O U T I N E =======================================

ms_map4_InitFunction:
										
										trap    #CHECK_FLAG
										dc.w $270               ; set after the soldiers are swallowed up by the earthquake
										bne.s   loc_5173A
										lea     cs_51750(pc), a0
										trap    #6
										trap    #SET_FLAG
										dc.w $270               ; set after the soldiers are swallowed up by the earthquake
										bra.s   return_51740
loc_5173A:
										
										lea     cs_51742(pc), a0
										trap    #6
return_51740:
										
										rts

	; End of function ms_map4_InitFunction

cs_51742:           dc.w $19                ; 0019 SET ENTITY POS AND FACING 80 0 0 0
										dc.b $80
										dc.b 0
										dc.b 0
										dc.b 0
										dc.w $19                ; 0019 SET ENTITY POS AND FACING 81 0 0 0
										dc.b $81
										dc.b 0
										dc.b 0
										dc.b 0
										dc.w $FFFF              ; END OF CUTSCENE SCRIPT
cs_51750:           dc.w 4                  ; 0004 INIT TEXT CURSOR 2CB : "Your Majesty!  Sir Astral!{N}Are you alright?{W1}"
										dc.w $2CB
										dc.w $19                ; 0019 SET ENTITY POS AND FACING 0 1D 4 3
										dc.b 0
										dc.b $1D
										dc.b 4
										dc.b 3
										dc.w $19                ; 0019 SET ENTITY POS AND FACING 1F 1C 3 3
										dc.b $1F
										dc.b $1C
										dc.b 3
										dc.b 3
										dc.w $19                ; 0019 SET ENTITY POS AND FACING 1E 1D 3 3
										dc.b $1E
										dc.b $1D
										dc.b 3
										dc.b 3
										dc.w $19                ; 0019 SET ENTITY POS AND FACING 9F 1E 3 3
										dc.b $9F
										dc.b $1E
										dc.b 3
										dc.b 3
										dc.w $33                ; 0033 SET QUAKE AMOUNT 1
										dc.w 1
										dc.w $39                ; 0039 FADE IN FROM BLACK
										dc.b $80                ; WAIT 1E
										dc.b $1E
										dc.w $33                ; 0033 SET QUAKE AMOUNT 1
										dc.w 1
										dc.w 0                  ; 0000 DISPLAY SINGLE TEXTBOX 80 : "Your Majesty!  Sir Astral!{N}Are you alright?{W1}"
										dc.w $80
										dc.w $2D                ; 002D MOVE ENTITY 1F FF 3 1
										dc.b $1F
										dc.b $FF
										dc.b 3
										dc.b 1
										dc.w $8080
										dc.w 0                  ; 0000 DISPLAY SINGLE TEXTBOX 1F : "You didn't escape?{N}Why are you here?{W1}"
										dc.w $1F
										dc.w 0                  ; 0000 DISPLAY SINGLE TEXTBOX 80 : "We've been waiting for you.{N}Chasms are appearing in the{N}ground.{W2}{N}Everybody is on the ship{N}to avoid falling into a{N}hole.{W1}"
										dc.w $80
										dc.w $23                ; 0023 SET ENTITY FACING 1F 0
										dc.b $1F
										dc.b 0
										dc.w 0                  ; 0000 DISPLAY SINGLE TEXTBOX 1F : "Thank you.  {LEADER},{N}hurry to the harbor.{W1}"
										dc.w $1F
										dc.w 0                  ; 0000 DISPLAY SINGLE TEXTBOX 80 : "Wooooo!{N}Help! Heeeeelp....{W1}"
										dc.w $80
										dc.w $23                ; 0023 SET ENTITY FACING 1F 3
										dc.b $1F
										dc.b 3
										dc.w $14                ; 0014 SET MANUAL ACTSCRIPT 80
										dc.b $80
										dc.b $FF
										dc.w $10                ;   0010 SET SPEED X=$4 Y=$4
										dc.b 4
										dc.b 4
										dc.w $34                ;   0034 JUMP TO ABSOLUTE ADDR. 0x451FC
										dc.l eas_Idle           
										dc.w $8080              ; 0014 END OF MANUAL ACTSCRIPT
										dc.w $14                ; 0014 SET MANUAL ACTSCRIPT 81
										dc.b $81
										dc.b $FF
										dc.w $10                ;   0010 SET SPEED X=$8 Y=$8
										dc.b 8
										dc.b 8
										dc.w $34                ;   0034 JUMP TO ABSOLUTE ADDR. 0x451FC
										dc.l eas_Idle           
										dc.w $8080              ; 0014 END OF MANUAL ACTSCRIPT
										dc.w $2D                ; 002D MOVE ENTITY 80 0 3 1
										dc.b $80
										dc.b 0
										dc.b 3
										dc.b 1
										dc.w $8080
										dc.w $2D                ; 002D MOVE ENTITY 81 0 0 1
										dc.b $81
										dc.b 0
										dc.b 0
										dc.b 1
										dc.w $8080
										dc.w 5                  ; 0005 PLAY SOUND SFX_BIG_DOOR_RUMBLE
										dc.w $5D
										dc.w $33                ; 0033 SET QUAKE AMOUNT 3
										dc.w 3
										dc.b $80                ; WAIT 1E
										dc.b $1E
										dc.w $34                ; 0034 SET BLOCKS 3312 B07 1803
										dc.w $3312
										dc.w $B07
										dc.w $1803
										dc.b $80                ; WAIT A
										dc.b $A
										dc.w $34                ; 0034 SET BLOCKS 3319 B07 1803
										dc.w $3319
										dc.w $B07
										dc.w $1803
										dc.b $80                ; WAIT A
										dc.b $A
										dc.w $34                ; 0034 SET BLOCKS 3320 B07 1803
										dc.w $3320
										dc.w $B07
										dc.w $1803
										dc.b $80                ; WAIT A
										dc.b $A
										dc.w $15                ; 0015 SET ACTSCRIPT 80 0 51840
										dc.b $80
										dc.b 0
										dc.l eas_51840          
										dc.b $80                ; WAIT 5
										dc.b 5
										dc.w $15                ; 0015 SET ACTSCRIPT 81 FF 51840
										dc.b $81
										dc.b $FF
										dc.l eas_51840          
										dc.w 5                  ; 0005 PLAY SOUND SFX_BIG_DOOR_RUMBLE
										dc.w $5D
										dc.w $34                ; 0034 SET BLOCKS 3300 504 1B00
										dc.w $3300
										dc.w $504
										dc.w $1B00
										dc.b $80                ; WAIT A
										dc.b $A
										dc.w $34                ; 0034 SET BLOCKS 3304 504 1B00
										dc.w $3304
										dc.w $504
										dc.w $1B00
										dc.b $80                ; WAIT A
										dc.b $A
										dc.w $34                ; 0034 SET BLOCKS 3308 504 1B00
										dc.w $3308
										dc.w $504
										dc.w $1B00
										dc.b $80                ; WAIT 1E
										dc.b $1E
										dc.w $33                ; 0033 SET QUAKE AMOUNT 1
										dc.w 1
										dc.b $80                ; WAIT 1E
										dc.b $1E
										dc.w $23                ; 0023 SET ENTITY FACING 1F 0
										dc.b $1F
										dc.b 0
										dc.w 0                  ; 0000 DISPLAY SINGLE TEXTBOX 1F : "That's too cruel....{N}{W2}{LEADER}, go to the{N}harbor from the east side.{N}It's safer.{W1}"
										dc.w $1F
										dc.w $15                ; 0015 SET ACTSCRIPT 1F 0 44F2E
										dc.b $1F
										dc.b 0
										dc.l eas_Follower1      
										dc.w $FFFF              ; END OF CUTSCENE SCRIPT
eas_51840:          dc.w $10                ; 0010 SET SPEED X=$0 Y=$0
										dc.b 0
										dc.b 0
										dc.w $11                ; 0011  $101
										dc.w $101
										dc.w $12                ; 0012  $FEFF
										dc.w $FEFF
										dc.w $13                ; 0013  $FEFF
										dc.w $FEFF
										dc.w $18                ; 0018 SET 1C BIT 7 $FFFF
										dc.w $FFFF
										dc.w $19                ; 0019 SET 1C BIT 6 $0
										dc.w 0
										dc.w $1A                ; 001A SET 1C BIT 5 $0
										dc.w 0
										dc.w $15                ; 0015 SET ABILITY TO CHANGE FACING $0
										dc.w 0
										dc.w 4                  ; 0004 MOVE TO RELATIVE DEST X=X+$0 Y=Y+$2
										dc.w 0
										dc.w 2
										dc.w $1F                ; 001F SET 1D BIT 3 $FFFF
										dc.w $FFFF
										dc.w $23                ; 0023 SEND SOUND COMMAND $SFX_FALLING
										dc.w $58
										dc.w $22                ; 0022 SET FACING $0
										dc.w 0
										dc.w $B                 ; 000B SET SPRITE SIZE $16
										dc.w $16
										dc.w $A                 ; 000A UPDATE SPRITE
										dc.w 0                  ; 0000 WAIT value $4
										dc.w 4
										dc.w $22                ; 0022 SET FACING $1
										dc.w 1
										dc.w $B                 ; 000B SET SPRITE SIZE $14
										dc.w $14
										dc.w $A                 ; 000A UPDATE SPRITE
										dc.w 0                  ; 0000 WAIT value $4
										dc.w 4
										dc.w $22                ; 0022 SET FACING $2
										dc.w 2
										dc.w $B                 ; 000B SET SPRITE SIZE $12
										dc.w $12
										dc.w $A                 ; 000A UPDATE SPRITE
										dc.w 0                  ; 0000 WAIT value $4
										dc.w 4
										dc.w $22                ; 0022 SET FACING $3
										dc.w 3
										dc.w $B                 ; 000B SET SPRITE SIZE $10
										dc.w $10
										dc.w $A                 ; 000A UPDATE SPRITE
										dc.w 0                  ; 0000 WAIT value $4
										dc.w 4
										dc.w $22                ; 0022 SET FACING $0
										dc.w 0
										dc.w $B                 ; 000B SET SPRITE SIZE $E
										dc.w $E
										dc.w $A                 ; 000A UPDATE SPRITE
										dc.w 0                  ; 0000 WAIT value $4
										dc.w 4
										dc.w $22                ; 0022 SET FACING $1
										dc.w 1
										dc.w $B                 ; 000B SET SPRITE SIZE $C
										dc.w $C
										dc.w $A                 ; 000A UPDATE SPRITE
										dc.w 0                  ; 0000 WAIT value $4
										dc.w 4
										dc.w $22                ; 0022 SET FACING $2
										dc.w 2
										dc.w $B                 ; 000B SET SPRITE SIZE $A
										dc.w $A
										dc.w $A                 ; 000A UPDATE SPRITE
										dc.w 0                  ; 0000 WAIT value $4
										dc.w 4
										dc.w $22                ; 0022 SET FACING $3
										dc.w 3
										dc.w $B                 ; 000B SET SPRITE SIZE $8
										dc.w 8
										dc.w $A                 ; 000A UPDATE SPRITE
										dc.w 0                  ; 0000 WAIT value $4
										dc.w 4
										dc.w $22                ; 0022 SET FACING $0
										dc.w 0
										dc.w $B                 ; 000B SET SPRITE SIZE $6
										dc.w 6
										dc.w $A                 ; 000A UPDATE SPRITE
										dc.w 0                  ; 0000 WAIT value $4
										dc.w 4
										dc.w $22                ; 0022 SET FACING $1
										dc.w 1
										dc.w $B                 ; 000B SET SPRITE SIZE $4
										dc.w 4
										dc.w $A                 ; 000A UPDATE SPRITE
										dc.w 0                  ; 0000 WAIT value $4
										dc.w 4
										dc.w $22                ; 0022 SET FACING $2
										dc.w 2
										dc.w $B                 ; 000B SET SPRITE SIZE $2
										dc.w 2
										dc.w $A                 ; 000A UPDATE SPRITE
										dc.w 1                  ; 0001 WAIT UNTIL DESTINATION
										dc.w $C                 ; 000C SET POSITION X=$0 Y=$0
										dc.w 0
										dc.w 0
										dc.w $34                ; 0034 JUMP TO ABSOLUTE ADDR. 0x451FC
										dc.l eas_Idle           
