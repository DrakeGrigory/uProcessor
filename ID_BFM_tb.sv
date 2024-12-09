`timescale  1ns/1ps

`include "ALU.sv"
`include "DffPIPO_CE_SET.sv" 
`include "PC.sv" 
`include "PP_BFM.sv"
`include "RegisterFile.sv"
`include "RF_ALU_CY_A_module.sv"


module PC_PP_BFM_tb;

logic clk_tb;
logic nReset_tb;
logic [7:0] A_out_tb;

//wires wires wires wires wires wires wires

// PC outputs
wire [4:0] PC_Addr;

// PP outputss
wire PP_RegCE;
wire [3:0] PP_RegAddr;
wire [2:0] PP_ALUCode; 
wire PP_CY_CE;
wire PP_A_CE;
wire PP_ResetCY;

// modules modules modules modules modules modules


PC PC1(.clk(clk_tb), .nReset(nReset_tb), .addr(PC_Addr));

PP_BFM PP1(
.addr(PC_Addr),        //input 
.RegAddr(PP_RegAddr),  //outputs
.ALUCode(PP_ALUCode), 
.Reg_CE(PP_RegCE),
.CY_CE(PP_CY_CE),
.A_CE(PP_A_CE)
);


RF_ALU_CY_A_module RF_ALU_CY_A_module1(
.clk(clk_tb),
.nReset(nReset_tb),
.RegAddr(PP_RegAddr), 
.ALUCode(PP_ALUCode), 
.RegCE(PP_RegCE),
.CY_CE(PP_CY_CE),
.A_CE(PP_A_CE)
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
    $dumpfile("tb_files/ID_BFM_tb.vcd");
    $dumpvars;
    $dumpon;
end


endmodule





