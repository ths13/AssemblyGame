; #########################################################################
;
;   blit.asm - Assembly file for EECS205 Assignment 3
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
include trig.inc
include blit.inc


.DATA

	;; If you need to, you can place global variables here
	
.CODE

; *********************************************
FixedMult PROC USES edx x:DWORD, y:DWORD

; -----Helper Function
    mov eax, x
    imul y        ; multiply two inputs
    
    shr eax, 16      
    shl edx, 16
    add eax, edx  

    ret

FixedMult ENDP

; *********************************************
DrawPixel PROC USES ebx ecx edx x:DWORD, y:DWORD, color:DWORD

    mov ebx, ScreenBitsPtr          ; place ptr into register
    mov ecx, y
    mov eax, 640
    imul ecx            
    add eax, x                      ; take y*640 (row) + x
    mov edx, color                  ; move color (32 bit) into register
    mov BYTE PTR [ebx + eax], dl    ; move byte of color into byte sized address
                                    ; add ptr to offset
    ret
    
DrawPixel ENDP

; *********************************************
BasicBlit PROC USES ebx ecx edx edi esi ptrBitmap:PTR EECS205BITMAP, xcenter:DWORD, ycenter:DWORD

    LOCAL screenX:DWORD, screenY:DWORD, dwW:DWORD, dwH:DWORD, dwHalfW:DWORD,
          dwHalfH:DWORD, transp:BYTE
    
    mov eax, ptrBitmap
    mov ebx, (EECS205BITMAP PTR[eax]).dwWidth
    mov dwW, ebx
    shr ebx, 1
    mov dwHalfW, ebx

    mov ebx, (EECS205BITMAP PTR[eax]).dwHeight
    mov dwH, ebx
    shr ebx, 1
    mov dwHalfH, ebx

    mov bl, (EECS205BITMAP PTR [eax]).bTransparent
    mov transp, bl

; -----Main
    mov ebx, xcenter        ; position of x
    sub ebx, dwHalfW        ; xcenter - width/2 
    mov ecx, ycenter     
    sub ecx, dwHalfH
    mov edi, (EECS205BITMAP PTR [eax]).lpBytes      ; sprite pointer
    mov esi, ScreenBitsPtr
    jmp Eval

Loop1:
; -----Increment Row
    mov ebx, xcenter
    sub ebx, dwHalfW
    add ecx, 1              ; increment row
    mov eax, ycenter
    add eax, dwHalfH
    cmp ecx, eax            ; if the new row is out of bounds we are finished
    jl Eval
    ret

Eval:
    cmp ebx, 0
    jl Loop2
    cmp ebx, 639
    jg Loop2
    cmp ecx, 0
    jl Loop2
    cmp ecx, 479
    jg Loop2

; -----Check Transparency / Draw
    mov dl, [edi]           ; sprite byte pointer
    cmp dl, transp
    je Loop2                ; skip drawing if transparent
    INVOKE DrawPixel, ebx, ecx, dl 
   
Loop2:     
; -----Pointer Moved Up & Increment Column
    mov eax, xcenter
    add eax, dwHalfW
    cmp ebx, eax
    jge Loop1               ; increment row if end of sprite
    add ebx, 1              ; increment one byte
    add edi, 1
    jmp Eval

    ret    	;;  Do not delete this line!

BasicBlit ENDP

; *********************************************
RotateBlit PROC USES ebx ecx edi esi edx lpBmp:PTR EECS205BITMAP, xcenter:DWORD, ycenter:DWORD, angle:FXPT

    LOCAL cosa:DWORD, sina:DWORD, dwW:DWORD, dwH:DWORD, shiftX:DWORD, shiftY:DWORD, dstW:DWORD,
          dstH:DWORD, dstX:DWORD, dstY:DWORD, srcX:DWORD, srcY:DWORD, screenY:DWORD,
          screenX:DWORD, lpBytes:DWORD, lpBitmapPtr:BYTE, color:BYTE, transp:BYTE

; -----Calculate cosa & sina
    INVOKE FixedCos, angle
    mov cosa, eax
    INVOKE FixedSin, angle
    mov sina, eax

    mov esi, lpBmp

; -----Get values from lpBmp address for Bitmap structure
    mov ebx, (EECS205BITMAP PTR [esi]).lpBytes
    mov lpBytes, ebx
    mov ebx, (EECS205BITMAP PTR [esi]).dwWidth
    mov dwW, ebx
    mov ebx, (EECS205BITMAP PTR [esi]).dwHeight
    mov dwH, ebx
    mov bl, (EECS205BITMAP PTR [esi]).bTransparent
    mov transp, bl

; -----Calculate

    ; -----shiftx
    mov ebx, dwW
    shr ebx, 1
    INVOKE FixedMult, cosa, ebx
    mov shiftX, eax

    mov edx, dwH
    shr edx, 1
    INVOKE FixedMult, sina, edx
    sub shiftX, eax    

    ; -----shifty
    mov ebx, dwH
    shr ebx, 1
    INVOKE FixedMult, cosa, ebx
    mov shiftY, eax

    mov ebx, dwH
    shr ebx, 1
    INVOKE FixedMult, cosa, ebx
    mov shiftY, eax

    mov edx, dwH
    shr edx, 1
    INVOKE FixedMult, sina, edx
    add shiftY, eax

    ; -----dswtwidth & dstheight
    mov eax, dwW
    add eax, dwH
    mov dstW, eax
    mov dstH, eax
    mov ebx, dstH       ; negate the height
    neg ebx
    mov dstY, ebx

Outer_For:
; -----Increment Row
    mov ecx, dstW
    neg ecx
    mov dstX, ecx

Inner_For:
; -----Increment Col
    ;; calculate srcx
    mov eax, dstX
    imul cosa
    sar eax, 16
    mov ebx, eax

    mov eax, dstY
    imul sina
    sar eax, 16
    add eax, ebx
    mov srcX, eax

    ;; srcy
    mov eax, dstY
    imul cosa
    sar eax, 16
    mov ebx, eax

    mov eax, dstX
    imul sina
    sar eax, 16
    sub ebx, eax
    mov srcY, ebx

    ; -----if statement    
    mov ebx, srcX
    cmp ebx, 0
    jl Eval
    cmp ebx, dwW
    jge Eval

    mov ebx, srcY
    cmp ebx, 0
    jl Eval
    cmp ebx, dwH
    jge Eval

    mov edx, 0
    sub edx, shiftX
    add edx, xcenter
    add edx, dstX
    mov screenX, edx
    cmp edx, 0
    jl Eval
    cmp edx, 639
    jge Eval
    mov edx, 0
    sub edx, shiftY
    add edx, dstY
    add edx, ycenter
    mov screenY, edx
    cmp edx, 0
    jl Eval
    cmp edx, 479
    jge Eval

    ; -----transparency check
    mov eax, srcY
    mov esi, dwW
    mul esi
    add eax, srcX
    add eax, lpBytes

    mov cl, BYTE PTR [eax]
    mov color, cl
    cmp cl, transp
    je Eval

; -----Draw
    INVOKE DrawPixel, screenX, screenY, color

Eval:
; -----if fail conditions, start with outer
    inc dstX
    mov ebx, dstX
    cmp ebx, dstW
    jl Inner_For

    inc dstY
    mov ebx, dstY
    cmp ebx, dstH
    jl Outer_For

    ret

RotateBlit ENDP

END
