`timescale  1ns/1ps

`include "ALU.sv"
`include "DffPIPO_CE_SET.sv" 
`include "PC_PP.sv" 
`include "RegisterFile.sv"

module PseudoPP_PC_tb;

logic clk_tb;
logic nReset_tb;
logic [7:0] A_out_tb;

//wires wires wires wires wires wires wires

// PC outputs
wire [4:0] PC_Addr;

// PP outputs
wire PP_RegCE;
wire [3:0] PP_RegAddr;
wire [2:0] PP_ALUCode; 
wire PP_CY_CE;
wire PP_A_CE;
wire PP_ResetCY;

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

PC PC1(.clk(clk_tb), .nReset(nReset_tb), .addr(PC_Addr));

PP PP1(
.addr(PC_Addr),        //input 
.RegAddr(PP_RegAddr),  //outputs
.ALUCode(PP_ALUCode), 
.Reg_CE(PP_RegCE),
.CY_CE(PP_CY_CE),
.A_CE(PP_A_CE)
);

RegfisterFile RF(
.RegCE(PP_RegCE),  //inputs
.RegNum(PP_RegAddr),
.A(A_out),
.nReset(nReset_tb),
.clk(clk_tb),
.out(RF_2_ALU) //output
);

ALU ALU_1(
.ALUCode(PP_ALUCode), //inputs
.R(RF_2_ALU),
.A(A_out),
.Ci(RegCY_Q), 
.Co(ALU_Co), //outputs
.out(ALU_2_A)
);

DffPIPO_CE_SET #(.SIZE(1)) RegCY(
.CE(PP_CY_CE),
.D(ALU_Co),
.clk(clk_tb),
.Q(RegCY_Q),
.nReset(nReset_tb | PP_ResetCY)
);

DffPIPO_CE_SET A(
.CE(PP_A_CE),
.D(ALU_2_A),
.clk(clk_tb),
.Q(A_out),
.nReset(nReset_tb)
);

// SIM SIM SIM SIM SIM SIM SIM SIM SIM SIM SIM SIM SIM SIM SIM SIM
initial begin //clk
forever begin
    #5 clk_tb = ~clk_tb;
end
end

initial begin //start values
A_out_tb = 8'h00;
clk_tb = 0;
nReset_tb = 0;
#6 nReset_tb = 1;

#200 $finish;
end

initial begin
    $dumpfile("PseudoPP_PC_tb.vcd");
    $dumpvars;
    $dumpon;
end






endmodule