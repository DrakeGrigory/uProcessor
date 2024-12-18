/* WHAT IS THIS? 
// This module is an Instruction Decoder
// It decodes instruction fetched from program memory                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
*/

module InstructionDecoder(
input [12:0] Ins,


output logic DataMem_WE,
output logic Reg_CE,   
output logic [3:0] RegAddr,
output logic [7:0] Data,
output logic [1:0] SelDataSource,   

output logic [2:0] ALUCode,
output logic Carry_CE,  

output logic Accu_CE    
);

parameter InsWidth = `PM_ID_INS_WIDTH;

wire [4:0] OpCode_w;
wire [1:0] OpCodeSection_w;
wire [2:0] OpCodeRest_w;
wire [1:0] RNum_w;
wire [7:0] Data_w;

assign OpCode_w        = Ins[InsWidth-1 : InsWidth-5];         //5 first five MSB bits
assign OpCodeSection_w = Ins[InsWidth-1 : InsWidth-2];         //2 first two MSB bits
assign OpCodeRest_w    = Ins[InsWidth-3 : InsWidth-5];         //3 3-5 MSB bits
assign RNum_w          = Ins[InsWidth-6 : InsWidth-7];         //2 6-7 MSB bit
assign Data_w          = Ins[7:0];

always @(*) begin

//RegAddr
    case (RNum_w)
     0: RegAddr = 4'b0001;
     1: RegAddr = 4'b0010;
     2: RegAddr = 4'b0100;
     3: RegAddr = 4'b1000;
     default: RegAddr = 4'b0000;
    endcase 

//Reg_CE
    if(OpCode_w == `OPCODE_ST_R) begin
        Reg_CE=1;
    end else begin
        Reg_CE=0;
    end


//SelDataSource
    if(OpCodeSection_w!=`SEC_REST) begin
        SelDataSource = OpCodeSection_w;
    end else begin
        case(OpCodeRest_w)
            0: SelDataSource = `SEC_R;      // LD_R
            1: SelDataSource = `SEC_DM;     // LD_MD
            2: SelDataSource = `SEC_IMD;    // LD_IMD
            3: SelDataSource = `SEC_R;      // ST_R
            4: SelDataSource = `SEC_DM;     // ST_DM
            default: SelDataSource = `SEC_R; //Random choice
        endcase
    end
     

//ALUCode
    if(OpCodeSection_w != `SEC_REST) begin   //First 3 instructions sections (0-7,8-15,16-23)
        if(OpCodeRest_w<=`ALU_NOT)
            ALUCode = OpCodeRest_w;
        else
            ALUCode = `ALU_DEF;
    end else begin              //Last instructions section (24-31)
        if(OpCodeRest_w <= `LAST_LD_INS)   
            ALUCode = `ALU_LD;  //Load instructions
        else
            ALUCode = `ALU_DEF; //Store instructions
    end


//Carry_CE
    if(OpCodeSection_w != `SEC_REST && OpCodeRest_w <= `ALU_SUB)  //Every ADD-SUB instruction
        Carry_CE = 1;
    else 
        Carry_CE = 0;

//Accu_CE
    if ((OpCodeSection_w != `SEC_REST && OpCodeRest_w <= `ALU_NOT    ) ||
       (OpCodeSection_w == `SEC_REST && OpCodeRest_w <= `LAST_LD_INS))  
        Accu_CE = 1;
    else 
        Accu_CE = 0;


//DataMem_WE
    if(OpCode_w == `OPCODE_ST_DM)
        DataMem_WE = 1;
    else
        DataMem_WE = 0;


//Data: IMD / DM_Addr
    assign Data = Data_w;
    
end


endmodule