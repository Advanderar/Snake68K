*-----------------------------------------------------------
* Subroutines
*-----------------------------------------------------------
CLEARSCREEN
    MOVEM   D0-D1,-(SP)
    MOVE.B  #11,D0
    MOVE.W  #$FF00,D1
    TRAP    #15
    MOVEM   (SP)+,D0-D1 

SETSCREEN
    MOVEM   D0-D1,-(SP)
    MOVE.W  #33,D0
    MOVE.W  #640,D1
    SWAP    D1
    MOVE.W  #640,D1
    TRAP    #15
    MOVEM   (SP)+,D0-D1
    RTS
  
DRAWS
    MOVEM   D0-D4,-(SP)
    MOVE.W  #87,D0
    MOVE.B  16(SP),D1
    MOVE.B  14(SP),D2
    MULU    #20,D1
    MULU    #20,D2
    MOVE.W  D1,D3
    MOVE.W  D2,D4
    ADD.W   #20,D3
    ADD.W   #20,D4
    TRAP    #15
    MOVEM   (SP)+,D0-D4
    RTS
    
DELAY
    MOVEM.L   D0,-(SP)
    CLR     D0
    MOVE.L  #$3FFFF,D0
DLOOP
    NOP
    SUB.L   #1,D0
    BNE     DLOOP
    MOVEM.L   (SP)+,D0
    RTS
    
ENABLEKEYBOARD
    MOVEM   D0-D1,-(SP)
    MOVE.W  #62,D0
    MOVE.W  #$0101,D1
    TRAP    #15
    CLR     D1
    MOVE.W  #32,D0
    MOVE.W  #5,D1
    TRAP    #15
    MOVEM   (SP)+,D0-D1
    RTS
    
KEYBOARD
    MOVEM.L   D0-D1,-(SP)
    MOVE.B  #19,D0
    MOVE.L  #0,D1
    TRAP    #15
    CMP     #$25,D1
    BLE     LCHANGE
    CMP     #$26,D1
    BLE     UCHANGE
    CMP     #$27,D1
    BLE     RCHANGE
    CMP     #$28,D1
    BLE     DCHANGE
    BRA     INTRTN 
LCHANGE
    MOVE.B  #1,(A2)
    BRA     INTRTN 
RCHANGE
    MOVE.B  #3,(A2)
    BRA     INTRTN 
UCHANGE
    MOVE.B  #2,(A2)
    BRA     INTRTN
DCHANGE 
    MOVE.B  #4,(A2)
    BRA     INTRTN
INTRTN
    MOVEM.L   (SP)+,D0-D1
    RTE

SCREENFLASH
    MOVEM   D0-D4,-(SP)
    MOVE.W  #87,D0
    MOVE.B  #0,D1
    MOVE.B  #0,D2
    MOVE.W  #640,D3
    MOVE.W  #640,D4
    TRAP    #15
    MOVEM   (SP)+,D0-D4
    RTS
    
CHANGE_RED
    MOVEM   D0-D1,-(SP)
    MOVE.W  #81,D0
    MOVE.L  #$000000CC,D1
    TRAP    #15
    MOVEM   (SP)+,D0-D1
    RTS
    
CHANGE_WHITE
    MOVEM   D0-D1,-(SP)
    MOVE.W  #81,D0
    MOVE.L  #$00FFFFFF,D1
    TRAP    #15
    MOVEM   (SP)+,D0-D1
    RTS
    
PLACEFOOD
    JSR     RANNUM
    MOVE.B  D2,(A3)+
    JSR     RANNUM
    MOVE.B  D2,(A3)
    SUBA    #1,A3
    RTS
    
RANNUM
    MOVEM   D0-D1,-(SP)
    MOVE.W  #8,D0
    TRAP    #15
    MOVE.B  D1,D2
    MOVE.L  D2,D1
    DIVU    #$8,D1
    MOVE.W  D1,D2
    MOVEM   (SP)+,D0-D1
    RTS
    



*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
