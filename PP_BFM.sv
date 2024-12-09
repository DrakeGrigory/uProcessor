module PP_BFM(
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
        5'd0:  begin RegAddr=4'b0000; Reg_CE = 0;   ALUCode = `ALU_LDR;  CY_CE = 0; ResetCY=1;    A_CE = 0;  end //Reset
        5'd1:  begin RegAddr=4'b0000; Reg_CE = 0;   ALUCode = `ALU_LDR;  CY_CE = 0; ResetCY=0;    A_CE = 0;  end //Reset
        5'd2:  begin RegAddr=4'b1000; Reg_CE = 0;   ALUCode = `ALU_ADD;  CY_CE = 1; ResetCY=0;    A_CE = 1;  end //A+=R3 A=4
        5'd3:  begin RegAddr=4'b0100; Reg_CE = 0;   ALUCode = `ALU_ADD;  CY_CE = 1; ResetCY=0;    A_CE = 1;  end //A+=R2 A=2
        5'd4:  begin RegAddr=4'b0010; Reg_CE = 0;   ALUCode = `ALU_ADD;  CY_CE = 1; ResetCY=0;    A_CE = 1;  end //A+=R1 A=1
        5'd5:  begin RegAddr=4'b0001; Reg_CE = 1;   ALUCode = `ALU_DEF;  CY_CE = 0; ResetCY=0;    A_CE = 0;  end //R1=A A=7
        5'd6:  begin RegAddr=4'b0001; Reg_CE = 0;   ALUCode = `ALU_SUB;  CY_CE = 1; ResetCY=0;    A_CE = 1;  end //A-=R1 A=0
        5'd7:  begin RegAddr=4'b0100; Reg_CE = 0;   ALUCode = `ALU_SUB;  CY_CE = 1; ResetCY=0;    A_CE = 1;  end //A-=R2 A=255-1 - CY
        5'd8:  begin RegAddr=4'b1000; Reg_CE = 0;   ALUCode = `ALU_SUB;  CY_CE = 1; ResetCY=0;    A_CE = 1;  end //A-=R3 A=254-4-1
        5'd9:  begin RegAddr=4'b1000; Reg_CE = 0;   ALUCode = `ALU_SUB;  CY_CE = 1; ResetCY=0;    A_CE = 1;  end //A-=R3 A=249-4
        5'd10: begin RegAddr=4'b0010; Reg_CE = 0;   ALUCode = `ALU_SUB;  CY_CE = 1; ResetCY=0;    A_CE = 1;  end //A-=R3 A=245-1
        5'd11: begin RegAddr=4'b0010; Reg_CE = 0;   ALUCode = `ALU_NOT;  CY_CE = 0; ResetCY=0;    A_CE = 1;  end //A!=A A=11
        5'd12: begin RegAddr=4'b0010; Reg_CE = 0;   ALUCode = `ALU_AND;  CY_CE = 0; ResetCY=0;    A_CE = 1;  end //A&=R1 A=b1011 & 0001

        default: 
            begin RegAddr=4'b1111; ALUCode = 3'b111; Reg_CE = 0; CY_CE = 0; ResetCY=0; A_CE = 0;  end
    endcase

end



endmodule