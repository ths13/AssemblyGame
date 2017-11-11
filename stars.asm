; #########################################################################
;
;   stars.asm - Assembly file for EECS205 Assignment 1
;
;
;   Thomas Sieben
;   ths266
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive


include stars.inc
include lines.inc

; for random
include \masm32\include\masm32.inc
includelib \masm32\lib\masm32.lib

.DATA

	;; If you need to, you can place global variables here

.CODE

StarFieldInit PROC
	
	rdtsc
	invoke nseed, eax

StarFieldInit ENDP

DrawStarField PROC USES edi esi ecx

	;; Place your code here

	xor edi, edi
	xor esi, esi
	mov ecx, 100
  Randomize:
	invoke nrandom, 640
	mov edi, eax
	invoke nrandom, 480
	mov esi, eax
  Draw:
	invoke DrawStar, edi, esi
	dec ecx
	cmp ecx, 0
	jg Randomize

	ret  			; Careful! Don't remove this line

DrawStarField ENDP



END
