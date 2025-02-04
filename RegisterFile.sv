/* WHAT IS THIS? 
// This module is a Register File
// It contain 4x8bit Registers (Dff) or 3x8bit  
// Output is a multiplexed register output                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
*/

`timescale  1ns/1ps
`include "DffPIPO_CE_SET.sv"

module RegfisterFile(
    input [7:0] Accu,   // inputs Accumulator output
    input clk,          
    input nReset,
    input [3:0] RegNum, // decoder will be placed in ID
    input RegCE,        // Clock Enable/Write Enable that allows for writing into registers
    input [7:0] inR3,   // input that allows to insert an user-defined value

    output logic [7:0] out);

wire [7:0] Reg2Mult [0:3];

DffPIPO_CE_SET R0(
.D(Accu),
.CE(RegNum[0] & RegCE),
.clk(clk),
.nReset(nReset),
.Q(Reg2Mult[0])
);

DffPIPO_CE_SET #(.SET(1)) R1(
.D(Accu),
.CE(RegNum[1] & RegCE),
.clk(clk),
.nReset(nReset),
.Q(Reg2Mult[1])
);

DffPIPO_CE_SET #(.SET(2)) R2(
.D(Accu),
.CE(RegNum[2] & RegCE),
.clk(clk),
.nReset(nReset),
.Q(Reg2Mult[2])
);

assign Reg2Mult[3] = inR3; //it can be done differently, this one is the fastest to ipmlement

// DffPIPO_CE_SET #(.SET(4)) R3(
// .D(Accu),
// .CE(RegNum[3] & RegCE),
// .clk(clk),
// .nReset(nReset),
// .Q(Reg2Mult[3])
// );


always @(*) begin
    case (RegNum)
        4'd1: out = Reg2Mult[0];
        4'd2: out = Reg2Mult[1];
        4'd4: out = Reg2Mult[2];
        4'd8: out = Reg2Mult[3];
        default: out = 4'h0;
    endcase
end

endmodule




