`timescale  1ns/1ps

`include "PC.sv"
`include "PP.sv"
`include "ID.sv"

module PP_ID_tb;

logic clk_tb;
logic nReset_tb;

// ===== WIRES ===== 
wire [4:0] PC_Addr; // PC output
wire [5:0] PP_Ins; //  PP output


// ===== MODULES ===== //
PC PC1(.clk(clk_tb), .nReset(nReset_tb), .addr(PC_Addr));
PP PP1 (.addr(PC_Addr), .InsOut(PP_Ins));

ID ID1(
.Ins(PP_Ins)
);


// ===== SIM ======//
initial begin //clk
forever begin
    #5 clk_tb = ~clk_tb;
end
end

initial begin //start values
clk_tb = 0;
nReset_tb = 0;
#6 nReset_tb = 1;

#55 $finish;
end

initial begin
    $dumpfile("PP_ID_tb.vcd");
    $dumpvars;
    $dumpon;
end




endmodule