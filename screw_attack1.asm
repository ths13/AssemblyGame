; #########################################################################
;
;   screw_attack1.asm - Assembly file for EECS205 Assignment 4/5
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

screw_attack1 EECS205BITMAP <64, 64, 255,, offset screw_attack1 + sizeof screw_attack1>
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0dbh,0b6h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0dbh,092h,024h,000h,0b6h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0dbh,092h,024h,000h,000h,06dh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0dbh,092h,024h,000h,000h,000h,049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0dbh,092h,024h,000h,024h,024h,000h,049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0dbh,0b6h,092h,06dh,06dh
	BYTE 06dh,06dh,092h,0b6h,0dbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0dbh,092h
	BYTE 024h,000h,024h,090h,090h,000h,049h,0dbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,06dh,024h,000h,000h,000h,020h,020h
	BYTE 020h,020h,000h,000h,000h,024h,06dh,0b6h,0ffh,0ffh,0ffh,0ffh,0dbh,092h,024h,000h
	BYTE 024h,090h,0fch,0b4h,000h,024h,0dbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,092h,025h,000h,000h,044h,068h,0a8h,0ach,0cch,0cch
	BYTE 0cch,0cch,0ach,0a8h,068h,044h,000h,000h,029h,092h,0dbh,092h,024h,000h,024h,090h
	BYTE 0fch,0fch,0b4h,000h,024h,0dbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0b6h,049h,000h,020h,088h,0cch,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h
	BYTE 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0cch,088h,020h,000h,000h,000h,024h,090h,0fch,0fch
	BYTE 0fch,0b4h,024h,024h,0b6h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,06dh,000h,020h,088h,0cch,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h
	BYTE 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0cch,088h,020h,000h,024h,090h,0fch,0fch,0fch,0fch
	BYTE 0d8h,024h,024h,0b6h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0dbh,049h,000h,064h,0cch,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h
	BYTE 0f0h,0f0h,0f0h,0f0h,0d0h,088h,020h,000h,024h,090h,0fch,0fch,0fch,0fch,0fch,0d8h
	BYTE 024h,000h,0b6h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0dbh,024h,000h,088h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h
	BYTE 0f4h,0f0h,0d0h,088h,020h,000h,024h,090h,0fch,0fch,0fch,0fch,0fch,0fch,0d8h,044h
	BYTE 000h,0b6h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0dbh
	BYTE 024h,000h,0a8h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f4h,0f4h,0f4h,0f4h,0f4h
	BYTE 0d0h,088h,020h,000h,024h,090h,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0d8h,048h,000h
	BYTE 092h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h
	BYTE 000h,0a8h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f4h,0f4h,0f4h,0f4h,0f4h,0d0h,088h
	BYTE 020h,000h,024h,090h,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,048h,000h,000h
	BYTE 049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06dh,000h
	BYTE 088h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f4h,0f4h,0f4h,0f4h,0f4h,0d0h,088h,024h,000h
	BYTE 024h,090h,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,048h,000h,088h,088h
	BYTE 000h,06dh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,000h,064h
	BYTE 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f4h,0f4h,0f4h,0f4h,0d0h,088h,024h,000h,024h,090h
	BYTE 0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,06ch,000h,068h,0f0h,0f0h
	BYTE 064h,000h,0b6h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,024h,020h,0cch
	BYTE 0f0h,0f0h,0f0h,0f0h,0f0h,0f4h,0f4h,0f4h,0d0h,08ch,024h,000h,024h,090h,0fch,0fch
	BYTE 0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,06ch,000h,068h,0f0h,0f0h,0f0h
	BYTE 0cch,020h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,092h,000h,088h,0f0h
	BYTE 0f0h,0f0h,0f0h,0f0h,0f4h,0f4h,0d0h,088h,024h,000h,024h,090h,0fch,0fch,0fch,0fch
	BYTE 0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,06ch,000h,068h,0f0h,0f0h,0f0h,0f0h
	BYTE 0f0h,088h,000h,092h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,029h,020h,0cch,0f0h
	BYTE 0f0h,0f0h,0f0h,0f4h,0d0h,088h,024h,000h,024h,090h,0fch,0fch,0fch,0fch,0fch,0fch
	BYTE 0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,090h,000h,044h,0f0h,0f4h,0f0h,0f0h,0f0h
	BYTE 0f0h,0ech,020h,029h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,000h,088h,0f0h,0f0h
	BYTE 0f0h,0f0h,0f0h,088h,024h,000h,024h,090h,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch
	BYTE 0fch,0fch,0fch,0fch,0fch,0fch,0fch,090h,000h,044h,0f0h,0f4h,0f4h,0f4h,0f0h,0f0h
	BYTE 0f0h,0f0h,088h,000h,0b6h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06dh,000h,0cch,0f0h,0f0h
	BYTE 0f0h,0f0h,08ch,000h,000h,090h,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch
	BYTE 0fch,0fch,0fch,0fch,0fch,0fch,090h,000h,044h,0d0h,0f4h,0f4h,0f4h,0f4h,0f0h,0f0h
	BYTE 0f0h,0f0h,0cch,000h,06dh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,024h,044h,0f0h,0f0h,0f0h
	BYTE 0f0h,0f0h,0d0h,024h,000h,06ch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch
	BYTE 0fch,0fch,0fch,0fch,0fch,0b4h,000h,024h,0d4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f0h
	BYTE 0f0h,0f0h,0f0h,044h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0dbh,000h,068h,0f0h,0f0h,0f0h
	BYTE 0f0h,0f4h,0f4h,0d0h,044h,000h,048h,0d8h,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch
	BYTE 0fch,0fch,0fch,0fch,0b4h,000h,024h,0d4h,0f8h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f0h
	BYTE 0f0h,0f0h,0f0h,068h,000h,0dbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,000h,0a8h,0f0h,0f0h,0f0h
	BYTE 0f0h,0f4h,0f4h,0f4h,0f4h,068h,000h,048h,0d8h,0fch,0fch,0fch,0fch,0fch,0fch,0fch
	BYTE 0fch,0fch,0fch,0b4h,024h,024h,0b4h,0f8h,0f8h,0f8h,0f4h,0f4h,0f4h,0f4h,0f4h,0f0h
	BYTE 0f0h,0f0h,0f0h,0a8h,000h,0b6h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,092h,000h,0ach,0f0h,0f0h,0f0h
	BYTE 0f0h,0f4h,0f4h,0f4h,0f4h,0f4h,08ch,000h,024h,0b4h,0fch,0fch,0fch,0fch,0fch,0fch
	BYTE 0fch,0fch,0d8h,024h,024h,0b4h,0f8h,0f8h,0f8h,0f8h,0f4h,0f4h,0f4h,0f4h,0f4h,0f0h
	BYTE 0f0h,0f0h,0f0h,0ach,000h,092h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06dh,020h,0cch,0f0h,0f0h,0f0h
	BYTE 0f0h,0f4h,0f4h,0f4h,0f4h,0f4h,0f8h,0b0h,024h,000h,090h,0fch,0fch,0fch,0fch,0fch
	BYTE 0fch,0fch,090h,000h,048h,0f8h,0f8h,0f8h,0f8h,0f8h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h
	BYTE 0f0h,0f0h,0f0h,0cch,020h,06dh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06dh,020h,0cch,0f0h,0f0h,0f0h
	BYTE 0f0h,0f4h,0f4h,0f4h,0f4h,0f4h,0f8h,0f8h,0d4h,024h,000h,06ch,0fch,0fch,0fch,0fch
	BYTE 0fch,0fch,0f8h,048h,000h,048h,0d4h,0f8h,0f8h,0f8h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h
	BYTE 0f0h,0f0h,0f0h,0cch,020h,06dh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06dh,020h,0cch,0f0h,0f0h,0f0h
	BYTE 0f0h,0f4h,0f4h,0f4h,0f4h,0f4h,0f8h,0f8h,0f8h,0d4h,048h,000h,048h,0f8h,0fch,0fch
	BYTE 0fch,0fch,0fch,0fch,06ch,000h,024h,0d4h,0f8h,0f8h,0f8h,0f4h,0f4h,0f4h,0f4h,0f4h
	BYTE 0f0h,0f0h,0f0h,0cch,020h,06dh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06dh,020h,0cch,0f0h,0f0h,0f0h
	BYTE 0f0h,0f4h,0f4h,0f4h,0f4h,0f4h,0f8h,0f8h,0f8h,0f8h,0f8h,048h,000h,090h,0fch,0fch
	BYTE 0fch,0fch,0fch,0fch,0fch,090h,000h,024h,0b0h,0f8h,0f8h,0f4h,0f4h,0f4h,0f4h,0f4h
	BYTE 0f0h,0f0h,0f0h,0cch,020h,06dh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,092h,000h,0ach,0f0h,0f0h,0f0h
	BYTE 0f0h,0f4h,0f4h,0f4h,0f4h,0f4h,0f8h,0f8h,0f8h,0f8h,0b4h,024h,024h,0d8h,0fch,0fch
	BYTE 0fch,0fch,0fch,0fch,0fch,0fch,0b4h,024h,000h,08ch,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h
	BYTE 0f0h,0f0h,0f0h,0ach,000h,092h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,000h,0a8h,0f0h,0f0h,0f0h
	BYTE 0f0h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f8h,0f8h,0b4h,024h,024h,0b4h,0fch,0fch,0fch
	BYTE 0fch,0fch,0fch,0fch,0fch,0fch,0fch,0d8h,048h,000h,068h,0f4h,0f4h,0f4h,0f4h,0f0h
	BYTE 0f0h,0f0h,0f0h,0a8h,000h,0b6h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0dbh,000h,068h,0f0h,0f0h,0f0h
	BYTE 0f0h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f8h,0d4h,024h,000h,0b4h,0fch,0fch,0fch,0fch
	BYTE 0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0d8h,048h,000h,044h,0d0h,0f4h,0f4h,0f0h
	BYTE 0f0h,0f0h,0f0h,068h,000h,0dbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,024h,044h,0f0h,0f0h,0f0h
	BYTE 0f0h,0f0h,0f4h,0f4h,0f4h,0f4h,0f4h,0d4h,024h,000h,0b4h,0fch,0fch,0fch,0fch,0fch
	BYTE 0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,06ch,000h,024h,0d0h,0f4h,0f0h
	BYTE 0f0h,0f0h,0f0h,044h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06dh,000h,0cch,0f0h,0f0h
	BYTE 0f0h,0f0h,0f4h,0f4h,0f4h,0f4h,0d0h,044h,000h,090h,0fch,0fch,0fch,0fch,0fch,0fch
	BYTE 0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,090h,000h,000h,08ch,0f4h,0f0h
	BYTE 0f0h,0f0h,0cch,000h,06dh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,000h,088h,0f0h,0f0h
	BYTE 0f0h,0f0h,0f0h,0f4h,0f4h,0f0h,044h,000h,090h,0fch,0fch,0fch,0fch,0fch,0fch,0fch
	BYTE 0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,090h,024h,000h,024h,088h,0f0h,0f0h,0f0h
	BYTE 0f0h,0f0h,088h,000h,0b6h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,029h,020h,0cch,0f0h
	BYTE 0f0h,0f0h,0f0h,0f4h,0f0h,044h,000h,090h,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch
	BYTE 0fch,0fch,0fch,0fch,0fch,0fch,090h,024h,000h,024h,088h,0d0h,0f4h,0f4h,0f0h,0f0h
	BYTE 0f0h,0ech,020h,029h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,092h,000h,088h,0f0h
	BYTE 0f0h,0f0h,0f0h,0f0h,068h,000h,06ch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch
	BYTE 0fch,0fch,0fch,0fch,090h,024h,000h,024h,08ch,0d0h,0f4h,0f4h,0f4h,0f0h,0f0h,0f0h
	BYTE 0f0h,088h,000h,092h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,024h,020h,0cch
	BYTE 0f0h,0f0h,0f0h,068h,000h,06ch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch
	BYTE 0fch,0fch,090h,024h,000h,024h,08ch,0d0h,0f4h,0f4h,0f4h,0f4h,0f0h,0f0h,0f0h,0f0h
	BYTE 0cch,020h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,000h,064h
	BYTE 0f0h,0f0h,068h,000h,06ch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch
	BYTE 090h,024h,000h,024h,08ch,0d0h,0f4h,0f4h,0f4h,0f4h,0f4h,0f0h,0f0h,0f0h,0f0h,0f0h
	BYTE 064h,000h,0b6h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06dh,000h
	BYTE 088h,088h,000h,048h,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,090h,024h
	BYTE 000h,024h,08ch,0d0h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f0h,0f0h,0f0h,0f0h,0f0h,088h
	BYTE 000h,06dh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h
	BYTE 000h,000h,048h,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,090h,024h,000h,020h
	BYTE 088h,0d0h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0a8h,000h
	BYTE 049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,092h
	BYTE 000h,048h,0d8h,0fch,0fch,0fch,0fch,0fch,0fch,0fch,090h,024h,000h,020h,088h,0d0h
	BYTE 0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0a8h,000h,024h
	BYTE 0dbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,000h
	BYTE 044h,0d8h,0fch,0fch,0fch,0fch,0fch,0fch,090h,024h,000h,020h,088h,0d0h,0f4h,0f4h
	BYTE 0f4h,0f4h,0f4h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,088h,000h,024h,0dbh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,000h,024h
	BYTE 0d8h,0fch,0fch,0fch,0fch,0fch,090h,024h,000h,020h,088h,0d0h,0f0h,0f0h,0f0h,0f0h
	BYTE 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0cch,064h,000h,049h,0dbh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,024h,024h,0d8h
	BYTE 0fch,0fch,0fch,0fch,090h,024h,000h,020h,088h,0cch,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h
	BYTE 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0ech,088h,020h,000h,06dh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,024h,024h,0b4h,0fch
	BYTE 0fch,0fch,090h,024h,000h,000h,000h,020h,088h,0cch,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h
	BYTE 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0cch,088h,020h,000h,049h,0b6h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0dbh,024h,000h,0b4h,0fch,0fch
	BYTE 090h,024h,000h,024h,092h,0dbh,092h,029h,000h,000h,044h,068h,0a8h,0ach,0cch,0cch
	BYTE 0cch,0cch,0ach,0a8h,068h,044h,000h,000h,025h,092h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0dbh,024h,000h,0b4h,0fch,090h,024h
	BYTE 000h,024h,092h,0dbh,0ffh,0ffh,0ffh,0ffh,0b6h,06dh,024h,000h,000h,000h,020h,020h
	BYTE 020h,020h,000h,000h,000h,024h,06dh,0b6h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0dbh,049h,000h,090h,090h,024h,000h,024h
	BYTE 092h,0dbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0dbh,0b6h,092h,06dh,06dh
	BYTE 06dh,06dh,092h,0b6h,0dbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,000h,024h,024h,000h,024h,092h,0dbh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,000h,000h,000h,024h,092h,0dbh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06dh,000h,000h,024h,092h,0dbh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,000h,024h,092h,0dbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,0dbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh

END
