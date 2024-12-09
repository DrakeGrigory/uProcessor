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