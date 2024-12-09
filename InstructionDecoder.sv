/* WHAT IS THIS? 
// This module is an Instruction Decoder
// It decodes instruction fetched from program memory                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
*/

module InstructionDecoder(
input [`ID_IN_MSB:0] Ins,


output logic [7:0] ID_DM_Addr,
output logic ID_DM_CE,
output logic Reg_CE,   
output logic [3:0] RegAddr,
output logic [7:0] ImdData,
output logic Sel,    
output logic [2:0] ALUCode, 
output logic nResetCY
output logic CY_CE,        
output logic A_CE,         

);

wire [4:0] OpCodeWire;
wire [1:0] RNumWire;
wire [2:0] ALUCodeWire;
wire [7:0] ImdDataWire;

assign OpCodeWire      = Ins[`ID_IN_MSB   : `ID_IN_MSB-4];         //5 first MSB bits
assign RNumWire        = Ins[`ID_IN_MSB-5 : `ID_IN_MSB-6];         //2 6-7 MSB bit
assign ALUCodeWire = Ins[`ID_IN_MSB-1 : `ID_IN_MSB-3];         //3 2-4 MSB bits
assign ImdDataWire     = Ins[7:0];

always @(*) begin

//RegAddr
    case (RNumWire)
     `R0: RegAddr = 4'b0001; 
     `R1: RegAddr = 4'b0010;
     `R2: RegAddr = 4'b0100;
     `R3: RegAddr = 4'b1000;
     default: RegAddr = 4'b0000;
    endcase 

//RegCE
    if(OpCodeWire == `OPCODE_ST_R) begin
        Reg_CE=1;
    end else begin
        Reg_CE=0;
    end


//ALUCode
    case(ALUCodeWire)
    // if(OpCode[3] == 1'b0) begin
    //     ALUCode = ALUCodeWire; 
    // end else begin
    //     if(OpCode[2]==1'b0) begin
    //         ALUCode = `ALU_LD;
    //     end else begin
    //         ALUCode = `ALU_DEF;
    //     end
    // end

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