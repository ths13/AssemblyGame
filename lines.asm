; #########################################################################
;
;   lines.asm - Assembly file for EECS205 Assignment 2
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

.DATA

	;; If you need to, you can place global variables here
	
.CODE
	

;; Don't forget to add the USES directive here
;;   Place any registers that you modify (either explicitly or implicitly)
;;   into the USES list so that caller's values can be preserved
	
;;   For example, if your procedure uses only the eax and ebx registers
;;      DrawLine PROC USES eax ebx x0:DWORD, y0:DWORD, x1:DWORD, y1:DWORD, color:DWORD

DrawLine PROC USES eax edi esi ecx edx ebx x0:DWORD, y0:DWORD, x1:DWORD, y1:DWORD, color:DWORD

	;; Feel free to use local variables...declare them here
	;; For example:
	;; 	LOCAL foo:DWORD, bar:DWORD

      LOCAL deltax:DWORD, deltay:DWORD, incx:DWORD, incy:DWORD, error:DWORD, currx:DWORD, curry:DWORD, preverror:DWORD
	
	;; Place your code here

  
            mov eax, x1       ; Computing delta_x (abs)
            sub eax, x0       ; subtract (x1 - x0)
            jge skip          ; if x1 > x0, already positive, so skip
            neg eax           ; otherwise, negate to make positive
       skip:
            mov deltax, eax   ; store in delta_x
                
            mov eax, y1       ; Computing delta_y (abs)
            sub eax, y0       ; subtract (y1 - y0)
            jge skip2         ; if y1 > y0, already positive, so skip2
            neg eax           ; otherwise, negate to make positive
      skip2:
            mov deltay, eax   ; store in delta_y
      cond1:                  ; if (x0 < x1)
            mov edi, x0       
            cmp edi, x1
            jge else1         ; if not less than, else1
            mov incx, 1
            jmp cond2     
      else1:
            mov incx, -1
      cond2:                  ; if (y0 < y1)
            mov esi, y0
            cmp esi, y1
            jge else2         ; if not less than, else2
            mov incy, 1
            jmp cond3
      else2:
            mov incy, -1      ; if (delta_x > delta_y)
      cond3:
            mov eax, deltax     
            cmp eax, deltay
            jle else3
            mov edx, 0          ; divide code start (clear edx)
            mov ecx, 2          ; divisor
            div ecx
            mov error, eax      ; divide code end
            jmp next
      else3:
            mov edx, 0          ; divide code start (clear edx)
            mov eax, deltay   
            mov ecx, -2          
            idiv ecx            ; signed division
            mov error, eax
       next:
            mov currx, edi      ; mov x0 (edi) into curr_x
            mov curry, esi      ; mov y0 (esi) into curr_y
               
            mov edi, x1         ; move values into registers
            mov esi, y1
            mov ecx, incx
            mov edx, incy

            invoke DrawPixel, currx, curry, color     ; Call DrawPixel

            jmp eval            ; While loop
         do:
            invoke DrawPixel, currx, curry, color
            mov eax, error
            mov preverror, eax
            mov ebx, deltax
            neg ebx
            cmp preverror, ebx
            jle next2
            sub eax, deltay
            mov error, eax
            add currx, ecx
      next2:
            mov ebx, deltay
            cmp preverror, ebx
            jge eval
            add eax, deltax
            mov error, eax
            add curry, edx
       eval:                    ; if either condition true (not equal), do loop
            cmp currx, edi
            jnz do              ; curr_x - x1: if not zero, jump
            cmp curry, esi
            jnz do              ; curr_y - y1: if not zero, jump
            


	ret        	;;  Don't delete this line...you need it
DrawLine ENDP




END
