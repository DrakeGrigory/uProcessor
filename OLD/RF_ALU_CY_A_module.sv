/* WHAT IS THIS? 
The RF_ALU_CY_A_module contains all other modules after ID neccesary for CPU to operate.
*/

`include "ALU.sv"
`include "RegisterFile.sv"

module RF_ALU_CY_A_module(
input clk,
input nReset, 
input [3:0] RegAddr,
input [2:0] ALUCode, 
input RegCE,
input CY_CE,
input nResetCY,
input A_CE
);

//============================================================================
//----------------------------------- WIRES ----------------------------------
//============================================================================

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

RegfisterFile RF(
.RegCE(RegCE),  //inputs
.RegNum(RegAddr),
.A(A_out),
.nReset(nReset),
.clk(clk),
.out(RF_2_ALU) //output
);

ALU ALU_1(
.ALUCode(ALUCode), //inputs
.R(RF_2_ALU),
.A(A_out),
.Ci(RegCY_Q), 
.Co(ALU_Co), //outputs
.out(ALU_2_A)
);

DffPIPO_CE_SET #(.SIZE(1)) RegCY(
.CE(CY_CE),
.D(ALU_Co),
.clk(clk),
.Q(RegCY_Q),
.nReset(nReset & nResetCY)
);

DffPIPO_CE_SET A(
.CE(A_CE),
.D(ALU_2_A),
.clk(clk),
.Q(A_out),
.nReset(nReset)
);

endmodule