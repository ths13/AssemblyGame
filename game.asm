; #########################################################################
;
;   game.asm - Assembly file for EECS205 Assignment 4/5
;
;   Thomas Sieben
;   ths266
;
;   March 8, 2017
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

; for random
include \masm32\include\masm32.inc
includelib \masm32\lib\masm32.lib

; for strings
include \masm32\include\user32.inc
includelib \masm32\lib\user32.lib

;; Has keycodes
include keys.inc

	
.DATA

;; sounds
music BYTE "Brinstar.wav",0
music2 BYTE "Samus_Appearance_Jingle.wav",0
music3 BYTE "Item_Jingle.wav",0
lvlup BYTE "levelup.wav",0
win BYTE "gamewin.wav",0
powerup BYTE "invincible.wav",0

;; strings
logo BYTE "METROID MANEUVER",0
pauseInst BYTE "[p] - pause",0
unpauseInst BYTE "[u] - start game (unpause)",0
arrowInst BYTE "Press arrow keys to move",0
objective BYTE "Collect the item pictured",0
crash BYTE "Oops!",0
fail BYTE "GAME OVER",0
restart BYTE "Please reopen 'game.exe' to play again",0
lvl BYTE "Level complete!",0
keepgoing BYTE "[c] - continue",0
newpower BYTE "You've earned temporary invicibility! Left click to activate",0
warn BYTE "WARNING - reduces speed",0
complete BYTE "Game COMPLETE!!!",0
expl BYTE "* invincibility used, +500 to score",0

scoreStr BYTE "Your Score: %d   (better scores are closer to zero)",0
outStr BYTE 256 DUP(0)

;; constants
noSound DWORD 100
soundDone DWORD -100
gameOver DWORD 0
Paused DWORD 1
rotate DWORD 0
level DWORD 0
invincible DWORD 0
used DWORD 0
timer DWORD 0
score DWORD 0
finalscore DWORD 0
spriteTopLimit DWORD 0
spriteBottomLimit DWORD 480

;; sprites

Samus Sprite <offset Samus_Aran, 38, 50, 25, 220, ?, 5>
SamusP Sprite <offset Samus_Aran2, 38, 50, 25, 220, ?, 5>

metr1 Sprite <offset metroid, 44, 48, 300, 400, 2, 7, 50, 50>
metr2 Sprite <offset metroid, 44, 48, 200, 80, 3, 10, 50, 50>
metr3 Sprite <offset metroid, 44, 48, 150, 400, 2, 3, 50, 50>
metr4 Sprite <offset metroid, 44, 48, 100, 80, 3, 3, 50, 50>
metr5 Sprite <offset metroid, 44, 48, 50, 400, 2, 5, 50, 50>

maze1_1 Sprite <offset wall_medium, 159, 41, 200, 60, 3, 2, 80, 80>
maze1_2 Sprite <offset wall_medium, 159, 41, 359, 60, 3, 2, 80, 80>
maze1_3 Sprite <offset wall_medium, 159, 41, 518, 60, 3, 2, 80, 80>
maze1_4 Sprite <offset wall_medium, 159, 41, 677, 60, 3, 2, 80, 80>
maze1_5 Sprite <offset wall_medium, 159, 41, 200, 380, 2, 2, 80, 80>
maze1_6 Sprite <offset wall_medium, 159, 41, 359, 380, 2, 2, 80, 80>
maze1_7 Sprite <offset wall_medium, 159, 41, 518, 380, 2, 2, 80, 80>
maze1_8 Sprite <offset wall_medium, 159, 41, 677, 380, 2, 2, 80, 80>

maze2_1 Sprite <offset wall_medium, 159, 41, 560, 80, 3, 2, 50, 50>
maze2_2 Sprite <offset wall_medium, 159, 41, 560, 380, 2, 2, 50, 50>
maze2_3 Sprite <offset wall_medium, 159, 41, 401, 0, 3, 2, 100, 100>
maze2_4 Sprite <offset wall_medium, 159, 41, 401, 460, 2, 2, 100, 100>

item Sprite <offset screw_attack1, 64, 64, 600, 220>
item2 Sprite <offset screw_attack1, 64, 64, 50, 400>
item3 Sprite <offset screw_attack1, 64, 64, 310, 270>




.CODE
	

;; Note: You will need to implement CheckIntersect!!!


; ************************************************************************
CheckIntersect PROC USES ecx esi oneX:DWORD, oneY:DWORD, oneBitmap:PTR EECS205BITMAP, twoX:DWORD, twoY:DWORD, twoBitmap:PTR EECS205BITMAP

      LOCAL oneleft: DWORD, twoleft:DWORD, oneright: DWORD, tworight: DWORD, oneup: DWORD, twoup: DWORD, onedown: DWORD, twodown: DWORD
     
      mov esi, oneBitmap
      mov eax, (EECS205BITMAP PTR [esi]).dwWidth
      shr eax, 1 

      mov ecx, oneX
      sub ecx, eax
      mov oneleft, ecx   
      mov ecx, oneX
      add ecx, eax
      mov oneright, ecx  

      mov eax, (EECS205BITMAP PTR [esi]).dwHeight
      shr eax, 1

      mov ecx, oneY
      sub ecx, eax
      mov onedown, ecx     
      mov ecx, oneY
      add ecx, eax
      mov oneup, ecx       

      mov esi, twoBitmap
      mov eax, (EECS205BITMAP PTR [esi]).dwWidth
      shr eax, 1

      mov ecx, twoX
      sub ecx, eax
      mov twoleft, ecx
      mov ecx, twoX
      add ecx, eax
      mov tworight, ecx

      mov eax, (EECS205BITMAP PTR [esi]).dwHeight
      shr eax, 1

      mov ecx, twoY
      sub ecx, eax
      mov twodown, ecx
      mov ecx, twoY
      add ecx, eax
      mov twoup, ecx

      xor eax, eax
      xor ecx, ecx

      horiz1:
          mov esi, twoleft
          cmp esi, oneleft
          jb horiz2
          cmp esi, oneright
          ja horiz2
          mov eax, 1
          jmp vertic1
      horiz2: 
          mov esi, oneleft
          cmp esi, twoleft
          jb vertic1
          cmp esi, tworight
          ja vertic1
          mov eax, 1
          jmp vertic1

      vertic1: 
          mov esi, twoup
          cmp esi, oneup
          ja vertic2
          cmp esi, onedown
          jb vertic2
          mov ecx, 1
          jmp exit
      vertic2: 
          mov esi, oneup
          cmp esi, twoup
          ja exit
          cmp esi, twodown
          jb exit
          mov ecx, 1
          jmp exit

      exit:
          and eax, ecx ;;make sure both horizontal and vertical collision happened

          ret
      
CheckIntersect ENDP


; ************************************************************************
MoveSprite PROC USES ebx ecx esi sprite:PTR Sprite, direction:DWORD
      mov esi, sprite
      mov ebx, (Sprite PTR [esi]).speed
      cmp direction, 1
      je right
      cmp direction, 2
      je up
      cmp direction, 3
      je down
   left:
      mov ecx, (Sprite PTR [esi]).x
      sub ecx, ebx
      mov (Sprite PTR [esi]).x, ecx
      ret
   right:
      mov ecx, (Sprite PTR [esi]).x
      add ecx, ebx
      mov (Sprite PTR [esi]).x, ecx
      ret 
   up:
      mov ecx, (Sprite PTR [esi]).y
      sub ecx, ebx
      cmp ecx, spriteTopLimit
      jle done
      mov (Sprite PTR [esi]).y, ecx
      ret
   down:
      mov ecx, (Sprite PTR [esi]).y
      add ecx, ebx
      cmp ecx, spriteBottomLimit
      jge done
      mov (Sprite PTR [esi]).y, ecx
      ret
   done:
      ret
MoveSprite ENDP


; ************************************************************************
MoveEnemy PROC USES esi ebx ecx edx sprite:PTR Sprite
      mov esi, sprite
      mov ebx, (Sprite PTR [esi]).direction
      mov ecx, (Sprite PTR [esi]).dist
      mov edx, (Sprite PTR [esi]).distleft
      jmp check
  do:
      invoke MoveSprite, esi, ebx
      sub (Sprite PTR [esi]).distleft, 1
      ret
  check:
      cmp edx, 0
      jne do
      mov (Sprite PTR [esi]).distleft, ecx
  direction_flip:
      cmp ebx, 0
      jne next
      mov (Sprite PTR [esi]).direction, 1
      ret
  next:
      cmp ebx, 1
      jne next2
      mov (Sprite PTR [esi]).direction, 0
      ret
  next2:
      cmp ebx, 2
      jne next3
      mov (Sprite PTR [esi]).direction, 3
      ret
  next3:
      mov (Sprite PTR [esi]).direction, 2
      ret
 
MoveEnemy ENDP


; ************************************************************************
HandleInput PROC USES esi

      mov esi, offset Samus
      mov eax, KeyPress
      cmp Paused, 1
      je paused
      cmp eax, 050h
      je pause
      cmp eax, 025h
      je left
      cmp eax, 026h
      je up
      cmp eax, 027h
      je right
      cmp eax, 028h
      je down
      lea eax, MouseStatus
      cmp (MouseInfo PTR [eax]).buttons, MK_LBUTTON
      je left_click
      jmp done

  left:
      mov (Sprite PTR [esi]).direction, 0
      invoke MoveSprite, esi, 0
      ret
  right:
      mov (Sprite PTR [esi]).direction, 1
      invoke MoveSprite, esi, 1
      ret
  up:
      invoke MoveSprite, esi, 2
      mov (Sprite PTR [esi]).direction, 2
      ret
  down:
      invoke MoveSprite, esi, 3
      mov (Sprite PTR [esi]).direction, 2
      ret
  left_click:
      cmp used, 1
      je done
      cmp invincible, 1
      jne done
      mov used, 1
      mov timer, 200
      invoke PlaySound, offset powerup, 0, SND_FILENAME OR SND_ASYNC
      mov soundDone, 200
      mov (Sprite PTR [esi]).speed, 1
      jmp done
  pause:
      xor Paused, 1
      ret
  paused:
      cmp eax, 055h
      je unpause
      ret
  unpause:
      xor Paused, 1
      ret
  done:
      ret
      
HandleInput ENDP


; ************************************************************************
memset PROC USES ecx edi dst:PTR BYTE, sze:DWORD, val:BYTE

      cld
      mov ecx, sze
      mov edi, dst
      mov al, val
      rep stosb
      mov eax, sze
      ret
      
memset ENDP


; ************************************************************************
GameInit PROC
	
      invoke PlaySound, offset music2, 0, SND_FILENAME OR SND_ASYNC
      rdtsc
      invoke nseed, eax
      ret         ;; Do not delete this line!!!
      
GameInit ENDP


; ************************************************************************
GamePlay PROC USES edi esi ebx ecx edx

 ;--Initialization
      cmp gameOver, 1
      je clear
      cmp level, 1
      je new
      cmp noSound, 0
      jne Skip1
      dec noSound
      invoke PlaySound, offset music, 0, SND_FILENAME OR SND_ASYNC OR SND_LOOP
      jmp Continue

   Skip1:
      dec noSound
      
 ;--Draw Instructions
   Continue:
      invoke DrawStr, offset logo, 250, 25, 0ffh
      invoke DrawStr, offset unpauseInst, 25, 50, 0ffh
      invoke DrawStr, offset pauseInst, 25, 75, 0ffh
      invoke DrawStr, offset arrowInst, 25, 100, 0ffh
      invoke DrawStr, offset objective, 210, 210, 0ffh
      lea edi, item3
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx
              
      mov eax, Paused
      cmp eax, 1
      je Skip2
      
 ;--Clear Screen
   clear:
      invoke memset, ScreenBitsPtr, 307200, 0
      cmp gameOver, 1
      je Game_Over
      cmp level, 1
      je new
      cmp level, 3
      je newnew

 ;--Handle User Input
   Skip2:
      invoke HandleInput
      mov eax, Paused
      cmp eax, 1
      je Pause_Skip

 ;--Draw Randomized Background
      inc score
      invoke DrawStarField

 ;--Draw Sprites      
      cmp timer, 0
      jg protected 
      
      ;--draw hero
      lea edi, Samus
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx

      cmp soundDone, 0
      jne compare
      invoke PlaySound, offset music, 0, SND_FILENAME OR SND_ASYNC OR SND_LOOP
      mov soundDone, -100
      lea edi, Samus
      mov (Sprite PTR [edi]).speed, 5
      jmp compare

   protected:
      lea esi, Samus
      lea edi, SamusP
      mov eax, (Sprite PTR [esi]).x
      mov ebx, (Sprite PTR [esi]).y
      mov (Sprite PTR [edi]).x, eax
      mov (Sprite PTR [edi]).y, ebx
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx
      dec timer
      dec soundDone

   compare:
      cmp level, 2
      je maze2

      
 ;--draw maze 1
      lea edi, maze1_1
      invoke MoveEnemy, edi
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx

      lea edi, maze1_2
      invoke MoveEnemy, edi
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx

      lea edi, maze1_3
      invoke MoveEnemy, edi
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx

      lea edi, maze1_4
      invoke MoveEnemy, edi
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx

      lea edi, maze1_5
      invoke MoveEnemy, edi
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx

      lea edi, maze1_6
      invoke MoveEnemy, edi
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx

      lea edi, maze1_7
      invoke MoveEnemy, edi
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx

      lea edi, maze1_8
      invoke MoveEnemy, edi
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx  

      lea edi, item
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke RotateBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx, rotate
      add rotate, 1024

      
  ;--Check Collisions 1
      lea edi, Samus
      lea esi, maze1_1      
      invoke CheckIntersect, (Sprite PTR [edi]).x, (Sprite PTR [edi]).y, (Sprite PTR [edi]).bitmapPtr, (Sprite PTR [esi]).x, (Sprite PTR [esi]).y, (Sprite PTR [esi]).bitmapPtr
      cmp eax, 0
      jne collision ;no collision if equal

      lea esi, maze1_2      
      invoke CheckIntersect, (Sprite PTR [edi]).x, (Sprite PTR [edi]).y, (Sprite PTR [edi]).bitmapPtr, (Sprite PTR [esi]).x, (Sprite PTR [esi]).y, (Sprite PTR [esi]).bitmapPtr
      cmp eax, 0
      jne collision ;no collision if equal

      lea esi, maze1_3      
      invoke CheckIntersect, (Sprite PTR [edi]).x, (Sprite PTR [edi]).y, (Sprite PTR [edi]).bitmapPtr, (Sprite PTR [esi]).x, (Sprite PTR [esi]).y, (Sprite PTR [esi]).bitmapPtr
      cmp eax, 0
      jne collision ;no collision if equal
      
      lea esi, maze1_4      
      invoke CheckIntersect, (Sprite PTR [edi]).x, (Sprite PTR [edi]).y, (Sprite PTR [edi]).bitmapPtr, (Sprite PTR [esi]).x, (Sprite PTR [esi]).y, (Sprite PTR [esi]).bitmapPtr
      cmp eax, 0
      jne collision ;no collision if equal

      lea esi, maze1_5      
      invoke CheckIntersect, (Sprite PTR [edi]).x, (Sprite PTR [edi]).y, (Sprite PTR [edi]).bitmapPtr, (Sprite PTR [esi]).x, (Sprite PTR [esi]).y, (Sprite PTR [esi]).bitmapPtr
      cmp eax, 0
      jne collision ;no collision if equal

      lea esi, maze1_6      
      invoke CheckIntersect, (Sprite PTR [edi]).x, (Sprite PTR [edi]).y, (Sprite PTR [edi]).bitmapPtr, (Sprite PTR [esi]).x, (Sprite PTR [esi]).y, (Sprite PTR [esi]).bitmapPtr
      cmp eax, 0
      jne collision ;no collision if equal

      lea esi, maze1_7      
      invoke CheckIntersect, (Sprite PTR [edi]).x, (Sprite PTR [edi]).y, (Sprite PTR [edi]).bitmapPtr, (Sprite PTR [esi]).x, (Sprite PTR [esi]).y, (Sprite PTR [esi]).bitmapPtr
      cmp eax, 0
      jne collision ;no collision if equal

      lea esi, maze1_8      
      invoke CheckIntersect, (Sprite PTR [edi]).x, (Sprite PTR [edi]).y, (Sprite PTR [edi]).bitmapPtr, (Sprite PTR [esi]).x, (Sprite PTR [esi]).y, (Sprite PTR [esi]).bitmapPtr
      cmp eax, 0
      jne collision ;no collision if equal

      lea esi, item     
      invoke CheckIntersect, (Sprite PTR [edi]).x, (Sprite PTR [edi]).y, (Sprite PTR [edi]).bitmapPtr, (Sprite PTR [esi]).x, (Sprite PTR [esi]).y, (Sprite PTR [esi]).bitmapPtr
      cmp eax, 0
      jne levelup ;no collision if equal
      
      jmp Pause_Skip

  ;--draw maze 2
  
  maze2:
      lea edi, maze2_1
      invoke MoveEnemy, edi
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx

      lea edi, maze2_2
      invoke MoveEnemy, edi
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx

      lea edi, maze2_3
      invoke MoveEnemy, edi
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx

      lea edi, maze2_4
      invoke MoveEnemy, edi
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx

  ;--new enemies
      lea edi, metr1
      invoke MoveEnemy, edi
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx

      lea edi, metr2
      invoke MoveEnemy, edi
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx

      lea edi, metr3
      invoke MoveEnemy, edi
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx

      lea edi, metr4
      invoke MoveEnemy, edi
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx

      lea edi, metr5
      invoke MoveEnemy, edi
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke BasicBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx

      lea edi, item2
      mov eax, (Sprite PTR [edi]).x
      mov ebx, (Sprite PTR [edi]).y
      invoke RotateBlit, (Sprite PTR [edi]).bitmapPtr, eax, ebx, rotate
      add rotate, 1024



  ;--invincible?
      cmp timer, 0
      jg Pause_Skip
      
      

  ;--Check Collisions 2
  Check2:
      lea edi, Samus
      lea esi, maze2_1      
      invoke CheckIntersect, (Sprite PTR [edi]).x, (Sprite PTR [edi]).y, (Sprite PTR [edi]).bitmapPtr, (Sprite PTR [esi]).x, (Sprite PTR [esi]).y, (Sprite PTR [esi]).bitmapPtr
      cmp eax, 0
      jne collision ;no collision if equal

      lea esi, maze2_2      
      invoke CheckIntersect, (Sprite PTR [edi]).x, (Sprite PTR [edi]).y, (Sprite PTR [edi]).bitmapPtr, (Sprite PTR [esi]).x, (Sprite PTR [esi]).y, (Sprite PTR [esi]).bitmapPtr
      cmp eax, 0
      jne collision ;no collision if equal

      lea esi, maze2_3      
      invoke CheckIntersect, (Sprite PTR [edi]).x, (Sprite PTR [edi]).y, (Sprite PTR [edi]).bitmapPtr, (Sprite PTR [esi]).x, (Sprite PTR [esi]).y, (Sprite PTR [esi]).bitmapPtr
      cmp eax, 0
      jne collision ;no collision if equal
      
      lea esi, maze2_4      
      invoke CheckIntersect, (Sprite PTR [edi]).x, (Sprite PTR [edi]).y, (Sprite PTR [edi]).bitmapPtr, (Sprite PTR [esi]).x, (Sprite PTR [esi]).y, (Sprite PTR [esi]).bitmapPtr
      cmp eax, 0
      jne collision ;no collision if equal

      lea esi, metr1     
      invoke CheckIntersect, (Sprite PTR [edi]).x, (Sprite PTR [edi]).y, (Sprite PTR [edi]).bitmapPtr, (Sprite PTR [esi]).x, (Sprite PTR [esi]).y, (Sprite PTR [esi]).bitmapPtr
      cmp eax, 0
      jne collision ;no collision if equal

      lea esi, metr2     
      invoke CheckIntersect, (Sprite PTR [edi]).x, (Sprite PTR [edi]).y, (Sprite PTR [edi]).bitmapPtr, (Sprite PTR [esi]).x, (Sprite PTR [esi]).y, (Sprite PTR [esi]).bitmapPtr
      cmp eax, 0
      jne collision ;no collision if equal

      lea esi, metr3    
      invoke CheckIntersect, (Sprite PTR [edi]).x, (Sprite PTR [edi]).y, (Sprite PTR [edi]).bitmapPtr, (Sprite PTR [esi]).x, (Sprite PTR [esi]).y, (Sprite PTR [esi]).bitmapPtr
      cmp eax, 0
      jne collision ;no collision if equal

      lea esi, metr4     
      invoke CheckIntersect, (Sprite PTR [edi]).x, (Sprite PTR [edi]).y, (Sprite PTR [edi]).bitmapPtr, (Sprite PTR [esi]).x, (Sprite PTR [esi]).y, (Sprite PTR [esi]).bitmapPtr
      cmp eax, 0
      jne collision ;no collision if equal

      lea esi, metr5      
      invoke CheckIntersect, (Sprite PTR [edi]).x, (Sprite PTR [edi]).y, (Sprite PTR [edi]).bitmapPtr, (Sprite PTR [esi]).x, (Sprite PTR [esi]).y, (Sprite PTR [esi]).bitmapPtr
      cmp eax, 0
      jne collision ;no collision if equal

      lea esi, item2  
      invoke CheckIntersect, (Sprite PTR [edi]).x, (Sprite PTR [edi]).y, (Sprite PTR [edi]).bitmapPtr, (Sprite PTR [esi]).x, (Sprite PTR [esi]).y, (Sprite PTR [esi]).bitmapPtr
      cmp eax, 0
      jne gamewin ;no collision if equal


      jmp Pause_Skip  
      
  collision:
      inc gameOver
      invoke PlaySound, offset music3, 0, SND_FILENAME OR SND_ASYNC
      jmp Game_Over

  levelup:
      inc level
      inc invincible
      invoke PlaySound, offset lvlup, 0, SND_FILENAME OR SND_ASYNC
      jmp clear
      
  new:    
      invoke DrawStr, offset lvl, 255, 110, 0ffh
      invoke DrawStr, offset keepgoing, 259, 130, 0ffh
      invoke DrawStr, offset newpower, 90, 270, 0ffh
      invoke DrawStr, offset warn, 220, 290, 0ffh
      mov ebx, KeyPress
      cmp ebx, 043h
      jne Pause_Skip
      inc level
      mov noSound, 0
      ret     
  gamewin:
      cmp used, 1
      jne gamewin2
      add score, 500
  gamewin2:
      inc level
      invoke PlaySound, offset win, 0, SND_FILENAME OR SND_ASYNC
      mov eax, score
      mov finalscore, eax
      jmp clear
  newnew:
      mov eax, finalscore
      push eax
      push offset scoreStr
      push offset outStr
      call wsprintf
      add esp, 12
      invoke DrawStr, offset outStr, 110, 100, 0ffh
      cmp used, 1
      jne finish
      invoke DrawStr, offset expl, 170, 150, 0ffh
  finish:
      ret
  Game_Over:
      invoke DrawStr, offset crash, 320, 100, 0ffh
      invoke DrawStr, offset fail, 300, 150, 0ffh
      invoke DrawStr, offset restart, 180, 250, 0ffh
  Pause_Skip:
	ret         ;; Do not delete this line!!!

GamePlay ENDP

END