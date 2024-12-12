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

wire [4:0] OpCode_w;
wire [2:0] OpCodeSection_w;
wire [1:0] RNum_w;
wire [2:0] ALUCode_w;
wire [7:0] ImdData_w;

assign OpCode_w      = Ins[`ID_IN_MSB   : `ID_IN_MSB-4];         //5 first five MSB bits
assign OpCodeSection_w      = Ins[`ID_IN_MSB   : `ID_IN_MSB-1];         //2 first two MSB bits
assign RNum_w        = Ins[`ID_IN_MSB-5 : `ID_IN_MSB-6];         //2 6-7 MSB bit
assign ALUCode_w     = Ins[`ID_IN_MSB-2 : `ID_IN_MSB-4];         //3 3-5 MSB bits
assign ImdData_w     = Ins[7:0];

always @(*) begin

//RegAddr
    case (RNum_w)
     `R0: RegAddr = 4'b0001; 
     `R1: RegAddr = 4'b0010;
     `R2: RegAddr = 4'b0100;
     `R3: RegAddr = 4'b1000;
     default: RegAddr = 4'b0000;
    endcase 

//RegCE
    if(OpCode_w == `OPCODE_ST_R) begin
        Reg_CE=1;
    end else begin
        Reg_CE=0;
    end


//ALUCode
    if(OpCodeSection_w!=2'b11) begin   //First 3 instructions sections (0-7,8-15,16-23)
        if(ALUCode_w<=`ALU_NOT)
            ALUCode = ALUCode_w;
        else
            ALUCode = `ALU_DEF;
    end else begin              //Last instructions section (24-31)
        if(ALUCode_w <= 3'd2)   
            ALUCode = `ALU_LD;  //Load instructions
        else
            ALUCode = `ALU_DEF; //Store instructions
    end


    

    // if(OpCode[3] == 1'b0) begin
    //     ALUCode = ALUCode_w; 
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