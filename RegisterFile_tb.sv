`timescale  1ns/1ps

`include "RegisterFile.sv"
`include "DffPIPO_CE.sv"

module RegisterFile_tb;

logic [7:0] Aku_tb;
logic clk_tb;
logic nReset_tb;
logic [7:0] out_tb;
logic [3:0] RegX_tb;
logic CE;

//=========================== MODULES ==========================


RegfisterFile RegfisterFile_1(
.Aku(Aku_tb),
.clk(clk_tb),
.RegCE(CE),
.RegX(RegX_tb),
.nReset(nReset_tb),
.out(out_tb)
);

// ====================================================== TB ======================================

initial begin //clk
forever begin
    #5 clk_tb = ~clk_tb;
end
end

initial begin //start values
clk_tb = 0;
nReset_tb = 0;
#6 nReset_tb = 1;

#60 $finish;
end


initial begin // 
    CE = 1'b1;
    #10 RegX_tb = 4'b0001; Aku_tb = 8'd4;
    #10 RegX_tb = 4'b0010; Aku_tb = 8'd5;
    #10 RegX_tb = 4'b0100; Aku_tb = 8'd6;
    #10 RegX_tb = 4'b1000; Aku_tb = 8'd7;
    #10 RegX_tb = 4'b0000;
end

initial begin
    $dumpfile("RegisterFile_tb.vcd");
    $dumpvars;
    $dumpon;
end




endmodule