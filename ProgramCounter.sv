/* WHAT IS THIS? 
// This module is a Program Counter
// It increments itself every clock cycle
// It outputs the counter value on output                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
*/

`include "defines.sv"

module ProgramCounter(
input clk,
input nReset,
output reg [5:0] addr
);

initial begin
    addr = 6'd0;
end

always @(posedge clk) begin
    if(nReset!=0)
    addr = addr +1;
    else
    addr = 6'd0;
end

endmodule



