`timescale  1ns/1ps

`include "RegisterFile.sv"
`include "DffPIPO_CE.sv"

module RegisterFile_tb;

logic [7:0] A_tb;
logic clk_tb;
logic nReset_tb;
logic [7:0] out_tb;
logic [3:0] RegNum_tb;
logic CE;

//=========================== MODULES ==========================


RegfisterFile RegfisterFile_1(
.A(A_tb),
.clk(clk_tb),
.RegCE(CE),
.RegNum(RegNum_tb),
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
    #10 RegNum_tb = 4'b0001; A_tb = 8'd4;
    #10 RegNum_tb = 4'b0010; A_tb = 8'd5;
    #10 RegNum_tb = 4'b0100; A_tb = 8'd6;
    #10 RegNum_tb = 4'b1000; A_tb = 8'd7;
    #10 RegNum_tb = 4'b0000;
end

initial begin
    $dumpfile("RegisterFile_tb.vcd");
    $dumpvars;
    $dumpon;
end




endmodule