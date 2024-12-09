module DffPIPO_CE(
    input CE,
    input [7:0] D,
    input clk,
    input nReset,

    output reg [7:0] Q
);

always @(posedge clk ) begin
    if(nReset) begin
        if(CE==1)
            Q <= D;
    end
    else 
        Q <= 8'h00;
end
endmodule