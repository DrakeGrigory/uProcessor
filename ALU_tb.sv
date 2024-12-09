`timescale  1ns/1ps

`include "Regs.sv"
`include "ALU.sv" 

module ALU_tb;

//Regs
logic A_CE_tb = 0;
logic CY_CE_tb = 0;
logic clk_tb = 0;


//ALU
logic [2:0] ALUCode_tb;
logic [7:0] A_tb = 8'd8;
logic [7:0] R_tb = 8'd4;
logic Ci_tb = 0;
logic Co_tb = 0;
logic [7:0] out_tb;

//WIRES
wire ALU_2_RegCY;
wire [7:0] ALU_2_RegAku;

//=========================== MODULES ==========================

ALU ALU_1(
.ALUCode(ALUCode_tb),
.A(A_tb),
.R(R_tb),
.Ci(Ci_tb), 
.Co(ALU_2_RegCY),
.out(out_tb)
);

Reg_CY Reg_CY_1(
.CE(CY_CE_tb),
.CY_in(ALU_2_RegCY),
.clk(clk_tb)
);

// Aku Aku(
// .CE(A_CE_tb),
// .D(ALU_2_RegAku),
// .clk(clk_tb)
// .Q()
// )


initial begin
clk_tb = 0;
#100 $finish;
end

initial begin
forever begin
    #5 clk_tb = ~clk_tb;
end
end

initial begin
    #0 ALUCode_tb = 3'd0;
end

initial begin
    $dumpfile("ALU_tb.vcd");
    $dumpvars;
    $dumpon;
end




endmodule