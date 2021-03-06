
; SCRIPT SECTION maps\entries\map10\mapsetups\s3 :
; 
ms_map10_ZoneEvents:dc.b $1D
										dc.b $FF
										dc.w sub_56F9C-ms_map10_ZoneEvents
										dc.b $21
										dc.b $FF
										dc.w sub_56FAE-ms_map10_ZoneEvents
										dc.b $1F
										dc.b $35
										dc.w sub_56FAE-ms_map10_ZoneEvents
										dc.w $FD00
										dc.w nullsub_74-ms_map10_ZoneEvents

; =============== S U B R O U T I N E =======================================

nullsub_74:
										
										rts

	; End of function nullsub_74


; =============== S U B R O U T I N E =======================================

sub_56F9C:
										
										trap    #CHECK_FLAG
										dc.w $2D0               ; set after the King of Bedoe speaks to his soldiers and they disperse
										bne.s   return_56FAC
										lea     cs_573EC(pc), a0
										trap    #6
										trap    #SET_FLAG
										dc.w $2D0               ; set after the King of Bedoe speaks to his soldiers and they disperse
return_56FAC:
										
										rts

	; End of function sub_56F9C


; =============== S U B R O U T I N E =======================================

sub_56FAE:
										
										trap    #CHECK_FLAG
										dc.w $2D1               ; set after you approach the King of Bedoe, starts with Luke speaking to Peter
										bne.s   return_56FBE
										lea     cs_574A6(pc), a0
										trap    #6
										trap    #SET_FLAG
										dc.w $2D1               ; set after you approach the King of Bedoe, starts with Luke speaking to Peter
return_56FBE:
										
										rts

	; End of function sub_56FAE

