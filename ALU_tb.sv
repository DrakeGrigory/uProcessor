`timescale  1ns/1ps

`include "Regs.sv"
`include "ALU.sv"
`include "DffPIPO_CE.sv" 

module ALU_tb;

//Regs
logic A_CE_tb = 0;
logic CY_CE_tb = 0;
logic clk_tb = 0;
logic nReset = 1;


//ALU
logic [2:0] ALUCode_tb;
logic [7:0] R_tb = 8'd4;
logic Ci_tb = 0;
logic [7:0] out_tb;

//WIRES
wire ALU_2_RegCY;
wire [7:0] ALU_2_RegAku;
wire [7:0] RegAku_2_ALU;

//=========================== MODULES ==========================

ALU ALU_1(
.ALUCode(ALUCode_tb),
.A(RegAku_2_ALU),
.R(R_tb),
.Ci(Ci_tb), 
.Co(ALU_2_RegCY),
.out(ALU_2_RegAku)
);

Reg_CY Reg_CY_1(
.CE(CY_CE_tb),
.CY_in(ALU_2_RegCY),
.clk(clk_tb)
);

DffPIPO_CE Aku(
.CE(A_CE_tb),
.D(ALU_2_RegAku),
.clk(clk_tb),
.Q(RegAku_2_ALU),
.nReset(nReset)
);


// ====================================================== TB ======================================

initial begin //clk
forever begin
    #5 clk_tb = ~clk_tb;
end
end

initial begin //start values
A_CE_tb = 1;
CY_CE_tb = 1;
clk_tb = 0;

nReset = 0;
#6 nReset = 1;

#200 $finish;
end


initial begin // ALU Codes
    ALUCode_tb = `ADD;
    #10 
    #10 
    #10 ALUCode_tb = `SUB;
    #10 ALUCode_tb = `ADD;
    #10 ALUCode_tb = `AND;
    #10 ALUCode_tb = `OR;
    #10 ALUCode_tb = `ADD;
    #10 ALUCode_tb = `XOR;
    #10 ALUCode_tb = `NOT;
    #10 ALUCode_tb = `LD;
    #10 ALUCode_tb = `SUB;
    #10 ALUCode_tb = `ADD;
    #10 ALUCode_tb = `ADD;
    #10 ALUCode_tb = `SUB;
    #10 ALUCode_tb = `NOT;
    #10 ALUCode_tb = `ADD;
end







initial begin
    $dumpfile("ALU_tb.vcd");
    $dumpvars;
    $dumpon;
end
endmodule