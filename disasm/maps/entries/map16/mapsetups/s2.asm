
; SCRIPT SECTION maps\entries\map16\mapsetups\s2 :
; 
ms_map16_EntityEvents:
										dc.b $94
										dc.b 3
										dc.w sub_51E50-ms_map16_EntityEvents
										dc.w $FD00
										dc.w nullsub_119-ms_map16_EntityEvents

; =============== S U B R O U T I N E =======================================

sub_51E3A:
										
										trap    #TEXTBOX
										dc.w $360               ; "King Galam changed when the{N}messenger was found dead.{W2}"
										trap    #TEXTBOX
										dc.w $361               ; "He groaned and suddenly{N}opened his eyes!{W2}"
										trap    #TEXTBOX
										dc.w $362               ; "Terrible...so terrible!{N}His face was not human!{W2}"
										trap    #TEXTBOX
										dc.w $363               ; "I'm sorry!{N}Please forget about it!{W2}"
										trap    #TEXTBOX
										dc.w $364               ; "I don't want him to kill me!{W1}"
										rts

	; End of function sub_51E3A


; =============== S U B R O U T I N E =======================================

sub_51E50:
										
										jsr     j_ChurchActions
										rts

	; End of function sub_51E50


; =============== S U B R O U T I N E =======================================

sub_51E58:
										
										trap    #TEXTBOX
										dc.w $365               ; "We have many people to{N}send to the jail today.{N}Why?"
										rts

	; End of function sub_51E58


; =============== S U B R O U T I N E =======================================

nullsub_118:
										
										rts

	; End of function nullsub_118


; =============== S U B R O U T I N E =======================================

sub_51E60:
										
										trap    #TEXTBOX
										dc.w $34C               ; "I saw them!  I saw them!{N}Many soldiers went through{N}the gate.{W2}"
										trap    #TEXTBOX
										dc.w $34D               ; "Where were they going?{N}To Granseal?{W2}"
										trap    #TEXTBOX
										dc.w $34E               ; "No way!  We are allies!{W1}"
										rts

	; End of function sub_51E60


; =============== S U B R O U T I N E =======================================

sub_51E6E:
										
										trap    #TEXTBOX
										dc.w $34F               ; "Are you tourists?{N}From Granseal!  They say{N}it's a nice place.{W1}"
										rts

	; End of function sub_51E6E


; =============== S U B R O U T I N E =======================================

sub_51E74:
										
										trap    #TEXTBOX
										dc.w $350               ; "The area north of Galam is{N}a wasteland.{W2}"
										trap    #TEXTBOX
										dc.w $351               ; "I heard that many monsters{N}are wandering around there.{W1}"
										rts

	; End of function sub_51E74


; =============== S U B R O U T I N E =======================================

sub_51E7E:
										
										move.b  #1,((CURRENT_SHOP_INDEX-$1000000)).w
										jsr     j_ShopActions
										rts

	; End of function sub_51E7E


; =============== S U B R O U T I N E =======================================

sub_51E8C:
										
										trap    #TEXTBOX
										dc.w $352               ; "The priest is out now.{N}Since he decided to marry{N}{NAME;25}, he has been{W2}{N}neglectful of his duties.{W1}"
										rts

	; End of function sub_51E8C


; =============== S U B R O U T I N E =======================================

sub_51E92:
										
										trap    #TEXTBOX
										dc.w $353               ; "I like trees!!{W1}"
										rts

	; End of function sub_51E92


; =============== S U B R O U T I N E =======================================

sub_51E98:
										
										trap    #TEXTBOX
										dc.w $354               ; "Young men like you are{N}not my guests.{N}Go away!{W1}"
										rts

	; End of function sub_51E98


; =============== S U B R O U T I N E =======================================

sub_51E9E:
										
										trap    #TEXTBOX
										dc.w $355               ; "(Hiccup)...I...I want to go{N}on a trip around the world.{W2}"
										trap    #TEXTBOX
										dc.w $356               ; "But...(hiccup), the north{N}gate of Galam won't open.{W2}"
										trap    #TEXTBOX
										dc.w $357               ; "I don't want to live my{N}entire life on such a small{N}island.{W1}"
										rts

	; End of function sub_51E9E


; =============== S U B R O U T I N E =======================================

sub_51EAC:
										
										trap    #TEXTBOX
										dc.w $358               ; "Sorry, we never open this{N}gate.{W1}"
										rts

	; End of function sub_51EAC


; =============== S U B R O U T I N E =======================================

sub_51EB2:
										
										trap    #TEXTBOX
										dc.w $359               ; "I heard the Princess of{N}Granseal is very beautiful.{W2}"
										trap    #TEXTBOX
										dc.w $35A               ; "I hope to see her someday.{W1}"
										rts

	; End of function sub_51EB2


; =============== S U B R O U T I N E =======================================

sub_51EBC:
										
										trap    #TEXTBOX
										dc.w $35B               ; "I'm writing in my diary.{W2}"
										trap    #TEXTBOX
										dc.w $35C               ; "I'm writing about the day{N}"
										trap    #TEXTBOX
										dc.w $35D               ; "when the war between Galam{N}and Granseal took place.{W1}"
										trap    #TEXTBOX
										dc.w $35E               ; "A record must be kept.{W1}"
										rts

	; End of function sub_51EBC


; =============== S U B R O U T I N E =======================================

sub_51ECE:
										
										trap    #TEXTBOX
										dc.w $35F               ; "I want to be a fine{N}soldier like {NAME;28}{N}when I grow up.{W1}"
										rts

	; End of function sub_51ECE


; =============== S U B R O U T I N E =======================================

sub_51ED4:
										
										move.b  #$10,((CURRENT_SHOP_INDEX-$1000000)).w
										jsr     j_ShopActions
										rts

	; End of function sub_51ED4


; =============== S U B R O U T I N E =======================================

nullsub_119:
										
										rts

	; End of function nullsub_119

