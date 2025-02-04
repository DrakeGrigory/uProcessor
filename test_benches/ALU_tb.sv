`define tb_path "tb_files/ALU_tb.vcd"

`timescale  1ns/1ps

`include "ALU.sv"
`include "DffPIPO_CE_SET.sv" 

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
wire RegCY_2_ALU;
wire [7:0] ALU_2_RegAku;
wire [7:0] RegAku_2_ALU;

//=========================== MODULES ==========================

ALU ALU_1(
.ALUCode(ALUCode_tb),
.A(RegAku_2_ALU),
.R(R_tb),
.Ci(RegCY_2_ALU), 
.Co(ALU_2_RegCY),
.out(ALU_2_RegAku)
);

DffPIPO_CE_SET  #(.SIZE(1))  RegCY_1(
.CE(CY_CE_tb),
.D(ALU_2_RegCY),
.clk(clk_tb),
.Q(RegCY_2_ALU),
.nReset(nReset)
);

DffPIPO_CE_SET Aku(
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

#300 $finish;
end


initial begin // ALU Codes
    ALUCode_tb = `ALU_ADD;
    #10 
    #10 
    #10 ALUCode_tb = `ALU_SUB;
    #10 ALUCode_tb = `ALU_ADD;
    #10 ALUCode_tb = `ALU_AND;
    #10 ALUCode_tb = `ALU_OR;
    #10 ALUCode_tb = `ALU_ADD;
    #10 ALUCode_tb = `ALU_XOR;
    #10 ALUCode_tb = `ALU_NOT;
    #10 ALUCode_tb = `ALU_LD;
    #10 ALUCode_tb = `ALU_SUB;
    #10 ALUCode_tb = `ALU_ADD;
    #10 ALUCode_tb = `ALU_ADD;
    #10 ALUCode_tb = `ALU_SUB;
    #10 ALUCode_tb = `ALU_NOT;
    #10 ALUCode_tb = `ALU_ADD;
    #20 ALUCode_tb = `ALU_LD;

    //Testing CY
    //Starting A=4;
    #10 ALUCode_tb = `ALU_NOT; R_tb = 8'd10; //251
    #10 ALUCode_tb = `ALU_ADD; //5 + CY
    #10 ALUCode_tb = `ALU_ADD; //16
    #10 ALUCode_tb = `ALU_SUB; //6
    #10 ALUCode_tb = `ALU_SUB; //252 - CY
    #10 ALUCode_tb = `ALU_SUB; //241

end







initial begin
    $dumpfile(`tb_path);
    $dumpvars;
    $dumpon;
end
endmodule