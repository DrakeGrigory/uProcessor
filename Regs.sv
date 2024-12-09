module Reg_CY(
input CE,
input CY_in,
input clk,

output logic CY_out
);

always @(posedge clk ) begin
    if(CE==1)
        CY_out <= CY_in;
end
endmodule


module Aku(
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