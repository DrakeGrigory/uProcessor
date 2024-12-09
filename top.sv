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
wire [5:0] PM_Ins;

// ID outputs
wire ID_RegCE;
wire [3:0] ID_RegAddr;
wire [2:0] ID_ALUCode; 
wire ID_CY_CE;
wire ID_A_CE;
wire ID_nResetCY;

// ---------------------------- Second Part -----------------------------------

// RF outputs
wire [7:0] RF_2_ALU;

//ALU output
wire [7:0] ALU_2_A;
wire ALU_Co;

//CY output
wire RegCY_Q;

//A output
wire [7:0] A_out;

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
.RegAddr(ID_RegAddr),  //outputs
.ALUCode(ID_ALUCode), 
.Reg_CE(ID_RegCE),
.CY_CE(ID_CY_CE),
.nResetCY(ID_nResetCY),
.A_CE(ID_A_CE)
);

// ---------------------------- Second Part -----------------------------------


//REGISTER FILE
RegfisterFile RF(
.RegCE(ID_RegCE),  //inputs
.RegNum(ID_RegAddr),
.A(A_out),
.nReset(nReset),
.clk(clk),
.out(RF_2_ALU) //output
);

//ALU
ALU ALU_1(
.ALUCode(ID_ALUCode), //inputs
.R(RF_2_ALU),
.A(A_out),
.Ci(RegCY_Q), 
.Co(ALU_Co), //outputs
.out(ALU_2_A)
);

//CARRY
DffPIPO_CE_SET #(.SIZE(1)) RegCY(
.CE(ID_CY_CE), //inputs
.D(ALU_Co),
.clk(clk),
.nReset(nReset & ID_nResetCY),
.Q(RegCY_Q) //output
);

//ACUMULATOR
DffPIPO_CE_SET A(
.CE(ID_A_CE), //inputs
.D(ALU_2_A),
.clk(clk),
.nReset(nReset),
.Q(A_out) //output

);


endmodule