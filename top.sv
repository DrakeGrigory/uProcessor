/* WHAT IS THIS? 
 This is a module that connects all modules
*/

`include "ProgramCounter.sv"
`include "ProgramMemory.sv"
`include "InstructionDecoder.sv"
`include "ALU.sv"
`include "RegisterFile.sv"
`include "SmallModules.sv"
`include "DataMemory.sv"

`include "DebugModule.sv"
module top(input clk, input nReset,
input  [7:0] inR3,          //user-defined input to one of regs 
output [5:0] PC_Addr_o,     //debug
output [7:0] Accu_out_o);   //debug

//============================================================================
//----------------------------------- WIRES ----------------------------------
//============================================================================

// PC outputs
wire [5:0] PC_Addr;

// PM outputs
wire [12:0] PM_Ins;

// ID outputs
wire ID_DataMem_WE;
wire ID_RegCE;
wire [3:0] ID_RegAddr;
wire [7:0] ID_Data;
wire [1:0] ID_SelDataSource;  
wire [2:0] ID_ALUCode; 
wire ID_Carry_CE;
wire ID_Accu_CE;
wire [6:0] ID_ControlPC;


// ---------------------------- Second Part -----------------------------------

// RF outputs
wire [7:0] RegFile_2_Mult;

// Data Memory outputs
wire [7:0] DataMem_2_Mult;

// Multiplexer output
wire [7:0] Mult_2_ALU;

//ALU output
wire [7:0] ALU_2_Accu;
wire ALU_Co;

//Carry output
wire RegCarry_2_ALU;

//Accu output
wire [7:0] Accu_out;

//============================================================================
//++++++++++++++++++++++++++++++++++ MODULES +++++++++++++++++++++++++++++++++
//============================================================================


//PROGRAM COUNTER
ProgramCounter PC(
.WriteEnable(ID_ControlPC[6]),
.clk(clk),
.nReset(nReset),
.AddrIn(ID_ControlPC[5:0]),
.AddrOut(PC_Addr)
);

//PROGRAM MEMORY
ProgramMemory PM(.addr(PC_Addr), .InsOut(PM_Ins));

//INSTRUCTION DECODER
InstructionDecoder ID(
.Ins(PM_Ins),          //input 
.DataMem_WE(ID_DataMem_WE),
.RegAddr(ID_RegAddr),  //outputs
.Data(ID_Data),
.SelDataSource(ID_SelDataSource),
.ALUCode(ID_ALUCode), 
.Reg_CE(ID_RegCE),
.Carry_CE(ID_Carry_CE),
.Accu_CE(ID_Accu_CE),
.ControlPC(ID_ControlPC)
);

// ---------------------------- Second Part -----------------------------------


//REGISTER FILE
RegfisterFile RF(
.RegCE(ID_RegCE),  //inputs
.RegNum(ID_RegAddr),
.Accu(Accu_out),
.nReset(nReset),
.clk(clk),
.inR3(inR3),
.out(RegFile_2_Mult) //output
);


//DATA MEMORY
DataMemory DM(
.Accu(Accu_out),
.WriteEnable(ID_DataMem_WE),
.Addr(ID_Data),
.nReset(nReset),
.clk(clk),
.DataOut(DataMem_2_Mult)
);

// MULTIPLEXER
Multiplexer4to1 Mult4to1(
.inA(RegFile_2_Mult),
.inB(DataMem_2_Mult),
.inC(ID_Data),
.inD(8'b0),
.SelDataSource(ID_SelDataSource),
.out(Mult_2_ALU)
);

//ALU
ALU ALU_1(
.ALUCode(ID_ALUCode), //inputs
.DataIn(Mult_2_ALU),
.AccuIn(Accu_out),
.Ci(RegCarry_2_ALU), 
.Co(ALU_Co), //outputs
.DataOut(ALU_2_Accu)
);

//CARRY
DffPIPO_CE_SET #(.SIZE(1)) RegCY(
.CE(ID_Carry_CE), //inputs
.D(ALU_Co),
.clk(clk),
.nReset(nReset & ID_Carry_CE),
.Q(RegCarry_2_ALU) //output
);

//ACCUMULATOR
DffPIPO_CE_SET A(
.CE(ID_Accu_CE), //inputs
.D(ALU_2_Accu),
.clk(clk),
.nReset(nReset),
.Q(Accu_out) //output
);


assign PC_Addr_o = PC_Addr;
assign Accu_out_o = Accu_out;
endmodule