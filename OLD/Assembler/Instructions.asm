ADD_R    R1  ; 1
SUB_R    R1  ; 0
SUB_R    R1  ; 255
SUB_R    R1  ; 253 (1+CY)
ADD_R    R2  ; 255
ADD_R    R2  ; 1
ADD_R    R2  ; 4 (0+CY)
ADD_R    R2  ; 6
ST_R     R0  ; R0=6
ADD_R    R0  ; 12
ADD_R    R2  ;  14 = 1110
AND_R    R0  ;  1110 & 0110 = 0110 = 6
NOT      R0  ; 249
OR_R     R0  ; 255
LD_R     R2  ; 2
XOR_R    R1  ; 0010 ^ 0001 = 0011 3
NOP ;
NOP ;                                                            
ADD_DM   22  ; A=3; A+=22 = 25
SUB_DM   18  ; A=7
AND_DM   14  ; A=0111 $ 1110 = 0110 = 6
OR_DM    8   ; A=1110 = 14 
ST_DM    253 ; DM[253] = 14        CHECK THIS
LD_DM    15  ; A = DM[15] = 15
XOR_DM   190 ; 0000_1111 ^ 1011_1110 = 1011_0001 = 177
NOT ;      
LD_DM    253 ; A=14
NOP ;  
NOP ; 
LD_IMD   5   ; A=5
ADD_IMD  20  ; A+=20 = 25
SUB_IMD  18  ; A=7
AND_IMD  14  ; A=0111 $ 1110 = 0110 = 6
OR_IMD   8   ; A=1110 = 14 
LD_IMD   15  ; A = 15
XOR_IMD  190 ; 0000_1111 ^ 1011_1110 = 1011_0001 = 177
NOT          ; A = 78  
NOP ;
NOP ;
NOP ;
NOP ;
NOP ;
JMP_IMD  44  ; 42
JMP_DM   45  ; 43
JMP_IMD  43  ; 44
SUB_IMD  18  ; 45
ST_R     R0  ; R0 = A = 60;
JMP_R    R0  ; JMP R0 = 60
NOP ;
NOP ;
NOP ;
NOP ;
NOP ;
NOP ;
NOP ;
NOP ;
NOP ;
NOP ;
NOP ;
NOP ;
JMP_IMD  0   ; 60
NOP ;
NOP ;
NOP ;