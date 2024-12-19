module ProgramMemory (
    input [5:0] addr,
    output reg [12:0] InsOut
);

parameter dmIns = 17;
parameter imdIns = dmIns+11;
integer i=0;
reg [12:0] Mem [63:0];

initial begin
    for(i=0; i<=63; i=i+1) begin
        Mem[i] = {`OPCODE_NOP,8'bxxxx_xxxx};
    end

//TESTING REGISTER FILE INSTRUCTION SEGMENT 
    //TESTING CARRY
    Mem[0]  = {`OPCODE_ADD_R,`R1}; //1
    Mem[1]  = {`OPCODE_SUB_R,`R1}; //0
    Mem[2]  = {`OPCODE_SUB_R,`R1}; //255
    Mem[3]  = {`OPCODE_SUB_R,`R1}; //253 (1+CY)
    Mem[4]  = {`OPCODE_ADD_R,`R2}; //255
    Mem[5]  = {`OPCODE_ADD_R,`R2}; //1
    Mem[6]  = {`OPCODE_ADD_R,`R0}; //2 (0+CY)


    Mem[7]  = {`OPCODE_ADD_R,`R3}; //6
    //TESTING STORE
    Mem[8]  = {`OPCODE_ST_R ,`R3}; //R3=6
    Mem[9]  = {`OPCODE_ADD_R,`R3}; //12
    Mem[10] = {`OPCODE_ADD_R,`R2}; // 14 = 1110
    //TESTING AND
    Mem[11] = {`OPCODE_AND_R,`R3}; // 1110 & 0110 = 0110 = 6
    //TESTING NOT
    Mem[12] = {`OPCODE_NOT,`R0}; //249
    //TESTING OR
    Mem[13] = {`OPCODE_OR_R ,`R3}; //255
    //TESTING LD
    Mem[14] = {`OPCODE_LD_R ,`R2}; //2
    //TESTING XOR
    Mem[15] = {`OPCODE_XOR_R,`R1}; //0010 ^ 0001 = 0011 3
    Mem[16] = {`OPCODE_XOR_R,`R3}; //0110 ^ 0011 = 0101 5

    Mem[17] = {`OPCODE_NOP,`R1};       
                                                                                  

//TESTING DATA MEMORY INSTRUCTION SEGMENT
    Mem[dmIns+1] = {`OPCODE_ADD_DM,8'd20};   // A=5; A+=20 = 25
    Mem[dmIns+2] = {`OPCODE_SUB_DM,8'd18};   // A=7
    Mem[dmIns+3] = {`OPCODE_AND_DM,8'd14};   // A=0111 $ 1110 = 0110 = 6
    Mem[dmIns+4] = {`OPCODE_OR_DM, 8'd8};    // A=1110 = 14 
    Mem[dmIns+5] = {`OPCODE_ST_DM, 8'd253};  // DM[253] = 14        CHECK THIS
    Mem[dmIns+6] = {`OPCODE_LD_DM, 8'd15};   // A = DM[15] = 15
    Mem[dmIns+7] = {`OPCODE_XOR_DM,8'hBE};   // 0000_1111 ^ 1011_1110 = 1011_0001 = 177
    Mem[dmIns+8] = {`OPCODE_NOT,8'd219};  //ERR ERR ERR A~=A; Data shouldnt count = 78
    Mem[dmIns+9] = {`OPCODE_LD_DM, 8'd253};  //A=14
    Mem[dmIns+10] = {`OPCODE_NOP,`R1};   
    Mem[dmIns+11] = {`OPCODE_NOP,`R2};   


//TESTING IMMEDIATE DATA INSTRUCTION SEGMENT
    Mem[imdIns+1] = {`OPCODE_LD_IMD, 8'd5};    // A=5
    Mem[imdIns+2] = {`OPCODE_ADD_IMD,8'd20};   // A+=20 = 25
    Mem[imdIns+3] = {`OPCODE_SUB_IMD,8'd18};   // A=7
    Mem[imdIns+4] = {`OPCODE_AND_IMD,8'd14};   // A=0111 $ 1110 = 0110 = 6
    Mem[imdIns+5] = {`OPCODE_OR_IMD, 8'd8};    // A=1110 = 14 
    Mem[imdIns+6] = {`OPCODE_LD_IMD, 8'd15};   // A = 15
    Mem[imdIns+7] = {`OPCODE_XOR_IMD,8'hBE};   // 0000_1111 ^ 1011_1110 = 1011_0001 = 177
    Mem[imdIns+8] = {`OPCODE_NOT,8'd219};  //ERR ERR ERR A~=A; Data shouldnt count = 78

end 

assign InsOut = Mem[addr];




endmodule