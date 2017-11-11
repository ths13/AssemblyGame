; #########################################################################
;
;   game.inc - Includes for EECS205 Assignment 4/5
;
;
; #########################################################################

;; Library Definitions
MouseInfo STRUCT
 horiz DWORD ?
 vert  DWORD ?
 buttons DWORD ?
MouseInfo ENDS

MK_CONTROL  = 0008h  ;; The CTRL key is down.
MK_LBUTTON  = 0001h  ;; The left mouse button is down.
MK_MBUTTON  = 0010h  ;; The middle mouse button is down.
MK_RBUTTON  = 0002h  ;; The right mouse button is down.
MK_SHIFT    = 0004h  ;; The SHIFT key is down.
MK_XBUTTON1 = 0020h  ;; The first X button is down.
MK_XBUTTON2 = 0040h  ;; The second X button is down.


Sprite STRUCT
    bitmapPtr DWORD ?
    dwHeight DWORD ?
    dwWidth DWORD ?
 
    x DWORD ?
    y DWORD ?
    direction DWORD 0
    
    
    speed DWORD 1
    dist DWORD 10
    distleft DWORD 10
Sprite ENDS

;; Library Functions
BlackStarField PROTO
DrawStr PROTO myStr:PTR BYTE, x:DWORD, y:DWORD, color:DWORD

;; Library Data
EXTERNDEF StarBitmap:EECS205BITMAP
EXTERNDEF MouseStatus:MouseInfo
EXTERNDEF KeyUp:DWORD
EXTERNDEF KeyDown:DWORD
EXTERNDEF KeyPress:DWORD

;; Bitmaps
EXTERNDEF Samus_Aran:EECS205BITMAP
EXTERNDEF Samus_Aran2:EECS205BITMAP
EXTERNDEF metroid:EECS205BITMAP
EXTERNDEF wall_medium:EECS205BITMAP
EXTERNDEF screw_attack1:EECS205BITMAP


;; User Defined Functions
GameInit PROTO
GamePlay PROTO
CheckIntersect PROTO oneX:DWORD, oneY:DWORD, oneBitmap:PTR EECS205BITMAP, twoX:DWORD, twoY:DWORD, twoBitmap:PTR EECS205BITMAP



