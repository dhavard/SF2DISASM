
; SCRIPT SECTION system\specialscreens\witchend\witchendinit :
; Witch end function

; =============== S U B R O U T I N E =======================================

WitchEnd:
										moveq   #$3C,d0 
										bsr.w   Sleep           
										bsr.w   InitWitchSuspendVIntFunctions
										move.w  #$1E,((BLINK_COUNTER-$1000000)).w
										move.w  #6,((word_FFB07C-$1000000)).w
										move.b  #$FF,((byte_FFB082-$1000000)).w
										trap    #TEXTBOX
										dc.w $EE                ; "Finally, you've fulfilled my{N}wish!{N}{D2}{D2}Thanks to you, I can{N}escape from this forest!{D2}{N}Are you really that{N}surprised?{D2}{D2}{D2}"
										trap    #TEXTBOX
										dc.w $FFFF
										clr.b   ((byte_FFB082-$1000000)).w
										bsr.w   sub_7CDC
										bsr.w   FadeOutToWhite
										trap    #VINT_FUNCTIONS
										dc.w VINTS_REMOVE
										dc.l VInt_WitchBlink
										jmp     j_EndGame

	; End of function WitchEnd

