/* WHAT IS THIS? 
 This is a module that connects all modules
*/

`include "ProgramCounter.sv"
`include "ProgramMemory.sv"
`include "InstructionDecoder.sv"
`include "ALU.sv"
`include "RegisterFile.sv"

module top(input clk, input nReset);

//============================================================================
//----------------------------------- WIRES ----------------------------------
//============================================================================

// PC outputs
wire [4:0] PC_Addr;

// PM outputs
wire [12:0] PM_Ins;

// ID outputs
wire ID_DataMem_CE;
wire ID_RegCE;
wire [3:0] ID_RegAddr;
wire [7:0] ID_Data;
wire [1:0] ID_SelDataSource;  
wire [2:0] ID_ALUCode; 
wire ID_Carry_CE;
wire ID_Accu_CE;


// ---------------------------- Second Part -----------------------------------

// RF outputs
wire [7:0] RegFile_2_ALU;

//ALU output
wire [7:0] ALU_2_Accu;
wire ALU_Co;

//CY output
wire RegCY_Q;

//A output
wire [7:0] Accu_out;

//============================================================================
//++++++++++++++++++++++++++++++++++ MODULES +++++++++++++++++++++++++++++++++
//============================================================================


//PROGRAM COUNTER
ProgramCounter PC(.clk(clk), .nReset(nReset), .addr(PC_Addr));

//PROGRAM MEMORY
ProgramMemory PM(.addr(PC_Addr), .InsOut(PM_Ins));




//INSTRUCTION DECODER
InstructionDecoder ID(
.Ins(PM_Ins),          //input 
.DataMem_CE(ID_DataMem_CE),
.RegAddr(ID_RegAddr),  //outputs
.Data(ID_Data),
.SelDataSource(ID_SelDataSource),
.ALUCode(ID_ALUCode), 
.Reg_CE(ID_RegCE),
.Carry_CE(ID_Carry_CE),
.Accu_CE(ID_Accu_CE)
);

// ---------------------------- Second Part -----------------------------------


//REGISTER FILE
RegfisterFile RF(
.RegCE(ID_RegCE),  //inputs
.RegNum(ID_RegAddr),
.A(Accu_out),
.nReset(nReset),
.clk(clk),
.out(RegFile_2_ALU) //output
);

//ALU
ALU ALU_1(
.ALUCode(ID_ALUCode), //inputs
.MemIn(RegFile_2_ALU),
.Accu(Accu_out),
.Ci(RegCY_Q), 
.Co(ALU_Co), //outputs
.Out(ALU_2_Accu)
);

//CARRY
DffPIPO_CE_SET #(.SIZE(1)) RegCY(
.CE(ID_Carry_CE), //inputs
.D(ALU_Co),
.clk(clk),
.nReset(nReset & ID_Carry_CE),
.Q(RegCY_Q) //output
);

//ACUMULATOR
DffPIPO_CE_SET A(
.CE(ID_Accu_CE), //inputs
.D(ALU_2_Accu),
.clk(clk),
.nReset(nReset),
.Q(Accu_out) //output
);


endmodule