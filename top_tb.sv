/* WHAT IS THIS? 
 This is a Testbench that tests all modules
*/

`define tb_path "sim_files/top_tb.vcd"

`timescale  1ns/1ps

`include "top.sv"

module top_tb;

logic clk_tb;
logic nReset_tb;
logic [7:0] inR3_reg;
logic [5:0] PC_Addr_wire;
logic [7:0] Accu_out_wire;

 

top top1(.clk(clk_tb),.nReset(nReset_tb),
.inR3(inR3_reg), 
.PC_Addr_o(PC_Addr_wire),       //debug 
.Accu_out_o(Accu_out_wire));    //debug


// ---------------------------- DEBUG Part -----------------------------------
DebugModule #(.INS_ADDR_WIDTH(6), .MEM_WIDTH(8), .MEM_LEN(64)) DebMod_CheckAccuVal (
.addr(PC_Addr_wire),
.accuValue(Accu_out_wire),
.clk(clk_tb)
);



//============================================================================
//****************************** INPUT SIGNALS *******************************
//============================================================================

always @(*) begin
    case(PC_Addr_wire)
        6'd45:  inR3_reg = 8'd85; //0x55 //0b0101_0101  //LD to accu // A=85
        6'd46:  inR3_reg = 8'hF0;                       //AND        // A=80
        6'd47:  inR3_reg = 8'hF0;                       //OR         // A=240
        6'd48:  inR3_reg = 8'h0F;                       //ADD        // A=255
        6'd49:  inR3_reg = 8'hFF;                       //SUB        // A=0
        default inR3_reg = 8'hx1;
    endcase
end



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

#1000 $finish;
end

initial begin // file save
    $dumpfile(`tb_path);
    $dumpvars;
    $dumpon;
end


endmodule





