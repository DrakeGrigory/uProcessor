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

    output reg [7:0] Q
);

always @(posedge clk ) begin
    if(CE==1)
        Q <= D;
end
endmodule 