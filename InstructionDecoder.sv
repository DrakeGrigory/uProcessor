/* WHAT IS THIS? 
// This module is an Instruction Decoder
// It decodes instruction fetched from program memory                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
*/

module InstructionDecoder(
input [12:0] Ins,                   //Instruction from Program Memory

output logic DataMem_WE,            // Write Enable for Data Mem (//shouldnt all CE be WE?)
output logic Reg_CE,                // Registers Write Enable Signal
output logic [3:0] RegAddr,         // Decoded Register address
output logic [7:0] Data,            // Data comming out of Instruction
output logic [1:0] SelDataSource,   // Selector of Data Source that will go into the ALU

output logic [2:0] ALUCode,         // ALU Operation Code 
output logic Carry_CE,              // Carry Write Enable

output logic Accu_CE,               // Accumulator Write Enable

output logic [6:0] ControlPC        // Flag (MSB) + Jump-to-Addrres (6b) :: Program Counter position manipulation
);

parameter InsWidth = `PM_ID_INS_WIDTH;

// Wires created for easier access to Instruction
wire [4:0] OpCode_w;        // The OpCode of instruction - 5 bits
wire [1:0] OpCodeSection_w; // The OpCode section of instruction - there are 4 sections: Register, DataMem, ImmediateData, Rest
wire [2:0] OpCodeRest_w;    // Opcode without OpCodeSection - so the REST 3 bits of OpCode
wire [1:0] RNum_w;          // Register Number - overlaps with Data_w
wire [7:0] Data_w;          // Data part of instruction - 8 bits
wire [5:0] PCAddrIn;        // Input address of Program Counter pointing to the jump address. First 6 LSB of Data_w (overlaps) 

assign OpCode_w        = Ins[InsWidth-1 : InsWidth-5];         //5 first five MSB bits
assign OpCodeSection_w = Ins[InsWidth-1 : InsWidth-2];         //2 first two MSB bits
assign OpCodeRest_w    = Ins[InsWidth-3 : InsWidth-5];         //3 3-5 MSB bits
assign RNum_w          = Ins[1:0];         //2 1-2 LSB bit
assign Data_w          = Ins[7:0];
assign PCAddrIn        = Ins[5:0];

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
    Reg_CE = (OpCode_w == `OPCODE_ST_R) ? 1 : 0;

//SelDataSource 
    if(OpCodeSection_w!=`SEC_REST) begin
        SelDataSource = OpCodeSection_w;
    end else begin
        case(OpCodeRest_w)
            0: SelDataSource = `SEC_R;      // LD_R
            1: SelDataSource = `SEC_DM;     // LD_MD
            2: SelDataSource = `SEC_IMD;    // LD_IMD
            3: SelDataSource = `SEC_DM;      // ST_R
            4: SelDataSource = `SEC_R;     // ST_DM
            default: SelDataSource = `SEC_R; //Arbitrary choice
        endcase
    end
     


//ALUCode and Accu_CE 
    if(OpCodeSection_w != `SEC_REST) begin   //First 3 instructions sections (0-7,8-15,16-23)
        if(OpCodeRest_w<=`ALU_XOR) begin
            ALUCode = OpCodeRest_w;
            Accu_CE = 1;
        end else begin
            ALUCode = `ALU_DEF;
            Accu_CE = 0;
        end
    end else begin              //Last instructions section (24-31)

        case(OpCodeRest_w)
            0,1,2:   begin ALUCode =  `ALU_LD;  Accu_CE = 1; end //Load  instructions
            5:       begin ALUCode =  `ALU_NOT; Accu_CE = 1; end //Not   instruction
            default: begin ALUCode =  `ALU_DEF; Accu_CE = 0; end
        endcase

    end


//Carry_CE 
    Carry_CE = (OpCodeSection_w != `SEC_REST && OpCodeRest_w <= `ALU_SUB) ? 1 : 0;  //Every ADD-SUB instruction

//DataMem_WE 
    DataMem_WE = (OpCode_w == `OPCODE_ST_DM) ? 1 : 0; //Only on Store

//ControlPC 
    //ControlPC = (OpCodeSection_w != `SEC_REST && OpCodeRest_w == `JMP) ? {1'b1, PCAddrIn} : {7'd0}; //Sets jump flag and address on JMP instruction; otherwise sends zeroes
    //But the feedback for Registers and DM was forgoten. Now, only the JMP_IMD can work at this moment.
    //Also, protection for max PC address should be added.
    
if(PCAddrIn<=6'd63)
    ControlPC = (OpCode_w == `OPCODE_JMP_IMD) ? {1'b1, PCAddrIn} : {7'd0}; //Sets jump flag and address on JMP instruction; otherwise sends zeroes
else
    ControlPC = (OpCode_w == `OPCODE_JMP_IMD) ? {1'b1, 6'd0} : {7'd0};
end

//Data: IMD / DM_Addr
assign Data = Data_w;

endmodule