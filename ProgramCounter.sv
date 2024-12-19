/* WHAT IS THIS? 
// This module is a Program Counter
// It increments itself every clock cycle
// It outputs the counter value on output                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
*/

`include "defines.sv"

module ProgramCounter(
input WriteEnable,
input clk,
input nReset,
input  logic [5:0] AddrIn,
output logic [5:0] AddrOut
);



always @(posedge clk) begin
    if(nReset==0 || (WriteEnable==1 && AddrIn == 6'd0))
        AddrOut = 6'd0;
    else begin
        if (WriteEnable==1)
            AddrOut = AddrIn;
        else
            AddrOut = AddrOut + 1;
    end   
end

endmodule



