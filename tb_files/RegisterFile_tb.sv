`define tb_path "sim_files/RegisterFile_tb.vcd"

`timescale  1ns/1ps

`include "RegisterFile.sv"

module RegisterFile_tb;

logic [7:0] Accu_tb;
logic clk_tb;
logic nReset_tb;
logic [7:0] out_tb;
logic [3:0] RegNum_tb;
logic CE;

//=========================== MODULES ==========================


RegfisterFile RegfisterFile_1(
.A(Accu_tb),
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
    CE = 1'b1; RegNum_tb = 4'b0000; Accu_tb = 8'd0;
    #10 RegNum_tb = 4'b0001; Accu_tb = 8'd4;
    #10 RegNum_tb = 4'b0010; Accu_tb = 8'd5;
    #10 RegNum_tb = 4'b0100; Accu_tb = 8'd6;
    #10 RegNum_tb = 4'b1000; Accu_tb = 8'd7;
    #10 RegNum_tb = 4'b0000;
end

initial begin
    $dumpfile(`tb_path);
    $dumpvars;
    $dumpon;
end




endmodule