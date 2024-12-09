/* WHAT IS THIS? 
 This is a Testbench that tests a Bus Functional Model of Instruction Decoder and Program Memory.
 The names need to be adjusted.
 It uses the RF_ALU_CY_A_module which contains in itself all other modules neccesary for CPU to operate (except PC).
*/
`define tb_path "tb_files/AllModulesV1_tb.vcd"

`timescale  1ns/1ps

`include "ProgramCounter.sv"
`include "ProgramMemory.sv"
`include "InstructionDecoder.sv"
`include "RF_ALU_CY_A_module.sv"

module AllModulesV1_tb;

logic clk_tb;
logic nReset_tb;

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

//============================================================================
//++++++++++++++++++++++++++++++++++ MODULES +++++++++++++++++++++++++++++++++
//============================================================================



ProgramCounter PC(.clk(clk_tb), .nReset(nReset_tb), .addr(PC_Addr));

ProgramMemory PM(.addr(PC_Addr), .InsOut(PM_Ins));

InstructionDecoder ID(
.Ins(PM_Ins),          //input 
.RegAddr(ID_RegAddr),  //outputs
.ALUCode(ID_ALUCode), 
.Reg_CE(ID_RegCE),
.CY_CE(ID_CY_CE),
.nResetCY(ID_nResetCY),
.A_CE(ID_A_CE)
);


RF_ALU_CY_A_module RF_ALU_CY_A_module1(
.clk(clk_tb),
.nReset(nReset_tb),
.RegAddr(ID_RegAddr), 
.ALUCode(ID_ALUCode), 
.RegCE(ID_RegCE),
.CY_CE(ID_CY_CE),
.nResetCY(ID_nResetCY),
.A_CE(ID_A_CE)
);

//============================================================================
//******************************** SIMULATION ********************************
//============================================================================

initial begin //clk
forever begin
    #5 clk_tb = ~clk_tb;
end
end

initial begin // start values
clk_tb = 0;
nReset_tb = 0;
#6 nReset_tb = 1;

#100 $finish;
end

initial begin // file save
    $dumpfile(`tb_path);
    $dumpvars;
    $dumpon;
end


endmodule





