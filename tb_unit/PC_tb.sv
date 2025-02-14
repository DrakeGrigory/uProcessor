/* WHAT IS THIS? 
 This is a Testbench that tests Program Counter
*/
`define tb_path "sim_files/PC_tb.vcd"
`timescale 1ns/1ps

`include "ProgramCounter.sv"


module PC_tb;

logic clk_tb;
logic nReset_tb;
logic WriteEnable_tb;
logic [5:0] AddrIn_tb;
logic [5:0] AddrOut_tb;

ProgramCounter PC(
.WriteEnable(WriteEnable_tb),
.clk(clk_tb),
.nReset(nReset_tb),
.AddrIn(AddrIn_tb),
.AddrOut(AddrOut_tb)
);

initial begin //clk
forever begin
    #5 clk_tb = ~clk_tb;
end
end


initial begin // start values
clk_tb = 0;
nReset_tb = 0;
#6 nReset_tb = 1;

#250 $finish;
end






initial begin
WriteEnable_tb = 1'b0;
AddrIn_tb = 6'd22;

#100 WriteEnable_tb = 1;  AddrIn_tb = 6'd0;
#10 WriteEnable_tb = 0;  AddrIn_tb = 6'd55;
#30 WriteEnable_tb = 1;  AddrIn_tb = 6'd26;
#10 WriteEnable_tb = 0;  AddrIn_tb = 6'd55;

end









initial begin // file save
    $dumpfile(`tb_path);
    $dumpvars;
    $dumpon;
end


endmodule