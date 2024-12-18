module Multiplexer4to1 #(parameter DataWidth = 8)(
input [DataWidth-1:0] inA,
input [DataWidth-1:0] inB,
input [DataWidth-1:0] inC,
input [DataWidth-1:0] inD,
input [1:0] SelDataSource,
output logic [DataWidth-1:0] out
);

always @(*) begin
    case(SelDataSource)
        0: assign out = inA;
        1: assign out = inB;
        2: assign out = inC;
        3: assign out = inD;
    endcase
end
endmodule