`include "defines.sv"

module PC(
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



module PP(
input [4:0] addr,

output reg [3:0] RegAddr,    
output reg [2:0] ALUCode, 
output reg Reg_CE,          
output reg CY_CE,        
output reg A_CE,         
output reg ResetCY
);


always @(*) begin
    case (addr)
        5'd0: begin RegAddr=4'b0000; Reg_CE = 0;   ALUCode = `LD; CY_CE = 0; ResetCY=1;    A_CE = 0;  end //Reset
        5'd0: begin RegAddr=4'b0000; Reg_CE = 0;   ALUCode = `LD; CY_CE = 0; ResetCY=0;    A_CE = 0;  end //Reset
        5'd1: begin RegAddr=4'b0001; Reg_CE = 0;   ALUCode = `LD; CY_CE = 0; ResetCY=0;    A_CE = 1;  end
        5'd2: begin RegAddr=4'b0000; Reg_CE = 1;   ALUCode = `LD; CY_CE = 0; ResetCY=0;    A_CE = 1;  end
        5'd3: begin RegAddr=4'b0100; Reg_CE = 0;   ALUCode = `LD; CY_CE = 0; ResetCY=0;    A_CE = 1;  end

        default: 
            begin RegAddr=4'b1111; ALUCode = 3'b111; Reg_CE = 0; CY_CE = 0; ResetCY=0; A_CE = 0;  end
    endcase
end

endmodule