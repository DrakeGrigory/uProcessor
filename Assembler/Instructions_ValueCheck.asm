ADD_R    R1  ; 1   ;
SUB_R    R1  ; 0   ;
SUB_R    R1  ; 255 ;
SUB_R    R1  ; 253 ; (1+CY)
ADD_R    R2  ; 255 ;
ADD_R    R2  ; 1   ;
ADD_R    R2  ; 4   ; (0+CY)
ADD_R    R2  ; 6   ;
ST_R     R0  ; 6   ; R0=6
ADD_R    R0  ; 12  ;
ADD_R    R2  ; 14  ; 14 = 1110
AND_R    R0  ; 6   ; 1110 & 0110 = 0110 = 6
NOT      R0  ; 249 ;
OR_R     R0  ; 255 ;
LD_R     R2  ; 2   ;
XOR_R    R1  ; 3   ; 0010 ^ 0001 = 0011 3
NOP          ; 3   ;
NOP          ; 3   ;                                                            
ADD_DM   22  ; 25  ; A=3; A+=22 = 25
SUB_DM   18  ; 7   ; A=7
AND_DM   14  ; 6   ; A=0111 $ 1110 = 0110 = 6
OR_DM    8   ; 14  ; A=1110 = 14 
ST_DM    253 ; 14  ; DM[253] = 14        //manual check
LD_DM    15  ; 15  ; A = DM[15] = 15
XOR_DM   190 ; 177 ; 0000_1111 ^ 1011_1110 = 1011_0001 = 177
NOT          ; 78  ; ~177 = 78       
LD_DM    253 ; 14  ; A=14
NOP          ; 14  ;   
NOP          ; 14  ;  
LD_IMD   5   ; 5   ; A=5
ADD_IMD  20  ; 25  ; A+=20 = 25
SUB_IMD  18  ; 7   ; A=7
AND_IMD  14  ; 6   ; A=0111 $ 1110 = 0110 = 6
OR_IMD   8   ; 14  ; A=1110 = 14 
LD_IMD   15  ; 15  ; A = 15
XOR_IMD  190 ; 177 ; 0000_1111 ^ 1011_1110 = 1011_0001 = 177
NOT          ; 78  ; A = 78  
NOP          ; 78  ; 
NOP          ; 78  ; 
NOP          ; 78  ; 
NOP          ; 78  ; 
NOP          ; 78  ;  //(keep in mind that lines in text editor starts with index 1)
JMP_IMD  44  ; 78  ;  JMP to PC=44 -> JMP_IMD  43       // MANUAL CHECK
JMP_DM   45  ; 78  ;  JMP to PC=45 -> LD_R     R3       // MANUAL CHECK
JMP_IMD  43  ; 78  ;  JMP to PC=43 -> JMP_DM   45       // MANUAL CHECK                    
LD_R     R3  ; 85  ;  //testing TB input
AND_R    R3  ; 80  ;  //testing TB input    
OR_R     R3  ; 240 ;  //testing TB input
ADD_R    R3  ; 255 ;  //testing TB input
SUB_R    R3  ; 0   ;  //testing TB input
LD_IMD   0   ; 0   ;
ST_R     R0  ; 0   ;  //Prepare for next sequence       // MANUAL CHECK
LD_IMD   1   ; 1   ;  //Prepare for next sequence
ST_R     R1  ; 1   ;  //Prepare for next sequence       // MANUAL CHECK
LD_IMD   2   ; 2   ;  //Prepare for next sequence
ST_R     R2  ; 2   ;  //Prepare for next sequence       // MANUAL CHECK
LD_R     R0  ; 0   ;  //Prepare for next sequence
JMP_IMD  62  ; 0   ;  JMP R0 = 60                       // MANUAL CHECK
NOP          ; SGH ;  //Shouldn't get here
NOP          ; SGH ;  //Shouldn't get here
NOP          ; SGH ;  //Shouldn't get here       
NOP          ; SGH ;  //Shouldn't get here
JMP_R    R0  ; 0   ;
NOP          ; SGH ;  //Shouldn't get here