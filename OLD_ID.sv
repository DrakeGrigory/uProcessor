/* WHAT IS THIS? 
// This module is an Instruction Decoder
// It decodes instruction fetched from program memory                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
*/

module InstructionDecoder(
input [5:0] Ins,



output logic [3:0] RegAddr,    
output logic [2:0] ALUCode, 
output logic Reg_CE,          
output logic CY_CE,        
output logic A_CE,         
output logic nResetCY
);

wire [3:0] OpCode;
wire [1:0] RNum;
wire [2:0] ALUCodeWire;

assign OpCode = Ins[5:2];       //4
assign RNum = Ins[1:0];         //2
assign ALUCodeWire = Ins[4:2];  //3 

always @(*) begin
//predefine



//RegAddr
    case (RNum)
     `R0: RegAddr = 4'b0001; 
     `R1: RegAddr = 4'b0010;
     `R2: RegAddr = 4'b0100;
     `R3: RegAddr = 4'b1000;
     default: RegAddr = 4'b0000;
    endcase 

//RegCE
    if(OpCode[3:2] == 2'b11) begin
        Reg_CE=1;
    end else begin
        Reg_CE=0;
    end


//ALUCode
    if(OpCode[3] == 1'b0) begin
        ALUCode = ALUCodeWire; 
    end else begin
        if(OpCode[2]==1'b0) begin
            ALUCode = `ALU_LD;
        end else begin
            ALUCode = `ALU_DEF;
        end
    end

//CY_CE AND nResetCY
    if(OpCode[3:1] == 3'b000) begin
        CY_CE = 1;
        nResetCY = 1;
    end else begin
        CY_CE = 0;
        nResetCY = 0;
    end

//A_CE
    if(OpCode<=`OPCODE_NOT || OpCode[3:2]==2'b10) begin
        A_CE = 1;
    end else begin
        A_CE = 0;
    end







//OPCODE 6 - quick fix - no instruction for OPCODE = 6;
    if(OpCode==4'd6) begin
        Reg_CE = 0;
        ALUCode = 3'b111;
        nResetCY = 1;
        CY_CE = 0;
        A_CE = 0;
    end

end







endmodule