`include "defines.sv"

module PC(
input clk,
output reg [4:0] addr
);

inital begin
    addr = 5'd0;
end

always @(posedge clk) begin
    addr = addr +1;
end

endmodule



module PP(
input [4:0] addr,

output [3:0] CEO,    // 4
output [2:0] ALUCode // 3
output CE,           // 1
output CY_CE,        // 1
output A_CE          // 1
);


always @(*) begin
    case (addr)
        5'd0: begin CEO=4'b0001; ALUCode = `ADD; CE = 0; CY_CE = 0; A_CE = 1;  end
        5'd1: begin CEO=4'b0010; ALUCode = `ADD; CE = 0; CY_CE = 0; A_CE = 1;  end
        5'd2: begin CEO=4'b0100; ALUCode = `ADD; CE = 0; CY_CE = 0; A_CE = 1;  end
        5'd3: begin CEO=4'b1000; ALUCode = `SUB; CE = 0; CY_CE = 0; A_CE = 1;  end

        default: 5'd0: begin CEO=4'b0000; ALUCode = 3'b000; CE = 0; CY_CE = 0; A_CE = 0;  end
    endcase
end




endmodule