/* WHAT IS THIS? 
// This module is an Instruction Decoder
// It decodes instruction fetched from program memory                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
*/

module InstructionDecoder(
input [5:0] Ins,

output reg [3:0] RegAddr,    
output reg [2:0] ALUCode, 
output reg Reg_CE,          
output reg CY_CE,        
output reg A_CE,         
output reg nResetCY
);

wire [3:0] OpCode;
wire [1:0] RNum;
wire [2:0] ALUCodeWire;

assign OpCode = Ins[5:2];
assign RNum = Ins[1:0];
assign ALUCodeWire = Ins[4:2]; 

always @(*) begin
//RegAddr
    case (RNum)
     `R0: RegAddr = 4'b0001; 
     `R1: RegAddr = 4'b0010;
     `R2: RegAddr = 4'b0100;
     `R3: RegAddr = 4'b1000;
    default: RegAddr = 4'd0;
    endcase 

//RegCE
    if((OpCode& 4'b1100) == 4'b1100) begin
        Reg_CE=1;
    end else begin
        Reg_CE=0;
    end


//ALUCode
    if((OpCode & 4'b1000) == 4'b0000) begin
        ALUCode = ALUCodeWire; 
    end else begin
        ALUCode = 3'b111;
    end

//CY_CE AND nResetCY
    if((OpCode & 4'b1110) == 4'b0000) begin
        CY_CE = 1;
        nResetCY = 1;
    end else begin
        CY_CE = 0;
        nResetCY = 0;
    end

//A_CE
    if(OpCode<`OPCODE_NOP) begin
        A_CE = 1;
    end else begin
        A_CE = 0;
    end
end









endmodule