/* WHAT IS THIS? 
// This module is an D-flip-flop. 
   It can be set to a given value in SET.
   It size/width can be set to the size given in SIZE                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
*/

module DffPIPO_CE_SET #(parameter SET = 0, parameter SIZE = 8)(
    input CE,               // Clock Enable - Enables/Disables writing into register of this memory (Q)
    input [SIZE-1:0] D,     // Value that will be written into memory
    input clk,      
    input nReset,

    output reg [SIZE-1:0] Q // Memory/Output of this memory
);

always @(posedge clk ) begin
    if(nReset) begin
        if(CE==1)
            Q <= D;
    end
    else 
        Q <= SET;
end
endmodule