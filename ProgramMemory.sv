module ProgramMemory (
    input [4:0] addr,
    output reg [12:0] InsOut
);

integer i=0;
reg [5:0] Mem [31:0];

initial begin
    for(i=0; i<31; i=i+1) begin
        Mem[i] = {`OPCODE_NOP,2'bxx};
    end

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
    Mem[11] = {`OPCODE_AND_R,`R3}; // 1110 & 0110 = 0110
    //TESTING NOT
    Mem[12] = {`OPCODE_NOT_R,`R0}; //249
    //TESTING OR
    Mem[13] = {`OPCODE_OR_R ,`R3}; //255
    //TESTING LD
    Mem[14] = {`OPCODE_LD_R ,`R2}; //2
    //TESTING XOR
    Mem[15] = {`OPCODE_XOR_R,`R1}; //0010 ^ 0001 = 0011 3
    Mem[16] = {`OPCODE_XOR_R,`R3}; //0110 ^ 0011 = 0101 5


    //DONE
end

assign InsOut = Mem[addr];




endmodule