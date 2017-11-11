; #########################################################################
;
;   metroid.asm - Assembly file for EECS205 Assignment 4/5
;
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

include stars.inc
include lines.inc
include trig.inc
include blit.inc
include game.inc

; for music
include \masm32\include\windows.inc
include \masm32\include\winmm.inc
includelib \masm32\lib\winmm.lib

;; Has keycodes
include keys.inc

	
.DATA

;; If you need to, you can place global variables here

;; sounds
music BYTE "Brinstar.wav",0


metroid EECS205BITMAP <44, 48, 255,, offset metroid + sizeof metroid>
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0dfh
	BYTE 0bah,0bah,075h,04ch,04ch,04ch,04ch,04ch,050h,0bah,0bah,0bah,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0dfh,096h,071h,071h,050h,095h,095h,075h
	BYTE 075h,075h,075h,075h,095h,095h,071h,050h,075h,071h,0dah,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0dfh,095h,071h,075h,099h,099h,099h,099h,095h,070h,051h,051h,051h,051h
	BYTE 075h,099h,099h,0b9h,099h,095h,050h,075h,0dah,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,095h,071h,099h
	BYTE 099h,099h,075h,050h,04ch,02ch,02ch,02ch,02ch,02ch,02ch,02ch,02ch,02ch,02ch,050h
	BYTE 050h,095h,099h,099h,071h,071h,0dah,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0bah,071h,075h,0b9h,099h,050h,02ch,008h,008h
	BYTE 02ch,070h,099h,099h,0beh,0beh,0beh,0b9h,099h,075h,050h,008h,008h,02ch,050h,075h
	BYTE 0b9h,099h,050h,095h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0bah,050h,099h,099h,099h,050h,02ch,008h,028h,04ch,071h,095h,071h,050h
	BYTE 050h,050h,070h,050h,050h,095h,075h,050h,028h,008h,008h,02ch,075h,099h,099h,075h
	BYTE 071h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0bah,070h,0b9h
	BYTE 099h,074h,050h,051h,028h,028h,008h,008h,028h,071h,071h,06dh,06dh,06dh,06dh,06dh
	BYTE 071h,071h,04ch,028h,028h,008h,02ch,02ch,075h,074h,099h,0b9h,075h,071h,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0dah,071h,0b9h,099h,074h,050h,02ch,075h
	BYTE 095h,071h,095h,024h,091h,0dfh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0dah,028h
	BYTE 04dh,091h,071h,099h,02ch,04ch,074h,099h,0b9h,075h,091h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,071h,099h,099h,074h,04ch,02ch,028h,095h,0ffh,0ffh,0ffh,071h
	BYTE 071h,0b6h,0b6h,0d6h,0d6h,0fbh,0d2h,0d6h,0fbh,096h,091h,091h,0b6h,0ffh,0ffh,0deh
	BYTE 04ch,008h,02ch,050h,095h,0beh,071h,0bah,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,071h
	BYTE 075h,0beh,099h,050h,02ch,028h,06ch,0bah,0dah,0ffh,0ffh,0b2h,0ffh,0ffh,0b6h,0fbh
	BYTE 0adh,0ceh,0ceh,0d2h,0d6h,0dbh,0ffh,0dbh,0d6h,0ffh,0dah,0dah,095h,028h,028h,04ch
	BYTE 075h,0beh,099h,051h,0dah,0ffh,0ffh,0ffh,0ffh,0ffh,0bah,071h,0bah,099h,075h,071h
	BYTE 050h,071h,068h,069h,0adh,0adh,08dh,0adh,0ffh,0dbh,0ffh,0fbh,0a9h,0eeh,0c9h,0f2h
	BYTE 0ffh,0dbh,0ffh,0fbh,089h,0adh,0b1h,08dh,048h,06dh,04ch,071h,075h,099h,0beh,095h
	BYTE 071h,0ffh,0ffh,0ffh,0ffh,0ffh,071h,075h,0bdh,050h,050h,028h,028h,06dh,0d6h,065h
	BYTE 089h,089h,089h,0adh,0ffh,0fbh,0b2h,0d2h,0a5h,0eeh,0c9h,0a9h,0f6h,0b2h,0ffh,0fbh
	BYTE 085h,0a9h,084h,089h,08dh,0dah,028h,028h,02ch,050h,099h,0b9h,04ch,0bah,0ffh,0ffh
	BYTE 0ffh,0bah,04ch,099h,075h,050h,02ch,028h,071h,0dah,0d6h,089h,0a9h,0eeh,0a9h,0a9h
	BYTE 0fbh,0d6h,0d2h,0a9h,084h,0a5h,0a5h,085h,0d2h,0f6h,0f7h,0d2h,085h,0cdh,0c9h,085h
	BYTE 0d2h,0d6h,0dah,028h,028h,02ch,050h,0b9h,075h,071h,0ffh,0ffh,0ffh,071h,071h,099h
	BYTE 074h,030h,028h,028h,092h,08dh,069h,064h,085h,0a5h,0a5h,085h,089h,065h,089h,0a9h
	BYTE 0c9h,0a5h,0c9h,0a9h,089h,089h,065h,085h,085h,0a5h,0a5h,085h,069h,069h,092h,071h
	BYTE 028h,02ch,050h,099h,099h,04ch,0dah,0ffh,0deh,04ch,099h,099h,050h,02ch,028h,095h
	BYTE 0dbh,0b6h,0dah,0d2h,085h,085h,085h,084h,085h,084h,085h,0c9h,0c9h,0c9h,0c9h,0eeh
	BYTE 0a5h,084h,084h,085h,084h,085h,085h,0a9h,0d6h,0b6h,0dbh,0dbh,028h,02ch,030h,074h
	BYTE 099h,071h,071h,0ffh,0deh,071h,0bdh,099h,050h,02ch,008h,091h,0b6h,0dbh,0dbh,06dh
	BYTE 064h,0adh,085h,064h,064h,084h,0a5h,0a5h,0c9h,0f2h,0eeh,0a5h,0a5h,085h,084h,064h
	BYTE 064h,0adh,089h,069h,092h,0ffh,0b6h,0bah,028h,028h,030h,074h,0bdh,099h,095h,0ffh
	BYTE 071h,075h,0b9h,0b9h,075h,075h,02ch,04ch,0bah,0dfh,0b6h,069h,0b6h,0fbh,08dh,089h
	BYTE 084h,084h,084h,084h,0a5h,0c9h,0c9h,0a5h,084h,085h,084h,065h,0aeh,0b2h,0fbh,091h
	BYTE 06dh,0dah,0ffh,071h,028h,071h,070h,099h,099h,099h,04ch,0dfh,070h,075h,099h,075h
	BYTE 0bah,050h,04ch,04ch,071h,091h,0d6h,0ffh,0ffh,0d6h,0d6h,069h,084h,085h,0a5h,0a9h
	BYTE 080h,0a5h,0a5h,085h,0c9h,084h,085h,064h,0d2h,08dh,0ffh,0ffh,0dbh,0b6h,071h,071h
	BYTE 04ch,02ch,099h,099h,095h,099h,04ch,0deh,095h,099h,099h,050h,050h,075h,04ch,091h
	BYTE 071h,0dfh,0ffh,0d6h,0d6h,0d2h,0d2h,065h,064h,085h,0a5h,0a5h,0a4h,0c9h,0a5h,0a5h
	BYTE 0a5h,0a5h,085h,060h,0aeh,0d2h,0d2h,0d6h,0dah,0ffh,096h,091h,071h,050h,075h,050h
	BYTE 074h,099h,071h,0deh,095h,099h,099h,050h,02ch,075h,04dh,0deh,0ffh,091h,0d6h,064h
	BYTE 0a5h,0a5h,085h,064h,080h,084h,085h,084h,0a5h,0c9h,0a9h,0a5h,080h,085h,084h,064h
	BYTE 084h,085h,0a5h,085h,08dh,0b2h,0dah,0ffh,071h,075h,050h,030h,074h,0b9h,075h,0deh
	BYTE 095h,099h,099h,050h,028h,04ch,071h,070h,06dh,08dh,089h,0c9h,0f2h,0c9h,0a5h,0a5h
	BYTE 0a5h,084h,084h,084h,085h,085h,085h,084h,084h,084h,0a5h,084h,0a5h,0c5h,0eeh,0eeh
	BYTE 0a9h,089h,06dh,091h,04ch,075h,008h,02ch,074h,0bdh,075h,0deh,095h,099h,099h,050h
	BYTE 028h,028h,0b9h,071h,044h,064h,0a5h,0c5h,0e9h,0c5h,0a5h,0a4h,0c9h,0c9h,084h,060h
	BYTE 064h,064h,064h,060h,060h,0a5h,0c9h,0a5h,0a5h,0c5h,0c9h,0c9h,0a5h,084h,044h,068h
	BYTE 0b5h,04ch,008h,02ch,074h,0b9h,075h,0deh,075h,099h,099h,050h,028h,028h,0bah,091h
	BYTE 088h,0a9h,080h,0a5h,0a5h,0a5h,0a4h,0c9h,0c5h,0a5h,064h,040h,040h,044h,044h,040h
	BYTE 060h,085h,0a5h,0c9h,0a5h,0a5h,0a5h,0a5h,0a5h,0a5h,0a9h,08dh,0dah,071h,008h,02ch
	BYTE 074h,0b9h,071h,0deh,071h,095h,099h,050h,02ch,028h,0bah,0b1h,089h,085h,0a5h,0a9h
	BYTE 084h,084h,084h,0cdh,0a5h,084h,064h,044h,064h,064h,064h,044h,064h,085h,084h,0c9h
	BYTE 0a9h,084h,084h,0a9h,0a9h,084h,089h,08dh,0dah,051h,028h,02ch,074h,0b9h,04ch,0deh
	BYTE 095h,095h,099h,074h,028h,008h,028h,071h,068h,064h,064h,068h,048h,048h,068h,068h
	BYTE 064h,064h,064h,064h,085h,0cdh,0a9h,064h,064h,064h,064h,068h,068h,048h,048h,068h
	BYTE 064h,064h,068h,08dh,048h,004h,008h,050h,095h,099h,071h,0dfh,0deh,071h,0bdh,074h
	BYTE 02ch,008h,008h,028h,044h,048h,048h,048h,048h,048h,048h,048h,024h,044h,044h,064h
	BYTE 084h,0a9h,0a5h,064h,044h,044h,044h,044h,048h,048h,048h,048h,048h,048h,048h,028h
	BYTE 028h,008h,02ch,050h,0b9h,099h,091h,0ffh,0dfh,071h,0b9h,099h,050h,02ch,02ch,02ch
	BYTE 04ch,04ch,095h,095h,099h,095h,095h,070h,02ch,048h,044h,064h,0a9h,064h,085h,089h
	BYTE 044h,048h,028h,04ch,075h,095h,099h,099h,095h,070h,04ch,02ch,02ch,02ch,02ch,074h
	BYTE 0b9h,095h,096h,0ffh,0ffh,095h,099h,0b9h,074h,030h,050h,074h,099h,0b9h,0b9h,0b9h
	BYTE 099h,0b9h,0bdh,099h,074h,02ch,028h,048h,068h,044h,044h,068h,028h,028h,050h,099h
	BYTE 0b9h,0b9h,099h,0b9h,0bdh,0b9h,0b9h,075h,050h,030h,050h,099h,0bdh,071h,0ffh,0ffh
	BYTE 0ffh,0dah,075h,0bdh,099h,050h,075h,0bdh,099h,099h,070h,070h,070h,070h,070h,095h
	BYTE 099h,074h,050h,04ch,028h,048h,048h,028h,050h,050h,099h,099h,070h,070h,070h,070h
	BYTE 070h,075h,099h,0b9h,099h,074h,074h,0bdh,099h,095h,0ffh,0ffh,0ffh,0ffh,04ch,0b9h
	BYTE 0bdh,099h,0b9h,099h,070h,04ch,028h,048h,048h,048h,028h,04ch,094h,098h,094h,070h
	BYTE 04ch,04ch,04ch,050h,074h,094h,099h,070h,028h,048h,048h,048h,028h,048h,04ch,074h
	BYTE 0b9h,099h,099h,0beh,071h,095h,0ffh,0ffh,0ffh,0ffh,095h,075h,0b9h,0bdh,075h,04ch
	BYTE 028h,06dh,0b5h,0b5h,08ch,0b1h,08dh,048h,04ch,074h,099h,074h,050h,02ch,050h,074h
	BYTE 098h,099h,070h,048h,06ch,091h,08ch,0b1h,0b1h,0b1h,048h,028h,070h,099h,0bdh,099h
	BYTE 04dh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,04ch,071h,071h,028h,048h,06ch,068h,06ch,08dh
	BYTE 0b1h,0d5h,08dh,048h,028h,04ch,095h,099h,075h,054h,074h,099h,099h,070h,048h,024h
	BYTE 06ch,0b1h,0d6h,08dh,08dh,068h,048h,06ch,028h,04ch,095h,04ch,096h,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0b6h,048h,028h,024h,048h,068h,068h,044h,044h,069h,0b1h,069h,044h
	BYTE 048h,048h,048h,070h,095h,0bdh,099h,075h,04ch,028h,048h,048h,044h,0b1h,08dh,068h
	BYTE 044h,044h,068h,048h,024h,024h,048h,06dh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 06dh,024h,048h,08dh,0b6h,0b1h,068h,044h,044h,044h,068h,08dh,0b1h,08dh,024h,028h
	BYTE 06ch,0b9h,095h,028h,024h,068h,0b1h,0b1h,068h,068h,044h,044h,044h,08dh,0d6h,0b1h
	BYTE 06dh,024h,048h,0dbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,048h,08dh,0dah
	BYTE 0feh,0b1h,068h,044h,044h,044h,068h,0b5h,0fah,0b6h,044h,048h,0dah,0ffh,0ffh,06dh
	BYTE 024h,06dh,0fah,0dah,08dh,044h,044h,044h,068h,08dh,0fah,0fah,0b5h,068h,069h,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,069h,06dh,0d6h,0ffh,0feh,0b1h,068h,068h
	BYTE 0b2h,08dh,08dh,0d6h,0dah,08dh,08dh,0dbh,0ffh,0ffh,0ffh,0ffh,0b6h,069h,0b1h,0fah
	BYTE 0b1h,068h,0b2h,08dh,068h,08dh,0fah,0ffh,0fah,091h,048h,0dbh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,06dh,091h,0fah,0feh,0dah,06ch,069h,0fbh,0ffh,0b2h,091h,0fah
	BYTE 0b1h,068h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,068h,0d6h,0d6h,08dh,0ffh,0ffh
	BYTE 0b1h,048h,0b1h,0fah,0feh,0b5h,06dh,0dah,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 06dh,0b5h,0fah,0feh,0b1h,048h,0dah,0ffh,0ffh,0dah,091h,0d6h,08dh,091h,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0dbh,068h,0b1h,0d6h,091h,0ffh,0ffh,0ffh,06dh,08dh,0fah
	BYTE 0feh,0d6h,08dh,0dah,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06dh,0b6h,0fah,0feh
	BYTE 08dh,06dh,0ffh,0ffh,0ffh,0ffh,08dh,0b1h,068h,0b6h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,068h,08dh,091h,0b6h,0ffh,0ffh,0ffh,0d6h,068h,0dah,0feh,0dah,08dh,0dah
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06dh,0b5h,0fah,0fah,069h,0b2h,0ffh,0ffh
	BYTE 0ffh,0ffh,0b2h,06dh,048h,0dbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,08dh,068h
	BYTE 08dh,0ffh,0ffh,0ffh,0ffh,0fbh,068h,0b5h,0fah,0dah,08dh,0dah,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,06dh,0b1h,0fah,0d6h,048h,0fbh,0ffh,0ffh,0ffh,0ffh,0d6h,048h
	BYTE 069h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0d6h,044h,06dh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,08dh,08dh,0fah,0b5h,06dh,0dah,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0b6h,08dh,0dah,0d6h,048h,0fbh,0ffh,0ffh,0ffh,0ffh,0ffh,0d6h,0dah,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,08dh,08dh
	BYTE 0fah,0b5h,08dh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0dah,08dh,0b5h,0d6h
	BYTE 06dh,0fbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b1h,0d6h,0b1h,08dh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,08dh,0b6h,06dh,0b6h,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06dh,0b1h,0b1h,08dh,0fbh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,069h,091h,08dh,08dh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0dbh,048h,0b1h,069h,0b6h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0fbh,08dh,048h,048h,0fbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,08dh,044h,06dh
	BYTE 0b2h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0b2h,069h,0dbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,092h,06dh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh

END

