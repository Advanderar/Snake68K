*-----------------------------------------------------------
* Title      :
* Written by : Hall7790
* Date       :
* Description: 
*-----------------------------------------------------------
    ORG     $064
    DC.L    KEYBOARD
    
    ORG    $1000
START:                  ; first instruction of program
    JSR ENABLEKEYBOARD
    JSR SETSCREEN
    LEA HEAD,A1
    LEA DIR,A2
    LEA FOOD,A3
    JSR PLACEFOOD
    
LOOP
    JSR     DELAY
    JSR     CLEARSCREEN
    
    JSR     CHANGE_RED
    MOVE.B  (A3)+,-(SP)
    MOVE.B  (A3),-(SP)
    JSR     DRAWS
    
    JSR     CHANGE_WHITE
    MOVE.B  (A1)+,-(SP)
    MOVE.B  (A1),-(SP)
    JSR     DRAWS
    
    SUBA    #1,A1
    SUBA    #1,A3
    
    MOVE.B  (A1)+,D1
    CMP     #32,D1
    BGT     DEAD
    CMP     #0,D1
    BLT     DEAD
    
    MOVE.B  (A1),D1
    CMP     #32,D1
    BGT     DEAD
    CMP     #0,D1
    BLT     DEAD
    
    SUBA    #1,A1
    
    MOVE.B  (A1)+,D0
    MOVE.B  (A3)+,D1
    LSL     #8,D0
    LSL     #8,D1
    MOVE.B  (A1),D0
    MOVE.B  (A3),D1
    CMP     D0,D1
    BEQ     EATEN 
    CLR.L   D1
    CLR.L   D0
    SUBA    #1,A1
    SUBA    #1,A3
 
    MOVE.B  (A2),D1
    
    CMP     #1,D1
    BEQ     GOL
    CMP     #2,D1
    BEQ     GOU
    CMP     #3,D1
    BEQ     GOR
    CMP     #4,D1
    BEQ     GOD
    
    
    
    BRA     LOOP
    
EATEN
    SUBA    #1,A1
    SUBA    #1,A3
    JSR PLACEFOOD
    CLR.L   D1
    CLR.L   D0
    BRA LOOP
    
GOL
    SUB.B   #1,(A1)    
    BRA     LOOP
GOU
    ADDA    #1,A1
    SUB.B   #1,(A1)
    SUBA    #1,A1
    BRA     LOOP
GOR
    ADD.B   #1,(A1)    
    BRA     LOOP  
GOD
    ADDA    #1,A1
    ADD.B   #1,(A1)
    SUBA    #1,A1
    BRA     LOOP 

DEAD
    MOVE.B  #3,D2
    JSR     CHANGE_RED
DEADLOOP
    JSR     SCREENFLASH
    JSR     DELAY
    JSR     CLEARSCREEN
    JSR     DELAY
    DBNE    D2,DEADLOOP
    SIMHALT             ; halt simulator
 

* Put program code here
    
    
    INCLUDE 'subs.X68'

FOOD    DC.B    0,0    
HEAD    DC.B    0,0
DIR     DC.B    3

    END    START        ; last line of source

*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
