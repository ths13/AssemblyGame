; #########################################################################
;
;   trig.asm - Assembly file for EECS205 Assignment 3
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

include trig.inc

.DATA

;;  These are some useful constants (fixed point values that correspond to important angles)
PI_HALF = 102943           	;;  PI / 2
PI =  205887	            ;;  PI 
TWO_PI	= 411774          ;;  2 * PI 
PI_INC_RECIP =  5340353       ;;  256 / PI    Use reciprocal to find the table entry for a given angle
	                        ;;              (It is easier to use than divison would be)


	;; If you need to, you can place global variables here
	
.CODE


FixedSin PROC USES ebx ecx edx angle:FXPT

      LOCAL isNegative:DWORD
      mov ebx, angle
      mov isNegative, 0
      cmp ebx, 0                ; check current angle value
      jg greaterZero
      neg ebx                   ; negative angle, make positive & set flag
      not isNegative
      
  greaterZero:
      cmp ebx, TWO_PI
      jle greaterZero_lessTwoPi
      sub ebx, TWO_PI           ; greater than 2pi, keep reducing
      jmp greaterZero
      
  greaterZero_lessTwoPi:
      cmp ebx, PI
      jle greaterZero_lessPi
      sub ebx, PI               ; greater than pi, keep reducing
      not isNegative            ; set flag
      
  greaterZero_lessPi:
      cmp ebx, PI_HALF
      jle getValue
      mov ecx, PI
      sub ecx, ebx
      mov ebx, ecx              ; subtract angle from pi

  getValue:
      mov eax, ebx
      mov ecx, PI_INC_RECIP
      imul ecx
      sub edx, 1
      shl edx, 1
      mov eax, DWORD PTR [SINTAB + edx]     ; get value from sine table
      shr eax, 16

  negative:
      cmp isNegative, 1
      jne done
      neg eax
      
  done:
	ret			; Don't delete this line!!!

FixedSin ENDP 



	
FixedCos PROC angle:FXPT

      mov ebx, angle
      add ebx, PI_HALF      ; trig conversion, cos(x) = sin(x + PI_HALF)
      INVOKE FixedSin, ebx  ; use sine to calculate cosine
      
	ret			; Don't delete this line!!!	

FixedCos ENDP	


END
