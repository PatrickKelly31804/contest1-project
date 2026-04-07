; Meteor Dodge
; Patrick Kelly
; CSE3120 Contest 1
;
; Simple survival game using MASM + Irvine32
; Player moves left/right while meteors fall
;
; NOTE:
; Uses Irvine32 library functions (WriteString, RandomRange, Delay, Gotoxy)
; These were provided in class materials and Irvine examples.

; Environment note:
; This file is being edited on macOS in VS Code.
; Final compile and testing will be done on the Windows MASM + Irvine32 setup used in class.

INCLUDE Irvine32.inc


ROWS = 20
COLS = 30
METEOR_COUNT = 5
PLAYER_ROW = 18



.data
titleMsg        BYTE "METEOR DODGE",0
startMsg        BYTE "Press any key to start",0
controlMsg      BYTE "A = left   D = right",0
gameOverMsg     BYTE "GAME OVER",0
replayMsg       BYTE "Press R to play again, any other key to quit",0
scoreLabel      BYTE "Score: ",0

playerChar      BYTE 'A'
meteorChar      BYTE '*'

playerCol       DWORD 15
score           DWORD 0
gameOver        BYTE 0

meteorRows      DWORD METEOR_COUNT DUP(0)
meteorCols      DWORD METEOR_COUNT DUP(0)

.code



main PROC
    call Randomize

GameStart:
    call InitGame
    call ShowTitle
    call ReadChar
    call RunGame
    call ShowGameOver
    call ReadChar

    cmp al,'r'
    je GameStart
    cmp al,'R'
    je GameStart

    exit
main ENDP




;----------------------------------------------------------
; InitGame
; Resets the player, score, game state, and meteor positions
;----------------------------------------------------------

InitGame PROC
    mov playerCol,15
    mov score,0
    mov gameOver,0

    mov ecx,METEOR_COUNT
    mov esi,0

InitLoop:
    mov DWORD PTR meteorRows[esi*4],0

    mov eax,COLS
    call RandomRange
    mov DWORD PTR meteorCols[esi*4],eax

    inc DWORD PTR meteorRows[esi*4]

    inc esi
    loop InitLoop

    ret
InitGame ENDP


;----------------------------------------------------------
; ShowTitle
; Displays the title screen and basic controls
;----------------------------------------------------------

ShowTitle PROC
    call Clrscr

    mov dh,2
    mov dl,10
    call Gotoxy
    mov edx,OFFSET titleMsg
    call WriteString

    mov dh,4
    mov dl,6
    call Gotoxy
    mov edx,OFFSET controlMsg
    call WriteString

    mov dh,6
    mov dl,5
    call Gotoxy
    mov edx,OFFSET startMsg
    call WriteString

    ret
ShowTitle ENDP



;----------------------------------------------------------
; RunGame
; Main loop for drawing, input, meteor movement, and scoring
;----------------------------------------------------------

RunGame PROC

MainGameLoop:

    cmp gameOver,1
    je EndGame

    call DrawGame
    call HandleInput
    call UpdateMeteors
    call CheckCollision

    cmp gameOver,1
    je EndGame

    inc score

    mov eax,80
    call Delay

    jmp MainGameLoop

EndGame:
    ret

RunGame ENDP


;----------------------------------------------------------
; DrawGame
; Draws score, player, and all active meteors
;----------------------------------------------------------

DrawGame PROC

    call Clrscr

    ; draw score
    mov dh,0
    mov dl,0
    call Gotoxy
    mov edx,OFFSET scoreLabel
    call WriteString
    mov eax,score
    call WriteDec

    ; draw divider line
    mov dh,1
    mov dl,0
    call Gotoxy
    mov edx,OFFSET titleMsg
    call WriteString

    ; draw player
    mov dh,PLAYER_ROW
    mov eax,playerCol
    mov dl,al
    call Gotoxy
    mov al,playerChar
    call WriteChar

    ; draw meteors
    mov ecx,METEOR_COUNT
    mov esi,0

DrawLoop:
    mov eax,DWORD PTR meteorRows[esi*4]
    cmp eax,ROWS
    jae Skip

    mov dh,al
    mov eax,DWORD PTR meteorCols[esi*4]
    mov dl,al
    call Gotoxy
    mov al,meteorChar
    call WriteChar

Skip:
    inc esi
    loop DrawLoop

    ret
DrawGame ENDP


;----------------------------------------------------------
; HandleInput
; Reads keyboard input and moves the player left or right
;----------------------------------------------------------

HandleInput PROC

    call ReadChar   ; waits for input (simpler + reliable)

    cmp al,'a'
    je MoveLeft
    cmp al,'A'
    je MoveLeft

    cmp al,'d'
    je MoveRight
    cmp al,'D'
    je MoveRight

    ret

MoveLeft:
    cmp playerCol,0
    je DoneMove
    dec playerCol
    ret

MoveRight:
    cmp playerCol,29
    jae DoneMove
    inc playerCol

DoneMove:
    ret

HandleInput ENDP

;----------------------------------------------------------
; UpdateMeteors
; Moves meteors downward and respawns them at the top
;----------------------------------------------------------

UpdateMeteors PROC
    mov ecx,METEOR_COUNT
    mov esi,0

UpdateLoop:

    inc DWORD PTR meteorRows[esi*4]

    mov eax,DWORD PTR meteorRows[esi*4]
    cmp eax,ROWS
    jb Next

    mov DWORD PTR meteorRows[esi*4],0

    mov eax,COLS
    call RandomRange
    mov DWORD PTR meteorCols[esi*4],eax

Next:
    inc esi
    loop UpdateLoop

    ret
UpdateMeteors ENDP


;----------------------------------------------------------
; CheckCollision
; Detects whether a meteor has hit the player
;----------------------------------------------------------

CheckCollision PROC
    mov ecx,METEOR_COUNT
    mov esi,0

CollisionLoop:

    mov eax,DWORD PTR meteorRows[esi*4]
    cmp eax,PLAYER_ROW
    jne Continue

    mov eax,DWORD PTR meteorCols[esi*4]
    cmp eax,playerCol
    jne Continue

    mov gameOver,1
    ret

Continue:
    inc esi
    loop CollisionLoop

    ret
CheckCollision ENDP


;----------------------------------------------------------
; ShowGameOver
; Displays final score and replay instructions
;----------------------------------------------------------

ShowGameOver PROC
    call Clrscr

    mov dh,5
    mov dl,10
    call Gotoxy
    mov edx,OFFSET gameOverMsg
    call WriteString

    mov dh,7
    mov dl,8
    call Gotoxy
    mov edx,OFFSET scoreLabel
    call WriteString
    mov eax,score
    call WriteDec

    mov dh,10
    mov dl,1
    call Gotoxy
    mov edx,OFFSET replayMsg
    call WriteString

    ret
ShowGameOver ENDP

END main