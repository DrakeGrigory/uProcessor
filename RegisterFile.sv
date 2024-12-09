`timescale  1ns/1ps

module RegfisterFile(
    input [7:0] A,
    input clk,
    input nReset,
    input [3:0] RegX, //decoder will be placed in ID
    input RegCE,

    output logic [7:0] out);

wire [7:0] Reg2Mult [0:3];

DffPIPO_CE R0(
.D(A),
.CE(RegX[0] & RegCE),
.clk(clk),
.nReset(nReset),
.Q(Reg2Mult[0])
);

DffPIPO_CE R1(
.D(A),
.CE(RegX[1] & RegCE),
.clk(clk),
.nReset(nReset),
.Q(Reg2Mult[1])
);

DffPIPO_CE R2(
.D(A),
.CE(RegX[2] & RegCE),
.clk(clk),
.nReset(nReset),
.Q(Reg2Mult[2])
);

DffPIPO_CE R3(
.D(A),
.CE(RegX[3] & RegCE),
.clk(clk),
.nReset(nReset),
.Q(Reg2Mult[3])
);


always @(*) begin
    case (RegX)
        4'd1: out = Reg2Mult[0];
        4'd2: out = Reg2Mult[1];
        4'd4: out = Reg2Mult[2];
        4'd8: out = Reg2Mult[3];
        default: out = 4'h0;
    endcase
end


endmodule