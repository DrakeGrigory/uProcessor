`include "defines.sv"

module ProgramCounter(
input clk,
input nReset,
output reg [4:0] addr
);

initial begin
    addr = 5'd0;
end

always @(posedge clk) begin
    if(nReset!=0)
    addr = addr +1;
    else
    addr = 5'd0;
end

endmodule



