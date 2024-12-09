module DffPIPO_CE_SET #(parameter SET = 0, parameter SIZE = 8)(
    input CE,
    input [SIZE-1:0] D,
    input clk,
    input nReset,

    output reg [SIZE-1:0] Q
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