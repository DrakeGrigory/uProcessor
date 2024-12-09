module ID(
input [5:0] Ins,

output reg [3:0] RegAddr,    
output reg [2:0] ALUCode, 
output reg Reg_CE,          
output reg CY_CE,        
output reg A_CE,         
output reg ResetCY
);

wire [3:0] OpCode;
wire [1:0] RNum;

assign OpCode = Ins[3:0];
assign RNum = Ins[6:5]; 


always @(clk) begin
//RegAddr
    case (RNum)
    `R0: 4'b0001; 
    `R1: 4'b0010;
    `R2: 4'b0100;
    `R3: 4'b1000;
    endcase

//RegCE
    if(OpCode==4'b11xx) begin
        Reg_CE=1;
    end else begin
        Reg_CE=0;
    end


//ALUCode
    case (ALUCode)
    `ADD: 
    `SUB: 
    `AND: 
    `OR :
    `XOR: 
    `NOT:
    `NOP:
    

    default:
end









endmodule