`timescale  1ns/1ps

`include "RegCY.sv"
`include "ALU.sv"
`include "DffPIPO_CE.sv" 
`include "PC_PP.sv" 
`include "RegisterFile.sv"

module PseudoPP_PC_tb;

logic clk_tb;
logic nReset_tb;

//wires wires wires wires wires wires wires

// PC outputs
wire [4:0] PC_Addr;

// PP outputs
wire PP_RegCE;
wire [3:0] PP_RegAddr;
wire [2:0] PP_ALUCode; 
wire PP_CY_CE;
wire PP_A_CE;

// RF outputs
wire [7:0] RF_2_ALU;

//ALU output
wire [7:0] ALU_2_A;
wire ALU_Co;

//CY output
wire RegCY_Q;

//A output
wire [7:0] A_out;

// modules modules modules modules modules modules

PC PC1(.addr(PC_Addr));

PP PP1(
.addr(PC_Addr),

.RegAddr(PP_RegAddr),
.ALUCode(PP_ALUCode), 
.Reg_CE(PP_RegCE),
.CY_CE(PP_CY_CE),
.A_CE(PP_A_CE)
);

RegfisterFile RF(
.RegCE(PP_RegCE),
.RegX(PP_RegAddr),
.A(A_out),
.nReset(nReset_tb),
.clk(clk_tb),
.out(RF_2_ALU)
);

ALU ALU_1(
.ALUCode(PP_ALUCode), //inputs
.R(RF_2_ALU),
.A(A_out),
.Ci(RegCY_Q), 
.Co(ALU_Co), //outputs
.out(ALU_2_A)
);

DffPIPO_CE RegCY(
.CE(PP_CY_CE),
.D(ALU_Co),
.clk(clk_tb),
.Q(RegCY_Q),
.nReset(nReset_tb)
);

DffPIPO_CE A(
.CE(PP_A_CE),
.D(ALU_2_A),
.clk(clk_tb),
.Q(A_out),
.nReset(nReset_tb)
);

// SIM SIM SIM SIM SIM SIM SIM SIM SIM SIM SIM SIM SIM SIM SIM SIM
initial begin //clk
clk_tb = 0;
forever begin
    #5 clk_tb = ~clk_tb;
end
end

initial begin //start values
nReset = 0;
#6 nReset = 1;

#70 $finish;
end

initial begin
    $dumpfile("ALU_tb.vcd");
    $dumpvars;
    $dumpon;
end






endmodule